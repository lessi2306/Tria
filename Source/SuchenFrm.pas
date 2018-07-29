unit SuchenFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StdCtrls,ComCtrls,StrUtils,
  AllgConst;

  procedure SuchenErsetzen(Modus:TSuchErsetzModus);

type
  TSuchenForm = class(TForm)
    SuchTabControl: TTabControl;
    SuchenNachLabel: TLabel;
    SuchenInLabel: TLabel;
    ErsetzenLabel: TLabel;
    SuchenNachCB: TComboBox;
    SuchenInCB: TComboBox;
    ErsetzenCB: TComboBox;
    OptionenGB: TGroupBox;
    GrossKleinCheckB: TCheckBox;
    GanzCheckB: TCheckBox;
    BestaetigenCB: TCheckBox;
    AllesButton: TButton;
    ErsetzButton: TButton;
    SuchButton: TButton;
    CancelButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure SuchTabControlChange(Sender: TObject);
    procedure SuchenNachLabelClick(Sender: TObject);
    procedure SuchenInLabelClick(Sender: TObject);
    procedure ErsetzenLabelClick(Sender: TObject);
    procedure SuchButtonClick(Sender: TObject);
    procedure ErsetzButtonClick(Sender: TObject);
    procedure AllesButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    SuchModus   : TSuchModus;
    SuchSpalte  : TColType;
    SuchText    : String;
    ErsatzText  : String;
    ErsatzCount : Integer;
    Bestaetigen,
    Abbruch     : Boolean;

    procedure WeiterSuchen(SuchModus: TSuchModus);
    function ErsetzeIdx(const TlnIdx:Integer): Boolean;
    procedure UpdateTab;
    function GetSpalte: TColType;
    procedure DatenUebernehmen;
    function EingabeOK: Boolean;

  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  SuchenForm  : TSuchenForm;
  SuchListe   : TStringList;
  ErsatzListe : TStringList;

implementation

{$R *.dfm}

uses TriaMain,AllgFunc,AllgObj,ListFmt,WettkObj,AkObj,TlnObj,TlnErg,DateiDlg,VistaFix;

//******************************************************************************
procedure SuchenErsetzen(Modus:TSuchErsetzModus);
//******************************************************************************
var i   : Integer;
    Col : TColType;
begin
  if HauptFenster.LstFrame.TriaGrid.ItemCount = 0 then
  begin
    TriaMessage('Die Liste ist leer.',mtInformation,[mbOk]);
    Exit;
  end;
  with SuchenForm do
  begin
    if Modus = seErsetzen then SuchTabControl.TabIndex := 1
                          else SuchTabControl.TabIndex := 0;

    Bestaetigen              := false;
    GrossKleinCheckB.Checked := false;
    GanzCheckB.Checked       := false;
    BestaetigenCB.Checked    := false;
    SuchenNachCB.Items       := SuchListe;
    if SuchenNachCB.Items.Count > 0 then
    begin
      SuchenNachCB.ItemIndex := 0;
      SuchenNachCB.SelectAll;
    end;
    ErsetzenCB.Items := ErsatzListe;
    if ErsetzenCB.Items.Count > 0 then
    begin
      ErsetzenCB.ItemIndex := 0;
      ErsetzenCB.SelectAll;
    end;

    for i:=0 to HauptFenster.LstFrame.TriaGrid.ColCount-1 do
    begin
      Col := GetColType(HauptFenster.ListType,i,lmSchirm);
      case Col of
        spNameVName:
        begin
          SuchenInCB.Items.Add(GetColHeader(spName,HauptFenster.SortWettk));
          SuchenInCB.Items.Add(GetColHeader(spVName,HauptFenster.SortWettk));
        end;
        spMannsch,spLand: // spMschName nicht ändern
          SuchenInCB.Items.Add(GetColHeader(Col,HauptFenster.SortWettk));
        else ;
      end;
    end;
  SuchenInCB.ItemIndex  := 0; // Name immer an 1. Stelle
  SuchenNachCB.Taborder := 0;
  SuchenInCB.Taborder   := 1;
  ErsetzenCB.Taborder   := 2;
  OptionenGB.Taborder   := 3;
  SetzeFonts(Font);

  // UpdateTab;  in FormShow

  SuchenForm.Show;

  {try
    SuchenForm.Show;
  finally
    FreeAndNil(SuchenForm);
  end;}
  {if AutoSpeichernRequest then TriDatAutoSpeichern; // falls Daten geändert wurden
  if not SofortRechnen or not Rechnen or
     not BerechneRangAlleWettk then HauptFenster.UpdateAnsicht;}
