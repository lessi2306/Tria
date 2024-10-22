unit KlassenDlg;

interface 

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, Mask,
  AllgComp,AllgConst,AllgFunc,AllgObj,VeranObj,WettkObj,AkObj,TlnObj,MannsObj;

procedure KlassenDefinieren;

type
  TKlassenDialog = class(TForm)
    WettkCBLabel: TLabel;
    WettkCB: TComboBox;
    TabControl1: TTabControl;
    TabControl2: TTabControl;
    TabControl3: TTabControl;
    AkGrid: TTriaGrid;
    KlasseGB: TGroupBox;
      NameLabel: TLabel;
      NameEdit: TTriaEdit;
      KuerzelLabel: TLabel;
      KuerzelEdit: TTriaEdit;
      VonLabel: TLabel;
      VonEdit: TTriaMaskEdit;
      VonUpDown: TTriaUpDown;
      BisLabel: TLabel;
      BisEdit: TTriaMaskEdit;
      BisUpDown: TTriaUpDown;
    AendButton: TButton;
    NeuButton: TButton;
    LoeschButton: TButton;
    KopierButton: TButton;
    EinfuegButton: TButton;
    UebernehmButton: TButton;
    OkButton: TButton;
    CancelButton: TButton;
    HilfeButton: TButton;
    DTU_Button: TButton;
    DLV_Button: TButton;
    AkGridLabel: TLabel;
    procedure TlnAkMGridDrawCell(Sender: TObject; ACol, ARow: Integer;
                                 Rect: TRect; State: TGridDrawState);
    procedure AkGridClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabControl1Change(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure WettkCBChange(Sender: TObject);
    procedure AendButtonClick(Sender: TObject);
    procedure NeuButtonClick(Sender: TObject);
    procedure LoeschButtonClick(Sender: TObject);
    procedure KopierButtonClick(Sender: TObject);
    procedure DefaultButtonClick(Sender: TObject);
    procedure UebernehmButtonClick(Sender: TObject);
    procedure EinfuegButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);
    procedure TabControl2Change(Sender: TObject);
    procedure TabControl3Change(Sender: TObject);
    procedure WettkCBLabelClick(Sender: TObject);

  private
    HelpFensterAlt : TWinControl;
    Updating       : Boolean;
    DisableButtons : Boolean;
    NeuEingabe     : Boolean;
    WkAktuell      : TWettkObj;
    AkAktuell      : TAkObj;
    AkListe        : TAkColl;
    KopierListe    : TAkColl;
    function    WettkSelected: TWettkObj;
    function    AkSelected: TAkObj;
    function    AkCollSelected: TAkColl;
    function    TlnMschSelected: TTlnMsch;
    function    WertgSelected: TKlassenWertung;
    function    SexSelected: TSex;
    procedure   SetWkDaten;
    procedure   SetTab1Daten;
    procedure   SetTab2Daten;
    procedure   SetTab3Daten;
    procedure   SetAkDaten;
    procedure   SetButtons;
    function    AkGeAendert: Boolean;
    function    KlasseDoppel: Boolean;
    function    KlasseOK: Boolean;
    function    AkNeu: Boolean;
    function    AkAendern: Boolean;
    procedure   AkLoeschen;
    function    ListeOK: Boolean;
    function    ListeGeAendert: Boolean;
    function    ListeAendern: Boolean;
    function    ListeUebernehmen: Boolean;
    function    DefaultListe(DefListe:TDefaultAkListe): Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

  end;

var
  KlassenDialog: TKlassenDialog;

implementation

uses TriaMain,TlnErg,DateiDlg,LstFrm,VistaFix;

{$R *.dfm}

(******************************************************************************)
procedure KlassenDefinieren;
(******************************************************************************)
begin
  KlassenDialog := TKlassenDialog.Create(HauptFenster);
  try
    KlassenDialog.ShowModal;
  finally
    FreeAndNil(KlassenDialog);
  end;
  HauptFenster.RefreshAnsicht;
end;

// public Methoden

(*============================================================================*)
constructor TKlassenDialog.Create(AOwner: TComponent);
(*============================================================================*)
var i : integer;
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
  AkAktuell      := nil;

  with Veranstaltung do
  begin
    for i:=0 to WettkColl.Count-1 do
      WettkCB.Items.AddObject(WettkColl.Items[i].Name,WettkColl.Items[i]);
    if WettkCB.Items.IndexOf(HauptFenster.SortWettk.Name) >= 0 then
      WettkCB.ItemIndex := WettkCB.Items.IndexOf(HauptFenster.SortWettk.Name)
    else WettkCB.ItemIndex := 0;
  end;

  with AkGrid do
  begin
    Canvas.Font := Font;
    DefaultRowHeight := AkGrid.Canvas.TextHeight('Tg')+1;
    FixedRows  := 1;
    FixedCols  := 0;
    ColWidths[1] := Canvas.TextWidth(' WK U20 ');
    ColWidths[2] := Canvas.TextWidth('  99  ');
    ColWidths[3] := Canvas.TextWidth('  99  ');
    ColWidths[0] := ClientWidth - ColWidths[1] - ColWidths[2] - ColWidths[3] - 3;
    TabOrder := 0; (* Set Focus *)
  end;

  VonEdit.EditMask := '09;0; ';
  BisEdit.EditMask := '09;0; ';
  VonUpDown.Min    := 0; // min 0 zulassen, aber als Fehler melden
  VonUpDown.Max    := cnAlterMax;
  BisUpDown.Min    := 0;
  BisUpDown.Max    := cnAlterMax;

  // damit Count in SetButtons abgefragt werden kann.
  // kwKein, damit ohne Inhalt
  KopierListe := TAkColl.Create(Veranstaltung,kwKein,cnMaennlich,alTria);

  TabControl1.TabIndex := 0; // Tlnwertung
  TabControl2.TabIndex := 0; // Gesamtwertung �ber alle Tln
  TabControl3.TabIndex := 0; // nur ein Tab, kein Geschelecht 
  SetWkDaten;
  // SetAkDaten wird in FormAShow aufgerufen
  //SetAkDaten;
  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);
end;

(*============================================================================*)
destructor TKlassenDialog.Destroy;
(*============================================================================*)
begin
  KopierListe.Free;
  AkListe.Free;
  HelpFenster := HelpFensterAlt;
  inherited Destroy;
end;

// private Methoden

