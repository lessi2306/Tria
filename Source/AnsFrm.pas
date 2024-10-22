unit AnsFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ToolWin, ComCtrls, Math,
  AllgObj,AllgConst,AllgFunc,VeranObj,WettkObj,AkObj,SMldObj,CmdProc;

function smString(SortMode:TSortMode): String;
function anString(Ansicht:TAnsicht): String;
function stString(Status:TStatus): String;
function sxString(Sex:TSex): String;

type

  TAnsFrame = class(TFrame)
    AnsichtCBLabel: TLabel;
    AnsichtCB: TComboBox;
    SortModeCBLabel: TLabel;
    SortModeCB: TComboBox;
    WettkampfCBLabel: TLabel;
    WettkampfCB: TComboBox;
    SexCBLabel: TLabel;
    SexCB: TComboBox;
    KlasseCBLabel: TLabel;
    KlasseCB: TComboBox;
    StatusCBlabel: TLabel;
    StatusCB: TComboBox;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Init(AnsichtNeu:TAnsicht;ModeNeu:TSortMode;
                   WkNeu:TWettkObj;WrtgModeNeu:TWertungMode;
                   SexNeu:TSex;AkNeu:TAkObj;StatusNeu:TStatus);
    procedure Refresh; (* bestehende Einstellung unver�ndert *)
    procedure SetEnable(En:Boolean);
    function ZeigeMschAnsicht(Wk:TWettkObj): Boolean;
    function ZeigeMschKompakt(Wk:TWettkObj): Boolean;
    procedure SetzeMschKlasseKompakt(Wk:TWettkObj;var Sx:TSex;var Kl:TAkObj);
    function ZeigeTlnSchwDist(Wk:TWettkObj): Boolean;
  protected
    procedure InitAnsichtListe(AnsichtNeu:TAnsicht;var Wk:TWettkObj;var Sx:TSex;var Kl:TAkObj);
    function  GetAnsicht: TAnsicht;
    procedure InitSortModeListe(ModeNeu:TSortMode);
    function  GetSortMode: TSortMode;
    procedure InitWettkListe(WkNeu:TWettkObj;WrtgNeu:TWertungMode);
    function  GetSortWettk: TWettkObj;
    function  GetSortWrtg: TWertungMode;
    procedure InitSexListe(SexNeu:TSex);
    function  GetSortSex: TSex;
    procedure InitKlasseListe(AkNeu:TAkObj);
    function  GetSortKlasse: TAkObj;
    procedure InitStatusListe(StatusNeu:TStatus);
    function  GetSortStatus: TStatus;
  published
    procedure AnsichtCBLabelClick(Sender: TObject);
    procedure AnsichtCBChange(Sender: TObject);
    procedure SortModeCBLabelClick(Sender: TObject);
    procedure SortModeCBChange(Sender: TObject);
    procedure WettkampfCBLabelClick(Sender: TObject);
    procedure WettkampfCBChange(Sender: TObject);
    procedure SexCBLabelClick(Sender: TObject);
    procedure SexCBChange(Sender: TObject);
    procedure KlasseCBLabelClick(Sender: TObject);
    procedure KlasseCBChange(Sender: TObject);
    procedure StatusCBlabelClick(Sender: TObject);
    procedure StatusCBChange(Sender: TObject);
    procedure ComboBoxCloseUp(Sender: TObject);
    procedure ComboBoxKeyPress(Sender: TObject; var Key: Char);
  end;

implementation

uses SMldFrm, TriaMain, ImpFrm, DateiDlg, TlnErg, SuchenDlg, MannsObj;

{$R *.dfm}

(******************************************************************************)
function anString(Ansicht:TAnsicht): String;
(******************************************************************************)
// Strings m�ssen f�r jede Ansicht unterschiedlich sein (AnsichtCB)
begin
  case Ansicht of
    //anKein           : Result := '-------------------------------------------'+
    //                             '-------------';
    anKein           : Result := ' ';
    anAnmEinzel      : Result := 'Anmeldung - Einzel';
    anAnmSammel      : Result := 'Anmeldung - Verein';
    anTlnStart       : Result := 'Startliste - Teilnehmer';
    anMschStart      : Result := 'Startliste - Mannschaften';
    anTlnErg         : Result := 'Ergebnisliste - Teilnehmer';
    anMschErgDetail  : Result := 'Mannschaftswertung - Detailliert';
    anMschErgKompakt : Result := 'Mannschaftswertung - Kompakt';
    anTlnErgSerie    : Result := 'Serienwertung - Teilnehmer';
    anMschErgSerie   : Result := 'Serienwertung - Mannschaften';
    anTlnUhrZeit     : Result := 'Kontrolliste - Uhrzeiten';
    anTlnRndKntrl    : Result := 'Kontrolliste - Runden';
    anTlnSchwDist    : Result := 'Checkliste - Bahnen';
  end;
end;

(******************************************************************************)
function smString(SortMode:TSortMode): String;
(******************************************************************************)
// Strings f�r SortModeCB m�ssen f�r jede SortMode unterschiedlich sein
begin
  case SortMode of
    smTlnName             : Result := 'Name, Vorname';
    smMschName,
    smMschErgMschName     : Result := Veranstaltung.MschSpalteUeberschrift(HauptFenster.Sortwettk);
    smTlnErstellt         : Result := 'Erstellt';
    smTlnBearbeitet       : Result := 'Bearbeitet';
    smTlnSnr,
    smMschTlnSnr          : Result := 'Startnummer';
    smTlnSBhn             : Result := 'Startbahn';
    smTlnAlter,
    smTlnSnrAlter,
    smTlnErgAlter,
    smTlnSerErgAlter      : Result := 'Alter';
    smTlnAk,
    smTlnSnrAk,
    smTlnErgAk,
    smTlnSerErgAk         : Result := 'Altersklasse';
    smTlnMschName,
    smTlnErgMschName,
    smTlnSerErgMschName   : Result := Veranstaltung.TlnMschSpalteUeberschrift(HauptFenster.Sortwettk);
    smTlnMschGroesse      : Result := Veranstaltung.TlnMschGroesseBezeichnung(HauptFenster.Sortwettk);
    smTlnMldZeit          : Result := 'Meldezeit';
    smTlnStartgeld        : Result := 'Startgeld';
    smTlnRfid             : Result := 'RFID-Code';

    smTlnAbs1StartZeit,
    smMschAbs1StartZeit   : Result := 'Startzeit';

    smTlnAbs2StartZeit..smTlnAbs8StartZeit:
      Result := 'Start Abschn. ' +
                IntToStr(Integer(SortMode)-Integer(smTlnAbs2StartZeit)+2);
    smMschAbs2StartZeit..smMschAbs8StartZeit:
      Result := 'Start Abschn. ' +
                IntToStr(Integer(SortMode)-Integer(smMschAbs2StartZeit)+2);

    smTlnErg              : if HauptFenster.Sortwettk.WettkArt=waStndRennen then
                              Result := 'Gesamtstrecke'
                            else Result := 'Endzeit';
    smTlnAbs1UhrZeit      : if HauptFenster.Sortwettk.AbschnZahl>1 then
                              Result := 'Abschn.1 Zeit'
                            else Result := 'Endzeit';

    smTlnAbs2UhrZeit..smTlnAbs8UhrZeit:
      Result := 'Abschn.' + IntToStr(Integer(SortMode)-Integer(smTlnAbs2UhrZeit)+2)+
                ' Zeit';

    smTlnAbs1Zeit..smTlnAbs8Zeit:
      Result := 'Abschn.' + IntToStr(Integer(SortMode)-Integer(smTlnAbs1Zeit)+1)+
                ' Zeit';
    smTlnSMld             : Result := 'Sammelmelder';
    smTlnSerErg,
    smMschSerErg          : Result := 'Gesamtergebnis';
    smMschErg             : if HauptFenster.Sortwettk.WettkArt=waStndRennen then
                              Result := 'Gesamtstrecke'
                            else if HauptFenster.Sortwettk.MschWrtgMode = wmTlnZeit then
                              Result := 'Endzeit'
                            else Result := 'Punkte';
    smTlnAbsRnd           : Result := 'Runden';
    smTlnAbsRndStZeit     : Result := 'Startzeit';
    smTlnStoppZeit        : Result := 'Stoppzeit';
    smTlnMinRndZeit       : Result := 'Min-Rundezeit';
    smTlnMaxRndZeit       : Result := 'Max-Rundezeit';
    smTlnAbsRndEffZeit    : if HauptFenster.Sortwettk.AbschnZahl>1 then
                              Result := 'Abschnittszeit'
                            else Result := 'Endzeit';
    else                    Result := 'Name';
  end;
