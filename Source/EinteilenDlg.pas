unit EinteilenDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math,
  AllgComp,AllgConst,AllgFunc,AllgObj,AkObj,WettkObj,TlnObj,VeranObj,SGrpObj,
  StdCtrls, ComCtrls, Mask, Grids, ExtCtrls;

procedure TlnEinteilen(EinteilungMode: TEinteilungMode);

type
  TEinteilenDialog = class(TForm)
    WettkCBLabel: TLabel;
    WettkCB: TComboBox;

    SGrpGB: TGroupBox;
    SGrpAlleRB: TRadioButton;
    SGrpMarkiertRB: TRadioButton;
    SGrpGridLabel: TLabel;
    SGrpGrid: TTriaGrid;

    SBhnGB: TGroupBox;
    SBhnAlleRB: TRadioButton;
    SBhnMarkiertRB: TRadioButton;
    SBhnLabel: TLabel;
    TlnProBahnLabel1: TLabel;
    TlnProBahnEdit: TTriaMaskEdit;
    TlnProBahnUpDown: TTriaUpDown;
    TlnProBahnLabel2: TLabel;
    SBhnGrid: TStringGrid;

    SnrBereichGB: TGroupBox;
    SnrVonLabel: TLabel;
    SnrVonEdit: TTriaMaskEdit;
    SnrVonUpDown: TTriaUpDown;
    SnrBisLabel: TLabel;
    SnrBisEdit: TTriaMaskEdit;
    SnrBisUpDown: TTriaUpDown;

    UebersichtGB: TGroupBox;
    NichtEingeteiltLabel: TLabel;
    NichtEingeteiltEdit: TTriaMaskEdit;
    EingeteiltLabel: TLabel;
    EingeteiltEdit: TTriaMaskEdit;

    EinteilungBeibehaltenCB: TCheckBox;

    OkButton: TButton;
    CancelButton: TButton;
    HilfeButton: TButton;

    procedure WettkCBLabelClick(Sender: TObject);
    procedure WettkCBChange(Sender: TObject);

    procedure SGrpRBClick(Sender: TObject);
    procedure SGrpGridLabelClick(Sender: TObject);
    procedure SGrpGridClick(Sender: TObject);
    procedure SGrpGridDrawCell(Sender: TObject; ACol, ARow: Integer;
                               Rect: TRect; State: TGridDrawState);

    procedure SBhnLabelClick(Sender: TObject);
    procedure SBhnRBClick(Sender: TObject);
    procedure SBhnGridClick(Sender: TObject);

    procedure OkButtonClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);
    procedure TlnProBahnLabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    HelpFensterAlt : TWinControl;
    Updating       : Boolean;
    DisableButtons : Boolean;
    SGrpCount      : array[0..cnSGrpMax] of Integer;
    TlnLst         : TList;
    SnrBelegtArr   : array[1..cnTlnMax] of Boolean; // kostet zeit,vorher berechnen
    AktSnr         : Integer;
    function  WettkSelected: TWettkObj;
    procedure SetWkDaten;
    procedure UpdateUebersicht;
    procedure UpdateSGrpAuswahl;
    procedure UpdateSBhnAuswahl;
    procedure UpdateSnrAuswahl;
    procedure UpdateSGrpGrid;
    procedure UpdateSBhnGrid;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

  end;

var
  EinteilenDialog   : TEinteilenDialog;
  Modus             : TEinteilungMode;

implementation

uses TriaMain,CmdProc,DateiDlg,TlnErg,VistaFix;

{$R *.dfm}

//******************************************************************************
procedure TlnEinteilen(EinteilungMode: TEinteilungMode);
//******************************************************************************
// Modus = emEinteilen : Einteilung in SGrp, SBhn und Startnummern für gelistete Tln
// Modus = emLoeschen  : Löschung der vorhandenen Einteilung
begin
  Modus := EinteilungMode;
  EinteilenDialog := TEinteilenDialog.Create(HauptFenster);
  try
    EinteilenDialog.ShowModal;
  finally
    FreeAndNil(EinteilenDialog);
  end;
  HauptFenster.RefreshAnsicht;
