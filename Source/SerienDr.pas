unit SerienDr;

interface

uses
  Winapi.Windows, Winapi.Messages,System.SysUtils, System.Variants, System.Classes, System.Math,
  Vcl.Dialogs,ShellApi,Forms,
  AllgComp,AllgObj,AllgConst,AllgFunc,AkObj,WettkObj,TlnObj,MannsObj,
  AusgDlg;

function SerDrDateiErstellen: Boolean; // menue-commands: rmSerDrtiketten, rmSerDrUrk
function AbsMaxBerechnen: TWkAbschnitt;
function EinfachTlnMaxBerechnen: Integer;
function MschTlnWertgMaxBerechnen: Integer;
function MschTlnStartMaxBerechnen: Integer;
procedure RndRennenSetzen;
function ZeileTlnWertung(SerDrMode:TSerDrMode;Tln:TTlnObj;RepWk:TWettkObj;RepWrtg:TWertungMode;RepAk:TAkObj): String; overload;
function ZeileTlnWertung(SerDrMode:TSerDrMode;Tln:TTlnObj): String; overload;
function ZeileMschWertung(SerDrMode:TSerDrMode;Msch:TMannschObj) : String;

var
  AbsMax           : TWkAbschnitt;
  MschTlnWertgMax,
  MschTlnStartMax,
  EinfachTlnMax    : Integer; // f�r Header berechnen, nur >0 wenn TlnStaffel oder TlnTeam
  RndRennen        : Boolean;

implementation

uses TriaMain,VeranObj,SMldObj,DateiDlg,ListFmt;

function ZeileTlnEtiketten(Tln:TTlnObj)     : String;  forward;
function ZeileSMldEtiketten(SMld:TSMldObj)  : String;  forward;
procedure IncRslt(const Txt:String);                   forward;

var
  SerDrDatei : Text;
  ResStr     : String;

//******************************************************************************
function AbsMaxBerechnen: TWkAbschnitt;
//******************************************************************************
// AbsMax berechnen f�r Header, �ber alle Wettk
var i : Integer;
begin
  Result := wkAbs0;
  for i:=0 to Veranstaltung.WettkColl.Count-1 do
    if Veranstaltung.WettkColl[i].AbschnZahl > Integer(Result) then
      Result := TWkAbschnitt(Veranstaltung.WettkColl[i].AbschnZahl);
end;

//******************************************************************************
function EinfachTlnMaxBerechnen: Integer;
//******************************************************************************
// StaffelTlnMax und TeamTlnMax einmalig berechnen f�r Header, �ber alle Wettk
// max cnAbsZahlMax = 8 Tln, 0 wenn kein waTlnStaffel oder waTlnTeam vorhanden
var i,StaffelMax,TeamMax : Integer;
begin
  StaffelMax := 0;
  TeamMax    := 0;
  for i:=0 to Veranstaltung.WettkColl.Count-1 do
    if Veranstaltung.WettkColl[i].WettkArt = waTlnStaffel then
      StaffelMax := Max(StaffelMax,Veranstaltung.WettkColl[i].AbschnZahl)
    else
    if Veranstaltung.WettkColl[i].WettkArt = waTlnTeam then
      TeamMax := Max(TeamMax,Veranstaltung.WettkColl[i].MschGroesseMax);
  Result := Max(StaffelMax,TeamMax);
end;

//******************************************************************************
function MschTlnWertgMaxBerechnen: Integer;
//******************************************************************************
// MschTlnWertgMax einmalig berechnen f�r Header �ber alle Wettk und alle Klassen
// max=16=cnMschGrMax
var i : Integer;
begin
  Result := 0;
  for i:=0 to Veranstaltung.WettkColl.Count-1 do
    with Veranstaltung.WettkColl[i] do
      if MschWertg <> mwKein then
      begin
        Result := Max(Result,MschGroesse[cnSexBeide]);
        Result := Max(Result,MschGroesse[cnMaennlich]);
        Result := Max(Result,MschGroesse[cnWeiblich]);
        Result := Max(Result,MschGroesse[cnMixed]);
      end;
end;

