unit WettkObj;

interface

uses
  Windows,Classes,SysUtils,Dialogs,Controls,Math,
  AllgConst,Allgfunc,AllgObj,AkObj,OrtObj;

type
  TSerWrtgPktRec = record
    RngVon,RngBis,PktVon,PktIncr : Integer;
  end;
  PSerWrtgPktRec = ^TSerWrtgPktRec;
  
  TSerWrtgPktColl = class(TTriaColl)
  protected
    function  GetBPObjType: Word; override;
    function  GetPItem(Indx:Integer): PSerWrtgPktRec;
    procedure SetPItem(Indx:Integer; Item:PSerWrtgPktRec);
    procedure FreeItem(Item: Pointer); override;
    function  LoadItem(Indx:Integer): Boolean; override;
    function  StoreItem(Indx:Integer): Boolean; override;
  public
    constructor Create(Veranst:Pointer);
    function  Add(Rec:TSerWrtgPktRec): Integer;
    function  GetCupPkt(Rng:integer): Integer;
    function  CupPktIncr: Boolean;
    property Items[Indx: Integer]: PSerWrtgPktRec read GetPItem write SetPItem; default;
  end;

  TRngMaxAkColl = class(TTriaColl) // pro AkCollItem eine Coll mit MaxRng pro Ort
  protected
    function  GetPItem(Indx:Integer): TWordCollection;
    procedure SetPItem(Indx:Integer; Coll:TWordCollection);
    procedure FreeItem(Item: Pointer); override;
    function  LoadItem(Indx:Integer): Boolean; override;
    function  StoreItem(Indx:Integer): Boolean; override;
  public
    AkRngColl : TAkColl; // AkColl gilt f�r alle Orte
    constructor Create(Veranst:Pointer;AkCollNeu:TAkColl);
    procedure Init;
    procedure SetRng(Klasse:TAkObj; Rng:Integer);
    procedure OrtAdd; // Rng pro Ort f�r alle Ak's
    procedure OrtClear(Indx:Integer);
    procedure OrtExch(Idx1,Idx2:Integer);
    //function AkAdd(Rng: Integer): Integer;
    property Items[Indx: Integer]: TWordCollection read GetPItem write SetPItem; default;
  end;


  TWettkObj = Class(TTriaObj)
  protected
    // allgemeine Daten
    // bei WettkAlleDummy: FVPtr=Veranstaltung=nil m�glich
    FName                  : String;
    FStreichErg,
    FStreichOrt            : array[tmTln..tmMsch] of Integer;
    FPflichtWkMode         : array[tmTln..tmMsch] of TPflichtWkMode;
    FSerWrtgJahr           : Integer; // nur bei Serienwertung benutzt
    FPflichtWkOrt1,
    FPflichtWkOrt2,
    FPunktGleichOrt        : array[tmTln..tmMsch] of TOrtObj; // Favorite Ort bei Punktgleichheit
    FMschWertg             : TMschWertung;
    FMannschModified       : Boolean;
    FKlassenModified       : Boolean;
    FMaennerKlasse         : array[tmTln..tmMsch] of TAkObj; // nur Name gespeichert
    FFrauenKlasse          : array[tmTln..tmMsch] of TAkObj;
    FSerWrtgMode           : array[tmTln..tmMsch] of TSerWrtgMode;
    FSerWrtgPktColl        : array[tmTln..tmMsch] of TSerWrtgPktColl;

    // Ortsbezogene Daten
    FStandTitelColl        : TTextCollection;
    FSondTitelColl         : TTextCollection; // 2005: Sonderwertung pro wettk
    FDatumColl             : TTextCollection;
    FDisqTxtColl           : TTextCollection; // 2015
    FWettkArtColl          : TWordCollection;
    FMschWrtgModeColl      : TWordCollection;
    FMschGrAlleColl        : TWordCollection;
    FMschGrMaennerColl     : TWordCollection; // 2011-2.4, nicht f�r Liga
    FMschGrFrauenColl      : TWordCollection; // 2011-2.4, nicht f�r Liga
    FMschGrMixedColl       : TWordCollection; // 2011-2.4, nicht f�r Liga
    FSchwimmDistanzColl    : TWordCollection;
    FStartBahnenColl       : TWordCollection;
    FErgModifiedColl       : TBoolCollection;
    FAbschnZahlColl        : TWordCollection;
    FAbschnNameCollArr     : array [wkAbs1..wkAbs8] of TTextCollection;
    FTlnTxtColl            : TTextCollection;
    FAbsMaxRndCollArr      : array [wkAbs1..wkAbs8] of TWordCollection;
    FRundLaengeColl        : TIntegerCollection; // 2015 f�r StundenRennen
    FStartgeldColl         : TIntegerCollection; // 2015  Startgeld in Cent

    FRngMaxAlleColl,         // f�r Serien-Punktwertung mit spRngDownPkt
    FRngMaxMaennerColl,      // RngMax f�r jede Klasse nach Berechnung festhalten
    FRngMaxFrauenColl      : array[tmTln..tmMsch] of TWordCollection; // Wert pro Ort
    FRngMaxMixedColl       : TWordCollection; // Wert pro Ort, nur f�r tmMsch
    FRngMaxAkMColl,
    FRngMaxAkWColl         : array[tmTln..tmMsch] of TRngMaxAkColl; // pro Klasse Wert pro Ort
    FRngMaxSkMColl,
    FRngMaxSkWColl         : TRngMaxAkColl; // pro Klasse Wert pro Ort, nur tmTln

    function    GetBPObjType: Word; override;
    procedure   SetName(NameNeu:String);
    function    GetStreichErg(TlnMsch:TTlnMsch): Integer;
    procedure   SetStreichErg(TlnMsch:TTlnMsch; const StreichErgNeu:integer);
    function    GetStreichOrt(TlnMsch:TTlnMsch): Integer;
    procedure   SetStreichOrt(TlnMsch:TTlnMsch; const StreichOrtNeu:integer);
    function    GetSerWrtgJahr: Integer;
    procedure   SetSerWrtgJahr(const JahrNeu: Integer);
    function    GetPflichtWkMode(TlnMsch:TTlnMsch): TPflichtWkMode;
    procedure   SetPflichtWkMode(TlnMsch:TTlnMsch; PflichtWkModeNeu:TPflichtWkMode);
    function    GetPflichtWkOrt1(TlnMsch:TTlnMsch): TOrtObj;
    procedure   SetPflichtWkOrt1(TlnMsch:TTlnMsch; OrtNeu:TOrtObj);
    function    GetPflichtWkOrt1Indx(TlnMsch:TTlnMsch): Integer;
    procedure   SetPflichtWkOrt1Indx(TlnMsch:TTlnMsch; IndxNeu:Integer);
    function    GetPflichtWkOrt2(TlnMsch:TTlnMsch): TOrtObj;
    procedure   SetPflichtWkOrt2(TlnMsch:TTlnMsch; OrtNeu:TOrtObj);
    function    GetPflichtWkOrt2Indx(TlnMsch:TTlnMsch): Integer;
    procedure   SetPflichtWkOrt2Indx(TlnMsch:TTlnMsch; IndxNeu:Integer);
    function    GetPunktGleichOrt(TlnMsch:TTlnMsch): TOrtObj;
    procedure   SetPunktGleichOrt(TlnMsch:TTlnMsch; OrtNeu:TOrtObj);
    function    GetPunktGleichOrtIndx(TlnMsch:TTlnMsch): Integer;
    procedure   SetPunktGleichOrtIndx(TlnMsch:TTlnMsch; IndxNeu:Integer);
    function    GetMschWertg: TMschWertung;
    procedure   SetMschWertg(WertgNeu:TMschWertung);
    function    GetSerWrtgMode(TlnMsch:TTlnMsch): TSerWrtgMode;
    procedure   SetSerWrtgMode(TlnMsch:TTlnMsch;SerWrtgModeNeu:TSerWrtgMode);
    function    GetSerWrtgPktColl(TlnMsch:TTlnMsch): TSerWrtgPktColl;
    procedure   SetMannschModified(ModifiedNeu:Boolean);
    procedure   SetKlassenModified(ModifiedNeu:Boolean);
    function    GetErgModified: Boolean;
    function    GetOrtErgModified(Indx:Integer): Boolean;
    procedure   SetErgModified(ModifiedNeu:Boolean);
    procedure   SetOrtErgModified(Indx:Integer; ModifiedNeu:Boolean);
    function    GetOrtStandTitel(Indx:Integer): String;
    function    GetStandTitel: String;
    procedure   SetOrtStandTitel(Indx:Integer; StandTitelNeu:String);
    procedure   SetStandTitel(StandTitelNeu:String);
    function    GetSondWrtg: Boolean;
    function    GetSondTitel: String;
    function    GetOrtSondTitel(Indx:Integer): String;
    procedure   SetSondTitel(SondTitelNeu:String);
    procedure   SetOrtSondTitel(Indx:Integer; SondTitelNeu:String);
    function    GetDatum: String;
    procedure   SetDatum(const DatumNeu: String);
    function    GetOrtDatum(Indx:Integer): String;
    procedure   SetOrtDatum(Indx:Integer; const DatumNeu: String);
    function    GetOrtJahr(Indx:Integer): Integer;
    function    GetDisqTxt: String;
    procedure   SetDisqTxt(const TextNeu: String);
    function    GetJahr: Integer;
    function    GetMaennerKlasse(TlnMsch:TTlnMsch):TAkObj;
    function    GetFrauenKlasse(TlnMsch:TTlnMsch):TAkObj;
    procedure   SetMaennerKlasse(TlnMsch:TTlnMsch;AkNeu:TAkObj);
    procedure   SetFrauenKlasse(TlnMsch:TTlnMsch;AkNeu:TAkObj);
    function    GetWettkArt: TWettkArt;
    procedure   SetWettkArt(WkArtNeu:TWettkArt);
    function    GetOrtWettkArt(Indx:Integer): TWettkArt;
    //procedure   SetOrtWettkArt(Indx:Integer; WkArtNeu:TWettkArt);
    function    GetMschWrtgMode: TMschWrtgMode;
    procedure   SetMschWrtgMode(MschWrtgModeNeu:TMschWrtgMode);
    function    GetOrtMschWrtgMode(Indx:Integer): TMschWrtgMode;
    procedure   SetOrtMschWrtgMode(Indx:Integer; MschWrtgModeNeu:TMschWrtgMode);
    function    GetMschGroesse(Sx:TSex): Integer;
    procedure   SetMschGroesse(Sx:TSex; Groesse:Integer);
    function    GetOrtMschGroesse(Sx:TSex;Indx:Integer): Integer;
    procedure   SetOrtMschGroesse(Sx:TSex;Indx:Integer; Groesse:Integer);
    function    GetSchwimmDistanz: Integer;
    function    GetOrtSchwimmDistanz(Indx:Integer): Integer;
    procedure   SetSchwimmDistanz(SchwimmDistanz:Integer);
    procedure   SetOrtSchwimmDistanz(Indx:Integer; SchwimmDistanz:Integer);
    function    GetStartBahnen: Integer;
    function    GetOrtStartBahnen(Indx:Integer): Integer;
    procedure   SetStartBahnen(StartBahnen:Integer);
    procedure   SetOrtStartBahnen(Indx:Integer; StartBahnen:Integer);
    function    GetAbschnZahl: Integer;
    procedure   SetAbschnZahl(ZahlNeu:Integer);
    function    GetOrtAbschnZahl(Indx:Integer): Integer;
    //procedure   SetOrtAbschnZahl(Indx,ZahlNeu:Integer);
    function    GetAbschnNameColl(Abschnitt:TWkAbschnitt): TTextCollection;
    function    GetAbschnName(Abschnitt:TWkAbschnitt): String;
    procedure   SetAbschnName(Abschnitt:TWkAbschnitt;NameNeu:String);
    function    GetOrtAbschnName(Indx:Integer;Abschnitt:TWkAbschnitt): String;
    procedure   SetOrtAbschnName(Indx:Integer;Abschnitt:TWkAbschnitt;NameNeu:String);
    function    GetTlnTxt: String;
    function    GetAbsMaxRunden(Abschnitt:TWkAbschnitt): Integer;
    procedure   SetAbsMaxRunden(Abschnitt:TWkAbschnitt;RundenNeu:Integer);
    //function    GetOrtAbschnRunden(Indx:Integer;Abschnitt:TWkAbschnitt): Integer;
    procedure   SetTlnTxt(TxtNeu:String);
    function    GetOrtTlnTxt(Indx:Integer): String;
    procedure   SetOrtTlnTxt(Indx:Integer;TxtNeu:String);
    function    GetRundLaenge: Integer;
    function    GetOrtRundLaenge(Indx:Integer): Integer;
    procedure   SetRundLaenge(RundLaenge:Integer);
    procedure   SetOrtRundLaenge(Indx:Integer; RundLaenge:Integer);
    function    GetStartgeld: Integer;
    function    GetOrtStartgeld(Indx:Integer): Integer;
    procedure   SetStartgeld(Startgeld:Integer);
    procedure   SetOrtStartgeld(Indx:Integer; Startgeld:Integer);

  public
    TlnAkZahlMax,
    MschAkZahlMax    : Integer;            // f�r Ergebnisse Berechnen
    TlnImZielColl    : array[tmTln..tmMsch] of TBoolCollection; // nur bei Serienwertung benutzt
    OrtZahlGestartet : array[tmTln..tmMsch] of Integer; // nur bei Serienwertung benutzt
    SerPktBuffColl   : TIntSortCollection; // nur bei Serienwertung benutzt
    AltMKlasseColl   : array[tmTln..tmMsch] of TAkColl; // alle AltersKlassen
    AltWKlasseColl   : array[tmTln..tmMsch] of TAkColl; // alle AltersKlassen
    SondMKlasseColl  : TAkColl; // alle SonderKlassen, nur Tln-Wertung
    SondWKlasseColl  : TAkColl; // alle SonderKlassen, nur Tln-Wertung

    constructor Create(Veranst:Pointer;Coll:TTriaObjColl;Add:TOrtAdd); override;
    destructor  Destroy; override;
    function    Load: Boolean; override;
    function    Store: Boolean; override;
    procedure   OrtCollAdd; override;
    procedure   OrtCollClear(Indx:Integer); override;
    procedure   OrtCollExch(Idx1,Idx2:Integer); override;
    procedure   SetWettkAllgDaten(Name: String;
                                  StreichErgTlnNeu,StreichErgMschNeu:Integer;
                                  StreichOrtTlnNeu,StreichOrtMschNeu: Integer;
                                  PflichtWkModeTlnNeu,PflichtWkModeMschNeu: TPflichtWkMode;
                                  PflichtWkOrt1TlnNeu,PflichtWkOrt1MschNeu,
                                  PflichtWkOrt2TlnNeu,PflichtWkOrt2MschNeu: TOrtObj;
                                  PunktGleichOrtTlnNeu,PunktGleichOrtMschNeu:TOrtObj;
                                  MschWertgNeu:TMschWertung;
                                  SerWrtgJahrNeu:Integer;
                                  TlnSerWrtgModeNeu,MschSerWrtgModeNeu:TSerWrtgMode);
    procedure   SetWettkOrtDaten(StandTitelNeu,SondTitelNeu,DatumNeu:String;
                                 WettkArtNeu:TWettkArt;AbschnZahlNeu,
                                 Abs1RndNeu,Abs2RndNeu,Abs3RndNeu,Abs4RndNeu,
                                 Abs5RndNeu,Abs6RndNeu,Abs7RndNeu,Abs8RndNeu:Integer;
                                 Abs1NameNeu,Abs2NameNeu,Abs3NameNeu,Abs4NameNeu,
                                 Abs5NameNeu,Abs6NameNeu,Abs7NameNeu,Abs8NameNeu,
                                 TlnTxtNeu:String; MschWrtgModeNeu:TMschWrtgMode;
                                 {MannschGrAnmNeu,MannschGrStrtNeu,}MschGrAlleNeu,
                                 MschGrMaennerNeu,MschGrFrauenNeu,MschGrMixedNeu,
                                 SchwimmDistanzNeu,StartBahnenNeu,
                                 RundLaengeNeu,StartgeldNeu:Integer;
                                 DisqTxtNeu:String);
    function    GetTlnAlter(Jg:Integer): Integer;
    function    GetKlasse(TlnMsch:TTlnMsch;AkWrtg:TKlassenWertung;Sx:TSex;Jg:Integer):TAkObj;
    function    MschGroesseMin: Integer;
    function    MschGroesseMax: Integer;
    procedure   KlasseCollKopieren(ZielColl,QuelColl:TAkColl);
    procedure   KlassenKopieren(Wk:TWettkObj);
    function    OrtSerPkt(TlnMsch:TTlnMsch;Indx:Integer;Klasse:TAkObj;Rng:Integer): Integer;
    function    CupPktIncr(TlnMsch:TTlnMsch): Boolean;
    function    EinzelWettk: Boolean;
    function    EinzelStart: Boolean;
    function    MschWettk: Boolean;
    function    RundenWettk: Boolean;
    function    TlnOrtSerWertung(Indx:Integer): Boolean;
    function    MschOrtSerWertung(Indx:Integer): Boolean;
    function    SexSortMode: TSortMode;
    function    JgLang(J:String): Integer;
    function    LangeAkKuerzel: Boolean;
    procedure   RngMaxCollUpdate(Coll:TAkColl);
    procedure   SetSerRngMax(TlnMsch:TTlnMsch;Klasse:TAkObj;Rng:Integer);
    function    ObjSize: Integer; override;

    property Name            : String read FName write SetName;
    property MschWertg       : TMschWertung read GetMschWertg write SetMschWertg;
    property MschModified    : Boolean read FMannschModified write SetMannschModified;
    property KlassenModified : Boolean read FKlassenModified write SetKlassenModified;
    property ErgModified     : Boolean read GetErgModified write SetErgModified;
    property OrtErgModified[Indx: Integer]: Boolean read GetOrtErgModified write SetOrtErgModified;
    property OrtStandTitel[Indx: Integer] : String read GetOrtStandTitel ; //write SetOrtStandTitel;
    property StandTitel      : String read GetStandTitel ; //write SetStandTitel;
    property SondWrtg        : Boolean read GetSondWrtg;
    property SondTitel       : String read GetSondTitel write SetSondTitel;
    property OrtSondTitel[Indx: Integer] : String read GetOrtSondTitel write SetOrtSondTitel;
    property Datum           : String read GetDatum write SetDatum;
    property OrtDatum[Indx: Integer]: String read GetOrtDatum write SetOrtDatum;
    property OrtJahr[Indx: Integer]: Integer read GetOrtJahr;
    property MaennerKlasse[TlnMsch:TTlnMsch] : TAkObj read GetMaennerKlasse write SetMaennerKlasse;
    property FrauenKlasse[TlnMsch:TTlnMsch]  : TAkObj read GetFrauenKlasse write SetFrauenKlasse;
    property Jahr            : Integer read GetJahr;
    property WettkArt        : TWettkArt read GetWettkArt write SetWettkArt;
    property OrtWettkArt[Indx: Integer]: TWettkArt read GetOrtWettkArt {write SetOrtWettkArt};
    property MschWrtgMode    : TMschWrtgMode read GetMschWrtgMode write SetMschWrtgMode;
    property OrtMschWrtgMode[Indx: Integer] : TMschWrtgMode read GetOrtMschWrtgMode write SetOrtMschWrtgMode;
    property MschGroesse[Sx:TSex] : Integer read GetMschGroesse write SetMschGroesse;
    property OrtMschGroesse[Sx:TSex;Indx:Integer]: Integer read GetOrtMschGroesse write SetOrtMschGroesse;
    property SchwimmDistanzColl : TWordCollection read FSchwimmDistanzColl write FSchwimmDistanzColl;
    property SchwimmDistanz  : Integer read GetSchwimmDistanz write SetSchwimmDistanz;
    property OrtSchwimmDistanz[Indx: Integer] : Integer read GetOrtSchwimmDistanz write SetOrtSchwimmDistanz;
    property OrtStartBahnen[Indx: Integer] : Integer read GetOrtStartBahnen write SetOrtStartBahnen;
    property StartBahnen     : Integer read GetStartBahnen write SetStartBahnen;
    property OrtRundLaenge[Indx: Integer] : Integer read GetOrtRundLaenge write SetOrtRundLaenge;
    property RundLaenge      : Integer read GetRundLaenge write SetRundLaenge;
    property AbschnZahl      : Integer read GetAbschnZahl {write SetAbschnZahl};
    property OrtAbschnZahl[Indx: Integer]: Integer read GetOrtAbschnZahl {write SetOrtAbschnZahl};
    property AbschnName[Abschnitt:TWkAbschnitt] : String
                               read GetAbschnName write SetAbschnName;
    property OrtAbschnName[Indx: Integer;Abschnitt:TWkAbschnitt] : String
                               read GetOrtAbschnName write SetOrtAbschnName;
    property TlnTxt          : String read GetTlnTxt write SetTlnTxt;
    property DisqTxt         : String read GetDisqTxt write SetDisqTxt;
    property AbsMaxRunden[Abschnitt:TWkAbschnitt]: Integer read GetAbsMaxRunden ;
    property OrtTlnTxt[Indx:Integer]: String read GetOrtTlnTxt write SetOrtTlnTxt;
    property OrtStartgeld[Indx: Integer] : Integer read GetOrtStartgeld write SetOrtStartgeld;
    property Startgeld        : Integer read GetStartgeld write SetStartgeld;
    // Serienwertung
    property StreichErg[TlnMsch:TTlnMsch]         : Integer read GetStreichErg write SetStreichErg;
    property StreichOrt[TlnMsch:TTlnMsch]         : Integer read GetStreichOrt write SetStreichOrt;
    property SerWrtgJahr                          : Integer read GetSerWrtgJahr write SetSerWrtgJahr;
    property PflichtWkMode[TlnMsch:TTlnMsch]      : TPflichtWkMode read GetPflichtWkMode write SetPflichtWkMode;
    property PflichtWkOrt1[TlnMsch:TTlnMsch]      : TOrtObj read GetPflichtWkOrt1 write SetPflichtWkOrt1;
    property PflichtWkOrt1Indx[TlnMsch:TTlnMsch]  : Integer read GetPflichtWkOrt1Indx write SetPflichtWkOrt1Indx;
    property PflichtWkOrt2[TlnMsch:TTlnMsch]      : TOrtObj read GetPflichtWkOrt2 write SetPflichtWkOrt2;
    property PflichtWkOrt2Indx[TlnMsch:TTlnMsch]  : Integer read GetPflichtWkOrt2Indx write SetPflichtWkOrt2Indx;
    property PunktGleichOrt[TlnMsch:TTlnMsch]     : TOrtObj read GetPunktGleichOrt write SetPunktGleichOrt;
    property PunktGleichOrtIndx[TlnMsch:TTlnMsch] : Integer read GetPunktGleichOrtIndx write SetPunktGleichOrtIndx;
    property SerWrtgMode[TlnMsch:TTlnMsch]        : TSerWrtgMode read GetSerWrtgMode write SetSerWrtgMode;
    property SerWrtgPktColl[TlnMsch:TTlnMsch]     : TSerWrtgPktColl read GetSerWrtgPktColl {write SetCupWrtgPktColl};
  end;

  TWettkColl = Class(TTriaObjColl)
  protected
    function    GetBPObjType: Word; override;
    function    GetPItem(Indx:Integer): TWettkObj;
    procedure   SetPItem(Indx:Integer; Item:TWettkObj);
    function    GetSortItem(Indx:Integer): TWettkObj;
  public
    constructor Create(Veranst:Pointer;ItemClass:TTriaObjClass);
    function    SortString(Item: Pointer): String; override;
    function    Compare(Item1, Item2: Pointer): Integer; override;
    function    Load: Boolean; override;
    function    Store: Boolean; override;
    procedure   OrtCollExch(Idx1,Idx2:Integer); override;
    procedure   Sortieren(SortModeNeu: TSortMode);
    function    MannschWettk: Boolean;
    function    AlleAbschnGleich: Boolean;
    function    AlleMitSchwDistanz: Boolean;
    function    KeinOderAlleTlnStaffel: Boolean;
    property Items[Indx: Integer]: TWettkObj read GetPItem write SetPItem; default;
    property SortItems[Indx:Integer]:TWettkObj read GetSortItem;
  end;

  TReportWkObj = class(TObject)
    Wettk : TWettkObj;
    Wrtg  : TWertungMode;
    constructor Create(WkNeu:TWettkObj; WrtgNeu:TWertungMode);
    function Name: String;
  end;

  var WettkAlleDummy : TWettkObj; // f�r AnsFrame/Sortwettk wenn Veranstaltung=nil