end;

// public Methoden

(*============================================================================*)
constructor TEinteilenDialog.Create(AOwner: TComponent);
(*============================================================================*)
var i : integer;
begin
  inherited Create(AOwner);
  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  Updating       := false;
  DisableButtons := false;
  if Modus = emLoeschen then
  begin
    Caption := 'Einteilung von Teilnehmern löschen';
    SGrpGB.Caption := 'Startgruppen löschen';
    SBhnGB.Caption := 'Startbahnen löschen';
    TlnProBahnEdit.Hide;
    TlnProBahnUpDown.Hide;
    TlnProBahnLabel1.Hide;               
    TlnProBahnLabel2.Hide;
    SBhnGB.Height := SBhnGB.Height - 35;
    SBhnGrid.Height := SBhnGrid.Height - 35;
    //SBhnAlleRB.Top := SBhnAlleRB.Top + 5;
    //SBhnMarkiertRB.Top := SBhnMarkiertRB.Top + 5;
    SBhnAlleRB.Caption := 'Alle Startbahnen';
    SnrBereichGB.Top := SnrBereichGB.Top - 35;
    UebersichtGB.Top := UebersichtGB.Top - 35;

    WettkCB.HelpContext := 3751;
    SGrpGB.HelpContext := 3752;
    SGrpAlleRB.HelpContext := 3752;
    SGrpMarkiertRB.HelpContext := 3752;
    SGrpGridLabel.HelpContext := 3753;
    SGrpGrid.HelpContext := 3753;
    SBhnGB.HelpContext := 3754;
    SBhnAlleRB.HelpContext := 3754;
    SBhnMarkiertRB.HelpContext := 3754;
    TlnProBahnLabel1.HelpContext := 3754;
    TlnProBahnEdit.HelpContext := 3754;
    TlnProBahnUpDown.HelpContext := 3754;
    TlnProBahnLabel2.HelpContext := 3754;
    SBhnLabel.HelpContext := 3755;
    SBhnGrid.HelpContext := 3755;
    SnrBereichGB.HelpContext := 3756;
    SnrVonLabel.HelpContext := 3756;
    SnrVonEdit.HelpContext := 3756;
    SnrVonUpDown.HelpContext := 3756;
    SnrBisLabel.HelpContext := 3756;
    SnrBisEdit.HelpContext := 3756;
    SnrBisUpDown.HelpContext := 3756;
    OkButton.HelpContext := 3758;

    SnrBereichGB.Caption := 'Startnummern löschen';
    EinteilungBeibehaltenCB.Hide;
    OkButton.Width := OkButton.Width + OkButton.Left - SGrpGrid.Left;
    OkButton.Left := SGrpGrid.Left;
    OkButton.Top := OkButton.Top - 25;
    OkButton.Caption := 'Einteilung löschen';
    CancelButton.Top := OkButton.Top;
    HilfeButton.Top := OkButton.Top;
    Height := Height - 25;
  end else
    EinteilungBeibehaltenCB.Checked := true;

  if Veranstaltung.Serie then
    Caption := Caption + '  -  ' + Veranstaltung.OrtName;

  with Veranstaltung do
  if HauptFenster.SortWettk = WettkAlleDummy then
  begin
    for i:=0 to WettkColl.Count-1 do
      WettkCB.Items.AddObject(WettkColl.Items[i].Name,WettkColl.Items[i]);
    if WettkCB.Items.IndexOf(HauptFenster.SortWettk.Name) >= 0 then
      WettkCB.ItemIndex := WettkCB.Items.IndexOf(HauptFenster.SortWettk.Name)
    else WettkCB.ItemIndex := 0;
    WettkCB.Enabled := true;
  end else
  begin
    WettkCB.Items.AddObject(HauptFenster.SortWettk.Name,HauptFenster.SortWettk);
    WettkCB.ItemIndex := 0;
    WettkCB.Enabled := false;
  end;

  with SGrpGrid do
  begin
    FixedCols := 0;
    FixedRows := 1;
    Canvas.Font := Font;
    DefaultRowHeight := 17; //SgrpGrid.Canvas.TextHeight('Tg')+1;
    TopAbstand := (DefaultRowHeight - Canvas.TextHeight('Tg')) DIV 2; // =2
    ColCount := 5;
    //ColWidths[0] := Canvas.TextWidth(' SGrp-Name ');
    ColWidths[1] := Canvas.TextWidth('  00:00:00.00  ');
    ColWidths[2] := 45;
    ColWidths[3] := 45;
    ColWidths[4] := 45;
    ColWidths[0] := ClientWidth-ColWidths[1]-ColWidths[2]-ColWidths[3]-ColWidths[4]-4;
    Init(Veranstaltung.SGrpColl,smSortiert,ssVertical,nil);
  end;

  with SBhnGrid do
  begin
    FixedCols := 0;
    FixedRows := 1;
    Canvas.Font := Font;
    DefaultRowHeight := 17;  //SBhnGrid.Canvas.TextHeight('Tg')+1;
    ScrollBars := ssNone;
    ColCount := 2;
    ColWidths[0] := 45;
    ColWidths[1] := ClientWidth - ColWidths[0] - 1;
    ScrollBars := ssVertical;
  end;

  // Aktuelle Sortliste festhalten, weil diese sich bei Einteilung/Löschung ändert
  TlnLst := TList.Create;
  for i:=0 to Veranstaltung.TlnColl.SortCount-1 do
    TlnLst.Add(Veranstaltung.TlnColl.SortItems[i]);

  // SnrBelegtArr initialisieren, Initwert = false
  for i:=0 to Veranstaltung.TlnColl.Count-1 do
    with Veranstaltung.TlnColl[i] do
      if Snr <> 0 then SnrBelegtArr[Snr] := true;

  TlnProBahnEdit.EditMask := '09;0; ';
  TlnProBahnUpDown.Min := 1;
  TlnProBahnUpDown.Max := 99;
  TlnProBahnEdit.Text  := IntToStr(cnTlnProBahnDefault);
  TlnProBahnUpDown.Position := cnTlnProBahnDefault;

  SnrVonEdit.EditMask := '0999;0; ';
  SnrBisEdit.EditMask := '0999;0; ';

  SetWkDaten;

  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);