//******************************************************************************
function MschTlnStartMaxBerechnen: Integer;
//******************************************************************************
// MschTlnStartMax einmalig berechnen f�r Header �ber alle Wettk und alle Klassen
// alle gemeldete Tln z�hlen, max=32=cnMschGrMaxStart, sonst Header zu lang
var i : Integer;
begin
  Result := 0;
  for i:=0 to Veranstaltung.MannschColl.Count-1 do
    if Veranstaltung.MannschColl[i].MschIndex=0 then
    begin
      Result := Max(Result,Veranstaltung.MannschColl[i].TlnListe.Count);
      if Result > cnMschGrMaxStart then
      begin
        Result := cnMschGrMaxStart;
        Exit;
      end;
    end;
end;

//******************************************************************************
procedure RndRennenSetzen;
//******************************************************************************
// RndRennen einmalig setzen f�r alle Wettk
var i : Integer;
begin
  RndRennen := false;
  for i:=0 to Veranstaltung.WettkColl.Count-1 do
    if Veranstaltung.WettkColl[i].WettkArt = waRndRennen then
    begin
      RndRennen := true;
      Exit;
    end;
end;

//******************************************************************************
function SerDrDateiErstellen: Boolean;
//******************************************************************************
// ReportMode vorher gesetzt:  rmSerDrEtiketten oder rmSerDrUrk
// rmSerDrtiketten: anAnmEinzel: alle gelisteten Tln (SortColl)
//                  anAnmSMld: alle SMld (SortColl)
// rmSerDrUrk: Tln/Msch nach ReportListe

var i,BarMax,WkNr : Integer;
    RepWk  : TReportWkObj;
    Titel : String;
    UrkTxtListe : TStringList;
    IOFehler : Boolean;

//..............................................................................
function WriteSerDrZeile(Txt:String): Boolean;
begin
  Result := false;
  if Txt <> '' then // '' wenn UrkDruck nicht gesetzt
  begin
    WriteLn(SerDrDatei,Txt);
    if IoResult<>0 then begin IOFehler := true; Exit; end;
  end;
  Result := true;
end;