end;

(******************************************************************************)
function stString(Status:TStatus): String;
(******************************************************************************)
begin
  case Status of
    stGemeldet        : Result := 'Alle';
    stSerGemeldet     : Result := 'Gemeldet';
    stEingeteilt      : Result := 'Eingeteilt';
    stDisqualifiziert : Result := 'Disqualifiziert';
    //stGestartet,
    stZeitVorhanden   : Result := 'Gestartet';
    stAbs1Start       : if HauptFenster.Sortwettk.AbSchnZahl > 1 then
                          Result := 'Abschnitt 1'
                        else Result := 'Gestartet';
    stAbs2Start..stAbs8Start:
      Result := 'Abschnitt ' + IntToStr(Integer(Status)-Integer(stAbs2Start)+2);
    stAbs1Zeit..stAbs8Zeit:
      Result := 'Abschnitt ' + IntToStr(Integer(Status)-Integer(stAbs1Zeit)+1);
    stAbs1Ziel..stAbs7Ziel:
      Result := 'Abschnitt ' + IntToStr(Integer(Status)-Integer(stAbs1Ziel)+1);

    stImZiel          : Result := 'Im Ziel';   // Endzeit g�ltig
    stGewertet,
    stSerWertung      : Result := 'Gewertet';  // Endzeit g�ltig, ohne Disq.
    stGewertetDisq    : Result := 'Gewertet+Disq.';// Endzeit g�ltig, mit Disq.
    stSerEndWertung   : Result := 'Endwertung'; // alle die in Endwertung kommen k�nnen
    stBahn1..stBahn16:
      Result := 'Bahn ' + IntToStr(Integer(Status)-Integer(stBahn1)+1);

    else                Result := 'Ohne Teiln.'; // stKein
  end;
end;

(******************************************************************************)
function sxString(Sex:TSex): String;
(******************************************************************************)
begin
  case Sex of
    cnSexBeide:  Result := 'Beide';
    cnMaennlich: Result := 'M�nnlich';
    cnWeiblich:  Result := 'Weiblich';
    cnMixed:     Result := 'Mixed';
    else         Result := '';
  end;
end;

// public Methoden

//==============================================================================
constructor TAnsFrame.Create(AOwner: TComponent);
//==============================================================================
begin
  inherited Create(AOwner);
  AnsichtCB.DropDownCount   := 26; // Liste maximal bis Unterkante Hauptfenster
  SortModeCB.DropDownCount  := 26;
  WettkampfCB.DropDownCount := 26;
  SexCB.DropDownCount       := 26;
  KlasseCB.DropDownCount    := 26;
  StatusCB.DropDownCount    := 26;
end;

//==============================================================================
procedure TAnsFrame.Init(AnsichtNeu:TAnsicht;ModeNeu:TSortMode;
                         WkNeu:TWettkObj;WrtgModeNeu:TWertungMode;
                         SexNeu:TSex;AkNeu:TAkObj;StatusNeu:TStatus);
//==============================================================================
begin
  InitAnsichtListe(AnsichtNeu,WkNeu,SexNeu,AkNeu); // WkNeu,AkNeu wird angepasst, damit AnsichtNeu g�ltig ist
  InitWettkListe(WkNeu,WrtgModeNeu);
  InitSortModeListe(ModeNeu);
  InitSexListe(SexNeu);
  InitKlasseListe(AkNeu);
  InitStatusListe(StatusNeu);
end;

//==============================================================================
procedure TAnsFrame.Refresh;
//==============================================================================
// nach �nderung in Veranstaltung-Collections, die vorher sortiert werden
// nicht benutzen im Dialoge solange WettkSortcollection noch benutzt wird
var Wk : TWettkObj;
    Sx : TSex;
    Kl : TAkObj;
begin
  // nach TriDatSchliessen (Veranstaltung = nil) sollen alle CB blank werden
  with HauptFenster do
  begin
    Wk := SortWettk;
    Sx := SortSex;
    Kl := SortKlasse;
    InitAnsichtListe(Ansicht,Wk,Sx,Kl); // SortWettk,SortSex,SortKlasse unver�ndert
    InitWettkListe(SortWettk,SortWrtg);
    InitSortModeListe(SortMode);
    InitSexListe(Sx);
    InitKlasseListe(Kl);
    InitStatusListe(SortStatus);
  end;
end;

//==============================================================================
procedure TAnsFrame.SetEnable(En:Boolean);
//==============================================================================
begin
  with HauptFenster do
  begin
    {AnsichtCBLabel.Enabled := En;
    WettkampfCBLabel.Enabled := En;
    SortModeCBLabel.Enabled := En;
    SexCBLabel.Enabled := En;
    KlasseCBLabel.Enabled := En;
    StatusCBLabel.Enabled := En;}
    AnsichtCB.Enabled := En;
    WettkampfCB.Enabled := En;
    SortModeCB.Enabled := En;
    SexCB.Enabled := En;
    KlasseCB.Enabled := En;
    StatusCB.Enabled := En;
  end;
end;

//==============================================================================
function TAnsFrame.ZeigeMschAnsicht(Wk:TWettkObj): Boolean;
//==============================================================================
var i : Integer;
begin
  Result := false;
  if Wk = WettkAlleDummy then // true wenn mindestens ein Wettk mit MschWertg
    for i:=0 to Veranstaltung.WettkColl.Count-1 do
      if Veranstaltung.WettkColl[i].MschWertg <> mwKein then
      begin
        Result := true;
        Exit;
      end else
  else
  if Wk.MschWertg <> mwKein then Result := true;
end;

//==============================================================================
function TAnsFrame.ZeigeMschKompakt(Wk:TWettkObj): Boolean;
//==============================================================================
// true wenn mindestens ein Wettk mit KompaktMschWertg, unabh�ngig von SortWettk
var i : Integer;
begin
  Result := false;
  if Wk = WettkAlleDummy then // true wenn mindestens ein Wettk mit Kompakt-MschGr��e
    for i:=0 to Veranstaltung.WettkColl.Count-1 do
      with Veranstaltung.WettkColl[i] do
        if (MschWertg <> mwKein) and
           (MschWrtgMode <> wmSchultour) and
           (MschGroesseMin <= cnMschGrMaxKompakt) then
        begin
          Result := true;
          Exit;
        end else
  else with Wk do
    if (MschWertg <> mwKein) and
       (MschWrtgMode <> wmSchultour) and
       (MschGroesseMin <= cnMschGrMaxKompakt) then Result := true;