end;

//------------------------------------------------------------------------------
procedure TSuchenForm.UpdateTab;
//------------------------------------------------------------------------------
begin
  if SuchTabControl.TabIndex = 1 then
  begin
    ErsetzenLabel.Show;
    ErsetzenCB.Show;
    BestaetigenCB.Show;
    ErsetzButton.Show;
    AllesButton.Show;
    if SuchenNachCB.Items.Count = 0 then SuchenNachCB.SetFocus
                                    else ErsetzenCB.SetFocus;
  end else
  begin
    ErsetzenLabel.Hide;
    ErsetzenCB.Hide;
    BestaetigenCB.Hide;
    ErsetzButton.Hide;
    AllesButton.Hide;
    SuchenNachCB.SetFocus;
    //SuchenNachCB.SelectAll;
  end;
    SuchenNachCB.SelectAll;
    ErsetzenCB.SelectAll;
end;

{------------------------------------------------------------------------------}
function TSuchenForm.GetSpalte: TColType;
{------------------------------------------------------------------------------}
var Idx  : Integer;
    S    :  string;
    //bool : Boolean;
begin
  Result := spLeer;
  Idx := SuchenInCB.ItemIndex;
  if Idx < 0 then Exit;
  S := SuchenInCB.Items[Idx];
  if S = GetColHeader(spName,HauptFenster.SortWettk) then Result := spName
  else if S = GetColHeader(spVName,HauptFenster.SortWettk) then Result := spVName
  else if S = GetColHeader(spMannsch,HauptFenster.SortWettk) then
    if HauptFenster.TlnAnsicht then Result := spMannsch
                               else Result := spMschName
  else if S = GetColHeader(spLand,HauptFenster.SortWettk) then Result := spLand;
end;

{------------------------------------------------------------------------------}
procedure TSuchenForm.DatenUebernehmen;
{------------------------------------------------------------------------------}
var i : Integer;
    Vorhanden : Boolean;
begin
  SuchText := SuchenNachCB.Text;
  Vorhanden := false;
  with SuchenNachCB do
  begin
    for i:=0 to Items.Count-1 do
      if (SuchText<>'') and (SuchText = Items[i]) then
      begin
        Vorhanden := true;
        Break;
      end;
    if not Vorhanden then
    begin
      if Items.Count >= cnSuchListeMax then Items.Delete(Items.Count-1);
      Items.Insert(0,SuchText);
      ItemIndex := 0;
      SuchListe.Clear;
      for i:=0 to Items.Count-1 do
        SuchListe.Add(Items[i]);
    end;
  end;
  if SuchModus = smErsetzen then
  begin
    ErsatzText := ErsetzenCB.Text;
    Vorhanden := false;
    with ErsetzenCB do
    begin
      for i:=0 to Items.Count-1 do
        if (ErsatzText<>'') and (ErsatzText = Items[i]) then
        begin
          Vorhanden := true;
          Break;
        end;
      if not Vorhanden then
      begin
        if Items.Count >= cnSuchListeMax then Items.Delete(Items.Count-1);
        Items.Insert(0,ErsatzText);
        ItemIndex := 0;
        SuchListe.Clear;
        for i:=0 to Items.Count-1 do
          SuchListe.Add(Items[i]);
      end;
    end;
  end;
  SuchSpalte := GetSpalte;
  Bestaetigen := (SuchModus = smErsetzen) and BestaetigenCB.Checked;
end;

