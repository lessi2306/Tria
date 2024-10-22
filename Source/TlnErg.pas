unit TlnErg;

interface

uses
  Classes,SysUtils,Dialogs,Math,Controls,Forms,
  AllgConst,AllgFunc,AkObj,WettkObj,SGrpObj,SMldObj,TlnObj,MannsObj,VeranObj,
  AllgObj,DateiDlg;

function BerechneRangAlleWettk: Boolean;

implementation

uses TriaMain;

procedure BerechneTagesRang(Wettkampf:TWettkObj); forward;
procedure BerechneSerienRang(Wettkampf:TWettkObj); forward;
//procedure SetzeErstZeit(Abs:TwkAbschnitt); forward;
procedure SetzeErstZeitTln(Abs:TwkAbschnitt); forward;
procedure SetzeErstZeitMsch(Abs:TwkAbschnitt); forward;

(******************************************************************************)
function BerechneRangAlleWettk: Boolean;
(******************************************************************************)
// in ProgressbarText wird ProcessMessages aufgerufen. Dabei kann Schliessen
// erkannt werden. Dann (Application terminated) Berechnung abbrechen
var i,j         : Integer;
    OrtIndexAlt : Integer;
    MaxBarSize  : Integer;
    MeldungText : String;
    MschZahl    : integer;
    AbsCnt      : TWkAbschnitt;
    ProgressBarStehenLassenAlt : Boolean;
begin
  Rechnen        := false;
  Result         := false;

  if not Application.Terminated and TriDatei.Geladen and (Veranstaltung<>nil) then
  with Veranstaltung do
  begin
    OrtIndexAlt := OrtIndex;
    ProgressBarStehenLassenAlt := HauptFenster.ProgressBarStehenLassen;

    if (WettkColl.Count>0) {and (TlnColl.Count>0)} then // auch beim l�schen aller Tln
    try                                                 // MschEinlesen (MannschColl.Clear)
      HauptFenster.ProgressBarStehenLassen := true;
      // zuerst MaxBarSize berechnen
      MaxBarSize := 0;
      // MannschColl erst nach dem Einlesen bekannt, deshalb zuerst einlesen
      // daf�r 10% der Gesamtzeit berechnen
      // davor zuerst TlnKlassen setzen, auch 10%
      for j:=0 to WettkColl.Count-1 do
        if WettkColl[j].KlassenModified then
        begin
          MaxBarSize := MaxBarSize + 10 * TlnColl.Count;
          Result := true; // unabh�ngig von TlnColl.Count
        end;

      if Result then // auch bei TlnCount=0
      begin
        // Init Meldung
        MeldungText := 'Altersklassen werden definiert';
        with HauptFenster do
          if ProgressBarStehenLassenAlt then // DateiDlg: Position = 20/30%
          begin
            ProgressBarText(MeldungText);
            ProgressBarMaxUpdate(MaxBarSize);
          end else
            ProgressBarInit(MeldungText,MaxBarSize);

        if Application.Terminated then Exit;
        HauptFenster.LstFrame.TriaGrid.StopPaint := true;
        // TlnKlassen setzen, 10% BarSteps
        for j:=0 to WettkColl.Count-1 do
          if WettkColl[j].KlassenModified then
          begin
            TlnColl.UpdateKlassen(WettkColl[j]);
            WettkColl[j].KlassenModified := false;
          end;
      end;
//ShowMessage('ProgressBar.Max = '+IntToStr(HauptFenster.ProgressBar.Max));
//ShowMessage('ProgressBar.Position = '+IntToStr(HauptFenster.ProgressBar.Position));
      // Mannschaften einlesen

      // Setze MschAkZahlMax f�r alle Berechnungen
      for i:=0 to WettkColl.Count-1 do
        with WettkColl[i] do
          MschAkZahlMax := Max(AltMKlasseColl[tmMsch].Count,
                             Max(AltWKlasseColl[tmMsch].Count,1));//f�r WrtgAlle,-Sex max=1

      MschZahl := 0;
      // Loop �ber alle Wettk�mpfe
      for j:=0 to WettkColl.Count-1 do
        // MschZahl berechnen
        if (MannschColl<>nil) and WettkColl[j].MschModified then
        begin
          MschZahl := MschZahl + MannschNameColl.Count;
          Result := true;
        end;
      if Result then // auch bei MannschNameColl.Count=0
      begin
        // Init Meldung
        MeldungText := 'Mannschaften werden definiert';
        with HauptFenster do
        begin
          if ProgressBarStehenLassenAlt or ProgressBar.Visible then
          begin
            // aktuelle BarPos beibehalten
            ProgressBarText(MeldungText);
            ProgressBarMaxUpdate(10*MschZahl);// weitere 10% f�llen
          end else
            ProgressBarInit(MeldungText,10*MschZahl);
          if Application.Terminated then Exit;
          LstFrame.TriaGrid.StopPaint := true;
        end;
        for j:=0 to WettkColl.Count-1 do
        with WettkColl[j] do
        begin
          if MannschColl<>nil then
          begin
            if MschModified then
            begin
              MannschColl.MschEinlesen(WettkColl[j]);
              MschModified := false;
            end;
          end;
        end;
      end;