end;


(*============================================================================*)
destructor TEinteilenDialog.Destroy;
(*============================================================================*)
begin
  FreeAndNil(TlnLst);
  HelpFenster := HelpFensterAlt;
  inherited Destroy;
end;

procedure TEinteilenDialog.FormCreate(Sender: TObject);
begin

end;

// private Methoden

//------------------------------------------------------------------------------
function TEinteilenDialog.WettkSelected: TWettkObj;
//------------------------------------------------------------------------------
begin
  if WettkCB.ItemIndex >= 0 then
    Result := TWettkObj(WettkCB.Items.Objects[WettkCB.ItemIndex])
  else Result := nil; // illegal
end;

//------------------------------------------------------------------------------
procedure TEinteilenDialog.SetWkDaten;
//------------------------------------------------------------------------------
// bei Create und Wettk-Change
begin
  if WettkSelected = nil then Exit;
  Updating := true;
  try
    UpdateUebersicht;
    UpdateSGrpAuswahl;
    UpdateSBhnAuswahl;
    UpdateSnrAuswahl;
  finally
    Updating := false;
  end;
end;

//------------------------------------------------------------------------------
procedure TEinteilenDialog.UpdateUebersicht;
//------------------------------------------------------------------------------
var i,n,m : Integer;
begin
  if WettkSelected <> nil then
  begin
    n := 0;
    m := 0;
    for i:=0 to TlnLst.Count-1 do with TTlnObj(TlnLst[i]) do
      if Wettk=WettkSelected then
      begin
        Inc(n);
        if TlnInStatus(stEingeteilt) then Inc(m);
      end;
    NichtEingeteiltEdit.Text := IntToStr(n - m);
    EingeteiltEdit.Text      := IntToStr(m);
  end else
  begin
    NichtEingeteiltEdit.Text := '';
    EingeteiltEdit.Text := '';
  end;