end;

//==============================================================================
procedure TAnsFrame.SetzeMschKlasseKompakt(Wk:TWettkObj;var Sx:TSex;var Kl:TAkObj);
//==============================================================================
// Wk <> WkAlleDummy
// f�r Wk mindestens eine Klasse g�ltig f�r KompaktMschWertg,
// Sx und Kl auf g�ltige Werte setzen
begin
  if not ZeigeMschKompakt(Wk) or
     (Wk.MschGroesse[Kl.Sex] <= cnMschGrMaxKompakt) then Exit; // Kl,Sx unver�ndert

  // g�ltige Klasse in Wk suchen
  with Wk do
    if MschGroesse[cnSexBeide] <= cnMschGrMaxKompakt then
    begin
      Sx := cnSexBeide;
      Kl := AkAlle;
    end else
    if (MschGroesse[cnMixed] <= cnMschGrMaxKompakt) then
    begin
      Sx := cnSexBeide;
      Kl := AkMixed;
    end else
    if MschGroesse[cnMaennlich] <= cnMschGrMaxKompakt then
    begin
      Sx := cnMaennlich;
      Kl := MaennerKlasse[tmMsch];
    end else
    if MschGroesse[cnWeiblich] <= cnMschGrMaxKompakt then
    begin
      Sx := cnWeiblich;
      Kl := FrauenKlasse[tmMsch];
    end; // else Result = false, kommt nicht vor
end;

//==============================================================================
function TAnsFrame.ZeigeTlnSchwDist(Wk:TWettkObj) : Boolean;
//==============================================================================
var i : Integer;
begin
  Result := false;
  if Wk = WettkAlleDummy then // true wenn mindestens ein Schwimm-Wettk
    for i:=0 to Veranstaltung.WettkColl.Count-1 do
      if Veranstaltung.WettkColl[i].SchwimmDistanz > 0 then
      begin
        Result := true;
        Exit;
      end else
  else
  if Wk.SchwimmDistanz > 0 then Result := true;
end;

// protected Methoden

//------------------------------------------------------------------------------
procedure TAnsFrame.InitAnsichtListe(AnsichtNeu:TAnsicht;var Wk:TWettkObj;var Sx:TSex;var Kl:TAkObj);
//------------------------------------------------------------------------------
// aufruf in InitAnsicht, RefreshAnsicht, WettkampfCBChange
// Ansicht nur zeigen, wenn in mindestens einem Wettk. g�ltig
// Wenn Ansicht f�r Wettk nicht g�ltig, dann g�ltigen Wettk w�hlen
var i : Integer;
//..............................................................................
procedure AppendAnsicht(AMode:TAnsicht);
begin
  AnsichtCB.Items.AddObject(anString(AMode),TObject(AMode));
end;
//..............................................................................
begin
  with AnsichtCB do
  begin
    Items.BeginUpdate; { prevent repaints until done }
    Items.Clear;
    ItemIndex := -1;
    HauptFenster.AnmEinzelAction.Checked      := false;
    HauptFenster.AnmSammelAction.Checked      := false;
    HauptFenster.TlnStartAction.Checked       := false;
    HauptFenster.TlnErgAction.Checked         := false;
    HauptFenster.TlnErgSerieAction.Checked    := false;
    HauptFenster.TlnUhrZeitAction.Checked     := false;
    HauptFenster.TlnRndKntrlAction.Checked    := false;
    HauptFenster.MschStartAction.Checked      := false;
    HauptFenster.MschErgDetailAction.Checked  := false;
    HauptFenster.MschErgKompaktAction.Checked := false;
    HauptFenster.MschErgSerieAction.Checked   := false;
    HauptFenster.TlnSchwBhnAction.Checked     := false;

    if Veranstaltung <> nil then
    begin

      // zuerst f�r AnsichtNeu g�ltiger Wk definieren, Annahme: AnsichtNeu wird �bernommen
      if Veranstaltung.WettkColl.Count > 0 then
        case AnsichtNeu of
          anAnmEinzel,
          anAnmSammel :
            if (Wk = WettkAlleDummy) and (Veranstaltung.WettkColl.Count = 1) then
              Wk := Veranstaltung.WettkColl[0];
          anTlnStart,
          anTlnErg,
          anTlnErgSerie:
            if Wk = WettkAlleDummy then
              Wk := Veranstaltung.WettkColl[0]; // 1. Wettk in WkListe
          anMschStart,
          anMschErgDetail,
          anMschErgSerie:
            if (Wk = WettkAlleDummy) or not ZeigeMschAnsicht(Wk) then // mindestens ein Wettk ist g�ltig
              if (HauptFenster.SortWettk <> WettkAlleDummy) and
                 ZeigeMschAnsicht(HauptFenster.SortWettk) then
                Wk := HauptFenster.SortWettk // SortWettk nach M�glichkeit beibehalten
              else
                for i:=0 to Veranstaltung.WettkColl.Count-1 do // suche 1. g�ltigen Wettk.
                  if ZeigeMschAnsicht(Veranstaltung.WettkColl[i]) then
                  begin
                    Wk := Veranstaltung.WettkColl[i];
                    Break;
                  end;
          anMschErgKompakt:
            if (Wk = WettkAlleDummy) or not ZeigeMschKompakt(Wk) then // mindestens ein Wettk ist g�ltig
              if (HauptFenster.SortWettk <> WettkAlleDummy) and
                 ZeigeMschKompakt(HauptFenster.SortWettk) then
              begin
                Wk := HauptFenster.SortWettk; // SortWettk nach M�glichkeit beibehalten
                SetzeMschKlasseKompakt(Wk,Sx,Kl);
              end else
                for i:=0 to Veranstaltung.WettkColl.Count-1 do
                  if ZeigeMschKompakt(Veranstaltung.WettkColl[i]) then
                  begin
                    Wk := Veranstaltung.WettkColl[i];
                    SetzeMschKlasseKompakt(Wk,Sx,Kl);
                    Break;
                  end else
            else // Wk ist Ok
              SetzeMschKlasseKompakt(Wk,Sx,Kl);

        anTlnUhrZeit,
        anTlnRndKntrl:
          if (Wk = WettkAlleDummy) and // WkAlle nur wenn alle mit gleicher Abschn-zahl
             ((Veranstaltung.WettkColl.Count=1) or not Veranstaltung.WettkColl.AlleAbschnGleich) then
            if HauptFenster.SortWettk <> WettkAlleDummy then
              Wk := HauptFenster.SortWettk // SortWettk nach M�glichkeit beibehalten
            else
              Wk := Veranstaltung.WettkColl[0];

        anTlnSchwDist:
          if ((Wk = WettkAlleDummy) and // WkAlle nur wenn alle mit Schwimmdistanz
              ((Veranstaltung.WettkColl.Count=1) or not Veranstaltung.WettkColl.AlleMitSchwDistanz)) or
             ((Wk <> WettkAlleDummy) and not ZeigeTlnSchwDist(Wk)) then
            if (HauptFenster.SortWettk <> WettkAlleDummy) and
               ZeigeTlnSchwDist(HauptFenster.SortWettk) then
              Wk := HauptFenster.SortWettk // SortWettk nach M�glichkeit beibehalten
            else
              for i:=0 to Veranstaltung.WettkColl.Count-1 do // suche 1. g�ltigen Wettk.
                if ZeigeTlnSchwDist(Veranstaltung.WettkColl[i]) then
                begin
                  Wk := Veranstaltung.WettkColl[i];
                  Break;
                end;
        else ; //anKein,
      end;

      // Init Liste
      AppendAnsicht(anAnmEinzel);
      AppendAnsicht(anAnmSammel);
      AppendAnsicht(anKein);

      AppendAnsicht(anTlnStart);

      if ZeigeMschAnsicht(Wk) then AppendAnsicht(anMschStart);
      AppendAnsicht(anKein);

      AppendAnsicht(anTlnErg);
      AppendAnsicht(anKein);

      if ZeigeMschAnsicht(Wk) then
      begin
        AppendAnsicht(anMschErgDetail);
        if ZeigeMschKompakt(Wk) then AppendAnsicht(anMschErgKompakt);
        AppendAnsicht(anKein);
      end;

      if Veranstaltung.Serie then
      begin
        AppendAnsicht(anTlnErgSerie);
        if ZeigeMschAnsicht(Wk) then AppendAnsicht(anMschErgSerie);
        AppendAnsicht(anKein);
      end;

      AppendAnsicht(anTlnUhrZeit);
      AppendAnsicht(anTlnRndKntrl);

      if ZeigeTlnSchwDist(Wk) then
        AppendAnsicht(anTlnSchwDist);

      ItemIndex := Items.IndexOfObject(TObject(AnsichtNeu));
      if ItemIndex < 0 then ItemIndex := 0;
      with HauptFenster do
      begin
        Ansicht := GetAnsicht;
        case Ansicht of
          anAnmEinzel:      AnmEinzelAction.Checked := true;
          anAnmSammel:      AnmSammelAction.Checked := true;
          anTlnStart:       TlnStartAction.Checked := true;
          anTlnErg:         TlnErgAction.Checked := true;
          anTlnErgSerie:    TlnErgSerieAction.Checked := true;
          anMschStart:      MschStartAction.Checked := true;
          anMschErgDetail:  MschErgDetailAction.Checked := true;
          anMschErgKompakt: MschErgKompaktAction.Checked := true;
          anMschErgSerie:   MschErgSerieAction.Checked := true;
          anTlnUhrZeit:     TlnUhrzeitAction.Checked := true;
          anTlnRndKntrl:    TlnRndKntrlAction.Checked := true;
          anTlnSchwDist:    TlnSchwBhnAction.Checked := true;
          else ;
        end;
      end;
    end else
    begin
      AppendAnsicht(anAnmEinzel);
      ItemIndex := 0;
      HauptFenster.Ansicht := GetAnsicht;
    end;

    Items.EndUpdate; {reenable painting }
    Refresh;
  end;