//ShowMessage('ProgressBar.Max = '+IntToStr(HauptFenster.ProgressBar.Max));
//ShowMessage('ProgressBar.Position = '+IntToStr(HauptFenster.ProgressBar.Position));

      // Rest f�r Progressbar berechnen
      MaxBarSize := 0;
      // Loop �ber alle Austragungsorte
      for i:=0 to OrtColl.Count-1 do
      begin
        // MschZeiten
        for j:=0 to WettkColl.Count-1 do
          if WettkColl[j].OrtErgModified[i] then
          begin
            MaxBarSize := MaxBarSize + (1+cnAbsZahlMax*2) * MannschColl.Count;
            Result := true; // unabh�ngig von MannschColl.Count
          end;
//ShowMessage('MaxBarSize = '+IntToStr(MaxBarSize)+#13+'MschZeiten'+#13+'OrtIndex = '+IntToStr(i));

        // BerechneRang(wettk(j))
        for j:=0 to WettkColl.Count-1 do
        begin
          if WettkColl[j].OrtErgModified[i] then
          begin
            //Result := true;  vorher bereits gesetzt
            if WettkColl[j].MschWertg<>mwKein then
              //MannschaftsWertung
              if WettkColl[j].MschWettk then //waMschStaffel,waMschTeam
                MaxBarSize := MaxBarSize + MannschColl.Count
              else // EinzelWettk
                MaxBarSize := MaxBarSize +
                                MannschColl.Count * (3 +
                                         WettkColl[j].AltMKlasseColl[tmMsch].Count+
                                         WettkColl[j].AltWKlasseColl[tmMsch].Count);
            // Einzelwertung pro Wettk.
            MaxBarSize := MaxBarSize + TlnColl.Count +
                            TlnColl.OrtTlnZahl(i,WettkColl[j],wgStandWrtg,AkAlle,stGemeldet);
            if WettkColl[j].OrtAbSchnZahl[i] >= 2 then
              MaxBarSize := MaxBarSize + WettkColl[j].OrtAbSchnZahl[i] * ( TlnColl.Count +
                            TlnColl.OrtTlnZahl(i,WettkColl[j],wgStandWrtg,AkAlle,stGemeldet));
          end;
//ShowMessage('MaxBarSize = '+IntToStr(MaxBarSize) +#13+'BerechneRang(Wettk('+IntToStr(j)+'))' +#13+'OrtIndex = '+IntToStr(i));
        end;
      end;

      // SerieWertung
      if Serie then
        for j:=0 to WettkColl.Count-1 do
          if WettkColl[j].OrtErgModified[-1] then
          begin
            Result := true;
            MaxBarSize := MaxBarSize + 4*TlnColl.Count; // 4 Klassenwertungen
            if WettkColl[j].MschWertg<>mwKein then
              MaxBarSize := MaxBarSize + MannschColl.Count *
                                     (3 +
                                      WettkColl[j].AltMKlasseColl[tmMsch].Count+
                                      WettkColl[j].AltWKlasseColl[tmMsch].Count);
          end;
//if Serie then
//  ShowMessage('MaxBarSize = '+IntToStr(MaxBarSize)+#13+'Serienwertung in '+OrtColl[OrtIndexAlt].Name);

      if Result then // UpdateAnsicht
        if HauptFenster.TlnAnsicht then MaxBarSize := MaxBarSize + TlnColl.Count
                                   else MaxBarSize := MaxBarSize + MannschColl.Count;

      //########################################################################
      // Ergebnisse berechnen
      //########################################################################

      if MaxBarSize > 0 then // sonst gibt es nichts zu berechnen
      begin
//ShowMessage('MaxBarSize = '+IntToStr(MaxBarSize));
        // Init Meldung
        MeldungText := 'Platzierungen werden berechnet';
        with HauptFenster do
        begin
          if ProgressBarStehenLassenAlt or ProgressBar.Visible then
          begin
            // aktuelle BarPos beibehalten
            ProgressBarText(MeldungText);
            ProgressBarMaxUpdate(MaxBarSize);
          end else
            ProgressBarInit(MeldungText,MaxBarSize);
          //StartBarSize := HauptFenster.ProgressBar.Position;
          if Application.Terminated then Exit;
          LstFrame.TriaGrid.StopPaint := true;
        end;
