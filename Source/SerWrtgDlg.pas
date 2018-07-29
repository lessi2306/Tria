unit SerWrtgDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, Grids, Math,ExtCtrls,
  AllgComp,AllgConst,AllgFunc,AllgObj,VeranObj,WettkObj,TlnObj,MannsObj,AkObj,
  OrtObj;

procedure SerWrtgDefinieren;


type
  TSerWrtgDialog = class(TForm)

  published
    WettkCBLabel: TLabel;
    WettkCB: TComboBox;
    SerWrtgGB: TGroupBox;
      StreichErgLabel: TLabel;
      StreichErgEdit: TTriaMaskEdit;
      StreichErgUpDown: TTriaUpDown;
      StreichOrtLabel: TLabel;
      StreichOrtEdit: TTriaMaskEdit;
      StreichOrtUpDown: TTriaUpDown;
      AkJahrLabel1: TLabel;
      AkJahrLabel2: TLabel;
      AkJahrCB: TComboBox;
      PflichtWkLabel: TLabel;
      PflichtWkArtDB: TComboBox;
      PflichtWkOrt1DB: TComboBox;
      PflichtWkOrt2DB: TComboBox;
      PunktGleichOrtLabel: TLabel;
      PunktGleichOrtDB: TComboBox;
    TabControl1: TTabControl;
      WertungPanel: TPanel;
      WertungsPunkteGB: TGroupBox;
        SerWrtgZeitRB: TRadioButton;
        SerPktRngUpRB: TRadioButton;
        RngUpCB: TCheckBox;
        SerPktRngDownRB: TRadioButton;
        RngDwnCB: TCheckBox;
        SerPktFlexRB: TRadioButton;
        WrtgPktHeaderGrid: TStringGrid;
        WrtgPktGrid: TStringGrid;
        WrtgPktGBPanel: TPanel;
        WrtgPktGB: TGroupBox;
          RngVonLabel: TLabel;
          RngVonEdit: TTriaMaskEdit;
          RngVonUpDown: TTriaUpDown;
          RngBisLabel: TLabel;
          RngBisEdit: TTriaMaskEdit;
          RngBisUpDown: TTriaUpDown;
          PktVonLabel: TLabel;
          PktVonEdit: TTriaMaskEdit;
          PktVonUpDown: TTriaUpDown;
          PktIncrCB: TComboBox;
          PktIncrEdit: TTriaMaskEdit;
          PktIncrUpDown: TTriaUpDown;
          PktBisLabel: TLabel;
          PktBisEdit: TTriaEdit;
        AendButton: TButton;
        NeuButton: TButton;
        LoeschButton: TButton;
        KopierButton: TButton;
        EinfuegButton: TButton;
        DefaultButton: TButton;
    UebernehmAlleButton: TButton;
    UebernehmButton: TButton;
    OkButton: TButton;
    CancelButton: TButton;
    HilfeButton: TButton;

    // Event Handler
    procedure FormShow(Sender: TObject);
    procedure WettkCBLabelClick(Sender: TObject);
    procedure WettkCBChange(Sender: TObject);

    procedure SerWrtgGBClick(Sender: TObject);
    procedure StreichErgLabelClick(Sender: TObject);
    procedure StreichErgEditChange(Sender: TObject);
    procedure StreichOrtLabelClick(Sender: TObject);
    procedure StreichOrtEditChange(Sender: TObject);
    procedure AkJahrLabelClick(Sender: TObject);
    procedure AkJahrCBChange(Sender: TObject);
    procedure PflichtWkLabelClick(Sender: TObject);
    procedure PflichtWkArtDBChange(Sender: TObject);
    procedure PunktGleichOrtLabelClick(Sender: TObject);
    procedure OrtDBChange(Sender: TObject);

    procedure TabControl1Change(Sender: TObject);
    procedure TabControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure SerPktRBClick(Sender: TObject);
    procedure WrtgPktHeaderGridClick(Sender: TObject);
    procedure WrtgPktGridClick(Sender: TObject);
    procedure WrtgPktRecChange(Sender: TObject);
    procedure AendButtonClick(Sender: TObject);
    procedure NeuButtonClick(Sender: TObject);
    procedure LoeschButtonClick(Sender: TObject);
    procedure KopierButtonClick(Sender: TObject);
    procedure EinfuegButtonClick(Sender: TObject);
    procedure DefaultButtonClick(Sender: TObject);

    procedure UebernehmAlleButtonClick(Sender: TObject);
    procedure UebernehmButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);

  private
    HelpFensterAlt : TWinControl;
    Updating       : Boolean;
    DisableButtons : Boolean;
    NeuEingabe     : Boolean;
    WkAktuell      : TWettkObj;
    RecIndxAktuell : Integer;
    DefListe       : array[tmTln..tmMsch] of TSerWrtgPktColl;
    KopierListe    : TSerWrtgPktColl;

    // Allgemein
    function    WettkSelected: TWettkObj;
    function    TabSelected: TTlnMsch;
    procedure   SetWkDaten;
    procedure   SetTabDaten;
    procedure   SetButtons;
    function    EingabeOK: Boolean;
    function    SerWrtgGeAendert(Wk:TWettkObj): Boolean;
    function    SerWrtgAendern(Wk:TWettkObj): Boolean;
    // SerWrtgGB
    procedure   SetStreichErg;
    function    GetStreichErg: Integer;
    procedure   SetStreichOrt;
    function    GetStreichOrt: Integer;
    procedure   SetAkJahr;
    function    GetAkJahr: Integer;
    procedure   SetPflichtWk;
    procedure   UpdatePflichtWk;
    procedure   SetPflichtWkOrt;
    procedure   UpdatePflichtWkOrt;
    function    GetPflichtWkMode: TPflichtWkMode;
    function    GetPflichtWkOrt1: TOrtObj;
    function    GetPflichtWkOrt2: TOrtObj;
    procedure   SetPunktGleichOrt;
    function    GetPunktGleichOrt: TOrtObj;

    // WertungsPunkteGB
    procedure   SetWertungsPunkteGB;
    function    GetSerWrtgMode: TSerWrtgMode;
    function    WrtgPktCollSelected(Wk:TWettkObj): TSerWrtgPktColl;
    function    WrtgPktRecSelected: Integer;
    function    GetWrtgPktRec(Indx:Integer): TSerWrtgPktRec;
    procedure   SetWrtgPktDaten;
    procedure   SetWrtgPktGrid(Liste: TSerWrtgPktColl);
    procedure   FocusWrtgPktRec(RecIndx:Integer);
    function    PktIncrement: Boolean;
    function    WrtgPktGridGeAendert(Wk:TWettkObj): Boolean;
    function    GetPktBis(Rec:TSerWrtgPktRec): Integer;
    function    GetPktBisStrng(Rec:TSerWrtgPktRec; L:Integer): String;
    function    GetEditRec: TSerWrtgPktRec;
    function    WrtgPktRecGeAendert: Boolean;
    function    WrtgPktRecOK: Boolean;
    function    WrtgPktRecNeu: Boolean;
    function    WrtgPktRecAendern: Boolean;
    procedure   WrtgPktRecLoeschen;
    function    ListeOK: Boolean;
    function    ListeAendern(Wk:TWettkObj): Boolean;
    function    CompDefaultListe: Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

var
  SerWrtgDialog: TSerWrtgDialog;

const
  hdVon  = '   von';
  hdBis  = '   bis';
  hdIncr = '  Inkr.';
  hdDecr = '  Dekr.';


implementation

uses TriaMain,TlnErg,DateiDlg,VistaFix;

{$R *.dfm}

(******************************************************************************)
procedure SerWrtgDefinieren;
(******************************************************************************)
begin
  SerWrtgDialog := TSerWrtgDialog.Create(HauptFenster);
  try
    SerWrtgDialog.ShowModal;
  finally
    FreeAndNil(SerWrtgDialog);
  end;
  HauptFenster.RefreshAnsicht;
end;


(*============================================================================*)
constructor TSerWrtgDialog.Create(AOwner: TComponent);
(*============================================================================*)
var i,w : Integer;
    Rec : TSerWrtgPktRec;
