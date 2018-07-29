unit SerDrUrkDlg;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Math,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, AllgComp,
  Vcl.ComCtrls, Vcl.Mask,

  AllgConst,WettkObj,AkObj;

procedure SerienDruck(Mode:TReportMode);
function WriteUrkZeile(RepPtr:Pointer): Boolean;

var
  SerDrDateiName  : String;
  SerDrDatei      : Text;
  // Parameter für Datenfelder
  SerDrAbsMax     : Integer;
  SerDrTlnMax     : Integer;
  SerDrMschGrMax  : Integer;
  SerDrRndRennen  : Boolean;
  SerDrStndRennen : Boolean;
  SerDrTZ         : Char; // TrennZeichen

type
  TSerDrUrkDialog = class(TForm)
    WettkLabel: TLabel;
    ImpDateiEdit: TTriaEdit;
    KlasseLabel: TLabel;
    TriaEdit1: TTriaEdit;
    RngBereichGB: TGroupBox;
    RngBisLabel: TLabel;
    RngAlleRB: TRadioButton;
    RngVonBisRB: TRadioButton;
    RngVonEdit: TTriaMaskEdit;
    RngBisEdit: TTriaMaskEdit;
    RngVonUpDown: TTriaUpDown;
    RngBisUpDown: TTriaUpDown;
    SnrBereichGB: TGroupBox;
    SnrBisLabel: TLabel;
    SnrAlleRB: TRadioButton;
    SnrVonBisRB: TRadioButton;
    SnrVonEdit: TTriaMaskEdit;
    SnrBisEdit: TTriaMaskEdit;
    SnrVonUpDown: TTriaUpDown;
    SnrBisUpDown: TTriaUpDown;
    OkButton: TButton;
    CancelButton: TButton;
    HilfeButton: TButton;

    procedure RngVonBisEditClick(Sender: TObject);
    procedure RngUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure SnrVonBisEditClick(Sender: TObject);
    procedure SnrUpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure RngVonBisRBClick(Sender: TObject);
    procedure SnrVonBisRBClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure SnrAlleRBClick(Sender: TObject);

  private
    HelpFensterAlt     : TWinControl;
    Updating           : Boolean;
    DisableButtons     : Boolean;

    RepWk : TReportWkObj;
    RepAk : TAkObj;

    procedure InitRngBereichGB;
    procedure InitSnrBereichGB;
    function  EingabeOk: Boolean;
    procedure DatenUebernehmen;

  public
    constructor Create(AOwner: TComponent); override;

  end;

var
  SerDrUrkDialog: TSerDrUrkDialog;

implementation

{$R *.dfm}

uses TriaMain,VistaFix,AllgFunc,AllgObj,VeranObj,TlnObj,MannsObj,DateiDlg;

function SerDateiErstellen: Boolean; forward;
procedure SerienDruckUrkunden; forward;

function SerienDruckTlnEtiketten: Boolean;                              forward;
function SerienDruckSMldEtiketten: Boolean;                             forward;
function UrkTxtZeileTlnTagesWertung(RepTln:TReportTlnObj): String;      forward;
function UrkTxtZeileTlnSerienWertung(RepTln:TReportTlnObj): String;     forward;
function UrkTxtZeileMschWertungKompakt(RepMsch:TReportMschObj): String; forward;
function UrkTxtZeileMschWertungDetail(RepMsch:TReportMschObj): String;  forward;
function UrkTxtZeileMschSerienWertung(RepMsch:TReportMschObj): String;  forward;
function SchreibFehler: Boolean;                                        forward;

//******************************************************************************
procedure SerienDruck(Mode:TReportMode);
//******************************************************************************
begin
  ReportMode := Mode;
  case ReportMode of
    rmEtiketten : SerDateiErstellen;
    rmUrkunden  : SerienDruckUrkunden;
    else
  end;
end;

//******************************************************************************
procedure SerienDruckUrkunden;
//******************************************************************************
begin
  SerDrUrkDialog := TSerDrUrkDialog.Create(HauptFenster);
  try
    if SerDrUrkDialog.ShowModal = mrOk then
      HauptFenster.RefreshAnsicht;
  finally
    FreeAndNil(SerDrUrkDialog);
  end;
end;

//******************************************************************************
function SerDateiErstellen: Boolean;
//******************************************************************************
var BarMax,WkNr,
    i,j   : Integer;
    RepWk : TReportWkObj;
    Titel : String;


