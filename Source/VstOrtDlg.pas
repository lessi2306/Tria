unit VstOrtDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, StdCtrls, ComCtrls, Buttons,
  AllgConst,AllgObj,AllgFunc,AllgComp,OrtObj,VeranObj,DateiDlg,ZtEinlDlg;

procedure VeranstaltungDefinieren;

type
  TVstOrtDialog = class(TForm)
    procedure VeranstArtRBClick(Sender: TObject);
    procedure VstNameEditChange(Sender: TObject);
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure VstSerieRGClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  published
    VstNameLabel: TLabel;
    VstNameEdit: TTriaEdit;
    VstSerieRG: TRadioGroup;
    OrtGB: TGroupBox;
      OrtNameLabel: TLabel;
      OrtNameEdit: TTriaEdit;
      OrtGrid: TTriaGrid;
      UpButton: TBitBtn;
      DownButton: TBitBtn;
      LoeschButton: TButton;
      NeuButton: TButton;
    OrtGBPanel: TPanel;
    UebernehmButton: TButton;
    OkButton: TButton;
    CancelButton: TButton;
    HilfeButton: TButton;
    // Eventhandler
    procedure VstNameLabelClick(Sender: TObject);
    procedure OrtNameLabelClick(Sender: TObject);
    procedure OrtNameEditChange(Sender: TObject);
    procedure OrtGridClick(Sender: TObject);
    procedure OrtGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
                              State: TGridDrawState);
    //procedure AendButtonClick(Sender: TObject);
    procedure NeuButtonClick(Sender: TObject);
    procedure LoeschButtonClick(Sender: TObject);
    procedure UebernehmButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

  private
    HelpFensterAlt: TWinControl;
    Updating       : Boolean;
    DisableButtons : Boolean;
    NeuEingabe     : Boolean;
    OrtAktuell     : TOrtObj;
    procedure InitDaten;
    procedure InitOrtDaten;
    //procedure   SetVstName;
    //function    GetVstName: String;
    //procedure   SetVstSerieRG;
    function    GetVstSerieRG: Boolean;
    function    VstAendern: Boolean;
    function    VstGeAendert: Boolean;
    procedure   SetOrtName;
    //procedure   SetOrtGB;
    procedure   SetButtons;
    function    OrtDoppel: Boolean;
    function    OrtNeu: Boolean;
    procedure   OrtLoeschen;
    function    EingabeOk: Boolean;
  end;

var
  VstOrtDialog: TVstOrtDialog;

implementation

{$R *.dfm}

uses LstFrm,TriaMain,CmdProc,TlnErg,WettkObj,VistaFix;


(******************************************************************************)
procedure VeranstaltungDefinieren;
(******************************************************************************)
begin
  if Veranstaltung = nil then Exit;
  VstOrtDialog := TVstOrtDialog.Create(HauptFenster);
  try
    if VstOrtDialog.ShowModal = mrOk then
      HauptFenster.RefreshAnsicht; //FSortOrt neu gesetzt, wenn nicht mehr vorhanden
  finally
    FreeAndNil(VstOrtDialog);
  end;
end;

(******************************************************************************)
(* Methoden von TVstOrtDialog                                                 *)
(******************************************************************************)

// public Methoden

(*============================================================================*)
constructor TVstOrtDialog.Create(AOwner: TComponent);
(*============================================================================*)
begin
  // Veranstaltung <> nil ist vorher geprüft
  inherited Create(AOwner);
  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  Updating := false;
  DisableButtons := false;
  
  VstNameEdit.TabOrder := 0;

  // OrtGB.Caption grau darstellen wenn disabled
  OrtGBPanel.Width := Canvas.TextWidth(OrtGB.Caption);
  OrtGBPanel.Top   := OrtGB.Top;
  OrtGBPanel.Left  := OrtGB.Left+8;

  OrtGrid.Canvas.Font := OrtGrid.Font;
  OrtGrid.DefaultRowHeight := OrtGrid.Canvas.TextHeight('Tg')+1;
  OrtGrid.TopAbstand := 0;
  OrtGrid.Init(Veranstaltung.OrtColl,smNichtSortiert,ssVertical,nil);

  // InitDaten in OnShow-Event

  OkButton.Default := true;
  CancelButton.Cancel := true;
  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);
