unit TlnObj;

interface

uses
  Classes,SysUtils,Dialogs,Math,Windows,DateUtils,
  AllgConst,AllgFunc,AllgObj,AkObj,WettkObj,SGrpObj,SMldObj;

type
  TZeitRecColl = class;

  TZeitRec = record
    ErfZeit,AufRndZeit: Integer; // erfasste und ggf. aufgerundete Zeit (1/100)
  end;
  PZeitRec = ^TZeitRec;

  TZeitRecList = array of TZeitRec;
  PZeitRecList = ^TZeitRecList;

  TZeitRecSortCompare = function(List: TZeitRecColl; Index1, Index2: Integer): Integer;

  {TZeitRecColl = class(TIntSortCollection) // Coll von TZeitRec für Runden-Uhrzeiten pro Abschnitt
  protected
    function    GetBPObjType: Word; override;
    function    GetPItem(Indx:Integer): PZeitRec;        //kein override ??
    procedure   SetPItem(Indx:Integer; Item:PZeitRec);
    procedure   SetItem(Indx:Integer;Item:TZeitRec);
    function    GetItem(Indx:Integer): TZeitRec;
    function    GetPSortItem(Indx:Integer): PZeitRec;
    function    GetSortItem(Indx:Integer): TZeitRec;//Integer;
    procedure   FreeItem(Item:Pointer); override;
    function    LoadItem(Indx:Integer): Boolean; override;
    function    StoreItem(Indx:Integer): Boolean; override;
  public
    constructor Create(Veranst:Pointer);
    //function    GetRunde(Zeit:Integer): Integer;
    function    SetErfZeit(Indx,Zeit:Integer): Integer;
    function    GetErfZeit(Indx:Integer): Integer;
    function    SetAufRndZeit(Indx,Zeit:Integer): Integer;
    function    GetAufRndZeit(Indx:Integer): Integer;
    function    SortValue(Item:Pointer): Integer; override;
    function    AddSortItem(Item:Pointer): Integer; override;
    function    Add(ErfZeitNeu,AufRndZeitNeu:Integer): Integer;
    function    AddAufRndZeit(AufRndZeitNeu:Integer): Integer;
    function    ErfZeitVorhanden(Zeit:Integer): Boolean;
    property    Items[Indx:Integer]: TZeitRec read GetItem; default;
    property    SortItems[Indx:Integer]:TZeitRec read GetSortItem;
  end; }

  TZeitRecColl = class(TTriaSortColl) // Coll von TZeitRec für Runden-Uhrzeiten pro Abschnitt
  private                             // abgeleitet von TTriaSortColl für TlnDlg-AbsGrid
    FCount: Integer;
    FCapacity: Integer;
    FList: TZeitRecList;
    procedure   ExchangeItems(Index1, Index2: Integer);
    procedure   Grow;
    procedure   QuickSort(L, R: Integer; SCompare: TZeitRecSortCompare);
    function    CompareZeit(const Zeit1, Zeit2: Integer): Integer;
    procedure   Sort;

  protected
    function    GetBPObjType: Word; override;
    function    GetCount: Integer; //override;
    procedure   SetCapacity(NewCapacity: Integer); override;
    function    GetPItem(Indx:Integer): Pointer;
    procedure   SetPItem(Indx:Integer; Item:Pointer);
    function    GetSortCount: Integer;
    function    GetSortItem(Indx:Integer): Pointer; // =nil, not used
    procedure   FreeItem(Item:Pointer); override;
    function    LoadItem(Indx:Integer): Boolean; override;
    function    StoreItem(Indx:Integer): Boolean; override;
    // neu
    function    GetRec(Indx:Integer): TZeitRec;
    function    SetRec(Indx:Integer;Rec:TZeitRec): Integer;
    function    GetStrtRec: TZeitRec;
    procedure   SetStrtRec(Rec:TZeitRec);

  public
    StrtRec : TZeitRec;

    constructor Create(Veranst:Pointer);
    function    Store: Boolean; override;
    function    CollSize: Integer; override;
    procedure   Clear; override;
    //function    ClearItem(Item:Pointer): Integer;  geerbt
    function    IndexOf(Item:Pointer): Integer;  //=-1, not used
    procedure   ClearIndex(Indx: Integer); override;
    function    AddItem(Item:Pointer): Integer; override; //=-1, not used
    function    SortString(Item:Pointer): String; override; // ='', not used
    //function    Compare(Item1,Item2:Pointer):Integer; // =0, geerbt,
    //function    ClearSortItem(Item:Pointer): Integer; // =-1, geerbt
    //procedure   SortClear; // geerbt, keine Funktion
    //function    AddSortItem(Item:Pointer): Integer; // =-1, keine Funktion
    //function    SortIndexOf(Item:Pointer): Integer; // =-1, keine Funktion



    function    AddRec(Rec:TZeitRec): Integer;
    procedure   InsertRec(Indx: Integer; Rec:TZeitRec);
    function    FindeZeit(Zeit:Integer; var Indx:Integer):Boolean;
    procedure   SetStrtErfZeit(Zeit:Integer);
    function    GetStrtErfZeit: Integer;
    procedure   SetStrtAufRndZeit(Zeit:Integer);
    function    GetStrtAufRndZeit: Integer;

    //function    GetRunde(Zeit:Integer): Integer;
    function    SetErfZeit(Indx,Zeit:Integer): Integer;
    function    GetErfZeit(Indx:Integer): Integer;
    function    SetAufRndZeit(Indx,Zeit:Integer): Integer;
    function    GetAufRndZeit(Indx:Integer): Integer;
    //function    SortValue(Item:Pointer): Integer; override;
    function    SortValue(const Zeit:Integer): Integer;
    //function    AddSortItem(Item:Pointer): Integer; override;
    function    Add(ErfZeitNeu,AufRndZeitNeu:Integer): Integer;
    function    AddAufRndZeit(AufRndZeitNeu:Integer): Integer;
    function    ErfZeitVorhanden(Zeit:Integer): Boolean;

    property    Count: Integer read GetCount;
    property    PItems[Indx: Integer]: Pointer read GetPItem write SetPItem; // not used
    property    Items[Indx:Integer]: TZeitRec read GetRec; default;
    //property    SortCount:Integer read GetSortCount; //=0, not used
    property    SortItems[Indx:Integer]:Pointer read GetSortItem; //=nil, not Used
    property    SortMode:TSortMode read FSortmode write FSortmode; //=smNichtSortiert, not used
    //property    SortMode:TSortMode read FSortmode write FSortmode;
    property    List : TZeitRecList read FList;
  end;



  TOrtZeitRecColl = class(TTriaColl)
  // OrtCollection von TZeitRecColls für Tln-UhrZeiten
  protected
    function    GetBPObjType: Word; override;
    function    LoadItem(Indx:Integer): Boolean; override;
    function    StoreItem(Indx:Integer): Boolean; override;
    procedure   FreeItem(Item: Pointer); override;
  public
    constructor Create(Veranst:Pointer);
    function    GetColl(OrtIndx:Integer): TZeitRecColl;
    procedure   SetColl(OrtIndx:Integer; Coll:TZeitRecColl);
  end;

  TNameArr            = array [wkAbs2..wkAbs8] of String;// ab wkAbs2
  TRngCollArr         = array [kwAlle..kwSondKl, wkAbs0..wkAbs8] of TWordCollection;// Abs0 für GesamtRng
  TSerRngCollArr      = array [kwAlle..kwSondKl] of TWordCollection;
  TMschRngCollArr     = array [kwAlle..kwAltKl] of TWordCollection;
  TOrtZeitRecCollArr  = array [wkAbs1..wkAbs8] of TOrtZeitRecColl;
  TZeitRecCollArr     = array [wkAbs1..wkAbs8] of TZeitRecColl;
  TIntArr             = array [kwAlle..kwSondKl] of Integer;
  TBoolArr            = array [kwAlle..kwSondKl] of Boolean;
  TAkArr              = array [kwAlle..kwSondKl] of TAkObj;
  TMschAkArr          = array [kwAlle..kwAltKl] of TAkObj;

  TTlnObj = class(TTriaObj)
  protected
    FName             : String;
    FVName            : String;
    FStrasse          : String;
    FHausNr           : String;//ab 2005-0.4, bleibt Leerstring bei ältere Dateien
    FPLZ              : String;//ab 2005-0.4, bleibt Leerstring bei ältere Dateien
    FOrt              : String;
    FSex              : TSex;
    FJg               : Integer;
    FMannschName      : PString;
    FLand             : String;
    FSMld             : TSMldObj;
    FWettk            : TWettkObj;
    FEMail            : String;    // ab 2010-0.2

    // Wertungsklassen
    FWertgKlasseArr   : TAkArr; // kwAlle..kwSondKl
    FMschWertgKlasseArr : TMschAkArr; // kwAlle..kwAltKl, für MschPktWrtg

    // Optionen
    FSerienWrtg,                            // für alle Orte
    FMschWrtg,
    FMschMixWrtg      : Boolean;           // neu 11.2.4
    FAusKonkAllgColl,
    FAusKonkAltKlColl,
    FAusKonkSondKlColl,
    FSondWrtgColl,
    FUrkDruckColl     : TBoolCollection;  // Wert pro Ort

    FSnrColl          : TWordCollection; // Wert pro Ort
    FSGrpColl         : TTriaPointerColl;
    FStrtBahnColl     : TWordCollection;
    FMldZeitColl      : TIntegerCollection; // 2006: in 1/10 Sek, 2008-2.0: 1/100
    FStartgeldColl    : TIntegerCollection; // 2010-0.2  Startgeld in Cent
    FKommentColl      : TTextCollection;

    FOrtZeitRecCollArr   : TOrtZeitRecCollArr;     //TZeitRecColl pro Ort

    FGutschriftColl   : TIntegerCollection;  //2008-2.0: 1/100
    FStrafZeitColl    : TIntegerCollection;  //2006: in 1/10, 2008-2.0: 1/100
    FDisqGrundColl    : TTriaPointerColl;
    FDisqNameColl     : TTriaPointerColl;    // 2008-2.0 neu
    FRestStreckeColl  : TIntegerCollection; // für Stundenrennen
    FStaffelVorgColl  : TSmallIntCollection; // Indx in TlnColl

    FRngCollArr,
    FSwRngCollArr     : TRngCollArr;     // End(wkAbs0) und wkAbs1..8 - Wertungen für kwAlle,kwSex,kwTlnAk,kwSondKl,
    FSerRngCollArr    : TSerRngCollArr;  // Serienwertung pro Ort, für kwAlle,kwSex,kwTlnAk,kwSondKl
    FMschRngCollArr   : TMschRngCollArr; // Platzierung für Msch-Punktwertung, für kwAlle,kwSex,kwTlnAk

    FSeriePktArr,      
    FSerieRngArr      : TIntArr;
    FSerieWrtgArr,                // mindestens eine Wertung für serie
    FSerieEndWrtgArr  : TBoolArr; // Endwertung erreicht / erreichbar

    FBearbeitet       : TTimeStamp;       // TTimeStamp=record/Time,Date:Integer;
                                          // speichern in 4x SmallInt, weil LongInt
                                          // in älteren Versionen nicht funktioniert
    // für Staffel-einfach, 
    FNameAbsArr,                 // Abs1: Name,VName
    FVNameAbsArr : TNameArr; // ab wkAbs2: Tln pro Abs

    function    GetBPObjType: Word; override;
    procedure   SetName(NameNeu: String);
    procedure   SetVName(VNameNeu: String);
    procedure   SetStrasse(StrasseNeu: String);
    procedure   SetHausNr(HausNrNeu: String);
    procedure   SetPLZ(PLZNeu: String);
    procedure   SetOrt(OrtNeu: String);
    procedure   SetEMail(EMailNeu: String);
    procedure   SetSex(SexNeu: TSex);
    procedure   SetJg(JgNeu: Integer);
    procedure   SetLand(LandNeu: String);
    function    GetMannschName: String;
    procedure   SetMannschNamePtr(MannschNamePtrNeu: PString);
    procedure   SetMannschName(MannschNameNeu: String);
    procedure   SetSMld(SMldNeu: TSMldObj);
    procedure   SetWettk(WettkNeu: TWettkObj);
    procedure   SetSerienWrtg(SerienWrtgNeu: Boolean);
    function    GetMschWrtg: Boolean;
    procedure   SetMschWrtg(MschWrtgNeu: Boolean);
    function    GetMschMixWrtg: Boolean;
    procedure   SetMschMixWrtg(MschMixWrtgNeu: Boolean);
    procedure   SetSeriePunkte(PktNeu:Integer;AkWrtg:TKlassenWertung);
    procedure   SetSerieRang(RngNeu:Integer;AkWrtg:TKlassenWertung);
    function    GetOrtAusKonkAllg(Indx:Integer): Boolean;
    function    GetAusKonkAllg: Boolean;
    procedure   SetAusKonkAllg(AusKonkAllgNeu: Boolean);
    function    GetAusKonkAltKl: Boolean;
    procedure   SetAusKonkAltKl(AusKonkAltKlNeu: Boolean);
    function    GetAusKonkSondKl: Boolean;
    procedure   SetAusKonkSondKl(AusKonkSondKlNeu: Boolean);
    function    GetSondWrtg: Boolean;
    procedure   SetSondWrtg(SondWrtgNeu: Boolean);
    function    GetUrkDruck: Boolean;
    procedure   SetUrkDruck(UrkDruckNeu: Boolean);

    function    GetSnr: Integer;
    procedure   SetSnr(SnrNeu: Integer);
    function    GetSGrp: TSGrpObj;
    procedure   SetSGrp(SGrpNeu:TSGrpObj);
    function    GetStrtBahn: Integer;
    procedure   SetStrtBahn(StrtBahn: Integer);
    function    GetMldZeit: Integer;
    procedure   SetMldZeit(MldZeitNeu:Integer);
    function    GetStartgeld: Integer;
    procedure   SetStartgeld(StartgeldNeu:Integer);
    function    GetKomment: String;
    procedure   SetKomment(KommentNeu:String);

    function    GetGutschrift: Integer;
    procedure   SetGutschrift(GutschriftNeu: Integer);
    function    GetStrafZeit: Integer;
    procedure   SetStrafZeit(StrafZeitNeu: Integer);
    function    GetDisqGrund: String;
    procedure   SetDisqGrund(DisqGrund: String);
    function    GetDisqName: String;
    procedure   SetDisqName(DisqName: String);
    function    GetReststrecke: Integer;
    procedure   SetReststrecke(ReststreckeNeu: Integer);
    function    GetOrtStaffelVorg(Indx:Integer): Integer;
    function    GetStaffelVorg: Integer;
    procedure   SetStaffelVorg(StaffelVorg: Integer);
    function    TlnInOrtStatus(Indx:Integer; Status:TStatus): Boolean;

    procedure   SetStaffelName(Abs:TWkAbschnitt;NameNeu: String);
    procedure   SetStaffelVName(Abs:TWkAbschnitt;VNameNeu: String);
    function    GetStaffelName(Abs:TWkAbschnitt): String;
    function    GetStaffelVName(Abs:TWkAbschnitt): String;
    procedure   SetSerieWrtg(AkWrtg:TKlassenWertung; Bool:Boolean);
    procedure   SetSerieEndWrtg(AkWrtg:TKlassenWertung; Bool:Boolean);
    function    GetSerieWrtg(AkWrtg:TKlassenWertung): Boolean;
    function    GetSerieEndWrtg(AkWrtg:TKlassenWertung): Boolean;

  public
    Dummy          : Boolean;
    MannschAllePtr,
    MannschSexPtr,
    MannschAkPtr   : Pointer;          // wird in Unit MannschObj gesetzt

    constructor Create(Veranst:Pointer;Coll:TTriaObjColl;Add:TOrtAdd); override;
    destructor  Destroy; override;
    function    Load: Boolean; override;
    function    Store: Boolean; override;
    procedure   SortAdd; override;
    procedure   SortRemove; override;
    procedure   OrtCollAdd; override;
    procedure   OrtCollClear(Indx:Integer); override;
    procedure   OrtCollExch(Idx1,Idx2:Integer); override;
    procedure   SetTlnAllgDaten(NameNeu,VNameNeu:String;
                                NameArrNeu,
                                VNameArrNeu:TNameArr;
                                StrasseNeu,HausNrNeu,
                                PLZNeu,OrtNeu,
                                EMailNeu       : String;
                                SexNeu         : TSex;
                                JgNeu          : Integer;
                                LandNeu        : String;
                                MannschNameNeu : String;
                                SMldNeu        : TSMldObj;
                                WettkNeu       : TWettkObj;
                                SerienWrtgNeu,
                                MschWrtgNeu,
                                MschMixWrtgNeu : Boolean);
    procedure   SetTlnOrtDaten(SnrNeu          : Integer; // nur aktueller OrtIndex
                               SGrpNeu         : TSGrpObj;
                               StrtBahnNeu,
                               MldZeitNeu,
                               StartgeldNeu    : Integer;
                               KommentNeu      : String;
                               ZeitRecCollArrNeu : TZeitRecCollArr;
                               GutschriftNeu   : Integer;
                               StrafZeitNeu,
                               ReststreckeNeu  : Integer;
                               DisqGrundNeu,
                               DisqNameNeu     : String;
                               AusKonkAllgNeu,
                               AusKonkAltKlNeu,
                               AusKonkSondKlNeu,
                               SondWrtgNeu,
                               UrkDruckNeu     : Boolean);

    function    MannschPtr(AkWrtg:TKlassenWertung) : Pointer;
    function    GetJgStr2: String;
    procedure   ClearStaffelVorg;
    function    GetSerOrtRng(Indx:Integer;AkWrtg:TKlassenWertung): Integer;
    function    TagesRng(Abs:TWkAbschnitt;AkWrtg:TKlassenWertung;Wrtg:TWertungMode): Integer;
    function    TagesEndRngStr(Abs:TWkAbschnitt;AkWrtg:TKlassenWertung;Wrtg:TWertungMode):String;
    function    TagesZwRngStr(Abs:TWkAbschnitt;AkWrtg:TKlassenWertung;Wrtg:TWertungMode): String;
    function    SerOrtRngToPkt(Indx:Integer;AkWrtg:TKlassenWertung;Rng:Integer): Integer;
    function    GetOrtPktSerStr(Indx:Integer;AkWrtg:TKlassenWertung): String;
    procedure   SetRng(Rng:Integer;Abs:TWkAbschnitt;WrtgMode:TWertungMode;AkWrtg:TKlassenWertung);
    function    SeriePunkte(AkWrtg:TKlassenWertung): Integer;
    function    SerieRang(AkWrtg:TKlassenWertung): Integer;
    function    GetSerieRangStr(AkWrtg:TKlassenWertung): String;
    procedure   BerechneSeriePunkte(AkWrtg:TKlassenWertung);
    function    NameVName     : String;
    function    NameVNameKurz : String;
    function    VNameName     : String;
    function    StaffelNameVName(Abs:TWkAbschnitt) : String;
    function    StaffelVNameName(Abs:TWkAbschnitt) : String;
    function    GetAlter      : Integer;
    function    WertungsKlasse(AkWrtg:TKlassenWertung;TM:TTlnMsch): TAkObj;
    function    TlnInKlasse(Klasse:TAkObj;TM:TTlnMsch): Boolean;
    function    TlnInStatus(Status:TStatus): Boolean;

    function    GetZeitRecColl(OrtIndx:Integer;Abs:TWkAbschnitt):TZeitRecColl; overload;
    function    GetZeitRecColl(Abs:TWkAbschnitt):TZeitRecColl; overload;
    function    GetZeitRecCollArr:TZeitRecCollArr; overload;

    procedure   ClearZeitRecCollArr(Abs:TWkAbschnitt); overload;
    procedure   ClearZeitRecCollArr; overload;
    procedure   SetZeitRecCollArr(ZeitRecCollArrNeu:TZeitRecCollArr); overload;
    procedure   SetZeitRecCollArr(Abs:TWkAbschnitt;ZeitRecCollNeu:TZeitRecColl); overload;
    procedure   CopyZeitRecCollArr(Tln:TTlnObj);

    procedure   SetStrtZeit(Abs:TWkAbschnitt);
    function    StrtZeit(Abs:TWkAbschnitt): Integer; overload;
    function    StrtZeit(OrtIndx:Integer;Abs:TWkAbschnitt) : Integer; overload;

    function    SetZtErfZeit(OrtIndx:Integer;Abs:TWkAbschnitt;Indx,Zeit:Integer): Integer; overload;
    function    SetZtErfZeit(Abs:TWkAbschnitt;Indx,Zeit:Integer): Integer; overload;
    //function    ZtErfZeit(OrtIndx:Integer;Abs:TWkAbschnitt;Runde:Integer): Integer; overload;
    //function    ZtErfZeit(Abs:TWkAbschnitt;Runde:Integer): Integer; overload;
    function    AbsZeitEingelesen(Abs:TWkAbschnitt;Zeit:Integer): Boolean;

    function    SetStoppZeit(OrtIndx:Integer;Abs:TWkAbschnitt;Indx,Zeit:Integer): Integer; overload;
    function    SetStoppZeit(Abs:TWkAbschnitt;Indx,Zeit:Integer): Integer; overload;
    function    AbsRundeStoppZeit(OrtIndx:Integer;Abs:TWkAbschnitt;Runde:Integer): Integer; overload;
    function    AbsRundeStoppZeit(Abs:TWkAbschnitt;Runde:Integer): Integer; overload;
    function    StoppZeit(OrtIndx:Integer;Abs:TWkAbschnitt): Integer; overload;
    function    StoppZeit(Abs:TWkAbschnitt): Integer; overload;
    function    StoppZeit(OrtIndx:Integer): Integer; overload;
    function    StoppZeit: Integer; overload;

    function    RundenZahl(OrtIndx:Integer;Abs:TWkAbschnitt): Integer; overload;
    function    RundenZahl(Abs:TWkAbschnitt): Integer; overload;
    procedure   UpdateRundenZahl(Abs:TWkAbschnitt);
    function    AbsEinzelRundeZeit(Abs:TWkAbschnitt;Runde:Integer): Integer;

    function    AbsRundenZeit(OrtIndx:Integer;Abs:TWkAbschnitt;Runde:Integer): Integer; overload;
    function    AbsRundenZeit(Abs:TWkAbschnitt;Runde:Integer):Integer; overload;
    function    AbsMinRundeZeit(Abs:TWkAbschnitt):Integer;
    function    AbsMaxRundeZeit(Abs:TWkAbschnitt):Integer;
    function    AbsZeit(OrtIndx:Integer;Abs:TWkAbschnitt): Integer; overload;
    function    AbsZeit(Abs:TWkAbschnitt): Integer; overload;

    function    NettoEndZeit: Integer;
    function    EndZeit: Integer;

    function    Vereinsname: String;
    procedure   KlassenSetzen;
    procedure   KlassenLoeschen;
    procedure   EinteilungLoeschen;
    procedure   CopyAllgemeinDaten(Tln:TTlnObj);
    procedure   CopyAnmeldungsDaten(Tln:TTlnObj);
    procedure   CopyEinteilungsDaten(Tln:TTlnObj);
    procedure   CopyErgebnisDaten(Tln:TTlnObj);
    procedure   CopyRngDaten(Tln:TTlnObj);
    procedure   SetWettkErgModified;
    procedure   SetzeBearbeitet;
    function    AenderungsZeit: String;
    //function    PflichtWkTeilnahme: Boolean;
    function    SerPktSort(AkWrtg:TKlassenWertung): Integer;
    function    ObjSize: Integer; override;

    property Name             : String    read FName write SetName;
    property VName            : String    read FVName write SetVName;
    property Strasse          : String    read FStrasse write SetStrasse;
    property HausNr           : String    read FHausNr write SetHausNr;
    property PLZ              : String    read FPLZ write SetPLZ;
    property Ort              : String    read FOrt write SetOrt;
    property EMail            : String    read FEMail write SetEMail;
    property Sex              : TSex      read FSex write SetSex;
    property Jg               : Integer   read FJg write SetJg;
    //property SexKlasse        : TAkObj    read FSexKlasse;
    //property SondKlasse       : TAkObj    read FSondKlasse;
    //property AltKlasse        : TAkObj    read FAltKlasse;
    //property WertgKlasse      : TAkArr     read WertungsKlasse;
    //property MschWertgKlasse  : TMschAkArr read MschWertungsKlasse;
    property Land             : String    read FLand write SetLand;
    property MannschName      : String    read GetMannschName write SetMannschName;
    property MannschNamePtr   : PString   read FMannschName write SetMannschNamePtr;
    property SMld             : TSMldObj  read FSMld write SetSMld;
    property Wettk            : TWettkObj read FWettk write SetWettk;
    property SerienWrtg       : Boolean   read FSerienWrtg write SetSerienWrtg;
    property AusKonkAllg      : Boolean   read GetAusKonkAllg write SetAusKonkAllg;
    property AusKonkAltKl     : Boolean   read GetAusKonkAltKl  write SetAusKonkAltKl;
    property AusKonkSondKl    : Boolean   read GetAusKonkSondKl write SetAusKonkSondKl;
    property MschWrtg         : Boolean   read GetMschWrtg write SetMschWrtg;
    property MschMixWrtg      : Boolean   read GetMschMixWrtg write SetMschMixWrtg;
    property SondWrtg         : Boolean   read GetSondWrtg write SetSondWrtg;
    property UrkDruck         : Boolean   read GetUrkDruck write SetUrkDruck;
    property Snr              : Integer   read GetSnr write SetSnr;
    property SGrp             : TSGrpObj  read GetSGrp write SetSGrp;
    property SBhn             : Integer   read GetStrtBahn write SetStrtBahn;
    property MldZeit          : Integer   read GetMldZeit write SetMldZeit;
    property Startgeld        : Integer   read GetStartgeld write SetStartgeld;
    property Komment          : String    read GetKomment write SetKomment;
    property StaffelName[Abs:TWkAbschnitt]  : String    read GetStaffelName write SetStaffelName;
    property StaffelVName[Abs:TWkAbschnitt] : String    read GetStaffelVName write SetStaffelVName;
    property NameAbsArr       : TNameArr  read FNameAbsArr write FNameAbsArr;
    property VNameAbsArr      : TNameArr  read FVNameAbsArr write FVNameAbsArr;
    property Gutschrift                : Integer   read GetGutschrift write SetGutschrift;
    property StrafZeit                 : Integer   read GetStrafZeit write SetStrafZeit;
    property DisqGrund                 : String    read GetDisqGrund write SetDisqGrund;
    property DisqName                  : String    read GetDisqName write SetDisqName;
    property Reststrecke               : Integer   read GetReststrecke write SetReststrecke;
    property Staffelvorg               : Integer   read GetStaffelvorg write SetStaffelvorg;
    property StrafZeitColl             : TIntegerCollection read FStrafZeitColl;
    property Bearbeitet                : TTimeStamp read FBearbeitet write FBearbeitet;
  end;

  TReportTlnObj = class(TObject)
  // für RaveReports, wird beim Sortieren gesetzt
  public
    TlnPtr    : TTlnObj;
    ReportWk  : TWettkObj;
    ReportWrtg: TWertungMode;
    ReportAk  : TAkObj;
    constructor Create(TlnNeu:TTlnObj;ReportWkNeu:TWettkObj;ReportWrtgNeu:TWertungMode;
                       {RepWkNeu:TReportWkObj;}ReportAkNeu:TAkObj);
    function    GetReportAkSortStr: String;
    function    GetReportSondWrtgStr: String;
  end;

  TReportTlnList = class(TList)
  // zusätzliche sortierte Pointer-Liste in TriaSortColl
  private
    function    SortString(Item:TReportTlnObj): String;
  public
    function    Add(Item:TTlnObj;RepWkNeu:TReportWkObj;AkNeu:TAkObj{;WettkNeu:TWettkObj;WrtgNeu:TWertungMode}): Integer;
    function    Find(Item:TReportTlnObj; var Indx:Integer): Boolean;
    function    Compare(Item1, Item2: TReportTlnObj): Integer;
  end;

  TTlnColl = class(TTriaObjColl)
  private
    FTlnMsch      : TTlnMsch; // für Msch.TlnListen cnMsch, sonst cnTln
  protected
    FReportItems  : TReportTlnList; // unabhängige Sortierliste für RaveReports
    FSortOrtIndex : Integer;
    FSortWettk    : TWettkObj;
    FSortWrtgMode : TWertungMode;
    FSortAkWrtg   : TKlassenWertung; // nur für Serienwertung
    FSortKlasse   : TAkObj;
    FSortSMld     : TSMldObj;
    FSortStatus   : TStatus;
    function    GetBPObjType: Word; override;
    function    GetPItem(Indx:Integer): TTlnObj;
    procedure   SetPItem(Indx:Integer; Item:TTlnObj);
    function    GetReportCount: Integer;
    function    GetSortItem(Indx:Integer): TTlnObj;
    function    GetReportItem(Indx:Integer): TReportTlnObj;
  public
    MschAkWrtg : TKlassenWertung; // nur in MannsObj gesetzt für Msch-Listen
    constructor Create(Veranst:Pointer;ItemClass:TTriaObjClass;ProgressBar:TStepProgressBar;TM:TTlnMsch);
    destructor  Destroy; override;
    function    SortString(Item:Pointer): String; override;
    //function    SortString(Item:TTlnObj;AkWrtg:TKlassenWertung): String; overload;
    function    AddItem(Item: Pointer): Integer; override;
    function    SortModeValid(Item:Pointer): Boolean;
    function    AddSortItem(Item:Pointer): Integer; override;
    procedure   ClearIndex(Indx:Integer); override;
    procedure   OrtCollExch(Idx1,Idx2:Integer); override;
    function    SnrMax(Wk:TWettkObj;WrtgMode:TWertungMode;Ak:TAkObj;St:TStatus):Integer;
    function    SnrMin(Wk:TWettkObj;WrtgMode:TWertungMode;Ak:TAkObj;St:TStatus):Integer;
    function    TagesRngMax(Wk:TWettkObj;WrtgMode:TWertungMode;Ak:TAkObj):Integer;
    function    SerieRngMax(Wk:TWettkObj;Ak:TAkObj):Integer;
    procedure   Sortieren(OrtIndexNeu:Integer; ModeNeu:TSortMode;
                          WettkNeu:TWettkObj; WrtgNeu:TWertungMode; AkNeu:TAkObj;
                          SMldNeu: TSMldObj; StatusNeu: TStatus);
    procedure   ReportSortieren; overload;
    //procedure   ReportSortieren(WettkNeu:TWettkObj;WrtgNeu:TWertungMode); overload;
    procedure   ReportSortieren(RepWkNeu:TReportWkObj); overload;
    procedure   ReportSortieren(RepWkNeu:TReportWkObj;AkNeu:TAkObj); overload;
    procedure   ReportClear;
    function    TlnZahl(Wk:TWettkObj;WrtgMode:TWertungMode;Kl:TAkObj;St:TStatus):Integer; overload;
    function    TlnZahl(SM:TSMldObj;Wk:TWettkObj;WrtgMode:TWertungMode;Kl:TAkObj;St:TStatus):Integer; overload;
    function    OrtTlnZahl(Ix:Integer;Wk:TWettkObj;WrtgMode:TWertungMode;Kl:TAkObj;St:TStatus):Integer;
    function    TlnGewertet(Wk:TWettkObj): Integer;
    function    OrtTlnGewertet(Ix:Integer;Wk:TWettkObj): Integer;
    function    SortTlnGewertet: Integer;
    function    TlnEingeteilt(Wk:TWettkObj): Integer;
    function    TlnGestartet(Wk:TWettkObj): Integer;
    function    MannschNameVorhanden(MschNamePtr:PString): Boolean;
    function    AlleMschNamenErsetzenErlaubt(MschAlt,MschNeu:String;Wk:TWettkObj): Boolean;
    procedure   AlleMschNamenErsetzen(MschAlt,MschNeu:String;Wk:TWettkObj);
    function    OrtTlnEingeteilt(Ix:Integer;Wk:TWettkObj):Integer;
    //function    OrtTlnGestartet(Ix:Integer;Wk:TWettkObj{;Klasse:TAkObj}):Boolean;
    function    OrtTlnImZiel(Ix:Integer;Wk:TWettkObj):Boolean;
    //function    OrteBelegt(Wk:TWettkObj;Klasse:TAkObj): Integer;
    function    SGrpBelegt(Item: TSGrpObj): Boolean;
    procedure   SerieWertung(WertungsWk:TWettkObj);
    procedure   SetAlleSerienWrtg(SerienWrtgNeu: Boolean);
    function    SucheTln(Selbst:TTlnObj;NameNeu,VNameNeu,MannschNeu:String;
                         WettkNeu:TWettkObj): TTlnObj;
    function    WettkTlnZahl(Item:TWettkObj): Integer; {von WettkColl}
    function    WettkSBhnTlnZahl(Item:TWettkObj; Bahn:Integer): Integer;
    function    SGrpTlnZahl(Item: TSGrpObj): Integer; {von SGrpColl}
    function    SBhnTlnZahl(Item: TSGrpObj; Bahn:Integer): Integer;
    function    TlnMitSnr(Sn:Integer): TTlnObj;
    function    ErsteFreieSnr(const Sg:TSGrpObj) : Integer;
    function    TlnAusserTagWrtg(Wk:TWettkObj;Wrtg:TWertungMode;Klasse:TAkObj;Status:TStatus):Boolean;
    function    TlnAusserSerWrtg(Wk:TWettkObj;Klasse:TAkObj;Status:TStatus):Boolean;
    function    LandDefiniert(Wk:TWettkObj;Wrtg:TWertungMode): Boolean;
    function    SondWrtgDefiniert(Wk:TWettkObj): Boolean;
    function    ZeitStrafe(Wk:TWettkObj;Wrtg:TWertungMode; Klasse:TAkObj; Status:TStatus): Boolean;
    procedure   UpdateKlassen(Wk:TWettkObj);
    procedure   ClearKlassen(Wk:TWettkObj);
    procedure   SetzeTlnStZeit(Abs:TWkAbschnitt;Wk:TWettkObj);
    procedure   ClearTlnStZeit(Wk:TWettkObj; SG:TSGrpObj);
    procedure   UpdateRundenZahl(Abs:TWkAbschnitt;Wk:TWettkObj);
    procedure   ZeitenRunden(Ix:Integer;Wk:TWettkObj;Abs:TWkAbschnitt);
    property    Items[Indx: Integer]: TTlnObj read GetPItem write SetPItem; default;
    property    SortItems[Indx:Integer]:TTlnObj read GetSortItem;
    property    SortList: TTriaSortList read FSortItems;
    property    ReportCount:Integer read GetReportCount;
    property    ReportItems[Indx:Integer]:TReportTlnObj read GetReportItem;
    property    ReportTlnList: TReportTlnlist read FReportItems;
    property    SortOrtIndex : Integer read FSortOrtIndex write FSortOrtIndex;
    property    SortWettk    : TWettkObj read FSortWettk write FSortWettk;
    property    SortWrtgMode : TWertungMode read FSortWrtgmode write FSortWrtgMode;
    property    SortKlasse   : TAkObj read FSortKlasse write FSortKlasse;
    property    SortAkWrtg   : TKlassenWertung read FSortAkWrtg write FSortAkWrtg;
    property    SortSMld     : TSMldObj read FSortSMld write FSortSMld;
    property    SortStatus   : TStatus read FSortStatus write FSortStatus;
  end;