(*----------------------------------------------------------------------------*)
function TKlassenDialog.WettkSelected: TWettkObj;
(*----------------------------------------------------------------------------*)
begin
  if WettkCB.ItemIndex >= 0 then
    Result := TWettkObj(WettkCB.Items.Objects[WettkCB.ItemIndex])
  else Result := nil; // illegal
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.AkSelected: TAkObj;
(*----------------------------------------------------------------------------*)
begin
  Result := TAkObj(AkGrid.FocusedItem);
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.AkCollSelected: TAkColl;
(*----------------------------------------------------------------------------*)
begin
  Result := nil;
  if WkAktuell <> nil then with WkAktuell do
    case WertgSelected of
      kwAltKl  : case SexSelected of
                   cnMaennlich : Result := AltMKlasseColl[TlnMschSelected];
                   cnWeiblich  : Result := AltWKlasseColl[TlnMschSelected];
                 end;
      kwSondKl : case SexSelected of
                   cnMaennlich : Result := SondMKlasseColl;
                   cnWeiblich  : Result := SondWKlasseColl;
                 end;
    end;
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.TlnMschSelected: TTlnMsch;
(*----------------------------------------------------------------------------*)
begin
  if TabControl1.TabIndex = 1 then Result := tmMsch
                              else Result := tmTln;
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.WertgSelected: TKlassenWertung;
(*----------------------------------------------------------------------------*)
begin
  case TabControl2.TabIndex of
    0: Result := kwAlle;
    1: Result := kwSex;
    2: Result := kwAltKl;
    3: if TlnMschSelected=tmTln then Result := kwSondKl // nur bei TlnWertg
                                else Result := kwKein;
    else Result := kwKein; // Compiler-Warnung vermeiden
  end;
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.SexSelected: TSex;
(*----------------------------------------------------------------------------*)
begin
  if TabControl3.Tabs.Count = 1 then Result := cnSexBeide
  else
  if TabControl3.TabIndex = 0 then Result := cnMaennlich
                              else Result := cnWeiblich;
end;

(*----------------------------------------------------------------------------*)
procedure TKlassenDialog.SetWkDaten;
(*----------------------------------------------------------------------------*)
// bei Wettk-Change
begin
  WkAktuell := WettkSelected;
  if WkAktuell = nil then Exit;
  Updating := true;

  // f�r DLV-Klassen 6 Stellen zulassen (nur f�r Wettk. mit 1 Abschn.)
  if WkAktuell.AbschnZahl = 1 then
    KuerzelEdit.MaxLength := 6
  else KuerzelEdit.MaxLength := 3;

  // TabControl1 setzen
  TabControl1.Tabs.Strings[0] := 'Klassen f�r Teilnehmerwertung';
  if WkAktuell.MschWertg <> mwKein then
    if TabControl1.Tabs.Count=1 then
      TabControl1.Tabs.Add('Klassen f�r Mannschaftswertung')
    else
  else // keine MschWertung
    if TabControl1.Tabs.Count=2 then  // MschWertung l�schen
    begin
      TabControl1.TabIndex := 0;
      TabControl1.Tabs.Delete(1);
    end;

  SetTab1Daten;
  Updating := false;
end;

(*----------------------------------------------------------------------------*)
procedure TKlassenDialog.SetTab1Daten;
(*----------------------------------------------------------------------------*)
// bei Tab1-Change, bei Tln mit SonderKlassen, bei Msch ohne Sonderklassen
// 4 Tabs: Alle Teilnehmer,Pro Geschlecht,Altersklassen,Sonderklassen
// bei MschWettk k�nnte auf TlnKlassen verzichtet werden, d�rfen aber bei Serie
// nicht ge�ndert werden, weil Klassen f�r alle Orte gelten, MschWettk werden
// aber nicht gewertet, deshalb Klassen dort egal
// Klassen bleiben, macht vielleicht doch irgendwo sinn
begin
  WkAktuell := WettkSelected;
  if WkAktuell = nil then Exit;
  Updating := true;

  // TabControl2 setzen
  // Klassen gelten bei Serie f�r alle Orte, unabh�ngig von WettkArt,
  // waTlnStaffel,waTlnTeam gibt es nicht bei Serie
  if TlnMschSelected = tmTln then
  begin
    // Tln mit Sonderklassen - 4 Tabs
    if TabControl2.Tabs.Count = 1 then TabControl2.Tabs.Add('Pro Geschlecht');
    if TabControl2.Tabs.Count = 2 then TabControl2.Tabs.Add('Altersklassen');
    if WkAktuell.EinzelWettk then // Sonderklassen
      if TabControl2.Tabs.Count = 3 then TabControl2.Tabs.Add('Sonderklassen'){;}
      else
    else // MschWettk
    if TabControl2.Tabs.Count = 4 then
    begin
      if TabControl2.TabIndex = 3 then TabControl2.TabIndex := 0;
      TabControl2.Tabs.Delete(3);
    end;
  end else // tmMsch
  begin
    if TabControl2.Tabs.Count = 4 then // nie Sonderklassen
    begin
      if TabControl2.TabIndex = 3 then TabControl2.TabIndex := 0;
      TabControl2.Tabs.Delete(3);
    end;
    if WkAktuell.MschWettk then  // Wertung nur f�r Alle Tln
    begin
      TabControl2.TabIndex := 0;
      if TabControl2.Tabs.Count=3 then TabControl2.Tabs.Delete(2);
      if TabControl2.Tabs.Count=2 then TabControl2.Tabs.Delete(1);
    end else
    begin
      if TabControl2.Tabs.Count = 1 then TabControl2.Tabs.Add('Pro Geschlecht');
      if TabControl2.Tabs.Count = 2 then TabControl2.Tabs.Add('Altersklassen');
    end;
  end;

  SetTab2Daten;
  Updating := false;
end;

(*----------------------------------------------------------------------------*)
procedure TKlassenDialog.SetTab2Daten;
(*----------------------------------------------------------------------------*)
// bei Tab2-Change, Geschlecht: 1 oder 2 Tabs
begin
  WkAktuell := WettkSelected;
  if WkAktuell = nil then Exit;
  Updating := true;

  // TabControl3 setzen
  if WertgSelected = kwAlle then
  begin
    TabControl3.Tabs.Strings[0] := 'Beide Geschlechter';
    if TabControl3.Tabs.Count=2 then
    begin
      TabControl3.TabIndex := 0;
      TabControl3.Tabs.Delete(1);
    end;
  end else
  begin
    TabControl3.Tabs.Strings[0] := 'M�nnlich';
    if TabControl3.Tabs.Count = 1 then
      TabControl3.Tabs.Add('Weiblich');
  end;

  SetTab3Daten;
  Updating := false;
end;

(*----------------------------------------------------------------------------*)
procedure TKlassenDialog.SetTab3Daten;
(*----------------------------------------------------------------------------*)
// bei Tab3-Change
var i    : Integer;
    Coll : TAkColl;
    Ak   : TAkObj;