//ShowMessage('ProgressBar.Max = '+IntToStr(HauptFenster.ProgressBar.Max));
//ShowMessage('ProgressBar.Position = '+IntToStr(HauptFenster.ProgressBar.Position-StartBarSize));

        // Berechne Rang
        // Setze TlnAkZahlMax f�r alle Berechnungen, auch Msch-Punktwertung
        for i:=0 to WettkColl.Count-1 do
          with WettkColl[i] do
            TlnAkZahlMax := Max(AltMKlasseColl[tmTln].Count,
                             Max(AltMKlasseColl[tmMsch].Count,
                              Max(SondMKlasseColl.Count,
                               Max(AltWKlasseColl[tmTln].Count,
                                Max(AltWKlasseColl[tmMsch].Count,
                                 Max(SondWKlasseColl.Count,1)))))); //f�r WrtgAlle,-Sex max=1
        // Loop �ber alle Orte
        for i:=0 to OrtColl.Count-1 do
        begin
          OrtIndex := i; // alle Berechnungen mit aktueller OrtIndex
          if Serie then
            MeldungText := 'Platzierungen werden berechnet f�r '+ OrtName;
          HauptFenster.ProgressBarText(MeldungText);
          if Application.Terminated then Exit;

          // MschZeiten setzen
          // alle Zeiten Abschnitt f�r Abschnitt komplett berechnen,
          // weil Abs-1 Zeiten ben�tigt werden
          for AbsCnt:=wkAbs1 to wkAbs8 do
          begin
            for j:=0 to WettkColl.Count-1 do
              if WettkColl[j].ErgModified then with MannschColl do
              begin
                if AbsCnt=wkAbs1 then SetzeStaffelVorg(WettkColl[j]); // 1x reicht
                SetzeMschAbsStZeit(AbsCnt,WettkColl[j]);
                SetzeMschAbsZeit(AbsCnt,WettkColl[j]);
              end;
            SetzeErstZeitMsch(AbsCnt); //nur MschWettk, ben�tigt f�r MschStZeit
          end;

          // Rundenzeiten korrigieren, hier alle Fehler abfangen
          for AbsCnt:=wkAbs1 to wkAbs8 do
            for j:=0 to WettkColl.Count-1 do
              if WettkColl[j].ErgModified then
                TlnColl.UpdateRundenZahl(AbsCnt,WettkColl[j]);

          for AbsCnt:=wkAbs1 to wkAbs8 do
          begin
            for j:=0 to WettkColl.Count-1 do
              if WettkColl[j].ErgModified then
                TlnColl.InitTlnStrtZeit(AbsCnt,WettkColl[j]); // Alle MschStZeiten ben�tigt
            SetzeErstZeitTln(AbsCnt); // nur EinzelWk, ben�tigt TlnAbsZeiten
          end;
//ShowMessage('ProgressBar.Position = '+IntToStr(HauptFenster.ProgressBar.Position-StartBarSize)+#13+
//            'MschZeiten'+#13+
//            'OrtIndex = '+IntToStr(i));

          // TagesErgebnisse berechnen
          for j:=0 to WettkColl.Count-1 do
          begin
            HauptFenster.ProgressBarText(MeldungText+' - ' + WettkColl[j].Name);
            if Application.Terminated then Exit;
            (* Rang Berechnen pro Wettkampf *)
            if WettkColl[j].ErgModified then BerechneTagesRang(WettkColl[j]);
//ShowMessage('ProgressBar.Position = '+IntToStr(HauptFenster.ProgressBar.Position-StartBarSize) +#13+
//            'BerechneRang(Wettk('+IntToStr(j)+'))' +#13+
//            'OrtIndex = '+IntToStr(i));
          end;
        end; // Loop �ber alle Orte

        //SerienErgebnisse berechnen (unabh�ngig OrtIndex)
        if Serie then
        begin
          MeldungText := 'Platzierungen werden berechnet f�r Serienwertung - ';
          for j:=0 to WettkColl.Count-1 do
          begin
            HauptFenster.ProgressBarText(MeldungText + WettkColl[j].Name);
            if Application.Terminated then Exit;
            if WettkColl[j].OrtErgModified[-1] then
              BerechneSerienRang(WettkColl[j]);
          end;
//ShowMessage('ProgressBar.Position = '+IntToStr(HauptFenster.ProgressBar.Position-StartBarSize)+#13+
//            'Serienwertung in '+OrtColl[OrtIndexAlt].Name);
        end;

        HauptFenster.ProgressBarText('Platzierungen werden berechnet');
        if Application.Terminated then Exit;
        //for j:=0 to WettkColl.Count-1 do
        //  WettkColl[j].OrtErgModified[-1] := false;

      end;

    finally
      if not Application.Terminated then
      begin
        for j:=0 to WettkColl.Count-1 do            // ErgModified immer zur�cksetzen,
          WettkColl[j].OrtErgModified[-1] := false; // auch wenn TlnColl.Count=0
        OrtIndex := OrtIndexAlt;
        with HauptFenster do
        begin
          // ProgressBarStehenLassen = true
          if Result then UpdateAnsicht
                    else LstFrame.TriaGrid.StopPaint := false;
          if not ProgressBarStehenLassenAlt then StatusBarClear;
          ProgressBarStehenLassen := ProgressBarStehenLassenAlt;
        end;
      end;
    end;
  end;
end;


(******************************************************************************)
procedure BerechneTagesRang(Wettkampf:TWettkObj);
(******************************************************************************)
(* Berechnung Plazierung aller Tln und Msch pro Wettkampf f�r
   alle Klassen und f�r aktuelle OrtIndex *)

type TIndx=(ixZahl,ixZeit,ixRang{,ixSWZahl,ixSWZeit,ixSWRang});

var i : integer;
    Ergebnis : Int64;// f�r Zeit, Runden+Zeit(RndRennen),Strecke(StndRennen) und SerieSumme benutzt
    WrtgArr  : array of array of array of array of array of Int64;
    // 0.Indx:WrtgMode, 1.Indx:TIndx, 2.Indx:AkWrtg,3.Indx:AkIndex 4.Indx:Sex
    //AkZahlMax : Integer;
    //AkBuff : TAkObj;
    //WkSondWrtg{,TlnSondWrtg} : Boolean;
    //SondRangTag : Integer;
    Tln: TTlnObj;
    EinzWrtg,SerWrtg,MschPktWrtg: Boolean;
    AbsCnt: TWkAbschnitt;
    AbsSortMode : TSortMode;