{------------------------------------------------------------------------------}
function TSuchenForm.EingabeOK: Boolean;
{------------------------------------------------------------------------------}
begin
  Result := false;
  if HauptFenster.LstFrame.TriaGrid.ItemCount = 0 then
  begin
    TriaMessage('Die Liste ist leer.',mtInformation,[mbOk]);
    Exit;
  end;
  if SuchenNachCB.Text = '' then
  begin
    TriaMessage('Suchbegriff fehlt.',mtInformation,[mbOk]);
    SuchenNachCB.SetFocus;
    Exit;
  end;
  if ErsetzenCB.Visible and (ErsetzenCB.Text = '') then
  begin
    TriaMessage('Ersatzbegriff fehlt.',mtInformation,[mbOk]);
    ErsetzenCB.SetFocus;
    Exit;
  end;
  {if GetSpalte = spMschName then
    if AnsiContainsStr(SuchenNachCB.Text,'~') then
    begin
      TriaMessage('Zeichen "~" kann nicht ersetzt werden',mtInformation,[mbOk],0);
      SuchenNachCB.SetFocus;
      Exit;
    end;}
  Result := true;
end;

//------------------------------------------------------------------------------
function TSuchenForm.ErsetzeIdx(const TlnIdx:Integer): Boolean;
//------------------------------------------------------------------------------
var Tln     : TTlnObj;
    Buttons : TMsgDlgButtons;

//..............................................................................
procedure TlnTextErsetzen;
//..............................................................................
function ReplaceSuchText(S:String): String;
begin
  if GrossKleinCheckB.Checked then Result := ReplaceStr(S,SuchText,ErsatzText)
                              else Result := ReplaceText(S,SuchText,ErsatzText);
end;
begin
  case SuchSpalte of
    spName    : Tln.Name        := ReplaceSuchText(Tln.Name);
    spVName   : Tln.VName       := ReplaceSuchText(Tln.VName);
    spMannsch : Tln.MannschName := ReplaceSuchText(Tln.MannschName);
    spLand    : Tln.Land        := ReplaceSuchText(Tln.Land);
    else Exit; //spMschName: nicht ersetzen
  end;
  Inc(ErsatzCount);
  HauptFenster.LstFrame.TriaGrid.Refresh; // noch nicht neu sortieren
  TriDatei.Modified := true;
end;

//..............................................................................
begin
  Result := false;
  Tln :=  TTlnObj(HauptFenster.LstFrame.TriaGrid[TlnIdx]);
  if Tln=nil then Exit;
  if SuchModus = smErsetzen then Buttons := [mbOk,mbCancel]
                            else Buttons := [mbYes,mbYesToAll,mbNo,mbCancel];

  if not Bestaetigen then
  begin
    TlnTextErsetzen;
    Result := true;
  end else
    case TriaMessage('Dieses Vorkommen von "'+SuchText+'" in "'+
                     Trim(GetColHeader(SuchSpalte,HauptFenster.SortWettk))+
                     '" ersetzen?',
                     mtInformation,Buttons) of
      mrYes, mrOk:
      begin
        TlnTextErsetzen;
        Result := true;
      end;
      mrYesToAll:
      begin
        Bestaetigen := false;
        TlnTextErsetzen;
        Result := true;
      end;
      mrNo: Result := true; // nicht Ersetzen aber weitersuchen
      else Abbruch := true; // Suche Abbrechen, Result false
    end;
end;

//------------------------------------------------------------------------------
procedure TSuchenForm.WeiterSuchen(SuchModus: TSuchModus);
//------------------------------------------------------------------------------
// ab aktueller Index suchen.
// wenn ganze Liste durchsucht und nicht bei Idx=0 angefangen, dann am Ende fragen
// ob am Anfang weitergesucht werden soll.
// smSuchen: nächste Zeile mit Übereinsimmung suchen
// smErsetzen: aktuelle Zeile vergleichen und bei Übereinstimmung Ersetzen. Dann,
// auch wenn keine Übereinstimmung, nächste Zeile suchen.
// smAlleErsetzen: bis zuim Ende nächste Zeile mit Übereinstimmung suchen und ersetzen

var SuchStartIdx,
    SuchStopIdx : Integer;
//..............................................................................
procedure VergleicheIdx(Idx:Integer);
//..............................................................................
// SuchStopIdx zeigt Ergebnis
var Tln  : TTlnObj;
    Wk   : TWettkObj;
    Ak   : TAkObj;
    Wrtg : TWertungMode;
    Bool : Boolean;
