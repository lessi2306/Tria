unit RfidEinlDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons, Vcl.ComCtrls, Vcl.Mask,
  AllgConst,AllgFunc,AllgObj,AllgComp,TlnObj;

procedure RfidEinlesen;

type
  TRfidEinlDialog = class(TForm)
    DateiEdit: TEdit;
    DateiLabel: TLabel;
    FormatGB: TGroupBox;
    SnrLabel1: TLabel;
    RfidLabel1: TLabel;
    SnrEdit: TTriaMaskEdit;
    SnrPosUpDown: TTriaUpDown;
    RfidEdit: TTriaMaskEdit;
    TriaUpDown1: TTriaUpDown;
    HeaderCB: TCheckBox;
    OkButton: TButton;
    CancelButton: TButton;
    LoeschenCB: TCheckBox;
    LoeschenGB: TGroupBox;
    SnrLabel2: TLabel;
    RfidLabel2: TLabel;
    TrennZeichenLabel: TLabel;
    TrennZeichenCB: TComboBox;
    DateiBtn: TBitBtn;
    HilfeButton: TButton;
    //procedure DateiLabelClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure DateiBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);

  private
    HelpFensterAlt: TWinControl;
    DisableButtons : Boolean;
    function  GetTrennZeichen: String;
    procedure SetTrennZeichen(S:String);
    procedure UpdateDateiEdit(S:String);
    function  RfidDatEinlesen: Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

var
  RfidEinlDialog: TRfidEinlDialog;
  SnrNameListe    : TStringList;

  implementation

uses VeranObj,TriaMain, DateiDlg, VistaFix;

{$R *.dfm}

//******************************************************************************
procedure RfidEinlesen;
//******************************************************************************
begin
  RfidEinlDialog := TRfidEinlDialog.Create(HauptFenster);
  try
    RfidEinlDialog.ShowModal;
  finally
    FreeAndNil(RfidEinlDialog);
  end;
  HauptFenster.RefreshAnsicht;
end;


(******************************************************************************)
(*           Methoden von TZtEinlDialog                                       *)
(******************************************************************************)

(*============================================================================*)
constructor TRfidEinlDialog.Create(AOwner: TComponent);
(*============================================================================*)
begin
  inherited Create(AOwner);

  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    //HilfeButton.Enabled := false;
  end;
  DisableButtons := false;

  UpdateDateiEdit(RfidDatName);
  HeaderCB.Checked    := RfidDatHeader;
  SnrEdit.EditMask    := '09;0; ';
  SnrEdit.Text        := IntToStr(RfidDatSnrPos);
  SetTrennZeichen(RfidDatTrennung);
  RfidEdit.EditMask   := '09;0; ';
  RfidEdit.Text       := IntToStr(RfidDatRfidPos);
  LoeschenCB.Checked  := RfidDatLoeschen;

  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);
end;


(*============================================================================*)
destructor TRfidEinlDialog.Destroy;
(*============================================================================*)
begin
  HelpFenster := HelpFensterAlt;
  inherited Destroy;
end;

//------------------------------------------------------------------------------
procedure TRfidEinlDialog.FormActivate(Sender: TObject);
//------------------------------------------------------------------------------
// ausgef�hrt bei Aufruf von DateiDialog
begin
  DateiEdit.Enabled := true;
  DateiBtn.Enabled := true;
  FormatGB.Enabled := true;

  OkButton.Enabled := true;
  CancelButton.Enabled := true;
end;

//------------------------------------------------------------------------------
procedure TRfidEinlDialog.FormDeactivate(Sender: TObject);
//------------------------------------------------------------------------------
// ausgef�hrt bei Aufruf von DateiDialog
begin
  DateiEdit.Enabled := false;
  DateiBtn.Enabled := false;
  FormatGB.Enabled := false;

  OkButton.Enabled := false;
  CancelButton.Enabled := false;
end;

//------------------------------------------------------------------------------
function TRfidEinlDialog.GetTrennZeichen: String;
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
procedure TRfidEinlDialog.SetTrennZeichen(S:String);
//------------------------------------------------------------------------------
begin
  if S = ',' then TrennZeichenCB.ItemIndex := 1
  else if S = ' ' then TrennZeichenCB.ItemIndex := 2
  else if S = #9 then TrennZeichenCB.ItemIndex := 3
  else TrennZeichenCB.ItemIndex := 0; // tzSemikolon
end;

//------------------------------------------------------------------------------
procedure TRfidEinlDialog.UpdateDateiEdit(S:String);
//------------------------------------------------------------------------------
var S1,S2 : String;
begin
  if Canvas.TextWidth(S) > DateiEdit.ClientWidth-16 then
  begin
    S1 := Copy(S,1,16);
    S2 := S;
    Delete(S2,1,16);
    S := S1+'...'+S2;
    while Canvas.TextWidth(S) > DateiEdit.ClientWidth-16 do
    begin
      Delete(S2,1,1);
      S := S1+'...'+S2;
    end;
  end;
  DateiEdit.Text := S;