implementation

uses TriaMain,VeranObj,MannsObj,DateiDlg,TlnErg,RaveUnit,ZtEinlDlg;


(******************************************************************************)
(*  Methoden von TZeitRecColl                                                 *)
(******************************************************************************)

//******************************************************************************
function ZeitRecCollCompare(List: TZeitRecColl; Index1, Index2: Integer): Integer;
//******************************************************************************
// für Sort
begin
  Result := List.CompareZeit(List[Index1].AufRndZeit,List[Index2].AufRndZeit);
end;

// private Methoden

//..............................................................................
procedure TZeitRecColl.ExchangeItems(Index1, Index2: Integer);
//..............................................................................
// wie
(*procedure TStringList.ExchangeItems(Index1, Index2: Integer);
var
  Temp: Pointer;
  Item1, Item2: PStringItem;
begin
  Item1 := @FList[Index1];
  Item2 := @FList[Index2];
  Temp := Pointer(Item1^.FString);
  Pointer(Item1^.FString) := Pointer(Item2^.FString);
  Pointer(Item2^.FString) := Temp;
  Temp := Item1^.FObject;
  Item1^.FObject := Item2^.FObject;
  Item2^.FObject := Temp;
end;*)

var
  Temp: Pointer;
  Item1, Item2: PZeitRec;
begin
  Item1 := @FList[Index1];
  Item2 := @FList[Index2];
  Temp := Pointer(Item1^.ErfZeit);
  Pointer(Item1^.ErfZeit) := Pointer(Item2^.ErfZeit);
  Pointer(Item2^.ErfZeit) := Temp;
  Temp := Pointer(Item1^.AufRndZeit);
  Pointer(Item1^.AufRndZeit) := Pointer(Item2^.AufRndZeit);
  Pointer(Item2^.AufRndZeit) := Temp;

{var
  Temp,Item1,Item2: TZeitRec;
begin
  Item1 := FItems[Index1];
  Item2 := FItems[Index2];
  Temp.ErfZeit    := Item1.ErfZeit;
  Temp.AufRndZeit := Item1.AufRndZeit;

  Item1.ErfZeit    := Item2.ErfZeit;
  Item1.AufRndZeit := Item2.AufRndZeit;

  Item2.ErfZeit    := Temp.ErfZeit;
  Item2.AufRndZeit := Temp.AufRndZeit; }
end;

//..............................................................................
procedure TZeitRecColl.QuickSort(L, R: Integer; SCompare: TZeitRecSortCompare);
//..............................................................................
// wie TStringList
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        if I <> J then
          ExchangeItems(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;

//..............................................................................
procedure TZeitRecColl.Sort;
//..............................................................................
begin
  if FCount > 1 then
    QuickSort(0, FCount - 1, {@}ZeitRecCollCompare);
end;

//..............................................................................
function TZeitRecColl.CompareZeit(const Zeit1, Zeit2: Integer): Integer;
//..............................................................................
var W1,W2:Integer;
begin
  W1 := SortValue(Zeit1);
  W2 := SortValue(Zeit2);
  if W1 > W2 then Result := 1
  else
  if W1 < W2 then Result := -1
  else Result := 0;
end;

//..............................................................................
procedure TZeitRecColl.Grow;
//..............................................................................
var
  Delta: Integer;
begin
  if FCapacity > 64 then Delta := FCapacity div 4 else
    if FCapacity > 8 then Delta := 16 else
      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

// protected Methoden

//------------------------------------------------------------------------------
function TZeitRecColl.GetBPObjType: Word;
//------------------------------------------------------------------------------
begin
  Result := rrZeitSortColl;
end;

//------------------------------------------------------------------------------
function TZeitRecColl.GetCount: Integer;
//------------------------------------------------------------------------------
begin
  Result := FCount;
end;

//------------------------------------------------------------------------------
procedure TZeitRecColl.SetCapacity(NewCapacity: Integer);
//------------------------------------------------------------------------------
begin
  if (NewCapacity >= FCount) and (NewCapacity <> FCapacity) then
  begin
    SetLength(FList, NewCapacity);
    FCapacity := NewCapacity;
  end;
end;

//------------------------------------------------------------------------------
function TZeitRecColl.GetPItem(Indx: Integer): Pointer;
//------------------------------------------------------------------------------
// nicht benutzen
begin
  Result := nil; //@FList[Indx];
end;

//------------------------------------------------------------------------------
procedure TZeitRecColl.SetPItem(Indx:Integer; Item:Pointer);
//------------------------------------------------------------------------------
// nicht benutzen
begin
  // keine Aktion
end;

//==============================================================================
function TZeitRecColl.GetSortCount: Integer;
//==============================================================================
// nicht benutzen
begin
  Result := 0;
end;

//==============================================================================
function TZeitRecColl.GetSortItem(Indx:Integer): Pointer;
//==============================================================================
// nicht benutzen
begin
  Result := nil;
end;

//------------------------------------------------------------------------------
procedure TZeitRecColl.FreeItem(Item: Pointer);
//------------------------------------------------------------------------------
begin
  // dummy
end;

//------------------------------------------------------------------------------
function TZeitRecColl.LoadItem(Indx:Integer): Boolean;
//------------------------------------------------------------------------------
var I1,I2 : Integer;
begin
  Result := false;
  try
    TriaStream.ReadBuffer(I1,cnSizeOfInteger);
    TriaStream.ReadBuffer(I2,cnSizeOfInteger);
    if Indx=0 then
    begin
      StrtRec.ErfZeit    := I1;
      StrtRec.AufRndZeit := I2;
    end else
      if Add(I1,I2) = Indx-1 then Result := true;
  except
    Exit;
  end;
end;

//------------------------------------------------------------------------------
function TZeitRecColl.StoreItem(Indx:Integer): Boolean;
//------------------------------------------------------------------------------
// nicht benutzt
begin
  Result := false;
end;

//------------------------------------------------------------------------------
function TZeitRecColl.GetRec(Indx:Integer): TZeitRec;
//------------------------------------------------------------------------------
// ohne Startzeit
begin
  if (Indx >= 0)  and (Indx < FCount) then
    Result := FList[Indx]
  else
  begin
    Result.ErfZeit    := -1;
    Result.AufRndZeit := -1;
  end;
end;

//------------------------------------------------------------------------------
function TZeitRecColl.SetRec(Indx:Integer; Rec:TZeitRec): Integer;
//------------------------------------------------------------------------------
// ohne Startzeit, nur gültige AufRndZeit
//var i: integer;
begin
  Result := -1;
  if (Rec.ErfZeit >= -1) and (Rec.AufRndZeit >= 0) and
     (Rec.ErfZeit < cnZeit24_00) and (Rec.AufRndZeit < cnZeit24_00) then
    {if Indx = 0 then // Startzeit, alle Runden neu sortieren
    begin
      PZeitRec(FItems[0])^ := Item;
      FSortItems.Count := 0;
      for i:=1 to Count-1 do FSortItems.Add(FItems[i]); // ohne Startzeit
    end else
    if (Indx > 0) and (Indx < Count) then // aktuelles item neu sortieren
    begin
      FSortItems.Remove(FItems[Indx]);
      PZeitRec(FItems[Indx])^ := Item;
      FSortItems.Add(FItems[Indx]);
    end;}
    if (Indx >= 0) and (Indx < FCount) then // aktuelles item neu sortieren
    begin
      ClearIndex(Indx);
      Result := AddRec(Rec);
    end;
end;

//------------------------------------------------------------------------------
function TZeitRecColl.GetStrtRec: TZeitRec;
//------------------------------------------------------------------------------
// ohne Startzeit
begin
  Result.ErfZeit    := StrtRec.ErfZeit;
  Result.AufRndZeit := StrtRec.AufRndZeit;
end;

//------------------------------------------------------------------------------
procedure TZeitRecColl.SetStrtRec(Rec:TZeitRec);
//------------------------------------------------------------------------------
// nur gültige AufRndZeit, alle Runden neu sortieren
//var i: integer;
begin
  if (Rec.ErfZeit >= -1) and (Rec.AufRndZeit >= 0) and
     (Rec.ErfZeit < cnZeit24_00) and (Rec.AufRndZeit < cnZeit24_00) then
  begin
    StrtRec.ErfZeit    := Rec.ErfZeit;
    StrtRec.AufRndZeit := Rec.AufRndZeit;
    Sort;
  end;
end;



// public Methoden

//==============================================================================
constructor TZeitRecColl.Create(Veranst:Pointer);
//==============================================================================
begin
  inherited Create(Veranst);
  FreeAndNil(FItems);
  FreeAndNil(FSortItems);
  FItemSize          := SizeOf(TZeitRec);
  StrtRec.ErfZeit    := -1;
  StrtRec.AufRndZeit := -1;
end;


//==============================================================================
function TZeitRecColl.Store: Boolean;
//==============================================================================
// inherited nicht nutzbar
var
  W : Word;
  i : Integer;
  C : SmallInt;
begin
  Result := false;
  if TriaStream = nil then Exit;
  W := BPObjType;
  try
    if TriaStream.Write(W, cnSizeOfWord) <> cnSizeOfWord then Exit;
    C := FCount+1;
    if TriaStream.Write(C,cnSizeOfSmallInt) <> cnSizeOfSmallInt then Exit;
    // Startzeit
    TriaStream.WriteBuffer(StrtRec.ErfZeit,cnSizeOfInteger);
    TriaStream.WriteBuffer(StrtRec.AufRndZeit,cnSizeOfInteger);
    // FList
    for i:=0 to FCount-1 do
    begin
      TriaStream.WriteBuffer(FList[i].ErfZeit,cnSizeOfInteger);
      TriaStream.WriteBuffer(FList[i].AufRndZeit,cnSizeOfInteger);
    end;
  except
    Exit;
  end;
  Result := true;
end;

//==============================================================================
function TZeitRecColl.CollSize:Integer;
//==============================================================================
begin
  Result := cnMinCollSize + (FCount+1)*FItemSize;
end;

//==============================================================================
procedure TZeitRecColl.Clear;
//==============================================================================
begin
  if FCount <> 0 then
  begin
    FCount := 0;
    SetCapacity(0);
  end;
end;

//==============================================================================
function TZeitRecColl.IndexOf(Item:Pointer):Integer;
//==============================================================================
// not used
begin
  Result := -1;
end;

//==============================================================================
procedure TZeitRecColl.ClearIndex(Indx:Integer);
//==============================================================================
begin
  // Explicitly finalize the element we about to stomp on with move
  //Finalize(FList[Indx]);
  Dec(FCount);
  if Indx < FCount then
  begin
    System.Move(FList[Indx + 1], FList[Indx], (FCount - Indx) * SizeOf(TZeitRec));
    // Make sure there is no danglng pointer in the last (now unused) element
    //PPointer(@FItems[FCount])^ := nil;
  end;
end;

//==============================================================================
function TZeitRecColl.AddItem(Item:Pointer): Integer;
//==============================================================================
// not used
begin
  Result := -1;
  //Result := FItems.Add(Item); //EOutOfMemory-Exception, wenn zu wenig Speicher
end;

//==============================================================================
function TZeitRecColl.SortString(Item:Pointer): String;
//==============================================================================
begin
  // Dummy um Compiler-Warnung zu vermeiden
  Result := '';
end;



//------------------------------------------------------------------------------
function TZeitRecColl.AddRec(Rec:TZeitRec): Integer;
//------------------------------------------------------------------------------
begin
  if not FindeZeit(Rec.AufRndZeit, Result) {or FDuplicates} then // keine Duplikate erlaubt
    InsertRec(Result,Rec);
end;




//------------------------------------------------------------------------------
procedure TZeitRecColl.InsertRec(Indx: Integer; Rec:TZeitRec);
//------------------------------------------------------------------------------
begin
  if FCount = FCapacity then Grow;
  if Indx < FCount then
    System.Move(FList[Indx], FList[Indx + 1], (FCount - Indx) * SizeOf(TZeitRec));
  with FList[Indx] do
  begin
    ErfZeit    := Rec.ErfZeit;
    AufRndZeit := Rec.AufRndZeit;
  end;
  Inc(FCount);
end;

//******************************************************************************
function TZeitRecColl.FindeZeit(Zeit:Integer; var Indx:Integer):Boolean;
//******************************************************************************
// Liste muß nach AufRndZeit sortiert sein, sonst falsches Ergebnis
// das bei Verwendung des Index Absturz verursacht
var
  L, H, I, C: Integer;
begin
  Result := false;
  L := 0;
  H := FCount-1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := CompareZeit(FList[I].AufRndZeit,Zeit);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := true;
        {if not FDuplicates then} L := I; // keine Duplikate erlaubt
      end;
    end;
  end;
  Indx := L;
end;

//------------------------------------------------------------------------------
procedure TZeitRecColl.SetStrtErfZeit(Zeit:Integer);
//------------------------------------------------------------------------------
begin
  if (Zeit >= -1) and (Zeit < cnZeit24_00) then
    StrtRec.ErfZeit := Zeit;
end;

//------------------------------------------------------------------------------
function TZeitRecColl.GetStrtErfZeit: Integer;
//------------------------------------------------------------------------------
begin
  Result := StrtRec.ErfZeit;
end;

//------------------------------------------------------------------------------
procedure TZeitRecColl.SetStrtAufRndZeit(Zeit:Integer);
//------------------------------------------------------------------------------
begin
  if (Zeit >= -1) and (Zeit < cnZeit24_00) then
    StrtRec.AufRndZeit := Zeit;
  Sort;
end;

//------------------------------------------------------------------------------
function TZeitRecColl.GetStrtAufRndZeit: Integer;
//------------------------------------------------------------------------------
begin
  Result := StrtRec.AufRndZeit;
end;

//==============================================================================
function TZeitRecColl.GetErfZeit(Indx:Integer): Integer;
//==============================================================================
// ohne Startzeit
begin
  {if Indx = -1 then // letzte Runde
    Result := GetItem(IndexOf(FSortItems.Last)).ErfZeit
  else
    Result := GetItem(Indx).ErfZeit; }

  if (Indx>=0) and (Indx<FCount) then
    Result := FList[Indx].ErfZeit
  else
    Result := FList[FCount-1].ErfZeit;  // letzte Runde
end;

//==============================================================================
function TZeitRecColl.SetErfZeit(Indx,Zeit:Integer): Integer;
//==============================================================================
// wird nur beim Zeiten Einlesen benutzt
// ohne Startzeit
begin
 {if (Zeit >= -1) and (Zeit < cnZeit24_00) then
    if (Indx >= 0) and (Indx < Count) then
    begin
      Result := Indx;
      PZeitRec(FItems[Indx]).ErfZeit := Zeit
    end else
    if Indx = -1 then // 1. leere Item setzen (oder letzte Runde)
    begin
      Result := IndexOf(FSortItems.Last); //1. leere Item steht am Ende
      if Result >=0 then
        PZeitRec(FItems[Result]).ErfZeit := Zeit;
    end
    else Result := -1
  else Result := -1; }

  if (Zeit >= -1) and (Zeit < cnZeit24_00) then
    if (Indx >= 0) and (Indx < FCount) then
    begin
      Result := Indx;
      FList[Indx].ErfZeit := Zeit;
    end else
    if Indx = -1 then // neues Item
    begin

      Result := FCount-1; //1. leere Item steht am Ende
      if Result >=0 then
        FList[Result].ErfZeit := Zeit;
    end
    else Result := -1
  else Result := -1;
end;

//==============================================================================
function TZeitRecColl.GetAufRndZeit(Indx:Integer): Integer;
//==============================================================================
// ohne Startzeit
begin
  {if Indx = -1 then // letzte Runde
    Result := GetItem(IndexOf(FSortItems.Last)).AufRndZeit
  else
    Result := GetItem(Indx).AufRndZeit;}

  if (Indx >= 0) and (Indx < FCount) then
    Result := FList[Indx].AufRndZeit
  else
    Result := FList[FCount-1].AufRndZeit;  // letzte Runde
end;

//==============================================================================
function TZeitRecColl.SetAufRndZeit(Indx,Zeit:Integer): Integer;
//==============================================================================
//var i: integer;
begin
  {if (Zeit >= -1) and (Zeit < cnZeit24_00) then
    if Indx = 0 then // Startzeit, alle Runden neu sortieren
    begin
      Result := 0;
      PZeitRec(FItems[Indx]).AufRndZeit := Zeit;
      FSortItems.Count := 0;
      for i:=1 to Count-1 do FSortItems.Add(FItems[i]); // ohne Startzeit
    end else
    if (Indx > 0) and (Indx < Count) then // aktuelles item neu sortieren
    begin
      Result := Indx;
      FSortItems.Remove(FItems[Indx]);
      PZeitRec(FItems[Indx]).AufRndZeit := Zeit;
      FSortItems.Add(FItems[Indx]);
    end else
    if Indx = -1 then // letzte Runde oder 1. Leere Runde
    begin
      Result := IndexOf(FSortItems.Last);
      if Result >=0 then
      begin
        FSortItems.Remove(FItems[Result]);
        PZeitRec(FItems[Result]).AufRndZeit := Zeit;
        FSortItems.Add(FItems[Result]);
      end;
    end
    else Result := -1
  else Result := -1; }

  if (Zeit >= -1) and (Zeit < cnZeit24_00) then
    if (Indx >= 0) and (Indx < FCount) then
    begin
      Result := Indx;
      FList[Indx].ErfZeit := Zeit;
    end

end;

//==============================================================================
function TZeitRecColl.SortValue(const Zeit:Integer): Integer;
//==============================================================================
// nach Zeitabstand zur Startzeit sortieren, ohne Startzeit
// Zeitgleichheit = 24 Stunden (cnZeit24_00)
var StrtZeit : Integer;
begin
  StrtZeit := Max(StrtRec.AufRndZeit,0);
  if Zeit >= 0 then // Rundenzeit gültig
  begin
    Result := Zeit - StrtZeit;
    if Result <= 0 then Result := Result + cnZeit24_00;
  end else  // keine Rundenzeit, am Ende der Liste
    Result := cnZeit192_00 + cnRundenMax+1;
end;

//==============================================================================
function TZeitRecColl.Add(ErfZeitNeu,AufRndZeitNeu:Integer): Integer;
//==============================================================================
var Rec : TZeitRec;
begin
  Rec.ErfZeit    := ErfZeitNeu;
  Rec.AufRndZeit := AufRndZeitNeu;
  Result := AddRec(Rec);
end;

//==============================================================================
function TZeitRecColl.AddAufRndZeit(AufRndZeitNeu:Integer): Integer;
//==============================================================================
begin
  Result := Add(-1,AufRndZeitNeu);
end;

//==============================================================================
function TZeitRecColl.ErfZeitVorhanden(Zeit:Integer): Boolean;
//==============================================================================
// Zeiten filtern (zeZeitFilter)
var i: Integer;
begin
  Result := false;
  if StrtRec.ErfZeit = Zeit then Result := true
  else
    for i:=0 to FCount-1 do // mit Startzeit
      if FList[i].ErfZeit = Zeit then
      begin
        Result := true;
        Exit;
      end;
end;

(******************************************************************************)
(*  Methoden von TOrtZeitRecColl                                                 *)
(******************************************************************************)

(*----------------------------------------------------------------------------*)
function TOrtZeitRecColl.GetBPObjType: Word;
(*----------------------------------------------------------------------------*)
begin
  Result := 0; // Dummy, Compiler-Warnung vermeiden
end;

(*----------------------------------------------------------------------------*)
function TOrtZeitRecColl.LoadItem(Indx:Integer): Boolean;
(*----------------------------------------------------------------------------*)
begin
  Result := false;
  // Dummy, Compiler-Warnung vermeiden
end;

(*----------------------------------------------------------------------------*)
function TOrtZeitRecColl.StoreItem(Indx:Integer): Boolean;
(*----------------------------------------------------------------------------*)
begin
  Result := false;
  // Dummy, Compiler-Warnung vermeiden
end;

//------------------------------------------------------------------------------
procedure TOrtZeitRecColl.FreeItem(Item: Pointer);
//------------------------------------------------------------------------------
begin
  TZeitRecColl(Item).Free;
end;


// public

//==============================================================================
constructor TOrtZeitRecColl.Create(Veranst:Pointer);
//==============================================================================
begin
  inherited Create(Veranst);
  FItemSize := cnMinCollSize + 2 * cnSizeOfinteger; // min 2 Items
end;

//==============================================================================
function TOrtZeitRecColl.GetColl(OrtIndx:Integer): TZeitRecColl;
//==============================================================================
begin
  Result := TZeitRecColl(inherited GetPItem(OrtIndx));
end;

//==============================================================================
procedure TOrtZeitRecColl.SetColl(OrtIndx:Integer; Coll:TZeitRecColl);
//==============================================================================
begin
  inherited SetPItem(OrtIndx,Coll);
end;


(******************************************************************************)
(*                      Methoden von TTlnObj                                  *)
(******************************************************************************)

// protected Methoden

(*----------------------------------------------------------------------------*)
function TTlnObj.GetBPObjType: Word;
(*----------------------------------------------------------------------------*)
(* Object Types aus Version 7.4 Stream Registration Records *)
begin
  Result := rrTlnObj;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetName(NameNeu: String);
(*----------------------------------------------------------------------------*)
begin
  if FName <> NameNeu then
  begin
    SortRemove;
    FName := NameNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetVName(VNameNeu: String);
(*----------------------------------------------------------------------------*)
begin
  if FVName <> VNameNeu then
  begin
    SortRemove;
    FVName := VNameNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetStrasse(StrasseNeu: String);
(*----------------------------------------------------------------------------*)
begin
  if FStrasse <> StrasseNeu then
  begin
    SortRemove;
    FStrasse := StrasseNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetHausNr(HausNrNeu: String);
(*----------------------------------------------------------------------------*)
begin
  if FHausNr <> HausNrNeu then
  begin
    SortRemove;
    FHausNr := HausNrNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetPLZ(PLZNeu: String);
(*----------------------------------------------------------------------------*)
begin
  if FPLZ <> PLZNeu then
  begin
    SortRemove;
    FPLZ := PLZNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetOrt(OrtNeu: String);
(*----------------------------------------------------------------------------*)
begin
  if FOrt <> OrtNeu then
  begin
    SortRemove;
    FOrt := OrtNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetEMail(EMailNeu: String);
(*----------------------------------------------------------------------------*)
begin
  if FEMail <> EMailNeu then
  begin
    SortRemove;
    FEMail := EMailNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetSex(SexNeu: TSex);
(*----------------------------------------------------------------------------*)
begin
  if FSex <> SexNeu then
  begin
    SortRemove;
    FSex := SexNeu;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      FWettk.KlassenModified := true;
    KlassenSetzen; // für Tln ausserhalb TlnColl
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetJg(JgNeu: Integer);
(*----------------------------------------------------------------------------*)
begin
  if FJg <> JgNeu then
  begin
    SortRemove;
    FJg := JgNeu;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      FWettk.KlassenModified := true;
    KlassenSetzen; // für Tln ausserhalb TlnColl
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetLand(LandNeu: String);
(*----------------------------------------------------------------------------*)
begin
  if FLand <> LandNeu then
  begin
    SortRemove;
    FLand := LandNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetMannschName: String;
(*----------------------------------------------------------------------------*)
begin
  if FMannschName<>nil then Result := FMannschName^
  else Result := '';
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetMannschNamePtr(MannschNamePtrNeu: PString);
(*----------------------------------------------------------------------------*)
begin
  if FMannschName <> MannschNamePtrNeu then
  begin
    SortRemove;
    FMannschName := MannschNamePtrNeu;
    SortAdd;
    // damit Tln in Mannschaften neu eingelesen werden:
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      FWettk.MschModified := true;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetMannschName(MannschNameNeu: String);
(*----------------------------------------------------------------------------*)
var MannschAlt : String;
begin
  if FMannschName<>nil then MannschAlt := FMannschName^
                       else MannschAlt := '';
  if MannschAlt <> Trim(MannschNameNeu) then // Groß/Klein-Unterschied wird überschrieben
  begin
    SortRemove;
    TVeranstObj(FVPtr).MannschNameColl.InsertName(MannschNameNeu);
    FMannschName := TVeranstObj(FVPtr).MannschNameColl.GetNamePtr(MannschNameNeu);
    (* alter Name löschen, wenn nicht mehr benutzt *)
    if MannschAlt <> '' then
      TVeranstObj(FVPtr).MannschNameColl.NameLoeschen(MannschAlt);
    SortAdd;
    // damit Tln in Mannschaften neu eingelesen werden:
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      FWettk.MschModified := true;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetSMld(SMldNeu: TSMldObj);
(*----------------------------------------------------------------------------*)
begin
  if FSMld<>SMldNeu then
  begin
    SortRemove;
    if (FSMld<>nil) and (CollectionIndex>=0) then FSMld.TlnListe.ClearItem(Self);
    FSMld := SMldNeu;
    if (FSMld<>nil) and (CollectionIndex>=0) then FSMld.TlnListe.AddItem(Self);
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetWettk(WettkNeu: TWettkObj);
(*----------------------------------------------------------------------------*)
// Ortsbezogene Daten nur für aktueller Ort
var AbsCnt : TWkAbschnitt;
begin
  if FWettk <> Wettkneu then
  begin
    SortRemove;
    if (FVPtr=Veranstaltung) and (CollectionIndex>=0) and (FWettk<>nil) then
      FWettk.KlassenModified := true;

    FWettk := WettkNeu;
    KlassenSetzen; // für Tln ausserhalb TlnColl
    if FWettk <> nil then
    begin
      for AbsCnt:=wkAbs1 to wkAbs8 do
      begin
        UpdateRundenZahl(AbsCnt); // nur Akt.OrtIndex, Rest in TlnErg
        SetStrtZeit(AbsCnt);      // nur Akt.OrtIndex, Rest in TlnErg
      end;
      if not FWettk.SondWrtg then SondWrtg := false;
      if FWettk.TlnTxt = '' then Land := '';
      if FWettk.StartBahnen = 0 then SBhn := 0;
    end;

    if (FVPtr=Veranstaltung) and (CollectionIndex>=0) and (FWettk<>nil) then
      FWettk.KlassenModified := true; // auch ErgModified für alle Orte
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetSerienWrtg(SerienWrtgNeu: Boolean);
(*----------------------------------------------------------------------------*)
begin
  (* muss für alle Orte gelten *)
  if FSerienWrtg <> SerienWrtgNeu then
  begin
    SortRemove;
    FSerienWrtg := SerienWrtgNeu;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      FWettk.MschModified := true; // auch ErgModified für alle Orte
    SortAdd;
  end;
end;

//------------------------------------------------------------------------------
function TTlnObj.GetMschWrtg: Boolean;
//------------------------------------------------------------------------------
begin
  if (FMannschName = nil) or
     (FWettk = nil) or (FWettk.MschWertg = mwKein) or
     (Veranstaltung.Serie and not FSerienWrtg) then
    Result := false
  else Result := FMschWrtg;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetMschWrtg(MschWrtgNeu: Boolean);
(*----------------------------------------------------------------------------*)
begin
  // gilt für alle Orte
  if FMschWrtg <> MschWrtgNeu then
  begin
    SortRemove;
    FMschWrtg := MschWrtgNeu;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      FWettk.MschModified := true;
    SortAdd;
  end;
end;

//------------------------------------------------------------------------------
function TTlnObj.GetMschMixWrtg: Boolean;
//------------------------------------------------------------------------------
begin
  if GetMschWrtg then Result := FMschMixWrtg
                 else Result := false;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetMschMixWrtg(MschMixWrtgNeu: Boolean);
(*----------------------------------------------------------------------------*)
begin
  // gilt für alle Orte
  if FMschMixWrtg <> MschMixWrtgNeu then
  begin
    SortRemove;
    FMschMixWrtg := MschMixWrtgNeu;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      FWettk.MschModified := true;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetSeriePunkte(PktNeu:Integer;AkWrtg:TKlassenWertung);
(*----------------------------------------------------------------------------*)
begin
  if AkWrtg <> kwKein then FSeriePktArr[AkWrtg] := PktNeu;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetSerieRang(RngNeu:Integer;AkWrtg:TKlassenWertung);
(*----------------------------------------------------------------------------*)
begin
  if AkWrtg <> kwKein then FSerieRngArr[AkWrtg] := RngNeu;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetOrtAusKonkAllg(Indx:Integer): Boolean;
(*----------------------------------------------------------------------------*)
begin
  if Indx >= 0 then Result := FAusKonkAllgColl[Indx]
               else Result := false;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetAusKonkAllg: Boolean;
(*----------------------------------------------------------------------------*)
begin
  Result := FAusKonkAllgColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetAusKonkAllg(AusKonkAllgNeu: Boolean);
(*----------------------------------------------------------------------------*)
begin
  if FAusKonkAllgColl[TVeranstObj(FVPtr).OrtIndex] <> AusKonkAllgNeu then
  begin
    SortRemove;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      SetWettkErgModified;
    FAusKonkAllgColl[TVeranstObj(FVPtr).OrtIndex] := AusKonkAllgNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetAusKonkAltKl: Boolean;
(*----------------------------------------------------------------------------*)
begin
  Result := FAusKonkAltKlColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetAusKonkAltKl(AusKonkAltKlNeu: Boolean);
(*----------------------------------------------------------------------------*)
begin
  if FAusKonkAltKlColl[TVeranstObj(FVPtr).OrtIndex] <> AusKonkAltKlNeu then
  begin
    SortRemove;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      SetWettkErgModified;
    FAusKonkAltKlColl[TVeranstObj(FVPtr).OrtIndex] := AusKonkAltKlNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetAusKonkSondKl: Boolean;
(*----------------------------------------------------------------------------*)
begin
  Result := FAusKonkSondKlColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetAusKonkSondKl( AusKonkSondKlNeu: Boolean);
(*----------------------------------------------------------------------------*)
begin
  if FAusKonkSondKlColl[TVeranstObj(FVPtr).OrtIndex] <> AusKonkSondKlNeu then
  begin
    SortRemove;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      SetWettkErgModified;
    FAusKonkSondKlColl[TVeranstObj(FVPtr).OrtIndex] := AusKonkSondKlNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetSondWrtg: Boolean;
(*----------------------------------------------------------------------------*)
begin
  Result := FSondWrtgColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetSondWrtg(SondWrtgNeu: Boolean);
(*----------------------------------------------------------------------------*)
begin
  if FSondWrtgColl[TVeranstObj(FVPtr).OrtIndex] <> SondWrtgNeu then
  begin
    SortRemove;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      SetWettkErgModified;
    FSondWrtgColl[TVeranstObj(FVPtr).OrtIndex] := SondWrtgNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetUrkDruck: Boolean;
(*----------------------------------------------------------------------------*)
begin
  Result := FUrkDruckColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetUrkDruck(UrkDruckNeu: Boolean);
(*----------------------------------------------------------------------------*)
begin
  if FUrkDruckColl[TVeranstObj(FVPtr).OrtIndex] <> UrkDruckNeu then
  begin
    SortRemove;
    FUrkDruckColl[TVeranstObj(FVPtr).OrtIndex] := UrkDruckNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetSnr: Integer;
(*----------------------------------------------------------------------------*)
begin
  Result := FSnrColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetSnr(SnrNeu: Integer);
(*----------------------------------------------------------------------------*)
var AbsCnt: TWkAbschnitt;
begin
  if FSnrColl[TVeranstObj(FVPtr).OrtIndex] <> SnrNeu then
  begin
    SortRemove;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      SetWettkErgModified;

    FSnrColl[TVeranstObj(FVPtr).OrtIndex] := SnrNeu;
    for AbsCnt:=WkAbs1 to wkAbs8 do
      SetStrtZeit(AbsCnt);

    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      SetWettkErgModified;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetSGrp: TSGrpObj;
(*----------------------------------------------------------------------------*)
begin
  Result := FSGrpColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetSGrp(SGrpNeu:TSGrpObj);
(*----------------------------------------------------------------------------*)
var AbsCnt: TWkAbschnitt;
begin
  if FSGrpColl[TVeranstObj(FVPtr).OrtIndex] <> SGrpNeu then
  begin
    SortRemove;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      SetWettkErgModified;

    FSGrpColl[TVeranstObj(FVPtr).OrtIndex] := SGrpNeu;
    for AbsCnt:=wkAbs1 to wkAbs8 do
      SetStrtZeit(AbsCnt);

    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      SetWettkErgModified;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetStrtBahn: Integer;
(*----------------------------------------------------------------------------*)
begin
  Result := FStrtBahnColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetStrtBahn(StrtBahn: Integer);
(*----------------------------------------------------------------------------*)
var AbsCnt: TWkAbschnitt;
    StBahnAlt : Integer;
begin
  if FStrtBahnColl[TVeranstObj(FVPtr).OrtIndex] <> StrtBahn then
  begin
    SortRemove;
    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      SetWettkErgModified;
    StBahnAlt := FStrtBahnColl[TVeranstObj(FVPtr).OrtIndex];
    FStrtBahnColl[TVeranstObj(FVPtr).OrtIndex] := StrtBahn;
    if (StBahnAlt = 0) or (StrtBahn = 0) then
      for AbsCnt:=wkAbs1 to wkAbs8 do
        SetStrtZeit(AbsCnt);

    if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
      SetWettkErgModified;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetMldZeit: Integer;
(*----------------------------------------------------------------------------*)
begin
  Result := FMldZeitColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetMldZeit(MldZeitNeu: Integer);
(*----------------------------------------------------------------------------*)
begin
  if FMldZeitColl[TVeranstObj(FVPtr).OrtIndex] <> MldZeitNeu then
  begin
    SortRemove;
    if (MldZeitNeu >= 0) and (MldZeitNeu < cnZeit24_00) then
       FMldZeitColl[TVeranstObj(FVPtr).OrtIndex] := MldZeitNeu
    else FMldZeitColl[TVeranstObj(FVPtr).OrtIndex] := -1;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetStartgeld: Integer;
(*----------------------------------------------------------------------------*)
begin
  Result := FStartgeldColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetStartgeld(StartgeldNeu: Integer);
(*----------------------------------------------------------------------------*)
begin
  if FStartgeldColl[TVeranstObj(FVPtr).OrtIndex] <> StartgeldNeu then
  begin
    SortRemove;
    if StartgeldNeu >= 0 then
      FStartgeldColl[TVeranstObj(FVPtr).OrtIndex] := StartgeldNeu
    else FStartgeldColl[TVeranstObj(FVPtr).OrtIndex] := 0;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetKomment: String;
(*----------------------------------------------------------------------------*)
begin
  Result := FKommentColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetKomment(KommentNeu: String);
(*----------------------------------------------------------------------------*)
begin
  if FKommentColl[TVeranstObj(FVPtr).OrtIndex] <> KommentNeu then
  begin
    SortRemove;
    FKommentColl[TVeranstObj(FVPtr).OrtIndex] := KommentNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetStaffelName(Abs:TWkAbschnitt; NameNeu: String);
(*----------------------------------------------------------------------------*)
//TNameArr = array [wkAbs2..wkAbs8] of String;// ab wkAbs2
begin
  if (Abs in [wkAbs1..wkAbs8]) and
     (GetStaffelName(Abs) <> NameNeu) then
  begin
    SortRemove;
    if Abs=wkAbs1 then FName := NameNeu
    else FNameAbsArr[Abs] := NameNeu;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetStaffelVName(Abs:TWkAbschnitt; VNameNeu: String);
(*----------------------------------------------------------------------------*)
//TNameArr = array [wkAbs2..wkAbs8] of String;// ab wkAbs2
begin
  if (Abs in [wkAbs1..wkAbs8]) and
     (GetStaffelVName(Abs) <> VNameNeu) then
  begin
    SortRemove;
    if Abs=wkAbs1 then FVName := VNameNeu
    else FVNameAbsArr[Abs] := VNameNeu;
    SortAdd;
  end;
end;
(*----------------------------------------------------------------------------*)
function TTlnObj.GetStaffelName(Abs:TWkAbschnitt): String;
(*----------------------------------------------------------------------------*)
begin
  if Abs=wkAbs1 then Result := FName
  else
  if (Abs in [wkAbs2..wkAbs8]) and (FWettk<>nil) and (FWettk.WettkArt=waTlnStaffel) then
    Result := FNameAbsArr[Abs]
  else Result := '';
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetStaffelVName(Abs:TWkAbschnitt): String;
(*----------------------------------------------------------------------------*)
begin
  if Abs=wkAbs1 then Result := FVName
  else
  if (Abs in [wkAbs2..wkAbs8]) and (FWettk<>nil) and (FWettk.WettkArt=waTlnStaffel) then
    Result := FVNameAbsArr[Abs]
  else Result := ''
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetGutschrift: Integer;
(*----------------------------------------------------------------------------*)
begin
  Result := FGutschriftColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetGutschrift(GutschriftNeu: Integer);
(*----------------------------------------------------------------------------*)
begin
  if GutschriftNeu <> FGutschriftColl[TVeranstObj(FVPtr).OrtIndex] then
  begin
    SortRemove;
    SetWettkErgModified;
    if (GutschriftNeu >= 0) and (GutschriftNeu < cnZeit_1Std) then
      FGutschriftColl[TVeranstObj(FVPtr).OrtIndex] := GutschriftNeu
    else FGutschriftColl[TVeranstObj(FVPtr).OrtIndex] := 0;  // default = 0
    SetWettkErgModified;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetStrafZeit: Integer;
(*----------------------------------------------------------------------------*)
begin
  Result := FStrafZeitColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetStrafZeit(StrafZeitNeu: Integer);
(*----------------------------------------------------------------------------*)
begin
  if StrafZeitNeu <> FStrafZeitColl[TVeranstObj(FVPtr).OrtIndex] then
  begin
    SortRemove;
    SetWettkErgModified;
    if (StrafZeitNeu >= 0) and (StrafZeitNeu < cnZeit_1Std) then
      FStrafZeitColl[TVeranstObj(FVPtr).OrtIndex] := StrafZeitNeu
    else FStrafZeitColl[TVeranstObj(FVPtr).OrtIndex] := -1;
    SetWettkErgModified;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetDisqGrund: String;
(*----------------------------------------------------------------------------*)
begin
  if FDisqGrundColl[TVeranstObj(FVPtr).OrtIndex] <> nil then
    Result := PString(FDisqGrundColl[TVeranstObj(FVPtr).OrtIndex])^
  else Result := '';
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetDisqGrund(DisqGrund: String);
(*----------------------------------------------------------------------------*)
// für jeden Tln eigener Eintrag in DisqGrundColl
var P : PString;
begin
  if DisqGrund <> GetDisqGrund then
  begin
    SortRemove;
    SetWettkErgModified;
    if FDisqGrundColl[TVeranstObj(FVPtr).OrtIndex] <> nil then
      TVeranstObj(FVPtr).DisqGrundColl.ClearItem(FDisqGrundColl[TVeranstObj(FVPtr).OrtIndex]);

    if DisqGrund <> '' then
    begin
      New(P); P^:= DisqGrund;
      FDisqGrundColl[TVeranstObj(FVPtr).OrtIndex] := P;
      TVeranstObj(FVPtr).DisqGrundColl.AddItem(FDisqGrundColl[TVeranstObj(FVPtr).OrtIndex]);
    end else FDisqGrundColl[TVeranstObj(FVPtr).OrtIndex] := nil;
    SetWettkErgModified;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetDisqName: String;
(*----------------------------------------------------------------------------*)
begin
  if FDisqNameColl[TVeranstObj(FVPtr).OrtIndex] <> nil then
    Result := PString(FDisqNameColl[TVeranstObj(FVPtr).OrtIndex])^
  else Result := cnDisqNameDefault;
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetDisqName(DisqName: String);
(*----------------------------------------------------------------------------*)
// für jeden Tln eigener Eintrag in DisqNameColl
// nil: cnDisqNameDefault
var P : PString;
begin
  if DisqName <> GetDisqName then
  begin
    SortRemove;
    SetWettkErgModified;
    if FDisqNameColl[TVeranstObj(FVPtr).OrtIndex] <> nil then
      TVeranstObj(FVPtr).DisqNameColl.ClearItem(FDisqNameColl[TVeranstObj(FVPtr).OrtIndex]);

    if (DisqName <> '') and (DisqName <> cnDisqNameDefault) then
    begin
      New(P); P^:= DisqName;
      FDisqNameColl[TVeranstObj(FVPtr).OrtIndex] := P;
      TVeranstObj(FVPtr).DisqNameColl.AddItem(FDisqNameColl[TVeranstObj(FVPtr).OrtIndex]);
    end else FDisqNameColl[TVeranstObj(FVPtr).OrtIndex] := nil;
    SetWettkErgModified;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetReststrecke: Integer;
(*----------------------------------------------------------------------------*)
begin
  Result := FReststreckeColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetReststrecke(ReststreckeNeu: Integer);
(*----------------------------------------------------------------------------*)
begin
  if ReststreckeNeu <> FReststreckeColl[TVeranstObj(FVPtr).OrtIndex] then
  begin
    SortRemove;
    SetWettkErgModified;
    if ReststreckeNeu >= 0 then // < 10.000
      FReststreckeColl[TVeranstObj(FVPtr).OrtIndex] := ReststreckeNeu
    else FReststreckeColl[TVeranstObj(FVPtr).OrtIndex] := 0;  // default = 0
    SetWettkErgModified;
    SortAdd;
  end;
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetOrtStaffelVorg(Indx:Integer): Integer;
(*----------------------------------------------------------------------------*)
begin
  Result := FStaffelVorgColl[Indx];
end;

(*----------------------------------------------------------------------------*)
function TTlnObj.GetStaffelVorg: Integer;
(*----------------------------------------------------------------------------*)
begin
  Result := FStaffelVorgColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*----------------------------------------------------------------------------*)
