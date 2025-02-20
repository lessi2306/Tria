unit UrkundeDlg;

// Info:
// Microsoft Knowledge Base 229310: 'How To Automate Word to Perform Mail Merge from Delphi'
// siehe unten

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleServer,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, System.Math,
  ComObj, Vcl.ComCtrls, Vcl.Mask, Printers,
  AllgConst,AllgObj,AllgComp,AllgFunc,AkObj,WettkObj,TlnObj,MannsObj;

procedure WordUrkunde(Mode:TReportMode);

type
  TUrkundeDialog = class(TForm)

  published
    PrintDialog: TPrintDialog;
    UrkDokLabel: TLabel;
    UrkDokCB: TComboBox;
    UrkDateiBtn: TBitBtn;
    DatenPanel: TPanel;
      TitelLabel: TLabel;
      WettkLabel: TLabel;
      WettkEdit: TTriaEdit;
      KlasseLabel: TLabel;
      KlasseCB: TComboBox;
      NameLabel: TLabel;
      NameEdit: TTriaEdit;
      RngLabel: TLabel;
      RngEdit: TTriaEdit;
      SnrLabel: TLabel;
      SnrEdit: TTriaEdit;
    DruckenGB: TGroupBox;
      UrkDrRB: TRadioButton;
      UrkWordRB: TRadioButton;
      DruckerCB: TComboBox;
      DruckerBtn: TButton;
      AnzahlLabel: TLabel;
      AnzahlEdit: TTriaMaskEdit;
      AnzahlUpDown: TTriaUpDown;
    OkButton: TButton;
    CancelButton: TButton;
    HilfeButton: TButton;

    procedure UrkDokLabelClick(Sender: TObject);
    procedure UrkDateiBtnClick(Sender: TObject);
    procedure UrkDokCBChange(Sender: TObject);
    procedure KlasseCBChange(Sender: TObject);
    procedure DruckerBtnClick(Sender: TObject);
    procedure UrkundeGBClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);

  private
    HelpFensterAlt  : TWinControl;
    DisableButtons  : Boolean;
    Updating        : Boolean;
    UrkHauptDokPfad : String;
    UrkDataDokPfad  : String;
    UrkAnzeigenAlt  : Boolean;
    UrkHauptDokNeu  : Boolean;
    FeldListe       : TStringList;
    wrdApp, wrdDoc  : Variant;

    procedure UpdateTlnRang;
    procedure UpdateMschDaten;
    procedure UpdateDruckenGB;
    function  DokIndx(DokName: String): Integer;
    procedure UpdateDokCB(DokName: String);
    procedure UpdateDokListe;
    function  UebernehmeUrkDaten: Boolean;
    function  QuellDateiErstellen: Boolean;
    function  UrkHauptDokErstellen: Boolean;
    function  UrkDokErstellen: Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;


var
  UrkundeDialog : TUrkundeDialog;
  UrkMode       : TReportMode;
  TlnPtr        : TTlnObj;
  MschPtr       : TMannschObj;
  AkPtr         : TAkObj;
  UrkAnzahl     : Integer;

implementation

uses TriaMain,DateiDlg,SerienDr,ListFmt,VeranObj,VistaFix,Registry;

Const wdAlignParagraphLeft = 0;
Const wdAlignParagraphCenter = 1;
Const wdAlignParagraphRight = 2;
Const wdAlignParagraphJustify = 3;
Const wdSendToNewDocument = 0;
Const wdFormLetters = 0;

procedure SetWindowsStandardDrucker(DruckerName:String); forward;


{$R *.dfm}

//******************************************************************************
procedure WordUrkunde(Mode:TReportMode);
//******************************************************************************
// Mode: rmWordUrk (Einzeldruck) oder rmSerDrUrk (Seriendruck)
begin
  TlnPtr  := nil;
  MschPtr := nil;
  UrkMode := Mode;

  if UrkMode = rmWordUrk then // Einzel-Urkunde
  with HauptFenster do
  begin
    if (Ansicht = anKein) or (LstFrame.TriaGrid.ItemCount = 0) then Exit;
    AkPtr := SortKlasse;
    TlnPtr := LstFrame.TriaGrid.FocusedItem;
    if TlnPtr = nil then Exit;
    if not TlnPtr.UrkDruck then
    begin
      TriaMessage('F�r  "'+TlnPtr.NameVName+'"  ist die Option "Urkunde drucken" ausgeschaltet.',
                  mtInformation,[mbOk]);
      Exit;
    end;

    if MschAnsicht then
    begin
      MschPtr := TlnPtr.MannschPtr(SortKlasse.Wertung); // in UpdateRang an AkPtr angepa�t
      if MschPtr = nil then Exit;
    end;
  end;

  UrkundeDialog := TUrkundeDialog.Create(HauptFenster);
  try
    UrkundeDialog.ShowModal;
  finally
    FreeAndNil(UrkundeDialog);
  end;
  HauptFenster.StatusBarClear;
  HauptFenster.RefreshAnsicht;
end;

{//******************************************************************************
function GetWindowsStandardDrucker: String;
//******************************************************************************
//Name HP LaserJet manchmal erweitert, nicht klar warum
var
  ResStr : array[0..255] of char;
begin
  Result := '';
  try
    GetProfileString('Windows','device','',ResStr,255);
    Result:=StrPas(ResStr);
  except
  end;
end;}

//******************************************************************************
procedure SetWindowsStandardDrucker(DruckerName:String);
//******************************************************************************
var
  ResStr : array[0..255] of char;
begin
  try
    StrPCopy(ResStr,DruckerName);
    WriteProfileString('windows', 'device', ResStr);
    StrCopy(ResStr, 'windows');
    SendMessage(HWND_BROADCAST, WM_WININICHANGE, 0, LongInt(@ResStr)); // Symbolleiste verschwindet
    HauptFenster.Refresh; // symbolleiste gleich wiederherstellen
  except
  end;
end;


(******************************************************************************)
(*           Methoden von TUrkundeDialog                                      *)
(******************************************************************************)