end;

(*============================================================================*)
destructor TVstOrtDialog.Destroy;
(*============================================================================*)
begin
  HelpFenster := HelpFensterAlt;
  inherited Destroy;
end;


// Private Methoden

//------------------------------------------------------------------------------
procedure TVstOrtDialog.InitDaten;
//------------------------------------------------------------------------------
begin
  Updating := true;
  VstNameEdit.Text := Veranstaltung.Name;
  if Veranstaltung.Serie then VstSerieRG.ItemIndex := 1
                         else VstSerieRG.ItemIndex := 0;
  if VstSerieRG.ItemIndex = 1 then
    OrtGrid.ItemIndex := Veranstaltung.OrtIndex; // OrtIndex >= 0
  InitOrtDaten;
  Updating := false;
end;

//------------------------------------------------------------------------------
procedure TVstOrtDialog.InitOrtDaten;
//------------------------------------------------------------------------------
begin
  if GetVstSerieRG then
  begin
    OrtGB.Enabled := true;
    OrtGBPanel.Hide;
    OrtNameLabel.Enabled := true;
    OrtNameEdit.Enabled := true;
    OrtGrid.Enabled := true;
    OrtGrid.Font.Color := clWindowText;
    if (OrtGrid.ItemCount = 1) and
       (TOrtObj(OrtGrid.Items[0]).Name = '') then NeuEingabe := true
    else NeuEingabe := false;
  end else
  begin
    OrtGB.Enabled := false;
    OrtGBPanel.Show;
    OrtNameLabel.Enabled := false;
    OrtNameEdit.Enabled := false;
    OrtGrid.Enabled := false;
    OrtGrid.ItemIndex := -1;
    OrtGrid.Font.Color := clGrayText;
    NeuEingabe := false;
  end;
  if NeuEingabe then
    if OrtNameEdit.CanFocus then OrtNameEdit.SetFocus
    else
  else if OrtGrid.CanFocus then OrtGrid.SetFocus;

  SetOrtName; // incl. SetButtons
end;

(*----------------------------------------------------------------------------*)
procedure TVstOrtDialog.SetOrtName;
(*----------------------------------------------------------------------------*)
begin
  if OrtGB.Enabled then OrtAktuell := TOrtObj(OrtGrid.FocusedItem)
                   else OrtAktuell := nil;
  if OrtAktuell <> nil then OrtNameEdit.Text := OrtAktuell.Name
                       else OrtNameEdit.Text := '';
  SetButtons;
end;

(*----------------------------------------------------------------------------*)
function TVstOrtDialog.GetVstSerieRG: Boolean;
(*----------------------------------------------------------------------------*)
begin
  if VstSerieRG.ItemIndex = 1 then Result := true
                              else Result := false;
end;

(*----------------------------------------------------------------------------*)
function TVstOrtDialog.VstGeAendert: Boolean;
(*----------------------------------------------------------------------------*)
begin
  Result := not StrGleich(VstNameEdit.Text,Veranstaltung.Name) or
            (GetVstSerieRG <> Veranstaltung.Serie) or
            GetVstSerieRG and (OrtAktuell<>nil) and
            not StrGleich(OrtAktuell.Name,OrtNameEdit.Text);
end;

(*----------------------------------------------------------------------------*)
function TVstOrtDialog.VstAendern: Boolean;
(*----------------------------------------------------------------------------*)
// ausgeführt wenn OkButton oder UebernehmButton gedruckt wird
var i : Integer;
    //Update: Boolean;
