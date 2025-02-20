unit LstFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls,Math,
  AllgComp,AllgConst,AllgFunc,CmdProc,DateiDlg,AllgObj,AkObj,WettkObj,TlnObj,
  VeranObj,SGrpObj,SMldObj,MannsObj, ExtCtrls, AnsFrm;

type
  TLstFrame = class(TFrame)
    AnsFrame: TAnsFrame;
    procedure FrameResize(Sender: TObject);
    procedure TriaGridKeyPress(Sender: TObject; var Key: Char);
    procedure TriaGridContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  published
    TriaGrid: TTriaGrid;
    procedure TriaGridClick(Sender: TObject);
    procedure TriaGridDblClick(Sender: TObject);
    procedure TriaGridDrawCell(Sender: TObject; ACol, ARow: Integer;
                               Rect: TRect; State: TGridDrawState);
  private
    // standard Spaltenbreite wird in Array gespeichert und kann manuell ge�ndert
    // werden. Wert gilt einheitlich f�r alle Ansichten
    ColBreite : array[anKein..anTlnSchwDist, spLeer..spVName] of Integer;
    //procedure   InitColBreiteArr;
    function    OrtColBreite(C:TColType):Integer;
    function    ZeitColBreite(C:TColType): Integer;
    function    MschTlnColBreite(MschGr:Integer):Integer;
    //function  ColType(C:Integer):TColType;
    function    StandardColBreite(Ans:TAnsicht; C:TColType):Integer;
  public
    procedure   InitColBreiteArr;
    constructor Create(AOwner: TComponent); override;
    procedure   Init; // erste Initialisierung
    procedure   SaveColWidths;
    procedure   UpdateColWidths;
    //procedure   UpdateColBreite;
    procedure   InitAnsicht(AnsichtNeu:TAnsicht;ModeNeu:TSortMode;
                            WkNeu:TWettkObj; WrtgNeu:TWertungMode;
                            SexNeu:TSex; AkNeu:TAkObj; StatusNeu:TStatus);
    procedure   UpdateAnsicht;  // bestehende Ansicht unver�ndert
    procedure   RefreshAnsicht; // TriaListe wird nicht mehr sortiert
    procedure   GridInit;
    procedure   GridRefresh;
    procedure   UpdateOrtColBreite;
    procedure   UpdateZeitColBreite;
    procedure   UpdateMschTlnColBreite;
    function    AkColBreite(C:TColType): Integer;
    procedure   UpdateAkColBreite;
    function    AlignMode(R:Integer; C:TColType; RepWk:TWettkObj):TAlignMent;
    //function    ColText(Tln:TTlnObj; C:TColType; var TrennLinie: Boolean):String;
  end;


implementation

uses TriaMain,TlnDlg, SMldFrm, ListFmt,ImpFrm;

{$R *.dfm}

// public Methoden

(*============================================================================*)
constructor TLstFrame.Create(AOwner: TComponent);
(*============================================================================*)
begin
  inherited Create(AOwner);
  TriaGrid.Canvas.Font := TriaGrid.Font;
  TriaGrid.DefaultRowHeight := TriaGrid.Canvas.TextHeight('Tg')+1; // =14
  TriaGrid.TopAbstand := 0;
  Align := alClient;
  TriaGrid.FixedRows := 1;
  TriaGrid.FixedCols := 0;
  TriaGrid.DefaultDrawing := true;
end;

(*============================================================================*)
procedure TLstFrame.Init;
(*============================================================================*)
// erste Initialisierung
begin
  HauptFenster.SortWettk := WettkAlleDummy; //ab 2010, Veranstaltung kann nil sein
  InitColBreiteArr;
  InitAnsicht(anAnmEinzel,smTlnName,HauptFenster.SortWettk,
              wgStandWrtg,cnSexBeide,AkAlle,stGemeldet);
end;

(*============================================================================*)
procedure TLstFrame.SaveColWidths;
(*============================================================================*)
// f�r aktuelle Ansicht
var i : Integer;
begin
  for i:=0 to TriaGrid.ColCount-1 do
    ColBreite[HauptFenster.Ansicht,GetColType(HauptFenster.ListType,HauptFenster.SortWettk,i,lmSchirm)] :=
      TriaGrid.ColWidths[i];
