unit TriaMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, ComCtrls, CommCtrl, Grids, ActnList, ToolWin, ImgList,
  DBActns, Buttons, Mask, ActnMan, ActnCtrls,Math,
  ActnMenus, XPStyleActnCtrls, StdStyleActnCtrls, Types,
  //IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,// HTTP
  hh, hh_funcs,
  // HTMLhelpViewer,  // f�r Delphi XE ?
  RpDefine, // Rave
  XPMan, // f�r XP Style, Externe Manifest-Datei nicht mehr n�tig
  VistaFix, // Korrekturen f�r Probleme mit Vista
  ShellApi,
  AllgObj,AllgComp,AllgConst,AllgFunc,AkObj,CmdProc,TlnObj,WettkObj,SMldObj,
  VeranObj,OrtObj,LstFrm,SMldFrm,PrevFrm,ImpFrm,KlassenDlg,ImpDlg,AnsFrm,
  MruObj,SerWrtgDlg,RfidEinlDlg;

type

  THauptFenster = class(TForm)
    PopupMenu1: TPopupMenu; //ab 11.5.0, wieso??
    WordUrkErst: TMenuItem;
    Bearbeiten: TMenuItem;
    N1: TMenuItem;
    Entfernen: TMenuItem;
    Disqualifizieren1: TMenuItem;

  published

    ActionMainMenuBar: TActionMainMenuBar;
    ActionToolBar: TActionToolBar;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    OrtCBLabel: TLabel;
    OrtCBPanel: TPanel;
    OrtCB: TComboBox;
    LstFrame: TLstFrame;
    SMldFrame: TSMldFrame;
    ActionManager : TActionManager;
    ToolbarImages : TImageList;
    XPManifest1   : TXPManifest;
    UhrzeitTimer  : TTimer;

    // Datei-Actions
    TriDatNeuAction: TAction;
    TriDatOeffnenAction: TAction;
    TriDatSpeichernAction: TAction;
    TriDatSpeichernUnterAction: TAction;
    ImpFrame: TImpFrame;
    ImportAction: TAction;
    BeendenAction: TAction;
    MruAction1: TAction;
    MruAction2: TAction;
    MruAction3: TAction;
    MruAction4: TAction;
    MruAction5: TAction;
    MruAction6: TAction;
    MruAction7: TAction;
    MruAction8: TAction;
    // Einsetellungen-Actions
    VeranstaltungAction: TAction;
    WettkEingebenAction: TAction;
    SerWrtgAction: TAction;
    StartgruppenAction: TAction;
    KlassenAction: TAction;
    // Teilnehmer-Actions
    TlnHinzufuegenAction: TAction;
    TlnBearbeitenAction: TAction;
    TlnEntfernenAction: TAction;
    TlnDisqualAction: TAction;
    TlnEinteilenAction: TAction;
    EinteilungLoeschenAction: TAction;
    RfidCodeAction: TAction;
    SuchenAction: TAction;
    ErsetzenAction: TAction;
    //Zeitnahme-Actions
    ZtErfEinlAction: TAction;
    LiveEinlesenAction: TAction;
    ZeitLoeschenAction: TAction;
    // Ansicht-Actions
    AnmEinzelAction: TAction;
    AnmSammelAction: TAction;
    TlnStartAction: TAction;
    TlnErgAction: TAction;
    TlnErgSerieAction: TAction;
    MschStartAction: TAction;
    MschErgDetailAction: TAction;
    MschErgKompaktAction: TAction;
    MschErgSerieAction: TAction;
    TlnSchwBhnAction: TAction;
    TlnUhrzeitAction: TAction;
    TlnRndKntrlAction: TAction;
    // Ausgabe-Actions
    ListeDruckAction: TAction;
    VorschauAction: TAction;
    HTMLDateiAction: TAction;
    ExcelDateiAction: TAction;
    TextDateiAction: TAction;
    PDFDateiAction: TAction;
    WordUrkundeAction: TAction;
    UrkTextDateiAction: TAction;
    EtikTxtDateiAction: TAction;
    // Extras-Actions
    UpdateAction: TAction;
    OptionenAction: TAction;
    // Hilfe-Actions
    HilfeAction: TAction;
    TriaImWeb: TAction;
    InfoAction: TAction;
    // Preview-Actions
    PrevStart: TAction;
    PrevBack: TAction;
    PrevNext: TAction;
    PrevLast: TAction;
    PrevDrucken: TAction;
    PrevPdfDatei: TAction;
    PrevClose: TAction;
    PrevFrame: TPrevFrame;
    PrevToolBar: TActionToolBar;

    // Men� Datei Eventhandler
    procedure TriDatNeuActionExecute(Sender: TObject);
    procedure TriDatOeffnenActionExecute(Sender: TObject);
    procedure TriDatSpeichernActionExecute(Sender: TObject);
    procedure TriDatSpeichernUnterActionExecute(Sender: TObject);
    procedure ImportActionExecute(Sender: TObject);
    procedure MruActionExecute(Sender: TObject); //f�r XP Style, Element unn�tig, XPMan in use reicht
    procedure BeendenActionExecute(Sender: TObject);

    // Men� Einstellungen Eventhandler
    procedure VeranstaltungActionExecute(Sender: TObject);
    //procedure OrtsnamenActionExecute(Sender: TObject);
    procedure WettkaempfeActionExecute(Sender: TObject);
    procedure SerWrtgActionExecute(Sender: TObject);
    procedure StartgruppenActionExecute(Sender: TObject);
    procedure KlassenActionExecute(Sender: TObject);

    // Men� Teilnehmer Eventhandler
    procedure TlnHinzufuegenActionExecute(Sender: TObject);
    procedure TlnBearbeitenActionExecute(Sender: TObject);
    procedure TlnEntfernenActionExecute(Sender: TObject);
    procedure SuchenActionExecute(Sender: TObject);
    procedure ErsetzenActionExecute(Sender: TObject);
    //procedure SuchWeiterActionExecute(Sender: TObject);
    procedure EinteilungLoeschenActionExecute(Sender: TObject);
    procedure TlnEinteilenActionExecute(Sender: TObject);
    procedure RfidCodeActionExecute(Sender: TObject);
    procedure TlnDisqualActionExecute(Sender: TObject);

    // Men� Zeitnahme Eventhandler
    procedure ZtErfEinlActionExecute(Sender: TObject);
    procedure LiveEinlesenActionExecute(Sender: TObject);
    procedure ZeitLoeschenActionExecute(Sender: TObject);

    // Men� Ansicht Eventhandler
    procedure AnmEinzelActionExecute(Sender: TObject);
    procedure AnmSammelActionExecute(Sender: TObject);
    procedure TlnStartActionExecute(Sender: TObject);
    procedure TlnErgActionExecute(Sender: TObject);
    procedure TlnErgSerieActionExecute(Sender: TObject);
    procedure TlnUhrZeitActionExecute(Sender: TObject);
    procedure TlnRndKntrlActionExecute(Sender: TObject);
    procedure MschStartActionExecute(Sender: TObject);
    procedure MschErgDetailActionExecute(Sender: TObject);
    procedure MschErgKompaktActionExecute(Sender: TObject);
    procedure MschErgSerieActionExecute(Sender: TObject);
    procedure TlnSchwBhnActionExecute(Sender: TObject);

    // Men� Ausgabe Eventhandler
    //procedure DruckEinrichtenActionExecute(Sender: TObject);
    procedure ListeDruckActionExecute(Sender: TObject);
    procedure VorschauActionExecute(Sender: TObject);
    procedure PDFDateiActionExecute(Sender: TObject);
    procedure HTMLDateiActionExecute(Sender: TObject);
    procedure ExcelDateiActionExecute(Sender: TObject);
    procedure WordUrkundeActionExecute(Sender: TObject);
    procedure TextDateiActionExecute(Sender: TObject);
    procedure UrkTextDateiActionExecute(Sender: TObject);
    procedure EtikTxtDateiActionExecute(Sender: TObject);

    // Men� Extras Eventhandler
    procedure UpdateActionExecute(Sender: TObject);
    procedure OptionenActionExecute(Sender: TObject);

    // Men� Hilfe Eventhandler
    procedure HilfeActionExecute(Sender: TObject);
    procedure TriaImWebExecute(Sender: TObject);
    procedure InfoActionExecute(Sender: TObject);

    // ToolBars Eventhandler
    procedure OrtCBChange(Sender: TObject);
    procedure OrtCBLabelClick(Sender: TObject);
    procedure ComboBoxCloseUp(Sender: TObject);
    procedure ComboBoxKeyPress(Sender: TObject; var Key: Char);

    // allgemeine Eventhandler
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UhrzeitTimerTick(Sender: TObject);
    procedure PrevStartExecute(Sender: TObject);
    procedure PrevBackExecute(Sender: TObject);
    procedure PrevNextExecute(Sender: TObject);
    procedure PrevLastExecute(Sender: TObject);
    procedure PrevDruckenExecute(Sender: TObject);
    procedure PrevPdfDateiExecute(Sender: TObject);
    procedure PrevCloseExecute(Sender: TObject);

  private
    FSortOrt        : TOrtObj;
    ProgressBarMax,           // ProgressBar.Max immer cnProgressBarMax (100)
    ProgressBarPos  : Int64;  // ProgressBarMax=ProgressBarScale*100
    BarStartZeit    : DWord;
    UhrZeitTimerTickDisabled : Boolean;
    FAutoSpeichernInterval : DWord; // in msek
    FLiveZtErfAktiviert : Boolean;
    procedure InitOrtListe(OrtNeu: TOrtObj);
    function  GetSortOrt: TOrtObj;
    procedure IdleEventHandler(Sender:TObject; var Done:Boolean);
    procedure SetAutoSpeichernInterval(Zeit:DWord);
    procedure SetLiveZtErfAktiviert(Bool:Boolean);

  protected
    function  CustomAlignInsertBefore(C1, C2: TControl): Boolean; override;
    procedure CustomAlignPosition(Control: TControl;
                            var NewLeft,NewTop,NewWidth,NewHeight: Integer;
                            var AlignRect:TRect; AlignInfo:TAlignInfo); override;
  public
    Ansicht    : TAnsicht;
    SortMode   : TSortMode;
    SortWettk  : TWettkObj;
    SortWrtg   : TWertungMode;
    SortSex    : TSex;
    SortKlasse : TAkObj;
    SortStatus : TStatus;
    SortSMld   : TSMldObj;
    MruListe   : TMruListe;
    NeuStart   : Boolean;
    ListType   : TListType;
    FocusedTln : TTlnObj;
    //WettkAlleDummy : TWettkObj; // f�r AnsFrame/Sortwettk wenn Veranstaltung=nil
    ProgressBarStehenLassen : Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   Init;   (* Standard Einstellung *)
    //function    UhrZeit: Integer;
    procedure   InitAnsicht(OrtNeu:TOrtObj; AnsichtNeu:TAnsicht;
                            ModeNeu:TSortMode;
                            WkNeu:TWettkObj; WrtgModeNeu:TWertungMode;
                            SexNeu:TSex; AkNeu:TAkObj; StatusNeu:TStatus);
    procedure   RefreshAnsicht; (* bestehende Einstellung unver�ndert *)
    procedure   UpdateAnsicht;
    function    TlnAnsicht: Boolean;
    function    MschAnsicht: Boolean;
    function    MeldeAnsicht: Boolean;
    procedure   ProgressBarInit(const Text: String; const MaxNeu:Int64);
    procedure   ProgressBarMaxUpdate(const MaxNeu:Int64);
    procedure   ProgressBarText(const Text: String);
    procedure   ProgressBarStep(Delta:Int64);
    procedure   ProgressBarClear;
    procedure   StatusBarText(const Text1,Text2: String);
    procedure   StatusBarUpdate;
    procedure   StatusBarClear;
    procedure   UpdateCaption;
    procedure   CommandHeader;
    procedure   CommandTrailer;
    procedure   CommandDataUpdate;

    property    AutoSpeichernInterval: DWord read FAutoSpeichernInterval write SetAutoSpeichernInterval;
    property    LiveZtErfAktiviert: Boolean read FLiveZtErfAktiviert write SetLiveZtErfAktiviert;
  end;