begin
  WkAktuell := WettkSelected;
  if WkAktuell = nil then Exit;
  Updating := true;

  // AkListe als Puffer f�r �nderungen erstellen
  AkListe.Free;
  // kwKein, damit AkListe ohne DTU-, SonderKlassen
  AkListe := TAkColl.Create(Veranstaltung,kwKein,SexSelected,alTria); // ohne Inhalt
  Coll := AkCollSelected;
  if Coll<>nil then // kwAltKl, kwSondKl
    for i:=0 to Coll.Count-1 do with Coll[i] do
    begin
      Ak := TAkObj.Create(Veranstaltung,Coll,oaAdd);
      Ak.Init(Name,Kuerzel,AlterVon,AlterBis,Sex,Wertung);
      AkListe.AddItem(Ak);
    end
  else // <> kwAltKl, kwSondKl
  begin
    case SexSelected of
      cnSexBeide:
      begin
        Ak := TAkObj.Create(Veranstaltung,Coll,oaAdd);
        with AkAlle do
          Ak.Init(Name,Kuerzel,AlterVon,AlterBis,Sex,Wertung);
        AkListe.AddItem(Ak);
        if (TlnMschSelected = tmMsch) or (WkAktuell.WettkArt=waTlnStaffel) or
           (WkAktuell.WettkArt=waTlnTeam) then
        begin
          Ak := TAkObj.Create(Veranstaltung,Coll,oaAdd);
          with AkMixed do
            Ak.Init(Name,Kuerzel,AlterVon,AlterBis,Sex,Wertung);
          AkListe.AddItem(Ak);
        end;
      end;
      cnMaennlich:
      begin
        Ak := TAkObj.Create(Veranstaltung,Coll,oaAdd);
        with WkAktuell.MaennerKlasse[TlnMschSelected] do
          Ak.Init(Name,Kuerzel,AlterVon,AlterBis,Sex,Wertung);
        AkListe.AddItem(Ak);
      end;
      cnWeiblich:
      begin
        Ak := TAkObj.Create(Veranstaltung,Coll,oaAdd);
        with WkAktuell.FrauenKlasse[TlnMschSelected] do
          Ak.Init(Name,Kuerzel,AlterVon,AlterBis,Sex,Wertung);
        AkListe.AddItem(Ak);
      end;
    end;
  end;

  if AkListe.Count = 0 then
  begin
    // vorab neue Klasse erstellen, die bei Abbruch wieder gel�scht wird
    Ak := TAkObj.Create(Veranstaltung,Coll,oaAdd);
    Ak.Init('','',0,0,SexSelected,WertgSelected);
    NeuEingabe := true;
    AkListe.AddItem(Ak);
  end else NeuEingabe := false;

  case WertgSelected of
    kwSex:
    begin // nur Name M�nner/Frauen �nderbar
      NameLabel.Enabled    := true;
      NameEdit.Enabled     := true;
      KuerzelLabel.Enabled := false;
      KuerzelEdit.Enabled  := false;
      VonLabel.Enabled     := false;
      VonEdit.Enabled      := false;
      VonUpDown.Enabled    := false;
      BisLabel.Enabled     := false;
      BisEdit.Enabled      := false;
      BisUpDown.Enabled    := false;
    end;
    kwAltKl:
    begin
      NameLabel.Enabled    := true;
      NameEdit.Enabled     := true;
      if TlnMschSelected = tmTln then
      begin
        KuerzelLabel.Enabled := true;
        KuerzelEdit.Enabled  := true;
      end else // tmMsch
      begin
        KuerzelLabel.Enabled := false; //K�rzel nur TlnAk
        KuerzelEdit.Enabled  := false;
      end;
      VonLabel.Enabled     := true;
      VonEdit.Enabled      := true;
      VonUpDown.Enabled    := true;
      BisLabel.Enabled     := true;
      BisEdit.Enabled      := true;
      BisUpDown.Enabled    := true;
    end;
    kwSondKl:
    begin
      NameLabel.Enabled    := true;
      NameEdit.Enabled     := true;
      KuerzelLabel.Enabled := false;
      KuerzelEdit.Enabled  := false;
      VonLabel.Enabled     := true;
      VonEdit.Enabled      := true;
      VonUpDown.Enabled    := true;
      BisLabel.Enabled     := true;
      BisEdit.Enabled      := true;
      BisUpDown.Enabled    := true;
    end;
    else // kwAlle: nichts �nderbar
    begin
      NameLabel.Enabled    := false;
      NameEdit.Enabled     := false;
      KuerzelLabel.Enabled := false;
      KuerzelEdit.Enabled  := false;
      VonLabel.Enabled     := false;
      VonEdit.Enabled      := false;
      VonUpDown.Enabled    := false;
      BisLabel.Enabled     := false;
      BisEdit.Enabled      := false;
      BisUpDown.Enabled    := false;
    end;
  end;
  AkGrid.Init(AkListe,smSortiert,ssVertical,nil);

  SetAkDaten; // nach Enable
  Updating := false;
end;

(*----------------------------------------------------------------------------*)
procedure TKlassenDialog.SetAkDaten;
(*----------------------------------------------------------------------------*)
begin
  AkAktuell := AkSelected;
  if AkAktuell = nil then Exit;
  Updating := true;
  NameEdit.Text := AkAktuell.Name;
  if KuerzelEdit.Enabled then KuerzelEdit.Text := AkAktuell.Kuerzel
                         else KuerzelEdit.Text := '';
  VonEdit.Text := IntToStr(AkAktuell.AlterVon);
  BisEdit.Text := IntToStr(AkAktuell.AlterBis);
  SetButtons;
  Updating := false;
  Refresh;
end;