end;

//------------------------------------------------------------------------------
function TAnsFrame.GetAnsicht: TAnsicht;
//------------------------------------------------------------------------------
begin
  if AnsichtCB.ItemIndex >= 0 then
    Result := TAnsicht(AnsichtCB.Items.Objects[AnsichtCB.ItemIndex])
  else Result := anKein;
end;

//------------------------------------------------------------------------------
procedure TAnsFrame.InitSortModeListe(ModeNeu:TSortMode);
//------------------------------------------------------------------------------
// immer g�ltiger Wert setzen
// nach InitWettkListe, weil abh�ngig von SortWettk
var AbsCnt : TWkAbschnitt;
//..............................................................................
procedure AppendSortMode(SMode:TSortMode);
begin
  SortModeCB.Items.AddObject(smString(SMode),TObject(SMode));
end;

//..............................................................................
begin
  with SortModeCB do
  begin
    // Init Liste
    Items.BeginUpdate; { prevent repaints until done }
    Items.Clear;
    ItemIndex := -1;
    if Veranstaltung <> nil then
    begin
      case HauptFenster.Ansicht of

        anAnmEinzel,anAnmSammel:
        begin
          AppendSortMode(smTlnName);
          AppendSortMode(smTlnSnr);
          AppendSortMode(smTlnAlter);
          AppendSortMode(smTlnAk);
          AppendSortMode(smTlnMschName);
          if HauptFenster.Ansicht = anAnmEinzel then AppendSortMode(smTlnMschGroesse);
          if HauptFenster.Ansicht = anAnmEinzel then AppendSortMode(smTlnSMld);
          AppendSortMode(smTlnMldZeit);
          AppendSortMode(smTlnStartgeld);
          if RfidModus then
            AppendSortMode(smTlnRfid);
          AppendSortMode(smTlnAbs1Startzeit);
          for AbsCnt:=wkAbs2 to TWkAbschnitt(HauptFenster.Sortwettk.AbschnZahl) do
            if Veranstaltung.SGrpColl.WettkJagdStartEinzel(
                                            HauptFenster.Sortwettk,AbsCnt) then
              AppendSortMode(TSortMode(Integer(smTlnAbs2Startzeit)+Integer(AbsCnt)-2));
          if HauptFenster.Sortwettk.SchwimmDistanz > 0 then
            AppendSortMode(smTlnSBhn);
          AppendSortMode(smTlnBearbeitet);
          AppendSortMode(smTlnErstellt);
        end;

        anTlnStart:
        begin
          AppendSortMode(smTlnSnr);
          AppendSortMode(smTlnName);
          AppendSortMode(smTlnSnrAlter);
          AppendSortMode(smTlnSnrAk);
          AppendSortMode(smTlnMschName);
          AppendSortMode(smTlnAbs1Startzeit);
          for AbsCnt:=wkAbs2 to TWkAbschnitt(HauptFenster.Sortwettk.AbschnZahl) do
            if Veranstaltung.SGrpColl.WettkJagdStartEinzel(
                                            HauptFenster.Sortwettk,AbsCnt) then
              AppendSortMode(TSortMode(Integer(smTlnAbs2Startzeit)+Integer(AbsCnt)-2));
          if HauptFenster.Sortwettk.SchwimmDistanz > 0 then
            AppendSortMode(smTlnSBhn);
        end;

        anTlnErg:
        begin
          AppendSortMode(smTlnErg);
          for AbsCnt:=wkAbs1 to TWkAbschnitt(HauptFenster.Sortwettk.AbschnZahl) do
            if (AbsCnt>wkAbs1) or (HauptFenster.Sortwettk.AbschnZahl >= 2) then
              AppendSortMode(TSortMode(Integer(smTlnAbs1Zeit)+Integer(AbsCnt)-1));
          AppendSortMode(smTlnSnr);
          AppendSortMode(smTlnName);
          AppendSortMode(smTlnErgAlter);
          AppendSortMode(smTlnErgAk);
          AppendSortMode(smTlnErgMschName);
        end;

        anTlnUhrZeit:
        begin
          AppendSortMode(smTlnAbs1Startzeit);
          for AbsCnt:=wkAbs1 to TWkAbschnitt(HauptFenster.Sortwettk.AbschnZahl) do
            AppendSortMode(TSortMode(Integer(smTlnAbs1UhrZeit)+Integer(AbsCnt)-1));
          AppendSortMode(smTlnSnr);
          AppendSortMode(smTlnName);
          AppendSortMode(smTlnMschName);
        end;

        anTlnRndKntrl:
        begin
          AppendSortMode(smTlnAbsRnd);
          AppendSortMode(smTlnAbsRndStZeit);
          AppendSortMode(smTlnStoppZeit);
          AppendSortMode(smTlnMinRndZeit);
          AppendSortMode(smTlnMaxRndZeit);
          AppendSortMode(smTlnAbsRndEffZeit);
          AppendSortMode(smTlnSnr);
          AppendSortMode(smTlnName);
          AppendSortMode(smTlnMschName);
        end;

        anTlnErgSerie:
        begin
          AppendSortMode(smTlnSerErg);
          AppendSortMode(smTlnName);
          AppendSortMode(smTlnSerErgAlter);
          AppendSortMode(smTlnSerErgAk);
          AppendSortMode(smTlnSerErgMschName);
        end;

        anMschStart:
        begin
          AppendSortMode(smMschName);
          AppendSortMode(smMschTlnSnr);
          if Veranstaltung.WettkColl.MannschWettk then
            AppendSortMode(smMschAbs1Startzeit);
          for AbsCnt:=wkAbs2 to wkAbs8 do
            if Veranstaltung.SGrpColl.WettkJagdStartMannsch(
                                             HauptFenster.Sortwettk,AbsCnt) then
              AppendSortMode(TSortMode(Integer(smMschAbs2Startzeit)+Integer(AbsCnt)-2));
        end;

        anMschErgDetail,anMschErgKompakt:
        begin
          AppendSortMode(smMschErg);
          AppendSortMode(smMschErgMschName);
        end;

        anMschErgSerie: AppendSortMode(smMschSerErg);

        anTlnSchwDist:  AppendSortMode(smTlnSBhn);
      end;

      ItemIndex := Items.IndexOfObject(TObject(ModeNeu));
      if ItemIndex < 0 then ItemIndex := 0;
      HauptFenster.SortMode := GetSortMode;
    end else
    begin
      AppendSortMode(smTlnName);
      ItemIndex := 0;
      HauptFenster.SortMode := GetSortMode;
    end;
    Items.EndUpdate; {reenable painting }
    Refresh;
  end;