end;

(*============================================================================*)
procedure TLstFrame.UpdateColWidths;
(*============================================================================*)
// f�r aktuelle Ansicht
var i : Integer;
begin
  for i:=0 to TriaGrid.ColCount-1 do
    TriaGrid.ColWidths[i] :=
      ColBreite[HauptFenster.Ansicht,GetColType(HauptFenster.ListType,HauptFenster.SortWettk,i,lmSchirm)];
end;

(*============================================================================*)
procedure TLstFrame.InitAnsicht(AnsichtNeu:TAnsicht;ModeNeu:TSortMode;
                                WkNeu:TWettkObj;WrtgNeu:TWertungMode;
                                SexNeu:TSex;AkNeu:TAkObj;StatusNeu:TStatus);
(*============================================================================*)
begin
  SaveColWidths; // ColWidths in ColBreiteArr f�r alte Ansicht speichern
  // neue Ansicht gesetzt
  AnsFrame.Init(AnsichtNeu,ModeNeu,WkNeu,WrtgNeu,SexNeu,AkNeu,StatusNeu);
  HauptFenster.FocusedTln := nil;
  GridInit;
end;

(*============================================================================*)
procedure TLstFrame.UpdateAnsicht;
(*============================================================================*)
begin
  SaveColWidths; // ColWidths in ColBreiteArr f�r aktuelle Ansicht speichern
  AnsFrame.Refresh;
  GridInit;
end;

(*============================================================================*)
procedure TLstFrame.RefreshAnsicht;
(*============================================================================*)
// nach �nderung in Veranstaltung-Collections, die vorher sortiert werden
// TriaListe wird nicht mehr sortiert
// nicht benutzen im Dialoge solange WettkSortcollection noch benutzt wird
begin
  AnsFrame.Refresh;
  GridRefresh;
end;

(*============================================================================*)
procedure TLstFrame.GridInit;
(*============================================================================*)
var i : Integer;
    //Meldung : Boolean;
begin
// Ansicht, SortOrt, SortWettk, SortSex, SortKlasse vorher g�ltig gesetzt
  if HauptFenster.Ansicht = anKein then Exit;

  // Aktuelle ColWidths vorher in ColBreite speichern

  TriaGrid.StopPaint := true;

  with HauptFenster do
  try
    if Veranstaltung <> nil then
    begin
      if Ansicht <> anAnmSammel then SMldFrame.Schliessen;
      case Ansicht of
        anAnmSammel:
        begin
          if not SMldFrame.Visible then SMldFrame.Oeffnen;
          SortSMld.TlnListe.Sortieren(SortMode,SortWettk,SortKlasse,SortStatus);
          TriaGrid.Init(HauptFenster.SortSMld.TlnListe,smSortiert,ssBoth,FocusedTln);
        end;
        anAnmEinzel,
        anTlnStart,
        anTlnErgSerie,
        anTlnErg,
        anTlnUhrZeit,
        anTlnRndKntrl,
        anTlnSchwDist:
        begin
          Veranstaltung.TlnColl.Sortieren(Veranstaltung.OrtIndex,SortMode,
                                          SortWettk,SortWrtg,SortKlasse,
                                          SortSMld,SortStatus);
          TriaGrid.Init(Veranstaltung.TlnColl,smSortiert,ssBoth,FocusedTln);
        end;
        anMschStart,
        anMschErgDetail,
        anMschErgKompakt,
        anMschErgSerie:
        begin
          // TlnColl wird gleichzeitig sortiert
          Veranstaltung.MannschColl.Sortieren(Veranstaltung.OrtIndex,SortMode,
                                              SortWettk,SortKlasse,
                                              SortStatus,smMitTlnColl);
          TriaGrid.Init(Veranstaltung.TlnColl,smSortiert,ssBoth,FocusedTln);
        end;
      end;

    end else
    begin
      TriaGrid.Init(nil,smNichtSortiert,ssBoth,nil);
    end;
    with TriaGrid do
    begin
      ListType := GetListType(lmSchirm,SortWettk,SortWrtg,SortWettk.MschGroesse[SortKlasse.Sex]);
      if ListType <> ltFehler then // beim Start �berschriftszeile ohne Text
      begin
        i:=0;
        while GetColType(ListType,SortWettk,i,lmSchirm) <> spLeer do
          Inc(i);
        if ColCount <> i then ColCount := i;
        UpdateColWidths; // Fenster wird manchmal Leer
        //UpdateAnsicht; // sonst bleibt Grid blank  Einfg�gen??
      end;
    end;

  finally
    TriaGrid.StopPaint := false;
    TriaGrid.Refresh;
    Application.ProcessMessages;
    with HauptFenster do
      if not ProgressBarStehenLassen then
      begin
        if ProgressBar.Visible then StatusBarClear;
        StatusBarUpdate;
      end;
  end;