begin
  inherited Create(AOwner);
  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  Updating       := false;
  DisableButtons := false;
  WkAktuell      := nil;
  RecIndxAktuell := 0;

  with Veranstaltung do
  begin
    for i:=0 to WettkColl.Count-1 do
      WettkCB.Items.AddObject(WettkColl.Items[i].Name,WettkColl.Items[i]);
    if WettkCB.Items.IndexOf(HauptFenster.SortWettk.Name) >= 0 then
      WettkCB.ItemIndex := WettkCB.Items.IndexOf(HauptFenster.SortWettk.Name)
    else WettkCB.ItemIndex := 0;
  end;

  StreichErgEdit.EditMask := '09;0; ';
  StreichOrtEdit.EditMask := '09;0; ';
  StreichErgUpDown.Min := 0;
  StreichErgUpDown.Max := Veranstaltung.OrtZahl-1;
  StreichOrtUpDown.Min := 1; // angezeigt als MindestWk = OrtZahl-StreichOrt
  StreichOrtUpDown.Max := Veranstaltung.OrtZahl;

  PunktGleichOrtDB.Items.Append('<kein>');
  PflichtWkOrt1DB.Items.Append('<kein>');
  PflichtWkOrt2DB.Items.Append('<kein>');
  with Veranstaltung.OrtColl do
    for i:=0 to Count-1 do
    begin
      PunktGleichOrtDB.Items.Append(Items[i].Name);
      PflichtWkOrt1DB.Items.Append(Items[i].Name);
      PflichtWkOrt2DB.Items.Append(Items[i].Name);
    end;

  with WrtgPktGrid do
  begin
    Top := AendButton.Top+DefaultRowHeight+2;
    Height := WrtgPktGB.Height + WrtgPktGB.Top - Top;
    Canvas.Font := Font;
    DefaultRowHeight := 17{WrtgPktGrid.Canvas.TextHeight('Tg')+1};
    FixedRows  := 1;
    FixedCols  := 0;
    ColCount   := 5;
    w := 37;
    for i:=0 to 3 do ColWidths[i] := w;
    ColWidths[4] := w + 1 + 16;
    w := 0;
    for i:=0 to ColCount-1 do w := w + ColWidths[i];
    w := w + 4;
    Width := w;
    TabOrder := 0; (* Set Focus *)
  end;

  with WrtgPktHeaderGrid do
  begin
    Top := AendButton.Top;
    Width := WrtgPktGrid.Width;
    Canvas.Font := Font;
    DefaultRowHeight := WrtgPktGrid.DefaultRowHeight+2;
    RowCount := 2;
    FixedRows := 1;
    ColCount := 2;
    ColWidths[0] := WrtgPktGrid.ColWidths[0]+WrtgPktGrid.ColWidths[1] + 1;
    ColWidths[1] := WrtgPktGrid.ColWidths[2]+WrtgPktGrid.ColWidths[3] +
                    WrtgPktGrid.ColWidths[4] + 2;
    Cells[0,0] := '   Platzierung';
    Cells[1,0] := '             Punkte';
  end;

  // WrtgPktGB.Caption grau darstellen wenn disabled
  WrtgPktGBPanel.Width := Canvas.TextWidth(WrtgPktGB.Caption);
  WrtgPktGBPanel.Top   := WrtgPktGB.Top;
  WrtgPktGBPanel.Left  := WrtgPktGB.Left+8;

  RngVonEdit.EditMask  := '0999;0; ';
  RngBisEdit.EditMask  := '0999;0; ';
  PktVonEdit.EditMask  := '0999;0; ';
  PktIncrEdit.EditMask := '0999;0; ';
  RngVonUpDown.Min  := 1;
  RngVonUpDown.Max  := cnTlnMax;
  RngBisUpDown.Min  := 1;
  RngBisUpDown.Max  := cnTlnMax;
  PktVonUpDown.Min  := 0;
  PktVonUpDown.Max  := cnTlnMax;
  PktIncrUpDown.Min := 0;
  PktIncrUpDown.Max := cnTlnMax;

  TabControl1.TabIndex := 0; // Teilnehmer

  DefListe[tmTln] := TSerWrtgPktColl.Create(Veranstaltung);
  Rec.RngVon  := 1;
  Rec.RngBis  := seTlnMaxRngDef;
  Rec.PktVon  := 1;
  Rec.PktIncr := 1;
  DefListe[tmTln].Add(Rec);
  DefListe[tmMsch] := TSerWrtgPktColl.Create(Veranstaltung);
  Rec.RngVon  := 1;
  Rec.RngBis  := seMschMaxRngDef;
  Rec.PktVon  := 1;
  Rec.PktIncr := 1;
  DefListe[tmMsch].Add(Rec);

  // damit Count in SetButtons abgefragt werden kann.
  KopierListe := TSerWrtgPktColl.Create(Veranstaltung);
  CancelButton.Cancel := true;
  // SetWkDaten  in FormShow;

  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);
end;


(*============================================================================*)
destructor TSerWrtgDialog.Destroy;
(*============================================================================*)
begin
  KopierListe.Free;
  DefListe[tmTln].Free;
  DefListe[tmMsch].Free;
  HelpFenster := HelpFensterAlt;
  inherited Destroy;
end;

// private Methoden
// Allgemein

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.WettkSelected: TWettkObj;
(*----------------------------------------------------------------------------*)
begin
  if WettkCB.ItemIndex >= 0 then
    Result := TWettkObj(WettkCB.Items.Objects[WettkCB.ItemIndex])
  else Result := nil; // illegal
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.TabSelected: TTlnMsch;
(*----------------------------------------------------------------------------*)
begin
  if TabControl1.TabIndex = 1 then Result := tmMsch
                              else Result := tmTln;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.SetWkDaten;
(*----------------------------------------------------------------------------*)
// bei Wettk-Change
begin
  WkAktuell := WettkSelected;
  if WkAktuell = nil then Exit;
  Updating := true;

  // TabControl1 setzen
  TabControl1.Tabs.Strings[0] := 'Teilnehmer';
  if WkAktuell.MschWertg <> mwKein then
    if TabControl1.Tabs.Count=1 then
      TabControl1.Tabs.Add('Mannschaften')
    else
  else // keine MschWertung
    if TabControl1.Tabs.Count=2 then  // MschWertung löschen
    begin
      TabControl1.TabIndex := 0;
      TabControl1.Tabs.Delete(1);
    end;
  // Tab muss vorher definiert sein
  SetTabdaten;

  Updating := false;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.SetTabDaten;
(*----------------------------------------------------------------------------*)
// bei Tab-Change
var UpdAlt : Boolean;
    SerWrtgAlle : Boolean;
    i : Integer;
begin
  UpdAlt := Updating;
  Updating := true;
  SerWrtgAlle := true;
  for i:=0 to Veranstaltung.OrtZahl-1 do
    if not WkAktuell.TlnOrtSerWertung(i) then
    begin
      SerWrtgAlle := false;
      Break;
    end;
  if (TabSelected = tmTln) and not SerWrtgAlle then 
    WertungPanel.Show
  else WertungPanel.Hide;
  SetStreichErg;
  SetStreichOrt;
  SetAkJahr;
  SetPflichtWk;
  SetPunktGleichOrt;
  SetWertungsPunkteGB;
  if StreichErgEdit.CanFocus then StreichErgEdit.SetFocus;
  Updating := UpdAlt;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.SetButtons;
(*----------------------------------------------------------------------------*)
begin
  // WrtgPktButtons
  if WrtgPktGB.Enabled then // (vaCup or tmTln) and SerPktFlex
  begin
    if WrtgPktRecGeAendert then AendButton.Enabled := true
                           else AendButton.Enabled := false;

    if NeuEingabe or
      (GetWrtgPktRec(RecIndxAktuell).RngBis >= cnTlnMax) or // cnTlnMax=cnMschMax
      (GetWrtgPktRec(WrtgPktGrid.RowCount-1).RngBis >= cnTlnMax) or // cnTlnMax=cnMschMax
      (GetPktBis(GetWrtgPktRec(RecIndxAktuell)) <= 0) or
      (GetPktBis(GetWrtgPktRec(RecIndxAktuell)) >= cnTlnMax) or
      (WrtgPktGrid.RowCount >= cnTlnMax+1) then NeuButton.Enabled := false
                                           else NeuButton.Enabled := true;

    if (WrtgPktGrid.RowCount <= 2) or (RecIndxAktuell <= 1) then
      LoeschButton.Enabled := false
    else LoeschButton.Enabled := true;

    if WrtgPktRecGeAendert or SerWrtgGeAendert(WkAktuell) then KopierButton.Enabled := false
                                                          else KopierButton.Enabled := true;

    if KopierListe.Count>0 then EinfuegButton.Enabled := true
                           else EinfuegButton.Enabled := false;

    if CompDefaultListe then DefaultButton.Enabled := false
                        else DefaultButton.Enabled := true;
  end else // disabled bei Liga-Mannschaften
  begin
    AendButton.Enabled := false;
    NeuButton.Enabled := false;
    LoeschButton.Enabled := false;
    KopierButton.Enabled := false;
    EinfuegButton.Enabled := false;
    DefaultButton.Enabled := false;
  end;

  if SerWrtgGeAendert(WkAktuell) then UebernehmButton.Enabled := true
                                 else UebernehmButton.Enabled := false;
  if (Veranstaltung.WettkColl.Count > 1) and SerWrtgGeAendert(WettkAlleDummy) then
    UebernehmAlleButton.Enabled := true
  else UebernehmAlleButton.Enabled := false;

  // Setze Default Button
  if WrtgPktGB.Enabled and WrtgPktRecGeAendert then
  begin
    UebernehmButton.Default   := false;
    OkButton.Default          := false;
    AendButton.Default        := true;
  end else
  begin
    AendButton.Default        := false;
    if SerWrtgGeAendert(WkAktuell) then
    begin
      OkButton.Default        := false;
      UebernehmButton.Default := true;
    end else
    begin
      UebernehmButton.Default := false;
      OkButton.Default        := true;
    end;
  end;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.EingabeOK: Boolean;