begin
  Result := false;
  if not EingabeOK then Exit;

  // geänderte Daten speichern
  Refresh;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    // Name ändern
    if not StrGleich(Veranstaltung.Name,VstNameEdit.Text) then
    begin
      Veranstaltung.Name := Trim(VstNameEdit.Text);
      if VstNameEdit.CanFocus then VstNameEdit.SetFocus;
      VstNameEdit.Text := Veranstaltung.Name;
    end;

    // Art ändern
    if GetVstSerieRG <> Veranstaltung.Serie then
    with Veranstaltung do
    begin
      for i:=0 to WettkColl.Count-1 do
        WettkColl[i].KlassenModified := true; // Klassen abhängig von Vst.Art
      if not GetVstSerieRG then // Einzel
      begin
        TlnColl.SetAlleSerienWrtg(false);
        for i:=0 to WettkColl.Count-1 do
          with WettkColl[i] do Name := OrtStandTitel[0];
        if (OrtZahl > 0) and (OrtColl.Items[0].Name <> '') then
          // auch OrtDaten für Tln und Mannsch werden gelöscht, wurde vorher bestätigt
          for i:=OrtZahl-1 downto 0 do OrtColl.ClearIndex(i);
        Serie := false;
      end else // Serie
      begin
        TlnColl.SetAlleSerienWrtg(true);
        Serie := true;
      end;
      if VstSerieRG.CanFocus then VstSerieRG.SetFocus;
    end;

    // Ort ändern
    if GetVstSerieRG and (OrtAktuell <> nil) and
       (OrtAktuell.Name <> Trim(OrtNameEdit.Text)) then
    begin
      OrtAktuell.Name := Trim(OrtNameEdit.Text);
      if NeuEingabe then
        // neu berechnen wegen Serienwertung, reicht eigentlich für 1 Ort
        for i:=0 to Veranstaltung.WettkColl.Count-1 do
          with Veranstaltung.WettkColl[i] do
            OrtErgModified[-1] := true;
      NeuEingabe := false; // vor Update
      OrtGrid.CollectionUpdate;
      OrtGrid.Refresh;
      OrtGrid.FocusedItem := OrtAktuell;
      if OrtGrid.CanFocus then OrtGrid.SetFocus;
      SetOrtName;
    end;

    SetButtons;
    TriDatei.Modified := true;
    HauptFenster.LstFrame.UpdateOrtColBreite;
    HauptFenster.LstFrame.UpdateColWidths; // Cols spSer anpassen
    Result := true;

  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;

end;

(*----------------------------------------------------------------------------*)
procedure TVstOrtDialog.SetButtons;
(*----------------------------------------------------------------------------*)
begin
  if OrtGB.Enabled and (OrtAktuell<>nil) then
  begin
    if OrtGrid.Collection.IndexOf(OrtAktuell) = 0 then
      UpButton.Enabled := false
    else UpButton.Enabled := true;
    if OrtGrid.Collection.IndexOf(OrtAktuell) = OrtGrid.ItemCount-1 then
      DownButton.Enabled := false
    else DownButton.Enabled := true;

    if NeuEingabe then
      NeuButton.Enabled := false
    else
      NeuButton.Enabled := true;

    if (OrtGrid.ItemCount=1) and StrGleich(TOrtObj(OrtGrid.Items[0]).Name,'') and
       StrGleich(OrtNameEdit.Text,'') then // Anfangs Zustand
      LoeschButton.Enabled := false
    else
      LoeschButton.Enabled := true;

  end else
  begin
    UpButton.Enabled     := false;
    DownButton.Enabled   := false;
    NeuButton.Enabled    := false;
    LoeschButton.Enabled := false;
  end;

  if VstGeAendert then
  begin
    OkButton.Default        := false;
    UebernehmButton.Enabled := true;
    UebernehmButton.Default := true;
  end else
  begin
    UebernehmButton.Default := false;
    UebernehmButton.Enabled := false;
    OkButton.Default        := true;
  end;
end;

(*----------------------------------------------------------------------------*)
function TVstOrtDialog.OrtDoppel: Boolean;
(*----------------------------------------------------------------------------*)
var i : Integer;
begin
  Result := false;
  for i:=0 to OrtGrid.ItemCount-1 do
    if (OrtAktuell <> nil) and (OrtAktuell <> OrtGrid.Items[i]) and
        StrGleich(TOrtObj(OrtGrid.Items[i]).Name,OrtNameEdit.Text) then
    begin
      Result := true;
      Exit;
    end;
end;

(*----------------------------------------------------------------------------*)
function TVstOrtDialog.OrtNeu: Boolean;
(*----------------------------------------------------------------------------*)
  // OrtNeu nur enabled wenn keine Daten geändert sind