//==============================================================================
constructor TUrkundeDialog.Create(AOwner: TComponent);
//==============================================================================
var i : Integer;
begin
  inherited Create(AOwner);

  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  Updating       := false;
  DisableButtons := false;

  with UrkDokCB do
  begin
    Items.Clear; // L�sung f�r Problem mit falschem Index beim Anklicken, wahrscheinlich nicht  ??????
    Items.Add('<neues Urkunde-Hauptdokument erstellen>');
    for i:=0 to UrkDokListe.Count-1 do
      if FileExists(UrkDokListe[i]) then
        Items.Add(UrkDokListe[i]);
    if Items.Count > 1 then
      ItemIndex := 1 // zuletzt verwendetes Hauptdok immer Indx=1
    else
    if Items.Count = 1 then
      ItemIndex := 0;

    if ItemIndex = 0 then
      Style := csDropDownList // kein Editieren m�glich
    else
      Style := csDropDown;
  end;

  KlasseCB.Items.Clear;

  // Items positionieren
  if UrkMode = rmWordUrk then // TlnPtr und MschPtr vorher gesetzt und <> nil
  begin
    Self.Caption := 'Urkunde mit MS-Word erstellen';
    // Wettkampf
    WettkEdit.Text := GetTitel2(TlnPtr.Wettk,HauptFenster.SortWrtg);

    if HauptFenster.TlnAnsicht then
    begin
      // Titel
      if Veranstaltung.Serie then
        if HauptFenster.Ansicht = anTlnErgSerie then
          TitelLabel.Caption := 'Urkunde Teilnehmer - Serienwertung '
        else
          TitelLabel.Caption := 'Urkunde Teilnehmer - Tageswertung'
      else
        TitelLabel.Caption := 'Urkunde Teilnehmer';

      // Klasse
      with KlasseCB do
      begin
        AkPtr := TlnPtr.WertungsKlasse(kwAlle,tmTln);
        Items.AddObject(AkPtr.Name,AkPtr); // immer vorhanden
        AkPtr := TlnPtr.WertungsKlasse(kwSex,tmTln);
        if AkPtr <> AkUnbekannt then
        begin
          Items.AddObject(AkPtr.Name,AkPtr);
          AkPtr := TlnPtr.WertungsKlasse(kwAltKl,tmTln);
          if (AkPtr <> AkUnbekannt) and (AkPtr <> AkMannUnbek) and (AkPtr <> AkFrauUnbek) then
            Items.AddObject(AkPtr.Name,AkPtr);
          AkPtr := TlnPtr.WertungsKlasse(kwSondKl,tmTln);
          if (AkPtr <> AkUnbekannt) and (AkPtr <> AkMannUnbek) and (AkPtr <> AkFrauUnbek) then
            Items.AddObject(AkPtr.Name,AkPtr);
        end;
        // SortKlasse voreinstellen
        if Items.IndexOfObject(HauptFenster.SortKlasse) > 0  then  // nicht Alle/M�nner
          ItemIndex := Items.IndexOfObject(HauptFenster.SortKlasse)
        else // kwAlle
        if (WordUrkAkIndx > 0) and (WordUrkAkIndx < Items.Count) then
          ItemIndex := WordUrkAkIndx
        else
          ItemIndex := 0;
        AkPtr := TAkObj(Items.Objects[ItemIndex]);
        if AkPtr=nil then AkPtr := HauptFenster.SortKlasse;
      end;

      UpdateTlnRang; // Rang abh�ngig von AkPtr

      // Tln-Name
      NameEdit.Text    := TlnPtr.VNameName;

      // Startnummer
      SnrLabel.Visible := true;
      SnrEdit.Visible  := true;
      SnrEdit.Text     := IntToStr(TlnPtr.Snr);
    end
    else // MschAnsicht
    begin
      // Titel
      if Veranstaltung.Serie then
        if HauptFenster.Ansicht = anMschErgSerie then
          TitelLabel.Caption := 'Urkunde Mannschaft - Serienwertung'
        else
          TitelLabel.Caption := 'Urkunde Mannschaft - Tageswertung'
      else
        TitelLabel.Caption := 'Urkunde Mannschaft';

      // Klasse, MschPtr <> nil, mindestens AkAlle und HauptFenster.SortKlasse
      with KlasseCB do
      begin
        Items.AddObject(AkAlle.Name,AkAlle); // immer vorhanden, weil MschAnsicht
        if Veranstaltung.MannschColl.SucheMannschaft(MschPtr.MannschName,MschPtr.Wettk,
                                                     AkMixed,
                                                     MschPtr.MschIndex) <> nil then
          Items.AddObject(AkMixed.Name,AkMixed);
        if Veranstaltung.MannschColl.SucheMannschaft(MschPtr.MannschName,MschPtr.Wettk,
                                                     MschPtr.Wettk.MaennerKlasse[tmMsch],
                                                     MschPtr.MschIndex) <> nil then
          Items.AddObject(MschPtr.Wettk.MaennerKlasse[tmMsch].Name,MschPtr.Wettk.MaennerKlasse[tmMsch]);
        for i:=0 to MschPtr.Wettk.AltMKlasseColl[tmMsch].Count-1 do
          if Veranstaltung.MannschColl.SucheMannschaft(MschPtr.MannschName,MschPtr.Wettk,
                                                       MschPtr.Wettk.AltMKlasseColl[tmMsch][i],
                                                       MschPtr.MschIndex) <> nil then
            Items.AddObject(MschPtr.Wettk.AltMKlasseColl[tmMsch][i].Name,MschPtr.Wettk.AltMKlasseColl[tmMsch][i]);
        if Veranstaltung.MannschColl.SucheMannschaft(MschPtr.MannschName,MschPtr.Wettk,
                                                     MschPtr.Wettk.FrauenKlasse[tmMsch],
                                                     MschPtr.MschIndex) <> nil then
          Items.AddObject(MschPtr.Wettk.FrauenKlasse[tmMsch].Name,MschPtr.Wettk.FrauenKlasse[tmMsch]);
        for i:=0 to MschPtr.Wettk.AltWKlasseColl[tmMsch].Count-1 do
          if Veranstaltung.MannschColl.SucheMannschaft(MschPtr.MannschName,MschPtr.Wettk,
                                                       MschPtr.Wettk.AltWKlasseColl[tmMsch][i],
                                                       MschPtr.MschIndex) <> nil then
            Items.AddObject(MschPtr.Wettk.AltWKlasseColl[tmMsch][i].Name,MschPtr.Wettk.AltWKlasseColl[tmMsch][i]);

        // SortKlasse voreinstellen
        if Items.IndexOfObject(HauptFenster.SortKlasse) > 0  then // muss so sein
          ItemIndex := Items.IndexOfObject(HauptFenster.SortKlasse)
        else
          ItemIndex := 0; // 0 = kwAlle , WordUrkAkIndx nur f�r Tln wegen Anm-Ansicht
        AkPtr := TAkObj(Items.Objects[ItemIndex]);
        if AkPtr=nil then AkPtr := HauptFenster.SortKlasse;
      end;

      UpdateMschDaten; // Rang und Name abh�ngig AkPtr/MschPtr

      SnrLabel.Visible := false;
      SnrEdit.Visible  := false;
    end;
  end
  else // rmSerDrUrk
  begin
    Self.Caption := 'Urkunden mit MS-Word erstellen';
    // Titel
    if HauptFenster.TlnAnsicht then
      if Veranstaltung.Serie then
        if HauptFenster.Ansicht = anTlnErgSerie then
          TitelLabel.Caption := 'Teilnehmer-Urkunden  - Serienwertung'
        else
          TitelLabel.Caption := 'Teilnehmer-Urkunden  - Tageswertung'
      else
        TitelLabel.Caption := 'Teilnehmer-Urkunden'
    else
      if Veranstaltung.Serie then
        if HauptFenster.Ansicht = anMschErgSerie then
          TitelLabel.Caption := 'Mannschafts-Urkunden - Serienwertung'
        else
          TitelLabel.Caption := 'Mannschafts-Urkunden - Tageswertung'
      else
        TitelLabel.Caption := 'Mannschafts-Urkunden';

    WettkLabel.Visible  := false;
    WettkEdit.Visible   := false;
    KlasseLabel.Visible := false;
    KlasseCB.Visible    := false;
    NameLabel.Visible   := false;
    NameEdit.Visible    := false;
    RngLabel.Visible    := false;
    RngEdit.Visible     := false;
    SnrLabel.Visible    := false;
    SnrEdit.Visible     := false;
    DatenPanel.Height   := 48;
    DruckenGB.Caption   := 'Urkunden erstellen'; // plural

    DruckenGB.Top       := DatenPanel.Top + DatenPanel.Height + 23;
    OkButton.Top        := DruckenGB.Top + DruckenGB.Height + 16;
    CancelButton.Top    := OkButton.Top;
    HilfeButton.Top     := OkButton.Top;
    Self.ClientHeight   := OkButton.Top + OkButton.Height + 16;
  end;

  UrkAnzeigenAlt := false; // default drucken
  AnzahlEdit.EditMask := '09;0; ';
  UpdateDruckenGB; // entsprechend UrkAnzeigenAlt

  FeldListe := TStringList.Create; // Header-Felder f�r Word-Urkunde
  FeldListe.Sorted := false;
  FeldListe.CaseSensitive := true;

  ReportSeiteVon        := 1;
  ReportSeiteBis        := 1;
  ReportAnzahlKopien    := 1;
  ReportKopienSortieren := false;

  if UrkMode = rmSerDrUrk then // Liste nur sortieren, damit Zahl angezeigt werden kann
  begin
    if HauptFenster.TlnAnsicht then
    begin
      HauptFenster.ProgressBarInit('Die Teilnehmerliste wird erstellt',Veranstaltung.TlnColl.Count);
      Veranstaltung.TlnColl.ReportSortieren; // TlnColl.Count ProgresBar Steps
      ReportSeiteBis := Veranstaltung.TlnColl.ReportCount;
    end
    else // MschAnsicht
    begin
      HauptFenster.ProgressBarInit('Die Mannschaftsliste wird erstellt',Veranstaltung.MannschColl.Count);
      Veranstaltung.MannschColl.ReportSortieren;
      ReportSeiteBis := Veranstaltung.MannschColl.ReportCount;
    end;
    TitelLabel.Caption := IntToStr(ReportSeiteBis) + ' ' + TitelLabel.Caption;
    HauptFenster.StatusBarClear;
   //HauptFenster.RefreshAnsicht;
  end;

  DefaultDrucker := '';
  // Druckerliste aktualisieren
  // Liste der installierten Drucker kann sich nach Programmstart ge�ndert haben
  Printer.Refresh;
  Printer.PrinterIndex := -1; // setze default printer
  if Printer.PrinterIndex < 0 then
  begin
    TriaMessage('Es wurde kein Drucker installiert.'+#13+
                'Bitte installieren Sie einen Drucker in den Windows-Einstellungen.',
                mtInformation,[mbOk]);
    ReportDrucker := '';
    Exit;
  end;

  DefaultDrucker := Printer.Printers[Printer.PrinterIndex]; // aktualisierter Windows DefaultPrinter

  with DruckerCB do
  begin
    Items.Clear;
    for i:=0 to Printer.Printers.Count-1 do
      Items.Add(Printer.Printers[i]);
    //for i:=0 to RpDev.Printers.Count-1 do
    //  Items.Add(RpDev.Printers[i]);
    // ReportDrucker pr�fen und aktualisieren
    if (ReportDrucker = '' ) or // nicht definiert
       (Printer.Printers.IndexOf(ReportDrucker) < 0) then // nicht vorhanden
      ReportDrucker := DefaultDrucker;
    DruckerCB.ItemIndex := Items.IndexOf(ReportDrucker);
  end;

  if UrkMode = rmSerDrUrk then
  begin
    UrkDokCB.HelpContext     := 2704;
    UrkDateiBtn.HelpContext  := 2704;
    WettkEdit.HelpContext    := 2701;
    KlasseCB.HelpContext     := 2702;
    UrkDrRB.HelpContext      := 2703;
    UrkWordRB.HelpContext    := 2703;
    OkButton.HelpContext     := 2706;
    CancelButton.HelpContext := 2705;
  end else
  begin
    UrkDokCB.HelpContext     := 2753;
    UrkDateiBtn.HelpContext  := 2753;
    WettkEdit.HelpContext    := 2751;
    KlasseCB.HelpContext     := 2752;
    UrkDrRB.HelpContext      := 2761;
    UrkWordRB.HelpContext    := 2761;
    OkButton.HelpContext     := 2756;
    CancelButton.HelpContext := 2755;
  end;
  //NameEdit.HelpContext := 2758;
  //RngEdit.HelpContext  := 2760;
  //SnrEdit.HelpContext  := 2759;

  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);