(*----------------------------------------------------------------------------*)
procedure TKlassenDialog.SetButtons;
(*----------------------------------------------------------------------------*)
begin
  if AkGeAendert then AendButton.Enabled := true
                 else AendButton.Enabled := false;

  if (WertgSelected=kwAlle) or (WertgSelected=kwSex) or
     NeuEingabe and (AkGrid.ItemCount>1) then NeuButton.Enabled := false
                                         else NeuButton.Enabled := true;

  if (WertgSelected=kwAlle) or (WertgSelected=kwSex) or
      NeuEingabe and (AkGrid.ItemCount=1) then LoeschButton.Enabled := false
                                          else LoeschButton.Enabled := true;

  if (WertgSelected=kwAlle) or (WertgSelected=kwSex) or
     AkGeAendert or ListeGeAendert or
     (AkGrid.ItemCount=1) and NeuEingabe then KopierButton.Enabled := false
                                         else KopierButton.Enabled := true;

  if (WertgSelected=kwAlle) or (WertgSelected=kwSex) or
     (KopierListe.Count=0) then EinfuegButton.Enabled := false
                           else EinfuegButton.Enabled := true;

  if (WertgSelected=kwAltKl) or (WertgSelected=kwSondKl) then
    if DefaultListe(alDTU) then
    begin
      DTU_Button.Enabled := false;
      if (WettkSelected<>nil) and (WettkSelected.AbschnZahl = 1) then
        DLV_Button.Enabled := true
      else DLV_Button.Enabled := false;
    end else
    if DefaultListe(alDLV) then
    begin
      DTU_Button.Enabled := true;
      DLV_Button.Enabled := false;
    end else
    begin
      DTU_Button.Enabled := true;
      if (WettkSelected<>nil) and (WettkSelected.AbschnZahl = 1) then
        DLV_Button.Enabled := true
      else DLV_Button.Enabled := false;
    end
  else
  begin
    DTU_Button.Enabled := false;
    DLV_Button.Enabled := false;
  end;

  if ListeGeAendert then UebernehmButton.Enabled := true
                    else UebernehmButton.Enabled := false;

  // Setze Default Button
  if AkGeAendert then
  begin
    UebernehmButton.Default   := false;
    OkButton.Default          := false;
    AendButton.Default        := true;
  end else
  begin
    AendButton.Default        := false;
    if ListeGeAendert then
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
function TKlassenDialog.AkGeAendert: Boolean;
(*----------------------------------------------------------------------------*)
begin
  if AkAktuell = nil then Result := false
  else Result := NameEdit.Enabled and not StrGleich(AkAktuell.Name,NameEdit.Text) or
                 KuerzelEdit.Enabled and not StrGleich(AkAktuell.Kuerzel,KuerzelEdit.Text) or
                 VonEdit.Enabled and (AkAktuell.AlterVon <> StrToIntDef(VonEdit.Text,0)) or
                 BisEdit.Enabled and (AkAktuell.AlterBis <> StrToIntDef(BisEdit.Text,0));
end;

//------------------------------------------------------------------------------
function TKlassenDialog.KlasseDoppel: Boolean;
//------------------------------------------------------------------------------
// aktuelle Klassenliste nicht einbeziehen, wird in KlasseOk vorher gepr�ft
var Coll:TAkColl;
    S : String;
//------------------------------------------------------------------------------
function AkNameInColl(const S:String; const Coll:TAkColl): Boolean;
var i:Integer;
begin
  Result := false;
  for i:=0 to Coll.Count-1 do
    if StrGleich(S,Coll[i].Name) then
    begin
      Result := true;
      Exit;
    end;
end;

//------------------------------------------------------------------------------
function AkKuerzelInColl(const S:String; const Coll:TAkColl): Boolean;
var i:Integer;
begin
  Result := false;
  for i:=0 to Coll.Count-1 do
    if StrGleich(S,Coll[i].Kuerzel) then
    begin
      Result := true;
      Exit;
    end;