end;

//------------------------------------------------------------------------------
function TRfidEinlDialog.RfidDatEinlesen: Boolean;
//------------------------------------------------------------------------------
// bei allen Tln in Liste wird RfidCode �berschrieben
// sonstige Tln nicht ge�ndert
var Zeile,
    SnrStr,RfidStr : String;
    i,
    //ZeilenLaenge,
    ZeileNr,
    SnrInt,
    SnrUnbekannt,
    CodeVorhanden,
    Spalten          : Integer;
    IOFehler         : Boolean;
    RfidDatei        : Textfile;
    Tln              : TTlnObj;
    RfidListe,
    TlnListe         : TStringList;

//------------------------------------------------------------------------------
function SpaltenZahl: Integer;
// leere Spalten m�glich
var i:Integer;
begin
  Result := 1; //Trennzeichen + 1
  for i:=1 to Length(Zeile) do
    if Zeile[i] = RfidDatTrennung then Inc(Result);
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
    if S[i]=RfidDatTrennung then Inc(Col);
    Inc(i);
  end;
  if i>1 then Delete(S,1,i-1); // bis Anfang der Spalte l�schen
  for i:=1 to Length(S) do
    if S[i] <> RfidDatTrennung then
      Result := Result + S[i]
    else Break;
end;
//------------------------------------------------------------------------------
function GetSnrStr: String;
begin
  Result := GetSpalte(RfidDatSnrPos);
end;
//------------------------------------------------------------------------------
function GetRfidStr: String;
begin
  Result := GetSpalte(RfidDatRfidPos);
end;