end;

//==============================================================================
destructor TUrkundeDialog.Destroy;
//==============================================================================
begin
  FeldListe.Free;
  HelpFenster := HelpFensterAlt;
  inherited Destroy;
end;

//------------------------------------------------------------------------------
procedure TUrkundeDialog.UpdateTlnRang;
//------------------------------------------------------------------------------
// AkPtr gesetzt und <> nil
begin
  if HauptFenster.Ansicht=anTlnErgSerie then
    RngEdit.Text := TlnPtr.GetSerieRangStr(AkPtr.Wertung)
  else
    RngEdit.Text := TlnPtr.TagesEndRngStr(wkAbs0,AkPtr.Wertung,HauptFenster.SortWrtg);
end;

//------------------------------------------------------------------------------
procedure TUrkundeDialog.UpdateMschDaten;
//------------------------------------------------------------------------------
// AkPtr gesetzt und <> nil
begin
  MschPtr := Veranstaltung.MannschColl.SucheMannschaft(MschPtr.MannschName,MschPtr.Wettk,
                                                       AkPtr,
                                                       MschPtr.MschIndex);
  if MschPtr = nil then
    MschPtr := TlnPtr.MannschPtr(HauptFenster.SortKlasse.Wertung);

  if MschPtr.MschIndex > 1 then
    NameEdit.Text := MschPtr.Name + '~' + IntToStr(MschPtr.MschIndex)
  else
    NameEdit.Text := MschPtr.Name;

  if HauptFenster.Ansicht=anMschErgSerie then
    RngEdit.Text := MschPtr.GetSerieRangStr
  else
    if (MschPtr.Wettk.MschWertg = mwMulti) and (MschPtr.MschIndex=0) and // nur Startliste
       (MschPtr.Msch1 <> nil) then
      RngEdit.Text := MschPtr.Msch1.TagesRngStr // MschPtr.Rng = 0
    else
      RngEdit.Text := MschPtr.TagesRngStr;
end;

//------------------------------------------------------------------------------
procedure TUrkundeDialog.UpdateDruckenGB;
//------------------------------------------------------------------------------
var UpdatingAlt : Boolean;
begin
  UpdatingAlt := Updating;
  Updating := true;
  try
    if UrkDokCB.ItemIndex = 0 then // cnNeu, immer Word anzeigen
    begin
      UrkDrRB.Enabled   := false;
      UrkDrRB.Checked   := false;
    end else // >0 oder -1
    begin
      UrkDrRB.Enabled   := true;
      if UrkAnzeigenAlt then // UrkAnzeigenAlt unver�ndert, nur bei Click �ndern
        UrkDrRB.Checked   := false
      else
        UrkDrRB.Checked   := true;
    end;

    if not UrkDrRB.Enabled or not UrkDrRB.Checked then
      UrkWordRB.Checked := true
    else UrkWordRB.Checked := false;

    if UrkDrRB.Checked then
    begin
      DruckerCB.Enabled    := true;
      DruckerBtn.Enabled   := true;
      AnzahlLabel.Enabled  := true;
      AnzahlEdit.Enabled   := true;
      AnzahlUpDown.Enabled := true;
      AnzahlUpDown.Min     := 1;
      AnzahlUpDown.Max     := cnUrkMax;
      AnzahlEdit.Text      := '1';
    end else
    begin
      DruckerCB.Enabled    := false;
      DruckerBtn.Enabled   := false;
      AnzahlLabel.Enabled  := false;
      AnzahlEdit.Enabled   := false;
      AnzahlUpDown.Enabled := false;
      AnzahlUpDown.Min     := 1;
      AnzahlUpDown.Max     := 1;
      AnzahlEdit.Text      := '1';
    end;

  finally
    Updating := UpdatingAlt;
  end;
end;

//------------------------------------------------------------------------------
function TUrkundeDialog.DokIndx(DokName: String): Integer;
//------------------------------------------------------------------------------
var i : Integer;
begin
  Result := - 1;
  if StrGleich(DokName,'') then Exit;
  with UrkDokCB do
    for i:=1 to Items.Count-1 do // 1. Item nicht ber�cksichtigen (neues Hauptdok)
      if StrGleich(DokName,Items[i]) then
      begin
        Result := i;
        Exit;
      end;
end;

//------------------------------------------------------------------------------
procedure TUrkundeDialog.UpdateDokCB(DokName: String);
//------------------------------------------------------------------------------
// Text-Pfad an 1. Pos. in Liste
// DokName <> '' : neues UrkHauptDok erstellt
var i : Integer;
    DokNeu : String;
    UpdatingAlt : Boolean;
begin
  UpdatingAlt := Updating;
  Updating := true;
  try

    DokNeu := '';
    with UrkDokCB do
    begin
      if Trim(DokName) <> '' then DokNeu := Trim(DokName) // neues UrkHauptDok erstellt oder gew�hlt
      else
      if (ItemIndex > 1) or (ItemIndex = 0) and // Index ge�ndert, Dok an Pos. 1 schieben
         (Trim(Text) <> Items[ItemIndex]) then  // UrkDok-Text ge�ndert, Text �bernehmen, vorher gepr�ft
        DokNeu := Trim(Text)
      else
        Exit; // keine �nderung

      // pr�fen ob DokNeu bereits vorhanden ist
      i := DokIndx(DokNeu);
      if i < 0 then // noch nicht in Liste
      begin
        if Items.Count >= cnUrkDokListeMax then
          Items.Delete(Items.Count-1);
        Items.Insert(1,DokNeu); // nach cnNeu einf�gen
      end else
      // i=1 keine Aktion (i=0 kommt nicht vor)
      if i > 1 then // DokNeu in Liste vorhanden, aber nicht an Pos.1
      begin
        Items.Delete(i);
        Items.Insert(1,DokNeu); // nach cnNeu einf�gen
      end;

      if Items.Count > 1 then
        ItemIndex := 1 // UrkDokCB.Text wird gesetzt
      else
      if Items.Count = 1 then
        ItemIndex := 0; // UrkDokCB.Text wird gesetzt
    end;

    UpdateDruckenGB;

  finally
    Updating := UpdatingAlt;
  end;