//..............................................................................
begin
  Result := false;

  case ReportMode of
    rmUrkunden  :
      case HauptFenster.Ansicht of
        anTlnStart,
        anTlnErg,
        anTlnErgSerie,
        anMschErgDetail,
        anMschErgKompakt,
        anMschErgSerie    : Titel := 'Seriendruckdatei für Urkunden erstellen';
        else
        begin
          TriaMessage('Für diese Ansicht kann keine Seriendruckdatei für Urkunden '+
                      'erstellt werden.',
                      mtInformation,[mbOk]);
          Exit;
        end;
      end;
    rmEtiketten :
      case HauptFenster.Ansicht of
        anAnmEinzel,
        anAnmSammel : Titel := 'Seriendruckdatei für Etiketten erstellen';
        else
        begin
          TriaMessage('Für diese Ansicht kann keine Seriendruckdatei für Etiketten '+
                      'erstellt werden.',
                      mtInformation,[mbOk]);
          Exit;
        end;
      end;
  end;

  SerDrDateiName := System.SysUtils.ChangeFileExt(TriDatei.Path,'.txt');
  if SaveFileDialog('txt',
                    'Textdatei (*.txt)|*.txt|Alle Dateien (*.*)|*.*',
                    System.SysUtils.ExtractFileDir(TriDatei.Path),
                    Titel,
                    SerDrDateiName) then
  begin
    case HauptFenster.Ansicht of
      anAnmEinzel       : BarMax := Veranstaltung.TlnColl.SortCount;
      anAnmSammel       : BarMax := Veranstaltung.SMldColl.SortCount;
      anTlnStart,
      anTlnErg,
      anTlnErgSerie     : BarMax := Veranstaltung.TlnColl.Count * 2;
      anMschErgDetail,
      anMschErgKompakt,
      anMschErgSerie    : BarMax := Veranstaltung.MannschColl.Count * 2;
      else BarMax:=0;
    end;

    if System.SysUtils.FileExists(SerDrDateiName) and not System.SysUtils.DeleteFile(SerDrDateiName) then
    begin
      TriaMessage('Vorhandene Datei  "'+System.SysUtils.ExtractFileName(SerDrDateiName)+
                  '"  kann nicht gelöscht werden.',
                   mtInformation,[mbOk]);
      Exit;
    end;

    HauptFenster.ProgressBarInit('Textdatei für Seriendruck wird erstellt',BarMax);

    // zuerst allgemeine Parameter über alle Wettk berechnen
    SerDrAbsMax     := 0;
    SerDrTlnMax     := 0;
    SerDrRndRennen  := false;
    SerDrStndRennen := false;
    SerDrMschGrMax  := cnMschGrMin;
    SerDrTZ         := FormatSettings.ListSeparator;

    {SerDrTlnMax := RepWk.Wettk.AbschnZahl;
    if RepWk.Wettk.WettkArt = waTlnStaffel then
    begin
      SerDrAbsMax := RepWk.Wettk.AbschnZahl;
      SerDrTlnMax := RepWk.Wettk.AbschnZahl;
    end else
    begin
      SerDrAbsMax := RepWk.Wettk.AbschnZahl;
      SerDrTlnMax := Max(SerDrTlnMax,0);
        if TReportWkObj(ReportWkListe[i]).Wettk.WettkArt = waRndRennen then
          SerDrRndRennen := true
        else
        if TReportWkObj(ReportWkListe[i]).Wettk.WettkArt = waStndRennen then
          SerDrStndRennen := true;  //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      end;
      for j:=0 to ReportAkListe.Count-1 do
        MschGrMax := Max(MschGrMax,TReportWkObj(ReportWkListe[i]).Wettk.MschGroesse[TAkObj(ReportAkListe[j]).Sex]);
    end;}

    try
      {$I-}
      AssignFile(SerDrDatei,SerDrDateiName);
      if SchreibFehler then Exit;

      Rewrite(SerDrDatei);
      if SchreibFehler then Exit;

      if ReportMode = rmEtiketten then // Tln-/SMldSortColl benutzt
        case HauptFenster.Ansicht of
          anAnmEinzel : if not SerienDruckTlnEtiketten then Exit;
          anAnmSammel : if not SerienDruckSMldEtiketten then Exit;
        end
      else
      begin // rmUrkunden
        if HauptFenster.TlnAnsicht then Veranstaltung.TlnColl.ReportSortieren(RepWk)
                                   else Veranstaltung.MannschColl.ReportSortieren(RepWk);
        // BarPos bleibt erhalten (50%), Report immer von TlnColl erstellt
        HauptFenster.ProgressBarMaxUpdate(Veranstaltung.TlnColl.ReportCount);

        // Header-Zeile
        if not WriteUrkZeile(nil) then Exit;
        // Daten-Zeilen
        if HauptFenster.TlnAnsicht then
          for i:=0 to Veranstaltung.TlnColl.ReportCount-1 do
          begin
            if not WriteUrkZeile(Veranstaltung.TlnColl.ReportItems[i]) then Exit;
            HauptFenster.ProgressBarStep(1);
          end
        else // MschAnsicht
          for i:=0 to Veranstaltung.MannschColl.ReportCount-1 do
          begin
            if not WriteUrkZeile(Veranstaltung.MannschColl.ReportItems[i]) then Exit;
            HauptFenster.ProgressBarStep(1);
          end;
      end;

      Result := true;

    finally
      CloseFile(SerDrDatei);
      IoResult;    (*Löschen Fehlerspeicher*)
      {$I+}
      HauptFenster.StatusBarClear;
    end;
  end;