implementation

uses TriaMain,VeranObj,DateiDlg, ZtEinlDlg, TlnObj;


(******************************************************************************)
(*  Methoden von TSerWrtgPktColl                                              *)
(******************************************************************************)

// protected Methoden

//------------------------------------------------------------------------------
function TSerWrtgPktColl.GetBPObjType: Word;
//------------------------------------------------------------------------------
(* Object Types aus Version 7.4 Stream Registration Records *)
begin
  Result := rrCupWrtgColl;
end;

//------------------------------------------------------------------------------
function TSerWrtgPktColl.GetPItem(Indx:Integer): PSerWrtgPktRec;
//------------------------------------------------------------------------------
begin
  Result := PSerWrtgPktRec(inherited GetPItem(Indx));
end;

//------------------------------------------------------------------------------
procedure TSerWrtgPktColl.SetPItem(Indx:Integer; Item:PSerWrtgPktRec);
//------------------------------------------------------------------------------
begin
  inherited SetPItem(Indx,Item);
end;

//------------------------------------------------------------------------------
procedure TSerWrtgPktColl.FreeItem(Item: Pointer);
//------------------------------------------------------------------------------
begin
  if Item <> nil then FreeMem(Item,SizeOf(TSerWrtgPktRec));
end;

//------------------------------------------------------------------------------
function TSerWrtgPktColl.LoadItem(Indx:Integer): Boolean;
//------------------------------------------------------------------------------
var R : TSerWrtgPktRec;
    P : PSerWrtgPktRec;
begin
  Result := false;
  try
    with TriaStream do
    begin
      ReadBuffer(R.RngVon,cnSizeOfInteger);
      ReadBuffer(R.RngBis,cnSizeOfInteger);
      ReadBuffer(R.PktVon,cnSizeOfInteger);
      ReadBuffer(R.PktIncr,cnSizeOfInteger);
    end;
    New(P); P^ := R;
    if AddItem(P) = Indx then Result := true;
  except
    Exit;
  end;
end;

//------------------------------------------------------------------------------
function TSerWrtgPktColl.StoreItem(Indx:Integer): Boolean;
//------------------------------------------------------------------------------
begin
  Result := false;
  try
    if (Indx>=0) and (Indx<Count) and (GetPItem(Indx) <> nil) then
    with TriaStream do with GetPItem(Indx)^ do
    begin
      WriteBuffer(RngVon,cnSizeOfInteger);
      WriteBuffer(RngBis,cnSizeOfInteger);
      WriteBuffer(PktVon,cnSizeOfInteger);
      WriteBuffer(PktIncr,cnSizeOfInteger);
      Result := true;
    end;
  except
    Exit;
  end;
end;

// public Methoden

//==============================================================================
constructor TSerWrtgPktColl.Create(Veranst:Pointer);
//==============================================================================
begin
  inherited Create(Veranst);
  FItemSize := SizeOf(TSerWrtgPktRec);
end;

//==============================================================================
function TSerWrtgPktColl.Add(Rec:TSerWrtgPktRec): Integer;
//==============================================================================
var P : PSerWrtgPktRec;
begin
  New(P);
  P^:= Rec;
  Result := AddItem(P);
end;

//==============================================================================
function TSerWrtgPktColl.GetCupPkt(Rng:integer): Integer;
//==============================================================================
// 0 <= Punkte <= cnTlnMax+1 (= 10.000)
var i : Integer;
begin
  if Count > 0 then
  begin
    if GetPItem(0).PktIncr > 0 then // Increment
      with GetPItem(Count-1)^ do
        Result := PktVon + (RngBis-RngVon)*PktIncr + 1 // 1 mehr als letzter Platz
    else Result := 0; // bei Decr immer 0 Punkte

    if (Rng > 0) and (Rng <= GetPItem(Count-1).RngBis) then // gewertet und gepunktet
      for i:=0 to Count-1 do
        with GetPItem(i)^ do
          if Rng <= RngBis then
          begin
            Result := PktVon + (Rng-RngVon)*PktIncr; // immer >0, <=cnTlnMax
            Exit;
          end;
  end
  else Result := 0;
end;

//==============================================================================
function TSerWrtgPktColl.CupPktIncr: Boolean;
//==============================================================================
begin
  if GetPItem(0).PktIncr > 0 then Result := true
                             else Result := false;
end;

(******************************************************************************)
(*   Methoden von TRngMaxAkColl                                               *)
(******************************************************************************)

// protected Methoden

//------------------------------------------------------------------------------
function TRngMaxAkColl.GetPItem(Indx:Integer): TWordCollection;
//------------------------------------------------------------------------------
begin
  Result := TWordCollection(inherited GetPItem(Indx));
end;

//------------------------------------------------------------------------------
procedure TRngMaxAkColl.SetPItem(Indx:Integer; Coll:TWordCollection);
//------------------------------------------------------------------------------
begin
  inherited SetPItem(Indx,Coll);
end;

//------------------------------------------------------------------------------
procedure TRngMaxAkColl.FreeItem(Item: Pointer);
//------------------------------------------------------------------------------
begin
  if Item <> nil then TWordCollection(Item).Free;
end;

//------------------------------------------------------------------------------
function TRngMaxAkColl.LoadItem(Indx:Integer): Boolean;
//------------------------------------------------------------------------------
begin
  // nicht benutzt, nur um Compiler-Warnung zu vermeiden
  Result := false;
end;

//------------------------------------------------------------------------------
function TRngMaxAkColl.StoreItem(Indx:Integer): Boolean;
//------------------------------------------------------------------------------
begin
  // nicht benutzt, nur um Compiler-Warnung zu vermeiden
  Result := false;
end;

// public Methoden

//==============================================================================
constructor TRngMaxAkColl.Create(Veranst:Pointer;AkCollNeu:TAkColl);
//==============================================================================
begin
  inherited Create(Veranst);
  AkRngColl := AkCollNeu;
  FItemSize := SizeOf(TWordCollection);
end;

//==============================================================================
procedure TRngMaxAkColl.Init;
//==============================================================================
// f�r alle Orte und alle Klassen Rng=0
var C : TWordCollection;
    i,j : Integer;
begin
  Clear; // alte Klassen l�schen
  for i:=0 to AkRngColl.Count-1 do // neue Klassen �bernehmen
  begin
    C := TWordCollection.Create(FVPtr);
    for j:=0 to TVeranstObj(FVPtr).OrtZahl-1 do C.Add(0);
    AddItem(C);
  end;
end;

//==============================================================================
procedure TRngMaxAkColl.SetRng(Klasse:TAkObj; Rng:Integer);
//==============================================================================
// aktueller OrtIndex
begin
  if (AkRngColl.IndexOf(Klasse) >= 0) and (AkRngColl.IndexOf(Klasse) < Count) then
    Items[AkRngColl.IndexOf(Klasse)][TVeranstObj(FVPtr).OrtIndex] := Rng;
end;

//==============================================================================
procedure TRngMaxAkColl.OrtAdd;
//==============================================================================
// f�r jede Ak ein neuer Rng=0 in RngColl addieren
var i : Integer;
begin
  for i:=0 to Count-1 do
    Items[i].Add(0); // Fehler/Exception ignorieren. In OrtCollAdd pr�fen???????
end;


//==============================================================================
procedure TRngMaxAkColl.OrtClear(Indx:Integer);
//==============================================================================
// f�r jede Ak Rng f�r Ort=Indx in RngColl l�schen
var i : Integer;
begin
  for i:=0 to Count-1 do
    Items[i].ClearIndex(Indx); // Indx wird in ClearIndx gepr�ft
end;

//==============================================================================
procedure TRngMaxAkColl.OrtExch(Idx1,Idx2:Integer);
//==============================================================================
// f�r jede Ak Rng f�r Ort=Ind1,2 in RngColl t�uschen
var i : Integer;
begin
  for i:=0 to Count-1 do
    Items[i].List.Exchange(Idx1,Idx2);
end;

(******************************************************************************)
(*                      Methoden von TWettkObj                                *)
(******************************************************************************)

// protected Methoden

//------------------------------------------------------------------------------
function TWettkObj.GetBPObjType: Word;
//------------------------------------------------------------------------------
(* Object Types aus Version 7.4 Stream Registration Records *)
begin
  Result := rrWettkObj;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetName(NameNeu:String);
//------------------------------------------------------------------------------
begin
  if NameNeu <> FName then
    FName := Trim(NameNeu);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetStreichErg(TlnMsch:TTlnMsch): Integer;
//------------------------------------------------------------------------------
// von 0 (=default) bis OrtZahl-1
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and TVeranstObj(FVPtr).Serie then
    Result := Min(FStreichErg[TlnMsch],TVeranstObj(FVPtr).OrtZahl-1)
  else Result := 0;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetStreichErg(TlnMsch:TTlnMsch; const StreichErgNeu:integer);
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if StreichErgNeu <> GetStreichErg(TlnMsch) then
    begin
      FStreichErg[TlnMsch] := StreichergNeu;
      if FVPtr=Veranstaltung then
        for i:=0 to Veranstaltung.OrtZahl-1 do
          if Veranstaltung.TlnColl.OrtTlnEingeteilt(i,Self)>0 then
            SetOrtErgmodified(i,true);
    end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetStreichOrt(TlnMsch:TTlnMsch): Integer;
//------------------------------------------------------------------------------
// von 0 (default, Wertung in allen Orte Pflicht) bis OrtZahl-1 (1 MindestWettk)
// StreichOrt = OrtZahl - MindestWettk
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and TVeranstObj(FVPtr).Serie then
    Result := Min(FStreichOrt[TlnMsch],TVeranstObj(FVPtr).OrtZahl-1)
  else Result := 0;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetStreichOrt(TlnMsch:TTlnMsch; const StreichOrtNeu:Integer);
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if StreichOrtNeu <> GetStreichOrt(TlnMsch) then
    begin
      FStreichOrt[TlnMsch] := StreichOrtNeu;
      if FVPtr=Veranstaltung then
        for i:=0 to Veranstaltung.OrtZahl-1 do
          if Veranstaltung.TlnColl.OrtTlnEingeteilt(i,Self)>0 then
            SetOrtErgmodified(i,true);
    end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetSerWrtgJahr: Integer;
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil) and (Self<>WettkAlleDummy) and TVeranstObj(FVPtr).Serie then
    if FSerWrtgJahr > 0 then
      Result := FSerWrtgJahr
    else                      // bis FSerWrtgJahr im SerWrtgDlg gesetzt wurde
      Result := GetOrtJahr(0) // gilt Datum im 1. Ort
  else Result := 0;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetSerWrtgJahr(const JahrNeu: Integer);
//------------------------------------------------------------------------------
// nur f�r Altersklassenberechnung bei Serie benutzt
// wird in SerWrtgDlg gesetzt
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if JahrNeu <> FSerWrtgJahr then
    begin
      FSerWrtgJahr := JahrNeu;
      if FVPtr = Veranstaltung then SetKlassenModified(true);
    end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetPflichtWkMode(TlnMsch:TTlnMsch): TPflichtWkMode;
