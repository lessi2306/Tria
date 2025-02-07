unit DatExp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ShellApi,Math,ComObj,OleCtrls, SHDocVw,
  AllgConst,AllgObj,AllgFunc,VeranObj, OleServer, ExcelXP{Excel2000}{, Excel97};

procedure ExportDateiAnzeigen;
function  ExportDateiSpeichern: Boolean;
function  ExcelStart: Boolean;
procedure ExcelStop;

implementation

uses DateiDlg,TriaMain,ListFmt,WettkObj,AkObj,TlnObj,ImpDlg,AusgDlg;

type
  TColTypeRec = record  // 2008-2.0
    CType : TColType;
    Runde : Integer;
  end;

var
  FLCID             : Integer;
  ExcListNr,ExcWkNr,ExcAkNr : Integer;
  ExportDatei       : Text;
  ExportReportType  : TListType;
  ColTypeArr        : array of TColTypeRec;  //dynamisches Array
  TabellenBreite    : Integer;
  OrtColBreite      : Integer;
  MschTlnCollBreite : Integer;
  ErsteZeile        : Boolean;

const
  MaxTabellenBreite = 740;
  ColSpace          = 1;

procedure ExportDateiAssignen;                                   forward;
procedure ExportDateiOeffnen;                                    forward;
procedure ExportDateiSchliessen;                                 forward;
procedure ExportDateiHeader;                                     forward;
procedure ExportDateiTrailer;                                    forward;
procedure ExportTabelHeader(RepTln:TReportTlnObj);               forward;
procedure ExportTabelTrailer(RepTln:TReportTlnObj);              forward;
procedure ExportTabelZeile(Zeile:Integer;RepTln:TReportTlnObj);  forward;

procedure Schreibe(S:String);                                    forward;
procedure HTMLDateiAssignen;                                     forward;
procedure HTMLDateiOeffnen;                                      forward;
procedure HTMLDateiSchliessen;                                   forward;
procedure HTMLDateiHeader;                                       forward;
procedure HTMLDateiTrailer;                                      forward;
procedure HTMLTabelHeader(RepTln:TReportTlnObj);                 forward;
procedure HTMLTabelTrailer;                                      forward;
procedure HTMLTabelBreite(RepTln:TReportTlnObj);                 forward;
function  HTMLColBreite(C:TColType):Integer;                     forward;
function  HTMLColHeader(C:TColType;RepTln:TReportTlnObj):String; forward;
function  HTMLColText(C:TColType;RepTln:TReportTlnObj):String;   forward;
procedure HTMLTabelZeile(Zeile:Integer;RepTln:TReportTlnObj);    forward;
procedure ExcelDateiSchliessen;                                  forward;
procedure ExcelDateiAssignen;                                    forward;
procedure ExcelDateiHeader;                                      forward;
procedure ExcelDateiTrailer;                                     forward;
procedure ExcelTabelHeader(RepTln:TReportTlnObj); forward;
procedure ExcelTabelTrailer;                                     forward;
procedure ExcelTabelZeile(Zeile:Integer;RepTln:TReportTlnObj);   forward;
function  ExcelRangePar(Row,Col:Integer): String;                forward;

procedure TextDateiAssignen;                                     forward;
procedure TextDateiOeffnen;                                      forward;
procedure TextDateiSchliessen;                                   forward;
procedure TextDateiHeader;                                       forward;
procedure TextDateiTrailer;                                      forward;
procedure TextTabelHeader(RepTln:TReportTlnObj);                 forward;
procedure TextTabelTrailer;                                      forward;
procedure TextTabelZeile(Zeile:Integer;RepTln:TReportTlnObj);    forward;
function  TextColHeader(CRec:TColTypeRec;RepTln:TReportTlnObj):String; forward;


(******************************************************************************)
function ExportDateiSpeichern: Boolean;
(******************************************************************************)
// gemeinsam f�r fmHTML, fmExcel, fmText
var i,BarMax,
    WkNr       : Integer;
    S          : String;
    RepWk      : TReportWkObj;
    RepTln     : TReportTlnObj;
    AkAlt      : TAkObj;
    TabelZeile : Integer;
    ListMode   : TListMode;