var Ort: TOrtObj;
begin
  Result := false;
  if VstGeAendert and not VstAendern then Exit;

  if Veranstaltung.OrtColl.Count >= seOrtMax then
  begin
    TriaMessage(Self,'Maximale Ortszahl erreicht.',mtInformation,[mbOk]);
    SetOrtName; (* Änderung rückgängig machen *)
    Exit;
  end;

  Refresh;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    Ort := TOrtObj.Create(Veranstaltung,Veranstaltung.OrtColl,oaNoAdd);
    NeuEingabe := true;  // vor AddItem
    OrtGrid.AddItem(Ort);
    OrtGrid.Refresh; // Refresh in TriaGrid.AddItem entfernt !!!!!!!!!!!!!
    OrtGrid.FocusedItem := Ort;
    SetOrtName; // OrtAktuell wird gesetzt
    if OrtNameEdit.CanFocus then OrtNameEdit.SetFocus;
    HauptFenster.LstFrame.UpdateOrtColBreite;
    Result := true;
  finally
    HauptFenster.UpdateAnsicht;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TVstOrtDialog.OrtLoeschen;
(*----------------------------------------------------------------------------*)
// OrtAktuell entfernen
var i:Integer;
begin
  if OrtAktuell = nil then Exit;
  if not NeuEingabe then
    if OrtGrid.ItemCount <= seOrtMin then
      if Veranstaltung.TlnColl.OrtTlnEingeteilt(Veranstaltung.Ortcoll.IndexOf(OrtAktuell),
                                     WettkAlleDummy) > 0 then
        if TriaMessage(Self,'Für Serie müssen mindestens '+IntToStr(seOrtMin)+
                       ' Ortsnamen eingegeben werden.'+#13+
                       'Ort ' + OrtAktuell.Name +
                       ' sowie die dafür eingegebenen Teilnehmerdaten löschen?',
                        mtConfirmation,[mbOk,mbCancel]) <> mrOk then Exit
        else
      else
        if TriaMessage(Self,'Für Serie müssen mindestens '+IntToStr(seOrtMin)+
                       ' Ortsnamen eingegeben werden.'+#13+
                       'Ort ' + OrtAktuell.Name + ' löschen?',
                        mtConfirmation,[mbOk,mbCancel]) <> mrOk then Exit
        else
    else
      if Veranstaltung.TlnColl.OrtTlnEingeteilt(Veranstaltung.Ortcoll.IndexOf(OrtAktuell),
                                     WettkAlleDummy) > 0 then
        if TriaMessage(Self,'Ort ' + OrtAktuell.Name +
                       ' sowie die dafür eingegebenen Teilnehmerdaten löschen?',
                        mtConfirmation,[mbOk,mbCancel]) <> mrOk then Exit
        else
      else
        if TriaMessage(Self,'Ort ' + OrtAktuell.Name + ' löschen?',
                        mtConfirmation,[mbOk,mbCancel]) <> mrOk then Exit;


  Refresh;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    if not NeuEingabe then
    begin
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
        with Veranstaltung.WettkColl[i] do
          OrtErgModified[-1] := true;
      TriDatei.Modified := true;
    end;
    NeuEingabe := false; // vor ClearItem
    OrtGrid.ClearItem(OrtAktuell);   (* OrtAktuell löschen *)
    if (OrtGrid.ItemCount = 1) and
       (TOrtObj(OrtGrid.Items[0]).Name = '') then NeuEingabe := true;
    OrtGrid.CollectionUpdate;
    OrtGrid.Refresh;
    SetOrtName;
    if NeuEingabe then
      if OrtNameEdit.CanFocus then OrtNameEdit.SetFocus
      else
    else if OrtGrid.CanFocus then OrtGrid.SetFocus;
    HauptFenster.LstFrame.UpdateOrtColBreite;
  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;
end;

(*----------------------------------------------------------------------------*)
function TVstOrtDialog.EingabeOk: Boolean;
(*----------------------------------------------------------------------------*)
var i : Integer;
    OrtWkDefiniert : Boolean;