//------------------------------------------------------------------------------
begin
  if TVeranstObj(FVPtr).Serie and
    ((GetStreichErg(TlnMsch) > 0) or (GetStreichOrt(TlnMsch) > 0)) then
    Result := FPflichtWkMode[TlnMsch]
  else Result := pw0;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetPflichtWkMode(TlnMsch:TTlnMsch; PflichtWkModeNeu:TPflichtWkMode);
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if PflichtWkModeNeu <> GetPflichtWkMode(TlnMsch) then
    begin
      FPflichtWkMode[TlnMsch] := PflichtWkModeNeu;
      if FVPtr=Veranstaltung then
        for i:=0 to Veranstaltung.OrtZahl-1 do
          if Veranstaltung.TlnColl.OrtTlnEingeteilt(i,Self)>0 then
            SetOrtErgmodified(i,true);
    end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetPflichtWkOrt1(TlnMsch:TTlnMsch): TOrtObj;
//------------------------------------------------------------------------------
begin
  if GetPflichtWkMode(TlnMsch) = pw0 then Result := nil //FVPtr in GetPflichtWkMode gepr�ft
  else Result := FPflichtWkOrt1[TlnMsch];
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetPflichtWkOrt1(TlnMsch:TTlnMsch; OrtNeu:TOrtObj);
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if OrtNeu <> GetPflichtWkOrt1(TlnMsch) then
    begin
      FPflichtWkOrt1[TlnMsch] := OrtNeu;
      if FVPtr=Veranstaltung then
        for i:=0 to Veranstaltung.OrtZahl-1 do
          if Veranstaltung.TlnColl.OrtTlnEingeteilt(i,Self)>0 then
            SetOrtErgmodified(i,true);
    end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetPflichtWkOrt1Indx(TlnMsch:TTlnMsch): Integer;
//------------------------------------------------------------------------------
begin
  if GetPflichtWkOrt1(TlnMsch)<>nil then // FVPtr in GetPflichtWkMode gepr�ft
    Result := TVeranstObj(FVPtr).OrtColl.IndexOf(FPflichtWkOrt1[TlnMsch])
  else Result := -1;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetPflichtWkOrt1Indx(TlnMsch:TTlnMsch; IndxNeu:Integer);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if (IndxNeu >= 0) and (IndxNeu < TVeranstObj(FVPtr).OrtColl.Count) then
      SetPflichtWkOrt1(TlnMsch,TVeranstObj(FVPtr).OrtColl[IndxNeu])
    else SetPflichtWkOrt1(TlnMsch,nil);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetPflichtWkOrt2(TlnMsch:TTlnMsch): TOrtObj;
//------------------------------------------------------------------------------
begin
  case GetPflichtWkMode(TlnMsch) of //FVPtr,WettkAlleDummy in GetPflichtWkMode gepr�ft
    pw0,pw1 : Result := nil;
    else Result := FPflichtWkOrt2[TlnMsch]; // pw1v2,pw2
  end;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetPflichtWkOrt2(TlnMsch:TTlnMsch; OrtNeu:TOrtObj);
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if OrtNeu <> GetPflichtWkOrt2(TlnMsch) then
    begin
      FPflichtWkOrt2[TlnMsch] := OrtNeu;
      if FVPtr=Veranstaltung then
        for i:=0 to Veranstaltung.OrtZahl-1 do
          if Veranstaltung.TlnColl.OrtTlnEingeteilt(i,Self)>0 then
            SetOrtErgmodified(i,true);
    end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetPflichtWkOrt2Indx(TlnMsch:TTlnMsch): Integer;
//------------------------------------------------------------------------------
begin
  if GetPflichtWkOrt2(TlnMsch)<>nil then //FVPtr,WettkAlleDummy in GetPflichtWkMode gepr�ft
    Result := TVeranstObj(FVPtr).OrtColl.IndexOf(FPflichtWkOrt2[TlnMsch])
  else Result := -1;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetPflichtWkOrt2Indx(TlnMsch:TTlnMsch; IndxNeu:Integer);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if (IndxNeu >= 0) and (IndxNeu < TVeranstObj(FVPtr).OrtColl.Count) then
      SetPflichtWkOrt2(TlnMsch,TVeranstObj(FVPtr).OrtColl[IndxNeu])
    else SetPflichtWkOrt2(TlnMsch,nil);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetPunktGleichOrt(TlnMsch:TTlnMsch): TOrtObj;
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and TVeranstObj(FVPtr).Serie and
     (FPunktGleichOrt[TlnMsch]<>nil) and
     (TVeranstObj(FVPtr).OrtColl.IndexOf(FPunktGleichOrt[TlnMsch]) >= 0) then
    Result := FPunktGleichOrt[TlnMsch]
  else Result := nil;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetPunktGleichOrt(TlnMsch:TTlnMsch; OrtNeu:TOrtObj);
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if OrtNeu <> GetPunktGleichOrt(TlnMsch) then
    begin
      FPunktGleichOrt[TlnMsch] := OrtNeu;
      if FVPtr=Veranstaltung then
        for i:=0 to Veranstaltung.OrtZahl-1 do
          if Veranstaltung.TlnColl.OrtTlnEingeteilt(i,Self)>0 then
            SetOrtErgmodified(i,true);
    end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetPunktGleichOrtIndx(TlnMsch:TTlnMsch): Integer;
//------------------------------------------------------------------------------
begin
  if GetPunktGleichOrt(TlnMsch)<>nil then //FVPtr,WettkAlleDummy in GetPunktGleichOrt gepr�ft
    Result := TVeranstObj(FVPtr).OrtColl.IndexOf(FPunktGleichOrt[TlnMsch])
  else Result := -1;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetPunktGleichOrtIndx(TlnMsch:TTlnMsch; IndxNeu:Integer);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if (IndxNeu >= 0) and (IndxNeu < TVeranstObj(FVPtr).OrtColl.Count) then
      SetPunktGleichOrt(TlnMsch,TVeranstObj(FVPtr).OrtColl[IndxNeu])
    else SetPunktGleichOrt(TlnMsch,nil);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetMschWertg: TMschWertung;
//------------------------------------------------------------------------------
begin
  if (FVPtr=nil) or (Self=WettkAlleDummy) then
    Result := mwKein
  else
    Result := FMschWertg
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetMschWertg(WertgNeu:TMschWertung);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if WertgNeu <> FMschWertg then
    begin
      FMschWertg := WertgNeu;
      if FVPtr=Veranstaltung then SetMannschModified(true);
    end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetSerWrtgMode(TlnMsch:TTlnMsch): TSerWrtgMode;
//------------------------------------------------------------------------------
begin
  if (FVPtr=nil) or (Self=WettkAlleDummy) then
    Result := swRngUpPkt
  else Result := FSerWrtgMode[TlnMsch];
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetSerWrtgMode(TlnMsch:TTlnMsch;SerWrtgModeNeu:TSerWrtgMode);
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if SerWrtgModeNeu <> FSerWrtgMode[TlnMsch] then
    begin
      FSerWrtgMode[TlnMsch] := SerWrtgModeNeu;
      if FVPtr=Veranstaltung then
        for i:=0 to Veranstaltung.OrtZahl-1 do
          if Veranstaltung.TlnColl.OrtTlnEingeteilt(i,Self)>0 then
            SetOrtErgmodified(i,true);
    end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetSerWrtgPktColl(TlnMsch:TTlnMsch): TSerWrtgPktColl;
//------------------------------------------------------------------------------
begin
  if (FVPtr=nil) or (Self=WettkAlleDummy) then
    Result := nil
  else Result := FSerWrtgPktColl[TlnMsch];
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetMannschModified(ModifiedNeu:Boolean);
//------------------------------------------------------------------------------
// alle Mannschaften werden gel�scht und neu eingelesen (MschEinlesen in TlnErg aufgerufen)
// Wertungen f�r alle Orte neu berechnen
// Staffelvorg m�ssen neu definiert und
// MschStartzeiten neu berechnet werden.
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
  begin
    FMannschModified := ModifiedNeu;
    if ModifiedNeu and (FVPtr=Veranstaltung) then
      SetOrtErgModified(-1,true);
  end;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetKlassenModified(ModifiedNeu:Boolean);