end;

(*============================================================================*)
procedure TLstFrame.GridRefresh;
(*============================================================================*)
begin
  TriaGrid.CollectionUpdate;
  TriaGrid.Refresh;
  SetzeCommands;
  HauptFenster.StatusBarUpdate;
end;

//==============================================================================
procedure TLstFrame.UpdateOrtColBreite;
//==============================================================================
// benutzt wenn in VstOrtDlg Ortsnamen ge�ndert werden
var A : TAnsicht;
    C : TColType;
    i : Integer;
begin
  for A:= anKein to anTlnSchwDist do
    for C:= spOrt1 to spOrt20 do
      ColBreite[A,C] := OrtColBreite(C);
  // und aktuelle ColWidths anpassen, da sonst bei UpdateAnsicht ColBreite auf
  // alter Wert zur�ckgesetzt wird
  for i:=0 to TriaGrid.ColCount-1 do
  begin
    C := GetColType(HauptFenster.ListType,HauptFenster.SortWettk,i,lmSchirm);
    if C in [spOrt1..spOrt20] then
      TriaGrid.ColWidths[i] := ColBreite[HauptFenster.Ansicht,C];
  end;
end;

//==============================================================================
procedure TLstFrame.UpdateZeitColBreite;
//==============================================================================
// benutzt wenn in OptDlg Zeitformat ge�ndert wird  (Sek,Zehntel,Hundertstel)
var A : TAnsicht;
    C : TColType;
    i : Integer;
//..............................................................................
function ZeitSpalte(C:TColType): Boolean;
begin
  Result := C in [spStZeit,
                  spMschStZeit,
                  spAbs1StrtZeit..spAbs8StrtZeit,
                  spAbs1Zeit..spAbs8Zeit,
                  spMschTlnZt0..spMschTlnZt7,
                  spAbs1UhrZeit..spAbs8UhrZeit,
                  spMschTlnEndZeit,
                  spTlnEndZeit,
                  spMschEndzeit,
                  spAbs1Rng..spAbs8Rng,
                  spAbs1StopZeit..spAbs8StopZeit,
                  spAbs1MinZeit..spAbs8MinZeit,
                  spAbs1MaxZeit..spAbs8MaxZeit,
                  spAbs1EffZeit..spAbs8EffZeit];
end;
//..............................................................................
begin
  for A:= anKein to anTlnSchwDist do
    for C:= spLeer to spVName do
      if ZeitSpalte(C) then
        ColBreite[A,C] := ZeitColBreite(C);
  // und aktuelle ColWidths anpassen, da sonst bei UpdateAnsicht ColBreite auf
  // alter Wert zur�ckgesetzt wird
  for i:=0 to TriaGrid.ColCount-1 do
  begin
    C := GetColType(HauptFenster.ListType,HauptFenster.SortWettk,i,lmSchirm);
    if ZeitSpalte(C) then
      TriaGrid.ColWidths[i] := ColBreite[HauptFenster.Ansicht,C];
  end;
end;

(*============================================================================*)
procedure TLstFrame.UpdateMschTlnColBreite;
(*============================================================================*)
// benutzt in WettkDlg wenn MschGr ge�ndert wird oder
// durch Wechsel von SortWettk oder SortKlasse
// Update ColBreiteArr und danach auch ColWidths, da sonst bei UpdateAnsicht
// (SaveColWidths) ColBreite auf alter Wert zur�ckgesetzt wird
// nur benutzt f�r Ansicht anMschErgKompakt
var i,MschGr : Integer;
    C : TColType;