end;
//------------------------------------------------------------------------------
begin
  Result := false;
  if TlnMschSelected = tmTln then S := 'Teilnehmer-'
                             else S := 'Mannschafts-';
  Coll := AkCollSelected;
  with WkAktuell do
  begin
    // pr�fe AkAlle.Name
    if (Coll<>nil)or(SexSelected<>cnSexBeide) then // cnSexKein kommt nicht vor
      if StrGleich(AkAlle.Name,NameEdit.Text) then
    begin
      TriaMessage(Self,'Die Bezeichnung  "'+Trim(NameEdit.Text)+
                  '"  wird bereits f�r  "Alle Klassen"  verwendet.',
                   mtInformation,[mbOk]);
      Result := true;
      Exit;
    end;
    // pr�fe M�nnerklasse
    if (Coll<>nil)or(SexSelected<>cnMaennlich) then
      if StrGleich(WkAktuell.MaennerKlasse[TlnMschSelected].Name,NameEdit.Text) then
    begin
      TriaMessage(Self,'Die Bezeichnung  "'+Trim(NameEdit.Text)+
                  '"  wird bereits f�r die  "'+S+'M�nnerklasse"  verwendet.',
                   mtInformation,[mbOk]);
      Result := true;
      Exit;
    end;
    // pr�fe Frauenklasse
    if (Coll<>nil)or(SexSelected<>cnWeiblich) then
      if StrGleich(WkAktuell.FrauenKlasse[TlnMschSelected].Name,NameEdit.Text) then
    begin
      TriaMessage(Self,'Die Bezeichnung  "'+Trim(NameEdit.Text)+
                  '"  wird bereits f�r die  "'+S+'Frauenklasse"  verwendet.',
                   mtInformation,[mbOk]);
      Result := true;
      Exit;
    end;
    // pr�fe Ak-M�nner-Name
    if (Coll <> AltMKlasseColl[TlnMschSelected]) and
       AkNameInColl(NameEdit.Text,AltMKlasseColl[TlnMschSelected]) then
    begin
      TriaMessage(Self,'Die Bezeichnung  "'+Trim(NameEdit.Text)+
                  '"  wird bereits f�r eine '+S+'Altersklasse - M�nnlich verwendet.',
                   mtInformation,[mbOk]);
      Result := true;
      Exit;
    end;
    // pr�fe Ak-Frauen-Name
    if (Coll <> AltWKlasseColl[TlnMschSelected]) and
       AkNameInColl(NameEdit.Text,AltWKlasseColl[TlnMschSelected]) then
    begin
      TriaMessage(Self,'Die Bezeichnung  "'+Trim(NameEdit.Text)+
                  '"  wird bereits f�r eine '+S+'Altersklasse - Weiblich verwendet.',
                   mtInformation,[mbOk]);
      Result := true;
      Exit;
    end;
    // pr�fe Ak-M�nner-K�rzel
    if TlnMschSelected = tmTln then
    begin
      if (Coll <> AltMKlasseColl[tmTln]) and
         AkKuerzelInColl(KuerzelEdit.Text,AltMKlasseColl[tmTln]) then
      begin
        TriaMessage(Self,'Das K�rzel  "'+Trim(KuerzelEdit.Text)+
                    '"  wird bereits f�r eine Altersklasse - M�nnlich verwendet.',
                     mtInformation,[mbOk]);
        Result := true;
        Exit;
      end;
      //pr�fe Ak-Frauen-K�rzel
      if (Coll <> AltWKlasseColl[tmTln]) and
         AkKuerzelInColl(KuerzelEdit.Text,AltWKlasseColl[tmTln]) then
      begin
        TriaMessage(Self,'Das K�rzel  "'+Trim(KuerzelEdit.Text)+
                    '"  wird bereits f�r eine Altersklasse - Weiblich verwendet.',
                     mtInformation,[mbOk]);
        Result := true;
        Exit;
      end;
      // pr�fe Sk-M�nner
      if (Coll <> SondMKlasseColl) and
         AkNameInColl(NameEdit.Text,SondMKlasseColl) then
      begin
        TriaMessage(Self,'Die Bezeichnung  "'+Trim(NameEdit.Text)+
                    '"  wird bereits f�r eine Sonderklasse - M�nnlich verwendet.',
                     mtInformation,[mbOk]);
        Result := true;
        Exit;
      end;
      // pr�fe Sk-Frauen
      if (Coll <> SondWKlasseColl) and
         AkNameInColl(NameEdit.Text,SondWKlasseColl) then
      begin
        TriaMessage(Self,'Die Bezeichnung  "'+Trim(NameEdit.Text)+
                    '"  wird bereits f�r eine Sonderklasse - Weiblich verwendet.',
                     mtInformation,[mbOk]);
        Result := true;
        Exit;
      end;
    end;
  end;
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.KlasseOK: Boolean;
(*----------------------------------------------------------------------------*)
// bei �nderung zun�chst nur Klasse pr�fen, nicht die Konsistenz der Liste
var i : Integer;
begin
  Result := false;

  if StrGleich(NameEdit.Text,'') then
  begin
    TriaMessage(Self,'Bezeichnung der Klasse fehlt.',mtInformation,[mbOk]);
    if NameEdit.CanFocus then NameEdit.SetFocus;
    Exit;
  end;
  if (WertgSelected = kwAltKl) and KuerzelEdit.Enabled and
      StrGleich(KuerzelEdit.Text,'') then
  begin
    TriaMessage(Self,'K�rzel der Klasse fehlt.',mtInformation,[mbOk]);
    if KuerzelEdit.CanFocus then KuerzelEdit.SetFocus;
    Exit;
  end;

  for i:=0 to AkGrid.ItemCount-1 do
    if (AkGrid[i] <> AkAktuell) and
       StrGleich(TAkObj(AkGrid[i]).Name, NameEdit.Text) then
    begin
      TriaMessage(Self,'Die Bezeichnung  "'+Trim(NameEdit.Text)+
                  '"  ist bereits in der Klassenliste enthalten.',mtInformation,[mbOk]);
      if NameEdit.CanFocus then NameEdit.SetFocus;
      Exit;
    end;

  if (WertgSelected = kwAltKl) and KuerzelEdit.Enabled then
    for i:=0 to AkGrid.ItemCount-1 do
      if (AkGrid[i] <> AkAktuell) and
         StrGleich(TAkObj(AkGrid[i]).Kuerzel, KuerzelEdit.Text) then
      begin
        TriaMessage(Self,'Das K�rzel  "'+Trim(KuerzelEdit.Text)+
                    '"  ist bereits in der Klassenliste enthalten.',mtInformation,[mbOk]);
        if KuerzelEdit.CanFocus then KuerzelEdit.SetFocus;
        Exit;
      end;

  if (WertgSelected<>kwAlle) and (WertgSelected<>kwSex) then
  begin

    if StrToIntDef(VonEdit.Text,0) = 0 then // UpDown.Min = 1
    begin
      TriaMessage(Self,'Der eingegebene Wert ist ung�ltig. Erlaubt sind Werte von ' +
                  IntToStr(cnAlterMin)+' bis '+IntToStr(cnAlterMax)+'.'
                  ,mtInformation,[mbOk]);
      if VonEdit.CanFocus then VonEdit.SetFocus;
      Exit;
    end;
    if StrToIntDef(BisEdit.Text,0) = 0 then // UpDown.Min = 1
    begin
      TriaMessage(Self,'Der eingegebene Wert ist ung�ltig. Erlaubt sind Werte von ' +
                  IntToStr(cnAlterMin)+' bis '+IntToStr(cnAlterMax)+'.'
                  ,mtInformation,[mbOk]);
      if BisEdit.CanFocus then BisEdit.SetFocus;
      Exit;
    end;

    // Validate wird nicht automatisch ausgef�hrt bei ENTER-Taste
    if not VonEdit.ValidateEdit then Exit;
    if not BisEdit.ValidateEdit then Exit;
    if (StrToInt(VonEdit.Text) > StrToInt(BisEdit.Text)) then
    begin
      TriaMessage(Self,'"Alter von" ist gr��er als "Alter bis".',mtInformation,[mbOk]);
      if VonEdit.CanFocus then VonEdit.SetFocus;
      Exit;
    end;
  end;

  if not KlasseDoppel then Result := true;
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.AkNeu: Boolean;
(*----------------------------------------------------------------------------*)
var Ak : TAkObj;
    AlterMinBuf : Integer;
begin
  Result := false;

  // ge�nderte Daten �bernehmen
  if AkGeAendert then
    if NeuEingabe then
      if not AkAendern then Exit
      else
    else
    case TriaMessage(Self,'Die Einstellungen der markierten Klasse wurden ge�ndert.'+#13+
           '�nderungen �bernehmen?',mtConfirmation,[mbYes,mbNo,mbCancel]) of
      mrYes : if not AkAendern then Exit;
      mrNo  : ;
      else    Exit;
    end
  else if NeuEingabe then
  begin
    if NameEdit.CanFocus then NameEdit.SetFocus;
    Exit; // keine Aktion
  end;

  if AkGrid.ItemCount >= cnAlterMax then
  begin
    TriaMessage(Self,'Maximale Klassenzahl erreicht.',mtInformation,[mbOk]);
    Exit;
  end;
  if (AkGrid.ItemCount > 0) and
     (TAkObj(AkGrid[AkGrid.ItemCount-1]).AlterBis < cnAlterMax) then
    AlterMinBuf := TAkObj(AkGrid[AkGrid.ItemCount-1]).AlterBis + 1
  else AlterMinBuf := 0;

  Refresh;
  Ak := TAkObj.Create(Veranstaltung,TAkColl(AkGrid.Collection),oaAdd);
  Ak.Init('','',AlterMinBuf,AlterMinBuf,SexSelected,WertgSelected);
  NeuEingabe := true;  // vor AddItem
  AkGrid.AddItem(Ak);
  AkGrid.Refresh; // Refresh in TriaGrid.AddItem entfernt !!!!!!!!!!!!!
  AkGrid.FocusedItem := Ak;
  SetAkDaten; (* AkAktuell gesetzt *)
  //SetPage(AllgemeinTS);
  if NameEdit.CanFocus then NameEdit.SetFocus;
  Result := true;
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.AkAendern: Boolean;
(*----------------------------------------------------------------------------*)
// AkAktuell �ndern
// nur Klasse pr�fen, nicht die Konsistentz der Liste
begin
  Result := false;
  if (AkAktuell=nil) or not KlasseOk then Exit;

  Refresh;
  AkAktuell.Init(Trim(NameEdit.Text),Trim(KuerzelEdit.Text),
                 StrToIntDef(VonEdit.Text,0),StrToIntDef(BisEdit.Text,0),SexSelected,WertgSelected);
  NeuEingabe := false; // vor Update
  AkGrid.CollectionUpdate;
  AkGrid.Refresh;
  AkGrid.FocusedItem := AkAktuell;
  SetAkDaten;
  if AkGrid.ItemCount <= 1 then
    if NameEdit.CanFocus then NameEdit.SetFocus
    else
  else
    if AkGrid.CanFocus then AkGrid.SetFocus;

  Result := true;