end;

end;





(******************************************************************************)
(*  Methoden TDruckDialog                                                     *)
(******************************************************************************)

// public Methoden

(*============================================================================*)
constructor TSerDrUrkDialog.Create(AOwner: TComponent);
(*============================================================================*)
begin
  inherited Create(AOwner);
  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  Updating       := false;
  DisableButtons := false;

  with HauptFenster.LstFrame.AnsFrame.WettkampfCB do
    if ItemIndex >= 0 then
      RepWk := TReportWkObj(Items.Objects[ItemIndex])
    else
      RepWk := nil;
  RepAk := HauptFenster.SortKlasse;

  // RngBereichGB immer visible
  InitRngBereichGB;

  if HauptFenster.Ansicht = anTlnErg then
  begin
    SnrBereichGB.Visible := true;
    InitSnrBereichGB;
  end else
  begin
    SnrBereichGB.Visible := false;
    OkButton.Top := RngBereichGB.Top + RngBereichGB.Height + 12;
    CancelButton.Top   := OkButton.Top;
    HilfeButton.Top    := OkButton.Top;
    ClientHeight       := OkButton.Top + OkButton.Height + 12;
  end;

  OkButton.Default := true;
  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);

end;

//------------------------------------------------------------------------------
procedure TSerDrUrkDialog.InitRngBereichGB;
//------------------------------------------------------------------------------
begin
  case HauptFenster.Ansicht of
    anTlnErg:
      RngBisUpDown.Max := Veranstaltung.TlnColl.TagesRngMax(RepWk.Wettk,RepWk.Wrtg,RepAk);
    anTlnErgSerie:
      RngBisUpDown.Max := Veranstaltung.TlnColl.SerieRngMax(RepWk.Wettk,RepAk);
    anMschErgDetail,anMschErgKompakt:
      RngBisUpDown.Max := Veranstaltung.MannschColl.TagesRngMax(RepWk.Wettk,RepAk);
    anMschErgSerie:
      RngBisUpDown.Max := Veranstaltung.MannschColl.SerieRngMax(RepWk.Wettk,RepAk);
    else
      RngBisUpDown.Max := 0;
  end;
  RngBisUpDown.Min  := Min(RngBisUpDown.Max,1);
  RngVonUpDown.Min  := RngBisUpDown.Min;
  RngVonUpDown.Max  := RngBisUpDown.Max;
  RngBisEdit.Text   := IntToStr(RngBisUpDown.Max);
  RngVonEdit.Text   := IntToStr(RngVonUpDown.Min);
  RngAlleRB.Checked := true;
end;

//------------------------------------------------------------------------------
procedure TSerDrUrkDialog.InitSnrBereichGB;
//------------------------------------------------------------------------------
begin
  if HauptFenster.Ansicht = anTlnErg then
  begin
    SnrBereichGB.Visible := true;
    SnrVonUpDown.Min := Veranstaltung.TlnColl.SnrMin(RepWk.Wettk,RepWk.Wrtg,RepAk,HauptFenster.SortStatus);
    if SnrVonUpDown.Min = cnTlnMax then SnrVonUpDown.Min := 0;
    SnrVonUpDown.Max := Veranstaltung.TlnColl.SnrMax(RepWk.Wettk,RepWk.Wrtg,RepAk,HauptFenster.SortStatus);
    SnrBisUpDown.Min := SnrVonUpDown.Min;
    SnrBisUpDown.Max := SnrVonUpDown.Max;
    SnrVonEdit.Text  := IntToStr(SnrVonUpDown.Min);
    SnrBisEdit.Text  := IntToStr(SnrVonUpDown.Max);
    SnrAlleRB.Checked := true;
  end else
    SnrBereichGB.Visible := false;
end;