end;

//------------------------------------------------------------------------------
procedure TEinteilenDialog.UpdateSGrpAuswahl;
//------------------------------------------------------------------------------
var i  : Integer;
    UpdatingAlt : Boolean;
begin
  if WettkSelected = nil then Exit;
  UpdatingAlt := Updating;
  Updating := true;
  try
    // Grid
    // nach Startzeit, Snr, Name sortiert
    Veranstaltung.SGrpColl.Sortieren(Veranstaltung.OrtIndex,WettkSelected);
    SGrpGrid.CollectionUpdate;
    SGrpGrid.Refresh;
    for i:=0 to SGrpGrid.ItemCount-1 do
      SGrpCount[i] := Veranstaltung.TlnColl.SGrpTlnZahl(TSGrpObj(SGrpGrid[i]));
    SGrpGrid.Refresh;

    // Bereich
    if SGrpGrid.ItemCount = 0 then
    begin
      SGrpGrid.Font.Color   := clGrayText;
      SGrpGrid.ItemIndex    := -1;
      SGrpGrid.Enabled      := false;
      SGrpGridLabel.Enabled := false;
      SGrpAlleRB.Enabled        := false;
      SGrpMarkiertRB.Enabled    := false;
      SGrpAlleRB.Checked        := false;
      SGrpMarkiertRB.Checked    := false;
    end else
    if SGrpGrid.ItemCount = 1 then
    begin
      SGrpGrid.Font.Color   := clWindowText;
      SGrpGrid.ItemIndex    := 0;
      SGrpGrid.Enabled      := true;
      SGrpGridLabel.Enabled := true;
      SGrpAlleRB.Enabled        := false;
      SGrpMarkiertRB.Enabled    := true;
      SGrpAlleRB.Checked        := false;
      SGrpMarkiertRB.Checked    := true;
    end else // > 1
    begin
      SGrpGrid.Font.Color   := clWindowText;
      SGrpGrid.ItemIndex    := 0;
      SGrpGrid.Enabled      := true;
      SGrpGridLabel.Enabled := true;
      SGrpAlleRB.Enabled        := true;
      SGrpMarkiertRB.Enabled    := true;
      if not SGrpAlleRB.Checked and not SGrpMarkiertRB.Checked then
        SGrpMarkiertRB.Checked  := true;
    end;

  finally
    Updating := UpdatingAlt;
  end;
end;

//------------------------------------------------------------------------------
procedure TEinteilenDialog.UpdateSBhnAuswahl;
//------------------------------------------------------------------------------
var i : Integer;
    UpdatingAlt : Boolean;