procedure TTlnObj.SetStaffelVorg(StaffelVorg: Integer);
(*----------------------------------------------------------------------------*)
begin
  SortRemove;
  FStaffelVorgColl[TVeranstObj(FVPtr).OrtIndex] := Staffelvorg;
  SortAdd;
end;

//------------------------------------------------------------------------------
procedure TTlnObj.SetSerieWrtg(AkWrtg:TKlassenWertung; Bool:Boolean);
//------------------------------------------------------------------------------
begin
  if AkWrtg<>kwKein then FSerieWrtgArr[AkWrtg] := Bool;
end;

//------------------------------------------------------------------------------
procedure TTlnObj.SetSerieEndWrtg(AkWrtg:TKlassenWertung; Bool:Boolean);
//------------------------------------------------------------------------------
begin
  if AkWrtg<>kwKein then FSerieEndWrtgArr[AkWrtg] := Bool;
end;

//------------------------------------------------------------------------------
function TTlnObj.GetSerieWrtg(AkWrtg:TKlassenWertung): Boolean;
//------------------------------------------------------------------------------
begin
  if AkWrtg<>kwKein then Result := FSerieWrtgArr[AkWrtg]
                    else Result := false;
end;

//------------------------------------------------------------------------------
function TTlnObj.GetSerieEndWrtg(AkWrtg:TKlassenWertung): Boolean;
//------------------------------------------------------------------------------
begin
  if AkWrtg<>kwKein then Result := FSerieEndWrtgArr[AkWrtg]
                    else Result := false;
end;


// public Methoden

(*============================================================================*)
constructor TTlnObj.Create(Veranst:Pointer;Coll:TTriaObjColl;Add:TOrtAdd);
(*============================================================================*)
var i : Integer;
    KwCnt  : TKlassenWertung; 
    AbsCnt : TWkAbschnitt;
begin

  //i:= AllocMemSize;
  inherited Create(Veranst,Coll,Add);
  FName              := '';
  FVName             := '';
  FStrasse           := '';
  FHausNr            := '';
  FPLZ               := '';
  FOrt               := '';
  FEMail             := '';
  FSex               := cnKeinSex;
  FJg                := 0;
  FLand              := '';
  FWettk             := nil; // FWettk muss definiert werden bevor in TlnColl eingefügt
  KlassenLoeschen;
  FMannschName       := nil;
  FSMld              := nil;
  FSerienWrtg        := true;
  FMschWrtg          := true;
  FMschMixWrtg       := false;
  MannschAllePtr     := nil;
  MannschSexPtr      := nil;
  MannschAkPtr       := nil;
  Dummy              := false;

  FAusKonkAllgColl   := TBoolCollection.Create(FVPtr);
  FAusKonkAltKlColl  := TBoolCollection.Create(FVPtr);
  FAusKonkSondKlColl := TBoolCollection.Create(FVPtr);
  FSondWrtgColl      := TBoolCollection.Create(FVPtr);
  FUrkDruckColl      := TBoolCollection.Create(FVPtr);
  FSnrColl           := TWordCollection.Create(FVPtr);
  FSGrpColl          := TTriaPointerColl.Create(FVPtr,TVeranstObj(FVPtr).SGrpColl);
  FStrtBahnColl      := TWordCollection.Create(FVPtr);
  FMldZeitColl       := TIntegerCollection.Create(FVPtr);
  FStartgeldColl     := TIntegerCollection.Create(FVPtr);
  FKommentColl       := TTextCollection.Create(FVPtr);
  FGutschriftColl    := TIntegerCollection.Create(FVPtr);
  FStrafZeitColl     := TIntegerCollection.Create(FVPtr);
  FDisqGrundColl     := TTriaPointerColl.Create(FVPtr,TVeranstObj(FVPtr).DisqGrundColl);
  FDisqNameColl      := TTriaPointerColl.Create(FVPtr,TVeranstObj(FVPtr).DisqNameColl);
  FReststreckeColl   := TIntegerCollection.Create(FVPtr);
  FStaffelVorgColl   := TSmallIntCollection.Create(FVPtr);

  for AbsCnt:=wkAbs0 to wkAbs8 do
  begin
    for KwCnt:=kwAlle to kwSondKl do
    begin
      FRngCollArr[KwCnt,AbsCnt]    := TWordCollection.Create(FVPtr);
      FSwRngCollArr[KwCnt,AbsCnt]  := TWordCollection.Create(FVPtr);
      if AbsCnt = wkAbs0 then
      begin
        if KwCnt=kwAlle then
        begin
          FWertgKlasseArr[KwCnt] := AkAlle;
          if KwCnt<kwSondKl then
            FMschWertgKlasseArr[KwCnt] := AkAlle;
        end else
        begin
          FWertgKlasseArr[KwCnt] := AkUnbekannt;
          if KwCnt<kwSondKl then
            FMschWertgKlasseArr[KwCnt] := AkUnbekannt;
        end;
        FSeriePktArr[KwCnt]     := 0;
        FSerieRngArr[KwCnt]     := 0;
        FSerieWrtgArr[KwCnt]    := false;
        FSerieEndWrtgArr[KwCnt] := false;
        FSerRngCollArr[KwCnt]   := TWordCollection.Create(FVPtr);
        if KwCnt < kwSondKl then
          FMschRngCollArr[KwCnt] := TWordCollection.Create(FVPtr);
      end;
    end;
    if AbsCnt > wkAbs0 then
      FOrtZeitRecCollArr[AbsCnt] := TOrtZeitRecColl.Create(FVPtr);
  end;
  if Add=oaAdd then for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do OrtCollAdd;
  SetzeBearbeitet;
end;

(*============================================================================*)
destructor TTlnObj.Destroy;
(*============================================================================*)
var i : Integer;
    AbsCnt : TWkAbschnitt;
    KwCnt : TKlassenWertung;
begin
  // FWettk.MannschModified wird in TlnColl.ClearItem gesetzt.
  // Tln.Free wird nicht direkt aufgerufen für Tln aus TlnColl
  FreeAndNil(FAusKonkAllgColl);
  FreeAndNil(FAusKonkAltKlColl);
  FreeAndNil(FAusKonkSondKlColl);
  FreeAndNil(FSondWrtgColl);
  FreeAndNil(FUrkDruckColl);
  FreeAndNil(FSnrColl);
  FreeAndNil(FSGrpColl);
  FreeAndNil(FStrtBahnColl);
  FreeAndNil(FMldZeitColl);
  FreeAndNil(FStartgeldColl);
  FreeAndNil(FKommentColl);
  FreeAndNil(FGutschriftColl);
  FreeAndNil(FStrafZeitColl);
  // Eintrag pro Tln in DisqGrundColl
  if FVPtr=Veranstaltung then
    for i:=0 to FDisqGrundColl.Count-1 do
      if FDisqGrundColl[i] <> nil then
        Veranstaltung.DisqGrundColl.ClearItem(FDisqGrundColl[i]);
  FreeAndNil(FDisqGrundColl);
  // Eintrag pro Tln in DisqNameColl
  if FVPtr=Veranstaltung then
    for i:=0 to FDisqNameColl.Count-1 do
      if FDisqNameColl[i] <> nil then
        Veranstaltung.DisqNameColl.ClearItem(FDisqNameColl[i]);
  FreeAndNil(FDisqNameColl);
  FreeAndNil(FReststreckeColl);

  FreeAndNil(FStaffelVorgColl);

  for AbsCnt:=wkAbs0 to wkAbs8 do
  begin
    for KwCnt:=kwAlle to kwSondKl do
    begin
      FreeAndNil(FRngCollArr[KwCnt,AbsCnt]);
      FreeAndNil(FSwRngCollArr[KwCnt,AbsCnt]);
      if AbsCnt = wkAbs0 then
      begin
        FreeAndNil(FSerRngCollArr[KwCnt]);
        if KwCnt<kwSondKl then
          FreeAndNil(FMschRngCollArr[KwCnt]);
      end;
    end;
    if AbsCnt > wkAbs0 then
      FreeAndNil(FOrtZeitRecCollArr[AbsCnt]);
  end;

  // SMldColl.Clear nach TlnColl.Clear bei Schliessen
  if FSMld<>nil then FSMld.TlnListe.ClearItem(Self);

  inherited Destroy;
end;

(*============================================================================*)
function TTlnObj.Load: Boolean;
(*============================================================================*)
var i,j    : Integer;
    W      : Word;
    Buff   : SmallInt;
    C,CollCnt : SmallInt;
    SBuff  : String;
    LBuff  : LongInt;
    WBuff  : Word;
    BBuff  : Boolean;
    TxtBuffColl : TTextCollection;
    ZeitRecBuffColl : TZeitRecColl;
    IntBuffColl : TIntegerCollection;
    AbsCnt : TWkAbschnitt;
    KwCnt  : TKlassenWertung;
begin
  Inc(TlnGeladen);
  Result := false;
  with TriaStream do
  try
    if FVPtr <> EinlVeranst then Exit;
    if not inherited Load then Exit;

    if (TriDatei.Version.Jahr>'2004')or
       (TriDatei.Version.Jahr='2004')and(TriDatei.Version.Nr>='1.1') then
    begin
      // read allg Strings in Coll
      ReadBuffer(C,cnSizeOfSmallInt);
      for i:=0 to C-1 do
        case i of
          0: ReadStr(FName);    // Str 1
          1: ReadStr(FVName);   // Str 2
          2: ReadStr(FStrasse); // Str 3
          3: ReadStr(FOrt);     // Str 4
          4: ReadStr(FLand);    // Str 5
          5: ReadStr(FHausNr);  // Str 6  ab 2005-0.4
          6: ReadStr(FPLZ);     // Str 7  ab 2005-0.4
          7: ReadStr(FEMail);   // Str 8  ab 2010-0.2
          8,9,10,11,12,13,14:   // Str 9-15 ab 2010-1.8, ohne 2011.1.0
             ReadStr(FNameAbsArr[TWkAbschnitt(i-6)]); // Abs 2-8
          15,16,17,18,19,20,21: // Str 16-22 ab 2010-1.8, ohne 2011.1.0
             ReadStr(FVNameAbsArr[TWkAbschnitt(i-13)]); // Abs 2-8
          else ReadStr(SBuff);  // zukünftige Erweiterungen
        end;

      // read allg SmallInt in Coll
      ReadBuffer(C,cnSizeOfSmallInt);
      for i:=0 to C-1 do
      //begin
        //ReadBuffer(Buff,cnSizeOfSmallInt);
        case i of
          0: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 1
               if (TriDatei.Version.Jahr < '2008')or   // ab 2008-1.6 KeinSex erlaubt
                  (TriDatei.Version.Jahr='2008')and(TriDatei.Version.Nr<'1.5') then
                 if Buff AND opSex = 0 then FSex := cnMaennlich
                                       else FSex := cnWeiblich;
               if Buff AND opSerienWrtg = 0 then FSerienWrtg := false
                                            else FSerienWrtg := true;
               if (TriDatei.Version.Jahr < '2008')or
                  (TriDatei.Version.Jahr='2008')and(TriDatei.Version.Nr<'2.0') then
                 for j:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
                 begin //a.K.-Option für jeden Ort einstellen - ab 2008-2.0 pro Ort
                   if Buff AND opAusKonkAllg = 0 then FAusKonkAllgColl.Add(false)
                                                 else FAusKonkAllgColl.Add(true);
                   if Buff AND opAusKonkAltKl = 0 then FAusKonkAltKlColl.Add(false)
                                                  else FAusKonkAltKlColl.Add(true);
                   if Buff AND opAusKonkSondKl = 0 then FAusKonkSondKlColl.Add(false)
                                                   else FAusKonkSondKlColl.Add(true);
                 end;
               if (TriDatei.Version.Jahr < '2011')or // ab 2011-2.4 Mixed Msch erlaubt
                  (TriDatei.Version.Jahr='2011')and(TriDatei.Version.Nr<'2.4') then
                 // neue Optionen ab 2005
                 if TriDatei.Version.Jahr >= '2005' then
                 begin
                   if Buff AND opMschWrtg = 0 then
                   begin
                     FMschWrtg    := false;
                     FMschMixWrtg := false;
                   end else
                   begin
                     FMschWrtg    := true;
                     FMschMixWrtg := false;
                   end;
                 end else
                 begin
                   FMschWrtg    := true;
                   FMschMixWrtg := false;
                 end
               else // ab 11.2.4
               begin
                 if Buff AND opMschWrtg = 0 then FMschWrtg := false
                                            else FMschWrtg := true;
                 if Buff AND opMschMixWrtg = 0 then FMschMixWrtg := false
                                               else FMschMixWrtg := true;
               end;
             end;
          1: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 2
               FJg := Buff;
             end;
          2: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 3
               if (Buff >= 0) and (Buff < TVeranstObj(FVPtr).MannschNameColl.Count)
                 then FMannschName := TVeranstObj(FVPtr).MannschNameColl[Buff]
                 else FMannschName := nil;
             end;
          3: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 4
               if (Buff >= 0) and (Buff < TVeranstObj(FVPtr).SMldColl.Count) then
               begin
                 FSMld := TVeranstObj(FVPtr).SMldColl[Buff];
                 if FSMld<>nil then              //FVPtr<>Veranstaltung,
                   FSMld.TlnListe.AddItem(Self); //deshalb nicht in AddItem
               end else FSMld := nil;
             end;
          4: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 5
               if (Buff >= 0)and(Buff<TVeranstObj(FVPtr).WettkColl.Count) then
                 FWettk := TVeranstObj(FVPtr).WettkColl[Buff]
               else Exit;
             end;
          5: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 6
               FBearbeitet.Date := Buff;
               FBearbeitet.Date := FBearbeitet.Date shl 16;
             end;
          6: begin // > 32k möglich
               ReadBuffer(WBuff,cnSizeOfSmallInt);     // Int 7
               FBearbeitet.Date := FBearbeitet.Date + WBuff;
             end;
          7: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 8
               FBearbeitet.Time := Buff;
               FBearbeitet.Time := FBearbeitet.Time shl 16;
             end;
          8: begin // > 32k möglich
               ReadBuffer(WBuff,cnSizeOfSmallInt);     // Int 9
               FBearbeitet.Time := FBearbeitet.Time + WBuff;
             end;
          9: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 10, ab 2008-1.5
               FSex := TSex(Buff);
             end;
          else ReadBuffer(Buff,cnSizeOfSmallInt);      // zukunft
        end;
      KlassenSetzen; // nach Einlesen von Sex, Jg und Wettk

      // read allg LongInt in Coll
      ReadBuffer(C,cnSizeOfSmallInt);
      for i:=0 to C-1 do ReadBuffer(Buff,cnSizeOfLongInt);//zukunft,korr.2005-1.1

      // read Ort Collections, momentan nur pro Ort
      ReadBuffer(CollCnt,cnSizeOfSmallInt);
      for i:=0 to CollCnt-1 do
      begin
        // read Strings pro Ort in Coll
        ReadBuffer(C,cnSizeOfSmallInt);
        for j:=0 to C-1 do
        begin
          ReadStr(SBuff);
          if i < TVeranstObj(FVPtr).OrtZahl then
            case j of
              0: if (TriDatei.Version.Jahr < '2006')or
                    (TriDatei.Version.Jahr='2006')and(TriDatei.Version.Nr<'0.6') then
                   FMldZeitColl.Add(UhrZeitWertMin(SBuff)) // MldZeit-TextColl
                 else ; // Dummy String, nicht mehr benutzt
              1: FKommentColl.Add(SBuff); // neu 2005
              2,4,6,8,10,12,14: // Abs2..8, Staffelnamen ab 10.1.8 in allg. Strings
                 if (i = 0) and  // TlnStaffel nicht für Serie
                    ((TriDatei.Version.Jahr < '2010')or
                     (TriDatei.Version.Jahr='2010')and(TriDatei.Version.Nr<'1.8') or
                     (TriDatei.Version.Jahr='2011')and(TriDatei.Version.Nr='1.0')) then
                 begin
                   AbsCnt := TWkAbschnitt(j DIV 2 +1); // Str 2-7  ab 2007-1.2
                   FNameAbsArr[AbsCnt] := SBuff; // Str 8-15 ab 2009
                 end;
              3,5,7,9,11,13,15: // Abs2..8
                 if (i = 0) and  // TlnStaffel nicht für Serie
                    ((TriDatei.Version.Jahr < '2010')or
                     (TriDatei.Version.Jahr='2010')and(TriDatei.Version.Nr<'1.8') or
                     (TriDatei.Version.Jahr='2011')and(TriDatei.Version.Nr='1.0')) then
                 begin
                   AbsCnt := TWkAbschnitt(j DIV 2 +1); // Str 2-7  ab 2007-1.2
                   FVNameAbsArr[AbsCnt] := SBuff; // Str 8-15 ab 2009
                 end;
              else ;  // zukünftige Erweiterungen
            end
          else ;  // zukünftige Erweiterungen
        end;
        // read SmallInt pro Ort in Coll
        ReadBuffer(C,cnSizeOfSmallInt);
        for j:=0 to C-1 do
        begin
          ReadBuffer(Buff,cnSizeOfSmallInt);
          if i < TVeranstObj(FVPtr).OrtZahl then
            case j of
              0: FSnrColl.Add(Buff);       // SmallInt 1
              1: FSGrpColl.Add(Buff);      // SmallInt 2
              2: FStrtBahnColl.Add(Buff);  // SmallInt 3
              3: FDisqGrundColl.Add(Buff); // SmallInt 4
              4: begin // SmallInt 5,  Options pro Ort, neu 2005
                   if Buff AND opSondWrtg = 0 then FSondWrtgColl.Add(false)
                                              else FSondWrtgColl.Add(true);
                   if Buff AND opUrkDruck = 0 then FUrkDruckColl.Add(false)
                                              else FUrkDruckColl.Add(true);
                   if (TriDatei.Version.Jahr > '2008')or
                      (TriDatei.Version.Jahr='2008')and(TriDatei.Version.Nr>='2.0') then
                   begin
                     if Buff AND opAusKonkAllg = 0 then FAusKonkAllgColl.Add(false)
                                                   else FAusKonkAllgColl.Add(true);
                     if Buff AND opAusKonkAltKl = 0 then FAusKonkAltKlColl.Add(false)
                                                    else FAusKonkAltKlColl.Add(true);
                     if Buff AND opAusKonkSondKl = 0 then FAusKonkSondKlColl.Add(false)
                                                     else FAusKonkSondKlColl.Add(true);
                   end;
                 end;
              5: FDisqNameColl.Add(Buff); // SmallInt 6, Neu 2008-2.0
              else ; // zukunft
            end
          else ;  // zukünftige Erweiterungen
        end;

        // read LongInt pro Ort in Coll - alle Uhrzeiten
        ReadBuffer(C,cnSizeOfSmallInt);
        for j:=0 to C-1 do
        begin
          ReadBuffer(LBuff,cnSizeOfLongInt);//ab 2006-0.3: 1/10, ab 2008-2.0: 1/100
          // LBuff umrechnen auf 1/100 Sek
          if (TriDatei.Version.Jahr<'2006')or
             (TriDatei.Version.Jahr='2006')and(TriDatei.Version.Nr<'0.3') then
            if LBuff > 0 then LBuff := LBuff * 100 // Sek ==> 1/100 Sek
            else
          else
          if (TriDatei.Version.Jahr<'2008')or
             (TriDatei.Version.Jahr='2008')and(TriDatei.Version.Nr<'2.0') then
            if LBuff > 0 then LBuff := LBuff * 10; // 1/10 ==> 1/100 Sek

          if i < TVeranstObj(FVPtr).OrtZahl then
            if (TriDatei.Version.Jahr<'2008')or
               (TriDatei.Version.Jahr='2008')and(TriDatei.Version.Nr<'2.0') then
              // Rundenzeiten initialisieren
              case j of
                0: begin  // Int 1
                     ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
                     //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
                     ZeitRecBuffColl.AddAufRndZeit(LBuff); // Runde 1
                     FOrtZeitRecCollArr[wkAbs1].AddItem(ZeitRecBuffColl);
                     FGutschriftColl.Add(0); // Gutschrift neu ab 2008-2.0
                   end;
                1: begin // Int 2
                     ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
                     //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
                     ZeitRecBuffColl.AddAufRndZeit(LBuff); // Runde 1
                     FOrtZeitRecCollArr[wkAbs2].AddItem(ZeitRecBuffColl);
                   end;
                2: begin // Int 3
                     ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
                     //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
                     ZeitRecBuffColl.AddAufRndZeit(LBuff); // Runde 1
                     FOrtZeitRecCollArr[wkAbs3].AddItem(ZeitRecBuffColl);
                   end;
                3: FStrafZeitColl.Add(LBuff);   // Int 4
                4: begin // Int 5
                     ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
                     //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
                     ZeitRecBuffColl.AddAufRndZeit(LBuff); // Runde 1
                     FOrtZeitRecCollArr[wkAbs4].AddItem(ZeitRecBuffColl);
                   end;
                5: FMldZeitColl.Add(LBuff);     // Int 6, ab 2006
                6,7,8,9:
                   for AbsCnt:=wkAbs5 to wkAbs8 do
                   begin // Int 7,8,9,10 - ab 2009
                     ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
                     //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
                     ZeitRecBuffColl.AddAufRndZeit(LBuff); // Runde 1
                     FOrtZeitRecCollArr[AbsCnt].AddItem(ZeitRecBuffColl);
                   end;
                else ; // zukunft
              end
            else  // ab 2008-2.0: RundenZeiten in ZeitSortColl
              case j of
                0: FMldZeitColl.Add(LBuff);      // Int 1
                1: FStrafZeitColl.Add(LBuff);    // Int 2
                2: FGutschriftColl.Add(LBuff);   // Int 3
                3: FStartgeldColl.Add(LBuff);    // Int 4, 2010-0.2
                4: FReststreckeColl.Add(LBuff);  // Int 5, 2015
                else ; // zukunft
              end
          else ; // zukunft
        end;

        if i < TVeranstObj(FVPtr).OrtZahl then
          if (TriDatei.Version.Jahr>'2008')or
             (TriDatei.Version.Jahr='2008')and(TriDatei.Version.Nr>='2.0') then
          begin
          // ab 2008-2.0: RundenZeiten in ZeitSortColl pro Ort in 1/100 Sek
            ReadBuffer(C,cnSizeOfSmallInt);
            for AbsCnt:=wkAbs1 to wkAbs8 do // ab Abs1
            begin
              ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
              if Integer(AbsCnt) <= C then // Coll gespeichert
              begin
                if not ZeitRecBuffColl.Load then Exit;
                // FehlerKorrektur Rundenzahl Version 2008-2.2 bis 2010-1.6 in TlnErg
              end else // Coll nicht gespeichert, vor 2009
              begin
                //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
                ZeitRecBuffColl.AddAufRndZeit(-1); // Runde 1
              end;
              FOrtZeitRecCollArr[AbsCnt].AddItem(ZeitRecBuffColl);
            end;
          end;

        // Korrekturen für alte Dateiversionen
        if i < TVeranstObj(FVPtr).OrtZahl then
        begin
          if TriDatei.Version.Jahr < '2005' then
          begin
            FSondWrtgColl.Add(false);
            FUrkDruckColl.Add(true);
            FKommentColl.AddItem(nil);
          end;

          if (TriDatei.Version.Jahr<'2005')or
             (TriDatei.Version.Jahr='2005')and(TriDatei.Version.Nr<'1.1') then
          begin
            ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
            //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
            ZeitRecBuffColl.AddAufRndZeit(-1); // Runde 1
            FOrtZeitRecCollArr[wkAbs4].AddItem(ZeitRecBuffColl);
          end;

          if (TriDatei.Version.Jahr<'2008')or
             (TriDatei.Version.Jahr='2008')and(TriDatei.Version.Nr<'2.0') then
            FDisqNameColl.AddItem(nil);

          if TriDatei.Version.Jahr < '2009' then
            for AbsCnt:=wkAbs5 to wkAbs8 do
            begin
              ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
              //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
              ZeitRecBuffColl.AddAufRndZeit(-1); // Runde 1
              FOrtZeitRecCollArr[AbsCnt].AddItem(ZeitRecBuffColl);
            end;

          if (TriDatei.Version.Jahr<'2010')or
             (TriDatei.Version.Jahr='2010')and(TriDatei.Version.Nr<'0.2') then
            FStartgeldColl.Add(0);

          if (TriDatei.Version.Jahr<'2011')or
             (TriDatei.Version.Jahr='2011')and(TriDatei.Version.Nr<'4.1') then
            FReststreckeColl.Add(0);

        end;

        // nicht gespeicherte Collections initialisieren
        if i < TVeranstObj(FVPtr).OrtZahl then
        begin
          FStaffelVorgColl.Add(-1);
          for AbsCnt:=wkAbs0 to wkAbs8 do
          begin
            for KwCnt:=kwAlle to kwSondKl do
            begin
              FRngCollArr[KwCnt,AbsCnt].Add(0);
              FSwRngCollArr[KwCnt,AbsCnt].Add(0);
              if AbsCnt=wkAbs0 then
              begin
                FSerRngCollArr[KwCnt].Add(0);
                if KwCnt<kwSondKl then
                  FMschRngCollArr[KwCnt].Add(0);
              end;
            end;
          end;
        end;

      end;
    end

    else // altes Dateiformat - vor 2004-1.1
    begin
      ReadStr(FName);
      ReadStr(FVName);
      ReadStr(FStrasse);
      ReadStr(FOrt);
      ReadBuffer(W, cnSizeOfWord);
      if W=0 then FSex := cnMaennlich else FSex := cnWeiblich;
      ReadBuffer(W, cnSizeOfWord);
      FJg := W;
      ReadStr(FLand);
      ReadBuffer(Buff, cnSizeOfSmallInt);
      if (Buff >= 0) and (Buff < TVeranstObj(FVPtr).MannschNameColl.Count)
        then FMannschName := TVeranstObj(FVPtr).MannschNameColl[Buff]
        else FMannschName := nil;
      ReadBuffer(Buff, cnSizeOfSmallInt);
      if (Buff >= 0) and (Buff < TVeranstObj(FVPtr).SMldColl.Count) then
      begin
        FSMld := TVeranstObj(FVPtr).SMldColl[Buff];
        if FSMld<>nil then
          FSMld.TlnListe.AddItem(Self);//FVPtr<>Veranstaltung, deshalb nicht in AddItem
      end else
        FSMld := nil;
      ReadBuffer(Buff, cnSizeOfSmallInt);
      if (Buff >= 0)and(Buff<TVeranstObj(FVPtr).WettkColl.Count) then
        FWettk := TVeranstObj(FVPtr).WettkColl[Buff]
      else Exit;
      KlassenSetzen; // nach Einlesen von FWettk
      ReadBuffer(FSerienWrtg, cnSizeOfBoolean);
      // ab 2008-2.0: a.K. pro Ort gespeichert
      ReadBuffer(BBuff, cnSizeOfBoolean);
      for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
        FAusKonkAllgColl.Add(BBuff);

      FMschWrtg := true;
      FMschMixWrtg := false; // neu 2011.2.4

      // OrtCollAdd in Create, bei Load nicht mehr benutzt
      //for i := TVeranstObj(FVPtr).OrtZahl-1 downto 0 do OrtCollClear(i);
      if not FSnrColl.Load then Exit;
      if not FSGrpColl.Load then Exit;
      if not FStrtBahnColl.Load then Exit;
      // MldZeitColl umgestellt von text auf Integer
      TxtBuffColl := TTextCollection.Create(FVPtr);
      if not TxtBuffColl.Load then Exit;
      for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
        FMldZeitColl.Add(UhrZeitWertMin(TxtBuffColl[i]));
      TxtBuffColl.Free;

      //Abs1
      IntBuffColl := TIntegerCollection.Create(FVPtr);
      if not IntBuffColl.Load then Exit;
      for i:=0 to IntBuffColl.Count-1 do
      begin
        if IntBuffColl[i] > 0 then  // in 1/100 Sek umrechnen
          IntBuffColl[i] := IntBuffColl[i] * 100;
        ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
        //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
        ZeitRecBuffColl.AddAufRndZeit(IntBuffColl[i]); // Runde 1
        FOrtZeitRecCollArr[wkAbs1].AddItem(ZeitRecBuffColl);
      end;
      //Abs2
      IntBuffColl.Clear;
      if not IntBuffColl.Load then Exit;
      for i:=0 to IntBuffColl.Count-1 do
      begin
        if IntBuffColl[i] > 0 then  // in 1/100 Sek umrechnen
          IntBuffColl[i] := IntBuffColl[i] * 100;
        ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
        //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
        ZeitRecBuffColl.AddAufRndZeit(IntBuffColl[i]); // Runde 1
        FOrtZeitRecCollArr[wkAbs2].AddItem(ZeitRecBuffColl);
      end;
      //Abs3
      IntBuffColl.Clear;
      if not IntBuffColl.Load then Exit;
      for i:=0 to IntBuffColl.Count-1 do
      begin
        if IntBuffColl[i] > 0 then  // in 1/100 Sek umrechnen
          IntBuffColl[i] := IntBuffColl[i] * 100;
        ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
        //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
        ZeitRecBuffColl.AddAufRndZeit(IntBuffColl[i]); // Runde 1
        FOrtZeitRecCollArr[wkAbs3].AddItem(ZeitRecBuffColl);
      end;
      IntBuffColl.Free;
      // Abs4..8
      for AbsCnt:=wkAbs4 to wkAbs8 do
        for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
        begin
          ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
          //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
          ZeitRecBuffColl.AddAufRndZeit(-1); // Runde 1
          FOrtZeitRecCollArr[AbsCnt].AddItem(ZeitRecBuffColl);
        end;

      if (TriDatei.Version.Jahr='2003')and(TriDatei.Version.Nr<'2.0') then
        for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
          FStrafZeitColl.Add(-1);       // sonst in VeranObj laden
      if not FDisqGrundColl.Load then Exit;

      // ab 2004-1.1 werden Ergebnisse nicht mehr gespeichert
      // Load überspringen für:
      // FStaffelVorgColl, FRngMWColl, FRngAkColl,
      // FRngAbs1Coll, FRngAbs2Coll, FRngAbs3Coll,
      // FRngAbs1AkColl, FRngAbs2AkColl, FRngAbs3AkColl,
      // FRngGesColl, FRngSenWkColl, FRngJunWkColl, FRngSerColl,

      // FRngMWAlleWkColl, FRngAkAlleWkColl, FRngAbs1MWAlleWkColl,
      // FRngAbs2MWAlleWkColl, FRngAbs3MWAlleWkColl, FRngAbs1AkAlleWkColl,
      // FRngAbs2AkAlleWkColl, FRngAbs3AkAlleWkColl, FRngGesAlleWkColl,
      // FRngSenAlleWkColl, FRngJunAlleWkColl
      Position := Position + 24 * (4 + TVeranstObj(FVPtr).OrtZahl) * cnSizeOfWord;

      // nicht gespeicherte Collections initialisieren
      for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
      begin
        FAusKonkAltKlColl.Add(false);  // neu 2008-2.0
        FAusKonkSondKlColl.Add(false); // neu 2008-2.0
        FSondWrtgColl.Add(false);      // neu 2005
        FUrkDruckColl.Add(true);
        FKommentColl.AddItem(nil);
        FStaffelVorgColl.Add(-1);
        for AbsCnt:=wkAbs0 to wkAbs8 do
        begin
          for KwCnt:=kwAlle to kwSondKl do
          begin
            FRngCollArr[KwCnt,AbsCnt].Add(0);
            FSwRngCollArr[KwCnt,AbsCnt].Add(0);
            if AbsCnt=wkAbs0 then
            begin
              FSerRngCollArr[KwCnt].Add(0);
              if KwCnt<kwSondKl then
                FMschRngCollArr[KwCnt].Add(0);
            end;
          end;
        end;
        FGutschriftColl.Add(0);    // Gutschrift ab 2008-2.0
        FDisqNameColl.AddItem(nil);
        FStartgeldColl.Add(0);     // ab 2010-0.2
        FReststreckeColl.Add(0);   // ab 2015
      end;

      ReadBuffer(W, cnSizeOfWord); // Dummy, FSeriePunkte := W;
      ReadBuffer(W, cnSizeOfWord); // Dummy, FSerieRang := W;
    end;

  except
    Result := false;
    Exit;
  end;

  Result := true;