end;

//------------------------------------------------------------------------------
procedure TUrkundeDialog.UpdateDokListe;
//------------------------------------------------------------------------------
var i : Integer;
begin
  UrkDokListe.Clear;
  for i:=1 to UrkDokCB.Items.Count-1 do
    UrkDokListe.Add(UrkDokCB.Items[i]);
end;

//------------------------------------------------------------------------------
function TUrkundeDialog.UebernehmeUrkDaten: Boolean;
//------------------------------------------------------------------------------
// SerDr-Parameter setzen
begin
  Result := false;

  if UrkDokCB.ItemIndex = 0 then // neues UrkHauptDok erstellen
  begin
    UrkHauptDokNeu  := true;
    UrkHauptDokPfad := '';
  end
  else // bestehendes UrkHauptDok verwenden
  begin
    UrkHauptDokNeu  := false;
    UrkHauptDokPfad := Trim(UrkDokCB.Text);
    if UrkHauptDokPfad = '' then
    begin
      TriaMessage(Self,'Kein Urkunde-Hauptdokument eingetragen.',
                  mtInformation,[mbOk]);
      UrkDokCB.SetFocus;
      Exit;
    end else
    if not FileExists(UrkHauptDokPfad) then
    begin
      TriaMessage(Self,'Das Urkunde-Hauptdokument  "'+ExtractFileName(UrkHauptDokPfad)+
                  '"  wurde nicht gefunden.',
                  mtInformation,[mbOk]);
      Exit;
    end else
    if FileInUse(UrkHauptDokPfad) then
    begin
      TriaMessage(Self,'Das Urkunde-Hauptdokument  "'+ExtractFileName(UrkHauptDokPfad)+
                  '"  ist bereits ge�ffnet.' +#13+
                  'Bitte schliessen Sie das Dokument, damit die Urkunde erstellt werden kann.',
                  mtInformation,[mbOk]);
      Exit;
    end;
    UpdateDokCB(''); // UrkHauptDokPfad an Pos.1
  end;

  // gew�hlte Klasse �bernehmen
  if (UrkMode = rmWordUrk) and (AkPtr = nil) then
  begin
    TriaMessage(Self,'Keine Klasse gew�hlt.',mtInformation,[mbOk]);
    Exit;
  end;

  if HauptFenster.TlnAnsicht then
  begin
    AbsMax          := AbsMaxBerechnen;
    MschTlnWertgMax := 0;
    MschTlnStartMax := 0;
    EinfachTlnMax   := EinfachTlnMaxBerechnen; // max 8 Tln
  end else
  begin
    AbsMax          := wkAbs0;
    MschTlnWertgMax := MschTlnWertgMaxBerechnen;  // Max 16 Tln
    MschTlnStartMax := MschTlnStartMaxBerechnen;  // Max 16 Tln
    EinfachTlnMax := 0;
  end;
  RndRennenSetzen;

  if HauptFenster.TlnAnsicht then
    WordUrkAkIndx := KlasseCB.ItemIndex;

  // Drucker �bernehmen und nochmals pr�fen
  if UrkDrRB.Checked then
  begin
    if not AnzahlEdit.ValidateEdit then Exit;
    ReportAnzahlKopien := StrToIntDef(AnzahlEdit.Text,1);

    if DruckerCB.ItemIndex < 0 then
    begin
      TriaMessage(Self,'Es wurde kein Drucker ausgew�hlt.',mtInformation,[mbOk]);
      Exit;
    end;
    ReportDrucker := DruckerCB.Items[DruckerCB.ItemIndex];
    // ReportDrucker als Systemdrucker einstellen f�r Word
    if not StrGleich(DefaultDrucker,ReportDrucker) then
    begin
      SetWindowsStandardDrucker(ReportDrucker);
      // WindowsStandard in Printer �bernehmen
      Printer.Refresh;
      Printer.PrinterIndex := -1; // setze default printer
      // pr�fen ob erfolgreich
      if not StrGleich(Printer.Printers[Printer.PrinterIndex],ReportDrucker) then
      begin
        TriaMessage(Self,'Drucker "'+ReportDrucker + '" konnte nicht als Systemdrucker f�r Windows eingestellt werden.',
                         mtInformation,[mbOk]);
        Exit;
      end;
    end;
  end;

  Result := true;
end;

//------------------------------------------------------------------------------
function TUrkundeDialog.QuellDateiErstellen: Boolean;
//------------------------------------------------------------------------------
var BufStr,S: String;
    i,WkNr,UrkRow : Integer;
    Header : String;
    RepWk  : TReportWkObj;
    wrdDataDoc : Variant;

//..............................................................................
function SchreibeZeile(Txt:String): Boolean;
// HeaderZeile: Row=1 bereits geschrieben
// Datenzeile: ab Row=2
// Row in UrkRow definiert
var i,Col : Integer;
    S : String;
begin
  Result := false;
  if Txt <> '' then // Result=true wenn Txt=''
  try
    if wrdDataDoc.Tables.Item(1).Rows.Count < UrkRow  then
      wrdDataDoc.Tables.Item(1).Rows.Add;
    // Daten einf�gen
    Col := 0;
    while Length(Txt) > 0 do
    begin
      Inc(Col);
      i := Pos(TZ,Txt);
      if i > 1 then // Feld und TZ und vorhanden
      begin
        S := Copy(Txt,1,i-1);  //
        Delete(Txt,1,i); // Feld + TZ l�schen
      end else
      if i = 0 then // letztes Feld ohne TZ
      begin
        S := Copy(Txt,1,Length(Txt));
        Txt := ''; // letztes Feld l�schen
      end else  // i = 1, leeres Feld vor TZ: sollte nicht vorkommen
        Break;
      wrdDataDoc.Tables.Item(1).Cell(UrkRow,Col).Range.InsertAfter(S);
    end;
  except
    // keine Exception-Fehlermeldung
    Exit;
  end;
  Result := true;
end;