//------------------------------------------------------------------------------
// wenn true werden alle Modifieds gesetzt
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
  begin
    FKlassenModified := ModifiedNeu;
    if ModifiedNeu and (FVPtr=Veranstaltung) then
      SetMannschModified(true);// auch ErgModified f�r alle Orte
  end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetErgModified: Boolean;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtErgModified(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtErgModified(-1);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtErgModified(Indx:Integer): Boolean;
//------------------------------------------------------------------------------
var i: Integer;
begin
  Result := false;
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    if (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
      Result := FErgModifiedColl[Indx]
    else if Indx=-1 then // �ber alle Orte pr�fen
      for i:=0 to FErgModifiedColl.Count-1 do
        if FErgModifiedColl[i] then
        begin
          Result := true;
          Exit;
        end;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetErgModified(ModifiedNeu:Boolean);
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    SetOrtErgModified(TVeranstObj(FVPtr).OrtIndex,ModifiedNeu);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtErgModified(Indx:Integer; ModifiedNeu:Boolean);
//------------------------------------------------------------------------------
var i,Min,Max : Integer;
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
  begin
    if Indx=-1 then begin Min := 0; Max := TVeranstObj(FVPtr).OrtZahl-1; end
               else begin Min := Indx; Max:=Indx; end;
    for i:=Min to Max do
      FErgModifiedColl[i] := ModifiedNeu;
    if ModifiedNeu then Rechnen := true;
  end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtStandTitel(Indx:Integer): String;
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    Result := FStandTitelColl[Indx]
  else Result := '';
  if Result = '' then Result := FName;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetStandTitel: String;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtStandTitel(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtStandTitel(-1);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtStandTitel(Indx:Integer; StandTitelNeu:String);
//------------------------------------------------------------------------------
// StandTitel niemals ''
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy)  and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    FStandTitelColl[Indx] := Trim(StandTitelNeu);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetStandTitel(StandTitelNeu:String);
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    SetOrtStandTitel(TVeranstObj(FVPtr).OrtIndex,StandTitelNeu);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetSondWrtg: Boolean;
//------------------------------------------------------------------------------
begin
  Result := not StrGleich(GetSondTitel,'');
end;

//------------------------------------------------------------------------------
function TWettkObj.GetSondTitel: String;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtSondTitel(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtSondTitel(-1);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtSondTitel(Indx:Integer): String;
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    Result := FSondTitelColl[Indx]
  else Result := '';
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetSondTitel(SondTitelNeu:String);
//------------------------------------------------------------------------------
// SondTitel = '', wenn keine Sonderwertung definiert wurde
begin
  if FVPtr<>nil then
    SetOrtSondTitel(TVeranstObj(FVPtr).OrtIndex,SondTitelNeu);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtSondTitel(Indx:Integer; SondTitelNeu:String);
//------------------------------------------------------------------------------
// SondTitel = '', wenn keine Sonderwertung definiert wurde
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    FSondTitelColl[Indx] := Trim(SondTitelNeu);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetDatum: String;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtDatum(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtDatum(-1);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtDatum(Indx:Integer): String;
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    if Self <> WettkAlleDummy then
      Result := FDatumColl[Indx]
    else
    if (FVPtr=Veranstaltung) and (Veranstaltung.WettkColl.Count > 0) then
      Result := Veranstaltung.WettkColl[0].OrtDatum[Indx]
    else
      Result := SystemDatum
  else Result := SystemDatum;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtDatum(Indx:Integer; const DatumNeu: String);
//------------------------------------------------------------------------------
var S : String;
begin
  S := DatumStr(DatumNeu); // Trennzeichen ignorieren
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) and
     (DatumWert(S) > 0) and (FDatumColl[Indx] <> S) then
  begin
    FDatumColl[Indx] := S;
    SetKlassenModified(true);
  end;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetDatum(const DatumNeu: String);
//------------------------------------------------------------------------------
// datum niemals ''
begin
  if FVPtr<>nil then
    SetOrtDatum(TVeranstObj(FVPtr).OrtIndex,DatumNeu);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtJahr(Indx:Integer): Integer;
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    Result := StrToIntDef(Copy(GetOrtDatum(Indx),7,4),0)
  else Result := 0;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetDisqTxt: String;
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil) and (Self <> WettkAlleDummy) then
    Result := FDisqTxtColl[TVeranstObj(FVPtr).OrtIndex]
  else Result := cnDisqNameDefault;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetDisqTxt(const TextNeu: String);
//------------------------------------------------------------------------------
begin
  if TextNeu <> '' then
    FDisqTxtColl[TVeranstObj(FVPtr).OrtIndex] := TextNeu;
end;
//------------------------------------------------------------------------------
function TWettkObj.GetJahr: Integer;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtJahr(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtJahr(-1);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetMaennerKlasse(TlnMsch:TTlnMsch):TAkObj;
//------------------------------------------------------------------------------
begin
  Result := FMaennerKlasse[TlnMsch];
end;

//------------------------------------------------------------------------------
function TWettkObj.GetFrauenKlasse(TlnMsch:TTlnMsch):TAkObj;
//------------------------------------------------------------------------------
begin
  Result := FFrauenKlasse[TlnMsch];
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetMaennerKlasse(TlnMsch:TTlnMsch;AkNeu:TAkObj);
//------------------------------------------------------------------------------
// nur Name �ndern
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    FMaennerKlasse[TlnMsch].Name := Trim(AkNeu.Name);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetFrauenKlasse(TlnMsch:TTlnMsch;AkNeu:TAkObj);
//------------------------------------------------------------------------------
// nur Name �ndern
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) then
    FFrauenKlasse[TlnMsch].Name := Trim(AkNeu.Name);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetWettkArt: TWettkArt;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtWettkArt(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtWettkArt(-1);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetWettkArt(WkArtNeu:TWettkArt);
//------------------------------------------------------------------------------
// WkArt: [waEinzel,waMschStaffel,waMschTeam,waInt3,waInt4,waTlnStaffel,waRndRennen,waStndRennen,waTlnTeam]
var AbsCnt   : TWkAbschnitt;
    WkArtAlt : TWettkArt;
begin
  if (FVPtr<>nil) and (Self<>WettkAlleDummy) and (WkArtNeu<>GetWettkArt) then
  begin
    WkArtAlt := GetWettkArt;
    FWettkArtColl[TVeranstObj(FVPtr).OrtIndex] := Integer(WkArtNeu);
    if FVPtr=Veranstaltung then
    begin
      if ((WkArtAlt=waRndRennen) or (WkArtAlt=waStndRennen)) and
          (WkArtNeu<>waRndRennen) and (WkArtNeu<>waStndRennen) then
        for AbsCnt:=wkAbs1 to wkAbs8 do
          SetAbsMaxRunden(AbsCnt,1)
      else
      if ((WkArtNeu=waRndRennen) or (WkArtNeu=waStndRennen)) and
          (WkArtAlt<>waRndRennen) and (WkArtAlt<>waStndRennen) then
      begin
        SetAbsMaxRunden(wkAbs1,cnRundenMax);
        for AbsCnt:=wkAbs2 to wkAbs8 do
          SetAbsMaxRunden(AbsCnt,1);
      end;
      SetMannschModified(true); // weil impact auf MschEinlesen
      SetErgModified(true);
    end;
  end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtWettkArt(Indx:Integer): TWettkArt;
//------------------------------------------------------------------------------
// waTlnStaffel,waTlnTeam nicht bei Serie
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
  begin
    if FWettkArtColl <> nil then
      case FWettkArtColl[Indx] of
        1: Result := waMschStaffel;
        2: Result := waMschTeam;
        //3:   Result := waMschSchopfheim; // ab 2005 nicht mehr unterst�tzt
        //3,4:   Result := waMschSigmaringen; // beide werte benutzt (4=alt)!
        5: if not TVeranstObj(FVPtr).Serie then Result := waTlnStaffel
                                           else Result := waEinzel;
        6: Result := waRndRennen;
        7: Result := waStndRennen;
        8: if not TVeranstObj(FVPtr).Serie then Result := waTlnTeam
                                           else Result := waEinzel;
        else Result := waEinzel; //waInt3,waInt4
      end
    else Result := waEinzel
  end
  else Result := waEinzel;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetMschWrtgMode: TMschWrtgMode;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtMschWrtgMode(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtMschWrtgMode(-1);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetMschWrtgMode(MschWrtgModeNeu:TMschWrtgMode);
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    SetOrtMschWrtgMode(TVeranstObj(FVPtr).OrtIndex,MschWrtgModeNeu);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtMschWrtgMode(Indx:Integer): TMschWrtgMode;
//------------------------------------------------------------------------------
begin
  Result := wmTlnZeit;
  if (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) and
     (FMschWrtgModeColl <> nil) and (GetMschWertg <> mwKein) then
    if FMschWrtgModeColl[Indx] = Integer(wmTlnPlatz) then
      Result := wmTlnPlatz
    else if ((GetMschWertg = mwEinzel)) and
             (FMschWrtgModeColl[Indx] = Integer(wmSchultour)) then
      Result := wmSchultour;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtMschWrtgMode(Indx:Integer; MschWrtgModeNeu:TMschWrtgMode);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) and
     (Integer(MschWrtgModeNeu) <> FMschWrtgModeColl[Indx]) then
  begin
    FMschWrtgModeColl[Indx] := Integer(MschWrtgModeNeu);
    if FVPtr=Veranstaltung then SetMannschModified(true); // weil impact auf MschEinlesen
  end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetMschGroesse(Sx:TSex): Integer;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtMschGroesse(Sx,TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtMschGroesse(Sx,-1);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtMschGroesse(Sx:TSex;Indx:Integer): Integer;
//------------------------------------------------------------------------------
var i : Integer;
//..............................................................................
function OrtWkMschGroesse(Sx:TSex;Wk:TWettkObj): Integer;
begin
  with Wk do
    if GetOrtWettkArt(Indx) = waTlnStaffel then
      Result := GetOrtAbschnZahl(Indx)
    else
    if GetOrtWettkArt(Indx) = waTlnTeam then
      case Sx of
        cnMaennlich : Result := FMschGrMaennerColl[Indx];
        cnWeiblich  : Result := FMschGrFrauenColl[Indx];
        cnMixed     : Result := FMschGrMixedColl[Indx];
        else          Result := FMschGrAlleColl[Indx]; // auch cnKeinSex
      end
    else
      case Sx of
        cnMaennlich : Result := FMschGrMaennerColl[Indx];
        cnWeiblich  : Result := FMschGrFrauenColl[Indx];
        cnMixed     : Result := FMschGrMixedColl[Indx];
        cnSexBeide  : Result := FMschGrAlleColl[Indx];
        else          Result := 0;
      end;
end;
//..............................................................................
begin
  Result := 0;
  if (FVPtr<>nil) and (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    if (Self=WettkAlleDummy) and (FVPtr=Veranstaltung) then
      // Max. f�r alle Wettk�mpfe, f�r RaveReports �ber Alle Wettk
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
        if Result < OrtWkMschGroesse(Sx,Veranstaltung.WettkColl[i]) then
          Result := OrtWkMschGroesse(Sx,Veranstaltung.WettkColl[i])
        else
    else
      Result := OrtWkMschGroesse(Sx,Self);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetMschGroesse(Sx:TSex;Groesse:Integer);
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    SetOrtMschGroesse(Sx,TVeranstObj(FVPtr).OrtIndex,Groesse);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtMschGroesse(Sx:TSex;Indx:Integer; Groesse:Integer);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil) and (Self<>WettkAlleDummy) and
     (Indx >= 0) and (Indx < TVeranstObj(FVPtr).OrtZahl) then
  begin
    if (Groesse < cnMschGrMin) or (Groesse > cnMschGrMax) then
      Groesse := cnMschGrDefault;
    case Sx of
      cnMaennlich:
        if FMschGrMaennerColl[Indx] <> Groesse then
        begin
          FMschGrMaennerColl[Indx] := Groesse;
          if FVPtr=Veranstaltung then SetMannschModified(true);
        end;
      cnWeiblich:
        if FMschGrFrauenColl[Indx] <> Groesse then
        begin
          FMschGrFrauenColl[Indx] := Groesse;
          if FVPtr=Veranstaltung then SetMannschModified(true);
        end;
      cnMixed:
        if FMschGrMixedColl[Indx] <> Groesse then
        begin
          FMschGrMixedColl[Indx] := Groesse;
          if FVPtr=Veranstaltung then SetMannschModified(true);
        end;
      cnSexBeide:
        if FMschGrAlleColl[Indx] <> Groesse then
        begin
          FMschGrAlleColl[Indx] := Groesse;
          if FVPtr=Veranstaltung then SetMannschModified(true);
        end;
      cnKeinSex: ;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetSchwimmDistanz: Integer;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtSchwimmDistanz(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtSchwimmDistanz(-1);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtSchwimmDistanz(Indx:Integer): Integer;
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil) and (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    if (Self=WettkAlleDummy) and (FVPtr=Veranstaltung) then // Max Wert f�r Rave Reports
    begin
      Result := 0;
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
        Result := Max(Result,Veranstaltung.WettkColl[i].SchwimmDistanzColl[Indx]);
    end
    else Result := SchwimmDistanzColl[Indx]
  else Result := 0;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetSchwimmDistanz(SchwimmDistanz:Integer);
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    SetOrtSchwimmDistanz(TVeranstObj(FVPtr).OrtIndex,SchwimmDistanz );
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtSchwimmDistanz(Indx:Integer; SchwimmDistanz:Integer);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    FSchwimmDistanzColl[Indx] := SchwimmDistanz;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetStartBahnen: Integer;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtStartBahnen(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtStartBahnen(-1);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtStartBahnen(Indx:Integer): Integer;
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil) and (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    if (Self=WettkAlleDummy) and (FVPtr=Veranstaltung) then //Max Wert f�r Rave Repotrs
    begin
      Result := 0;
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
        with Veranstaltung.WettkColl[i] do
          if FStartBahnenColl[Indx] > Result
            then Result := FStartBahnenColl[Indx];
    end
    else Result := FStartBahnenColl[Indx]
  else Result := 0;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetStartBahnen(StartBahnen:Integer);
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    SetOrtStartBahnen(TVeranstObj(FVPtr).OrtIndex,StartBahnen);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtStartBahnen(Indx:Integer; StartBahnen:Integer);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    FStartBahnenColl[Indx] := StartBahnen;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetRundLaenge: Integer;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtRundLaenge(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtRundLaenge(-1);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtRundLaenge(Indx:Integer): Integer;
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil) and (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    if (Self=WettkAlleDummy) and (FVPtr=Veranstaltung) then //Max Wert f�r Rave Repotrs
    begin
      Result := 0;
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
        with Veranstaltung.WettkColl[i] do
          if FRundLaengeColl[Indx] > Result
            then Result := FRundLaengeColl[Indx];
    end
    else Result := FRundLaengeColl[Indx]
  else Result := 0;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetRundLaenge(RundLaenge:Integer);
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    SetOrtRundLaenge(TVeranstObj(FVPtr).OrtIndex,RundLaenge);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtRundLaenge(Indx:Integer; RundLaenge:Integer);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    FRundLaengeColl[Indx] := RundLaenge;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetAbschnZahl: Integer;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtAbschnZahl(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtAbschnZahl(-1);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetAbschnZahl(ZahlNeu:Integer);
//------------------------------------------------------------------------------
// nur in SetWettkOrtDaten mit anderen Werten
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (FAbschnZahlColl[TVeranstObj(FVPtr).OrtIndex] <> ZahlNeu) then
  begin
    FAbschnZahlColl[TVeranstObj(FVPtr).OrtIndex] := Max(1,ZahlNeu);
    if FVPtr=Veranstaltung then SetErgModified(true);
  end;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtAbschnZahl(Indx:Integer): Integer;
//------------------------------------------------------------------------------
var i : Integer;
begin
  Result := 1;
  if (FVPtr<>nil) and (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    if (Self=WettkAlleDummy) and (FVPtr=Veranstaltung) then
      for i := 0 to Veranstaltung.WettkColl.Count-1 do
        Result := Max(Result,Veranstaltung.WettkColl[i].FAbschnZahlColl[Indx])
    else Result := Max(1,FAbschnZahlColl[Indx]);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetAbschnNameColl(Abschnitt:TWkAbschnitt): TTextCollection;
//------------------------------------------------------------------------------
begin
  Result := FAbschnNameCollArr[Abschnitt];
end;

//------------------------------------------------------------------------------
function TWettkObj.GetAbschnName(Abschnitt:TWkAbschnitt): String;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtAbschnName(TVeranstObj(FVPtr).OrtIndex,Abschnitt)
  else Result := GetOrtAbschnName(-1,Abschnitt);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetAbschnName(Abschnitt:TWkAbschnitt;NameNeu:String);
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    SetOrtAbschnName(TVeranstObj(FVPtr).OrtIndex,Abschnitt,NameNeu);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtAbschnName(Indx:Integer;Abschnitt:TWkAbschnitt): String;
//------------------------------------------------------------------------------
var i : Integer;
begin
  Result := ''; // gilt bei AbschnZahl=1
  if (FVPtr<>nil) and
     (Indx >= 0) and (Indx < TVeranstObj(FVPtr).OrtZahl) and
     (GetOrtAbschnZahl(Indx)>1)and(Integer(Abschnitt)<=GetOrtAbschnZahl(Indx)) then

    if (Self<>WettkAlleDummy) or (FVPtr<>Veranstaltung)then
      Result := GetAbschnNameColl(Abschnitt)[Indx]
    else
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
        if Result = '' then
          Result := Veranstaltung.WettkColl[i].GetAbschnNameColl(Abschnitt)[Indx]
        else if Result<>Veranstaltung.WettkColl[i].GetAbschnNameColl(Abschnitt)[Indx] then
        begin
          Result := 'Abs. ' + IntToStr(Integer(Abschnitt));
          Exit;
        end;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtAbschnName(Indx:Integer;Abschnitt:TWkAbschnitt;NameNeu:String);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx >= 0) and (Indx < TVeranstObj(FVPtr).OrtZahl) then
    FAbschnNameCollArr[Abschnitt][Indx] := Trim(NameNeu);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetTlnTxt: String;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtTlnTxt(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtTlnTxt(-1);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetTlnTxt(TxtNeu:String);
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    SetOrtTlnTxt(TVeranstObj(FVPtr).OrtIndex,TxtNeu);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtTlnTxt(Indx:Integer): String;
//------------------------------------------------------------------------------
var i : Integer;
    TxtVorhanden   : Boolean;
    TxtUnterschied : Boolean;
    S : String;
begin
  if (FVPtr<>nil) and (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    if ((Self<>WettkAlleDummy) or (FVPtr<>Veranstaltung)) and (FCollection<>nil) then
      Result := FTlnTxtColl[Indx]
    else // bei WettkAlleDummy gilt 'Opt' oder TlnTxt (nur AnmeldeAnsicht) (FCollection=nil)
    begin
      TxtVorhanden   := false;
      TxtUnterschied := false;
      S := '';
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
        if not StrGleich(Veranstaltung.WettkColl[i].OrtTlnTxt[Indx],'') then
        begin
          TxtVorhanden := true;
          if not StrGleich(S,'') and
             not StrGleich(S,Veranstaltung.WettkColl[i].OrtTlnTxt[Indx]) then
               TxtUnterschied := true;
          S := Veranstaltung.WettkColl[i].OrtTlnTxt[Indx];
        end;
      if TxtVorhanden then
        if TxtUnterschied then Result := 'Opt.'
                          else Result := S
      else Result := '';
    end
  else Result := '';
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtTlnTxt(Indx:Integer;TxtNeu:String);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    FTlnTxtColl[Indx] := Trim(TxtNeu);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetStartgeld: Integer;
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    Result := GetOrtStartgeld(TVeranstObj(FVPtr).OrtIndex)
  else Result := GetOrtStartgeld(-1);
end;

//------------------------------------------------------------------------------
function TWettkObj.GetOrtStartgeld(Indx:Integer): Integer;
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (FVPtr<>nil) and (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    if (Self=WettkAlleDummy) and (FVPtr=Veranstaltung) then //Max Wert f�r Rave Repotrs
    begin
      Result := 0;
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
        with Veranstaltung.WettkColl[i] do
          if FStartgeldColl[Indx] > Result
            then Result := FStartgeldColl[Indx];
    end
    else Result := FStartgeldColl[Indx]
  else Result := 0;
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetStartgeld(Startgeld:Integer);
//------------------------------------------------------------------------------
begin
  if FVPtr<>nil then
    SetOrtStartgeld(TVeranstObj(FVPtr).OrtIndex,Startgeld);
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetOrtStartgeld(Indx:Integer; Startgeld:Integer);
//------------------------------------------------------------------------------
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    FStartgeldColl[Indx] := Startgeld;
end;

//------------------------------------------------------------------------------
function TWettkObj.GetAbsMaxRunden(Abschnitt:TWkAbschnitt): Integer;
//------------------------------------------------------------------------------
// Max �ber alle Wettk in TlnColl.RundenZahlMax
begin
  if (FVPtr<>nil) and (Self<>WettkAlleDummy) then
    if RundenWettk then
      Result := cnRundenMax
    else
      Result := Max(1,FAbsMaxRndCollArr[Abschnitt][TVeranstObj(FVPtr).OrtIndex])
  else
    Result := 1; // Dummy
end;

//------------------------------------------------------------------------------
procedure TWettkObj.SetAbsMaxRunden(Abschnitt:TWkAbschnitt;RundenNeu:Integer);
//------------------------------------------------------------------------------
// nur in SetWettkOrtDaten mit anderen Werten
// Min = 1
begin
  if (FVPtr<>nil)and(Self<>WettkAlleDummy) {and // nicht beim Laden
     (GetAbsMaxRunden(Abschnitt) <> Max(1,RundenNeu))} then // immer, alte Werte korrigieren
  begin
    if RundenWettk then
      FAbsMaxRndCollArr[Abschnitt][TVeranstObj(FVPtr).OrtIndex] := cnRundenMax
    else
      FAbsMaxRndCollArr[Abschnitt][TVeranstObj(FVPtr).OrtIndex]:= Max(1,RundenNeu);
    if FVPtr=Veranstaltung then
    begin
      Veranstaltung.TlnColl.UpdateRundenZahl(Abschnitt,Self);
      SetErgModified(true);
    end;
  end;
end;


// public Methoden

//==============================================================================
constructor TWettkObj.Create(Veranst:Pointer;Coll:TTriaObjColl;Add:TOrtAdd);
//==============================================================================
var i: Integer;
    R: TSerWrtgPktRec;
    AbsCnt : TWkAbschnitt;
    TlnMsch : TTlnMsch;
begin
  inherited Create(Veranst,Coll,Add);
  FName     := '';

  R.RngVon  := 1;
  R.RngBis  := cnTlnMax;
  R.PktVon  := 1;
  R.PktIncr := 1;
  for TlnMsch:=tmTln to tmMsch do
  begin
    FStreichErg[TlnMsch]     := 0;
    FStreichOrt[TlnMsch]     := 0;
    FPflichtWkMode[TlnMsch]  := pw0;
    FPflichtWkOrt1[TlnMsch]  := nil;
    FPflichtWkOrt2[TlnMsch]  := nil;
    FPunktGleichOrt[TlnMsch] := nil;
    FSerWrtgMode[TlnMsch]    := swRngUpPkt; // default
    FSerWrtgPktColl[TlnMsch] := TSerWrtgPktColl.Create(FVPtr);
    FSerWrtgPktColl[TlnMsch].Add(R); // Init SerWrtgColl nach LBS-Nachwuchscup
    FMaennerKlasse[TlnMsch]  := TAkObj.Create(nil,nil,oaAdd);
    FFrauenKlasse[TlnMsch]   := TAkObj.Create(nil,nil,oaAdd);
    with AkMaenner do FMaennerKlasse[TlnMsch].Init(Name,Kuerzel,AlterVon,AlterBis,Sex,Wertung);
    with AkFrauen do FFrauenKlasse[TlnMsch].Init(Name,Kuerzel,AlterVon,AlterBis,Sex,Wertung);
    AltMKlasseColl[TlnMsch]     := TAkColl.Create(FVPtr,kwAltKl,cnMaennlich,alTria);
    AltWKlasseColl[TlnMsch]     := TAkColl.Create(FVPtr,kwAltKl,cnWeiblich,alTria);
    FRngMaxAlleColl[TlnMsch]    := TWordCollection.Create(FVPtr);
    FRngMaxMaennerColl[TlnMsch] := TWordCollection.Create(FVPtr);
    FRngMaxFrauenColl[TlnMsch]  := TWordCollection.Create(FVPtr);
    FRngMaxAkMColl[TlnMsch]     := TRngMaxAkColl.Create(FVPtr,AltMKlasseColl[TlnMsch]);
    FRngMaxAkWColl[TlnMsch]     := TRngMaxAkColl.Create(FVPtr,AltWKlasseColl[TlnMsch]);
  end;
  SondMKlasseColl  := TAkColl.Create(FVPtr,kwSondKl,cnMaennlich,alTria);
  SondWKlasseColl  := TAkColl.Create(FVPtr,kwSondKl,cnWeiblich,alTria);
  FRngMaxMixedColl := TWordCollection.Create(FVPtr); // nur tmMsch benutzt
  FRngMaxSkMColl   := TRngMaxAkColl.Create(FVPtr,SondMKlasseColl); // nur tmTln
  FRngMaxSkWColl   := TRngMaxAkColl.Create(FVPtr,SondWKlasseColl); // nur tmTln

  FMannschModified := false;
  FKlassenModified := false;
  FMschWertg       := mwEinzel;  // DefaultMschWertg;

  FStandTitelColl     := TTextCollection.Create(FVPtr);
  FSondTitelColl      := TTextCollection.Create(FVPtr);
  FDatumColl          := TTextCollection.Create(FVPtr);
  FDisqTxtColl        := TTextCollection.Create(FVPtr);
  FWettkArtColl       := TWordCollection.Create(FVPtr);
  FMschWrtgModeColl   := TWordCollection.Create(FVPtr);
  FMschGrAlleColl     := TWordCollection.Create(FVPtr);
  FMschGrMaennerColl  := TWordCollection.Create(FVPtr);
  FMschGrFrauenColl   := TWordCollection.Create(FVPtr);
  FMschGrMixedColl    := TWordCollection.Create(FVPtr);
  FSchwimmDistanzColl := TWordCollection.Create(FVPtr);
  FStartBahnenColl    := TWordCollection.Create(FVPtr);
  FErgModifiedColl    := TBoolCollection.Create(FVPtr);
  FAbschnZahlColl     := TWordCollection.Create(FVPtr);
  FRundLaengeColl     := TIntegerCollection.Create(FVPtr);
  FStartgeldColl      := TIntegerCollection.Create(FVPtr);
  for AbsCnt:=wkAbs1 to wkAbs8 do
  begin
    FAbschnNameCollArr[AbsCnt] := TTextCollection.Create(FVPtr);
    FAbsMaxRndCollArr[AbsCnt]  := TWordCollection.Create(FVPtr);
  end;

  FTlnTxtColl := TTextCollection.Create(FVPtr);
  SerPktBuffColl := TIntSortCollection.Create(FVPtr);

  for TlnMsch:=tmTln to tmMsch do
  begin
    TlnImZielColl[TlnMsch] := TBoolCollection.Create(FVPtr);
    OrtZahlGestartet[TlnMsch] := 0; // benutzt und gesetzt bei Seriewertung
  end;

  TlnAkZahlMax     := 0; // f�r Ergebnisse Berechnen
  MschAkZahlMax    := 0; // f�r Ergebnisse Berechnen
  FSerWrtgJahr     := 0; // nur f�r Altersberechnung Serienwertung

  if (Add=oaAdd) and (FVPtr<>nil) then
    for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do OrtCollAdd;
end;

//==============================================================================
destructor TWettkObj.Destroy;
//==============================================================================
var AbsCnt : TWkAbschnitt;
    TlnMsch : TTlnMsch;
begin
  // Collections l�schen
  FreeAndNil(FStandTitelColl);
  FreeAndNil(FSondTitelColl);
  FreeAndNil(FDatumColl);
  FreeAndNil(FDisqTxtColl);
  FreeAndNil(FWettkArtColl);
  FreeAndNil(FMschWrtgModeColl);
  FreeAndNil(FMschGrAlleColl);
  FreeAndNil(FMschGrMaennerColl);
  FreeAndNil(FMschGrFrauenColl);
  FreeAndNil(FMschGrMixedColl);
  FreeAndNil(FSchwimmDistanzColl);
  FreeAndNil(FStartBahnenColl);
  FreeAndNil(FErgModifiedColl);
  FreeAndNil(FAbschnZahlColl);
  FreeAndNil(FRundLaengeColl);
  FreeAndNil(FStartgeldColl);
  for AbsCnt:=wkAbs1 to wkAbs8 do
  begin
    FreeAndNil(FAbschnNameCollArr[AbsCnt]);
    FreeAndNil(FAbsMaxRndCollArr[AbsCnt]);
  end;
  for TlnMsch := tmTln to tmMsch do
  begin
    FreeAndNil(FRngMaxAlleColl[TlnMsch]);
    FreeAndNil(FRngMaxMaennerColl[TlnMsch]);
    FreeAndNil(FRngMaxFrauenColl[TlnMsch]);
    FreeAndNil(FRngMaxAkMColl[TlnMsch]);
    FreeAndNil(FRngMaxAkWColl[TlnMsch]);
    FreeAndNil(FSerWrtgPktColl[TlnMsch]);
    FreeAndNil(AltMKlasseColl[TlnMsch]);
    FreeAndNil(AltWKlasseColl[TlnMsch]);
  end;
  FreeAndNil(FRngMaxMixedColl);
  FreeAndNil(SondMKlasseColl);
  FreeAndNil(SondWKlasseColl);
  FreeAndNil(FRngMaxSkWColl);
  FreeAndNil(FRngMaxSkMColl);
  FreeAndNil(FTlnTxtColl);
  FreeAndNil(TlnImZielColl);
  FreeAndNil(SerPktBuffColl);

  inherited Destroy;
end;

//==============================================================================
function TWettkObj.Load: Boolean;
//==============================================================================
var i,j             : Integer;
    MschWrtgBuf,
    AkWrtgBuf,
    WordBuf         : Word;
    Buff,
    C,CollCnt,
    AkMinBuff,
    AkMaxBuff       : SmallInt;
    SBuff           : String;
    LBuff           : LongInt;
    DummyKlasseColl : TAkColl;
    AbsCnt          : TWkAbschnitt;
    TlnMsch         : TTlnMsch;
    DummyWordColl   : TWordCollection;

begin
  Result := false;

  with TriaStream do
  try
    if FVPtr <> EinlVeranst then Exit;
    if not inherited Load then Exit;

    if (TriDatei.Version.Jahr>'2004')or
       (TriDatei.Version.Jahr='2004')and(TriDatei.Version.Nr>='1.1') then
    begin
      // read allg Strings
      ReadBuffer(C,cnSizeOfSmallInt);
      for i:=0 to C-1 do
        case i of
          0: ReadStr(FName);      // Str 1
          1: ReadStr(SBuff);      // Str 2, Dummy f�r FLigaKuerzel, ab 2010
          2: begin ReadStr(SBuff);FMaennerKlasse[tmTln].Name :=SBuff; end;// Str 3 2005
          3: begin ReadStr(SBuff);FFrauenKlasse[tmTln].Name :=SBuff; end;// Str 4
          4: begin ReadStr(SBuff);FMaennerKlasse[tmMsch].Name:=SBuff; end;// Str 5
          5: begin ReadStr(SBuff);FFrauenKlasse[tmMsch].Name:=SBuff; end;// Str 6
          else ReadStr(SBuff);           // zuk�nftige Erweiterungen
        end;
      // read allg SmallInt
      ReadBuffer(C,cnSizeOfSmallInt);
      for i:=0 to C-1 do
        case i of
          0: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 1
               {case Buff of
                 0: FTlnGesWertg := gwAlleAk;
                 1: FTlnGesWertg := gwMannFrau;
                 2: FTlnGesWertg := gwProAk;
               end;}
             end;
          1: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 2
               case Buff of
                 0: FMschWertg := mwKein;
                 1: FMschWertg := mwEinzel;
                 2: FMschWertg := mwMulti;
               end;
             end;
          2: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 3
               {case Buff of
                 0: FMschGesWertg := gwAlleAk;
                 1: FMschGesWertg := gwMannFrau;
                 2: FMschGesWertg := gwProAk;
               end; }
             end;
          3: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 4
               FStreichErg[tmTln] := Buff;
             end;
          4: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 5
               SetPunktGleichOrtIndx(tmTln,Buff);
             end;
          5: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 6
               FPflichtWkMode[tmTln] := TPflichtWkMode(Buff);
             end;
          6: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 7
               SetPflichtWkOrt1Indx(tmTln,Buff);
             end;
          7: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 8
               SetPflichtWkOrt2Indx(tmTln,Buff);
             end;
          8: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 9
               FStreichOrt[tmTln] := Buff;
             end;
          9: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 10
               FStreichErg[tmMsch] := Buff;
             end;
         10: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 11
               SetPunktGleichOrtIndx(tmMsch,Buff);
             end;
         11: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 12
               FPflichtWkMode[tmMsch] := TPflichtWkMode(Buff);
             end;
         12: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 13
               SetPflichtWkOrt1Indx(tmMsch,Buff);
             end;
         13: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 14
               SetPflichtWkOrt2Indx(tmMsch,Buff);
             end;
         14: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 15
               FStreichOrt[tmMsch] := Buff;
             end;
         15: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 16 - ab 11.1.4
               SetSerWrtgJahr(Buff);
             end;
         16: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 17 - ab 11.2.4
               SetSerWrtgMode(tmTln,TSerWrtgMode(Buff));
             end;
         17: begin
               ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 18 - ab 11.2.4
               SetSerWrtgMode(tmMsch,TSerWrtgMode(Buff));
             end;
          else ReadBuffer(Buff,cnSizeOfSmallInt);      // zukunft
        end;

      // read allg LongInt
      ReadBuffer(C,cnSizeOfSmallInt);
      for i:=0 to C-1 do ReadBuffer(LBuff,cnSizeOfLongInt);  // zukunft

      // load 6x KlasseColl
      DummyKlasseColl := TAkColl.Create(FVPtr,kwKein,cnMaennlich,alTria);
      ReadBuffer(C,cnSizeOfSmallInt);
      for i:=0 to C-1 do
        case i of
          0: if not AltMKlasseColl[tmTln].Load then Exit; // Clear vor Load in AkObj
          1: if not SondMKlasseColl.Load then Exit;
          2: if not AltMKlasseColl[tmMsch].Load then Exit;
          3: if not AltWKlasseColl[tmTln].Load then Exit;
          4: if not SondWKlasseColl.Load then Exit;
          5: if not AltWKlasseColl[tmMsch].Load then Exit;
          else if not DummyKlasseColl.Load then Exit; // Clear in AkObj
        end;
      DummyKlasseColl.Free;

      // load Ort Collections, momentan nur pro Ort
      ReadBuffer(CollCnt,cnSizeOfSmallInt);
      for i:=0 to CollCnt-1 do
      begin
        // read Strings pro Ort in Coll
        ReadBuffer(C,cnSizeOfSmallInt);
        for j:=0 to C-1 do
          if i < TVeranstObj(FVPtr).OrtZahl then
            case j of
              0: begin
                   ReadStr(SBuff);
                   FStandTitelColl.Add(SBuff);  // Str 1
                 end;
              1: begin
                   ReadStr(SBuff); // Trennzeichen ignorieren
                   FDatumColl.Add(DatumStr(SBuff));   // Str 2
                 end;
              2: begin
                   ReadStr(SBuff);
                   FAbschnNameCollArr[wkAbs1].Add(SBuff);  // Str 3
                 end;
              3: begin
                   ReadStr(SBuff);
                   FAbschnNameCollArr[wkAbs2].Add(SBuff);  // Str 4
                 end;
              4: begin
                   ReadStr(SBuff);
                   FAbschnNameCollArr[wkAbs3].Add(SBuff);  // Str 5
                 end;
              5: begin
                   ReadStr(SBuff);
                   FTlnTxtColl.Add(SBuff);  // Str 6
                 end;
              6: begin
                   // neu 2005
                   ReadStr(SBuff);
                   FSondTitelColl.Add(SBuff);  // Str 7
                 end;
              7: begin
                   // neu 2005-1.1
                   ReadStr(SBuff);
                   FAbschnNameCollArr[wkAbs4].Add(SBuff);    // Str 8
                 end;
              8,9,10,11: // ab 2009                          // Str 9..12
                 begin
                   ReadStr(SBuff);
                   AbsCnt := TWkAbschnitt(j-3); // 5..8
                   FAbschnNameCollArr[AbsCnt].Add(SBuff);
                 end;
              12:begin
                   ReadStr(SBuff);
                   FDisqTxtColl.Add(SBuff);  // Str 13
                 end;
              else ReadStr(SBuff);  // zuk�nftige Erweiterungen
            end
          else ReadStr(SBuff);  // zuk�nftige Erweiterungen

        // read SmallInt pro Ort in Coll
        ReadBuffer(C,cnSizeOfSmallInt);
        for j:=0 to C-1 do
          if i < TVeranstObj(FVPtr).OrtZahl then
            case j of
              0: begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 1
                   FWettkArtColl.Add(Buff);
                 end;
              1: begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 2
                   //FMannschGrAnmColl.Add(Buff);
                 end;
              2: begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 3
                   //FMannschGrStrtColl.Add(Buff);
                 end;
              3: begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 4
                   FMschGrAlleColl.Add(Buff);
                   if (TriDatei.Version.Jahr<'2011')or
                      (TriDatei.Version.Jahr='2011')and(TriDatei.Version.Nr<'2.4') then
                   begin
                     FMschGrMaennerColl.Add(Buff);
                     FMschGrFrauenColl.Add(Buff);
                     FMschGrMixedColl.Add(Buff);
                   end;
                 end;
              4: begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 5
                   FSchwimmDistanzColl.Add(Buff);
                 end;
              5: begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 6
                   FStartBahnenColl.Add(Buff);
                 end;
              6: begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 7
                   FAbschnZahlColl.Add(Buff);
                 end;
              7,8,9,10,11,12,13,14:                        // Int 8..15
                 begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);
                   AbsCnt := TWkAbschnitt(j-6); // 1..8
                   if (TriDatei.Version.Jahr<'2011')or
                      (TriDatei.Version.Jahr='2011')and(TriDatei.Version.Nr<='4.1') then
                     if (GetOrtWettkArt(i)=waRndRennen)or(GetOrtWettkArt(i)=waStndRennen) then
                       if AbsCnt=wkAbs1 then Buff := cnRundenMax
                                        else Buff := 1;
                   FAbsMaxRndCollArr[AbsCnt].Add(Buff);
                 end;
              15:begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 16
                   FMschWrtgModeColl.Add(Buff);
                 end;
              16:begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 17
                   FMschGrMaennerColl.Add(Buff);
                 end;
              17:begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 18
                   FMschGrFrauenColl.Add(Buff);
                 end;
              18:begin
                   ReadBuffer(Buff,cnSizeOfSmallInt);      // Int 19
                   FMschGrMixedColl.Add(Buff);
                 end;
              else ReadBuffer(Buff,cnSizeOfSmallInt);      // Zukunft
            end
          else ReadBuffer(Buff,cnSizeOfSmallInt);  // zuk�nftige Erweiterungen

        // read LongInt pro Ort in Coll
        ReadBuffer(C,cnSizeOfSmallInt);
        for j:=0 to C-1 do
          if i < TVeranstObj(FVPtr).OrtZahl then
            case j of
              0: begin
                   ReadBuffer(LBuff,cnSizeOfLongInt);      // Int 1
                   FRundLaengeColl.Add(LBuff);
                 end;
              1: begin
                   ReadBuffer(LBuff,cnSizeOfLongInt);      // Int 2
                   FStartgeldColl.Add(LBuff);
                 end;
              else ReadBuffer(LBuff,cnSizeOfLongInt);      // Zukunft
            end
          else ReadBuffer(LBuff,cnSizeOfLongInt);  // zuk�nftige Erweiterungen

      end;

      // neu 2005
      if TriDatei.Version.Jahr<'2005' then
        for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do FSondTitelColl.Add('');
      if (TriDatei.Version.Jahr<'2005')or
         (TriDatei.Version.Jahr='2005')and(TriDatei.Version.Nr<'1.1') then
        for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do FAbschnNameCollArr[wkAbs4].Add('Ski');

      // neu 2008-2.0
      if (TriDatei.Version.Jahr<'2008')or
         (TriDatei.Version.Jahr='2008')and(TriDatei.Version.Nr<'2.0') then
        for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
          for AbsCnt:=wkAbs1 to wkAbs4 do
            if (GetOrtWettkArt(i)=waRndRennen)or(GetOrtWettkArt(i)=waStndRennen) and
               (AbsCnt=wkAbs1) then
              FAbsMaxRndCollArr[AbsCnt].Add(cnRundenMax)
            else
              FAbsMaxRndCollArr[AbsCnt].Add(1);

      // ab 2007 bis 2008-2.0 SerWrtgPktColl in VeranObj laden,
      // ab 2008-2.0 in WettkObj
      if (TriDatei.Version.Jahr>'2008')or
         (TriDatei.Version.Jahr='2008')and(TriDatei.Version.Nr>='2.0') then
        for TlnMsch := tmTln to tmMsch do
        begin
          FSerWrtgPktColl[TlnMsch].Clear;
          if not FSerWrtgPktColl[TlnMsch].Load then Exit;
        end;

      // neu 2009
      if TriDatei.Version.Jahr<'2009' then
        for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
          for AbsCnt:=wkAbs5 to wkAbs8 do
          begin
            FAbschnNameCollArr[AbsCnt].Add('Run');
            FAbsMaxRndCollArr[AbsCnt].Add(1);
          end;

      // neu 2011
      if (TriDatei.Version.Jahr<'2010')or
         (TriDatei.Version.Jahr='2010')and(TriDatei.Version.Nr<'2.1') then
        for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
          FMschWrtgModeColl.Add(Integer(wmTlnZeit));

      // neu 2015
      if (TriDatei.Version.Jahr<'2011')or
         (TriDatei.Version.Jahr='2011')and(TriDatei.Version.Nr<'4.1') then
        for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
        begin
          FRundLaengeColl.Add(cnRundLaengeDefault);
          FStartgeldColl.Add(0);
          FDisqTxtColl.Add(cnDisqNameDefault);
        end;
    end

    else // altes Dateiformat vor 2004-1.1
    begin
      ReadStr(FName);
      // AkMin,AkMax ab 2004-1.1 nicht mehr benutzt
      ReadBuffer(AkMinBuff, cnSizeOfSmallInt); //Dummy
      ReadBuffer(AkMaxBuff, cnSizeOfSmallInt); //Dummy
      ReadStr(SBuff); // Dummy f�r FLigaKuerzel ab 2010
      ReadBuffer(WordBuf, cnSizeOfWord);
      FStreichErg[tmTln]  := WordBuf;
      ReadBuffer(WordBuf, cnSizeOfWord); // Dummy
      ReadBuffer(MschWrtgBuf, cnSizeOfWord);
      case MschWrtgBuf of
        0: FMschWertg := mwKein;
        1: FMschWertg := mwEinzel;
        2: FMschWertg := mwMulti;
      end;
      ReadBuffer(AkWrtgBuf, cnSizeOfWord); // Dummy, FMschGesWertg
      ReadBuffer(AkWrtgBuf, cnSizeOfWord); // Dummy, FTlnGesWertg
      if not FStandTitelColl.Load then Exit;
      if not FDatumColl.Load then Exit;
      // ab 2004-1.1 werden KlasseColl gespeichert
      // AkColl neu erstellen, nachdem Datum eingelesen wurde
      for TlnMsch := tmTln to tmMsch do
      begin
        AltMKlasseColl[TlnMsch].Free;
        AltWKlasseColl[TlnMsch].Free;
        AltMKlasseColl[TlnMsch] := TAkColl.Create(FVPtr,kwAltKl,cnMaennlich,alTria);
        AltWKlasseColl[TlnMsch] := TAkColl.Create(FVPtr,kwAltKl,cnWeiblich,alTria);
        // Coll initialisieren
        AltMKlasseColl[TlnMsch].SetzeAkLimits(AkMinBuff,AkMaxBuff);
        AltWKlasseColl[TlnMsch].SetzeAkLimits(AkMinBuff,AkMaxBuff);
      end;
      SondMKlasseColl.Free;
      SondWKlasseColl.Free;
      SondMKlasseColl := TAkColl.Create(FVPtr,kwSondKl,cnMaennlich,alTria);
      SondWKlasseColl := TAkColl.Create(FVPtr,kwSondKl,cnWeiblich,alTria);
      if not FWettkArtColl.Load then Exit;
      DummyWordColl := TWordCollection.Create(FVPtr);
      if not DummyWordColl.Load then Exit; // Dummy FMannschGrAnmColl
      DummyWordColl.Clear;
      if not DummyWordColl.Load then Exit; // Dummy FMannschGrStrtColl
      DummyWordColl.Free;
      if not FMschGrAlleColl.Load then Exit;
      if not FSchwimmDistanzColl.Load then Exit;
      if not FStartBahnenColl.Load then Exit;

      if not FAbschnZahlColl.Load then Exit;
      if not FAbschnNameCollArr[wkAbs1].Load then Exit;
      if not FAbschnNameCollArr[wkAbs2].Load then Exit;
      if not FAbschnNameCollArr[wkAbs3].Load then Exit;

      // ab 2003-1.4: Korrektur f�r �ltere Versionen:
      // bei Einzelveranstaltung immer StandTitel = Name
      if (TriDatei.Version.Jahr<'2004') and not TVeranstObj(FVPtr).Serie then
        for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do FStandTitelColl[i] := Name;

      for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
      begin
        FTlnTxtColl.Add('Land');
        FSondTitelColl.Add('');
        FAbschnNameCollArr[wkAbs4].Add('Ski');
        for AbsCnt:=wkAbs5 to wkAbs8 do
          FAbschnNameCollArr[AbsCnt].Add('Abs.'+IntToStr(Integer(AbsCnt)));
        for AbsCnt:=wkAbs1 to wkAbs8 do
          if (GetOrtWettkArt(i)=waRndRennen)or(GetOrtWettkArt(i)=waStndRennen) and
             (AbsCnt=wkAbs1) then
            FAbsMaxRndCollArr[AbsCnt].Add(cnRundenMax)
          else
            FAbsMaxRndCollArr[AbsCnt].Add(1);
        FMschWrtgModeColl.Add(Integer(wmTlnZeit));
        FMschGrMaennerColl.Add(FMschGrAlleColl[i]);
        FMschGrFrauenColl.Add(FMschGrAlleColl[i]);
        FMschGrMixedColl.Add(FMschGrAlleColl[i]);
        FRundLaengeColl.Add(cnRundLaengeDefault);
        FStartgeldColl.Add(0);
        FDisqTxtColl.Add(cnDisqNameDefault);
      end;
    end;

    // einheitliche Anzeige f�r 'Alle Wettk�mpfe' ab 2010 nicht mehr benutzt
    //if Self = WettkAlleDummy then FName := cnWettkAlleName;
    for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
    begin
      FErgModifiedColl.Add(false);
      TlnImZielColl[tmTln].Add(false);
      TlnImZielColl[tmMsch].Add(false);
      SerPktBuffColl.Add(0);
      FRngMaxMixedColl.Add(0);
    end;

    for TlnMsch := tmTln to tmMsch do
    begin
      for i:=0 to TVeranstObj(FVPtr).OrtZahl-1 do
      begin
        FRngMaxAlleColl[TlnMsch].Add(0);
        FRngMaxMaennerColl[TlnMsch].Add(0);
        FRngMaxFrauenColl[TlnMsch].Add(0);
      end;
      RngMaxCollUpdate(AltMKlasseColl[TlnMsch]);
      RngMaxCollUpdate(AltWKlasseColl[TlnMsch]);
    end;
    RngMaxCollUpdate(SondMKlasseColl);
    RngMaxCollUpdate(SondWKlasseColl);

    // neu 2010
    // Seriewertungsoptionen komplett getrennt f�r Tln und Msch,
    // StreichOrt neu (Ortzahl - PflichtWettk)
    if TriDatei.Version.Jahr < '2010' then
    begin
      FStreichErg[tmMsch]     := FStreichErg[tmTln];
      FPflichtWkMode[tmMsch]  := FPflichtWkMode[tmTln];
      FPflichtWkOrt1[tmMsch]  := FPflichtWkOrt1[tmTln];
      FPflichtWkOrt2[tmMsch]  := FPflichtWkOrt2[tmTln];
      FPunktGleichOrt[tmMsch] := FPunktGleichOrt[tmTln];
      FStreichOrt[tmTln]      := FStreichErg[tmTln];
      FStreichOrt[tmMsch]     := FStreichOrt[tmTln];
    end;

    //neu 2011-2
    if (TriDatei.Version.Jahr<'2011')or
       (TriDatei.Version.Jahr='2011')and(TriDatei.Version.Nr<'1.4') then
      SetSerWrtgJahr(GetOrtJahr(0));

    // neu 2013
    if (TriDatei.Version.Jahr<'2011')or
       (TriDatei.Version.Jahr='2011')and(TriDatei.Version.Nr<'2.4') then
    begin
      SetSerWrtgMode(tmTln,swFlexPkt); // statt Default spRngUpPkt
      SetSerWrtgMode(tmMsch,swFlexPkt);
    end;

  except
    Result := false;
    Exit;
  end;

  Result := true;
  {if MemAvail<cnLowMemSize then S.Error(stLowMemError,0);}
end;

//==============================================================================
function TWettkObj.Store;
//==============================================================================
var i : Integer;
    Buff,C,Orte: SmallInt;
    LBuff : LongInt;
    AbsCnt : TWkAbschnitt;
    TlnMsch : TTlnMsch;
begin
  Result := false;
  if not inherited Store then Exit; // BPObjType
  with TriaStream do
  try
    // store allg Strings in Coll
    C := 6;
    WriteBuffer(C,cnSizeOfSmallInt);
    WriteStr(FName);                  // Str 1
    WriteStr('');                     // Str 2, Dummy f�r FLigaKuerzel ab 2010
    WriteStr(FMaennerKlasse[tmTln].Name);      // Str 3 2005
    WriteStr(FFrauenKlasse[tmTln].Name);       // Str 4
    WriteStr(FMaennerKlasse[tmMsch].Name);     // Str 5
    WriteStr(FFrauenKlasse[tmMsch].Name);      // Str 6
    // store allg SmallInt in Coll
    C := 18;
    WriteBuffer(C,cnSizeOfSmallInt);
    {case GetTlnGesWertg of
      gwAlleAk:   Buff := 0;
      gwMannFrau: Buff := 1;
      gwProAk:    Buff := 2;
    end;}
    Buff := 0; // TlnGesWertg
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 1
    case GetMschWertg of
      mwKein:   Buff := 0;
      mwEinzel: Buff := 1;
      mwMulti:  Buff := 2;
    end;
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 2
    {case GetMschGesWertg of
      gwAlleAk:   Buff := 0;
      gwMannFrau: Buff := 1;
      gwProAk:    Buff := 2;
    end;}
    Buff := 0; // MschGesWertg
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 3

    Buff := GetStreichErg(tmTln);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 4
    Buff := GetPunktGleichOrtIndx(tmTln);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 5
    Buff := Integer(GetPflichtWkMode(tmTln));
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 6
    Buff := GetPflichtWkOrt1Indx(tmTln);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 7
    Buff := GetPflichtWkOrt2Indx(tmTln);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 8
    Buff := GetStreichOrt(tmTln);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 9

    Buff := GetStreichErg(tmMsch);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 10
    Buff := GetPunktGleichOrtIndx(tmMsch);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 11
    Buff := Integer(GetPflichtWkMode(tmMsch));
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 12
    Buff := GetPflichtWkOrt1Indx(tmMsch);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 13
    Buff := GetPflichtWkOrt2Indx(tmMsch);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 14
    Buff := GetStreichOrt(tmMsch);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 15
    Buff := FSerWrtgJahr;
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 16 - ab 11.1.4
    Buff := SmallInt(FSerWrtgMode[tmTln]);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 17 - ab 11.2.4
    Buff := SmallInt(FSerWrtgMode[tmMsch]);
    WriteBuffer(Buff,cnSizeOfSmallInt);     // Int 18 - ab 11.2.4

    // store allg LongInt in Coll
    C := 0;
    WriteBuffer(C,cnSizeOfSmallInt);

    // store 6x KlasseColl
    C := 6;
    WriteBuffer(C,cnSizeOfSmallInt);
    if not AltMKlasseColl[tmTln].Store then Exit;
    if not SondMKlasseColl.Store then Exit;
    if not AltMKlasseColl[tmMsch].Store then Exit;
    if not AltWKlasseColl[tmTln].Store then Exit;
    if not SondWKlasseColl.Store then Exit;
    if not AltWKlasseColl[tmMsch].Store then Exit;

    // store Ort Collections, momentan nur pro Ort
    Orte := TVeranstObj(FVPtr).OrtZahl;
    WriteBuffer(Orte,cnSizeOfSmallInt);
    for i:=0 to Orte-1 do
    begin
      // store Strings pro Ort in Coll
      C := 13; // momentan f�r alle Orte gleich
      WriteBuffer(C,cnSizeOfSmallInt);
      WriteStr(FStandTitelColl[i]);             // Str 1
      WriteStr(FDatumColl[i]);                  // Str 2
      WriteStr(FAbschnNameCollArr[wkAbs1][i]);  // Str 3
      WriteStr(FAbschnNameCollArr[wkAbs2][i]);  // Str 4
      WriteStr(FAbschnNameCollArr[wkAbs3][i]);  // Str 5
      WriteStr(FTlnTxtColl[i]);                 // Str 6
      WriteStr(FSondTitelColl[i]);              // Str 7
      for AbsCnt:=wkAbs4 to wkAbs8 do
        WriteStr(FAbschnNameCollArr[AbsCnt][i]);// Str 8..12
      WriteStr(FDisqTxtColl[i]);                 // Str 13
      // store SmallInt pro Ort in Coll
      C := 19;
      WriteBuffer(C,cnSizeOfSmallInt);
      Buff := FWettkArtColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 1
      Buff := 0;
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 2 Dummy FMannschGrAnmColl[
      Buff := 0;
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 3 Dummy FMannschGrStrtColl
      Buff := FMschGrAlleColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 4
      Buff := FSchwimmDistanzColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 5
      Buff := FStartBahnenColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 6
      Buff := FAbschnZahlColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 7
      for AbsCnt:=wkAbs1 to wkAbs8 do
      begin
        Buff := FAbsMaxRndCollArr[AbsCnt][i];
        WriteBuffer(Buff,cnSizeOfSmallInt); // Int 8..15
      end;
      Buff := FMschWrtgModeColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 16
      Buff := FMschGrMaennerColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 17
      Buff := FMschGrFrauenColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 18
      Buff := FMschGrMixedColl[i];
      WriteBuffer(Buff,cnSizeOfSmallInt);   // Int 19

      // store allg LongInt in Coll
      C := 2;
      WriteBuffer(C,cnSizeOfSmallInt);
      LBuff := FRundLaengeColl[i];
      WriteBuffer(LBuff,cnSizeOfLongInt);   // Int 1
      LBuff := FStartgeldColl[i];
      WriteBuffer(LBuff,cnSizeOfLongInt);   // Int 2
    end;

    // ab 2007 bis 2008-2.0 Store in VeranObj.Store:
    for TlnMsch := tmTln to tmMsch do
      if not FSerWrtgPktColl[TlnMsch].Store then Exit;

  except
    Result := false;
    Exit;
  end;
  Result := true;
end;

//==============================================================================
procedure TWettkObj.OrtCollAdd;
//==============================================================================
var S : String;
    AbsCnt  : TWkabschnitt;
    TlnMsch : TTlnMsch;
begin
  FStandTitelColl.Add(FName);
  // f�r nachf. Wettk. Datum von Wettk.0 �bernehmen, sonst aktuelles Datum
  if (FCollection <> nil) and (FCollection.Count > 0) and (Self<>FCollection[0]) then  // GetIndx = -1
    S := TWettkObj(FCollection[0]).FDatumColl[Self.FDatumColl.Count] // vorher gesetzt
  else
    S := SystemDatum;
  FDatumColl.Add(DatumStr(S));
  FWettkArtColl.Add(0);
  FMschWrtgModeColl.Add(0);
  FMschGrAlleColl.Add(cnMschGrDefault);
  FMschGrMaennerColl.Add(cnMschGrDefault);
  FMschGrFrauenColl.Add(cnMschGrDefault);
  FMschGrMixedColl.Add(cnMschGrDefault);
  FSchwimmDistanzColl.Add(0);
  FRundLaengeColl.Add(cnRundLaengeDefault);
  FStartgeldColl.Add(0);
  FStartBahnenColl.Add(0);
  FErgModifiedColl.Add(false);
  FAbschnZahlColl.Add(1);
  FAbschnNameCollArr[wkAbs1].Add('Swim');
  FAbschnNameCollArr[wkAbs2].Add('Bike');
  FAbschnNameCollArr[wkAbs3].Add('Run');
  FAbschnNameCollArr[wkAbs4].Add('Ski');
  for AbsCnt:=wkAbs5 to wkAbs8 do
    FAbschnNameCollArr[AbsCnt].Add('Abs.'+IntToStr(Integer(AbsCnt)));
  for AbsCnt:=wkAbs1 to wkAbs8 do
    FAbsMaxRndCollArr[AbsCnt].Add(1);
  FTlnTxtColl.Add('Land');
  FDisqTxtColl.Add(cnDisqNameDefault);
  TlnImZielColl[tmTln].Add(false);
  TlnImZielColl[tmMsch].Add(false); // Korrektur 2015
  SerPktBuffColl.Add(0);
  FSondTitelColl.Add('');
  for TlnMsch := tmTln to tmMsch do
  begin
    FRngMaxAlleColl[TlnMsch].Add(0);
    FRngMaxMaennerColl[TlnMsch].Add(0);
    FRngMaxFrauenColl[TlnMsch].Add(0);
    FRngMaxAkMColl[TlnMsch].OrtAdd;
    FRngMaxAkWColl[TlnMsch].OrtAdd;
  end;
  FRngMaxMixedColl.Add(0);
  FRngMaxSkMColl.OrtAdd; // nur f�r Tln benutzt
  FRngMaxSkWColl.OrtAdd; // nur f�r Tln benutzt
end;

//==============================================================================
procedure TWettkObj.OrtCollClear(Indx:Integer);
//==============================================================================
var AbsCnt : TWkabschnitt;
    TlnMsch : TTlnMsch;
begin
  if (Indx<0) or (Indx>FStandTitelColl.Count-1) then Exit;
  FStandTitelColl.ClearIndex(Indx);
  FDatumColl.ClearIndex(Indx);
  FWettkArtColl.ClearIndex(Indx);
  FMschWrtgModeColl.ClearIndex(Indx);
  FMschGrAlleColl.ClearIndex(Indx);
  FMschGrMaennerColl.ClearIndex(Indx);
  FMschGrFrauenColl.ClearIndex(Indx);
  FMschGrMixedColl.ClearIndex(Indx);
  FSchwimmDistanzColl.ClearIndex(Indx);
  FStartBahnenColl.ClearIndex(Indx);
  FRundLaengeColl.ClearIndex(Indx);
  FStartgeldColl.ClearIndex(Indx);
  FErgModifiedColl.ClearIndex(Indx);
  FAbschnZahlColl.ClearIndex(Indx);
  for AbsCnt:=wkAbs1 to wkAbs8 do
  begin
    FAbschnNameCollArr[AbsCnt].ClearIndex(Indx);
    FAbsMaxRndCollArr[AbsCnt].ClearIndex(Indx);
  end;
  FTlnTxtColl.ClearIndex(Indx);
  FDisqTxtColl.ClearIndex(Indx);
  TlnImZielColl[tmTln].ClearIndex(Indx);
  TlnImZielColl[tmMsch].ClearIndex(Indx);
  SerPktBuffColl.ClearIndex(Indx);
  FSondTitelColl.ClearIndex(Indx);
  for TlnMsch := tmTln to tmMsch do
  begin
    FRngMaxAlleColl[TlnMsch].ClearIndex(Indx);
    FRngMaxMaennerColl[TlnMsch].ClearIndex(Indx);
    FRngMaxFrauenColl[TlnMsch].ClearIndex(Indx);
    FRngMaxAkMColl[TlnMsch].OrtClear(Indx);
    FRngMaxAkWColl[TlnMsch].OrtClear(Indx);
  end;
  FRngMaxMixedColl.ClearIndex(Indx);
  FRngMaxSkMColl.OrtClear(Indx); // nur f�r Tln benutzt
  FRngMaxSkWColl.OrtClear(Indx); // nur f�r Tln benutzt
end;

//==============================================================================
procedure TWettkObj.OrtCollExch(Idx1,Idx2:Integer);
//==============================================================================
var AbsCnt : TWkabschnitt;
    TlnMsch : TTlnMsch;
begin
  FStandTitelColl.List.Exchange(Idx1,Idx2);
  FDatumColl.List.Exchange(Idx1,Idx2);
  FWettkArtColl.List.Exchange(Idx1,Idx2);
  FMschWrtgModeColl.List.Exchange(Idx1,Idx2);
  FMschGrAlleColl.List.Exchange(Idx1,Idx2);
  FMschGrMaennerColl.List.Exchange(Idx1,Idx2);
  FMschGrFrauenColl.List.Exchange(Idx1,Idx2);
  FMschGrMixedColl.List.Exchange(Idx1,Idx2);
  FSchwimmDistanzColl.List.Exchange(Idx1,Idx2);
  FStartBahnenColl.List.Exchange(Idx1,Idx2);
  FRundLaengeColl.List.Exchange(Idx1,Idx2);
  FErgModifiedColl.List.Exchange(Idx1,Idx2);
  FAbschnZahlColl.List.Exchange(Idx1,Idx2);
  for AbsCnt:=wkAbs1 to wkAbs8 do
  begin
    FAbschnNameCollArr[AbsCnt].List.Exchange(Idx1,Idx2);
    FAbsMaxRndCollArr[AbsCnt].List.Exchange(Idx1,Idx2);
  end;
  FTlnTxtColl.List.Exchange(Idx1,Idx2);
  FDisqTxtColl.List.Exchange(Idx1,Idx2);
  TlnImZielColl[tmTln].List.Exchange(Idx1,Idx2);
  TlnImZielColl[tmMsch].List.Exchange(Idx1,Idx2);
  SerPktBuffColl.List.Exchange(Idx1,Idx2);
  FSondTitelColl.List.Exchange(Idx1,Idx2);
  for TlnMsch := tmTln to tmMsch do
  begin
    FRngMaxAlleColl[TlnMsch].List.Exchange(Idx1,Idx2);
    FRngMaxMaennerColl[TlnMsch].List.Exchange(Idx1,Idx2);
    FRngMaxFrauenColl[TlnMsch].List.Exchange(Idx1,Idx2);
    FRngMaxAkMColl[TlnMsch].OrtExch(Idx1,Idx2);
    FRngMaxAkWColl[TlnMsch].OrtExch(Idx1,Idx2);
  end;
  FRngMaxMixedColl.List.Exchange(Idx1,Idx2);
  FRngMaxSkMColl.OrtExch(Idx1,Idx2); // nur f�r Tln benutzt
  FRngMaxSkWColl.OrtExch(Idx1,Idx2); // nur f�r Tln benutzt
end;


//==============================================================================
procedure TWettkObj.SetWettkAllgDaten(Name: String;
                                      StreichErgTlnNeu,StreichErgMschNeu:Integer;
                                      StreichOrtTlnNeu,StreichOrtMschNeu: Integer;
                                      PflichtWkModeTlnNeu,PflichtWkModeMschNeu: TPflichtWkMode;
                                      PflichtWkOrt1TlnNeu,PflichtWkOrt1MschNeu,
                                      PflichtWkOrt2TlnNeu,PflichtWkOrt2MschNeu: TOrtObj;
                                      PunktGleichOrtTlnNeu,PunktGleichOrtMschNeu:TOrtObj;
                                      MschWertgNeu:TMschWertung;
                                      SerWrtgJahrNeu:Integer;
                                      TlnSerWrtgModeNeu,MschSerWrtgModeNeu:TSerWrtgMode);
//==============================================================================
begin
  SetName(Name);
  SetMschWertg(MschWertgNeu);
  SetStreichErg(tmTln,StreichErgTlnNeu);
  SetStreichErg(tmMsch,StreichErgMschNeu);
  SetStreichOrt(tmTln,StreichOrtTlnNeu);
  SetStreichOrt(tmMsch,StreichOrtMschNeu);
  SetPflichtWkMode(tmTln,PflichtWkModeTlnNeu);
  SetPflichtWkMode(tmMsch,PflichtWkModeMschNeu);
  SetPflichtWkOrt1(tmTln,PflichtWkOrt1TlnNeu);
  SetPflichtWkOrt1(tmMsch,PflichtWkOrt1MschNeu);
  SetPflichtWkOrt2(tmTln,PflichtWkOrt2TlnNeu);
  SetPflichtWkOrt2(tmMsch,PflichtWkOrt2MschNeu);
  SetPunktGleichOrt(tmTln,PunktGleichOrtTlnNeu);
  SetPunktGleichOrt(tmMsch,PunktGleichOrtMschNeu);
  SetSerWrtgJahr(SerWrtgJahrNeu);
  SetSerWrtgMode(tmTln,TlnSerWrtgModeNeu);
  SetSerWrtgMode(tmMsch,MschSerWrtgModeNeu);
end;

//==============================================================================
procedure TWettkObj.SetWettkOrtDaten(StandTitelNeu,SondTitelNeu,DatumNeu:String;
                                     WettkArtNeu:TWettkArt;AbschnZahlNeu,
                                     Abs1RndNeu,Abs2RndNeu,Abs3RndNeu,Abs4RndNeu,
                                     Abs5RndNeu,Abs6RndNeu,Abs7RndNeu,Abs8RndNeu:Integer;
                                     Abs1NameNeu,Abs2NameNeu,Abs3NameNeu,Abs4NameNeu,
                                     Abs5NameNeu,Abs6NameNeu,Abs7NameNeu,Abs8NameNeu,
                                     TlnTxtNeu:String; MschWrtgModeNeu:TMschWrtgMode;
                                     {MannschGrAnmNeu,MannschGrStrtNeu,}MschGrAlleNeu,
                                     MschGrMaennerNeu,MschGrFrauenNeu,MschGrMixedNeu,
                                     SchwimmDistanzNeu,StartBahnenNeu,
                                     RundLaengeNeu,StartgeldNeu:Integer;
                                     DisqTxtNeu:String);
//==============================================================================
// nur in WettkDlg und ImpFrm
begin
  if FVPtr<>nil then
  begin
    SetDatum(DatumNeu);
    SetWettkArt(WettkArtNeu);
    SetMschWrtgMode(MschWrtgModeNeu);
    SetAbschnZahl(AbschnZahlNeu);
    SetAbsMaxRunden(wkAbs1,Abs1RndNeu);
    SetAbsMaxRunden(wkAbs2,Abs2RndNeu);
    SetAbsMaxRunden(wkAbs3,Abs3RndNeu);
    SetAbsMaxRunden(wkAbs4,Abs4RndNeu);
    SetAbsMaxRunden(wkAbs5,Abs5RndNeu);
    SetAbsMaxRunden(wkAbs6,Abs6RndNeu);
    SetAbsMaxRunden(wkAbs7,Abs7RndNeu);
    SetAbsMaxRunden(wkAbs8,Abs8RndNeu);
    SetAbschnName(wkAbs1,Abs1NameNeu);
    SetAbschnName(wkAbs2,Abs2NameNeu);
    SetAbschnName(wkAbs3,Abs3NameNeu);
    SetAbschnName(wkAbs4,Abs4NameNeu);
    SetAbschnName(wkAbs5,Abs5NameNeu);
    SetAbschnName(wkAbs6,Abs6NameNeu);
    SetAbschnName(wkAbs7,Abs7NameNeu);
    SetAbschnName(wkAbs8,Abs8NameNeu);
    SetTlnTxt(TlnTxtNeu);
    FSchwimmDistanzColl[TVeranstObj(FVPtr).OrtIndex] := SchwimmDistanzNeu;
    FStartBahnenColl[TVeranstObj(FVPtr).OrtIndex]    := StartBahnenNeu;
    FStandTitelColl[TVeranstObj(FVPtr).OrtIndex]     := Trim(StandTitelNeu);
    FSondTitelColl[TVeranstObj(FVPtr).OrtIndex]      := Trim(SondTitelNeu);
    FRundLaengeColl[TVeranstObj(FVPtr).OrtIndex]     := RundLaengeNeu;
    FStartgeldColl[TVeranstObj(FVPtr).OrtIndex]      := StartgeldNeu;
    SetMschGroesse(cnSexBeide,MschGrAlleNeu);
    SetMschGroesse(cnMaennlich,MschGrMaennerNeu);
    SetMschGroesse(cnWeiblich,MschGrFrauenNeu);
    SetMschGroesse(cnMixed,MschGrMixedNeu);
    FDisqTxtColl[TVeranstObj(FVPtr).OrtIndex]        := Trim(DisqTxtNeu);
  end;
end;

//==============================================================================
function TWettkObj.GetTlnAlter(Jg:Integer): Integer;
//==============================================================================
begin
  if (FVPtr<>nil) and TVeranstObj(FVPtr).Serie then
    Result := GetSerWrtgJahr - Jg  // bei Serie gilt Datum im 1. Ort, bis
  else                             // FSerWrtgJahr im SerWrtgDlg gesetzt wurde
    Result := GetJahr - Jg;
  if (Result > cnAlterMax) or (Result < cnAlterMin) then Result := 0;
end;

//==============================================================================
function TWettkObj.GetKlasse(TlnMsch:TTlnMsch;AkWrtg:TKlassenWertung;Sx:TSex;Jg:Integer):TAkObj;
//==============================================================================
var i, Alter : Integer;
    AkColl   : TAkColl;
begin
  Result := AkUnbekannt;
  AkColl := nil;
  case AkWrtg of
    kwAlle: Result := AkAlle; //unabh�ngig von Sex und Jg
    kwSex:  case Sx of
              cnMaennlich : Result := FMaennerKlasse[TlnMsch];
              cnWeiblich  : Result := FFrauenKlasse[TlnMsch];
              cnMixed     : Result := AkMixed; // nur tmMsch und tmTln bei TlnStaffel
            end;
    kwAltKl,kwSondKl:
    begin
      case Sx of
        cnMaennlich : Result := AkMannUnbek;
        cnWeiblich  : Result := AkFrauUnbek;
        else Exit;  // Klassen nur pro Geschlecht
      end;
      if AkWrtg = kwAltKl then
        if Sx = cnMaennlich then AkColl := AltMKlasseColl[TlnMsch]
                            else AkColl := AltWKlasseColl[TlnMsch]
      else
      if TlnMsch=tmTln then // SondKl nur f�r tmTln
        if Sx = cnMaennlich then AkColl := SondMKlasseColl
                            else AkColl := SondWKlasseColl;
      Alter := GetTlnAlter(Jg);
      if (AkColl <> nil) and (Alter > 0) then
        for i:=0 to AkColl.Count-1 do
          if (Alter>=AkColl[i].AlterVon) and (Alter<=AkColl[i].AlterBis) then
          begin
            Result := AkColl[i];
            Exit;
          end;
    end;
  end;
end;

//==============================================================================
function TWettkObj.MschGroesseMin: Integer;
//==============================================================================
var Buf : Integer;
begin
  Result := GetMschGroesse(cnSexBeide);
  Buf := GetMschGroesse(cnMaennlich);
  if (Buf > 0) and (Buf < Result) then Result := Buf;
  Buf := GetMschGroesse(cnWeiblich);
  if (Buf > 0) and (Buf < Result) then Result := Buf;
  Buf := GetMschGroesse(cnMixed);
  if (Buf > 0) and (Buf < Result) then Result := Buf;
end;

//==============================================================================
function TWettkObj.MschGroesseMax: Integer;
//==============================================================================
var i,Buf : Integer;
begin
  Result := 0;
  if Self <> WettkAlleDummy then
    Result := Max(GetMschGroesse(cnSexBeide),
                  Max(GetMschGroesse(cnMaennlich),
                      Max(GetMschGroesse(cnWeiblich),GetMschGroesse(cnMixed))))
  else
    // max �ber alle Wettk
    if (Veranstaltung<>nil) and (Veranstaltung.WettkColl<>nil) then
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
      with Veranstaltung.WettkColl[i] do
      begin
        Buf := Max(GetMschGroesse(cnSexBeide),
                 Max(GetMschGroesse(cnMaennlich),
                      Max(GetMschGroesse(cnWeiblich),GetMschGroesse(cnMixed))));
        if Buf > Result then Result := Buf;
      end;
end;

//==============================================================================
procedure TWettkObj.KlasseCollKopieren(ZielColl,QuelColl:TAkColl);
//==============================================================================
var KlNeu, EinlKl : TAkObj;
    i : Integer;
begin
  ZielColl.Clear;
  for i:=0 to QuelColl.Count-1 do
  begin
    EinlKl := QuelColl[i];
    KlNeu:=TAkObj.Create(FVPtr,ZielColl,oaAdd);
    KlNeu.Init(EinlKl.Name,EinlKl.Kuerzel,EinlKl.AlterVon,EinlKl.AlterBis,EinlKl.Sex,EinlKl.Wertung);
    // setze EinlKl.LoadPtr als Pointer f�r Tln.Klasse
    EinlKl.LoadPtr := KlNeu;
    ZielColl.AddItem(KlNeu);
  end;
end;

//==============================================================================
procedure TWettkObj.KlassenKopieren(Wk:TWettkObj);
//==============================================================================
// in ImpFrm benutzt
var i : Integer;
begin
  if FVPtr=nil then Exit;
  for i:=0 to TVeranstObj(FVPtr).TlnColl.Count-1 do
    TVeranstObj(FVPtr).TlnColl[i].KlassenLoeschen;
  for i:=0 to TVeranstObj(FVPtr).MannschColl.Count-1 do
    TVeranstObj(FVPtr).MannschColl[i].Klasse := AkUnbekannt;
  KlasseCollKopieren(AltMKlasseColl[tmTln],Wk.AltMKlasseColl[tmTln]);
  KlasseCollKopieren(AltWKlasseColl[tmTln],Wk.AltWKlasseColl[tmTln]);
  KlasseCollKopieren(SondMKlasseColl,Wk.SondMKlasseColl);
  KlasseCollKopieren(SondWKlasseColl,Wk.SondWKlasseColl);
  KlasseCollKopieren(AltMKlasseColl[tmMsch],Wk.AltMKlasseColl[tmMsch]);
  KlasseCollKopieren(AltWKlasseColl[tmMsch],Wk.AltWKlasseColl[tmMsch]);
  SetKlassenModified(true);
end;

//==============================================================================
function TWettkObj.OrtSerPkt(TlnMsch:TTlnMsch;Indx:Integer;Klasse:TAkObj;Rng:Integer): Integer;
//==============================================================================
var i,Idx1,Idx2: Integer;
begin
  Result := 0;
  if (Indx<0) or (Indx>=TVeranstObj(FVPtr).OrtZahl) then Exit;
  case SerWrtgMode[TlnMsch] of
    swZeit: Exit; // Result = 0
    swRngUpPkt,swRngUpEqPkt:
    begin
      // Rng=0 ==> Pkt = MaxRng+1, bei spRngUpEqPkt max �ber alle Orte +1
      // sonst ==> Pkt = Rng
      if Rng=0 then
      begin
        if SerWrtgMode[TlnMsch] = swRngUpPkt then
        begin
          Idx1 := Indx;
          Idx2 := Indx;
        end else // spRngUpEqPkt
        begin
          Idx1 := 0;
          Idx2 := TVeranstObj(FVPtr).OrtZahl-1;
        end;
        for i:=Idx1 to Idx2 do
          case Klasse.Wertung of
            kwAlle: Result := Max(Result,FRngMaxAlleColl[TlnMsch][i]);
            kwSex :
              if Klasse.Sex = cnWeiblich then
                Result := Max(Result,FRngMaxFrauenColl[TlnMsch][i])
              else
              if Klasse.Sex = cnMixed then // nur tmMsch
                Result := Max(Result,FRngMaxMixedColl[i])
              else
                Result := Max(Result,FRngMaxMaennerColl[TlnMsch][i]);
            kwAltKl:
              if (Klasse.Sex = cnWeiblich) and (AltWKlasseColl[TlnMsch].IndexOf(Klasse) >= 0) then
                Result := Max(Result,FRngMaxAkWColl[TlnMsch][AltWKlasseColl[TlnMsch].IndexOf(Klasse)][i])
              else
              if (Klasse.Sex = cnMaennlich) and (AltMKlasseColl[TlnMsch].IndexOf(Klasse) >= 0) then
                Result := Max(Result,FRngMaxAkMColl[TlnMsch][AltMKlasseColl[TlnMsch].IndexOf(Klasse)][i]);
            kwSondKl: // nur tmTln
              if (Klasse.Sex = cnWeiblich) and (SondWKlasseColl.IndexOf(Klasse) >= 0) then
                Result := Max(Result,FRngMaxSkWColl[SondWKlasseColl.IndexOf(Klasse)][i])
              else
              if (Klasse.Sex = cnMaennlich) and (SondMKlasseColl.IndexOf(Klasse) >= 0) then
                Result := Max(Result,FRngMaxSkMColl[SondMKlasseColl.IndexOf(Klasse)][i]);
          end;
        if Result > 0 then Inc(Result); // 0 Pkt wenn MaxRng = 0
      end else
        Result := Rng;
    end;

    swRngDwnPkt,swRngDwnEqPkt:
    begin
      // Rng=0 ==> 0 Pkt
      // sonst ==> Pkt = MaxRng - Rng + 1,  spRngDwnEqPkt: MaxRng = max �ber alle Orte
      if Rng > 0 then
      begin
        if SerWrtgMode[TlnMsch] = swRngDwnPkt then
        begin
          Idx1 := Indx;
          Idx2 := Indx;
        end else // spRngDwnEqPkt
        begin
          Idx1 := 0;
          Idx2 := TVeranstObj(FVPtr).OrtZahl-1;
        end;
        for i:=Idx1 to Idx2 do
          case Klasse.Wertung of
            kwAlle: Result := Max(Result,FRngMaxAlleColl[TlnMsch][i]);
            kwSex :
              if Klasse.Sex = cnWeiblich then
                Result := Max(Result,FRngMaxFrauenColl[TlnMsch][i])
              else
              if Klasse.Sex = cnMixed then // nur tmMsch, TlnStaffel nicht f�r Serie
                Result := Max(Result,FRngMaxMixedColl[i])
              else
                Result := Max(Result,FRngMaxMaennerColl[TlnMsch][i]);
            kwAltKl:
              if (Klasse.Sex = cnWeiblich) and (AltWKlasseColl[TlnMsch].IndexOf(Klasse) >= 0) then
                Result := Max(Result,FRngMaxAkWColl[TlnMsch][AltWKlasseColl[TlnMsch].IndexOf(Klasse)][i])
              else
              if (Klasse.Sex = cnMaennlich) and (AltMKlasseColl[TlnMsch].IndexOf(Klasse) >= 0) then
                Result := Max(Result,FRngMaxAkMColl[TlnMsch][AltMKlasseColl[TlnMsch].IndexOf(Klasse)][i]);
            kwSondKl: // nur tmTln
              if (Klasse.Sex = cnWeiblich) and (SondWKlasseColl.IndexOf(Klasse) >= 0) then
                Result := Max(Result,FRngMaxSkWColl[SondWKlasseColl.IndexOf(Klasse)][i])
              else
              if (Klasse.Sex = cnMaennlich) and (SondMKlasseColl.IndexOf(Klasse) >= 0) then
                Result := Max(Result,FRngMaxSkMColl[SondMKlasseColl.IndexOf(Klasse)][i]);
          end;
        Result := Max(0, Result - Rng + 1); // wenn Rng>0 muss auch MaxRng>0 sein
      end;
    end;
    else // swFlexPkt
      Result := FSerWrtgPktColl[TlnMsch].GetCupPkt(Rng);
  end;
end;

//==============================================================================
function TWettkObj.CupPktIncr(TlnMsch:TTlnMsch): Boolean;
//==============================================================================
begin
  Result := FSerWrtgPktColl[TlnMsch].CupPktIncr;
end;

//==============================================================================
function TWettkObj.EinzelWettk: Boolean;
//==============================================================================
begin
  Result := (WettkArt=waEinzel) or (WettkArt=waTlnStaffel) or
            (WettkArt=waRndRennen) or (WettkArt=waStndRennen) or
            (WettkArt=waTlnTeam);
end;

//==============================================================================
function TWettkObj.EinzelStart: Boolean;
//==============================================================================
// pro Wettkampf
var i : Integer;
begin
  Result := false;
  if Self=WettkAlleDummy then Exit;
  with TVeranstObj(FVPtr).SGrpColl do
    for i:=0 to Count-1 do
      if (Self=Items[i].Wettkampf) and (not MschWettk) then
      begin
        Result := Items[i].StartModus[wkAbs1] = stOhnePause; // Einzelstart nur f�r EinzelWettk
        Exit;
      end;
end;

//==============================================================================
function TWettkObj.MschWettk: Boolean;
//==============================================================================
// TWettkArt = (waEinzel,waMschStaffel,waMschTeam,
//             waTlnStaffel,waRndRennen,waStndRennen,waTlnTeam)
begin
  Result := (GetWettkArt=waMschStaffel) or (GetWettkArt=waMschTeam);
end;

//==============================================================================
function TWettkObj.RundenWettk: Boolean;
//==============================================================================
begin
  Result := (GetWettkArt=waRndRennen) or (GetWettkArt=waStndRennen);
end;

//==============================================================================
function TWettkObj.TlnOrtSerWertung(Indx:Integer): Boolean;
//==============================================================================
// Staffel- und Teamwettbewerbe werden bei Tln-SerWertung nicht ber�cksichtigt
begin
  if (FVPtr<>nil) and (FCollection<>nil) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    Result := (GetOrtWettkArt(Indx) = waEinzel) or
              (GetOrtWettkArt(Indx) = waRndRennen) or
              (GetOrtWettkArt(Indx) = waStndRennen) and (GetSerWrtgMode(tmTln)<>swZeit)
  else Result := false;
end;

//==============================================================================
function TWettkObj.MschOrtSerWertung(Indx:Integer): Boolean;
//==============================================================================
// bei ZeitWertung Serie auch ZeitWertung Msch
begin
  if (FVPtr<>nil) and (FCollection<>nil) and
     (Indx>=0) and (Indx<TVeranstObj(FVPtr).OrtZahl) then
    Result := (SerWrtgMode[tmMsch] <> swZeit) or (GetOrtMschWrtgMode(Indx) = wmTlnZeit)
  else Result := false;
end;

//==============================================================================
function TWettkObj.SexSortMode: TSortMode;
//==============================================================================
begin
  Result := smSxBeide; //nur Wertung �ber alle Tln (kwAlle)
  if (FVPtr=nil) or (FCollection=nil) then Exit;

  case HauptFenster.Ansicht of
    anAnmEinzel,
    anAnmSammel,
    anTlnStart,
    anTlnErg,
    anTlnErgSerie:   Result := smSxBeideMF; // Beide, M�nner, Frauen

    anMschStart,     // nie WettkAlleDummy
    anMschErgDetail,
    anMschErgKompakt,
    anMschErgSerie:  if EinzelWettk then Result := smSxBeideMF // Beide, M�nner, Frauen
                     else Result := smSxBeide; //MschWertung nur �ber alle Tln (kwAlle)
    anTlnUhrZeit,
    anTlnRndKntrl,
    anTlnSchwDist:  Result := smSxBeide; //nur Beide
  end;
end;

//==============================================================================
function TWettkObj.JgLang(J:String): Integer;
//==============================================================================
// J='0' wird als 2000 gewertet, J='' als 0
// 2-stellig in 4-stellig gewandelt
begin
  Result := StrToIntDef(Trim(J),0);
  if (Length(Trim(J)) = 1) or (Length(Trim(J)) = 2) then
  begin
    // hochrechnen auf 1900/2000, WettkJahr: 2000-2099, Alter 1-99
    Result := Result + (GetJahr DIV 100) * 100;
    if  Result > Jahr then Result := Result - 100;
  end;
end;

//==============================================================================
function TWettkObj.LangeAkKuerzel: Boolean;
//==============================================================================
// f�r alle Ak pr�fen ob K�rzel l�nger als 3 vorhanden sind
//------------------------------------------------------------------------------
var i : Integer;
function LangeKuerzel(AkColl: TAkColl): Boolean;
var i: Integer;
begin
  Result := false;
  for i:=0 to AkColl.Count-1 do
    if Length(AkColl[i].Kuerzel) > 3  then
    begin
      Result := true;
      Exit;
    end;
end;
//------------------------------------------------------------------------------
function LangeKuerzelWk(Wk:TWettkObj): Boolean;
begin
  if LangeKuerzel(Wk.AltMKlasseColl[tmMsch]) or
     LangeKuerzel(Wk.AltWKlasseColl[tmMsch]) or
     LangeKuerzel(Wk.AltMKlasseColl[tmTln]) or
     LangeKuerzel(Wk.AltWKlasseColl[tmTln]) then Result := true
  else Result := false;
end;
//------------------------------------------------------------------------------
begin
  Result := false;
  if (FVPtr<>nil) and (FVPtr=Veranstaltung) then
    if Self=WettkAlleDummy then
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
        if (Veranstaltung.WettkColl[i].GetAbschnZahl = 1) and
           LangeKuerzelWk(Veranstaltung.WettkColl[i]) then
        begin
          Result := true;
          Exit;
        end else
    else
      Result := (Self.GetAbschnZahl = 1) and LangeKuerzelWk(Self);
end;

//==============================================================================
procedure TWettkObj.RngMaxCollUpdate(Coll:TAkColl);
//==============================================================================
// Rng=0 f�r jeden Ort und f�r alle Klassen in Coll
// nach �nderung AkColl
begin
  if Coll = AltMKlasseColl[tmTln] then FRngMaxAkMColl[tmTln].Init
  else
  if Coll = SondMKlasseColl then FRngMaxSkMColl.Init
  else
  if Coll = AltWKlasseColl[tmTln] then FRngMaxAkWColl[tmTln].Init
  else
  if Coll = SondWKlasseColl then FRngMaxSkWColl.Init
  else
  if Coll = AltMKlasseColl[tmMsch] then FRngMaxAkMColl[tmMsch].Init
  else
  if Coll = AltWKlasseColl[tmMsch] then FRngMaxAkWColl[tmMsch].Init;
end;

//==============================================================================
procedure TWettkObj.SetSerRngMax(TlnMsch:TTlnMsch;Klasse:TAkObj;Rng:Integer);
//==============================================================================
// wird in TlnErg.BerechneTagesRang (tmTln) und MannschColl.MannschWertung (tmMsch) benutzt,
// nur f�r akt. OrtsIndex
begin
  case Klasse.Wertung of
    kwAlle:
      FRngMaxAlleColl[TlnMsch][TVeranstObj(FVPtr).OrtIndex] := Rng;
    kwSex :
      if Klasse.Sex = cnMaennlich then
        FRngMaxMaennerColl[TlnMsch][TVeranstObj(FVPtr).OrtIndex] := Rng
      else
      if Klasse.Sex = cnWeiblich then
        FRngMaxFrauenColl[TlnMsch][TVeranstObj(FVPtr).OrtIndex] := Rng
      else
      if (Klasse.Sex = cnMixed) and (TlnMsch = tmMsch) then
        FRngMaxMixedColl[TVeranstObj(FVPtr).OrtIndex] := Rng;
    kwAltKl:
      if Klasse.Sex = cnMaennlich then
        FRngMaxAkMColl[TlnMsch].SetRng(Klasse,Rng)
      else
      if Klasse.Sex = cnWeiblich then
        FRngMaxAkWColl[TlnMsch].SetRng(Klasse,Rng);
    kwSondKl:
      if TlnMsch = tmTln then
        if Klasse.Sex = cnMaennlich then
          FRngMaxSkMColl.SetRng(Klasse,Rng)
        else
        if Klasse.Sex = cnWeiblich then
          FRngMaxSkWColl.SetRng(Klasse,Rng);
  end;
end;

//==============================================================================
function TWettkObj.ObjSize: Integer;
//==============================================================================
begin
    // Ortsbezogene Daten
  Result := 2*cnSizeOfString +
            2*cnSizeOfInteger + {2*SizeOf(TGesWertung) +} cnSizeOfBoolean +
            cnSizeOfWord + SizeOf(TMschWertung) +
            AltMKlasseColl[tmTln].CollSize +
            SondMKlasseColl.CollSize +
            AltMKlasseColl[tmMsch].CollSize +
            AltWKlasseColl[tmTln].CollSize +
            SondWKlasseColl.CollSize +
            AltWKlasseColl[tmMsch].CollSize +
            FStandTitelColl.CollSize +
            FSondTitelColl.CollSize +
            FDatumColl.CollSize +
            FWettkArtColl.CollSize +
            FMschWrtgModeColl.CollSize +
            4*FMschGrAlleColl.CollSize +
            FSchwimmDistanzColl.CollSize +
            FStartBahnenColl.CollSize +
            FRundLaengeColl.CollSize +
            FStartgeldColl.CollSize +
            FErgModifiedColl.CollSize +
            FAbschnZahlColl.CollSize +
            cnAbsZahlMax*FAbschnNameCollArr[wkAbs1].CollSize +
            FTlnTxtColl.CollSize +
            FDisqTxtColl.CollSize +
            cnAbsZahlMax*FAbsMaxRndCollArr[wkAbs1].CollSize +
            2*TlnImZielColl[tmTln].CollSize +
            SerPktBuffColl.CollSize +
            FSerWrtgPktColl[tmTln].CollSize +
            FSerWrtgPktColl[tmMsch].CollSize+
            7*FRngMaxAlleColl[tmTln].CollSize;
end;


(******************************************************************************)
(* Methoden von TWettkColl                                                    *)
(******************************************************************************)

// protected Methoden

//------------------------------------------------------------------------------
function TWettkColl.GetBPObjType: Word;
//------------------------------------------------------------------------------
(* Object Types aus Version 7.4 Stream Registration Records *)
begin
  Result := rrWettkColl;
end;

//------------------------------------------------------------------------------
function TWettkColl.GetPItem(Indx:Integer): TWettkObj;
//------------------------------------------------------------------------------
// kein Range-Pr�fung wegen Geschwindigkeit
begin
  Result := TWettkObj(inherited GetPItem(Indx));
end;

//------------------------------------------------------------------------------
procedure TWettkColl.SetPItem(Indx:Integer; Item:TWettkObj);
//------------------------------------------------------------------------------
begin
  inherited SetPItem(Indx,Item);
end;

//------------------------------------------------------------------------------
function TWettkColl.GetSortItem(Indx:Integer): TWettkObj;
//------------------------------------------------------------------------------
begin
  Result := TWettkObj(inherited GetSortItem(Indx));
end;

// public Methoden

//==============================================================================
constructor TWettkColl.Create(Veranst:Pointer; ItemClass:TTriaObjClass);
//==============================================================================
begin
  inherited Create(Veranst,ItemClass);
  FStepProgressBar      := true;
  FSortItems.Duplicates := true; (* damit gleiche Eintr�ge aufgelistet werden *)
  FSortMode             := smWkEingegeben;
end;

//==============================================================================
function TWettkColl.SortString(Item:Pointer): String;
//==============================================================================
begin
  if (Item <> nil) and (IndexOf(Item) >= 0) then
    Result := Format('%2u',[IndexOf(Item)])
  else Result := ' ';
end;

//==============================================================================
function TWettkColl.Compare(Item1, Item2: Pointer): Integer;
//==============================================================================
begin
  // WettkAlleDummy immer an 1. Stelle
  if Item1 = WettkAlleDummy then Result := -1
  else if Item2 = WettkAlleDummy then Result := 1
  else
  begin
    // Kleinbuchstaben < Gro�buchstaben
    Result := AnsiCompareStr(SortString(Item1),SortString(Item2));
    // Unterschied ss/� ber�cksichtigen
    if Result = 0 then
      Result := CompareStr(SortString(Item1),SortString(Item2));
  end;
end;

//==============================================================================
function TWettkColl.Load: Boolean;
//==============================================================================
// angepasst an BP-Version
var
  ObjType : Word;
  i : Integer;
  B : byte;
  C : Word;
  SI: SmallInt;
  StreamPosAlt : Int64;
  WkAlleBuf : TWettkObj;

  begin

  Result := false;
  WkAlleBuf := TWettkObj.Create(FVPtr,Self,oaNoAdd);
  try

    if TriaStream = nil then Exit;

    if FStepProgressBar then StreamPosAlt := TriaStream.Position
    else StreamPosAlt := 0;

    try
      // read dummy Byte
      TriaStream.ReadBuffer(B,cnSizeOfByte);
      TriaStream.ReadBuffer(ObjType,cnSizeOfWord);

      if TriDatei.Version.Jahr < '2010' then
        if not WkAlleBuf.Load then Exit; // WettkAlleDummy ab 2010 nicht mehr benutzt

      TriaStream.ReadBuffer(C,cnSizeOfWord);
      if (TriDatei.Version.Jahr<'2008')or
         (TriDatei.Version.Jahr='2008')and(TriDatei.Version.Nr<'2.0') then
       begin
         // Dummy Read FLimit,FDelta
         TriaStream.ReadBuffer(SI,cnSizeOfSmallInt);
         TriaStream.ReadBuffer(SI,cnSizeOfSmallInt);
       end;

      if FStepProgressBar then
      begin
        HauptFenster.ProgressBarStep(TriaStream.Position - StreamPosAlt);
        StreamPosAlt := TriaStream.Position;
      end;

      SetCapacity(C); // zur Leistungssteigerung
      for i:=0 to C-1 do
      begin
        if not LoadItem(i) then Exit;
        if FStepProgressBar then
        begin
          HauptFenster.ProgressBarStep(TriaStream.Position - StreamPosAlt);
          StreamPosAlt := TriaStream.Position;
        end;
      end;
      SetItemSize;
    except
      Exit;
    end;

    Result := true;

  finally
    FreeAndNil(WkAlleBuf);
  end;
end;

//==============================================================================
function TWettkColl.Store: Boolean;
//==============================================================================
var
  i : Integer;
  B : byte;
  C : Word;
begin
  Result := false;
  try
    if TriaStream = nil then Exit;
    SetItemSize;
    B := 0;  // write dummy Byte
    TriaStream.WriteBuffer(B,cnSizeOfByte);
    C := BPObjType;
    TriaStream.WriteBuffer(C,cnSizeOfWord);
    C := Count;
    TriaStream.WriteBuffer(C,cnSizeOfWord);
    if FStepProgressBar then HauptFenster.ProgressBarStep(cnMinCollSize);
    for i:=0 to C-1 do
    begin
      if not StoreItem(i) then Exit;
      if FStepProgressBar then HauptFenster.ProgressBarStep(FItemSize);
    end;
  except
    Exit;
  end;
  Result := true;
end;

//==============================================================================
procedure TWettkColl.OrtCollExch(Idx1,Idx2:Integer);
//==============================================================================
begin
  if (Idx1<0) or (Idx1>TVeranstObj(FVPtr).OrtZahl-1) then Exit;
  if (Idx2<0) or (Idx2>TVeranstObj(FVPtr).OrtZahl-1) then Exit;
  inherited OrtCollExch(Idx1,Idx2);
end;

//==============================================================================
procedure TWettkColl.Sortieren(SortModeNeu:TSortMode);
//==============================================================================
// Reihenfolge fest, wie in WettkColl
var i : Integer;
begin
  FSortMode := SortModeNeu;
  SortClear;
  if FSortItems.Capacity < FItems.Capacity+1 then
    FSortItems.Capacity := FItems.Capacity + 1;
  if (FSortMode = smWkPlusAlle) or (FSortMode = smWkNurAlle) then
    AddSortItem(WettkAlleDummy);
  if FSortMode <> smWkNurAlle then // smWkEingegeben, smWkPlusAlle
    for i:=0 to Count-1 do AddSortItem(GetPItem(i));
end;

//==============================================================================
function TWettkColl.MannschWettk: Boolean;
//==============================================================================
var i : Integer;
begin
  Result := false;
  for i:=0 to Count-1 do
    if TWettkObj(FItems[i]).MschWettk then
    begin
      Result := true;
      Exit;
    end;
end;

{==============================================================================}
function TWettkColl.AlleAbschnGleich: Boolean;
{==============================================================================}
var i,AbsZahlAlle  : Integer;
    AbsNameAlleArr : array [wkAbs1..wkAbs8] of String;
    AbsRndAlleArr  : array [wkAbs1..wkAbs8] of Integer;
    StrtMode       : TStartMode;
    AbsCnt         : TWkAbschnitt;
begin
  Result := false;
  if (FVPtr<>nil) and (Count > 1) then
  begin
    with Items[0] do
    begin
      StrtMode  := TVeranstObj(FVPtr).SGrpColl.WettkStartModus(Items[0],wkAbs1);
      AbsZahlAlle := GetAbschnZahl;
      for AbsCnt:=wkAbs1 to wkabs8 do
      begin
        AbsNameAlleArr[AbsCnt] := GetAbschnName(AbsCnt);
        AbsRndAlleArr[AbsCnt]  := GetAbsMaxRunden(AbsCnt);
      end;
    end;
    for i:=1 to Count-1 do with Items[i] do
    begin
      if StrtMode <> TVeranstObj(FVPtr).SGrpColl.WettkStartModus(Items[i],wkAbs1) then Exit;
      if AbsZahlAlle <> GetAbschnZahl then Exit;
      for AbsCnt:=wkAbs1 to wkabs8 do
        if (AbsNameAlleArr[AbsCnt] <> GetAbschnName(AbsCnt)) or
           (AbsRndAlleArr[AbsCnt]  <> GetAbsMaxRunden(AbsCnt)) then Exit;
    end;
  end;
  Result := true;
end;

{==============================================================================}
function TWettkColl.KeinOderAlleTlnStaffel: Boolean;
{==============================================================================}
// true wenn keine oder alle TlnStaffel
var i,j : Integer;
begin
  Result := false;
  for i:=0 to Count-1 do
    for j:=i+1 to Count-1 do
      if (GetPItem(i).WettkArt = waTlnStaffel) <>
         (GetPItem(j).WettkArt = waTlnStaffel) then Exit;
  Result := true;
end;

{==============================================================================}
function TWettkColl.AlleMitSchwDistanz: Boolean;
{==============================================================================}
var i : Integer;
begin
  Result := false;
  for i:=0 to Count-1 do
    if Items[i].GetSchwimmDistanz = 0 then Exit;
  Result := true;
end;


(******************************************************************************)
(*     Methoden von TReportWkObj                                              *)
(******************************************************************************)

//==============================================================================
constructor TReportWkObj.Create(WkNeu:TWettkObj; WrtgNeu:TWertungMode);
//==============================================================================
begin
  Wettk := WkNeu;
  Wrtg  := WrtgNeu;
end;

//==============================================================================
function TReportWkObj.Name: String;
//==============================================================================
begin
  if Wrtg = wgStandWrtg then Result := Wettk.Name
                        else Result := Wettk.SondTitel;
end;

end.