//..............................................................................
function InitColTypeArr(RepWk:TWettkObj;RepWrtg:TWertungMode;RepMschGr:Integer): Boolean;
var i,j : Integer;
begin
  Result := false;
  ExportReportType := GetListType(ListMode,RepWk,RepWrtg,RepMschGr);
  if ExportReportType = ltFehler then Exit;
  {case ExportReportType of
    ltMldLstTln,ltMldLstTlnSml,ltMldLstTlnSer,ltMldLstTlnSerSml,
    ltMldLstTlnLnd,ltMldLstTlnSmlLnd,ltMldLstTlnSerLnd,ltMldLstTlnSerSmlLnd:
      ExportReportType := ltMldLstTlnExp;
    ltFehler: Exit;
  end;}

  // Init ColTypeArr mit Zusatzspalten f�r Excel und Text
  if ExportReportType=ltMldLstTlnExp then
  begin
    InitImpFeldArr(RepWk,lmExport,0);
    SetLength(ColTypeArr, Length(ImpFeldArr)+1); // spWettk am Anfang einf�gen
    ColTypeArr[0].CType := spWettk;
    ColTypeArr[0].Runde := 0;
    for i:=1 to Length(ColTypeArr)- 1 do
    begin
      ColTypeArr[i].CType := ImpFeldArr[i-1].FeldType;
      ColTypeArr[i].Runde := ImpFeldArr[i-1].Runde;
    end;
  end else
  begin
    i:=0; j:=0;
    // Spalten wie gelistet
    while GetColType(ExportReportType,RepWk,i,ListMode) <> spLeer do
    begin
      // i z�hlt definierte Spalten in Liste
      // j index in ColTypeArray mit zus�tzlichen Spalten
      Inc(i); Inc(j);
      SetLength(ColTypeArr, j);
      ColTypeArr[j-1].CType := GetColType(ExportReportType,RepWk,i-1,ListMode);
      ColTypeArr[j-1].Runde := 0;
      // Zus�tzliche Spalten f�r Ergebnisliste
      if (ExportDatFormat = ftExcel) or (ExportDatFormat = ftText) then
      begin
         // einfache Staffelwertung
        if ColTypeArr[j-1].CType = spMschTlnZt0 then
        begin
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spAbs1Rng;
          ColTypeArr[j-1].Runde := 0;
        end else
        if ColTypeArr[j-1].CType = spMschTlnZt1 then
        begin
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spAbs2Rng;
          ColTypeArr[j-1].Runde := 0;
        end else
        if ColTypeArr[j-1].CType = spMschTlnZt2 then
        begin
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spAbs3Rng;
          ColTypeArr[j-1].Runde := 0;
        end else
        if ColTypeArr[j-1].CType = spMschTlnZt3 then
        begin
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spAbs4Rng;
          ColTypeArr[j-1].Runde := 0;
        end else
        if ColTypeArr[j-1].CType = spMschTlnZt4 then
        begin
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spAbs5Rng;
          ColTypeArr[j-1].Runde := 0;
        end else
        if ColTypeArr[j-1].CType = spMschTlnZt5 then
        begin
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spAbs6Rng;
          ColTypeArr[j-1].Runde := 0;
        end else
        if ColTypeArr[j-1].CType = spMschTlnZt6 then
        begin
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spAbs7Rng;
          ColTypeArr[j-1].Runde := 0;
        end else
        if ColTypeArr[j-1].CType = spMschTlnZt7 then
        begin
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spAbs8Rng;
          ColTypeArr[j-1].Runde := 0;
        end else
        // MschWettk
        if RepWk.MschWettk and
           (ColTypeArr[j-1].CType in [spMschEndzeit,spMschStrecke,spMschPunkte]) then
        begin
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spMschStrafZeit;
          ColTypeArr[j-1].Runde := 0;
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spMschGutschrift;
          ColTypeArr[j-1].Runde := 0;
        end else
        // allgemein
        if ColTypeArr[j-1].CType in [spTlnEndZeit,spTlnEndStrecke,
                                     spMschTlnEndZeit,spMschTlnStrecke,spMschTlnPunkte] then
        begin
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spTlnZeitNetto;
          ColTypeArr[j-1].Runde := 0;
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spTlnStrafZeit;
          ColTypeArr[j-1].Runde := 0;
          Inc(j);
          SetLength(ColTypeArr, j);
          ColTypeArr[j-1].CType := spGutschrift;
          ColTypeArr[j-1].Runde := 0;
        end;
      end;
    end;
    // Zus�tzliche Kommentarspalte
    if ((ExportDatFormat = ftExcel) or (ExportDatFormat = ftText)) and
       (HauptFenster.SortStatus <> stKein) and
       (HauptFenster.Ansicht <> anMschErgKompakt) and
       (HauptFenster.Ansicht <> anMschErgSerie) and
       (HauptFenster.Ansicht <> anAnmEinzel) and
       (HauptFenster.Ansicht <> anAnmSammel) then
    begin
      Inc(j);
      SetLength(ColTypeArr, j);
      ColTypeArr[j-1].CType := spKomment;
      ColTypeArr[j-1].Runde := 0;
    end;
    // Zus�tzliche RFID-Spalte in Startliste
    if RfidModus and
       ((ExportDatFormat = ftExcel) or (ExportDatFormat = ftText)) and
       (HauptFenster.SortStatus <> stKein) and
       (HauptFenster.Ansicht = anTlnStart) then
    begin
      Inc(j);
      SetLength(ColTypeArr, j);
      ColTypeArr[j-1].CType := spRfid;
      ColTypeArr[j-1].Runde := 0;
    end;
  end;
  Result := true;
end;