end;

(*----------------------------------------------------------------------------*)
procedure TKlassenDialog.AkLoeschen;
(*----------------------------------------------------------------------------*)
// Akktuell entfernen
var Ak : TAkObj;
begin
  if AkAktuell = nil then Exit;
  if not NeuEingabe and (TriaMessage(Self,'Markierte Klasse l�schen?',
                         mtConfirmation,[mbOk,mbCancel]) <> mrOk) then Exit;
  Refresh;
  NeuEingabe := false; // vor ClearItem
  AkGrid.ClearItem(AkAktuell);   (* AkAktuell l�schen *)

  if AkGrid.ItemCount = 0 then
  begin
    NeuEingabe := true; // vor AddItem
    Ak := TAkObj.Create(Veranstaltung,TAkColl(AkGrid.Collection),oaAdd);
    Ak.Init('','',0,0,SexSelected,WertgSelected);
    AkGrid.AddItem(Ak);
  end;
  AkGrid.CollectionUpdate;
  AkGrid.Refresh;
  SetAkDaten;
  if (AkGrid.ItemCount <= 1) or NeuEingabe then
    if NameEdit.CanFocus then NameEdit.SetFocus
    else
  else
    if AkGrid.CanFocus then AkGrid.SetFocus;
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.ListeOK: Boolean;
(*----------------------------------------------------------------------------*)
// vor Wechsel der Seite oder OkButton die Liste auf Konsistenz pr�fen
// Pr�fung auf Doppel-Namen/-K�rzel vorher in KlasseOk
var i,AlterBuf : Integer;
begin
  Result := false;
  // leere Liste ist zul�ssig
  // Alters-�berlappung nicht zul�ssig
  AlterBuf := -1;
  for i:=0 to AkGrid.ItemCount-1 do
    with TAkObj(AkGrid[i]) do
      if AlterVon <= AlterBuf then
      begin
        TriaMessage(Self,'Die Altersgrenzen der Klassen  "'+TAkObj(AkGrid[i-1]).Name +
                    '"  und  "'+Name+'"  �berlappen sich.',mtInformation,[mbOk]);
        AkGrid.ItemIndex := i;
        SetAkDaten;
        if VonEdit.CanFocus then VonEdit.SetFocus;
        Exit;
      end else AlterBuf := AlterBis;

  // Alters-L�cken nicht zul�ssig
  AlterBuf := cnAlterMax;
  for i:=0 to AkGrid.ItemCount-1 do
    with TAkObj(AkGrid[i]) do
      if AlterVon > AlterBuf + 1 then
        if WertgSelected = kwAltKl then // keine L�cken zulassen
        begin
          TriaMessage(Self,'Das Alter  "'+IntToStr(AlterBuf+1)+
                      '"  ist in keiner Altersklasse enthalten.'+#13+
                      'In der Klassenliste sind Altersl�cken nicht erlaubt.',
                       mtInformation,[mbOk]);
          AkGrid.ItemIndex := i;
          SetAkDaten;
          if VonEdit.CanFocus then VonEdit.SetFocus;
          Exit;
        end else
      else AlterBuf := AlterBis;

  Result := true;
end;

//------------------------------------------------------------------------------
function TKlassenDialog.ListeGeAendert: Boolean;
//------------------------------------------------------------------------------
var i    : Integer;
    Coll : TAkColl;
//..............................................................................
function AkUnGleich(CollIdx,Idx:Integer): Boolean;
begin
  with Coll.SortItems[CollIdx] do
    Result := not StrGleich(Name,TAkObj(AkGrid[Idx]).Name) or
             (TlnMschSelected=tmTln) and not StrGleich(Kuerzel,TAkObj(AkGrid[Idx]).Kuerzel) or
             (AlterVon <> TAkObj(AkGrid[Idx]).AlterVon) or
             (AlterBis <> TAkObj(AkGrid[Idx]).AlterBis);
end;

begin
  Result := false;
  Coll := AkCollSelected;
  if Coll = nil then // kwAlle, kwSex
    case SexSelected of
      cnMaennlich : if not StrGleich(WkAktuell.MaennerKlasse[TlnMschSelected].Name,
                                     TAkObj(AkGrid[0]).Name) then Result := true;
      cnWeiblich  : if not StrGleich(WkAktuell.FrauenKlasse[TlnMschSelected].Name,
                                     TAkObj(AkGrid[0]).Name) then Result := true;
      else // cnSexBeide, cnSexKein
    end
  else // kwAltKl, kwSondKl

  if NeuEingabe then // bei NeuEingabe Zus�tzlicher Ak in AkGrid[0]
    if Coll.SortCount <> AkGrid.ItemCount-1 then
      Result := true
    else
      for i:=0 to Coll.SortCount-1 do
        if AkUnGleich(i,i+1) then
        begin
          Result := true;
          Exit;
        end else
  else
  if Coll.SortCount <> AkGrid.ItemCount then
    Result := true
  else
    for i:=0 to Coll.SortCount-1 do with Coll.SortItems[i] do
      if AkUnGleich(i,i) then
      begin
        Result := true;
        Exit;
      end;
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.ListeAendern: Boolean;
(*----------------------------------------------------------------------------*)
var i    : Integer;
    Coll : TAkColl;
    Ak   : TAkObj;