//------------------------------------------------------------------------------
function TSerDrUrkDialog.EingabeOk: Boolean;
//------------------------------------------------------------------------------
begin
  Result := false;

  // prüfen ob Tln vorhanden bei RngAlle ???

  if RngVonBisRB.Checked then
  begin
    if (StrToIntDef(RngVonEdit.Text,0) < RngVonEdit.UpDown.Min) or
       (StrToIntDef(RngVonEdit.Text,0) > RngVonEdit.UpDown.Max)then
    begin
      TriaMessage('Der eingegebene Wert ist ungültig. Erlaubt sind Werte von ' +
                  IntToStr(RngVonEdit.UpDown.Min)+' bis '+IntToStr(RngVonEdit.UpDown.Max)+'.',
                  mtInformation,[mbOk]);
      if RngVonEdit.CanFocus then RngVonEdit.SetFocus;
      Exit;
    end;
    if (StrToIntDef(RngBisEdit.Text,0) < RngBisEdit.UpDown.Min) or
       (StrToIntDef(RngBisEdit.Text,0) > RngBisEdit.UpDown.Max) then
    begin
      TriaMessage('Der eingegebene Wert ist ungültig. Erlaubt sind Werte von ' +
                  IntToStr(RngBisEdit.UpDown.Min)+' bis '+IntToStr(RngBisEdit.UpDown.Max)+'.',
                  mtInformation,[mbOk]);
      if RngBisEdit.CanFocus then RngBisEdit.SetFocus;
      Exit;
    end;
    if (StrToIntDef(RngVonEdit.Text,0) > StrToIntDef(RngBisEdit.Text,0)) then
    begin
      TriaMessage('Bereich der Platzierungen ist ungültig.',mtInformation,[mbOk]);
      if RngVonEdit.CanFocus then RngVonEdit.SetFocus;
     Exit;
    end;
  end;

  // prüfen ob Tln vorhanden bei SnrAlle ???

  if SnrBereichGB.Visible and SnrVonBisRB.Checked then
  begin
    if (StrToIntDef(SnrBisEdit.Text,0) < SnrBisEdit.UpDown.Min) or
       (StrToIntDef(SnrBisEdit.Text,0) > SnrBisEdit.UpDown.Max) then
    begin
      TriaMessage('Der eingegebene Wert ist ungültig. Erlaubt sind Werte von ' +
                  IntToStr(SnrBisEdit.UpDown.Min)+' bis '+IntToStr(SnrBisEdit.UpDown.Max)+'.',
                  mtInformation,[mbOk]);
      if SnrBisEdit.CanFocus then SnrBisEdit.SetFocus;
      Exit;
    end;
    if StrToIntDef(SnrVonEdit.Text,0) > StrToIntDef(SnrBisEdit.Text,0) then
    begin
      TriaMessage('Der Startnummernbereich ist ungültig.',mtInformation,[mbOk]);
      if SnrVonEdit.CanFocus then SnrVonEdit.SetFocus;
      Exit;
    end;
  end;

  Result := true;
end;

//------------------------------------------------------------------------------
procedure TSerDrUrkDialog.DatenUebernehmen;
//------------------------------------------------------------------------------
begin
  // RngBereichGB
  if not RngAlleRB.Checked then
  begin
    ReportRngVon := StrToIntDef(RngVonEdit.Text,0);
    ReportRngBis := StrToIntDef(RngBisEdit.Text,0);
  end else
  begin
    ReportRngVon := 0;
    ReportRngBis := cnTlnMax;
  end;

  // SnrBereichGB
  if SnrBereichGB.Visible and not SnrAlleRB.Checked then
  begin
    ReportSnrVon := StrToIntDef(SnrVonEdit.Text,0);
    ReportSnrBis := StrToIntDef(SnrBisEdit.Text,0);
  end else
  begin
    ReportSnrVon := 0;
    ReportSnrBis := cnTlnMax;
  end;
  //ExportDateiName := SysUtils.ChangeFileExt(TriDatei.Path,TriDateiExt(ExportDatFormat));
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerDrUrkDialog.RngVonBisRBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then
  begin
    if RngVonEdit.CanFocus then RngVonEdit.SetFocus;
    RngVonBisRB.Checked := true;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerDrUrkDialog.RngVonBisEditClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then RngVonBisRB.Checked := true;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerDrUrkDialog.RngUpDownClick(Sender: TObject; Button: TUDBtnType);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then RngVonBisRB.Checked := true;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerDrUrkDialog.SnrVonBisRBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then
  begin
    if SnrVonEdit.CanFocus then SnrVonEdit.SetFocus;
    SnrVonBisRB.Checked := true;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerDrUrkDialog.SnrVonBisEditClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then SnrVonBisRB.Checked := true;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerDrUrkDialog.SnrUpDownClick(Sender: TObject; Button: TUDBtnType);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then SnrVonBisRB.Checked := true;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerDrUrkDialog.OkButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    if not EingabeOk then Exit;
    DatenUebernehmen;
    if SerDateiErstellen then ModalResult := mrOk;
  finally
    DisableButtons := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSerDrUrkDialog.SnrAlleRBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  Application.HelpContext(2700);// Urkunden Drucken
end;


end.