//..............................................................................
begin
  Result := false;
  UrkAnzahl := 0;

  UrkDataDokPfad := ChangeFileExt(UrkHauptDokPfad,'~data.doc');

  if FileExists(UrkDataDokPfad) and not DeleteFile(UrkDataDokPfad) then
  begin
    TriaMessage(Self,'Die Daten-Quelldatei  "'+ExtractFileName(UrkDataDokPfad)+'"  '+
                'kann nicht erstellt werden,'+
                'weil eine Datei mit diesem Namen bereits vorhanden ist und nicht gel�scht werden kann.',
                mtInformation,[mbOk]);
    Exit; // keine weitere Fehlermeldung
  end;

  try
    // Header, nur Unterschied Tln/Msch sonst f�r alle Ansichten gleich
    if HauptFenster.TlnAnsicht then
      Header := ZeileTlnWertung(sdWord,nil)
    else
      Header := ZeileMschWertung(sdWord,nil);
    if Header = '' then Exit;

    // Header-Feldliste f�r sp�tere Pr�fung UrkHauptDok in UrkDokErstellen
    FeldListe.Clear;
    BufStr := Header;
    while Length(BufStr) > 0 do
    begin
      i := Pos(TZ,BufStr);
      if i > 1 then // Feld und TZ und vorhanden
      begin
        S := Copy(BufStr,1,i-1);  //
        Delete(BufStr,1,i); // Feld + TZ l�schen
      end else
      if i = 0 then // letztes Feld ohne TZ
      begin
        S := Copy(BufStr,1,Length(BufStr));
        BufStr := ''; // letztes Feld l�schen
      end else  // i = 1, leeres Feld vor TZ: sollte nicht vorkommen
        Exit;
      FeldListe.Add(S);
    end;
    if FeldListe.Count < 2 then Exit;

    HauptFenster.ProgressBarStep(10); // 50% Position

    try
      // Create a data source containing the field data (Tabelle mit Header + Leerzeile)
      // wenn falsche Feldname in IF-Statement, dann h�lt Word an mit einer Fehlermeldung.
      // diese kann hinter Tria verborgen sein und ist dann nicht erkennbar und somit
      // h�ngt alles
      wrdDoc.MailMerge.CreateDataSource(UrkDataDokPfad,EmptyParam,EmptyParam,Header);
      // Open the file to insert data
      wrdDataDoc := wrdApp.Documents.Open(UrkDataDokPfad);
    except
      // keine Exception-Fehlermeldung
      Exit;
    end;

    HauptFenster.ProgressBarStep(10); // 60% Position

    //Datenzeilen
    UrkRow := 2; // 1. Zeile nach Header, in SchreibeZeile benutzt
    if UrkMode = rmWordUrk then // Einzel, nur 1x DatenZeile
    begin
      if HauptFenster.TlnAnsicht then
        if not SchreibeZeile(ZeileTlnWertung(sdWord,TlnPtr,TlnPtr.Wettk,HauptFenster.SortWrtg,AkPtr)) then Exit
        else
      else
        if not SchreibeZeile(ZeileMschWertung(sdWord,MschPtr)) then Exit;
      HauptFenster.ProgressBarStep(20); // 80% Position
      UrkRow := 3; // UrkAnzahl := 1
    end else // rmSerDrUrk
    begin
      // Urkunden entspr. SortMode sortiert, Wettk�mpfe nacheinander enspr. ReportWkListe
      for WkNr:=0 to ReportWkListe.Count-1 do // Anfang bei WkNr=0
      begin
        RepWk := ReportWkListe[WkNr];
        if HauptFenster.TlnAnsicht then
        begin
          // BarPos erhalten, BarMax anpassen, damit beim Sortieren in Summe �ber Wk BarPos von 60 nach 70% erh�ht wird
          HauptFenster.ProgressBarMaxUpdate(Veranstaltung.TlnColl.Count * (ReportWkListe.Count*4 - WkNr*2));
          Veranstaltung.TlnColl.ReportSortieren(RepWk.Wettk,RepWk.Wrtg); // TlnColl.Count ProgresBar Steps
          // BarPos erhalten, BarMax anpassen, damit beim Schreiben in Summe �ber Wk BarPos von 70 nach 80% erh�ht wird
          HauptFenster.ProgressBarMaxUpdate(Veranstaltung.TlnColl.ReportCount * (ReportWkListe.Count*4 - 1 - WkNr*2));
          for i:=0 to Veranstaltung.TlnColl.ReportCount-1 do
          with Veranstaltung.TlnColl.ReportItems[i] do
          begin
            if TlnPtr.UrkDruck then
            begin
              if not SchreibeZeile(ZeileTlnWertung(sdWord,TlnPtr,ReportWk,ReportWrtg,ReportAk)) then Exit;
              HauptFenster.ProgressBarText('Die Daten-Quelldatei wird erstellt ('+IntToStr(UrkRow-1)+')');
              Inc(UrkRow);
            end;
            HauptFenster.ProgressBarStep(1);
          end;
        end
        else // MschAnsicht
        begin
          // BarPos erhalten, BarMax anpassen, damit beim Sortieren in Summe �ber Wk BarPos von 60 nach 70% erh�ht wird
          HauptFenster.ProgressBarMaxUpdate(Veranstaltung.MannschColl.Count * (ReportWkListe.Count*4 - WkNr*2));
          Veranstaltung.MannschColl.ReportSortieren(RepWk.Wettk);
          // BarPos erhalten, BarMax anpassen, damit beim Schreiben in Summe �ber Wk BarPos von 70 nach 80% erh�ht wird
          HauptFenster.ProgressBarMaxUpdate(Veranstaltung.MannschColl.ReportCount * (ReportWkListe.Count*4 - 1 - WkNr*2));
          for i:=0 to Veranstaltung.MannschColl.ReportCount-1 do
          begin
            if not SchreibeZeile(ZeileMschWertung(sdWord,Veranstaltung.MannschColl.ReportItems[i].MschPtr)) then Exit;
            HauptFenster.ProgressBarText('Die Daten-Quelldatei wird erstellt ('+IntToStr(UrkRow-1)+')');
            Inc(UrkRow);
            HauptFenster.ProgressBarStep(1);
          end;
        end;
      end;
    end;

    UrkAnzahl := UrkRow - 2;
    Result := true;

  finally
    if Result then wrdDataDoc.Save
    else
      TriaMessage(Self,'Die Daten-Quelldatei  "'+ExtractFileName(UrkDataDokPfad)+'"  '+
                  'kann nicht erstellt werden.',
                  mtInformation,[mbOk]);
    wrdDataDoc.Close(False);  // sonst funktioniert Merge nicht
  end;

end;

//------------------------------------------------------------------------------
function TUrkundeDialog.UrkHauptDokErstellen: Boolean;
//------------------------------------------------------------------------------
var
    Dir,Pfad : String;
    UrkHauptDokName : String;
    wrdSelection, wrdMailMerge, wrdMergeFields{, wrdDataDoc} : Variant;
    wrdAppGestartet,wrdDocGeOeffnet : Boolean;