//..............................................................................
begin
  Result := false;
  IOFehler := false;
  UrkTxtListe := TStringList.Create;
  Titel  := '';
  BarMax := 100;

  // SerienDruckDatei erstellen f�r alle Tln/Msch in Liste
  case ReportMode of
    rmSerDrUrk       : Titel := 'Seriendruckdatei f�r Urkunden erstellen';
    rmSerDrEtiketten : Titel := 'Seriendruckdatei f�r Etiketten erstellen';
    else ;
  end;

  ExportDateiName := System.SysUtils.ChangeFileExt(TriDatei.Path,'.txt');
  if not SaveFileDialog('txt',
                        'Textdatei (*.txt)|*.txt|Alle Dateien (*.*)|*.*',
                         System.SysUtils.ExtractFileDir(TriDatei.Path),
                         Titel,
                         ExportDateiName) then Exit; // ExportDateiName evtl. ge�ndert

  case ReportMode of
    rmSerDrEtiketten : if HauptFenster.Ansicht = anAnmSammel then
                         BarMax := Veranstaltung.SMldColl.SortCount
                       else
                         BarMax := Veranstaltung.TlnColl.SortCount;
    rmSerDrUrk       : if HauptFenster.TlnAnsicht then
                         BarMax := Veranstaltung.TlnColl.Count * 2
                       else
                         BarMax := Veranstaltung.MannschColl.Count * 2;
    else ;
  end;

  BarMax := BarMax + 4;
  HauptFenster.ProgressBarInit(Titel,BarMax); // 0

  if FileExists(ExportDateiName) and not DeleteFile(ExportDateiName) then
  begin
    TriaMessage('Die Seriendruckdatei  "'+ExtractFileName(ExportDateiName)+'"  '+
                'kann nicht erstellt werden,'+
                'weil eine Datei mit diesem Namen bereits vorhanden ist und nicht gel�scht werden kann.',
                mtInformation,[mbOk]);
    Exit;
  end;

  if HauptFenster.TlnAnsicht then
  begin
    AbsMax          := AbsMaxBerechnen;        // max 8
    MschTlnWertgMax := 0;
    MschTlnStartMax := 0;
    EinfachTlnMax   := EinfachTlnMaxBerechnen; // max 8 Tln
  end else
  begin
    AbsMax          := wkAbs0;
    MschTlnWertgMax := MschTlnWertgMaxBerechnen;  // Max 16 Tln
    MschTlnStartMax := MschTlnStartMaxBerechnen;  // Max 32 Tln
    EinfachTlnMax   := 0;
  end;
  RndRennenSetzen;

  HauptFenster.ProgressBarStep(1); // 1

  try

    {$I-}
    AssignFile(SerDrDatei,ExportDateiName);
    if IoResult<>0 then begin IOFehler := true; Exit; end;
    HauptFenster.ProgressBarStep(1); // 2

    Rewrite(SerDrDatei);
    if IoResult<>0 then begin IOFehler := true; Exit; end;
    HauptFenster.ProgressBarStep(1); // 3

    // restlichen Zeilen mit Tln/Msch-Daten
    if ReportMode = rmSerDrEtiketten then // Tln-/SMldSortColl benutzt
      case HauptFenster.Ansicht of
        anAnmEinzel :
        begin
          if not WriteSerDrZeile(ZeileTlnEtiketten(nil))then Exit; // Header
          HauptFenster.ProgressBarStep(1); // 4
          for i:=0 to Veranstaltung.TlnColl.SortCount-1 do
          begin
            if not WriteSerDrZeile(ZeileTlnEtiketten(Veranstaltung.TlnColl.SortItems[i])) then Exit;
            HauptFenster.ProgressBarStep(1);
          end;
        end;
        anAnmSammel :
        begin
          if not WriteSerDrZeile(ZeileSMldEtiketten(nil)) then Exit; // Header
          HauptFenster.ProgressBarStep(1); // 4
          for i:=0 to Veranstaltung.SMldColl.SortCount-1 do
          begin
            if not WriteSerDrZeile(ZeileSMldEtiketten(Veranstaltung.SMldColl.SortItems[i])) then Exit;
            HauptFenster.ProgressBarStep(1);
          end;
        end;
        else;
      end
    else // rmSerDrUrk
    begin
      // Header, nur Unterschied Tln/Msch sonst f�r alle Ansichten gleich
      if HauptFenster.TlnAnsicht  and not WriteSerDrZeile(ZeileTlnWertung(sdText,nil)) or
         HauptFenster.MschAnsicht and not WriteSerDrZeile(ZeileMschWertung(sdText,nil)) then
        Exit;
      HauptFenster.ProgressBarStep(1); // 4

      for WkNr:=0 to ReportWkListe.Count-1 do // Anfang bei WkNr=0
      begin
        RepWk := ReportWkListe[WkNr];
        // BarPos bleibt erhalten
        if WkNr>0 then HauptFenster.ProgressBarMaxUpdate(BarMax);
        if HauptFenster.TlnAnsicht then Veranstaltung.TlnColl.ReportSortieren(RepWk.Wettk,RepWk.Wrtg)
                                   else Veranstaltung.MannschColl.ReportSortieren(RepWk.Wettk);
        // BarPos bleibt erhalten (50%), Report immer von TlnColl erstellt
        HauptFenster.ProgressBarMaxUpdate(Veranstaltung.TlnColl.ReportCount*ReportWkListe.Count);

        // Statusbar steht auf halbe Position
        if HauptFenster.TlnAnsicht then
        begin
          for i:=0 to Veranstaltung.TlnColl.ReportCount-1 do
          with Veranstaltung.TlnColl.ReportItems[i] do
          begin
            if TlnPtr.UrkDruck then
              if not WriteSerDrZeile(ZeileTlnWertung(sdText,TlnPtr,ReportWk,ReportWrtg,ReportAk)) then Exit;
            HauptFenster.ProgressBarStep(1);
          end;
        end else // MschAnsicht
        begin
          for i:=0 to Veranstaltung.MannschColl.ReportCount-1 do
          begin
            if not WriteSerDrZeile(ZeileMschWertung(sdText,Veranstaltung.MannschColl.ReportItems[i].MschPtr)) then Exit;
            HauptFenster.ProgressBarStep(1);
          end;
        end;
      end;
    end;

    Result := true;

  finally
    UrkTxtListe.Free;
    CloseFile(SerDrDatei);
    IoResult; //L�schen Fehlerspeicher
    HauptFenster.StatusBarClear;
    {$I+}
    if not Result and IoFehler then
      TriaMessage('Die Seriendruckdatei  "'+ExtractFileName(ExportDateiName)+'"  '+
                  'kann nicht erstellt werden.',
                  mtInformation,[mbOk]);
  end;