begin
  // Array Colbreite f�r MschTln auf Standartwerte setzen
  MschGr := HauptFenster.SortWettk.MschGroesse[HauptFenster.SortKlasse.Sex];
  for C:=spMschTln0 to spMschTln7 do
    ColBreite[anMschErgKompakt,C] := MschTlnColBreite(MschGr);

  // und aktuelle ColWidths anpassen, da sonst bei UpdateAnsicht ColBreite auf
  // alter Wert zur�ckgesetzt wird
  if HauptFenster.Ansicht = anMschErgKompakt then
    for i:=0 to TriaGrid.ColCount-1 do
    begin
      C := GetColType(HauptFenster.ListType,HauptFenster.SortWettk,i,lmSchirm);
      if C in [spMschTln0..spMschTln7] then
        TriaGrid.ColWidths[i] := ColBreite[anMschErgKompakt,C];
    end;
end;

//==============================================================================
function TLstFrame.AkColBreite(C:TColType): Integer;
//==============================================================================
begin
  with TriaGrid do
  case C of
    spAk,
    spMschKlasse : if HauptFenster.SortWettk.LangeAkKuerzel then
                     Result := Canvas.TextWidth(' WK0U00 ')
                   else
                     Result := Canvas.TextWidth(' W00 ');
    spAkRng,
    spAkRngSer   : if HauptFenster.SortWettk.LangeAkKuerzel then
                     Result := Canvas.TextWidth(' WK0U00  0000 ')
                   else
                     Result := Canvas.TextWidth(' W00  0000 ');
    else Result := Canvas.TextWidth(' ');
  end;
end;

//==============================================================================
procedure TLstFrame.UpdateAkColBreite;
//==============================================================================
// Ausf�hren wenn Wettk.LangeAkKuerzel sich �ndert in KlassenDlg oder
// durch Wechsel von SortWettk
// Update ColBreiteArr und danach auch ColWidths, da sonst bei UpdateAnsicht
// (SaveColWidths) ColBreite auf alter Wert zur�ckgesetzt wird
var A : TAnsicht;
    C : TColType;
    i : Integer;
begin
  for A:= anKein to anTlnSchwDist do
  begin
    ColBreite[A,spAk]         := AkColBreite(spAk);
    ColBreite[A,spMschKlasse] := AkColBreite(spMschKlasse);
    ColBreite[A,spAkRng]      := AkColBreite(spAkRng);
    ColBreite[A,spAkRngSer]   := AkColBreite(spAkRngSer);
  end;
  for i:=0 to TriaGrid.ColCount-1 do
  begin
    C := GetColType(HauptFenster.ListType,HauptFenster.SortWettk,i,lmSchirm);
    if C in [spAk,spMschKlasse,spAkRng,spAkRngSer] then
      TriaGrid.ColWidths[i] := ColBreite[HauptFenster.Ansicht,C];
  end;
end;