//..............................................................................
begin
  Result := false;
  if ReportWkListe.Count = 0 then Exit; // sollte nicht vorkommen

  ExportDateiName := SysUtils.ChangeFileExt(TriDatei.Path,TriDateiExt(ExportDatFormat));
  case ExportDatFormat of
    ftHTML  : S := 'HTML-Datei';
    ftExcel : S := 'Excel-Datei';
    ftText  : S := 'Textdatei';
    else S := '';
  end;
  if SaveFileDialog(Copy(TriDateiExt(ExportDatFormat),2,3),
                    S + ' ('+TriExtFilter(ExportDatFormat)+')|'+
                    TriExtFilter(ExportDatFormat)+'|Alle Dateien (*.*)|*.*',
                    SysUtils.ExtractFileDir(TriDatei.Path),
                    S + ' Speichern',
                    ExportDateiName) then // ExportDateiName evtl. ge�ndert
  begin
    //Self.Refresh;
    HauptFenster.Refresh;
  end else
    Exit;


  if SysUtils.FileExists(ExportDateiName) and not SysUtils.DeleteFile(ExportDateiName) then
  begin
    TriaMessage('Vorhandene Datei  "'+SysUtils.ExtractFileName(ExportDateiName)+
                '"  kann nicht gel�scht werden.',
                 mtInformation,[mbOk]);
    Exit;
  end;

  with HauptFenster do
  begin
    if TlnAnsicht then BarMax := Veranstaltung.TlnColl.Count * 2 * ReportWkListe.Count
    else if MschAnsicht then BarMax := Veranstaltung.MannschColl.Count * 2 * ReportWkListe.Count
    else BarMax := 0;
    //S vorher initialisiert
    ProgressBarInit(S+' wird erstellt',BarMax);
  end;

  try
    ExportDateiAssignen;
    try
      ExportDateiOeffnen;
      ExportDateiHeader;

      ExcListNr := 0; // z�hlt �ber alle Wk und Ak, Anfang bei ListNr=1
      ExcWkNr   := 0;
      for WkNr:=0 to ReportWkListe.Count-1 do // Anfang bei WkNr=0
      begin
        RepWk := ReportWkListe[WkNr];
        // BarPos bleibt erhalten
        if WkNr>0 then HauptFenster.ProgressBarMaxUpdate(BarMax);
        // �ber alle Ak's aus ReportAkListe sortieren
        if HauptFenster.TlnAnsicht then Veranstaltung.TlnColl.ReportSortieren(RepWk.Wettk,RepWk.Wrtg)
                                   else Veranstaltung.MannschColl.ReportSortieren(RepWk.Wettk);
        if Veranstaltung.TlnColl.ReportCount = 0 then Continue;

        Inc(ExcWkNr); // Anfang bei ExcWkNr=1, leere Listen nicht mitz�hlen
        // BarPos bleibt erhalten (50%), Report immer von TlnColl erstellt
        HauptFenster.ProgressBarMaxUpdate(Veranstaltung.TlnColl.ReportCount*ReportWkListe.Count);

        case ExportDatFormat of
          ftExcel,
          ftText  : ListMode := lmExport;
          else      ListMode := lmReport;
        end;

        AkAlt      := nil;
        ExcAkNr    := 0; // neu z�hlen bei jeden Wk, Anfang bei 1
        TabelZeile := 0;
        // ExportDatei mit Inhalt f�llen, Statusbar steht auf halbe Position
        for i:=0 to Veranstaltung.TlnColl.ReportCount-1 do //auch bei MschAnsicht
        begin
          RepTln := Veranstaltung.TlnColl.ReportItems[i];
          if RepTln.ReportAk <> AkAlt then
          begin
            AkAlt := RepTln.ReportAk;
            if not InitColTypeArr(RepWk.Wettk,RepWk.Wrtg,RepWk.Wettk.MschGroesse[AkAlt.Sex]) then Exit;
            Inc(ExcListNr); // Anfang bei LstNr=1
            Inc(ExcAkNr); // Anfang bei AkNr=1
            ExportTabelHeader(RepTln);
            TabelZeile := 0;
            ErsteZeile := true;
          end;
          Inc(TabelZeile);
          ExportTabelZeile(TabelZeile,RepTln);
          ErsteZeile := false;
          if i = Veranstaltung.TlnColl.ReportCount-1 then ExportTabelTrailer(RepTln)
          else
          with Veranstaltung.TlnColl.ReportItems[i+1] do
            if RepTln.ReportAk <> ReportAk then ExportTabelTrailer(RepTln);
          HauptFenster.ProgressBarStep(1);
        end;
      end;
      ExportDateiTrailer;
      Result := true;

    finally
      ImpFeldArr := nil;
      ColTypeArr := nil;
      ExportDateiSchliessen;
      HauptFenster.StatusBarClear;
    end;

  except
    // alle Exceptions abfangen
    case ExportDatFormat of
      ftHTML  : HTMLDateiSchliessen;
      ftExcel : ExcelDateiSchliessen;
      ftText  : TextDateiSchliessen;
    end;
    HauptFenster.StatusBarClear; // vor Meldung, damit Cursor zur�ckgesetzt wird
    TriaMessage('Fehler beim Erstellen der Datei "'+ExportDateiName+'".',
                 mtInformation,[mbOk]);
  end;
end;

(******************************************************************************)
procedure ExportDateiAnzeigen;
(******************************************************************************)
var S : String;
begin
  // Excel bereits gestartet und ExcelDatei visible gesetzt
  if ExportDatFormat <> ftExcel then //with ExportDialog do
  begin
    case ExportDatFormat of
      ftHTML  : S := 'dem standard Internet Browser';
      ftText  : S := 'dem standard Texteditor';
    end;
    if ShellExecute(Application.Handle,'open',PChar(ExportDateiName),
                    nil,nil, sw_ShowNormal) <= 32 then
       TriaMessage('Die Datei "'+ExportDateiName+
                   '" konnte mit '+S+' nicht angezeigt werden.',
                    mtInformation,[mbOk]);
  end;
end;

(******************************************************************************)
procedure ExportDateiAssignen;
(******************************************************************************)
begin
  case ExportDatFormat of
    ftHTML  : HTMLDateiAssignen;
    ftExcel : ExcelDateiAssignen;
    ftText  : TextDateiAssignen;
  end;
end;

(******************************************************************************)
procedure ExportDateiOeffnen;
(******************************************************************************)
begin
  case ExportDatFormat of
    ftHTML  : HTMLDateiOeffnen;
    ftExcel : ; // in ExcelDateiAssignen erstellt
    ftText  : TextDateiOeffnen;
  end;
end;

(******************************************************************************)
procedure ExportDateiSchliessen;
(******************************************************************************)
begin
  case ExportDatFormat of
    ftHTML  : HTMLDateiSchliessen;
    ftExcel : ; // Datei mit ExcelAppl geschlossen
    ftText  : TextDateiSchliessen;
  end;
end;

(******************************************************************************)
procedure ExportDateiHeader;
(******************************************************************************)
begin
  case ExportDatFormat of
    ftHTML  : HTMLDateiHeader;
    ftExcel : ExcelDateiHeader;
    ftText  : TextDateiHeader;
  end;