end;

//------------------------------------------------------------------------------
function TAnsFrame.GetSortMode: TSortMode;
//------------------------------------------------------------------------------
begin
  if SortModeCB.ItemIndex >= 0 then
    Result := TSortMode(SortModeCB.Items.Objects[SortModeCB.ItemIndex])
  else Result := smNichtSortiert;
end;

//------------------------------------------------------------------------------
procedure TAnsFrame.InitWettkListe(WkNeu:TWettkObj; WrtgNeu:TWertungMode);
//------------------------------------------------------------------------------
// wenn ImpFrame.Visible dann keine SonWrtg einf�gen, WrtgNeu = wgStandWrtg,
var i     : Integer;
    WkSM  : TSortMode;
    RepWk : TReportWkObj;

    //..............................................................................
function SondWrtgInListe(Wk:TWettkObj): Boolean;
// nie f�r WettkAlleDummy
begin
  Result := not HauptFenster.ImpFrame.Visible and
            Wk.SondWrtg and
           (HauptFenster.MeldeAnsicht or
            (HauptFenster.Ansicht = anTlnStart) or
            (HauptFenster.Ansicht = anTlnErg));
end;

//..............................................................................
procedure AppendWettk(Wk:TWettkObj);
begin
  RepWk := TReportWkObj.Create(Wk,wgStandWrtg);
  if Wk = WettkAlleDummy then
    WettkampfCB.Items.AddObject('Alle',RepWk)
  else
  begin
    WettkampfCB.Items.AddObject(Wk.Name,RepWk);
    if SondWrtgInListe(Wk) then
    begin
      RepWk := TReportWkObj.Create(Wk,wgSondWrtg);
      WettkampfCB.Items.AddObject(Wk.SondTitel,RepWk);
    end;
  end;
end;

//..............................................................................
function GetSortMode: TSortMode;
begin
  if HauptFenster.ImpFrame.Visible then Result := smWkEingegeben
  else
  case GetAnsicht of
    anAnmEinzel,
    anAnmSammel:      if Veranstaltung.WettkColl.Count > 1 then
                        Result := smWkPlusAlle
                      else Result := smWkEingegeben;
    anTlnStart,
    anMschStart,
    anTlnErg,
    anMschErgDetail,
    anMschErgKompakt,
    anTlnErgSerie,
    anMschergSerie:   Result := smWkEingegeben;
    anTlnUhrZeit,
    anTlnRndKntrl:    if (Veranstaltung.WettkColl.Count > 1) and
                         Veranstaltung.WettkColl.AlleAbschnGleich then
                        Result := smWkPlusAlle
                      else Result := smWkEingegeben;
    anTlnSchwDist:    if (Veranstaltung.WettkColl.Count > 1) and
                         Veranstaltung.WettkColl.AlleMitSchwDistanz then
                        Result := smWkPlusAlle
                      else Result := smWkEingegeben;
    else              Result := smWkNurAlle; //Compiler-Warnung vermeiden
  end;
end;

//..............................................................................
begin
  with WettkampfCB do
  begin
    Items.BeginUpdate; { prevent repaints until done }
    Items.Clear;
    ItemIndex := -1;
    if Veranstaltung <> nil then
    begin
      //WettkColl nicht sortieren, weil in Dialogen benutzt
      WkSM := GetSortMode;
      if (WkSM = smWkPlusAlle) or (WkSM = smWkNurAlle) or
         (Veranstaltung.WettkColl.Count=0) then //SortWettk immer definiert
        AppendWettk(WettkAlleDummy);
      if WkSM <> smWkNurAlle then
        with Veranstaltung.WettkColl do
          for i:=0 to Count-1 do AppendWettk(Items[i]);

      for i:=0 to Items.Count-1 do
        with TReportWkObj(Items.Objects[i]) do
          if (Wettk = WkNeu) and (Wrtg=WrtgNeu) then
          begin
            ItemIndex := i;
            Break;
          end;
      if (ItemIndex < 0) or (ItemIndex >= Items.Count) then ItemIndex := 0;
      HauptFenster.SortWettk := GetSortWettk;
      HauptFenster.SortWrtg  := GetSortWrtg;
      HauptFenster.LstFrame.UpdateMschTlnColBreite;//ColBreiteArr und Colwidths
      HauptFenster.LstFrame.UpdateAkColBreite; // ColBreiteArr und Colwidths
    end else
    begin
      AppendWettk(WettkAlleDummy);
      ItemIndex := 0;
      HauptFenster.SortWettk := GetSortWettk;
      HauptFenster.SortWrtg  := GetSortWrtg;
    end;
    Items.EndUpdate; { reenable repaints }
    Refresh;
  end;
end;

//------------------------------------------------------------------------------
function TAnsFrame.GetSortWettk: TWettkObj;
//------------------------------------------------------------------------------
begin
  if WettkampfCB.ItemIndex >= 0 then
    Result := TReportWkObj(WettkampfCB.Items.Objects[WettkampfCB.ItemIndex]).Wettk
  else Result := WettkAlleDummy;
end;

//------------------------------------------------------------------------------
function TAnsFrame.GetSortWrtg: TWertungMode;
//------------------------------------------------------------------------------
begin
  if WettkampfCB.ItemIndex >= 0 then
    Result := TReportWkObj(WettkampfCB.Items.Objects[WettkampfCB.ItemIndex]).Wrtg
  else
    Result := wgStandWrtg;
end;

//------------------------------------------------------------------------------
procedure TAnsFrame.InitSexListe(SexNeu:TSex);
//------------------------------------------------------------------------------
//..............................................................................
procedure AppendSexMode(Sex:TSex);
begin
  SexCB.Items.AddObject(sxString(Sex),TObject(Sex));