begin
  if WettkSelected = nil then Exit;
  UpdatingAlt := Updating;
  Updating := true;
  try
    with SBhnGrid do
    begin
      if (WettkSelected.StartBahnen > 0) and
         SGrpMarkiertRB.Checked and (SGrpGrid.FocusedItem <> nil) then // gültige SGrp
      begin
        // Grid
        Font.Color := clWindowText;
        RowCount := WettkSelected.StartBahnen + 1;
        Cells[0,0] := 'Bahn';
        Cells[1,0] := 'Teiln.';
        for i:=1 to RowCount-1 do
        begin
          Cells[0,i] := ' '+Strng(i,2);
          Cells[1,i] := ' '+Strng(Veranstaltung.TlnColl.SBhnTlnZahl(TSGrpObj(SGrpGrid.FocusedItem),i),4);
        end;
        SBhnLabel.Enabled := true;
        Enabled := true;

        // Bereich
        if SBhnGrid.RowCount <= 2 then // <= 1 Bahn
        begin
          SBhnAlleRB.Enabled     := false;
          SBhnAlleRB.Checked     := false;
          SBhnMarkiertRB.Enabled := true;
          SBhnMarkiertRB.Checked := true;
        end else // > 1 Bahn
        begin
          SBhnAlleRB.Enabled     := true;
          SBhnMarkiertRB.Enabled := true;
          if not SBhnAlleRB.Checked and not SBhnMarkiertRB.Checked then
            SBhnAlleRB.Checked := true; // else alter Zustand behalten
        end;
        TlnProBahnLabel1.Enabled  := true;
        TlnProBahnEdit.Enabled    := true;
        TlnProBahnUpDown.Enabled  := true;
        TlnProBahnLabel2.Enabled  := true;
        SBhnGB.Enabled            := true;
      end else
      begin
        // Grid
        Font.Color := clGrayText;
        RowCount := 2;
        Cells[0,0] := 'Bahn'; // nach RowCount-Änderung, weil dabei gelöscht wird
        Cells[1,0] := 'Teiln.';
        Cells[0,1] := '';
        Cells[1,1] := '';
        SBhnLabel.Enabled := false;
        Enabled := false;

        // Bereich
        if (WettkSelected.StartBahnen > 0) and SGrpAlleRB.Checked then
        begin
          SBhnAlleRB.Enabled        := true;
          SBhnMarkiertRB.Enabled    := false;
          SBhnAlleRB.Checked        := true;
          SBhnMarkiertRB.Checked    := false;
          TlnProBahnLabel1.Enabled  := true;
          TlnProBahnEdit.Enabled    := true;
          TlnProBahnUpDown.Enabled  := true;
          TlnProBahnLabel2.Enabled  := true;
          SBhnGB.Enabled            := true;
        end else
        begin
          SBhnAlleRB.Enabled        := false;
          SBhnMarkiertRB.Enabled    := false;
          SBhnAlleRB.Checked        := false;
          SBhnMarkiertRB.Checked    := false;
          TlnProBahnLabel1.Enabled  := false;
          TlnProBahnEdit.Enabled    := false;
          TlnProBahnUpDown.Enabled  := false;
          TlnProBahnLabel2.Enabled  := false;
          SBhnGB.Enabled            := false;
        end;

      end;
      Row := 1;
      Refresh;

    end;

  finally
    Updating := UpdatingAlt;
  end;
end;

//------------------------------------------------------------------------------
procedure TEinteilenDialog.UpdateSnrAuswahl;
//------------------------------------------------------------------------------
var UpdatingAlt : Boolean;
    i,
    MinSnr,MaxSnr : Integer;
begin
  if WettkSelected = nil then Exit;
  UpdatingAlt := Updating;
  Updating := true;
  try
    if SGrpMarkiertRB.Checked and (SGrpGrid.FocusedItem <> nil) then // 1 SGrp markiert
    with TSGrpObj(SGrpGrid.FocusedItem) do
    begin
      MinSnr := StartnrVon;
      MaxSnr := StartnrBis;
    end else // Alle SGrp oder keine SGrp in Liste
    if not SGrpAlleRB.Checked or (SGrpGrid.ItemCount = 0) then
    begin
      MinSnr := 0;
      MaxSnr := 0;
    end else // Alle SGrp
    begin
      MinSnr := cnTlnMax+1;
      MaxSnr := 0;
      with SGrpGrid do
        for i:=0 to SGrpGrid.ItemCount-1 do
        begin
          if TSGrpObj(Items[i]).StartnrVon < MinSnr then
            MinSnr := TSGrpObj(Items[i]).StartnrVon;
          if TSGrpObj(Items[i]).StartnrBis > MaxSnr then
            MaxSnr := TSGrpObj(Items[i]).StartnrBis;
        end;
      if MinSnr > cnTlnMax then MinSnr := 0;
    end;

    SnrVonUpDown.Min := MinSnr;
    SnrVonUpDown.Max := MaxSnr;
    SnrBisUpDown.Min := SnrVonUpDown.Min;
    SnrBisUpDown.Max := SnrVonUpDown.Max;
    SnrVonEdit.Text  := IntToStr(MinSnr);
    SnrVonUpDown.Position := MinSnr;
    SnrBisEdit.Text  := IntToStr(MaxSnr);
    SnrBisUpDown.Position := MaxSnr;

    if MinSnr = 0 then // keine Snr verfügbar
    begin
      SnrVonLabel.Enabled  := false;
      SnrVonEdit.Enabled   := false;
      SnrVonUpDown.Enabled := false;
      SnrBisLabel.Enabled  := false;
      SnrBisEdit.Enabled   := false;
      SnrBisUpDown.Enabled := false;
    end else
    begin
      SnrVonLabel.Enabled  := true;
      SnrVonEdit.Enabled   := true;
      SnrVonUpDown.Enabled := true;
      SnrBisLabel.Enabled  := true;
      SnrBisEdit.Enabled   := true;
      SnrBisUpDown.Enabled := true;
    end;

  finally
    Updating := UpdatingAlt;
  end;