//==============================================================================
function TLstFrame.AlignMode(R:integer; C:TColType; RepWk:TWettkObj):TAlignment;
//==============================================================================
begin
  Result := taLeftJustify;
  if R >= TriaGrid.ItemCount  + 1 then Exit;
  if R>0 then // Datenzeilen
    case C of
      spGeAendert   : Result := taCenter;
      spSnr         : Result := taRightJustify;
      spNameVName   : Result := taLeftJustify;
      spMannsch     : Result := taLeftJustify;
      spMschGroesse : Result := taCenter;
      spLand        : Result := taLeftJustify;
      spJg          : Result := taCenter;
      spAk          : Result := taCenter;
      spWettk       : Result := taLeftJustify;
      spStZeit      : Result := taRightJustify;
      //spSGrpStZeit   : Result := taRightJustify;
      spStBahn      : Result := taCenter;
      spMeldeZeit   : Result := taRightJustify;
      spStartgeld   : Result := taRightJustify;
      spMschWrtg,
      spMschMixWrtg,
      spSondWrtg,
      spSerWrtg,
      spUrkDr,
      spAusKonkAllg,
      spAusKonkAltKl,
      spAusKonkSondKl : Result := taCenter;
      spRfid        : Result := taLeftJustify;
      spKomment     : Result := taLeftJustify;
      spRng,
      spAkRng,
      spAkRngSer,
      spAbs1Rng..spAbs8Rng,
      spAbs1Zeit..spAbs8Zeit,
      spAbs1UhrZeit..spAbs8UhrZeit,
      spAbs1MinZeit..spAbs8MinZeit,
      spAbs1MaxZeit..spAbs8MaxZeit,
      spAbs1EffZeit..spAbs8EffZeit,
      spMschTlnZt0..spMschTlnZt7,
      spMschTlnEndZeit,spMschTlnStrecke,spMschTlnPunkte,
      spTlnEndZeit,
      spTlnEndStrecke : Result := taRightJustify;

      spAbs1Runden..spAbs8Runden,
      spMschRunden,spMschTlnRunden,
      spAbs1StrtZeit..spAbs8StrtZeit,
      spAbs1StopZeit..spAbs8StopZeit : Result := taCenter;

      spStatus      : Result := taLeftJustify;
      spRngSer      : Result := taRightJustify;
      spSumSer      : Result := taRightJustify;
      spOrt1..spOrt20: Result := taCenter;
      spMschName    : Result := taLeftJustify;
      spMschKlasse  : Result := taCenter;
      spMschWettk   : Result := taLeftJustify;
      spMschRngGes,spMschRngSer,spMschSumSer:
                      Result := taRightJustify;
      spMschEndzeit,spMschStrecke,spMschPunkte:
                      Result := taRightJustify;
      spMschTln0..spMschTln7: Result := taLeftJustify;

      spName,
      spVName       : Result := taLeftJustify;
      spSex         : Result := taCenter;
      spStrasse,
      spHausNr,
      spPLZ,
      spOrt,
      spEMail       : Result := taLeftJustify;

      else            Result := taLeftJustify;
    end
  else // Headerzeile
    case C of
      spGeAendert   : Result := taLeftJustify;
      spSnr         : Result := taCenter;
      spNameVName   : Result := taLeftJustify;
      spMannsch     : Result := taLeftJustify;
      spMschGroesse : Result := taCenter;
      spLand        : Result := taCenter;
      spJg          : Result := taCenter;
      spAk          : Result := taCenter;
      spWettk       : Result := taLeftJustify;
      spStZeit      : Result := taCenter;
      //spSGrpStZeit  : Result := taCenter;
      spStBahn      : Result := taCenter;
      spMeldeZeit   : Result := taCenter;
      spStartgeld   : Result := taCenter;
      spMschWrtg,
      spMschMixWrtg,
      spSondWrtg,
      spSerWrtg,
      spUrkDr,
      spAusKonkAllg,
      spAusKonkAltKl,
      spAusKonkSondKl : Result := taCenter;
      spRfid        : Result := taLeftJustify;
      spKomment     : Result := taLeftJustify;
      spRng,
      spAkRng,
      spAkRngSer    : Result := taCenter;
      spAbs1Rng..spAbs8Rng,
      spAbs1Zeit..spAbs8Zeit,
      spAbs1UhrZeit..spAbs8UhrZeit,
      spAbs1Runden..spAbs8Runden,
      spMschRunden,spMschTlnRunden,
      spAbs1MinZeit..spAbs8MinZeit,
      spAbs1MaxZeit..spAbs8MaxZeit,
      spAbs1EffZeit..spAbs8EffZeit,
      spAbs1StopZeit..spAbs8StopZeit,
      spAbs1StrtZeit..spAbs8StrtZeit,
      spMschTlnZt0..spMschTlnZt7,
      spMschTlnEndZeit,spMschTlnStrecke,spMschTlnPunkte,
      spTlnEndZeit,
      spTlnEndStrecke : Result := taCenter;
      spStatus      : Result := taLeftJustify;
      spRngSer      : Result := taCenter;
      spSumSer      : Result := taCenter;
      spOrt1..spOrt20: Result := taCenter;
      spMschName    : Result := taLeftJustify;
      spMschKlasse  : Result := taCenter;
      spMschWettk   : Result := taLeftJustify;
      spMschRngGes,spMschEndzeit,
      spMschStrecke,spMschPunkte,
      spMschRngSer,spMschSumSer:
                      Result := taCenter;
      spMschTln0,spMschTln1,spMschTln2,spMschTln3,
      spMschTln4,spMschTln5,spMschTln6,spMschTln7:
                      Result := taLeftJustify;
      spName,
      spVName       : Result := taLeftJustify;
      spSex         : Result := taCenter;
      spStrasse,
      spHausNr,
      spPLZ,
      spOrt,
      spEMail       : Result := taLeftJustify;

      else            Result := taLeftJustify;
    end;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TLstFrame.TriaGridClick(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  // wird immer ausgef�hrt wenn ItemIndex gesetzt wird
  // und damit wird FocusedTln automatisch aktualisiert, aber
  // nur wenn sich Zeile �ndert
  if TriaGrid.StopPaint then Exit;
  HauptFenster.FocusedTln := TTlnObj(TriaGrid.FocusedItem);
  if HauptFenster.ImpFrame.Visible and HauptFenster.ImpFrame.ImpTlnEnabled and
     not HauptFenster.ImpFrame.Updating then //nach ImpTlnFrame.Init enabled
  begin
    HauptFenster.ImpFrame.ZielTln := HauptFenster.FocusedTln;
    HauptFenster.ImpFrame.SetImpTlnFontStyle;
    //HauptFenster.ImpTlnFrame.SetImpTlnModeGB;
  end;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TLstFrame.TriaGridDblClick(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if TriaGrid.StopPaint then Exit;
  if HauptFenster.TlnBearbeitenAction.Enabled then
    HauptFenster.TlnBearbeitenActionExecute(Sender);
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TLstFrame.TriaGridKeyPress(Sender: TObject; var Key: Char);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if TriaGrid.StopPaint then Exit;
  if Word(Key) = VK_RETURN then
    if HauptFenster.TlnBearbeitenAction.Enabled then
    begin
      HauptFenster.TlnBearbeitenActionExecute(Sender);
      Key := #0;
    end;
  inherited KeyPress(Key);
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TLstFrame.TriaGridDrawCell(Sender: TObject; ACol, ARow: Integer;
                                     Rect: TRect; State: TGridDrawState);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
var CType : TColType;
    S:String;
    TrennLinie: Boolean;
begin
  with Sender as TTriaGrid do
  begin
    if StopPaint then Exit;
    CType := spLeer; // Compiler-Warnung vermeiden
    if ARow > ItemCount then S := '' // RowsMin = 2,auch wenn ItemCount=0
    else
    begin
      CType := GetColType(HauptFenster.ListType,HauptFenster.SortWettk,ACol,lmSchirm);
      if ARow < FixedRows then
        S := GetColHeader(CType,HauptFenster.SortWettk)
      else S := GetColData(HauptFenster.SortWettk,HauptFenster.SortWrtg,HauptFenster.SortKlasse,
                           TTlnObj(TriaGrid[ARow-1]),CType,TrennLinie,lmSchirm);
    end;
    DrawCellText(Rect,S,AlignMode(ARow,CType,HauptFenster.SortWettk));
    (* bei Mannschaftsansicht mit Teilnehmer hor. Trennlinie pro Mannschaft *)
    if TrennLinie and (ARow>1) then
      Canvas.Polyline([Rect.TopLeft, Point(Rect.Right,Rect.Top)]);
  end;
end;

//------------------------------------------------------------------------------
procedure TLstFrame.InitColBreiteArr;
//------------------------------------------------------------------------------
// nur Erst-Initialisierung
var A : TAnsicht;
    C : TColType;
begin
  for A:= anKein to anTlnSchwDist do // alle Ansichten
    for C:= spLeer to spVName do // alle Spalten
      ColBreite[A,C] := StandardColBreite(A,C);
end;

{------------------------------------------------------------------------------}
function TLstFrame.OrtColBreite(C:TColType):Integer;
{------------------------------------------------------------------------------}
var i : Integer;
begin
  Result := 0;
  if C in [spOrt1..spOrt20] then
  begin
    Result := TriaGrid.Canvas.TextWidth(' 00000 ');
    if Veranstaltung <> nil then // Spalten nicht benutzt wenn nil
    begin
      i := (Integer(C)-Integer(spOrt1));
      if Veranstaltung.OrtColl.Count > i then
        Result := Max(Result,TriaGrid.Canvas.TextWidth('  '+Veranstaltung.OrtColl[i].Name));
    end;
  end;
end;

//------------------------------------------------------------------------------
function TLstFrame.ZeitColBreite(C:TColType): Integer;
//------------------------------------------------------------------------------
var ZeitWidth : Integer;
begin
  with TriaGrid do
  begin
    case ZeitFormat of
      zfSek     : ZeitWidth := Canvas.TextWidth(' 00:00:00 ');
      zfZehntel : ZeitWidth := Canvas.TextWidth(' 00:00:00.0 ')
      else        ZeitWidth := Canvas.TextWidth(' 00:00:00.00 '); // zfHundertstel
    end;
    case C of
      spStZeit,
      spMschStZeit,
      spAbs1StrtZeit..spAbs8StrtZeit,
      spAbs1Zeit..spAbs8Zeit,
      spMschTlnZt0..spMschTlnZt7,
      spAbs1UhrZeit..spAbs8UhrZeit   : Result := ZeitWidth; // mit Sek,Zehntel,Hundertstel
      spMschTlnEndZeit,
      spTlnEndZeit,spMschEndzeit,
      spSumSer,spMschSumSer          : Result := ZeitWidth + Canvas.TextWidth('*'); // mit Sek,Zehntel,Hundertstel
      spAbs1Rng..spAbs8Rng           : Result := ZeitWidth + Canvas.TextWidth(' 0000 ');
      spAbs1StopZeit..spAbs8StopZeit : Result := Max(ZeitWidth,Canvas.TextWidth(' Stoppzeit '));
      spAbs1MinZeit..spAbs8MinZeit,
      spAbs1MaxZeit..spAbs8MaxZeit,
      spAbs1EffZeit..spAbs8EffZeit   : Result := Max(ZeitWidth,Canvas.TextWidth(' Abs.4-Zeit '));
      else Result := 0;
    end;
  end;
end;

//------------------------------------------------------------------------------
function TLstFrame.MschTlnColBreite(MschGr:Integer):Integer;
//------------------------------------------------------------------------------
begin
  with TriaGrid.Canvas do
  case MschGr of
    5:   Result := TextWidth(' Xxxxxxxxxxxxx,Xxxxxxx ');
    6:   Result := TextWidth(' Xxxxxxxxxxxxx,Xxxxx ');
    7:   Result := TextWidth(' Xxxxxxxxxxxxx,Xxx');
    8:   Result := TextWidth(' Xxxxxxxxxxxxx,X');
    else Result := TextWidth(' Xxxxxxxxxxxxx,Xxxxxxxxx');
  end;
end;

//------------------------------------------------------------------------------
function TLstFrame.StandardColBreite(Ans:TAnsicht; C:TColType):Integer;
//------------------------------------------------------------------------------
begin
  with TriaGrid do
  begin
    case C of
      spGeAendert   : Result := Canvas.TextWidth(' 00.00.0000  00:00 ');
      spSnr         : Result := Canvas.TextWidth(' 0000 ');
      spNameVName   :
        case Ans of
          anAnmEinzel,anAnmSammel:
               Result := Canvas.TextWidth(' 0123456789, 01234 ');
          else Result := Canvas.TextWidth(' 012345678901234, 0123456 ');
        end;
      spMannsch     :
        case Ans of
          anAnmEinzel,anAnmSammel:
               Result := Canvas.TextWidth(' 01234567890123456 ');
          else Result := Canvas.TextWidth(' 012345678901234567890 ');
        end;
      spMschGroesse : Result := Canvas.TextWidth(' 0000 ');
      spLand        : Result := Canvas.TextWidth(' NRW ');
      spJg          : Result := Canvas.TextWidth(' 00 ');
      spAk,
      spAkRng,
      spAkRngSer,
      spMschKlasse  : Result := AkColBreite(C);
      spWettk       : Result := Canvas.TextWidth(' 0123456789012345678 ');
      //spSGrpStZeit   : Result := Canvas.TextWidth(' 00:00:00 ');
      spStBahn      : Result := Canvas.TextWidth(' 00 ');
      spMschWrtg    : Result := Canvas.TextWidth(' Msch ');
      spMschMixWrtg : Result := Canvas.TextWidth(' Mix ');
      spSondWrtg    : Result := Canvas.TextWidth(' Sond ');
      spSerWrtg     : Result := Canvas.TextWidth(' Ser ');
      spUrkDr       : Result := Canvas.TextWidth(' Urk ');
      spAusKonkAllg : Result := Canvas.TextWidth(' a.K. ');
      spAusKonkAltKl : Result := Canvas.TextWidth(' a.K.AK ');
      spAusKonkSondKl: Result := Canvas.TextWidth(' a.K.SK ');
      spRfid        : Result := Canvas.TextWidth(' 01234567890AB ');
      spKomment     : Result := Canvas.TextWidth(' 01234567890123456789 ');
      spRng         : Result := Canvas.TextWidth(' 0000 ');
      //spMeldeZeit   : Result := Canvas.TextWidth(' 00:00:00 ');// ohne Zehntel
      spMeldeZeit   : Result := Canvas.TextWidth('Meldezeit ');
      spStartgeld   : Result := Canvas.TextWidth('Startgeld ');
      spStZeit,
      spMschStZeit,
      spAbs1StrtZeit..spAbs8StrtZeit,
      spAbs1Zeit..spAbs8Zeit,
      spMschTlnZt0..spMschTlnZt7,
      spAbs1UhrZeit..spAbs8UhrZeit,
      spMschTlnEndZeit,
      spTlnEndZeit,spMschEndzeit,
      spSumSer,spMschSumSer,
      spAbs1Rng..spAbs8Rng,
      spAbs1StopZeit..spAbs8StopZeit,
      spAbs1MinZeit..spAbs8MinZeit,
      spAbs1MaxZeit..spAbs8MaxZeit,
      spAbs1EffZeit..spAbs8EffZeit   : Result := ZeitColBreite(C);
      spTlnEndStrecke,
      spMschStrecke,spMschTlnStrecke : Result := Canvas.TextWidth(' 000,000 *');
      spMschPunkte,spMschTlnPunkte   : Result := Canvas.TextWidth(' Punkte ');
      spAbs1Runden..spAbs8Runden,
      spMschRunden,spMschTlnRunden   : Result := Canvas.TextWidth(' Runden ');
      spStatus        : Result := Canvas.TextWidth(' Abschn.2 ');
      spRngSer        : Result := Canvas.TextWidth(' 0000 ');
      spOrt1..spOrt20 : Result := OrtColBreite(C);
      spMschName      : Result := Canvas.TextWidth(' 012345678901234567890 ');
      spMschWettk     : Result := Canvas.TextWidth(' Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ');
      spMschRngGes    : Result := Canvas.TextWidth(' 0000 ');
      spMschRngSer    : Result := Canvas.TextWidth(' 0000 ');
      spMschTln0..spMschTln7 : Result := MschTlnColBreite(cnMschGrDefault); // Default = 3

      else Result := Canvas.TextWidth(' ');
    end;
  end;
end;

{procedure TLstFrame.FrameResize(Sender: TObject);
begin
  if TriaGrid = nil then Exit;
  TriaGrid.Width := ClientWidth;
  TriaGrid.Height := ClientHeight - AnsFrame.Height;
end;}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TLstFrame.FrameResize(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  // beim Scrollen ItemIndex/Row anpassen, damit dieser sichtbar bleibt
  // damit �ndert sich FocusedItem beim Scrollen
  with TriaGrid do
    if Row < TopRow then Row := TopRow
    else if Row >= TopRow + VisibleRowCount then Row := TopRow+VisibleRowCount-1;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TLstFrame.TriaGridContextPopup(Sender:TObject; MousePos:TPoint; var Handled:Boolean);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var ACol,ARow:Integer;
begin
  TriaGrid.MouseToCell(MousePos.X,MousePos.Y,ACol,ARow);
  if (ARow >= 1) and (ARow <= TriaGrid.ItemCount) then
    TriaGrid.ItemIndex := ARow-1
  else
    Handled := true; // kein PopUp
end;


end.