end;

//..............................................................................
begin
  with SexCB do
  begin
    Items.BeginUpdate; { prevent repaints until done }
    Items.Clear;
    ItemIndex := -1;
    if Veranstaltung <> nil then
    begin
      case HauptFenster.SortWettk.SexSortMode of
        smSxBeideMF: (*Beide+M�nner+Frauen*)
        begin
          AppendSexMode(cnSexBeide);
          AppendSexMode(cnMaennlich);
          AppendSexMode(cnWeiblich);
        end;
        smSxBeide: (* nur Beide *)
        begin
          AppendSexMode(cnSexBeide);
        end;
      end;
      ItemIndex := Items.IndexOfObject(TObject(SexNeu));
      if ItemIndex < 0 then ItemIndex := 0;
      HauptFenster.SortSex := GetSortSex;
    end else
    begin
      AppendSexMode(cnSexBeide);
      ItemIndex := 0;
      HauptFenster.SortSex := GetSortSex;
    end;
    Items.EndUpdate; { reenable repaints }
    Refresh;
  end;
end;

//------------------------------------------------------------------------------
function TAnsFrame.GetSortSex: TSex;
//------------------------------------------------------------------------------
begin
  if SexCB.ItemIndex >= 0 then
    Result := TSex(SexCB.Items.Objects[SexCB.ItemIndex])
  else Result := cnSexBeide;
end;

//------------------------------------------------------------------------------
procedure TAnsFrame.InitKlasseListe(AkNeu:TAkObj);
//------------------------------------------------------------------------------
// SortModi: smAkNurAlle   : nur 'Alle' wenn cnSexBeide, sonst alle SondKl+ProAk
//           smAkNurTMW    : nur alle TM/TW des Wettkampfes
//           smAkAlle      : 'M�nner/Frauen'+ Jun + Sen + 'TM/TW..' + Aktive
//           smAkMFPlusTMW : 'M�nner/Frauen' + 'TM/TW..'
//           smAkNurMF     : nur M�nner oder Frauen
// bei Listen-Ansichten nur gewertete Klassen zur Auswahl
var i : Integer;
    TlnMsch : TTlnMsch;
begin
  with KlasseCB do with HauptFenster do
  begin
    Items.BeginUpdate;
    Items.Clear;
    ItemIndex := -1;
    if TlnAnsicht then TlnMsch := tmTln
                  else TlnMsch := tmMsch;

    if Veranstaltung <> nil then with SortWettk do
    begin
      // Klassen immer von SortWettk
      // f�r WettkAlleDummy keine Alters- und Sonderklassen anzeigen,
      // da diese pro Wettk definiert sind
      // bei Serienwertung nur eine WertungsKlasse pro Tln gewertet
      case SortSex of
        cnMaennlich:
        begin
          Items.AddObject(MaennerKlasse[TlnMsch].Name,MaennerKlasse[TlnMsch]);
          if SortWettk <> WettkAlleDummy then
          begin
            // Altersklassen, auch wenn nur 1 Ak definiert
            for i:=0 to AltMKlasseColl[TlnMsch].SortCount-1 do
              Items.AddObject(AltMKlasseColl[TlnMsch].SortItems[i].Name,
                              AltMKlasseColl[TlnMsch].SortItems[i]);
            // Sonderklassen, auch wenn nur 1 Ak definiert, nur tmTln
            if (TlnMsch=tmTln) and EinzelWettk then
              for i:=0 to SondMKlasseColl.SortCount-1 do
                Items.AddObject(SondMKlasseColl.SortItems[i].Name,
                                           SondMKlasseColl.SortItems[i]);
          end;
        end;
        cnWeiblich:
        begin
          Items.AddObject(FrauenKlasse[TlnMsch].Name,FrauenKlasse[TlnMsch]);
          if SortWettk <> WettkAlleDummy then
          begin
            // Altersklassen, auch wenn nur 1 Ak definiert
            for i:=0 to AltWKlasseColl[TlnMsch].SortCount-1 do
              Items.AddObject(AltWKlasseColl[TlnMsch].SortItems[i].Name,
                                          AltWKlasseColl[TlnMsch].SortItems[i]);
            // Sonderklassen, auch wenn nur 1 Ak definiert, nur tmTln
            if (TlnMsch=tmTln) and EinzelWettk then
              for i:=0 to SondWKlasseColl.SortCount-1 do
                Items.AddObject(SondWKlasseColl.SortItems[i].Name,
                                           SondWKlasseColl.SortItems[i]);
          end;
        end;
        else
        begin
          Items.AddObject(AkAlle.Name,AkAlle); // cnSexBeide
          if SortWettk <> WettkAlleDummy then
            if (TlnMsch=tmMsch) or (SortWettk.WettkArt=waTlnStaffel) or
               (SortWettk.WettkArt=waTlnTeam) then
              Items.AddObject(AkMixed.Name,AkMixed);
        end;
      end;
      if Items.Count = 0 then Items.AddObject(AkUnbekannt.Name,AkUnbekannt);
      ItemIndex := Items.IndexOfObject(AkNeu); // geht nur bei gleichem SortWettk
      if ItemIndex < 0 then ItemIndex := 0;
      SortKlasse := GetSortKlasse;
      HauptFenster.LstFrame.UpdateMschTlnColBreite;//ColBreiteArr und Colwidths
    end else
    begin
      Items.AddObject(AkAlle.Name,AkAlle);
      ItemIndex := 0;
      SortKlasse := GetSortKlasse;
    end;
    Items.EndUpdate; { reenable repaints }
    Refresh;
  end;
end;

//------------------------------------------------------------------------------
function TAnsFrame.GetSortKlasse: TAkObj;
//------------------------------------------------------------------------------
begin
  if KlasseCB.ItemIndex >= 0 then
    Result := TAkObj(KlasseCB.Items.Objects[KlasseCB.ItemIndex])
  else Result := AkUnbekannt;
end;

//------------------------------------------------------------------------------
procedure TAnsFrame.InitStatusListe(StatusNeu:TStatus);
//------------------------------------------------------------------------------
var AbsCnt : TWkAbschnitt;
{..............................................................................}
procedure AppendStatus(Stat:TStatus);
begin
  StatusCB.Items.AddObject(stString(Stat),TObject(Stat));