begin
  Result := false;
  wrdAppGestartet := false;
  wrdDocGeOeffnet := false;

  HauptFenster.ProgressBarInit('Microsoft Word wird gestartet',100);
  HauptFenster.ProgressBarStep(10); // 10% Position

  try

    try
      wrdApp := CreateOleObject('Word.Application'); // neuer Instanz von Word erstellen
      // hier kann Meldung kommen, wenn Word nicht als Standard zum �ffnen definiert wurde
      // diese muss vom Anwender geschlossen werden, sonst kann Dok nicht erstellt werden
      wrdAppGestartet := true;
      wrdApp.Visible := false;
      wrdApp.DisplayAlerts := 0; // Meldungen unterdr�cken
    except
      TriaMessage(Self,'Microsoft Word kann nicht gestartet werden.',
                   mtInformation,[mbOk]);
      Exit;
    end;

    if HauptFenster.TlnAnsicht then
      UrkHauptDokName := 'TlnUrk_HauptDok'
    else
      UrkHauptDokName := 'MschUrk_HauptDok';

    Dir  := ExtractFileDir(TriDatei.Path);
    Pfad := Dir + '\' + UrkHauptDokName + '.doc';
    if not SaveFileDialog('doc',
                          'MS-Word Dokumente (*.doc, *.docx)|*.doc;*.docx',
                          Dir,
                          'Urkunde-Hauptdokument speichern',
                          Pfad) then Exit;
    if FileInUse(Pfad) then
    begin
      TriaMessage(Self,'Das Urkunde-Hauptdokument  "'+ExtractFileName(Pfad)+
                  '"  ist bereits ge�ffnet.' +#13+
                  'Bitte schliessen Sie das Dokument, damit die Urkunde erstellt werden kann.',
                  mtInformation,[mbOk]);
      Exit;
    end;
    UrkHauptDokPfad := Pfad;
    HauptFenster.ProgressBarStep(20); // 20% Position

    try
      // Neues UrkHauptDok erstellen
      wrdDoc := wrdApp.Documents.Add();
      wrdDocGeOeffnet := true;
      wrdDoc.Select;
      wrdDoc.SaveAs(UrkHauptDokPfad);
      wrdSelection := wrdApp.Selection;
      wrdMailMerge := wrdDoc.MailMerge;
    except
      TriaMessage(Self,'Das neue Urkunde-Hauptdokument  "'+ExtractFileName(UrkHauptDokPfad)+
                  '"  kann nicht erstellt werden.',
                  mtInformation,[mbOk]);
      Exit;
    end;

    HauptFenster.ProgressBarStep(20); // 40% Position
    HauptFenster.ProgressBarText('Die Daten-Quelldatei wird erstellt');

    // Daten-Quelldate erstellen
    if not QuellDateiErstellen then Exit; // keine weitere Fehlermeldung
    // ProgressBar + 20
    wrdMailMerge.MainDocumentType := wdFormLetters; // ist bereits eingestellt

    try

      HauptFenster.ProgressBarStep(20); // 80% Position
      HauptFenster.ProgressBarText('Das neue Urkunde-Hauptdokument wird erstellt');

      //wrdApp.Visible := True;
      wrdMergeFields := wrdMailMerge.Fields;

      // Text und Felder in UrkHauptDok einf�gen
      wrdSelection.Font.Name := 'Segoe UI';
      wrdSelection.Font.Size := 8;
      wrdSelection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
      wrdSelection.TypeParagraph;
      wrdSelection.Font.Size := 72;
      wrdSelection.Font.Bold := True;
      wrdSelection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
      wrdSelection.TypeText('URKUNDE');

      wrdSelection.Font.Size := 28;
      wrdSelection.TypeParagraph;
      wrdSelection.TypeParagraph;
      wrdSelection.Font.Size := 36;
      wrdMergeFields.Add(wrdSelection.Range,'Veranst');

      wrdSelection.Font.Size := 28;
      wrdSelection.TypeParagraph;
      wrdSelection.TypeParagraph;
      wrdMergeFields.Add(wrdSelection.Range,'Wettk');
      wrdSelection.TypeParagraph;

      wrdSelection.Font.Size := 28;
      wrdSelection.TypeParagraph;
      wrdMergeFields.Add(wrdSelection.Range,'Wertg');

      if HauptFenster.TlnAnsicht then
      begin
        // TlnUrk_HauptDok
        wrdSelection.Font.Size := 24;
        wrdSelection.TypeParagraph;
        wrdSelection.TypeText('in ');
        if Veranstaltung.Serie then
          wrdMergeFields.Add(wrdSelection.Range,'VstOrt')
        else
          wrdSelection.TypeText('"Ortsname"');
        wrdSelection.TypeText(' am ');
        wrdMergeFields.Add(wrdSelection.Range,'Datum');

        wrdSelection.Font.Size := 36;
        wrdSelection.TypeParagraph;
        wrdSelection.TypeParagraph;
        wrdMergeFields.Add(wrdSelection.Range,'Name');
        wrdSelection.Font.Size := 26;
        wrdSelection.TypeParagraph;
        wrdMergeFields.Add(wrdSelection.Range,Veranstaltung.MschSpalteName(WettkAlleDummy));
        wrdSelection.Font.Size := 20;
        wrdSelection.TypeParagraph;
        wrdSelection.TypeParagraph;
        wrdSelection.TypeText('belegte den ');
        wrdMergeFields.Add(wrdSelection.Range,'Rng');
        wrdSelection.TypeText('. Platz');
        wrdSelection.TypeParagraph;
        wrdSelection.TypeText('in der Klasse ');
        wrdMergeFields.Add(wrdSelection.Range,'Klasse');
        wrdSelection.Font.Size := 8;
        wrdSelection.TypeParagraph;
      end
      else // MschAnsicht
      begin
        // MschUrk_HauptDok
        wrdSelection.Font.Size := 24;
        wrdSelection.TypeParagraph;
        wrdSelection.TypeText('in ');
        wrdMergeFields.Add(wrdSelection.Range,'VstOrt');
        wrdSelection.TypeText(' am ');
        wrdMergeFields.Add(wrdSelection.Range,'Datum');
        wrdSelection.Font.Size := 36;
        wrdSelection.TypeParagraph;
        wrdSelection.TypeParagraph;
        wrdSelection.TypeParagraph;
        wrdMergeFields.Add(wrdSelection.Range,'Mannschaft');
        wrdSelection.Font.Size := 20;
        wrdSelection.TypeParagraph;
        wrdSelection.TypeParagraph;
        wrdSelection.TypeText('belegte den ');
        wrdMergeFields.Add(wrdSelection.Range,'Rng');
        wrdSelection.TypeText('. Platz');
        wrdSelection.TypeParagraph;
        wrdSelection.TypeText('in der Klasse ');
        wrdMergeFields.Add(wrdSelection.Range,'Klasse');
        wrdSelection.Font.Size := 8;
        wrdSelection.TypeParagraph;
      end;

      wrdApp.Visible := True;

      HauptFenster.ProgressBarStep(10); // 90% Position
      HauptFenster.ProgressBarText('Das neue Urkunde-Hauptdokument wird gespeichert');

      wrdDoc.Save;

    except
      TriaMessage(Self,'Das neue Urkunde-Hauptdokument  "'+ExtractFileName(UrkHauptDokPfad)+
                  '"  kann nicht erstellt werden.',
                  mtInformation,[mbOk]);
      Exit;
    end;

    HauptFenster.ProgressBarStep(10); // 100% Position
    HauptFenster.ProgressBarText('Das neue Urkunde-Hauptdokument wurde erfolgreich gespeichert');

    UpdateDokCB(UrkHauptDokPfad);
    Result := true;  // Dialog schliessen

  finally
    // wrdApp und wrdDoc nicht schliessen
    // UrkDataDokPfad nicht l�schen, wird immer �berschrieben
    HauptFenster.StatusBarClear;
    if Result then
      TriaMessage(Self,'Das neue Urkunde-Hauptdokument  "'+ExtractFileName(UrkHauptDokPfad)+'"' +#13+
                  'und die entsprechende Daten-Quelldatei  "'+ExtractFileName(UrkDataDokPfad)+'"' +#13+
                  'wurden erfolgreich erstellt.'+#13+#13+
                  'Dieses Hauptdokument ist nur ein einfaches Beispiel.'+#13+
                  'Text und Seriendruckfelder k�nnen in Word bearbeitet werden. '+
                  'Auf der Registerkarte Sendungen k�nnen weitere Seriendruckfelder eingef�gt und '+
                  'das Ergebnis unter Vorschau angezeigt werden.',
                  mtInformation,[mbOk])
    else
      if wrdAppGestartet then
      begin
        if wrdDocGeOeffnet then
        try
          wrdDoc.Saved := True;  // wrdDoc im Fehlerfall schliessen
          wrdDoc.Close(False);   // sonst Fehlermeldung bei Quit
        except
          // weitere Fehlermeldung vermeiden
        end;
        wrdApp.Quit;  // Word im Fehlerfall schliessen
      end;
  end;

end;

//------------------------------------------------------------------------------
function TUrkundeDialog.UrkDokErstellen: Boolean;
//------------------------------------------------------------------------------
var wrdSelection, wrdMailMerge : Variant;
    i : Integer;
    S : String;
    wrdAppGestartet,wrdDocGeOeffnet : Boolean;
    FirstTickCount : DWord;

//..............................................................................
function FeldVorhanden(Feld:String): Boolean;
// nur g�ltige Seriendruckfelder pr�fen
var j : Integer;
    S : String;
begin
  if (Length(Feld) > 2) and Assigned(FeldListe) and
     (Feld[1] = '�') and (Feld[Length(Feld)] = '�') then // g�ltiges Seriendruckfeld
  begin
    Result := false;
    S := Copy(Feld,2,Length(Feld)-2); // Feldname z.B. '�Veranstaltung�'
    for j:=0 to FeldListe.Count-1 do
      if S = FeldListe[j] then
      begin
        Result := true;
        Exit;
      end;
  end else // z.B. IF-Verkn�pfung immer akzeptieren
    Result := true;
end;