var
  HauptFenster : THauptFenster;
  mHHelp       : THookHelpSystem;
  HelpFenster  : TWinControl;

implementation

{$R *.DFM}

uses History,DateiDlg,
     VstOrtDlg,WettkDlg,SGrpDlg,TlnDlg,TlnErg,OptDlg,
     AusgDlg,UrkundeDlg,InfoDlg,SuchenDlg,
     ZtEinlDlg,ZtLoeschDlg,TriaConfig,UpdateDlg,EinteilenDlg,SerienDr,MannsObj;


// f�r Help Context Popup
(******************************************************************************)
procedure F1HelpEvent(ContextHelpID:LongInt; x,y:Integer);
(******************************************************************************)
// Alle 'Whats This' und F1 Help_ContextPopup WinHelp-Ereignisse werden
// hier ankommen
var hhpopup: HH.THHPopup;
begin
  with hhpopup do
  begin
    // Gr��e dieser Struktur
    cbStruct := SizeOf(hhpopup);
    // Instanz-Handle f�r String-Ressource
    hinst := 0;
    // Enth�lt 0, eine Ressourcen-ID o dre eine Topic-ID in einer Textdatei
    idString := ContextHelpID;
    // Enth�lt den Text, der angezeigt werden soll, wenn idString 0 ist
    pszText := nil;
    // top center (in Pixeln) des Popup-Fensters
    pt := Point(x,y);
    // Textfarbe, verwende -1 f�r Standard; RGB-Wert z.B. rot: $000000FF
    clrForeground := COLORREF(-1);
    // Hintergrundfarbe, verwende -1 f�r Stanndard, sonst RGB-Wert
    clrBackground := COLORREF(-1);
    // Anzahl an Leerzeichen zwischen Fensterrand und Text, -1 f�r jeden
    // Teil zum ignorieren
    rcMargins := Rect(-1,-1,-1,-1);
    // Schrift: facename, point size, char set, BOLD ITALIC UNDERLINE
    pszFont := '';
  end;
  // wenn F1 gedruckt wird und kein Dialog ge�ffnet ist, soll Tria-Hilfe
  // gestartet werden
  {if HelpFenster = HauptFenster then
    HauptFenster.HilfeActionExecute(HelpFenster)
  else }
    HtmlHelp(HelpFenster.Handle,
             PChar(ExtractFilePath(ParamStr(0))+'Tria.chm::/Tria.txt'),
             HH_DISPLAY_TEXT_POPUP, DWORD(@hhpopup));
end;

// private Methoden