end;

//==============================================================================
procedure IncRslt(const Txt:String);
//==============================================================================
begin
  ResStr := ResStr + TZ + Txt;
  if Txt='' then ResStr := ResStr + '-'; // keine leere Felder erlauben
end;

//==============================================================================
function ZeileTlnEtiketten(Tln:TTlnObj): String;
//==============================================================================
begin
  if Tln=nil then ResStr := 'Name'      else ResStr := Tln.VNameName;
  if Tln=nil then IncRslt('Vorname')    else IncRslt(Tln.VName);
  if Tln=nil then IncRslt('Nachname')   else IncRslt(Tln.Name);
  if Tln=nil then IncRslt('Wettkampf')  else IncRslt(Tln.Wettk.Name);
  if Tln=nil then IncRslt('Jahrgang')   else if Tln.Jg>0 then IncRslt(IntToStr(Tln.Jg))
                                                         else IncRslt('-');
  if Tln=nil then IncRslt('Geschl')     else case Tln.Sex of
                                               cnMaennlich : IncRslt('M�nnlich');
                                               cnWeiblich  : IncRslt('Weiblich');
                                               cnMixed     : IncRslt('Mixed');
                                               else          IncRslt('-');
                                             end;
  if Tln=nil then IncRslt('GeschlKurz') else case Tln.Sex of
                                               cnMaennlich : IncRslt('M');
                                               cnWeiblich  : IncRslt('W');
                                               cnMixed     : IncRslt('X');
                                               else          IncRslt('-');
                                             end;
  if Tln=nil then IncRslt('Ak')         else IncRslt(Tln.WertungsKlasse(kwAltKl,tmTln).Name);
  if Tln=nil then IncRslt('AkKurz')     else IncRslt(Tln.WertungsKlasse(kwAltKl,tmTln).Kuerzel);
  if Tln=nil then IncRslt(Veranstaltung.MschSpalteName(WettkAlleDummy))
                                        else IncRslt(Tln.MannschName);
  if Tln=nil then IncRslt('Snr')        else IncRslt(IntToStr(Tln.Snr));
  if Tln=nil then IncRslt('Land')       else IncRslt(Tln.Land);
  if Tln=nil then IncRslt('Kommentar')  else IncRslt(Tln.Komment);
  if Tln=nil then IncRslt('Startgeld')  else IncRslt(EuroStr(Tln.Startgeld));
  if Tln=nil then IncRslt('VerMld')     else if Tln.SMld=nil then IncRslt('-')
                                             else IncRslt(Tln.SMld.VName+' '+Tln.SMld.Name);
  if Tln=nil then IncRslt('Strasse')    else if Tln.SMld=nil then IncRslt(Tln.Strasse)
                                             else IncRslt(Tln.SMld.Strasse);
  if Tln=nil then IncRslt('Hausnr')     else if Tln.SMld=nil then IncRslt(Tln.Hausnr)
                                             else IncRslt(Tln.SMld.HausNr);
  if Tln=nil then IncRslt('PLZ')        else if Tln.SMld=nil then IncRslt(Tln.PLZ)
                                             else IncRslt(Tln.SMld.PLZ);
  if Tln=nil then IncRslt('Ort')        else if Tln.SMld=nil then IncRslt(Tln.Ort)
                                             else IncRslt(Tln.SMld.Ort);
  if Tln=nil then IncRslt('EMail')      else if Tln.SMld=nil then IncRslt(Tln.EMail)
                                             else IncRslt(Tln.SMld.EMail);

  Result := ResStr;
end;