end;

//------------------------------------------------------------------------------
procedure TEinteilenDialog.UpdateSGrpGrid;
//------------------------------------------------------------------------------
var i : Integer;
begin
  with SGrpGrid do
  begin
    for i:=0 to SGrpGrid.ItemCount-1 do
      SGrpCount[i] := Veranstaltung.TlnColl.SGrpTlnZahl(TSGrpObj(SGrpGrid[i]));
    Refresh;
  end;
end;

//------------------------------------------------------------------------------
procedure TEinteilenDialog.UpdateSBhnGrid;
//------------------------------------------------------------------------------
var i : Integer;
begin
  if (WettkSelected.StartBahnen > 0) and
      SGrpMarkiertRB.Checked and (SGrpGrid.FocusedItem <> nil) then // gültige SGrp
    with SBhnGrid do
    begin
      for i:=1 to RowCount-1 do
      begin
        Cells[0,i] := ' '+Strng(i,2);
        Cells[1,i] := ' '+Strng(Veranstaltung.TlnColl.SBhnTlnZahl(TSGrpObj(SGrpGrid.FocusedItem),i),4);
      end;
      Refresh;
    end;
end;

// Event Handler

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.WettkCBLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if WettkCB.CanFocus then WettkCB.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.WettkCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  SetWkDaten;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.SGrpRBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then
  begin
    UpdateSBhnAuswahl;
    UpdateSnrAuswahl;
  end;
end;


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.SGrpGridLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if SGrpGrid.CanFocus then SGrpGrid.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.SGrpGridClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then
  begin
    SGrpMarkiertRB.Checked  := true;
    UpdateSBhnAuswahl;
    UpdateSnrAuswahl;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.SGrpGridDrawCell(Sender: TObject; ACol,
                             ARow: Integer; Rect: TRect; State: TGridDrawState);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var Text : String;
    SGrp : TSGrpObj;
begin
  with SGrpGrid do
  begin
    (* FixedRows = 1 *)
    if (Collection = nil) or
       (ARow > ItemCount) then Text := '' // dummy leerzeile bei Itemcount = 0
    else if ARow=0 then (* Überschrift *)
      case ACol of
        0:  Text := 'Name';
        1:  Text := ' Startzeit';
        2:  Text := 'SnrVon';
        3:  Text := 'SnrBis';
        4:  Text := 'Teiln.';
      end
    else // ARow > 0
    begin
      SGrp := TSGrpObj(Collection.SortItems[ARow-1]);
      case ACol of
        0: Text := SGrp.Name;
        1: Text := ' '+UhrZeitStr(SGrp.StartZeit[wkAbs1]);
        2: Text := '  '+Strng(SGrp.StartNrVon,4);
        3: Text := '  '+Strng(SGrp.StartNrBis,4);
        4: Text := '  '+Strng(SGrpCount[ARow-1],4);
      end;
    end;
    DrawCellText(Rect,Text,taLeftJustify);
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.SBhnRBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then UpdateSnrAuswahl;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.SBhnLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if SBhnGrid.CanFocus then SBhnGrid.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.SBhnGridClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then
  begin
    SBhnMarkiertRB.Checked  := true;
    UpdateSnrAuswahl;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.TlnProBahnLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if TlnProBahnEdit.CanFocus then TlnProBahnEdit.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.OkButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var i,MinSnr,MaxSnr,SGrpZahl,SBhnZahl,TlnSumme : Integer;