//..............................................................................
begin
  Result := false;
  wrdAppGestartet := false;
  wrdDocGeOeffnet := false;

  HauptFenster.ProgressBarInit('Microsoft Word wird gestartet',100);
  HauptFenster.ProgressBarStep(10); // 10% Position

  try

    try
      // neuer Instanz von Word erstellen
      wrdApp := CreateOleObject('Word.Application');
      wrdAppGestartet := true;
      wrdApp.Visible := false;
      wrdApp.DisplayAlerts := 0; // Meldungen unterdr�cken
    except
      TriaMessage(Self,'Microsoft Word kann nicht gestartet werden.',
                   mtInformation,[mbOk]);
      Exit;
    end;

    HauptFenster.ProgressBarStep(10); // 20% Position
    HauptFenster.ProgressBarText('Das Urkunde-Hauptdokument wird ge�ffnet');

    try
      // UrkHauptDok �ffnen
      // UrkHauptDokPfad vorher in UebernehmeDaten gesetzt und gepr�ft
      wrdDoc := wrdApp.Documents.Open(UrkHauptDokPfad);
      wrdDocGeOeffnet := true;
      wrdDoc.Select;
      wrdSelection := wrdApp.Selection;
      //wrdApp.Visible := true;
      wrdMailMerge := wrdDoc.MailMerge;
    except
      TriaMessage(Self,'Das Urkunde-Hauptdokument  "'+ExtractFileName(UrkHauptDokPfad)+
                  '"  kann nicht ge�ffnet werden.',
                  mtInformation,[mbOk]);
      Exit;
    end;

    HauptFenster.ProgressBarStep(20); // 40% Position
    HauptFenster.ProgressBarText('Die Daten-Quelldatei wird erstellt');

    // Daten-Quellddatei erstellen (UrkDataDokPfad)
    if not QuellDateiErstellen then Exit; // keine weitere Fehlermeldung

    HauptFenster.ProgressBarText('Die Urkunde wird erstellt');  // 80%
    wrdMailMerge.MainDocumentType := wdFormLetters; // ist bereits eingestellt

    // Felder pr�fen um Fehlermeldung in MailMerge zu vermeiden
    for i:=1 to wrdDoc.Fields.Count do
    begin
      S := wrdDoc.Fields.Item(i).Result.Text;
      if not FeldVorhanden(S) then
      begin
        TriaMessage(Self,'Das Urkunden-Feld  "'+ S + '" ist in der Daten-Quelldatei nicht vorhanden.'+#13+
                    'Die Urkunde kann nicht erstellt werden.',
                    mtInformation,[mbOk]);
        Exit;
      end;
    end;


    // Perform mail merge
    try
      wrdMailMerge.Destination := wdSendToNewDocument;
      wrdMailMerge.Execute(False);
    except
      TriaMessage(Self,'Die Urkunde kann nicht erstellt werden.',
                  mtInformation,[mbOk]);
      Exit;
    end;

    // Daten-Quellddatei erstellen (UrkDataDokPfad)
    wrdDoc.Saved := True;
    wrdDoc.Close(False);

    // Urkunde mit eingetragenen Daten �ffnen (Serienbriefe 1)
    wrdDoc := wrdApp.ActiveDocument;
    //wrdDoc.Select; sonst werden alle Felder werden sektiert

    HauptFenster.ProgressBarMaxUpdate(20);
    HauptFenster.ProgressBarStep(10); // 90% Position
    if UrkWordRB.Checked then // Urkunde in Word �ffnen
    begin
      wrdApp.Visible := true;
      HauptFenster.ProgressBarStep(10); // 100% Position
    end
    else
    // Urkunde drucken, Drucker vorher eingestellt
    begin
      HauptFenster.ProgressBarText('Die Urkunde wird gedruckt');
      for i:=1 to ReportAnzahlKopien do
        wrdDoc.PrintOut(false); // false: wait until the print file has been spooled to the printer queue
      HauptFenster.ProgressBarStep(5); // 95% Position
      // 1 Sek Pause vor wrdApp.Quit, sollte eigentlich nicht n�tig sein
      FirstTickCount := GetTickCount;
      while ((GetTickCount - FirstTickCount) < 1000) do // 1000 Sec
        Application.ProcessMessages;
      HauptFenster.ProgressBarStep(5); // 100% Position
      wrdDoc.Saved := True;
      wrdDoc.Close(false);
      wrdApp.Quit;
      // UrkDataDokPfad nicht l�schen, wird immer �berschrieben
    end;

    // Windows Standard-Drucker wieder zur�cksetzen, falls in UebernehmeUrkDaten ge�ndert
    if UrkDrRB.Checked and not StrGleich(DefaultDrucker,ReportDrucker) then
      SetWindowsStandardDrucker(DefaultDrucker);

    Result := true; // Dialog schliessen

  finally
    HauptFenster.StatusBarClear;
    if not Result and wrdAppGestartet then
    begin
      if wrdDocGeOeffnet then
      try
        wrdDoc.Saved := True;  // wrdDoc im Fehlerfall schliessen
        wrdDoc.Close(False);   // sonst Fehlermeldung bei Quit
      except
        // weitere Fehlermeldung vermeiden
      end;
      wrdApp.Quit;  // Word im Fehlerfall schliessen
    end;
  end;

end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TUrkundeDialog.UrkDokLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if UrkDokCB.CanFocus then UrkDokCB.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TUrkundeDialog.UrkDateiBtnClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var Dir,DokName : String;
    FilterIndx : Integer;
begin
  Dir := ExtractFileDir(Trim(UrkDokCB.Text));
  if Dir = '' then Dir := ExtractFileDir(TriDatei.Path);
  FilterIndx := 1; // nur Word Dokumente
  DokName := '';
  UrkundeDialog.DeActivate;
  if OpenFileDialog('*', // ohne Punkt
                    'MS-Word Dokumente (*.doc, *.docx)|*.doc;*.docx',
                    Dir,
                    FilterIndx,
                    'Urkunde-Hauptdokument �ffnen',
                    DokName) then
    UpdateDokCB(Trim(DokName));
  UrkundeDialog.Activate;
  ActiveControl := OkButton;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TUrkundeDialog.UrkDokCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Text-�nderung nicht ber�cksichtigen
begin
  if not Updating then
  begin
    if UrkDokCB.ItemIndex = 0 then
      UrkDokCB.Style := csDropDownList // keine Text-�nderung m�glich
    else
      UrkDokCB.Style := csDropDown;
    UpdateDruckenGB;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TUrkundeDialog.KlasseCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Klasse einstellbar
var AkBuff : TAkObj;
begin
  if not Updating then
  begin
    Updating := true;

    AkBuff := TAkObj(KlasseCB.Items.Objects[KlasseCB.ItemIndex]);
    if AkBuff=nil then
      TriaMessage(Self,'Keine Klasse gew�hlt.',mtInformation,[mbOk])
    else
    begin
      AkPtr := AkBuff;
      if HauptFenster.TlnAnsicht then
        UpdateTlnRang
      else
        UpdateMschDaten;
    end;

    Updating := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TUrkundeDialog.UrkundeGBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then
  begin
    Updating := true;
    UrkAnzeigenAlt := not UrkDrRB.Checked;
    UpdateDruckenGB;
    Updating := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TUrkundeDialog.DruckerBtnClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var Idx : Integer;
begin
  Printer.Refresh;
  Idx := DruckerCB.ItemIndex;
  if (Idx < 0) or
     (Printer.Printers.IndexOf(DruckerCB.Items[Idx]) < 0) then
  begin
    TriaMessage(Self,'Kein g�ltiger Drucker gew�hlt.',mtInformation,[mbOk]);
    Exit;
  end else
    Printer.PrinterIndex := Printer.Printers.IndexOf(DruckerCB.Items[Idx]);

  with PrintDialog do
  begin
    Options    := [];// poPageNums, poSelection
    FromPage   := 1;
    MinPage    := 1;
    ToPage     := 1;
    MaxPage    := 1;
    Copies     := StrToIntDef(AnzahlEdit.Text,1);
    Collate    := false;
    PrintRange := prAllPages;

    if Execute then
    begin
      // Liste noch mal aktualisieren
      with DruckerCB do
      begin
        Items.Clear;
        for Idx:=0 to Printer.Printers.Count-1 do
          Items.Add(Printer.Printers[Idx]);
      end;
      Idx := Printer.PrinterIndex;
      if (Idx < 0) or
         (DruckerCB.Items.IndexOf(Printer.Printers[Idx]) < 0) then
      begin
        TriaMessage(Self,'Kein g�ltiger Drucker gew�hlt.',mtInformation,[mbOk]);
        Exit;
      end;
      DruckerCB.ItemIndex := DruckerCB.Items.IndexOf(Printer.Printers[Idx]);
      AnzahlEdit.Text := IntToStr(Copies);
    end;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TUrkundeDialog.OkButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    ModalResult := mrNone;

    if not UebernehmeUrkDaten then Exit;

    if UrkHauptDokNeu and UrkHauptDokErstellen or
       not UrkHauptDokNeu and UrkDokErstellen then
    begin
      UpdateDokListe;
      ModalResult := mrOk; // f�r neue Tln immer neuer Dialog �ffnen
    end;

  finally
    DisableButtons := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TUrkundeDialog.HilfeButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if UrkMode = rmWordUrk then
    Application.HelpContext(2750)  // Einzel-Urkunde mit MS-Word
  else
    Application.HelpContext(2700); // Seriendruck mit MS Word
end;