//==============================================================================
function ZeileSMldEtiketten(SMld:TSMldObj): String;
//==============================================================================
begin
  if SMld=nil then ResStr := 'Vorname'   else ResStr := SMld.VName;
  if SMld=nil then IncRslt('Name')       else IncRslt(SMld.Name);
  if SMld=nil then IncRslt('Strasse')    else IncRslt(SMld.Strasse);
  if SMld=nil then IncRslt('Hausnr')     else IncRslt(SMld.HausNr);
  if SMld=nil then IncRslt('PLZ')        else IncRslt(SMld.PLZ);
  if SMld=nil then IncRslt('Ort')        else IncRslt(SMld.Ort);
  if SMld=nil then IncRslt('Mannschaft') else IncRslt(SMld.MannschName);
  if SMld=nil then IncRslt('EMail')      else IncRslt(SMld.EMail);

  Result := ResStr;
end;

//==============================================================================
function ZeileTlnWertung(SerDrMode:TSerDrMode;Tln:TTlnObj): String;
//==============================================================================
// Header f�r alle Wettk,Klassen gleich
begin
  Result := ZeileTlnWertung(SerDrMode,nil,HauptFenster.SortWettk,HauptFenster.SortWrtg,HauptFenster.SortKlasse);
end;

//==============================================================================
function ZeileTlnWertung(SerDrMode:TSerDrMode;Tln:TTlnObj;RepWk:TWettkObj;RepWrtg:TWertungMode;RepAk:TAkObj): String;
//==============================================================================
// keine Sonderzeichen (.,-) in Feldnamen, sonst wird Trennzeichen ';' von Word nicht automatisch erkannt
// Max 255 Zeichen f�r Header in CreateDataSource
var i : Integer;
    AbsCnt : TWkAbschnitt;