begin
  SuchStopIdx := -1;
  Wk          := HauptFenster.SortWettk;
  Ak          := HauptFenster.SortKlasse;
  Wrtg        := HauptFenster.SortWrtg;
  with HauptFenster.LstFrame do
  begin
    if (Idx < 0) or (Idx >= TriaGrid.ItemCount) then Exit;
    //TriaGrid.ItemIndex := Idx; // Suche laufend in Liste anzeigen
    Tln := TTlnObj(TriaGrid[Idx]);
    if GanzCheckB.Checked and GrossKleinCheckB.Checked and
       AnsiSameStr(Trim(GetColData(Wk,Wrtg,Ak,Tln,SuchSpalte,Bool,lmSchirm)),Suchtext) or
       GanzCheckB.Checked and not GrossKleinCheckB.Checked and
       AnsiSameText(Trim(GetColData(Wk,Wrtg,Ak,Tln,SuchSpalte,Bool,lmSchirm)),Suchtext) or
       not GanzCheckB.Checked and GrossKleinCheckB.Checked and
       AnsiContainsStr(Trim(GetColData(Wk,Wrtg,Ak,Tln,SuchSpalte,Bool,lmSchirm)),Suchtext) or
       not GanzCheckB.Checked and not GrossKleinCheckB.Checked and
       AnsiContainsText(Trim(GetColData(Wk,Wrtg,Ak,Tln,SuchSpalte,Bool,lmSchirm)),Suchtext) then
    begin
      SuchStopIdx := Idx;
      TriaGrid.ItemIndex := Idx; // Suche in Liste anzeigen
    end;
    // function AnsiResemblesText(const AText, AOther: String): Boolean;  end;
  end;
end;

//..............................................................................
procedure SucheAbNextIdx(Idx:Integer);
//..............................................................................
// Ganze Liste durchsuchen ab Idx nach StartIdx bis SuchStart-1, true wenn gefunden
// SuchStopIdx zeigt Ergebnis
var i : Integer;
//..............................................................................
function NextIdx(Idx:Integer):Integer;
begin
  if Idx < HauptFenster.LstFrame.TriaGrid.ItemCount-1 then
    Result := Idx+1
  else Result := 0; // weiter am Anfang
end;
//..............................................................................
begin
  SuchStopIdx := -1;
  i := Idx;
  repeat
    i := NextIdx(i);
    if i = SuchStartIdx then Exit; // Suchvorgang abgeschlossen
    VergleicheIdx(i);
  until SuchStopIdx >= 0;
end;

//..............................................................................
begin // function VergleicheIdx(Idx:Integer): Boolean;

  SuchStartIdx := HauptFenster.LstFrame.TriaGrid.ItemIndex;
  if SuchStartIdx < 0 then Exit;
  SuchStopIdx := -1;
  ErsatzCount := 0;
  Bestaetigen := (SuchModus <> smSuchen) and BestaetigenCB.Checked;
  Abbruch := false;

  case SuchModus of
    smSuchen:
    begin
      VergleicheIdx(SuchStartIdx);
      if SuchStopIdx < 0 then
        SucheAbNextIdx(SuchStartIdx); // ganze Liste wird durchsucht;
    end;
    smErsetzen: // ersetzen nur am Anfang der Liste, Abbruch wenn Ersetzen abgebrochen wird
    begin
      VergleicheIdx(SuchStartIdx);
      if (SuchStopIdx < 0) or ErsetzeIdx(SuchStartIdx) then
        SucheAbNextIdx(SuchStartIdx); // ganze Liste wird durchsucht;
    end;
    smAlleErsetzen:
    begin
      VergleicheIdx(SuchStartIdx);
      if (SuchStopIdx < 0) or ErsetzeIdx(SuchStartIdx) then //Abbruch wenn Ersetzen abgebrochen wird
      begin
        SuchStopIdx := SuchStartIdx;
        repeat
          SucheAbNextIdx(SuchStopIdx); // ganze Liste wird durchsucht;
          if (SuchStopIdx >= 0) and not ErsetzeIdx(SuchStopIdx) then
            SuchStopIdx := -1;
        until (SuchStopIdx < 0);
      end;
    end;
  end;

  if (SuchModus=smSuchen) and (SuchStopIdx < 0) or
     ((SuchModus=smErsetzen)or(SuchModus=smAlleErsetzen)) and
      (ErsatzCount = 0) and not Abbruch then
    TriaMessage('Der Suchvorgang ist abgeschlossen.'+#13+
                'Der Suchbegriff "'+SuchText+'" wurde in Spalte "'+
                Trim(GetColHeader(SuchSpalte,HauptFenster.SortWettk))+
                '" nicht gefunden.',
                mtInformation,[mbOk])
  else
  if (SuchModus=smAlleErsetzen) and (ErsatzCount > 0) then
    TriaMessage('Der Suchvorgang ist abgeschlossen.'+#13+
                'Der Suchbegrif "'+SuchText+'" wurde in Spalte "'+
                Trim(GetColHeader(SuchSpalte,HauptFenster.SortWettk))+'"'+#13+
                IntToStr(ErsatzCount)+' mal ersetzt.',
                mtInformation,[mbOk]);