const
  cnDim0=4; //WrtgMode: wgStandWrtg,wgSondWrtg,wgSerWrtg,wgMschPktWrtg
  cnDim1=3; //ixZahl,ixZeit,ixRang
  cnDim2=4; //KlassenWertung: kwAlle,kwSex,kwProAk,kwSondKl
  // cnDim3 wird berechnet, max KlasseColl.Count
  cnDim4=3; //Sex: cnMaennlich, cnWeiblich, cnMixed (f�r Mixed Msch, TlnStaffel)

//..............................................................................
procedure ClearWrtgArr;
// WrtgArr initialisieren (notwendig oder automatisch initialisiert ??)
var i,j,k,m,n : integer;

begin
  for i:=0 to cnDim0-1 do
    for j:=0 to cnDim1-1 do
      for k:=0 to cnDim2-1 do
        for m:=0 to Wettkampf.TlnAkZahlMax-1 do
          for n:=0 to cnDim4-1 do WrtgArr[i,j,k,m,n] := 0;
end;

//..............................................................................
procedure SetRangTag(const Abs:TWkAbschnitt; const WrtgMode:TWertungMode;
                     const AkWrtg:TKlassenWertung);
// wird pro Tln f�r alle WrtgZt, WrtgMode und AkWrtg ausgef�hrt:
// Abs = wkAbs0(Gesamt),wkAbs1 bis wkAbs8
// WrtgMode = wgStandWrtg,wgSondWrtg,wgSerWrtg,wgMschPktWrtg
// AkWrtg = kwAlle,kwSex,kwAltKl,kwSondKl
var KlasseIndx,SexIndx : Integer;
begin
  if Tln<>nil then with Tln do
  begin
    SexIndx := -1;
    KlasseIndx := -1;

    // Setze SexIndx, KlasseIndx
    case AkWrtg of
      kwAlle:
      begin
        SexIndx    := 0;
        KlasseIndx := 0;
      end;
      kwSex:
      begin
        if WrtgMode <> wgMschPktWrtg then
          case Sex of
            cnMaennlich : SexIndx := 0;
            cnWeiblich  : SexIndx := 1;
            cnMixed     : SexIndx := 2; // nur bei TlnStaffel
          end
        else  // wgMschPktWrtg, Platzierung f�r Msch-Punkte ben�tigt
          if MschMixWrtg then
            SexIndx := 2 // Mixed Wertung unabh�ngig vom Geschlecht
          else
            case Sex of
              cnMaennlich : SexIndx := 0;
              cnWeiblich  : SexIndx := 1;
            end;
        if SexIndx >= 0 then KlasseIndx := 0;
      end;
      kwAltKl:
      begin
        case Sex of
          cnMaennlich : SexIndx := 0; // bei Mixed TlnStaffel keine Ak-Wertung
          cnWeiblich  : SexIndx := 1;
        end;
        if WrtgMode <> wgMschPktWrtg then
          case SexIndx of
            0: KlasseIndx := Wettkampf.AltMKlasseColl[tmTln].IndexOf(Tln.WertungsKlasse(kwAltKl,tmTln));
            1: KlasseIndx := Wettkampf.AltWKlasseColl[tmTln].IndexOf(Tln.WertungsKlasse(kwAltKl,tmTln));
          end
        else // wgMschPktWrtg, Platzierung f�r Msch-Punkte ben�tigt
          case SexIndx of
            0: KlasseIndx := Wettkampf.AltMKlasseColl[tmMsch].IndexOf(Tln.WertungsKlasse(kwAltKl,tmMsch));
            1: KlasseIndx := Wettkampf.AltWKlasseColl[tmMsch].IndexOf(Tln.WertungsKlasse(kwAltKl,tmMsch));
          end;
      end;
      kwSondKl:
        if Wettkampf.EinzelWettk then // sonst keine Sonderwertung
        begin
          case Sex of
            cnMaennlich : SexIndx := 0;
            cnWeiblich  : SexIndx := 1;
          end;
          case SexIndx of
            0: KlasseIndx := Wettkampf.SondMKlasseColl.IndexOf(Tln.WertungsKlasse(kwSondKl,tmTln));
            1: KlasseIndx := Wettkampf.SondWKlasseColl.IndexOf(Tln.WertungsKlasse(kwSondKl,tmTln));
          end;
        end;
    end;

    if KlasseIndx >= 0 then
    begin
      Inc(WrtgArr[Integer(WrtgMode),Integer(ixZahl),Integer(AkWrtg),KlasseIndx,SexIndx]);
      if WrtgArr[Integer(WrtgMode),Integer(ixZeit),Integer(AkWrtg),KlasseIndx,SexIndx] <> Ergebnis then
      begin
        WrtgArr[Integer(WrtgMode),Integer(ixZeit),Integer(AkWrtg),KlasseIndx,SexIndx] := Ergebnis;
        WrtgArr[Integer(WrtgMode),Integer(ixRang),Integer(AkWrtg),KlasseIndx,SexIndx] :=
                               WrtgArr[Integer(WrtgMode),Integer(ixZahl),Integer(AkWrtg),KlasseIndx,SexIndx];
      end;
      SetRng(WrtgArr[Integer(WrtgMode),Integer(ixRang),Integer(AkWrtg),KlasseIndx,SexIndx],
               Abs,WrtgMode,AkWrtg);
    end else
      SetRng(0,Abs,WrtgMode,AkWrtg);
  end;