(*----------------------------------------------------------------------------*)
procedure THauptFenster.InitOrtListe(OrtNeu: TOrtObj);
(*----------------------------------------------------------------------------*)
var i : Integer;
begin
  OrtCB.Items.BeginUpdate; { prevent repaints until done }
  OrtCB.Items.Clear;
  if (Veranstaltung<>nil) and (Veranstaltung.OrtColl<>nil) then
    for i:=0 to Veranstaltung.OrtColl.Count-1 do
      OrtCB.Items.Append(Veranstaltung.OrtColl[i].Name)
  else
    OrtCB.Items.Append(''); // dummy
  OrtCB.Items.EndUpdate; { reenable repaints }

  if (OrtNeu<>nil) and (OrtCB.Items.IndexOf(OrtNeu.Name) >= 0) then
    OrtCB.ItemIndex := OrtCB.Items.IndexOf(OrtNeu.Name)
  else OrtCB.ItemIndex := 0;
  FSortOrt := GetSortOrt;
end;

(*----------------------------------------------------------------------------*)
function THauptFenster.GetSortOrt: TOrtObj;
(*----------------------------------------------------------------------------*)
begin
  if (Veranstaltung<>nil) and (Veranstaltung.OrtColl<>nil) and
     (OrtCB.ItemIndex >= 0) and
     (OrtCB.ItemIndex < Veranstaltung.OrtColl.Count) then
    Result := Veranstaltung.OrtColl[OrtCB.ItemIndex]
  else Result := nil;
end;

(*----------------------------------------------------------------------------*)
procedure THauptFenster.IdleEventHandler(Sender:TObject; var Done:Boolean);
(*----------------------------------------------------------------------------*)
begin
  if NeuStart then
  begin
    NeuStart := false;
    LadeKonfiguration; // FormShow Event
    if Application.Terminated then
    begin
      Done := true;
      Exit;
    end;
    UhrZeitTimer.Enabled := true;
    UhrZeitTimerTickDisabled:= false;
  end;

  // PersistentHotkeys wird bei jedem Men�zugriff zur�ckgesetzt
  // Muss gesetzt bleiben, sonst wird '&' in Dateiname nicht richtig angezeigt.
  if (ActionMainMenuBar<>nil) and not ActionMainMenuBar.PersistentHotKeys then
    ActionMainMenuBar.PersistentHotKeys:= true;

  Done := true;
end;

//------------------------------------------------------------------------------
procedure THauptFenster.SetAutoSpeichernInterval(Zeit:DWord);
//------------------------------------------------------------------------------
// Zeiten in mSek
begin
  if Zeit > 0 then FAutoSpeichernInterval := Zeit
              else FAutoSpeichernInterval := 0;
  ZeitDatGespeichert := 0; // Interval neu gestartet
  AutoSpeichernRequest := false;
end;

//------------------------------------------------------------------------------
procedure THauptFenster.SetLiveZtErfAktiviert(Bool:Boolean);
//------------------------------------------------------------------------------
begin
  if Bool then FLiveZtErfAktiviert := true
          else FLiveZtErfAktiviert := false;
  ZtErfDatGelesen  := 0; // Interval neu gestartet
  LiveZtErfRequest := false;
end;


// Protected Methoden

(*----------------------------------------------------------------------------*)
function THauptFenster.CustomAlignInsertBefore(C1, C2: TControl): Boolean;
(*----------------------------------------------------------------------------*)
// true wenn C2 vor C1 gezeichnet wird
// Reihenfolge nach TabOrder
begin
  if TWinControl(C1).TabOrder < TWinControl(C2).TabOrder then Result := true
  else Result := false;
end;

(*----------------------------------------------------------------------------*)
procedure THauptFenster.CustomAlignPosition(Control: TControl;
                              var NewLeft,NewTop,NewWidth,NewHeight: Integer;
                              var AlignRect:TRect; AlignInfo:TAlignInfo);
(*----------------------------------------------------------------------------*)
begin
  if Control = OrtCBPanel then
    NewLeft := ClientWidth - OrtCBPanel.Width
  {else if Control = OrtCBLabel then
    NewLeft := ClientWidth - OrtCBPanel.Width - OrtCBLabel.Width }
  {else if Control = ProgressBar then
    NewTop := ClientHeight - StatusBar.Height + 3}
  else if Control =PrevToolBar then
    NewTop := PrevFrame.Top;
end;

// Public Methoden