(*----------------------------------------------------------------------------*)
begin
  Result := false;

  // SerWrtgGB
  if GetStreichErg < 0 then // ungültig
  begin
    // standard Fehlermeldung auch bei drucken der Enter-Taste
    StreichErgEdit.ValidateEdit;
    Exit;
  end;
  if GetStreichOrt < 0 then
  begin
    // standard Fehlermeldung auch bei drucken der Enter-Taste
    StreichErgEdit.ValidateEdit;
    Exit;
  end;

  if GetPflichtWkMode <> pw0 then
  begin
    if GetPflichtWkOrt1 = nil then
    begin
      TriaMessage(Self,'Erster Pflichtwettkampfort ist nicht definiert.',
                   mtInformation,[mbOk]);
      if PflichtWkOrt1DB.CanFocus then PflichtWkOrt1DB.SetFocus;
      Exit;
    end else
    if (TabSelected = tmTln) and
       (Veranstaltung.OrtColl.IndexOf(GetPflichtWkOrt1) >= 0) and
       (WkAktuell <> nil) and
       not WettkSelected.TlnOrtSerWertung(Veranstaltung.OrtColl.IndexOf(GetPflichtWkOrt1)) then
    begin
      TriaMessage(Self,'Erster Pflichtwettkampfort wird nur für Mannschafts-Serienwertung berücksichtigt.',
                   mtInformation,[mbOk]);
      if PflichtWkOrt1DB.CanFocus then PflichtWkOrt1DB.SetFocus;
      Exit;
    end;
  end;

  if (GetPflichtWkMode = pw1v2) or (GetPflichtWkMode = pw2) then
  begin
    if GetPflichtWkOrt2 = nil then
    begin
      TriaMessage(Self,'Zweiter Pflichtwettkampfort ist nicht definiert.',
                   mtInformation,[mbOk]);
      if PflichtWkOrt2DB.CanFocus then PflichtWkOrt2DB.SetFocus;
      Exit;
    end;
    if (GetPflichtWkMode = pw2) and (GetStreichErg > Veranstaltung.OrtZahl-2) then
    begin
      TriaMessage(Self,'Bei 2 Pflichtwettkämpfen können höchstens ' +
                   IntToStr(Veranstaltung.OrtZahl-2) + ' der '+IntToStr(Veranstaltung.OrtZahl)+
                   ' Ergebnisse gestrichen werden.',
                   mtInformation,[mbOk]);
      if StreichErgEdit.CanFocus then StreichErgEdit.SetFocus;
      Exit;
    end;
    if (TabSelected = tmTln) and
       (Veranstaltung.OrtColl.IndexOf(GetPflichtWkOrt2) >= 0) and
       (WkAktuell <> nil) and
       not WettkSelected.TlnOrtSerWertung(Veranstaltung.OrtColl.IndexOf(GetPflichtWkOrt2)) then
    begin
      TriaMessage(Self,'Zweiter Pflichtwettkampfort wird nur für Mannschafts-Serienwertung berücksichtigt.',
                   mtInformation,[mbOk]);
      if PflichtWkOrt2DB.CanFocus then PflichtWkOrt2DB.SetFocus;
      Exit;
    end;
    if GetPflichtWkOrt1 = GetPflichtWkOrt2 then
    begin
      TriaMessage(Self,'Die beiden Pflichtwettkampforte müssen unterschiedlich sein.',
                   mtInformation,[mbOk]);
      if PflichtWkOrt2DB.CanFocus then PflichtWkOrt2DB.SetFocus;
      Exit;
    end;
  end;

  if (TabSelected = tmTln) and (GetPunktGleichOrt <> nil) and
     (Veranstaltung.OrtColl.IndexOf(GetPunktGleichOrt) >= 0) and
     (WkAktuell <> nil) and
     not WettkSelected.TlnOrtSerWertung(Veranstaltung.OrtColl.IndexOf(GetPunktGleichOrt)) then
  begin
    TriaMessage(Self,'Ort für Punktgleichheit wird nur für Mannschafts-Serienwertung berücksichtigt.',
                 mtInformation,[mbOk]);
    if PunktGleichOrtDB.CanFocus then PunktGleichOrtDB.SetFocus;
    Exit;
  end;

  if not ListeOk then Exit;
  if not WrtgPktRecOK then Exit;

  Result := true;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.SerWrtgGeAendert(Wk:TWettkObj): Boolean;
(*----------------------------------------------------------------------------*)
// Ergebnis pro Tab
var TlnMsch : TTlnMsch;
    Indx,WkMinIndx,WkMaxIndx : Integer;
begin
  Result := false;
  if Wk = nil then Exit;
  if Wk = WettkAlleDummy then
  begin
    WkMinIndx := 0;
    WkMaxIndx := Veranstaltung.WettkColl.Count-1;
  end else
  begin
    WkMinIndx := Veranstaltung.WettkColl.IndexOf(Wk);
    WkMaxIndx := WkMinIndx;
  end;
  if WkMinIndx < 0 then Exit;

  TlnMsch := TabSelected;
  Result := true;
  for Indx := WkMinIndx to WkMaxIndx do
  with Veranstaltung.WettkColl[Indx] do
  begin
    if ((GetStreichErg <> StreichErg[TlnMsch]) or
        (GetStreichOrt <> StreichOrt[TlnMsch]) or
        (GetAkJahr <> SerWrtgJahr) or
        ((GetStreichErg > 0) or (GetStreichOrt > 0)) and
        ((GetPflichtWkMode <> PflichtWkMode[TlnMsch]) or
         (GetPflichtWkOrt1 <> PflichtWkOrt1[TlnMsch]) or
         (GetPflichtWkOrt2 <> PflichtWkOrt2[TlnMsch]))) or
        (GetSerWrtgMode    <> SerWrtgMode[TlnMsch]) or
        (GetPunktGleichOrt <> PunktGleichOrt[TlnMsch]) then Exit;
  end;
  if WrtgPktRecGeAendert or WrtgPktGridGeAendert(Wk) then Exit;
  Result := false;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.SerWrtgAendern(Wk:TWettkObj): Boolean;
(*----------------------------------------------------------------------------*)
// nur für aktuelle Tab ändern
var Indx,WkMinIndx,WkMaxIndx : Integer;
begin
  Result := false;
  if (Wk=nil) or not EingabeOk then Exit;

  if Wk = WettkAlleDummy then
  begin
    WkMinIndx := 0;
    WkMaxIndx := Veranstaltung.WettkColl.Count-1;
  end else
  begin
    WkMinIndx := Veranstaltung.WettkColl.IndexOf(Wk);
    WkMaxIndx := WkMinIndx;
  end;
  if WkMinIndx < 0 then Exit;

  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    for Indx := WkMinIndx to WkMaxIndx do
    with Veranstaltung.WettkColl[Indx] do
    begin
      StreichErg[TabSelected]     := GetStreichErg;
      StreichOrt[TabSelected]     := GetStreichOrt;
      SerWrtgJahr                 := GetAkJahr;
      PflichtWkMode[TabSelected]  := GetPflichtWkMode;
      PflichtWkOrt1[TabSelected]  := GetPflichtWkOrt1;
      PflichtWkOrt2[TabSelected]  := GetPflichtWkOrt2;
      PunktGleichOrt[TabSelected] := GetPunktGleichOrt;
      SerWrtgMode[TabSelected]    := GetSerWrtgMode;
    end;

    if WrtgPktRecGeAendert and not WrtgPktRecAendern then Exit;
    if WrtgPktGridGeAendert(Wk) and not ListeAendern(Wk) then Exit;

    SetButtons;
    TriDatei.Modified := true;
    Result := true;

  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;

end;

// SerWrtgGB

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.SetStreichErg;
(*----------------------------------------------------------------------------*)
// benutzt in SetWkDaten
begin
  if WkAktuell <> nil then
  begin
    StreichErgLabel.Enabled  := true;
    StreichErgEdit.Enabled   := true;
    StreichErgUpDown.Enabled := true;
    StreichErgEdit.Text := IntToStr(WkAktuell.StreichErg[TabSelected]);// nach Enable
  end else
  begin
    StreichErgLabel.Enabled  := false;
    StreichErgEdit.Enabled   := false;
    StreichErgUpDown.Enabled := false;
    StreichErgEdit.Text := '';
  end;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.GetStreichErg: Integer;
(*----------------------------------------------------------------------------*)
begin
  if (StrToIntDef(StreichErgEdit.Text,0) >= StreichErgUpDown.Min) and
     (StrToIntDef(StreichErgEdit.Text,0) <= StreichErgUpDown.Max) then
    Result := StrToIntDef(StreichErgEdit.Text,0)
  else Result := -1; // ungültig, in EingabeOk ausgewertet
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.SetStreichOrt;
(*----------------------------------------------------------------------------*)
// benutzt in SetWkDaten
// Edit.Text: Mindestwettk = OrtZahl - StreichOrt
begin
  if WkAktuell <> nil then
  begin
    StreichOrtLabel.Enabled  := true;
    StreichOrtEdit.Enabled   := true;
    StreichOrtUpDown.Enabled := true;
    StreichOrtEdit.Text := IntToStr(Veranstaltung.OrtZahl-WkAktuell.StreichOrt[TabSelected]);// nach Enable
  end else
  begin
    StreichOrtLabel.Enabled  := false;
    StreichOrtEdit.Enabled   := false;
    StreichOrtUpDown.Enabled := false;
    StreichOrtEdit.Text := '';
  end;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.GetStreichOrt: Integer;
(*----------------------------------------------------------------------------*)
begin
  if (StrToIntDef(StreichOrtEdit.Text,0) >= StreichOrtUpDown.Min) and
     (StrToIntDef(StreichOrtEdit.Text,0) <= StreichOrtUpDown.Max) then
    Result := Veranstaltung.OrtZahl - StrToIntDef(StreichOrtEdit.Text,0)
  else Result := -1 // ungültig, in EingabeOk ausgewertet
end;