//------------------------------------------------------------------------------
begin
  Result        := false;
  IOFehler      := false;
  SnrUnbekannt  := 0;
  CodeVorhanden := 0;
  ZeileNr       := 0;
  //ZeilenLaenge  := 0;
  Spalten       := 0;

  RfidListe := TStringList.Create; // zuerst in Liste einlesen,
  with RfidListe do
  begin
    CaseSensitive := true;
    Duplicates    := dupAccept;
    OwnsObjects   := false;
    Sorted        := false;
  end;
  TlnListe := TStringList.Create; // zuerst in Liste einlesen,
  with TlnListe do
  begin
    CaseSensitive := true;
    Duplicates    := dupAccept;
    OwnsObjects   := false;
    Sorted        := false;
  end;

  HauptFenster.LstFrame.TriaGrid.StopPaint := true;

  try
    (*$I-*)
    AssignFile(RfidDatei,RfidDatName);
    SetLineBreakStyle(RfidDatei,tlbsCRLF); // CR + LF
    Reset(RfidDatei);
    if IoResult<>0 then begin IOFehler := true; Exit; end;

    while not Eof(RfidDatei) do
    begin
      Inc(ZeileNr);
      if RfidDatHeader and (ZeileNr > cnTlnMax+1) or (ZeileNr > cnTlnMax) then
      begin
        TriaMessage(Self,'Maximale Anzahl von 9.999 Datenzeilen �berschritten.'+#13+
                    'Es wurden keine RDFID-Codes importiert.',
                     mtInformation,[mbOk]);
        Exit;
      end;
      ReadLn(RfidDatei,Zeile);
      if IoResult<>0 then begin IOFehler := true; Exit; end;
      Zeile := Trim(Zeile);

      if RfidDatHeader and (ZeileNr = 1) then Continue
      else
      if not RfidDatHeader and (ZeileNr = 1) or RfidDatHeader and (ZeileNr = 2) then
      begin
        //ZeilenLaenge := Length(Zeile);
        Spalten := SpaltenZahl;
        if (Spalten < RfidDatSnrPos) or (Spalten < RfidDatRfidPos) then
        begin
          TriaMessage(Self,'In Zeile '+IntToStr(ZeileNr)+' sind nur '+IntToStr(Spalten)+ ' Spalten vorhanden.',
                      mtInformation,[mbOk]);
          Exit;
        end;
      end else // ab 2. Zeile
        if SpaltenZahl <> Spalten then Exit;

      // Spaltenzahl Ok, Format pr�fen
      SnrStr  := GetSnrStr;
      RfidStr := GetRfidStr;

      if (Length(SnrStr) > 4) or not TryStrToInt(SnrStr,SnrInt) or (SnrInt <= 0) then
      begin
        TriaMessage(Self,'Startnummer in Zeile ' + IntToStr(ZeileNr) + ' ("' + SnrStr + '") ist nicht Ok.'+#13+
                    'Es wurden keine RFID-Codes importiert.',
                     mtInformation,[mbOk]);
        Exit;
      end;
      if Length(RfidStr) > cnRfidzeichenMax then
      begin
        TriaMessage(Self,'Der RFID-Code hat mehr als '+IntToStr(cnRfidzeichenMax)+ ' Zeichen.'+#13+
                    'Es wurden keine RFID-Codes importiert.',
                    mtInformation,[mbOk]);
        Exit;
      end;
      if not RfidTrimValid(RfidStr) then
      begin
        TriaMessage(Self,'RFID-Code in Zeile ' + IntToStr(ZeileNr) + ' ("' + RfidStr + '") hat Leerzeichen am Anfang und/oder Ende.'+#13+
                    'Es wurden keine RFID-Codes importiert.',
                     mtInformation,[mbOk]);
        Exit;
      end;
      if not RfidLengthValid(RfidStr) then
        if TriaMessage(Self,'Der RFID-Code in Zeile '+IntToStr(ZeileNr)+
                       ' hat '+IntTostr(Length(RfidStr))+' statt '+IntTostr(RfidZeichen)+' Zeichen.'+#13+
                        'Die maximal zul�ssige Zeichenl�nge auf '+ IntToStr(Length(RfidStr))+' erh�hen?',
                        mtConfirmation,[mbOk,mbCancel]) <> mrOk then
          Exit
        else
          RfidZeichen := Length(RfidStr);
      if RfidHex and not RfidHexValid(RfidStr) then
        if TriaMessage(Self,'Der RFID-Code in Zeile '+IntToStr(ZeileNr)+
                       ' ("'+RfidStr+'") ist keine g�ltige Hexadezimale Zahl.'+#13+
                       'Nicht-hexadezimale Zeichen generell zulassen?',
                       mtConfirmation,[mbOk,mbCancel]) <> mrOk then
          Exit
        else
          RfidHex := false;

      // pr�fe ob Tln mit Snr vorhanden
      Tln := Veranstaltung.TlnColl.TlnMitSnr(SnrInt);
      if Tln <> nil then // Tln vorhanden
      begin
        // pr�fe ob Snr oder RFID-Code doppelt
        for i:=0 to TlnListe.Count-1 do
        begin
          if TTlnObj(TlnListe.Objects[i]) = Tln then
          begin
            TriaMessage(Self,'Startnummer in Zeile ' + IntToStr(ZeileNr) + ' ("' + SnrStr + '") ist in der Datei mehrfach vorhanden.'+#13+
                        'Es wurden keine RFID-Codes importiert.',
                        mtInformation,[mbOk]);
            Exit;
          end;
          if TTlnObj(TlnListe.Objects[i]).RfidCode = RfidStr then
          begin
            TriaMessage(Self,'RFID-Code in Zeile ' + IntToStr(ZeileNr) + ' ("' + RfidStr + '") ist in der Datei mehrfach vorhanden.'+#13+
                        'Es wurden keine RFID-Codes importiert.',
                        mtInformation,[mbOk]);
            Exit;
          end;
        end;
        TlnListe.AddObject(RfidStr,Tln);

        // pr�fe ob RFID-Code bereits vergeben
        if RfidHex and (Tln.RfidCode <> LowerCase(RfidStr)) or
           not RfidHex and (Tln.RfidCode <> RfidStr) then // neuer Code f�r Tln
          if Veranstaltung.TlnColl.TlnMitRfid(RfidStr) <> nil then // RfidCode doppel
          begin
            TriaMessage(Self,'RFID-Code in Zeile ' + IntToStr(ZeileNr) + ' ("' + RfidStr + '") wurde bereits vergeben.'+#13+
                        'Es wurden keine RFID-Codes importiert.',
                        mtInformation,[mbOk]);
            Exit;
          end else// RfidCode Ok, in Liste speichern
            RfidListe.AddObject(RfidStr,Tln)
        else // Tln.RfidCode = RfidStr
          Inc(CodeVorhanden); // Code bereits vorhanden, n�chste Zeile
      end
      else // Tln = nil
        Inc(SnrUnbekannt); // Snr nicht vorhanden, n�chste Zeile
    end;

    Result := true;

  finally
    CloseFile(RfidDatei);
    IoResult;
    (*$I+*)

    if not Result then
      if IOFehler then
        if ZeileNr = 0 then
          TriaMessage(Self,'Fehler beim Lesen der Datei  "'+RfidDatName+'".'+#13+
                      'Es wurden keine RFID-Codes importiert.',
                      mtInformation,[mbOk])
        else
          TriaMessage(Self,'Fehler beim Lesen von Zeile  ' + IntToStr(ZeileNr)+'.'+#13+
                      'Es wurden keine RFID-Codes importiert.',
                      mtInformation,[mbOk])
      else // keine nochmalige Fehlermeldung

    else // Einlesen OK,  Daten �bernehmen
    begin
      if RfidListe.Count > 0 then
      begin
        for i:=0 to RfidListe.Count-1 do
        with TTlnObj(RfidListe.Objects[i]) do
        begin
          RfidCode := RfidListe[i];
          SetzeBearbeitet;
        end;
        TriDatei.Modified := true;
      end;
      if RfidDatHeader then i := ZeileNr-1
                       else i := ZeileNr;
      TriaMessage(Self,'Es wurden ' + IntToStr(i)+' Datenzeilen gelesen und'+#13+
                  'daraus wurden ' + IntToStr(RfidListe.Count) + ' RFID-Codes importiert.'+#13+#13+
                  'Ignoriert wurden ' + IntToStr(CodeVorhanden) + ' vorhandene RFID-Codes '+#13+
                  'und ' + IntToStr(SnrUnbekannt) + ' unbekannte Startnummern.',
                   mtInformation,[mbOk])
    end;
    FreeAndNil(TlnListe);
    FreeAndNil(RfidListe);
    HauptFenster.UpdateAnsicht;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;