begin
  Result := false;
  if Trim(VstNameEdit.Text) = '' then
  begin
    TriaMessage(Self,'Veranstaltungsname fehlt.',mtInformation,[mbOk]);
    if VstNameEdit.CanFocus then VstNameEdit.SetFocus;
    Exit;
  end;
  if GetVstSerieRG then
  begin
    if not NeuEingabe and (Trim(OrtNameEdit.Text) = '') then
    begin
      TriaMessage(Self,'Ortsname fehlt.',mtInformation,[mbOk]);
      if OrtNameEdit.CanFocus then OrtNameEdit.SetFocus;
      Exit;
    end;
    if OrtDoppel then
    begin
      TriaMessage(Self,'Ortsname ist bereits vorhanden.',mtInformation,[mbOk]);
      if OrtNameEdit.CanFocus then OrtNameEdit.SetFocus;
      Exit;
    end;
  end else // Einzel
    if Veranstaltung.Serie and
       (Veranstaltung.OrtZahl > 0) and (Veranstaltung.OrtColl.Items[0].Name <> '') then
    begin
      OrtWkDefiniert := false;
      for i:=1 to Veranstaltung.OrtZahl-1 do
        if (Veranstaltung.WettkColl.Count > 0) and (Veranstaltung.WettkColl[0].Name <> '') then
        begin
          OrtWkDefiniert := true;
          Break;
        end;
      if OrtWkDefiniert and // es wurden Ortnamen mit Daten definiert
         (TriaMessage(Self,'Alle Ortsnamen löschen?'+#13+
                      'Achtung:'+#13+
                      'Nur die für den Ort  "'+Veranstaltung.OrtColl.Items[0].Name+
                      '"  eingegebenen Daten bleiben erhalten.',
                       mtConfirmation,[mbCancel,mbOk]) <> mrOk) then
      begin
        VstSerieRG.ItemIndex := 1; // Alter Wert (Serie) setzen
        Exit;
      end;
    end;

  Result := true;
end;


// published Methoden

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.VstNameLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not Updating then
    if VstNameEdit.CanFocus then VstNameEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.VstNameEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not Updating then SetButtons;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TVstOrtDialog.VstSerieRGClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then InitOrtDaten;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.VeranstArtRBClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not Updating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.OrtNameLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not Updating then
    if OrtNameEdit.CanFocus then OrtNameEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.OrtNameEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
    if not Updating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.OrtGridClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// ausgeführt beim Clicken UND beim Setzen von FocusedItem oder ItemIndex