//------------------------------------------------------------------------------
procedure TSerWrtgDialog.SetAkJahr;
//------------------------------------------------------------------------------
var i,Min,Max : Integer;
begin
  AkJahrLabel1.Enabled := false;
  AkJahrLabel2.Enabled := false;
  AkJahrCB.Enabled     := false;

  AkJahrCB.Items.Clear;
  AkJahrCB.ItemIndex := -1;
  if WkAktuell <> nil then
  begin
    // zunächst Liste mit möglichen Jahrzahlen erstellen
    Min := cnJahrMax;
    Max := cnJahrMin;
    with WkAktuell do
    begin
      for i:=0 to Veranstaltung.OrtZahl-1 do
      begin
        if OrtJahr[i] < Min then Min := OrtJahr[i];
        if OrtJahr[i] > Max then Max := OrtJahr[i];
      end;
      if (SerWrtgJahr > 0) and (SerWrtgJahr < Min) then // falls SerWrtgJahr früher
      begin
        AkJahrCB.Items.Append(Format('%.4u',[SerWrtgJahr]));
        AkJahrCB.ItemIndex := 0;
      end;
      for i:=Min to Max do
      begin
        AkJahrCB.Items.Append(Format('%.4u',[i]));
        if SerWrtgJahr = i then AkJahrCB.ItemIndex := AkJahrCB.Items.Count-1;
      end;
      if SerWrtgJahr > Max then // falls SerWrtgJahr später
      begin
        AkJahrCB.Items.Append(Format('%.4u',[SerWrtgJahr]));
        AkJahrCB.ItemIndex := AkJahrCB.Items.Count-1;
      end;
      if AkJahrCB.ItemIndex = -1 then AkJahrCB.ItemIndex := 0;
      if (TabSelected = tmTln) and       // nur auf Tln-Tab änderbar
         (AkJahrCB.Items.Count > 1) then // nicht alle Wettk im gleichen Jahr
      begin
        AkJahrLabel1.Enabled := true;
        AkJahrLabel2.Enabled := true;
        AkJahrCB.Enabled     := true;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TSerWrtgDialog.GetAkJahr: Integer;
//------------------------------------------------------------------------------
begin
  with AkJahrCB do
    if ItemIndex >= 0 then
      Result := StrToIntDef(Items[ItemIndex],0)
    else Result := 0;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.SetPflichtWk;
(*----------------------------------------------------------------------------*)
// benutzt in SetTabDaten, nach SetStreichErg, SetStreichOrt
begin
  if (WkAktuell <> nil) and
     ((GetStreichErg > 0) or (GetStreichOrt > 0)) then
  begin
    PflichtWkLabel.Enabled := true;
    PflichtWkArtDB.Enabled := true;
  end else
  begin
    PflichtWkLabel.Enabled   := false;
    PflichtWkArtDB.Enabled   := false;
  end;

  if WkAktuell <> nil then
    case WkAktuell.PflichtWkMode[TabSelected] of
      pw1   : PflichtWkArtDB.ItemIndex  := 1;
      pw1v2 : PflichtWkArtDB.ItemIndex  := 2;
      pw2   : PflichtWkArtDB.ItemIndex  := 3;
      else    PflichtWkArtDB.ItemIndex  := 0; // pw0:
    end
  else PflichtWkArtDB.ItemIndex  := 0;

  SetPflichtWkOrt;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.UpdatePflichtWk;
(*----------------------------------------------------------------------------*)
// benutzt in StreichErgChange, StreichOrtChange
begin
  if (GetStreichErg > 0) or (GetStreichOrt > 0) then
  begin
    PflichtWkLabel.Enabled := true;
    PflichtWkArtDB.Enabled := true;
    // PflichtWkArtDB.ItemIndex unverändert
  end else
  begin
    PflichtWkLabel.Enabled   := false;
    PflichtWkArtDB.Enabled   := false;
    PflichtWkArtDB.ItemIndex := 0; // pw0:
  end;
  UpdatePflichtWkOrt;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.SetPflichtWkOrt;
(*----------------------------------------------------------------------------*)
begin
  if WkAktuell <> nil then
  begin
    case PflichtWkArtDB.ItemIndex of
      1: //pw1
      begin
        PflichtWkOrt1DB.Enabled := true;
        if (WkAktuell.PflichtWkOrt1Indx[TabSelected] >= 0) and
           (WkAktuell.PflichtWkOrt1Indx[TabSelected] < Veranstaltung.OrtColl.Count) then
          PflichtWkOrt1DB.ItemIndex := WkAktuell.PflichtWkOrt1Indx[TabSelected] + 1
        else
          PflichtWkOrt1DB.ItemIndex := 0;
        PflichtWkOrt2DB.Enabled := false;
        PflichtWkOrt2DB.ItemIndex := 0;
      end;
      2,3: //pw1v2, pw2
      begin
        PflichtWkOrt1DB.Enabled := true;
        if (WkAktuell.PflichtWkOrt1Indx[TabSelected] >= 0) and
           (WkAktuell.PflichtWkOrt1Indx[TabSelected] < Veranstaltung.OrtColl.Count) then
          PflichtWkOrt1DB.ItemIndex := WkAktuell.PflichtWkOrt1Indx[TabSelected] + 1
        else
          PflichtWkOrt1DB.ItemIndex := 0;
        PflichtWkOrt2DB.Enabled := true;
        if (WkAktuell.PflichtWkOrt2Indx[TabSelected] >= 0) and
           (WkAktuell.PflichtWkOrt2Indx[TabSelected] < Veranstaltung.OrtColl.Count) then
          PflichtWkOrt2DB.ItemIndex := WkAktuell.PflichtWkOrt2Indx[TabSelected] + 1
        else
          PflichtWkOrt2DB.ItemIndex := 0;
      end;
      else //pw0
      begin
        PflichtWkOrt1DB.Enabled := false;
        PflichtWkOrt1DB.ItemIndex := 0;
        PflichtWkOrt2DB.Enabled := false;
        PflichtWkOrt2DB.ItemIndex := 0;
      end;
    end;
  end else
  begin
    PflichtWkOrt1DB.Enabled := false;
    PflichtWkOrt1DB.ItemIndex := 0;
    PflichtWkOrt2DB.Enabled := false;
    PflichtWkOrt2DB.ItemIndex := 0;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.UpdatePflichtWkOrt;
(*----------------------------------------------------------------------------*)
begin
  case PflichtWkArtDB.ItemIndex of
    1: //pw1
    begin
      PflichtWkOrt1DB.Enabled   := true;
      // Index PflichtWkOrt1DB unverändert
      PflichtWkOrt2DB.Enabled   := false;
      PflichtWkOrt2DB.ItemIndex := 0;
    end;
    2,3: //pw1v2, pw2
    begin
      PflichtWkOrt1DB.Enabled := true;
      PflichtWkOrt2DB.Enabled := true;
      // Indices unverändert
    end;
    else //pw0
    begin
      PflichtWkOrt1DB.Enabled   := false;
      PflichtWkOrt1DB.ItemIndex := 0;
      PflichtWkOrt2DB.Enabled   := false;
      PflichtWkOrt2DB.ItemIndex := 0;
    end;
  end;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.GetPflichtWkMode: TPflichtWkMode;
(*----------------------------------------------------------------------------*)
begin
  case PflichtWkArtDB.ItemIndex of
    1: Result := pw1;
    2: Result := pw1v2;
    3: Result := pw2;
    else Result := pw0;
  end;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.GetPflichtWkOrt1: TOrtObj;
(*----------------------------------------------------------------------------*)
begin
  if PflichtWkOrt1DB.ItemIndex >= 1 then
    Result := Veranstaltung.OrtColl[PflichtWkOrt1DB.ItemIndex - 1]
  else Result := nil;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.GetPflichtWkOrt2: TOrtObj;
(*----------------------------------------------------------------------------*)
begin
  if PflichtWkOrt2DB.ItemIndex >= 1 then
    Result := Veranstaltung.OrtColl[PflichtWkOrt2DB.ItemIndex - 1]
  else Result := nil;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.SetPunktGleichOrt;
(*----------------------------------------------------------------------------*)
// benutzt in SetWkDaten
begin
  if (WkAktuell <> nil) and
     (WkAktuell.PunktGleichOrtIndx[TabSelected] >= 0) and
     (WkAktuell.PunktGleichOrtIndx[TabSelected] < Veranstaltung.OrtColl.Count) then
    PunktGleichOrtDB.ItemIndex := WkAktuell.PunktGleichOrtIndx[TabSelected] + 1
  else
    PunktGleichOrtDB.ItemIndex := 0;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.GetPunktGleichOrt: TOrtObj;
(*----------------------------------------------------------------------------*)
begin
  if PunktGleichOrtDB.ItemIndex >= 1 then
    Result := Veranstaltung.OrtColl[PunktGleichOrtDB.ItemIndex - 1]
  else Result := nil;
end;

// WertgungsPunkteGB

//------------------------------------------------------------------------------
procedure TSerWrtgDialog.SetWertungsPunkteGB;
//------------------------------------------------------------------------------
// aufgerufen von SetWkDaten
// Daten von WkAktuell übernehmen
var UpdAlt  : Boolean;
    ModeNeu :TSerWrtgMode;