end;

//..............................................................................
begin
  if Application.Terminated then Exit;
  if Veranstaltung.TlnColl.Count=0 then Exit;

  // Staffelvorg�nger mu� vor Einzelwertung definiert werden
  // Msch-Start und abschn.-zeiten vorher definieren
  (* definieren bei Staffel, sonst r�cksetzen *)
  (* Staffelwertung nur mit Ak=akAlle *)

  try

    // TAGESWERTUNGEN TEILNEHMER ************************************************
    // Einzel-Tageswertung: Gesamt und pro Abschnitt (nur bei AbsZahl > 1)
    // Serien-Tageswertung nur Gesamt und waEinzel,waRndRennen,waStndRennen (Cup+Liga), keine WkSonderwertung

    // 5-dimensionales dynamisches Array WrtgArr anlegen
    SetLength(WrtgArr,cnDim0,cnDim1,cnDim2,Wettkampf.TlnAkZahlMax,cnDim4);
    Veranstaltung.TlnColl.SortMode := smNichtSortiert; // immer sortieren

    for AbsCnt:=wkAbs0 to TWkAbschnitt(Wettkampf.AbSchnZahl) do
    begin
      if Application.Terminated then Exit;
      EinzWrtg    := (AbsCnt = wkAbs0) or (Wettkampf.AbSchnZahl > 1);
      SerWrtg     := (AbsCnt = wkAbs0) and Veranstaltung.Serie and
                     ((Wettkampf.WettkArt=waEinzel)or
                      (Wettkampf.WettkArt=waRndRennen)or(Wettkampf.WettkArt=waStndRennen));
      MschPktWrtg := (AbsCnt = wkAbs0) and
                     ((Wettkampf.MschWrtgMode=wmTlnPlatz)or(Wettkampf.MschWrtgMode=wmSchultour)) and
                     ((Wettkampf.WettkArt=waEinzel)or
                      (Wettkampf.WettkArt=waRndRennen)or(Wettkampf.WettkArt=waStndRennen));

      if EinzWrtg or SerWrtg or MschPktWrtg then
      begin
        if AbsCnt = wkAbs0 then AbsSortMode := smTlnEndZeit
                           else AbsSortMode := TSortMode(Integer(smTlnAbs1Zeit)+Integer(AbsCnt)-1);
        Veranstaltung.TlnColl.Sortieren(Veranstaltung.OrtIndex,AbsSortMode,Wettkampf,
                                        wgStandWrtg,AkAlle,nil,stGemeldet);
        ClearWrtgArr;

        // alle Tln Berechnen
        for i:=0 to Veranstaltung.TlnColl.SortCount-1 do
        begin
          Tln := Veranstaltung.TlnColl.SortItems[i];
          with Tln do
          begin
            if Application.Terminated then Exit;
            if Wettkampf.WettkArt=waStndRennen then // nur 1 Abschn
              Ergebnis := Gesamtstrecke
            else
            if Wettkampf.WettkArt=waRndRennen then // nur 1 Abschn
              // Rundenzahl SHL 24 = Rundenzahl * 16.777.216(>cnZeit24_00)
              // Endzeit-max bei 1 Abschn. = cnZeit24_00 = 8.640.000
              Ergebnis := Rundenzahl(wkAbs1) SHL 24 + EndZeit //Rundenzahl*16.777.216 >cnZeit24_00
            else
            if AbsCnt=wkAbs0 then Ergebnis := EndZeit
                             else Ergebnis := AbsZeit(AbsCnt);
            if (Ergebnis > 0) and
               ((AbsCnt=wkAbs0) or (AbsCnt=wkAbs1) or
                (AbsZeit(TWkAbschnitt(Integer(AbsCnt)-1))<>0)) and
                not TlnInStatus(stDisqualifiziert) then
            begin
              // EinzelWrtg
              if EinzWrtg then
                if not AusKonkAllg then // keine Wrtg wenn A.K.
                begin
                  SetRangTag(AbsCnt,wgStandWrtg,kwAlle);
                  SetRangTag(AbsCnt,wgStandWrtg,kwSex);
                  if not AusKonkAltKl then SetRangTag(AbsCnt,wgStandWrtg,kwAltKl)
                                      else SetRng(0,AbsCnt,wgStandWrtg,kwAltKl);
                  if not AusKonkSondKl then SetRangTag(AbsCnt,wgStandWrtg,kwSondKl)
                                       else SetRng(0,AbsCnt,wgStandWrtg,kwSondKl);
                  if Wettkampf.SondWrtg then
                    if SondWrtg then
                    begin
                      SetRangTag(AbsCnt,wgSondWrtg,kwAlle);
                      SetRangTag(AbsCnt,wgSondWrtg,kwSex);
                      if not AusKonkAltKl then SetRangTag(AbsCnt,wgSondWrtg,kwAltKl)
                                          else SetRng(0,AbsCnt,wgSondWrtg,kwAltKl);
                      if not AusKonkSondKl then SetRangTag(AbsCnt,wgSondWrtg,kwSondKl)
                                           else SetRng(0,AbsCnt,wgSondWrtg,kwSondKl);
                    end else
                    begin
                      SetRng(0,AbsCnt,wgSondWrtg,kwAlle);
                      SetRng(0,AbsCnt,wgSondWrtg,kwSex);
                      SetRng(0,AbsCnt,wgSondWrtg,kwAltKl);
                      SetRng(0,AbsCnt,wgSondWrtg,kwSondKl);
                    end;
                end else
                begin
                  SetRng(0,AbsCnt,wgStandWrtg,kwAlle);
                  SetRng(0,AbsCnt,wgStandWrtg,kwSex);
                  SetRng(0,AbsCnt,wgStandWrtg,kwAltKl);
                  SetRng(0,AbsCnt,wgStandWrtg,kwSondKl);
                  SetRng(0,AbsCnt,wgSondWrtg,kwAlle);
                  SetRng(0,AbsCnt,wgSondWrtg,kwSex);
                  SetRng(0,AbsCnt,wgSondWrtg,kwAltKl);
                  SetRng(0,AbsCnt,wgSondWrtg,kwSondKl);
                end;

              if SerWrtg then // nur f�r AbsCnt=Abs0
                if SerienWrtg then // nur werten wenn Option SerienWrtg gesetzt
                begin
                  SetRangTag(wkAbs0,wgSerWrtg,kwAlle);
                  SetRangTag(wkAbs0,wgSerWrtg,kwSex);
                  if not AusKonkAltKl then SetRangTag(wkAbs0,wgSerWrtg,kwAltKl)
                                      else SetRng(0,wkAbs0,wgSerWrtg,kwAltKl);
                  if not AusKonkSondKl then SetRangTag(wkAbs0,wgSerWrtg,kwSondKl)
                                       else SetRng(0,wkAbs0,wgSerWrtg,kwSondKl);
                end else
                begin
                  SetRng(0,wkAbs0,wgSerWrtg,kwAlle);
                  SetRng(0,wkAbs0,wgSerWrtg,kwSex);
                  SetRng(0,wkAbs0,wgSerWrtg,kwAltKl);
                  SetRng(0,wkAbs0,wgSerWrtg,kwSondKl);
                end;

              if MschPktWrtg then // nur f�r AbsCnt=Abs0
                if MschWrtg and (not Veranstaltung.Serie or SerienWrtg) then
                begin
                  SetRangTag(wkAbs0,wgMschPktWrtg,kwAlle);
                  SetRangTag(wkAbs0,wgMschPktWrtg,kwSex);    // f�r M/W und Mix-MschWrtng
                  SetRangTag(wkAbs0,wgMschPktWrtg,kwAltKl);
                end else
                begin
                  SetRng(0,wkAbs0,wgMschPktWrtg,kwAlle);
                  SetRng(0,wkAbs0,wgMschPktWrtg,kwSex);
                  SetRng(0,wkAbs0,wgMschPktWrtg,kwAltKl);
                end;

            end else // Zeit = 0
            begin
              if EinzWrtg then
              begin
                SetRng(0,AbsCnt,wgStandWrtg,kwAlle);
                SetRng(0,AbsCnt,wgStandWrtg,kwSex);
                SetRng(0,AbsCnt,wgStandWrtg,kwAltKl);
                SetRng(0,AbsCnt,wgStandWrtg,kwSondKl);
                SetRng(0,AbsCnt,wgSondWrtg,kwAlle);
                SetRng(0,AbsCnt,wgSondWrtg,kwSex);
                SetRng(0,AbsCnt,wgSondWrtg,kwAltKl);
                SetRng(0,AbsCnt,wgSondWrtg,kwSondKl);
              end;
              if SerWrtg then
              begin
                SetRng(0,wkAbs0,wgSerWrtg,kwAlle);
                SetRng(0,wkAbs0,wgSerWrtg,kwSex);
                SetRng(0,wkAbs0,wgSerWrtg,kwAltKl);
                SetRng(0,wkAbs0,wgSerWrtg,kwSondKl);
              end;
              if MschPktWrtg then
              begin
                SetRng(0,wkAbs0,wgMschPktWrtg,kwAlle);
                SetRng(0,wkAbs0,wgMschPktWrtg,kwSex);
                SetRng(0,wkAbs0,wgMschPktWrtg,kwAltKl);
              end;
            end;
          end;
          HauptFenster.ProgressBarStep(1);
          if Application.Terminated then Exit;
        end;

        if SerWrtg then // MaxRng f�r Tln-Serienwertung setzen (TlnStaffel/AkMixed nicht f�r Serie)
        with Wettkampf do
        begin
          SetSerRngMax(tmTln,AkAlle,WrtgArr[Integer(wgSerWrtg),Integer(ixZahl),Integer(kwAlle),0,0]);
          SetSerRngMax(tmTln,MaennerKlasse[tmTln],WrtgArr[Integer(wgSerWrtg),Integer(ixZahl),Integer(kwSex),0,0]);
          SetSerRngMax(tmTln,FrauenKlasse[tmTln],WrtgArr[Integer(wgSerWrtg),Integer(ixZahl),Integer(kwSex),0,1]);
          for i:=0 to AltMKlasseColl[tmTln].Count-1 do
            SetSerRngMax(tmTln,AltMKlasseColl[tmTln][i],WrtgArr[Integer(wgSerWrtg),Integer(ixZahl),Integer(kwAltKl),i,0]);
          for i:=0 to AltWKlasseColl[tmTln].Count-1 do
            SetSerRngMax(tmTln,AltWKlasseColl[tmTln][i],WrtgArr[Integer(wgSerWrtg),Integer(ixZahl),Integer(kwAltKl),i,1]);
          for i:=0 to SondMKlasseColl.Count-1 do
            SetSerRngMax(tmTln,SondMKlasseColl[i],WrtgArr[Integer(wgSerWrtg),Integer(ixZahl),Integer(kwSondKl),i,0]);
          for i:=0 to SondWKlasseColl.Count-1 do
            SetSerRngMax(tmTln,SondWKlasseColl[i],WrtgArr[Integer(wgSerWrtg),Integer(ixZahl),Integer(kwSondKl),i,1]);
        end;

      end;
    end;

    // TAGESWERTUNGEN MANNSCHAFTEN ***********************************************
    // Mannsch.Punktwertung f�r Liga mu� nach Einzelwertung berechnet werden
    // Punktwertung nicht mehr benutzt
    if Wettkampf.MschWertg <> mwKein then
      Veranstaltung.MannschColl.MannschWertung(Wettkampf);

  finally
    WrtgArr := nil;
  end;