begin
  Result := false;
  if not ListeOK then Exit;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    Coll := AkCollSelected;
    if Coll <> nil then
    begin
      if Coll.IndexOf(HauptFenster.SortKlasse) >= 0 then
        HauptFenster.SortKlasse := AkUnbekannt; //SortKlasse wird nachher gel�scht
      if (Coll=WkAktuell.AltMKlasseColl[tmMsch])or
         (Coll=WkAktuell.AltWKlasseColl[tmMsch]) then
        Veranstaltung.MannschColl.ClearKlassen(WkAktuell)
      else Veranstaltung.TlnColl.ClearKlassen(WkAktuell);
      Coll.Clear;
      if not NeuEingabe then // AkListe.Count=1 bei leere Liste
        for i:=0 to AkListe.Count-1 do with AkListe[i] do
        begin
          Ak := TAkObj.Create(Veranstaltung,Coll,oaAdd);
          Ak.Init(Name,Kuerzel,AlterVon,AlterBis,SexSelected,WertgSelected);
          Coll.AddItem(Ak);
        end;
      WkAktuell.RngMaxCollUpdate(Coll);
      WkAktuell.KlassenModified := true; // alles neu berechnen
    end else
      case SexSelected of
        //cnSexBeide  : AkAlle, AkMixed nicht �nderbar
        cnMaennlich : WkAktuell.MaennerKlasse[TlnMschSelected].Name := AkListe[0].Name;
        cnWeiblich  : WkAktuell.FrauenKlasse[TlnMschSelected].Name := AkListe[0].Name;
        else Exit;
      end;

    SetButtons;
    TriDatei.Modified := true;
    Result := true;
  finally
    with HauptFenster do
    begin
      HauptFenster.LstFrame.UpdateAkColBreite;
      // neue Ansicht gesetzt, weil Ak-liste sich �ndern kann
      LstFrame.AnsFrame.Init(Ansicht,SortMode,SortWettk,SortWrtg,SortSex,SortKlasse,SortStatus);
      HauptFenster.CommandDataUpdate;
      LstFrame.TriaGrid.StopPaint := false;
    end;
  end;
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.ListeUebernehmen: Boolean;
(*----------------------------------------------------------------------------*)
var S : String;
begin
  Result := false;
  if not AkGeAendert and not ListeGeAendert then
    if NeuEingabe then AkLoeschen
    else
  else
  begin
    if ListeGeAendert then S := 'Die Klassenliste wurde ge�ndert.'
    else S := 'Die markierte Klasse wurde ge�ndert.';

    case TriaMessage(S +#13+ '�nderungen �bernehmen?',
                     mtConfirmation,[mbYes,mbNo,mbCancel]) of
      mrYes : if AkGeAendert and not AkAendern then Exit
              else begin
                if NeuEingabe then AkLoeschen;
                if not ListeAendern then Exit;
              end;
      mrNo  : if NeuEingabe then AkLoeschen;
      else    Exit;
    end;
  end;
  Result := true;
end;

(*----------------------------------------------------------------------------*)
function TKlassenDialog.DefaultListe(DefListe:TDefaultAkListe): Boolean;
(*----------------------------------------------------------------------------*)
var i : Integer;
    DefAkListe : TAkColl;
begin
  Result := false;
  DefAkListe := DTU_M_AkListe; // Compiler-Warnung vermeiden

  case DefListe of
    alDTU:
      case WertgSelected of // keinen Unterschied f�r Tln-Msch
        kwAltKl  : case SexSelected of
                     cnMaennlich : DefAkListe := DTU_M_AkListe;
                     cnWeiblich  : DefAkListe := DTU_W_AkListe;
                     else Exit;
                   end;
        kwSondKl : case SexSelected of
                     cnMaennlich : DefAkListe := DTU_M_SkListe;
                     cnWeiblich  : DefAkListe := DTU_W_SkListe;
                     else Exit;
                   end;
        else Exit;
      end;
    alDLV:
      case WertgSelected of // keinen Unterschied f�r Tln-Msch
        kwAltKl  : case SexSelected of
                     cnMaennlich : DefAkListe := DLV_M_AkListe;
                     cnWeiblich  : DefAkListe := DLV_W_AkListe;
                     else Exit;
                   end;
        kwSondKl : case SexSelected of
                     cnMaennlich : DefAkListe := DLV_M_SkListe;
                     cnWeiblich  : DefAkListe := DLV_W_SkListe;
                     else Exit;
                   end;
        else Exit;
      end;
  end;

  if AkListe.SortCount = DefAkListe.SortCount then
    for i:=0 to AkListe.SortCount-1 do with AkListe.SortItems[i] do
    begin
      if Name <> DefAkListe.SortItems[i].Name then Exit;
      if Kuerzel <> DefAkListe.SortItems[i].Kuerzel then Exit;
      if AlterVon <> DefAkListe.SortItems[i].AlterVon then Exit;
      if AlterBis <> DefAkListe.SortItems[i].AlterBis then Exit;
    end
  else Exit;
  Result := true;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.TlnAkMGridDrawCell(Sender: TObject; ACol,
                             ARow: Integer; Rect: TRect; State: TGridDrawState);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var Text : String;
    Ak : TAkObj;
    Ausrichtung: TAlignment;