//------------------------------------------------------------------------------
function SBhnEinteilen(const SG:TSGrpObj; const SB:Integer): Boolean;
// Result false wenn alle Snr vergeben sind
var TlnSBhn,TlnIndx : Integer;

//..............................................................................
function Einteilen(const Tln:TTlnObj): Boolean;
// nur für nicht eingeteilte Tln aufgerufen
// Result := false wenn alle Snr vergeben
begin
  Result := false; // keine freie Snr
  // erste freie Snr in SG suchen, AktSnr > 0
  while SnrBelegtArr[AktSnr] = true do
    if AktSnr < Min(MaxSnr,SG.StartnrBis) then
      Inc(AktSnr)
    else Exit; // Result false, keine freie Snr
  // einteilen mit AktSnr = erste freie Snr in SG
  with Tln do
  begin
    SGrp := SG;
    SBhn := SB;
    Snr  := AktSnr;
    SnrBelegtArr[AktSnr] := true;
    if SB > 0 then Inc(TlnSBhn);
    Inc(TlnSumme);
    SetzeBearbeitet;
    TriDatei.Modified := true;
  end;
  Result := true; // weiter mit nächster Tln
end;

//..............................................................................
begin
  Result := false;

  // init TlnSBhn für jede SBhn
  if SB > 0 then // Startbahnen definiert
  begin
    TlnSBhn := Veranstaltung.TlnColl.SBhnTlnZahl(SG,SB);
    if TlnSBhn >= StrToIntDef(TlnProBahnEdit.Text,0) then // Bahn voll
    begin
      Result := true; // eventuell weiter mit nächster SBhn
      HauptFenster.ProgressBarStep(TlnLst.Count);
      Exit;
    end;
  end else TlnSBhn := 0;
  // init TlnIndx für jede SBhn
  TlnIndx := 0;

  // SB Einteilen
  while (TlnIndx < TlnLst.Count) and
        (TlnSBhn < StrToIntDef(TlnProBahnEdit.Text,0)) do
  with TTlnObj(TlnLst[TlnIndx]) do
  begin
    HauptFenster.ProgressBarStep(1);
    if (Wettk=WettkSelected) and not TlnInStatus(stEingeteilt) then
      if not Einteilen(TTlnObj(TlnLst[TlnIndx])) then Exit; //Result false, keine freie Snr
    Inc(TlnIndx);
  end;
  HauptFenster.ProgressBarStep(TlnLst.Count - TlnIndx); // <>0 wenn Bahn voll

  Result := true;
end;

//------------------------------------------------------------------------------
procedure SGrpEinteilen(const SG:TSGrpObj);
var SB : Integer;
begin
  // Init AktSnr, erste zu vergebene Snr
  AktSnr := Max(MinSnr,SG.StartnrVon);
  if (AktSnr = 0) or
     (AktSnr > Min(MaxSnr,SG.StartnrBis)) then Exit;
  // Init SB
  if WettkSelected.StartBahnen > 0 then
    if SBhnMarkiertRB.Checked then
      SBhnEinteilen(SG,SBhnGrid.Row)
    else
    if SBhnAlleRB.Checked then
      for SB:=1 to WettkSelected.StartBahnen do
        if not SBhnEinteilen(SG,SB) then Exit // alle Snr in SGrp vergeben
        else
    else Exit
  else
    SBhnEinteilen(SG,0); // ohne SBhn
end;