(*============================================================================*)
constructor THauptFenster.Create(AOwner: TComponent);
(*============================================================================*)
var chmFile: String;
begin
  inherited Create(AOwner);

  NeuStart                 := true;
  UhrZeitTimer.Enabled     := false;
  UhrzeitTimer.Interval    := cnTriTimerInterval;  // 0,2 Sek
  UhrZeitTimerTickDisabled := true;
  Visible                  := false;
  Position                 := poScreenCenter; // wird in TriaConfig �berschrieben

  // f�r HTML Help
  //Application.HelpFile:= ExtractFilePath(Application.ExeName) + 'MyHelpFile.chm';
  chmFile := ExtractFilePath(Paramstr(0))+'Tria.chm';
  mHHelp  := nil;

  // pr�fen ob Hilfe-Datei vorhanden ist
  if not SysUtils.FileExists(chmFile) then
  begin
    HelpDateiVerfuegbar := false;
    HilfeAction.Enabled := false;
    with SMldFrame do
    begin
      biHelpBtn.Enabled   := false;
      HilfeButton.Enabled := false;
    end;
    with ImpFrame do
    begin
      biHelpBtn.Enabled   := false;
      HilfeButton.Enabled := false;
    end;
  end else
    HelpDateiVerfuegbar := true;

  (*HH 1.2 oder h�her Versionskontrolle*)
  if (hh.HHCtrlHandle = 0)
     or (hh_funcs._hhMajVer < 4)
     or ((hh_funcs._hhMajVer = 4) and (hh_funcs._hhMinVer < 73)) then
    TriaMessage('Microsoft HTML Help 1.2 oder h�her ist erforderlich.',
                 mtInformation,[mbOk]);

  (*Hook - verwendet HH_funcs.pas*)
  mHHelp := hh_funcs.THookHelpSystem.Create(chmFile,'',htHHAPI);
  mHHelp.HelpCallback2 := F1HelpEvent;
  HelpContext := 0(*100*); //damit kein Popup bei Elementen ohne ContextID (=0)

  // Trennzeichen setzen (;)
  TZ := FormatSettings.ListSeparator;

  // VistaFix: Fonts
  Font.Name := 'Segoe UI';
  Font.Size := 9;
  SetzeFonts(Self.Font);
  SetzeFonts(LstFrame.Font); // geht nicht in TLstFrame.Create
  SetzeFonts(LstFrame.AnsFrame.Font);
  SetzeFonts(ImpFrame.Font);
  SetzeFonts(SMldFrame.Font);
  SetzeFonts(PrevFrame.Font);

  ClientWidth           := 861;
  Constraints.MinWidth  := Width;
  Height                := 570;
  Constraints.MinHeight := 520;
  Constraints.MaxHeight := 0; // keine Einschr�nkung
  Constraints.MaxWidth  := 0; // keine Einschr�nkung

  //Icon.Handle := LoadIcon(HInstance, 'TRIAVISTA'); bringt nix

  ProgVersion           := TVersion.Create(cnVersionsJahr,cnVersionsNummer);
  TriDatei              := TDatei.Create;
  TriDatei.Path         := '';
  UpdateCaption;
  TriaStream            := nil;
  EinlVeranst           := nil;
  ReportSeiteVon        := 1;
  ReportSeiteBis        := cnSeiteMax;
  ReportWkListe         := TList.Create;
  ReportAkListe         := TList.Create;
  DefaultDrucker        := '';
  ReportDrucker         := '';
  //ReportOrientation     := poPortrait;
  AutoUpdate            := opAutoUpdate;
  UpdateDatum           := opUpdateDatum;
  SnrUeberlapp          := opSnrUeberlapp;
  MruDateiOeffnen       := opMruDateiOeffnenTri;
  BackupErstellen       := opBackupErstellenTri;
  SofortRechnen         := opSofortRechnen;
  DefaultSex            := cnKeinSex;
  //DecZeiten             := opDecZeiten;
  ZeitFormat            := zfSek;
  DecTrennZeichen       := opDecTrennZeichen;
  RfidModus             := false;
  RfidZeichen           := cnRfidZeichenDefault; //=24, erlaubt 1-24
  RfidHex               := cnRfidHexDefault; // false
  RfidDatName           := '';
  ZeitFilter            := opDefaultZeitFilter;
  Rechnen               := true;
  InitAllgAk;            // Allgemeine Klassen definieren, vor WettkAlleDummy
  WettkAlleDummy        := TWettkObj.Create(nil,nil,oaNoAdd); // sp�ter VPtr = Veranstaltung
  WettkAlleDummy.Name   := cnWettkAlleName;
  FSortOrt              := nil;
  SerieOrtIndex         := 0;
  Ansicht              := anKein;
  SortMode             := smNichtSortiert;
  SortWettk            := WettkAlleDummy;
  SortWrtg             := wgStandWrtg;
  SortSex              := cnSexBeide;
  SortKlasse           := AkAlle;
  SortStatus           := stKein;
  SortSMld             := nil;
  FocusedTln            := nil;
  // Init StatusBarPanel
  //ProgressBar.Left         := 2;
  StatusBar.Panels[0].Text := '';
  StatusBar.Panels[1].Text := '';
  // ProgressBar.Min          := 0;   // default
  ProgressBar.Max          := cnProgressBarMax; // default 100
  // ProgressBar.Position          := 0;   // default
  ProgressBar.Visible      := false;
  ProgressBarMax           := cnProgressBarMax;
  ProgressBarPos           := 0;
  BarStartZeit             := 0;
  CursorAlt                := Screen.Cursor;
  {SuchListe                := TStringList.Create;
  SuchListe.Sorted         := false;
  SuchListe.Capacity       := cnSuchListeMax+1;
  ErsatzListe              := TStringList.Create;
  ErsatzListe.Sorted       := false;
  ErsatzListe.Capacity     := cnSuchListeMax+1;}
  HelpFenster              := Self;
  BorderIcons              := BorderIcons + [biHelp]; // f�r Popup Help
  PrevToolBar.Visible      := false;
  OrtCBPanel.TabOrder      := 0;
  MruListe := TMruListe.Create(Self,ActionMainMenuBar);
  //HilfeAction.Caption      := '&Tria' +' '+cnVersionsJahr + ' - Hilfe';
  //TriaImWeb.Caption        :=   'Tria'  +' '+cnVersionsJahr + ' im &Web';
  ProgressBarStehenLassen := false;
  ActionMainMenuBar.PersistentHotKeys := true;

  FAutoSpeichernInterval  := opAutoSpeichernTri;
  AutoSpeichernRequest    := false;
  ZeitAktuell             := 0;
  ZeitDatGespeichert      := 0;

  FLiveZtErfAktiviert        := false;
  LiveZtErfRequest           := false;
  ZeitErfDateiListe          := TStringList.Create;
  ZeitErfDateiListe.Sorted   := false;
  ZeitErfDateiListe.Capacity := cnZtErfDatListeMax+1;
  ZtErfDatAktZeit            := 0;
  ZtErfDatGelesen            := 0;
  ZtErfDatLetztChangeTime    := 0;
  ZEColl                     := TZEColl.Create(nil,TZEObj); // sp�ter VPtr = Veranstaltung
  ZECollOk                   := TZEColl.Create(nil,TZEObj); // sp�ter VPtr = Veranstaltung
  ZECollNOk                  := TZEColl.Create(nil,TZEObj); // sp�ter VPtr = Veranstaltung
  UrkDokListe                := TStringList.Create;
  UrkDokListe.Sorted         := false;
  UrkDokListe.Capacity       := cnUrkDokListeMax+1;
  WordUrkAkIndx              := -1;    // nicht definiert
  ZeitenBehalten             := true;

  MenueCommandActive := false;
  SetzeCommands;
  SuchenDialog := TSuchenDialog.Create(HauptFenster); // muss vor LeseKonfiguration

  Application.OnIdle := IdleEventHandler; //Am Ende, damit Handler nicht zu fr�h aufgerufen wird

  if not HelpDateiVerfuegbar then
    TriaMessage('Die Hilfe-Datei wurde nicht gefunden:' +#13+ chmFile,
                mtInformation,[mbOk]);
end;

(*============================================================================*)
destructor THauptFenster.Destroy;
(*============================================================================*)
begin
  // bei 2x Close Drucken kann Versanstaltung=nil sein
  if (Veranstaltung <> nil) then SpeichereKonfiguration;
  FreeAndNil(SuchenDialog); // muss nach SpeichereKonfiguration
  TriDatSchliessen(100); //nicht in FormClose, weil danach Berechnung noch weitergeht

  // f�r HTML-Help
  HHCloseAll;  // Schlie�t alle Hilfe-Fenster
  if Assigned(mhHelp) then FreeAndNil(mHHelp);

  ClearAllgAk;
  FreeAndNil(WettkAlleDummy);
  FreeAndNil(ZeitErfDateiListe);
  {FreeAndNil(SuchListe);
  FreeAndNil(ErsatzListe);}
  FreeAndNil(UrkDokListe);
  FreeAndNil(TriaStream);
  FreeAndNil(ProgVersion);
  FreeAndNil(TriDatei);
  FreeAndNil(MruListe);
  FreeAndNil(ReportWkListe);
  FreeAndNil(ReportAkListe);
  if ZECollOk<>nil then ZECollOk.DeleteItems; // nur Ptr l�schen
  if ZECollNOk<>nil then ZECollNOk.DeleteItems; // nur Ptr l�schen
  if ZEColl<>nil then FreeAndNil(ZEColl);

  Screen.Cursor := CursorAlt;
  inherited Destroy;
end;

(*============================================================================*)
procedure THauptFenster.Init;
(*============================================================================*)
// erste Initialisierung
// aufgerufen in :  LadeKonfiguration, TriDatNeu, TriDatOeffnen
begin
  // if Veranstaltung = nil then Exit;  nil soll erlaubt sein
  Refresh; (* wegen CB-dropdown-loch *)
  if Veranstaltung <> nil then InitOrtListe(Veranstaltung.Ort)
                          else InitOrtListe(nil);
  LstFrame.Init;
  CommandTrailer;
end;

{(*============================================================================*)
function THauptFenster.UhrZeit: Integer;
(*============================================================================*)
// in Sek
var
  DateTime : TDateTime;
  hh,mm,ss,ddd : Word;  // ddd = msec
begin
  DateTime := Time; // Aktuelles Datum und Uhrzeit
  DecodeTime(DateTime,hh,mm,ss,ddd);
  Result := ss + 60*mm + 3600*hh;
end;}