begin
  Text := ''; // dummy Leerzeile wenn Itemcount = 0
  Ausrichtung := taLeftJustify;
  with AkGrid do
  begin
    if Collection <> nil then
      if ARow=0 then (* �berschrift *)
      begin
        case ACol of
          0:  begin
                Text := 'Bezeichnung';
                 Ausrichtung := taLeftJustify;
              end;
          1:  begin
                Text := 'K�rzel';
                 Ausrichtung := taCenter;
              end;
          2:  begin
                Text := 'Von';
                 Ausrichtung := taCenter;
              end;
          3:  begin
                Text := 'Bis';
                Ausrichtung := taCenter;
              end;
        end;
      end
      else if ARow < ItemCount  + 1 then (* FixedRows = 1 *)
      begin
        Ak := TAkObj(Collection.SortItems[ARow-1]);
        if Enabled then
          //if (ARow>1) or not NeuEingabe then // Text='' f�r neue Ak,immer 1.zeile
          case ACol of
            0: begin
                 Text := Ak.Name;
                 Ausrichtung := taLeftJustify;
               end;
            1: begin
                 if TlnMschSelected = tmTln then Text := Ak.Kuerzel
                                            else Text := '';
                 Ausrichtung := taCenter;
               end;
            2: begin
                 if (WertgSelected=kwAlle) or (WertgSelected=kwSex) or
                    (Ak.AlterVon > 0) then
                   Text := Format('%.2u',[Ak.AlterVon])
                 else Text := '';
                 Ausrichtung := taCenter;
               end;
            3: begin
                 if (WertgSelected=kwAlle) or (WertgSelected=kwSex) or
                    (Ak.AlterBis > 0) then
                   Text := Format('%.2u',[Ak.AlterBis])
                 else Text := '';
                 Ausrichtung := taCenter;
               end;
          end;
      end;
    DrawCellText(Rect,Text,Ausrichtung);
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.AkGridClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var Ak : TAkObj;
begin
  // Exit beim Setzen von FocusedItem oder ItemIndex
  if not AkGrid.EnableOnClick then Exit
  else AkGrid.EnableOnClick := false;

  try
    Ak := AkSelected;
    if (Ak = nil) or (AkAktuell = nil) then Exit;

    if AkGeAendert then
    begin
      AkGrid.ScrollBars := ssNone;
      case TriaMessage(Self,'Die Klasse wurde ge�ndert.'+#13+
                      '�nderungen �bernehmen?',
                       mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes : if AkAendern then SetAkDaten (* Ak *)
                             else AkGrid.FocusedItem := AkAktuell;
        mrNo  : if (Ak<>AkAktuell) and NeuEingabe then AkLoeschen
                                                  else SetAkDaten;
        else    AkGrid.FocusedItem := AkAktuell;
      end;
    end else if (Ak<>AkAktuell) and NeuEingabe then AkLoeschen
    else SetAkDaten; (* hier wird auch akAktuell neu gesetzt *)

  finally
    AkGrid.ScrollBars := ssVertical;
    AkGrid.EnableOnClick := true;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.FormShow(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  SetAkDaten;
  if (AkGrid.ItemCount <= 1) or NeuEingabe then
    if NameEdit.CanFocus then NameEdit.SetFocus
    else
  else
    if AkGrid.CanFocus then AkGrid.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.WettkCBChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not ListeUebernehmen then
  begin
    if WettkCB.Items.IndexOf(WkAktuell.Name) >= 0 then
      WettkCB.ItemIndex := WettkCB.Items.IndexOf(WkAktuell.Name)
    else WettkCB.ItemIndex := 0;
    //WettkCB.ItemIndex := Veranstaltung.WettkColl.SortIndexOf(WkAktuell);
    Exit;
  end;

  SetWkDaten;
  //SetAkDaten;
  if (AkGrid.ItemCount <= 1) or NeuEingabe then
    if NameEdit.CanFocus then NameEdit.SetFocus
    else
  else
    if AkGrid.CanFocus then AkGrid.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.WettkCBLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if WettkCB.CanFocus then WettkCB.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.TabControlChanging(Sender:TObject;var AllowChange:Boolean);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// vor change ausgef�hrt
begin
  if not Updating then AllowChange := ListeUebernehmen
  else AllowChange := true;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.TabControl1Change(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// nach change ausgef�hrt
begin
  if not Updating then
  begin
    SetTab1Daten;
    if (AkGrid.ItemCount <= 1) or NeuEingabe then
      if NameEdit.CanFocus then NameEdit.SetFocus
      else
    else
      if AkGrid.CanFocus then AkGrid.SetFocus;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.TabControl2Change(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// nach change ausgef�hrt
begin
  if not Updating then
  begin
    SetTab2Daten;
    if (AkGrid.ItemCount <= 1) or NeuEingabe then
      if NameEdit.CanFocus then NameEdit.SetFocus
      else
    else
      if AkGrid.CanFocus then AkGrid.SetFocus;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.TabControl3Change(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// nach change ausgef�hrt
begin
  if not Updating then
  begin
    SetTab3Daten;
    if (AkGrid.ItemCount <= 1) or NeuEingabe then
      if NameEdit.CanFocus then NameEdit.SetFocus
      else
    else
      if AkGrid.CanFocus then AkGrid.SetFocus;
    end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.EditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not Updating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  CanClose := true;
  // neue Ak ohne Eingaben wird gel�scht
  if (ModalResult=mrCancel) and NeuEingabe then AkGrid.ClearItem(AkAktuell);
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.AendButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass w�hrend Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    if AkGeAendert then AkAendern;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.NeuButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass w�hrend Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    AkNeu;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.LoeschButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass w�hrend Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    AkLoeschen;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.KopierButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var i  : Integer;
    Ak : TAkObj;
begin
  // verhindern, dass w�hrend Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    // AkListe als Puffer f�r �nderungen erstellen
    KopierListe.Free;
    // kwKein, damit AkListe ohne DTU-, SonderKlassen
    KopierListe := TAkColl.Create(Veranstaltung,kwKein,SexSelected,alTria); // ohne Inhalt
    for i:=0 to AkListe.Count-1 do with AkListe[i] do
    begin
      Ak := TAkObj.Create(Veranstaltung,nil,oaAdd);
      Ak.Init(Name,Kuerzel,AlterVon,AlterBis,Sex,Wertung);
      KopierListe.AddItem(Ak);
    end;
    SetButtons;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.EinfuegButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var i : Integer;
    Ak : TAkObj;
begin
  // verhindern, dass w�hrend Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    if NeuEingabe and (AkListe.Count <= 1) or
       (TriaMessage(Self,'Alle in der Liste enthaltene Klassen werden gel�scht.',
                     mtWarning,[mbOk,mbCancel]) = mrOk) then
    begin
      Updating := true;
      NeuEingabe := false; // vor grid.init, wegen drawcell
      AkListe.Free;
      // kwKein, damit AkListe OHNE DTU-, SonderKlassen
      AkListe := TAkColl.Create(Veranstaltung,kwKein,SexSelected,alTria); // ohne Inhalt
      for i:=0 to KopierListe.Count-1 do with KopierListe[i] do
      begin
        Ak := TAkObj.Create(Veranstaltung,AkListe,oaAdd);
        Ak.Init(Name,Kuerzel,AlterVon,AlterBis,SexSelected,WertgSelected);
        AkListe.AddItem(Ak);
      end;
      AkGrid.Init(AkListe,smSortiert,ssVertical,nil);
      KopierListe.Clear; // Damit wird EinfuegButton disabled
      SetAkDaten;
      Updating := false;
  end;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.DefaultButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass w�hrend Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    if NeuEingabe and (AkListe.Count <= 1) or
       (TriaMessage(Self,'Alle in der Liste enthaltene Klassen werden gel�scht.',
                     mtWarning,[mbOk,mbCancel]) = mrOk) then
    begin
      Updating := true;
      NeuEingabe := false; // vor grid.init, wegen drawcell
      AkListe.Free;
      if Sender=DLV_Button then
        AkListe := TAkColl.Create(Veranstaltung,WertgSelected,SexSelected,alDLV)
      else
        AkListe := TAkColl.Create(Veranstaltung,WertgSelected,SexSelected,alDTU);
      AkGrid.Init(AkListe,smSortiert,ssVertical,nil);
      SetAkDaten;
      Updating := false;
    end;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.UebernehmButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass w�hrend Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    if AkGeAendert and not AkAendern then Exit;
    if NeuEingabe then AkLoeschen;
    ListeAendern;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.OkButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// Bei �nderung speichern ohne nachzufragen
begin
  // verhindern, dass w�hrend Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    if AkGeAendert and not AkAendern then Exit;
    if ListeGeAendert and not ListeAendern then Exit;
    ModalResult := mrOk;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TKlassenDialog.HilfeButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  Application.HelpContext(3400);  // Alterslklassen
end;


end.