var Ort: TOrtObj;
begin
  (* Exit beim Setzen von FocusedItem oder ItemIndex *)
  if not OrtGrid.EnableOnClick then Exit
  else OrtGrid.EnableOnClick := false;

  try
    Ort := TOrtObj(OrtGrid.FocusedItem);
    if (Ort = nil) or (OrtAktuell = nil) then Exit;

    if not StrGleich(OrtAktuell.Name,OrtNameEdit.Text) then
    begin
      OrtGrid.ScrollBars := ssNone; // weiteres Scrollen verhindern
      // OrtAktuell war vor Click Focussiert
      case TriaMessage(Self,'Ortsname wurde geändert.'+#13+
                       'Änderung übernehmen?',
                        mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes : if VstAendern then SetOrtName
                              else OrtGrid.FocusedItem := OrtAktuell;
        mrNo  : if (Ort<>OrtAktuell) and NeuEingabe then OrtLoeschen
                else SetOrtName;
        else    OrtGrid.FocusedItem := OrtAktuell;
      end;
    end else
    if (Ort<>OrtAktuell) and NeuEingabe then OrtLoeschen
    else SetOrtName; (* hier wird auch OrtAktuell neu gesetzt *)

  finally
    OrtGrid.ScrollBars := ssVertical;
    OrtGrid.EnableOnClick := true;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.OrtGridDrawCell(Sender: TObject; ACol, ARow: Integer;
                                        Rect: TRect; State: TGridDrawState);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var Text : String;
begin
  with OrtGrid do
  begin
    if Enabled and (Collection <> nil) and (ARow < ItemCount) then // FixedRows = 0
      Text := TOrtObj(Collection[ARow]).Name
    else Text := ''; // dummy leerzeile wenn itemcount = 0, leer wenn disabled
    DrawCellText(Rect,Text,taLeftJustify);
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.NeuButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    OrtNeu;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.LoeschButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    OrtLoeschen;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.UebernehmButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var Neu:Boolean;
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    Neu := NeuEingabe;
    if VstGeAendert and not VstAendern then Exit;
    if Neu then
      if (Trim(OrtNameEdit.Text) <> '') and // falls VstName oder VstSerieGB geändert wurden
         (Veranstaltung.OrtColl.Count < seOrtMax) then
        OrtNeu
      else
      if OrtNameEdit.CanFocus then OrtNameEdit.SetFocus;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.UpButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var OrtAlt : TOrtObj;
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if DisableButtons then Exit;

  DisableButtons := true;
  OrtAlt := Veranstaltung.Ort; // über OrtIndex definiert, die sich ändern kann
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    Veranstaltung.OrtColl.OrtCollExch(OrtGrid.ItemIndex,OrtGrid.ItemIndex-1);
    OrtGrid.Refresh;
    OrtGrid.FocusedItem := OrtAktuell;
    Veranstaltung.OrtIndex := Veranstaltung.OrtColl.IndexOf(OrtAlt);
    HauptFenster.LstFrame.UpdateOrtColBreite;
    TriDatei.Modified := true;
    SetButtons;
    HauptFenster.RefreshAnsicht; // OrtListe neu
  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.DownButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var OrtAlt : TOrtObj;
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if DisableButtons then Exit;

  DisableButtons := true;
  OrtAlt := Veranstaltung.Ort; // über OrtIndex definiert, die sich ändern kann
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    Veranstaltung.OrtColl.OrtCollExch(OrtGrid.ItemIndex,OrtGrid.ItemIndex+1);
    OrtGrid.Refresh;
    OrtGrid.FocusedItem := OrtAktuell;
    Veranstaltung.OrtIndex := Veranstaltung.OrtColl.IndexOf(OrtAlt);
    HauptFenster.LstFrame.UpdateOrtColBreite;
    TriDatei.Modified := true;
    SetButtons;
    HauptFenster.RefreshAnsicht; // OrtListe neu
  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.OkButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    if not EingabeOk then Exit;
    if NeuEingabe and (Trim(OrtNameEdit.Text) = '') then
    begin
      OrtGrid.ClearItem(OrtAktuell);
      SetOrtName; // sonst Exception in VstGeAendert
    end;
    if VstGeAendert and not VstAendern then Exit;
    ModalResult := mrOk;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.HilfeButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  Application.HelpContext(0300);  // Veranstaltung
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.CancelButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  ModalResult := mrCancel; (* Prüfung in FormCloseQuery *)
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TVstOrtDialog.FormShow(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  InitDaten;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TVstOrtDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if ModalResult = mrCancel then
  begin
    if VstGeAendert and
       (TriaMessage(Self,'Die Veranstaltungsdaten wurden geändert.'+#13+
                    'Fenster ohne speichern der Daten schließen?',
                     mtConfirmation,[mbOk,mbCancel]) <> mrOk) then
    begin
      CanClose := false;
      if NeuEingabe then
        if OrtNameEdit.CanFocus then OrtNameEdit.SetFocus
        else
      else
        if VstNameEdit.CanFocus then VstNameEdit.SetFocus;
      Exit;
    end;
    CanClose := true;
    // neuer Ortsname mit oder ohne Eingaben wird gelöscht
    if NeuEingabe then
      OrtGrid.ClearItem(OrtAktuell);
  end
  else // mrOk
  if GetVstSerieRG and (OrtGrid.ItemCount < seOrtMin) and
     (TriaMessage(Self,'Für eine Serienverantaltung müssen mindestens '+IntToStr(seOrtMin)+
                  ' Ortsnamen eingegeben werden.'+#13+
                  'Fenster trotzdem schließen?',
                   mtConfirmation,[mbOk,mbCancel]) <> mrOk) then
  begin
    CanClose := false;
    OrtNeu;
  end
  else
    CanClose := true;
end;


end.