end;

(******************************************************************************)
procedure ExportDateiTrailer;
(******************************************************************************)
begin
  case ExportDatFormat of
    ftHTML  : HTMLDateiTrailer;
    ftExcel : ExcelDateiTrailer;
    ftText  : TextDateiTrailer;
  end;
end;

(******************************************************************************)
procedure ExportTabelHeader(RepTln:TReportTlnObj);
(******************************************************************************)
begin
  case ExportDatFormat of
    ftHTML  : HTMLTabelHeader(RepTln);
    ftExcel : ExcelTabelHeader(RepTln);
    ftText  : TextTabelHeader(RepTln);
  end;
end;

(******************************************************************************)
procedure ExportTabelTrailer(RepTln:TReportTlnObj);
(******************************************************************************)
begin
  case ExportDatFormat of
    ftHTML  : HTMLTabelTrailer;
    ftExcel : ExcelTabelTrailer;
    ftText  : TextTabelTrailer;
  end;
end;

(******************************************************************************)
procedure ExportTabelZeile(Zeile:Integer;RepTln:TReportTlnObj);
(******************************************************************************)
begin
  case ExportDatFormat of
    ftHTML  : HTMLTabelZeile(Zeile,RepTln);
    ftExcel : ExcelTabelZeile(Zeile,RepTln);
    ftText  : TextTabelZeile(Zeile,RepTln);
  end;
end;


(******************************************************************************)
(*   HTML - Export                                                            *)
(******************************************************************************)

(******************************************************************************)
procedure Schreibe(S:String);
(******************************************************************************)
begin
  if S <> '' then // bei leere Zeile kein CR
    WriteLn(ExportDatei,S);
end;

(******************************************************************************)
procedure HTMLDateiAssignen;
(******************************************************************************)
begin
  AssignFile(ExportDatei,ExportDateiName);
end;

(******************************************************************************)
procedure HTMLDateiOeffnen;
(******************************************************************************)
begin
  Rewrite(ExportDatei);
end;

(******************************************************************************)
procedure HTMLDateiSchliessen;
(******************************************************************************)
begin
  CloseFile(ExportDatei);
end;