begin
  WkAktuell := WettkSelected;
  if WkAktuell = nil then Exit;
  UpdAlt := Updating;
  Updating := true;

  // Setze SerWrtgMode
  ModeNeu := WkAktuell.SerWrtgMode[TabSelected];
  case ModeNeu of // RB.Checked=false wird automatisch gesetzt, wenn nötig
    swRngUpPkt:
    begin
      SerPktRngUpRB.Checked   := true;
      SerPktRngDownRB.Checked := false;
      SerPktFlexRB.Checked    := false;
      SerWrtgZeitRB.Checked   := false;
      RngUpCB.Enabled  := true;
      RngUpCB.Checked  := false;
      RngDwnCB.Enabled := false;
      RngDwnCB.Checked := false;
    end;
    swRngUpEqPkt:
    begin
      SerPktRngUpRB.Checked   := true;
      SerPktRngDownRB.Checked := false;
      SerPktFlexRB.Checked    := false;
      SerWrtgZeitRB.Checked   := false;
      RngUpCB.Enabled  := true;
      RngUpCB.Checked  := true;
      RngDwnCB.Enabled := false;
      RngDwnCB.Checked := false;
    end;
    swRngDwnPkt:
    begin
      SerPktRngDownRB.Checked := true;
      SerPktRngUpRB.Checked   := false;
      SerPktFlexRB.Checked    := false;
      SerWrtgZeitRB.Checked   := false;
      RngUpCB.Enabled  := false;
      RngUpCB.Checked  := false;
      RngDwnCB.Enabled := true;
      RngDwnCB.Checked := false;
    end;
    swRngDwnEqPkt:
    begin
      SerPktRngDownRB.Checked := true;
      SerPktRngUpRB.Checked   := false;
      SerPktFlexRB.Checked    := false;
      SerWrtgZeitRB.Checked   := false;
      RngUpCB.Enabled  := false;
      RngUpCB.Checked  := false;
      RngDwnCB.Enabled := true;
      RngDwnCB.Checked := true;
    end;
    swFlexPkt:
    begin
      SerPktFlexRB.Checked    := true;
      SerPktRngUpRB.Checked   := false;
      SerPktRngDownRB.Checked := false;
      SerWrtgZeitRB.Checked   := false;
      RngUpCB.Enabled  := false;
      RngUpCB.Checked  := false;
      RngDwnCB.Enabled := false;
      RngDwnCB.Checked := false;
    end;
    swZeit:
    begin
      SerWrtgZeitRB.Checked   := true;
      SerPktFlexRB.Checked    := false;
      SerPktRngUpRB.Checked   := false;
      SerPktRngDownRB.Checked := false;
      RngUpCB.Enabled  := false;
      RngUpCB.Checked  := false;
      RngDwnCB.Enabled := false;
      RngDwnCB.Checked := false;
    end;
  end;

  SetWrtgPktDaten;

  Updating := UpdAlt;
end;

//------------------------------------------------------------------------------
function TSerWrtgDialog.GetSerWrtgMode: TSerWrtgMode;
//------------------------------------------------------------------------------
begin
  if SerPktRngUpRB.Checked then
    if RngUpCB.Checked then Result := swRngUpEqPkt
                       else Result := swRngUpPkt
  else
  if SerPktRngDownRB.Checked then
    if RngDwnCB.Checked then Result := swRngDwnEqPkt
                        else Result := swRngDwnPkt
  else
  if SerPktFlexRB.Checked then
    Result := swFlexPkt
  else
    Result := swZeit;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.WrtgPktCollSelected(Wk:TWettkObj): TSerWrtgPktColl;
(*----------------------------------------------------------------------------*)
begin
  if Wk <> nil then
    Result := Wk.SerWrtgPktColl[TabSelected]
  else Result := nil; // Compiler-Warnung vermeiden
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.WrtgPktRecSelected: Integer;
(*----------------------------------------------------------------------------*)
// von 1 bis RowCount-1 (FixedRows=1)
begin
  if WrtgPktGrid.Row > 0 then Result := WrtgPktGrid.Row
                         else Result := 1;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.GetWrtgPktRec(Indx:Integer): TSerWrtgPktRec;
(*----------------------------------------------------------------------------*)
begin
  with WrtgPktGrid do
    if (Indx > 0) and (Indx < RowCount) then
    begin
      Result.RngVon  := StrToIntDef(Cells[0,Indx],0);
      Result.RngBis  := StrToIntDef(Cells[1,Indx],0);
      Result.PktVon  := StrToIntDef(Cells[2,Indx],0);
      if PktIncrement then Result.PktIncr :=   StrToIntDef(Cells[3,Indx],0)
                      else Result.PktIncr := - StrToIntDef(Cells[3,Indx],0);
    end else
    begin
      Result.RngVon  := 0;
      Result.RngBis  := 0;
      Result.PktVon  := 0;
      Result.PktIncr := 0;
    end;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.SetWrtgPktDaten;
(*----------------------------------------------------------------------------*)
// aufgerufen von SetWertungsPunkteGB und SerPktRBClick
// SerWrtgMode vorher gesetzt
// Daten von WkAktuell übernehmen
var Coll : TSerWrtgPktColl;
    UpdAlt: Boolean;
begin
  WkAktuell := WettkSelected;
  if WkAktuell = nil then Exit;
  UpdAlt := Updating;
  Updating := true;

  if SerPktFlexRB.Checked then
  begin
    RngUpCB.Enabled  := false;
    RngUpCB.Checked  := false;
    RngDwnCB.Enabled := false;
    RngDwnCB.Checked := false;
    WrtgPktGrid.Enabled := true;
    WrtgPktGrid.Font.Color := clWindowText;
    WrtgPktHeaderGrid.Enabled := true;
    WrtgPktHeaderGrid.Font.Color := clWindowText;
    WrtgPktGB.Enabled := true;
    WrtgPktGBPanel.Hide;
    RngVonLabel.Enabled := true;
    RngVonEdit.Enabled := true;
    RngVonUpDown.Enabled := true;
    RngBisLabel.Enabled := true;
    RngBisEdit.Enabled := true;
    RngBisUpDown.Enabled := true;
    PktVonLabel.Enabled := true;
    PktVonEdit.Enabled := true;
    PktVonUpDown.Enabled := true;
    PktIncrCB.Enabled := true;
    PktIncrEdit.Enabled := true;
    PktIncrUpDown.Enabled := true;
    PktBisLabel.Enabled := true;
    PktBisEdit.Enabled := true;
  end else
  begin
    if SerWrtgZeitRB.Checked then
    begin
      RngUpCB.Enabled  := false;
      RngUpCB.Checked  := false;
      RngDwnCB.Enabled := false;
      RngDwnCB.Checked := false;
    end else
    if SerPktRngUpRB.Checked then
    begin
      RngUpCB.Enabled  := true;
      RngDwnCB.Enabled := false;
      RngDwnCB.Checked := false;
    end else // SerPktRngDwnRB.Checked
    begin
      RngUpCB.Enabled  := false;
      RngUpCB.Checked  := false;
      RngDwnCB.Enabled := true;
    end;
    WrtgPktGrid.Enabled := false;
    WrtgPktGrid.Font.Color := clGrayText;
    WrtgPktHeaderGrid.Enabled := false;
    WrtgPktHeaderGrid.Font.Color := clGrayText;
    WrtgPktGB.Enabled := false;
    WrtgPktGBPanel.Show; // WrtgPktGB.Caption grau darstellen
    RngVonLabel.Enabled := false;
    RngVonEdit.Enabled := false;
    RngVonUpDown.Enabled := false;
    RngBisLabel.Enabled := false;
    RngBisEdit.Enabled := false;
    RngBisUpDown.Enabled := false;
    PktVonLabel.Enabled := false;
    PktVonEdit.Enabled := false;
    PktVonUpDown.Enabled := false;
    PktIncrCB.Enabled := false;
    PktIncrEdit.Enabled := false;
    PktIncrUpDown.Enabled := false;
    PktBisLabel.Enabled := false;
    PktBisEdit.Enabled := false;
  end;

  Coll := WrtgPktCollSelected(WkAktuell);
  if (Coll <> nil) and (Coll.Count > 0) then // muss so sein
    SetWrtgPktGrid(Coll)
  else
    SetWrtgPktGrid(nil);

  Updating := UpdAlt;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.SetWrtgPktGrid(Liste:TSerWrtgPktColl);
(*----------------------------------------------------------------------------*)
// aufgerufen von SetWrtgPktDaten, EinfuegButtonClick, DefaultButtonClick
var i : Integer;
begin
  with WrtgPktGrid do
  begin
    if (GetSerWrtgMode <> swFlexPkt) or
       (Liste=nil) or (Liste.Count < 1) then
    begin
      RowCount := 2; // fixed rows = 1
      // Header
      Cells[0,0] := hdVon;
      Cells[1,0] := hdBis;
      Cells[2,0] := hdVon;
      if GetSerWrtgMode = swRngDwnPkt then Cells[3,0] := hdDecr
                                      else Cells[3,0] := hdIncr; // default, auch swZeit
      Cells[4,0] := hdBis;
      Cells[0,1] := '';
      Cells[1,1] := '';
      Cells[2,1] := '';
      Cells[3,1] := '';
      Cells[4,1] := '';
    end else
    begin
      RowCount := Liste.Count + 1; // fixed rows = 1
      // Header
      Cells[0,0] := hdVon;
      Cells[1,0] := hdBis;
      Cells[2,0] := hdVon;
      Cells[3,0] := hdIncr; // default
      for i:=0 to Liste.Count-1 do
        if Liste[i]^.PktIncr <> 0 then
        begin
          if Liste[i]^.PktIncr > 0 then Cells[3,0] := hdIncr // PktIncrement=true
                                   else Cells[3,0] := hdDecr;
          Break;
        end;
      Cells[4,0] := hdBis;
      // Daten
      for i:=1 to RowCount-1 do with Liste[i-1]^ do
      begin
        Cells[0,i] := ' '+Strng(RngVon,4);
        Cells[1,i] := ' '+Strng(RngBis,4);
        Cells[2,i] := ' '+Strng(PktVon,4);
        if RngBis > RngVon then
        begin
          Cells[3,i] := ' '+Strng(PktIncr,4);
          if PktIncrement then Cells[3,i] := ' '+Strng(PktIncr,4)
                          else Cells[3,i] := ' '+Strng(-PktIncr,4);
        end else
          Cells[3,i] := '    -';
        Cells[4,i] := ' '+GetPktBisStrng(Liste[i-1]^,4);
      end;
    end;

    FocusWrtgPktRec(1); // erste Rec focussieren und RecIndxAktuell setzen
    Refresh;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.FocusWrtgPktRec(RecIndx:Integer);