end;

(*============================================================================*)
function TTlnObj.Store: Boolean;
(*============================================================================*)
var Buff  : SmallInt;
    LBuff : LongInt;
    i     : Integer;
    Orte,C : SmallInt;
    WBuff : Word;
    AbsCnt : TWkAbschnitt;

begin
  Result := false;
  if not inherited Store then Exit; // BPObjType
  with TriaStream do
  try
    // store allg Strings in Coll
    C := 22;
    WriteBuffer(C,cnSizeOfSmallInt);
    WriteStr(FName);    // Str 1
    WriteStr(FVName);   // Str 2
    WriteStr(FStrasse); // Str 3
    WriteStr(FOrt);     // Str 4
    WriteStr(FLand);    // Str 5
    WriteStr(FHausNr);  // Str 6
    WriteStr(FPLZ);     // Str 7
    WriteStr(FEMail);   // Str 8
    for AbsCnt:=wkabs2 to wkAbs8 do // Str 9..15, ab 10.1.8, nicht 11.1.0
      WriteStr(FNameAbsArr[AbsCnt]);
    for AbsCnt:=wkabs2 to wkAbs8 do  // Str 16..22, ab 10.1.8, nicht 11.1.0
      WriteStr(FVNameAbsArr[AbsCnt]);

    // store allg SmallInt in Coll
    C := 10;
    WriteBuffer(C,cnSizeOfSmallInt);
    Buff := 0;
    //if FSex = cnWeiblich then Buff := Buff OR opSex; Ab 2008-2.0 nicht speichern
    if FSerienWrtg         then Buff := Buff OR opSerienWrtg;
    //if FAusserKonkAllg   then Buff := Buff OR opAusserKonkAllg;
    if FMschWrtg           then Buff := Buff OR opMschWrtg;         // neu 2005
    //if FAusserKonkAltKl  then Buff := Buff OR opAusserKonkAltKl;  // neu 2008
    //if FAusserKonkSondKl then Buff := Buff OR opAusserKonkSondKl;
    if FMschMixWrtg        then Buff := Buff OR opMschMixWrtg;      // neu 11.2.4
    WriteBuffer(Buff,cnSizeOfSmallInt);      // Int 1, Options
    Buff := FJg;
    WriteBuffer(Buff,cnSizeOfSmallInt);      // Int 2
    if FMannschName<>nil
      then Buff:=TVeranstObj(FVPtr).MannschNameColl.SortIndexOf(FMannschName)
      else Buff:=-1;
    WriteBuffer(Buff, cnSizeOfSmallInt);     // Int 3
    if FSMld<>nil then Buff := TVeranstObj(FVPtr).SMldColl.IndexOf(FSMld)
                  else Buff := -1;
    WriteBuffer(Buff, cnSizeOfSmallInt);     // Int 4
    if FWettk<>nil then Buff := TVeranstObj(FVPtr).WettkColl.IndexOf(FWettk)
                   else Buff := -1;
    WriteBuffer(Buff, cnSizeOfSmallInt);     // Int 5
    LBuff := FBearbeitet.Date shr 16;
    Buff := LBuff;
    WriteBuffer(Buff, cnSizeOfSmallInt);     // Int 6
    LBuff := FBearbeitet.Date shl 16;
    LBuff := LBuff shr 16;
    WBuff := LBuff; // > 32k möglich
    WriteBuffer(WBuff, cnSizeOfSmallInt);     // Int 7
    LBuff := FBearbeitet.Time shr 16;
    Buff := LBuff;
    WriteBuffer(Buff, cnSizeOfSmallInt);     // Int 8
    LBuff := FBearbeitet.Time shl 16;
    LBuff := LBuff shr 16;
    WBuff := LBuff; // > 32k möglich
    WriteBuffer(WBuff, cnSizeOfSmallInt);     // Int 9
    Buff := SmallInt(FSex);
    WriteBuffer(Buff,cnSizeOfSmallInt);       // Int 10, ab 2008-1.5

    // store allg LongInt in Coll
    C := 0;
    WriteBuffer(C,cnSizeOfSmallInt);

    // store Ort Collections, momentan nur pro Ort
    Orte := TVeranstObj(FVPtr).OrtZahl;
    WriteBuffer(Orte,cnSizeOfSmallInt);
    for i:=0 to Orte-1 do
    begin
      // store Strings pro Ort in Coll
      C := 2; // momentan für alle Orte gleich
      WriteBuffer(C,cnSizeOfSmallInt);
      WriteStr(' ');                   // Str 1,Dummy statt MldZeit ab 2006
      WriteStr(FKommentColl[i]);       // neu 2005

      // store SmallInt pro Ort in Coll
      C := 6; // neu 2008
      WriteBuffer(C,cnSizeOfSmallInt);
      Buff := FSnrColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);    // SmallInt 1
      if FSGrpColl[i] <> nil then
        Buff := FSGrpColl.Collection.IndexOf(FSGrpColl[i])
      else Buff := -1;
      WriteBuffer(Buff,cnSizeOfSmallInt);    // SmallInt 2
      Buff := FStrtBahnColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);    // SmallInt 3
      if FDisqGrundColl[i] <> nil then
        Buff := FDisqGrundColl.Collection.IndexOf(FDisqGrundColl[i])
      else Buff := -1;
      WriteBuffer(Buff,cnSizeOfSmallInt);    // SmallInt 4
      Buff := 0;                                              // neu 2005
      if FSondWrtgColl[i]      then Buff := Buff OR opSondWrtg;   // neu 2005
      if FUrkDruckColl[i]      then Buff := Buff OR opUrkDruck;   // neu 2005
      if FAusKonkAllgColl[i]   then Buff := Buff OR opAusKonkAllg;   // neu 2008-2.0
      if FAusKonkAltKlColl[i]  then Buff := Buff OR opAusKonkAltKl;  // neu 2008-2.0
      if FAusKonkSondKlColl[i] then Buff := Buff OR opAusKonkSondKl; // neu 2008-2.0
      WriteBuffer(Buff,cnSizeOfSmallInt);    // SmallInt 5    // neu 2005
      if FDisqNameColl[i] <> nil then // neu 2008-2.0
        Buff := FDisqNameColl.Collection.IndexOf(FDisqNameColl[i])
      else Buff := -1;
      WriteBuffer(Buff,cnSizeOfSmallInt); // SmallInt 6

      // store LongInt pro Ort in Coll
      C := 5; // 2008-2.0: Rundenzeiten in Coll und Gutschrift
      WriteBuffer(C,cnSizeOfSmallInt);
      LBuff := FMldZeitColl[i];
      WriteBuffer(LBuff,cnSizeOfLongInt);      // Int 1
      LBuff := FStrafZeitColl[i];
      WriteBuffer(LBuff,cnSizeOfLongInt);      // Int 2
      LBuff := FGutschriftColl[i];
      WriteBuffer(LBuff,cnSizeOfLongInt);      // Int 3
      LBuff := FStartgeldColl[i];
      WriteBuffer(LBuff,cnSizeOfLongInt);      // Int 4  ab 2010-0.2
      LBuff := FReststreckeColl[i];
      WriteBuffer(LBuff,cnSizeOfLongInt);      // Int 5  ab 2015
      // Store RundenZeiten
      C := 8; // 8 Abschnitte
      WriteBuffer(C,cnSizeOfSmallInt);
      for AbsCnt:=wkAbs1 to wkAbs8 do
        if not FOrtZeitRecCollArr[AbsCnt].GetColl(i).Store then Exit;
    end;

  except
    Result := false;
    Exit;
  end;
  Result := true;
end;
(*============================================================================*)
procedure TTlnObj.SortAdd;
(*============================================================================*)
// DummyTln wird bei SortAdd/Remove ignoriert
begin
  if (GetIndex >= 0) and not Dummy then FCollection.AddSortItem(Self);
end;

(*============================================================================*)
procedure TTlnObj.SortRemove;
(*============================================================================*)
begin
  if (FCollection <> nil) and not Dummy then FCollection.ClearSortItem(Self);
end;

(*============================================================================*)
procedure TTlnObj.OrtCollAdd;
(*============================================================================*)
var ZeitRecBuffColl : TZeitRecColl;
    AbsCnt : TWkAbschnitt;
    KwCnt : TKlassenWertung;
begin
  FAusKonkAllgColl.Add(false);
  FAusKonkAltKlColl.Add(false);
  FAusKonkSondKlColl.Add(false);
  FSondWrtgColl.Add(false);
  FUrkDruckColl.Add(true);
  FSnrColl.Add(0);
  FSGrpColl.AddItem(nil);
  FStrtBahnColl.Add(0);
  FMldZeitColl.Add(-1);
  FStartgeldColl.Add(0);
  FKommentColl.AddItem(nil);
  FGutschriftColl.Add(0);
  FStrafZeitColl.Add(-1);
  FDisqGrundColl.AddItem(nil);
  FDisqNameColl.AddItem(nil);
  FReststreckeColl.Add(0);
  FStaffelVorgColl.Add(-1);

  for AbsCnt:=wkAbs0 to wkAbs8 do
  begin
    for KwCnt:=kwAlle to kwSondKl do
    begin
      FRngCollArr[KwCnt,AbsCnt].Add(0);
      FSwRngCollArr[KwCnt,AbsCnt].Add(0);
      if AbsCnt=wkAbs0 then
      begin
        FSerRngCollArr[KwCnt].Add(0);
        if KwCnt<kwSondKl then
          FMschRngCollArr[KwCnt].Add(0);
      end;
    end;
    if AbsCnt > wkAbs0 then
    begin
      ZeitRecBuffColl := TZeitRecColl.Create(FVPtr);
      //ZeitRecBuffColl.AddAufRndZeit(-1); // Startzeit
      ZeitRecBuffColl.AddAufRndZeit(-1); // Runde 1
      FOrtZeitRecCollArr[AbsCnt].AddItem(ZeitRecBuffColl);
    end;
  end;
end;

(*============================================================================*)
procedure TTlnObj.OrtCollClear(Indx:Integer);
(*============================================================================*)
var AbsCnt : TWkAbschnitt;
    KwCnt : TKlassenWertung;
begin
  if (Indx<0) or (Indx>FSnrColl.Count-1) then Exit;
  FAusKonkAllgColl.ClearIndex(Indx);
  FAusKonkAltKlColl.ClearIndex(Indx);
  FAusKonkSondKlColl.ClearIndex(Indx);
  FSondWrtgColl.ClearIndex(Indx);
  FUrkDruckColl.ClearIndex(Indx);
  FSnrColl.ClearIndex(Indx);
  FSGrpColl.ClearIndex(Indx);
  FStrtBahnColl.ClearIndex(Indx);
  FMldZeitColl.ClearIndex(Indx);
  FStartgeldColl.ClearIndex(Indx);
  FKommentColl.ClearIndex(Indx);
  FGutschriftColl.ClearIndex(Indx);
  FStrafZeitColl.ClearIndex(Indx);
  FDisqGrundColl.ClearIndex(Indx);
  FDisqNameColl.ClearIndex(Indx);
  FReststreckeColl.ClearIndex(Indx);
  FStaffelVorgColl.ClearIndex(Indx);
  for AbsCnt:=wkAbs0 to wkAbs8 do
  begin
    for KwCnt:=kwAlle to kwSondKl do
    begin
      FRngCollArr[KwCnt,AbsCnt].ClearIndex(Indx);
      FSwRngCollArr[KwCnt,AbsCnt].ClearIndex(Indx);
      if AbsCnt=wkAbs0 then
      begin
        FSerRngCollArr[KwCnt].ClearIndex(Indx);
        if KwCnt<kwSondKl then
          FMschRngCollArr[KwCnt].ClearIndex(Indx);
      end;
    end;
    if AbsCnt > wkAbs0 then
      FOrtZeitRecCollArr[AbsCnt].ClearIndex(Indx);
  end;
end;

(*============================================================================*)
procedure TTlnObj.OrtCollExch(Idx1,Idx2:Integer);
(*============================================================================*)
var AbsCnt : TWkAbschnitt;
    KwCnt : TKlassenWertung;
begin
  FAusKonkAllgColl.List.Exchange(Idx1,Idx2);
  FAusKonkAltKlColl.List.Exchange(Idx1,Idx2);
  FAusKonkSondKlColl.List.Exchange(Idx1,Idx2);
  FSondWrtgColl.List.Exchange(Idx1,Idx2);
  FUrkDruckColl.List.Exchange(Idx1,Idx2);
  FSnrColl.List.Exchange(Idx1,Idx2);
  FSGrpColl.List.Exchange(Idx1,Idx2);
  FStrtBahnColl.List.Exchange(Idx1,Idx2);
  FMldZeitColl.List.Exchange(Idx1,Idx2);
  FStartgeldColl.List.Exchange(Idx1,Idx2);
  FKommentColl.List.Exchange(Idx1,Idx2);
  FGutschriftColl.List.Exchange(Idx1,Idx2);
  FStrafZeitColl.List.Exchange(Idx1,Idx2);
  FDisqGrundColl.List.Exchange(Idx1,Idx2);
  FDisqNameColl.List.Exchange(Idx1,Idx2);
  FReststreckeColl.List.Exchange(Idx1,Idx2);
  FStaffelVorgColl.List.Exchange(Idx1,Idx2);

  for AbsCnt:=wkAbs0 to wkAbs8 do
  begin
    for KwCnt:=kwAlle to kwSondKl do
    begin
      FRngCollArr[KwCnt,AbsCnt].List.Exchange(Idx1,Idx2);
      FSwRngCollArr[KwCnt,AbsCnt].List.Exchange(Idx1,Idx2);
      if AbsCnt=wkAbs0 then
      begin
        FSerRngCollArr[KwCnt].List.Exchange(Idx1,Idx2);
        if KwCnt<kwSondKl then
          FMschRngCollArr[KwCnt].List.Exchange(Idx1,Idx2);
      end;
    end;
    if AbsCnt > wkAbs0 then
      FOrtZeitRecCollArr[AbsCnt].List.Exchange(Idx1,Idx2);
  end;
end;

(*============================================================================*)
procedure TTlnObj.SetTlnAllgDaten(NameNeu,VNameNeu:String;
                                  NameArrNeu,
                                  VNameArrNeu:TNameArr;
                                  StrasseNeu,HausNrNeu,
                                  PLZNeu,OrtNeu,EMailNeu : String;
                                  SexNeu: TSex; JgNeu: Integer; LandNeu:String;
                                  MannschNameNeu : String;
                                  SMldNeu        : TSMldObj;
                                  WettkNeu       : TWettkObj;
                                  SerienWrtgNeu ,
                                  MschWrtgNeu,
                                  MschMixWrtgNeu : Boolean);
(*============================================================================*)
var AbsCnt : TWkAbschnitt;
begin
  SetName(NameNeu);
  SetVName(VNameNeu);
  for AbsCnt:=wkAbs2 to wkAbs8 do
  begin
    SetStaffelName(AbsCnt,NameArrNeu[AbsCnt]);
    SetStaffelVName(AbsCnt,VNameArrNeu[AbsCnt]);
  end;
  SetStrasse(StrasseNeu);
  SetHausNr(HausNrNeu);
  SetPLZ(PLZNeu);
  SetOrt(OrtNeu);
  SetEMail(EMailNeu); // ab 2010-0.2
  SetSex(SexNeu); // 25.12
  SetJg(JgNeu);   // 25.12
  SetLand(LandNeu);
  SetWettk(WettkNeu);
  SetMannschName(MannschNameNeu);
  SetSMld(SMldNeu);
  SetSerienWrtg(SerienWrtgNeu);
  SetMschWrtg(MschWrtgNeu);
  SetMschMixWrtg(MschMixWrtgNeu);
end;

(*============================================================================*)
procedure TTlnObj.SetTlnOrtDaten(SnrNeu             : Integer;
                                 SGrpNeu            : TSGrpObj;
                                 StrtBahnNeu,
                                 MldZeitNeu,
                                 StartgeldNeu       : Integer;
                                 KommentNeu         : String;
                                 ZeitRecCollArrNeu  : TZeitRecCollArr;
                                 GutschriftNeu      : Integer;
                                 StrafZeitNeu,
                                 ReststreckeNeu     : Integer;
                                 DisqGrundNeu,
                                 DisqNameNeu        : String;
                                 AusKonkAllgNeu,
                                 AusKonkAltKlNeu,
                                 AusKonkSondKlNeu,
                                 SondWrtgNeu,
                                 UrkDruckNeu        : Boolean);
(*============================================================================*)
// für aktuellen OrtIndex
begin
  SetSnr(SnrNeu);
  SetSGrp(SGrpNeu);
  SetStrtBahn(StrtBahnNeu);
  SetMldZeit(MldZeitNeu);
  SetStartgeld(StartgeldNeu);
  SetKomment(KommentNeu);
  SetZeitRecCollArr(ZeitRecCollArrNeu);
  SetGutschrift(GutschriftNeu);
  SetStrafZeit(StrafZeitNeu);
  SetDisqGrund(DisqGrundNeu);
  SetDisqName(DisqNameNeu);
  SetReststrecke(ReststreckeNeu);
  SetAusKonkAllg(AusKonkAllgNeu); // 2008-2.0
  SetAusKonkAltKl(AusKonkAltKlNeu);
  SetAusKonkSondKl(AusKonkSondKlNeu);
  SetSondWrtg(SondWrtgNeu);
  SetUrkDruck(UrkDruckNeu);
end;

(*============================================================================*)
function TTlnObj.MannschPtr(AkWrtg:TklassenWertung): Pointer;
(*============================================================================*)
begin
  case AkWrtg of
    kwAlle   : Result := MannschAllePtr;
    kwSex    : Result := MannschSexPtr;
    kwAltKl  : Result := MannschAkPtr;
    else       Result := nil;
  end;
end;

(*============================================================================*)
function TTlnObj.GetJgStr2: String;
(*============================================================================*)
begin
  Result := Strng(FJg MOD 100,2);
end;

(*============================================================================*)
procedure TTlnObj.ClearStaffelVorg;
(*============================================================================*)
var i : Integer;
begin
  SortRemove;
  for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do FStaffelVorgColl[i] := -1;
  SortAdd;
end;

(*============================================================================*)
function TTlnObj.NameVName: String;
(*============================================================================*)
(* Name und Vorname zusammenfassen aus Platzgründen *)
begin
  if FName<>'' then Result := FName+', '+FVName
               else Result := '';
end;

(*============================================================================*)
function TTlnObj.NameVNameKurz: String;
(*============================================================================*)
(* ohne Blank nach Komma aus Platzgründen *)
begin
  if FName<>'' then Result := FName+','+FVName
               else Result := '';
end;

(*============================================================================*)
function TTlnObj.VNameName: String;
(*============================================================================*)
(*Name und Vorname zusammenfassen aus Platzgründen *)
begin
  Result := FVName + ' ' + FName;
end;

(*============================================================================*)
function TTlnObj.StaffelNameVName(Abs:TWkAbschnitt): String;
(*============================================================================*)
(* Name und Vorname zusammenfassen aus Platzgründen *)
begin
  if GetStaffelName(Abs) <> '' then
  begin
    Result := GetStaffelName(Abs);
    if GetStaffelVName(Abs) <> '' then Result := Result+','+GetStaffelVName(Abs);
  end
  else Result := '';
end;

(*============================================================================*)
function TTlnObj.StaffelVNameName(Abs:TWkAbschnitt): String;
(*============================================================================*)
(* Name und Vorname zusammenfassen für Urkunden *)
begin
  if GetStaffelName(Abs) <> '' then
  begin
    Result := GetStaffelName(Abs);
    if GetStaffelVName(Abs) <> '' then
      Result := GetStaffelVName(Abs) + ' ' + Result;
  end
  else Result := '';
end;

(*============================================================================*)
function TTlnObj.GetAlter :Integer;
(*============================================================================*)
// alter fehlt: result = 0
begin
  Result := FWettk.GetTlnAlter(Jg);
end;

//==============================================================================
function TTlnObj.WertungsKlasse(AkWrtg:TKlassenWertung;TM:TTlnMsch): TAkObj;
//==============================================================================
begin
  Result := AkUnbekannt;
  case TM of
    tmTln : if AkWrtg < kwKein   then Result := FWertgKlasseArr[AkWrtg];
    tmMsch: if AkWrtg < kwSondKl then Result := FMschWertgKlasseArr[AkWrtg];
  end;
end;

(*============================================================================*)
function TTlnObj.TlnInKlasse(Klasse:TAkObj;TM:TTlnMsch): Boolean;
(*============================================================================*)
// Klasse in unterschiedliche Collections unabhängig gespeichert, daher direkter
// Pointer-Vergleich nur in gleiche Collection möglich
// Klasse,FAltKlasse,FSondKlasse nie = nil
// für Msch.TlnListe MschWrtg und MschMixWrtg berücksichtigen
begin
  Result := false;
  case Klasse.Wertung of
    kwAlle   : Result := (TM = tmTln) or MschWrtg;
    kwSex    : if TM = tmTln then
                 Result := FSex = Klasse.Sex // bei TlnStaffel auch FSex=cnMixed
               else
                 Result := MschWrtg and
                           ((FSex = Klasse.Sex) and not MschMixWrtg or
                            (Klasse.Sex=cnMixed) and MschMixWrtg); // unabhängig von FSex
    kwAltKl  : Result := ((TM = tmTln) or MschWrtg) and
                         (FSex = Klasse.Sex) and
                         (GetAlter >= Klasse.AlterVon) and
                         (GetAlter <= Klasse.AlterBis);
    kwSondKl : Result := (TM = tmTln) and // nicht bei Msch
                         (FSex = Klasse.Sex) and
                         (GetAlter >= Klasse.AlterVon) and
                         (GetAlter <= Klasse.AlterBis);
  end;
end;

(*============================================================================*)
function TTlnObj.TlnInStatus(Status:TStatus): Boolean;
(*============================================================================*)
begin
  Result := TlnInOrtStatus(TVeranstObj(FVPtr).OrtIndex,Status);
end;