(*============================================================================*)
procedure THauptFenster.InitAnsicht(OrtNeu:TOrtObj; AnsichtNeu:TAnsicht;
                                    ModeNeu:TSortMode;
                                    WkNeu:TWettkObj; WrtgModeNeu:TWertungMode;
                                    SexNeu:TSex;AkNeu:TAkObj;StatusNeu:TStatus);
(*============================================================================*)
begin
  // Veranstaltung = nil ist erlaubt
  if (Ansicht=anAnmSammel) and (AnsichtNeu<>anAnmSammel) and
      not SMldFrame.Schliessen then
  begin
    LstFrame.RefreshAnsicht;
    Exit;
  end;
  InitOrtListe(OrtNeu);
  LstFrame.InitAnsicht(AnsichtNeu,ModeNeu,WkNeu,WrtgModeNeu,
                       SexNeu,AkNeu,StatusNeu);
  CommandTrailer;
end;

(*============================================================================*)
procedure THauptFenster.UpdateAnsicht;
(*============================================================================*)
begin
  if Veranstaltung = nil then Exit;
  InitOrtListe(Veranstaltung.Ort);
  LstFrame.UpdateAnsicht;
  CommandTrailer;
end;

(*============================================================================*)
procedure THauptFenster.RefreshAnsicht;
(*============================================================================*)
// nach �nderung in Veranstaltung-Collections, die vorher sortiert werden
// aufgerufen in VeranstDefinieren, VeranstOrtEingeben, WettkEingeben,
//               SGrpEingeben, TlnAnmelden, TlnBearbeiten, TlnEntfernen,
//               SortiereAnsicht, OrtCB.Change, SuchenDlg
// nicht benutzen im Dialoge solange WettkSortcollection noch benutzt wird
begin
  if Veranstaltung = nil then Exit;
  InitOrtListe(Veranstaltung.Ort);
  LstFrame.RefreshAnsicht;
  CommandTrailer;
end;

(*============================================================================*)
function THauptFenster.TlnAnsicht: Boolean;
(*============================================================================*)
begin
  Result := (Ansicht = anAnmEinzel) or
            (Ansicht = anAnmSammel) or
            (Ansicht = anTlnStart) or
            (Ansicht = anTlnErg) or
            (Ansicht = anTlnUhrZeit) or
            (Ansicht = anTlnRndKntrl) or
            (Ansicht = anTlnErgSerie) or
            (Ansicht = anTlnSchwDist);
end;

(*============================================================================*)
function THauptFenster.MschAnsicht: Boolean;
(*============================================================================*)
begin
  Result := (Ansicht = anMschStart) or
            (Ansicht = anMschErgDetail) or
            (Ansicht = anMschErgKompakt) or
            (Ansicht = anMschErgSerie);
end;

(*============================================================================*)
function THauptFenster.MeldeAnsicht: Boolean;
(*============================================================================*)
begin
  Result := (Ansicht = anAnmEinzel) or (Ansicht = anAnmSammel);
end;

(*============================================================================*)
procedure THauptFenster.ProgressBarInit(const Text:String; const MaxNeu:Int64);
(*============================================================================*)
// Position := 0
// Max bleibt cnProgressBarMax, nur var ProgressBarMax anpassen
// bei Store,Clear: Veranstaltung.ItemSize, Fortschritt nach Coll.ItemSize
// bei Sortieren:   Coll.ItemCount, Fortschritt per Item
// Progressbar wird auch beim Schliessen benutzt, dann Application=Terminated
begin
  //if Application.Terminated then Exit;
  ProgressBarText(Text);
  ProgressBar.Position := 0;
  ProgressBarMaxUpdate(MaxNeu);
  ProgressBar.Visible := true;
  Screen.Cursor := crHourGlass; // Cursor als Sanduhr, vor SetzeCommands
  SetzeCommands; // disable menue
  Application.ProcessMessages;
end;

(*============================================================================*)
procedure THauptFenster.ProgressBarMaxUpdate(const MaxNeu:Int64);
(*============================================================================*)
// var ProgressBarPosition und ProgressBarMax updaten.
// Max bleibt immer cnProgressBarMax(100), Position bleibt unver�ndert
// MaxNeu: aktuelle steps von Pos bis zum erreichen von Max.
// MaxNeu kann < Max(100) sein
// BarSize Werte bei Load:
//  TriaStream.Size, Fortschritt entspr. TriaStream.Position
//  Int64  (Integer-Max = 2.147.483.647, reicht nicht)
begin
  //if Application.Terminated then Exit;
  with ProgressBar do
  begin
    if (Position > 0) and (Position < Max) then
      ProgressBarMax := (MaxNeu * Max) DIV (Max - Position) // Max <> Position
    else
      ProgressBarMax := MaxNeu;
    if ProgressBarMax <= 0 then ProgressBarMax := cnProgressBarMax; // DIV durch 0 verhindern
    ProgressBarPos := (Position * ProgressBarMax) DIV cnProgressBarMax;
  end;
  Application.ProcessMessages;
end;

(*============================================================================*)
procedure THauptFenster.ProgressBarStep(Delta:Int64);
(*============================================================================*)
// Steps zun�chst nur in ProgressBarPos z�hlen
// 100/max % voreilen
//var StartZeit: DWord;
begin
  //if Application.Terminated then Exit;
  with ProgressBar do
  begin
    if not Visible then Exit;
    if (Delta > 0) and (Position < Max) then
    begin
      ProgressBarPos := ProgressBarPos + Delta;
      if ProgressBarPos > (Position * ProgressBarMax) DIV Max then // Max=100
      begin
        Position := 1 + (ProgressBarPos * Max) DIV ProgressBarMax; // Max > 0
        Position := Position - 1; // damit Pos in Vista angezeigt wird
        Position := Position + 1;
        Application.ProcessMessages;
        // slowmotion f�r test
        {StartZeit := GetTickCount;
        repeat
          Application.ProcessMessages;
        until GetTickCount > StartZeit + 100;}
      end;
    end;
  end;
end;

(*============================================================================*)
procedure THauptFenster.ProgressBarText(const Text: String);
(*============================================================================*)
begin
  //if Application.Terminated then Exit;
  StatusBar.Panels[0].Text := '';
  if Text <> '' then StatusBar.Panels[1].Text := ' '+Text+'...'
                else StatusBar.Panels[1].Text := '';
  Application.ProcessMessages;
end;

(*============================================================================*)
procedure THauptFenster.ProgressBarClear;
(*============================================================================*)
begin
  // f�r Test
  {if ProgressBar.Position < ProgressBar.Max then
    TriaMessage('Maximum Position von ProgressBar nicht erreicht:' +#13+
                '   Ist  = '+IntToStr(ProgressBar.Position) +#13+
                '   Soll = '+IntToStr(ProgressBar.Max),
                 mtInformation,[mbOk])
  else
    TriaMessage('Maximum Position von ProgressBar erreicht:' +#13+
                '   Max  = '+IntToStr(ProgressBar.Max),
                 mtInformation,[mbOk]); }

  ProgressBar.Visible     := false;
  ProgressBar.Position    := 0;
  ProgressBarStehenLassen := false;
end;

(*============================================================================*)
procedure THauptFenster.StatusBarText(const Text1,Text2: String);
(*============================================================================*)
begin
  //if Application.Terminated then Exit;
  if (' '+Text1) <> StatusBar.Panels[0].Text then
  begin
    StatusBar.Panels[0].Text := ' '+Text1;
    Application.ProcessMessages;
  end;
  if not Application.Terminated and
     ((' '+Text2) <> StatusBar.Panels[1].Text) then
  begin
    StatusBar.Panels[1].Text := ' '+Text2;
    Application.ProcessMessages;
  end;