end;
{..............................................................................}
begin
  with StatusCB do
  begin
    // Init Liste
    Items.BeginUpdate; { prevent repaints until done }
    Items.Clear;
    ItemIndex := -1;
    if Veranstaltung <> nil then
    begin
      case HauptFenster.Ansicht of
        anAnmEinzel,anAnmSammel:
        begin
          AppendStatus(stGemeldet);
          AppendStatus(stEingeteilt);
          with HauptFenster.SortWettk do
            if not RundenWettk then // bei Rnd/Stnd-Rennen identisch stImZiel
              for AbsCnt:=wkAbs1 to wkAbs8 do
                if (AbschnZahl > Integer(AbsCnt)) or (AbsMaxRunden[AbsCnt] > 1) then
                  AppendStatus(TStatus(Integer(stAbs1Start)+Integer(AbsCnt)-1));
          AppendStatus(stImZiel);
          AppendStatus(stGewertet);
          AppendStatus(stDisqualifiziert);
          AppendStatus(stGewertetDisq);
        end;
        anTlnStart:
        begin
          if not (HauptFenster.SortMode in [smTlnAbs2Startzeit..smTlnAbs8Startzeit]) then
            AppendStatus(stGemeldet);
          AppendStatus(stEingeteilt);
        end;
        anTlnErg:
        begin
          AppendStatus(stGemeldet);
          AppendStatus(stEingeteilt);
          with HauptFenster.SortWettk do
            if not RundenWettk then // bei Rnd/Stnd-Rennen identisch stImZiel
              for AbsCnt:=wkAbs1 to wkAbs8 do
                if (AbschnZahl > Integer(AbsCnt)) or (AbsMaxRunden[AbsCnt] > 1) then
                  AppendStatus(TStatus(Integer(stAbs1Start)+Integer(AbsCnt)-1));
          AppendStatus(stImZiel);
          AppendStatus(stGewertet);
          AppendStatus(stDisqualifiziert);
          AppendStatus(stGewertetDisq);
        end;
        anTlnUhrZeit:
        begin
          AppendStatus(stEingeteilt);
          AppendStatus(stZeitVorhanden);
        end;
        anTlnRndKntrl:
          with HauptFenster.SortWettk do
            for AbsCnt:=wkAbs1 to wkAbs8 do
              if AbschnZahl >= Integer(AbsCnt) then
                AppendStatus(TStatus(Integer(stAbs1Zeit)+Integer(AbsCnt)-1));
        anTlnErgSerie:
        begin
          AppendStatus(stGemeldet);
          AppendStatus(stSerGemeldet);
          AppendStatus(stSerWertung);
          AppendStatus(stSerEndWertung);
        end;
        anMschStart:
        case HauptFenster.SortMode of
          smMschAbs2Startzeit..smMschAbs8Startzeit:
            AppendStatus(stKein);
          else
          begin
            AppendStatus(stKein); //auch f�r alle wettk
            AppendStatus(stGemeldet);
            AppendStatus(stEingeteilt);
          end;
        end;
        anMschErgDetail:
        begin
          AppendStatus(stGemeldet);
          AppendStatus(stEingeteilt);
          with HauptFenster.SortWettk do
            if WettkArt <> waMschStaffel then
              for AbsCnt:=wkAbs1 to wkAbs7 do
                if AbschnZahl > Integer(AbsCnt) then
                  AppendStatus(TStatus(Integer(stAbs1Ziel)+Integer(AbsCnt)-1));
          AppendStatus(stImZiel);
          AppendStatus(stGewertet);
        end;
        anMschErgKompakt:
        begin
          AppendStatus(stGewertet);
        end;
        anMschErgSerie:
        begin
          AppendStatus(stGemeldet);
          AppendStatus(stSerWertung);
          AppendStatus(stSerEndWertung);
        end;
        anTlnSchwDist:
        begin
          AppendStatus(stGemeldet);
          AppendStatus(stEingeteilt);
          with HauptFenster.Sortwettk do
          begin
            if StartBahnen >  0 then AppendStatus(stBahn1);
            if StartBahnen >  1 then AppendStatus(stBahn2);
            if StartBahnen >  2 then AppendStatus(stBahn3);
            if StartBahnen >  3 then AppendStatus(stBahn4);
            if StartBahnen >  4 then AppendStatus(stBahn5);
            if StartBahnen >  5 then AppendStatus(stBahn6);
            if StartBahnen >  6 then AppendStatus(stBahn7);
            if StartBahnen >  7 then AppendStatus(stBahn8);
            if StartBahnen >  8 then AppendStatus(stBahn9);
            if StartBahnen >  9 then AppendStatus(stBahn10);
            if StartBahnen > 10 then AppendStatus(stBahn11);
            if StartBahnen > 11 then AppendStatus(stBahn12);
            if StartBahnen > 12 then AppendStatus(stBahn13);
            if StartBahnen > 13 then AppendStatus(stBahn14);
            if StartBahnen > 14 then AppendStatus(stBahn15);
            if StartBahnen > 15 then AppendStatus(stBahn16);
          end;
        end;
      end;
      ItemIndex := Items.IndexOfObject(TObject(StatusNeu));
      if ItemIndex=-1 then ItemIndex := 0;
      HauptFenster.SortStatus := GetSortStatus;
    end else
    begin
      AppendStatus(stGemeldet);
      ItemIndex := 0;
      HauptFenster.SortStatus := GetSortStatus;
    end;
    Items.EndUpdate; {reenable painting }
    Refresh;
  end;
end;

//------------------------------------------------------------------------------
function TAnsFrame.GetSortStatus: TStatus;
//------------------------------------------------------------------------------
begin
  if StatusCB.ItemIndex >= 0 then
    Result := TStatus(StatusCB.Items.Objects[StatusCB.ItemIndex])
  else Result := stKein;
end;


// published Methoden (Event Handler)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.AnsichtCBLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with AnsichtCB do
    if CanFocus then
    begin
      SetFocus;
      DroppedDown := true;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.AnsichtCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with HauptFenster do
    if GetAnsicht <> Ansicht then
    begin
      if SuchenDialog.Visible then SuchenDialog.Hide;
      case GetAnsicht of
        anAnmEinzel      : AnmEinzelActionExecute(Self);
        anAnmSammel      : AnmSammelActionExecute(Self);
        anTlnStart       : TlnStartActionExecute(Self);
        anTlnErg         : TlnErgActionExecute(Self);
        anTlnErgSerie    : TlnErgSerieActionExecute(Self);
        anTlnUhrZeit     : TlnUhrZeitActionExecute(Self);
        anTlnRndKntrl    : TlnRndKntrlActionExecute(Self);
        anMschStart      : MschStartActionExecute(Self);
        anMschErgDetail  : MschErgDetailActionExecute(Self);
        anMschErgKompakt : MschErgKompaktActionExecute(Self);
        anMschErgSerie   : MschErgSerieActionExecute(Self);
        anTlnSchwDist    : TlnSchwBhnActionExecute(Self);
        anKein           : AnsichtCB.ItemIndex :=
                             AnsichtCB.Items.IndexOfObject(TObject(Ansicht));
      end;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.SortModeCBLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with SortModeCB do
    if CanFocus then
    begin
      SetFocus;
      DroppedDown := true;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.SortModeCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var SortModeNeu: TSortMode;
begin
  MenueCommandActive := true;
  with HauptFenster do
  try
    // SortModeListe ge�ndert, aber nicht FSortMode
    SortModeNeu := GetSortMode;// vor CommandHeader, weil beim Berechnen ge�ndert
    CommandHeader;
    if SortModeNeu <> SortMode then
    begin
      LstFrame.SaveColWidths; // ColWidths in ColBreiteArr gespeichert
      if Ansicht = anMschStart then
        case SortModeNeu of
          smMschAbs1Startzeit:
            if (SortWettk <> WettkAlleDummy) and // noch keine Wettk
                not SortWettk.MschWettk then
            begin
              TriaMessage('F�r Wettkampf wurde keinen Mannschaftsstart definiert.',
                          mtInformation,[mbOk]);
              SortModeNeu := smMschName;
            end;
          smMschAbs2Startzeit..smMschAbs8Startzeit:
            if (SortWettk <> WettkAlleDummy) and // noch keine Wettk.
               not Veranstaltung.SGrpColl.WettkJagdStartMannsch(SortWettk,
                 TWkAbschnitt(Integer(SortModeNeu)-Integer(smMschAbs2Startzeit)+2)) then
            begin
              TriaMessage('F�r Wettkampf (Abschnitt ' +
                          IntToStr(Integer(SortModeNeu)-Integer(smMschAbs2Startzeit)+2) +
                          ') wurde keinen Jagdstart definiert.',mtInformation,[mbOk]);
              SortModeNeu := smMschName;
            end;
        end;
      InitSortModeListe(SortModeNeu);
      InitStatusListe(SortStatus);
      if (Ansicht = anAnmEinzel) and (SortMode = smTlnMschGroesse) then
        InitMschGrListe;
      LstFrame.GridInit; // ColWidths aus ColBreite eingelesen
      LstFrame.TriaGrid.ItemIndex := 0;
      FocusedTln := LstFrame.TriaGrid.FocusedItem;
    end;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.WettkampfCBLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with WettkampfCB do
    if CanFocus then
    begin
      SetFocus;
      DroppedDown := true;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.WettkampfCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// bei Wechsel Wettk. Ansicht pr�fen, wenn n�tig zu einer g�ltigen Ansicht wechseln