end;

//==============================================================================
constructor TSuchenForm.Create(AOwner: TComponent);
//==============================================================================
var i   : Integer;
    Col : TColType;
begin
  inherited Create(AOwner);

  Bestaetigen   := false;
  GrossKleinCheckB.Checked := false;
  GanzCheckB.Checked       := false;
  BestaetigenCB.Checked    := false;
  SuchenNachCB.Items := SuchListe;
  if SuchenNachCB.Items.Count > 0 then
  begin
    SuchenNachCB.ItemIndex := 0;
    SuchenNachCB.SelectAll;
  end;

  ErsetzenCB.Items := ErsatzListe;
  if ErsetzenCB.Items.Count > 0 then
    ErsetzenCB.ItemIndex := 0;

  for i:=0 to HauptFenster.LstFrame.TriaGrid.ColCount-1 do
  begin
    Col := GetColType(HauptFenster.ListType,i,lmSchirm);
    case Col of
      spNameVName:
      begin
        SuchenInCB.Items.Add(GetColHeader(spName,HauptFenster.SortWettk));
        SuchenInCB.Items.Add(GetColHeader(spVName,HauptFenster.SortWettk));
      end;
      spMannsch,spLand: // spMschName nicht ändern
        SuchenInCB.Items.Add(GetColHeader(Col,HauptFenster.SortWettk));
      else ;
    end;
  end;
  SuchenInCB.ItemIndex  := 0; // Name immer an 1. Stelle
  SuchenNachCB.Taborder := 0;
  SuchenInCB.Taborder   := 1;
  ErsetzenCB.Taborder   := 2;
  OptionenGB.Taborder   := 3;
  SetzeFonts(Font);

  if SuchErsetzModus = seErsetzen then SuchTabControl.TabIndex := 1
                                  else SuchTabControl.TabIndex := 0;
  // UpdateTab;  in FormShow

end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSuchenForm.FormShow(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  UpdateTab;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSuchenForm.FormHide(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if AutoSpeichernRequest then TriDatAutoSpeichern; // falls Daten geändert wurden
  if not SofortRechnen or not Rechnen or
     not BerechneRangAlleWettk then HauptFenster.UpdateAnsicht;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSuchenForm.SuchTabControlChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  UpdateTab;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSuchenForm.SuchenNachLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if SuchenNachCB.CanFocus then SuchenNachCB.SetFocus;
  SuchenNachCB.SelectAll; // Cursor vollständig dargestellt
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSuchenForm.SuchenInLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if SuchenInCB.CanFocus then SuchenInCB.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSuchenForm.ErsetzenLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if ErsetzenCB.CanFocus then ErsetzenCB.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSuchenForm.SuchButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if EingabeOK then // Weitersuchen
  begin
    DatenUebernehmen;
    WeiterSuchen(smSuchen);
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSuchenForm.ErsetzButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if EingabeOK then // Weitersuchen
  begin
    DatenUebernehmen;
    WeiterSuchen(smErsetzen);
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSuchenForm.AllesButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if EingabeOK then
  begin
    DatenUebernehmen;
    WeiterSuchen(smAlleErsetzen);
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSuchenForm.CancelButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  Hide;
end;



end.