(******************************************************************************)
procedure HTMLDateiHeader;
(******************************************************************************)
begin
  Schreibe('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
  Schreibe('<html>');
  Schreibe('<head>');
  Schreibe('<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">');
  Schreibe('<title>'+Veranstaltung.Name+'</title>');
  Schreibe('<meta name="date" content="'+SystemDatum+'-'+SystemZeit+'">');
  Schreibe('<meta name="generator" content="Tria - '+ProgVersion.JrNr+'">');
  Schreibe('<style type="text/css">');
  Schreibe('<!--');
  Schreibe('body,td,th,p,a {font-family:Arial,Helvetica,sans-serif}');
  Schreibe('a {font-size:12px;font-weight:bold;}');
  Schreibe('a:link {color:#0000CC;}');
  Schreibe('a:visited {color:#0000CC;}');
  Schreibe('a:active {color:#CC0000;}');
  Schreibe('a:hover {color:#CC0000;}');
  Schreibe('table {border-style:solid;border-width:1px;border-color:#0045AE;}');
  Schreibe('tr.H {background-color:#B2D0ED;}');
  Schreibe('tr.E {background-color:#DEEBF7;}');
  Schreibe('tr.O {background-color:#F5F8FB;}');
  Schreibe('td {font-size:11px;padding-left:3px;padding-right:3px;text-align:right;'+
           'white-space:nowrap;}');
  Schreibe('th {font-size:11px;padding-left:3px;padding-right:3px;text-align:center;'+
           'color:#FFFFFF;background-color:#0045AE;font-weight:bold;'+
           'white-space:nowrap;}');
  Schreibe('.L {text-align:left;}');
  Schreibe('.C {text-align:center;}');
  Schreibe('.R {text-align:right;}');
  Schreibe('-->');
  Schreibe('</style>');
  Schreibe('</head>');

  Schreibe('<body leftmargin="10" topmargin="10" marginwidth="10" marginheight="10" '+
       'bgcolor="#FFFFFF" text="#000000" link="#0000CC" vlink="#0000CC" alink="#CC0000">');
  Schreibe('<a name="anfang">'+
       '<span style="font-size:18px;font-weight:bold;color:#FF7C42;">'+
       '&nbsp;&#916;</span>'+
       '<span style="font-size:13.4px;font-weight:bold;color:#001C66;">'+
       'Tria</span></a>');

  // Tabellenbreite setzen f�r 1. RepTln
  if Veranstaltung.TlnColl.ReportCount > 0 then
    HTMLTabelBreite(Veranstaltung.TlnColl.ReportItems[0])
  else Tabellenbreite := MaxTabellenBreite;

  Schreibe('<table width="'+IntToStr(TabellenBreite)+'" '+
           'cellspacing="1" cellpadding="8">');
  Schreibe('<tr class="H"><td class="C">'+
           '<span style="font-size:20px;font-weight:bold;color:#001C66;">'+
            Veranstaltung.Name+'</span></td></tr></table><br>');
end;

(******************************************************************************)
procedure HTMLDateiTrailer;
(******************************************************************************)
begin
  Schreibe('</body>');
  Schreibe('</html>');
end;

(******************************************************************************)
procedure HTMLTabelBreite(RepTln:TReportTlnObj);
(******************************************************************************)
// RepTln nur f�r anMschErgKompakt
var i : Integer;
begin
  OrtColBreite := 0;
  MschTlnCollBreite := 0;
  TabellenBreite := 2 + ColSpace; // 2*Border + 1*ColSpace
  for i:=0 to Length(ColTypeArr)-1 do
    TabellenBreite := TabellenBreite + HTMLColBreite(ColTypeArr[i].CType) + ColSpace;

  with HauptFenster do
  if (Ansicht=anTlnErgSerie)or(Ansicht=anMschErgSerie) then
  begin
    OrtColBreite := (MaxTabellenBreite - TabellenBreite) DIV Veranstaltung.OrtZahl;
    OrtColBreite := Min(OrtColBreite,110);
    TabellenBreite := TabellenBreite + Veranstaltung.OrtZahl * OrtColBreite;
    OrtColBreite := OrtColBreite - ColSpace;
  end else
  if Ansicht=anMschErgKompakt then 
  begin
    if RepTln.ReportWk.MschGroesseMax > 0 then // einheitlich f�r alle Klassen
      MschTlnCollBreite := (MaxTabellenBreite-TabellenBreite) DIV RepTln.ReportWk.MschGroesseMax
    else MschTlnCollBreite := (MaxTabellenBreite-TabellenBreite) DIV 3;
    MschTlnCollBreite := Min(MschTlnCollBreite,HTMLColBreite(spNameVName));
    TabellenBreite   := TabellenBreite + RepTln.ReportWk.MschGroesseMax * MschTlnCollBreite;
    MschTlnCollBreite := MschTlnCollBreite - ColSpace;
  end;
end;

(******************************************************************************)
procedure HTMLTabelHeader(RepTln:TReportTlnObj);
(******************************************************************************)
var i : Integer;
    S : String;
begin
  // Tabellenbreite setzen
  HTMLTabelBreite(RepTln);
  // Tabelle
  Schreibe('<br><table width="'+IntToStr(TabellenBreite)+'" '+
           'cellspacing="1" cellpadding="1">');
  // Titel 2+3
  S := GetTitel2(RepTln.ReportWk,RepTln.ReportWrtg) + '  am  ' + RepTln.ReportWk.Datum+'<br>'+
         GetTitel3(ExportReportType,RepTln.ReportWk,RepTln.ReportAk);
  Schreibe('<tr class="H"><td class="C" colspan="'+IntToStr(Length(ColTypeArr))+'">'+
       '<span style="font-size:16px;font-weight:bold;color:#001C66;">'+S+
       '</span></td></tr>');
  // Header
  S := '<tr>';
  for i:=0 to Length(ColTypeArr)-1 do
    S := S+HTMLColHeader(ColTypeArr[i].CType,RepTln);
  S := S+'</tr>';
  Schreibe(S);
end;

(******************************************************************************)
procedure HTMLTabelTrailer;
(******************************************************************************)
begin
  Schreibe('</table>');
  Schreibe('<p><a href="#anfang">Seitenanfang</a></p>');
end;

(******************************************************************************)
function HTMLColBreite(C:TColType):Integer;
(******************************************************************************)
// OrtColBreite, MschTlnCollBreite als Variable definiert
begin
  case C of
    spRng,
    spMschRngGes  : Result := 35;
    spSnr         : Result := 25;
    spNameVName   : Result := 155;
    spMannsch,
    spMschName    : Result := 135;
    spLand        : Result := 35;
    spJg          : Result := 20;
    spAk          : Result := 35;
    spStBahn      : Result := 20;
    spAkRng,
    spAbs1Rng..spAbs8Rng          : Result := 30;
    spAbs1Zeit..spAbs8Zeit,
    spMschTlnZt0..spMschTlnZt7    : Result := 45;
    spTlnEndZeit,
    spMschTlnEndZeit,spMschTlnStrecke,spMschTlnPunkte,
    spMschEndzeit,spMschStrecke,spMschPunkte,
    spRestStrecke,
    spStZeit                      : Result := 50;
    spRngSer,spMschRngSer         : Result := 35;
    spSumSer,spMschSumSer         : Result := 50;
    spOrt1..spOrt20               : Result := OrtColBreite;
    spMschTln0..spMschTln7        : Result := MschTlnCollBreite;
    else Result :=  0;// f�r OrtCol, MschTlnCol
  end;
end;

(******************************************************************************)
function HTMLColHeader(C:TColType;RepTln:TReportTlnObj):String;
(******************************************************************************)
var //S : string;
    Ausrichtung : TAlignment;
//------------------------------------------------------------------------------
function ColHeader(C1:TColType): String;
begin
  Result := GetColHeader(C1,RepTln.ReportWk);
  if Result = '' then Result := '&nbsp;';
end;
//------------------------------------------------------------------------------
begin
  Ausrichtung := HauptFenster.LstFrame.AlignMode(0,C,RepTln.ReportWk);
  case C of
    // zusammengefa�te Spalten
    spAk       : if HauptFenster.Ansicht = anTlnErg then
                   Result := '<th colspan="2">'+ColHeader(spAkRng)+'</th>'
                 else
                 if HauptFenster.Ansicht = anTlnErgSerie then
                   Result := '<th colspan="2">'+ColHeader(spAkRngSer)+'</th>'
                 else Result := '<th>'+ColHeader(C)+'</th>';
    spAkRng,
    spAkRngSer : Result := ''; // nur bei anTlnErg, anTlnErgSerie
    spAbs1Zeit : Result := '<th colspan="2">'+ColHeader(spAbs1Rng)+'</th>';
    spAbs1Rng  : Result := '';
    spAbs2Zeit : Result := '<th colspan="2">'+ColHeader(spAbs2Rng)+'</th>';
    spAbs2Rng  : Result := '';
    spAbs3Zeit : Result := '<th colspan="2">'+ColHeader(spAbs3Rng)+'</th>';
    spAbs3Rng  : Result := '';
    spAbs4Zeit : Result := '<th colspan="2">'+ColHeader(spAbs4Rng)+'</th>';
    spAbs4Rng  : Result := '';
    spAbs5Zeit : Result := '<th colspan="2">'+ColHeader(spAbs5Rng)+'</th>';
    spAbs5Rng  : Result := '';
    spAbs6Zeit : Result := '<th colspan="2">'+ColHeader(spAbs6Rng)+'</th>';
    spAbs6Rng  : Result := '';
    spAbs7Zeit : Result := '<th colspan="2">'+ColHeader(spAbs7Rng)+'</th>';
    spAbs7Rng  : Result := '';
    spAbs8Zeit : Result := '<th colspan="2">'+ColHeader(spAbs8Rng)+'</th>';
    spAbs8Rng  : Result := '';
    else
      case Ausrichtung of
        taLeftJustify  : Result := '<th class="L">'+ColHeader(C)+'</th>';
        taCenter       : Result := '<th>'+Colheader(C)+'</th>'; // default
        taRightJustify : Result := '<th class="R">'+ColHeader(C)+'</th>';
      end;
  end;
end;

(******************************************************************************)
function HTMLColText(C:TColType; RepTln:TReportTlnObj):String;
(******************************************************************************)
var S : String;
    Ausrichtung : TAlignment;

function ColData: String;
var Bool : Boolean;
begin
  with RepTln do
    Result := GetColData(ReportWk,ReportWrtg,ReportAk,TlnPtr,C,Bool,lmReport);
  if Result = '' then Result := '&nbsp;'
end;

begin
  {if ErsteZeile then S := '<td width="'+IntToStr(HTMLColBreite(C))+'"'
                else} S := '<td'; // sonst funktioniert class="C" nicht
  Ausrichtung := HauptFenster.LstFrame.AlignMode(1,C,RepTln.ReportWk);
  case Ausrichtung of
    taLeftJustify  : Result := S + ' class="L">'+ColData+'</td>';
    taCenter       : Result := S + ' class="C">'+ColData+'</td>';
    taRightJustify : Result := S + '>'+ColData+'</td>'; // default
  end;
end;

(******************************************************************************)
procedure HTMLTabelZeile(Zeile:Integer;RepTln:TReportTlnObj);
(******************************************************************************)
var i : Integer;
    S : String;
begin
  if Zeile MOD 2 = 0 then S := '<tr class="E">'
                     else S := '<tr class="O">';
  for i:=0 to Length(ColTypeArr)-1 do
    S := S+HTMLColText(ColTypeArr[i].CType,RepTln);
  S := S+'</tr>';
  Schreibe(S);
end;


(******************************************************************************)
(*   Excel - Export                                                           *)
(******************************************************************************)
// Interface definiert in Delphi7\Ocx\Servers\Excel97.pas

(******************************************************************************)
function ExcelStart: Boolean;
(******************************************************************************)
begin
  Result := false;
  with AusgDialog do
  begin
    try
      FLCID := GetUserDefaultLCID;
      ExcelApplication.ConnectKind := ckNewInstance; // sonst manchmal Probleme wenn Excel bereit gestartet
      ExcelApplication.Connect;
    except
      TriaMessage('Microsoft Excel wurde nicht gefunden.',mtInformation,[mbOk]);
      Exit;
    end;
    try
      ExcelApplication.Visible[FLCID] := false; // alte nicht richtig closed appl k�nnte sichtbar sein
      ExcelApplication.UserControl := false;    // False wenn Excel unsichtbar sein soll
      ExcelApplication.DisplayAlerts[FLCID] := False;
      ExcelApplication.AskToUpdateLinks[FLCID] := False;
      Result := true;
    except
      TriaMessage('Microsoft Excel konnte nicht gestartet werden.',mtInformation,[mbOk]);
    end;
  end;
end;

(******************************************************************************)
procedure ExcelStop;
(******************************************************************************)
begin
  with AusgDialog do
  try
    if ExportDateiAnsehen then
    begin
      ExcelApplication.Visible[FLCID] := true;
      ExcelApplication.UserControl := true;
    end else
      ExcelDateiSchliessen;
  except
    // Meldung unterdr�cken ShowMessage('Exception beim Close');
  end;
end;

//******************************************************************************
procedure ExcelDateiSchliessen;
//******************************************************************************
begin
  with AusgDialog do
  try
    ExportDateiAnsehen := false;
    ExcelWorksheet.Disconnect;
    ExcelWorkbook.Disconnect;
    ExcelApplication.Quit;
    ExcelApplication.Disconnect;
  except
    // Meldung unterdr�cken ShowMessage('Exception beim Close');
  end;
end;

(******************************************************************************)
procedure ExcelDateiAssignen;
(******************************************************************************)
begin
  with AusgDialog do
  begin
    // WorkBook mit 1 WorkSheet erzeugen
    ExcelApplication.Workbooks.Add(xlWBATWorksheet, FLCID);
    ExcelWorkBook.ConnectTo(ExcelApplication.ActiveWorkbook);
    // leere Datei vorab speichern
    // Exception in Excel 2007-Beta-Version bei SaveAs
    // OLE-Fehler 800A03EC, EOleException (access denied error)
    // Exception nicht abfangen

    ExcelWorkBook.SaveAs(ExportDateiName,       // FileName immer mit Ext. (.xls)
                         EmptyParam,            // FileFormat, Ext. w�rde evtl. erg�nzt
                         EmptyParam,            // Password
                         EmptyParam,            // WriteResPassword
                         false,                 // ReadOnlyRecommended
                         false,                 // CreateBackup
                         xlExclusive,           // AccessMode, xlShared gibt Fehler
                         xlLocalSessionChanges, // ConflictResolution, keine Meldung
                         false,                 // AddToMru
                         EmptyParam,            // TextCodepage
                         EmptyParam,            // TextVisualLayout
                         EmptyParam,            // Local
                         FLCID);
  end;
end;

(******************************************************************************)
procedure ExcelDateiHeader;
(******************************************************************************)
begin
  with AusgDialog.ExcelWorkBook do
  begin
    Title[FLCID]   := Veranstaltung.Name;
    Author[FLCID]  := 'Tria - '+ProgVersion.JrNr;
  end;
end;

(******************************************************************************)
procedure ExcelDateiTrailer;
(******************************************************************************)
begin
  AusgDialog.ExcelWorkBook.Save(FLCID);
  // Exception hier nicht abfangen
end;

(******************************************************************************)
procedure ExcelTabelHeader(RepTln:TReportTlnObj);
(******************************************************************************)
var i : Integer;
    S : String;

procedure InitSpalte(C:Integer; CTypeRec:TColTypeRec);
var Ausrichtung : TAlignment;
begin
  Ausrichtung := HauptFenster.LstFrame.AlignMode(0,CTypeRec.CType,RepTln.ReportWk);
  with AusgDialog.ExcelWorkSheet do
  begin
    with Range[ExcelRangePar(6,C),ExcelRangePar(6,C)].EntireColumn do
      case Ausrichtung of
        taLeftJustify  : HorizontalAlignment := xlHAlignLeft;
        taCenter       : HorizontalAlignment := xlHAlignCenter;
        taRightJustify : HorizontalAlignment := xlHAlignRight;
      end;
    Range[ExcelRangePar(6,C),ExcelRangePar(6,C)].Value2 := TextColHeader(CTypeRec,RepTln);
  end;
end;

begin
  with AusgDialog do
  begin
    if ExcListNr > 1 then
    begin
      ExcelWorkBook.Worksheets.Add(EmptyParam,ExcelApplication.WorkSheets[ExcListNr-1],1,
                                   EmptyParam,FLCID);
      ExcelWorkSheet.Disconnect;
    end;
    S := 'B1';
    with ExcelWorkSheet do
    begin
      ConnectTo(ExcelWorkBook.WorkSheets[ExcListNr] as _Worksheet); 
      Name := 'Liste_' + IntToStr(ExcWkNr) + '.' + IntToStr(ExcAkNr);
      Range['A1','A1'].Value2 := Veranstaltung.Name;
      with Range['A1',ExcelRangePar(1,Length(ColTypeArr))].EntireColumn do
      begin
        //Interior.Color := clWhite;
        Font.Size := 10;
        NumberFormat := '@';
        HorizontalAlignment := xlHAlignCenter;
      end;
      with Range['A1',ExcelRangePar(1,Length(ColTypeArr))] do
      begin
        Merge(EmptyParam);
        Font.Size := 16;
        Font.FontStyle := 'Bold';
      end;
      Range['A2',ExcelRangePar(2,Length(ColTypeArr))].Merge(EmptyParam);
      Range['A3','A3'].Value2 :=
        GetTitel2(RepTln.ReportWk,RepTln.ReportWrtg) + '  am  ' + RepTln.ReportWk.Datum;
      with Range['A3',ExcelRangePar(3,Length(ColTypeArr))] do
      begin
        Merge(EmptyParam);
        Font.Size := 12;
        Font.FontStyle := 'Bold';
      end;
      Range['A4','A4'].Value2 :=
        GetTitel3(ExportReportType,RepTln.ReportWk,RepTln.ReportAk);
      with Range['A4',ExcelRangePar(4,Length(ColTypeArr))] do
      begin
        Merge(EmptyParam);
        Font.Size := 12;
        Font.FontStyle := 'Bold';
      end;
      Range['A5',ExcelRangePar(5,Length(ColTypeArr))].Merge(EmptyParam);
      with Range['A6',ExcelRangePar(6,Length(ColTypeArr))] do
      begin
        Font.FontStyle := 'Bold';
        with Borders[xlEdgeBottom] do
        begin
          LineStyle := xlContinuous;
          Weight := xlMedium;
          ColorIndex := xlAutomatic;
        end;
      end;
      for i:=1 to Length(ColTypeArr) do InitSpalte(i,ColTypeArr[i-1]);
    end;
  end;
end;

(******************************************************************************)
procedure ExcelTabelTrailer;
(******************************************************************************)
var i : Integer;
begin
  for i:=1 to Length(ColTypeArr) do
    AusgDialog.ExcelWorkSheet.Range[ExcelRangePar(1,i),ExcelRangePar(1,i)].
                                                           EntireColumn.AutoFit;
end;

(******************************************************************************)
procedure ExcelTabelZeile(Zeile:Integer;RepTln:TReportTlnObj);
(******************************************************************************)
var i    : Integer;
    Bool : Boolean;
begin
  with AusgDialog.ExcelWorkSheet do
    //with Range[ExcelRangePar(Zeile+6,1),ExcelRangePar(Zeile+6,Length(ColTypeArr))] do
    //  if Zeile MOD 2 = 0 then Interior.Color := clLtGray;
    for i:=1 to Length(ColTypeArr) do
      with RepTln do
      Range[ExcelRangePar(Zeile+6,i),ExcelRangePar(Zeile+6,i)].Value2 :=
        GetColData(ReportWk,ReportWrtg,ReportAk,TlnPtr,ColTypeArr[i-1].CType,Bool,
                   lmExport,ColTypeArr[i-1].Runde); //Runde nur bei ltMldLstTlnExp > 0
        //TextColData(ColTypeArr[i-1],RepTln);
end;

(******************************************************************************)
function ExcelRangePar(Row,Col:Integer): String;
(******************************************************************************)
var M,R : integer;
begin
  M := Col DIV 26; // 26 Buchstaben von A-Z;
  R := Col MOD 26; // 0 f�r Z (letzte =26. Buchstabe)
  if R=0 then
  begin
    M := M-1;
    R := 26;  // Z
  end;
  if M=0 then Result := chr(64+R) + IntToStr(Row)
  else Result := chr(64+M) + chr(64+R) + IntToStr(Row);
end;

{(******************************************************************************)
function ExcelDateiNeu(DatName:String): Boolean;
(******************************************************************************)
var excel : Variant;
    i,j   : Integer;
begin
  try
   Excel := CreateOleObject('Excel.Application');
   //Excel.Visible := true; // nur f�r Test
     WorkBook := Excel.Workbooks.Add;
     for i:=1 to 4 do
       for j:=1 to 8 do
         Excel.Cells[i,j].Value := IntToStr(i)+IntToStr(j);
     // Excel Message verhindern:
     if SysUtils.FileExists(cnTempDateiName) then SysUtils.DeleteFile(cnTempDateiName);
     Workbook.SaveAs(Filename := 'C:\temp\test.xls');
     Excel.Quit;
    (*Seite := Excel.ActiveSheet;
     if VarIsEmpty(Seite) then Seite := Excel.Sheets[1];
     Excel.Sheets[1].Activate;
     Excel.Cells[0,0].Wert := 10;
     seitensheet := Seite.Shapes['testseite']; *)
     //excel := unassigned;
  except
    ShowMessage('Fehler');
  end;
end; }


(******************************************************************************)
(*   Text - Export                                                            *)
(******************************************************************************)


(******************************************************************************)
procedure TextDateiAssignen;
(******************************************************************************)
begin
  AssignFile(ExportDatei,ExportDateiName);
end;

(******************************************************************************)
procedure TextDateiOeffnen;
(******************************************************************************)
begin
  Rewrite(ExportDatei);
end;

(******************************************************************************)
procedure TextDateiSchliessen;
(******************************************************************************)
begin
  CloseFile(ExportDatei);
end;

(******************************************************************************)
procedure TextDateiHeader;
(******************************************************************************)
begin
  Schreibe('erstellt mit Tria-'+ProgVersion.JrNr+
           ' am '+SystemDatum+' um '+SystemZeit+' Uhr');
  WriteLn(ExportDatei,'');
  Schreibe(Veranstaltung.Name);
end;

(******************************************************************************)
procedure TextDateiTrailer;
(******************************************************************************)
begin
end;

(******************************************************************************)
procedure TextTabelHeader(RepTln:TReportTlnObj);
(******************************************************************************)
var i : Integer;
    S : String;
begin
  WriteLn(ExportDatei,'');
  WriteLn(ExportDatei,'');
  // Titel 2+3
  Schreibe(GetTitel2(RepTln.ReportWk,RepTln.ReportWrtg) + '  am  ' + RepTln.ReportWk.Datum);
  Schreibe(GetTitel3(ExportReportType,RepTln.ReportWk,RepTln.ReportAk));
  WriteLn(ExportDatei,'');
  S := '';
  for i:=0 to Length(ColTypeArr)-1 do
    if i=0 then S := TextColHeader(ColTypeArr[i],RepTln)
           else S := S + ';' + TextColHeader(ColTypeArr[i],RepTln);
  Schreibe(S);
end;

(******************************************************************************)
procedure TextTabelTrailer;
(******************************************************************************)
begin
end;

(******************************************************************************)
procedure TextTabelZeile(Zeile:Integer;RepTln:TReportTlnObj);
(******************************************************************************)
var i    : Integer;
    S    : String;
    Bool : Boolean;
begin
  S := '';
  for i:=0 to Length(ColTypeArr)-1 do
    with RepTln do
    if i=0 then
      S := GetColData(ReportWk,ReportWrtg,ReportAk,TlnPtr,
                      ColTypeArr[i].CType,Bool,lmExport,ColTypeArr[i].Runde)//nur bei ltMldLstTlnExp Rnd>0
    else
      S := S + ';' +  GetColData(ReportWk,ReportWrtg,ReportAk,TlnPtr,
                         ColTypeArr[i].CType,Bool,lmExport,ColTypeArr[i].Runde);

  Schreibe(S);
end;

(******************************************************************************)
function TextColHeader(CRec:TColTypeRec;RepTln:TReportTlnObj):String;
(******************************************************************************)
begin
  if ExportReportType = ltMldLstTlnExp then
    Result := GetFeldNameKurz(CRec.CType,CRec.Runde)
  else
  case CRec.CType of
    // zusammengefasste Spalten
    spAkRng,
    spAkRngSer : Result := 'AkRng'; // nur bei anTlnErg,anTlnErgSerie
    spAbs1Rng  : Result := 'Rng1';
    spAbs2Rng  : Result := 'Rng2';
    spAbs3Rng  : Result := 'Rng3';
    spAbs4Rng  : Result := 'Rng4';
    spAbs5Rng  : Result := 'Rng5';
    spAbs6Rng  : Result := 'Rng6';
    spAbs7Rng  : Result := 'Rng7';
    spAbs8Rng  : Result := 'Rng8';
    else         Result := GetColHeader(CRec.CType,RepTln.ReportWk);
  end;
end;


end.