//------------------------------------------------------------------------------
begin
  // verhindern, dass während Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try

    DisableButtons := true;
    TlnSumme := 0; // Summe der eingeteilten Tln für Meldung am Ende
    HauptFenster.LstFrame.TriaGrid.StopPaint := true;

    if not TlnProBahnEdit.ValidateEdit then Exit;

    MinSnr  := StrToIntDef(SnrVonEdit.Text,0);
    MaxSnr  := StrToIntDef(SnrBisEdit.Text,0);
    if SGrpAlleRB.Checked then SGrpZahl := SGrpGrid.ItemCount
                          else SGrpZahl := 1;
    if WettkSelected.StartBahnen > 0 then
      if SBhnAlleRB.Checked then SBhnZahl := WettkSelected.StartBahnen
                            else SBhnZahl := 1
    else SBhnZahl := 0;

    if Modus = emEinteilen then
    begin
      if SBhnZahl > 0 then i := SGrpZahl * SBhnZahl  + 1
                      else i := SGrpZahl + 1;
      HauptFenster.ProgressBarInit('Teilnehmer werden eingeteilt...', i*TlnLst.Count);

      // Einteilung löschen
      for i:=0 to TlnLst.Count-1 do
      with TTlnObj(TlnLst[i]) do
      begin
        HauptFenster.ProgressBarStep(1);
        if (Wettk = WettkSelected) and (SGrp<> nil) and
           (not EinteilungBeibehaltenCB.Checked or // alle löschen
           not TlnInStatus(stEingeteilt)) then // unvollständige Einteilung löschen
        begin
          if Snr <> 0 then SnrBelegtArr[Snr] := false;
          EinteilungLoeschen;
          SetzeBearbeitet;
          TriDatei.Modified := true;
        end;
      end;

      // Einteilen
      if SGrpMarkiertRB.Checked then
        SGrpEinteilen(SGrpGrid.FocusedItem)
      else
      if SGrpAlleRB.Checked then
        for i:=0 to SGrpGrid.ItemCount-1 do
          SGrpEinteilen(SGrpGrid[i]);
      TriaMessage(Self,'Es wurden '+IntToStr(TlnSumme)+' Teilnehmer eingeteilt.',
                   mtInformation,[mbOk]);
    end

    else // Modus = emloeschen
    begin
      HauptFenster.ProgressBarInit('Einteilung von Teilnehmern wird gelöscht...', TlnLst.Count);
      for i:=0 to TlnLst.Count-1 do
      with TTlnObj(TlnLst[i]) do
      begin
        HauptFenster.ProgressBarStep(1);
        if (Wettk = WettkSelected) and (SGrp <> nil) and
           // SGrp gültig
           (SGrpMarkiertRB.Checked and (TSGrpObj(SGrpGrid.FocusedItem) = SGrp) or
            SGrpAlleRB.Checked) and
           // SBhn gültig
           ((Wettk.StartBahnen = 0) or
            (SBhnMarkiertRB.Checked and (SBhnGrid.Row = SBhn) or
            SBhnAlleRB.Checked)) and // auch SBhn = 0
           // Snr gültig oder unvollständig eingeteilt
           ((Snr = 0 ) or (Snr >= MinSnr) and (Snr <= MaxSnr)) then
        begin
          Inc(TlnSumme);
          if Snr <> 0 then SnrBelegtArr[Snr] := false;
          EinteilungLoeschen;
          SetzeBearbeitet;
          TriDatei.Modified := true;
        end;
      end;
      TriaMessage(Self,'Die Einteilung wurde bei '+IntToStr(TlnSumme)+' Teilnehmern gelöscht.',
                   mtInformation,[mbOk]);
    end;

  finally
    UpdateSGrpGrid;
    UpdateSBhnGrid;
    UpdateUebersicht;
    HauptFenster.StatusBarClear;
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
    DisableButtons := false;
  end;

end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TEinteilenDialog.HilfeButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  case Modus of
    emEinteilen : Application.HelpContext(3700);
    emLoeschen  : Application.HelpContext(3750);
  end;
end;


end.