begin
  Result := '';
  if (Tln<>nil) and not Tln.UrkDruck then Exit; // Urkunde nicht drucken

  if Tln=nil then ResStr := 'Veranst'   else ResStr := Veranstaltung.Name;
  if Tln=nil then IncRslt('Wettk')      else IncRslt(GetTitel2(RepWk,RepWrtg));
  if Tln=nil then IncRslt('Wertg')      else
                                        if HauptFenster.Ansicht=anTlnErgSerie then
                                          IncRslt('Serienwertung')
                                        else
                                          IncRslt('Tageswertung');
  if Tln=nil then IncRslt('Datum')      else IncRslt(RepWk.Datum);
  if Veranstaltung.Serie then
    if Tln=nil then IncRslt('VstOrt')   else IncRslt(Veranstaltung.OrtName);
  if Tln=nil then IncRslt('Snr')        else
                                        if HauptFenster.Ansicht=anTlnErgSerie then
                                          IncRslt('-')
                                        else
                                          IncRslt(IntToStr(Tln.Snr));
  if Tln=nil then IncRslt('Name')       else IncRslt(Tln.VNameName); // auch bei Staffel
  if Tln=nil then IncRslt('VName')      else IncRslt(Tln.VName);
  if Tln=nil then IncRslt('NName')      else IncRslt(Tln.Name);

  if HauptFenster.Ansicht<>anTlnErgSerie then
    for i:=2 to EinfachTlnMax do // TlnTeam,TlnStaffel mindestens 2 Tln, max 8 Tln, sonst 0
      if Tln=nil then IncRslt('Tln'+IntToStr(i))
                 else
                 if (RepWk.WettkArt=waTlnStaffel) and (i <= RepWk.AbschnZahl) or
                    (RepWk.WettkArt=waTlnTeam) and (i <= RepWk.MschGroesse[RepAk.Sex]) then
                   IncRslt(Tln.StaffelVNameName(TWkAbschnitt(i)))
                 else IncRslt('-');

  if Tln=nil then IncRslt(Veranstaltung.MschSpalteName(WettkAlleDummy))
                                        else IncRslt(Tln.MannschName);
  if Tln=nil then IncRslt('Land')       else IncRslt(Tln.Land);
  if Tln=nil then IncRslt('Jg')         else if Tln.Jg>0 then IncRslt(IntToStr(Tln.Jg))
                                                         else IncRslt('-');
  if Tln=nil then IncRslt('Geschl')     else case Tln.Sex of
                                               cnMaennlich : IncRslt('M�nnlich');
                                               cnWeiblich  : IncRslt('Weiblich');
                                               cnMixed     : IncRslt('Mixed');
                                               else          IncRslt('-');
                                             end;
  if Tln=nil then IncRslt('Klasse')     else IncRslt(Tln.WertungsKlasse(RepAk.Wertung,tmTln).Name);
  if Tln=nil then IncRslt('Rng')        else
                                        if HauptFenster.Ansicht=anTlnErgSerie then
                                          IncRslt(Tln.GetSerieRangStr(RepAk.Wertung))
                                        else
                                          IncRslt(Tln.TagesEndRngStr(wkAbs0,RepAk.Wertung,RepWrtg));
  if Tln=nil then IncRslt('Ak')         else IncRslt(Tln.WertungsKlasse(kwAltKl,tmTln).Name);
  if Tln=nil then IncRslt('AkKurz')     else IncRslt(Tln.WertungsKlasse(kwAltKl,tmTln).Kuerzel);
  if Tln=nil then IncRslt('AkRng')      else
                                          if HauptFenster.Ansicht=anTlnErgSerie then
                                            IncRslt(Tln.GetSerieRangStr(kwAltKl))
                                          else
                                            IncRslt(Tln.TagesZwRngStr(wkAbs0,kwAltKl,RepWrtg));
  if Tln=nil then IncRslt('GesRng')     else
                                          if HauptFenster.Ansicht=anTlnErgSerie then
                                            IncRslt(Tln.GetSerieRangStr(kwAlle))
                                          else
                                            IncRslt(Tln.TagesZwRngStr(wkAbs0,kwAlle,RepWrtg));
  if Tln=nil then IncRslt('SexKl')      else IncRslt(Tln.WertungsKlasse(kwSex,tmTln).Name);
  if Tln=nil then IncRslt('SexRng')     else
                                          if HauptFenster.Ansicht=anTlnErgSerie then
                                            IncRslt(Tln.GetSerieRangStr(kwSex))
                                          else
                                            IncRslt(Tln.TagesZwRngStr(wkAbs0,kwSex,RepWrtg));
  if Tln=nil then IncRslt('SondKl')     else IncRslt(Tln.WertungsKlasse(kwSondKl,tmTln).Name);
  if Tln=nil then IncRslt('SkRng')      else
                                          if HauptFenster.Ansicht=anTlnErgSerie then
                                            IncRslt(Tln.GetSerieRangStr(kwSondKl))
                                          else
                                            IncRslt(Tln.TagesZwRngStr(wkAbs0,kwSondKl,RepWrtg));
  if (HauptFenster.Ansicht<>anTlnErgSerie) and (Integer(AbsMax) > 1) then
    for AbsCnt := wkAbs1 to AbsMax do
    begin
      if Tln=nil then IncRslt('Zt'+IntToStr(Integer(AbsCnt)))
                 else IncRslt(EffZeitStr(Tln.AbsZeit(AbsCnt)));
      if (SerDrMode = sdText) or (Integer(AbsMax) <= 4) then
        if Tln=nil then IncRslt('Eh'+IntToStr(Integer(AbsCnt)))
                   else IncRslt(ZeitEinhStr(Tln.AbsZeit(AbsCnt)));
      if Tln=nil then IncRslt('Rg'+IntToStr(Integer(AbsCnt)))
                 else IncRslt(Tln.TagesZwRngStr(AbsCnt,RepAk.Wertung,RepWrtg));
    end;

  if (HauptFenster.Ansicht<>anTlnErgSerie) and RndRennen then // Runden nur wenn mindestens 1 Wettk=waRndRennen
    if Tln=nil then IncRslt('Rnd')      else // header bei jeder Wettk f�r einheitliche Vorlage
                                          if RepWk.WettkArt = waRndRennen then
                                            IncRslt(IntToStr(Tln.RundenZahl(wkAbs1)))
                                          else IncRslt('-');
  if Tln=nil then IncRslt('Result')     else
                                        if HauptFenster.Ansicht=anTlnErgSerie then
                                          IncRslt(Tln.GetSerieSumStr(lmReport,RepAk.Wertung))
                                        else
                                          IncRslt(Tln.GetTagSumStr);
  if Tln=nil then IncRslt('Einh')       else
                                          if HauptFenster.Ansicht=anTlnErgSerie then
                                            IncRslt(Tln.GetSerieSumEinh(RepAk.Wertung))
                                          else
                                            IncRslt(Tln.GetTagSumEinh);
  if SerDrMode = sdText then
  begin
    if Tln=nil then IncRslt('Startg')     else IncRslt(EuroStr(Tln.Startgeld));
    if Tln=nil then IncRslt('VerMld')     else if Tln.SMld=nil then IncRslt('-')
                                               else IncRslt(Tln.SMld.VName+' '+Tln.SMld.Name);
    if Tln=nil then IncRslt('Strasse')    else if Tln.SMld=nil then IncRslt(Tln.Strasse)
                                               else IncRslt(Tln.SMld.Strasse);
    if Tln=nil then IncRslt('Hausnr')     else if Tln.SMld=nil then IncRslt(Tln.Hausnr)
                                               else IncRslt(Tln.SMld.HausNr);
    if Tln=nil then IncRslt('PLZ')        else if Tln.SMld=nil then IncRslt(Tln.PLZ)
                                               else IncRslt(Tln.SMld.PLZ);
    if Tln=nil then IncRslt('Ort')        else if Tln.SMld=nil then IncRslt(Tln.Ort)
                                               else IncRslt(Tln.SMld.Ort);
    if Tln=nil then IncRslt('EMail')      else if Tln.SMld=nil then IncRslt(Tln.EMail)
                                               else IncRslt(Tln.SMld.EMail);
  end;
  if Tln=nil then IncRslt('Komm')         else IncRslt(Tln.Komment);

  Result := ResStr;
  //if Tln=nil then ShowMessage(IntToStr(Length(ResStr))); // 157 (Serie, MschSpalteName='Schulklasse')
                                                         // 221 (8 Abschnitte + 8x 8)
                                                         // 185 (8 StaffelTln - 7 (Serie) + 7x 5
                                                         // 249 (8 Abschn. + 8x 8
