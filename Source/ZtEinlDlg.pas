unit ZtEinlDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, DateUtils, Buttons, ComCtrls, Mask,
  AllgComp,AllgConst,AllgFunc,AllgObj,WettkObj,TlnObj;

procedure ZeitErfassung;
procedure LiveZeiterfassung;
function  LiveZtErfDatEinlesen: Boolean;
function  ZtErfAbschnString: String;
function  ZtErfDatGeAendert: Boolean;

const dBaseHeaderEnde     = 13;
      dBaseFeldZahlMax    = 16;
      dBaseFeldLaengeMax  = 254; {Bytes}

type
  TZtEinlDialog = class(TForm)
    DateiLabel: TLabel;
    DateiCB: TComboBox;
    DateiBtn: TBitBtn;
    FormatGB: TGroupBox;
      HeaderCB: TCheckBox;
      FormatCB: TComboBox;
      FormatLabel: TLabel;
      SnrPosLabel1: TLabel;
      SnrPosLabel2: TLabel;
      SnrPosEdit: TTriaMaskEdit;
      SnrPosUpDown: TTriaUpDown;
      ZeitPosLabel1: TLabel;
      ZeitPosLabel2: TLabel;
      ZeitPosEdit: TTriaMaskEdit;
      ZeitPosUpDown: TTriaUpDown;
      ZeitFormLabel: TLabel;
      ZeitFormCB: TComboBox;
      TrennZeichenLabel: TLabel;
      TrennZeichenCB: TComboBox;
      TrennZeitLabel: TLabel;
      TrennZeitCB: TComboBox;
    WettkLabel: TLabel;
    WettkCB: TComboBox;
    EinzelStartGB: TGroupBox;
      EinzelStartCB: TCheckBox;
    AbschnittGB: TGroupBox;
      Abschn1CB: TCheckBox;
      Abschn1Edit: TTriaEdit;
      Abschn2CB: TCheckBox;
      Abschn2Edit: TTriaEdit;
      Abschn3CB: TCheckBox;
      Abschn3Edit: TTriaEdit;
      Abschn4CB: TCheckBox;
      Abschn4Edit: TTriaEdit;
      Abschn5CB: TCheckBox;
      Abschn5Edit: TTriaEdit;
      Abschn6CB: TCheckBox;
      Abschn6Edit: TTriaEdit;
      Abschn7CB: TCheckBox;
      Abschn7Edit: TTriaEdit;
      Abschn8CB: TCheckBox;
      Abschn8Edit: TTriaEdit;
    ZeitenBehaltenCB: TCheckBox;
    LetzterTlnCB: TCheckBox;
    OkButton: TButton;
    CancelButton: TButton;
    HilfeButton: TButton;
    procedure DateiBtnClick(Sender: TObject);
    procedure WettkLabelClick(Sender: TObject);
    procedure WettkCBChange(Sender: TObject);
    procedure AbschnEditClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure DateiLabelClick(Sender: TObject);
    procedure FormatLabelClick(Sender: TObject);
    procedure FormatCBChange(Sender: TObject);
  protected
    HelpFensterAlt: TWinControl;
    AbschnCB   : array[wkAbs1..wkAbs8] of TCheckBox;
    AbschnEdit : array[wkAbs1..wkAbs8] of TTriaEdit;
    DisableButtons : Boolean;
    procedure InitFormatCB(FormatNeu: TTrzDateiFormat);
    function  GetTrzDateiFormat: TTrzDateiFormat;
    procedure InitDateiCB;
    function  GetTrennZeichen: String;
    procedure SetTrennZeichen(S:String);
    procedure InitFormatGB;
    function  GetZeitTrennzeichen: String;
    procedure SetZeitTrennzeichen(TrennzeichenNeu:String);
    function  GetZeitFormat: TZeitFormat;
    procedure SetZeitFormat(ZtFormatNeu:TZeitFormat);
    function  GetWettk: TWettkObj;
    procedure SetAbschnitt;
    function  SetAbschnArr: Boolean;
    function  DateiIndx(DatName: String): Integer;
    procedure UpdateDateiListe(DatName: String);
    procedure ZtErfDateiOeffnen;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

  TZEObj = class(TTriaObj)
  public
    Snr         : Integer;
    RfidCode    : String;
    EinleseZeit : Integer; // ungeänderte Zeit in 1/100
    UebernZeit  : Integer; // gerundete Zeit in 1/100 für Report
    Runde       : Integer;
    Abschn      : TWkAbschnitt;
    KommStr     : String;
    ZEFehler    : TZEFehler;
    Tln         : TTlnObj;
    constructor Create(Veranst:Pointer; Coll:TTriaObjColl;Add:TOrtAdd); override;
    function    ObjSize: Integer; override;
    procedure   Init(SnrNeu:Integer;RfidNeu:String;ZeitNeu:Integer;KommStrNeu:String);
    procedure   OrtCollAdd; override;
    procedure   OrtCollClear(Indx:Integer); override;
    procedure   OrtCollExch(Idx1,Idx2:Integer); override;
    //procedure   Pruefen{(Disziplin:Integer)};
    procedure   Einlesen;
  end;

  TZEColl = class(TTriaObjColl)
  protected
    function    GetPItem(Indx:Integer): TZEObj;
    procedure   SetPItem(Indx:Integer; Item:TZEObj);
    function    GetSortItem(Indx:Integer): TZEObj;
  public
    constructor Create(Veranst:Pointer;ItemClass:TTriaObjClass);
    function    SortString(Item: Pointer): String; override;
    function    AddSortItem(Item: Pointer): Integer; override;
    procedure   Einlesen;
    function    TlnEintraege(SortIndx:Integer): Integer;
    function    ItemVorhanden(ZEObj:TZEObj): Boolean;
    function    DoppelEintrag(SnrNeu,Zeit:Integer;RfidNeu:String): Boolean;
    property    Items[Indx: Integer]: TZEObj read GetPItem write SetPItem; default;
    property    SortItems[Indx:Integer]:TZEObj read GetSortItem;
  end;

  TdBaseDateiInfoRec = record
    Version        : Byte;
    Jahr           : Byte;
    Monat          : Byte;
    Tag            : Byte;
    RecordZahl     : LongInt;
    VorspannLaenge : Word;
    RecordLaenge   : Word;
    Reserviert     : array[1..20] of AnsiChar;
  end;

  TdBaseFeldInfoRec = record
    FeldName     : array[1..10] of AnsiChar;
    Reserviert_1 : Byte;
    Feldtype     : AnsiChar;
    Reserviert_2 : array[1..4] of AnsiChar;
    FeldLaenge   : Byte;
    Dezimalen    : Byte;
    Reserviert_3 : array[1..14] of AnsiChar;
  end;

  TdBaseFeldInfoObj = class(TTriaObj)
  public
    FeldName     : String[10];
    FeldType     : AnsiChar;
    FeldLaenge   : Byte;
    Dezimalen    : Byte;
    constructor Create(Veranst:Pointer;Coll:TTriaObjColl;Add:TOrtAdd); override;
    function    ObjSize: Integer; override;
    procedure   Init(NameNeu:ShortString;TypeNeu:AnsiChar;LaengeNeu,DeziNeu:Byte);
    procedure   OrtCollAdd; override;
    procedure   OrtCollClear(Indx:Integer); override;
    procedure   OrtCollExch(Idx1,Idx2:Integer); override;
  end;

  TdBaseFeldInfoColl = class(TTriaObjColl)
  public
    function    SortString(Item: Pointer): String; override;
  end;

  TCharArray = array[0..dBaseFeldLaengeMax] of AnsiChar;
  TFeldArray = array[0..dBaseFeldZahlMax] of TCharArray;

var ZEColl,
    ZECollOk,
    ZECollNOk         : TZEColl; // Create und Free in TriaMain
    dBaseFeldInfoColl : TdBaseFeldInfoColl;
    ZtEinlDialog      : TZtEinlDialog;
    ZtErfWettkampf    : TWettkObj;
    //ZtErfStartZeit    : Integer; // erste Startzeit in Wettk für Zeit-Sortierung
    ZtErfAbschnArr    : array[wkAbs0..wkAbs8] of Boolean;
    ZtErfDateiName    : String;
    DoppelEintraege   : Integer;
    LiveErfDlg        : Boolean;
    ZtErfDatLetztChangeTime : TDateTime; // 0 = 30.12.1899 12.00 Uhr
    LetzterWettkTln   : TTlnObj;
    LetzterTlnFocus   : Boolean = true;

implementation

uses TriaMain,VeranObj, DateiDlg, ZtEinlRep,TlnErg,VistaFix;

{$R *.dfm}

function  ZtErfDatEinlesen: Boolean; forward;
function  dBaseDateiLaden: Boolean; forward;
function  ZeitDateiLaden: Boolean; forward;
function  dBaseSnrIntUmw(Feld:TdBaseFeldInfoObj;S:AnsiString):Integer; forward;
function  dBaseSnrStrUmw(Feld:TdBaseFeldInfoObj;S:AnsiString):String; forward;
function  dBaseZeitIntUmw(Feld:TdBaseFeldInfoObj;S1:AnsiString):Integer; forward;
function  TlnDoppelEintrag(Tln:TTlnObj;Zeit:Integer): Boolean; forward;
function  LiveZtErfStoppen: Boolean; forward;
function  LiveZtErfStarten: Boolean; forward;
function  ZtErfMessage(const Msg:String;DlgType:TMsgDlgType;Buttons:TMsgDlgButtons):Integer; forward;


//******************************************************************************
function ZtErfMessage(const Msg:String;DlgType:TMsgDlgType;Buttons:TMsgDlgButtons):Integer;
//******************************************************************************
begin
  with HauptFenster do
    if LiveZtErfAktiviert then
    begin
      if ProgressBar.Visible then StatusBarClear;
      if LiveZtErfFehler > cnLiveZtErfFehlerMax then
        StatusBarText('Live Zeiterfassung aktiviert',Msg);
      Result := mrOk
    end else
      Result := TriaMessage(Msg,DlgType,Buttons);
end;

//******************************************************************************
function  ZtErfDatGeAendert: Boolean;
//******************************************************************************
// nur für Live Zeiterfassung
// auch: Result := CompareDateTime(LiveZtErfLetztChange, ZeitNeu) <> EqualsValue
var ChangeTimeNeu : TDateTime;
begin
  if FileAge(ZtErfDateiName,ChangeTimeNeu) then // Zugriff Ok
  begin
    LiveZtErfFehler := 0;
    HauptFenster.StatusBarClear; // Text 'Live Zeiterfassung aktiviert' bleibt
    Result := not SameDateTime(ZtErfDatLetztChangeTime, ChangeTimeNeu);
    //if Result then HauptFenster.StatusBarClear;
  end else
  begin
    Result := false; // keine Aktion, Fehlermeldung wenn > LiveZtErfFehlerMax
    if LiveZtErfFehler > cnLiveZtErfFehlerMax then
      ZtErfMessage('Fehler beim Zugriff auf die Datei  "'+ZtErfDateiName+'".',
                    mtInformation,[mbOk])
    else Inc(LiveZtErfFehler);
  end;
end;

(******************************************************************************)
procedure ZeitErfassung;
(******************************************************************************)
begin
  if HauptFenster.LiveZtErfAktiviert and not LiveZtErfStoppen then Exit;

  LiveErfDlg   := false;
  ZtEinlDialog := TZtEinlDialog.Create(HauptFenster);
  try
    ZtEinlDialog.ShowModal;
  finally
    FreeAndNil(ZtEinlDialog);
  end;
  HauptFenster.RefreshAnsicht;
end;

//******************************************************************************
procedure LiveZeiterfassung;
//******************************************************************************
// wenn LiveZtErfassung aktiv dann Stoppen, sonst Starten
begin
  if HauptFenster.LiveZtErfAktiviert then LiveZtErfStoppen
  else // Live Zeiterfassung Starten
  begin
    LiveErfDlg   := true;
    ZtEinlDialog := TZtEinlDialog.Create(HauptFenster);
    try
      ZtEinlDialog.ShowModal;
    finally
      FreeAndNil(ZtEinlDialog);
    end;
  end;
  HauptFenster.RefreshAnsicht;
end;

//******************************************************************************
function LiveZtErfStoppen: Boolean;
//******************************************************************************
begin
  with HauptFenster do
    if LiveZtErfAktiviert then // sonst keine Aktion
      if TriaMessage('Möchten Sie die Live Zeiterfassung abbrechen?',
                      mtConfirmation,[mbYes,mbNo]) = mrYes then
      begin
        LiveEinlesenAction.Caption := '&Live Zeiterfassung starten...';
        LiveZtErfAktiviert := false;
        LiveZtErfFehler := 0;
        StatusBarClear;
        Result := true
      end else Result := false
    else Result := true;
end;

//******************************************************************************
function LiveZtErfStarten: Boolean;
//******************************************************************************
// vom Dialog (Ok-Button) ausgeführt
begin
  Result := false;
  LiveZtErfFehler := 0;
  with HauptFenster do
  begin
    if ZtErfDatEinlesen then // 1x einlesen mit Fehlermeldungen und Report
    begin
      Result := true;
      LiveEinlesenAction.Caption := '&Live Zeiterfassung stoppen';
      LiveZtErfAktiviert := true; // StatusBarText('Live Zeiterfassung aktiviert','');
    end else
      TriaMessage('Die Live Zeiterfassung konnte nicht gestartet werden.',
                   mtInformation,[mbOk]);
    StatusBarClear;
  end;
end;

//******************************************************************************
function ZtErfAbschnString: String;
//******************************************************************************
var Abs : TWkAbschnitt;
begin
  Result := '';
  for Abs:=wkAbs0 to wkAbs8 do
    if ZtErfAbschnArr[Abs] then
      if Abs=wkAbs0 then Result := 'Einzelstart'
      else
      if Result = '' then Result := 'Abschn. '+ IntToStr(Integer(Abs))
      else
      if Result = 'Einzelstart' then Result := Result + ', Abschn. '+ IntToStr(Integer(Abs))
      else
      Result := Result + ', ' + IntToStr(Integer(Abs));
end;