end; // BerechneTagesRang

(******************************************************************************)
procedure BerechneSerienRang(Wettkampf:TWettkObj);
(******************************************************************************)
// Ergebnis unabh�ngig von aktueller OrtIndex
// Wertung nur pro Wettk
var i : Integer;
begin
  with Veranstaltung do
    if Serie then
    begin
      Wettkampf.OrtZahlGestartet[tmTln] := OrtZahl;
      Wettkampf.OrtZahlGestartet[tmMsch] := OrtZahl;
      // vorher pro Ort festlegen ob Wettkampf gestartet wurde
      for i:=0 to OrtZahl-1 do
      begin
        if TlnColl.OrtTlnImZiel(i,Wettkampf) then
        begin
          if Wettkampf.TlnOrtSerWertung(i) then // nur Einzelwertung f�r Serie
            Wettkampf.TlnImZielColl[tmTln][i] := true
          else
            Wettkampf.TlnImZielColl[tmTln][i] := false;
          if Wettkampf.MschOrtSerWertung(i) then // nur beide ZeitWrtg oder PktWrtg
            Wettkampf.TlnImZielColl[tmMsch][i] := true
          else
            Wettkampf.TlnImZielColl[tmMsch][i] := false
        end
        else
        begin
          Wettkampf.TlnImZielColl[tmTln][i] := false;
          Wettkampf.TlnImZielColl[tmMsch][i] := false;
        end;
        if not Wettkampf.TlnImZielColl[tmTln][i] then Dec(Wettkampf.OrtZahlGestartet[tmTln]);
        if not Wettkampf.TlnImZielColl[tmMsch][i] then Dec(Wettkampf.OrtZahlGestartet[tmMsch]);
      end;

      TlnColl.SerieWertung(Wettkampf);
      if Wettkampf.MschWertg <> mwKein then MannschColl.SerieWertung(Wettkampf);
    end;