end;

//==============================================================================
function ZeileMschWertung(SerDrMode:TSerDrMode;Msch:TMannschObj): String;
//==============================================================================
// Max 255 Zeichen, 63 Felder
// Felder gleich f�r alle WkArten
var i,MschTlnMax : Integer;
begin
  Result := '';

  if Msch=nil then ResStr := 'Veranst'   else ResStr := Veranstaltung.Name;
  if Msch=nil then IncRslt('Wettk')      else IncRslt(GetTitel2(Msch.Wettk,wgStandWrtg));
  if Msch=nil then IncRslt('Wertg')      else
                                         if HauptFenster.Ansicht=anMschErgSerie then
                                           IncRslt('Serienwertung Mannschaften')
                                         else
                                           IncRslt('Mannschaftswertung');
  if Msch=nil then IncRslt('Datum')      else IncRslt(Msch.Wettk.Datum);
  if Veranstaltung.Serie then
    if Msch=nil then IncRslt('VstOrt')   else IncRslt(Veranstaltung.OrtName);
  if Msch=nil then IncRslt('Mannschaft') else
                                         if Msch.MschIndex > 1 then
                                           IncRslt(Msch.Name+ '~' + IntToStr(Msch.MschIndex))
                                         else IncRslt(Msch.Name);
  if Msch=nil then IncRslt('Klasse')     else IncRslt(Msch.Klasse.Name);
  if Msch=nil then IncRslt('Rng')        else
                                         if HauptFenster.Ansicht=anMschErgSerie then
                                           IncRslt(Msch.GetSerieRangStr)
                                         else
                                         if (Msch.Wettk.MschWertg = mwMulti) and
                                            (Msch.MschIndex=0) then // Startliste
                                           if Msch.Msch1<>nil then
                                             IncRslt(Msch.Msch1.TagesRngStr)
                                           else
                                             IncRslt('-')
                                         else
                                           IncRslt(Msch.TagesRngStr);
  if RndRennen and (HauptFenster.Ansicht<>anMschErgSerie) then
    if Msch=nil then IncRslt('Rnd')      else
                                           if Msch.Wettk.WettkArt = waRndRennen then
                                             IncRslt(IntToStr(Msch.Runden))
                                           else IncRslt('-');
  if Msch=nil then IncRslt('Result')     else
                                         if HauptFenster.Ansicht=anMschErgSerie then
                                           IncRslt(Msch.GetSerieSumStr(lmReport))
                                         else
                                         if (Msch.Wettk.MschWertg = mwMulti) and
                                            (Msch.MschIndex=0) then // Startliste
                                           if Msch.Msch1<>nil then
                                             IncRslt(Msch.Msch1.GetTagSumStr(nil))
                                           else
                                             IncRslt('-')
                                         else
                                           IncRslt(Msch.GetTagSumStr(nil));
  if Msch=nil then IncRslt('Einh')       else
                                           if HauptFenster.Ansicht=anMschErgSerie then
                                             IncRslt(Msch.GetSerieSumEinh)
                                           else
                                           if (Msch.Wettk.MschWertg = mwMulti) and
                                              (Msch.MschIndex=0) then // Startliste
                                             if Msch.Msch1<>nil then
                                               IncRslt(Msch.Msch1.GetTagSumEinh(nil))
                                             else
                                               IncRslt('-')
                                           else
                                             IncRslt(Msch.GetTagSumEinh(nil));

  if HauptFenster.Ansicht <> anMschErgSerie then // keine MschTln bei Serienwertung
  begin
    if HauptFenster.Ansicht = anMschStart then
      MschTlnMax := MschTlnStartMax  // max 32 Tln
    else
      MschTlnMax := MschTlnWertgMax; // max 16 Tln
    for i:=0 to MschTlnMax-1 do
      if Msch=nil then // Header
      begin
        IncRslt('Tln'+IntToStr(i+1));
        if HauptFenster.Ansicht <> anMschStart then
        begin
          if ((SerDrMode= sdText) or (MschTlnMax <= 8)) and RndRennen then // sonst keine Runden f�r Word, weil ResStr > 255
            IncRslt('Rd'+IntToStr(i+1));
          IncRslt('Res'+IntToStr(i+1));
          if (SerDrMode= sdText) or (MschTlnMax <= 8) then // sonst keine Einh f�r Word, weil ResStr > 255
            IncRslt('Eh'+IntToStr(i+1));
        end;
      end
      else // Daten
        if (i<Msch.TlnListe.SortCount) and (Msch.SortedTln[i]<>nil) then
        begin
          IncRslt(Msch.SortedTln[i].VNameName); //TlnName auch wenn nicht gewertet
          if HauptFenster.Ansicht <> anMschStart then
          begin
            if ((SerDrMode= sdText) or (MschTlnMax <= 8)) and RndRennen then // sonst keine Runden, weil ResStr > 255
              if Msch.SortedTln[i].TlnInStatus(stGewertet) then
                IncRslt(IntToStr(Msch.SortedTln[i].RundenZahl(wkAbs1)))
              else IncRslt('-');
            if Msch.SortedTln[i].TlnInStatus(stGewertet) then
              IncRslt(Msch.GetTagSumStr(Msch.SortedTln[i]))
            else IncRslt('-');
            if ((SerDrMode= sdText) or (MschTlnMax <= 8)) then
              if Msch.SortedTln[i].TlnInStatus(stGewertet) then
                IncRslt(Msch.GetTagSumEinh(Msch.SortedTln[i]))
              else
                IncRslt('-');
          end;
        end else
        begin
          IncRslt('-');
          if HauptFenster.Ansicht <> anMschStart then
          begin
            if ((SerDrMode= sdText) or (MschTlnMax <= 8)) and RndRennen then
              IncRslt('-');
            IncRslt('-');
            if (SerDrMode= sdText) or (MschTlnMax <= 8) then
              IncRslt('-');
          end;
        end;
  end;

  Result := ResStr;                                         // 70 + 8 x 18 = 214
  //if Msch=nil then ShowMessage(IntToStr(Length(ResStr))); // 70 + 16 x 10 = 230
end;                                                        // 70 + 32 x 5 = 230 Startliste







end.