(*============================================================================*)
function TTlnObj.TlnInOrtStatus(Indx:Integer; Status:TStatus): Boolean;
(*============================================================================*)
var AbsCnt : TWkAbschnitt;
begin
  Result := false;
  if Indx < 0 then Exit; // Funktion nur pro Ort, Indx = -1 nicht erlaubt

  case Status of
    stGemeldet: Result := true; // für alle Orte gleich

    stSerGemeldet: Result := FSerienWrtg; // für alle Orte gleich

    stEingeteilt:  // Snr>0 sollte reichen, SBhn > 0 wenn StrtBahnen definiert
      Result := (FSGrpColl[Indx] <> nil) and (FSnrColl[Indx] > 0) and
                ((FWettk.OrtStartBahnen[Indx]=0) or (FStrtBahnColl[Indx]>0));

    stZeitVorhanden:// mindestens eine Zeit eingelesen,auch Disq,auch SBhn=0,nur anTlnUhrZeit
      if (FSGrpColl[Indx] <> nil) and (FSnrColl[Indx] > 0) then  // auch mit ungültiger Startzeit
        for AbsCnt:= wkAbs1 to TWkAbschnitt(FWettk.OrtAbschnZahl[Indx]) do
          if AbsRundeStoppZeit(Indx,AbsCnt,1) >= 0 then
          begin
            Result := true;
            Exit;
          end;

    stAbs1Zeit..stAbs8Zeit: // mindestens eine Zeit in Abs eingelesen,auch Disq,auch SBhn=0,nur anTlnRndKntrl
      Result := (FSGrpColl[Indx] <> nil) and (FSnrColl[Indx] > 0) and
                //(StrtZeit(TWkAbschnitt(Integer(Status)-Integer(stAbs1Zeit)+1)) >= 0) and
                (AbsRundeStoppZeit(Indx,TWkAbschnitt(Integer(Status)-Integer(stAbs1Zeit)+1),1) >= 0);

    stAbs1Start..stAbs8Start:// mindestens insgesamt eine gültige Zeit eingelesen, auch Disq, SBhn=gültig
      if (FSGrpColl[Indx] <> nil) and (FSnrColl[Indx] > 0) and
         (StrtZeit(Indx,TWkAbschnitt(Integer(Status)-Integer(stAbs1Start)+1)) >= 0) and
         ((FWettk.OrtStartBahnen[Indx]=0) or (FStrtBahnColl[Indx]>0)) then
        for AbsCnt:= TWkAbschnitt(Integer(Status)-Integer(stAbs1Start)+1) to
                     TWkAbschnitt(FWettk.OrtAbschnZahl[Indx]) do
          if (FWettk.OrtAbschnZahl[Indx] >= Integer(AbsCnt)) and
             (AbsRundeStoppZeit(Indx,AbsCnt,1) >= 0) then
          begin
            Result := true;
            Exit;
          end;

    stAbs1Ziel..stAbs7Ziel: // mit disq. tln, stAbs8Ziel=stImZiel
      for AbsCnt:= TWkAbschnitt(Integer(Status)-Integer(stAbs1Ziel)+1) to
                   TWkAbschnitt(FWettk.OrtAbschnZahl[Indx]) do
        if AbsZeit(Indx,AbsCnt) > 0 then // nur mit gültigen Startzeiten
        //if StoppZeit(Indx,AbsCnt) > 0 then
        begin
          Result := true;
          Exit;
        end;

    stAbs1UhrZeit..stAbs8UhrZeit: // StoppZeit Abschnitt gültig, unabhängig von Startzeit
      if StoppZeit(Indx,TWkAbschnitt(Integer(Status)-Integer(stAbs1UhrZeit)+1)) > 0 then
      begin
        Result := true;
        Exit;
      end;

    stImZiel:   // gültige Endzeit, mit disq. Tln, nur mit gültigen Startzeiten
      if (FWettk.OrtWettkArt[Indx] = waRndRennen) or
         (FWettk.OrtWettkArt[Indx] = waStndRennen) then // nur 1 Abschn.
        Result := AbsRundenZeit(Indx,wkAbs1,1) > 0 // mindestens 1 Runde
      else
        Result := AbsZeit(Indx,TWkAbschnitt(FWettk.OrtAbschnZahl[Indx])) > 0;
      //Result := StoppZeit(Indx,TWkAbschnitt(FWettk.OrtAbschnZahl[Indx])) > 0;

    stEndUhrZeit: // Gültige Endzeit ohne Disq - unabhängig von StZeit
      Result := (StoppZeit(Indx,TWkAbschnitt(FWettk.OrtAbschnZahl[Indx])) > 0) and
                (FDisqGrundColl[Indx] = nil);

    stDisqualifiziert:
      Result := FDisqGrundColl[Indx] <> nil;

    stGewertet: // gültige Endzeit, ohne disq. Tln
      if FDisqGrundColl[Indx] = nil then
        if (FWettk.OrtWettkArt[Indx] = waRndRennen) or
           (FWettk.OrtWettkArt[Indx] = waStndRennen) then
          Result := AbsRundenZeit(Indx,wkAbs1,1) > 0 // mindestens 1 Runde
        else
          Result := AbsZeit(Indx,TWkAbschnitt(FWettk.OrtAbschnZahl[Indx])) > 0;

    stGewertetDisq: // gültige Endzeit, mit allen disq. Tln
    begin
      Result := FDisqGrundColl[Indx] <> nil; // Disq Tln
      if not Result then // gewertete Tln
        if (FWettk.OrtWettkArt[Indx] = waRndRennen) or
           (FWettk.OrtWettkArt[Indx] = waStndRennen) then // nur 1 Abschn.
          Result := AbsRundenZeit(Indx,wkAbs1,1) > 0 // mindestens 1 Runde
        else
          Result := AbsZeit(Indx,TWkAbschnitt(FWettk.OrtAbschnZahl[Indx])) > 0;
    end;
    
    stSerWertung:
      if Collection <> nil then
        Result := GetSerieWrtg(TTlnColl(Collection).FSortAkWrtg);

    stSerEndWertung:
      if Collection <> nil then
        Result := GetSerieEndWrtg(TTlnColl(Collection).FSortAkWrtg);

    stBahn1..stBahn16:
      Result := FStrtBahnColl[Indx] = Integer(Status)-Integer(stBahn1) + 1;

    //else Result := false;
  end;
end;

//==============================================================================
function TTlnObj.GetZeitRecColl(OrtIndx:Integer;Abs:TWkAbschnitt):TZeitRecColl;
//==============================================================================
// Abs > wkAbs0, keine überprüfung
begin
  Result := FOrtZeitRecCollArr[Abs].GetColl(OrtIndx)
end;

//==============================================================================
function TTlnObj.GetZeitRecColl(Abs:TWkAbschnitt):TZeitRecColl;
//==============================================================================
begin
  Result := GetZeitRecColl(TVeranstObj(FVPtr).OrtIndex,Abs);
end;

//==============================================================================
function TTlnObj.GetZeitRecCollArr: TZeitRecCollArr;
//==============================================================================
var AbsCnt : TWkAbschnitt;
begin
  for AbsCnt:=wkAbs1 to wkAbs8 do
    Result[AbsCnt] := GetZeitRecColl(TVeranstObj(FVPtr).OrtIndex,AbsCnt);
end;

//==============================================================================
procedure TTlnObj.SetZeitRecCollArr(ZeitRecCollArrNeu:TZeitRecCollArr);
//==============================================================================
// AufRndZeit übernommen,  ErfZeit := -1, wenn AufRndZeit geändert
var i : Integer;
    Coll : TZeitRecColl;
    AbsCnt : TWkAbschnitt;
begin
  SortRemove;
  if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
    SetWettkErgModified;

  for AbsCnt:=wkAbs1 to wkAbs8 do
  begin
    Coll := GetZeitRecColl(TVeranstObj(FVPtr).OrtIndex,AbsCnt);
    Coll.Clear;
    for i:=0 to FWettk.AbschnRunden[AbsCnt] do
      if (ZeitRecCollArrNeu[AbsCnt] <> nil) and (i < ZeitRecCollArrNeu[AbsCnt].Count) then
        Coll.AddAufRndZeit(TZeitRec(ZeitRecCollArrNeu[AbsCnt][i]).AufRndZeit)
      else Coll.AddAufRndZeit(-1);
  end;

  for AbsCnt:=wkAbs1 to wkAbs8 do
    SetStrtZeit(AbsCnt);

  if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
    SetWettkErgModified;
  SortAdd;
end;

//==============================================================================
procedure TTlnObj.SetZeitRecCollArr(Abs:TWkAbschnitt;ZeitRecCollNeu:TZeitRecColl);
//==============================================================================
// Abs > wkAbs0, keine überprüfung
// AufRndZeit übernommen,  ErfZeit := -1, wenn AufRndZeit geändert
var i : Integer;
    Coll : TZeitRecColl;
    AbsCnt : TWkAbschnitt;
begin
  SortRemove;
  if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
    SetWettkErgModified;

  Coll := GetZeitRecColl(TVeranstObj(FVPtr).OrtIndex,Abs);
  Coll.Clear;
  for i:=0 to FWettk.AbschnRunden[Abs] do
    if (ZeitRecCollNeu <> nil) and (i < ZeitRecCollNeu.Count) then
      Coll.AddAufRndZeit(TZeitRec(ZeitRecCollNeu[i]).AufRndZeit){
    else Coll.AddAufRndZeit(-1)};

  for AbsCnt:=Abs to wkAbs8 do
    SetStrtZeit(AbsCnt);

  if (FVPtr=Veranstaltung) and (FWettk<>nil) and (CollectionIndex >= 0) then
    SetWettkErgModified;
  SortAdd;
end;

//==============================================================================
procedure TTlnObj.ClearZeitRecCollArr;
//==============================================================================
var AbsCnt : TWkAbschnitt;
    Arr : TZeitRecCollArr;
begin
  for AbsCnt:=wkAbs1 to wkAbs8 do Arr[AbsCnt] := nil;
  SetZeitRecCollArr(Arr);
end;

//==============================================================================
procedure TTlnObj.ClearZeitRecCollArr(Abs:TWkAbschnitt);
//==============================================================================
// Abs > wkAbs0, keine überprüfung
begin
  SetZeitRecCollArr(Abs,nil);
end;

//==============================================================================
procedure TTlnObj.CopyZeitRecCollArr(Tln:TTlnObj);
//==============================================================================
begin
  if Tln=nil then ClearZeitRecCollArr
             else SetZeitRecCollArr(Tln.GetZeitRecCollArr);
end;

{//==============================================================================
procedure TTlnObj.CopyOrtZeitRecColl(Abs:TWkAbschnitt;Tln:TTlnObj);
//==============================================================================
var Coll : TZeitSortColl;
begin
  if Tln=nil then Coll := nil
  else Coll := Tln.GetOrtZeitRecColl(TVeranstObj(FVPtr).OrtIndex,Abs);
  SetOrtZeitRecColl(TVeranstObj(FVPtr).OrtIndex,Abs,Coll);
end;}

//==============================================================================
procedure TTlnObj.SetStrtZeit(Abs:TWkAbschnitt);
//==============================================================================
// Abs > wkAbs0, keine überprüfung
// Startzeit für Abs > 0 setzen
// SGrp muß assigned und SGrp.Startzeit definiert sein
// wenn Startbahnen definiert, muss Bahn zugeordnet sein
// auf gültige frühere Abs-Zeiten prüfen
// 00:00:00 ist gültige Sartzeit, StartZeit=-1 wenn ungültig

var VorgTln  : array [0..cnAbsZahlMax] of TTlnObj;
    VorgIndx : array [0..cnAbsZahlMax] of Integer;
    i, StZeitNeu, Abs_1Zeit, Abs_1StZeit: Integer;
    SG : TSGrpObj;
    Abs_1,AbsCnt : TWkAbschnitt;

begin
  StZeitNeu := -1; // ungültige Uhrzeit vordefinieren
  if (FWettk <> nil) and (GetSnr > 0) and
     ((FWettk.StartBahnen=0) or (FStrtBahnColl[TVeranstObj(FVPtr).OrtIndex]>0)) and
     (FWettk.AbschnZahl >= Integer(Abs)) then
  begin
    SG := GetSGrp;
    Abs_1 := TWkAbschnitt(Integer(Abs)-1); // nur für Abs > wkAbs1
    if (SG<>nil) and (Abs=wkAbs1) and
       (SG.StartModus[wkAbs1]=stOhnePause) then Exit; // keine Aktion, EinzelStart
    if SG <> nil then
    begin
      if Abs > wkAbs1 then Abs_1StZeit := StrtZeit(Abs_1)
                      else Abs_1StZeit := SG.Startzeit[wkAbs1];
      if Abs_1StZeit >= 0 then
      begin
        if Abs > wkAbs1 then Abs_1Zeit := AbsZeit(Abs_1)
                        else Abs_1Zeit := 0;

        case FWettk.WettkArt of

          waMschTeam: //nur kwAlle
            if (FLoadPtr<>nil)and(TTlnObj(FLoadPtr).CollectionIndex>=0) and
               (TTlnObj(FLoadPtr).MannschAllePtr<>nil) then
              if Abs = wkAbs1 then
                StZeitNeu := TMannschObj(TTlnObj(FLoadPtr).MannschAllePtr).MschAbsStZeit[Abs]
              else
              if SG.StartModus[Abs] <> stOhnePause then
                if Abs_1Zeit > 0 then
                  StZeitNeu := TMannschObj(TTlnObj(FLoadPtr).MannschAllePtr).MschAbsStZeit[Abs]
                else
                  StZeitNeu := -1 // bei stOhnePause muss vorhergehender AbsZeit gültig sein
              else // AbsCnt > 1 und stOhnePause
                StZeitNeu := Abs_1StZeit + Abs_1Zeit;

          waMschStaffel: // nur kwAlle
            // jeder MschTln bestreitet alle WettkAbschn
            // für MschGr bis 8 kann Pause definiert werden in MschAbsStZeit
            // für > 8 Tln gilt immer Start OhnePause
            if (FLoadPtr<>nil)and(TTlnObj(FLoadPtr).CollectionIndex>=0)and
               (TTlnObj(FLoadPtr).MannschAllePtr<>nil) then
              if Abs = wkAbs1 then // Startzeit abhängig von Staffelvorgänger
              begin
                // MschZeiten müssen vorher gesetzt sein
                // Self nicht benutzen weil sonst Zeitberechnung für TlnBuff in TlnDlg
                // nicht funktioniert
                VorgTln[0]  := FLoadPtr;
                VorgIndx[0] := FCollection.IndexOf(VorgTln[0]);
                if VorgIndx[0] < 0 then // Vorg[0] muss in Collection sein
                  StZeitNeu := TMannschObj(TTlnObj(FLoadPtr).MannschAllePtr).MschAbsStZeit[wkAbs1]
                else
                begin
                  i := 1;
                  repeat
                    // prüfen ob i. StaffelTln
                    VorgIndx[i] := VorgTln[i-1].GetStaffelVorg;
                    if VorgIndx[i] < 0 then // Vorgänger muss gültiger Indx haben
                    begin
                      StZeitNeu := TMannschObj(TTlnObj(FLoadPtr).MannschAllePtr).MschAbsStZeit[wkAbs1];
                      Break;
                    end else
                    begin
                      VorgTln[i] := TTlnObj(FCollection[VorgIndx[i]]);
                      if VorgTln[i] = VorgTln[i-1] then // i. Tln
                      begin
                        if FWettk.MschGroesse[cnSexBeide] >= i then
                          StZeitNeu := TMannschObj(TTlnObj(FLoadPtr).MannschAllePtr).MschAbsStZeit[TWkAbschnitt(i)]
                        else
                          StZeitNeu := VorgTln[1].StoppZeit;
                        Break;
                      end else
                        Inc(i);
                    end;
                  until i > cnAbsZahlMax;

                  if i > cnAbsZahlMax then // StoppZeit von Vorg gilt immer als StartZeit
                    StZeitNeu := VorgTln[1].StoppZeit;
                end;
              end else // Abs > 1
                StZeitNeu := Abs_1StZeit + Abs_1Zeit; // alle Abschn ohne Pause

          else // EinzelWettk:
            case SG.StartModus[Abs] of
              stOhnePause: // nur für AbsCnt > 1
                StZeitNeu := Abs_1StZeit + Abs_1Zeit;// bei Zeit=0 gilt StZeit
              stMassenStart:
                if (Abs = wkAbs1) or (Abs_1Zeit > 0) then
                  StZeitNeu := SG.StartZeit[Abs];
              stJagdStart:
                if Abs = wkAbs1 then
                  StZeitNeu := SG.StartZeit[wkAbs1] + (GetSnr - SG.StartnrVon) * SG.Start1Delta
                else // > wkAbs1
                  if (Abs_1Zeit > 0) and
                     (SG.StartZeit[Abs] >= 0) and (SG.ErstZeit[Abs_1] > 0) then
                  begin
                    // Summe über alle vorangegangene Abs bestimmt Startzeit
                    if Abs_1 > wkAbs1 then
                      for AbsCnt:=wkAbs1 to TWkAbschnitt(Integer(Abs_1)-1) do
                        Abs_1Zeit := Abs_1Zeit + AbsZeit(AbsCnt);
                    if SG.StartZeit[Abs] + Abs_1Zeit >= SG.ErstZeit[Abs_1] then
                      StZeitNeu := SG.StartZeit[Abs] + Abs_1Zeit - SG.ErstZeit[Abs_1]
                    else
                      StZeitNeu := cnZeit24_00 + SG.StartZeit[Abs] + Abs_1Zeit - SG.ErstZeit[Abs_1];
                  end;
            end;
        end;
      end;
    end;
  end;

  while StZeitNeu >= cnZeit24_00 do StZeitNeu := StZeitNeu - cnZeit24_00;
  SetStoppZeit(Abs,0,StZeitNeu);
end;

//==============================================================================
function TTlnObj.StrtZeit(OrtIndx:Integer;Abs:TWkAbschnitt): Integer;
//==============================================================================
// Abs > wkAbs0, keine überprüfung
// Startzeit muss vorher in OrtZeitRecColl gesetzt sein
begin
  Result := GetZeitRecColl(OrtIndx,Abs).GetAufRndZeit(0);
end;

//==============================================================================
function TTlnObj.StrtZeit(Abs:TWkAbschnitt): Integer;
//==============================================================================
begin
  Result := StrtZeit(TVeranstObj(FVPtr).OrtIndex,Abs);
end;

//==============================================================================
function TTlnObj.SetZtErfZeit(OrtIndx:Integer;Abs:TWkAbschnitt;Indx,Zeit:Integer): Integer;
//==============================================================================
// Abs > wkAbs0, keine überprüfung
begin
  Result := GetZeitRecColl(OrtIndx,Abs).SetErfZeit(Indx,Zeit);
end;

//==============================================================================
function TTlnObj.SetZtErfZeit(Abs:TWkAbschnitt;Indx,Zeit:Integer): Integer;
//==============================================================================
begin
  Result := SetZtErfZeit(TVeranstObj(FVPtr).OrtIndex,Abs,Indx,Zeit);
end;

//==============================================================================
function TTlnObj.AbsZeitEingelesen(Abs:TWkAbschnitt;Zeit:Integer): Boolean;
//==============================================================================
// Abs > wkAbs0, keine überprüfung
// Zeiten filtern (zeZeitFilter)
begin
  Result := GetZeitRecColl(TVeranstObj(FVPtr).OrtIndex,Abs).ErfZeitVorhanden(Zeit);
end;

//==============================================================================
function TTlnObj.SetStoppZeit(OrtIndx:Integer;Abs:TWkAbschnitt;Indx,Zeit:Integer): Integer;
//==============================================================================
// Abs > wkAbs0, keine überprüfung
begin
  Result := GetZeitRecColl(OrtIndx,Abs).SetAufRndZeit(Indx,Zeit);
end;

//==============================================================================
function TTlnObj.SetStoppZeit(Abs:TWkAbschnitt;Indx,Zeit:Integer): Integer;
//==============================================================================
begin
  Result := SetStoppZeit(TVeranstObj(FVPtr).OrtIndex,Abs,Indx,Zeit);
end;

//==============================================================================
function TTlnObj.AbsRundeStoppZeit(OrtIndx:Integer;Abs:TWkAbschnitt;Runde:Integer): Integer;
//==============================================================================
// Abs > wkAbs0, keine überprüfung
// Runde >= 0
// gerundete Zeit, unabhängig von gültiger Startzeit
begin
  with GetZeitRecColl(OrtIndx,Abs) do
    if Runde = 0 then // Startzeit
      Result := GetAufRndZeit(0)
    else // Runde > 0
    if Runde <= FSortItems.Count then
      Result := GetAufRndZeit(IndexOf(FSortItems[Runde-1]))
    else
      Result := -1; // 0 > Runde > FSortItems.Count
end;

//==============================================================================
function TTlnObj.AbsRundeStoppZeit(Abs:TWkAbschnitt;Runde:Integer): Integer;
//==============================================================================
// aktueller Ort
begin
  Result := AbsRundeStoppZeit(TVeranstObj(FVPtr).OrtIndex,Abs,Runde);
end;

//==============================================================================
function TTlnObj.StoppZeit(OrtIndx:Integer;Abs:TWkAbschnitt): Integer;
//==============================================================================
// letzte Runde
// Abs > wkAbs0, keine überprüfung
begin
  with FOrtZeitRecCollArr[Abs].GetColl(OrtIndx) do
    Result := GetAufRndZeit(IndexOf(FSortItems.Last)); //falsch: item statt index verwenden
end;

//==============================================================================
function TTlnObj.StoppZeit(Abs:TWkAbschnitt): Integer;
//==============================================================================
// aktueller Ort, letzte Runde
begin
  Result := StoppZeit(TVeranstObj(FVPtr).OrtIndex,Abs);
end;

(*============================================================================*)
function TTlnObj.StoppZeit(OrtIndx:Integer): Integer;
(*============================================================================*)
// letzter Abschn, letzte Runde.
begin
  Result := StoppZeit(OrtIndx,TWkAbschnitt(FWettk.AbschnZahl));
end;

(*============================================================================*)
function TTlnObj.StoppZeit: Integer;
(*============================================================================*)
// aktueller Ort, letzter Abschn, letzte Runde.
begin
  Result := StoppZeit(TVeranstObj(FVPtr).OrtIndex,TWkAbschnitt(FWettk.AbschnZahl));
end;

//==============================================================================
function TTlnObj.RundenZahl(OrtIndx:Integer;Abs:TWkAbschnitt): Integer;
//==============================================================================
// Abs > wkAbs0, keine überprüfung
begin
  {with GetZeitRecColl(OrtIndx,Abs) do
  begin
    for Result:=0 to SortCount-1 do
      if SortItems[Result].AufRndZeit < 0 then Exit;
    Result := SortCount;
  end; }
  Result := GetZeitRecColl(OrtIndx,Abs).Count;
end;

//==============================================================================
function TTlnObj.RundenZahl(Abs:TWkAbschnitt): Integer;
//==============================================================================
begin
  Result := RundenZahl(TVeranstObj(FVPtr).OrtIndex,Abs);
end;

(*============================================================================*)
procedure TTlnObj.UpdateRundenZahl(Abs:TWkAbschnitt);
(*============================================================================*)
// Abs > wkAbs0, keine überprüfung
begin
  with GetZeitRecColl(TVeranstObj(FVPtr).OrtIndex,Abs) do
    if Count <> FWettk.AbschnRunden[Abs] + 1 then
    begin
      while Count < FWettk.AbschnRunden[Abs] + 1 do // Runden + Startzeit
        AddAufRndZeit(-1);
      while Count > FWettk.AbschnRunden[Abs] + 1 do
        ClearIndex(Count-1);
      if (FVPtr=Veranstaltung) and (CollectionIndex >= 0) then
        TriDatei.Modified := true; // damit FehlerKorrekturen gespeichert werden
    end;
end;

//==============================================================================
function TTlnObj.AbsEinzelRundeZeit(Abs:TWkAbschnitt;Runde:Integer): Integer;
//==============================================================================
// Abs > wkAbs0, keine überprüfung
// AbsZeit einer Runde Result immer >= 0
// UhrZeit = 0 ist gültiger Wert
// Wenn StZeit = Zeit: Result = 24:00:00 wenn 1 Runde definiert, sonst Result = 0,
// damit Gesamt-Zeit <= 24:00:00 bleibt
var StZt,UhrZt: Integer;
begin
  if Runde > 0 then
  begin
    StZt  := AbsRundeStoppZeit(Abs,Runde-1);
    UhrZt := AbsRundeStoppZeit(Abs,Runde);
    if (StZt >= 0) and (UhrZt >= 0) then
      if UhrZt > StZt then Result := UhrZt - StZt
      else
      if UhrZt < StZt then Result := cnZeit24_00 + UhrZt - StZt
      else // UhrZt = StZt
      if Runde = 1 then Result := cnZeit24_00 // nur möglich wenn 1 Runde definiert
                   else Result := 0 // bei doppelte Rundenzeiten
    else Result := 0;
  end else Result := 0;
end;

//==============================================================================
function TTlnObj.AbsRundenZeit(OrtIndx:Integer;Abs:TWkAbschnitt;Runde:Integer): Integer;
//==============================================================================
// Abs > wkAbs0, keine überprüfung
// Runde >= 0
// GesamtZeit Abs bis Runde, Result immer >= 0
// UhrZeit = 0 ist gültiger Wert
// Wenn StZeit = Zeit, dann Result = 24:00:00
var StZt,UhrZt: Integer;
begin
  if Runde > 0 then
  begin
    StZt  := StrtZeit(OrtIndx,Abs);
    UhrZt := AbsRundeStoppZeit(OrtIndx,Abs,Runde);
    if (StZt >= 0) and (UhrZt >= 0) then
      if UhrZt > StZt then Result := UhrZt - StZt
                      else Result := cnZeit24_00 + UhrZt - StZt
    else Result := 0;
  end else Result := 0;
end;

//==============================================================================
function TTlnObj.AbsRundenZeit(Abs:TWkAbschnitt;Runde:Integer): Integer;
//==============================================================================
// aktueller OrtIndex
begin
  Result := AbsRundenZeit(TVeranstObj(FVPtr).OrtIndex,Abs,Runde);
end;

//==============================================================================
function TTlnObj.AbsMinRundeZeit(Abs:TWkAbschnitt):Integer;
//==============================================================================
// aktueller OrtIndex
var i,StZt,UhrZt,RndZt : Integer;
begin
  Result := 0;
  with GetZeitRecColl(TVeranstObj(FVPtr).OrtIndex,Abs) do
  begin
    //StZt := GetAufRndZeit(0);
    StZt := StrtRec.AufRndZeit;
    if StZt < 0 then Exit;  // 0 wenn keine Runden
    //for i:=0 to SortCount-1 do
    for i:=0 to Count-1 do
    begin
      //UhrZt := SortItems[i].AufRndZeit;
      UhrZt := Items[i].AufRndZeit;
      if UhrZt < 0 then Exit  // 0 wenn keine Runden
      else
      begin
        if i=0 then Result := cnZeit192_00; // max als Anfangswert
        if UhrZt > StZt then RndZt := UhrZt - StZt
                        else RndZt := cnZeit24_00 + UhrZt - StZt;
        StZt := UhrZt;
        if RndZt < Result then Result := RndZt;
      end;
    end;
  end;
end;

//==============================================================================
function TTlnObj.AbsMaxRundeZeit(Abs:TWkAbschnitt):Integer;
//==============================================================================
// aktueller OrtIndex
var i,StZt,UhrZt,RndZt : Integer;
begin
  Result := 0; // min als Anfangswert
  with GetZeitRecColl(TVeranstObj(FVPtr).OrtIndex,Abs) do
  begin
    //StZt := GetAufRndZeit(0);
    StZt := StrtRec.AufRndZeit;
    if StZt < 0 then Exit;  // 0 wenn keine Runden
    //for i:=0 to SortCount-1 do
    for i:=0 to Count-1 do
    begin
      //UhrZt := SortItems[i].AufRndZeit;
      UhrZt := Items[i].AufRndZeit;
      if UhrZt < 0 then Exit  // 0 wenn keine Runden
      else
      begin
        if UhrZt > StZt then RndZt := UhrZt - StZt
                        else RndZt := cnZeit24_00 + UhrZt - StZt;
        StZt := UhrZt;
        if RndZt > Result then Result := RndZt;
      end;
    end;
  end;
end;

(*============================================================================*)
function TTlnObj.AbsZeit(OrtIndx:Integer;Abs:TWkAbschnitt): Integer;
(*============================================================================*)
// Abs > wkAbs0, keine überprüfung
// alle Runden
// GesamtZeit Abs, Result immer >= 0
// Wenn StZt = UhrZt, dann Max Result = 24:00:00
// Max pro abschnitt 24:00:00
var StZt,UhrZt: Integer;
begin
  StZt  := StrtZeit(OrtIndx,Abs);
  UhrZt := StoppZeit(OrtIndx,Abs);
  if (StZt >= 0) and (UhrZt >= 0) then
    if UhrZt > StZt then Result := UhrZt - StZt
                    else Result := cnZeit24_00 + UhrZt - StZt
  else Result := 0;
end;

(*============================================================================*)
function TTlnObj.AbsZeit(Abs:TWkAbschnitt): Integer;
(*============================================================================*)
// aktueller OrtIndex, alle Runden
begin
  Result := AbsZeit(TVeranstObj(FVPtr).OrtIndex,Abs);
end;

(*============================================================================*)
function TTlnObj.NettoEndZeit: Integer;
(*============================================================================*)
// Netto Endzeit, ohne Gutschr., Zeitstrafe
// waRndRennen: Endzeit mit unvollständigen Rundenzahlen im letzten Abschnitt
// aktueller Ort
// GesamtZeit über alle Abs, Result immer >= 0
// Nur bei Startmode ohne Pause dürfen vorherige Abszeiten = 0 sein
// bei StaffelWettk gilt Startmode für Msch, Tln immer ohne Pause
// Zeit bis 99:59:59 möglich
// 8*24 = 192:00:00
var AbsCnt : TWkAbschnitt;
begin
  if (FWettk.WettkArt = waRndRennen) or
     (FWettk.WettkArt = waStndRennen) then
    Result := AbsRundenZeit(TVeranstObj(FVPtr).OrtIndex,
                      TWkAbschnitt(FWettk.AbschnZahl),
                      RundenZahl(TWkAbschnitt(FWettk.AbschnZahl)))
  else
    Result := AbsZeit(TVeranstObj(FVPtr).OrtIndex,
                      TWkAbschnitt(FWettk.AbschnZahl));
  if Result > 0 then
    for AbsCnt:=wkAbs1 to TWkAbschnitt(FWettk.AbschnZahl-1) do
      Result := Result + AbsZeit(TVeranstObj(FVPtr).OrtIndex,AbsCnt);
end;

(*============================================================================*)
function TTlnObj.EndZeit: Integer;
(*============================================================================*)
// Brutto EndZeit incl. Gutschrift und Strafzeit, Result immer >= 0
var Gutschr : Integer;
begin
  Result := NettoEndZeit; // Netto Endzeit
  Gutschr := FGutschriftColl[TVeranstObj(FVPtr).OrtIndex];
  if Result > Gutschr then Result := Result - Gutschr
  else Result := 0;
  if (Result > 0) and
     (FStrafZeitColl[TVeranstObj(FVPtr).OrtIndex] > 0) then
    Result := Result + FStrafZeitColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*============================================================================*)