(*----------------------------------------------------------------------------*)
// aufgerufen von SetWrtgPktGrid, WrtgPktGridClick, usw....
var UpdAlt : Boolean;
    Rec : TSerWrtgPktRec;
begin
  // WrtgPktGridClick Event wieder ausgelöst, deshalb Updating true gesetzt
  UpdAlt := Updating;
  Updating := true;

  if RecIndx < 1 then  // FixedRows = 1
    WrtgPktGrid.Row := 1 // erste Zeile
  else
  if RecIndx > WrtgPktGrid.RowCount-1 then
    WrtgPktGrid.Row := WrtgPktGrid.RowCount-1  // letzte Zeile
  else
    WrtgPktGrid.Row := RecIndx;

  // RecIndxAktuell wird nur hier gesetzt
  RecIndxAktuell := WrtgPktRecSelected; // RecIndxAktuell >= 1

  if PktIncrement then PktIncrCB.ItemIndex := 0
                  else PktIncrCB.ItemIndex := 1;
  Rec := GetWrtgPktRec(RecIndxAktuell);

  if WrtgPktGrid.Enabled then // SerPktFlex
  begin
    if RecIndxAktuell = 1 then // RngVon fest (1) für 1. Rec.
    begin
      RngVonEdit.ReadOnly  := true;
      RngVonEdit.Color     := clBtnFace;
      RngVonUpDown.Enabled := false;
      PktIncrCB.Enabled    := true; // Incr/Decr nur für 1. Rec definierbar
    end else
    begin
      RngVonEdit.ReadOnly  := false;
      RngVonEdit.Color     := clWindow;
      RngVonUpDown.Enabled := true;
      PktIncrCB.Enabled    := false;
    end;
    if Rec.RngBis > Rec.RngVon then
    begin
      PktIncrEdit.Enabled   := true;
      PktIncrUpDown.Enabled := true;
      PktIncrEdit.Text := IntToStr(Abs(Rec.PktIncr));
    end else
    begin
      PktIncrEdit.Enabled   := false;
      PktIncrUpDown.Enabled := false;
      PktIncrEdit.Text := '';
    end;

    RngVonEdit.Text  := IntToStr(Rec.RngVon); // nach Enable
    RngBisEdit.Text  := IntToStr(Rec.RngBis);
    PktVonEdit.Text  := IntToStr(Rec.PktVon);
    PktBisEdit.Text  := GetPktBisStrng(Rec,1);
  end else
  begin
    RngVonEdit.Text  := '';
    RngBisEdit.Text  := '';
    PktVonEdit.Text  := '';
    PktBisEdit.Text  := '';
    PktIncrEdit.Text := '';
  end;

  SetButtons;
  Updating := UpdAlt;
  Refresh;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.PktIncrement: Boolean;
(*----------------------------------------------------------------------------*)
begin
  Result := WrtgPktGrid.Cells[3,0] = hdIncr;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.WrtgPktRecGeAendert: Boolean;
(*----------------------------------------------------------------------------*)
var Rec : TSerWrtgPktRec;
begin
  if WrtgPktGrid.Enabled then // (vaCup or tmTln) and SerPktFlex
  begin
    Rec := GetWrtgPktRec(RecIndxAktuell);
    Result := (Rec.RngVon <> StrToIntDef(RngVonEdit.Text,0)) or
              (Rec.RngBis <> StrToIntDef(RngBisEdit.Text,0)) or
              (Rec.PktVon <> StrToIntDef(PktVonEdit.Text,0)) or
              (Abs(Rec.PktIncr) <> StrToIntDef(PktIncrEdit.Text,0)) or
              (PktIncrement and (PktIncrCB.ItemIndex<>0) or
               not PktIncrement and (PktIncrCB.ItemIndex<>1));
  end else // Liga-Mannschaften
    Result := false;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.WrtgPktRecOK: Boolean;
(*----------------------------------------------------------------------------*)
// bei Änderungen zunächst nur CupWrtgRec prüfen, nicht die Konsistenz der Liste
begin
  if WrtgPktGrid.Enabled then
  begin
    Result := false;
    // Validate wird nicht automatisch ausgeführt bei ENTER-Taste
    if not RngVonEdit.ValidateEdit then Exit;
    if not RngBisEdit.ValidateEdit then Exit;
    if not PktVonEdit.ValidateEdit then Exit;

    if StrToIntDef(RngBisEdit.Text,0) < StrToIntDef(RngVonEdit.Text,0) then
    begin
      TriaMessage(Self,'"Platz bis" ist kleiner als "Platz von".',
                  mtInformation,[mbOk]);
      if RngBisEdit.CanFocus then RngBisEdit.SetFocus;
      Exit;
    end;

    if StrToIntDef(PktVonEdit.Text,0) = 0 then
    begin
      TriaMessage(Self,'Der Wert "Punkte von" muss größer als 0 sein.',
                   mtInformation,[mbOk]);
      if PktVonEdit.CanFocus then PktVonEdit.SetFocus;
      Exit;
    end;

    if StrToIntDef(PktBisEdit.Text,0) = 0 then
    begin
      TriaMessage(Self,'Der Wert "Punkte bis" ist ungültig.'+#13+
                  'Erlaubt sind Werte von 1 bis 9.999.',mtInformation,[mbOk]);
      if PktVonEdit.CanFocus then PktVonEdit.SetFocus;
      Exit;
    end;
  end;

  Result := true;
end;

//------------------------------------------------------------------------------
function TSerWrtgDialog.WrtgPktGridGeAendert(Wk:TWettkObj): Boolean;
//------------------------------------------------------------------------------
var i : Integer;
    Indx,WkMinIndx,WkMaxIndx : Integer;
    Coll : TSerWrtgPktColl;
    Rec  : TSerWrtgPktRec;
begin
  Result := false;
  if not WrtgPktGrid.Enabled then Exit;
  if Wk = nil then Exit;

  if Wk = WettkAlleDummy then
  begin
    WkMinIndx := 0;
    WkMaxIndx := Veranstaltung.WettkColl.Count-1;
  end else
  begin
    WkMinIndx := Veranstaltung.WettkColl.IndexOf(Wk);
    WkMaxIndx := WkMinIndx;
  end;
  if WkMinIndx < 0 then Exit;

  Result := true;
  for Indx := WkMinIndx to WkMaxIndx do
  begin
    Coll := WrtgPktCollSelected(Veranstaltung.WettkColl[Indx]); // TlnCupWrtgPktColl oder MschCupWrtgPktColl
    if (Coll = nil) or (Coll.Count < 1) then Exit;
    with WrtgPktGrid do
    begin
      if Coll.Count <> RowCount-1 then Exit;
      for i:=1 to RowCount-1 do
      begin
        Rec := GetWrtgPktRec(i);
        if Rec.RngVon <> Coll[i-1]^.RngVon then Exit;
        if Rec.RngBis <> Coll[i-1]^.RngBis then Exit;
        if Rec.PktVon <> Coll[i-1]^.PktVon then Exit;
        if Rec.PktIncr <> Coll[i-1]^.PktIncr then Exit;
      end;
    end;
  end;
  Result := false;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.GetPktBis(Rec:TSerWrtgPktRec): Integer;
(*----------------------------------------------------------------------------*)
begin
  with Rec do
    if RngBis >= RngVon then
    begin
      Result := PktVon + (RngBis - RngVon) * PktIncr;
      if (Result > cnTlnMax) or (Result < 0) then Result := -1;
    end
    else Result := -1;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.GetPktBisStrng(Rec:TSerWrtgPktRec; L:Integer): String;
(*----------------------------------------------------------------------------*)
var Pkt: Integer;
begin
  Pkt := GetPktBis(Rec);
  if Pkt >= 0 then Result := IntToStr(Pkt)
              else Result := ' ?';
  while Length(Result) < L do Result := ' ' + Result;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.GetEditRec: TSerWrtgPktRec;