end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TRfidEinlDialog.DateiBtnClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var Dir,DatName : String;
    FilterIndx : Integer;
begin
  if RfidDatName <> '' then
  begin
    Dir := SysUtils.ExtractFileDir(RfidDatName);
    DatName := SysUtils.ExtractFileName(RfidDatName);
    FilterIndx := RfidDatFilter;
  end else
  begin
    Dir := SysUtils.ExtractFileDir(TriDatei.Path);
    DatName := '';
    FilterIndx := 1; // txt
  end;

  //RfidEinlDialog.DeActivate;
  if OpenFileDialog('*', //const DefExt: string
                    'Text-Dateien (*.txt)|*.txt|'+
                    'CSV-Dateien (*.csv)|*.csv|'+
                    'Alle Dateien (*.*)|*.*',//Filter: string
                    Dir, //InitialDir: string
                    FilterIndx, // Type Txt Dateien
                    'RFID-Codes Einlesen',//Title: string
                    DatName) then //var FileName: string
  begin
    RfidDatName := Trim(DatName);
    RfidDatFilter := FilterIndx;
    UpdateDateiEdit(RfidDatName);
  end;
  //RfidEinlDialog.Activate;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TRfidEinlDialog.OkButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var
  i: Integer;
begin
  if not DisableButtons then
  try
    DisableButtons := true;

    // Dateiname pr�fen
    if StrGleich(DateiEdit.Text,'') then
    begin
      TriaMessage(Self,'Der Dateiname fehlt.',mtInformation,[mbOk]);
      DateiEdit.SetFocus;
      Exit;
    end;

    if not SnrEdit.ValidateEdit then Exit;
    if not RfidEdit.ValidateEdit then Exit;
    if (StrToIntDef(SnrEdit.Text,0) <= 0) or (StrToIntDef(RfidEdit.Text,0) <= 0) or
       (StrToInt(SnrEdit.Text) = StrToInt(RfidEdit.Text)) then
    begin
      TriaMessage(Self,'Die Spalten sind ung�ltig.'+#13+
                  'Es wurden keine RFID-Codes importiert.',
                  mtInformation,[mbOk]);
      if SnrEdit.CanFocus then SnrEdit.SetFocus;
      Exit;
    end;

    RfidDatHeader   := HeaderCB.Checked;
    RfidDatSnrPos   := StrToInt(SnrEdit.Text);
    RfidDatTrennung := GetTrennZeichen;
    RfidDatRfidPos  := StrToInt(RfidEdit.Text);
    RfidDatLoeschen := LoeschenCB.Checked;

    if RfidDatLoeschen and Veranstaltung.TlnColl.RfidBenutzt then
      if TriaMessage(Self,'Es wurden bereits RFID-Codes definiert.' +#13+
                     'Diese werden alle gel�scht.',
                     mtConfirmation,[mbOk,mbCancel]) = mrOk then
      begin
        for i:=0 to Veranstaltung.TlnColl.Count-1 do
        with Veranstaltung.TlnColl[i] do
          if RfidCode <> '' then
          begin
            RfidCode := '';
            SetzeBearbeitet;
          end;
        TriDatei.Modified := true;
      end else
        Exit;

    if RfidDatEinlesen then
      ModalResult := mrOk

  finally
    DisableButtons := false;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TRfidEinlDialog.HilfeButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  Application.HelpContext(2350);  // RFID-Codes Importieren
end;


end.