function TTlnObj.GetSerOrtRng(Indx:Integer;AkWrtg:TKlassenWertung): Integer;
(*============================================================================*)
// nur verwendet für wgSerWrtg
begin
  if (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    Result := FSerRngCollArr[AkWrtg][Indx]
  else Result := 0;
end;

(*============================================================================*)
function TTlnObj.TagesRng(Abs:TWkAbschnitt;AkWrtg:TKlassenWertung;Wrtg:TWertungMode): Integer;
(*============================================================================*)
// bei wgMschPktWrtg AkWrtg=kwSex auch für Mixed MschWrtg (2011-2.4)
begin
  case Wrtg of
    wgStandWrtg   : Result := FRngCollArr[AkWrtg,Abs][TVeranstObj(FVPtr).OrtIndex];
    wgSondWrtg    : Result := FSwRngCollArr[AkWrtg,Abs][TVeranstObj(FVPtr).OrtIndex];
    wgSerWrtg     : Result := FSerRngCollArr[AkWrtg][TVeranstObj(FVPtr).OrtIndex];//Abs0,Cup
    wgMschPktWrtg : if AkWrtg<kwSondKl then Result := FMschRngCollArr[AkWrtg][TVeranstObj(FVPtr).OrtIndex]//Abs0
                                       else Result := 0;
    else            Result := 0;
  end;
end;

(*============================================================================*)
function TTlnObj.TagesEndRngStr(Abs:TWkAbschnitt;AkWrtg:TKlassenWertung;Wrtg:TWertungMode):String;
(*============================================================================*)
// Für 1. Spalte in ErgListe, mit 'disq' und 'a.K.'
var Rng : Integer;
begin
  Rng := TagesRng(Abs,AkWrtg,Wrtg);
  if TlnInStatus(stDisqualifiziert) then Result := GetDisqName //'disq'
  else
  if GetAusKonkAllg and (Wrtg<>wgMschPktWrtg) then Result := 'a.K.'
  else
  if GetAusKonkAltKl and (Wrtg<>wgMschPktWrtg) and (AkWrtg=kwAltKl) then Result := 'a.K.'
  else
  if GetAusKonkSondKl and (Wrtg<>wgMschPktWrtg) and (AkWrtg=kwSondKl) then Result := 'a.K.'
  else
  if Rng = 0 then Result := '-'
  else
  Result := IntToStr(Rng);
end;

(*============================================================================*)
function TTlnObj.TagesZwRngStr(Abs:TWkAbschnitt;AkWrtg:TKlassenWertung;Wrtg:TWertungMode): String;
(*============================================================================*)
// ZwischenRang für Spalten > 1 und Ak-Spalte (Abs0)
// disq, a.K. nicht angezeigt, ausg. Ak-Spalte
var Rng : Integer;
begin
  Rng := TagesRng(Abs,AkWrtg,Wrtg);
  if (GetAusKonkAllg or GetAusKonkAltKl) and (Abs=wkAbs0) then Result := 'a.K.'
  else
  if Rng = 0 then Result := '-'
             else Result := IntToStr(Rng);
end;

(*============================================================================*)
function TTlnObj.SerOrtRngToPkt(Indx:Integer;AkWrtg:TKlassenWertung;Rng:Integer): Integer;
(*============================================================================*)
begin
  if TVeranstObj(FVPtr).Serie and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) and (AkWrtg < kwKein) then
    Result := FWettk.OrtSerPkt(tmTln,Indx,FWertgKlasseArr[AkWrtg],Rng)
  else Result := 0;
end;

(*============================================================================*)
function TTlnObj.GetOrtPktSerStr(Indx:Integer;AkWrtg:TKlassenWertung): String;
(*============================================================================*)
// auch wenn nicht gewertet Punkte anzeigen, nur wenn TlnImZiel
var Pkt : Integer;
begin
  if FWettk.TlnImZielColl[tmTln][Indx] then
  begin // mindestens 1 Tln im Ziel in EinzelWettk
    Pkt := SerOrtRngToPkt(Indx,AkWrtg,FSerRngCollArr[AkWrtg][Indx]);
    if FSerRngCollArr[AkWrtg][Indx] > 0 then
      Result := IntToStr(Pkt)
    else // Rng=0
    if Pkt > 0 then // PktIncr.
      Result := '('+IntToStr(Pkt)+')'
    else Result := '-'; // PktDecr oder keiner im Ziel
  end else Result := '-';
end;

(*============================================================================*)
procedure TTlnObj.SetRng(Rng:Integer;Abs:TWkAbschnitt;WrtgMode:TWertungMode;
                         AkWrtg:TKlassenWertung);
(*============================================================================*)
begin
  case WrtgMode of
    wgStandWrtg   : FRngCollArr[AkWrtg,Abs][TVeranstObj(FVPtr).OrtIndex]   := Rng;
    wgSondWrtg    : FSwRngCollArr[AkWrtg,Abs][TVeranstObj(FVPtr).OrtIndex] := Rng;
    wgSerWrtg     : FSerRngCollArr[AkWrtg][TVeranstObj(FVPtr).OrtIndex]    := Rng;//Abs0,Cup
    wgMschPktWrtg : if AkWrtg<kwSondKl then
                      FMschRngCollArr[AkWrtg][TVeranstObj(FVPtr).OrtIndex] := Rng;//Abs0
  end;
end;

(*============================================================================*)
function TTlnObj.SeriePunkte(AkWrtg:TKlassenWertung): Integer;
(*============================================================================*)
begin
  if AkWrtg <> kwKein then Result := FSeriePktArr[AkWrtg]
                      else Result := 0;
end;

(*============================================================================*)
function TTlnObj.SerieRang(AkWrtg:TKlassenWertung): Integer;
(*============================================================================*)
begin
  if AkWrtg <> kwKein then Result := FSerieRngArr[AkWrtg]
                      else Result := 0;
end;

(*============================================================================*)
function TTlnObj.GetSerieRangStr(AkWrtg:TKlassenWertung): String;
(*============================================================================*)
var Rng : Integer;
begin
  if GetAusKonkAllg then Result := 'a.K.'
  else
  if GetAusKonkAltKl and (AkWrtg=kwAltKl) then Result := 'a.K.'
  else
  if GetAusKonkSondKl and (AkWrtg=kwSondKl) then Result := 'a.K.'
  else
  begin
    Rng := SerieRang(AkWrtg);
    if Rng = 0 then Result := '-'
               else Result := IntToStr(Rng);
  end;
end;

(*============================================================================*)
procedure TTlnObj.BerechneSeriePunkte(AkWrtg:TKlassenWertung);
(*============================================================================*)
// Punkte für Serie berechnen, immer über alle Orte
// wenn einige Wettkämpfe ausfallen, z.B. wegen zu niedrigen Temperaturen,
// sollen diese ignoriert werden
// wenn der oder die letzten Orte ausfallen oder noch nicht gestartet sind,
// werden diese auch nicht gewertet, aber als StreichErg berücksichtigt
// StreichErg gibt es erst, wenn die MindestZahl an Wettk (OrtZahl-StreichErg)
// überschritten wird
// Mannschaftswettbewerbe für Serie nicht berücksichtigen (2007-1.2)

var i, TlnOrteGewertet, WkLetztOrtGewertet,
    ErstPktZahl,LetztPktZahl               : Integer;
    PflichtWkErfuellt, PflichtWkErfuellt1  : Boolean;

//..............................................................................
procedure SetPflichtWkErfuellt(Indx:Integer);
// PflichtWkErfuellt nur ändern, wenn true
begin
  with FWettk do
    case PflichtWkMode[tmTln] of
      pw1:
        if Indx = PflichtWkOrt1Indx[tmTln] then PflichtWkErfuellt := true;
      pw1v2:
        if (Indx = PflichtWkOrt1Indx[tmTln]) or
           (Indx = PflichtWkOrt2Indx[tmTln]) then PflichtWkErfuellt := true;
      pw2:
        if (Indx = PflichtWkOrt1Indx[tmTln]) or
           (Indx = PflichtWkOrt2Indx[tmTln]) then
          if not PflichtWkErfuellt1 then PflichtWkErfuellt1 := true
                                    else PflichtWkErfuellt := true;
      else PflichtWkErfuellt := true; // pw0
    end;
end;

//------------------------------------------------------------------------------
procedure StreichergEntfernen;
// pro Klassenwertung aufgerufen, weil Rng-Folge unterschiedlich sein kann
// Items aus RngColl nicht entfernen, sondern Rng=0 setzen
var StreichZahl,
    StreichIndx,
    StreichSortIndx : Integer;
    StreichErg1v2   : Boolean;
begin
  // OrtZahlGestartet in TlnErg berechnet
  with FWettk do
  begin
    // Streichzahl wird um Zahl der nicht durchgeführte EinzelWettk + MschWettk gekürzt
    StreichZahl := StreichErg[tmTln] - TVeranstObj(FVPtr).OrtZahl + OrtZahlGestartet[tmTln];
    StreichSortIndx := SerPktBuffColl.SortCount-1; // schlechteste PktZahl am Ende
    StreichErg1v2 := true;

    // bei Streichung Rng=0 setzen, wird bei SeriePunkte ignoriert
    // Für Streichung schlechteste Punktzahl berücksichtigen, nicht letzter Rng
    // SerPktBuffColl nach Punktzahl sortiert, nicht nach Rng
    // schlechteste Punktzahl am Ende (höchste bei Incr oder niedrigste bei Decr)
    while (StreichZahl > 0) and (StreichSortIndx >= 0) do
    begin
      // höchster Rang steht immer am Ende von SortListe, auch nach Streichung
      StreichIndx := SerPktBuffColl.IndexOf(SerPktBuffColl.PSortItems[StreichSortIndx]);
      // StreichErg entfernen, falls kein PflichtWk
      case PflichtWkMode[tmTln] of
        pw1:
          if StreichIndx <> PflichtWkOrt1Indx[tmTln] then
          begin
            SerPktBuffColl[StreichIndx] := ErstPktZahl; // am Anfang der Liste
            StreichZahl := StreichZahl - 1;
          end else
            StreichSortIndx := StreichSortIndx - 1;
        pw1v2:
          if (StreichIndx <> PflichtWkOrt1Indx[tmTln]) and
             (StreichIndx <> PflichtWkOrt2Indx[tmTln]) then
          begin
            SerPktBuffColl[StreichIndx] := ErstPktZahl; // am Anfang der Liste
            StreichZahl := StreichZahl - 1;
          end else
          if StreichErg1v2 then
          begin
            SerPktBuffColl[StreichIndx] := ErstPktZahl; // am Anfang der Liste
            StreichZahl := StreichZahl - 1;
            StreichErg1v2 := false;
          end else
            StreichSortIndx := StreichSortIndx - 1;
        pw2:
          if (StreichIndx <> PflichtWkOrt1Indx[tmTln]) and
             (StreichIndx <> PflichtWkOrt2Indx[tmTln]) then
          begin
            SerPktBuffColl[StreichIndx] := ErstPktZahl; // am Anfang der Liste
            StreichZahl := StreichZahl - 1;
          end else
            StreichSortIndx := StreichSortIndx - 1;
        else // pw0, kein PflichtWk
        begin
          SerPktBuffColl[StreichIndx] := ErstPktZahl; // am Anfang der Liste
          StreichZahl := StreichZahl - 1;
        end;
      end;
    end;
  end;
end;

//begin Hauptprocedure BerechneSeriePunkte -------------------------------------
begin
  SetSeriePunkte(0,AkWrtg);
  SetSerieWrtg(AkWrtg,false);
  SetSerieEndWrtg(AkWrtg,false);
  if not TVeranstObj(FVPtr).Serie then Exit;

  with FWettk do
  begin
    if (OrtZahlGestartet[tmTln] <= 0) or
       (OrtZahlGestartet[tmTln] > TVeranstObj(FVPtr).OrtZahl) then Exit;

    // alle OrtsWertungen in OrtRngColl's nach Platzierung sortieren
    // Rng = 0, bei Punkteberechnung nicht berücksichtigt
    PflichtWkErfuellt1 := false;
    if FWettk.PflichtWkMode[tmTln] = pw0 then PflichtWkErfuellt := true // auch ohne Wertung
                                         else PflichtWkErfuellt := false;
    if (SerPktMode[tmTln] = spRngUpPkt) or (SerPktMode[tmTln] = spRngUpEqPkt) or
       (SerPktMode[tmTln] = spFlexPkt) and CupPktIncr(tmTln) then
    begin
      SerPktBuffColl.SortMode := smIncr; // Punkte von 1 bis cnTlnMax+1
      ErstPktZahl  := 0; // < 1
      LetztPktZahl := cnTlnMax+2; // > cnTlnMax+1
    end else
    begin
      SerPktBuffColl.SortMode := smDecr; // Punkte von cnTlnMax bis 0
      ErstPktZahl  := cnTlnMax+1; // > cnTlnMax
      LetztPktZahl := -1;  // < 0
    end;
    SerPktBuffColl.SortClear; // weil nur bis OrteGewertet überschrieben
    TlnOrteGewertet    := 0;
    WkLetztOrtGewertet := -1;

    for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
      if TlnOrtSerWertung(i) then // EinzelWettk
        if TlnImZielColl[tmTln][i] then // EinzelWettk durchgeführt
        begin
          WkLetztOrtGewertet := i;
          if GetSerOrtRng(i,AkWrtg) > 0 then // Disq Tln nicht berücksichtigen
          begin
            Inc(TlnOrteGewertet);
            SetPflichtWkErfuellt(i);
            SerPktBuffColl[i] := OrtSerPkt(tmTln,i,FWertgKlasseArr[AkWrtg],GetSerOrtRng(i,AkWrtg));
          end else // Rng=0 am Ende setzen, damit diese zuerst gestrichen wird
            SerPktBuffColl[i] := LetztPktZahl;
        end else // EinzelWettk (noch) nicht durchgeführt
        begin
          SetPflichtWkErfuellt(i);
          SerPktBuffColl[i] := ErstPktZahl;
        end
      else // MschWettk ignorieren
        SerPktBuffColl[i] := ErstPktZahl; // egal ob Tln Gestartet

    if TlnOrteGewertet > 0 then
    begin
      SetSerieWrtg(AkWrtg,true); // Tln in mindestens 1 Ort gewertet
      if PflichtWkErfuellt and
         (TlnOrteGewertet >= WkLetztOrtGewertet+1 - StreichOrt[tmTln]) then
        SetSerieEndWrtg(AkWrtg,true); // Endwertung erreichbar oder erreicht, für Sortierung
    end;

    // Streichergebnisse entfernen (Rng := 0 setzen):
    // Rng = 0 wird bei Punkteberechnung nicht berücksichtigt
    // Items nicht löschen, damit PflichtWkOrtIndx sich nicht ändert
    StreichergEntfernen;

    // SeriePunkte über Orte summieren
    for i:=0 to SerPktBuffColl.Count-1 do // Count = TVeranstObj(FVPtr).OrtZahl
      if SerPktBuffColl[i] <> ErstPktZahl then // Rng=0 incl. StreichErgebnisse ignorieren
      begin
        if SerPktBuffColl[i] = LetztPktZahl then // Rng war ursprünglich 0
          SerPktBuffColl[i] := OrtSerPkt(tmTln,i,FWertgKlasseArr[AkWrtg],0);
        SetSeriePunkte(SeriePunkte(AkWrtg) + SerPktBuffColl[i], AkWrtg);
      end;
  end;
end;

(*============================================================================*)
function TTlnObj.VereinsName: String;
(*============================================================================*)
(* Endziffer entfernen, verwendet für Presse-Ergebnisse *)
var S: String;
begin
  S := GetMannschName;
  if (Length(S)>0) and CharInSet(S[Length(S)],['0'..'9']) then
    S := Copy(S,1,Length(S)-1);
  Result := S;
end;

(*============================================================================*)
procedure TTlnObj.KlassenSetzen;
(*============================================================================*)
// kwAlle in Create gesetzt
var KwCnt : TKlassenWertung;
begin
  if FWettk<>nil then with FWettk do
  begin
    for KwCnt:=kwSex to kwSondKl do // kwSex,kwAltKl,kwSondKl
      FWertgKlasseArr[KwCnt] := GetKlasse(tmTln,KwCnt,FSex,FJg); // FSex auch cnMixed bei TlnStaffel

    if FMschWrtg then
      if FMschMixWrtg then
      begin
        FMschWertgKlasseArr[kwSex]   := GetKlasse(tmMsch,kwSex,cnMixed,FJg);
        FMschWertgKlasseArr[kwAltKl] := AkUnbekannt;
      end else
      begin
        FMschWertgKlasseArr[kwSex]   := GetKlasse(tmMsch,kwSex,FSex,FJg);
        FMschWertgKlasseArr[kwAltKl] := GetKlasse(tmMsch,kwAltKl,FSex,FJg)
      end
    else
    begin
      FMschWertgKlasseArr[kwSex]   := AkUnbekannt;
      FMschWertgKlasseArr[kwAltKl] := AkUnbekannt;
    end;
  end;
end;

(*============================================================================*)
procedure TTlnObj.KlassenLoeschen;
(*============================================================================*)
begin
  case FSex of
    cnMaennlich: FWertgKlasseArr[kwSex] := AkMannUnbek;
    cnWeiblich:  FWertgKlasseArr[kwSex] := AkFrauUnbek;
    else         FWertgKlasseArr[kwSex] := AkUnbekannt;
  end;
  FWertgKlasseArr[kwAltKl]     := FWertgKlasseArr[kwSex];
  FWertgKlasseArr[kwSondKl]    := FWertgKlasseArr[kwSex];
  FMschWertgKlasseArr[kwSex]   := FWertgKlasseArr[kwSex];
  FMschWertgKlasseArr[kwAltKl] := FWertgKlasseArr[kwSex];
end;

(*============================================================================*)
procedure TTlnObj.EinteilungLoeschen;
(*============================================================================*)
// nur Einteilungsdaten löschen
var AbsCnt : TWkAbschnitt;
    Arr : TZeitRecCollArr;
begin
  for AbsCnt:=wkAbs1 to wkAbs8 do Arr[AbsCnt] := nil;
  SetTlnOrtDaten(0,               // Snr
                 nil,             // SGrp
                 0,               // Startbahn
                 MldZeit,
                 Startgeld,
                 Komment,
                 Arr,             // ZeitCollArr
                 0,               // Gutschrift
                 -1,              // StrafZeit
                 0,               // Reststrecke
                 '',              // DisqGrund
                 '',              // DisqName
                 GetAusKonkAllg,
                 GetAusKonkAltKl,
                 GetAusKonkSondKl,
                 GetSondWrtg,
                 GetUrkDruck);
end;

(*============================================================================*)
procedure TTlnObj.CopyAllgemeinDaten(Tln:TTlnObj);
(*============================================================================*)
// copy Daten von Tln, aktueller Ortindex
var AbsCnt : TWkAbschnitt;
begin
  if Tln = nil then Exit;
  FVPtr := Tln.FVPtr;
  SetName(Tln.FName);
  SetVName(Tln.FVName);
  for AbsCnt:=wkAbs2 to wkAbs8 do
  begin
    SetStaffelName(AbsCnt,Tln.GetStaffelName(AbsCnt));
    SetStaffelVName(AbsCnt,Tln.GetStaffelVName(AbsCnt));
  end;
  SetStrasse(Tln.FStrasse);
  SetHausNr(Tln.FHausNr);
  SetPLZ(Tln.FPLZ);
  SetOrt(Tln.FOrt);
  SetEMail(Tln.FEMail);
  SetSex(Tln.FSex);
  SetJg(Tln.FJg);
  SetLand(Tln.FLand);
  SetWettk(Tln.FWettk);
  SetMannschNamePtr(Tln.FMannschName);
  SetSMld(Tln.FSMld);
  SetSerienWrtg(Tln.FSerienWrtg);
  SetMschWrtg(Tln.FMschWrtg);
  SetMschMixWrtg(Tln.FMschMixWrtg);
end;

(*============================================================================*)
procedure TTlnObj.CopyAnmeldungsDaten(Tln:TTlnObj);
(*============================================================================*)
// copy Daten von Tln, aktueller Ortindex
var AbsCnt : TWkAbschnitt;
    Arr    : TZeitRecCollArr;
begin
  if Tln = nil then Exit;
  for AbsCnt:=wkAbs1 to wkAbs8 do Arr[AbsCnt] := nil;
  SetTlnOrtDaten(0,                       // Snr
                 nil,                     // SGrp
                 0,                       // Startbahn
                 Tln.MldZeit,
                 Tln.Startgeld,
                 Tln.Komment,
                 Arr,                     // ZeitCollArr
                 0,                       // Gutschrift
                 -1,                      // StrafZeit
                 0,                       // Reststrecke
                 '',                      // DisqGrund
                 '',                      // DisqName
                 Tln.GetAusKonkAllg,
                 Tln.GetAusKonkAltKl,
                 Tln.GetAusKonkSondKl,
                 Tln.GetSondWrtg,
                 Tln.GetUrkDruck);
end;

(*============================================================================*)
procedure TTlnObj.CopyEinteilungsDaten(Tln:TTlnObj);
(*============================================================================*)
// copy Daten von Tln, aktueller Ortindex
var AbsCnt : TwkAbschnitt;
    Arr : TZeitRecCollArr;
begin
  if Tln = nil then Exit;
  for AbsCnt:=wkAbs1 to wkAbs8 do Arr[AbsCnt] := nil;
  SetTlnOrtDaten(Tln.Snr,
                 Tln.SGrp,
                 Tln.SBhn,
                 Tln.MldZeit,
                 Tln.Startgeld,
                 Tln.Komment,
                 Arr,                     // ZeitCollArr
                 0,                       // Gutschrift
                 -1,                      // StrafZeit
                 0,                       // Reststrecke
                 '',                      // DisqGrund
                 '',                      // DisqName
                 Tln.GetAusKonkAllg,
                 Tln.GetAusKonkAltKl,
                 Tln.GetAusKonkSondKl,
                 Tln.GetSondWrtg,
                 Tln.GetUrkDruck);
end;

(*============================================================================*)
procedure TTlnObj.CopyErgebnisDaten(Tln:TTlnObj);
(*============================================================================*)
// copy Daten von Tln, aktueller Ortindex
begin
  if Tln = nil then Exit;
  SetTlnOrtDaten(Tln.Snr,
                 Tln.SGrp,
                 Tln.SBhn,
                 Tln.MldZeit,
                 Tln.Startgeld,
                 Tln.Komment,
                 Tln.GetZeitRecCollArr,
                 Tln.GetGutschrift,
                 Tln.GetStrafZeit,
                 Tln.GetReststrecke,
                 Tln.DisqGrund,
                 Tln.DisqName,
                 Tln.GetAusKonkAllg,
                 Tln.GetAusKonkAltKl,
                 Tln.GetAusKonkSondKl,
                 Tln.GetSondWrtg,
                 Tln.GetUrkDruck);
end;

(*============================================================================*)
procedure TTlnObj.CopyRngDaten(Tln:TTlnObj);
(*============================================================================*)
var i : Integer;
    AbsCnt : TWkAbschnitt;
    KwCnt : TKlassenWertung;
begin
  if Tln = nil then Exit;
  i := TVeranstObj(FVPtr).OrtIndex;
  FStaffelVorgColl[i] := Tln.Staffelvorg;
  // FRngBuffColl  nur während Serienwertung benutzt
  for AbsCnt:=wkAbs0 to wkAbs8 do
  begin
    for KwCnt:=kwAlle to kwSondKl do
    begin
      FRngCollArr[KwCnt,AbsCnt][i]   := Tln.TagesRng(AbsCnt,KwCnt,wgStandWrtg);
      FSwRngCollArr[KwCnt,AbsCnt][i] := Tln.TagesRng(AbsCnt,KwCnt,wgSondWrtg);
      if AbsCnt = wkAbs0 then
      begin
        FSeriePktArr[KwCnt]      := Tln.FSeriePktArr[KwCnt];
        FSerieRngArr[KwCnt]      := Tln.FSerieRngArr[KwCnt];
        FSerieWrtgArr[KwCnt]     := Tln.FSerieWrtgArr[KwCnt];
        FSerieEndWrtgArr[KwCnt]  := Tln.FSerieEndWrtgArr[KwCnt];
        FSerRngCollArr[KwCnt][i] := Tln.TagesRng(AbsCnt,KwCnt,wgSerWrtg);
        if KwCnt<kwSondKl then
          FMschRngCollArr[KwCnt][i] := Tln.TagesRng(AbsCnt,KwCnt,wgMschPktWrtg);
      end;
    end;
  end;
end;


(*============================================================================*)
procedure TTlnObj.SetWettkErgModified;
(*============================================================================*)
// Funktion muss vor und nach StatusÄnderung aufgerufen werden
begin
  if (FVPtr<>Veranstaltung) or (FWettk=nil) or (CollectionIndex<0) then Exit;
  // immer nötig für Setzen Startzeit, wenn eingeteilt (ab 2008-2.0)
  if TlnInStatus(stEingeteilt) then
    FWettk.ErgModified := true;
end;

(*============================================================================*)
procedure TTlnObj.SetzeBearbeitet;
(*============================================================================*)
var
  SystemTime: TSystemTime;
  DateTime: TDateTime;
begin
  GetLocalTime(SystemTime);
  DateTime := SystemTimeToDateTime(SystemTime);
  SortRemove;
  FBearbeitet := DateTimeToTimeStamp(DateTime);
  SortAdd;
end;

(*============================================================================*)
function TTlnObj.AenderungsZeit: String;
(*============================================================================*)
var D : TDateTime;
begin
  try
  if FBearbeitet.Date=0 then Result := '-'
  else
  begin
    D := TimeStampToDateTime(FBearbeitet);
    Result := Format('%.2u.%.2u.%.4u  %.2u:%.2u',[DayOf(D),MonthOf(D),YearOf(D),HourOf(D),MinuteOf(D)]);
  end;
  except
    Result := '-';
  end;
end;
{
(*============================================================================*)
function TTlnObj.PflichtWkTeilnahme: Boolean;
(*============================================================================*)
// Teilnahme-Pflicht nur für Wettk die bereits stattgefunden haben
begin
  Result := false;
  if (FWettk = nil) or (FCollection = nil) then Exit;
  case FWettk.PflichtWkMode of
    pw1:
      if (GetRngSer(FWettk.PflichtWkOrt1Indx) > 0) or
         not TTlnColl(FCollection).OrtTlnGestartet(FWettk.PflichtWkOrt1Indx,
                            WettkAlleDummy,AkAlle) then
        Result := true;
    pw1v2:
      if (GetRngSer(FWettk.PflichtWkOrt1Indx) > 0) or
         not TTlnColl(FCollection).OrtTlnGestartet(FWettk.PflichtWkOrt1Indx,
                            WettkAlleDummy,AkAlle) or
         (GetRngSer(FWettk.PflichtWkOrt2Indx) > 0) or
         not TTlnColl(FCollection).OrtTlnGestartet(FWettk.PflichtWkOrt2Indx,
                            WettkAlleDummy,AkAlle) then
        Result := true;
    pw2:
      if ((GetRngSer(FWettk.PflichtWkOrt1Indx) > 0) or
          not TTlnColl(FCollection).OrtTlnGestartet(FWettk.PflichtWkOrt1Indx,
                            WettkAlleDummy,AkAlle)) and
          ((GetRngSer(FWettk.PflichtWkOrt2Indx) > 0) or
         not TTlnColl(FCollection).OrtTlnGestartet(FWettk.PflichtWkOrt2Indx,
                            WettkAlleDummy,AkAlle)) then
        Result := true;
    else Result := true; // pw0
  end;
end;
}
(*============================================================================*)
function TTlnObj.SerPktSort(AkWrtg:TKlassenWertung): Integer;
(*============================================================================*)
begin
  Result := 0; // compiler-warnung vermeiden
  if TVeranstObj(FVPtr).Serie then
    case FWettk.SerPktMode[tmTln] of
      spRngUpPkt,spRngUpEqPkt   : Result := SeriePunkte(AkWrtg);
      spRngDwnPkt,spRngDwnEqPkt : Result := seSerPktMax - SeriePunkte(AkWrtg);
      spFlexPkt :
        if FWettk.CupPktIncr(tmTln) then Result := SeriePunkte(AkWrtg)
                                    else Result := seSerPktMax - SeriePunkte(AkWrtg);
    end;
end;

(*============================================================================*)
function TTlnObj.ObjSize: Integer;
(*============================================================================*)
begin
  Result := (10+(cnAbsZahlMax-1)*2)*cnSizeOfString + //FName,FVName,FStrasse,FOrt,Land,Text,Komment,PLZ,Nr,EMail
            SizeOf(FSex) +
            3*cnSizeOfInteger + //FJg, FSeriePunkte, FSerieRang,
            4*cnSizeOfPointer + //FMannschName,FSMld,FWettk,FMannschPtr
            2*cnSizeOfBoolean + //FSerienWrtg,FMschWrtg
            5*FSondWrtgColl.CollSize +
            FSnrColl.CollSize +
            FSGrpColl.CollSize +
            FStrtBahnColl.CollSize +
            FMldZeitColl.CollSize +
            FStartgeldColl.CollSize +
            FKommentColl.CollSize +
            cnAbsZahlMax*4*FOrtZeitRecCollArr[wkAbs1].CollSize +
            FGutschriftColl.CollSize +
            FStrafZeitColl.CollSize +
            FReststreckeColl.CollSize +
            FDisqGrundColl.CollSize +
            FDisqNameColl.CollSize +
            FStaffelVorgColl.CollSize +
            //FRngMWColl.CollSize +
            (1+cnAbsZahlMax)*8*FRngCollArr[kwAlle,wkAbs0].CollSize +
            4*FSerRngCollArr[kwAlle].CollSize +
            3*FMschRngCollArr[kwAlle].CollSize;
end;


(******************************************************************************)
(* Methoden von TTlnColl                                                      *)
(******************************************************************************)

// protected

(*----------------------------------------------------------------------------*)
function TTlnColl.GetBPObjType: Word;
(*----------------------------------------------------------------------------*)
(* Object Types aus Version 7.4 Stream Registration Records *)
begin
  Result := rrTlnColl;
end; 

(*----------------------------------------------------------------------------*)
function TTlnColl.GetPItem(Indx:Integer): TTlnObj;
(*----------------------------------------------------------------------------*)
begin
  Result := TTlnObj(inherited GetPItem(Indx));
end;

(*----------------------------------------------------------------------------*)
procedure TTlnColl.SetPItem(Indx:Integer; Item:TTlnObj);
(*----------------------------------------------------------------------------*)
begin
  inherited SetPItem(Indx,Item);
end;

(*----------------------------------------------------------------------------*)
function TTlnColl.GetSortItem(Indx:Integer): TTlnObj;
(*----------------------------------------------------------------------------*)
begin
  Result := TTlnObj(inherited GetSortItem(Indx));
end;

(*----------------------------------------------------------------------------*)
function TTlnColl.GetReportCount: Integer;
(*----------------------------------------------------------------------------*)
begin
  Result := FReportItems.Count;
end;

(*----------------------------------------------------------------------------*)
function TTlnColl.GetReportItem(Indx:Integer): TReportTlnObj;
(*----------------------------------------------------------------------------*)
begin
  if (Indx>=0) and (Indx<FReportItems.Count) then
    Result := TReportTlnObj(FReportItems[Indx])
  else Result := nil;
end;

(*----------------------------------------------------------------------------*)
function TTlnColl.SortString(Item:Pointer): String;
(*----------------------------------------------------------------------------*)
var Zt  : Integer;
    Buf : Integer;
    AbsCnt : TWkAbschnitt;
label Ende;

//..............................................................................
function ErgStr
(const Tln:TTlnObj): String;
// Tln als Par, wegen Warning beim Erzeugen von tria
var AbsCnt : TWkAbschnitt;
begin
  with Tln do
  begin
    if not TlnInStatus(stEingeteilt) then // stGemeldet, stSerGemeldet
      if GetSnr=0 then
        Result := 'F '
      else
        Result := Format('E %4u',[GetSnr])
    else // Snr > 0
    if TlnInStatus(stDisqualifiziert) then // stDisqualifiziert
      Result := Format('B %4u',[GetSnr])
    else

    if FWettk.WettkArt = waRndRennen then // nur 1 Abschnitt
      if (StrtZeit(wkAbs1) >= 0) and
         (AbsRundeStoppZeit(wkAbs1,1) >= 0) then // stGewertet, mindestens 1 Runde
        Result := Format('A %5u %8u',[cnRundenMax+1-RundenZahl(wkAbs1),EndZeit])
      else
        Result := Format('D %4u',[GetSnr])

    else
    if FWettk.WettkArt = waStndRennen then // nur 1 Abschnitt, Gesamtstrecke
      if (StrtZeit(wkAbs1) >= 0) and
         (AbsRundeStoppZeit(wkAbs1,1) >= 0) then // stGewertet, mindestens 1 Runde
        Result := Format('A %5u %6u',[cnRundenMax+1-RundenZahl(wkAbs1),
                                          cnRestStreckeMax+1-Reststrecke])
      else
        Result := Format('D %4u',[GetSnr])

    else
      if (StrtZeit(TWkAbschnitt(FWettk.AbschnZahl)) >= 0) and
         (StoppZeit(TWkAbschnitt(FWettk.AbschnZahl)) >= 0) then // stGewertet
        Result := Format('A %8u',[EndZeit])
      else
      begin
        for AbsCnt:=TWkAbschnitt(FWettk.AbschnZahl) downto wkAbs1 do
          if (StrtZeit(AbsCnt) >= 0) and (AbsRundeStoppZeit(AbsCnt,1) >= 0) then//stAbsCntStart
          begin
            Result := Format('C %u %5u %8u',
                             [cnAbsZahlMax+1-Integer(AbsCnt),
                              cnRundenMax+1-RundenZahl(AbsCnt),
                              AbsRundenZeit(AbsCnt,RundenZahl(AbsCnt))]);
            Exit;
          end;  // stEingeteilt
        Result := Format('D %4u',[GetSnr]);
      end;
  end;
end;