(*----------------------------------------------------------------------------*)
begin
  Result.RngVon := StrToIntDef(RngVonEdit.Text,0);
  Result.RngBis := StrToIntDef(RngBisEdit.Text,0);
  Result.PktVon := StrToIntDef(PktVonEdit.Text,0);
  if PktIncrCB.ItemIndex = 1 then Result.PktIncr := - StrToIntDef(PktIncrEdit.Text,0)
                             else Result.PktIncr :=   StrToIntDef(PktIncrEdit.Text,0);
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.WrtgPktRecNeu: Boolean;
(*----------------------------------------------------------------------------*)
var RecLetzt, RecNeu : TSerWrtgPktRec;
begin
  Result := false;

  // geänderte Daten übernehmen
  if WrtgPktRecGeAendert then
    if NeuEingabe then
      if not WrtgPktRecAendern then Exit // ohne Bestätigung ändern
      else
    else
    case TriaMessage(Self,'Die Definition der Wertungspunkte wurde geändert.'+#13+
                     'Änderungen übernehmen?',
                     mtConfirmation,[mbYes,mbNo,mbCancel]) of
      mrYes : if not WrtgPktRecAendern then Exit;
      mrNo  : ;
      else    Exit;
    end;

  if WrtgPktGrid.RowCount > 1 then // mindestens 1 Rec, gilt immer
  begin
    RecLetzt := GetWrtgPktRec(WrtgPktGrid.RowCount-1); // PktBis ist gültig
    with RecNeu do
    begin
      RngVon := Min(RecLetzt.RngBis+1, cnTlnMax);
      RngBis := cnTlnMax;
      PktVon := GetPktBis(RecLetzt);
      PktIncr := 1;
      if PktIncrement then
      begin
        if PktVon < cnTlnMax then PktVon := PktVon + 1;
        if PktVon >= cnTlnMax then PktIncr := 0;
      end else
      begin
        if PktVon > 0 then PktVon := PktVon - 1;
        if PktVon <= 0 then PktIncr := 0;
      end;
    end;
  end;
  Refresh;
  NeuEingabe := true;
  with WrtgPktGrid do
  begin
    RowCount := RowCount + 1;
    Cells[0,RowCount-1] := ' '+Strng(RecNeu.RngVon,4);
    Cells[1,RowCount-1] := ' '+Strng(RecNeu.RngBis,4);
    Cells[2,RowCount-1] := ' '+Strng(RecNeu.PktVon,4);
    Cells[3,RowCount-1] := ' '+Strng(RecNeu.PktIncr,4);
    Cells[4,RowCount-1] := ' '+GetPktBisStrng(RecNeu,4);
    FocusWrtgPktRec(RowCount-1);
    Refresh;
  end;
  if RngBisEdit.CanFocus then RngBisEdit.SetFocus;
  Result := true;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.WrtgPktRecAendern: Boolean;
(*----------------------------------------------------------------------------*)
// RecIndxAktuell in WrtgPktGrid übernehmen
// nur WrtgPktRec prüfen, nicht die Konsistentz der Liste
var Invert : Boolean;
    Rec    : TSerWrtgPktRec;
    i      : Integer;
begin
  Result := false;
  if (RecIndxAktuell < 1) or not WrtgPktRecOk then Exit;

  Refresh;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;

  with WrtgPktGrid do
  try
    if PktIncrement and (PktIncrCB.ItemIndex <> 0) or
       not PktIncrement and (PktIncrCB.ItemIndex <> 1) then
      Invert := true
    else Invert := false;
    if PktIncrCB.ItemIndex = 1 then Cells[3,0] := hdDecr
                               else Cells[3,0] := hdIncr; // PktIncrement=true
    Cells[0,RecIndxAktuell] := ' '+Strng(StrToIntDef(RngVonEdit.Text,0),4);
    Cells[1,RecIndxAktuell] := ' '+Strng(StrToIntDef(RngBisEdit.Text,0),4);
    Cells[2,RecIndxAktuell] := ' '+Strng(StrToIntDef(PktVonEdit.Text,0),4);
    if Cells[1,RecIndxAktuell] > Cells[0,RecIndxAktuell] then
      Cells[3,RecIndxAktuell] := ' '+Strng(StrToIntDef(PktIncrEdit.Text,0),4)
    else Cells[3,RecIndxAktuell] := '    -';
    Cells[4,RecIndxAktuell] := ' '+Strng(StrToIntDef(PktBisEdit.Text,0),4);

    if Invert then
      for i:=1 to RowCount-1 do
        if i <> RecIndxAktuell then
        begin
          // PktBis neu berechnen
          Rec := GetWrtgPktRec(i);
          Cells[4,i] := ' '+GetPktBisStrng(Rec,4);
        end;
    Repaint;

    NeuEingabe := false; // vor Update
    //SetWrtgPktRec;
    FocusWrtgPktRec(RecIndxAktuell);

  finally
    if WrtgPktGrid.CanFocus then WrtgPktGrid.SetFocus;
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;
  Result := true;
end;

(*----------------------------------------------------------------------------*)
procedure TSerWrtgDialog.WrtgPktRecLoeschen;
(*----------------------------------------------------------------------------*)
var i : Integer;
begin
  if (RecIndxAktuell < 1) or (WrtgPktGrid.RowCount <= 2) then Exit;
  if TriaMessage(Self,'Markierte Wertungspunktedefinition löschen?',
                 mtConfirmation,[mbOk,mbCancel]) <> mrOk then Exit;
  Refresh;
  NeuEingabe := false; // vor ClearItem

  // Löschen
  with WrtgPktGrid do
  begin
    for i:=RecIndxAktuell to RowCount-2 do // alle 1 Row nach vorne schieben
    begin
      Cells[0,i] := Cells[0,i+1];
      Cells[1,i] := Cells[1,i+1];
      Cells[2,i] := Cells[2,i+1];
      Cells[3,i] := Cells[3,i+1];
      Cells[4,i] := Cells[4,i+1];
    end;
    // Cells[3,0] bleibt unverändert;
    RowCount := RowCount - 1; // letzte Row löschen
    //SetWrtgPktRec;
    FocusWrtgPktRec(RecIndxAktuell); // RecIndxAktuell wird korrigiert falls nötig
    Refresh;
    if CanFocus then SetFocus;
  end;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.ListeOK: Boolean;
(*----------------------------------------------------------------------------*)
// immer mindestens 1 Eintrag
var i,RngBisBuf : Integer;
    Rec : TSerWrtgPktRec;
    PktAlt: Integer;
begin
  if WrtgPktGrid.Enabled then with WrtgPktGrid do
  begin
    // Überlappung und Lücken nicht zulässig
    Result := false;
    Rec := GetWrtgPktRec(1); // 1. Eintrag
    if Rec.RngVon <> 1 then
    begin
      TriaMessage(Self,'Liste muss mit Platz 1 beginnen.'
                  ,mtInformation,[mbOk]);
      FocusWrtgPktRec(1);
      Exit;
    end;
    RngBisBuf := Rec.RngBis;
    for i:=2 to RowCount-1 do
    begin
      Rec := GetWrtgPktRec(i);
      if Rec.RngVon <= RngBisBuf then
      begin
        TriaMessage(Self,'Platzierungen dürfen sich nicht überlappen.'
                    ,mtInformation,[mbOk]);
        FocusWrtgPktRec(i);
        if RngVonEdit.CanFocus then RngVonEdit.SetFocus;
        Exit;
      end else
      if Rec.RngVon > RngBisBuf + 1 then
      begin
        TriaMessage(Self,'Platzierungen müssen lückenlos sein.'
                    ,mtInformation,[mbOk]);
        FocusWrtgPktRec(i);
        if RngVonEdit.CanFocus then RngVonEdit.SetFocus;
        Exit;
      end else RngBisBuf := Rec.RngBis;
    end;

    // Reihenfolge der Punkte prüfen
    PktAlt := GetPktBis(GetWrtgPktRec(1)); // 1. Eintrag
    for i:=2 to RowCount-1 do
    begin
      Rec := GetWrtgPktRec(i);
      if PktIncrement and (Rec.PktVon < PktAlt) then
      begin
        TriaMessage(Self,'Wenn Inkrement definiert ist, müssen Wertungspunkte '+#13+
                    'gleich oder aufsteigend definiert sein.'
                    ,mtInformation,[mbOk]);
        FocusWrtgPktRec(i);
        if PktVonEdit.CanFocus then PktVonEdit.SetFocus;
        Exit;
      end else
      if not PktIncrement and (Rec.PktVon > PktAlt) then
      begin
        TriaMessage(Self,'Wenn Dekrement definiert ist, müssen Wertungspunkte '+#13+
                    'gleich oder absteigend definiert sein.'
                    ,mtInformation,[mbOk]);
        FocusWrtgPktRec(i);
        if PktVonEdit.CanFocus then PktVonEdit.SetFocus;
        Exit;
      end;
      PktAlt := GetPktBis(Rec);
    end;

  end;
  Result := true;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.ListeAendern(Wk:TWettkObj): Boolean;
(*----------------------------------------------------------------------------*)
var i    : Integer;
    Indx,WkMinIndx,WkMaxIndx : Integer;
    Coll : TSerWrtgPktColl;
    Rec  : TSerWrtgPktRec;
begin
  Result := false;
  if (Wk=nil) or not ListeOK then Exit;
  if Wk = WettkAlleDummy then
  begin
    WkMinIndx := 0;
    WkMaxIndx := Veranstaltung.WettkColl.Count-1;
  end else
  begin
    WkMinIndx := Veranstaltung.WettkColl.IndexOf(Wk);
    WkMaxIndx := WkMinIndx;
  end;

  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    for Indx := Max(0,WkMinIndx) to WkMaxIndx do
    begin
      Coll := WrtgPktCollSelected(Veranstaltung.WettkColl[Indx]); // TlnCupWrtgPktColl oder MschCupWrtgPktColl
      if Coll <> nil then with WrtgPktGrid do
      begin
        Coll.Clear;
        for i:=1 to RowCount-1 do
        begin
          Rec := GetWrtgPktRec(i);
          Coll.Add(Rec);
        end;
      end;
      if (Veranstaltung.WettkColl[Indx] <> nil) and
         (Veranstaltung.TlnColl.WettkTlnZahl(Veranstaltung.WettkColl[Indx])>0) then
        Veranstaltung.WettkColl[Indx].OrtErgModified[-1] := true;
    end;
    SetButtons;
    TriDatei.Modified := true;
    Result := true;
  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;