//******************************************************************************
function LiveZtErfDatEinlesen: Boolean;
//******************************************************************************
begin
  if ZtErfDatEinlesen then // Fehlermeldung wenn LiveZtErfFehler > cnLiveZtErfFehlerMax
  begin
    LiveZtErfFehler := 0; // Fehlerzahl nach erfolgreicher Zugriff zurücksetzen
    HauptFenster.StatusBarClear;
    Result := true;
  end else
  begin
    // im Fehlerfall weitermachen, aber evtl. Fehlermeldung stehen lassen
    Inc(LiveZtErfFehler);
    Result := false;
  end;
  LiveZtErfRequest := false;
  //else HauptFenster.LiveZtErfAktiviert := false // im Fehlerfall abschalten}
end;

(******************************************************************************)
function ZtErfDatEinlesen: Boolean;
(******************************************************************************)
var ChangeTimeNeu,
    ChangeTimeAlt : TDateTime;
    i : Integer;
    AbsCnt : TWkAbschnitt;
    ZEObj  : TZEObj;
begin
  Result := false;
  LetzterWettkTln := nil;

  if not FileAge(ZtErfDateiName,ChangeTimeAlt) then
  begin // beim nächsten TimerTick wieder versuchen, oder Fehlermeldung
    ZtErfMessage('Fehler beim Zugriff auf die Datei  "'+ZtErfDateiName+'".',
                  mtInformation,[mbOk]);
    Exit;
  end;

  DoppelEintraege := 0;
  try
    ZECollOk.DeleteItems; //Items in ZEColl erhalten
    ZECollNOk.DeleteItems; //Items in ZEColl erhalten
    ZEColl.Clear;
    case ZtErfDateiFormat of
      fzTriaZeit,
      fzZerf,
      fzGis,
      fzSportronic,
      fzDAG,
      fzMandigo,
      fzSonstig     : if not ZeitDateiLaden then Exit; // Daten in ZEColl speichern
      fzTCBacknang  : if not dBaseDateiLaden then Exit; // fehlermeldung ??
    end;

    // prüfen ob Änderungsdatum während des Lesevorgangs geändert wurde
    if FileAge(ZtErfDateiName,ChangeTimeNeu) then
      if not SameDateTime(ChangeTimeAlt, ChangeTimeNeu) then
      begin
        ZtErfMessage('Zugriffskonflikt beim Lesen der Datei  "'+ZtErfDateiName+'".',
                      mtInformation,[mbOk]);
        Exit;
      end else // Ok, Date nicht geändert
    else // beim nächsten TimerTick wieder versuchen, oder Fehlermeldung
    begin
      ZtErfMessage('Fehler beim Zugriff auf die Datei  "'+ZtErfDateiName+'".',
                    mtInformation,[mbOk]);
      Exit;
    end;

    // alle Eingaben nach Zeit sortiert in ZEColl
    if ZEColl.Count = 0 then
    begin
      ZtErfMessage('Die Datei  "'+ZtErfDateiName+'"  ist Leer.',
                    mtInformation,[mbOk]);
      if LiveErfDlg then Result := true; // bei Live nur warnen
      Exit;
    end;

    HauptFenster.LstFrame.TriaGrid.StopPaint := true;
    try

      // bisherige Zeiten behalten oder löschen
      if not ZeitenBehalten then
      begin
        for i:=0 to Veranstaltung.TlnColl.Count-1 do
          with Veranstaltung.TlnColl[i] do
            if (ZtErfWettkampf = WettkAlleDummy) or (ZtErfWettkampf = Wettk) then
              for AbsCnt:=wkAbs0 to wkAbs8 do
                if ZtErfAbschnArr[AbsCnt] then
                  ErfZeitenLoeschen(AbsCnt);
        ZtErfWettkampf.ErgModified := true; // immer, unabhängig vom Status
        TriDatei.Modified := true;
      end;

      // Prüfen: wenn Ok in ZECollOk, wenn Fehler in ZECollNOk
      for i:=0 to ZEColl.Count-1 do
      begin
        ZEObj := ZEColl[i];
        with ZEObj do
        begin
          // Daten prüfen, ZEFehler setzen
          if ZECollOk.DoppelEintrag(Snr,EinleseZeit,RfidCode) or
             ZECollNOk.DoppelEintrag(Snr,EinleseZeit,RfidCode) then
            ZEFehler := zeZeitFilter // Ignorieren, Zeitgleich oder fast Zeitgleich
          else
          if not RfidModus and (Snr = 0) then // RfidCode bereits vorher geprüft
            ZEFehler := zeSnrFehlt
          else
          if EinleseZeit < 0 then
            ZEFehler := zeZeitFehlt  // Zeit=0 ist gültige Uhrzeit
          else
          begin
            if RfidModus then
              Tln := Veranstaltung.TlnColl.TlnMitRfid(RfidCode)
            else
              Tln := Veranstaltung.TlnColl.TlnMitSnr(Snr);
            if Tln = nil then
              ZEFehler := zeTlnUnbekannt
            else
            with Tln do
              if SGrp = nil then
                ZEFehler := zeSGrpUnbekannt // sollte nicht vorkommen
              else
              begin
                // prüfen ob bereits eingelesen, egal welcher Abschnitt
                for AbsCnt:=wkAbs1 to wkAbs8 do
                  if AbsZeitEingelesen(AbsCnt,EinleseZeit) then
                  begin
                    ZEFehler := zeZeitEingelesen; // gleiche Zeit wird nicht nochmals Eingelesen
                    Break; // Fehler
                  end;
                if ZEFehler <> zeZeitEingelesen then
                  if ZECollOk.ItemVorhanden(ZEObj) or ZECollNOk.ItemVorhanden(ZEObj) then
                    ZEFehler := zeItemDoppelt // Fehler, nur möglich wenn kein Zeitfilter
                  else
                  if TlnDoppelEintrag(Tln,EinleseZeit) then //hier werden eingelesene Zeiten mit erfasst
                    ZEFehler := zeZeitFilter // Ignorieren
                  else
                  if (ZtErfWettkampf<>WettkAlleDummy) and (ZtErfWettkampf<>Wettk) then
                    ZEFehler := zeNichtInWettk;
                  // else Snr und Zeit gültig
                  // Runden-Überlauf-Prüfung in sortierte Liste
              end;
          end;

          if ZEFehler = zeKeinFehler then
            ZECollOk.AddItem(ZEObj)
          else // gefilterte Einträge nicht auflisten, nur zählen für Report
          if ZEFehler = zeZeitFilter then Inc(DoppelEintraege)
          else
            ZECollNOk.AddItem(ZEObj);
        end;
      end;

      // Daten in Datei *.tri einlesen, LetzterWettkTln gesetzt
      ZECollOk.Einlesen;
      HauptFenster.StatusBarClear;

    finally
      if AutoSpeichernRequest then TriDatAutoSpeichern;
      if not SofortRechnen or not Rechnen or
         not BerechneRangAlleWettk then HauptFenster.UpdateAnsicht;
      HauptFenster.LstFrame.TriaGrid.StopPaint := false;
    end;

    with HauptFenster do
      if (LiveZtErfAktiviert or ((ZtEinlDialog<>nil)and LiveErfDlg)) then
        if LetzterTlnFocus and (LetzterWettkTln <> nil) then
        begin
          if LstFrame.TriaGrid.Collection.SortIndexOf(LetzterWettkTln) >= 0 then
            LstFrame.TriaGrid.FocusedItem := LetzterWettkTln; //nach UpdateAnsicht
          Refresh;
        end;

    if ZtEinlDialog <> nil then
    begin
      ZtEinlReport := TZtEinlReport.Create(HauptFenster);
      try
        ZtEinlReport.ShowModal;
      finally
        FreeAndNil(ZtEinlReport);
      end;
    end;

    Result := true;

  finally
    ZtErfDatLetztChangeTime := ChangeTimeAlt;
    ZtErfDatGelesen         := GetTickCount; // in mSek, neue Periode von 1Sek
    LiveZtErfRequest        := false;
    if (ZtEinlDialog<>nil) or Result then // sonst Fehlermeldung stehenlassen
      HauptFenster.StatusBarClear;
  end;
end;

(***************************************************+************************)
function ZeitDateiLaden: Boolean;
(****************************************************************************)
// Einlesen von .trz-, .zrf-, .txt-, .gtz- Format (Alle sind Textdateien)
// [1..4]  Startnummer mit 4 Ziffern
// [5]     TAB oder beliebiges Trennzeichen
// [6..13/15/16] Uhrzeit (hh:mm:ss / hh:mm:ss.d / hh:mm:ss.dd)
// [14/16]    ZERF: beliebiges Trennzeichen
// [15/17...] ZERF: Kommentar-String,nur beim letzten Abschn. gespeichert,'' erlaubt

// Zeilenende :  Windows, DOS  : 0D 0A                 ==> unterstützt
//               Unix, Linux   : 0A  (Linefeed)        ==> unterstützt
//               MacIntosh     : 0D  (Carriage Return) ==> nicht unterstützt

// auch während LiveZtErfassung benutzt, dann Fehlermeldungen nur in Statuszeile
// anzeigen, gesteuert von ZtErfMessage

var IOFehler,
    Weiter,
    Rundung  : Boolean;
    ZeileNr  : Integer;
    SnrStr   : String;
    SnrInt   : Integer;
    ZeitStr  : String;
    ZeitInt  : Integer;
    KommStr  : String;
    ZeObj    : TZEObj;
    ZeDatei  : Textfile;
    Zeile    : String;
    S,Z      : String;
    i,
    Spalten,
    ZeitNeu,
    ZeitAlt,
    ZeitAlt00,
    Ueberlauf,
    Teiler,
    Zeit24    : Integer;
    PosAlt    : Int64;
    TrennZeichen : Char;
    ZeilenLaenge : Integer;
    RfidStr      : String;
    Voll         : Boolean;