{###############################################################################

Microsoft Knowledge Base 229310:
   How To Automate Word to Perform Mail Merge from Delphi

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure InsertLines(LineNum : Integer);
    procedure CreateMailMergeDataFile;
    procedure FillRow(Doc : Variant; Row : Integer;
                 Text1,Text2,Text3,Text4 : String);
  private

  public
    wrdApp, wrdDoc: Variant;
  end;

var
  Form1: TForm1;

implementation

uses ComObj;

Const wdAlignParagraphLeft = 0;
Const wdAlignParagraphCenter = 1;
Const wdAlignParagraphRight = 2;
Const wdAlignParagraphJustify = 3;
Const wdAdjustNone = 0;
Const wdGray25 = 16;
Const wdGoToLine = 3;
Const wdGoToLast = -1;
Const wdSendToNewDocument = 0;

(*$R *.DFM*)

procedure TForm1.InsertLines(LineNum : Integer);
var
  iCount : Integer;
begin
  for iCount := 1 to LineNum do
     wrdApp.Selection.TypeParagraph;
end;

procedure TForm1.FillRow(Doc : Variant; Row : Integer;
                 Text1,Text2,Text3,Text4 : String);

begin
  Doc.Tables.Item(1).Cell(Row,1).Range.InsertAfter(Text1);
  Doc.Tables.Item(1).Cell(Row,2).Range.InsertAfter(Text2);
  Doc.Tables.Item(1).Cell(Row,3).Range.InsertAfter(Text3);
  Doc.Tables.Item(1).Cell(Row,4).Range.InsertAfter(Text4);
end;

procedure TForm1.CreateMailMergeDataFile;
var
  wrdDataDoc : Variant;
  iCount : Integer;
begin
  // Create a data source at C:\DataDoc.doc containing the field data
  wrdDoc.MailMerge.CreateDataSource('C:\DataDoc.doc',,'FirstName, LastName,' +
       ' Address, CityStateZip');
  // Open the file to insert data
  wrdDataDoc := wrdApp.Documents.Open('C:\DataDoc.doc');
  for iCount := 1 to 2 do
    wrdDataDoc.Tables.Item(1).Rows.Add;
  // Fill in the data
  FillRow(wrdDataDoc, 2, 'Steve', 'DeBroux',
        '4567 Main Street', 'Buffalo, NY  98052');
  FillRow(wrdDataDoc, 3, 'Jan', 'Miksovsky',
        '1234 5th Street', 'Charlotte, NC  98765');
  FillRow(wrdDataDoc, 4, 'Brian', 'Valentine',
        '12348 78th Street  Apt. 214', 'Lubbock, TX  25874');
  // Save and close the file
  wrdDataDoc.Save;
  wrdDataDoc.Close(False);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  StrToAdd : String;
  wrdSelection, wrdMailMerge, wrdMergeFields : Variant;
begin
  // Create an instance of Word and make it visible
  wrdApp := CreateOleObject('Word.Application');
  wrdApp.Visible := True;
  // Create a new document
  wrdDoc := wrdApp.Documents.Add();
  wrdDoc.Select;

  wrdSelection := wrdApp.Selection;
  wrdMailMerge := wrdDoc.MailMerge;

  // Create MailMerge data file
  CreateMailMergeDataFile;


  // Create a string and insert it into the document
  StrToAdd := 'State University' + Chr(13) +
              'Electrical Engineering Department';
  wrdSelection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
  wrdSelection.TypeText(StrToAdd);

  InsertLines(4);

  // Insert Merge Data
  wrdSelection.ParagraphFormat.Alignment := wdAlignParagraphLeft;
  wrdMergeFields := wrdMailMerge.Fields;

  wrdMergeFields.Add(wrdSelection.Range,'FirstName');
  wrdSelection.TypeText(' ');
  wrdMergeFields.Add(wrdSelection.Range,'LastName');
  wrdSelection.TypeParagraph;
  wrdMergeFields.Add(wrdSelection.Range,'Address');
  wrdSelection.TypeParagraph;
  wrdMergeFields.Add(wrdSelection.Range,'CityStateZip');

  InsertLines(2);

  // Right justify the line and insert a date field with
  // the current date
  wrdSelection.ParagraphFormat.Alignment := wdAlignParagraphRight;
  wrdSelection.InsertDateTime('dddd, MMMM dd, yyyy',False);

  InsertLines(2);

  // Justify the rest of the document
  wrdSelection.ParagraphFormat.Alignment := wdAlignParagraphJustify;

  wrdSelection.TypeText('Dear ');
  wrdMergeFields.Add(wrdSelection.Range,'FirstName');

  wrdSelection.TypeText(',');
  InsertLines(2);

  // Create a string and insert it into the document
  StrToAdd := 'Thank you for your recent request for next ' +
      'semester''s class schedule for the Electrical ' +
      'Engineering Department.  Enclosed with this ' +
      'letter is a booklet containing all the classes ' +
      'offered next semester at State University.  ' +
      'Several new classes will be offered in the ' +
      'Electrical Engineering Department next semester.  ' +
      'These classes are listed below.';
  wrdSelection.TypeText(StrToAdd);

  InsertLines(2);

  // Insert a new table with 9 rows and 4 columns
  wrdDoc.Tables.Add(wrdSelection.Range,9,4);
  wrdDoc.Tables.Item(1).Columns.Item(1).SetWidth(51,wdAdjustNone);
  wrdDoc.Tables.Item(1).Columns.Item(2).SetWidth(170,wdAdjustNone);
  wrdDoc.Tables.Item(1).Columns.Item(3).SetWidth(100,wdAdjustNone);
  wrdDoc.Tables.Item(1).Columns.Item(4).SetWidth(111,wdAdjustNone);
  // Set the shading on the first row to light gray

  wrdDoc.Tables.Item(1).Rows.Item(1).Cells
      .Shading.BackgroundPatternColorIndex := wdGray25;
  // BOLD the first row
  wrdDoc.Tables.Item(1).Rows.Item(1).Range.Bold := True;
  // Center the text in Cell (1,1)
  wrdDoc.Tables.Item(1).Cell(1,1).Range.Paragraphs.Alignment :=
        wdAlignParagraphCenter;

  // Fill each row of the table with data
  FillRow(wrdDoc, 1, 'Class Number', 'Class Name', 'Class Time',
     'Instructor');
  FillRow(wrdDoc, 2, 'EE220', 'Introduction to Electronics II',
     '1:00-2:00 M,W,F', 'Dr. Jensen');
  FillRow(wrdDoc, 3, 'EE230', 'Electromagnetic Field Theory I',
     '10:00-11:30 T,T', 'Dr. Crump');
  FillRow(wrdDoc, 4, 'EE300', 'Feedback Control Systems',
     '9:00-10:00 M,W,F', 'Dr. Murdy');
  FillRow(wrdDoc, 5, 'EE325', 'Advanced Digital Design',
     '9:00-10:30 T,T', 'Dr. Alley');
  FillRow(wrdDoc, 6, 'EE350', 'Advanced Communication Systems',
     '9:00-10:30 T,T', 'Dr. Taylor');
  FillRow(wrdDoc, 7, 'EE400', 'Advanced Microwave Theory',
     '1:00-2:30 T,T', 'Dr. Lee');
  FillRow(wrdDoc, 8, 'EE450', 'Plasma Theory',
     '1:00-2:00 M,W,F', 'Dr. Davis');
  FillRow(wrdDoc, 9, 'EE500', 'Principles of VLSI Design',
     '3:00-4:00 M,W,F', 'Dr. Ellison');

  // Go to the end of the document

  wrdApp.Selection.GoTo(wdGotoLine,wdGoToLast);
  InsertLines(2);

  // Create a string and insert it into the document
  StrToAdd := 'For additional information regarding the ' +
             'Department of Electrical Engineering, ' +
             'you can visit our website at ';
  wrdSelection.TypeText(StrToAdd);
  // Insert a hyperlink to the web page
  wrdSelection.Hyperlinks.Add(wrdSelection.Range,'http://www.ee.stateu.tld');
  // Create a string and insert it into the document
  StrToAdd := '.  Thank you for your interest in the classes ' +
             'offered in the Department of Electrical ' +
             'Engineering.  If you have any other questions, ' +
             'please feel free to give us a call at ' +
             '555-1212.' + Chr(13) + Chr(13) +
             'Sincerely,' + Chr(13) + Chr(13) +
             'Kathryn M. Hinsch' + Chr(13) +
             'Department of Electrical Engineering' + Chr(13);
  wrdSelection.TypeText(StrToAdd);

  // Perform mail merge
  wrdMailMerge.Destination := wdSendToNewDocument;
  wrdMailMerge.Execute(False);

  // Close the original form document
  wrdDoc.Saved := True;
  wrdDoc.Close(False);

  // Notify the user we are done.
  ShowMessage('Mail Merge Complete.');

  // Clean up temp file
  DeleteFile('C:\DataDoc.doc');

end;

end.
}


end.