end;

(******************************************************************************)
procedure SetzeErstZeitTln(Abs:TWkAbschnitt);
(******************************************************************************)
// Zur Berechnung der Startzeiten f�r Abs+1 bei Jagdstart
// nur EinzelWettk
// vorher m�ssen AbsZeiten(Abs) f�r Tln berechnet werden
// Pro SGrp wird die Zeit des schnellsten Tln aus vorigem Abnschnitt gesetzt
// es werden dabei alle SGrp mit gleicher StartZeit(Abs+1) ber�cksichtigt
// bei Liga �ber alle Wk, sonst pro Wk
// grunds�tzlich �ber alle Wettk berechnen, auch wenn nur 1 Wk modified
// jeden Abs komplett und dann n�chster Abs, weil Startzeit(Abs) bei Abs+1 benutzt wird
// nicht f�r letzter Abschnitt
var i,j,Zeit : Integer;
    JagdStart: Boolean;
    AbsCnt,AbsPlus1: TWkAbschnitt;

//..............................................................................
function EinzelAbsZeitGueltig(const Tln:TTlnObj): Boolean;
var AbsCnt: TWkAbschnitt;
begin
  Result := false;
  with Tln do
    if (Integer(Abs) < Wettk.AbschnZahl) and (AbsZeit(Abs) > 0) and
       (SGrp <> nil) and (SGrp.StartZeit[AbsPlus1] >= 0) then // ab Abs2
    begin
      for AbsCnt := wkAbs2 to Abs do
        if (SGrp.StartModus[AbsCnt] <> stOhnePause) and
           (AbsZeit(TWkAbschnitt(Integer(AbsCnt)-1)) <= 0) then Exit;
      Result := true;
    end;
end;