//------------------------------------------------------------------------------
procedure SetSportronicStrings;
{ Format Sportronic:
  Alle Felder werden grundzätzlich mit TAB Ascii(09) getrennt.
  Jede Zeile wird mit TAB Ascii(09)+CR Ascii(13)+LF Ascii(10) abgeschlossen.
  Teilnehmer, die nicht erfasst wurden (Transponder-Startnummer Zuordnung),
  bekommen die Start Nr. 90001 bis 99999.
  Die Zeit ist eine Tagesereigniszeit.
  Die Spalte Kennung dient zur Messortidentifikation.

  Felddefinition:
  LFNR       - Ereigniszähler von 1 bis 99999 linksbündig.
               NEU: 6-Stellig mit führenden Leerzeichen
  START_NR   - von 1 bis 90000 linksbündig.
               NEU: führende Leerzeichen
  ZEIT       - Tagesereigniszeit, immer 11 Stellen, Format Std:Min:Sec.ZH
  RUNDE      - Automatische Rundendetektion von 1 bis 9999, linksbündig.
               NEU: führende Leerzeichen
  KENNUNG    - Automatische Messortidentifikation von 1 bis 99, frei wählbar, linksbündig.
               NEU: führende Leerzeichen
  TRANS_CODE - Interner Code, für EDV Auswertung nicht vorgesehen, immer 24 Stellen.
               NEU: abschliessendes TAB-Zeichen

  Der Exportdateiname ist immer der gleiche Ttms_03.TXT.
  Die Selektion der Dateiinhalte erfolgt durch den Anwender.
  Bei Zwischenexporten werden immer alle Messereignise exportiert, auch wenn
  sie bereits zuvor exportiert wurden.

  Beispieldatei:
  1   1005  19:53:41.68	1	1	LR 0000 0000000019914130
  2   662   09:56:33.85	1	1	LR 0000 0000000030906253
  3   663	  09:56:34.79	1	1	LR 0000 0000000007096181
  4   661	  09:56:40.24	1	1	LR 0000 0000000068814043
  5   750	  09:59:18.05	1	1	LR 0000 0000000070160219
  6   672	  09:59:50.88	1	1	LR 0000 0000000030896604
  7   765	  09:59:57.17	1	1	LR 0000 0000000028582989
  8   90001	09:59:59.79	1	1	LR 0007 0000000003389227
  9   764	  09:59:59.90	1	1	LR 0000 0000000068814504
  10  731   10:00:08.93	1	1	LR 0000 0000000070152961
  570 669   10:04:33.00	1	1	Kein Transponder
}
// nicht unbedingt nach Zeit sortiert (siehe Zeile 1)
// Snr über 9.999 werden als 0 eingelesen
var i,L : Integer;
begin
  SnrStr  := '';
  ZeitStr := '';
  i := 0;
  L := Length(Zeile);
  //Zeilenr. überspringen
  repeat
    Inc(i);
  until (Zeile[i]=#9{TAB}) or (i=L);
  //Zeile[i] = #9{TAB}, Snr einlesen
  while i<L do
  begin
    Inc(i);
    if Zeile[i] <> #9{TAB} then SnrStr := SnrStr + Zeile[i]
                            else Break;
  end;
  // bis 4 (9.999) zulassen
  SnrStr := Trim(SnrStr); // Leerzeichen entfernen
  if Length(SnrStr) > 4 then SnrStr := '0'; // max Snr für Tria: 9.999
  //Zeile[i] = #9{TAB}, Zeit einlesen
  while i<L do
  begin
    Inc(i);
    if Zeile[i] <> #9{TAB} then ZeitStr := ZeitStr + Zeile[i]
                            else Break;
  end;
  ZeitStr := Trim(ZeitStr); // nur aus Vorsicht
end;
//------------------------------------------------------------------------------
procedure SetDAGStrings;
{ Format DAG-System:
  Alle Felder werden grundzätzlich mit TAB Ascii(09) getrennt.
  Jede Zeile wird mit CR Ascii(13)+LF Ascii(10) abgeschlossen.
  Teilnehmer, die nicht erfasst wurden (Transponder-Startnummer Zuordnung),
  Felddefinition:
    1-6   RunningCount
    8-9   BlackboxNumber
    11-26 ChipNumber
    28-29 ReaderNumber
    31-41 TimeStamp
    danach zusäztliche Flags, getrennt durch TAB wie ManualBadgerInput, DetectionCount, ...
    sollten vernachlässigt werden.

  Der Exportdateiname ist immer der gleiche Ttms_03.TXT.
  Die Selektion der Dateiinhalte erfolgt durch den Anwender.
  Bei Zwischenexporten werden immer alle Messereignise exportiert, auch wenn
  sie bereits zuvor exportiert wurden.

  Beispieldatei:
000001	03	0000000000000474	01	10:06:50.01 ==> Runningcount auch ohne führende 0
000002	03	0000000000000473	01	10:06:50.51
000003	03	0000000000000460	01	10:06:51.87
000004	03	0000000000000434	01	10:06:52.92
000005	03	0000000000000439	01	10:06:55.94
000006	03	0000000000000409	01	10:06:57.97
000007	03	0000000000000102	01	10:06:58.72
000008	03	0000000000000432	01	10:07:02.12
000009	03	0000000000000459	01	10:07:02.13
000010	03	0000000000000441	01	10:07:02.78
}
// Snr über 9.999 werden als 0 eingelesen
var i,L : Integer;
begin
  SnrStr  := '';
  ZeitStr := '';
  i := 0;
  L := Length(Zeile);
  //RunningCount überspringen
  repeat
    Inc(i);
  until (Zeile[i]=#9{TAB}) or (i=L);
  if i<L then
  begin
    //BlackboxNumber überspringen
    repeat
      Inc(i);
    until (Zeile[i]=#9{TAB}) or (i=L);
    //Zeile[i] = #9{TAB},
    //Snr (ChipNumber) bis TAB einlesen
    if i<L then
    begin
      // führende nullen ignorienen
      repeat
        Inc(i);
      until (Zeile[i]<>'0') or (i=L);
      if (Zeile[i] <> #9{TAB}) then
      begin
        SnrStr := SnrStr + Zeile[i]; // 1. Zeichen <> 0
        while i<L do
        begin
          Inc(i);
          if Zeile[i] <> #9{TAB} then
            SnrStr := SnrStr + Zeile[i] // restliche Zeichen
          else Break;
        end;
      end;
      //Zeile[i] = #9{TAB}
      if i<L then
      begin
        // ReaderNumber überspringen
        repeat
          Inc(i);
        until (Zeile[i]=#9{TAB}) or (i=L);
        //Zeile[i] = #9{TAB}, Zeit einlesen
        while i<L do
        begin
          Inc(i);
          if Zeile[i] <> #9{TAB} then ZeitStr := ZeitStr + Zeile[i]
                                  else Break;
        end;
      end;
    end;
  end;
  // bis 4 (9.999) zulassen
  SnrStr := Trim(SnrStr); // Leerzeichen entfernen
  if (Length(SnrStr)=0) or (Length(SnrStr)>4) then SnrStr := '0'; // max Snr für Tria: 9.999
  ZeitStr := Trim(ZeitStr); // nur aus Vorsicht
end;
//------------------------------------------------------------------------------
procedure SetMandigoStrings;
{Format Mandigo:
 1-6    Counter - ignorieren ===> auch ohne führende 0'en akzeptieren
 7      Blank
 8-17   Zeit in Zehntel
 18     Blank
 19-22  Snnn - ignorieren
 23-26  Startnr
 27-34  Lnnnnnnn - ignorieren

Beispieldatei:
000001 00:00:06.9 S0000014L0000001
000002 00:00:07.0 S0000065L0000001
000003 00:00:09.4 S0000039L0000001
000004 00:00:09.7 S0000012L0000001
000005 00:00:09.9 S0000054L0000001
000006 00:00:10.3 S0000061L0000001
000007 00:00:13.8 S0000068L0000002
000008 00:00:13.9 S0000001L0000001
000009 00:00:14.0 S0000063L0000001
000010 00:00:14.1 S0000031L0000001
..
..
000703 ==> letzte Zeile ohne CR LF ignorieren
}
begin
  SnrStr  := '';
  ZeitStr := '';
  if Length(Zeile) >= 17 then
  begin
    ZeitStr := Copy(Zeile,8,10);
    ZeitStr := Trim(ZeitStr); // nur aus Vorsicht
    if Length(Zeile) >= 26 then
    begin
      SnrStr := Copy(Zeile,23,4);
      SnrStr := Trim(SnrStr); // Leerzeichen entfernen
    end;
  end;
end;
//------------------------------------------------------------------------------
function IstMandigoFormat: Boolean;
// Sportronics: 10  731   10:00:08.93	1	1	LR 0000 0000000070152961 (TAB getrennt)
// Mandigo:     000001 00:00:06.9 S0000014L0000001 (Blank getrennt)
// wird nur bei Zeile1 benutzt
begin
  if (Length(Zeile) = 34) and (Pos(#9,Zeile) = 0) then // kein TAB vorhanden
    Result := true
  else Result := false;
end;
//------------------------------------------------------------------------------
function SpaltenZahl: Integer;
// fzSonstig, leere Spalten möglich
var i:Integer;
begin
  Result := 1; //Trennzeichen + 1
  for i:=1 to Length(Zeile) do
    if Zeile[i] = ZtErfTrennung then Inc(Result);
end;
//------------------------------------------------------------------------------
function GetSpalte(Nr:Integer):String;
var i,Col:Integer;
    S : String;
begin
  Result := '';
  i   := 1;
  Col := 1; // 1 mehr als Spalten
  S := Zeile;
  while (Col < Nr) and (i < Length(Zeile)) do
  begin
    if S[i]=ZtErfTrennung then Inc(Col);
    Inc(i);
  end;
  if i>1 then Delete(S,1,i-1); // bis Anfang der Spalte löschen
  for i:=1 to Length(S) do
    if S[i] <> ZtErfTrennung then
      Result := Result + S[i]
    else Break;
  //Result := Trim(Result);
end;
//------------------------------------------------------------------------------
function GetSnrStr: String;
// fzSonstig
begin
  Result := GetSpalte(ZtErfSnrPos);
end;
//------------------------------------------------------------------------------
function GetRfidStr: String;
// fzSonstig
begin
  Result := GetSpalte(ZtErfSnrPos); // SnrPos = RfidPos
end;
//------------------------------------------------------------------------------
function GetZeitStr: String;
// fzSonstig
var S : String;
begin
  Result := '';
  S := GetSpalte(ZtErfZeitPos);
  if ZtErfZeitTrenn = '' then // in gültigem ZeitStr mit Trennzeichen umwandeln
    case ZtErfFormat of
      zfSek:
        if Length(S) <= 6 then
        begin
          S := AddLeadZero(S,6);
          Result := Copy(S,1,2) + ':' + Copy(S,3,2) + ':' + Copy(S,5,2);
        end;
      zfZehntel:
        if (Pos(',',S) = 0) and (Pos('.',S) = 0) then // kein Dez.Trennzeichen
          if Length(S) <= 7 then
          begin
            S := AddLeadZero(S,7);
            Result := Copy(S,1,2) + ':' + Copy(S,3,2) + ':' + Copy(S,5,2) + ',' + Copy(S,7,1);
          end
          else
        else
        if (Pos(',',S) = Length(S)-1) or (Pos('.',S) = Length(S)-1) then // gültiges Dez.Trennzeichen
          if Length(S) <= 8 then
          begin
            S := AddLeadZero(S,8);
            Result := Copy(S,1,2) + ':' + Copy(S,3,2) + ':' + Copy(S,5,4);
          end;
          // else ungültiges Dez. Trennzeichen
      zfHundertstel:
        if (Pos(',',S) = 0) and (Pos('.',S) = 0) then // kein Dez.Trennzeichen
          if Length(S) <= 8 then
          begin
            S := AddLeadZero(S,8);
           Result := Copy(S,1,2) + ':' + Copy(S,3,2) + ':' + Copy(S,5,2) + ',' + Copy(S,7,2);
          end
          else
        else
        if (Pos(',',S) = Length(S)-2) or (Pos('.',S) = Length(S)-2) then // gültiges Dez.Trennzeichen
          if Length(S) <= 9 then
          begin
            S := AddLeadZero(S,9);
            Result := Copy(S,1,2) + ':' + Copy(S,3,2) + ':' + Copy(S,5,5);
          end;
        //else // ungültiges Dez. Trennzeichen
    end
  else // Zeit mit Trennzeichen
    case ZtErfFormat of
      zfSek:
        if Length(S) = 7 then // höchstens 1x leading 0 ergänzen
          Result := AddLeadZero(S,8)
        else
        if Length(S) = 8 then
          Result := S;
      zfZehntel:
        if Length(S) = 9 then // höchstens 1x leading 0 ergänzen
          Result := AddLeadZero(S,10)
        else
        if Length(S) = 10 then
          Result := S;
      zfHundertstel:
        if Length(S) = 10 then // höchstens 1x leading 0 ergänzen
          Result := AddLeadZero(S,11)
        else
        if Length(S) = 11 then
          Result := S;
    end;
end;

//------------------------------------------------------------------------------
begin
  Result   := false;
  IOFehler := false;
  ZeitInt  := -1;  // Compiler-Warnmeldung vermeiden
  ZeileNr := 0;
  Spalten := 0;
  TrennZeichen := #9;{TAB}
  ZeilenLaenge := 13;
  Voll           := false;
  try
    {$I-}
    AssignFile(ZeDatei,ZtErfDateiName);
    SetLineBreakStyle(ZeDatei,tlbsCRLF); // nur beim Schreiben von Bedeutung
    Reset(ZeDatei);
    if IoResult<>0 then begin IOFehler := true; Exit; end;

    // Progressbar nur bis 1/3 füllen
    HauptFenster.ProgressBarInit(
        'Aus Datei  "'+ZtErfDateiName+'"  werden Zeiten für  '+ZtErfAbschnString+'  eingelesen',
        FileSize(ZeDatei) * 3);
    PosAlt := 0;
    while not Eof(ZeDatei) do
    begin
      Inc(ZeileNr); // 1 = erste Zeile
      if ZtErfHeader and (ZeileNr > cnTlnMax+1) or (ZeileNr > cnTlnMax) then
      begin
        Voll := true;
        Exit;
      end;

      ReadLn(ZeDatei,Zeile);
      if IoResult<>0 then begin IOFehler := true; Exit; end;
      //Zeile := Trim(Zeile);

      // allgemeines Zeilenformat 1. und restlichen Zeilen prüfen
      if not RfidModus then
      begin
        case ZtErfDateiFormat of
          fzTriaZeit:
            if ZeileNr = 1 then
            begin
              ZeilenLaenge := Length(Zeile);
              TrennZeichen := Zeile[5];
              case ZeilenLaenge of
                13: ZtErfFormat := zfSek;
                15: ZtErfFormat := zfZehntel;
                16: ZtErfFormat := zfHundertstel;
                else Exit; // Format ungültig
              end;
              if (ZeitFormat <> ZtErfFormat) and not HauptFenster.LiveZtErfAktiviert then
                TriaMessage('Die eingelesen Zeiten sind in ' +FormatStr(ZtErfFormat)+' definiert, aber werden'+#13+
                            'entsprechend der eingestellten Option in ' + FormatStr(ZeitFormat) + ' dargestellt.',
                            mtInformation,[mbOk]);
            end else // ab 2. Zeile
              if (Length(Zeile) <> ZeilenLaenge) or
                 (Pos(TrennZeichen,Zeile) <> 5) then Exit;

          fzZerf:
             if ZeileNr = 1 then
            begin
              if Length(Zeile) < 14 then Exit //mind. Trennz. mit Leerstring
              else
              if (Length(Zeile) >= 17) and //mind. Trennz. mit Leerstring
                 (UhrZeitWert100(Copy(Zeile,6,11)) >= 0) then ZtErfFormat := zfHundertstel
              else
              if (Length(Zeile) >= 16) and //mind. Trennz. mit Leerstring
                 (UhrZeitWertDec(Copy(Zeile,6,10)) >= 0) then ZtErfFormat := zfZehntel
              else ZtErfFormat := zfSek;
              if (ZeitFormat <> ZtErfFormat) and not HauptFenster.LiveZtErfAktiviert then
                TriaMessage('Die eingelesen Zeiten sind in ' +FormatStr(ZtErfFormat)+' definiert, aber werden'+#13+
                            'entsprechend der eingestellten Option in ' + FormatStr(ZeitFormat) + ' dargestellt.',
                            mtInformation,[mbOk]);
            end else // ab 2. Zeile
              case ZtErfFormat of
                zfSek         : if Length(Zeile) < 14 then Exit;
                zfZehntel     : if Length(Zeile) < 16 then Exit;
                zfHundertstel : if Length(Zeile) < 17 then Exit;
              end;

          fzGis:
          begin
            if ZeileNr = 1 then
            begin
              ZtErfFormat := zfHundertstel;
            end;
            if Length(Zeile) <> 16 then Exit;
          end;

          fzSportronic:
          begin
            if ZeileNr = 1 then
            begin
              // prüfe ob Sportronics- oder Mandigo-Format
              if IstMandigoFormat then
              begin
                ZtErfDateiFormat := fzMandigo;
                ZtErfFormat := zfZehntel;
              end else
                ZtErfFormat := zfHundertstel;
            end;
            if Length(Zeile) < 15 then Exit;
          end;

          fzDAG:
          begin
            if ZeileNr = 1 then
            begin
              ZtErfFormat := zfHundertstel;
            end;
            if Length(Zeile) < 20 then Exit;
          end;

          fzMandigo:
          begin
            if ZeileNr = 1 then
            begin
              ZtErfFormat := zfZehntel;
            end;
            if Length(Zeile) <> 34 then
            begin
              if Length(Zeile) = 6 then Result := true; // Zeile nur mit Counter
              Exit;
            end;
          end;

          fzSonstig:
          begin
            if ZtErfHeader and (ZeileNr = 1) then Continue
            else
            if not ZtErfHeader and (ZeileNr = 1) or
               ZtErfHeader and (ZeileNr = 2) then
            begin
              ZeilenLaenge := Length(Zeile);
              Spalten := SpaltenZahl;
              if (Spalten < ZtErfSnrPos) or (Spalten < ZtErfZeitPos) then Exit;
              if (ZeitFormat <> ZtErfFormat) and not HauptFenster.LiveZtErfAktiviert then
                TriaMessage('Die eingelesen Zeiten sind in ' +FormatStr(ZtErfFormat)+' definiert, aber werden'+#13+
                            'entsprechend der eingestellten Option in ' + FormatStr(ZeitFormat) + ' dargestellt.',
                            mtInformation,[mbOk]);
            end else // ab 2. Zeile
              if SpaltenZahl <> Spalten then Exit;
          end;
        end;

        // restliche Zeilen Snr und Zeit extrahieren und prüfen
        RfidStr := '';
        case ZtErfDateiFormat of
          fzTriaZeit, fzZerf:
          begin
            SnrStr  := Copy(Zeile,1,4); // Zeile[5] beliebiges Trennzeichen
            case ZtErfFormat of
              zfSek:
              begin
                ZeitStr := Copy(Zeile,6,8);
                ZeitInt := UhrZeitWertSek(ZeitStr); // Wert in 1/100 Sek
              end;
              zfZehntel:
              begin
                ZeitStr := Copy(Zeile,6,10);
                ZeitInt := UhrZeitWertDec(ZeitStr); // Wert in 1/100 Sek
              end;
              zfHundertstel:
              begin
                ZeitStr := Copy(Zeile,6,11);
                ZeitInt := UhrZeitWert100(ZeitStr); // Wert in 1/100 Sek
              end;
            end;
          end;
          fzSonstig:
          begin
            SnrStr  := GetSnrStr;
            ZeitStr := GetZeitStr;
            case ZtErfFormat of
              zfSek         : ZeitInt := UhrZeitWertSek(ZeitStr); // Wert in 1/100 Sek
              zfZehntel     : ZeitInt := UhrZeitWertDec(ZeitStr);
              zfHundertstel : ZeitInt := UhrZeitWert100(ZeitStr);
            end;
          end;
          fzGis:
          begin
            SnrStr  := Copy(Zeile,1,4); // Zeile[5] beliebiges Trennzeichen
            ZeitStr := Copy(Zeile,6,11);
            ZeitInt := UhrZeitWert100(ZeitStr); // Wert in 1/100 Sek
          end;
          fzSportronic:
          begin
            SetSportronicStrings;
            ZeitInt := UhrZeitWert100(ZeitStr); // Wert in 1/100 Sek
          end;
          fzDAG:
          begin
            SetDAGStrings;
            ZeitInt := UhrZeitWert100(ZeitStr); // Wert in 1/100 Sek
          end;
          fzMandigo: // Zeile > 1
          begin
            SetMandigoStrings;
            ZeitInt := UhrZeitWertDec(ZeitStr); // Wert in 1/100 Sek
          end;
        end;

        if not TryDecStrToInt(SnrStr,SnrInt) or
           not ZeitFormatOk(ZeitStr,ZtErfFormat) then Exit;

        // Zeile[14] beliebiges Trenneichen  bei fmZerf
        KommStr := '';
        if ZtErfDateiFormat=fzZerf then
          case ZtErfFormat of
            zfSek         : if Length(Zeile) > 14 then //Kommentar vorh.
                              KommStr := Copy(Zeile,15,Length(Zeile)-14);
            zfZehntel     : if Length(Zeile) > 16 then //Kommentar vorh.
                              KommStr := Copy(Zeile,17,Length(Zeile)-16);
            zfHundertstel : if Length(Zeile) > 17 then //Kommentar vorh.
                              KommStr := Copy(Zeile,18,Length(Zeile)-17);
          end;
      end

      else // RfidModus,
      begin
        // unterschiedliche Code-Längen und falsche Hex-Codes nach Best. aktzeptieren
        case ZtErfDateiFormat of
          fzTriaZeit:
            if ZeileNr = 1 then
            begin
              ZeilenLaenge := Length(Zeile); // RFID nicht für alle Zeilen gleich
              // festes TrennZeichen: TAB , #9
              if Pos(TrennZeichen,Zeile) = 0 then // 0 Rfid-Zeichen erlauben
              begin
                if not HauptFenster.LiveZtErfAktiviert then
                  TriaMessage('In Zeile 1 ist kein Trennzeichen (TAB) vorhanden.'+#13+
                              'Es wurden keine Zeiten eingelesen.',
                              mtInformation,[mbOk]);
                Exit;
              end;
              // Zeitformat variabel aber gleich für alle Zeilen
              case ZeilenLaenge - Pos(TrennZeichen,Zeile) of
                8 : ZtErfFormat := zfSek;
                10: ZtErfFormat := zfZehntel;
                11: ZtErfFormat := zfHundertstel;
                else
                begin
                  if not HauptFenster.LiveZtErfAktiviert then
                    TriaMessage('Das Zeitformat in Zeile 1 ist ungültig.'+#13+
                                'Es wurden keine Zeiten eingelesen.',
                                mtInformation,[mbOk]);
                  Exit; // ZeitFormat ungültig
                end;
              end;
              if (ZeitFormat <> ZtErfFormat) and not HauptFenster.LiveZtErfAktiviert then
                TriaMessage('Die eingelesen Zeiten sind in ' +FormatStr(ZtErfFormat)+' definiert, aber werden'+#13+
                            'entsprechend der eingestellten Option in ' + FormatStr(ZeitFormat) + ' dargestellt.',
                            mtInformation,[mbOk]);
            end else // ab 2. Zeile zunächst nur Pos Trennzeichen prüfen
              case ZtErfFormat of
                zfSek         : if Pos(TrennZeichen,Zeile) <> Length(Zeile) -  8 then
                                begin
                                  if not HauptFenster.LiveZtErfAktiviert then
                                    TriaMessage('Das Zeitformat in Zeile '+IntToStr(ZeileNr)+' ist ungültig.'+#13+
                                    'Es wurden keine Zeiten eingelesen.',
                                     mtInformation,[mbOk]);
                                  Exit;
                                end;
                zfZehntel     : if Pos(TrennZeichen,Zeile) <> Length(Zeile) - 10 then
                                begin
                                  if not HauptFenster.LiveZtErfAktiviert then
                                    TriaMessage('Das Zeitformat in Zeile '+IntToStr(ZeileNr)+' ist ungültig.'+#13+
                                    'Es wurden keine Zeiten eingelesen.',
                                     mtInformation,[mbOk]);
                                  Exit;
                                end;
                zfHundertstel : if Pos(TrennZeichen,Zeile) <> Length(Zeile) - 11 then
                                begin
                                  if not HauptFenster.LiveZtErfAktiviert then
                                    TriaMessage('Das Zeitformat in Zeile '+IntToStr(ZeileNr)+' ist ungültig.'+#13+
                                    'Es wurden keine Zeiten eingelesen.',
                                     mtInformation,[mbOk]);
                                  Exit;
                                end;
              end;

          fzSonstig:
          begin
            if ZtErfHeader and (ZeileNr = 1) then Continue
            else
            if not ZtErfHeader and (ZeileNr = 1) or
               ZtErfHeader and (ZeileNr = 2) then
            begin
              //ZeilenLaenge := Length(Zeile);
              Spalten := SpaltenZahl;
              if (Spalten < ZtErfSnrPos) or (Spalten < ZtErfSnrPos) then
              begin
                if not HauptFenster.LiveZtErfAktiviert then
                  TriaMessage('In Zeile '+IntToStr(ZeileNr)+' sind nur '+IntToStr(Spalten)+ ' Spalten vorhanden.'+#13+
                              'Es wurden keine Zeiten eingelesen.',
                              mtInformation,[mbOk]);
                Exit;
              end;
              // ZtErfFormat fest vorgegeben
              if (ZeitFormat <> ZtErfFormat) and not HauptFenster.LiveZtErfAktiviert then
                TriaMessage('Die eingelesen Zeiten sind in ' +FormatStr(ZtErfFormat)+' definiert, aber werden'+#13+
                            'entsprechend der eingestellten Option in ' + FormatStr(ZeitFormat) + ' dargestellt.',
                            mtInformation,[mbOk]);
            end else // ab 2. Zeile zunächst nur Spaltenzahl prüfen
              if SpaltenZahl <> Spalten then
              begin
                if not HauptFenster.LiveZtErfAktiviert then
                  TriaMessage('In Zeile '+IntToStr(ZeileNr)+' sind '+IntToStr(SpaltenZahl)+
                              ' statt '+IntToStr(Spalten)+ ' Spalten vorhanden.'+#13+
                              'Es wurden keine Zeiten eingelesen.',
                              mtInformation,[mbOk]);
                Exit;
              end;
          end;
        end;

        // restliche Zeilen RfidModus, Rfid und Zeit extrahieren und prüfen
        SnrStr  := '';

        RfidStr := GetRfidStr;
        if Length(RfidStr) > cnRfidzeichenMax then
        begin
          if not HauptFenster.LiveZtErfAktiviert then
            TriaMessage('Der RFID-Code hat mehr als '+IntToStr(cnRfidzeichenMax)+ ' Zeichen.'+#13+
                        'Es wurden keine Zeiten eingelesen.',
                        mtInformation,[mbOk]);
          Exit;
        end;
        if not RfidTrimValid(RfidStr) then
        begin
          if not HauptFenster.LiveZtErfAktiviert then
            TriaMessage('RFID-Code in Zeile ' + IntToStr(ZeileNr) + ' ("' + RfidStr + '") hat Leerzeichen am Anfang und/oder Ende.'+#13+
                        'Es wurden keine Zeiten eingelesen.',
                         mtInformation,[mbOk]);
          Exit;
        end;
        if not RfidLengthValid(RfidStr) then
          if not HauptFenster.LiveZtErfAktiviert then
            if TriaMessage('Der RFID-Code in Zeile '+IntToStr(ZeileNr)+
                           ' hat '+IntTostr(Length(RfidStr))+' statt '+IntTostr(RfidZeichen)+' Zeichen.'+#13+
                           'Die maximal zulässige Zeichenlänge auf '+ IntToStr(Length(RfidStr))+' erhöhen?',
                            mtConfirmation,[mbOk,mbCancel]) <> mrOk then
              Exit
            else
              RfidZeichen := Length(RfidStr)
          else
            RfidZeichen := Length(RfidStr);
        if RfidHex and not RfidHexValid(RfidStr) then
          if not HauptFenster.LiveZtErfAktiviert then
            if TriaMessage('Der RFID-Code in Zeile '+IntToStr(ZeileNr)+
                           ' ("'+RfidStr+'") ist keine gültige Hexadezimale Zahl.'+#13+
                         'Nicht-hexadezimale Zeichen generell zulassen?',
                         mtConfirmation,[mbOk,mbCancel]) <> mrOk then
              Exit
            else
              RfidHex := false
          else
            RfidHex := false;
        ZeitStr := GetZeitStr;
        if not ZeitFormatOk(ZeitStr,ZtErfFormat) then
        begin
          if not HauptFenster.LiveZtErfAktiviert then
            TriaMessage('Die Zeit in Zeile ' + IntToStr(ZeileNr) + ' ("' + ZeitStr + '") ist nicht Ok.'+#13+
                        'Es wurden keine Zeiten eingelesen.',
                         mtInformation,[mbOk]);
          Exit;
        end;

        case ZtErfDateiFormat of
          fzTriaZeit:
          begin
            case ZtErfFormat of
              zfSek         : ZeitInt := UhrZeitWertSek(ZeitStr); // Wert in 1/100 Sek
              zfZehntel     : ZeitInt := UhrZeitWertDec(ZeitStr); // Wert in 1/100 Sek
              zfHundertstel : ZeitInt := UhrZeitWert100(ZeitStr); // Wert in 1/100 Sek
            end;
          end;
          fzSonstig:
          begin
            RfidStr := GetRfidStr;
            ZeitStr := GetZeitStr;
            case ZtErfFormat of
              zfSek         : ZeitInt := UhrZeitWertSek(ZeitStr); // Wert in 1/100 Sek
              zfZehntel     : ZeitInt := UhrZeitWertDec(ZeitStr);
              zfHundertstel : ZeitInt := UhrZeitWert100(ZeitStr);
            end;
          end;
        end;
      end;

      ZEObj := TZEObj.Create(Veranstaltung,ZEColl,oaAdd);
      // Daten speichern in ZEColl, später prüfen
      ZEObj.Init(SnrInt,RfidStr,ZeitInt,KommStr);
      ZEColl.AddItem(ZEObj);
      HauptFenster.ProgressBarStep(FilePos(ZeDatei)-PosAlt);
      PosAlt := FilePos(ZeDatei);
    end;

    Result := true;

  finally
    CloseFile(ZeDatei);
    IoResult;
    {$I+}

    if not Result then
      if IOFehler then
        if ZeileNr = 0 then
          ZtErfMessage('Fehler beim Lesen der Datei  "'+ZtErfDateiName+'".',
                        mtInformation,[mbOk])
        else
          ZtErfMessage('Fehler beim Lesen von Zeile  ' + IntToStr(ZeileNr)+'.',
                        mtInformation,[mbOk])
      else
      if not RfidModus or HauptFenster.LiveZtErfAktiviert then // sonst Fehlermeldungen vorher erzeugt
      begin
        if Voll then
          ZtErfMessage('Fehler: Maximale Anzahl von 9.999 Zeilen überschritten.',
                        mtInformation,[mbOk])
        else
        begin
          case ZtErfDateiFormat of
            fzTriaZeit   : if not RfidModus then
                             S := 'TriaZeit Datei (Startnr.-Modus)'
                           else S := 'TriaZeit Datei (RFID-Modus)';
            fzSonstig    : if not RfidModus then
                             S := 'Textdatei (Startnr.-Modus)'
                           else S := 'Textdatei (RFID-Modus)';
            fzZerf       : S := 'ZERF Textdatei';
            fzGis        : S := 'GiS Textdatei';
            fzSportronic : S := 'Sportronic Textdatei';
            fzDAG        : S := 'DAG Textdatei';
            fzMandigo    : S := 'Mandigo Textdatei';
          end;
          if ZeileNr = 0 then
              ZtErfMessage('Die Datei  "'+ZtErfDateiName+'"  ist keine gültige '+S+'.',
                            mtInformation,[mbOk])
          else
          begin
            Z := '';
            for i:=1 to Length(Zeile) do
              if Zeile[i] = #9 then // TAB
                Z := Z + #8594      // Pfeil nach rechts
              else
              if Zeile[i] < #33 then // auch Blank als Punkt
                Z := Z + #183        // MIDDLE DOT
              else
                Z := Z + Zeile[i];
            ZtErfMessage('Fehler in Zeile  ' + IntToStr(ZeileNr)+': "' + Z + '".',
                          mtInformation,[mbOk]);
          end;
        end;
    end;
  end;
end; // procedure ZeitDateiLaden

(****************************************************************************)
function dBaseDateiLaden: Boolean;
(****************************************************************************)
var dBaseDatei    : file of Byte;
    DateiInfo     : TdBaseDateiInfoRec;
    FeldInfo      : TdBaseFeldInfoRec;
    FeldZahl      : Integer;
    HeaderEnde    : Byte;
    RecordAnfang  : Byte;
    i,j           : Integer;
    FeldArray     : TFeldArray;
    //SnrPtr        : TdBaseFeldInfoObj;
    SnrIndex      : Integer;
    //ZeitPtr       : TdBaseFeldInfoObj;
    ZeitIndex     : Integer;
    dBaseZeit     : Integer;
    dBaseSnr      : Integer{Word};
    S             : AnsiString;
    //ZeitAlt       : Integer;
    //ZeitNeu       : Integer;
    FeldNameBuff  : array[1..10] of AnsiChar;
    ZEObj         : TZEObj;
    FeldInfoObj   : TdBaseFeldInfoObj;
    PosAlt        : Int64;
begin
  Result := false;
  dBaseFeldInfoColl := nil; // damit free ohne Create richtig funktioniert

  try
    {$I-}
    AssignFile(dBaseDatei,ZtErfDateiName);
    if IoResult<>0 then
    begin
      ZtErfMessage('Fehler beim Lesen der Datei  "'+ZtErfDateiName+'".',
                    mtInformation,[mbOk]);
      Exit;
    end;
    Reset(dBaseDatei); (* typisierte Datei, Recordlänge=1 Byte*)
    if IoResult<>0 then
    begin
      ZtErfMessage('Fehler beim Lesen der Datei  "'+ZtErfDateiName+'".',
                    mtInformation,[mbOk]);
      Exit;
    end;

    // Progressbar nur bis 1/3 füllen
    HauptFenster.ProgressBarInit('Zeiterfassungsdatei  "'+ZtErfDateiName+'"  wird geöffnet',
                             FileSize(dbaseDatei) * 3);
    PosAlt := 0;

    // Ablauf in 2 Phasen:
    // - Datei Einlesen und prüfen
    // - Zeiten übernehmen

    {Lese Header. allgemeine Datei-Info }
    BlockRead(dBaseDatei,DateiInfo,32); //Warnung für BlockRead, Fehler mit BlockWrite in TriaZeit
{with Dateiinfo do
begin
brk('Version '+IntToStr(version));
brk('Jahr '+IntToStr(jahr));
brk('Monat '+IntToStr(monat));
brk('Tag '+IntToStr(tag));
brk('RecordZahl '+IntToStr(recordzahl));
brk('VorspannLaenge '+IntToStr(vorspannlaenge));
brk('RecordLaenge '+IntToStr(recordlaenge));
end;}

    if IoResult<>0 then
    begin
      ZtErfMessage('Fehler beim Lesen der Datei  "'+ZtErfDateiName+'".',
                    mtInformation,[mbOk]);
      Exit;
    end;
    HauptFenster.ProgressBarStep(FilePos(dbaseDatei)-PosAlt);
    PosAlt := FilePos(dbaseDatei);
    { Info Überprüfen }
    with DateiInfo do
    begin
      if (Version and $07 <> $03) then { niederw. 3 Bits <> '011' }
      begin
        ZtErfMessage('Die Datei "'+ZtErfDateiName+'" ist keine dBase Datei.',
                      mtInformation,[mbOk]);
        Exit;
      end
      else if RecordZahl>cnTlnMax then
      begin
        ZtErfMessage('Die Datei "'+ZtErfDateiName+'" enthält zu viele Records.',
                      mtInformation,[mbOk]);
        Exit;
      end
      else if RecordZahl<=0 then
      begin
        ZtErfMessage('Die Datei "'+ZtErfDateiName+'" enthält keine Records.',
                      mtInformation,[mbOk]);
        Exit;
      end;
      FeldZahl := (VorspannLaenge-32) DIV 32;
      if FeldZahl > dBaseFeldZahlMax then
      begin
        ZtErfMessage('Die Datei "'+ZtErfDateiName+'" enthält zu viele Felder.',
                      mtInformation,[mbOk]);
        Exit;
      end;
    end;

    {DateiInfo ist OK}
    dBaseFeldInfoColl := TdBaseFeldInfoColl.Create(Veranstaltung,TdBaseFeldInfoObj);
    { Lese FeldInfo aus dem Header bis Header-Ende }
    for i:=0 to FeldZahl-1 do with FeldInfo do
    begin
      BlockRead(dBaseDatei,FeldInfo,32);
      if IoResult<>0 then Exit;
      (* Feldname mit Blanks ausfüllen *)
      for j:=1 to 10 do FeldNameBuff[j] := ' ';
      for j:=1 to 10 do
        if FeldInfo.Feldname[j] = chr(0)
          then Break
          else FeldNameBuff[j] := FeldInfo.Feldname[j];
      FeldInfoObj := TdBaseFeldInfoObj.Create(Veranstaltung,dBaseFeldInfoColl,oaAdd);
      FeldInfoObj.Init(FeldNameBuff,FeldType,FeldLaenge,Dezimalen);
      dBaseFeldInfoColl.AddItem(FeldInfoObj);
      {if MemAvail < cnLowMemSize then
      begin
        MeldungOk('Fehler','Nicht gengend Speicher fr Datei '+dBPath);
        Fehler := 1;
        Exit;
      end;}
    end;
    BlockRead(dBaseDatei,HeaderEnde,1);
    if IoResult<>0 then
    begin
      ZtErfMessage('Fehler beim Lesen der Datei  "'+ZtErfDateiName+'".',
                    mtInformation,[mbOk]);
      Exit;
    end;
    HauptFenster.ProgressBarStep(FilePos(dbaseDatei)-PosAlt);;
    PosAlt := FilePos(dbaseDatei);
    if HeaderEnde <> dBaseHeaderEnde then
    begin
      ZtErfMessage('Fehler beim Lesen der Datei "'+ZtErfDateiName+'".',
                      mtInformation,[mbOk]);
      Exit;
    end;
    if dBaseFeldInfoColl.Count=0 then
    begin
      ZtErfMessage('Die Datei "'+ZtErfDateiName+'" enthält keine Felder.',
                    mtInformation,[mbOk]);
      Exit;
    end;

    {Feldinfo ist OK}
    {Lese 1. Record nach Ende des Vorspanns}
    j := DateiInfo.VorspannLaenge-1 - ((FeldZahl+1) * 32); (* restliche Bytes *)
    for i:=1 to j+1 do
    begin
      BlockRead(dBaseDatei,Recordanfang,1);
      if IoResult<>0 then
      begin
        ZtErfMessage('Fehler beim Lesen der Datei  "'+ZtErfDateiName+'".',
                      mtInformation,[mbOk]);
        Exit;
      end;
    end;
    HauptFenster.ProgressBarStep(FilePos(dbaseDatei)-PosAlt);
    PosAlt := FilePos(dbaseDatei);
    if (RecordAnfang <> $20) and (RecordAnfang <> $2A) then
    begin
      ZtErfMessage('Fehler beim Lesen der Datei "'+ZtErfDateiName+'".',
                   mtInformation,[mbOk]);
      Exit;
    end;

    {lese Felder des 1. Records in FeldArray}
    for i:=0 to dBaseFeldInfoColl.Count-1 do with
      TdBaseFeldInfoObj(dBaseFeldInfoColl[i]) do
    begin
      BlockRead(dBaseDatei,FeldArray[i],FeldLaenge);
      if IoResult<>0 then
      begin
        ZtErfMessage('Fehler beim Lesen der Datei  "'+ZtErfDateiName+'".',
                      mtInformation,[mbOk]);
        Exit;
      end;
      {if MemAvail < cnLowMemSize then
      begin
        MeldungOk('Fehler','Nicht gengend Speicher fr Datei '+dBPath);
        Fehler := 1;
        Exit;
      end;}
    end;
    HauptFenster.ProgressBarStep(FilePos(dbaseDatei)-PosAlt);
    PosAlt := FilePos(dbaseDatei);

    {if ZtErfDateiFormat=fmDBase then
    begin
      dBaseDlg := New(PdBaseDlg, Init(dBaseDatei,dBPath,FeldArray));
      if DeskTop^.ExecView(dBaseDlg)=cmCancel then
      begin
        Dispose(dBaseDlg, Done);
        Exit;
      end else
      begin
        (*gew„hlte Felder auslesen*)
        SnrPtr  := dBaseDlg^.GetSnrFeld;
        SnrIndex := dBaseFeldInfoColl^.IndexOf(SnrPtr);
        ZeitPtr := dBaseDlg^.GetZeitFeld;
        ZeitIndex := dBaseFeldInfoColl^.IndexOf(ZeitPtr);
        Dispose(dBaseDlg, Done);
      end;
    end else}
    (* ZtErfDateiFormat = fmTCBacknang *)
    begin
      with TdBaseFeldInfoObj(dBaseFeldInfoColl[0]) do
        if (Copy(FeldName,1,3)<>'SNR') or
           (FeldType<>'N') or
           (FeldLaenge<>4) or
           (Dezimalen<>0) then
      begin
        ZtErfMessage('Fehler beim Lesen der Datei "'+ZtErfDateiName+'".'{+#13+
                     '1. Recordfeld "'+FeldName+'" ungleich "SNR".'},
                     mtInformation,[mbOk]);
        Exit;
      end;
      with TdBaseFeldInfoObj(dBaseFeldInfoColl[1]) do
        if (Copy(FeldName,1,6)<>'STOP_S') or
           (FeldType<>'N') or
           (FeldLaenge<>8) or
           (Dezimalen<>2) then
      begin
        ZtErfMessage('Fehler beim Lesen der Datei "'+ZtErfDateiName+'".'{+#13+
                    '2. Recordfeld "'+FeldName+'" ungleich "STOP_S".'},
                     mtInformation,[mbOk]);
        Exit;
      end;
      SnrIndex := 0;
      zeitIndex := 1;
    end;

    {dBaseRecordsEinlesen}
    {W := New(PDateiWindow,Init('dBase Records einlesen',dBPath));
    Desktop^.Insert(W);}

    for i:=0 to DateiInfo.RecordZahl-1 do
    begin
      if i>0 then {1. Record bereits gelesen}
      begin
        BlockRead(dBaseDatei,Recordanfang,1);
        if IoResult<>0 then
        begin
          ZtErfMessage('Fehler beim Lesen der Datei  "'+ZtErfDateiName+'".',
                        mtInformation,[mbOk]);
          Exit;
        end;
        if (RecordAnfang <> $20) and (RecordAnfang <> $2A) then
        begin
          ZtErfMessage('Fehler beim Lesen der Datei "'+ZtErfDateiName+'".'{+#13+
                      'RecordAnfang ungleich $20 und $2A.'},
                       mtInformation,[mbOk]);
          Exit;
        end;
        for j:=0 to dBaseFeldInfoColl.Count-1 do with
          TdBaseFeldInfoObj(dBaseFeldInfoColl[j]) do
        begin
          BlockRead(dBaseDatei,FeldArray[j],FeldLaenge);
          if IoResult<>0 then
          begin
            ZtErfMessage('Fehler beim Lesen der Datei "'+ZtErfDateiName+'".'{+#13+
                        'In Record '+IntToStr(i)},
                         mtInformation,[mbOk]);
            Exit;
          end;
        end;
      end;
      S := FeldArray[SnrIndex];
      SetLength(S,TdBaseFeldInfoObj(dBaseFeldInfoColl[SnrIndex]).FeldLaenge);
      dBaseSnr := dBaseSnrIntUmw(TdBaseFeldInfoObj(dBaseFeldInfoColl[SnrIndex]),S);
      if dBaseSnr < 0 then
      begin
        ZtErfMessage('Fehler beim Lesen der Datei "'+ZtErfDateiName+'".'{+#13+
                    'Startnummer "'+S+'" ist ungültig.'},
                     mtInformation,[mbOk]);
        Exit;
      end;
      S := FeldArray[ZeitIndex];
      SetLength(S,TdBaseFeldInfoObj(dBaseFeldInfoColl[ZeitIndex]).FeldLaenge);
      dBaseZeit := dBaseZeitIntUmw(TdBaseFeldInfoObj(dBaseFeldInfoColl[ZeitIndex]),S);
      if dBaseZeit < 0 then
      begin
        ZtErfMessage('Fehler beim Lesen der Datei "'+ZtErfDateiName+'".'{+#13+
                    'Uhrzeit "'+S+'" ist ungültig.'},
                     mtInformation,[mbOk]);
        Exit;
      end;
      // in ZEDatei Zeit=0 wenn keine Zeit eingegeben wurde, ändern in -1
      if dBaseZeit = 0 then dBaseZeit := -1;
      ZEObj := TZEObj.Create(Veranstaltung,ZEColl,oaAdd);
      ZEObj.Init(dBaseSnr,'',dBaseZeit,'');
      ZEColl.AddItem(ZEObj);
      HauptFenster.ProgressBarStep(FilePos(dbaseDatei)-PosAlt);
      PosAlt := FilePos(dbaseDatei);
    end;

    Result := true;

  finally
    dBaseFeldInfoColl.Free;
    closeFile(dBaseDatei);
    IoResult;
    {$I+}
  end;
end; (* function dBaseDateiLaden *)


(******************************************************************************)
(*                   Methoden von TZEObj                                      *)
(******************************************************************************)

//==============================================================================
constructor TZEObj.Create(Veranst:Pointer;Coll:TTriaObjColl;Add:TOrtAdd);
//==============================================================================
begin
  inherited Create(Veranst,Coll,Add);
  Snr         := 0;
  EinleseZeit := -1;
  UebernZeit  := -1;
  ZEFehler    := zeKeinFehler;
  Tln         := nil;
end;

//==============================================================================
function TZEObj.ObjSize: Integer;
//==============================================================================
begin
  // Dummy, nur um Compiler-Warnings zu vermeiden
  Result := 0;
end;

//==============================================================================
procedure TZEObj.Init(SnrNeu:Integer;RfidNeu:String;ZeitNeu:Integer;KommStrNeu:String);
//==============================================================================
// Init immer vor AddItem
begin
  Snr         := SnrNeu;
  RfidCode    := RfidNeu;
  EinleseZeit := ZeitNeu; //in 1/100
  KommStr     := KommStrNeu;
  Runde       := 0; // Runde erst nach dem Einlesen setzen, damit Reihenfolge stimmt
  Abschn      := wkAbs1;
  ZEFehler    := zeKeinFehler;
  Tln         := nil;
  //GerundeteZeit unverändert
end;

//==============================================================================
procedure TZEObj.OrtCollAdd;
//==============================================================================
begin
  // Dummy, nur um Compiler-Warnings zu vermeiden
end;

//==============================================================================
procedure TZEObj.OrtCollClear(Indx:Integer);
//==============================================================================
begin
  // Dummy, nur um Compiler-Warnings zu vermeiden
end;

//==============================================================================
procedure TZEObj.OrtCollExch(Idx1,Idx2:Integer);
//==============================================================================
begin
  // Dummy, nur um Compiler-Warnings zu vermeiden
end;

//==============================================================================
procedure TZEObj.Einlesen;
//==============================================================================
var Abs : TWkAbschnitt;
begin
  with Tln do
  begin
    // Zeit einlesen
    // EinzelStart- und RundenZeiten der Reihe nach in Abschnitten einlesen
    for Abs:=wkAbs0 to wkAbs8 do
      if ZtErfAbschnArr[Abs] then
        if (Abs=wkAbs0) and (StrtZeit(wkAbs1) < 0) then
        begin
          SetZeitRec(wkAbs1,0,EinleseZeit,EinleseZeit);
          Abschn := wkAbs0;
          Break;
        end else
        if (Abs>wkAbs0) and (RundenZahl(Abs) < Wettk.AbsMaxRunden[Abs]) then
        begin
          // 1. leere Runde: ErfZeit setzen, auch RndZeit damit diese sortiert wird
          // Index in Runde festhalten, nach dem Einlesen Runde für report aktualisieren
          Runde := GetZeitRecColl(Abs).Count-1; // Index in GetZeitRecColl(Abs)
          AddZeitRec(Abs,EinleseZeit,EinleseZeit); // Leeres Item am Ende beschreiben
          Abschn := Abs;
          Break;
        end;

    // für letzten Abschnitt, aber alle Runden, Komment setzen
    // nur wenn <> '', nur letzte Runde sollte Komment haben, wird nicht überprüft
    if (ZtErfDateiFormat = fzZerf) then
      if (Wettk.AbSchnZahl = Integer(Abschn)) and (KommStr <> '') then
        Komment := KommStr;

    Wettk.ErgModified := true; // immer, unabhängig vom Status
    SetzeBearbeitet;
    TriDatei.Modified := true;
  end;
end;


(******************************************************************************)
(*                   Methoden von TZEColl                                     *)
(******************************************************************************)

// protected Methoden

//------------------------------------------------------------------------------
function TZEColl.GetPItem(Indx:Integer): TZEObj;
//------------------------------------------------------------------------------
begin
  Result := TZEObj(inherited GetPItem(Indx));
end;

//------------------------------------------------------------------------------
procedure TZEColl.SetPItem(Indx:Integer; Item:TZEObj);
//------------------------------------------------------------------------------
begin
  inherited SetPItem(Indx,Item);
end;

//------------------------------------------------------------------------------
function TZEColl.GetSortItem(Indx:Integer): TZEObj;
//------------------------------------------------------------------------------
begin
  Result := TZEObj(inherited GetSortItem(Indx));
end;

// public Methoden

//==============================================================================
constructor TZEColl.Create(Veranst:Pointer;ItemClass:TTriaObjClass);
//==============================================================================
begin
  inherited Create(Veranst,ItemClass);
  FSortMode := smZEZeit; // Sortieren für ZEColl nicht benötigt, nur für übrige Coll's
  FSortItems.Duplicates := true;(* damit gleiche Einträge aufgelistet werden *)
end;

//==============================================================================
function TZEColl.SortString(Item:Pointer): String;
//==============================================================================
// Zeit max 7 Stellen bei hundertstel sec, 8640000=24*60*60*100 hunderstelsec
// Runde nur für zeKeinFehler gesetzt
// nach Zeit ab Tln.StrtZeit sortieren (ZECollOk), 
// wenn nicht definiert (ZEColl, ZECollNOk) dann ab StrtZeit=0
// geht nur gut wenn Gesamtzeit 24:00:00 nicht überschritten wird, aber über
// Tagesgrenze wird korrekt sortiert.
var SortZeit,StartZeit : Integer;
begin
  with TZEObj(Item) do
  begin
    if (Tln <> nil) and (Tln.StrtZeit(wkAbs1) >= 0) then
      StartZeit := Tln.StrtZeit(wkAbs1) // Startzeit gültig
    else
      StartZeit := 0; // Startzeit nicht definiert, Einlesezeit unverändert

    if EinleseZeit >= 0 then
      if EinleseZeit > StartZeit then
        SortZeit := EinleseZeit - StartZeit // > 0
      else // EinleseZeit <= StartZeit
        SortZeit := EinleseZeit + cnZeit24_00 - StartZeit // min=0, max=cnZeit24_00
    else
      SortZeit  := cnZeit24_00 + 1; // am Ende der Liste

    if RfidModus then
      if (FSortMode=smZESnr)
        then Result := Format('%s  %u %4u %7d %2u',[RfidCode,Integer(Abschn),Runde,SortZeit,Integer(ZEFehler)])
        else Result := Format('%7d  %s  %u %4u %2u',[SortZeit,RfidCode,Integer(Abschn),Runde,Integer(ZEFehler)])
    else
      if (FSortMode=smZESnr)
        then Result := Format('%4u %u %4u %7d %2u',[Snr,Integer(Abschn),Runde,SortZeit,Integer(ZEFehler)])
        else Result := Format('%7d %4u %u %4u %2u',[SortZeit,Snr,Integer(Abschn),Runde,Integer(ZEFehler)]);
  end;
end;

//==============================================================================
function TZEColl.AddSortItem(Item: Pointer): Integer;
//==============================================================================
begin
  Result := FSortItems.Add(Item);
end;

//==============================================================================
procedure TZEColl.Einlesen;
//==============================================================================
// Nur ZECollOk, sortiert nach Zeiten rel. zur Startzeit
var i,RndZahl,RndMax,WkIndx,WkMinIndx,WkMaxIndx,Cnt : Integer;
    Abs : TWkAbschnitt;
begin
  if Count=0 then Exit;
  if Veranstaltung.TlnColl.TlnEingeteilt(ZtErfWettkampf) = 0 then
    ZtErfMessage('Es wurden keine Teilnehmer eingeteilt.',
                  mtInformation,[mbOk])
  else
  begin

    // ProgressBar-Max anpassen, Position nach DateiLesen auf 1/3
    if ZtErfWettkampf = WettkAlleDummy then
    begin
      WkMinIndx := 0;
      WkMaxIndx := Veranstaltung.WettkColl.Count-1;
    end else
    begin
      WkMinIndx := Veranstaltung.WettkColl.IndexOf(ZtErfWettkampf);
      WkMaxIndx := WkMinIndx;
    end;
    Cnt := 3; // 3 * TlnColl.Count Steps in dieser procedure
    // 3 * TlnColl.Count Steps in ZeitenRunden
    for WkIndx := WkMinIndx to WkMaxIndx do
      for Abs:=wkAbs1 to wkAbs8 do // Startzeit wird immer mit gerundet
        if (Abs=wkAbs1) and ZtErfAbschnArr[wkAbs0] or
            ZtErfAbschnArr[Abs] then
          Cnt := Cnt + 3;
    HauptFenster.ProgressBarMaxUpdate(Cnt * Veranstaltung.TlnColl.Count);

    HauptFenster.ProgressBarStep(Veranstaltung.TlnColl.Count);

    // Runden-Überlauf-Prüfung in nach Rel-Zeit sortierte Liste
    for i:=0 to SortCount-1 do
    with GetSortItem(i) do
      if ZEFehler = zeKeinFehler then
      begin
        if (Veranstaltung.SGrpColl.WettkStartModus(Tln.Wettk,wkAbs1)=stOhnePause) and
           ZtErfAbschnArr[wkAbs0] then
        begin
          RndMax := 1; // incl. Startzeit
          if Tln.StrtZeit(wkAbs1) >= 0 then RndZahl := 1
                                       else RndZahl := 0;
        end else
        begin
          RndMax  := 0;
          RndZahl := 0;
        end;
        for Abs:=wkAbs1 to wkAbs8 do // auch RundenWettk
          if ZtErfAbschnArr[Abs] then
          begin
            RndZahl := RndZahl + Tln.RundenZahl(Abs);
            RndMax  := RndMax  + Tln.Wettk.AbsMaxRunden[Abs];
          end;
        if RndZahl + TlnEintraege(i) >= RndMax then
        begin
          ZEFehler := zeRundenUeberlauf;
          ZECollNOk.AddItem(GetSortItem(i));
        end;
      end;

    // Items mit Überlauf aus ZECollOk löschen
    for i:=Count-1 downto 0 do
    with Items[i] do
      if ZEFehler = zeRundenUeberlauf then
      begin
        ClearSortItem(GetPItem(i));
        FItems.Delete(i); // nur Ptr löschen, Item bleibt in ZECollNOk
      end;

    // KeinFehler-Items in aufsteigend sortierte Reihenfolge einlesen
    for i:=0 to SortCount-1 do
      GetSortItem(i).Einlesen;

    // RndZeit Runden, ProgressBar - Step 3 * TlnColl.Count
    // getrennt pro Wettkampf und Abschnitt
    HauptFenster.ProgressBarStep(Veranstaltung.TlnColl.Count);

    for WkIndx := WkMinIndx to WkMaxIndx do
      for Abs:=wkAbs1 to wkAbs8 do // Startzeit wird immer mit gerundet
        if (Abs=wkAbs1) and ZtErfAbschnArr[wkAbs0] or
            ZtErfAbschnArr[Abs] then
          Veranstaltung.TlnColl.ZeitenRunden(Veranstaltung.OrtIndex,Veranstaltung.WettkColl[WkIndx],Abs);

    // Runde und gerundete zeit definieren nachdem alle eingelesen wurden,
    // gerundete zeit nur für Report
    HauptFenster.ProgressBarStep(Veranstaltung.TlnColl.Count);
    for i:=0 to Count-1 do
    with Items[i] do
    begin
      // Runde beim Einlesen auf Index in ZeitErfColl gesetzt, Abschn gesetzt
      if Abschn = wkAbs0 then
      begin
        Runde := 0;
        UebernZeit := Tln.StrtZeit(wkAbs1);
      end else
      begin
        Runde := Tln.GetZeitRecColl(Abschn).SortIndexOf(
                                     Tln.GetZeitRecColl(Abschn).PItems[Runde]) + 1;
        UebernZeit := Tln.AbsRundeStoppZeit(Abschn,Runde);
      end;
      // Letzter Tln setzen entsprechend eingestellter Liste
      if ((HauptFenster.SortWettk=WettkAlleDummy)or(HauptFenster.SortWettk=Tln.Wettk)) and
         Tln.TlnInKlasse(HauptFenster.SortKlasse,tmTln) and
         Tln.TlnInStatus(HauptFenster.SortStatus) then
        LetzterWettkTln := Tln;
    end;
  end;
end;

//==============================================================================
function TZEColl.TlnEintraege(SortIndx:Integer) : Integer;
//==============================================================================
// nur für ZECollOk, nur vorher eingelesene Tln zählen (nach Rel Zeit sortiert)
var i : Integer;
    TlnObj : TTlnObj;
begin
  Result := 0;
  TlnObj := SortItems[SortIndx].Tln;
  for i:=0 to SortIndx-1 do
    with GetSortItem(i) do
      if Tln = TlnObj then Inc(Result);
end;

//==============================================================================
function TZEColl.ItemVorhanden(ZEObj:TZEObj): Boolean;
//==============================================================================
// bei Zeitfilter >= 0 werden diese vorher ausgefiltert
var i : Integer;
begin
  for i:=0 to Count-1 do
    with TZEObj(GetPItem(i)) do
    if (RfidModus and SameStr(RfidCode,ZEObj.RfidCode) or
        not RfidModus and (Snr = ZEObj.Snr)) and
        (EinleseZeit = ZEObj.EinleseZeit) then
    begin
      Result := true;
      Exit;
    end;
  Result := false;
end;

//==============================================================================
function TZEColl.DoppelEintrag(SnrNeu,Zeit:Integer;RfidNeu:String) : Boolean;
//==============================================================================
// Zeiten filtern (zeZeitFilter), für ZECollOk und ZECollNOk
// Zeitgleichheit auch filtern (zeItemDoppelt)
var i : Integer;
begin
  Result := false;
  if (ZeitFilter < 0) or (Zeit < 0) then Exit;
  for i:=0 to Count-1 do
    with TZEObj(GetPItem(i)) do
      if (RfidModus and SameStr(RfidNeu,RfidCode) or
          not RfidModus and (Snr = SnrNeu)) and
         (EinleseZeit >= 0) and
         (Abs(Zeit-EinleseZeit) <= ZeitFilter) then
      begin
        Result := true;
        Exit;
      end;
end;


//******************************************************************************
function dBaseSnrIntUmw(Feld:TdBaseFeldInfoObj;S:AnsiString):Integer;
//******************************************************************************
begin
  if (Feld.FeldType<>'N') or (Feld.Dezimalen>0) or
     (Feld.FeldLaenge>4) or (Feld.FeldLaenge<3) then Result := -1
  else Result := StrToIntDef(String(S),0);
end;

//******************************************************************************
function dBaseSnrStrUmw(Feld:TdBaseFeldInfoObj;S:AnsiString):String{Str4};
//******************************************************************************
var X : Integer;
begin
  X := dBaseSnrIntUmw(Feld,S);
  if X=-1 then Result := '????'
          else Result := String(Strng(X,4));
end;

(****************************************************************************)
function dBaseZeitIntUmw(Feld:TdBaseFeldInfoObj;S1:AnsiString):Integer;
(****************************************************************************)
// ab 2008-2.0 Result immer in Hundertstel
var h,h10       : AnsiChar;
    m,m10       : AnsiChar;
    s,s10       : AnsiChar;
    d,d10       : AnsiChar;
    hh,mm,ss,dd : AnsiString;
    S2          : AnsiString;
    Dec         : AnsiString;
begin
  Result := -1;
  ZtErfFormat := zfSek;
  case Feld.Feldtype of
   'N' : if Feld.Dezimalen=0 then
           if Feld.FeldLaenge>=5 then Result := StrToIntDef(String(S1),0)
                                 else
         else if (Feld.Dezimalen=1)and(Feld.FeldLaenge>=7) then
         begin
           //Komma entfernen
           S2 := Copy(S1,1,Length(S1)-Feld.Dezimalen-1);
           Dec := Copy(S1,Length(S1)-Feld.Dezimalen+1,1);
           S2 := S2+Dec;
           Result := StrToIntDef(String(S2),0);
           ZtErfFormat := zfZehntel;
         end
         else if (Feld.Dezimalen=2)and(Feld.FeldLaenge>=8) then
         begin
           //Komma entfernen
           S2 := Copy(S1,1,Length(S1)-Feld.Dezimalen-1);
           Dec := Copy(S1,Length(S1)-Feld.Dezimalen+1,2);
           S2 := S2+Dec;
           Result := StrToIntDef(String(S2),0);
           ZtErfFormat := zfHundertstel;
         end;
   'C':  if (Feld.FeldLaenge =  8) or      {hh:mm:ss}
            (Feld.FeldLaenge = 10) or      {hh:mm:ss,d}
            (Feld.FeldLaenge = 11) then    {hh:mm:ss:dd}
         begin
           h10 := S1[1]; h := S1[2]; hh := h10+h;
           m10 := S1[4]; m := S1[5]; mm := m10+m;
           s10 := S1[7]; s := S1[8]; ss := s10+s;
           if CharInSet(h10,[' ','0'..'2']) and CharInSet(h,[' ','0'..'9']) and
              CharInSet(m10,[' ','0'..'5']) and CharInSet(m,[' ','0'..'9']) and
              CharInSet(s10,[' ','0'..'5']) and CharInSet(s,[' ','0'..'9']) and
              (StrToIntDef(String(hh),0)<24) and (StrToIntDef(String(mm),0)<60) and
              (StrToIntDef(String(ss),0)<60) then
           begin
             if (Feld.FeldLaenge =  8) then
               Result := StrToIntDef(String(hh),0)*3600 +
                         StrToIntDef(String(mm),0)*60 + StrToIntDef(String(ss),0)
             else if Feld.FeldLaenge = 10 then
             begin
               d10 := S1[10];
               Result :=
                 10*(StrToIntDef(String(hh),0)*3600 +StrToIntDef(String(mm),0)*60 +
                 StrToIntDef(String(ss),0)) + StrToIntDef(String(d10),0);
               ZtErfFormat := zfZehntel;
             end else if Feld.FeldLaenge = 11 then
             begin
               d10 := S1[10]; d := S1[11]; dd := d10+d;
               Result :=
                 100*(StrToIntDef(String(hh),0)*3600 + StrToIntDef(String(mm),0)*60 +
                 StrToIntDef(String(ss),0)) + StrToIntDef(String(dd),0);
               ZtErfFormat := zfHundertstel;
             end;
           end;
         end;
  end;
  // Result auf Hundertstel umrechnen
  case ZtErfFormat of
    zfSek     : if Result > 0 then Result := Result * 100;
    zfZehntel : if Result > 0 then Result := Result * 10;
    else ; // zfHundertstel, keine Aktion
  end;
end;

//******************************************************************************
function TlnDoppelEintrag(Tln:TTlnObj;Zeit:Integer): Boolean;
//******************************************************************************
// prüfen ob Zeit bereits vorher eingelesen wurde
// Zeitgleichheit auch filtern (zeItemDoppelt)
var i      : Integer;
    AbsCnt : TWkAbschnitt;
begin
  Result := false;
  if (ZeitFilter < 0) or (Zeit < 0) then Exit;
  for AbsCnt := wkAbs1 to wkAbs8 do
  with Tln.GetZeitRecColl(AbsCnt) do
    for i:=0 to Count-1 do // mit Startzeit
      if (Items[i].ErfZeit >= 0) and
         (Abs(Zeit - Items[i].ErfZeit) <= ZeitFilter) then
      begin
        Result := true;
        Exit;
      end;
end;

//==============================================================================
constructor TdBaseFeldInfoObj.Create(Veranst:Pointer;Coll:TTriaObjColl;Add:TOrtAdd);
//==============================================================================
begin
  inherited Create(Veranst,Coll,Add);
  FeldName   := '';
  FeldType   := chr(0);
  FeldLaenge := 0;
  Dezimalen  := 0;
end;

//==============================================================================
function TdBaseFeldInfoObj.ObjSize: Integer;
//==============================================================================
begin
  // Dummy, nur um Compiler-Warnings zu vermeiden
  Result := 0;
end;

//==============================================================================
procedure TdBaseFeldInfoObj.Init(NameNeu:ShortString{Str10};TypeNeu:AnsiChar;LaengeNeu,DeziNeu:Byte);
//==============================================================================
begin
  FeldName   := NameNeu;
  FeldType   := TypeNeu;
  FeldLaenge := LaengeNeu;
  Dezimalen  := DeziNeu;
end;

//==============================================================================
procedure TdBaseFeldInfoObj.OrtCollAdd;
//==============================================================================
begin
  // Dummy, nur um Compiler-Warnings zu vermeiden
end;

//==============================================================================
procedure TdBaseFeldInfoObj.OrtCollClear(Indx:Integer);
//==============================================================================
begin
  // Dummy, nur um Compiler-Warnings zu vermeiden
end;

//==============================================================================
procedure TdBaseFeldInfoObj.OrtCollExch(Idx1,Idx2:Integer);
//==============================================================================
begin
  // Dummy, nur um Compiler-Warnings zu vermeiden
end;

//------------------------------------------------------------------------------
function TdBaseFeldInfoColl.SortString(Item:Pointer): String;
//------------------------------------------------------------------------------
begin
  // Dummy, nur um Compiler-Warnings zu vermeiden
end;

(******************************************************************************)
(*           Methoden von TZtEinlDialog                                       *)
(******************************************************************************)

// public Methoden

//==============================================================================
constructor TZtEinlDialog.Create(AOwner: TComponent);
//==============================================================================
var i : Integer;
begin
  inherited Create(AOwner);

  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  DisableButtons := false;

  with FormatCB do
    if RfidModus then
    begin
      Items.Append('TriaZeit');
      Items.Append('Sonstige');
    end else
    begin
      Items.Append('TriaZeit');
      Items.Append('Backnang');
      Items.Append('ZERF');
      Items.Append('GiS');
      Items.Append('Sportronic');
      Items.Append('DAG');
      Items.Append('Mandigo');
      Items.Append('Sonstige');
    end;

  InitDateiCB;

  SetTrennZeichen(';');

  SnrPosEdit.EditMask  := '09;0; ';
  ZeitPosEdit.EditMask := '09;0; ';
  SnrPosUpDown.Min     := 1;
  SnrPosUpDown.Max     := 99;
  ZeitPosUpDown.Min    := 1;
  ZeitPosUpDown.Max    := 99;

  InitFormatCB(ZtErfDateiFormat);
  InitFormatGB; // nach InitFormatCB

  // Init Arrays
  AbschnCB[wkAbs1] := Abschn1CB;
  AbschnCB[wkAbs2] := Abschn2CB;
  AbschnCB[wkAbs3] := Abschn3CB;
  AbschnCB[wkAbs4] := Abschn4CB;
  AbschnCB[wkAbs5] := Abschn5CB;
  AbschnCB[wkAbs6] := Abschn6CB;
  AbschnCB[wkAbs7] := Abschn7CB;
  AbschnCB[wkAbs8] := Abschn8CB;
  AbschnEdit[wkAbs1] := Abschn1Edit;
  AbschnEdit[wkAbs2] := Abschn2Edit;
  AbschnEdit[wkAbs3] := Abschn3Edit;
  AbschnEdit[wkAbs4] := Abschn4Edit;
  AbschnEdit[wkAbs5] := Abschn5Edit;
  AbschnEdit[wkAbs6] := Abschn6Edit;
  AbschnEdit[wkAbs7] := Abschn7Edit;
  AbschnEdit[wkAbs8] := Abschn8Edit;

  with Veranstaltung.WettkColl do
  begin
    if (Count > 1) and (AlleAbschnGleich) then
    WettkCB.Items.AddObject('Alle Wettkämpfe',WettkAlleDummy);
    for i:=0 to Count-1 do
      WettkCB.Items.AddObject(Items[i].Name,Items[i]);
  end;
  WettkCB.ItemIndex := 0;
  if (GetWettk=WettkAlleDummy) and (HauptFenster.SortWettk<>WettkAlleDummy) then
    WettkCB.ItemIndex := WettkCB.Items.IndexOfObject(HauptFenster.SortWettk);

  CancelButton.Cancel := true;

  if LiveErfDlg then
  begin
    Caption := 'Live Zeiterfassung';
    LetzterTlnCB.Checked := LetzterTlnFocus; // Letzte Einstellung übernehmen
    with OkButton do
    begin
      Caption := 'Live Zeiterfassung starten';
      Left    := 16;
      Width   := 205;
      HelpContext := 2213;
    end;
  end else
  begin
    LetzterTlnCB.Hide;
    LetzterTlnCB.Checked := false;
    Height := Height - OkButton.Top + LetzterTlnCB.Top;
    OkButton.Top     := LetzterTlnCB.Top;
    CancelButton.Top := LetzterTlnCB.Top;
    HilfeButton.Top  := LetzterTlnCB.Top;
  end;

  ZeitenBehaltenCB.Checked := ZeitenBehalten;

  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);
end;

//==============================================================================
destructor TZtEinlDialog.Destroy;
//==============================================================================
begin
  HelpFenster := HelpFensterAlt;
  inherited Destroy;
end;

// protected Methoden

//------------------------------------------------------------------------------
procedure TZtEinlDialog.FormActivate(Sender: TObject);
//------------------------------------------------------------------------------
// ausgeführt nach Create und nach Schliessen von DateiDialog
begin
  FormatCB.Enabled := true;
  DateiCB.Enabled := true;
  DateiBtn.Enabled := true;
  FormatGB.Enabled := true;
  WettkCB.Enabled := true;
  AbschnittGB.Enabled := true;
  SetAbschnitt;

  OkButton.Enabled := true;
  CancelButton.Enabled := true;
  if HelpDateiVerfuegbar then HilfeButton.Enabled := true
                         else HilfeButton.Enabled := false;
end;

//------------------------------------------------------------------------------
procedure TZtEinlDialog.FormDeactivate(Sender: TObject);
//------------------------------------------------------------------------------
// ausgeführt bei Aufruf von DateiDialog
begin
  FormatCB.Enabled := false;
  DateiCB.Enabled := false;
  DateiBtn.Enabled := false;
  FormatGB.Enabled := false;
  WettkCB.Enabled := false;
  AbschnittGB.Enabled := false;
  Abschn1CB.Enabled := false;
  Abschn2CB.Enabled := false;
  Abschn3CB.Enabled := false;
  Abschn4CB.Enabled := false;
  Abschn5CB.Enabled := false;
  Abschn6CB.Enabled := false;
  Abschn7CB.Enabled := false;
  Abschn8CB.Enabled := false;

  OkButton.Enabled := false;
  CancelButton.Enabled := false;
  HilfeButton.Enabled := false;
end;

//------------------------------------------------------------------------------
procedure TZtEinlDialog.InitFormatCB(FormatNeu: TTrzDateiFormat);
//------------------------------------------------------------------------------
begin
  if RfidModus then
    case FormatNeu of
      fzSonstig:   FormatCB.ItemIndex := 1;
      else         FormatCB.ItemIndex := 0; // fzTriaZeit
    end
  else
    case FormatNeu of
      fzTCBacknang: FormatCB.ItemIndex := 1;
      fzZERF:       FormatCB.ItemIndex := 2;
      fzGiS:        FormatCB.ItemIndex := 3;
      fzSportronic: FormatCB.ItemIndex := 4;
      fzDAG:        FormatCB.ItemIndex := 5;
      fzMandigo:    FormatCB.ItemIndex := 6;
      fzSonstig:    FormatCB.ItemIndex := 7;
      else          FormatCB.ItemIndex := 0; // fzTriaZeit
    end;
end;

//------------------------------------------------------------------------------
function TZtEinlDialog.GetTrzDateiFormat: TTrzDateiFormat;
//------------------------------------------------------------------------------
begin
  if RfidModus then
    case FormatCB.ItemIndex of
      1:   Result := fzSonstig;
      else Result := fzTriaZeit;
    end
  else
    case FormatCB.ItemIndex of
      1:   Result := fzTCBacknang;
      2:   Result := fzZERF;
      3:   Result := fzGiS;
      4:   Result := fzSportronic;
      5:   Result := fzDAG;
      6:   Result := fzMandigo;
      7:   Result := fzSonstig;
      else Result := fzTriaZeit;
    end;
end;

//------------------------------------------------------------------------------
procedure TZtEinlDialog.InitDateiCB;
//------------------------------------------------------------------------------
var i : Integer;
    S,S1,S2: String;
begin
  with DateiCB do
  begin
    Items.Clear;
    for i:=0 to ZeitErfDateiListe.Count-1 do
    begin
      S := ZeitErfDateiListe[i];
      if Canvas.TextWidth(S) > ClientWidth-46 then
      begin
        S1 := Copy(S,1,16);
        S2 := S;
        Delete(S2,1,16);
        S := S1+'...'+S2;
        while Canvas.TextWidth(S) > ClientWidth-46 do
        begin
          Delete(S2,1,1);
          S := S1+'...'+S2;
        end;
      end;
      AddItem(S,nil);
    end;
    if Items.Count > 0 then ItemIndex := 0;
  end;
end;

//------------------------------------------------------------------------------
function TZtEinlDialog.GetTrennZeichen: String;
//------------------------------------------------------------------------------
begin
  case TrennZeichenCB.ItemIndex of
    1 : Result  := ',';
    2 : Result  := ' ';
    3 : Result  := #9; // TAB
    else Result := ';';
  end;
end;

//------------------------------------------------------------------------------
procedure TZtEinlDialog.SetTrennZeichen(S:String);
//------------------------------------------------------------------------------
begin
  if S = ',' then TrennZeichenCB.ItemIndex := 1
  else if S = ' ' then TrennZeichenCB.ItemIndex := 2
  else if S = #9 then TrennZeichenCB.ItemIndex := 3
  else TrennZeichenCB.ItemIndex := 0; // tzSemikolon
end;

//------------------------------------------------------------------------------
procedure TZtEinlDialog.InitFormatGB;
//------------------------------------------------------------------------------
begin
  if GetTrzDateiFormat = fzSonstig then
  begin
    FormatGB.Enabled := true;
    HeaderCB.Enabled := true;
    SnrPosLabel1.Enabled := true;
    SnrPosLabel2.Enabled := true;
    SnrPosEdit.Enabled := true;
    SnrPosUpDown.Enabled := true;
    TrennZeichenLabel.Enabled := true;
    TrennZeichenCB.Enabled := true;
    TrennZeitCB.Enabled := true;
    TrennZeitLabel.Enabled := true;
    ZeitPosLabel1.Enabled := true;
    ZeitPosLabel2.Enabled := true;
    ZeitPosEdit.Enabled := true;
    ZeitPosUpDown.Enabled := true;
    ZeitFormLabel.Enabled := true;
    ZeitFormCB.Enabled := true;
  end else
  begin
    FormatGB.Enabled := false;
    HeaderCB.Enabled := false;
    SnrPosLabel1.Enabled := false;
    SnrPosLabel2.Enabled := false;
    SnrPosEdit.Enabled := false;
    SnrPosUpDown.Enabled := false;
    TrennZeichenLabel.Enabled := false;
    TrennZeichenCB.Enabled := false;
    TrennZeitCB.Enabled := false;
    TrennZeitLabel.Enabled := false;
    ZeitPosLabel1.Enabled := false;
    ZeitPosLabel2.Enabled := false;
    ZeitPosEdit.Enabled := false;
    ZeitPosUpDown.Enabled := false;
    ZeitFormLabel.Enabled := false;
    ZeitFormCB.Enabled := false;
  end;

  if RfidModus then
  begin
    SnrPosLabel1.Caption := 'RFID-Code';
    case GetTrzDateiFormat of
      fzTriaZeit:
      begin
        HeaderCB.Checked := false;
        SnrPosEdit.Text  := '1';
        SetTrennZeichen(#9);
        ZeitPosEdit.Text := '2';
        SetZeitFormat(ZeitFormat);
        SetZeitTrennzeichen(':');
      end;
      fzSonstig:
      begin
        HeaderCB.Checked := ZtErfHeader;
        SnrPosEdit.Text  := IntToStr(ZtErfSnrPos);
        SetTrennZeichen(ZtErfTrennung);
        ZeitPosEdit.Text := IntToStr(ZtErfZeitPos);
        SetZeitFormat(ZtErfFormat);
        SetZeitTrennzeichen(ZtErfZeitTrenn);
      end;
    end;
  end else
  begin
    SnrPosLabel1.Caption := 'Startnummer';
    case GetTrzDateiFormat of
      fzTriaZeit:
      begin
        HeaderCB.Checked := false;
        SnrPosEdit.Text  := '1';
        SetTrennZeichen(#9);
        ZeitPosEdit.Text := '2';
        SetZeitFormat(ZeitFormat);
        SetZeitTrennzeichen(':');
      end;
      fzSonstig:
      begin
        HeaderCB.Checked := ZtErfHeader;
        SnrPosEdit.Text  := IntToStr(ZtErfSnrPos);
        SetTrennZeichen(ZtErfTrennung);
        ZeitPosEdit.Text := IntToStr(ZtErfZeitPos);
        SetZeitFormat(ZtErfFormat);
        SetZeitTrennzeichen(ZtErfZeitTrenn);
      end;
      else //fzTCBacknang,fzZERF,fzGiS,fzSportronic,fzDAG,fzMandigo
      begin
        HeaderCB.Checked := false;
        SnrPosEdit.Text  := ''; // nicht benutzt
        TrennZeichenCB.ItemIndex := -1;
        ZeitPosEdit.Text := '';
        ZeitFormCB.ItemIndex := -1;
        TrennZeitCB.ItemIndex := -1;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TZtEinlDialog.GetZeitTrennzeichen: String;
//------------------------------------------------------------------------------
begin
  case TrennZeitCB.ItemIndex of
    1 :  Result := '';
    else Result := ':';
  end;
end;

//------------------------------------------------------------------------------
procedure TZtEinlDialog.SetZeitTrennzeichen(TrennzeichenNeu:String);
//------------------------------------------------------------------------------
// Items in Create gesetzt
begin
  if StrGleich(TrennzeichenNeu,'') then TrennZeitCB.ItemIndex := 1
  else TrennZeitCB.ItemIndex := 0;
end;

//------------------------------------------------------------------------------
function TZtEinlDialog.GetZeitFormat: TZeitFormat;
//------------------------------------------------------------------------------
begin
  case ZeitFormCB.ItemIndex of
    1 :  Result := zfZehntel;
    2 :  Result := zfHundertstel;
    else Result := zfSek;
  end;
end;

//------------------------------------------------------------------------------
procedure TZtEinlDialog.SetZeitFormat(ZtFormatNeu:TZeitFormat);
//------------------------------------------------------------------------------
// Items in Create gesetzt
begin
  case ZtFormatNeu of
    zfSek         : ZeitFormCB.ItemIndex := 0;
    zfZehntel     : ZeitFormCB.ItemIndex := 1;
    zfHundertstel : ZeitFormCB.ItemIndex := 2;
  end;
end;

//------------------------------------------------------------------------------
function TZtEinlDialog.GetWettk: TWettkObj;
//------------------------------------------------------------------------------
begin
  if WettkCB.ItemIndex >= 0 then
    Result := TWettkObj(WettkCB.Items.Objects[WettkCB.ItemIndex])
  else Result := WettkAlleDummy;
end;

//------------------------------------------------------------------------------
procedure TZtEinlDialog.SetAbschnitt;
//------------------------------------------------------------------------------
var AbsCnt : TWkAbschnitt;
begin
  if Veranstaltung.SGrpColl.WettkStartModus(GetWettk,wkAbs1) = stOhnePause then
    EinzelStartCB.Enabled := true
  else
  begin
    EinzelStartCB.Checked := false;
    EinzelStartCB.Enabled := false;
  end;

  for AbsCnt:=wkAbs1 to wkAbs8 do
  begin
    AbschnEdit[AbsCnt].Text := GetWettk.AbschnName[AbsCnt];
    if GetWettk.AbschnZahl >= Integer(AbsCnt) then
    begin
      AbschnEdit[AbsCnt].Enabled := true;
      AbschnCB[AbsCnt].Enabled   := true;
    end else
    begin
      AbschnEdit[AbsCnt].Enabled := false;
      AbschnCB[AbsCnt].Enabled   := false;
      AbschnCB[AbsCnt].Checked   := false; // löschen wenn disabled
    end;
  end;

  if GetWettk.AbschnZahl=1 then
  begin
    AbschnEdit[wkAbs1].Text    := '';
    AbschnEdit[wkAbs1].Enabled := false; // nur Edit disabled
    if not EinzelStartCB.Enabled then
      AbschnCB[wkAbs1].Checked := true;  // bei 1 Abs. immer checked
  end;

end;

//------------------------------------------------------------------------------
function TZtEinlDialog.SetAbschnArr: Boolean;
//------------------------------------------------------------------------------
var AbsCnt : TWkAbschnitt;
begin
  Result := false;
  if EinzelStartCB.Checked then
  begin
    ZtErfAbschnArr[wkAbs0] := true;
    Result := true;
  end
  else ZtErfAbschnArr[wkAbs0] := false;

  for AbsCnt:=wkAbs1 to wkAbs8 do
    if AbschnCB[AbsCnt].Checked then
    begin
      ZtErfAbschnArr[AbsCnt] := true;
      Result := true;
    end
    else ZtErfAbschnArr[AbsCnt] := false;
end;

//------------------------------------------------------------------------------
function TZtEinlDialog.DateiIndx(DatName: String): Integer;
//------------------------------------------------------------------------------
var i : Integer;
begin
  Result := - 1;
  if StrGleich(DatName,'') then Exit;
  for i:=0 to ZeitErfDateiListe.Count-1 do
    if StrGleich(DatName,ZeitErfDateiListe[i]) then
    begin
      Result := i;
      Exit;
    end;
end;

//------------------------------------------------------------------------------
procedure TZtEinlDialog.UpdateDateiListe(DatName: String);
//------------------------------------------------------------------------------
var i : Integer;
begin
  if Trim(DatName) = '' then Exit;
  i := DateiIndx(Trim(DatName)); // Datei an 1. Position der Liste setzen
  if i <> 0 then
  begin
    if i < 0 then // Datei noch nicht in Liste
      if ZeitErfDateiListe.Count >= cnZtErfDatListeMax then
        ZeitErfDateiListe.Delete(ZeitErfDateiListe.Count-1)
      else
    else if i > 0 then // Datei in Liste vorhanden (Pos > 0)
      ZeitErfDateiListe.Delete(i);
    ZeitErfDateiListe.Insert(0,Trim(DatName));
  end; // else Datei bereits an 1. pos., keine Aktion

  InitDateiCB;
end;

//------------------------------------------------------------------------------
procedure TZtEinlDialog.ZtErfDateiOeffnen;
//------------------------------------------------------------------------------
var Dir,DatName,Filter : String;
    FilterIndx : Integer;
begin
  if (DateiCB.ItemIndex >= 0) and (DateiCB.ItemIndex < ZeitErfDateiListe.Count) then
    DatName := ZeitErfDateiListe[DateiCB.ItemIndex]
  else DatName := '';
  if DatName <> '' then
    Dir     := SysUtils.ExtractFileDir(DatName)
  else
    Dir     := SysUtils.ExtractFileDir(TriDatei.Path);

  DatName := '';
  case GetTrzDateiFormat of
    fzTriaZeit:   Filter := 'TriaZeit Dateien (*'+TrzDateiExt(fzTriaZeit)+')|*'+TrzDateiExt(fzTriaZeit)+'|';
    fzTCBacknang: Filter := 'TC Backnang Dateien (*'+TrzDateiExt(fzTCBacknang)+')|*'+TrzDateiExt(fzTCBacknang)+'|';
    fzZERF:       Filter := 'ZERF Dateien (*'+TrzDateiExt(fzZerf)+')|*'+TrzDateiExt(fzZerf)+'|';
    fzGiS:        Filter := 'GiS Dateien (*'+TrzDateiExt(fzGis)+')|*'+TrzDateiExt(fzGis)+'|';
    fzSportronic: Filter := 'Sportronic Dateien (*'+TrzDateiExt(fzSportronic)+')|*'+TrzDateiExt(fzSportronic)+'|';
    fzDAG:        Filter := 'DAG Dateien (*'+TrzDateiExt(fzDAG)+')|*'+TrzDateiExt(fzDAG)+'|';
    fzMandigo:    Filter := 'Mandigo Dateien (*'+TrzDateiExt(fzMandigo)+')|*'+TrzDateiExt(fzMandigo)+'|';
    fzSonstig:    Filter := '';
  end;
  Filter := Filter + 'Alle Dateien (*.*)|*.*';
  FilterIndx := 1;

  ZtEinlDialog.DeActivate;
  if OpenFileDialog('*',Filter,Dir,FilterIndx,'Zeiterfassungsdatei öffnen',DatName) then
    UpdateDateiListe(DatName);
  ZtEinlDialog.Activate;
end;

// Event Handler

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtEinlDialog.FormatLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if FormatCB.CanFocus then FormatCB.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtEinlDialog.FormatCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  InitFormatGB;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtEinlDialog.DateiLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if DateiCB.CanFocus then DateiCB.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtEinlDialog.DateiBtnClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  ZtErfDateiOeffnen;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtEinlDialog.WettkLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if WettkCB.CanFocus then WettkCB.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtEinlDialog.WettkCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  SetAbschnitt;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtEinlDialog.AbschnEditClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var AbsCnt : TWkAbschnitt;
begin
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if Sender = AbschnEdit[AbsCnt] then
    begin
      AbschnCB[AbsCnt].Checked := not AbschnCB[AbsCnt].Checked;
      Break;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtEinlDialog.OkButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var DatFormat : TTrzDateiFormat;
    DatName   : String;
    //L         : Integer;
begin
  if not DisableButtons then
  try
    DisableButtons := true;

    // Dateiname prüfen
    if (DateiCB.ItemIndex >= 0) and (DateiCB.ItemIndex < ZeitErfDateiListe.Count) then
      DatName := ZeitErfDateiListe[DateiCB.ItemIndex]
    else DatName := '';
    if StrGleich(DatName,'') then
    begin
      TriaMessage(Self,'Der Dateiname fehlt.',mtInformation,[mbOk]);
      DateiCB.SetFocus;
      Exit;
    end;

    // Abschnitt prüffen
    if not SetAbschnArr then
    begin
      TriaMessage(Self,'Es muss mindestens eine Zeit zum einlesen gewählt werden.',mtInformation,[mbOk]);
      AbschnittGB.SetFocus;
      Exit;
    end;
    ZtErfWettkampf := GetWettk;

    // Dateiformat prüfen
    DatFormat := GetTrzDateiFormat;
    if DatFormat = fzSonstig then // sonst FormatGB disabled
    begin
      if not SnrPosEdit.ValidateEdit then Exit;
      if not ZeitPosEdit.ValidateEdit then Exit;
      if (StrToIntDef(SnrPosEdit.Text,0) <= 0) or (StrToIntDef(ZeitPosEdit.Text,0) <= 0) or
         (StrToInt(SnrPosEdit.Text) = StrToInt(ZeitPosEdit.Text)) then
      begin
        TriaMessage(Self,'Die Spalten sind ungültig.',mtInformation,[mbOk]);
        if SnrPosEdit.CanFocus then SnrPosEdit.SetFocus;
        Exit;
      end;
    end;

    // FormatGB übernehmen, nur gültig für fzTriaZeit und fzSonstig
    ZtErfHeader := HeaderCB.Checked;
    if SnrPosEdit.Text <> '' then         ZtErfSnrpos := StrToInt(SnrPosEdit.Text);
    if TrennZeichenCB.ItemIndex >= 0 then ZtErfTrennung  := GetTrennZeichen;
    if ZeitPosEdit.Text <> '' then        ZtErfZeitPos := StrToInt(ZeitPosEdit.Text);
    if ZeitFormCB.ItemIndex >= 0 then     ZtErfFormat := GetZeitFormat;
    if TrennZeitCB.ItemIndex >= 0 then    ZtErfZeitTrenn := GetZeitTrennzeichen;

    // Daten übernemen
    ZtErfDateiFormat := DatFormat;
    ZtErfDateiName   := DatName;
    UpdateDateiListe(DatName);
    ZeitenBehalten   := ZeitenBehaltenCB.Checked;
    if LiveErfDlg then
      LetzterTlnFocus  := LetzterTlnCB.Checked;

    if LiveErfDlg then
      if LiveZtErfStarten then
        ModalResult := mrOk
      else
    else ZtErfDatEinlesen; // Dialog immer stehen lassen und über Abbrechen beenden

  finally
    DisableButtons := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtEinlDialog.HilfeButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if LiveErfDlg then
     Application.HelpContext(2250) // Live Zeiterfasung
  else
    Application.HelpContext(2200); // Zeitnahme
end;


end.