//..............................................................................
begin
  Result := ' ';
  if Item=nil then Exit;
  with TTlnObj(Item) do
  begin
    if FWettk=nil then Exit;
    // 2 Blanks zwischen Strings, damit bei 1 Blank im String noch richtig
    // sortiert wird
    case FSortMode of

      smTlnName:
        Result := Format('%s  %s  %s  %s',[FName,FVName,GetMannschName,FWettk.Name]);

      smTlnSnr:
        if GetSnr>0 then
          Result := Format('%4u  %s  %s  %s  %s',
                           [GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else Result := Format('Z  %s  %s  %s  %s',
                           [FName,FVName,GetMannschName,FWettk.Name]);

      smTlnAlter:
        Result := Format('%2u %s  %s  %s  %s',
                         [GetAlter,
                          FName,FVName,GetMannschName,FWettk.Name]);

      smTlnAk:
        Result := Format('%2u %u %s  %s  %s  %s',
                         [WertungsKlasse(kwAltKl,tmTln).AlterVon,5-Integer(FSex),
                          FName,FVName,GetMannschName,FWettk.Name]);

      smTlnSnrAlter:
        if GetSnr>0 then
          Result := Format('%2u %4u  %s  %s  %s  %s',
                           [GetAlter,GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else Result := Format('%2u Z  %s  %s  %s  %s',
                           [GetAlter,
                            FName,FVName,GetMannschName,FWettk.Name]);

      smTlnSnrAk:
        if GetSnr>0 then
          Result := Format('%2u %u %4u  %s  %s  %s  %s',
                           [WertungsKlasse(kwAltKl,tmTln).AlterVon,5-Integer(FSex),
                            GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else Result := Format('%2u %u Z  %s  %s  %s  %s',
                           [WertungsKlasse(kwAltKl,tmTln).AlterVon,5-Integer(FSex),
                            FName,FVName,GetMannschName,FWettk.Name]);

      smTlnMldZeit:
      begin
        Zt := GetMldZeit;
        //Zmax = cnZeit100_00 = 36000000 (8 Ziffern)
        if Zt >= 0 then
          Result := Format('%8u  %s  %s  %s  %s',
                           [Zt,FName,FVName,GetMannschName,FWettk.Name])
        else Result := Format('Z  %s  %s  %s  %s',
                           [FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnStartgeld:
        if GetStartgeld>0 then
          Result := Format('%5u  %s  %s  %s  %s',
                           [GetStartgeld,
                            FName,FVName,GetMannschName,FWettk.Name])
        else Result := Format('Z  %s  %s  %s  %s',
                           [FName,FVName,GetMannschName,FWettk.Name]);

      smTlnAbs1Startzeit..smTlnAbs8Startzeit:
      begin
        Zt := StrtZeit(TWkAbschnitt(Integer(FSortMode)-Integer(smTlnAbs1Startzeit)+1));
        if Zt >= 0 then // Zmax = cnZeit24_00 = 8640000 (7 Ziffern)
          Result := Format('%7u  %4u  %s  %s  %s  %s',
                           [Zt,GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else Result := Format('Z  %s  %s  %s  %s',
                           [FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnSBhn:
        if GetSGrp <> nil then
          if GetSGrp.StartModus[wkAbs1] = stOhnePause then  // Einzelstart, keine StartZeit
            Result := Format('%2u  %s  %4u  %s  %s  %s  %s',
                             [GetStrtBahn,GetSGrp.Name,
                              GetSnr,FName,FVName,GetMannschName,FWettk.Name])
          else
            Result := Format('%2u  %7u  %4u  %s  %s  %s  %s',
                             [GetStrtBahn,GetSGrp.StartZeit[wkAbs1],
                              GetSnr,FName,FVName,GetMannschName,FWettk.Name])
        else Result := Format('0  %s  %s  %s  %s',
                              [FName,FVName,GetMannschName,FWettk.Name]);

      smTlnAbs1Zeit..smTlnAbs8Zeit:
      begin
        Zt := AbsZeit(TWkAbschnitt(Integer(FSortMode)-Integer(smTlnAbs1Zeit)+1));
        if Zt > 0 then // Zmax = cnZeit100_00 = 36000000 (8 Ziffern) 8*24 
          Result := Format('%8u  %s  %s  %s  %s',
                           [Zt,FName,FVName,GetMannschName,FWettk.Name])
        else Result := Format('Z  %s  %s  %s  %s',
                           [FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnEndZeit: // für Wertung
      begin
        Zt := EndZeit; // Zmax = cnZeit192_00=69120100 (8 Ziffern)
        if Zt > 0 then
          if FWettk.WettkArt = waRndRennen then
            Result := Format('%5u %8u  %s  %s  %s  %s',
                             [cnRundenMax+1-RundenZahl(wkAbs1),Zt,
                              FName,FVName,GetMannschName,FWettk.Name])
          else
          if FWettk.WettkArt = waStndRennen then
            Result := Format('%5u %6u  %s  %s  %s  %s',
                             [cnRundenMax+1-RundenZahl(wkAbs1),
                              cnReststreckeMax+1-Reststrecke,
                              FName,FVName,GetMannschName,FWettk.Name])
          else
            Result := Format('%8u  %s  %s  %s  %s',
                             [Zt,FName,FVName,GetMannschName,FWettk.Name])
        else // Zt = 0
          Result := Format('Z  %s  %s  %s  %s',
                             [FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnErg:
        Result := Format('%s  %s  %s  %s  %s',
                         [ErgStr(Item),FName,FVName,GetMannschName,FWettk.Name]);

      smTlnErgAlter:
        Result := Format('%2u  %s  %s  %s  %s  %s',
                         [GetAlter,ErgStr(Item),FName,FVName,GetMannschName,FWettk.Name]);

      smTlnErgAk:
        Result := Format('%2u %u  %s  %s  %s  %s  %s',
                         [WertungsKlasse(kwAltKl,tmTln).AlterVon, 5-Integer(FSex), ErgStr(Item),
                          FName,FVName,GetMannschName,FWettk.Name]);

      smTlnMschName:
        Result := Format('%s  %s  %s  %s',[GetMannschName,FWettk.Name,FName,FVName]);

      smTlnErgMschName:
        Result := Format('%s  %s  %s  %s  %s',
                         [GetMannschName,ErgStr(Item),FName,FVName,FWettk.Name]);

      smTlnSMld:
        if FSMld<>nil then
          Result := Format('%s  %s  %s  %s  %s  %s  %s',
                           [FSMld.Name,FSMld.VName,FSMld.Verein,
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('Z  %s  %s  %s  %s',
                           [FName,FVName,GetMannschName,FWettk.Name]);

      smTlnAbs1UhrZeit..smTlnAbs8UhrZeit:
      begin
        Zt := -1;
        for AbsCnt:=TWkAbschnitt(Integer(FSortMode)-Integer(smTlnAbs1UhrZeit)+1) downto wkAbs1 do
        begin
          Zt := StoppZeit(AbsCnt);
          if Zt >= 0 then // StoppZeit vorhanden in wkAbs(AbsCnt)
          begin
            Result := Format('A %u %7u %4u %s  %s  %s  %s',
                             [cnAbsZahlMax+1-Integer(AbsCnt),
                              Zt,GetSnr,
                              FName,FVName,GetMannschName,FWettk.Name]);
            Break;
          end;
        end;
        if Zt < 0 then // keine Stoppzeit vorhanden
          if StrtZeit(wkAbs1) >= 0 then // Startzeit vorhanden
            Result := Format('Y %7u %4u %s  %s  %s  %s',
                             [StrtZeit(wkAbs1),GetSnr,
                              FName,FVName,GetMannschName,FWettk.Name])
          else // keine Start- und StoppZeit
            Result := Format('Z %4u %s  %s  %s  %s',
                             [GetSnr,
                              FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnAbsRnd: // Rundenkontrolle, auch 24h-Rennen, 2008-2.0
                   // nach höchste Rundenzahl, niedrigste RundenZeit (eff)
      begin        // HauptFenster.SortStatus: stAbs1..8Zeit
        AbsCnt := TWkAbschnitt(Integer(HauptFenster.SortStatus)-Integer(stAbs1Zeit)+1);
        if StrtZeit(AbsCnt) >= 0 then // gültige AbsZeit
          Result := Format('%5u %8u %4u %s  %s  %s  %s',
                           [cnRundenMax+1-RundenZahl(AbsCnt),
                            AbsRundenZeit(AbsCnt,RundenZahl(AbsCnt)),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('Z %5u %8u %4u %s  %s  %s  %s',
                           [cnRundenMax+1-RundenZahl(AbsCnt),
                            AbsRundeStoppZeit(AbsCnt,RundenZahl(AbsCnt)),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name]);

      end;
      smTlnAbsRndStZeit: // Rundenkontrolle, 2008-2.0
      begin              // HauptFenster.SortStatus: stAbs1..8Zeit
        AbsCnt := TWkAbschnitt(Integer(HauptFenster.SortStatus)-Integer(stAbs1Zeit)+1);
        if StrtZeit(AbsCnt) >= 0 then // gültige AbsZeit
          Result := Format('%8u %5u %8u %4u %s  %s  %s  %s',
                           [StrtZeit(AbsCnt),
                            cnRundenMax+1-RundenZahl(AbsCnt),
                            AbsRundenZeit(AbsCnt,RundenZahl(AbsCnt)),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('Z %5u %8u %4u %s  %s  %s  %s',
                           [cnRundenMax+1-RundenZahl(AbsCnt),
                            AbsRundeStoppZeit(AbsCnt,RundenZahl(AbsCnt)),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name]);
      end;
      smTlnStoppZeit: // Rundenkontrolle, 2008-2.0 , nicht Ok wenn über mitternacht ????
      begin           // HauptFenster.SortStatus: stAbs1..8Zeit
        AbsCnt := TWkAbschnitt(Integer(HauptFenster.SortStatus)-Integer(stAbs1Zeit)+1);
        if StrtZeit(AbsCnt) >= 0 then // gültige AbsZeit
          Result := Format('%8u %5u %8u %4u %s  %s  %s  %s',
                           [AbsRundeStoppZeit(AbsCnt,RundenZahl(AbsCnt)),
                            cnRundenMax+1-RundenZahl(AbsCnt),
                            AbsRundenZeit(AbsCnt,RundenZahl(AbsCnt)),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('%8u %5u Z %4u %s  %s  %s  %s',
                           [AbsRundeStoppZeit(AbsCnt,RundenZahl(AbsCnt)),
                            cnRundenMax+1-RundenZahl(AbsCnt),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnMinRndZeit:    // Rundenkontrolle, 2015
      begin               // HauptFenster.SortStatus: stAbs1..8Zeit
        AbsCnt := TWkAbschnitt(Integer(HauptFenster.SortStatus)-Integer(stAbs1Zeit)+1);
        if StrtZeit(AbsCnt) >= 0 then // gültige AbsZeit
          Result := Format('%8u %5u %4u %s  %s  %s  %s',
                           [AbsMinRundeZeit(AbsCnt),
                            cnRundenMax+1-RundenZahl(AbsCnt),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('Z %5u %8u %4u %s  %s  %s  %s',
                           [cnRundenMax+1-RundenZahl(AbsCnt),
                            AbsRundeStoppZeit(AbsCnt,RundenZahl(AbsCnt)),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnMaxRndZeit:    // Rundenkontrolle, 2015
      begin               // HauptFenster.SortStatus: stAbs1..8Zeit
        AbsCnt := TWkAbschnitt(Integer(HauptFenster.SortStatus)-Integer(stAbs1Zeit)+1);
        if StrtZeit(AbsCnt) >= 0 then // gültige AbsZeit
          Result := Format('%8u %5u %4u %s  %s  %s  %s',
                           [AbsMaxRundeZeit(AbsCnt),
                            cnRundenMax+1-RundenZahl(AbsCnt),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('Z %5u %8u %4u %s  %s  %s  %s',
                           [cnRundenMax+1-RundenZahl(AbsCnt),
                            AbsRundeStoppZeit(AbsCnt,RundenZahl(AbsCnt)),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnAbsRndEffZeit: // Rundenkontrolle, 2008-2.0
      begin               // HauptFenster.SortStatus: stAbs1..8Zeit
        AbsCnt := TWkAbschnitt(Integer(HauptFenster.SortStatus)-Integer(stAbs1Zeit)+1);
        if StrtZeit(AbsCnt) >= 0 then // gültige AbsZeit
          Result := Format('%8u %5u %4u %s  %s  %s  %s',
                           [AbsRundenZeit(AbsCnt,RundenZahl(AbsCnt)),
                            cnRundenMax+1-RundenZahl(AbsCnt),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('Z %5u %8u %4u %s  %s  %s  %s',
                           [cnRundenMax+1-RundenZahl(AbsCnt),
                            AbsRundeStoppZeit(AbsCnt,RundenZahl(AbsCnt)),GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smEndUhrZeit: // nicht Ok wenn über mitternacht
      begin
        Zt := StoppZeit;
        if Zt >= 0 then // Endzeit vorhanden
          Result := Format('A %7u %4u %s  %s  %s  %s',
                           [Zt,GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name])
        else // keine Endzeit
        begin
          for AbsCnt:=TWkAbschnitt(FWettk.AbschnZahl) downto wkAbs1 do
          begin
            Zt := StoppZeit(AbsCnt);
            if Zt >= 0 then // StoppZeit vorhanden in wkAbs(AbsCnt)
            begin
              Result := Format('B %u %7u %4u %s  %s  %s  %s',
                           [cnAbsZahlMax+1-Integer(AbsCnt),
                            Zt,GetSnr,
                            FName,FVName,GetMannschName,FWettk.Name]);
              Break;
            end;
          end;
          if Zt < 0 then // keine End- und Stoppzeit vorhanden
            if StrtZeit(wkAbs1) >= 0 then // Startzeit vorhanden
              Result := Format('B %7u %4u %s  %s  %s  %s',
                               [StrtZeit(wkAbs1),GetSnr,
                                FName,FVName,GetMannschName,FWettk.Name])
            else // keine Start- und Endzeit
              Result := Format('C %4u %s  %s  %s  %s',
                               [GetSnr,
                                FName,FVName,GetMannschName,FWettk.Name]);
        end;
      end;

      smTlnSerErg:
      begin
        if (FWettk.PunktGleichOrtIndx[tmTln] >= 0) and
           (GetSerOrtRng(FWettk.PunktGleichOrtIndx[tmTln],kwAlle) > 0)
          then Buf := GetSerOrtRng(FWettk.PunktGleichOrtIndx[tmTln],kwAlle)
          else Buf := cnTlnMax+1;
        if GetSerieEndWrtg(FSortAkWrtg) then
          Result := Format('A %6u %5u  %s  %s  %s  %s',
                           [SerPktSort(FSortAkWrtg),Buf,
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('B %6u %5u  %s  %s  %s  %s',
                           [SerPktSort(FSortAkWrtg),Buf,
                            FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnSerErgAlter:
      begin
        if (FWettk.PunktGleichOrtIndx[tmTln] >= 0) and
           (GetSerOrtRng(FWettk.PunktGleichOrtIndx[tmTln],kwAlle) > 0)
          then Buf := GetSerOrtRng(FWettk.PunktGleichOrtIndx[tmTln],kwAlle)
          else Buf := cnTlnMax+1;
        if GetSerieEndWrtg(FSortAkWrtg) then
          Result := Format('%2u A %6u %5u %s  %s  %s  %s',
                           [GetAlter,
                            SerPktSort(FSortAkWrtg),Buf,
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('%2u B %6u %5u %s  %s  %s  %s',
                           [GetAlter,
                            SerPktSort(FSortAkWrtg),Buf,
                            FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnSerErgAk:
      begin
        if (FWettk.PunktGleichOrtIndx[tmTln] >= 0) and
           (GetSerOrtRng(FWettk.PunktGleichOrtIndx[tmTln],kwAlle) > 0)
          then Buf := GetSerOrtRng(FWettk.PunktGleichOrtIndx[tmTln],kwAlle)
          else Buf := cnTlnMax+1;
        if GetSerieEndWrtg(FSortAkWrtg) then
          Result := Format('%2u %u A %6u %5u %s  %s  %s  %s',
                           [WertungsKlasse(kwAltKl,tmTln).AlterVon,5-Integer(FSex),
                            SerPktSort(FSortAkWrtg),Buf,
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('%2u %u B %6u %5u %s  %s  %s  %s',
                           [WertungsKlasse(kwAltKl,tmTln).AlterVon,5-Integer(FSex),
                            SerPktSort(FSortAkWrtg),Buf,
                            FName,FVName,GetMannschName,FWettk.Name]);
      end;

      smTlnSerErgMschName: // in anTlnErgSerie
      begin
        if (FWettk.PunktGleichOrtIndx[tmTln] >= 0) and
           (GetSerOrtRng(FWettk.PunktGleichOrtIndx[tmTln],kwAlle) > 0)
          then Buf := GetSerOrtRng(FWettk.PunktGleichOrtIndx[tmTln],kwAlle)
          else Buf := cnTlnMax+1;
        if GetSerieEndWrtg(FSortAkWrtg) then
          Result := Format('%s  %s  A %6u %5u  %s  %s',
                           [GetMannschName,FWettk.Name,
                            SerPktSort(FSortAkWrtg),Buf,FName,FVName])
        else
          Result := Format('%s  %s  B %6u %5u  %s  %s',
                           [GetMannschName,FWettk.Name,
                            SerPktSort(FSortAkWrtg),Buf,FName,FVName]);
      end;

      smTlnMschSerErg: // anMschErgSerie und SerieWertung Msch
                       // MschIndex nur bei Cup berücksichtigen
        if MannschPtr(FSortAkWrtg)<>nil then
        begin
          if (FWettk.PunktGleichOrtIndx[tmMsch] >= 0) and
             (TMannschObj(MannschPtr(FSortAkWrtg)).RngColl[FWettk.PunktGleichOrtIndx[tmMsch]] > 0)
            then Buf := TMannschObj(MannschPtr(FSortAkWrtg)).RngColl[FWettk.PunktGleichOrtIndx[tmMsch]]
            else Buf := cnTlnMax+1;
          Result := Format('B %6u %5u %s  %u  %s  %s  %s  %s  %s  %s',
                           [TMannschObj(MannschPtr(FSortAkWrtg)).SerPktSort,Buf,
                            TMannschObj(MannschPtr(FSortAkWrtg)).Name,
                            TMannschObj(MannschPtr(FSortAkWrtg)).MschIndex,
                            TMannschObj(MannschPtr(FSortAkWrtg)).Wettk.Name,
                            TMannschObj(MannschPtr(FSortAkWrtg)).Klasse.Name,
                            FName,FVName,GetMannschName,FWettk.Name]);
        end
        else Result := Format('A %s  %s  %s  %s',
                              [FName,FVName,GetMannschName,FWettk.Name]);

      smTlnErstellt:
        if IndexOf(Item) >= 0 then
          Result := Format('%4u',[IndexOf(Item)])
        else
          Result := Format('X %s  %s  %s  %s',
                           [FName,FVName,GetMannschName,FWettk.Name]);
      smTlnBearbeitet:
        with FBearbeitet do
        if Date > 0 then
          Result := Format('%8u %8u %4u %s  %s  %s  %s',
                           [Date,Time,IndexOf(Item),
                            FName,FVName,GetMannschName,FWettk.Name])
        else
          Result := Format('Z %8u %8u %4u %s  %s  %s  %s',
                           [Date,Time,IndexOf(Item),
                            FName,FVName,GetMannschName,FWettk.Name]);
    end;

    if MschAkWrtg <> kwKein then // MschListe
      Result := Format('%s  %s',
                       [TVeranstObj(FVptr).MannschColl.SortString(MannschPtr(MschAkWrtg)),
                        Result]);
  end;
end;

// public Methoden

(*============================================================================*)
constructor TTlnColl.Create(Veranst:Pointer;ItemClass:TTriaObjClass;ProgressBar:TStepProgressBar;TM:TTlnMsch);
(*============================================================================*)
begin
  inherited Create(Veranst,ItemClass);
  if ProgressBar = pbMitStepping then FStepProgressBar := true
                                 else FStepProgressBar := false;
  FReportItems := TReportTlnList.Create;
  FSortItems.Duplicates := true; // gleiche Einträge (ss=ß, mehrere Runden) erlaubt
  FSortMode     := smTlnName; // 2011-2.4 smTlnName Anfangssortierung in AnsFrm
  if TVeranstObj(FVPtr) <> nil
    then FSortOrtIndex := TVeranstObj(FVPtr).OrtIndex
    else FSortOrtIndex := 0;
  FSortWettk    := WettkAlleDummy;
  FSortWrtgMode := wgStandWrtg;
  FSortAkWrtg   := kwAlle;
  FSortKlasse   := AkAlle;
  FSortSMld     := nil;
  FSortStatus   := stGemeldet;
  FTlnMsch      := TM;
  MschAkWrtg    := kwKein;
end;

(*============================================================================*)
destructor TTlnColl.Destroy;
(*============================================================================*)
begin
  FreeAndNil(FReportItems); (*bei RemoveItem abgefragt *)
  inherited Destroy;
end;

(*============================================================================*)
function TTlnColl.AddItem(Item: Pointer): Integer;
(*============================================================================*)
begin
  Result := inherited AddItem(Item);
  if FReportItems.Capacity < FItems.Capacity then
    FReportItems.Capacity := FItems.Capacity;
  if (Result>=0) and (FVPtr=Veranstaltung) and
     (Self=Veranstaltung.TlnColl) then with TTlnObj(Item) do
  begin
    if FSMld<>nil then FSMld.TlnListe.AddItem(Self);
    if FWettk<>nil then
      FWettk.MschModified := true;
  end;
end;

(*============================================================================*)
function TTlnColl.SortModeValid(Item: Pointer): Boolean;
(*============================================================================*)
// Verwendet von TlnObj.SortAdd, TlnColl.Sortieren, ReportSortieren
// Result gilt für letzte Tln
// nur für Listen verwendet, nicht für Wertung
// bei MschSortierung(smMitTlnColl) nicht verwendet, sondern SortListe.Add
begin
  Result := false;
  if (FSortMode=smNichtSortiert) or (Item=nil) then Exit;

  with TTlnObj(Item) do
  begin
    if not TlnInStatus(FSortStatus) then Exit;
    if (FSortSMld <> nil) and (FSortSMld <> FSMld) then Exit;
    case FSortMode of
      smTlnAbs2Startzeit..smTlnAbs8Startzeit:
        if (GetSGrp=nil) or
           (GetSGrp.StartModus[TWkAbschnitt(Integer(FSortMode)-Integer(smTlnAbs2Startzeit)+2)] <> stJagdStart)
          then Exit;
      smTlnSBhn:
        if FWettk.SchwimmDistanz = 0 then Exit; // Checkliste auch ohne Startbahnen
    end;
  end;
  Result := true;
end;

(*============================================================================*)
function TTlnColl.AddSortItem(Item: Pointer): Integer;
(*============================================================================*)
// Verwendet von TlnObj.SortAdd, TlnColl.Sortieren, nicht ReportSortieren
// Result gilt für letzte Tln
// nur für Listen verwendet, nicht für Wertung
// bei MschSortierung(smMitTlnColl) nicht verwendet, sondern SortListe.Add
begin
  with TTlnObj(Item) do
    if SortModeValid(Item) and
       ((FSortWettk=WettkAlleDummy) or (FSortWettk=FWettk)) and
       ((FSortWrtgMode=wgStandWrtg) or GetSondWrtg) and
       TlnInKlasse(FSortKlasse,FTlnMsch) then
      Result := FSortItems.Add(Item)
    else Result := -1;
end;

(*============================================================================*)
procedure TTlnColl.ClearIndex(Indx: Integer);
(*============================================================================*)
var i,j,y   : integer;
    Mannsch : PString;
    Tln     : TTlnObj;
begin
  if (Indx<0)or(Indx>=Count) then Exit;
  Tln := GetPItem(Indx);
  if Tln = nil then Exit;
  Mannsch := nil;

  if (FVPtr=Veranstaltung) and (Self=Veranstaltung.TlnColl) then
  begin
    (* Indx von Staffelvorgänger korrigieren *)
    for i:=0 to Count-1 do
      for j:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
      begin
        y := GetPItem(i).GetOrtStaffelVorg(j);
        if y > Indx then // SetOrtStaffelVorg(j,y-1) nicht benutzen wegen sortieren
          GetPItem(i).FStaffelVorgColl[j] := y-1; // nicht neu sortieren
      end;
    // MannschModified setzen
    Mannsch := Tln.FMannschName;
    if Tln.FWettk<>nil then
      Tln.FWettk.MschModified := true;
  end;

  inherited ClearIndex(Indx);

  (* MannschName Löschen wenn nicht mehr benutzt *)
  // FMannschPtr wird nicht gelöscht
  if (Mannsch <> nil) and (TVeranstObj(FVPtr).MannschNameColl <> nil) then
    TVeranstObj(FVPtr).MannschNameColl.NameLoeschen(Mannsch^);
end;

(*============================================================================*)
procedure TTlnColl.OrtCollExch(Idx1,Idx2:Integer);
(*============================================================================*)
begin
  if (Idx1<0) or (Idx1>TVeranstObj(FVPtr).OrtZahl-1) then Exit;
  if (Idx2<0) or (Idx2>TVeranstObj(FVPtr).OrtZahl-1) then Exit;
  inherited OrtCollExch(Idx1,Idx2);
end;

(*============================================================================*)
function TTlnColl.SnrMax(Wk:TWettkObj;WrtgMode:TWertungMode;Ak:TAkObj;St:TStatus):Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to Count-1 do
    with GetPItem(i) do
      if ((Wk=WettkAlleDummy)or(Wk=FWettk)) and
         ((WrtgMode=wgStandWrtg) or GetSondWrtg) and
          TlnInKlasse(Ak,FTlnMsch) and TlnInStatus(St) and
         (FSnrColl[TVeranstObj(FVPtr).OrtIndex] > Result) then
        Result := FSnrColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*============================================================================*)
function TTlnColl.SnrMin(Wk:TWettkObj;WrtgMode:TWertungMode;Ak:TAkObj;St:TStatus):Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := cnTlnMax;
  for i:=0 to Count-1 do
    with GetPItem(i) do
      if ((Wk=WettkAlleDummy)or(Wk=FWettk)) and
         ((WrtgMode=wgStandWrtg) or GetSondWrtg) and
          TlnInKlasse(Ak,FTlnMsch) and TlnInStatus(St) and
         (FSnrColl[TVeranstObj(FVPtr).OrtIndex] < Result) and
         (FSnrColl[TVeranstObj(FVPtr).OrtIndex] > 0) then
        Result := FSnrColl[TVeranstObj(FVPtr).OrtIndex];
end;

(*============================================================================*)
function TTlnColl.TagesRngMax(Wk:TWettkObj;WrtgMode:TWertungMode;Ak:TAkObj):Integer;
(*============================================================================*)
// für AusgDlg
var i,Rng  : Integer;
    //AkWrtg : TKlassenWertung;
begin
  Result := 0;
  for i:=0 to Count-1 do
    with GetPItem(i) do
      if ((Wk=WettkAlleDummy)or(Wk=FWettk)) and TlnInKlasse(Ak,FTlnMsch) then
      begin
        Rng := TagesRng(wkAbs0,Ak.Wertung,WrtgMode);
        if Rng > Result then Result := Rng;
      end;
end;

(*============================================================================*)
function TTlnColl.SerieRngMax(Wk:TWettkObj;Ak:TAkObj):Integer;
(*============================================================================*)
// für AusgDlg
var i,Rng  : Integer;
begin
  Result := 0;
  for i:=0 to Count-1 do
    with GetPItem(i) do
      if ((Wk=WettkAlleDummy)or(Wk=FWettk)) and TlnInKlasse(Ak,FTlnMsch) then
      begin
        Rng := SerieRang(Ak.Wertung);
        if Rng > Result then Result := Rng;
      end;
end;

(*============================================================================*)
procedure TTlnColl.Sortieren(OrtIndexNeu:Integer; ModeNeu:TSortMode;
                             WettkNeu:TWettkObj;WrtgNeu:TWertungMode;AkNeu:TAkObj;
                             SMldNeu:TSMldObj; StatusNeu:TStatus);
(*============================================================================*)
// sicherheitshalber immer sortieren,
// Problem Schneider mit falsch sortierter Erg.Liste ungeklärt
var i : integer;
begin
  {if (FSortMode     <> ModeNeu)       or
     (FSortWettk    <> WettkNeu)      or
     (FSortWrtgMode <> WrtgNeu)       or
     (FSortAkWrtg   <> AkNeu.Wertung) or //nur bei Serienwertung gesetzt
     (FSortKlasse   <> AkNeu)         or
     (FSortSMld     <> SMldNeu)       or
     (FSortStatus   <> StatusNeu)     or
     (FSortOrtIndex <> OrtIndexNeu) then
  begin}
    if FStepProgressBar and not HauptFenster.ProgressBarStehenLassen then
      HauptFenster.ProgressBarInit('Teilnehmer werden sortiert',FItems.Count);

    FSortOrtIndex  := OrtIndexNeu;
    FSortMode      := ModeNeu;
    FSortWettk     := WettkNeu;
    FSortWrtgMode  := WrtgNeu;
    FSortAkWrtg    := AkNeu.Wertung;
    FSortKlasse    := AkNeu;
    FSortSMld      := SMldNeu;
    FSortStatus    := StatusNeu;

    SortClear;
    if FSortItems.Capacity < FItems.Capacity then
      FSortItems.Capacity := FItems.Capacity;
    for i:=0 to FItems.Count-1 do
    begin
      AddSortItem(GetPItem(i));
      if FStepProgressBar then HauptFenster.ProgressBarStep(1);//nicht bei Msch.TlnListe
    end;
    if FStepProgressBar and not HauptFenster.ProgressBarStehenLassen then
      HauptFenster.StatusBarClear;
  {end;}
end;

(*============================================================================*)
procedure TTlnColl.ReportSortieren;
(*============================================================================*)
// es werden nur ReportItems sortiert. SortMode, etc wie bei SortItems
// entsprechend in LstFrm dargestellte Liste
// für alle Wettk in ReportWkListe
var i,j,k : Integer;
    SortAkWrtgAlt : TKlassenWertung; // nur für Serienwertung
begin
  SortAkWrtgAlt := FSortAkWrtg; // wird bei Sortieren geändert
  FReportItems.Clear;
  for i:=0 to FItems.Count-1 do
  begin
    for j:=0 to ReportWkListe.Count-1 do
      for k:=0 to ReportAkListe.Count-1 do
        FReportItems.Add(GetPItem(i),TReportWkObj(ReportWkListe[j]),ReportAkListe[k]);
    if FStepProgressBar then HauptFenster.ProgressBarStep(1); // MeldungInit vorher
  end;
  FSortAkWrtg := SortAkWrtgAlt; // alter Wert zurücksetzen
end;

(*============================================================================*)
procedure TTlnColl.ReportSortieren(RepWkNeu:TReportWkObj);
(*============================================================================*)
// es werden nur ReportItems sortiert. SortMode, etc wie bei SortItems
// entsprechend in LstFrm dargestellte Liste
var i,k : Integer;
    SortAkWrtgAlt : TKlassenWertung; // nur für Serienwertung
begin
  SortAkWrtgAlt := FSortAkWrtg; // wird bei Sortieren geändert
  FReportItems.Clear;
  for i:=0 to FItems.Count-1 do
  begin
    for k:=0 to ReportAkListe.Count-1 do
      FReportItems.Add(GetPItem(i),RepWkNeu,ReportAkListe[k]);
    if FStepProgressBar then HauptFenster.ProgressBarStep(1); // MeldungInit vorher
  end;
  FSortAkWrtg := SortAkWrtgAlt; // alter Wert zurücksetzen
end;

(*============================================================================*)
procedure TTlnColl.ReportSortieren(RepWkNeu:TReportWkObj;AkNeu:TAkObj);
(*============================================================================*)
// es werden nur ReportItems sortiert. SortMode, etc wie bei SortItems
// entsprechend in LstFrm dargestellte Liste
var i : Integer;
    SortAkWrtgAlt : TKlassenWertung; // nur für Serienwertung
begin
  SortAkWrtgAlt := FSortAkWrtg; // wird bei Sortieren geändert
  FReportItems.Clear;
  for i:=0 to FItems.Count-1 do
  begin
    FReportItems.Add(GetPItem(i),RepWkNeu,AkNeu);
    if FStepProgressBar then HauptFenster.ProgressBarStep(1); // MeldungInit vorher
  end;
  FSortAkWrtg := SortAkWrtgAlt; // alter Wert zurücksetzen
end;

(*============================================================================*)
procedure TTlnColl.ReportClear;
(*============================================================================*)
begin
  FReportItems.Clear;
end;

(*============================================================================*)
function TTlnColl.TlnZahl(Wk:TWettkObj;WrtgMode:TWertungMode;Kl:TAkObj;St:TStatus):Integer;
(*============================================================================*)
begin
  Result := OrtTlnZahl(TVeranstObj(FVptr).OrtIndex,Wk,WrtgMode,Kl,St);
end;

(*============================================================================*)
function TTlnColl.TlnZahl(SM:TSMldObj;Wk:TWettkObj;WrtgMode:TWertungMode;Kl:TAkObj;St:TStatus):Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if ((SM=nil)or(SM=FSmld)) and
       ((FWettk = Wk) or (Wk=WettkAlleDummy)) and
       ((WrtgMode=wgStandWrtg) or SondWrtg) and
        TlnInKlasse(Kl,FTlnMsch) and
        TlnInStatus(St) then Inc(Result);
end;

(*============================================================================*)
function TTlnColl.OrtTlnZahl(Ix:Integer;Wk:TWettkObj;WrtgMode:TWertungMode;Kl:TAkObj;St:TStatus):Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if ((FWettk = Wk) or (Wk=WettkAlleDummy)) and
       ((WrtgMode=wgStandWrtg) or SondWrtg) and
        TlnInKlasse(Kl,FTlnMsch) and
        TlnInOrtStatus(Ix,St) then Inc(Result);
end;

(*============================================================================*)
function TTlnColl.TlnGewertet(Wk:TWettkObj): Integer;
(*============================================================================*)
begin
  Result := OrtTlnGewertet(TVeranstObj(FVptr).OrtIndex,Wk);
end;

(*============================================================================*)
function TTlnColl.OrtTlnGewertet(Ix:Integer;Wk:TWettkObj): Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if ((FWettk = Wk) or (Wk=WettkAlleDummy)) and
       TlnInOrtStatus(Ix,stGewertet) then Inc(Result);
end;

(*============================================================================*)
function TTlnColl.SortTlnGewertet: Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to FSortItems.Count-1 do with GetSortItem(i) do
    if TlnInStatus(stGewertet) then Inc(Result);
end;

(*============================================================================*)
function TTlnColl.TlnEingeteilt(Wk:TWettkObj): Integer;
(*============================================================================*)
begin
  Result := OrtTlnEingeteilt(TVeranstObj(FVptr).OrtIndex,Wk);
end;

(*============================================================================*)
function TTlnColl.TlnGestartet(Wk:TWettkObj):Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if ((FWettk = Wk)or(Wk=WettkAlleDummy)) and
       TlnInStatus(stAbs1Start) then Inc(Result);
end;

(*============================================================================*)
function TTlnColl.MannschNameVorhanden(MschNamePtr:PString): Boolean;
(*============================================================================*)
var i : Integer;
begin
  Result := false;
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if FMannschName = MschNamePtr then
    begin
      Result := true;
      Exit;
    end;
end;

//==============================================================================
function TTlnColl.AlleMschNamenErsetzenErlaubt(MschAlt,MschNeu:String;Wk:TWettkObj): Boolean;
//==============================================================================
// MschAlt='' nicht erlauben, MschNeu='' erlauben
var i : Integer;
    MschAltPtr : PString;
begin
  Result := false;
  MschAltPtr := TVeranstObj(FVPtr).MannschNameColl.GetNamePtr(MschAlt);
  if MschAltPtr = nil then Exit;
  for i:=0 to FItems.Count-1 do
    with GetPItem(i) do
      if (FMannschName = MschAltPtr) and (FWettk = Wk) and  // Tln mit Altem MschName
         (SucheTln(GetPItem(i),FName,FVName,MschNeu,FWettk)<>nil) then // Tln mit neuem MschName
        Exit;
  Result := true;
end;

//==============================================================================
procedure TTlnColl.AlleMschNamenErsetzen(MschAlt,MschNeu:String;Wk:TWettkObj);
//==============================================================================
// MschAlt='' nicht erlauben, MschNeu='' erlauben
var i : Integer;
    MschAltPtr : PString;
begin
  MschAltPtr := TVeranstObj(FVPtr).MannschNameColl.GetNamePtr(MschAlt);
  if MschAltPtr = nil then Exit;
  for i:=0 to FItems.Count-1 do
  with GetPItem(i) do
    if (FMannschName = MschAltPtr) and (FWettk = Wk) then   // Tln mit Altem MschName
      SetMannschName(MschNeu); // Tln mit neuem MschName
end;

(*============================================================================*)
function TTlnColl.OrtTlnEingeteilt(Ix:Integer;Wk:TWettkObj):Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if ((FWettk=Wk)or(Wk=WettkAlleDummy)) and TlnInOrtStatus(Ix,stEingeteilt) then
      Inc(Result);
end;

{(*============================================================================*)
function TTlnColl.OrtTlnGestartet(Ix:Integer;Wk:TWettkObj):Boolean;
(*============================================================================*)
// Wettk gilt als gestartet, wenn irgend ein Tln gestartet ist, egal welche Klasse
var i : Integer;
begin
  Result := false;
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if (FWettk = Wk)or(Wk=WettkAlleDummy) then
      if TlnInOrtStatus(Ix,stAbs1Start) then
      begin
        Result := true;
        Exit;
      end;
end;}

(*============================================================================*)
function TTlnColl.OrtTlnImZiel(Ix:Integer;Wk:TWettkObj):Boolean;
(*============================================================================*)
// Wettk gilt als gestartet, wenn irgend ein Tln ImZiel ist, egal welche Klasse
var i : Integer;
begin
  Result := false;
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if (FWettk = Wk)or(Wk=WettkAlleDummy) then
      if TlnInOrtStatus(Ix,stImZiel) then
      begin
        Result := true;
        Exit;
      end;
end;

{(*============================================================================*)
function TTlnColl.OrteBelegt(Wk:TWettkObj;Klasse:TAkObj): Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  // nicht gestartete Wettk zwischendrin mitzählen
  for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
    if OrtTlnGestartet(i,Wk,Klasse) then Result := i+1;
end;}

(*============================================================================*)
function TTlnColl.SGrpBelegt(Item:TSGrpObj): Boolean;
(*============================================================================*)
var i : Integer;
begin
  Result := false;
  for i:=0 to FItems.Count-1 do
    if GetPItem(i).GetSGrp = Item then
    begin
      Result := true;
      Exit;
    end;
end;

(*============================================================================*)
procedure TTlnColl.SerieWertung(WertungsWk:TWettkObj);
(*============================================================================*)
// Berechnung SeriePunkte und SerieRang für alle Klassen
// Nur pro Einzel-Wettk

type TIndx=(ixRngZahl,ixRngBuff,ixPktBuff,ixOrtRngBuff);

var Tln     : TTlnObj;
    WrtgArr : array of array of array of Integer;

const
  cnDim1=4; //ixRngZahl,ixRngBuff,ixPktBuff,ixOrtRngBuff
  // cnDim2 wird in TlnErg berechnet, max KlasseColl.Count
  cnDim3=2; //Sex: cnMaennlich, cnWeiblich

(*----------------------------------------------------------------------------*)
procedure ClearWrtgArr;
// WrtgArr initialisieren
var j,k,m : integer;
begin
  for j:=0 to cnDim1-2 do
    for k:=0 to WertungsWk.TlnAkZahlMax-1 do
      for m:=0 to cnDim3-1 do WrtgArr[j,k,m] := 0;
  for k:=0 to WertungsWk.TlnAkZahlMax-1 do
    for m:=0 to cnDim3-1 do WrtgArr[Integer(ixOrtRngBuff)-1,k,m] := cnTlnMax;
end;

(*----------------------------------------------------------------------------*)
procedure SetzeSerieRang(const AkWrtg:TKlassenWertung);
// wird pro Tln für alle AkWrtg einzeln ausgeführt:
// AkWrtg = kwAlle,kwSex,kwTlnAk,kwMschAk,kwSondKl
var KlasseIndx,SexIndx : Integer;
begin
  if Tln=nil then Exit;
  if (AkWrtg=kwAlle) or (Tln.Sex=cnMaennlich) then SexIndx := 0
  else if Tln.Sex=cnWeiblich then SexIndx := 1
  else SexIndx := -1; // cnKeinSex erlaubt, nicht gewertet

  // Setze KlasseIndx
  case AkWrtg of
    kwAlle :
      KlasseIndx := 0;
    kwSex :
      if SexIndx >= 0 then KlasseIndx := 0
                      else KlasseIndx := -1;
    kwAltKl:
      case SexIndx of
        0: KlasseIndx := WertungsWk.AltMKlasseColl[tmTln].IndexOf(Tln.WertungsKlasse(kwAltKl,tmTln));
        1: KlasseIndx := WertungsWk.AltWKlasseColl[tmTln].IndexOf(Tln.WertungsKlasse(kwAltKl,tmTln));
        else KlasseIndx := -1;
      end;
    kwSondKl:
      case SexIndx of
        0: KlasseIndx := WertungsWk.SondMKlasseColl.IndexOf(Tln.WertungsKlasse(kwSondKl,tmTln));
        1: KlasseIndx := WertungsWk.SondWKlasseColl.IndexOf(Tln.WertungsKlasse(kwSondKl,tmTln));
        else KlasseIndx := -1;
      end;
    else KlasseIndx := -1;
  end;

  if KlasseIndx >= 0 then
  begin
    Inc(WrtgArr[Integer(ixRngZahl),KlasseIndx,SexIndx]); // RangZahl jedesmal erhöht
    if Tln.SeriePunkte(AkWrtg) <> WrtgArr[Integer(ixPktBuff),KlasseIndx,SexIndx] then
    begin
      WrtgArr[Integer(ixPktBuff),KlasseIndx,SexIndx] := Tln.SeriePunkte(AkWrtg);
      WrtgArr[Integer(ixRngBuff),KlasseIndx,SexIndx] :=
                          WrtgArr[Integer(ixRngZahl),KlasseIndx,SexIndx];
      if WertungsWk.PunktGleichOrtIndx[tmTln] >= 0 then // Wertung bei Punktgleichheit
        WrtgArr[Integer(ixOrtRngBuff),KlasseIndx,SexIndx] :=
            Tln.GetSerOrtRng(WertungsWk.PunktGleichOrtIndx[tmTln],AkWrtg);
    end else
      if WertungsWk.PunktGleichOrtIndx[tmTln] >= 0 then
        // jetzt gilt Wertung in ausgewähltem Ort
        if WrtgArr[Integer(ixOrtRngBuff),KlasseIndx,SexIndx] <>
          Tln.GetSerOrtRng(WertungsWk.PunktGleichOrtIndx[tmTln],AkWrtg) then
        begin
          WrtgArr[Integer(ixRngBuff),KlasseIndx,SexIndx] :=
                 WrtgArr[Integer(ixRngZahl),KlasseIndx,SexIndx];
          WrtgArr[Integer(ixOrtRngBuff),KlasseIndx,SexIndx] :=
            Tln.GetSerOrtRng(WertungsWk.PunktGleichOrtIndx[tmTln],AkWrtg);
        end; // Wertung gleich wie Vorgänger
    Tln.SetSerieRang(WrtgArr[Integer(ixRngBuff),KlasseIndx,SexIndx],AkWrtg);
  end;
end;

(*----------------------------------------------------------------------------*)
procedure KlassenWertung(AkWrtg:TKlassenWertung);
// Berechnung SeriePunkte und SerieRang pro Wertungsklasse
// muss getrennt erfolgen, weil Sortierung unterschiedlich ist
var i: Integer;
begin
  FSortAkWrtg := AkWrtg;
  SortClear;
  for i:=0 to Count-1 do
  begin
    Tln := GetPItem(i);
    with Tln do
      if WertungsWk = FWettk then // Seriewertung nur pro Einzel-Wettk
      begin
        BerechneSeriePunkte(AkWrtg);
        SetSerieRang(0,AkWrtg);
        if GetSerieEndWrtg(AkWrtg) then FSortItems.Add(Tln); //schneller als AddSortItem
      end;
    if FStepProgressBar then HauptFenster.ProgressBarStep(1);
  end;
  ClearWrtgArr;
  for i:=0 to FSortItems.Count-1 do
  begin
    Tln := GetSortItem(i);
    if (Tln.SeriePunkte(AkWrtg) > 0) and
    not Tln.GetAusKonkAllg and
    (not Tln.GetAusKonkAltKl or (AkWrtg<>kwAltKl)) and
    (not Tln.GetAusKonkSondKl or (AkWrtg<>kwSondKl)) then SetzeSerieRang(AkWrtg);
  end;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
// Begin Haupt-Procedure SerieWertung
begin
  if not TVeranstObj(FVPtr).Serie then Exit;

  // zuerst TlnCupWrtgPktColl updaten, wenn nötig
  // in (SerPktMode=spRngDownPkt) sind Punkte abhängig vom max. Rng

  FSortOrtIndex := TVeranstObj(FVPtr).OrtIndex;
  FSortMode     := smTlnSerErg; // sortiert nach SeriePunkte  + OrtGleichRng
  FSortWettk    := WertungsWk;
  FSortWrtgMode := wgStandWrtg;
  FSortKlasse   := AkAlle;
  FSortSMld     := nil;
  FSortStatus   := stGemeldet;

  try
    // 3-dimensionales dynamisches Array WrtgArr anlegen
    SetLength(WrtgArr,cnDim1,WertungsWk.TlnAkZahlMax,cnDim3);
    KlassenWertung(kwAlle);
    KlassenWertung(kwSex);
    KlassenWertung(kwAltKl);
    KlassenWertung(kwSondKl);

  finally
    WrtgArr := nil;
  end;

end;

(*============================================================================*)
procedure TTlnColl.SetAlleSerienWrtg(SerienWrtgNeu: Boolean);
(*============================================================================*)
var i: Integer;
begin
  for i:=0 to FItems.Count-1 do
    with GetPItem(i) do
    begin
      FSerienWrtg := SerienWrtgNeu;
      if FWettk<>nil then
        FWettk.MschModified := true;
    end;
end;

(*============================================================================*)
function TTlnColl.SucheTln(Selbst:TTlnObj;NameNeu,VNameNeu,MannschNeu:String;
                           WettkNeu:TWettkObj): TTlnObj;
(*============================================================================*)
// nur nach dieser Methode unterschiedliche Obj werden in Coll aufgenommen
// Aufnahme NICHT erlauben bei nur Groß/Klein-Unterschied
// Aufnahme erlauben bei nur ss/ß-Unterschied
// Tln=Selbst<>nil wird bei Suche ausgeschlossen
// Leer- und Steuierzeichen ignorieren
var i : Integer;
    S : String;
begin
  Result := nil;
  if MannschNeu <> cnKein then S := MannschNeu
                          else S := '';
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if GetPItem(i) <> Selbst then
      if TxtGleich(FWettk.Name,WettkNeu.Name) and
         TxtGleich(FName,NameNeu) and
         TxtGleich(FVName,VNameNeu) and
         TxtGleich(GetMannschName,S) then
      begin
        Result := GetPItem(i);
        Exit;
      end;
end;

(*============================================================================*)
function TTlnColl.WettkTlnZahl(Item: TWettkObj): Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to FItems.Count-1 do
    if GetPItem(i).FWettk = Item then Inc(Result);
end;

(*============================================================================*)
function TTlnColl.WettkSBhnTlnZahl(Item:TWettkObj; Bahn:Integer): Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if ((Item=WettkAlleDummy)or(FWettk=Item)) and (GetStrtBahn = Bahn) then
      Inc(Result);
end;

(*============================================================================*)
function TTlnColl.SGrpTlnZahl(Item:TSGrpObj): Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to FItems.Count-1 do
    if GetPItem(i).GetSGrp = Item then Inc(Result);
end;

(*============================================================================*)
function TTlnColl.SBhnTlnZahl(Item:TSGrpObj; Bahn:Integer): Integer;
(*============================================================================*)
var i : Integer;
begin
  Result := 0;
  for i:=0 to FItems.Count-1 do with GetPItem(i) do
    if (GetSGrp = Item) and (GetStrtBahn = Bahn) then Inc(Result);
end;

(*============================================================================*)
function TTlnColl.TlnMitSnr(Sn:Integer): TTlnObj;
(*============================================================================*)
var i : Integer;
begin
  Result := nil;
  for i:=0 to FItems.Count-1 do
    if GetPItem(i).GetSnr = Sn then
    begin
      Result := GetPItem(i);
      Exit;
    end;
end;

(*============================================================================*)
function TTlnColl.ErsteFreieSnr(const Sg:TSGrpObj) : Integer;
(*============================================================================*)
// sucht die erste freie Startnummer in der Startgruppe
var i : Integer;
    SnrBelegtArr : array of Boolean; // kostet zeit,vorher berechnen
begin
  Result := 0;
  try
    // Setze SnrBelegtArr
    SetLength(SnrBelegtArr, Sg.StartnrBis - Sg.StartnrVon + 1);
    for i:=0 to FItems.Count-1 do
    with GetPItem(i) do
      if (GetSnr >= Sg.StartnrVon) and
         (GetSnr <= Sg.StartnrBis) then
        SnrBelegtArr[GetSnr - Sg.StartnrVon] := true;

    for i:=0 to Sg.StartnrBis - Sg.StartnrVon do
      if not SnrBelegtArr[i] then
      begin
        Result := i + Sg.StartnrVon;
        Exit;
      end;

  finally
    SnrBelegtArr := nil;
  end;
end;

{==============================================================================}
function TTlnColl.TlnAusserTagWrtg(Wk:TWettkObj;Wrtg:TWertungMode;Klasse:TAkObj;
                                   Status:TStatus):Boolean;
{==============================================================================}
var i : Integer;
begin
  Result := false;
  for i:=0 to FItems.Count-1 do
    with GetPItem(i) do
      if ((Wk=WettkAlleDummy) or (Wk=FWettk)) and
         ((Wrtg=wgStandWrtg) or GetSondWrtg) and TlnInKlasse(Klasse,FTlnMsch) and
         (GetAusKonkAllg or
          (GetAusKonkAltKl and (Klasse.Wertung = kwAltKl)) or
          (GetAusKonkSondKl and (Klasse.Wertung = kwSondKl)) ) and
         TlnInStatus(Status) then
      begin
        Result := true;
        Exit;
      end;
end;

{==============================================================================}
function TTlnColl.TlnAusserSerWrtg(Wk:TWettkObj;Klasse:TAkObj;Status:TStatus):Boolean;
{==============================================================================}
var i : Integer;
begin
  Result := false;
  for i:=0 to FItems.Count-1 do
    with GetPItem(i) do
      if ((Wk=WettkAlleDummy) or (Wk=FWettk)) and
         TlnInKlasse(Klasse,FTlnMsch) and
         not FSerienWrtg and
         TlnInStatus(Status) then
      begin
        Result := true;
        Exit;
      end;
end;

{==============================================================================}
function TTlnColl.LandDefiniert(Wk:TWettkObj;Wrtg:TWertungMode): Boolean;
{==============================================================================}
var i : Integer;
begin
  Result := false;
  for i:=0 to FItems.Count-1 do
  with GetPItem(i) do
    if ((Wk=WettkAlleDummy) or (Wk=FWettk)) and
       ((Wrtg=wgStandWrtg) or GetSondWrtg) and
       (FLand <> '') then
    begin
      Result := true;
      Exit;
    end;
end;

{==============================================================================}
function TTlnColl.SondWrtgDefiniert(Wk:TWettkObj): Boolean;
{==============================================================================}
var i : Integer;
begin
  Result := false;
  for i:=0 to FItems.Count-1 do
  with GetPItem(i) do
    if (Wk=WettkAlleDummy) or (Wk=FWettk) then
      if GetSondWrtg then
      begin
        Result := true;
        Exit;
      end;
end;

{==============================================================================}
function TTlnColl.ZeitStrafe(Wk:TWettkObj;Wrtg:TWertungMode;Klasse:TAkObj;
                             Status:TStatus): Boolean;
{==============================================================================}
var i : Integer;
begin
  Result := false;
  for i:=0 to FItems.Count-1 do
    with GetPItem(i) do
      if ((Wk=WettkAlleDummy) or (Wk=FWettk)) and
         ((Wrtg=wgStandWrtg) or GetSondWrtg) and
         (FStrafZeitColl[TVeranstObj(FVPtr).OrtIndex] >=0) and
         TlnInKlasse(Klasse,FTlnMsch) and
         TlnInStatus(Status) then
      begin
        Result := true;
        Exit;
      end;
end;

{==============================================================================}
procedure TTlnColl.UpdateKlassen(Wk:TWettkObj);
{==============================================================================}
var i : Integer;
begin
  if Wk=WettkAlleDummy then
    for i:=0 to FItems.Count-1 do
    begin
      with GetPItem(i) do KlassenSetzen;
      if FStepProgressBar then HauptFenster.ProgressBarStep(1);
    end
  else
    if TVeranstObj(FVptr).WettkColl.IndexOf(Wk) >= 0 then // nicht für DTUColl
      for i:=0 to FItems.Count-1 do
      begin
        with GetPItem(i) do if FWettk=Wk then KlassenSetzen;
        if FStepProgressBar then HauptFenster.ProgressBarStep(1);
      end;
end;

{==============================================================================}
procedure TTlnColl.ClearKlassen(Wk:TWettkObj);
{==============================================================================}
var i : Integer;
begin
  if Wk=WettkAlleDummy then
    for i:=0 to FItems.Count-1 do
      with GetPItem(i) do KlassenLoeschen
  else
    if TVeranstObj(FVptr).WettkColl.IndexOf(Wk) >= 0 then // nicht für DTUColl
      for i:=0 to FItems.Count-1 do
        with GetPItem(i) do if FWettk=Wk then KlassenLoeschen;
end;

//==============================================================================
procedure TTlnColl.SetzeTlnStZeit(Abs:TWkAbschnitt;Wk:TWettkObj);
//==============================================================================
// wkAbs1..wkAbs8
var i : Integer;
begin
  for i:=0 to FItems.Count-1 do
    with GetPItem(i) do
      if ((Wk=WettkAlleDummy) or (Wk=FWettk)) then
        SetStrtZeit(Abs);
end;

//==============================================================================
procedure TTlnColl.ClearTlnStZeit(Wk:TWettkObj; SG:TSGrpObj);
//==============================================================================
var i : Integer;
begin
  for i:=0 to FItems.Count-1 do
    with GetPItem(i) do
      if ((Wk=WettkAlleDummy) or (Wk=FWettk)) and (SGrp = SG) then
      begin
        SetZtErfZeit(wkAbs1,0,-1);
        SetStoppZeit(wkAbs1,0,-1);
      end;
end;

//==============================================================================
procedure TTlnColl.UpdateRundenZahl(Abs:TWkAbschnitt;Wk:TWettkObj);
//==============================================================================
// in WettkDlg aufgerufen, nur akt. OrtIndex
var i : Integer;
begin
  for i:=0 to FItems.Count-1 do
    with GetPItem(i) do
      //HauptFenster.ProgressBarStep(1);
      if ((Wk=WettkAlleDummy) or (Wk=FWettk)) then
        UpdateRundenZahl(Abs);
end;

(*============================================================================*)
procedure TTlnColl.ZeitenRunden(Ix:Integer; Wk:TWettkObj; Abs:TWkAbschnitt);
(*============================================================================*)
// wkAbs1..wkAbs8
// eingelesen Zeiten stehen in ErfZeit als Original
// manuell eingetragene, geänderte oder importierte Zeiten nur in AufRndZeit
// AufRndZeit entsprechend ZeitFormat gerundet speichern
// bei alle in ErfZeit eingelesen Zeiten die Reihenfolge der Zeiten beibehalten,
// unabhängig von Runde
// ProgressBar Step = 3 * TlnColl.Count
// nur individuell pro Wettk (Wk <> WettkAlleDummy)
var i,j,Inkr,
    ZeitNeu,
    ZeitAlt,
    ZeitNeuGerundet,
    ZeitAltGerundet,
    Ueberlauf: Integer;
    TlnPtr : TTlnObj;
    ErfZeitColl: TZEColl;
    ZEObj : TZEObj;
begin
  // alle ErfZeiten für alle Tln und alle Runden in Coll sortieren
  HauptFenster.ProgressBarStep(Count);
  ErfZeitColl := TZEColl.Create(Veranstaltung,TZEObj);

  if Wk=WettkAlleDummy then Exit;

  for i:=0 to Count-1 do
  begin
    TlnPtr := GetPItem(i);
    if TlnPtr.FWettk = Wk then
      for j:=0 to Wk.OrtAbschnRunden[Ix,Abs] do // auch Startzeit (j=0)
      begin
        ZeitNeu := TlnPtr.GetZeitRecColl(Ix,Abs).GetErfZeit(j);
        if ZeitNeu >= 0 then // ErfZeit vorhanden
        begin
          TlnPtr.GetZeitRecColl(Ix,Abs).SetAufRndZeit(j,-1); // AufRndZeit löschen
          ZEObj := TZEObj.Create(Veranstaltung,ErfZeitColl,oaAdd);
          with ZEObj do
          begin
            Tln   := TlnPtr;
            Runde := j; // Index, nicht Runde
            EinleseZeit  := ZeitNeu;
          end;
          ErfZeitColl.AddItem(ZEObj); // nach Zeit sortiert
        end else // keine ErfZeit vorhanden, AufRndZeit runden
        begin
          ZeitNeu := TlnPtr.GetZeitRecColl(Ix,Abs).GetAufRndZeit(j);
          if ZeitNeu > 0 then
            TlnPtr.GetZeitRecColl(Ix,Abs).SetAufRndZeit(j,ZeitRunden(ZeitNeu));
        end;
      end;
  end;

  ZeitAlt         := -1;
  ZeitAltGerundet := -1;
  Ueberlauf       :=  0;
  case ZeitFormat of
    zfSek     : Inkr := 100;
    zfZehntel : Inkr := 10;
    else        Inkr := 0; // zfHundertstel, nicht runden
  end;

  // Zuerst Überlauf 24:00:00 berechnen, Zeit noch nicht ändern
  HauptFenster.ProgressBarStep(Count);
  for i:=0 to ErfZeitColl.SortCount-1 do // alle ErfZeiten
  with ErfZeitColl.SortItems[i] do
  begin
    ZeitNeu := EinleseZeit;
    ZeitNeuGerundet := ZeitRundenMitUeberlauf(ZeitNeu);
    // wenn gerundete Sek gleich und hundertstel ungleich wird angepasst
    if ZeitNeuGerundet > ZeitAltGerundet then
      ZeitAltGerundet := ZeitNeuGerundet
    else
      if ZeitNeu <> ZeitAlt then
        ZeitAltGerundet := ZeitAltGerundet + Inkr;
      //else ZeitAltGerundet unverändert
    if ZeitAltGerundet >= cnZeit24_00 then Ueberlauf := Ueberlauf + Inkr; // 24:00:00
    ZeitAlt := ZeitNeu;
  end;

  // jetzt umrechnen und Überlauf bei 24:00:00 berücksichtigen
  ZeitAlt := -1;
  ZeitAltGerundet := Ueberlauf - Inkr;
  HauptFenster.ProgressBarStep(Count);
  for i:=0 to ErfZeitColl.SortCount-1 do // alle ErfZeiten
  with ErfZeitColl.SortItems[i] do
  begin
    ZeitNeu := EinleseZeit;
    ZeitNeuGerundet := ZeitRundenMitUeberlauf(ZeitNeu);
    if ZeitNeuGerundet > ZeitAltGerundet then
      ZeitAltGerundet := ZeitNeuGerundet
    else
      if ZeitNeu <> ZeitAlt then
        ZeitAltGerundet := ZeitAltGerundet + Inkr;
      //else ZeitAltGerundet unverändert
    ZeitNeuGerundet := ZeitAltGerundet; // ZeitAlt auch über 24:00:00 zählen
    if ZeitNeuGerundet >= cnZeit24_00 then
      ZeitNeuGerundet := ZeitNeuGerundet - cnZeit24_00; //24:00:00 => 00:00:00
    Tln.GetZeitRecColl(Ix,Abs).SetAufRndZeit(Runde,ZeitNeuGeRundet);
    ZeitAlt := ZeitNeu;
  end;

  Wk.OrtErgModified[Ix] := true;
  FreeAndNil(ErfZeitColl);
end;


(*============================================================================*)
(*         Methoden von TReportTlnObj                                         *)
(*============================================================================*)

{==============================================================================}
constructor TReportTlnObj.Create(TlnNeu:TTlnObj; ReportWkNeu:TWettkObj;
                                 ReportWrtgNeu:TWertungMode; ReportAkneu:TAkObj);
{==============================================================================}
begin
  TlnPtr     := TlnNeu;
  ReportWk   := ReportWkNeu;
  ReportWrtg := ReportWrtgNeu;
  ReportAk   := ReportAkNeu;
end;

{==============================================================================}
function TReportTlnObj.GetReportAkSortStr: String;
{==============================================================================}
begin
  with ReportAk do
    case Wertung of
      kwAlle   : Result := 'a'; // Alle Tln immer an 1. Stelle
      kwSex    : if Sex=cnMaennlich then Result := 'bM'  // Männer zuerst
                 else if Sex=cnWeiblich then Result := 'bW' // cnWeiblich
                 else if Sex=cnMixed then Result := 'bX' // cnMixed
                 else Result := 'bZ'; // cnKeinSex
      kwAltKl  : if Sex=cnMaennlich then Result := 'c'+strng(AlterVon,2)+'M'
                                    else Result := 'c'+strng(AlterVon,2)+'W';
      kwSondKl : if Sex=cnMaennlich then Result := 'd'+strng(AlterVon,2)+'M'
                                    else Result := 'd'+strng(AlterVon,2)+'W';
      else Result := 'x';
    end;
end;

{==============================================================================}
function TReportTlnObj.GetReportSondWrtgStr: String;
{==============================================================================}
begin
  case ReportWrtg of
    wgStandWrtg : Result := 'a';
    wgSondWrtg  : Result := 'b';
  end;
end;

(******************************************************************************)
(*         Methoden von TReportTlnList                                        *)
(******************************************************************************)

(*----------------------------------------------------------------------------*)
function TReportTlnList.SortString(Item:TReportTlnObj): String;
(*----------------------------------------------------------------------------*)
begin
  Result := Format('%s  %s  %s  %s',
                   [Veranstaltung.WettkColl.SortString(Item.ReportWk),
                    Item.GetReportSondWrtgStr,
                    Item.GetReportAkSortStr,
                    Veranstaltung.TlnColl.SortString(Item.TlnPtr)]);
end;

(*============================================================================*)
function TReportTlnList.Add(Item:TTlnObj;RepWkNeu:TReportWkObj;AkNeu:TAkObj):Integer;
(*============================================================================*)
// bei MschAnsicht nicht verwendet, nur von TlnColl.ReportSortieren
var RepTln : TReportTlnObj;
begin
  Result := -1;
  if Item=nil then Exit;

  if ((RepWkNeu.Wettk=WettkAlleDummy) or (RepWkNeu.Wettk=Item.FWettk)) and
     ((RepWkNeu.Wrtg=wgStandWrtg) or Item.SondWrtg) then
  begin
   // für Serienwertung muss SortAkWrtg gesetzt werden, damit die Klassenbezogene
   // Serienpunkte benutzt werden und für SortModeValid(Status)
    Veranstaltung.TlnColl.SortAkWrtg := AkNeu.Wertung;
    if Veranstaltung.TlnColl.SortModeValid(Item) and
       Item.TlnInKlasse(AkNeu,tmTln) then
      if ((HauptFenster.Ansicht <> anTlnErg) or
         (Item.TagesRng(wkAbs0,AkNeu.Wertung,RepWkNeu.Wrtg) >= ReportRngVon) and
         (Item.TagesRng(wkAbs0,AkNeu.Wertung,RepWkNeu.Wrtg) <= ReportRngBis) and
         (Item.GetSnr >= ReportSnrVon) and
         (Item.GetSnr <= ReportSnrBis)) and
         ((HauptFenster.Ansicht <> anTlnErgSerie) or
          (Item.SerieRang(AkNeu.Wertung) >= ReportRngVon) and
          (Item.SerieRang(AkNeu.Wertung) <= ReportRngBis)) then
      begin
        RepTln := TReportTlnObj.Create(Item,RepWkNeu.Wettk,RepWkNeu.Wrtg,AkNeu);
        if not Find(RepTln, Result) then Insert(Result,RepTln)
                                    else RepTln.Free;
      end;
  end;
end;

(*============================================================================*)
function TReportTlnList.Find(Item:TReportTlnObj; var Indx:Integer): Boolean;
(*============================================================================*)
var
  L, H, I, C: Integer;
begin
  Result := false;
  L := 0;
  H := Count-1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Compare(Items[I],Item);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := true;
        L := I;
      end;
    end;
  end;
  Indx := L;
end;

(*============================================================================*)
function TReportTlnList.Compare(Item1, Item2: TReportTlnObj): Integer;
(*============================================================================*)
// Reihenfolge nach AnsiCompareStr: Groß/Klein-Buchstaben unterscheiden, ss/ß nicht
begin
  Result := AnsiCompareStr(SortString(Item1),SortString(Item2));
  // Unterschied ss/ß berücksichtigen
  if Result = 0 then
    Result := CompareStr(SortString(Item1),SortString(Item2));
end;


end.