// neuer Ansicht hat keine R�ckwirkung auf WettkListe (bleibt immer smWkEingegeben)
var WkNeu     : TWettkObj;
    WrtgNeu   : TWertungMode;
    WkAnsicht : TAnsicht;
    Sx        : TSex;
    Kl        : TAkObj;
begin
  MenueCommandActive := true;
  with HauptFenster do
  try
    WkNeu   := GetSortWettk;
    WrtgNeu := GetSortWrtg;
    Sx      := SortSex;
    Kl      := SortKlasse;
    CommandHeader;

    if (WkNeu <> SortWettk) or (WrtgNeu <> SortWrtg) then
    begin
      LstFrame.SaveColWidths; // ColWidths in ColBreiteArr gespeichert, vor InitWettkListe
      InitWettkListe(WkNeu,WrtgNeu); // MschTln in arr ColBreite auf standard gesetzt

      // Ansichtliste anpassen, ist abh�ngig vom Wettk.
      WkAnsicht := Ansicht;
      case Ansicht of
        //anKein: ;
        //anAnmEinzel: ;
        //anAnmSammel: ;
        //anTlnStart: ;
        //anTlnErg: ;
        //anTlnErgSerie: ;
        //anTlnUhrZeit: ;
        //anTlnRndKntrl: ;
        anMschStart:
          if WkNeu.MschWertg = mwKein then WkAnsicht := anTlnStart; //smWkEingegeben
        anMschErgDetail:
          if WkNeu.MschWertg = mwKein then WkAnsicht := anTlnErg;  //smWkEingegeben
        anMschErgKompakt:
          if WkNeu.MschWertg = mwKein then WkAnsicht := anTlnErg   //smWkEingegeben
          else
          if (WkNeu.MschWrtgMode = wmSchultour) or
             (WkNeu.MschGroesse[SortKlasse.Sex] > cnMschGrMaxKompakt) then WkAnsicht := anMschErgDetail; //smWkEingegeben
        anMschErgSerie: if WkNeu.MschWertg = mwKein then WkAnsicht := anTlnErgSerie;       //smWkEingegeben
        anTlnSchwDist: if Wkneu.SchwimmDistanz = 0 then WkAnsicht := anTlnStart;           //smWkEingegeben
        else
      end;
      InitAnsichtListe(WkAnsicht,WkNeu,Sx,Kl);
      InitSortModeListe(SortMode);
      InitSexListe(Sx);
      InitKlasseListe(Kl);
      InitStatusListe(SortStatus);
      if (Ansicht = anAnmEinzel) and (SortMode = smTlnMschGroesse) then
        InitMschGrListe;
      LstFrame.GridInit; // ColWidths aus ColBreite eingelesen
      LstFrame.TriaGrid.ItemIndex := 0;
      FocusedTln := LstFrame.TriaGrid.FocusedItem;
    end;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.SexCBLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with SexCB do
    if CanFocus then
    begin
      SetFocus;
      DroppedDown := true;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.SexCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var Kl    : TAkObj;
    Wk    : TWettkObj;
    SxNeu : TSex;
begin
  MenueCommandActive := true;
  with HauptFenster do
  try
    SxNeu := GetSortSex;
    Wk    := SortWettk;
    CommandHeader;
    if SxNeu <> SortSex then
    begin
      LstFrame.SaveColWidths; // ColWidths in ColBreiteArr gespeichert
      InitSexListe(SxNeu);
      InitKlasseListe(AkAlle);
      Kl := SortKlasse;
      if (Ansicht = anMschErgKompakt) and
         (Wk.MschGroesse[Kl.Sex] > cnMschGrMaxKompakt) then
        InitAnsichtListe(anMschErgDetail,Wk,SxNeu,Kl);
      if (Ansicht = anAnmEinzel) and (SortMode = smTlnMschGroesse) then
        InitMschGrListe;
      LstFrame.GridInit; // ColWidths aus ColBreite eingelesen
      LstFrame.TriaGrid.ItemIndex := 0;
      FocusedTln := LstFrame.TriaGrid.FocusedItem;
    end;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.KlasseCBLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with KlasseCB do
    if CanFocus then
    begin
      SetFocus;
      DroppedDown := true;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.KlasseCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var KlNeu : TAkObj;
    Wk    : TWettkObj;
    Sx    : TSex;
begin
  MenueCommandActive := true;
  with HauptFenster do
  try
    KlNeu := GetSortKlasse;
    Wk    := SortWettk;
    Sx    := SortSex;
    CommandHeader;
    if KlNeu <> SortKlasse then
    begin
      LstFrame.SaveColWidths; // ColWidths in ColBreiteArr gespeichert
      InitKlasseListe(KlNeu);
      if (Ansicht = anMschErgKompakt) and
         (Wk.MschGroesse[KlNeu.Sex] > cnMschGrMaxKompakt) then
        InitAnsichtListe(anMschErgDetail,Wk,Sx,KlNeu);
      if (Ansicht = anAnmEinzel) and (SortMode = smTlnMschGroesse) then
        InitMschGrListe;
      LstFrame.GridInit; // ColWidths aus ColBreite eingelesen
      LstFrame.TriaGrid.ItemIndex := 0;
      FocusedTln := LstFrame.TriaGrid.FocusedItem;
    end;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.StatusCBlabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  with StatusCB do
    if CanFocus then
    begin
      SetFocus;
      DroppedDown := true;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.StatusCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var StatusNeu: TStatus;
begin
  MenueCommandActive := true;
  with HauptFenster do
  try
    StatusNeu := GetSortStatus;
    CommandHeader;
    if StatusNeu <> SortStatus then
    begin
      LstFrame.SaveColWidths; // ColWidths in ColBreiteArr gespeichert
      InitStatusListe(StatusNeu);
      if (Ansicht = anAnmEinzel) and (SortMode = smTlnMschGroesse) then
        InitMschGrListe;
      LstFrame.GridInit; // ColWidths aus ColBreite eingelesen
      LstFrame.TriaGrid.ItemIndex := 0;
      FocusedTln := LstFrame.TriaGrid.FocusedItem;
    end;
    CommandTrailer;
  finally
    MenueCommandActive := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.ComboBoxCloseUp(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if HauptFenster.LstFrame.TriaGrid.CanFocus then
    HauptFenster.LstFrame.TriaGrid.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TAnsFrame.ComboBoxKeyPress(Sender: TObject; var Key: Char);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if (Key = #13) or (Key = #27) then
    if HauptFenster.LstFrame.TriaGrid.CanFocus then
      HauptFenster.LstFrame.TriaGrid.SetFocus;
end;


end.
