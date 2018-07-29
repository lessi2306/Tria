unit History;

interface

const
  // Version 11.5.8
  cnVersionsNummer = '5.8b';
  cnVersionsJahr   = '2011'; // bleibt auch in 2012.....
  cnReleaseJahr    = '2018'; // f�r Copyright in InfoDlg

implementation

(******************************************************************************)
(*        History                                                             *)
(******************************************************************************)
{

================================================================================
2003-1.0
=========
13.03.2003:  Version 1.0 auf der Homepage
================================================================================

2003-1.1
========
Durchgef�hrte �nderungen:
-------------------------

13.03.2003: WettkDlg - WettkGeaendert
Bei Serie wird Titel2Edit.Text=WkAktuell.Name gesetzt wenn WkAktuell.Titel2=''.
Dies f�hrte zum Result=true ohne �nderung der daten

13.03.2003: VeranObj - AkMinIndex/AkMaxIndex
Einschr�nkungen bei Liga gel�scht.

13.03.2003: WettkDlg - WettkAendern
Nach �nderung wurde FocusedItem ver�ndert. FocusedItem deshalb neu auf WkAktuell
gesetzt

13.03.2003: WettkDlg - WettkAendern
Abfrage eingef�gt bei �nderung der MschGrAnm/Strt/Wrtg ob f�r alle Orte
ge�ndert werden soll.

13.03.2003: WettkDlg - WettkDialog
L�ngenbegrenzung f�r WettkName/Titel2 entfernt, F�r WkK�rzel gesetzt

13.03.2003: VeranDlg - VeranDialog
L�ngenbegrenzung f�r Veranstaltungsname gel�scht

13.03.2003: OrtDlg - OrtDialog
L�ngenbegrenzung f�r Ortsname gel�scht

13.03.2003:  Version 1.1 auf der Homepage
================================================================================

2003-1.2
========
Durchgef�hrte �nderungen:
-------------------------

14.03.2003: SMldDlg:
Buttons umbenannt �ndern==>�bernehmen, Schliessen==>Schlie�en und & entfernt
& Funktioniert nicht richtig. Vermutlich irgendwo disable, aber nicht klar wo

14.03.2002: DateiDlg/AllgConst
Variablen StoreMode/LoadMode in AllgConst aufgenommen

14.03.2003: EnvProc - SpeichereEnvironment
Fehlermeldungen gel�scht. Wenn nicht gespeichert werden kann, wird halt mit
einer neuen datei ge�ffnet

14.03.2003: EnvProc/AllgConst:
EnvDateiName getremnnt in var und const, damit die non-Standard Compiler Option
Zuweisung von typisierten Constanten nicht mehr ben�tigt wird

14.03.2003: WettkDlg
Finetuning bei Namen und Entfernung &-Zeichen
Buttons an SGrpDlg angepa�t

14.03.2002: TriaMain
FormCloseQuery eingef�hrt f�r Abfrage wenn w�hrend �nderung von SMld geschlossen wird

14.03.2003: IdleProc/SMldDlg:
Sperren von Menues Veranstaltung,Zeitnahme in Ansicht SMldMeldung
Sperren Von menu Teilnehmer bei neuEingabe und w�hrend �nderung

14.03.2003: MannsObj - TMannschObj.OrtCollAdd/Clear  #######
DummyTln.OrtCollAdd/Clear erg�nzt ==> Absturz beim Berechnen beu neuem Ort

14.03.2003: OrtDlg
Buttons an SGrpDlg angepa�t

15.03.2003: WettkDlg:
Check fehlendes WettkK�rzel f�r Liga eingebaut

15.03.2003: LstFmt - GetListType
Bei MschTagWrtgCompact wird TlnZahl von RepWk anstelle von SortWettk abgeleitet,
damit immer max Spaltenzahl genommen wird

15.03.2003:  Version 1.2 auf der Homepage
================================================================================

================================================================================
2003-1.3
========
Durchgef�hrte �nderungen:
-------------------------

19.3.2003: AllgComp - Paint
Visibility DummySB ge�ndert. Problem bei TriaZeit wenn HauptFenster mit
Scrollbalken hochkommt.
 
07.04.2003: TlnDlg
- TlnFirstButtonClick,TlnBackButtonClick,TlnLastButtonClick:
Zeile 'if TlnGeAendert and not TlnAendern then Exit;'  entfernt, weil
Pr�fung vorher schon stattfindet
- SnrDoppel:
TlnAktuell durch TlnBuffer ersetzt (doppelte Snr in Mengen)
- SnrGeAendert: entfernt

07.04.03: UrkDrDlg:
 SerienDruckMschTagesWertungDetail - Felder Veranstaltg und Ort haben gefehlt 

07.04.03: WettkObj
- Load: G�ltigkeit Index f�r AkMin und AkMax �berpr�ft und im Fehlerfall auf
0 und AkObjColl.Count-1 gesetzt statt nil
- Store: AkMin/AkMax index f�r DOS auf cnDOSAkIndexMax  (=18) begrenzt
(Fehler Mengen, Abst�rz von DOS-Version weil AkMaxIndex = 19)
- GetOrtMannschGrAnm,GetOrtMannschGrStrt,GetOrtMannschGrWrtg:
Defaultwerte f�r non-Liga veranstaltungen auslesen. Bei �nderung von Veranst.Art
nichts �ndern. Problem in Mengen weil 1.Ort nicht initialisiert wurde und beim
einlesen von mannschaften dort die MschGrWrtg benutzt wird bei Multi-Msch

08.04.03: LstFmt
GetColType f�r ErgLstTlnLndSR korrigiert (Spalte Run fehlte)

09.04.03: SGrpObj (und in Folge Tlnerg,TlnObj,MannsObj):
FErstZeit1, FErstZeit2 durch Abs1ErstTln und Abs2ErstTln ersetzt.
F�r Startzeitberechnung muss effektive Zeiten statt Uhrzeiten benutzt werden,
weil vesrschiedene Startgruppen mit unterschiedliche Erststartzeiten gleiche
StartZeit2,3 habne k�nnen.
ErstZeit1,2 werden gespeichert wegen kompatibilit�t. ErstTln werden nach jedem
Laden neu gesetzt.

09.04.2003: ListFmt
GetListType: f�r Startliste in SortMode=smJagdStartAbschn_2,3 keine Bahn-Spalte

09.04.03; ZtEinlDlg, ZtLoeschDlg:
- SetAbschnitt: bei WettkAlle AbschnZahlAlle ausgewertet statt AbschnZahl

09.04.03: ImpFrm,ZtEinlDlg,DateiDlg:
- beim �ffnen der Datei spezifischer Title erg�nzt 

09.04.2003:  Version 1.3 auf der Homepage
================================================================================

================================================================================
2003-1.4
========
Durchgef�hrte �nderungen:
-------------------------
29.04.03 - WettkObj
- TWettkObj.Load: Titel2 bei non-Serie gleich Name gesetzt

29.04.03: WettkDlg
- WettkGeAendert; Vergleich Titel2Edit.Text korrigiert

29.04.03: DateiDlg
- TriDatSpeichernunter: TriDatei.UpdatePath(FileName) an richtige Stelle platziert
                        Warnung nur bei speichern in DOS-Mode
- TriDateiSpeichern: Warnung nur bei speichern in DOS-Mode

29.04.03: Sortierproblem Startlisten nach Startzeit
- es wurde SGRpColl.SortIndex benutzt, diese ist aber je nach Vorgeschichte
  unterschiedlich sortiert
  in TlnObj,SMldObj  SortString smStartUhrzeit/smMschStUhrZeit korrigiert
  in VeranObj SGrpColl.Sortieren entfernt in SetOrtIndex

30.04.03: Sortierung Ergebnislisten:
- anTlnTagesWertung: neuer SortMode smAkEndZeit f�r smAltersKlasse
- anTlnSerienWertung: neuer SortMode smAkSeriePunkte statt smAltersKlasse
                      neuer SortMode smMschTlnSeriePunkte statt MannschName

30.04.03: Berechnung in alte Dateien nicht immer in Ordnung:
- nach dem Laden einer �lteren/neueren Version grunds�tzlich neu Berechnen
  in DateiDlg.TriDatOeffnen und EnvProc.LeseEnvironment, nicht beim Import.

02.05.03: RaveUnit - Serienwertung Tln (ohne Ak, 6 Orte) korrigiert

02.05.2003: - version 1.4 auf Homepage
================================================================================

================================================================================
2003-1.5
========
Durchgef�hrte �nderungen:
-------------------------
09.05.03: Mika Timing Format eingef�hrt:
- AllgConst: TTztErfDateiFormat erweitert mit fmMikaTiming
- ZtEinlDlg: neue Funktion MikaDateiLaden
             Progressbar Stepping in TriaZEDateiLaden korrigiert
             Zeit=0 in Zeit=-1 umwandeln in TriaZEDateiLaden und dBaseDateiLaden
             Zeit<0 Fehler, Zeit=0 ist g�ltige Zeit in TZeObj.Init 
             TRIAZEDateiLaden: Fehler-Auswertung korrigiert
- TlnObj: Funktion Abs3Zeit korrigiert (Check auf Uhrzeit<0 hat gefehlt)
          Funktion Endzeit: Check auf EndUhrzeit hat gefehlt und
                            Zeit nicht mehr auf <24:00:00 begrenzt
- AllgFunc: ZeitStr erlaubt bis 99:59:59 statt bisher 23:59:59

10.05.2003: zus�tzliche Wertung f�r Aktive
- AkObj: Text f�r AnsFrm-SortKlassen ge�ndert
- AnsFrm: f�r TlnStartliste smAkAlle statt smAkMFPlusTMW, damit auch U23/Senioren
- AllgConst, AkObj, AnsFrm,ListFmt: Aktive Klasse eingef�hrt
- TlnObj: neue Collections: FRngAktWkColl, FRngAktAlleWkColl eingef�hrt,
          werden wegen kompatibilit�t nicht gespeichert ==> nach laden neu berechnen
- TlnErg:
- RaveUnit,UrkDrDlg: bei Reports/Seriendruck war GesRng falsch f�r Junioren und
  Senioren Erg.Liste 
- TlnObj,SMldObj: smAltersklasse ge�ndert: h�chste Jg zuerst
- AllgObj: Auswertung DOSmode korrigiert
- AllgConst: Limits TlnMax,MannschMax,SgrpMax,DisqGrundMax auf 9999 erh�ht

12.05.2003: DateiDlg (Rainer Rupf, Dettingen/Erms)
- SpeichernUnter: Fehler korrigiert - es wurde immer unter alter Name gespeichert
- DateiSpeichern, DateiLaden: bei IO exception wird Standard meldung erzeugt,
                              deshalb keine Fehlermeldung im programm
- DateiSpeichernUnter: bei exception wird Path zur�ckgesetzt

13.05.2003:
- TlnObj : 'disq' als Rang angezeigt bei Disqualifikation
- AllgObj : abh�ngigkeit von anderen Units entfernt um Filesize Triazeit zu
             verkleinern (m��igiger Erfolg)
- ZtEinlDlg: TriaZeit Format eingef�hrt
- UrkDrDlg: ZwischenZeiten in UrkundenDruckDatei erg�nzt

13.05.2003: - version 1.5 auf Homepage
================================================================================


================================================================================
2003-1.6
========
Durchgef�hrte �nderungen:
-------------------------
14.05.2003:
- TlnErg - SetzeErstZeit1,2
- TTlnObj.Abs3StartZeit:
  Korrektur: Abs2ErstTln wird nach schnellster Gesamtzeit
             Abs1Zeit+Abs2Zeit und nicht nur nach Abs2Zeit ermittelt

15.05.2003:
- TlnObj: SetWettkErgModified korrigiert f�r Indx=-1, damit f�r alle Orte neu
          berechnet wird.
          Deswegen auch neue funktion OrtEndUhrZeit erg�nzt

16.05.2003:
- AllgObj: TVersion.DateiType ersetzt DOSType, dtUnbekannt eingef�hrt
           LoadMode gestrichen
- DateiDlg: Versionscheck auch f�r dtUnbekannt,
            Veranst.LoadKorrektur nach Laden aufgerufen benutzt
- EnvProc:  Veranst.LoadKorrektur nach Laden aufgerufen
            TriaStream.Create mit fmShareDenyNone
- LstFrm:   TriaGrid.Colwidths speichern, damit User-�nderungen w�hrend
            Sitzung erhalten bleiben
            neu: array ColBreite, InitColBreite,StandardColBreite, OrtColBreite,
            UpdateOrtColBreite, UpdateMschTlnColBreite
            Setzen ColBreite ge�ndert, damit Fenster nicht mehr sichtbar leer wird
- WettkDlg: MschGroesseCB/label unsichtbar gesetzt f�r EinzelVeranstaltung
            WettkAendern- bei �nderung MschGrWrtg: UpdateMschTlnColBreite
- WettkObj: Load- Anpassungen f�r Version <= 7.4 entfernt
            SetMannschErgModified nach VeranObj.Load
- VeranObj: Load/Store  - DateiErweiterungen um neu Berechnen zu vermeiden
            - TlnColl - RngAktWkColl, RngAktAlleWkColl
            - MannschColl - Abs1,2,3StZeitColl, Abs1,2ZeitColl
            LoadKorrektur: neu berechnen f�r:
            - DOS und Version <> akt. Version: MschModified,OrtErgModified
            - DOS und Version < 1.6: MschModified,OrtErgModified wenn Tln imZiel
- TlnDlg: NichtRechen true wenn Dialog aktiv. Erst nach Schliessen neu berechnen
- WettkDlg: NichtRechen true wenn Dialog aktiv.
- OrtDlg:  NichtRechen true wenn Dialog aktiv.
- SGrpDlg: NichtRechen true wenn Dialog aktiv.
- VeranDlg: NichtRechen true wenn Dialog aktiv.

18.05.2003:

21.05.2003:
- AllgConst: spSGrpStZeit,spMschStZeit entfernt, nur spStZeit verwenden
             smStartGruppe, smStartBahn entfernt
- ListFmt:   spStZeit neu definiert, immer errechnete Abs1Startzeit anzeigen
- TlnObj:    Funktion SGrpStartZeit entfernt, nur Abs1Startzeit verwenden
             Abs1Uhrzeit f�r Abs1-Jagdstart ge�ndert
- WettkDlg:  bei MschWettk�mpfe ist nur Wertung �ber alle Klassen erlaubt und
             nur 1 Wertung pro Mannschaft
             WettkArtRGClick und SetMschAkWertgRG korrigiert


22.05.2003:
- Idleproc:  TeilnehmerMenueCommands ge�ndert, damit ZeitnahmeMenueCommands
             enabled werden abh�ngig von OrtTlnEingeteilt statt TriaGrid.Count

26.05.2003:
- MannsObj:  Fehler in StaffelWertung, Schopfheim99Wertung, Schopfheim00Wertung:
             lokale Variablele Zeit benutzen statt MammschObj.Zeit
             Damit nicht unvollst�ndige Mannsch. nicht gewertet werden

30.06.03:
- TlnObj:    Property RngAktWkColl, RngAktAlleWkColl eingef�hrt
             Wenn MschModified, nicht auch WettkErgMod setzen (in WettkObj)
             In Load Abfrage not DOStype durch dtWIN ersetzt, wegen alte Dateien
             FRngAktWkColl/FRngAktAlleWkColl speichern und laden
             SortModi Startzeit ge�ndert

- MannsObj:  Abs1StZeitColl,Abs1ZeitColl,Abs2StZeitColl,Abs2ZeitColl,Abs3StZeitColl
             eingef�hrt, benutzt in TlnObj
             smSeriePktStart f�r Jagdstart Abschn.1 waTeam neu eingef�hrt

- TlnErg:    BarPosition korrigiert
             MschErstZeite1,2 und MschAbs1,2,3Stzeit und MschAbs1,2Zeit berechnen

- SGrpObj:   FAbs1,2ErstTln wieder entfernt und FErstZeit1,2 wieder benutzt,
             jetzt aber effektive Zeit statt Uhrzeit.

- SuchDlg: Trim-Funktion f�r Suchtext eingef�hrt, weil Snr. Leading Blanks hat

30.05.2003: - version 1.6 auf Homepage
================================================================================

2003-1.7
========
Durchgef�hrte �nderungen:
-------------------------

18.06.2003:
MannsObj:  TmannschObj.TlnListeEinlesen entfernt, weil nicht benutzt

24.06.2003:
VeranObj:  FArt als TVeranstArt (war Integer), FJahr als Integer (war String)
           Destroy: Collections auf nil abfragen
AkObj:     an Veranst.Jahr angepa�t
AllgConst: type TVeranstArt eingef�hrt
AllgFunc:   SystemJahr auf integer umgestellt
AllgObj:    TriaColl: methoden freeitem, loaditem, streitem als abstract definiert
                      GetItem,SetItem range check entfernt wegen Geschwindigkeit
                      Clear Delete statt Remove (schneller)
                      ClearIndex modifiziert (var Item entfernt)
            TriaObjColl: SetItem auch bei nil Fehlermeldung
                         FreeItem: pr�fung item streichen (schneller)
MannsObj:   GetTln, TlnlisteEinlesen entfernt
            MannschTlnListe.freeItem: Tln,MannschPtr nur nil wenn Msch gleich
            MannschTlnListe.Clear: Deltete statt Remove
            MannschTlnListe.AddItem: nur f�r MschIndex=0 Tln.mannschPtr setzen
            MannschColl.Clear: Delete statt Remove
            MannschColl.MschTlnLoeschen: neue Funktion f�r TlnDialog
SGrpObj:    SGrpColl.Clear: Delete statt Remove
SMldObj:    SMldColl.Clear, TlnListe.Clear: Delete statt Remove
TlnObj:     TlnColl.Clear:  delete statt Remove
TlnDlg:     function MannschLoeschen nach MannsObj
            TlnEntfernen:  MschTlnLoeschen bevor Tln gel�scht wird, weil dabei
                           Tln.MannschPtr=nil gesetzt wird



30.06.2003:
TWettkObj: SetMannschModified: ErgModified wenn TlnEingeteilt statt TlnGewertet
           wegen MschAbs1StZeit-Berechnung
SGrpDlg,   ErgModified wenn TlnEingeteilt statt TlnGewertet
TlnObj:    TlnObj.Destroy:  TlnListe.ClearItem entfernt, wird in TlnDlg getan
           TlnObj.SetWettkErgModified MschAbs1StZeit ber�cksichtigt
           TlnObj.GetAkStr:  Fomat eingef�hrt
           TlnColl.SortString: Format eingef�hrt,
                               2 blanks zwischen Strings, damit bei 1 blank in
                               string richtig sortiert wird
           OrtTlnEingeteilt: Abfrage Klasse entfernt, weil nicht benutzt
VeranDlg:  GetVeranstArt, SetVeranstArt eingef�hrt
WettkDlg:  WettkAendern: ErgModified wenn TlnEingeteilt statt TlnGewertet

02.07.2003:
ImpTlnFrm: SucheQuelTln immer ab LetzteGefundene Tln, damit bei gleichem TlnNamen
           und unterschiedlichem MschName keine �berfl�ssige Meldungen kommen
           und die Suche schneller geht
           BerechneRang entfernt, damit erst am Ende neu berechnet wird
LstFrm:    ColBreite speichern in GridInit, statt InitAnsicht und UpdateAnsicht,
           sonst bei z.B. bei SortmodeChange keine Speicherung.

03.07.2003:
TlnDlg:    SexCB statt SexRG,
           TabFolge Sex vor Jg damit Sex nicht so leicht �bersehen wird
ImpTlnDlg  wie oben

TlnErg:    SetzeCupRang: Wertung abh�ngig von Wettk.TlnAkWertg, war nur f�r
           awProAk implementiert
           BerechneRang: bei Liga, WettkAlle wird Wertung nicht nochmals f�r
           alle Wettk einzel berechnet (war doppelt)
           
04.07.2003: - version 1.7 auf Homepage
================================================================================

2003-1.8
========
Durchgef�hrte �nderungen:
-------------------------
14.07.2003:
WettkDlg: in WettkLoeschen Mannschaften vor Tln l�schen, sonst Absturz in
          TlnListe.Free
15.07.2003:
AnsFrm:   in InitStatusListe stGemeldet erg�nzt f�r SortMode<>Abschn2,3

15.07.2003:
InfoDlg:  Haftungsklausel ge�ndert
          siehe:  http://www.tutorials.delphi-source.de/haftung/

15.07.2003: - Version 1.8 auf Homepage (mit TriaZeit 1.1)
================================================================================


################################################################################
2003-1.9
========
Durchgef�hrte �nderungen:
-------------------------
15.07.2003:
SMldObj:   function getSortedTln entfernt, weil nicht benutzt
TztAllg:   TztColl.SortString korrigiert (FZeit=String, kein Integer)

21.07.2003:
WettkObj:  GetDatum: bei Liga immer Result von WettkAlle
           SetOrtDatum: Aktion nur wenn sich was �ndert,
                        Veranst.Jahr auch f�r wettkAlle setzen
           SetOrtWettkArt: Aktion nur wenn sich was �ndert
                           Integer(WklArtNeu) verwenden statt case
                           SetMannschModified erg�nzt
           SetMschGrAnm: Aktion nur wenn sich was �ndert
                         SetMannschModified erg�nzt
           SetMschGrStrt: Aktion nur wenn sich was �ndert
                         SetMannschModified erg�nzt
           GetOrtAbschnZahl: bei Liga immer Result von WettkAlle
           GetOrtAbschnName: bei Liga immer Result von WettkAlle
           function AkJahr: f�r Liga/WettkAlle korrigiert

22.07.2003:
ImpTlnFrm: in Import bei Eizelveranstaltungen auf doppelte Tln pr�fen
           function IportTln erg�nzt
ImpFrm:    Var TlnVergleichen durch leereDatei ersetzt
           ImpStartButtonClick: Best�tigungen ob �nderung f�r alle Orte oder
           alle wettk�mpfe f�r Cup und liga erg�nzt

23.07.2003:
WettkDlg:  in SetWettkDaten Datum immer enabled (war bei Liga nur WettkAlle)
           in SetWettkArtRG RG immer enabled
           in WettkAbschnGB GB immer enabled
           in WettkAendern Best�tigungen f�r Datum,WettkArt,WettkAbschn f�r
           �nederung aller wettk�mpfe bei Liga
IdleProc:  in DateiMenueCommands Speichern nur enabled wenn TriDatei.Modified
           in CommandTrailer HauptFenster.LstFrame.TriaGrid.SetFocus erg�nzt,
           damit Liste immer den Focus bekommt
           Gleiches in ImpFrm, ImpTlnFrm

24.07.2003:
VeranObj:  in Load ProgressBarPosition Update bei Datei-Erweiterungen


31.08.2003: �nderung RngColl in TlnObj:
TlnObj:     - ..WkColl ersetzt durch ..Coll, ..AlleWkColl entf�llt
              f�r Liga wird WkColl f�r Wertung �ber alle Wk benutzt, Wertung
              pro Wk in SerColl (Tln immer in Serienwertung)
            - ..SenWkColl,JunWkColl,AktWkColl ersetzt durch ZusColl, Sen-, Jun-
              und Akt-Klassen nicht �berlappend, deshalb reicht eine Coll.
            - ..SerWkColl ersetzt durch ..SerGesColl, ..SerMWColl und ..SerAkColl
              um Cupwertung (Einzel+Msch) �ber Alle und MW zu erlauben
TlnDlg:     SerienWrtgCB disabled f�r Liga - Tln immer in Serienwertung
VeranObj:   in Load DateiErweiterung f�r RngAktWkColl,RngAktAlleWkColl �berspringen
            und sp�ter neu berechnen (in RngZusColl)

09.09.2003: TlnObj: smAltersklasse unabh�ngig von Snr, damit bei Snr-Zuteilung
            die Reihenfolge unver�ndert bleibt, wenn nach Altersklasse sortiert

07.10.2003:
AllgConst: TMschSortWertung,TMannschSortmode eingef�hrt und Definitionen
           generell umsortiert
DruckDlg:  ProgressBar korrigiert (100 durch N ersetzt)

12.10.2003:
VeranObj: WettkObj.OrtWertg bei Load und Store erg�nzt
ListFmt:  spRng korrigiert
UrkDrDlg: spRng korrigiert
TlnObj:   TReportTlnList.Add procedure InsertRepTln korrigiert f�r RngSer
          TReportTlnList.GetTlnRng gel�scht weil nicht benutzt
MannsObj: BerechneSeriePunkte korrigiert f�r Swim&Run (OrtAbSchnZahl[i] = 2)

Wertung bei Punktgleichheit eingef�hrt:
TlnObj,MannsObj: smSeriePunkte modifiziert
WettkDlg: Serienwertung modifiziert

13.10.2003: - Version 1.9 auf Homepage (mit TriaZeit 1.2)
================================================================================



################################################################################
2003-2.0 - Einf�hrung flexible Altersklassen
========
�nderungen schrittweise einbringen:
-----------------------------------

2003-1.9a :
MannsObj: umbenennen RngTag ==> RngGes (bei Msch nur Gesamtwertung, keine Alters-
                                        wertung und Zusatzwertung wie bei Tln)
                     Klasse ==> GesKlStr
          dabei Fehler gefunden: FKlasse wird als 4 Char gespeichert, kann aber
          auch l�nger sein bei akMaennerStr/akFrauenStr
          MannschInKlasse f�r akMaennerStr/akFrauenStr korrigiert
TlnObj:   RngGesColl ersetzt RngGesColl+RngMWColl f�r Gesamtwertung
WettkObj: Tln/MschAkWertg ==> Tln/MschGesWertg

TlnDlg :
TlnErg :  Berechnung korrigiert f�r AkAlle
-------------------------------------------------------
2003-1.9b :
TlnErg :  Berechnung Tln-Tageswertungen verbessert
-------------------------------------------------------
2003-1.9c :
TlnDlg:    Wertung verbessert: Gesamt/Altersklassen/Zusatzklasse
TlnObj:    GetGesAkStr/GetZusAkStr eingef�hrt
ImpFrm:    Jahr entfernt
TlnDlg,    TlnDoppel-Pr�fung immer durchf�hren, dazu TlnColl.SucheTln ge�ndert.
TlnObj:    Zur Sicherheit, da in Liga-Datei 2003 Tln doppelt definiert sind (XXx).
           Kann beim Import geschehen, wird jetzt korrigiert:
ImpTlnFrm: Vor Import nochmals pr�fen ob Tln vorhanden ist, damit doppelte Tln
           nicht mehr m�glich sind
           ImpTlnChange/SetImpTlnColor erst nach Init enablen 
           SMldCB mit Objects initialisiert um einfacher auslesen zu k�nnen in
           GetImpSMld
DateiDlg:  bei Opendialog und SaveDialog erganzt: ofFileMustExist,ofEnableSizing
           Fehler bei Speichern von Neu.Tri korrigiert: bei Abbruch vom
           Speichernunter wurde statt dessen Neu.tri gespeichert
SMldFrm:   CommandTrailer entfernt, weil damit TriaGrid focussiert wird
           SetErgModified vor SetSMldDaten, damit Speicher-Button richtig gesetzt wird
TriaMain:  Event Handler TriaGridClick,SMldVNameEditChange,SMldGridDraw entfernt,
           Nur noch in SMldFrm und LstFrm. Dazu musste zuerst in beide gel�scht
           und dann neu erstellt werden (Delphi Problem)
           StatusToolBar durch Panel ersetzt (R�nder sehen besser aus)
           F�r Anzeige Sizegrip weiterhin keine M�glichkeit gefunden

09.11.03:  AllgObj: SortIndex mit TList inherited IndexOf statt mit Find.
           Bei langen Listen m�glicherweise langsamer, aber es wird immer der
           richtige Index zur�ckgegeben.
           Bei Find immer der erste Index bei gleicher Sortstring

-------------------------------------------------------
2003-1.9d :
DateiDlg:  Options in TriDatOeffnen,TriDatSpeichernUnter korrigiert
           TriDatSpeichern f�r TriDatNeu korrigiert
           DateiSpeichern: Erstellung BackupDatei eingef�gt
ImpTlnFrm: function GetImpSMld erg�nzt, SetImpTlnModeGB entfernt
           Land in Tln-Vergleich aufgenommen
           SMldCB mit AddObj statt Append initialisieren
           WeiterButtonClick - Korrektur: nochmals auf Gleichheit pr�fen
SMldFrm:   TriDatModified := true vor SetSMldDaten, damit SpeicherButton enabled wird
           SetSMldButtons: auch MenueButtons setzen
           SetSMldDaten: Update LstFrame damit Focus nicht ge�ndert wird
TlnErg:    Abschn1,2,3-Wertungen bei Liga nur f�r WettkAlle
TlnObj:    SucheTln: Self als Parameter erg�nzt
TriaMain   UpdateCaption: nur Dateiname nicht ganzer Pfad anzeigen
           FormPaint: FocusedItem bleibt auch bei Resize sichtbar
           FormPaint: GridPanel dimensionieren, sonst erscheint manchmal
           VertScrollBar bei TlnImport
IdleProc   TeilnehmerMenueCommands: ErsetzDlg nur Enabled wenn �nderbare Spalten
           vorhanden sind (spMschName nicht �nderbar)
OptDlg     Men�punkt Extras mit Optionen hinzugef�gt: Berechnen und Backup
TlnDlg     Start- und ErgebnisZeiten Read Only gesetzt
           Page Disqualifikation in Strafen umbenannt und Zeitstrafen eingef�hrt
           DisqGrundText optional. Wenn H�kchen gesetzt und keine Text
           eingegeben, dann ' '(cnDisqGrundDummy) speichern
VeranObj,
WettkObj,
MannsObj:   MemorySize korrigiert
AnsFrm:    AnsichtCBChange auf cmExecute umgestellt, identisch zu Men�Pkt Ansicht
TriaMain:  InitAnsicht korrigiert mit LstFrame.RefreshAnsicht
RaveUnit   Feld ZeitStrafe eingef�hrt und RaveReports in RaveDesigner ge�ndert

30.11.2003: - Version 2.0 auf Homepage (mit TriaZeit 1.3)
================================================================================


################################################################################
2003-2.1 - Einf�hrung Altersklassen als TAkObj statt String
========
VeranstObj: In Loadkorrektur: bei Dateien <2.0 doppelte Tln l�schen
OptDlg:     In BerechnenButtonClick MschModified gesetzt
IdleProc:   cmErsetzen disabled bei (Ansicht=anMschStartListe)and(SortStatus=stKein
WettkObj:   SetMannschModified f�r WettkAlle korrigiert
ZtEinlDlg:  Format Tria_ZE entfernt
TlnDlg:     AlterEdit zus�tzlich eingef�hrt
            Einteillung: Starzeit in Startzeit korrigiert
            LigaWertung statt Serienwertungen, nur Alle Klassen Sichtbar
            Height GesPkt und GesRng korrigiert (AutoSize := false)
TlnErg:     Serienwertung Cup f�r alle GesWertng'n korrigiert, war nur f�r gwProAk
ZtEinlRep:  Caption mit Abschnitt erweitert
UrkDrDlg:   Feldnamen Abschn.1/2/3 Punkt durch Unterstrich ersetzt damit Word
            Trennzeichen ';' automatisch erkennt.
OptDlg:     Berechnen: 'Alle' auf Schalter hinzugef�gt,
            Platzierungen statt Ergebnisse 
ImpTlnFrm:  TImpTlnFrame.Init: FocusedItem := ZielTln vor visible:=true, sonst
            wird Zieltln in LstFrame.TriaGridClick ge�ndert.
AnsFrm:     SortModeCB wieder an 2. Stelle nach AnsichtCB

20.12.2003: - Version 2.1 auf Homepage (mit TriaZeit 1.3)
================================================================================

################################################################################
2003-2.2
========

AkObj:     AllgAk's in AkObjColl aufgenommen, weil sonst mit EinlVeranst
           nach Import gel�scht
ImpTlnFrm: �nderung 2.1 r�ckg�ngig, weil nicht korrekt, nur TopRow mindestens
           FixedRows, statt 0 bleibt, zus�tzlich in
LstFrm:    TriaGridClick ge�ndert: ZielTln nur �ndern wenn Update=false,


22.12.2003: - Version 2.2 auf Homepage (mit TriaZeit 1.3)
================================================================================
23.12.2003: - neue Version 2.2 auf Homepage mit Korrektur TriaGridClick

AkObj:     Fehler in TAkObjColl.Sortieren:  FWettk durch SortWettk ersetzt
           FWettk generell aus TAkObj entfernt
================================================================================
25.12.2003: - neue Version 2.2 auf Homepage mit Korrektur

AkObj    TAkObjColl.GetAltKlasse: pr�fung Index f�r cnWeiblich korrigiert
         TM/W70 AlterBis von 79 nach 74 korrigiert
         AkObjColl.Update: WettkAlle entfernt, macht Probleme und wird nicht benutzt
WettkObj  GetAkMin,Max korrigiert
          Load, Store:  AkMin,Max korrigiert
          SetAkLimits korrigiert, nicht f�r WettkAlle ausf�hren
VeranObj: AkObjColl Free/Create nach laden von FJahr, muss vor wettkColl.Load
          wegen AkMin/MaxIndx
================================================================================
25.12.2003: - neue Version 2.2 auf Homepage mit Korrektur

TriaMain  in FormPaint TopRow anpassen statt Row/ItemIndex
ImpTlnFrm in Init Focussierung in der Mitte, Fenster.Update nach vorne

================================================================================
28.12.2003: - neue Version 2.2 auf Homepage mit Korrektur



################################################################################
2004-1.0
========
16.01.04 - Online Hilfe in allen Dialogen
           Windows XP Design

25.01.04 - TlnStartListe (exc. liga) und MschStartliste nur pro Wettkampf,
           sonst verwirrend bei �nderung der Ansicht und Wertung pro Ak und
           Listen sollten auch nur pro Wettk gedruckt werden.
           TlnStartListe nur getrennt pro Geschlecht, exc. bei gwAlleAk
25.01.04 - AddSortItem bei TlnColl und MschColl ge�ndert ==> schneller
           TlnObj.TlnInOrtStatus ge�ndert  ==> schneller
01.01.04:
AllgFunc - neue Funktion DatumWert
WettkDlg - Pr�fen ob WettkDatum in richtige Orts-Reihenfolge vergeben wird
WettkObj - neue Funktion GetOrtDatum
         - 
TlnObj   - Alter nach Wettk.datum statt Veranst.Datum berechnet,
           Ak unver�ndert nach Veranst.Jahr

================================================================================
18.02.2004: - neue Version 2004-1.0 auf Homepage (mit TriaZeit 2.0)


################################################################################
2004-1.1
========
01.03.04 - TriaMain: TabOrder OrtCBPanel und OrtCBlabel fixiert in Create und
           CustomAlignInsertBefore eingef�gt, weil OrtCBLabel nach Panel
           positioniert werden muss
         - TlnObj,LstFmt,UrkDrDlg: neue Funktion GetRngAkStr, weil GetRngStr nur
           f�r 1.Spalte/gesamtwertung geeignet ist
         - TlnObj,TlnDlg: FRngAbs1,2,3ZusColl erg�nzt.
07.03.04 - AnsFrm.InitSexListe: Korrektur:
           bei Start- und Erg.Listen bei gwAlleAk auch M�nner und Frauen zur
           Auswahl (bislang nur Beide Geschlechter)
           WettkListe f�r Liga nur AlleWk bei Start- und Erg-Listen
11.03.04 - Unterst�tzung f�r DOS-Dateitype enfernt 
18.03.04 - AllgObj,TlnObj,WettkObj,MannschObj:
           bei Load Collection OrtCollAdd in Create nicht ausf�hren (TOrtAdd)
           damit unn�tige Adds und Clears vermieden werden
01.04.04 - MannsObj: beim StaffelWettk Tlnzahl >3 erlaubt
         - WettkDlg: MschGroesseCB eingef�hrt => f�r alle Veranst.Art <> liga
         - AnsFrm: Korrektur bei WettkCB change: UpdateMschTlnColBreite
         - WettkObj - GetOrtMannschGrWrtg MschGroesse frei aich wenn <> liga
05.04.04 - IdleProc,TriaMain: RecreateControls erst nach ActionUpdate um
           Absturz zu vermeiden, wenn IdleProc vor Ende durchlaufen wird.
         - AnsFrm:  UhrZeitKontrolliste immer mit Status Abschn1
16.04.02 - Spalte Land frei definierbar
         - Altersklassen frei definierbar
         - Mannschaftsgr��e frei definierbar
================================================================================
18.02.2004: - neue Version 2004-1.1 auf Homepage (mit TriaZeit 2.0)


################################################################################
2004-1.2
========

26.04.04 - WettkObj: SetOrtDatum erg�nzt mit SetMannschModified(true), da bei
           Datums-�nderung Klassen ge�ndert werden und neu berechnet werden muss

10.05.04 - TriaMain: OrtCB Label ge�ndert, weil nicht immer sichtbar
12.05.04 - IdleProc,LstFrm: DisableSMldCommands entfernt, weil schon in
           TeilnehmerMenueCommands gehandelt
           TriaMain: PrevNextExecute,etc ohne ToolRand update um schnelles
           Schalten zu erm�glichen
22.05.04 - MannschErgListe Kompakt wurde nicht gedruckt:
           Fehler in MannsObj: in TMannschObj.Init DummyTln.Jg korrigiert und
           DummyTln.KlassenSetzen erg�nzt
         - Zeitstrafe bei Staffel wirkte nur beim letzten Tln. EndzeitMStr und
           EndZeitOStr eingef�hrt statt Endzeit. Startzeit beim Staffel jetzt
           unabh�ngig von Strafzeit. Bei waMschSchopfheim funktioniert dies nur
           bei gewerteten Tln richtig.
25.05.04 - ImpFrm:  Website und EMail-Adresse als Link
================================================================================
02.06.2004: - neue Version 2004-1.2 auf Homepage (mit TriaZeit 2.1)



################################################################################
2005-1.0
========

20.06.04 - AllgFunc: ZeitStr durch EffZeitStr ersetzt, f�hrende Blanks entfernt
12.07.04 - DruckDlg: InitKlasseGB korrigiert, keine Abh�ngigkeit von WettkGB
           anChkLstSchwBhn wie anTlnUhrZeiten behandelt(immer SexBeide)
           Opt. Spalte nur enabled wenn f�r Wettk definiert
           Buttons in PrevFrame mit neuem Hint
13.07.04 - AnsFrm: nur gewertete Klassen auflisten
14.07.04 - DruckDlg: InitOptSpalteGB,InitKlasseGB korrigiert
           TlnObj: TReportTlnList.Add korrigiert
20.07.04 - Steuerung progressBar korrigiert. In AllgObj neue Funktionen:
           ObjSize,CollSize,SetItemSize eingef�hrt.
10.12.04 - ExpDlg neu, mit Export nach Excel-, HTML- und TextDateien
17.08.04 - WettkDlg: in WettkArtRGClick keine Fehlermeldung wenn
           SetWettkDaten ausgef�hrt wird (Update = true), weil dann die
           Bedingungen noch nicht stimmen.

12.12.04 - Spalte Mannschaft in TlnAnsicht Variabel: normal 'Verein/Ort', nur
           bei Liga 'Mannschaft'. Mannschaftswertg pro Tln einstellbar
           TlnDlg/TlnObj: neue Optionen: MschWertg, SondWertg, Urk.Drucken,
           Kommentar - Textfeld, Ausgabe in Exportdateien,
           nicht in SGrp definierte Startnr. zulassen,
           neuer TAB f�r Sonderwertung,
           Snr disabled, wenn Wettk.SBhn definiert und kein Tln.SBhn
           (in WettkDlg Tln.SBhn gel�scht wenn Wettk.SBhn gel�scht)
         - WettkDlg,TlnDlg,WettkObj,TlnErg,TlnObj: Sonderwertung pro Wettkampf
         - ZetErfDlg: neues Format ZERF mit Einlesen von Kommentar,
           Dateiformat trz,zrf toleranter: CR+LF und nur LF zul�ssig, und
           beliebige Trennzeichen

02.02.04 - KlassenDialog: Caption Wertungsklassen statt Altersklassen,
           Tab f�r Gesamtwertung erg�nzt (Name f�r M�nner/Frauen �nderbar)
           WettkObj: TlnMKlasse..MschWKlasse erg�nzt

03.02.05 - IdleProc: Tln �ndern/entfernen disabeln wenn nur Msch aufgelistet
20.02.05 - TlnDlg: KlassenGB eingef�gt mit Alters- und Zusatzklasse.Name
23.02.05 - WettkDlg: Enabeln/Disabeln bei Liga f�r WettkAlle und EinzelWettk
           konsequenter
06.03.05 - TlnObj: TlnInOrtStatus - stAbschn1/2/3,stImZiel,stGewertet nur mit
           g�ltigen Zeiten, bei GetAbs2/3StZeit mu� Zeit �ber voriger
           Abschn. g�ltig sein, bei Endzeit mu� Zeit �ber letzte Abschn.
           g�ltig sein (auch MannsObj)
         - MannsObj - Gemeinsame MschWkWertung f�r Team/Staffel/Sigm. mit
           Nutzung der vorher gespeicherten Abschn-Zeiten
         - SGrpDlg: Korrektur: OnClick f�r Abs2/3 Massenst. und Jagdst-RB
07.03.05 - TlnObj:Abs1/2/3-Zeiten wenn StartZeit=Uhrzeit,dann Zeit:=24St statt 0
09.03.05 - SGrpDlg: bei Staffel gilt Tln statt Abschnitt
10.03.05 - RaveUnit: ErgLstMschAbs2 neu erstellt
11.03.05 - Version 0.4:TlnObj,SMldObj: HausNr und PLZ als eigenst�ndiges Datenfeld
13.03.05 - ListFmt: Strafzeit bei MschErgListen mit '*' gekennzeichnet
31.03.05 - WettkAlle nur in Auswahllisten einf�gen wenn WettkColl.Count > 1
02.04.05 - TlnDlg - keine neue Tln wenn nur Gro�/Klein-Buchstaben unterschiedlich 
13.04.05 - MannsObj: Tln nicht in Msch einlesen wenn a.K. oder not SerWrtg
         - TlnDlg: Optionen MschWrtg,SondWrtg,SerWrtg Update bei �nderung
         - InfoDlg: Email-adresse entfernt, CopyRight angepa�t 
         - AllgComp,TlnDlg: TopAbstand in TriaGrid eingef�hrt, damit Margin
           einstellbar. In TlnDlg,SGrpGrid/SBgnGrid Rowheights auf 17, damit
           in Beide gleiche Margin (=2)
15.04.05 - Update StatusBar eingef�gt
16.04.05 - Context Hilfe-Button korrigiert in verschiedene Dialoge
17.04.05 - ImpFrm-Darstellung am Anfang korrigiert (passte nicht im Fenster)
         - TlnObj: Tlngestartet korrigiert
18.04.05 - AnsFrm: bei Serienwertung nur gewertete Klassen in Liste
         - KlassenDlg: TabControl2 korrigiert
================================================================================
26.04.2005: - neue Version 2005-1.0 auf Homepage (mit TriaZeit 2.2)


################################################################################
2005-1.1
========
04.05.05 - TlnDlg:
           Snr wieder freigegeben, wenn SBhn = 0 weil flexibler
           RangeSelect f�r SBhnGrid disabled
           bei frei definierbare labels (Land, Abschnitte)
           ShowAccelChar false gesetzt, damit & benutzt werden kann
           Taborder korrigiert, Tabstop f�r Buttons disabled
           entspr. Navigationsbuttons disabled am Anfang und Ende
           TlnNextBtn als Default statt OkButton
           Daten ohne Abfrage �bernehmen bei Nav.Buttons
           Jahrgang-Check war falsch ==> korrigiert
           Jahrg., Snr und Strafzeit l�schen erm�glicht
           mit Tasten Bild auf/ab Tln Scrollen
           EingabeOk nur wenn TlnGeaendert ausf�hren um Meldungern zu
           vermeiden bei Scrollen
           TriDatei.Modified nur bei �nderung
           bei Next/Back Grid.Index neu setzen vor �nderung, damit step von
           Neusortierung des ge�nderten Tln unabh�ngig
         - WettkDlg: AbschnZahlUpDown disabled bei Liga-Einzelwettk.
         - TlnObj,AnsFrm,TlnDlg: neue Sortmodes smTlnErstellt, smTlnBearbeitet f�r
           Anmelde-Ansichten, FBearbeitet/TTimeStamp eingef�hrt
           Load: Size von allg LongInt korrigiert cnSizeofLongInt (zukunft)
11.05.05 - ZtEinlDlg: AbschnZahl bei WettkAlle korrigiert(max aller EinzelWettk
           statt Wert WettkAlle (bei einzelVeranst. immer 3)
12.05.05 - DruckDlg: OptSpalte disabled f�r ErgListe Liga
         - RaveUnit: neue ErgListen mit 4. Abschn.
         - ExpDlg: Korrektur: bei AlleWettk gab es keine eigene Liste f�r
           Sonderwertung
         - WettkDlg: Korrektur: bei �nderung AbschnZahl ErgModified setzen
17.05.05 - TlnObj: Abs1OrtStartZeit f�r Staffel, 4.Abschn korrigiert
         - MannsObj: SetzeMschAbs3Zeit,GetEndZeit f�r Staffel korrigiert
18.05.05 - AnsFrm: f�r Startliste zus�tzlich WettkAlle und SexBeide zur Auswahl
19.05.05 - ImpFrm: Snr-Pr�fung eingef�hrt
================================================================================
20.05.2005: - neue Version 2005-1.1 auf Homepage (mit TriaZeit 2.3)


################################################################################
2005-1.2
========
30.05.05 - ImpDlg: Korrektur: Snr-Pr�fung nur f�r Tln aus QuellWettk

================================================================================
30.05.2005: - neue Version 2005-1.2 auf Homepage (mit TriaZeit 2.3)


################################################################################
2005-1.3
========
03.06.2005: - UrkDrDlg: Pr�fung in OkButtonClick korrigiert. UrkDruck war nur
              bei TlnTageswertung m�glich
================================================================================
03.06.2005: - neue Version 2005-1.3 auf Homepage (mit TriaZeit 2.3)


################################################################################
2005-1.4
========
28.06.2005: - TlnObj-TReportTlnList.Add korrigiert f�r TlnSerienwertung
              (keine Sonderwertung)
            - Pflichtwettk S&R nur ab 2 Wettk mit 2 Abschn.
              TlnObj-TlnInOrtStatus/BerechneSeriePunkte korrigiert,
              WettkObj-OrtZahlMit2Abschn neu eingef�hrt.
            - WettkTitel auf Listen nicht gedruckt, wenn bei serie OrtsWettkname
              (und damit (FStandTitelColl) nicht definiert wurde:
              WettObj: GetOrtStandTitel eingef�hrt, StandTitel = FName wenn
              nicht initialisiert (= '').
              WettkDlg StandTitelEdit.Text angepa�t
            - ZtEinlDlg: AlleWettk nur einf�gen, wenn alle Abschnitte gleich
================================================================================
28.06.2005: - neue Version 2005-1.4 auf Homepage (mit TriaZeit 2.3)


################################################################################
2005-1.5
========
14.07.2005: - Pflichtwettk S&R nur ab 2 Wettk mit 2 Abschn., war in 1.4 f�r
              Serienwertung Mannsch. vergessen
================================================================================
14.07.2005: - neue Version 2005-1.5 auf Homepage (mit TriaZeit 2.3)


################################################################################
2006-0.1
========
ab 12.01.06:

ImpDlg:
- Auswahl Excel-Tabellenblatt eingef�hrt
  leeres Feld und Wert=0 akzeptieren f�r Snr, SBhn

ImpFrm:
- Snr-�berpr�fung bei Tria-Import nur f�r Snr>0

AllgConst,IdleProc,TriaMain,SuchDlg:
- ToolbuttonRandUpdate entfernt, weil ToolBar-Fehler in Delphi 2006 korrigiert.  wurde .

TriaMain,ImpDlg,SuchDlg:
- Dlg-Position korrigiert - Desktop-/MainFormCenter statt AsDesigned

RaveUnit/RaveReports:
- Fehler in Rave 6.5: Horizontale Linie pro Zeile. Entfernt auf
  durch verkleinern von Even- und OddSections auf Page 2: Gleiche H�he
  wie auf Page 1. (5,2=>4,5; 4,3=>3,8).
  Linie unterhalb wird dann nur f�r letzte section gedruckt.
- Datasection Page 1: Lnd Vert.Line zu hoch auf allen Reports
- Checkliste Schwimmbahnen: �berschrift Bahn x, statt Schwimmbahn x

AllgConst,TriaMain,...:
- TAnsicht: Namen teilweise ge�ndert und MschErgDetail/Kompakt erg�nzt
- TSortMode: Namen neu sortiert und teilweise ge�ndert

TlnObj:
- neue Funktion TlnZahl/OrtTlnZahl, u.a. f�r StatusBar
  Index f�r Alle Ortzeiten nicht ber�cksichtigt ??????
          
MannschObj:
- neue Funktionen: MschAbs1,2,3,4OrtStZeit
- Funktion MschKlasseEinlesen beschleunigt und nur Einlesen wenn
  eine vollst�ndige Mannschaft gemeldet wurde
- Liga: bei zu hohe Starterzahl wird Msch disqualifiziert

LstFrm:
- Spaltenbreite modifiziert, weil Textwidth ungleich Delphi 7 (breiter)

AnsFrm:
- AnsichtCB.DropDownCount korrigiert (war zu niedrig)
- AnsichtCB  Reihenfolge ge�ndert und Trennlinien eingef�gt
- StatusCB: stGemeldet f�r Msch-Startliste erg�nzt, Startliste nur bis
            stEingeteilt

AllgConst,LstFmt,RaveUnit,...
- Bei MschWrtgDetail, Spalte TlnRng ersetzt durch Snr, da TlnRng nicht
  korrekt ist, wenn MschKlassenwertung und TlnKlassenwertung
  verschieden sind. Rng hat f�r Wertung sowieso keine Bedeutung

RaveUnit:
- Fu�note Zeitstrafe bei MschWertung auch wenn Einzelwettk und einer
  der Teilnehmer Zeitstrafe hat

UrkDrDlg:
- Spalten mit Abs-zeiten und Rng bei Einzel-Urkunden erg�nzt

TriaMain,MannsObj:
- Statusbar-Anzeige f�r Mannsch-ansichten korrigiert
- neue Funktionen (Ort)MschZahl wegen Statusbar-anzeige,
  ersetzen OrtMschImZiel

AllgConst,LstFmt,LstFrm,TlnObj:
- Spalte 'Ge�ndert am' in Meldeansicht hinzugef�gt,
  auch bei Create wird Aend.Datum gesetzt

ZtEinlDlg,AllgConst:
- fmGis, fmSportronic erg�nzt
- Pr�fung auf doppelte Snr in ZECollOk eingef�hrt
- Hunderstel auf Sek runden; bei Sek-Zeitgleichheit und Hunderstel ungleich
  Zeit inkrmentieren, damit Reihenfolge gleich bleibt.
  �berlauf bei 24:00:00 ber�cksichtigt.

TriaMain,IdleProc
- HauptFenster.ActionMainMenuBar.PersistentHotKeys := true: in Create und
  IdleEventHandler gesetzt. Wird sonst bei jedem Menu-zugriff zur�ckgesetzt
  (Delphi Fehler?)
  Muss konstant true sein, damit '&' in MruListe korrekt angezeigt wird.

InfoDlg:
- TMemo durch TLabel ersetzt, weil Text markiert und gel�scht werden konnte.

AllgFunc, etc. :
- function ErsetzeEinfachUnd eingef�hrt um '&' in MessageDlg/MruListe richtig
  anzuzeigen (Einfach '&' wird als Unterstrich angezeigt).
- Function TriaMessage als Ersatz f�r MessageDlg mit ErsetzeEinfachUnd

EnvProc,TRiaConfig:
- EnvProc entfernt, ersetzt durch TriaConfig
- Befehlszeilenargumente f�r Doppelclick auf Tria-Datei auswerten
- MruListe, Layout, Drucker, Optionen

AllgConst, OptDlg, TriaConfig:
- neue Option: MruDateiOeffnen auf AllgemeinTS, statt SpeichernTS

ExpDlg,UrkDrDlg:
- Spalten mit Nettozeit und Strafzeit erg�nzt bei TlnErg und MschErgDetail
  f�r Exportdateinen (Excel+Text) und Urkunden f�r TlnTageswertung.
  Kommentarspalte nur bei Listen mit Tln pro Zeile
  Korrektur: kein ';' nach letztem Feld

WettkObj:
- GetOrtAbschnName und GetOrtAbschnZahl f�r Ansicht mit Alle Wettk korrigiert.

LstFrm:
- UpdateOrtColBreite, UpdateMschTlnColBreite korrigiert. Werten wurden nur f�r
  aktuelle Ansicht neu berechnet, jetzt f�r alle Ansichten

AnsFrm,IdleProc:
- SerienAnsicht Tln/Msch disabled f�r nicht Serie/Cup

  
################################################################################
2006-0.2
========
ab 14.02.06:

DruckDlg,RaveUnit:
- Mit PrintDialog experimentiert. XP Dialog kann mit TMPrintDialogEx
  benutzt werden, aber �bernahme der Settings f�r rvRenderPrinter nicht
  m�glich.
  Standard Delphi PrintDialog kann modifiziert werden, aber keine �nderung der
  Hilfe-Funktion m�glich. Auch keine �bernahme der erweiterten Settings.
  Bei RvNDRWriter.ShowPrintDialog ist page range disabled. Keine
  M�glichkeit gefunden den Dialog zu �ndern.
  Deshalb Aussehen des DruckDialogs flexibel und Printerliste entfernt.
  Printer Settings k�nnen �ber Button 'Drucker einstellen' mittels
  ShowPrinterSetupDialog ge�ndert werden.


################################################################################
2006-0.6
========
ab 10.03.06:

Zeiten generell auf 1/10 Sek umgestellt ==> Datei nicht abw�rts kompatibel

AllgFunc,ZtEinlDlg:
- function ZeitWert durch UhrZeitWertSek ersetzt

TlnDlg:
- Tasten Pos1 und Ende zus�tzlich zu Bild auf/ab zum Navigieren abgefangen
- Bei �nderung Zeitstrafe Update Strafzeit auf Seite Zeitnahme korrigiert
- Tln-Adressen immer eingetragen, auch bei Sammelmeldung, damit TlnGeaendert
- nicht true wird, wenn bei Sammelmeldung vorher adresse eingetragen wurde
- Schwimmzeit in hh:mm:ss und von text auf Integer umgestellt (auch in TlnObj)

RaveReports:
- ZeitstrafeBand  height = 0, section bleibt 3,8
  Damit wird Zeitstrafesection Text oder Blank immer unter dem Frame geschrieben
  und nicht auf eine neue Seite, wenn Seite bis unten voll ist
  Fehler trat auf bei ErgListe mit 60 Tln

IdleProc, Dialoge
- Nach �ffnen von Dialoge wird Cursor in Editfelder,ComboBoxen nicht richtig, bzw
  gar nicht angezeigt. Gel�st in Idle durch �ndern von Selection.
  Funktioniert nicht bei OpenDialog,SaveDialog, weil hier kein IdleEvent auftritt
  Delphi 2006 Fehler !!!!

TriaMain
- Neuer Men�eintrag Hilfe/Tria 2006 im Web

VeranObj:
- Option DecZeiten in Datei speichern und beim Laden �bernehmen

WettkDlg, AllgConst:
- Fehlermeldung f�r StreichErg korrigiert
- cnMschGrMax von 8 auf 16 erh�ht

SGrpDlg, WettkDlg, TlnDlg, ...:
- TriaMaskEdit-Felder ge�ndert (neues/modifiziertes ChangeEvent), damit keine
  ung�ltige Formate nach Exit auftreten

ZtEinlDlg:
- neue Funktion: Speichern der Reportdaten

OptDlg:
- neu: �ffnen mit zuletz benutzte Datei
- neu: Default Geschlecht
- neu: Zehntelsek.
  
released: 14.04.2006
################################################################################

2006-1.1
========

ZtEinlDlg,ZtEinlRep,DateiDlg,DruckDlg,UrkDrDlg,ExpDlg
- DefaultExt ohne '*.'

ImpFrm,TlnObj:
- HausNr und PLZ wurden nicht importiert, weil diese in SetTlnAllgDaten fehlten

ZtEinlDlg:
- in Sportronic-Format Leerzeichen in Snr (und Zeit) entfernt (Fehler M.Weick)

TriaConfig
- Ini-datei in C:\Dokumente und einstellungen\user\Anwendungsdaten\Tria, weil
  hier keine Administrator-Rechte zum Erstellen/Schreiben n�tig sind
- Exceptions beim Speichern abfangen, damit das Programm beendet wird

TlnDlg:
- Begriff Stoppzeit statt Zeitnahme

UpdateDlg
- Neu: Internet Update

released: 07.05.2006

################################################################################
2006-1.2
========
TlnObj,VeranObj:
- Load von FBearbeitet korrigiert (WBuff statt Buff)
- LoadKorrektur f�r 2006-1.0/1.1

released: 02.06.2006

################################################################################
2006-1.3
========
- AnsFrm: Fehler-Korrektur: in WettkampfCBChange SondWrtg-Change ber�cksichtigt

released: 15.06.2006

################################################################################
2006-1.4
========
Hilfedatei Hlp1010.htm korrigiert

AllgComp:
- in TTriaGrid.Paint: kein Exit bei FCollection=nil, damit leeres Fenster
  dargestellt wird (wegen DateiDlg.TriDatSchliessen).
  In anderen Modulen Pr�fung auf FCollection=nil erg�nzt

AllgConst:
 - neuer Status: stGewertetDisq f�r TlnErgListe
 - seMannschPktMax=50000, statt 5000 (< seOrtMax*cnTlnMax/cnMschGrMin = 39.996) 

AnsFrm:
- AnsichtLeiste f�llen wenn Veranstaltung=nil: anAnmEinzel, smTlnErstellt,
  Wettkdummy, cnSexBeide, AkAlle, stGemeldet:
- auf Wk=HauptFenster.WettkDummy statt nil abfragen
- bei ltKtLstUhrZeit1 nur Sortmode 'Endzeit'
- Ansicht anTlnSchwBhn nur wenn Startbahnen definiert sind
- bei anTlnSchwBhn AlleWettk nur wenn alle Wk mit Startbahn definiert
- bei anTlnUhrZeit AlleWettk nur wenn f�r alle Wk gleiche Abschn. definiert sind
- Status Disqualifiziert und Gewertet+Disq. erg�nzt f�r MeldeAnsicht und TlnErg

D6OnHelpFix:
- neue Version mit HelpSelector._Release; ==> pr�fen bei neue delphi-Version

DateiDlg:
- TriDatNeu:
  - NeuBerechnen (unver�ndert) aus Loadkorrektur �bernommen
  - nach TriDatSchliessen leeres Fenster bevor Laden begint ((HauptFenster.Init)
  - TlnGrid nach Laden sofort anzeigen (HauptFenster.Init)
- TriDatSchliessen: StopPaint statt LstFrame.Schliessen, damit Gridinhalt
  stehen bleibt solange Fenster sichtbar ist

hh, hh_funcs:
- neue Version (1.8) f�r Windows-Vista

IdleProc:
- SetzeCommands: alles Disabeln bei Veranstaltung=nil
- DateiMenueCommands: TriDatNeuAction,TriDatOeffnenAction immer disabeln wenn
  Setzen=false
- AnsichtMenueCommands: Abfrage SortWettk=DummyWettk statt nil, AnsichtToolBar
  immer enabled

KlassenDialog:
- ListeAendern korrigiert: MschAltMKlasseColl war doppelt, in MschAltWKlasseColl
  ge�ndert

LstFmt:
- GetListType:
  - anAnmEinzel f�r Veranstaltung=nil korrigiert
  - anTlnErg f�r DateiNeu/WettkAlle korrigiert (1 Abschn.)
  - anTlnUhrZeit f�r DateiNeu/WettkAlle korrigiert (1 Abschn.)
  - anMschErgKompakt f�r DateiNeu/WettkAlle korrigiert (3 Tln/Msch)
- GetColHeader:
  - g�ltiger Header auch wenn Veranstaltung=nil,
  - wenn AbschnZahl=1, Header f�r spAbs1UhrZeit in KtLstUhrZeit1 fix 'Endzeit'
- GetColData:
  - Result='' bei Veranstaltung=nil
  - spAbs1,2,3,4Zeit/Rng Inhalt leer, wenn Abs nicht definiert f�r Listen mit
    allen Wettk
    
LstFrm:
- TListFrame.GetStopPaint/SetStopPaint entfernt
- TListFrame.Schliessen entfernt (jetzt StopPaint in SMldFrm und DateiDlg)
- in Create TriaGrid.Hide gel�scht:  Grid immer sichtbar
- LstFrame.Init: wenn Veranstaltung=nil HauptFenster.WettkDummy als SortWettk
  statt WettkAlle
- LstFrame.GridInit auch f�r Veranstaltung=nil g�ltig

MannsObj:
- SerieWertung korrigiert: smMschSerErg statt smMschSerPunkte

RaveUnit:
- TriaRvCustomConnectionGetRow: Abs1StartZeit in Titel3 f�r anTlnSchwBhn statt
  SGrp.StartZeit1 (Exception bei SGrp=nil)  

SMldFrm:
- Schliessen: LstFrame.TriaGrid.StopPaint statt LstFrame.Schliessen

SMldObj:
- TSMldTlnListe.SortString korrigiert: smTlnErstellt,smTlnBearbeitet fehlten

TlnDlg:
- Jahrgang darf 2-Stellig eingegeben werden, wird umgerechnet auf 19../20..
  Neue Funktion: GetJg
- wenn nur 1 SGrp f�r wettk definiert, wird diese bei Neu-Anmeldung
  voreingestellt (und bei Eingabe gespeichert)
  Anpassung von: UpdateSGrpListe

TlnErg:
- Meldung 'Alterskl-k-assen werden definiert' korrigiert

TlnObj:
- in TlnColl.Create: FSortMode := smTlnErstellt, statt smTlnname, weil dies
  der Anfangssortierung in AnsFrame ist
- SerieWertung korrigiert: smMschSerErg statt smMschSerPunkte
- AddSortItem: bei smTlnSBhn nur einf�gen wenn Startbahnen f�r Wk definiert sind
- TReportTlnList.Add: f�r Ansichten anTlnSchwBhn und anTlnUhrZeit wird Liste
  bei rmWkAlle getrennt pro Wettk gedruckt statt eine gemeinsame Liste �ber alle
  Wettk. Gemeinsame Liste wird bei Auswahl Alle Wk in AnsichtListe gedruckt
- TTlnColl.SBhnBelegt entfernt
- TTlnObj.TlnInOrtStatus:
  - stEingeteilt wenn f�r wettk Startbahnen definiert sind, dann muss Sartbahn
    auch f�r Tln definiert sein
  - neuer Status stGewertetDisq f�r TlnErgListe

TriaMain:
- Funktion/var StopPaint gel�scht, durch LstFrame.TriaGrid.StopPaint ersetzen
- WettkDummy f�r SortWettk wenn veranstaltung=nil
- Create: Position := poDesktopCenter ; WettkDummy (nach InitAllgAk) ;
          SortSex ; SetzeCommands
- Veranstaltung=nil erlaubt in InitOrtListe, Init, InitAnsicht,StatusBarUpdate;
  nicht erlaubt in RefreshAnsicht, UpdateAnsicht
- StatusBarUpdate: Veranstaltung statt LstFrame.TriaGrid.Collection.VPtr, weil
  EinlVeranst hier nie verwendet wird.
- TriDatNeuActionExecute, TriDatOeffnenActionExecute: CommandTrailer entfernt,
  weil bereits in vorherige Funktion (TriDatNeu) enthalten
- Close von InternetUpdate nach UpdateActionExecute

UpdateDlg:
- Close von InternetUpdate nach UpdateActionExecute

VeranObj:
- LoadKorrektur: f�r Bearbeitet auch bei Exception Bool := true
- NeuBerechnen (unver�ndert) von Loadkorrektur nach DateiDlg.TriDatNeu

WettkDlg:
- SetWettkAbschnGB, EnableWettkAbschn: nur wenn AbschnZahl > 1
- Pr�fung BahnEinteilung korrigiert: Funktion von EingabeOk nach WettkAendern,
  alte Funktion in WettkAendern (mit SBhnBelegt) entfernt

WettkObj:
- Funtionen f�r FVPtr=nil geeignet gemacht (wegen WettkDummy)
- GetOrtAbschnName =  '' wenn AbschnZahl  = 1
- SetOrtAbschnName: nur wenn AbschnZahl > 1
- GetOrtAbschnName: '' wenn AbschnZahl < 1 oder Abschn >= AbschnZahl
- Funktion TWettkColl.AlleAbschnGleich neu

ZtEinlDlg:
- Create: neue Funktion AlleAbschnGleich benutzt
- SetAbschnitt/GetAbschnitt vereinfacht

Released: 02.08.2006


################################################################################
2006-1.5
========
TlnErg:
- BerechneTagesRang: nach stGemeldet sortiert, damit Rang auch zur�ckgesetzt wird
  wenn Status in stGemeldet ge�ndert wird

TlnObj:
- TlnInOrtStatus korrigiert: FWettk.OrtStartBahnen(neu) statt StartBahnen
- SetOrtStrtBahn: SetWettkErgModified erg�nzt (wegen Status-�nderung)
- Abs1OrtStartZeit: ung�ltig wenn kein Startbahn definiert (stGemeldet)

WettkObj:
- GetOrtStartBahnen neu f�r TlnObj.TlnInOrtStatus


Released: 05.08.2006


################################################################################
2006-1.6
========

TriaMain:
- ProgressBar in FormShow in StatusBar eingef�gt (keine verbesserung bei Vista)

WettkDlg;
- in SetMschGesWertgRG Wertung disabled bei MeschWertung=mwKein,
  in MschWertgRGClick SetMschGesWertgRG aufgerufen
- SetMschGrGB ersetzt SetMschGrGBDaten und SetMschGrGBEnable

TlnDlg:
- InitData: TlnBuffer.SGrp gesetzt, wenn nur 1 SGrp vorhanden, damit TlnGeaendert
  am Anfang false bleibt;
  TlnBuffer.Free gererell hier statt in anderen Funktionen
- InitDialog: Sonderklassen nur enabled, wenn mindestens 1 Sonderklasse definiert ist
- UpdateKlasse: Sonderklasse bei gwProAk nicht angezeigt und disabled wenn
  keine Sonderklasse definiert ist
- UpdateSGrpListe: Anzahl Tln ohne SGrp statt nicht eingeteilte Tln
- EingabeOK: bei PageChange nur Tab-Daten pr�fen, keine allgemeine Daten
- TlnAnmelden: WettkAktuell := erste Wettk nach alphabetischer Reihenfolge,
               statt erste Wettk in WettkColl
- TlnAendern: InitTlnBuffer (neue Funktion, auch in InitData) aufnehmen, weil
  TlnBuffer gleich sein muss an TlnAktuell (Fehler: TlnAktuell.MannschName wird
  bei �nderung gel�scht, wenn nicht mehr in Datei vorhanden; dadurch
  Zugriffsverlettzung in TlnBuffer (Gerard)).
  TlnAktuell fokussieren vor UpdateAnsicht.
- TlnNext, TlnBack, ...etc: Anpassung an ge�nderte Funktion TlnAendern

TlnObj:
- SortString: bei Altersklassen: FAltKlasse.AlterVon / 1-Integer(FSex)
  statt FSex / Alter;
  neuer SortMode: smTlnSnrAk, Altersklasse f�r Startliste
- TReportTlnList.Add: Fehler beim Drucken der Siegerliste: TBuff war undefiniert,
  durch Item.Wettk ersetzt.
 
AllgConst:
- neuer Sortmode: smTlnSnrAk, Altersklasse f�r Startliste

LstFmt:
- GetListType: Funktion AkSpalte eingef�hrt, keine Funktions�nderung



---------------------
Released: 13.10.2006
---------------------

################################################################################
2007-1.0
========

Allgemein:  Copiler-Warnungen reduziert
DruckDlg:
- Pr�fung in OkButtonClick korrigiert
UrkDrDlg:
- Pr�fung in OkButtonClick korrigiert
AllgConst:
- TWettkArt/waDummy wegen Doppelbenutzung waSigmaringen (Int3,4).
  waSchopfheim fr�her f�lscherweise bei TWettkArt gel�scht, deshalb
  waSigmaringen in alten Dateien mit Idx 4, neu mit Indx 3 gespeichert
  Zuk�nftige neue wettkArten sollen deshalb ab Indx 5 beginnen
- TDateiFormat getrennt in TtriDateiFormat und TTrzDateiFormat weil .txt doppelt
WettkObj:
  TWettkObj:
- GetOrtTlnTxt: bei Liga grunds�tzlich Leerstring, damit wird TeilnehmerTS im
  TlnDlg f�r Liga nicht mehr ben�tigt.
- GetOrtWettkArt korrigiert: waSigmaringen mit Indx 3 und 4 benutzt
- GetOrtMannschGrAnm,GetOrtMannschGrStrt: auch f�r non-Liga gespeicherter Wert
  auslesen, fr�her fest auf cnTlnMax
- Load:
  read allg LongInt f�r Zukunft korrigiert: cnSizeOfLongInt statt -SmallInt
  MannschGrAnmColl,MachGrStrtColl f�r �ltere Versionen auf cnTlnMax setzen
- FPunktGleichOrt von Integer auf TortObj umstellen, um Fehler bei �nderung in
  OrtColl zu vermeiden
TWettkColl:
  SortString immer gleich Index, SortColl nur noch f�r WettkAlle
- Create: Sortieren macht keinen Sinn, da Count = 0, deshalb nur SortMode setzen
- FSortNachAk muss bei AddSortItem neu berechnet werden
WettkDlg:
- Create: bei Liga waSchopfheim generell entfernt, auch vor 2005 waSigmaringen
- SchwimmTS gel�scht: info in AllgemeinTS
- SerienTS gel�scht: Info in MannschTS f�r Liga, in CupDlg f�r Cup
- SetPage: Korrektur: AllgemeinTS gew�hlt, wenn Page nicht Visible
- MschGrAnm,Str,Wrtg f�r alle Veranstaltungsarten
MannsObj:
- MannschWkWertung: f�r alle Veranst.arten Starterzahl pr�fen, nicht nur vaLiga
- RngMax neu f�r UrkDrDlg
- Startzeiten f�r Jagdstart Liga (ortindex > 0) korrigiert 
TOrtObj:
- eigenst�ndige Unit statt in VeranObj, damit TOrtObj in TWettkObj benutzt
  werden kann
ImpFrm:
- ImpStartButtonClick-WettkUebernehmen: ClearSortItem/AddSortItem, damit
  WettkColl neu sortiert wird
UrkDrDlg:
- Snr- und RngBereich mit aktuellen Werte initialisiert, daf�r neue Funktionen
  in TlnObj: SnrMin, SnrMax, RngMax;  MannsObj: RngMax
TlnObj:
- SnrMin, SnrMax, RngMax neu f�r UrkDrDlg
SnrDlg:
- UpDown f�r SnrVon und SnrBis eingef�hrt
TlnDlg:
- Jg nur l�schen wenn unbekannnt; nicht "0" eintragen da dies 2000 entspricht
- UpDown eingef�hrt f�r Jg
- Alter von 1 bis 99 erlaubt, abh�ngig von Wettk.Jahr
- SnrButton entfernt, daf�r Liste mit freie Snr zur Auswahl. 1. Freie Snr
- voreingestellt, wenn SGrp gew�hlt und noch keine Snr definiert ist
OptDlg:
- SofortRechnen statt AutoBerechnen, alternativ nach Schlie�en des Dialogs
- Setzen VorgabeButton korrigiert
IdleProc,TriaMain,AllgConst,..:
- NichtRechnen entfernt, grunds�tzlich nach jedem relevanten Men�befehl neu
  berechen, optional (default) auch sofort nach �nderung im Dialog.
  Zus�tzlich vor jedem Men�befehl, falls mal was schief gehen sollte
  Keine Berechnung mehr im IdleHandler
  Nicht klar ob damit Problem beim ZeitenEinlesen (Keine Neuberechnung - Rost)
  gel�st ist.
- Alle Befehle gespert w�hrend PrgressBar.Visible und HauptFenster Active ist,
  auch ProgrammAbbruch gesperrt um Abst�rz zu vermeiden.
  Wenn nicht Active sind Befehle sowieso gesperrt.
TriaMain:
- ProgressBar-Funktionen mit ProcessMessages erg�nzt, damit Fortschritt unter
  Vista dargestellt wird (lauft immer noch nicht bis zum Ende) und Steps nur
  alle 2% und 200 mSek dargestellt werden (Zeitgewinn)
DateiDlg:
- Beim Dateiladen und nachfolgendem Berechnen und Sortieren bleibt Progressbar
  stehen, damit das Bild ruhiger wird
ImpDlg:
- beim Tln-Import k�nnen die Daten gleicher Tln optional �berschreiben werden
ExpDlg:
- Jahrgang mit 4 statt 2 Stellen exportieren (Excel und Text)
- Beim Excel-Export werden verbundene Felder in Einzelfelder getrennt wegen
  einfachere Extraktion und Sortierung
OrtDlg:
- gestrichen, in VeranDlg integriert
SerWrtgDlg:
- neu, f�r flexible serienwertung


---------------------
Released: 28.03.2007
---------------------


################################################################################
2007-1.1
========

SGrpDlg:
- SGrpGridClick korrigiert: wenn bei Click nach �nderung best�tigt wird, wird
  nicht mehr nach vorige SGrp zur�ckgeschaltet

VstOrtDlg:
- TVstOrtDialog.Create: Veranstaltung.OrtIndex voreingestellt

TlnDlg:
- TTlnDialog.TlnAendern: Fehlerkorr. bei �nderung SnrBelegtArr[Snr] updaten


---------------------
Released: 11.04.2007
---------------------



################################################################################
2007-1.2:   Einfache Staffelwertung
================================================================================

AllgConst:
- waMschSigmaringen entfernt, waTlnStaffel erg�nzt (Int(5))

WettkObj:
- GetOrtWettkArt:  waTlnStaffel erg�nzt
- GetTlnGesWertg: fest f�r Liga:  gwMannFrau f�r WettkAlle, sonst gwAlleAk
- GetMschWertg: fest f�r Liga:    mwKein f�r WettkAlle, sonst mwEinzel
- GetMschGesWertg: fest f�r Liga: gwAlleAk
- DefaultTlnWertg,DefaultMschWertg,DefaultMschGesWertg gestrichen

WettkDlg:
- SetWettkArtRG, GetWettkArtRG: waTlnStaffel erg�nzt
- EingabeOK: Fehler: MschGr/AnmStrt/Wrtg/Edit validate nur wenn Enabled
- SetMschGrWrtg: Fehler: immer g�ltiger wert setzen (0 nach mwKein)
- WettkArtRGClick: Best�tigung statt Meldung bei MschWettk.: mwKein,gwAlleAk
  Git bei Cup f�r alle Orte
- SetMschWertgRG,SetMschGesWertgRG:
  bei vaCup WettkArt in andere VeranstaltungsOrte ber�cksichtigen,
  disablen wenn irgendwo ein Mschwettk definiert ist 
- SetMschGrAnm,SetMschGrStrt,SetMschGrWrtg: disabled bei waTlnStaffel
- WettkAendern: Korrektur MschGrWrtg =3 wenn disabled (war 0), um
  Fehler Division durch Null zu vermeiden

ImpFrm, ZtEinlDlg,AllgConst:
- InitialDir gesetzt und letzter wert gespeichert

TlnObj:
- GetOrtAbs2,3,4UhrZeit Fehler korrigiert: FWettk.OrtAbschnZahl statt AbschnZahl
- BerechneSeriePunkte: MschWettbewerbe nicht ber�cksichtigen

ZtEinlDlg:
- ZeitErfDateiEinlesen:TriDatei.Modified entfernt, nur gesetzt in TZEObj.Einlesen

UpdateDlg:
- SetStatus: Fehler: teilweise alte ProgName durch neue ProgName ersetzt

AnsFrm:
- Korrektur: UpdateMschTlnColBreite in InitWettkListe statt WettkampfCBChange,
  damit Breite auch bei WettkChange durch Ansichtswechsel angepa�t wird
- InitWettkListe: Korrektur: Index+1 f�r SondWrtg nur wenn SondWrtg in Liste

PrevFrm:
- TPrevFrame.Oeffnen: Korrektur: Zoomfactor nach Definition von PrevScrollBox  

MannsObj:
- TMannschTlnListe.Sortieren: Korrektur: DIV durch null verhindern wenn
  OrtMannschGrWrtg[OrtIndexNeu] = 0
- MannsColl.Sortieren:  Fehlerkorrektur: TlnColl.SortWrtgMode := wgStandWrtg;


---------------------
Released: 09.05.2007
---------------------


################################################################################
2007-1.3:
================================================================================

SMldFrm:
- Fehlerkorrektur: sporadische Zugriffsverletzung beim Schliessen von SMld-Dialog
  TSMldFrame.Schliessen: HauptFenster.LstFrame.TriaGrid.Collection := nil, nach
  L�schen von SMld, weil TlnListe ung�ltig wird

---------------------
Released: 22.05.2007
---------------------


################################################################################
2007-1.4:
================================================================================

SerWrtgDlg:
- EingabeOk: ung�ltig wenn GetStreichErg < 0, statt <= 0
- WrtgPktRecAendern,SetButtons: RecIndxAktuell statt Row benutzen
- UebernehmButtonClick,OkButtonClick: wenn WrtgPktRecGeAendert zuerst Rec in
  Liste �bernehmen, vor Liste gepr�ft wird
- FocusWrtgPktRec: setze Updating vor Row-�nderung, wegen Click-Event,
  Funktion SetWrtgPktRec einf�gen
- SetWrtgPktGrid,WrtgPktRecNeu,WrtgPktRecLoeschen,ListeOk: FocusWrtgPktRec
  benutzen, Row nicht direkt setzen

Meldedaten nach Excel und Text exportieren
- ExpDlg: mehrere �nderungen
- AllgConst: ltMldLstTlnExp mit Spalten definiert
- IdleProc: DruckenMenueCommands angepasst
- ImpDlg: GetFeldNamenKurz auch f�r LstFmt zug�nglich
- LstFmt: GetTitel3, GetColType, GetColHeader, GetColData f�r ltMldLstTlnExp erg�nzt
- LstFrm: AlignMode f�r ltMldLstTlnExp erg�nzt
- TlnObj: TReportTlnLst.Add: ltMldLstTlnExp erg�nzt

ImpDlg:
- ImportiereDaten: beim �berschreiben von TlnDaten nicht importierte Felder auf
- Initwert setzen (wie beim Create)

---------------------
Released: 10.06.2007
---------------------


################################################################################
2007-1.5:
================================================================================

UrkDrDlg:
- in SerienDruckTlnTagesWertung VName+Name statt Name,Vname f�r Staffelteilnehmer

TlnObj:
- function StaffelVNameName f�r Urkunden erg�nzt

---------------------
Released: 24.06.2007
---------------------


################################################################################
2007-1.6:
================================================================================

ImpDlg:
- Felder f�r StaffelTln, Zeiten, DisqGrund hinzugef�gt, damit sind ALLE Daten
  importierbar. (Ergebnisse notwendig bei Mika Timing Zeitnahme, da spezielles
  Zeitdatei-Format gestrichen wird.
- Pr�fung auf vergebener Snr korrigiert bei vorhandener Tln
- Bei Pr�fung auf vorh. Tln. Option mbNo gestrichen, weil verwirrend, da keine
  individuelle Entscheidung pro Tln m�glich ist.
  Korrektur: Bei Cancel Fehler setzen vor Exit.
- Korrektur: Meldezeit in Zehntel statt in Sek.
- nur Datenfelder mit Defaultnamen automatisch zuordnen, �brige nicht mehr der
  Reihe nach
  
AllgConst:
- Spalten und Datenfelder f�r Im-/Export erg�nzt in TImpFeld und TColType

AllgFunc:
- Funktionen MinZeitWertDec, MinZeitWertSek erg�nzt f�r Import Strafzeit

ImpFmt:
- Spalten f�r Im-/Export erg�nzt in ltMldLstTlnExp

ExpDlg:
- bei Text- und Excel-Export wird in sp(Msch)TlnEndzeit kein Blank angeh�ngt
- Felder f�r StaffelTln, Zeiten, DisqGrund hinzugef�gt, damit werden ALLE
  Daten exportiert.
- nur f�r Wettkampf relevante Datenfelder exportieren.
- function ExcelRangePar korrigiert

TlnDlg:
- Korrektur: MldZeitEdit Events definiert (fehlten)
- TlnEntfernen: Alle Tln aus Liste k�nnen auf einmal gel�scht werden

WettkObj:
- neue Funktion:  AlleWettkArtAehnlich
- neue Funktion:  AlleGesWertgGleich

DruckDlg:
- AkRBClick: AkNewPageCB nur enablen wenn bei Init enabled

DruckDlg,UrkDrDlg,ExpDlg:
- WkWahlRB und AkWahlRB an oberste Position und voreinstellen
- WkAlleRB disablen wenn nicht AlleWettkArtAehnlich
- AkAlleRB disablen wenn SortSex = cnSexBeide

---------------------
Released: 7.10.2007
---------------------


################################################################################
2008-0.1:
================================================================================

TlnObj,TlnErg,MannschObj,...:
- Wertung Tln und Msch immer f�r kwAlle,kwSex,kwProAk und f�r Tln zus. kwSondKl,
  sowohl f�r Tages- wie Serienwertung
- Sortieren: ProgressBarStehenLassen statt ZeigeMeldung benutzen 

TlnObj:
- TagesEndRngStr,TagesZwRngStr ersetzen TagesRngStr.
  Nur in Spalte 1 wird disq/aK angezeigt

AusgDlg:
- Neu, ersetzt DruckDlg und ExpDlg, UrkDrDlg bleibt
- ReportWkMode entf�llt, Listen nur f�r SortWettk
- ReportAkMode durch ReportAkListe ersetzt    

WettkObj/WettkDlg:
- waTlnStaffel bei Serien nicht verf�gbar
- MannschGrAnm,MannschGrStrt wieder nur f�r Liga, sonst m�sste getrennt pro
  Wertungsklasse definiert werden (nur f�r AkAlle definieren)
  GetOrtMannschGrAnm,GetOrtMannschGrStrt: f�r non-Liga wieder fest auf cnTlnMax

TlnErg:
- TlnSerienwertung bei Cup nur f�r WettkArt=waEinzel
- SetzeErstZeit1,2,3: Fehler: auf Abs1,2,3Zeit statt Abs1,2,3UhrZeit pr�fen

TriaConfig,DateiDlg,TriaMain:
- OrtIndex in Ini- statt Tri-Datei speichern. Nur beim Neustart mit zuletzt benutzter
  Datei verwenden. Beim Laden w�hrend Programmausf�hrung letzter Index beibehalten.
  In OrtCBChange TriDatei nicht Modified setzen

PrevFrm:
- Scrolltasten disabled, wenn nicht benutzbar

TriaMain:
- Statusbar-Anzeige erweitert mit Tln/Msch-Zahlen in Klasse, in Wettk
- Msch in ErgListe auch bei mwMulti nur einmal gez�hlt (konsistent)
- ProgressBar �berarbeitet:
  Init in DateiDlg,TlnErg,etc. ge�ndert, damit Bar continue weiterlauft
  Pause nach Clear damit Max-Stand sichtbar wird bei Vista
  ProgressBarText: Panels[0]='', bei Panels[1] immer '...' am Ende
  StatusBarText: wie vorher ProgressBartext mit Panels[0],Panels[1] als Input

IdleProc:
- TlnNeu-Button im Men� disablen wenn keine Tln-Ansicht

ImpFrm:
- DatenImportieren - Korrektur: bei ftKein Import abbrechen 

AnsFrm:
- InitStatusListe: anMschErgDetail: stAbschn1,2,3 statt stGestartet.
  stGestartet nur f�r anTlnUhrZeit, weil AbsZeit nicht g�ltig sein muss (SBhn=0)
- InitWettkListe: Startliste bei Liga auch pro einzelWettk
- InitSexListe: M�nner/Frauen unabh�ngig von Klassen- oder Sonderwertung.count

LstFmt:
- GetColData: spStatus korrigiert: stGestartet eliminiert, nur noch f�r
  anTlnUhrZeit verwendet (stGestartet ist g�ltig auch wenn SBhn=0)
  Bezeichnung Abschn1 statt ImZiel (bei AbschnZahl=1)

AlgConst,AnsFrm,TlnObj,SMldObj:
- zus�tzlicher SortMode TlnAlter   

KlassenDlg:
- ListeOK: auch 0 Altersklassen zulassen
  Gleiche Bezeichnungen f�r Name oder K�rzel pro Wettkampf nicht zulassen
- K�rzel f�r Mannschaften disablen, weil nur f�r Tln-Altersklassen benutzt

ZtEinlDlg:
- MikaTiming entfernt, weil nicht benutzbar

AllgConst,TlnObj,TlnDlg,TlnErg,...
- Tln-Option a.K f�r Altersklassen- und Sonderklassenwertung (Rost).
  Gilt f�r alle Orte und f�r Serienwertung, nicht f�r MschWertg
  AusserKonk gilt auch nicht mehr f�r MschWrtg, da hierf�r eigene Option MschWrtg


---------------------
Vorab an T. Rost: 27.1.2008
---------------------


################################################################################
2008-1.0:
================================================================================


VistaFix:
- Problem mit Alt-Taste gel�st (Texte verschwinden beim Drucken auf Alt-Taste)
  TStaticText durch TLabel ersetzt um m�gliches Problem in XP mit Alt-Taste zu
  vermeiden.
- Schriftarten alle auf Segoe UI, size 9 gesetzt (Vista Standard). War fr�her
  Sans Serif (alte OS) und Tahoma (XP). Beide gemischt vorhanden.
  Wenn OS <> Vista wird auf Tahoma, Size 8 oder MS Sans Serif umgestellt
- Vista Open und SaveDialog verwendet

UpdateDlg:
- Download-exe: default Verzeichnis Desktop statt ProgrammDir

TriaConfig:
- Ini-datei vor Speichern immer l�schen, damit alte Leichen verschwinden

AusgDlg:
- Drucken aus Preview korrigiert: alte Einstellungen �bernehmen und in Dialog
  disabled darstellen.
- Druckereinstellung: A4 und Portrait voreingestellt und Meldung wenn
  vom Anwender ver�ndert
- Urkunden mit altem Dialog

TriaMain:
- ProgressBarMaxUpdate: ProgressBarScale entfernt, weil Funktion bei
  MaxNeu < 100 nicht OK.
- THauptFenster.StatusBarUpdate: bei anAnmSammel alle Zahlen auf SMld bezogen
- THauptFenster.MruActionExecute: Fehlerkorrektur: Zuerst SMldFrame schliessen
- InitOrtListe: Dummy Ort in OrtCB um Count=0 zu verhindern (m�gl. Ursache f�r Exc??) 

TlnErg,MannsObj,WettkObj:
- Fehlerkorrektur: bei TlnStaffel wird bei Jagdstart keine Abschn-Startzeit
  berechnet. Neue Funktion eingef�hrt: TWettkObj.EinzelWettk:Boolean.

TlnErg:
- AusserKonkAltKl,AusserKonkSondKl auch bei TagesSerienwertung ber�cksichtigt 
- Korrektur: ProgressBarStehenLassen := true nach try, sonst bleibt
  ProgressBarStehenLassen=true bei WettkColl.Count und TlnColl.Count=0 

DatExp:
- TextColText korrigiert: spTlnEndZeit/spMschTlnEndZeit ersetzt durch
  spTlnEndZeitExp/spMschTlnEndZeitExp damit kein Blank eingef�gt wird

DatExp,SerDrDlg:
- bei TlnStaffel Rang-Spalten pro Teilehmer erg�nzt

WettkObj:
- Korrektur: ProgressBarStep in WettkColl.Store erg�nzt
  
AllgFunc,TlnDlg:
- EffZeitStr: Zeit=0 als -/-,- dargestellt statt 0/0,0, weil 0 ung�ltig ist
  Nur Strafzeit in TlnDlg wird als 0/0,0 dargestellt

KlassenDlg (,AnsFrm,TlnErg):
- bei waMschStaffel,waMschTeam keine SonderKlassen
- wenn AkGrid.ItemCount = 1  oder NeuEingabe Name focussieren statt AkGrid
 
ImpDlg:
- PruefeDaten korrigiert: zuerst checken ob Pflichtfelder zugeordnet sind
- Nur Name,Vorname als Pflichtfelder anzeigen und pr�fen


---------------------
Released: 9.3.2008
---------------------


################################################################################
2008-1.01:
================================================================================

WettkObj:
- GetTlnKlasse: Ergebnis bei Liga von WettkAlle

AusgDlg:
- rmUrkunden erg�nzt

SerienDr:
- Neu, ersetzt UrkDrDlg,

RaveUnit:
- Logo von 2007 in 2008 ge�ndert

---------------------
Vorab an T.Rost: 15.3.2008
---------------------


################################################################################
2008-1.1:
================================================================================

TlnErg,TlnDlg,AnsFrm,AusgDlg:
- waTlnStaffel auch pro Geschlecht werten

TlnDlg:
- Korrektur: Abs2,3,4ZeitEdit.ReadOnly true gesetzt wenn EditMask = ''

KlassenDlg:
- ListeOK: keine Warnung wenn Altersl�cke in Sonderklasse

TlnErg:
- Korrektur: weitere ProgressBarInit eingef�gt. Bisher nur bei TlnAkModified

--------------------------------------------------------------------------------
Released: 26.3.2008
--------------------------------------------------------------------------------


################################################################################
2008-1.2:
================================================================================


TlnDlg:
- Korrektur: UpdateKlasse: Updating war am Ende immer gesetzt (Rost)

SerienDr:
- Korrektur in verschiedenen Listen: Loop bis ReportWkListe.Count-1 statt Count

ImpDlg,WettkObj,TlnDlg:
- Import Jg sowohl 2- als 4-stellig, function WettkObj.JgLang eingef�hrt
- neue funktion WettkObj.Jglang um Jg von 2- nach 4-stellig umzurechnen


--------------------------------------------------------------------------------
Released: 31.3.2008
--------------------------------------------------------------------------------


################################################################################
2008-1.3:
================================================================================

RaveUnit:
- Fehlerkorrektur:
- RvNDRWriterPrint:
  Wenn kein ReportNewWkPage dann nur einen Report f�r alle Wettk., weil
  ExecuteReport immer am Anfang der Seite beginnt (==> �berlappung)
  Geht nur bei gleichem ReportType f�r alle Wettk.
- TriaRvCustomConnectionGetRow: HauptFenster.SortWettk ersertzt durch ReportWk
                                HauptFenster.SortWrtg ersetzt durch ReportWrtg

TlnObj:
- Fehlerkorrektur:
  TReportTlnList.Add: SortWrtg durch ReportWrtg ersetzt
  ReportSortieren in 2 versionen: gemeinsame und getrennte listen pro wettkampf
- Checkliste Schwimmbahnen wenn Schwimmdistanz definiert ist, Bahnen m�ssen
  nicht mehr definiert sein (TTlnColl.AddSortItem)

DatExp:
- ExportDateiSpeichern: keine Ausgabe wenn Liste leer ist

AusgDlg:
- UpdateLayoutGB: wenn kein Wettk-NewPage, dann kein Ak-NewPage
- DatenUebernehmen: anTlnSchwDist: bei Wettk-, Bahn- und Startzeit-�nderung immer
  neue Seite
  
AnsFrm:
- InitAnsichtListe: anTlnSBhn umbenannt in anTlnSchwDist und angezeigt wenn Distanz
  definiert ist (statt startbahnen)

TlnDlg:
- neue Funktion WettkObj.JgLang benutzt
- SBhnGrid ColBreite eingestellt

--------------------------------------------------------------------------------
Released: 17.4.2008
--------------------------------------------------------------------------------


################################################################################
2008-1.4:
================================================================================

TlnDlg:
- UpdateJg: Jg nicht umrechnen w�hrend JgEdit ge�ndert wird.

--------------------------------------------------------------------------------
Released: 21.4.2008
--------------------------------------------------------------------------------


################################################################################
2008-1.43:
================================================================================
Basiert auf 1.4
Zwischenversion f�r BWTV:

bei Liga 4 Abschnitte erlauben f�r Wettkampf in TBB (Swim&Run + Triathlon)
cnWettkAbschnMaxLiga entfernt

LstFmt:
- ltErgLstTlnQuad enabled f�r Liga

RaveForm:
- TriaRvCustomConnectionGetCols/Rows f�r Liga-Abschn.4 ge�ndert

AusgDlg:
- WettkCLB: disabeln wenn nur 1 Wettk vorhanden

--------------------------------------------------------------------------------
an BWTV: 11.6.2008
--------------------------------------------------------------------------------

################################################################################
2008-1.44:
================================================================================

Basiert auf 1.43
Zwischenversion f�r Sch�ttler:
- Korrketur K�rzel f�r Msch-Altersklasse

KlassenDlg:
- DrawCell: Kuerzel nur f�r TlnWrtg anzeigen, sonst ''
- KlasseOk: Kuerzel nur pr�fen, wenn enabled (TlnWrtg)

AllgComp:
- TTriaMaskEdit.Change: Text:=Trim(Text): Blanks am Anfang und ende aut. l�schen

--------------------------------------------------------------------------------
an Sch�ttler: 20.6.2008
--------------------------------------------------------------------------------


################################################################################
2008-1.5:
================================================================================

Basiert auf 1.44

AllgConst:
- typt TImpFeld gel�scht, daf�r TColtype benutzt
  extra TColType f�r Schleifen als letzte Spalte: spExpKein
- MruImpFeldArr dynamisches array of TMruImpFeldRec, nur g�ltige Feldnamen

AllgFunc:
- TriaMessage: Showmessage benutzen wenn Application.MainForm=nil. Ist der Fall,
  wenn Tria.chm nicht existiert (wenn Tria.exe ohne .chm in Verzeichnis kopiert wird) 
- UhrZeitWert100 Fehlerpr�fung erweitert

AllgComp:
- TTriaMaskEdit.Change: Blanks auch in der  Mitte aut. l�schen

MannsObj:
- TMannschObj.BerechneSeriePunkte korrigiert f�r Liga: Msch unabh�ngig von
  Teilnahme immer f�r Liga gewertet.
- MschEinlesen: nicht einlesen f�r M�nner-Klasse wenn Tln.Sex=cnKeinSex

TlnObj:
- TlnObj.Load korrigiert: Name2,3,4Coll.Add(nil) vor 2007-1.2
- Load/Store: Sex als Integer statt als Option speichern, damit auch cnKeinSex m�glich
- SerieWertung: keine M�nner-Wertung wenn cnKeinSex
- ReportSortieren,ReportTlnListe.Add: FSortAkWrtg pro Tln anpassen, damit korrekte
  Serienpunkte benutzt werden. (Fehlerkorrektur Marti)

DatExp:
- Korrektur ExcelTabelZeile: auch bei Excel-Export wird in sp(Msch)TlnEndzeit
  kein Blank angeh�ngt
  TextColData f�r Excel und Text benutzt
- neu GetFeldData f�r ltMldLstTlnExp, sonst GetColData

TriaConfig:
- MruImportFeldnamenListe dynamisch, nur g�ltige Feldnamen  

ImpFrm:
- WeiterButtonClick: G�tigkeit JgEdit f�r Wettk.Datum pr�fen

AusgDlg:
- Drucker aus uses entfernt

ImpDlg:
- TImpFeld durch TColType ersetzt
- FeldZuordArr entfernen, ersetzt durch ImpFeldArr.Spalte
- bei Uhrzeiten immer Dec und Sek-Format akzeptieren

LstFmt:
- spAk bei TlnStaffel Geschlecht als M oder W angeben
- GetColdata: Data f�r ltMldLstTlnExp entfernr

TlnErg:
- SetRngTag:
  keine M�nner-wertung, wenn Geschlecht nicht definiert ist
  Damit mixed-Staffel nur in der Gesamtwertung, wenn kein Geschlecht definier wird.
  �ber Sonderwertung ist dann eine eigene mixed-wertung m�glich.

KlassenDlg:
 - bei TlnStaffel auch M�nner/Frauen erlauben: SetTab1Daten ge�ndert

WettkObj:
- JgLang nur 2-stellige Zahlen hochrechnen ??
 - bei TlnStaffel: GetTlnKlasse : bei Alt/SondKlasse: AkUnbekannt

TlnDlg:
- SexCB: immer KeinSex erlauben, f�r alle WkArten.
- JgUpDown.Min/Max nicht begrenzen. Wert(JgEdit) als Position �bernehmen,
  umrechnen erst bei �nderung

--------------------------------------------------------------------------------
Released: 26.6.2008
--------------------------------------------------------------------------------



################################################################################
2008-1.6:
================================================================================

MannsObj,TlnObj:
- BerechneSeriePunkte korrigiert
  Zeile RngBuffColl.SortList.Add(RngBuffColl.PItems[i]); fehlte

- SortString korrigiert f�r Serienwertung: SerPktSort,GetSerOrtRng => 5-stellig
  TlnObj: smTlnSerErgMschName korrigiert

ZtEinlDlg,AllgConst:
- fzDAG f�r DAG-System erg�nzt
- fzTriaZeitHundert, fzZerfHundert erg�nzt

--------------------------------------------------------------------------------
Released: 15.7.2008
--------------------------------------------------------------------------------


################################################################################
2008-1.7:
================================================================================

TriaMain:
- Fehler: TlnSchwBhnActionExecute mit stEingeteilt statt stSerEndWertung. Hatte
  keine wirkung, weil stGemeldet als default gesetzt wurde 

TlnObj:
  Fehler: FSerieWertung, FSerieEndwertung pro KlassenWertung definiert, statt
  nur f�r AkAlle. Wenn nicht alle gewertete Tln Serienpunkte erhalten, kann Tln
  bei akAlle ohne Punkte und z.B. bei M�nner Punkte bekommen.
  Fehler: StreichErgLoeschen korrigiert

MannsObj:
  Fehler: StreichErgLoeschen korrigiert

--------------------------------------------------------------------------------
Released: 31.7.2008
--------------------------------------------------------------------------------


################################################################################
2008-2.0:
================================================================================

AllgConst,WettkDlg,TlnDlg,........
- neues Dateiformat f�r Rundenkontrolle
- 1-9.999 Runden pro Abschnitt definierbar
- Rundenkontrolliste, geeignet f�r 24h-Lauf - ltKtLstRunden

VeranObj:
- Load/Store am Datei-Ende: Funktionen in einzelene Objecten verlegt, weil sich
  Dateiformat sowieso �ndert.

SerWrtgDlg:
- PktIncrEdit/UpDown disabeln und in Grid als '-' darstellen, wenn RngVon=RngMin
- bei Incr-Change Grid-PktBis-Spalte updaten
- Pkt-Reihenfolge in ListeOk pr�fen
- smTlnSerErgMschName: auch abh�ngig vonFSeriewertung und PunktGleichOrtIndx

TriaConfig:
- SpeichereKonfiguration: Exit wenn Veranstaltung=nil (Fehler bei 2x Close)
- ZtErfDateiFormat in Ini-Datei gespeichert
- HauptFenster.Position := poDesigned, wenn Ini verf�gbar, sonst Ini-Werte ignoriert
  Wenn kein Ini-File bleibt poDeskTopCenter, damit Position immer definiert ist

TlnObj:
- a.K.-Wertungen pro Ort definieren. Wenn a.K. dann wird Ort f�r die Serie nicht
  gewertet
- disq-Bezeichnung pro Tln und pro Ort definieren.
  DisqGrund und DisqBezeichnung in Destroy l�schen

TriaConfig,AllgConst:
- ZtErfDateiFormat in Ini-Datei gespeichert

AllgConst, AllgFunc, OptDlg, ....
- neues Zeitformat Hundertstel: TZeitFormat = zfSek,zfZehntel,zfHundertstel
- var DecZeiten ersetzt durch ZeitFormat
- Option AutoSpeichern eingef�hrt

AusgDlg:
- Fehlerkorr.: bei Drucken aus preview wurden Daten (Seiten/Exemplare) nicht �bernommen
  in OkButtonClick wird DatenUebernahme jetzt immer aufgerufen, �bernahme nur f�r
  Druckbereich und Exemplare
- Default AkNewPageCB.Checked false statt true

RaveUnit:
- ltKtLstUhrZeit4 erg�nzt

KlassenDlg:
- f�r MschWk MschWertung nur f�r Alle Tln: keine Tabs f�r Geschlecht und Altersklassen
  TlnWertung auch f�r Altersklassen (nur f�r Darstellung in MschWertung-Detailliert) 

LstFrm:
- TriaGridClick,TriaGridDblClick,TriaGridDrawCell: Exit wenn StopPaint. Sonst
  f�hrt Click w�hrend DateiSchliessen zur Exception
  
ZtEinlDlg:
- GiS DoppelEintr�ge mit Zeitdiff. < 60 sek gefiltert

ZtLoeschDlg:
- ZtErfLoeschen: StopPaint gesetzt w�hrend l�schen

ZtEinlDlg,ZtloeschDlg,ZtEinlRep:
- gleichzeitiges Einlesen von verschiedenen Abschnittszeiten aus einer Datei
  auch beliebige Mischung in verschiedene Dateien
- DAG-System: min. Zeilenl�nge von 40 nach 20. Bei manchen systeme fehlen die
  f�hrende Nullen (Rost)

TlnDlg,TlnObj,MannsObj,.....
- ZeitGutschrift eingef�hrt
- TTlnDialog.SnrFrei: bei Snr=0 immer true
- SnrEdit - ClearText entfernt, keine Pr�fung auf Doppelte Snr bei Snr=0 

ImpDlg,AllgFunc:
- bei Uhrzeiten (UhrZeitWert) nur Decimalen entsprechend Option ZeitFormat zulassen um
  Ungleichheiten in TlnDlg zu vermeiden
- bei StrafZeit und Gutschrift (MinZeitWert) Stunden=0 und Decimalen=0 zulassen
  ensprechend Option ZeitFormat

Export:
- f�r Excel und Text ExpZeitStr statt EffZeitStr in Uhrzeitformat
  bei StrafZeit und Gutschrift Uhrzeit ohne Dec.
  ListMode lmExport eingef�hrt
  GetFeldData entfernt
- MschWettk:  bei spMschEndZeit spMschStrafzeit/spMschGutschrift erg�nzt

TlnObj:
- EndZeitNetto statt EndZeitOStrf
- EndZeit statt EndZeitMStrf : EndZeitNetto + Strafe - Gutschrift

IdleProc:
- anTlnUhrZeit,anTlnRndKntrl: beide nach Excel und Text exportierbar

--------------------------------------------------------------------------------
Released: 10.10.2008
--------------------------------------------------------------------------------


################################################################################
2008-2.1:
================================================================================

Fehler beim AutoSpeichern korrigiert
TriaMain,

ZeitFilter pr�fen auch f�r bereits eingelesene Zeiten

--------------------------------------------------------------------------------
Released: 18.10.2008
--------------------------------------------------------------------------------


################################################################################
2008-2.2:
================================================================================

AllgConst,TriaMain,DateiDlg:
- ZeitAktGespeichert ===> ZeitDatGespeichert

AllgFunc:
- ValidDatum entfernt, function DatumWert ge�ndert, Pr�fung mit ValidateEdit
- TryStrToInt durch neue function TryDecStrToInt ersetzt

AllgComp:
- TTriaGrid abgeleitet von TCustomDrawGrid statt TDrawGrid
  Nicht benutzte properties entfernt
- TTriaCustomMaskEdit neu als Basis f�r alle MaskEdits
- ValidateEdit als fuction statt procedure, zu verwenden in allen Dlg in EigabeOk,
  (weil Validate bei Enter nicht automatisch ausgef�hrt wird)
- FOrgText, AendereText, GetText, SetText neu, damit in ValidateEdit
  auch �nderungen erkannt werden, die in Change durchgef�hrt werden
- MessageBeep in ValidateError entfernt
- LeerValid entfernt (wird nur bei Liga MschGrAnm/Start benutzt)
- ClearText enfernt
- TZeitEdit.FLeerZulassen entfernt, immer zulassen (true in Tria, false in TriaZeit)

WettkDlg:
- DatumEdit - Font in Courier New ge�ndert, Mask = !90/00/0000;1;_
  Pr�fung mit ValidateEdit, zus�tz�iche Pr�fung auf Tag > 0
- LeerValid f�r MschGrAnm/Start entfernt (wird nur bei Liga benutzt)

TlnObj:
- Fehler bei Rundenzeiten korrigiert (Roessgen):
  Bei �ndern von Wettk in TlnDlg wurde RundeColl der Tln nicht an neue Rundenzahl
  angepasst
  TlnObj.SetWettk: UpdateRundenZahl erg�nzt
  TlnObj.Load RundenzeitColl im Fehlerfall angepasst
- SetOrtStrtBahn: Korrektur: StartZeiten neu berechnen wenn StBahnAlt=0 (Wert VOR �nderung) 

OptDlg,TriaConfig,UpdateDlg,AllgConst:
- Automatische Update-Pr�fung als neue Option (max 1x t�glich)


--------------------------------------------------------------------------------
Released: 19.01.2009
--------------------------------------------------------------------------------


################################################################################
2009 - 1.0:
================================================================================

TriaMain:
- FormCloseQuery true nach SetupGestartet, sonst nach AutoUpdate nicht
  geschlossen, weil BeendenAction disabled ist
- TriDatSpeichernActionExecute, ...: Abfrage SMldFrame.Schliessen nu bei
  FAnsicht=anAnmSammel (war in 2.2 vesehentlich gel�scht). Damit beim Speichern
  keine Umschaltung mehr nach anEinzelAnm
- Progressbar-Anzeige f�r Vista �ber Pos.-�nderung statt Warteschleife
- Konflikt zwischen Men�Commands und Timer-Tick gel�st �ber ProgressBar und
  Disable-Men�commands

AllgConst,AnsFrm,TriaMain,TlnObj:
- stGestartet in stUhrzeitVorhanden umbenannt (anTlnUhrZeit)
- stAbs1Zeit,stAbs2Zeit,stAbs3Zeit,stAbs4Zeit neu f�r mindestens eine Uhrzeit (SBhn egal, anTlnRndKntrl)
- stAbs1Start,stAbs2Start,stAbs3Start,stAbs4Start neu f�r mindestens eine g�ltige Uhrzeit (SBhn g�ltig)
- Tln bei unvollst�ndiger Rundenzahl in Ergliste aufgenommen.
  Nach Rundenzahl und Zeit sortiert. EndRndZeit statt EndZeit, auch unvollst�ndige
  Zeiten angezeigt. Rundenzahl aber nicht angezeigt, braucht neue Spalte

SGrpObj,TlnObj:
- TlnGestartet: stAbs1Start statt stAbs1Ziel (nur bei Rundenzahl>1 unterschiedlich)

TlnObj:
- TlnInStatus: stAbs1..7Ziel,stImZiel wenn StoppZeit g�ltig, nicht Abs, weil
  bei setzen MschZeiten/MschStaffel TlnStartzeiten noch nicht alle g�ltig sind 
- SetStrtZeit: Korrektur bei waMschTeam:

TlnDlg:
- TTlnDialog.UpdateZeiten - Fehlerkorrektur:
  ZeitEdit bei ge�nderter Sortierung als Folge von Startzeit-�nderung anpassen 
- InitSondWertgTS korrigiert: Label disabeln bei Staffel

AllgConst, .....
- auf 8 Abschn. erweitert
- MruListe max 8 statt 4
- Gro�buchstaben als Ext. zulassen

AllgConst,WettkObj,WettkDlg:
- MschGrWrtg max 8 bei MschStaffel, weil AbsArr f�r Zeiten benutzt wird
- Fehler korrigiert: Berechnung bei MschStaffel war nicht Ok, weil TlnStartzeit
  benutzt wurde, bevor diese definiert war

OptDlg:
- Sex Voreinstellen: wenn disabled, SexCB.Indx := -1 (CB leer)
- neue Option: �berlappende Snr-Bereiche zulassen

ImpFrm:
- ImportiereTln: Fehlerkorrektur: bei Import mit Erg wurde SGrp nicht �bernommen

VeranObj:
- Store: Fehlerkorrektur: DisqGrundColl wurde 2. mal gespeichert.
  Dadurch Zeitformat nach Load immer auf Sek.

TlnErg,TlnDlg,AnsFrm,KlassenDlg:
- F�r TlnStaffel auch alter erlauben und damit Allers- und SonderKlassenwertungen

LstFrm:
- auch mit Eingabe-Taste Tln-Bearbeiten, wie DoppelKlick
- StandardColBreite spMschTln0..spMschTln7 gleich f�r Tln/MschStaffel und
  breiter f�r Tln > 4

AllgFunc:
- GetSpecialFolder als neue Funktion

DateiDlg:
- TridatNeu - GetSpecialFolder(CSIDL_DESKTOPDIRECTORY), statt Programmdir, nur wenn
              vorher keine Datei geladen war
  TridatNeu - SetCurrentDirectory erg�nzt

ZtEinl,ZtLoeschen, ZtFmtDlg(neu):
- Abschn.1 nicht mehr voreingestellt, damit nicht versehentlich mit gew�hlt wird
- FormatAuswahl �ber Datei
- Dateiname im Dialog
- Report mit Zahl der ausgefilterte Doppeleintr. erg�nzt.
- Fehler ZeitVorhanden, DoppelItems wurde ausgefiltert: korrigiert
- Neu: Live Zeiterfassung

UpdateDlg:
- Progressbar-Anzeige f�r Vista �ber Pos.-�nderung statt Warteschleife

MannsObj:
- MschZeiten auch definieren wenn nicht komplett gewertet, f�r Anzeige bei
  Live Zeiterfassung (Status imZiel)
- Korrektur: SetzeMschAbsZeit: stAbs1UhrZeit statt stAbs1Ziel weil nur Stoppzeiten
  benutzt werden k�nnen. Tln-Abszeiten werden sp�ter nach SetStrtZeit erst g�ltig

SGRpDlg:
- Pr�fung: Startmodi m�ssen f�r alle Startgruppen eines Wettkampfes gleich sein  

--------------------------------------------------------------------------------
Released: 28.04.2009
--------------------------------------------------------------------------------

2009 - 1.1:
TlnDlg: Exception bei SGrp=nil
================================================================================

2009 - 1.2:
- ImportDialog.InitImpFeldArr: Exception
  Zeile erg�nzt: if Col in [spAbs1UhrZeit..spAbs8UhrZeit] then
TriaMain.ImportActionExecute: Exception
  ImportDialog in ImpFrame umbenannt

================================================================================

--------------------------------------------------------------------------------
Released: 28.04.2009
--------------------------------------------------------------------------------


################################################################################
2009 - 1.3:
================================================================================

AllgConst, OptDlg, TriaMain, TriaConfig:
- Fehler in OptDlg korrigiert, AutoSpeichernInterval konsequent in mSek;
  Angezeigt in OptDlg und in Ini-Datei in Min

TriaMain:
- ProgressBarInit,StatusBarClear - Korrektur: Cursor setzen vor SetzeCommands
- BeendenActionExecute: MenueCommandActive auch hier setzen
- CommandHeader in TriaMain statt IdleProc und ge�ndert:
  MenueCommandActive, StatusBarClear und Berechnen hier aufnehmen

IdleProc:
- AnsichtMenueCommands: korrektur: TlnRndKntrlAction.Enabled/Disabled erg�nzt

AnsFrame:
- InitAnsichtListe: Korrektur: TlnRndKntrlAction.Checked:= false; erg�nzt

LstFmt:
- GetTitel3 bei M�nner/Frauen Name Wettk-abh�ngig definieren
- GetColData: Korrektur: spStaffelVName2..spStaffelVName8 erg�nzt (wurden nicht exportiert)

ImpDlg:
- InitImpFeldArr: Korrektur in StaffelNameGueltig (StaffelVNamen nicht importierbar) 

WettkDlg,TlnObj,....
- neue wertungsart: Rundenrennen

================================================================================
--------------------------------------------------------------------------------
Vorab-Version 1.2a an Marti: 7.05.2009
--------------------------------------------------------------------------------

SGrpObj:
- StartModeVorgegeben: Korrektur: Basis SG.WkOrtIndex statt Vst.OrtIndex

SerienDr:
- SerienDruckTlnEtiketten: Jg erg�nzt
- Urkunden: Einheit Std./Min./Sek. erga�nzt

SGrpDlg:
- EingabeOk: ModiUebernehmen auch f�r SGAktuell und ClearTlnStZeit erg�nzt,
  ErgModified,TriDateModified gesetzt

TlnObj:
- TTlnColl.ClearIndex: SetOrtStaffelVorg nicht benutzen wegen Sortierung

TlnDlg:
- TlnFirst,TlnLast korrigiert: wenn Tln aus Liste verschwindet, wird ItemIndex
  in TlnAender = 0. Deshalb kein Exit bei ItemIndex=0, weil sonst Dialog nicht
  mit neuer Tln initialisiert wird    
- TlnEntfernen: neuer Index korrigiert, gleiche Zeile auch bei neu-sortieren
- in ZeitEdits wird letzte gestoppte Rundenzeit angezeigt statt Zeit der letzten Runde
  zus�tzliche Edits pro Abschnitt f�r Rundenzahl
  ErgEdit und EndZeit zeigen Zeit bei RndRennen auch bei unvollst�ndiger Rundenzahl

================================================================================

--------------------------------------------------------------------------------
Released: 15.5.2009
--------------------------------------------------------------------------------


################################################################################
2009 - 1.4:
================================================================================
ImpDlg:
- ImportDialog.GetSGrp korrigiert: SGrpColl statt SortColl, weil sonst nicht immer
  alle wettk enthalten sind.
================================================================================

--------------------------------------------------------------------------------
Released: 21.5.2009
--------------------------------------------------------------------------------


################################################################################
2009 - 1.5:
================================================================================

MannsObj:
- Fehler in MannschWkWertung korrigiert: SetAbsZeit entfernt, da sonst keine
  Wertung
================================================================================

--------------------------------------------------------------------------------
Released: 6.6.2009
--------------------------------------------------------------------------------

################################################################################
2009 - 1.6a:
================================================================================

TlnDlg:
- VereinCB ersetzt durch LookupEdit/GRid/Btn
- Verein bei Neuanmeldung := nil statt Verein voriger Tln,
  MschNamePtrAktuell entfernt
- KeinJg-, KeinSexAkzeptiertAll eingf�hrt f�r alle Tln

ZtEinlDlg,ZtFmtDlg:
- Zeitnahme f�r Mandigo-Systeme: (Rost)
  Dateiformat - getdata_out24.txt:
  000001 00:00:06.9 S0000014L0000001
  000002 00:00:07.0 S0000065L0000001
  000003 00:00:09.4 S0000039L0000001
  ..
  000703
  -------hh:mm:ss.d-----NNNN--------

- Bei LiveZeitErfassung optional letzter Tln fokussieren
================================================================================

--------------------------------------------------------------------------------
Geschickt an Rost: 8.10.2009
--------------------------------------------------------------------------------

################################################################################
2010 - 1.0:
================================================================================

Allgemein:
- Initialisiert in Dialoge entfernt, FormShow statt FormActivate benutzt f�r
  Fokussierung
  var HelpDateiVerfuegbar eingef�hrt, Helpbuttons disabled, wenn Datei nicht
  vorhanden ist
- bei Liga Einzel- Tages- und Serienwertung pro Wettkampf
- WettkAlle durch WettkAlleDummy ersetzt. Wird nicht mehr gespeichert, weil nicht
  mehr f�r Liga ben�tigt

AllgObj:
- TVersion JrNr erg�nzt, damit Version als 10.1.0 angezeiigt wird statt 2010-1.0  

CmdProc ersetzt IdleProc:
- IdleHandler entfernt, Funktion in IdleEventHandler
- Reset ActiveCtrl erg�nzt

ZtEinlDlg:
- bei LiveErfDlg nicht abbrechen wenn Datei leer ist

TriaMain
- FormCreate und FormDestroy entfernt, Funktion in Create/Destroy �bernommen
- SpeichereKonfiguration und TriDatSchliessen(100) in Destroy,  nicht in FormClose,
  weil danach Berechnung noch weitergeht ==> Exception bei Abbruch
- In TriaMain.IdleEventHandler nur Refresh bei DialogNeu um SelectAll in SuchDlg
  zu erm�glichen
- wenn HelpDateiVerfuegbar=false Hilfe Buttons auf SMldFrm und ImpFrm disabeln.
  Geht nicht in Frm, weil die vorher in inherited Create erstellt werden

WettkObj:
- neue Funktion: TlnOrtSerWertung
- neu: StreichOrt (f�r MindestWettk�mpfe)
- StreichErg,StreichOrt,PflichtWhMode,PflichtWkOrt1/2,PubktGleichOrt f�r Msch
  und Tln getrennt
- GetCupPkt: nicht gewertet erh�lt bei Incr 1 mehr als letzter Platz
- LigaKuerzel entfernt
- WettkAlle entfernt, durch WettkAlleDummy ersetzt

TlnObj:
- in TTlnColl.SortString Label Ende entfernt
- BerechneSeriePunkte korrigiert: TlnOrtSerWertung(i) pro Ort statt f�r OrtAktuell
- f�r StreichOrt angepasst
- SerRngToPkt: einheitlich f�r Cup und Liga, basiert auf Wettk.TlnCupPkt
- GetPktSerStr: wenn TlnImZiel, dann Pkt auch anzeigen wenn nicht gewertet
- SerPktSort f�r Liga und Cup einheitlich
- EinteilungLoeschen: nur Einteilungsdaten l�schen, alles andere unver�ndert lassen

MannsObj:
- BerechneSeriePunkte f�r StreichOrt angepasst
- SerRngToPkt: einheitlich f�r Cup und Liga, basiert auf Wettk.MschCupPkt
- GetPktSerStr: wenn TlnImZiel, dann Pkt auch anzeigen wenn nicht gewertet
- MschEinlesen: Wettk.MschCupWrtgPktColl neu berechnen f�r Liga

AnsFrm:
- AppendStatus(stGemeldet) f�r anMschErgSerie und anTlnErgSerie
- AppendAnsicht(anTlnErgSerie) auch f�r Liga
- InitAnsichtListe Fehler: AppendAnsicht(anTlnSchwDist) abh�ngig von WettkAlleDummy
  statt SortWettk, weil diese sich sp�ter �ndern kann. Bei �nderung InitAnsichtListe
  neu ist keine Alternative, weil hier wieder Impact auf wettkListe
- AppendSortMode(smTlnSBhn) f�r anAnmEinzel,AnmSammel,TlnStart, wenn SBhn vorhanden

DateiDlg:
- Speichern: Warnung das Dateisicherung bei Extension .~tri nicht geht

AllgConst, etc...
- Mandigo-Format auskommentiert
- ListTypes f�r ErgLstLiga entfernt
- spLiga,LigaRng entfernt

SerWrtgDlg:
- alle Einstellugen getrennt f�r Tln u. Msch
- StreichOrte/MindestWettk als neue Option
- neue Button: �nderungen �bernehmen f�r alle Wettk
- Tln Liga frei definierbar wie Cup, nur Liga-Msch voreingestellt
- bei NeuEingabe nicht automatisch l�schen, nur NeuEingabe zur�cksetzen
- Neu sperren, wenn RngBis in letzter Eintrag 9.999
- L�schen sperren f�r 1. Eintrag in Liste
- WrtgPktRecChange: PktIncr nicht l�schen, bringt Fehler bei �nderung

KlassenDlg:
- auch bei Liga TlnKlassen pro Wettk, statt f�r WettkAlle definieren

ListFmt:
- ListTypes f�r ErgLstLiga entfernt
- spLiga,LigaRng entfernt

TlnDlg:
- Korrektur: in EingabeOK bei Snr-Pr�fung GetWettk benutzt statt Hauptfenster.SortWettk
- Tages-Serienwertung mit Punkte erg�nzt, Anzeige auch f�r Liga
- Blanks in Name, VName automatisch entfernen
- Warnung bei Einteilung mit Snr ohne SBhn

SMldFrm:
- Blanks in Name,VName automatisch entfernen

SerienDr:
- Bei Urkunden Msch Tln-Endzeiten erg�nzt

SuchDlg, ErsetzDlg:
- SelectAll, wenn Liste nicht leer ist und letzter Suchbegriff angezeigt wird. Kann
  damit gleich �berschrieben werden.
  Dazu in TriaMain.IdleEventHandler nur Refresh bei DialogNeu.

SGrpObj:
- TSGrpColl.SortString nach Startzeit statt Name sortiert

UpdateDlg:
- angepasst weil ProgName jetzt ohne Jahrzahl.

ImpDlg:
- HelpContext korrigiert
  Excel:
  Fehler beim �ffnen korrigiert, wenn parallel Excel bereits ge�ffnet.
  Excel: Open und Close als neue Routinen. Korrektur bei Exceptions: Meldungen unterdruckt.
  FLCID �ber Funktion statt Konstante: Werte unterschiedlich.

VeranObj:
- in Load Exception abfangen (try except)

Scrollfehler in Grids:
  wenn ein Item ge�ndert wird und anschliessend per Maus den Scrollbar bedient wird,
  erscheint Meldung: Daten ge�ndert....
  Wenn Fenster steht, wird aber weitergescrolled. Wenn anschlie�end den Scrollbutton
  geklicked wird, wird teil vom grid grau. Ursache nicht gefunden, Scrollbarstatus
  irgendwie inkonsistent.
  Fehler beseitigt indem Scrollbars := ssNone gesetzt wird bevor Fenster ge�ffnet wird.
  Dann wird weiteres scrollen verhindert und auch der folgefehler.
- Korrigiert in: VstOrtDlg, SGrpDlg, SerWrtgDlg, KlassenDlg, WettkDlg, SMLdFrm

EinteilenDlg
- NEU: automatische Einteilung und L�schung

ZtEinl:
- Fehler beim Einlesen von fzZerf: zfSek-Pr�fung falsch >14 statt bisher <14 
- bei Zeit-Formatpr�fung auch ung�ltige Werte (-1) zulassen, nur Format pr�fen
  Damit kein Abbruch bei Leerstring ('  :  :  .  '), wegen Fehler in triaZeit 

--------------------------------------------------------------------------------
19.03.2010: Released
--------------------------------------------------------------------------------

################################################################################
2010 - 1.1:
================================================================================

UpdateDlg:

- Korrektur in PadFileLesen: mit ProgVersion.JrNr statt Nr vergeleichen

--------------------------------------------------------------------------------
28.03.2010: Released
--------------------------------------------------------------------------------


################################################################################
2010 - 1.2:
================================================================================

WettkObj:
- SexSortMode korrigiert, bei MannschWertung EinzelWettk <> liga M�nner/Frauen
  wieder einf�gen, Fehler in 10.1.0

TlnObj:
- SetStrtZeit korrigiert: Fehler bei Jagdstart f�r Abs > 2. Bei Berechnung
  von Startzeit wurde nur letzter Abs ber�cksichtigt, statt Summe aller Abs.

--------------------------------------------------------------------------------
14.04.2010: Released
--------------------------------------------------------------------------------


################################################################################
2010 - 1.3:
================================================================================

TriaConfig:
- procedure LadeKonfiguration: Exit nach Hauptfenster.Close, damit Datei nicht
  mehr geladen wird

TriaMain:
- FormClose: InitProgressbar nur wenn Veranstaltung <> nil, sonst Exception beim
  autom. Update und Tria-Fenster bleibt offen

WettkObj:
- GetOrtDatum korrigiert f�r WettkAlleDummy: Datum des 1. Wettk
- GetOrtMschGrWrtg, OrtSchwimmdistanz,GetOrtStartbahnen,OrtAbschnZahl,
  GetOrtAbschnName, GetOrtTlnTxt,GetOrtAbschnRunden:
  Wert f�r WettkAlleDummy nur berechnen wenn FVPtr=Veranstaltung und <> nil

--------------------------------------------------------------------------------
20.04.2010: Released
--------------------------------------------------------------------------------


################################################################################
2010 - 1.4:
================================================================================

SGrpDlg:
- in EingabeOk, SGrpAendern WettkAlleBuff.OrtErgModified durch Schleife �ber
  alle Wettk ersetzt, weil Funktion in WettkObj nicht f�r WettkAlleBuff funktioniert
  Korrektur weil Ergebnisse nach �nderung nicht neu berechnet wurden

TlnObj:
- Load: Count von ZeitColl gleich Rundenzahl setzen wenn Version < 10.1.4,
  weil noch Fehler in alten Dateien vorkommen k�nnen (Marti)

AllgConst,ImpDlg,DatExp:
- ltTlnImport/lmImport eingef�hrt
- ltMldLstTlnExp mit Startzeit erweitert (nur Export, kein Import)  

--------------------------------------------------------------------------------
21.05.2010: Released
--------------------------------------------------------------------------------


################################################################################
2010 - 1.5:
================================================================================

ZtEinlDlg,ZtFmtDlg, AllgConst,TriaConfig:
- Zeitnahme f�r Mandigo-Systeme: (Nagel,Rost)
  Dateiformat - getdata_out24.txt:
  000001 00:00:06.9 S0000014L0000001
  000002 00:00:07.0 S0000065L0000001
  000003 00:00:09.4 S0000039L0000001
  ..
  000703
  -------hh:mm:ss.d-----NNNN--------

TlnObj:
- Load: Count von ZeitColl immer gleich Rundenzahl setzen, weil doch noch Fehler
  in 10.1.4 Dateien vorkommen k�nnen (Nagel). Zur Sicherheit auch f�r neue Versionen.
- SetTlnOrtDaten nur f�r akt. OrtIndex
- TlnObj.UpdateRundenzahl OrtIndex als Parameter erg�nzt
- SetWettk Korrektur:
  - UpdateRundenZahl f�r alle Orte, statt nur akt. Ort,
  - f�r Abs>AbsZahl Zeiten l�schen
  - SondWrtg, TlnTex,StartBahnen an Wettk-Einstellung angepasst
- TlnInOrtStatus korrigiert: WettkArt falsch ausgewertet bei waRndRennen
    FWettk.OrtWettkArt[Indx] = waRndRennen statt FWettk.WettkArt = waRndRennen

WettkObj:
- SetWettkOrtDaten nur f�r akt. OrtIndx
- SetAbschnRunden: nur f�r akt. OrtIndex Rundenzahl Updaten, SetOrtAbschnRunden entf�llt,
  kein Update beim Laden, nur benutzt in SetWettkOrtDaten,
  keine StatusBar-Anzeige
- SetOrtDatum und load Datum korrigiert: Trennzeichen immer '.' setzen

--------------------------------------------------------------------------------
03.06.2010: Released
--------------------------------------------------------------------------------


################################################################################
2010 - 1.5a:
================================================================================

WettkDlg:
- EditMask TDatumEdit in WettkDlg ge�ndert in Designer von:
  '!90/00/0000;1;_' in '!90.00.0000;1;_'
  Das Zeichen / dient dazu, in Datumsangaben Jahr, Monat und Tag voneinander zu trennen.
  Wenn die L�ndereinstellungen in der Systemsteuerung Ihres Rechners ein anderes
  Trennzeichen vorsehen, wird dieses an Stelle von / verwendet.
  In NL z.B. '-' statt '.'

--------------------------------------------------------------------------------
18.06.2010: Testversion an Versteeg
--------------------------------------------------------------------------------

################################################################################
2010 - 1.5b:
================================================================================

TlnObj:
- TlnObj.Load: Fehlerkorrektur: Rundenkorrektur f�r Ort-Rundenzahl statt f�r OrtIndex

--------------------------------------------------------------------------------
19.06.2010: Testversion an Nagel
--------------------------------------------------------------------------------

################################################################################
2010 - 1.6:
================================================================================

�nderungen in 1.5a, 1.5b released

--------------------------------------------------------------------------------
28.06.2010: Released
--------------------------------------------------------------------------------


################################################################################
2010 - 1.7:
================================================================================

TlnObj:
- SortString - function ErgStr korrigiert f�r RndRennen, damit Reihenfolge bei
  ErgListen stimmt
- TTlnObj.UpdateRundenZahl: f�r akltueller OrtIndex. War pro Ort, aber
  falsch: Aktueller AbschnRunden verwendet statt Ort AbschnRunden
  TriDatei.Modified um Korrekturen zu speichern
- SetWettk: UpdateRundenZahl nur f�r akt. OrtIndex, fr�her f�r alle, aber falsch:
  stets basierend auf AbschnZahl f�r akt. OrtIndex
  Bei �nderung in WettkDlg m�ssen alle Orte ge�ndert werden. Dies geschieht aber
  generell in TlnErg
- Load Korrektur Rundenzahl entfernt, geschieht jetzt in TlnErg.
- TlnColl sicherheitshalber immer sortieren

TlnErg:
- UpdateRundenZahl f�r alle Orte erg�nzt.

SerienDr, Felder erg�nzt:
- SerienDrTlnEtiketten:  E-Mail, Startgeld
- SerienFrSMldEtiketten: E-Mail
- SerienDrTlnTageswertung: Strasse,HausNr,PlZ,Ort,EMail,Startgeld
                           Abs1Zeit nur wenn mehr als 1 Abschn.
                           Einheiten pro Absch.
- SerienDrTlnSerienwertung: Strasse,HausNr,PlZ,Ort,EMail
- SerienDruckMschWertungKompakt,
  SerienDruckMschWertungDetail: Zeit-Einheiten pro Tln

AllgFunc:
- neue Funktion ZeitEinhStr

SMldObj:
- SMldTlnListe sicherheitshalber immer sortieren

--------------------------------------------------------------------------------
6.10.2010: Released
--------------------------------------------------------------------------------


################################################################################
2010 - 1.8:
================================================================================

TlnObj:
- TNameCollArr of String statt TTextCollection:
  TlnStaffel nicht bei Serie, deshalb Name,VName Ortsunabh�ngig
  TlnColl sicherheitshalber immer sortieren, weil manchmal falsch sortiert,
  siehe EMail vom 11.7.2010 von Oscar schneider. Ursache unklar

VstOrtDlg:
- VstAendern: bei vaEinzel WettkArt auf waTlnStaffel pr�fen und ggf. auf waEinzel
  setzten (bei Serien kein waTlnStaffel erlaubt)

ImpFrm:
- Fehler bei Import in Serie: Staffelname wurde vom Veranstaltung.Ortindex �bernommen
  statt vom EinlVeranst.OrtIndx.


--------------------------------------------------------------------------------
27.10.2010: Released
--------------------------------------------------------------------------------


################################################################################
2011 - 1.0:
================================================================================

Anpassung an Delphi XE (2011):

Korrekturen f�r Delphi 2006 entfernt:
- AllgConst, etc.: DialogNeu entfernt, Korrektur f�r Delphi XE nicht mehr ben�tigt
- VistaFix: VistaAltFix, FileDialog-function entfernt
- TriaMain: D6OnHelpFix, HideAppFormTaskBarButton,CreateParams,WMSyscommand,WMActivate entfernt

DateiDlg:
- FileOpenDialog1,FileSaveDialog1 f�r Vista erg�nzt (Neu in Delphi XE (2011))
- OpenFileDialog, SaveFileDialog angepasst

AllgComp:
- IstLeer: Character.IsDigit statt "in ['0'..'9']"
- TTriaUpDown:
  - Click korrigiert, weil Position bei Delphi XE vorher nicht mehr aktualisiert wird
  - event ChangingEx statt CanChange benutzt, weil hier neuer Position verf�gbar ist
  - von TCustomUpDown statt TUpDown abgeleitet

AllgFunc:
- function Strg entfernt, ersetzt durch SysUtils.IntToStr
- function RemTrailBlank, RemTrailNr, RemLeadZero entfernt, weil nicht benutzt
- function AddLeadZero entfernt, daf�r DatumStr neu
- function AddLeadBlank entfernt, ersetzt durch Format('%'+IntToStr(L)+'s',[S])

TlnDlg:
- Kontexthilfe f�r Mannschaftsname wiederhergestellt

Mannschaftswertung mit Option Platzaddition erweitert
- AllgConst: TSortMode-neu:smMschPunkte, TWertungMode-neu:wgMschPktWrtg
             TMschWrtgMode = (wmZeit,wmPlatz)
- WettkDlg,WettkObj,TlnObj,TlnErg,MannsObj erg�nzt

KlassenDlg:
- bei ListeAendern TlnAkModified auch wenn MschAltklassen ge�ndert werden

AllgObj, ...: Strings als AnsiString statt ShortString gespeichert
- ReadStr, WriteStr von ShortString auf AnsiString umgestellt.
  UniString nicht verwendet, weil mit 2 Bytes/Char Datei unn�tig gro� wird
  Immer als Prozedur statt Bool-Funktion, mit Exception im Fehlerfall
  Stream.Read und Stream.Write durch ReadBuffer und WriteBuffer ersetzt, Prozeduren
  mit Exception im Fehlerfall.
  Alle Load- und Store-Procs entsprechend umgestellt, Exception abgefangen keine
  zus�tzliche Fehlermeldung.

--------------------------------------------------------------------------------
15.03.2011: Released
--------------------------------------------------------------------------------


################################################################################
2011 - 1.1:
================================================================================

TlnObj:
- in 2011-1.0 wurde �nderung in 10.1.8 nicht ber�cksichtigt:
  Umstellung von StaffelNamen und -Vornamen von Ortsspezifisch auf Allgemein.
  �nderung in Source 10.1.8 verloren gegangen.
  Fehler beim �ffnen von Dateiversionen 10.1.8. Speichern nicht m�glich.

--------------------------------------------------------------------------------
20.03.2011: Released
--------------------------------------------------------------------------------


################################################################################
2011 - 1.2:
================================================================================


Einf�hrung Mannschaftswertung f�r DTU Schultour:
  1. Platz = 4 Punkte
  2. Platz = 3 Punkte
  3. Platz = 2 Punkte
  ab 4. Platz = 1 Punkt
--------------------------------------------------------------------------------

AllgConst:
- TMschWrtgMode = (wmTlnZeit,wmTlnPlatz,wmSchultour) statt (wmZeit,wmPlatz)
- smMschTlnZeit,smMschTlnPlatz,smMschSchultour statt smMschEndZeit,smMschPunkte

LstFmt:
- �berschriften:
  - Startliste Schulklassen statt Startliste Mannschaften
  - Klassenwertung statt Mannschaftswertung
  - Ak statt Klasse

MannsObj:
- SortString erweitert mit smMschSchultour
- EinzelWkWertung erweitert mit DTUSchultourPunkte f�r wmSchultour
- SortmodeValid: TlnListe: bei Schultour alle Tln gewertet

AnsFrm:
- anMschErgKompakt nicht bei wmSchultour
- smString: Text bei Msch-Ansichten anpassen an Spalten�berschrift

CmdProc:
- ErgLstCompact bei Schultour disabeln

AusgDlg:
- bei AlleListenGleich auch Schultour ber�cksichtigen (f�r Wettk auf neue Seite)

WettkDlg:
- MschWrtgMode wmSchultour erg�nzen
- WettkArtAlt eingef�hrt um auf letzter WkArt zur�ckzuschalten statt auf WkAktuell

WettkObj:
- wmSchultour als MschWrtMode erg�nzt

History, InfoDlg:
- cnReleaseJahr neu f�r InfoDlg, unabh�ngig von cnVersionsJahr

TlnDlg:
- Fehler in TlnGeaendert:
  Default in StrToIntDef(StartgeldEdit.Text,0) und StrToIntDef(SnrEdit.Text,0)
  von -1 in 0 ge�ndert. Sonst Result immer true wenn keine Snr vergeben.
- VereinLabel an Wettk.MschWrtgMode angepasst

RaveUnit:
- Param.MschSpalte statt 'Mannschaft' f�r alle Msch-Listen (wie bisher Tln-Listen)
  Param f�r jeden Wettkampf einzeln setzen
- Spalten�berschrift Klasse durch Ak ersetzt

VeranObj:
- TlnMschSpalteUeberschrift erg�nzt mit 'Schulklasse' f�r Tln-Ansicht
- MschSpalteUeberschrift neu mit 'Mannschaft' oder 'Schulklasse' f�r Msch-Ansicht

SerienDr:
- Spalten�berschrift MschSpalte abh�ngig vom Wettkampf setzen

TlnErg:
- BerechneTagesRang: MschPktWrtg mit wmSchultour erg�nzt

--------------------------------------------------------------------------------
21.12.2011: Source als 1.2 gespeichert
--------------------------------------------------------------------------------


################################################################################
2011 - 1.3:
================================================================================

RaveUnit:
- Druckdatum als zus�tzlicher parameter (Datum - Uhrzeit)
- Druckdatum am Ende jeder Seite/Liste erg�nzt f�r alle Listenarten

--------------------------------------------------------------------------------
8.1.2012: Source als 1.3 gespeichert
--------------------------------------------------------------------------------


################################################################################
2011 - 1.4:
================================================================================

TlnObj:
- GetMschWrtg wieder eingef�hrt, siehe mail Sube

SerWrtgDlg:
- neuer Parameter AkJahr f�r Altersklassenberechnung (bisher fest Wettk.OrtJahr(0))
  gleich f�r Tln und Msch, nur auf Tln-Tab �nderbar

WettkObj:
- TlnAkModified durch KlasenModified ersetzt
- in SetKlassenModified auch MannschModified und ErgModified f�r alle Orte gesetzt
- in SetMannschModified auch ErgModified f�r alle Orte
- neu: FSerWrtgJahr mit Get- und Set-Funktionen

SerienDr:
- SerienDruckTlnTagesWertung,SerienDruckTlnSerienWertung:
  alle Wertungen immer mitgeben: WertgRng (1.Spalte),GesRng,SexRng,AkRng,SondKlRng
  und zus�tzlich Vorname und Nachname;

ErsetzDlg:
- in TextErsetzen TriDatei.Modified := true gesetzt;  (Fehlerkorrektur)

--------------------------------------------------------------------------------
3.2.2012: Source als 1.4 gespeichert
--------------------------------------------------------------------------------


################################################################################
2011 - 2.0:
================================================================================

TlnObj,ImpFrm:
-  function AlleMschNamenErsetzenErlaubt und AlleMschNamenErsetzen eingef�hrt

SuchenDlg:
- neu, ersetzt SuchDlg und ErsetzDlg: Suchfunktion �berarbeitet

LstFrm, ...
- StopPaint in GridInit unver�ndert, generell �berarbeitet
- HauptFenster.FocusedTln �berarbeitet, war nicht immer gleich mit ItemIndex

TTlnDialog:
- UpdateMschWrtg MschWrtgCB immer gesetzt wenn vorher disabled war

AllgObj:
- in TriaSortColl-functions �berall auf FSortItems<>nil �berpr�fen, weil
  Abbruch in TTriaSortColl.GetSortCount (FSortItems=nil) aufgetreten beim
  Wechsel der Tria-Datei

--------------------------------------------------------------------------------
16.03.2012: Released
--------------------------------------------------------------------------------


################################################################################
2011 - 2.1:
================================================================================

AllgConst, LstFmt, VstOrtDlg, RaveUnit:
- Anzahl Veranstaltungsorte von 8 auf 20 erweitert. Listen in Querformat
- seSerPktMax erweitert
- Ansicht anTlnErgSerie spAk durch spAkRngSer ersetzt (Ak + AkRng)

LstFrm:
- StandardColBreite angepasst: Serpunkte: 6-stellig

SGrpDlg:
- ErgModified nur f�r aktueller Ort setzen

TlnObj:
- SetWettkErgModified immer nur f�r akt. Ortindex

TlnDlg:
- ControlAktuell := ActiveControl; gesetzt in SetPage, EingabeOk, InitDat, damit bei
  TlnNext, tec. den Focus auch beim 1. Mal erhalten bleibt. EingabeEnter reicht nicht

WettkObj:
- FSerErgModified neu
- GetSerWrtgJahr entfernt, Wert immer FSerWrtgJahr
- SetOrtMschWrtgMode: Korrektur f�r Schultour: SetMannschModified(true) weil impact auf MschEinlesen
- SetWettkAllgDaten mit SerWrtgJahr erweitert

SerWrtgDlg:
- SetAkJahr: Akt. Jahr in Liste aufnehmen, falls ausserhalb der Wettk.Ortjahre,
  weil dies durch sp�tere Wettk-Datum�nderung m�glich ist

WettkDlg:
- WettkAendern: zuerst alle Optionen abfragen und bei Abbruch nichts �ndern
- WettkAendern: bei Datum-�nderung pr�fen ob SerWrtgJahr im Bereich bleibt. Wenn
  nicht ggf. �ndern.

CmndProc:
- TeilnehmerMenueCommands: TlnEinteilenAction nur enabeln wenn SGrp'en vorhanden

DatExp:
- in ExportDateiHeader (HTML, EXCEL, Text) GetTitel3 entfernt, weil ExportReportType
  noch nicht bekannt (Wettk-abh�ngig)

SGrpDlg:
- EingabeOK: keine Meldung wenn Name der SGrp fehlt

AllgFunc:
- TryDecStrToInt: Bedingung erweitert mit (Value >= 0), nur pos. Werte zul�ssig

ZtEinlDlg:
- bei Live-Zeiterfassung Zugriffs-Fehler erst nach 3. Mal melden

--------------------------------------------------------------------------------
29.04.2012: Released
--------------------------------------------------------------------------------

Beliebiges Textformat f�r Zeiten einlesen
Arbeit abgebrochen, weil zu zeitaufwendig
Vielleicht sp�ter nachholen

--------------------------------------------------------------------------------
27.4.2012: vorab gespeichert 11.2.1a
--------------------------------------------------------------------------------

################################################################################
2011 - 2.2:
================================================================================

AllgFunc:
- function AddLeadZero,RemLeadZero wieder eingef�hrt, weil benutzt f�r TriaZeit

DateiDlg, VistaFix:
- function SetzeVistaFilter von DateiDlg nach VistaFix, weil auch f�r TriaZeit ben�tigt

RaveReports:
- Seitenangabe mit Gesamtzahl auch f�r Portrait erg�nzt:
  'Seite ' & Report.RelativePage & '/' & Report.TotalPages
  War nur f�r Landscape vorhanden

AusgDlg:
- Duplex-Einstellung wurde vorher nicht �bernommen, immer Simplex
  Deshalb in ReportDrucken:  IgnoreFileSettings := false;
  ErstelleNDRDatei benutzt RpDev-Einstellungen, die in RpDev.PrinterSetupDialog
  gesetzt werden.
  Bei IgnoreFileSettings := true wurden RaveForm.RvRenderPrinter-Einstellungen
  benutzt, die nicht in Dialog angepasst werden.
- In RpDev.PrinterSetupDialog wird immer der Windows Defaultprinter selektiert.
  Deshalb neue Funktionen GetDefaultDrucker und SetDefaultDrucker um beim
  Dialog-Aufruf den DefaultPrinter an DruckerCB anzupassen. Danach DefaultPrinter
  wieder zur�cksetzen. RpDev.Device entspricht eingestellter Drucker.
  Copies und Collate werden nicht automatisch von Drucker-Einstellungen
  �bernommen, deshalb getrennt aus AusgDlg �bernehmen.
- Druckerbezogene Teile im Layout gemeinsam im oberen Bereich, der Optik wegen
- Vorschau-Button erg�nzt (rmDrcken,rmPrevDrucken,rmPDFDatei)
  ClearNDRDatei

TriaMain:
- Men�punkt Druckereinstellungen entfernt. Nur im AusgabeDlg/Drucken vorhanden
  Sonst �ber Windows (Ger�te und Drucker)

AnsFrm:
- Startliste Tln nur pro Wettkampf. Bei Ausdruck �ber alle Wettk wird kein Wettk
  gelistet und damit nicht sinnvoll.
- InitAnsichtListe: Ansicht nur wenn g�ltig in Liste aufnehmen, in Men� sonst
  disabeln. Bei WettkAlle nur wenn es f�r mindestens einen Wettk. eine g�ltige Liste gibt.
  Gilt f�r anMschStart, anMschErgDetail, anMschErgKompakt, anMschErgSerie, anTlnSchwDist.
  Wenn gew�hlte Ansicht f�r Wettk keine g�ltige Liste ist, wird g�ltiger Wettk
  gew�hlt.
- WettkampfCBChange:
  Ansichtliste an WkNeu anpassen. Wenn aktuelle Ansicht f�r gew�hlter Wettk. keine
  g�ltige Liste ist, wird g�ltige Ansicht gew�hlt. Dabei gibt es keine R�ckwirkung
  auf WettkListe, da Ansicht mit identischer WettkSortMode gew�hlt wird.
  Deshalb auch bei anTlnStart WettkAlle gestrichen.

CmdProc:
- AnsichtMenueCommands: Enabeln der Ansichten korrigiert.


--------------------------------------------------------------------------------
09.07.2012: Released
--------------------------------------------------------------------------------


################################################################################
2011 - 2.3:
================================================================================

TriaMain:
- CommandDataUpdate neu, benutzt in allen Commandfunktionen f�r AutoSpeichern und
  Sofortberechnen. Zus�tzlich jetzt auch LiveZeitErfRequest abgefragt
- UhrzeitTimerTick - Wenn CommandActive, f�r AutoSpeichern und LiveZtErf nur
  Request setzen, nicht durchf�hren.
  Disabeln von Commands streichen, da Konflikt w�hrend Commandausf�hrung (Cursor
  als Sanduhr, evtl. Blockade?)
  Annahme, dass Commands zwischen Abfrage CommandActive und Ausf�hrung nicht
  aktiviert werden k�nnen.

ZtEinlDlg:
- LiveZtErfDatEinlesen als Funktion, wird in CommandDataUpdate  abgefragt
- TZtEinlDialog.OkButtonClick: DisableButtons eingef�hrt
- TZEColl.Einlesen: auch bei WettkAlle getrennt nach Wettk runden um unn�tige
  Aufrundungen bei Zeitgleichheit zu vermeiden,
  Progressbarmax korrigieren

TlnObj:
- TlnColl.ZeitenRunden: nur einzeln pro Wettk (WettkAlle ung�ltig)

AllgFunc:
- EuroWert korrigiert, damit auch ganze Zahlen beim Import akzeptiert werden

AllgConst:
- bei Import TTriDateiFormat durch TImpDateiFormat ersetzt
- functions ImpExtFormat, ImpExtFilter erg�nzt f�r DateiImport (.csv f�r Textdateien erg�nzt)
- cnKopfeilenMax=10 erg�nzt

ImpDlg:
- ExcelSheetCB: Style von csDropDown in csDropDownList korrigiert: Eingabe f�hrte zu Fehler!
- ExcelSheetLaden: erste 10 Zeilen ignorieren, wenn nicht gen�gend Spalten
  Damit kann exportierte Datei unver�ndert importiert werden
- ImportiereDatei: TImpDateiFormat statt TTriDateiFormat (.csv f�r Textdateien erg�nzt)
- TextDateiLaden: bis zu cnKofzeilenMax (10) Kopfzeilen ignorieren, 10. oder
  letzte Zeile als Basis f�r Spaltenzahl und Trennzeichen nehmen
- ExcelSheetLaden: bis zu cnKofzeilenMax (10) Kopfzeilen ignorieren.
  Import von exportierte Datei ohne �nderung m�glich
- InitFeldValueListEditor: Pflichtfelder immer Datenfelder zuordnen, damit auf jedenfall
  Daten in Vorschau angezeigt werden.
- in Form: TrennZeichenGB in RadioGroup ge�ndert, weil sonst am
  Anfang immer SemiKolonRB selektiert wird, auch wenn vorher ein anderes
  Trennzeichen gesetzt wird. Setzen in FormShow-Event hilft nicht, Ursache nicht klar
  SonstEdit auf RadioGroup platziert
- Texterkennungszeichen erg�nzt. Erkannt wenn am Anfang und Ende eines Feldes.
  Doppelte Erkennungszeichen dazwischen werden als 1 Zeichen eingelesen.

SerienDr:
- SerienDruckTlnTagesWertung, SerienDruckTlnSerienWertung: Geschlecht erg�nzt


--------------------------------------------------------------------------------
04.11.2012: 2011-2.3 Released
--------------------------------------------------------------------------------


################################################################################
2011 - 3.0:
================================================================================

AllgConst:
- TListType ltErgLstTlnAbs1LAk, ltErgLstTlnAbs1LAkLnd,ltErgLstMschTlnRndL,
            ltErgLstTlnRndLAkLnd,ltErgLstTlnRndLAk erg�nzt f�r lange Ak-K�rzel
- TColType spMschMixWrtg erg�nzt, spCupWrtg in spSerWrtg umbenannt
- TSex mit cnMixed (Index=2) erweitert
- Sortmode smIncr,smDecr erg�nzt f�r Seriewertung - StreichErgebnisse
- Status: stSerGemeldet f�r Serienpunkte-Berechnung
          stAbs1UhrZeit..stAbs8UhrZeit, stEndUhrZeit f�r SetzeMschAbsZeit,
          unabh�ngig von Tln-StrtZeit, die erst sp�ter gesetzt werden
- TDefaultAkListe = (alDTU,alDLV) f�r KlassenDlg
- TSerPktMode = (spRngUpPkt,spRngUpEqPkt,spRngDwnPkt,spRngDwnEqPkt,spFlexPkt)
- TVeranstArt = (vaEinzel,vaCup,vaLiga) entfernt, durch Serie-Boolean ersetzt
- TImpOption = (ioTrue,ioFalse,ioFehler); bislang TSex f�r Options verwendet
- opMschMixWrtg, iiSuchListe, iiErsatzListe,
  SuchListe,ErsatzListe: Suchliste in Ini gespeichert

AllgFunc:
- TxtGleich, StrGleich:  SameTxt,SameStr statt Compare

AllgObj:
- TDatei.SetPath(const PathNeu:String); // Leerzeichen am Anfang+Ende vermeiden
- TIntSortCollection.Compare: smIncr,smDecr unterscheiden

AkObj:
- neu: AkMixed mit Sex=cnMixed f�r Mixed-MschWrtg und Tln-Staffel
- Default Klassen: DTU_M_AkListe, DTU_W_AkListe, DTU_M_SkListe, DTU_W_SkListe,
  DLV_M_AkListe, DLV_W_AkListe, DLV_M_SkListe, DLV_W_SkListe: TAkColl;

AnsFrm:
- procedure SetzeMschKlasseKompakt, abh�ngig vom Wettk g�ltige Werte f�r Sex und Klasse
- InitAnsichtListe abh�ngig von Sex und Klasse, wegen MschGr in anMschErgKompakt
- stSerGemeldet statt stGemeldet bei Serienwertung
- TAnsFrame.Create: DropDownCount generell auf 26, bis zur min. Unterkante vom
  Hauptfenster. AnsichtCB war zu kurz.
- Ansicht anAnmEinzel: smTlnName als erste und default-Sortierung, damit bei
  Neu-Anmeldung nach vorhandenen Tln-Namen gesucht werden kann
- KlasseListe mit AkMixed f�r Mannschaftsansicht erg�nzt
UpdateAkColBreite

AusgDlg:
- AkMixed f�r MschListen erg�nzt und TlnStaffel
- GleichesWkAkListenFormat: Format an MschErgKompakt abh�ngig von Klasse (MschGr)

ImpDlg:
- TImpOption statt TSex f�r Options verwenden
- neue Funktion GetSexOption, GetSexStr...  wegen cnMixed bei TlnStaffel
- neue Option f�r MschMixWrtg
- Startzeit bei Einzelstart importieren (procedure SetzeStrtZeit)
- TxtGleich benutzt um Leer- und Steuerzeichen am Anfang und Ende von
  Name, VName, Vere�n zu ignorieren
- Tln.Sex korrigiert: cnKeinSex akzeptieren
- Jg-Pr�fung korrigiert, nur einmal warnen wenn Jg = ''
- w�hrend Pr�fung VorschauGrid.Row/Row nicht updaten, weil sehr langsam und unruhig

KlassenDlg:
- SetWkDaten: KuerzelEdit.MaxLength bei 1 Abschn auf 6 erweitert f�r DLV-Klassen
- DTU und DLV Defaultlisten einstellbar
- AkMixed zus�tzlich zu AkAlle bei cnSexBeide

ListFmt:
- GetListType abh�ngig von MschGr in anMschErgKompakt und LangeAkKuerzel

LstFrm:
- StandardColBreite f�r Ak optional auf 6 Stellen erh�ht.
  Neue Funktionen AkColBreite und UpdateAkColBreite
- Init: InitAnsicht mit smTlnName statt smTlnErstellt wegen Tln-Suche bei Neu-Anmeldung
- neue Funktionen: UpdateMschTlnColBreite,
  AkColBreite, ZeitColBreite(C:TColType), MschTlnColBreite(MschGr:Integer)

MannsObj:
- GetPktSerStr: '-' (Decr) oder (xx)(Incr) wenn nicht gewertet
- in SetzeRng SerRngMax f�r Msch setzen
- f�r MschName TxtGleich statt SameText benutzen, Leerzeichen ignorieren
- BerechneSeriePunkte: StreichErg nach Punkte statt Rng sortiert streichen
- ReportSortieren: AkListe hier ber�cksichtigen
- MschWkWertung/EinzelWkWertung: Meldezahl Pr�fung f�r Liga entf�llt
- MschWertung: zus�tzlich f�r AkMixed
- MschEinlesen: untersch. MschGr f�r Alle, Mixed, M�nner, Frauen ber�cksichtigen
  Pr�fung Starterzahl f�r Liga entf�llt

RaveUnit:
- ltErgLstMschTlnRnd in RaveDesigner korrigiert: Runden waren nicht in DataView
- ltErgLstMschTlnRndL, ltErgLstTlnAbs1LAk,ltErgLstTlnAbs1LAkLnd,
  ltErgLstTlnRndLAkLnd,ltErgLstTlnRndLAk   erg�nzt f�r Lange Ak (DLV)
- RvNDRWriterPrint: Liste auch getrennt nach Ak sortieren, weil bei MschErgKompakt
  Format (MschGr��e) Klassenabh�ngig

SerienDr:
- TlnEtiketten: Geschlecht, Ak und AkK�rzel erg�nzt
- Tageswertung (Urk) AkK�rzel erg�nzt
- AkMixed erg�nzt

SerWrtgDlg:
- Pkt entsprechend und umgekehrt zur Platzierung
- StreichOrtUpDown.Min = 1 statt 0
- WrtgPktGB incl. Label grau wenn disabled

SuchenDlg:
- Option '�bereinstimmung am Wortanfang' hinzugef�gt und als default markiert

TlnObj:
- Load,Store: Option Mixed Msch vorsehen
- in Create smTlnName statt smTlnErstellt weil Anfangssortierung in AnsFrm
- GetPktSerStr: '-'(Decr) oder (xx)(Incr) wenn nicht gewertet

TlnDlg:
- TxtGleich benutzt um Leer- und Steuerzeichen am Anfang und Ende von
  Name, VName, Vere�n zu ignorieren
- WrtgGB f�r MschWrtg, MixMsch,SonWrtg,SerWrtg, statt Options-MschWrtgCB
- AllgemeinGB f�r UrkDruck
- neue Funktionen: SetMschWrtg, GetMschWrtg, UpdateMixWrtg
- neue Funktion: UpdateSex, nach WettkCB Change, TlnBuff.Wettk hier setzen
- EingabeChange: bei jeder �nderung von NameEdit wird erste Tln mit
  Namens-�bereinstimmung in Liste focussiert um erkennen zu k�nnen ob Tln bereits
  vorhanden ist
- Liste bei Neu-Anmeldung immer nach Name sortieren und 1. Tln fokussieren (auch
  bei n�chster Anmeldung)
- RestStreckeUpDown entfernt: Position muss kleiner 32767 (SmallInt) bleiben, sonst �berlauf-Fehler

TlnErg:
- BerechneTagesRang: cnDim2 auf 3 erh�ht f�r Sex=cnMixed bei wgMschPktWrtg
- if SerWrtg then MaxRng f�r Tln-Serienwertung setzen
- OrtZahlGestartet getrennt f�t Tln und Msch

TriaConfig:
- Lade-/SpeichereKonfiguration: SuchListe und Ersatzliste in Ini gespeichert

TriaMain:
- ClientWidth von 836 auf 861 erh�ht wegen breitere Klassennamem
- TlnHinzufuegenActionExecute: Ansicht und Sortmode f�r Anmeldung einstellen

VeranObj:
- FArt (TVeranstArt) durch FSerie (Boolean) ersetzt
- Load: AkKuerzelLaden(WettkAlleDummy) ersetzt durch 1. Wettk
  CupWrtgPktColl laden, default l�schen - f�r alte Dateien gel�scht, weil
  Fehler bei lauf.tri 2008-0.2 (am Ende von Tria-Datei)

VstOrtDlg:
- Cup und Liga durch Serie ersetzt
- Tabcontrol entfernt, Orte und Art zusammen

WettkDlg:
- AbschnZahlEditChange: Meldung wenn K�rzel langer als 3 sind
- WettkPageControl:  Wertungen an 2. Stelle statt Abschnitte
- MannschaftsGr��e einzeln f�r Alle,M�nner,Frauen,Mixed
- RundLaengeUpDown entfernt: Position muss kleiner 32767 (SmallInt) bleiben, sonst �berlauf-Fehler

WettkObj:
- neue Funktion LangeAkKuerzel zur Pr�fung bei AbschnZahlChange und AkColBreite
- WettkObj.TlnOrtSerPkt:
- statt FMannschGrWrtgColl: FMschGrAlle-,FMschGrMaenner-,FMschGrFrauen-,FMschGrMixedColl
- SerPktMode f�r Msch und Tln vorsehen
- RngMax Coll f�r alle Klassen Msch+Tln f�r Serienwertung

AllgComp:
- TTriaMaskEdit:

- TTriaUpDown:



--------------------------------------------------------------------------------
10.04.2013: 2011-3.0 Released
--------------------------------------------------------------------------------


################################################################################
2011 - 3.1:
================================================================================

SerienDr:
- Korrektur SerienDruckTlnTagesWertung, SerienDruckTlnSerienWertung:
  im Header nach AkKuerzel ';' erg�nzt

TriaMain:
- CreateMutex(nil, False, 'TriaMutexName'); eingef�hrt um beim n�chsten Update
  Setup abzubrechen wenn tria ausgef�hrt wird

--------------------------------------------------------------------------------
24.04.2013: 2011-3.1 Released
--------------------------------------------------------------------------------


################################################################################
2011 - 3.2:
================================================================================

SerienDr:
- Korrektur SerienDruckTlnTagesWertung, SerienDruckMschWertungDetail:
  f�r waRndRennen Rundenzahl eingef�gt

TlnObj:
- overload functionen von AbsEndZeit und EndZeit gestrichen
- functionen AbsRndEndZeit, RndEndZeit entfernt. Option f�r RndRennen in
  AbsEndZeit, EndZeit �bernommen
- overload functionen StoppZeit und AbsZeit vereinfacht

--------------------------------------------------------------------------------
11.06.2013: 2011-3.2 Released
--------------------------------------------------------------------------------


################################################################################
2011 - 3.3:  Stand 2013.12.16
================================================================================

................................................................................
FehlerKorrektur:
  In BahnenKontrolliste werden Startzeiten und Bahnen nicht auf getrennte Seiten
  gedruckt

AusgDlg:
- DatenUebernehmen: RepNewAkPage=false f�r anTlnSchwDist, d.h. NewPage bei
  jeder Titel3-�nderung. Bei BahnenKontrolliste f�r StartZeit- und Bahn�nderung
  statt f�r Ak benutzt

RaveUnit:
- RvNDRWriterPrint: AkBand.StartNewPage := true f�r anTlnSchwDist

................................................................................
FehlerKorrektur:
  Wenn man einen Teilnehmer anlegt ohne Geschlecht wird im Export korrekter weise
  keine Anrede gesetzt, es wird jedoch vergessen ein eintsprechendes Semikolon hinzuzuf�gen.

SerienDr:
- In SerienDruckTlnEtiketten ';' erg�nzt

--------------------------------------------------------------------------------
19.12.2013: 2011-3.3 vorab gespeichert
--------------------------------------------------------------------------------
Fehlerkorrektur:
  Wenn von einer leere Liste im Klassendialog zu einer anderen Klasse gewechselt
  wurde, wurde immer geffragt ob �nderunge gespeicher werden sollte, auch wenn
  nichts ge�ndert wurde.

KlassenDlg:
- TKlassenDialog.ListeGeAendert korrigiert. Bei NeuEingabe wurde immer Status
  ge�ndert zur�ckgegeben, auch wenn die Liste leer war
................................................................................

--------------------------------------------------------------------------------
21.01.2014: 2011-4.0 Released
--------------------------------------------------------------------------------


################################################################################
2011 - 4.1:  Stand 2015.02.10
================================================================================

Von XE auf XE2 umgestellt

RaveReport in FastReport konvertiert. Nicht weiter umgestellt.

AnsFrm:
- Left-Position �berschrift 'Status' in Ansichtleiste korrigiert

TlnObj:
- Bezeichnungen der Funktion entsprechend deutlicher formuliert

--------------------------------------------------------------------------------
17.01.2015: 114.0.a Source gespeichert
--------------------------------------------------------------------------------

SuchDlg:
- BorderStyle bsSingle statt bsDialog, Fenster kann stehen bleiben
- Create in TriaMain.Create, sonst problem in Config
- Alle Dlg-Parameter in Ini speichern

TriaMain:
- Shortcut f�r Teilnehmer entfernen von Entf in Ctrl+Entf ge�ndert
  Damit kein konflikt mehr mit Entf-Taste in SuchenDialog
- ProgressBarMaxUpdate korrigiert DIV durch 0 bei leere Liste verhindert
- neues Men�ueCommand: Tln disqualifizieren

TlnDlg:
- TAB in TlnPageBuf festhalten und beim n�chsten Aufruf voreinstellen
- Startgeld aus Wettk voreinstellen
- Reststrecke f�r Stundenrennen
- FehlerKorrektur: bei EingabeChange-WettkCB SnrBelegtArr nicht �ndern, sondern
  erst bei endg�ltiger �nderung in TlnAendern
- L�schLabel.caption erg�nzt
- JgEdit: in NavKeyDown mit VK_UP,VK_DOWN FUpDown.Click simulieren
- SnrEdit: in NavKeyDown mit VK_UP,VK_DOWN SnrGrid simulieren
- neue Funktion: Tln Disqualifizieren
- UpdateZeiten: Immer nur eine LeerZeile f�r Eingabe weitere Rundenzeit
- UpdateDisqGrund: default von Wettk �bernehmen
- Loesch1Label1.Caption angepasst
- SetPage: immer Name fokussieren, wenn noch nicht eingetragen
- NavKeyDown: f�r JgEdit VK_UP/DOWN verwenden

AllgConst,AnsFrm,WettkObj,WettkDlg,..
- neue WettkArt: waStndRennen, neue Spalte: spRestStrecke

WettkObj:
- neu: FRundLaengeColl mit zus. Funktionen f�r Stundenrennen
- neu: FMaxRundenModified, neu berechnen in TlnErg
- OrtCollAdd:
  - Korrektur TlnImZielColl[tmMsch].Add - Absturz wenn Ort in bestehende Datei erg�nzt wurde
  - Korrektur Datum gleich an 1. Ort (Self<>FCollection[0]) statt GetIndx, weil immer -1
  - FAbschnZahlColl.Add(1) statt 3
- GetSerWrtgJahr: GetOrtJahr(0) (Datum im 1. Ort) wenn FSerWrtgJahr noch nicht gesetzt in SerWrtgDlg

WettkDlg:
- neue WettkArt: waStndRennen
- TAB Abschnitte in Abschn./Runden ge�ndert
- neues Feld f�r RundLaenge auf TAB Abschn./Runden
- WettkArtAlt gel�scht, im Fehlerfall immer waEinzel weil da alle Einstellungen m�glich
- neues Feld f�r Startgeld
- WettkArtAlt eingef�hrt: bei Fehler wird nicht immer zu waEinzel sondern zur letzten Art gewechselt
- Teilnehmer: neues feld f�r DisqTxt, Vorgabe f�r teilnehmer-DisqualifiKation
- SEtWettkDaten: InitWettkAbschnGB nach WettkArt
- SetMschWrtg: MschWrtgModeGB.Enabled: MschWertgRG.ItemIndex <= 0 statt mwKein sonst waTlnStaffel nicht ber�cksichtigt
- WettkAendern: immer SerWrtgJahrUebernehmen wenn WkAktuell.SerWrtgJahr = 0, damit beim 1.Wettk gesetzt
- AbschnZahlEditChange: Text �ndern geht hier nicht, weil UpDown-Position nicht mit ge�ndert wird.

AllgComp:
- TTriaMaskEdit.Change:  Fehler in Felder mit Dezimalen
  - if CType = mcLiteral then //Inc(TextIndx) entfernt
  - SelStart := Min(i,Length(EditText)) EditText statt Text + 1
  - bei �nderung durch FUpDown-Click, wird Position erst sp�ter gesetzt, deshalb
    bei TextAlt nicht auf Position pr�fen
  - UpDown-Limits pr�fen und Text ggf. korrigieren
- TTriaMaskEdit.KeyDown: mit VK_UP,VK_DOWN FUpDown.Click simulieren
- TTriaLookupEdit.Click: Self.Hide statt (Edit)Hide - Fehler erst mit XE2 bemerkbar
- TTriaLookupEdit.KeyDown:
  - VK_UP,DOWN nur auswerten wenn Liste.Count>0, nicht Items.Count>0
  - wenn TextEdit='', bei VK_UP,DOWN ganze Liste zeigen
  - Liste nur zeigen wenn Items.Count > 0
- TZeitEdit.EditMask anpassen mit '\'
  IstLeer erg�nzt f�r Maskzeichen '\' vor ':', damit unabh�ngig von L�ndereinstellungen

TlnObj:
- neu FRestStreckeColl f�r Stundenrennen

ImpFrm:
- Korrektur: auch importierte SGrp-Zeiten werden gerundet, nicht nur Tln-Zeiten

TlnErg:
- BerechneTagesRang korrigiert f�r RndRennen: Ergebnis:Int64, RundenZahl ber�cksichtigen,
  bislang bei zeitgleicheit gleicher Rng bei unterschiedlicher rundenzahl
- MaxRundenModified f�r UpdateRundenZahl benutzen statt WettkErgModified
- SetzeErstZeitMsch korrigiert f�r MschStaffel (MschGroesse statt AbschnZahl)

DatExp:
- ExcelRangePar: Korrektur: Absturz bei 52,78,.. Spalten wegen falsche Spaltenbezeichnung '@' statt 'Z'
- ExcelDateiSchliessen: neue Funktion
- ExportDateiSpeichern: bei Exception alle Dateien schliessen
- spRestStrecke erg�nzt

ImpDlg:
- InitImpFeldArr: Par. MaxRnd erg�nzt um Spalten unabh�ngig von Wettk.AbschnZahl zu definieren
- InitFeldValueListEditor:
  - Init ImpFeldArr und Feld-Zuordnung nach Laden der Datei
  - Max RundenZahl nach einlesen der Datei berechnen anhand Spaltenzahl
- PruefeDaten: spRestStrecke erg�nzt

LstFmt:
- GetTitel3:
  - Abschn f�r JagdStartliste Staffel erg�nzt
  - RundenKontrolliste: Abschn nur bei mehr als 1 Abschn
  - Meldeliste in Vereinsansicht nur f�r Sammelmelder gemeldete Tln listen

MannsObj:
- StndRennen erg�nzt
- SetzeMschAbsZeit: Korrektur f�r waMschStaffel>8: FTlnListe.SortCount ber�cksichtigen, sonst Exception

RaveRep:
- TriaRvCustomConnectionGetRow: bei anTlnRndKntrl Abschn. nur wenn > 1

SGrpObj:
- neue Funktiopn: TSGrpObj.ZeitenRunden

VstOrtDlg:
- SetButtons: NeuBtn immer disabeln w�hrend NeuEingabe
- EingabeOk: Blank in Name nicht OK: Trim(OrtNameEdit.Text) = ''
- FormCloseQuery: SetOrtName nach ClearItem, sonst Exception in VstGeAendert
- UebernehmButtonClick: bei NeuEingabe OrtNeu statt OrtLoeschen, damit weitere Orte
  mit Enter ohne Klick auf Neu-Button erzeugt werden k�nnen

EinteilenDlg:
- wenn HauptFenster.SortWettk=WettkAlle alle Wettk in WettkCB zur Auswahl, sonst
  nur SortWettk.
- �bersichtszahlen an tats�chlich ausgew�hlten Tln anpassen und nicht ganzen Wettk


--------------------------------------------------------------------------------
21.04.2015: 2015-4.1 Released
--------------------------------------------------------------------------------


################################################################################
2011 - 4.2:  Stand 2015.06.16
================================================================================

AllgObj:
- TIntSortCollection.Compare: smIncr,smDecr unterscheiden f�r Serienwertung-Streicherg.
  War bereits in 11.3.0 eingef�hrt, aber in 11.4.1 verschwunden

AllgConst:
- cnZeitStrUeberlauf ersetzt cnZeit192_00 bei Zeit-Str-Ausgabe,
  max 3 Zeichen f�r Stunden
  �berlauf nur m�glich bei Msch mit Zeitaddition (3.087:nn:nn.dd  1/100 sek).
  SerWrtg-Zeit-Str in Sek, deshalb kein �berlauf bei Zeitaddition
- TSerPktMode ersetzt durch TSerWrtgMode (swRngUpPkt,swRngUpEqPkt,swRngDwnPkt,swRngDwnEqPkt,swFlexPkt,swZeit),
  Zus�tzliche Wrtg durch Zeitaddition
- spPktSer in spSumSer und spMschPktSer in spMschSumSer ge�ndert: Anzeige Punkte oder Zeit

SerWrtgDlg:
- neu: Wertung durch Zeitaddition

MannschObj:
- FSeriePunkte(Integer) durch FSerSummeSort und FSerSumLst ersetzt. FSerSummeSort f�r
  Sortieren und Rng-Berechnung mit Max-Zeit wenn keine Zeit vorhanden ist. SerSumLst
  mit Zeit=0 wenn keine Zeit vorhanden ist ==> in Listen als Summe gezeigt
  Int64 um �berlauf der Summe bei swZeit zu vermeiden. Wert in 1/100, angezeigt an�bver in Sek
- FSerSumColl:  Summe pro Ort f�r Serienwertung in Klasse
- function GetOrtEndZeit neu f�r Summenberechnung
- function GetOrtSerSumStr mit Umwandlung Int64 => Integer und Sek
- function SerWrtgSortZahl statt SerPktSort mit Option swZeit
- BerechneSerieSumme statt BerechneSeriePunkte, erweitert mit swZeit
- Create:  Korrektur: DummTln: oaNoAdd, damit OrtAdd nicht 2x ausgef�hrt wird

TlnObj:
- wie MannschObj f�r swZeit erweitert

WettkObj:
- TlnOrtSerWertung: waStndRennen nur f�r Serie werten wenn SerWrtgMode <> swZeit

--------------------------------------------------------------------------------
05.07.2015: 2015-4.2 Released
--------------------------------------------------------------------------------


################################################################################
2011 - 5.0:  Stand 2016.02.21
================================================================================

................................................................................
Fehlerkorrektur: Fehlermeldung bei Excel-Import: Listenindex �berschreitet das max. 0
                 trat auf bei Wechsel von Tabellenseite

ImpDlg:
- ExcelDateiLaden:
  - wenn mehrere Sheets, dann bei Fehler in ExcelSheetLaden
    Dialog trotzdem ausf�hren, weil andere Sheets Ok sein k�nnen
- ExcelSheetLaden:
  - am Anfang und im Fehlerfall DatenArray l�schen
- ExcelSheetCBChange:
  - Exception in ExcelWorkSheet.ConnectTo abfangen
  - InitFeldValueListEditorund UpdateVorschau auch im Fehlerfall, damit Grid
    leer wird
- InitFeldValueListEditor:
  - FehlerKorrektur: FeldValueListEditor.Strings.Clear erg�nzt, gab Index-Fehler
    bei Tabellenblatt-Wechsel, weil Strings immer wieder hinzugef�gt wurden
  - f�r Length(DatenArray)=0 angepasst
- UpdateVorschau:
  - f�r Length(DatenArray)=0 angepasst
- PruefeDaten:
  - bei Abbruch durch Fehler keine weitere Fehlermeldung (Result = -1)


................................................................................
Fehlerkorrektur:
  Vereinsliste in TlnDlg / MannschNameColl wird bei Alle Tln l�schen nicht gel�scht.
  MannschColl wird nur bei MschEinlesen in TlnErg gel�scht, aber nicht wenn TlnColl.Count = 0.
  Leichen bleiben erhalten.

SMldOb:
- neu: TSMldColl.ClearIndex: damit Mannschname in MannschNameColl gel�scht wird
  (wenn nicht mehr vorhanden)
SMldFrm:
- zus�tzlicher Button AlleSMldLoeschen
- function SMldLoeschen mit Parameter: TSMldLoeschen = (smEinzel,smAlle)
MannsObj:
- TMannschNameColl.NameLoeschen: MannschColl ist abgeleitet von TlnColl,
  deshalb hier nicht ber�cksichtigen, nur TlnColl und SMldColl
  MannschName wurden nicht entfernt, weil im MannschColl noch vorhanden
- function MannschColl.MannschNameVorhanden entfernen
- Korrektur TagesRngMax, SerieRngMax: MannschInKlasse(Kl) statt ((FKlasse=Kl)or(Kl=AkAlle))
  falsches Ergebnis bei Kl=AkAlle
TlnErg:
- BerechneRangAlleWettk: auch wenn TlnColl.Count=0 berechnen, damit MannschColl gel�scht wird
- BerechneTagesRang: kwAltKl bei wgMschPktWrtg auch bei MschMixWrtg berechnen, damit
  Tln von Mixed Msch auch Ihre AltKl-Wertung ber�cksichtigt werden.
  AltKl-MschWertung nach Punkten wurde bei Tln mit MixWrtg falsch berechnet
TlnObj:
- KlassenSetzen: FMschWertgKlasseArr[kwAltKl] unabh�ngig von FMschMixWrtg setzen

VeranObj:
- LoadKorrektur erweitert um Leichen in MannschNameColl zu l�schen

................................................................................
UrkundeDlg: neu f�r Drucken von Urkunde mit Word
            in alle Ansichten, auch ohne Zeitnahme
            Einzeln oder Liste
SerDrDlg ersetzt SerienDr
- Urk-Druck nur f�r HauptFenster.SortWettk und HauptFenster.SortKlasse
- restliche Funktionen anders aufgeteilt
- Seriendruck-Datei f�r MschWrtg-Detail und -Kompakt identisch
- seriendruck Urk auch f�r Startlisten

AusgDlg:
- Seriendruck Etiketten und Urkunden entfernt, in SerDrDlg behandeln
- DruckerCB durch DruckerEdit ersetzt. Drucker-Auswahl nur in DruckEinstellungen-Dialog,
  weil sonst doppelte Wahlm�glichkeit.
  Keine L�sung um Druckereigenschaften direkt aufzurufen, nur in DruckEinstellungen-Dialog.
- PgBisInitTxt Parameter speichert Wert f�r Druckbereich bei PreviewDruck.
  Bleibt bei Wechsel nach Alle Seiten erhalten, wurde vorher auf 1 gesetzt
- function  GetDefaultDrucker entfernt, weil Ergebnis bei HP nicht immer RpDev.Device
  entsprach (zus�tzlicher Text in Name). Statt dessen RpDev.ItemIndex vor�bergehend
  auf -1 gesetzt (Setzt DefaultDrucker)

ImpDlg:
- GetFeldNameLang/Kurz: spWettk erg�nzt f�r Export Meldeliste

DatExp:
- ExportDateiSpeichern: f�r ltMldLstTlnExp spWettk am Anfang eingef�gt

LstFmt:
- GetTitel2 bei SerienErgebnisse Wettk.Name verwenden, weil Ortsunabh�ngig

................................................................................
UpdateDlg:
- Fehlerkorrektur: LHandler: TIdSSLIOHandlerSocketOpenSSL erg�nzt, sonst
  Exception in IdHTTP.Get - seit Umstellung von www.selten.de auf SSL / HTTPS

................................................................................
TriaMain,LstFrm:
- KontextMenue mit rechte Maustaste f�r Tln-Funktionen


--------------------------------------------------------------------------------
22.02.2016: 11.5.0 Released
--------------------------------------------------------------------------------


################################################################################

UrkundeDlg:
- Fehlerkorrektur UrkDateiBtnClick:
  UpdateDokCB(Trim(DokName)) einf�gen, damit DokNeu in Liste aufgenommen wird

--------------------------------------------------------------------------------
23.02.2016: 11.5.1 Released
================================================================================


################################################################################
11.5.2:  Stand 08.04.2016
################################################################################

InnoSetup Version 5.5.8 (vorher 5.5.5)

SerDrDlg: aus project entfernt - AusgDlg f�r SerienDr benutzt, TxtDatei und WordUrk
SerienDr: hinzugef�gt

RaveReports:
- Alle Reports Odd Rectangle Color von ECECEC nach F4F4F4 ge�ndert: etwas heller

CmdProc,AusgDlg:
- Seriendruck Msch auch f�r MschStartliste

UrkundeDlg:
- procedure WordUrkunde(Mode:TReportMode) f�r Einzel und Liste
- UrkTab durch Panel ersetzt: rmWordUrk: nur Einzel-Urk mit KlasseCB rmSerDrUrk: Liste von AusgDlg
- KlasseCB auch f�r Msch: alle Klassen mit gleicher MschName und Wettk
- WordUrkAnzeigen entfernt, grunds�tzlich Drucken als default, wenn HauptDok gew�hlt
- nach PrintOut profilaktisch 1 Sek Pause, damit Quit nicht zu fr�h kommt.
  Sollte nicht n�tig sein, schadet aber auch nicht.
- Datenliste entfernt: direkt schreiben (SchreibeZeile)

AusgDlg:
- rmSerDrEtiketten,rmSerDrUrk erg�nzen  : ExportDatFormat := ftText;
- rmSerDrUrk erg�nzen f�r Seriendruck Urkunden
- SerienDrGB f�r Seriendruck Textdatei oder Word Urkunden
- Seriendruck Etiketten mit Abfrage f�r Anzeigen

SerDrDlg:
- ZeileTlnWertung erweitert: 205 Zeichen - nicht f�r Staffel
    GesRng, Akkurz, SexKl,SexRng,SondKl,SkRng

TTlnObj:
- TReportTlnList.Add in alle Ansichten sortieren wegen Seriendruck

MannschObj:
- funktionen OrtMschAnzahl, TlnZahlMax enfernt
- MschAnzahl: immer f�r stGemeldet berechnen
- MschTlnListeSortieren:
  - Korrektur f�r f�r mwMulti: (FMannschPtr.FMschIndex < IndxMax) // sonst Tln doppel
  - IndxMax := Mindestens 1, damit unvollst�ndige Msch ber�cksichtigt werden

DatExp:
- ExportDateiSpeichern: ExportDateiName hier erstellen, statt in AusgDlg

TriaMain:
- StatusBarUpdate f�r Msch korrigiert:
    Panel[0]: aktuelle Liste, bei mwMulti alle Indx mitz�hlen, evtl. g��er als Panel2
    Panel[1]: grunds�tzlich nur 1x z�hlen (Indx=0, stGemeldet)
- Seriendruck �ber ListAusgabe (AusgDlg)

AllgConst:
- cnWebSite statt cnHomePage, ohne Protokoll (http://)

AllgComp:
- an Triazeit angepasst (Ziffernblock Tasten)

TriaConfig:
- WordUrkAnzeigen entfernt

UpdateDlg:
- PadFileLesen: exception in Get abfangen falls kein SSL

VeranObj:
- LoadKorrektur: doppelte Tln gefunden mit Gro�/Klein-Unterschied
  Pr�fung auf doppelte Tln erweitern von 2003 auf 2005:
  if (Jahr<'2005') or
     (Jahr='2005')and(Nr<'1.1') then // auch bis 2005-1.0 Gro�/Klein unterschieden
- TlnMschSpalteUeberschrift: 'Mannschaft' f�r TlnTeam und TlnStaffel

WettkDlg:
- WettkArtRG: waTlnTeam erg�nzen
- UpdateWettkAbschnGB: Abschn.Zahl als Parameter
- WettkArtRGClick: AbschnZahl korrigieren nach Best�tigung

TlnDlg:
- TlnPageControlChanging: TabGeaendert statt TlnGeaendert, FehlerCheck nur
  wenn Tab ge�ndert wurde.
- UpdateStaffelTln: TlnTeam erg�nzt
- UpdatePageControl: TSStaffel: Caption Team oder Staffel



################################################################################
11.5.3:  Stand 28.04.2016
################################################################################

ImpDlg:
- Fehler in InitImpFeldArr / StaffelNameGueltig korrigiert
  Spalten fehlen bei Import und Export Text / Excel

ZtLoeschenDlg:
- ZtErfLoeschen benutzt  TTlnObj.ErfZeitenLoeschen(Abs:TWkAbschnitt)

TlnObj:
- procedure   ErfZeitenLoeschen(Abs:TWkAbschnitt); neu

ZtEinlDlg,AllgConst,TriaConfig:
- Parameter ZeitenBehalten erg�nzt
- ZtErfDatEinlesen: zun�chst ZEColl speichern, sp�ter pr�fen und in ZECollOk/NOk

AllgObj:
- neu: TTriaObjColl.DeleteItems um nur Ptr zu l�schen

--------------------------------------------------------------------------------
03.05.2016: 11.5.3 Released
================================================================================


################################################################################
11.5.4:  Stand 17.06.2016
################################################################################

TlnDlg:
- Fehlermeldung bei Einteilung korrigiert:
  . UpdateSnr: SnrEdit.SetFocus entfernt, Focus bleibt unver�ndert
  . SetPage: ControlAktuell := ActiveControl entfernt, weil ActiveControl nil sein kann.
             Dies f�hrt zu Exception in ControlAktuell.CanFocus 

TriaConfig:
- LadeKonfiguration: ZeitenBehalten wurde nicht initialisiert:
  Korrektur: ZeitenBehalten := ReadBool(iiZtErf,iiZeitenBehalten,true);

ZtEinlDlg:
- ZeitenBehalten wurde als var doppel definiert, ist in AllgConst bereits definiert

--------------------------------------------------------------------------------
17.06.2016: 11.5.4 Released
================================================================================

################################################################################
11.5.5:  Stand 5.7.2016
################################################################################

UrkundeDialog:
- UrkDokErstellen: function FeldVorhanden ge�ndert, nur g�ltige Seriendruckfelder
  pr�fen, damit IF-Verkn�pfung im Hauptdokument nicht als Fehler bewertet wird
  z.B.: [ IF [ MERGEFIELD Geschl ] = "M�nnlich" "Herr" "Frau" ] => [,] ersetzen durch geschw.Klammer
- UpdateDruckenGB: UrkWordRB nur Disabled wenn ItemIndex=0, nicht bei -1
  (z.B. nach Text-�nderung in UrkDokCB)
- procedure WordUrkunde: Bei Word-Tln-Einzelurkunde Meldung und Exit, wenn Option
  'Urkunde drucken' nicht gesetzt ist.

SerienDr:
- ZeileTlnWertung, ZeileMschWertung: Feld Einh nach Result eingef�gt
- ZeileTlnWertung:
  - Tln-Felder nur eintragen wenn Wettk waTlnStaffel oder waTlnTeam Vorhanden
   (EinfachTlnMax > 0) und keine Serienansicht
  - Feld VstOrt nur f�r Serienveranstaltung
  - Rnd-Felder nur bei RndRennen und nicht in Serienansicht
- ZeileMschWertung:
  - SerDrMode sdText, sdWord als zus. Parameter
  - in serienansicht keine MschTln
  - In Ansicht Startliste nur TlnName eintragen (max 32), sonst zus�tzlich Result
    pro Tln. (max 16)
  - Einh und Runden f�r sdWord nur wenn MschTlnMax <= 8, sonst wird ResStr zu lang,
    f�r TextDatei (sdText) unbegrenzt
  - Feld VstOrt nur f�r Serienveranstaltung
  - Rnd-Felder nur bei RndRennen und nicht in Serienansicht
- MschTlnMaxBerechnen: splitten in:
    - MschTlnStart: max 32 Tln
    - MschTlnWrtg: max 16 Tln
- RndRennenSetzen: neue Proc. Rnd-Felder nur wenn ein waRndRennen in Vst vorhanden

TlnObj, MannsObj:
- funktionen GetTagSumEinh, GetSerieSumEinh erg�nzt f�r Seriendruck

MannsObj:
- MschEinlesen: AddMschToColl: bei mwMulti, MschIndex>0, TlnListe nur f�r Klasse
  �bernehmen (wie Msch0) und nicht alle Tln von MschTlnLst

--------------------------------------------------------------------------------
05.07.2016: 11.5.5 Released
================================================================================


################################################################################
11.5.5b:  Stand 03.04.2017
################################################################################

UpdateDlg:
- auf Homepage werden xml- und exe-dateien nicht mehr auf https umgeschaltet,
  weil Tria-Zugriff nicht funktioniert. Veraltetes protokoll wird nach
  1&1-Vertrags�nderung nicht mehr unterst�tzt.
  IdSSLOpenSSL nicht mehr benutzt, zur�ck nach altem Zustand.

UrkundeDlg:
- UrkDokCB: 1x Problem mit falschen Index gesehen beim Anklicken - Ursache unbekannt
  Items.Clear in Create erg�nzt. Nicht klar ob es hilft.

AllgConst:
- TSerDrMode=(sdText,sdWord) neu: in TextMode werden zus�tzliche Felder ausgegeben
- TListType: ltMldLstTlnSchirm ersetzt alle bisherigen Listen in MeldeAnsicht (Tln+SMld)
  Ansichtsfelder variabel, je nach Verwendung sichtbar
- TColType: spRfid neu f�r RfidCode
- iiRfidModus,iiRfidZeichen,iiRfidHex neu f�r Init-Datei
- Neue Rfid-Konstanten: cnRfidZeichenMin=2;cnRfidZeichenMax=24;cnRfidZeichenDefault=10;
  opDefaultRfidHex=true;
- Neue Variablen: RfidModus;RfidZeichen;RfidHex;

AllgFunc:
- TriaMessage wird mit CreateMessageDialog im Form zentriert und mit Form als
  zus�tzlicher Parameter.
  Kein Unterschied mehr f�r tria und TriaZeit
  File- und Printdialoge unver�ndert.
- neue Pr�f-Funktionen f�r RFID

ImpDlg:
- TextDateiLaden: Fehlermeldung bei Format-Fehler konkreter formuliert mit Zeilennummer
  und Zeilen-Inhalt. TAB als Pfeil nach rechts und nicht druckbare Zeichen
  (inkl. Blank) als MIDDLE DOT

ZtEinlDlg:
- Korrektur: Runde (f�r Report) war falsch gesetzt in TZEObj.Einlesen (SortIndex statt Index)
  dadurch wurden im Report �bernommene Zeit und Runde nicht eingetragen.
- f�r Format-Funktion Zeit in %7d, %8d statt %7u weil neg. Zeit (-1) m�glich
- DateiTypCB erg�nzt und DateiName nur DropDownList.
- zfSonstige erg�nzt mit flexible Formatdefinition
- Create Korrektur: HauptFenster.SortWettk selektieren statt WettkAlle
- ZtErfZeitTrenn neue Par. f�r Einlesen ZeitErfdatei

ZtLoeschDlg:
- Create Korrektur: HauptFenster.SortWettk selektieren statt WettkAlle

ZtEinlRep:
- Anpassung f�r RFID-Code

AusgDlg:
- ReportDrucken: Daten von RvNDRWriter �bernehmen, dort vorher alle Parameter setzen
- DatenUebernehmen: Daten ExemplareGB in ReportAnzahlKopien, ReportKopienSortieren
  �bernehmen. Diese werden bei RvNDRWrite benutzt
  Korrektur: bisher wurde immer nur 1 Kopie gedruckt

RaveUnit
- ErstelleNDRDatei: Copies und Collate vorher in RpDev setzen (ReportAnzahlKopien,
  ReportKopienSortieren). Wird nur beim Drucken verwendet
- ErstelleNDRDatei: nicht alle Seiten, sondern ReportSeiteVon-ReportSeiteBis

SerienDr:
- ZeileTlnWertung: Abs-zeiten und -Platzierung erg�nzt.
- neue Funktion AbsMaxBerechnen �ber alle wettk, damit gleiches Hauptdok f�r alle verwendet werden kann
- Einh. nur in Textdatei oder wenn AbsMax <= 4
- Adressinfo nur in Textdatei

ImpDlg:
- ExcelSheetLaden: Fehlerpr�fung verbessert, genauere Fehlermeldungen
- RfidCode erg�nzt

TriaConfig:
- LadeKonfiguration: Layout auf Hauptbildschirm angepasst
  Screen.WorkAreaHeight/Width (=Hauptbildschirm) durch Self.Monitor.WorkAreaRect.Height/Width
  (= BenutzerBildschirm) ersetzt
- SetBounds benutzt damit Align nur 1x aufgerufen wird
- Select prinnter nur bei exakter Namensgleichheit
- RfidCode erg�nzt
- #9 wird in Ini als 'TAB' gespeichert, weil sonst '' gelesen wird

TriaMain:
- f�r Multiscreen mit mehreren Monitoren angepasst
- poScreenCenter statt poDesktopCenter , wird bei mehreren Monitoren �ber alle zentriert

LstFmt:
- GetColType: ltMldLstTlnLnd,ltMldLstTlnSmlLnd: spSondWrtg war 2x vorhanden
- ltMldLstTlnSchirm ersetzt alle bisherigen Listen in MeldeAnsicht, Spalten variabel

TlnDlg:
- RFID-Code erg�nzt, Reiter Anmeldung angepasst
- SMldStrg in Create vereinfacht um Platz zu sparen
- function SnrFrei ersetzt durch TlnColl.TlnMitSnr, weil einfacher
- TlnAendern: HauptFenster.LstFrame.UpdateColWidths; // Cols spStartBahn anpassen

TlnObj:
- ab 11.5.5b RFID-Code erg�nzt und gespeichert (statt Dummy f�r MldZeit)
- neue function MeldeZeitBenutzt,StartgeldBenutzt,KommentBenutzt um Spalten in MeldeAnsicht zu steuern

MannsObj,TlnObj,SGrpObj,SMldObj:
- f�r Format-Funktion Zeit in %7d, %8d statt %7u weil neg. Zeit (-1) m�glich

SMldObj,TlnObj:
- SortString: ung�ltige RFID-Codes normal alphabetisch anzeigen

WettkObj:
- GetOrtTlnTxt korrigiert f�r AnmeldeAnsicht: FCollection=nil

OptDlg:
- Rfid erg�nzt

RfidEinlDlg:
- neues Modul um Datei mit Snr und Rfid-Codes zu importieren
- DateiBtn eingef�gt, statt vor Dialog-�ffnung Datei einlesen.
- DateiEdit grau statt weiss
- flexible Zeilenl�nge beim Einlesen
- abweichende Code-L�nge und ung�ltige Hex-Code nach Best�tigung akzeptieren.
- ZtErfMessage benutzen, TriaMessage nur wenn nicht LiveZtErfAktiviert

AusgDlg,InfoDlg,OptDlg,RfidEinlDlg,UrkundeDlg,VstOrtDlg,WkWahlDlg,ZtEinlDlg:
- CancelButton: Cancel false damit Dialog nicht mit Esc geschlossen wird


--------------------------------------------------------------------------------
02.05.2017: 11.5.6 Released
================================================================================


################################################################################
11.5.6a:  Stand 21.06.2017
################################################################################

AusgDlg:
- DruckerAktualisieren: neue Funktion um �nderungen in der Windows-Druckerliste
  zu ber�cksichtigen. Wird vor jedem Druckvorgang ausgef�hrt.

--------------------------------------------------------------------------------
22.06.2017: 11.5.6a f�r Prof. Winter
================================================================================


################################################################################
11.5.7:  Stand 04.04.2018
################################################################################

AllgComp:
- TTriaLookupGrid.UpdateItems: Gro�-/Kleinschreibung nicht unterscheiden beim �ffnen
  der Liste. Benutzt in TlnDlg f�r Verein/Ort
  property OnChangingEx erg�nzt
- TTriaMaskEdit.Change: unabh�ngig von TUpDown erlauben
  bei ung�ltiger FUpDown.Position Min oder Max setzen, nur wenn Edit enabled
- TTriaUpDown: procedure ChangingEx, var Aendernd entfernt, weil nicht benutzt.
- TTriaUpDown.Click: Korrekturen, weil der andere Button nach Klick manchmal verschwindet
  inherited Click(Button) vorab ausf�hren, Aendernd nicht benutzen, RecreateWnd erg�nzt
  Edit.SetFocus kann benutzt werden, weil kein ValidateError benutzt wird und deshalb
  kein Problem mit ESC-Taste auftritt
- TTriaMaskEdit: bei FUpDown-Benutzung EditMask mit 1 Ziffer (0) fest ('099;0; ';)

AllgConst (und weitere):
- spSammelMelder, spSMldName, spSMldVerein entfernt, weil nicht benutzt
- smRelAbs1-8UhrZeit statt smEndUhrZeit f�r MschWettk, Zeit relativ zur Startzeit
  f�r Tages�bergang
- stEndUhrzeit enfernt, stAbs1-8UhrZeit benutzt
- var DefaultDrucker, ReportDrucker neu

AusgDlg:
- DruckerAktualisieren: neue Funktion um �nderungen in der Windows-Druckerliste
  zu ber�cksichtigen. Wird bei jedem Druckaufruf (in Create) und bei Fehler (in EingabeOk) ausgef�hrt
  ReportDrucker, DefaultDrucker und Liste aktualisiert
- Drucker ausw�hlen in ComboBox statt Edit
- SortierCB Initwert = false statt true
- EingabeOk: RpDev.SelectPrinter pr�fen
- DatenUebernehmen: ReportDrucker �bernehmen := RpDev.Device , in EingabeOk gesetzt
- Taborder korrigiert
- PgVonUpDownClick und RngVonUpDownClick entfernt, wird durch ge�nderte TTriaUpDownClick ersetzt
- PgVonBisRBEnter, RngVonBisRBEnter erg�nzt
- DruckerBtn ersetzt SetupBtn: TPrintDialog und Printers benutzt statt RpDev.PrinterSetupDialog,
  weil Anzahl, Range sinnvoller als Papierformate (bei Rave nicht m�glich,
  RpDev.PrintDialog funktioniert nicht)

DatExp:
- ExcelStart: Meldung nicht gefunden und nicht gestartet unterschieden

ImpDlg:
- AufRndZeit durch AufrundZeit ersetzt: bezieht sich aufs Aufrunden und nicht auf Runden
- ImportiereDaten: TlnBuff.DisqName := '' statt TlnBuff.Wettk.DisqTxt;

ImpFrm:
- AufRndZeit durch AufrundZeit ersetzt: bezieht sich aufs Aufrunden und nicht auf Runden

KlassenDlg:
- VonUpDown.Min und BisUpDown.Min =1 statt =0, wegen ge�nderter TTriaUpDownClick
- VonEdit.Text, BisEdit.Text IntToStr statt Format 2-Stellig, weil einfachere Eingabe

LstFmt:
- GetListType/SpalteAusKonk korrigiert f�r Veranstaltung=nil
- GetColType: Wettk-Spalte nur bei WettkAlle

MannsObj:
- function Startzeit, GetAbsOrtStZeit entfernt, weil nicht ben�tigt
- procedure TMannschColl.SetzeMschAbsStZeit: in wkAbs1 kein stOhnePause (=EinzelStart)
  EinzelStart bei waMschTeam und waMschStaffel streichen: Startzeiten nicht immer eindeutig.
  Nur noch f�r EinzelWettk erlauben
- Korrektur in TMannschColl.SortModeValid: smMschAbs2Startzeit..smMschAbs2Startzeit
                            ersetzt durch: smMschAbs2Startzeit..smMschAbs8Startzeit
  Fehler f�r Jagdstart Msch f�r Abschn. 3 bis 8
- TMannschColl.Sortieren: f�r MschWettk
    smMschAbs2StartZeit..smMschAbs8StartZeit: und smMschErg,smMschErgMschName:
    FTlnSortMode := TSortMode(Integer(smRelAbs1UhrZeit)+WettkNeu.AbschnZahl-1) // letzter Abschnitt
    statt smEndUhrZeit. Zeit rel. zur StartZeit Abs1 f�r Tages�berlauf um Mitternacht
- TMannschColl.SetzeStaffelVorg: TSortMode(Integer(smRelAbs1UhrZeit)+WertungsWk.AbschnZahl-1)
    statt smEndUhrzeit. Zeit rel. zur StartZeit Abs1 f�r Tages�berlauf um Mitternacht
- TmannschColl.SetzeMschAbsStZeit: in wkAbs1 kein stOhnePause (=EinzelStart)
- TMannschColl.SetzeMschAbsZeit: rel. zur StartZeit Abs1 f�r Tages�berlauf um Mitternacht
    waMschTeam: TSortMode(Integer(smRelAbs1UhrZeit)+Integer(Abs)-1) statt smTlnAbs1UhrZeit
    waMschStaffel: TSortMode(Integer(smRelAbs1UhrZeit)+FWettk.AbschnZahl-1) statt smEndUhrZeit,
                   TStatus(Integer(stAbs1UhrZeit)+FWettk.AbschnZahl-1) statt stEndUhrZeit

SerienDr:
- SerDrDateiErstellen/WriteSerDrZeile: nur wenn UrkDruck gesetzt,
  keine Fehlermeldung wenn nicht gesetzt

SGrpDlg:
- Create, SGrpNeu: Neue SGrp.Init mit SnrVon=SnrBis=0
- SetSGrpDaten: bei neuer SGrp FreierSnrBereich einstellen
- SGrpGridDrawCell: 1. Zeile bei NeuEingabe: Text = ''
- Label f�r MschStaffel korrigiert
- SetWettkDaten: StartOhnePauseRB[wkAbs1].Visible := false bei waMschTeam oder waMschStaffel

SGrpObj:
- TSGrpObj.GetStartModus, Load: kein Einzelstart bei MschWettk
- WettkStartModus f�r WkAlle korrigiert
- InitValue: Result := true hat gefehlt

SMldFrm:
- HilfeButtonClick: HelpContext := 1500 statt 0701

SMldObj:
- TSMldTlnListe.SortString: smTlnStartgeld, smTlnSBhn erg�nzt

TlnDlg:
- AufRndZeit durch AufrundZeit ersetzt: bezieht sich aufs Aufrunden und nicht auf Runden
- TlnDisqualifizieren: DisqName unver�ndert
- UpdateDisqGrund: DisqNameEdit.Text := TlnBuffer.DisqName, ist nie ''
- InitTlnBuffer: LoadPtr := TlnBuffer statt Self; ==> Absturz bei TlnNeu
- ZeitnahmeTS1,2: Differenz durch Abschnitts- und zeit ersetzt.
- G�ltige AbsZeit nur wenn Runden vollst�ndig, ausgen. RundenWettk
- Proc. JgUpDownClick erg�nzt, TTriaUpDownClick nicht benutzen, JgUpDown.Edit := nil
- ReststreckeUpDown entfernt, wegen �berlauf 16 Bit
- NavKeyDown: VK_UP, VK_Down bei JgEdit hochrechnen auf 1900/2000

TlnErg:
- UpdateRundenZahl bei ErgModified statt MaxRundenModified

TlnObj:
- VereinsName entfernt, weil nicht benutzt
- AufRndZeit durch AufrundZeit ersetzt: bezieht sich aufs Aufrunden und nicht auf Runden
- TlnInOrtStatus: stAbs1UhrZeit..stAbs8UhrZeit: ohne Disq und auf >= 0 pr�fen statt >0
                  stEnduhrzeit ersetzt durch stAbs.x.Uhrzeit (letzter Abschnitt)
- InitStrtZeit: FLoadPtr benutzen f�r Berechnung im TlnDlg
- GetDisqName: Result='' nur wenn DisqGrund=''
- SetDisqName: nur von default abweichende Namen aufnehmen
- SetMschWrtg, SetMschMixWrtg: setze KlassenModified statt MschModified und KlassenSetzen
- GetMschWrtg: Result := FMschWrtg, unabh�ngig von �brigen Parameter, damit
  Default=true in TlnDialog angezeigt wird
- TTlnColl.ZeitenRunden: if ZeitNeuGerundet <> ZeitAltGerundet statt ZeitNeuGerundet > ZeitAltGerundet,
  Fehler, weil Tages�bergang nicht ber�cksichtigt wurde
- TTlnColl.SortString: smRelAbs1UhrZeit..smRelAbs8UhrZeit: neu, nur Msch.TlnListe
                       smEndUhrZeit: entfernt, ersetzt durch smRelAbs.x.UhrZeit (letzter Abschn.)

TriaConfig:
- ReportDrucker in Ini speichern, hier noch kein RpDev.SelectPrinter, erst bei Benutzung

ZtEinlRep:
- NOkGridDrawCell,SpeichernButtonClick: zeZeitEingelesen,zeRundenUeberlauf: Text verbessert

ZtLoeschDlg:
- HilfeButtonClick: // Kommentar korrigiert: Zeiten l�schen

TlnErg, WettkObj:
- MaxRundenModified wieder ersetzt durch WettkErgModified

TriaMain:
- Create: TriaMessage ohne Self, weil noch nicht verf�gbar

UrkundeDlg:
- DruckerCB, AnzahlEdit und DruckerBtn erg�nzt
- QuellDateiErstellen: SchreibeZeile nur wenn UrkDruck gesetzt

WettkDlg:
- RundLaengeUpDown entfernt wegen �berlauf 16 Bit

WettkObj:
- FMaxRundenModified entfernt, ErgModified benutzen
- Einzelstart nur f�r EinzelWettk

ZtEinlDlg:
- HelpContext f�r OkButten und HilfeBtn f�r LiveZtErf neu definiert.
  Text in Tria.txt korrigiert/erg�nzt.
  Neue Tria.chm erstellt.
- TZEColl.SortString: nach Zeit ab Tln.StrtZeit statt 00:00:00 sortieren,
  Damit wird Tages�bergang bei Zuordnung der Abschn. ber�cksichtigt

ZtEinlRep:
- Create: Text Abschnitt(e) korrigiert
- NOkGridDrawCell: Max. Anzahl Zeiten statt Rundenzahl �berschritten


--------------------------------------------------------------------------------
07.04.2018: 11.5.7 released
================================================================================


################################################################################
11.5.8:  Stand 10.04.2018
################################################################################

KlassenDlg:
- Create: Fehlerkorr. VonUpDown.Min, BisUpDownMin := 0 statt 1, wie in 11.5.6.
  F�hrte zum Fehler beider Definition von Klassen weil ! statt 0 im Leerzustand angezeigt wurde

MannsObj:
- Store f�r MannsNameObj/Coll wieder enabled. Waren versehentlich noch auskommenitiert.
  F�hrte zum Fehler beim Speichern der Datei

--------------------------------------------------------------------------------
10.04.2018: 11.5.8 released
================================================================================


################################################################################
11.5.8a:  Stand 15.04.2018
################################################################################

TlnObj:
- SetMannschName an SMldObj angleichen, keine Funktions�nderung
- TlnColl.SortString: zus�tzlicher SortMode: smTlnMschGroesse

SMldObj:
- Bezeichnungen MannschName an TlnObj angeglichen:
    Verein durch MannschName ersetzt
    MannschName durch MannschNamePtr ersetzt

MannsObj:
- neuer Proc: InitMschGrListe f�r Sortierung nach Mannschaftsgr��e

AlgConst:
- zus�tzlicher SortMode: smTlnMschGroesse und Spalte: spMschGroesse

--------------------------------------------------------------------------------
11.5.8b:  Stand 16.04.2018
--------------------------------------------------------------------------------

TlnObj:
- TTlnObj: FVereinPtr zus�tzlich, FmannschName in MannschNamePtr ge�ndert
  zus�tzlich auch GetVerein, SetVereinPtr, SetVerein

VeranObj:
- TVeranstObj.VereinColl zus�tzlich

TlnDlg:
- Verein und Mannschaft separat

KlassenDlg:
- WettkCBChange: Veranstaltung.WettkColl.SortIndexOf(WkAktuell) ersetzt durch
                 WettkCB.Items.IndexOf(WkAktuell.Name)
                 MUSS NOCH GETESTET WERDEN

}

end.