end;

(*============================================================================*)
procedure THauptFenster.StatusBarUpdate;
(*============================================================================*)
var Text : String;
    i,j,Zahl1,Zahl2,Zahl3,Zahl4: Integer;
    SM: TSMldObj;
    Msch : TMannschObj;
begin
  //if Application.Terminated then Exit;
  if (ProgressBar.Visible = false) and
     (LstFrame.TriaGrid.Collection <> nil) and
     (Veranstaltung <> nil) then
    //with TVeranstObj(LstFrame.TriaGrid.Collection.VPtr) do
    // Liste nie von EinlVeran abgeleitet
  with Veranstaltung do
  begin
    if LiveZtErfAktiviert then
    begin
      StatusBarText('Live Zeiterfassung aktiviert','');
      Exit;
    end;
    if TlnAnsicht then
    begin
      if Ansicht = anAnmSammel then SM := SortSMld
                               else SM := nil;
      if SM = nil then Zahl1 := TlnColl.SortCount
                  else Zahl1 := SM.TlnListe.SortCount;
      Zahl2 := TlnColl.TlnZahl(SM,SortWettk,SortWrtg,SortKlasse,stGemeldet);
      Zahl3 := TlnColl.TlnZahl(SM,SortWettk,SortWrtg,AkAlle,stGemeldet);
      if SM = nil then Zahl4 := TlnColl.Count
                  else Zahl4 := SM.TlnListe.Count;
      Text  := '  Teilnehmer ';
    end else
    begin
      // Panel[1]: bei Multi alle MschIndx mitz�hlen, kann mehr sein als in panel2
      Zahl1 := 0;
      // auch in MschAnsicht werden Tln gelistet
      with MannschColl do
        for i:=0 to SortCount-1 do
        begin
          Msch := SortItems[i];
          for j:=0 to TlnColl.SortCount-1 do // pr�fen ob Msch in TlnSortColl
            if TlnColl.SortItems[j].MannschPtr(SortKlasse.Wertung) = Msch then
            begin
              Inc(Zahl1);
              Break;
            end;
        end;
      Zahl2 := MannschColl.MschAnzahl(SortWettk,SortKlasse); // stGemeldet, nur MschIndx=0
      Zahl3 := MannschColl.MschAnzahl(SortWettk,AkAlle);
      Zahl4 := MannschColl.MschAnzahl(WettkAlleDummy,AkAlle);
      Text  := '  Mannschaften ';
    end;
    StatusBar.Panels[0].Text := ' '+IntToStr(Zahl1)+Text+'in Liste';
    StatusBar.Panels[1].Text := ' '+IntToStr(Zahl2)+'  '+'in Klasse,  '+
                                    IntToStr(Zahl3)+'  '+'in Wettkampf,  '+
                                    IntToStr(Zahl4)+'  '+'insgesamt';
    //StatusBar.Refresh;
    Application.ProcessMessages;
  end;
end;

(*============================================================================*)
procedure THauptFenster.StatusBarClear;
(*============================================================================*)
begin
  //if Application.Terminated then Exit;
  ProgressBarClear;
  StatusBarText('','');
  Screen.Cursor := CursorAlt; // Alter Zustand wiederherstellen, vor SetzeCommands
  SetzeCommands; // enable menue
  StatusBarUpdate;  // incl. ProcessMessages
end;

(*============================================================================*)
procedure THauptFenster.UpdateCaption;
(*============================================================================*)
begin
  Caption := Application.Title;
  if (TriDatei<>nil) and (TriDatei.Path <> '') then
    Caption := Caption + '  -  ' + ExtractFileName(TriDatei.Path);
end;

//==============================================================================
procedure THauptFenster.CommandHeader;
//==============================================================================
// in try..finally Block
// MenueCommandActive vorher true und in finally false gesetzt
begin
  // Commands werden in PogressBarInit disabled.
  if ProgressBar.Visible then StatusBarClear;
  if Rechnen then BerechneRangAlleWettk; // sollte nicht vorkommen
  if not ActionMainMenuBar.PersistentHotKeys then
    ActionMainMenuBar.PersistentHotKeys:= true;
  Refresh; // komplettes Fenster Repaint
end;

//==============================================================================
procedure THauptFenster.CommandTrailer;
//==============================================================================
begin
  SetzeCommands;
  Refresh; // problem: kein komplettes Fenster Repaint
  LstFrame.TriaGrid.Refresh; // deshalb zus�tzlich diesen Befehl
  if LstFrame.TriaGrid.CanFocus then LstFrame.TriaGrid.SetFocus;
end;