end;

(*----------------------------------------------------------------------------*)
function TSerWrtgDialog.CompDefaultListe: Boolean;
(*----------------------------------------------------------------------------*)
var i : Integer;
    Rec : TSerWrtgPktRec;
begin
  Result := false;
  if DefListe[TabSelected] <> nil then with WrtgPktGrid do
  begin
    if DefListe[TabSelected].Count <> RowCount-1 then Exit;
    for i:=1 to RowCount-1 do
    begin
      Rec := GetWrtgPktRec(i);
      if Rec.RngVon <> DefListe[TabSelected][i-1]^.RngVon then Exit;
      if Rec.RngBis <> DefListe[TabSelected][i-1]^.RngBis then Exit;
      if Rec.PktVon <> DefListe[TabSelected][i-1]^.PktVon then Exit;
      if Rec.PktIncr <> DefListe[TabSelected][i-1]^.PktIncr then Exit;
    end;
  end;
  Result := true;
end;


(******************************************************************************)
//  Event Handler
(******************************************************************************)

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TSerWrtgDialog.FormShow(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  SetWkDaten;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.WettkCBLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if WettkCB.CanFocus then WettkCB.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.WettkCBChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not SerWrtgGeAendert(WkAktuell) then
    if NeuEingabe then NeuEingabe := false
    else
  else
    case TriaMessage(Self,'Die Serienwertung wurde geändert.'+#13+
                     'Änderungen übernehmen?',
                     mtConfirmation,[mbYes,mbNo,mbCancel]) of
      mrYes : if not SerWrtgAendern(WkAktuell) then
              begin
                WettkCB.ItemIndex := Veranstaltung.WettkColl.IndexOf(WkAktuell);
                Exit;
              end else
              if NeuEingabe then NeuEingabe := false;
      mrNo  : if NeuEingabe then NeuEingabe := false;
      else    begin
                WettkCB.ItemIndex := Veranstaltung.WettkColl.IndexOf(WkAktuell);
                Exit;
              end;
      Exit;
    end;

  SetWkDaten; // auch WkAktuell auf neuer Wert gesetzt
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.SerWrtgGBClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not Updating then
    if StreichErgEdit.CanFocus then StreichErgEdit.SetFocus;
end;


(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.StreichErgLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if StreichErgEdit.CanFocus then StreichErgEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.StreichErgEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// Event auch wenn disabled
begin
  if not Updating then
  begin
    UpdatePflichtWk;
    SetButtons;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.StreichOrtLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if StreichOrtEdit.CanFocus then StreichOrtEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.StreichOrtEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// Event auch wenn disabled
begin
  if not Updating then
  begin
    UpdatePflichtWk;
    SetButtons;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerWrtgDialog.AkJahrLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if AkJahrCB.CanFocus then AkJahrCB.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerWrtgDialog.AkJahrCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.PflichtWkLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if PflichtWkArtDB.CanFocus then PflichtWkArtDB.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.PflichtWkArtDBChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not Updating then
  begin
    UpdatePflichtWkOrt;
    SetButtons;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.PunktGleichOrtLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if PunktGleichOrtDB.CanFocus then PunktGleichOrtDB.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.OrtDBChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not Updating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.TabControl1Changing(Sender:TObject;var AllowChange:Boolean);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// vor change ausgeführt, geänderte Liste/Record vorher übernehmen
var S : String;
begin
  if not Updating then
  begin
    AllowChange := false;
    if not WrtgPktRecGeAendert then
    begin
      if NeuEingabe then NeuEingabe := false;
      S := TabControl1.Tabs[TabControl1.TabIndex];
      if SerWrtgGeAendert(WkAktuell) then
        case TriaMessage(Self,'Die Serienwertung für '+S+ ' wurde geändert.' + #13 +
                         'Änderungen übernehmen?',
                         mtConfirmation,[mbYes,mbNo,mbCancel]) of
          mrYes : if not SerWrtgAendern(WkAktuell) then Exit;
          mrNo  : ;
          else    Exit;
        end;
    end else // WrtgPktRecGeAendert
    begin
      case TriaMessage(Self,'Die markierte Wertungspunktdefinition wurde geändert.' +#13 +
                       'Änderungen übernehmen?',
                       mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes : if not WrtgPktRecAendern then Exit
                else begin
                  if NeuEingabe then NeuEingabe := false;
                  if not SerWrtgAendern(WkAktuell) then Exit;//Liste ohne Nachfrage übernehmen
                end;
        mrNo  : if NeuEingabe then NeuEingabe := false;
        else    Exit;
      end;
    end;
  end;

  AllowChange := true;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.TabControl1Change(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// nach change ausgeführt
begin
  if not Updating then
  begin
    SetTabDaten;
    SetButtons;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerWrtgDialog.SerPktRBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then
    SetWrtgPktDaten;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.WrtgPktHeaderGridClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if WrtgPktGrid.CanFocus then WrtgPktGrid.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.WrtgPktGridClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var RecIndx : Integer;
begin
  // Exit beim Setzen von Row
  if Updating then Exit;

  try
    RecIndx := WrtgPktRecSelected; // neuer Row
    if (RecIndx < 0) or (RecIndxAktuell < 0) then Exit;

    if WrtgPktRecGeAendert then
    begin
      WrtgPktGrid.ScrollBars := ssNone; // weiterscrollen verhindern
      case TriaMessage(Self,'Die Definition der Wertungspunkten wurde geändert.'+#13+
                       'Änderungen übernehmen?',
                       mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes : if WrtgPktRecAendern then FocusWrtgPktRec(RecIndx)
                                     else FocusWrtgPktRec(RecIndxAktuell);
        mrNo  : begin
                  if (RecIndx <> RecIndxAktuell) and NeuEingabe then
                    NeuEingabe := false;
                  FocusWrtgPktRec(RecIndx);
                end;
        else    FocusWrtgPktRec(RecIndxAktuell);
      end;
    end else
    begin
      if (RecIndx <> RecIndxAktuell) and NeuEingabe then
        NeuEingabe := false;
      FocusWrtgPktRec(RecIndx); // hier wird auch RecIndxAktuell neu gesetzt
    end;

  finally
    WrtgPktGrid.Scrollbars := ssVertical;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.WrtgPktRecChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var Rec : TSerWrtgPktRec;
begin
  if not Updating then
  begin
    Rec :=GetEditRec;
    PktBisEdit.Text := GetPktBisStrng(Rec,1);
    if Rec.RngBis > Rec.RngVon then
    begin
      PktIncrEdit.Enabled   := true;
      PktIncrUpDown.Enabled := true;
    end else
    begin
      PktIncrEdit.Enabled   := false;
      PktIncrUpDown.Enabled := false;
    end;
    SetButtons;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.AendButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    if WrtgPktRecGeAendert then WrtgPktRecAendern;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.NeuButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    WrtgPktRecNeu;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.LoeschButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    WrtgPktRecLoeschen;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.KopierButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var i  : Integer;
    Rec : TSerWrtgPktRec;
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    KopierListe.Free;
    KopierListe := TSerWrtgPktColl.Create(Veranstaltung);
    for i:=1 to WrtgPktGrid.RowCount-1 do
    begin
      Rec := GetWrtgPktRec(i);
      KopierListe.Add(Rec);
    end;
    SetButtons;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.EinfuegButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if (TriaMessage(Self,'Die vorhandene Liste wird gelöscht.',
                   mtWarning,[mbOk,mbCancel]) = mrOk) then
  if not DisableButtons then
  try
    DisableButtons := true;
    Updating := true;
    NeuEingabe := false;
    SetWrtgPktGrid(KopierListe);  // focus auf erste Zeile der Liste
    KopierListe.Clear; // Damit wird EinfuegButton disabled
    Updating := false;
    SetButtons;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.DefaultButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    Updating := true;
    NeuEingabe := false; // vor grid.init, wegen drawcell
    SetWrtgPktGrid(DefListe[TabSelected]); // focus erste Zeile der Liste
    Updating := false;
    SetButtons;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.UebernehmButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    // wenn WrtgPktRecGeAendert zuerst Rec in Liste übernehmen, vor Liste geprüft wird
    if WrtgPktRecGeAendert and not WrtgPktRecAendern then Exit;
    if SerWrtgGeAendert(WkAktuell) then SerWrtgAendern(WkAktuell);
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.UebernehmAlleButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    // wenn WrtgPktRecGeAendert zuerst Rec in Liste übernehmen, vor Liste geprüft wird
    if WrtgPktRecGeAendert and not WrtgPktRecAendern then Exit;
    if SerWrtgGeAendert(WettkAlleDummy) then
      SerWrtgAendern(WettkAlleDummy);
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.OkButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    // wenn WrtgPktRecGeAendert zuerst Rec in Liste übernehmen, vor Liste geprüft wird
    if (WrtgPktRecGeAendert and not WrtgPktRecAendern) or
       (SerWrtgGeAendert(WkAktuell) and not SerWrtgAendern(WkAktuell)) then
      ModalResult := mrNone
    else ModalResult := mrOk;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TSerWrtgDialog.HilfeButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  Application.HelpContext(1000);  // SerWrtg
end;




end.