//..............................................................................
begin
  JagdStart := false;
  if Abs = wkAbs8 then Exit
  else AbsPlus1 := TWkAbschnitt(Integer(Abs)+1);

  with Veranstaltung do
  begin
    // zun�chst alle ErstZeiten zur�cksetzen
    for i:=0 to SGrpColl.Count-1 do
    with SGrpColl[i] do
      if (WkOrtIndex = OrtIndex) and Wettkampf.EinzelWettk then
      begin
        ErstZeit[Abs] := 0;
        if (Integer(Abs) < Wettkampf.AbschnZahl) and
           (StartModus[AbsPlus1] = stJagdStart) then JagdStart := true;
      end;
    if not JagdStart then Exit; // ErstZeit wird nur f�r Jagdstart benutzt

    // ErstZeit(Abs) = schnellster Tln nach Gesamtzeit wkAbs1 bis Abs
    for i:=0 to TlnColl.Count-1 do
    with TlnColl[i] do
      if Wettk.EinzelWettk and EinzelAbsZeitGueltig(TlnColl[i]) then
      begin
        Zeit := AbsZeit(wkAbs1);
        for AbsCnt := wkAbs2 to Abs do
          Zeit := Zeit + AbsZeit(AbsCnt);
        for j:=0 to SGrpColl.Count-1 do
        with SGrpColl[j] do
          // alle SGrp mit gleicher Startzeit(Abs+1) und gleicher Wettk(auch f�r Liga)2010
          if (WkOrtIndex = OrtIndex) and (Wettkampf=Wettk) and
             (StartZeit[AbsPlus1] = SGrp.StartZeit[AbsPlus1]) and
             ((Zeit < ErstZeit[Abs]) or (ErstZeit[Abs] = 0))
            then ErstZeit[Abs] := Zeit;
      end;
  end;
end;

(******************************************************************************)
procedure SetzeErstZeitMsch(Abs:TWkAbschnitt);
(******************************************************************************)
// Zur Berechnung der Startzeiten f�r Abs+1 bei Jagdstart
// nur waMschTeam + waMschStaffel
// vorher m�ssen AbsZeiten(Abs) f�r Msch berechnet werden
// Pro SGrp wird die Zeit des schnellsten Msch aus vorigem Abnschnitt gesetzt
// es werden dabei alle SGrp mit gleicher StartZeit(Abs+1) ber�cksichtigt
// bei Liga �ber alle Wk, sonst pro Wk
// grunds�tzlich �ber alle Wettk berechnen, auch wenn nur 1 Wk modified
// jeden Abs komplett und dann n�chster Abs, weil Startzeit(Abs) bei Abs+1 benutzt wird
// nicht f�r letzter Abschnitt
var i,j,Zeit : Integer;
    JagdStart: Boolean;
    AbsCnt,AbsPlus1: TWkAbschnitt;
    AbsZahlMax : Integer; // bei MschStaffel MschGroesse statt AbschnZahl

//..............................................................................
function EinzelAbsZeitGueltig(const Tln:TTlnObj): Boolean;
var AbsCnt: TWkAbschnitt;
begin
  Result := false;
  with Tln do
    if (Integer(Abs) < Wettk.AbschnZahl) and (AbsZeit(Abs) > 0) and
       (SGrp <> nil) and (SGrp.StartZeit[AbsPlus1] >= 0) then
    begin
      for AbsCnt := wkAbs2 to Abs do
        if (SGrp.StartModus[AbsCnt] <> stOhnePause) and
           (AbsZeit(TWkAbschnitt(Integer(AbsCnt)-1)) <= 0) then Exit;
      Result := true;
    end;
end;
//..............................................................................
begin
  JagdStart := false;

  if Abs = wkAbs8 then Exit
  else AbsPlus1 := TWkAbschnitt(Integer(Abs)+1);

  with Veranstaltung do
  begin
    // zun�chst alle ErstZeiten zur�cksetzen
    for i:=0 to SGrpColl.Count-1 do
    with SGrpColl[i] do
    begin
      if Wettkampf.WettkArt = waMschStaffel then
        AbsZahlMax := Wettkampf.MschGroesse[cnSexBeide]
      else
        AbsZahlMax := Wettkampf.AbschnZahl;
      if (WkOrtIndex = OrtIndex) and Wettkampf.MschWettk then
      begin
        ErstZeit[Abs] := 0;
        if (Integer(Abs) < AbsZahlMax) and
           (StartModus[AbsPlus1] = stJagdStart) then JagdStart := true;
      end;
    end;
    if not JagdStart then Exit; // ErstZeit wird nur f�r Jagdstart benutzt

    // MschAbsZeit und DummyTln.SGrp vorher gesetzt
    // ErstZeit(Abs) = schnellster Msch nach Gesamtzeit wkAbs1 bis Abs
    for i:=0 to MannschColl.Count-1 do with MannschColl[i] do
      if Wettk.MschWettk and (MschAbsZeit[Abs] > 0) and
         (DummyTln.SGrp <> nil) and (DummyTln.SGrp.StartZeit[AbsPlus1] >= 0) then
      begin
        Zeit := MschAbsZeit[wkAbs1];
        for AbsCnt := wkAbs2 to Abs do
          Zeit := Zeit + MschAbsZeit[AbsCnt];
        for j:=0 to SGrpColl.Count-1 do
        with SGrpColl[j] do
          // alle SGrp mit gleicher Startzeit(Abs+1) und gleicher Wettk (auch f�r Liga)
          if (WkOrtIndex = OrtIndex) and (Wettkampf = Wettk) and
             (StartZeit[AbsPlus1] = DummyTln.SGrp.StartZeit[AbsPlus1]) and
             ((Zeit < ErstZeit[Abs]) or (ErstZeit[Abs] = 0))
            then ErstZeit[Abs] := Zeit;
      end;
  end;
end;


end.