//==============================================================================
procedure THauptFenster.CommandDataUpdate;
//==============================================================================
// LiveZtErfDatEinlesen beinhaltet TriDatAutoSpeichern und
// Berechnen/UpdateAnsicht wenn true.
// Doppelter UpdateAnsicht in dem Fall verhindern
begin
  if not LiveZtErfRequest or not LiveZtErfDatEinlesen then
  begin
    if AutoSpeichernRequest then TriDatAutoSpeichern;
    if not SofortRechnen or not Rechnen or not BerechneRangAlleWettk then
      UpdateAnsicht;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Men� Datei - Event Handler                                              *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.TriDatNeuActionExecute(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if Ansicht=anAnmSammel then
      if not SMldFrame.Schliessen then Exit
      else HauptFenster.AnmEinzelActionExecute(Sender);
    TriDatNeu('');
    // CommandTrailer;  in TriDatNeu
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.TriDatOeffnenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if Ansicht=anAnmSammel then
      if not SMldFrame.Schliessen then Exit
      else HauptFenster.AnmEinzelActionExecute(Sender);
    TriDatOeffnen;
    // CommandTrailer;  in TriDatOeffnen/TriDatNeu
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TriDatSpeichernActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if Ansicht=anAnmSammel then
      if not SMldFrame.Schliessen then Exit
      else HauptFenster.AnmEinzelActionExecute(Sender);
    TriDatSpeichern(100);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TriDatSpeichernUnterActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if Ansicht=anAnmSammel then
      if not SMldFrame.Schliessen then Exit
      else HauptFenster.AnmEinzelActionExecute(Sender);
    TriDatSpeichernUnter(100);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.ImportActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if Ansicht=anAnmSammel then
      if not SMldFrame.Schliessen then Exit
      else HauptFenster.AnmEinzelActionExecute(Sender);
    DatenImportieren;
    ProgressBarStehenLassen := false;
    if LstFrame.TriaGrid.CanFocus then LstFrame.TriaGrid.SetFocus;
    // Berechnen in ImpFrm.Schliessen oder ImpDlg.ImportiereDatei()
  finally
    if not ImpFrame.Visible then MenueCommandActive := false;
    // sonst in ImportDialog.Schliessen zur�cksetzen
  end;
end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.MruActionExecute(Sender: TObject);
var
  Idx : Integer;
  Pfad : String;
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if Ansicht=anAnmSammel then
      if not SMldFrame.Schliessen then Exit
    else HauptFenster.AnmEinzelActionExecute(Sender);
    if Sender = MruAction1 then Idx := 1
    else if Sender = MruAction2 then Idx := 2
    else if Sender = MruAction3 then Idx := 3
    else if Sender = MruAction4 then Idx := 4
    else if Sender = MruAction5 then Idx := 5
    else if Sender = MruAction6 then Idx := 6
    else if Sender = MruAction7 then Idx := 7
    else if Sender = MruAction8 then Idx := 8
    else Idx := -1;
    Pfad := MruListe[Idx];
    if Pfad <> '' then TriDatNeu(Pfad);
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.BeendenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if Ansicht=anAnmSammel then
      if not SMldFrame.Schliessen then Exit
      else HauptFenster.AnmEinzelActionExecute(Sender);
    Close;
  finally
    MenueCommandActive := false; // fals Exit nach SMldFrame.Schliessen
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Men� Veranstaltung - Event Handler                                      *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.VeranstaltungActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    VeranstaltungDefinieren;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.WettkaempfeActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    WettkEingeben;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.SerWrtgActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    SerWrtgDefinieren;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.StartgruppenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    SGrpEingeben;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.KlassenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    KlassenDefinieren;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Men� Teilnehmer - Event Handler                                         *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TlnBearbeitenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    TlnBearbeiten(HauptFenster.SortSMld);
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TlnHinzufuegenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if Ansicht = anAnmSammel then
    begin
      if SortMode <> smTlnName then // neu Sortieren
        InitAnsicht(FSortOrt,Ansicht,smTlnName,
                    SortWettk,SortWrtg,SortSex,SortKlasse,SortStatus);
      TlnAnmelden(HauptFenster.SortSMld)
    end else
    begin
      if Ansicht <> anAnmEinzel then
        AnmEinzelActionExecute(Sender) //SortMode=smTlnName
      else
      if SortMode <> smTlnName then // neu Sortieren
        InitAnsicht(FSortOrt,Ansicht,smTlnName,
                    SortWettk,SortWrtg,SortSex,SortKlasse,SortStatus);
      TlnAnmelden(nil);
    end;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TlnEntfernenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    TlnEntfernen;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.TlnEinteilenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    TlnEinteilen(emEinteilen);
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.EinteilungLoeschenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    TlnEinteilen(emLoeschen);
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.RfidCodeActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    RfidEinlesen;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.SuchenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    //CommandHeader;
    SuchenErsetzen(seSuchen);
    //CommandTrailer;
    //if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
{procedure THauptFenster.SuchWeiterActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    SucheWiederholen(LstFrame.TriaGrid.ItemIndex);
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;}
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.ErsetzenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    //CommandHeader;
    SuchenErsetzen(seErsetzen);
    //CommandTrailer;
    //if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.TlnDisqualActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    TlnDisqualifizieren;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Men� Zeitnahme - Event Handler                                          *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.ZtErfEinlActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ZeitErfassung;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.LiveEinlesenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    LiveZeitErfassung;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.ZeitLoeschenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ZtErfLoeschen;
    CommandTrailer;
    if Rechnen then BerechneRangAlleWettk;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Men� Ansicht - Event Handler                                            *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

procedure THauptFenster.AnmEinzelActionExecute(Sender: TObject);
// au�er Ansicht nur {SortMode und} Status �ndern
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InitAnsicht(FSortOrt,anAnmEinzel,SortMode,
                SortWettk,SortWrtg,SortSex,SortKlasse,stGemeldet);
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.AnmSammelActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InitAnsicht(FSortOrt,anAnmSammel,SortMode,
                SortWettk,SortWrtg,SortSex,SortKlasse,stGemeldet);
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TlnStartActionExecute(Sender: TObject);
var Wk: TWettkObj;
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    // neue Startliste nicht f�r WettkAlleBuf �ffnen
    Wk := SortWettk;
    with Veranstaltung.WettkColl do
    if (Ansicht <> anTlnStart) and
       (Wk = WettkAlleDummy) and (Count > 0) then Wk := Items[0];
    InitAnsicht(FSortOrt,anTlnStart,smTlnSnr,
                                Wk,SortWrtg,SortSex,SortKlasse,stEingeteilt);
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TlnErgActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    // default mit disq. Tln.
    InitAnsicht(FSortOrt,anTlnErg,smTlnErg,
                SortWettk,SortWrtg,SortSex,SortKlasse,stGewertetDisq);
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TlnUhrZeitActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InitAnsicht(FSortOrt,anTlnUhrZeit,smTlnAbs1Startzeit,
                SortWettk,SortWrtg,SortSex,SortKlasse,stZeitVorhanden);
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TlnRndKntrlActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InitAnsicht(FSortOrt,anTlnRndKntrl,smTlnAbsRnd,
                SortWettk,SortWrtg,SortSex,SortKlasse,stAbs1Zeit);
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TlnErgSerieActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InitAnsicht(FSortOrt,anTlnErgSerie,smTlnSerErg,
                SortWettk,SortWrtg,SortSex,SortKlasse,stSerEndWertung);
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.MschStartActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InitAnsicht(FSortOrt,anMschStart,smMschName,
                SortWettk,SortWrtg,SortSex,SortKlasse,stEingeteilt);
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.MschErgDetailActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InitAnsicht(FSortOrt,anMschErgDetail,smMschErg,
                SortWettk,SortWrtg,SortSex,SortKlasse,stGewertet);
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.MschErgKompaktActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InitAnsicht(FSortOrt,anMschErgKompakt,smMschErg,
                SortWettk,SortWrtg,SortSex,SortKlasse,stGewertet);
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.MschErgSerieActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InitAnsicht(FSortOrt,anMschErgSerie,smMschSerErg,
                SortWettk,SortWrtg,SortSex,SortKlasse,stSerEndWertung);
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TlnSchwBhnActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InitAnsicht(FSortOrt,anTlnSchwDist,smTlnSBhn,
                SortWettk,SortWrtg,SortSex,SortKlasse,stEingeteilt);
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Men� Drucken - Event Handler                                            *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
{procedure THauptFenster.DruckEinrichtenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    DruckerEinstellungen;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;}
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.ListeDruckActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ListAusgabe(rmDrucken);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.VorschauActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ListAusgabe(rmVorschau);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.PDFDateiActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ListAusgabe(rmPDFDatei);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.HTMLDateiActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ListAusgabe(rmHTMLDatei);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.ExcelDateiActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ListAusgabe(rmExcelDatei);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.WordUrkundeActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    WordUrkunde(rmWordUrk);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.TextDateiActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ListAusgabe(rmTextDatei);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.UrkTextDateiActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ListAusgabe(rmSerDrUrk);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.EtikTxtDateiActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ListAusgabe(rmSerDrEtiketten);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Men� Extras - Event Handler                                         *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.UpdateActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    InternetUpdate(umManuell);
    if SetupGestartet then Close
    else CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.OptionenActionExecute(Sender: TObject);
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    Optionen;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    Men� Hilfe - Event Handler                                              *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.HilfeActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    Application.HelpContext(0100);  // �bersicht
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.TriaImWebExecute(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ShellExecute(Application.Handle,'open',PChar(cnHomePage),
                 nil,nil, sw_ShowNormal);
    // keine Fehlermeldung (wenn Result <= 32)
    CommandTrailer; //Tria bleibt im Hintergrund !!
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.InfoActionExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ZeigeInfo;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
(*    ToolBar - Event Handler                                                 *)
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.OrtCBlabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    with OrtCB do
      if CanFocus then
      begin
        SetFocus;
        DroppedDown := true;
      end;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.OrtCBChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    //Refresh;
    Veranstaltung.OrtIndex := OrtCB.ItemIndex;
    // OrtIndex wird in Ini-datei statt TriDatei gespeichert
    //TriDatei.Modified := true; //vor Init wegen Speichern-ToolButton
    InitAnsicht(GetSortOrt,Ansicht,SortMode,SortWettk,SortWrtg,
                SortSex,SortKlasse,SortStatus);
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.ComboBoxCloseUp(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  LstFrame.AnsFrame.ComboBoxCloseUp(Sender);
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.ComboBoxKeyPress(Sender: TObject; var Key: Char);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  LstFrame.AnsFrame.ComboBoxKeyPress(Sender,Key);
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// nach AutoUpdate BeendenAction = disabled
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    if not BeendenAction.Enabled and not SetUpGestartet then
      CanClose := false
    else
    if Ansicht=anAnmSammel then
    begin
      if SMldFrame.Schliessen then AnmEinzelActionExecute(Sender);
      CanClose := false;
    end else
    if ImpFrame.Visible then
    begin
      ImpFrame.Schliessen;
      CanClose := false;
    end else
    if PrevFrame.Visible then
    begin
      PrevCloseExecute(Sender);
      CanClose := false;
    end;
  finally
    if not CanClose then MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.FormClose(Sender: TObject; var Action: TCloseAction);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader; // MenueCommandActive bleibt true in FormCloseQuery
    ProgressBarStehenLassen := true;
    {if (Veranstaltung <> nil) and not DateiSichern(50) then
    begin
      HauptFenster.ProgressBarStehenLassen := false;
      HauptFenster.StatusBarClear;
      Action := caNone;
    end else
      Action := caFree; // auch bei exceptions in soll beendet werden.}

    if (Veranstaltung <> nil) and TriDatei.Modified then
      case TriaMessage('�nderungen in Datei  "'+TriDatei.Path+'"  speichern?',
                       mtConfirmation, [mbYes, mbNo, mbCancel]) of
        mrYes: if TriDatSpeichern(50) then
                 Action := caFree // ==> schliessen
               else
               begin
                 ProgressBarStehenLassen := false;
                 StatusBarClear;
                 Action := caNone; // nicht schliessen
               end;
        mrNo:  begin
                 ProgressBarStehenLassen := false;
                 // Init hier vorziehen, weil es sp�ter nicht funktioniert (Application=terminated)
                 ProgressBarInit('Datei  "'+TriDatei.Path+'"  wird geschlossen',
                                  Veranstaltung.ObjSize);
                 Action := caFree; // ==> schliessen
               end;
        else   begin
                 ProgressBarStehenLassen := false;
                 StatusBarClear;
                 Action := caNone; // nicht schliessen
               end;
      end else
      begin
        if Veranstaltung <> nil then
        begin
          // ProgressBarInit hier vorziehen, weil es sp�ter nicht funktioniert (Application=terminated)
          ProgressBarStehenLassen := false;
          ProgressBarInit('Datei  "'+TriDatei.Path+'"  wird geschlossen',
                          Veranstaltung.ObjSize);
        end;
        Action := caFree; // ==> schliessen
      end;

  finally
    MenueCommandActive := false; // immer
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.FormShow(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// OnShow-Event benutzen, weil in Create noch keine Handles verf�gbar sind
var R: TRect;
begin
  // SatusBar in Panel 0
  StatusBar.Perform(SB_GETRECT,0,Integer(@R));
  ProgressBar.Parent := StatusBar;
  ProgressBar.Top    := R.Top+1;
  ProgressBar.Left   := R.Left+1;
  ProgressBar.Width  := R.Right - R.Left - 2;
  ProgressBar.Height := R.Bottom - R.Top - 2;

  FocusControl(nil);
  if LstFrame.TriaGrid.CanFocus then LstFrame.TriaGrid.SetFocus;
  StatusBarUpdate;
  // Tria Setup abbrechen, wenn Tria ausgef�hrt wird
  // gleicher MutexName in Inno Setup verwenden
  CreateMutex(nil, False, 'TriaMutexName');
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure THauptFenster.UhrzeitTimerTick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// cnTriTimerInterval = 200; // 200 mSek
// hier wird nur gespeichert/ eingelesen, wenn kein Command aktiv ist
// Wenn Command aktiv, dann nur Request setzen. Ausf�hrung der Aktion w�hrend
// Command-Ausf�hrung zum geschickten Zeitpunkt

begin
  if Application.Terminated or NeuStart or UhrZeitTimerTickDisabled then Exit;
  UhrZeitTimerTickDisabled := true; // Funktionen komplett abschlie�en

  // Zeit nur 1x auslesen
  ZeitAktuell := GetTickCount; // Zeiten in mSek
  if ZeitDatGespeichert = 0 then // ZeitAktGespeichert initialisieren
    ZeitDatGespeichert := ZeitAktuell; // Interval neu gestartet

  // Live Zeiterfassung
  // Zuerst LiveZtErfDatEinlesen, beinhaltet Berechnen und AutoSpeichern
  if LiveZtErfAktiviert and ZtErfDatGeAendert and
     (ZeitAktuell >= ZtErfDatGelesen + cnLiveZtErfInterval) then
    LiveZtErfRequest := true
  else LiveZtErfRequest := false;
  if LiveZtErfRequest and not MenueCommandActive then
    LiveZtErfDatEinlesen; // LiveZtErfRequest zur�ckgesetzt

  // AutoSpeichern
  if (AutoSpeichernInterval > 0) and TriDatei.Modified and
     (ZeitAktuell >= ZeitDatGespeichert + AutoSpeichernInterval) then
    AutoSpeichernRequest := true
  else AutoSpeichernRequest := false;
  if AutoSpeichernRequest and not MenueCommandActive then
    TriDatAutoSpeichern; // AutoSpeichernRequest zur�ckgesetzt

  UhrZeitTimerTickDisabled := false;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.PrevStartExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  with PrevFrame do PrevSeiteEdit.Text := IntToStr(PrevUpDown.Min);//OnChange Event
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.PrevBackExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  with PrevFrame do
    if SeiteAktuell > PrevUpDown.Max then
      PrevSeiteEdit.Text:=IntToStr(PrevUpDown.Max)
    else
    if SeiteAktuell < PrevUpDown.Min then
      PrevSeiteEdit.Text:=IntToStr(PrevUpDown.Min)
    else
      PrevSeiteEdit.Text:=IntToStr(Max(SeiteAktuell-1,PrevUpDown.Min));//OnChange Event
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.PrevNextExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  with PrevFrame do
    if SeiteAktuell > PrevUpDown.Max then
      PrevSeiteEdit.Text:=IntToStr(PrevUpDown.Max)
    else
    if SeiteAktuell < PrevUpDown.Min then
      PrevSeiteEdit.Text:=IntToStr(PrevUpDown.Min)
    else
      PrevSeiteEdit.Text:=IntToStr(Min(SeiteAktuell+1,PrevUpDown.Max));//OnChange Event
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.PrevLastExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  with PrevFrame do PrevSeiteEdit.Text := IntToStr(PrevUpDown.Max);//OnChange Event
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.PrevDruckenExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ListAusgabe(rmPrevDrucken);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.PrevPdfDateiExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ListAusgabe(rmPrevPDFDatei);
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure THauptFenster.PrevCloseExecute(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// nur BeendenAction enabled
begin
  MenueCommandActive := true;
  try
    CommandHeader;
    ReportVorschauSchliessen;
    CommandTrailer; // Commands wieder enabeln
  finally
    MenueCommandActive := false;
  end;
end;


end.
