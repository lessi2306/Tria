﻿unit WettkDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ExtCtrls, ComCtrls, Grids,Math,
  AllgComp,AllgConst,AllgFunc,DateiDlg,AllgObj,AkObj,WettkObj,TlnObj,VeranObj,
  OrtObj, Buttons, ImgList, ActnList, XPStyleActnCtrls, ActnMan;


procedure WettkEingeben;

type

  TWettkDialog = class(TForm)
    DisqTxtEdit: TTriaEdit;
    StartgeldEdit: TTriaMaskEdit;
    StartgeldLabel2: TLabel;
    StartgeldCB: TCheckBox;
    DisqTxtCB: TCheckBox;
    procedure StartgeldCBClick(Sender: TObject);
    procedure DisqTxtCBClick(Sender: TObject);

  published
    WettkLabel: TLabel;
    WettkGrid: TTriaGrid;
    WettkPageControl: TPageControl;
      AllgemeinTS: TTabSheet;
        NameLabel: TLabel;
        NameEdit: TTriaEdit;
        StandTitelLabel: TLabel;
        StandTitelEdit: TTriaEdit;
        DatumLabel: TLabel;
        DatumEdit: TDatumEdit;
      AbschnTS: TTabSheet;
        WettkAbschnGB: TGroupBox;
          AbschnZahlLabel: TLabel;
          AbschnZahlEdit: TTriaMaskEdit;
          AbschnZahlUpDown: TTriaUpDown;
          AbsNameHeader: TLabel;
          Abs1NameLabel: TLabel;
          Abs1NameCB: TComboBox;
          Abs2NameLabel: TLabel;
          Abs2NameCB: TComboBox;
          Abs3NameLabel: TLabel;
          Abs3NameCB: TComboBox;
          Abs4NameLabel: TLabel;
          Abs4NameCB: TComboBox;
          Abs5NameLabel: TLabel;
          Abs5NameCB: TComboBox;
          Abs6NameLabel: TLabel;
          Abs6NameCB: TComboBox;
          Abs7NameLabel: TLabel;
          Abs7NameCB: TComboBox;
          Abs8NameCB: TComboBox;
          Abs8NameLabel: TLabel;
          AbsRundenHeader: TLabel;
          Abs1RundenLabel: TLabel;
          Abs1RundenEdit: TTriaMaskEdit;
          Abs1RundenUpDown: TTriaUpDown;
          Abs2RundenLabel: TLabel;
          Abs2RundenEdit: TTriaMaskEdit;
          Abs2RundenUpDown: TTriaUpDown;
          Abs3RundenLabel: TLabel;
          Abs3RundenEdit: TTriaMaskEdit;
          Abs3RundenUpDown: TTriaUpDown;
          Abs4RundenLabel: TLabel;
          Abs4RundenEdit: TTriaMaskEdit;
          Abs4RundenUpDown: TTriaUpDown;
          Abs5RundenLabel: TLabel;
          Abs5RundenEdit: TTriaMaskEdit;
          Abs5RundenUpDown: TTriaUpDown;
          Abs6RundenLabel: TLabel;
          Abs6RundenEdit: TTriaMaskEdit;
          Abs6RundenUpDown: TTriaUpDown;
          Abs7RundenLabel: TLabel;
          Abs7RundenEdit: TTriaMaskEdit;
          Abs7RundenUpDown: TTriaUpDown;
          Abs8RundenLabel: TLabel;
          Abs8RundenEdit: TTriaMaskEdit;
          Abs8RundenUpDown: TTriaUpDown;
          RundLaengeLabel: TLabel;
          RundLaengeEdit: TTriaMaskEdit;
      WertungTS: TTabSheet;
        WettkArtRG: TRadioGroup;
      TlnWertungTS: TTabSheet;
          TlnTxtCB: TCheckBox;
          TlnTxtEdit: TTriaEdit;
          TlnGB: TGroupBox;
            SondWrtgCB: TCheckBox;
            SondTitelEdit: TTriaEdit;
      MannschWertungTS: TTabSheet;
        MschWertgRG: TRadioGroup;
        MschWrtgModeGB: TGroupBox;
          TlnZeitRB: TRadioButton;
          TlnPlatzRB: TRadioButton;
          SchultourRB: TRadioButton;
        MschGrGB: TGroupBox;
          MschGrAlleLabel: TLabel;
          MschGrAlleEdit: TTriaMaskEdit;
          MschGrAlleUpDown: TTriaUpDown;
          MschGrMaennerEdit: TTriaMaskEdit;
          MschGrMaennerUpDown: TTriaUpDown;
          MschGrMaennerLabel: TLabel;
          MschGrFrauenEdit: TTriaMaskEdit;
          MschGrFrauenUpDown: TTriaUpDown;
          MschGrMixedEdit: TTriaMaskEdit;
          MschGrMixedUpDown: TTriaUpDown;
          MschGrMixedLabel: TLabel;
          MschGrFrauenLabel: TLabel;
      SchwimmTS: TTabSheet;
        SchwimmGB: TGroupBox;
          StrtBahnCB: TCheckBox;
          StrtBahnLabel: TLabel;
          StrtBahnEdit: TTriaMaskEdit;
          StrtBahnUpDown: TTriaUpDown;
          SchwDistLabel: TLabel;
          SchwDistEdit: TTriaMaskEdit;
          SchwDistUpDown: TTriaUpDown;
          SchwDistCB: TCheckBox;

    UpButton: TBitBtn;
    DownButton: TBitBtn;
    AendButton: TButton;
    NeuButton: TButton;
    LoeschButton: TButton;
    OkButton: TButton;
    CancelButton: TButton;
    HilfeButton: TButton;

    //WettkDialog
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    // WettkGrid
    procedure WettkLabelClick(Sender: TObject);
    procedure WettkGridClick(Sender: TObject);
    procedure WettkGridDrawCell(Sender: TObject; ACol, ARow: Integer;
                                Rect: TRect; State: TGridDrawState);
    //WettkPageControl
    procedure WettkPageControlChanging(Sender:TObject; var AllowChange:Boolean);
    procedure WettkPageControlChange(Sender: TObject);
    // AllgemeinTS
    procedure AllgemeinTSShow(Sender: TObject);
      procedure NameLabelClick(Sender: TObject);
      procedure NameEditChange(Sender: TObject);
      procedure StandTitelEditChange(Sender: TObject);
      procedure StandTitelLabelClick(Sender: TObject);
      procedure DatumLabelClick(Sender: TObject);
      procedure DatumEditChange(Sender: TObject);
    // AbschnTS
    procedure AbschnTSShow(Sender: TObject);
      procedure AbschnZahlLabelClick(Sender: TObject);
      procedure AbschnZahlEditChange(Sender: TObject);
      procedure AbsNameLabelClick(Sender: TObject);
      procedure AbsNameCBChange(Sender: TObject);
      procedure AbsRundenLabelClick(Sender: TObject);
      procedure AbsRundenEditChange(Sender: TObject);
      procedure RundLaengeLabelClick(Sender: TObject);
      procedure RundLaengeEditChange(Sender: TObject);
    // WertungTS
    procedure WertungTSShow(Sender: TObject);
      procedure WettkArtRGClick(Sender: TObject);
    // TeilnehmerTS
    procedure TlnWertungTSShow(Sender: TObject);
      procedure TlnTxtCBClick(Sender: TObject);
      procedure SondWrtgCBClick(Sender: TObject);
      procedure EditChange(Sender: TObject);
      procedure StartgeldLabelClick(Sender: TObject);
    // MannschaftenTS
    procedure MannschWertungTSShow(Sender: TObject);
      procedure MschWertgRGClick(Sender: TObject);
      procedure MschWrtgModeGBClick(Sender: TObject);
      procedure MschGrLabelClick(Sender: TObject);
      procedure MschGrEditChange(Sender: TObject);
    // SchwimmTS
    procedure SchwimmTSShow(Sender: TObject);
      procedure StrtBahnCBClick(Sender: TObject);
      procedure StrtBahnLabelClick(Sender: TObject);
      procedure StrtBahnEditChange(Sender: TObject);
      procedure SchwDistCBClick(Sender: TObject);
      procedure SchwDistLabelClick(Sender: TObject);
      procedure SchwDistEditChange(Sender: TObject);

    // Buttons
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure NeuButtonClick(Sender: TObject);
    procedure AendButtonClick(Sender: TObject);
    procedure LoeschButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);


  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;


  private
    HelpFensterAlt  : TWinControl;
    DlgUpdating     : Boolean;
    NeuEingabe      : Boolean;
    WkAktuell       : TWettkObj;
    DisableButtons  : Boolean;
    AbsNameArr      : array [wkAbs1..wkAbs8] of String;
    AbsNameLabel,
    AbsRundenLabel  : array [wkAbs1..wkAbs8] of TLabel;
    AbsNameCB       : array [wkAbs1..wkAbs8] of TComboBox;
    AbsRundenEdit   : array [wkAbs1..wkAbs8] of TTriaMaskEdit;
    AbsRundenUpDown : array [wkAbs1..wkAbs8] of TTriaUpDown;
    WettkArtAlt     : TWettkArt;

    function    WettkSelected: TWettkObj;
    procedure   SetWettkDaten;
    procedure   SetPage;
    procedure   SetButtons;
    procedure   SetWettkArtRG(WettkArtNeu:TWettkArt);
    function    GetWettkArtRG: TWettkArt;
    procedure   InitWettkAbschnGB;
    procedure   UpdateWettkAbschnGB(ZahlNeu:Integer);
    procedure   SetzeAbschnZahl(ZahlNeu:Integer);
    procedure   SetzeAbschnNamen;
    procedure   SetzeAbschnRunden;
    procedure   SetAbsName(Abs:TWkAbschnitt;NameNeu:String);
    //procedure   SetAbsRunden(Abs:TWkAbschnitt;RundenNeu:String);
    procedure   UpdateAbschn(Zahl:Integer);
    function    GetAbsName(Abs:TWkAbschnitt): String;
    function    GetAbsRunden(Abs:TWkAbschnitt): Integer;
    procedure   UpdateSondTitelEdit;
    procedure   UpdateTlnTxtCB;
    procedure   UpdateTlnTxtEdit;
    procedure   UpdateStartgeldEdit;
    procedure   UpdateDisqTxtEdit;
    procedure   SetDatenSchwimmTS;
    procedure   UpdateStrtBahn;
    procedure   UpdateSchwDist;
    function    AlleEinzel: Boolean;
    function    MindestensEineEinfachWrtg: Boolean;
    function    GetMschWertgRG: TMschWertung;
    function    GetMschWrtgModeGB: TMschWrtgMode;
    procedure   SetMschWrtg(MschWertgNeu:TMschWertung;MschWrtgModeNeu:TMschWrtgMode;
                            {GrAnmNeu,GrStrtNeu,}
                            GrAlleNeu,GrMaennerNeu,GrFrauenNeu,GrMixedNeu:Integer);
    function    WettkGeaendert: Boolean;
    function    WettkNameGeaendert(Wk:TWettkObj): Boolean;
    function    WettkStandTitelGeaendert(Wk:TWettkObj): Boolean;
    function    WettkSondTitelGeaendert(Wk:TWettkObj): Boolean;
    function    WettkNameDoppel: Boolean;
    function    WettkStandTitelDoppel: Boolean;
    function    WettkSondTitelDoppel: Boolean;
    function    EingabeOK: Boolean;
    function    WettkNeu: Boolean;
    function    WettkAendern: Boolean;
    procedure   WettkLoeschen;
end;

var
  WettkDialog: TWettkDialog;

implementation

uses TriaMain,CmdProc,Tlnerg,VistaFix;

{$R *.DFM}

(******************************************************************************)
procedure WettkEingeben;
(******************************************************************************)
begin
  WettkDialog := TWettkDialog.Create(HauptFenster);
  try
    WettkDialog.ShowModal;
  finally
    FreeAndNil(WettkDialog);
  end;
  HauptFenster.RefreshAnsicht;
end;

(******************************************************************************)
(*  Methoden TWettkDialog                                                     *)
(******************************************************************************)

// public Methoden

(*============================================================================*)
constructor TWettkDialog.Create(AOwner: TComponent);
(*============================================================================*)
var AbsCnt : TWkAbschnitt;
//..............................................................................
procedure InitAbsArr;
begin
  //Abs1
  AbsNameLabel[wkAbs1]     := Abs1NameLabel;
  AbsNameCB[wkAbs1]        := Abs1NameCB;
  AbsRundenLabel[wkAbs1]   := Abs1RundenLabel;
  AbsRundenEdit[wkAbs1]    := Abs1RundenEdit;
  AbsRundenUpDown[wkAbs1]  := Abs1RundenUpDown;
  //Abs2
  AbsNameLabel[wkAbs2]     := Abs2NameLabel;
  AbsNameCB[wkAbs2]        := Abs2NameCB;
  AbsRundenLabel[wkAbs2]   := Abs2RundenLabel;
  AbsRundenEdit[wkAbs2]    := Abs2RundenEdit;
  AbsRundenUpDown[wkAbs2]  := Abs2RundenUpDown;
  //Abs3
  AbsNameLabel[wkAbs3]     := Abs3NameLabel;
  AbsNameCB[wkAbs3]        := Abs3NameCB;
  AbsRundenLabel[wkAbs3]   := Abs3RundenLabel;
  AbsRundenEdit[wkAbs3]    := Abs3RundenEdit;
  AbsRundenUpDown[wkAbs3]  := Abs3RundenUpDown;
  //Abs4
  AbsNameLabel[wkAbs4]     := Abs4NameLabel;
  AbsNameCB[wkAbs4]        := Abs4NameCB;
  AbsRundenLabel[wkAbs4]   := Abs4RundenLabel;
  AbsRundenEdit[wkAbs4]    := Abs4RundenEdit;
  AbsRundenUpDown[wkAbs4]  := Abs4RundenUpDown;
  //Abs5
  AbsNameLabel[wkAbs5]     := Abs5NameLabel;
  AbsNameCB[wkAbs5]        := Abs5NameCB;
  AbsRundenLabel[wkAbs5]   := Abs5RundenLabel;
  AbsRundenEdit[wkAbs5]    := Abs5RundenEdit;
  AbsRundenUpDown[wkAbs5]  := Abs5RundenUpDown;
  //Abs6
  AbsNameLabel[wkAbs6]     := Abs6NameLabel;
  AbsNameCB[wkAbs6]        := Abs6NameCB;
  AbsRundenLabel[wkAbs6]   := Abs6RundenLabel;
  AbsRundenEdit[wkAbs6]    := Abs6RundenEdit;
  AbsRundenUpDown[wkAbs6]  := Abs6RundenUpDown;
  //Abs7
  AbsNameLabel[wkAbs7]     := Abs7NameLabel;
  AbsNameCB[wkAbs7]        := Abs7NameCB;
  AbsRundenLabel[wkAbs7]   := Abs7RundenLabel;
  AbsRundenEdit[wkAbs7]    := Abs7RundenEdit;
  AbsRundenUpDown[wkAbs7]  := Abs7RundenUpDown;
  //Abs8
  AbsNameLabel[wkAbs8]     := Abs8NameLabel;
  AbsNameCB[wkAbs8]        := Abs8NameCB;
  AbsRundenLabel[wkAbs8]   := Abs8RundenLabel;
  AbsRundenEdit[wkAbs8]    := Abs8RundenEdit;
  AbsRundenUpDown[wkAbs8]  := Abs8RundenUpDown;
end;

//..............................................................................
begin
  inherited Create(AOwner);
  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  DlgUpdating    := false;
  DisableButtons := false;
  WkAktuell      := nil;
  WettkGrid.Canvas.Font := WettkGrid.Font;
  WettkGrid.DefaultRowHeight := WettkGrid.Canvas.TextHeight('Tg')+1;
  WettkGrid.TopAbstand := 0;
  WettkGrid.FixedRows := 0;
  WettkGrid.FixedCols := 0;
  WettkGrid.ColWidths[0] := WettkGrid.ClientWidth;

  WettkPageControl.ActivePage := AllgemeinTS;
  WettkArtRG.Items.Clear;
  WettkArtRG.Items.Add('Standardwertung (Einzel- und Mannschaftswertung)');
  WettkArtRG.Items.Add('Rundenrennen (Wertung nach Rundenzahl und Gesamtzeit)');
  WettkArtRG.Items.Add('Stundenrennen (Wertung nach Rundenzahl und Reststrecke)');

  if not Veranstaltung.Serie then
  begin
    NameLabel.Visible    := false;
    NameEdit.Visible     := false;
    StandTitelLabel.Top  := 85;
    StandTitelEdit.Top   := 100;
    DatumLabel.Top       := 165;
    DatumEdit.Top        := 180;
    // TlnStaffel nicht für Serie
    WettkArtRG.Items.Add('Einfach - Staffelwertung  (ein Teilnehmer pro Wettkampfabschnitt)');
    WettkArtRG.Items.Add('Einfach - Teamwertung  (mehrere Teilnehmer für einen Abschnitt)');
    MschWertgRG.Caption  := 'Mannschaftszahl';
  end else
  begin
    Caption := Caption + '  -  ' + Veranstaltung.OrtName;
    StandTitelLabel.Caption :=
      StandTitelLabel.Caption + '  -  ' + Veranstaltung.OrtName;
    MschWertgRG.Caption := 'Mannschaftszahl (für alle Orte)';
  end;
  WettkArtRG.Items.Add('Mannschaft - Staffelwertung  (jeder Teilnehmer bestreitet alle Abschnitte)');
  WettkArtRG.Items.Add('Mannschaft - Teamwertung  (letzter Teilnehmer bestimmt das Ergebnis)');
  WettkArtAlt := waEinzel;

  AbschnZahlEdit.EditMask := '0;0; ';
  AbschnZahlUpDown.Min := 1;
  AbschnZahlUpDown.Max := cnAbsZahlMax;
  InitAbsArr;
  for AbsCnt:=wkAbs1 to wkAbs8 do
  begin
    with AbsNameCB[AbsCnt].Items do
    begin
      Add('Abs.'+IntToStr(Integer(AbsCnt)));
      Add('Swim');
      Add('Bike');
      Add('Run');
      Add('Run 1');
      Add('Kanu');
      Add('Kajak');
      Add('Ski');
    end;
    // TextBuffer wird nach Disable bei wieder Enable übernommen
    AbsNameArr[AbsCnt] := 'Abs.'+IntToStr(Integer(AbsCnt));
    AbsRundenEdit[AbsCnt].EditMask := '0999;0; ';
    AbsRundenUpDown[AbsCnt].Min := 1;
    AbsRundenUpDown[AbsCnt].Max := cnRundenMax;
  end;
  RundLaengeEdit.EditMask := '09999;0; ';
  //RundLaengeUpDown.Min := cnRundLaengeMin; // 1 m
  //RundLaengeUpDown.Max := cnRundLaengeMax; // 99.999 m, max 32767 (SmallInt) erlaubt

  SchwDistEdit.EditMask  := '09;0; ';
  SchwDistUpDown.Min     := 1;
  SchwDistUpDown.Max     := cnSchwDistMax;
  StrtBahnEdit.EditMask  := '09;0; ';
  StrtBahnUpDown.Min     := 1;
  StrtBahnUpDown.Max     := cnStrtBahnMax;

  // Msch-Größe
  MschGrAlleEdit.EditMask    := '09;0; ';
  MschGrMaennerEdit.EditMask := '09;0; ';
  MschGrFrauenEdit.EditMask  := '09;0; ';
  MschGrMixedEdit.EditMask   := '09;0; ';
  MschGrAlleUpDown.Min       := cnMschGrMin;
  MschGrAlleUpDown.Max       := cnMschGrMax;
  MschGrMaennerUpDown.Min    := cnMschGrMin;
  MschGrMaennerUpDown.Max    := cnMschGrMax;
  MschGrFrauenUpDown.Min     := cnMschGrMin;
  MschGrFrauenUpDown.Max     := cnMschGrMax;
  MschGrMixedUpDown.Min      := cnMschGrMin;
  MschGrMixedUpDown.Max      := cnMschGrMax;
  MschGrAlleEdit.TextAlt     := IntToStr(cnMschGrMin);
  MschGrMaennerEdit.TextAlt  := IntToStr(cnMschGrMin);
  MschGrFrauenEdit.TextAlt   := IntToStr(cnMschGrMin);
  MschGrMixedEdit.TextAlt    := IntToStr(cnMschGrMin);

  Veranstaltung.WettkColl.Sortieren(smWkEingegeben);
  WettkGrid.Init(Veranstaltung.WettkColl,smSortiert,ssVertical,nil);
  // vorab neuer Wettk erstellen, der bei Abbruch wieder gelöscht wird
  if WettkGrid.ItemCount = 0 then
  begin
    NeuEingabe := true; // vor AddItem
    WettkGrid.AddItem(TWettkObj.Create(Veranstaltung,Veranstaltung.WettkColl,oaAdd));
  end else NeuEingabe := false;
  // SetWettkDaten wird in FormShow aufgerufen
  // SetWettkDaten (SetPage) kann nicht benutzt werden wegen FocusItem

  CancelButton.Cancel := true;
  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);
end;

(*============================================================================*)
destructor TWettkDialog.Destroy;
(*============================================================================*)
begin
  HelpFenster := HelpFensterAlt;
  inherited Destroy;
end;

// private Methoden

(*----------------------------------------------------------------------------*)
function TWettkDialog.WettkSelected: TWettkObj;
(*----------------------------------------------------------------------------*)
begin
  Result := TWettkObj(WettkGrid.FocusedItem);
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.SetWettkDaten;
(*----------------------------------------------------------------------------*)
begin
  WkAktuell := WettkSelected;
  if WkAktuell = nil then Exit;
  DlgUpdating := true;

  // AllgemeinTS
  NameEdit.Text := WkAktuell.Name;
  if Veranstaltung.Serie then StandTitelEdit.Text := WkAktuell.StandTitel
                         else StandTitelEdit.Text := WkAktuell.Name;
  DatumEdit.Text := WkAktuell.Datum;

  // WertungTS
  SetWettkArtRG(WkAktuell.WettkArt);

  // AbschnTS
  InitWettkAbschnGB;

  // TeilnehmerTS
  // TlnText
  if (WkAktuell.WettkArt=waTlnStaffel)or(WkAktuell.WettkArt=waTlnTeam) then
  begin
    TlnTxtCB.Enabled := false;
    TlnTxtCB.Checked := false;
  end else
  begin
    TlnTxtCB.Enabled := true;
    if WkAktuell.TlnTxt = '' then TlnTxtCB.Checked := false
                             else TlnTxtCB.Checked := true;
  end;
  if TlnTxtCB.Checked = true then TlnTxtEdit.TextAlt := WkAktuell.TlnTxt
                             else TlnTxtEdit.TextAlt := '';
  UpdateTlnTxtCB;
  // SonderWertung
  if WkAktuell.SondWrtg then
  begin
    SondWrtgCB.Checked := true;
    SondTitelEdit.TextAlt := WkAktuell.SondTitel;
  end else
  begin
    SondWrtgCB.Checked := false;
    SondTitelEdit.TextAlt := '';
  end;
  UpdateSondTitelEdit;
  // Startgeld
  if WkAktuell.Startgeld > 0 then
  begin
    StartgeldCB.Checked := true;
    StartgeldEdit.TextAlt := IntToStr(WkAktuell.Startgeld);
  end else
  begin
    StartgeldCB.Checked := false;
    StartgeldEdit.TextAlt := '';
  end;
  UpdateStartgeldEdit;
  //StartgeldEdit.Text := IntToStr(WkAktuell.Startgeld);
  // DisqText
  if WkAktuell.DisqTxt <> '' then
  begin
    DisqTxtCB.Checked := true;
    DisqTxtEdit.TextAlt := WkAktuell.DisqTxt;
  end else
  begin
    DisqTxtCB.Checked := false;
    DisqTxtEdit.TextAlt := '';
  end;
  UpdateDisqTxtEdit;

  // MannschaftTS
  with WkAktuell do
    SetMschWrtg(MschWertg,MschWrtgMode,
                MschGroesse[cnSexBeide],MschGroesse[cnMaennlich],
                MschGroesse[cnWeiblich],MschGroesse[cnMixed]);

  // SchwimmTS
  SetDatenSchwimmTS;

  SetButtons;
  SetPage;
  DlgUpdating := false;
  Refresh; // weil anschließend neu berechnet wird
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.SetButtons;
(*----------------------------------------------------------------------------*)
begin
  OkButton.Enabled := true;
  if WkAktuell = nil then Exit;

  if WettkGrid.Collection.SortIndexOf(WkAktuell) >= 1 then
    UpButton.Enabled := true
  else UpButton.Enabled := false;
  if WettkGrid.Collection.SortIndexOf(WkAktuell) <= WettkGrid.ItemCount-2 then
    DownButton.Enabled := true
  else DownButton.Enabled := false;

  if NeuEingabe then
    if not WettkGeAendert then
    begin
      NeuButton.Enabled := false;
      AendButton.Enabled := false;
      if WettkGrid.ItemCount <=1 then LoeschButton.Enabled := false
                                 else LoeschButton.Enabled := true;
      AendButton.Default := false;
      OkButton.Default := true;
    end else
    begin
      NeuButton.Enabled := false;
      AendButton.Enabled := true;
      LoeschButton.Enabled := true;
      AendButton.Default := true;
      OkButton.Default := false;
    end
  else // keine NeuEingabe
    if not WettkGeAendert then
    begin
      NeuButton.Enabled := true;
      AendButton.Enabled := false;
      LoeschButton.Enabled := true;
      AendButton.Default := false;
      OkButton.Default := true;
    end else
    begin
      NeuButton.Enabled := true;
      AendButton.Enabled := true;
      LoeschButton.Enabled := true;
      AendButton.Default := true;
      OkButton.Default := false;
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.SetPage;
(*----------------------------------------------------------------------------*)
begin
  // AktivePage vorher gesetzt:  WettkPageControl.ActivePage
  if WettkPageControl.ActivePage = AllgemeinTS then
    if NameEdit.CanFocus then NameEdit.SetFocus
    else
    if StandTitelEdit.CanFocus then StandTitelEdit.SetFocus
    else
  else
  if WettkPageControl.ActivePage = AbschnTS then
    if AbschnZahlEdit.CanFocus then
      AbschnZahlEdit.SetFocus
    else
    if RundLaengeEdit.CanFocus then
      RundLaengeEdit.SetFocus
    else
  else
  if WettkPageControl.ActivePage = WertungTS then
    if WettkArtRG.CanFocus then WettkArtRG.SetFocus
    else
  else
  if WettkPageControl.ActivePage = TlnWertungTS then
    if SondWrtgCB.CanFocus then SondWrtgCB.SetFocus
    else
  else
  if WettkPageControl.ActivePage = MannschWertungTS then
    if MschWertgRG.CanFocus then MschWertgRG.SetFocus
    else
    if MschGrAlleEdit.CanFocus then MschGrAlleEdit.SetFocus
    else
  else
  if WettkPageControl.ActivePage = SchwimmTS then
    if StrtBahnCB.CanFocus then StrtBahnCB.SetFocus;
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.SetWettkArtRG(WettkArtNeu:TWettkArt);
(*----------------------------------------------------------------------------*)
// TWettkArt = (waEinzel,waMschStaffel,waMschTeam,waTlnStaffel,waRndRennen,waStndRennen,waTlnTeam);
// waTlnStaffel, waTlnTeam nicht bei Serie
begin
  case WettkArtNeu of
    waRndRennen   : WettkArtRG.ItemIndex := 1;
    waStndRennen  : WettkArtRG.ItemIndex := 2;
    waTlnStaffel  : WettkArtRG.ItemIndex := 3; // nie bei Serie
    waTlnTeam     : WettkArtRG.ItemIndex := 4; // nie bei Serie
    waMschStaffel : if Veranstaltung.Serie then WettkArtRG.ItemIndex := 3
                                           else WettkArtRG.ItemIndex := 5;
    waMschTeam    : if Veranstaltung.Serie then WettkArtRG.ItemIndex := 4
                                           else WettkArtRG.ItemIndex := 6;
    else WettkArtRG.ItemIndex := 0;  // waEinzel
  end;
  WettkArtAlt := GetWettkArtRG;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.GetWettkArtRG: TWettkArt;
(*----------------------------------------------------------------------------*)
begin
  case WettkArtRG.ItemIndex of
    1 : Result := waRndRennen;
    2 : Result := waStndRennen;
    3 : if Veranstaltung.Serie then Result := waMschStaffel
                               else Result := waTlnStaffel;
    4 : if Veranstaltung.Serie then Result := waMschTeam
                               else Result := waTlnTeam;
    5 : Result := waMschStaffel; // nicht vorhanden bei Serie
    6 : Result := waMschTeam;    // nicht vorhanden bei Serie
    else Result := waEinzel;     // Compiler-Warnung vermeiden
  end;
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.InitWettkAbschnGB;
(*----------------------------------------------------------------------------*)
// Daten von WettkAktuell übernehmen, Init Zustand
// WettkArt vorher in WettkArtRG gesetzt
var UpdatingAlt : Boolean;
    AbsCnt : TWkAbschnitt;
begin
  UpdatingAlt := DlgUpdating;
  DlgUpdating := true;

  // Setze AbschnZahl
  SetzeAbschnZahl(WkAktuell.AbschnZahl); // =1 beim neuen Wettk

  // Init AbsNameArr
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if WkAktuell.AbschnZahl >= Max(2,Integer(AbsCnt)) then
      AbsNameArr[AbsCnt] := WkAktuell.AbschnName[AbsCnt]
    else
      AbsNameArr[AbsCnt] := 'Abs.'+IntToStr(Integer(AbsCnt));
  // Setze 8 AbschnNamen
  SetzeAbschnNamen;

  // AbschRunden
  // Init AbsRundenEdit auch TextAlt wird für spätere Benutzung gesetzt
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if (WkAktuell.AbschnZahl >= Integer(AbsCnt)) and not WkAktuell.RundenWettk then
      AbsRundenEdit[AbsCnt].Text := IntToStr(Max(1,WkAktuell.AbsMaxRunden[AbsCnt]))
    else
      AbsRundenEdit[AbsCnt].Text := '1';
  // Init RundLaenge, auch TextAlt wird für spätere Benutzung gesetzt
  if (WkAktuell.RundLaenge > 0) and WkAktuell.RundenWettk then
    RundLaengeEdit.Text := IntToStr(WkAktuell.RundLaenge)
  else
    RundLaengeEdit.Text := IntToStr(cnRundLaengeDefault);

  // Setze 8 AbschnRunden und RundenLaenge
  SetzeAbschnRunden;

  DlgUpdating := UpDatingAlt;
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.UpdateWettkAbschnGB(ZahlNeu:Integer);
(*----------------------------------------------------------------------------*)
// Daten von WettkArtRG übernehmen, nach WettkArtRGClick
// AbschnZahlEdit.Text vorher geprüft, bleibt unverändert
//var UpdatingAlt : Boolean;
begin
//  UpdatingAlt := DlgUpdating;
//  DlgUpdating := true;

  // Setze AbschnZahl, Zahl unverändert
  //SetzeAbschnZahl(StrToIntDef(AbschnZahlEdit.Text,1));
  SetzeAbschnZahl(ZahlNeu);
  // Setze 8 AbschnNamen
  SetzeAbschnNamen;
  // Setze 8 AbschnRunden und RundenLaenge
  SetzeAbschnRunden;

//  DlgUpdating := UpDatingAlt;
end;

//------------------------------------------------------------------------------
procedure TWettkDialog.SetzeAbschnZahl(ZahlNeu:Integer);
//------------------------------------------------------------------------------
var UpdatingAlt : Boolean;
begin
  UpdatingAlt := DlgUpdating;
  DlgUpdating := true;

  if (GetWettkArtRG<>waRndRennen) and (GetWettkArtRG<>waStndRennen) and
     (GetWettkArtRG<>waTlnTeam) then
  begin
    AbschnZahlLabel.Enabled  := true;
    AbschnZahlEdit.Enabled   := true;
    AbschnZahlUpDown.Enabled := true;
    if GetWettkArtRG = waTlnStaffel then AbschnZahlUpDown.Min := 2
                                    else AbschnZahlUpDown.Min := 1;
  end else
  begin
    AbschnZahlLabel.Enabled  := false;
    AbschnZahlEdit.Enabled   := false;
    AbschnZahlUpDown.Enabled := false;
    AbschnZahlUpDown.Min     := 1;
  end;
  AbschnZahlEdit.Text := IntToStr(ZahlNeu);

  DlgUpdating := UpDatingAlt;
end;

//------------------------------------------------------------------------------
procedure TWettkDialog.SetzeAbschnNamen;
//------------------------------------------------------------------------------
// verwendet in InitWettkAbschnGB, nach SetzeAbschnZahl und Init AbsNameArr
// AbsNameArr unverändert
var UpdatingAlt : Boolean;
    AbsCnt : TWkAbschnitt;
begin
  UpdatingAlt := DlgUpdating;
  DlgUpdating := true;

  if AbschnZahlEdit.Enabled and (StrToIntDef(AbschnZahlEdit.Text,1) > 1) then
    AbsNameHeader.Enabled  := true
  else
    AbsNameHeader.Enabled := false;
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if AbsNameHeader.Enabled and (StrToIntDef(AbschnZahlEdit.Text,1)>=Integer(AbsCnt)) then
    begin
      AbsNameLabel[AbsCnt].Enabled := true;
      AbsNameCB[AbsCnt].Enabled    := true;
      SetAbsName(AbsCnt,AbsNameArr[AbsCnt]);
    end else
    begin
      AbsNameLabel[AbsCnt].Enabled := false;
      AbsNameCB[AbsCnt].Enabled    := false;
      SetAbsName(AbsCnt,'Abs.'+IntToStr(Integer(AbsCnt)));
    end;

  DlgUpdating := UpDatingAlt;
end;

//------------------------------------------------------------------------------
procedure TWettkDialog.SetzeAbschnRunden;
//------------------------------------------------------------------------------
var UpdatingAlt : Boolean;
    AbsCnt : TWkAbschnitt;
begin
  UpdatingAlt := DlgUpdating;
  DlgUpdating := true;

  // AbschRunden
  if (GetWettkArtRG<>waRndRennen) and (GetWettkArtRG<>waStndRennen) then
    AbsRundenHeader.Enabled  := true
  else
    AbsRundenHeader.Enabled  := false;
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if AbsRundenHeader.Enabled and (StrToIntDef(AbschnZahlEdit.Text,1) >= Integer(AbsCnt))  then
    begin
      AbsRundenEdit[AbsCnt].Text      := AbsRundenEdit[AbsCnt].TextAlt;
      AbsRundenLabel[AbsCnt].Enabled  := true;
      AbsRundenEdit[AbsCnt].Enabled   := true;
      AbsRundenUpDown[AbsCnt].Enabled := true;
    end else
    begin
      AbsRundenLabel[AbsCnt].Enabled  := false;
      AbsRundenEdit[AbsCnt].Enabled   := false;
      AbsRundenUpDown[AbsCnt].Enabled := false;
      AbsRundenEdit[AbsCnt].Text      := ''; // TextAlt unverändert
    end;

  // RundenLaenge
  if GetWettkArtRG=waStndRennen then
  begin
    RundLaengeLabel.Enabled  := true;
    RundLaengeEdit.Enabled   := true;
    //RundLaengeUpDown.Enabled := true;
    RundLaengeEdit.Text      := RundLaengeEdit.TextAlt; // letzter gültiger Wert
  end else
  begin
    RundLaengeLabel.Enabled  := false;
    RundLaengeEdit.Enabled   := false;
    //RundLaengeUpDown.Enabled := false;
    RundLaengeEdit.Text      := ''; // TextAlt nicht geändert
  end;

  DlgUpdating := UpDatingAlt;
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.SetAbsName(Abs:TWkAbschnitt;NameNeu:String);
(*----------------------------------------------------------------------------*)
begin
  with AbsNameCB[Abs] do // unabhängig von Enabled
    begin
      Text := NameNeu;
      if not StrGleich(Text,'') then
        if Items.IndexOf(Text) < 0 then Items.Insert(0,Text)
        else
      else // ''
        if Enabled then Text := Items[0];
      ItemIndex := Items.IndexOf(Text);
      //if not StrGleich(Text,'') then AbsNameArr[Abs] := AbsNameCB[Abs].Text;
    end;
end;

{(*----------------------------------------------------------------------------*)
procedure TWettkDialog.SetAbsRunden(Abs:TWkAbschnitt;RundenNeu:String);
(*----------------------------------------------------------------------------*)
var Edit : TTriaMaskEdit;
begin
  case Abs of
    wkAbs1: Edit := Abs1RundenEdit;
    wkAbs2: Edit := Abs2RundenEdit;
    wkAbs3: Edit := Abs3RundenEdit;
    wkAbs4: Edit := Abs4RundenEdit;
    else Edit := Abs1RundenEdit; // warnung vermeiden
  end;
  with Edit do // unabhängig von Enabled
    begin
      Text := RundenNeu;
      if (Wert(Text) < 1) and Enabled then Text := '1';
      if not StrGleich(Text,'') then
        case Abs of
          wkAbs1: Abs1RundenBuf := Abs1RundenEdit.Text;
          wkAbs2: Abs2RundenBuf := Abs2RundenEdit.Text;
          wkAbs3: Abs3RundenBuf := Abs3RundenEdit.Text;
          //wkAbs4: Abs4RundenBuf := Abs4RundenEdit.Text;
        end;
    end;
end;}

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.UpdateAbschn(Zahl:Integer);
(*----------------------------------------------------------------------------*)
var AbsCnt : TWkAbschnitt;
begin
  if WkAktuell = nil then Exit;
  if (Zahl >= AbschnZahlUpDown.Min) and (Zahl <= AbschnZahlUpDown.Max) then
  begin
    if AbschnZahlEdit.Enabled and (Zahl > 1) then
      AbsNameHeader.Enabled  := true
    else
      AbsNameHeader.Enabled := false;

    for AbsCnt:=wkAbs1 to wkAbs8 do
    begin
      AbsNameLabel[AbsCnt].Enabled    := Zahl >= Max(2,Integer(AbsCnt));
      AbsNameCB[AbsCnt].Enabled       := AbsNameLabel[AbsCnt].Enabled;
      if Zahl >= Max(2,Integer(AbsCnt)) then SetAbsName(AbsCnt,AbsNameArr[AbsCnt])
                                        else SetAbsName(AbsCnt,'Abs.'+IntToStr(Integer(AbsCnt)));

      if (GetWettkArtRG=waRndRennen) or (GetWettkArtRG=waStndRennen) then
      begin
        AbsRundenLabel[AbsCnt].Enabled  := false;
        AbsRundenEdit[AbsCnt].Enabled   := false;
        AbsRundenUpDown[AbsCnt].Enabled := false;
        AbsRundenEdit[AbsCnt].Text      := '';
      end else
      if Zahl >= Integer(AbsCnt) then
      begin
        if not AbsRundenLabel[AbsCnt].Enabled then
          AbsRundenEdit[AbsCnt].Text    := AbsRundenEdit[AbsCnt].TextAlt;
        AbsRundenLabel[AbsCnt].Enabled  := true;
        AbsRundenEdit[AbsCnt].Enabled   := true;
        AbsRundenUpDown[AbsCnt].Enabled := true;
      end else
      begin
        AbsRundenLabel[AbsCnt].Enabled  := false;
        AbsRundenEdit[AbsCnt].Enabled   := false;
        AbsRundenUpDown[AbsCnt].Enabled := false;
        AbsRundenEdit[AbsCnt].Text      := '';
      end;
    end;

  end else // sollte nicht vorkommen
    for AbsCnt:=wkAbs1 to wkAbs8 do
    begin
      AbsNameLabel[AbsCnt].Enabled    := false;
      AbsNameCB[AbsCnt].Enabled       := false;
      SetAbsName(AbsCnt,AbsNameArr[AbsCnt]);
      AbsRundenLabel[AbsCnt].Enabled  := false;
      AbsRundenEdit[AbsCnt].Enabled   := false;
      AbsRundenUpDown[AbsCnt].Enabled := false;
      AbsRundenEdit[AbsCnt].Text      := AbsRundenEdit[AbsCnt].TextAlt;
      //AbsRundenEdit[AbsCnt].Text      := '';
    end;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.GetAbsName(Abs:TWkAbschnitt): String;
(*----------------------------------------------------------------------------*)
begin
  Result := AbsNameCB[Abs].Text;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.GetAbsRunden(Abs:TWkAbschnitt): Integer;
(*----------------------------------------------------------------------------*)
begin
  if AbsRundenEdit[Abs].Enabled then
    Result := StrToIntDef(AbsRundenEdit[Abs].Text,0)
  else
  if (Abs=wkAbs1) and
     ((GetWettkArtRG=waRndRennen) or (GetWettkArtRG=waStndRennen)) then
    Result := cnRundenMax
  else
    Result := 1;
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.UpdateSondTitelEdit;
(*----------------------------------------------------------------------------*)
// TextAlt bei jede Änderung updated
begin
  SondTitelEdit.Enabled := SondWrtgCB.Enabled and SondWrtgCB.Checked;
  if SondWrtgCB.Checked then SondTitelEdit.Text := SondTitelEdit.TextAlt
                        else SondTitelEdit.Text := '';
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.UpdateTlnTxtCB;
(*----------------------------------------------------------------------------*)
// bei WettkArt-Änderung
begin
  if (GetWettkArtRG=waTlnStaffel) or (GetWettkArtRG=waTlnTeam) then
  begin
    TlnTxtCB.Enabled := false;
    TlnTxtCB.Checked := false;
  end else
  begin
    TlnTxtCB.Enabled := true;
    if TlnTxtEdit.TextAlt = '' then TlnTxtCB.Checked := false
                               else TlnTxtCB.Checked := true;
  end;

  UpdateTlnTxtEdit;
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.UpdateTlnTxtEdit;
(*----------------------------------------------------------------------------*)
// TextAlt bei jede Änderung updated
begin
  TlnTxtEdit.Enabled := TlnTxtCB.Enabled and TlnTxtCB.Checked;
  if TlnTxtCB.Checked then TlnTxtEdit.Text := TlnTxtEdit.TextAlt
                      else TlnTxtEdit.Text := '';
end;

//------------------------------------------------------------------------------
procedure TWettkDialog.UpdateStartgeldEdit;
//------------------------------------------------------------------------------
begin
  StartgeldEdit.Enabled := StartgeldCB.Enabled and StartgeldCB.Checked;
  if StartgeldCB.Checked then StartgeldEdit.Text := StartgeldEdit.TextAlt
                         else StartgeldEdit.Text := '';
end;

//------------------------------------------------------------------------------
procedure TWettkDialog.UpdateDisqTxtEdit;
//------------------------------------------------------------------------------
begin
  DisqTxtEdit.Enabled := DisqTxtCB.Enabled and DisqTxtCB.Checked;
  if DisqTxtCB.Checked then
    if not StrGleich(DisqTxtEdit.TextAlt,'') then
      DisqTxtEdit.Text := DisqTxtEdit.TextAlt
    else
     DisqTxtEdit.Text := cnDisqNameDefault
  else DisqTxtEdit.Text := '';
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.SetDatenSchwimmTS;
(*----------------------------------------------------------------------------*)
// nur ausgeführt wenn Updating = true
begin
  if WkAktuell = nil then Exit;
  if WkAktuell.StartBahnen > 0 then StrtBahnCB.Checked := true
                               else StrtBahnCB.Checked := false;

  if WkAktuell.SchwimmDistanz > 0 then SchwDistCB.Checked := true
                                  else SchwDistCB.Checked := false;
  StrtBahnEdit.TextAlt := IntToStr(Max(StrtBahnUpDown.Min,WkAktuell.StartBahnen));
  UpdateStrtBahn;
  SchwDistEdit.TextAlt := IntToStr(Max(SchwDistUpDown.Min,WkAktuell.SchwimmDistanz));
  UpdateSchwDist;
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.UpdateStrtBahn;
(*----------------------------------------------------------------------------*)
var UpdatingAlt : Boolean;
begin
  UpdatingAlt := DlgUpdating;
  DlgUpdating := true;
  if StrtBahnCB.Enabled and StrtBahnCB.Checked then
  begin
    StrtBahnLabel.Enabled  := true;
    StrtBahnEdit.Enabled   := true;
    StrtBahnUpDown.Enabled := true;
  end else
  begin
    StrtBahnLabel.Enabled  := false;
    StrtBahnEdit.Enabled   := false;
    StrtBahnUpDown.Enabled := false;
  end;
  if StrtBahnCB.Checked then StrtBahnEdit.Text := StrtBahnEdit.TextAlt
                        else StrtBahnEdit.Text := '';
  DlgUpdating := UpdatingAlt;
end;

(*----------------------------------------------------------------------------*)
procedure TWettkDialog.UpdateSchwDist;
(*----------------------------------------------------------------------------*)
var UpdatingAlt : Boolean;
begin
  UpdatingAlt := DlgUpdating;
  DlgUpdating := true;
  if SchwDistCB.Enabled and SchwDistCB.Checked then
  begin
    SchwDistEdit.Enabled   := true;
    SchwDistLabel.Enabled  := true;
    SchwDistUpDown.Enabled := true;
  end else
  begin
    SchwDistEdit.Enabled   := false;
    SchwDistLabel.Enabled  := false;
    SchwDistUpDown.Enabled := false;
  end;
  if SchwDistCB.Checked then SchwDistEdit.Text := SchwDistEdit.TextAlt
                        else SchwDistEdit.Text := '';
  DlgUpdating := UpdatingAlt;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.AlleEinzel: Boolean;
(*----------------------------------------------------------------------------*)
//bei Serie WettkArt in andere VeranstaltungsOrte berücksichtigen
var i : integer;
begin
  Result := false;
  if WkAktuell = nil then Exit;
  for i:=0 to Veranstaltung.OrtZahl-1 do
    if (i<>Veranstaltung.OrtIndex) and
       ((WkAktuell.OrtWettkArt[i]=waTlnStaffel) or
        (WkAktuell.OrtWettkArt[i]=waTlnTeam) or
        (WkAktuell.OrtWettkArt[i]=waMschStaffel) or
        (WkAktuell.OrtWettkArt[i]=waMschTeam)) then
      Exit;
  Result := true;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.MindestensEineEinfachWrtg: Boolean;
(*----------------------------------------------------------------------------*)
//bei Serie WettkArt in andere VeranstaltungsOrte berücksichtigen
var i : integer;
begin
  Result := false;
  if WkAktuell = nil then Exit;
  for i:=0 to Veranstaltung.OrtZahl-1 do
    if (i<>Veranstaltung.OrtIndex) and
       ((WkAktuell.OrtWettkArt[i]=waTlnStaffel)or(WkAktuell.OrtWettkArt[i]=waTlnTeam)) then
    begin
      Result := true;
      Exit;
    end;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.GetMschWertgRG: TMschWertung;
(*----------------------------------------------------------------------------*)
begin
  case MschWertgRG.ItemIndex of
    1: Result   := mwEinzel;
    2: Result   := mwMulti;
    else Result := mwKein;
  end;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.GetMschWrtgModeGB: TMschWrtgMode;
(*----------------------------------------------------------------------------*)
begin
  if TlnPlatzRB.Checked then Result := wmTlnPlatz
  else if SchultourRB.Checked then Result := wmSchultour
  else Result := wmTlnZeit;
end;

//------------------------------------------------------------------------------
procedure TWettkDialog.SetMschWrtg(MschWertgNeu:TMschWertung;MschWrtgModeNeu:TMschWrtgMode;
                                   GrAlleNeu,GrMaennerNeu,GrFrauenNeu,GrMixedNeu: Integer);
//------------------------------------------------------------------------------
// MschWertgRG und MschWrtgModeGB in einer Prozedur wegen gegenseitige Abhängigkeit
// wmSchultour nur enabled wenn not Liga, waEinzel und mwEinzel
var UpdatingAlt : Boolean;
begin
  UpdatingAlt := DlgUpdating;
  DlgUpdating := true;
  try
    // SetMschWertgRG
    if (GetWettkArtRG=waTlnStaffel) or
       (GetWettkArtRG=waTlnTeam) or
       (GetWettkArtRG=waMschStaffel) or
       (GetWettkArtRG=waMschTeam) or
       (Veranstaltung.Serie and not AlleEinzel) or
       (MschWrtgModeNeu = wmSchultour) then
    begin
      MschWertgRG.Enabled := false;
      if (GetWettkArtRG = waTlnStaffel) or (GetWettkArtRG = waTlnTeam) or
         (Veranstaltung.Serie and MindestensEineEinfachWrtg) then
        MschWertgRG.ItemIndex := 0  // mwKein, hat Vorrang vor mwEinzel
      else MschWertgRG.ItemIndex := 1; // mwEinzel: waMschStaffel,waMschTeam, wmSchultour
    end else // waEinzel, waRndRennen, waStndRennen
    begin
      MschWertgRG.Enabled := true;
      case MschWertgNeu of
        mwKein:   MschWertgRG.ItemIndex := 0;
        mwEinzel: MschWertgRG.ItemIndex := 1;
        mwMulti:  MschWertgRG.ItemIndex := 2;
      end;
    end;

    //SetMschWrtgModeGB
    // zunächst alle zurücksetzen
    TlnZeitRB.Checked   := false;
    TlnPlatzRB.Checked  := false;
    SchultourRB.Checked := false;
    if (MschWertgRG.ItemIndex <= 0) or // mwKein, waTlnStaffel, waTlnTeam
       (GetWettkArtRG = waMschTeam) or (GetWettkArtRG = waMschStaffel) then
    begin
      MschWrtgModeGB.Enabled := false;
      TlnZeitRB.Enabled   := false;
      TlnPlatzRB.Enabled  := false;
      SchultourRB.Enabled := false;
    end else // waEinzel, waRndRennen, waStndRennen
    begin
      MschWrtgModeGB.Enabled := true;
      TlnZeitRB.Enabled   := true;
      TlnPlatzRB.Enabled  := true;
      if (GetWettkArtRG = waEinzel) and (GetMschWertgRG = mwEinzel) then
        SchultourRB.Enabled := true
      else SchultourRB.Enabled := false;
      if GetWettkArtRG = waStndrennen then
        TlnZeitRB.Caption := 'Streckenaddition'
      else
        TlnZeitRB.Caption := 'Zeitaddition';
      case MschWrtgModeNeu of
        wmTlnZeit  : TlnZeitRB.Checked   := true;
        wmTlnPlatz : TlnPlatzRB.Checked  := true;
        wmSchultour: if SchultourRB.Enabled then
                       SchultourRB.Checked := true
                     else TlnZeitRB.Checked := true;
        else TlnZeitRB.Checked := true;
      end;
    end;

    // SetMschGrAlle,Maenner,Frauen,Mixed;
    if GetWettkArtRG = waTlnTeam then
    begin
      MschGrAlleUpDown.Max    := cnAbsZahlMax; // max 8 TeamTln, wie bei Staffel
      MschGrMaennerUpDown.Max := cnAbsZahlMax;
      MschGrFrauenUpDown.Max  := cnAbsZahlMax;
      MschGrMixedUpDown.Max   := cnAbsZahlMax;
    end else
    begin
      MschGrAlleUpDown.Max    := cnMschGrMax; // max 16 Tln
      MschGrMaennerUpDown.Max := cnMschGrMax;
      MschGrFrauenUpDown.Max  := cnMschGrMax;
      MschGrMixedUpDown.Max   := cnMschGrMax;
    end;
    if (GetMschWertgRG = mwKein)and(GetWettkArtRG <> waTlnTeam) or // immer bei waTlnStaffel
       (GetMschWrtgModeGB = wmSchultour) then // keine MschGroesse
    begin
      MschGrAlleLabel.Enabled     := false;
      MschGrAlleEdit.Enabled      := false;
      MschGrAlleUpDown.Enabled    := false;
      MschGrAlleEdit.Text         := '';
      MschGrMaennerLabel.Enabled  := false;
      MschGrMaennerEdit.Enabled   := false;
      MschGrMaennerUpDown.Enabled := false;
      MschGrMaennerEdit.Text      := '';
      MschGrFrauenLabel.Enabled   := false;
      MschGrFrauenEdit.Enabled    := false;
      MschGrFrauenUpDown.Enabled  := false;
      MschGrFrauenEdit.Text       := '';
      MschGrMixedLabel.Enabled    := false;
      MschGrMixedEdit.Enabled     := false;
      MschGrMixedUpDown.Enabled   := false;
      MschGrMixedEdit.Text        := '';
    end else
    if (GetWettkArtRG = waMschTeam) or (GetWettkArtRG = waMschStaffel) then // nur AkAlle
    begin
      MschGrAlleLabel.Enabled     := true;
      MschGrAlleEdit.Enabled      := true;
      MschGrAlleUpDown.Enabled    := true;
      if (GrAlleNeu < MschGrAlleUpDown.Min) or (GrAlleNeu > MschGrAlleUpDown.Max) then
        GrAlleNeu := cnMschGrDefault; // gültiger Wert setzen
      MschGrAlleEdit.Text := IntToStr(GrAlleNeu);// nach Enable
      MschGrMaennerLabel.Enabled  := false;
      MschGrMaennerEdit.Enabled   := false;
      MschGrMaennerUpDown.Enabled := false;
      MschGrMaennerEdit.Text      := '';
      MschGrFrauenLabel.Enabled   := false;
      MschGrFrauenEdit.Enabled    := false;
      MschGrFrauenUpDown.Enabled  := false;
      MschGrFrauenEdit.Text       := '';
      MschGrMixedLabel.Enabled    := false;
      MschGrMixedEdit.Enabled     := false;
      MschGrMixedUpDown.Enabled   := false;
      MschGrMixedEdit.Text        := '';
    end
    else // alle Groessen, auch bei waTlnTeam
    begin
      MschGrAlleLabel.Enabled     := true;
      MschGrAlleEdit.Enabled      := true;
      MschGrAlleUpDown.Enabled    := true;
      if (GrAlleNeu < MschGrAlleUpDown.Min) or (GrAlleNeu > MschGrAlleUpDown.Max) then
        GrAlleNeu := cnMschGrDefault; // gültiger wert setzen
      MschGrAlleEdit.Text       := IntToStr(GrAlleNeu);// nach Enable

      MschGrMaennerLabel.Enabled  := true;
      MschGrMaennerEdit.Enabled   := true;
      MschGrMaennerUpDown.Enabled := true;
      if (GrMaennerNeu < MschGrMaennerUpDown.Min) or (GrMaennerNeu > MschGrMaennerUpDown.Max) then
        GrMaennerNeu := cnMschGrDefault; // gültiger wert setzen
      MschGrMaennerEdit.Text      := IntToStr(GrMaennerNeu);// nach Enable

      MschGrFrauenLabel.Enabled   := true;
      MschGrFrauenEdit.Enabled    := true;
      MschGrFrauenUpDown.Enabled  := true;
      if (GrFrauenNeu < MschGrFrauenUpDown.Min) or (GrFrauenNeu > MschGrFrauenUpDown.Max) then
        GrFrauenNeu := cnMschGrDefault; // gültiger wert setzen
      MschGrFrauenEdit.Text       := IntToStr(GrFrauenNeu);// nach Enable

      MschGrMixedLabel.Enabled    := true;
      MschGrMixedEdit.Enabled     := true;
      MschGrMixedUpDown.Enabled   := true;
      if (GrMixedNeu < MschGrMixedUpDown.Min) or (GrMixedNeu > MschGrMixedUpDown.Max) then
        GrMixedNeu := cnMschGrDefault; // gültiger wert setzen
      MschGrMixedEdit.Text        := IntToStr(GrMixedNeu);// nach Enable
     end;

  finally
      DlgUpdating := UpdatingAlt;
  end;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.WettkGeaendert: Boolean;
(*----------------------------------------------------------------------------*)
//..............................................................................
function AbsGeAendert: Boolean;
var AbsCnt : TWkAbschnitt;
begin
  Result := true;
  with WkAktuell do
  begin
    if AbschnZahlEdit.Enabled and
      (AbSchnZahl <> StrToIntDef(AbschnZahlEdit.Text,0)) then Exit;
    for AbsCnt:=wkAbs1 to wkAbs8 do
    begin
      if AbsNameCB[AbsCnt].Enabled and
        not StrGleich(AbschnName[AbsCnt],GetAbsName(AbsCnt)) then Exit;
      if AbsRundenEdit[AbsCnt].Enabled and
        (AbsMaxRunden[AbsCnt] <> GetAbsRunden(AbsCnt)) then Exit;
    end;
    if RundLaengeEdit.Enabled and
      (RundLaenge <> StrToIntDef(RundLaengeEdit.Text,0)) then Exit;
  end;
  Result := false;
end;

//..............................................................................
begin
  Result := false;
  if WkAktuell=nil then Exit
  else with WkAktuell do
    Result :=
      Veranstaltung.Serie and not StrGleich(StandTitelEdit.Text,StandTitel)  or
      not Veranstaltung.Serie and not StrGleich(StandTitelEdit.Text,Name)    or
      NameEdit.Enabled and not StrGleich(Name,NameEdit.Text)                 or
      DatumEdit.Enabled and not StrGleich(Datum,DatumEdit.Text)              or

      WettkArtRG.Enabled and (WettkArt <> GetWettkArtRG)                     or

      AbsGeAendert                                                           or

      SondWrtgCB.Enabled and (SondWrtgCB.Checked <> SondWrtg)                or
      SondTitelEdit.Enabled and not StrGleich(SondTitel,SondTitelEdit.Text)  or
      TlnTxtCB.Enabled and (TlnTxtCB.Checked = StrGleich(TlnTxt,''))         or
      TlnTxtEdit.Enabled and not StrGleich(TlnTxt,TlnTxtEdit.Text)           or
      StartgeldCB.Enabled and (StartgeldCB.Checked <> (Startgeld>0))         or
      StartgeldEdit.Enabled and (Startgeld <> StrToIntDef(StartgeldEdit.Text,0)) or
      DisqTxtCB.Enabled and (DisqTxtCB.Checked = StrGleich(DisqTxt,''))      or
      DisqTxtEdit.Enabled and not StrGleich(DisqTxt,DisqTxtEdit.Text)        or

      MschWertgRG.Enabled and (MschWertg <> GetMschWertgRG)                  or
      MschWrtgModeGB.Enabled and (MschWrtgMode <> GetMschWrtgModeGB)         or
      MschGrAlleEdit.Enabled and (MschGroesse[cnSexBeide]<>StrToIntDef(MschGrAlleEdit.Text,0))        or
      MschGrMaennerEdit.Enabled and (MschGroesse[cnMaennlich]<>StrToIntDef(MschGrMaennerEdit.Text,0)) or
      MschGrFrauenEdit.Enabled and (MschGroesse[cnWeiblich]<>StrToIntDef(MschGrFrauenEdit.Text,0))    or
      MschGrMixedEdit.Enabled and (MschGroesse[cnMixed]<>StrToIntDef(MschGrMixedEdit.Text,0))         or

      SchwDistCB.Enabled and (SchwDistCB.Checked=(SchwimmDistanz=0))         or
      SchwDistEdit.Enabled and (SchwimmDistanz <> StrToIntDef(SchwDistEdit.Text,0))   or
      StrtBahnCB.Enabled and (StrtBahnCB.Checked=(StartBahnen=0))            or
      StrtBahnEdit.Enabled and (StartBahnen <> StrToIntDef(StrtBahnEdit.Text,0));
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.WettkNameGeaendert(Wk:TWettkObj): Boolean;
(*----------------------------------------------------------------------------*)
begin
  if Wk=nil then Result := false
  else Result := Veranstaltung.Serie and not StrGleich(Wk.Name,NameEdit.Text);
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.WettkStandTitelGeaendert(Wk:TWettkObj): Boolean;
(*----------------------------------------------------------------------------*)
begin
  if Wk=nil then Result := false
  else Result := not StrGleich(Wk.StandTitel,StandTitelEdit.Text);
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.WettkSondTitelGeaendert(Wk:TWettkObj): Boolean;
(*----------------------------------------------------------------------------*)
begin
  if Wk=nil then Result := false
  else Result := (SondWrtgCB.Checked <> Wk.SondWrtg) or
                 not StrGleich(Wk.SondTitel,SondTitelEdit.Text);
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.WettkNameDoppel: Boolean;
(*----------------------------------------------------------------------------*)
var i: Integer;
begin
  Result := false;
  if WettkNameGeAendert(WkAktuell) then
  begin
    for i:=0 to WettkGrid.ItemCount-1 do
      if not WettkNameGeAendert(TWettkObj(WettkGrid.Items[i])) then
      begin
        Result := true;
        TriaMessage(Self,'Wettkampfname ist bereits vorhanden.',mtInformation,[mbOk]);
        WettkPageControl.ActivePage := AllgemeinTS;
        if NameEdit.CanFocus then NameEdit.SetFocus
        else if StandTitelEdit.CanFocus then StandTitelEdit.SetFocus;
        Exit;
      end;
    // SondTitel prüfen
    for i:=0 to WettkGrid.ItemCount-1 do
      if StrGleich(NameEdit.Text,TWettkObj(WettkGrid.Items[i]).SondTitel) then
      begin
        Result := true;
        TriaMessage(Self,'Wettkampfname ist bereits für Sonderwertung definiert.',
                     mtInformation,[mbOk]);
        WettkPageControl.ActivePage := AllgemeinTS;
        if NameEdit.CanFocus then NameEdit.SetFocus
        else if StandTitelEdit.CanFocus then StandTitelEdit.SetFocus;
        Exit;
      end;
  end;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.WettkStandTitelDoppel: Boolean;
(*----------------------------------------------------------------------------*)
var i: Integer;
begin
  Result := false;
  if WettkStandTitelGeAendert(WkAktuell) then
  begin
    for i:=0 to WettkGrid.ItemCount-1 do
      if not WettkStandTitelGeAendert(TWettkObj(WettkGrid.Items[i])) then
      begin
        Result := true;
        TriaMessage(Self,'Wettkampfname ist bereits vorhanden.',mtInformation,[mbOk]);
        WettkPageControl.ActivePage := AllgemeinTS;
        if StandTitelEdit.CanFocus then StandTitelEdit.SetFocus;
        Exit;
      end;
    // SondWrtg prüfen
    for i:=0 to WettkGrid.ItemCount-1 do
      if StrGleich(StandTitelEdit.Text,TWettkObj(WettkGrid.Items[i]).SondTitel) then
      begin
        Result := true;
        TriaMessage(Self,'Wettkampfname ist bereits als Sonderwertung definiert.',
                     mtInformation,[mbOk]);
        WettkPageControl.ActivePage := AllgemeinTS;
        if StandTitelEdit.CanFocus then StandTitelEdit.SetFocus;
        Exit;
      end;
  end;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.WettkSondTitelDoppel: Boolean;
(*----------------------------------------------------------------------------*)
var i: Integer;
begin
  Result := false;
  if SondWrtgCB.Checked and WettkSondTitelGeAendert(WkAktuell) then
  begin
    for i:=0 to WettkGrid.ItemCount-1 do
      if not WettkSondTitelGeAendert(TWettkObj(WettkGrid.Items[i])) then
      begin
        Result := true;
        TriaMessage(Self,'Sonderwertung ist bereits vorhanden.',mtInformation,[mbOk]);
        WettkPageControl.ActivePage := AllgemeinTS;
        if SondTitelEdit.CanFocus then SondTitelEdit.SetFocus;
        Exit;
      end;
    if SondWrtgCB.Checked then
      // Name und Titel2 prüfen
      for i:=0 to WettkGrid.ItemCount-1 do
        if StrGleich(SondTitelEdit.Text,TWettkObj(WettkGrid.Items[i]).StandTitel)or
           StrGleich(SondTitelEdit.Text,TWettkObj(WettkGrid.Items[i]).Name) then
      begin
        Result := true;
        TriaMessage(Self,'Sonderwertung ist bereits als Wettkampfname definiert.',
                   mtInformation,[mbOk]);
        WettkPageControl.ActivePage := AllgemeinTS;
        if SondTitelEdit.CanFocus then SondTitelEdit.SetFocus;
        Exit;
      end;
  end;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.EingabeOK: Boolean;
(*----------------------------------------------------------------------------*)
var i : Integer;
    AbsCnt : TWkAbschnitt;

begin
  Result := false;
  if WkAktuell = nil then Exit;

  // AllgemeinTS
  if NameEdit.Enabled and Veranstaltung.Serie and StrGleich(NameEdit.Text,'') then
  begin
    TriaMessage(Self,'Wettkampfname für Serie fehlt.',mtInformation,[mbOk]);
    WettkPageControl.ActivePage := AllgemeinTS;
    if NameEdit.CanFocus then NameEdit.SetFocus;
    Exit;
  end;
  if StrGleich(StandTitelEdit.Text,'') then
  begin
    if Veranstaltung.Serie then
      TriaMessage(Self,'Wettkampfname für '+
                  Veranstaltung.OrtName+' fehlt.',mtInformation,[mbOk])
    else
      TriaMessage(Self,'Wettkampfname fehlt.',mtInformation,[mbOk]);
    WettkPageControl.ActivePage := AllgemeinTS;
    if StandTitelEdit.CanFocus then StandTitelEdit.SetFocus;
    Exit;
  end;
  if DatumEdit.Enabled and not DatumEdit.ValidateEdit then Exit;
  // prüfen ob Datum bei Serie in richtige Reihenfolge
  if DatumEdit.Enabled and Veranstaltung.Serie and not NeuEingabe then
  begin
    for i:=0 to Veranstaltung.OrtIndex-1 do
      if DatumWert(WkAktuell.OrtDatum[i]) > DatumWert(DatumEdit.Text) then
        if TriaMessage(Self,'Das eingetragene Datum liegt vor dem Datum in '+
                        Veranstaltung.OrtColl[i].Name+'.'+#13+
                       'Datum trotzdem Speichern?',
                        mtWarning,[mbOk,mbCancel]) <> mrOK then
        begin
          WettkPageControl.ActivePage := AllgemeinTS;
          if DatumEdit.Canfocus then DatumEdit.SetFocus;
          Exit;
        end
        else Break; // nur 1x fragen
    for i:=Veranstaltung.OrtIndex+1 to Veranstaltung.OrtZahl-1 do
      if DatumWert(WkAktuell.OrtDatum[i]) < DatumWert(DatumEdit.Text) then
        if TriaMessage(Self,'Das eingetragene Datum liegt nach dem Datum in '+
                        Veranstaltung.OrtColl[i].Name+'.'+#13+
                       'Datum trotzdem Speichern?',
                        mtWarning,[mbOk,mbCancel]) <> mrOK then
        begin
          WettkPageControl.ActivePage := AllgemeinTS;
          if DatumEdit.Canfocus then DatumEdit.SetFocus;
          Exit;
        end
        else Break; // nur 1x fragen
  end;

  // AbschnTS
  // Validate wird nicht automatisch ausgeführt bei ENTER-Taste
  with AbschnZahlEdit do
    if Enabled and not ValidateEdit then Exit;
  for AbsCnt:=wkAbs1 to wkAbs8 do
    with AbsRundenEdit[AbsCnt] do
      if Enabled and not ValidateEdit then Exit;
  with RundLaengeEdit do
    if Enabled then
    begin
      if not ValidateEdit then Exit;
      if StrToIntDef(Text,0) < 1 then
      begin
        TriaMessage(Self,'Die Rundenlänge muss größer null sein.'
                    ,mtInformation,[mbOk]);
        WettkPageControl.ActivePage := AbschnTS;
        if CanFocus then SetFocus;
        Exit;
      end;
    end;

  for AbsCnt:=wkAbs1 to wkAbs8 do
    if AbsNameCB[AbsCnt].Enabled and StrGleich(AbsNameCB[AbsCnt].Text,'') then
    begin
      TriaMessage(Self,'Name für Abschnitt '+IntToStr(Integer(AbsCnt))+' fehlt.',mtInformation,[mbOk]);
      WettkPageControl.ActivePage := AbschnTS;
      if AbsNameCB[AbsCnt].CanFocus then AbsNameCB[AbsCnt].SetFocus;
      Exit;
    end;
  // prüfen ob Kuerzel auf 3 Zeichen gekürzt werden müssen (Tln- und MschAnsicht)
  if (StrToIntDef(AbschnZahlEdit.Text,0) > 1) and WkAktuell.LangeAkKuerzel then
  begin
    TriaMessage(Self,'Für '+WkAktuell.Name+#13+
                'sind Altersklassen-Kürzel mit mehr als 3 Zeichen definiert.'+#13+
                'Bei mehr als 1 Wettkampfabschnitt sind nur 3 Zeichen erlaubt.'
                ,mtInformation,[mbOk]);
    WettkPageControl.ActivePage := AbschnTS;
    if AbschnZahlEdit.CanFocus then AbschnZahlEdit.SetFocus;
    Exit;
  end;

  // TlnWertungTS
  if SondWrtgCB.Checked and StrGleich(SondTitelEdit.Text,'') then
  begin
    TriaMessage(Self,'Bezeichnung für Sonderwertung fehlt.',mtInformation,[mbOk]);
    WettkPageControl.ActivePage := TlnWertungTS;
    if SondTitelEdit.CanFocus then SondTitelEdit.SetFocus;
    Exit;
  end;
  if TlnTxtCB.Enabled and TlnTxtCB.Checked and
     StrGleich(TlnTxtEdit.Text,'') then
  begin
    TriaMessage(Self,'Bezeichnung für optionales Textfeld fehlt.',
                 mtInformation,[mbOk]);
    WettkPageControl.ActivePage := TlnWertungTS;
    if TlnTxtEdit.CanFocus then TlnTxtEdit.SetFocus;
    Exit;
  end;
  with StartgeldEdit do
    if Enabled and not ValidateEdit then Exit;
  if StartgeldCB.Enabled and StartgeldCB.Checked and
     (StrToIntDef(StartgeldEdit.Text,0) = 0) then
  begin
    TriaMessage(Self,'Startgeld fehlt.',
                 mtInformation,[mbOk]);
    WettkPageControl.ActivePage := TlnWertungTS;
    if StartgeldEdit.CanFocus then StartgeldEdit.SetFocus;
    Exit;
  end;
  if DisqTxtCB.Enabled and DisqTxtCB.Checked and
     StrGleich(DisqTxtEdit.Text,'') then
  begin
    TriaMessage(Self,'Standardtext für Disqualifikation fehlt.',
                 mtInformation,[mbOk]);
    WettkPageControl.ActivePage := TlnWertungTS;
    if DisqTxtEdit.CanFocus then DisqTxtEdit.SetFocus;
    Exit;
  end;

  // MschWertungTS
  if GetMschWertgRG <> mwKein then  // Edit-Felder Enabled
  begin
    with MschGrAlleEdit do
      if Enabled and not ValidateEdit then Exit;
    with MschGrMaennerEdit do
      if Enabled and not ValidateEdit then Exit;
    with MschGrFrauenEdit do
      if Enabled and not ValidateEdit then Exit;
    with MschGrMixedEdit do
      if Enabled and not ValidateEdit then Exit;
  end;

  // SchwimmTS
  with StrtBahnEdit do
    if Enabled and not ValidateEdit then Exit;
  with SchwDistEdit do
    if Enabled and not ValidateEdit then Exit;
  if StrtBahnEdit.Enabled and (StrToInt(StrtBahnEdit.Text) > cnStrtBahnMax) then
  begin
    TriaMessage(Self,'Die Zahl der Startbahnen muss kleiner sein als ' +
                IntToStr(cnStrtBahnMax)+'.',mtInformation,[mbOk]);
    WettkPageControl.ActivePage := SchwimmTS;
    if StrtBahnEdit.CanFocus then StrtBahnEdit.SetFocus;
    Exit;
  end;
  if SchwDistEdit.Enabled and (StrToIntDef(SchwDistEdit.Text,0) > cnSchwDistMax) then
  begin
    TriaMessage(Self,'Die Schwimmdistanz muss kleiner sein als ' +
                IntToStr(cnSchwDistMax)+'.',mtInformation,[mbOk]);
    WettkPageControl.ActivePage := SchwimmTS;
    if SchwDistEdit.CanFocus then SchwDistEdit.SetFocus;
    Exit;
  end;

  if WettkNameDoppel then Exit;
  if WettkStandTitelDoppel then Exit;
  if WettkSondTitelDoppel then Exit;

  Result := true;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.WettkNeu: Boolean;
(*----------------------------------------------------------------------------*)
var Wk :TWettkObj;
begin
  Result := false;
  if WkAktuell = nil then Exit;

  // geänderte Daten übernehmen
  if WettkGeAendert then
    if NeuEingabe then
      if not WettkAendern then Exit
      else
    else
    case TriaMessage(Self,'Die Einstellungen für '+WkAktuell.Name+' wurden geändert.'+#13+
                     'Änderungen übernehmen?',
                      mtConfirmation,[mbYes,mbNo,mbCancel]) of
      mrYes : if not WettkAendern then Exit;
      mrNo  : ;
      else    Exit;
    end;

  if Veranstaltung.WettkColl.Count >= cnWettkMax then
  begin
    TriaMessage(Self,'Maximale Wettkampfzahl erreicht.',mtInformation,[mbOk]);
    if WettkGeAendert then SetWettkDaten; (* Änderung rückgängig *)
    Exit;
  end;

  Refresh;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    Wk:=TWettkObj.Create(Veranstaltung,Veranstaltung.WettkColl,oaAdd);
    NeuEingabe := true;  // vor AddItem
    WettkGrid.AddItem(Wk);
    WettkGrid.Refresh; // Refresh in TriaGrid.AddItem entfernt!!!!!!!!!!!!!!!!!!!
    WettkGrid.FocusedItem := Wk;
    SetWettkDaten; // WkAktuell gesetzt
    if NameEdit.CanFocus then NameEdit.SetFocus (* nur bei Serie *)
    else if StandTitelEdit.CanFocus then StandTitelEdit.SetFocus;
    Result := true;
  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;
end;

(*----------------------------------------------------------------------------*)
function TWettkDialog.WettkAendern: Boolean;
(*----------------------------------------------------------------------------*)
// WkAktuell ändern
// zuerst alle Optionen abfragen und bei Abbruch nichts ändern
var i,JahrNeu,WkMin,WkMax,
    MschGrAlle,MschGrMaenner,MschGrFrauen,MschGrMixed : Integer;
    AlleMschWrtgModeUebernehmen,
    AlleMannschGrUebernehmen,
    AlleWkDatumUebernehmen,
    SerWrtgJahrUebernehmen,
    AlleSondWrtgLoeschen,
    AlleTlnLandLoeschen,
    AlleTlnTextUebernehmen,
    AlleSBhnLoeschen : Boolean;
    NameStr,S : String;

begin
  Result := false;
  if (WkAktuell=nil) or not EingabeOk then Exit;

  AlleMschWrtgModeUebernehmen := false;
  AlleMannschGrUebernehmen    := false;
  AlleWkDatumUebernehmen      := false;
  AlleSondWrtgLoeschen        := false;
  AlleTlnLandLoeschen         := false;
  AlleTlnTextUebernehmen      := false;
  AlleSBhnLoeschen            := false;

  if not Veranstaltung.Serie or (WkAktuell.SerWrtgJahr = 0) or NeuEingabe then
    SerWrtgJahrUebernehmen := true
  else
    SerWrtgJahrUebernehmen := false;
  JahrNeu := StrToIntDef(Copy(DatumEdit.Text,7,4),0);

  if not NeuEingabe and Veranstaltung.Serie then
  // gemeinsame Daten für alle Orte andern
  begin

    if MschWertgRG.Enabled and (WkAktuell.MschWertg<>GetMschWertgRG) then
      case TriaMessage(Self,'Mannschaftswertung gilt für alle Austragungsorte.'+#13+
                       'Änderung übernehmen?',
                        mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes    : ;
        mrNo     : SetMschWrtg(WkAktuell.MschWertg,GetMschWrtgModeGB,
                               StrToIntDef(MschGrAlleEdit.Text,0),
                               StrToIntDef(MschGrMaennerEdit.Text,0),
                               StrToIntDef(MschGrFrauenEdit.Text,0),
                               StrToIntDef(MschGrMixedEdit.Text,0));
        mrCancel : Exit;
      end;

    if MschWrtgModeGB.Enabled and (WkAktuell.MschWrtgMode<>GetMschWrtgModeGB) then
      case TriaMessage(Self,'Mannschafts-Wertungsmode für alle Austragungsorte übernehmen?',
                        mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes    : AlleMschWrtgModeUebernehmen := true;
        mrNo     : ;
        mrCancel : Exit;
      end;

    if MschGrAlleEdit.Enabled and (WkAktuell.MschGroesse[cnSexBeide]<>StrToIntDef(MschGrAlleEdit.Text,0)) or
       MschGrMaennerEdit.Enabled and (WkAktuell.MschGroesse[cnMaennlich]<>StrToIntDef(MschGrMaennerEdit.Text,0)) or
       MschGrFrauenEdit.Enabled and (WkAktuell.MschGroesse[cnWeiblich]<>StrToIntDef(MschGrFrauenEdit.Text,0)) or
       MschGrMixedEdit.Enabled and (WkAktuell.MschGroesse[cnMixed]<>StrToIntDef(MschGrMixedEdit.Text,0)) then
      case TriaMessage(Self,'Mannschaftsgrößen für alle Austragungsorte übernehmen?',
                        mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes    : AlleMannschGrUebernehmen := true;
        mrNo     : ;
        mrCancel : Exit;
      end;
  end;

  if DatumEdit.Enabled and not StrGleich(WkAktuell.Datum,DatumEdit.Text) then
  begin
    if Veranstaltung.WettkColl.Count > 1 then
    begin
      if not Veranstaltung.Serie then S := ''
      else S := ' in ' + Veranstaltung.OrtName;
      case TriaMessage(Self,'Datum für alle Wettkämpfe'+S+' übernehmen?',
                        mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes    : AlleWkDatumUebernehmen := true;
        mrNo     : ;
        mrCancel : Exit;
      end;
    end;

    if AlleWkDatumUebernehmen then
    begin
      WkMin := 0;
      WkMax := Veranstaltung.WettkColl.Count-1;
    end else
    begin
      WkMin := Veranstaltung.WettkColl.IndexOf(WkAktuell);
      WkMax := WkMin;
    end;

    if Veranstaltung.Serie and not SerWrtgJahrUebernehmen then
      for i:=WkMin to WkMax do
      with Veranstaltung.WettkColl[i] do
        if SerWrtgJahr <> JahrNeu then
        begin
          if AlleWkDatumUebernehmen then S := ' für alle Wettkämpfe '
                                    else S := ' ';
          case TriaMessage(Self,'Für die Serienwertung wurde das Jahr '+IntToStr(SerWrtgJahr)+
                           ' für die Berechnung der Altersklassen definiert.' +#13+
                           'Dieses Jahr'+S+'in '+IntToStr(JahrNeu)+' ändern?',
                            mtConfirmation,[mbYes,mbNo,mbCancel]) of
            mrYes    : begin
                         SerWrtgJahrUebernehmen := true;
                         Break; // Bestätigung gilt für alle Wettk
                       end;
            mrNo     : Break;
            mrCancel : Exit;
          end;
        end;

  end;

  if SondWrtgCB.Enabled and not SondWrtgCB.Checked and WkAktuell.SondWrtg and
     Veranstaltung.TlnColl.SondWrtgDefiniert(WkAktuell) then
    if TriaMessage(Self,'Für den gewählten Wettkampf wurden bereits Teilnehmer ' +
                   'für die SonderWertung eingeteilt.'+#13+
                   'Diese Einteilung wird gelöscht.',
                    mtConfirmation,[mbOk,mbCancel]) <> mrOk then Exit
    else
      AlleSondWrtgLoeschen := true;

  if TlnTxtCB.Enabled and not StrGleich(WkAktuell.TlnTxt,TlnTxtEdit.Text) then
  begin
    if StrGleich(TlnTxtEdit.Text,'') and
       Veranstaltung.TlnColl.LandDefiniert(WkAktuell,wgStandWrtg) then
      if TriaMessage(Self,'Für den gewählten Wettkampf wurden für das Textfeld  "'+
                     WkAktuell.TlnTxt + '"  bereits Teilnehmerdaten eingegeben.'+#13+
                     'Diese Daten werden gelöscht.',
                      mtConfirmation,[mbOk,mbCancel]) <> mrOk then Exit
      else
        AlleTlnLandLoeschen := true;

    if Veranstaltung.WettkColl.Count > 1 then
    begin
      if not Veranstaltung.Serie then S := ''
      else S := ' in ' + Veranstaltung.OrtName;
      if StrGleich(TlnTxtEdit.Text,'') then S := S + ' löschen?'
                                       else S := S + ' übernehmen?';
      case TriaMessage(Self,'Optionales Teilnehmer-Textfeld für alle Wettkämpfe' + S,
                        mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes    : AlleTlnTextUebernehmen := true;
        mrNo     : ;
        mrCancel : Exit;
      end ;
    end;
  end;

  if StrtBahnEdit.Enabled and (StrToInt(StrtBahnEdit.Text) < WkAktuell.StartBahnen) then
    for i:=StrToInt(StrtBahnEdit.Text)+1 to WkAktuell.StartBahnen do
    begin
      if Veranstaltung.TlnColl.WettkSBhnTlnZahl(WkAktuell,i) > 0 then
        if TriaMessage(Self,'Für die gelöschten Startbahnen wurden bereits '+
                       'Teilnehmer eingeteilt.' + #13 +
                       'Diese Einteilung löschen?',
                        mtConfirmation,[mbOk,mbCancel])<>mrOk then
        begin
          WettkPageControl.ActivePage := SchwimmTS;
          if StrtBahnEdit.CanFocus then StrtBahnEdit.SetFocus;
          Exit;
        end else // Tln.SBhn löschen
        begin
          AlleSBhnLoeschen := true;
          Break;
        end;
    end;

  Refresh;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try

    // Optionale Änderungen durchführen
    if AlleMschWrtgModeUebernehmen then
      for i:=0 to Veranstaltung.OrtZahl-1 do
        WkAktuell.OrtMschWrtgMode[i] := GetMschWrtgModeGB;

    if AlleMannschGrUebernehmen then
      for i:=0 to Veranstaltung.OrtZahl-1 do
      with WkAktuell do
      begin
        OrtMschGroesse[cnSexBeide,i]  := StrToIntDef(MschGrAlleEdit.Text,0);
        OrtMschGroesse[cnMaennlich,i] := StrToIntDef(MschGrMaennerEdit.Text,0);
        OrtMschGroesse[cnWeiblich,i]  := StrToIntDef(MschGrFrauenEdit.Text,0);
        OrtMschGroesse[cnMixed,i]     := StrToIntDef(MschGrMixedEdit.Text,0);
      end;


    if AlleWkDatumUebernehmen then
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
      with Veranstaltung.WettkColl[i] do
      begin
        Datum := DatumEdit.Text;
        if SerWrtgJahrUebernehmen then SerWrtgJahr := JahrNeu;
      end
    else
    if SerWrtgJahrUebernehmen then
      WkAktuell.SerWrtgJahr := JahrNeu;


    if AlleSondWrtgLoeschen then
      for i:=0 to Veranstaltung.TlnColl.Count-1 do
      with Veranstaltung.TlnColl[i] do
        if WkAktuell = Wettk then SondWrtg := false;

    if AlleTlnLandLoeschen then
      for i:=0 to Veranstaltung.TlnColl.Count-1 do
      with Veranstaltung.TlnColl[i] do
        if WkAktuell = Wettk then Land := '';

    if AlleTlnTextUebernehmen then
    begin
      for i:=0 to Veranstaltung.WettkColl.Count-1 do
         Veranstaltung.WettkColl[i].TlnTxt := TlnTxtEdit.Text;
      if StrGleich(TlnTxtEdit.Text,'') then
        for i:=0 to Veranstaltung.TlnColl.Count-1 do
          Veranstaltung.TlnColl[i].Land := '';
    end;

    if AlleSBhnLoeschen then
      for i:=0 to Veranstaltung.TlnColl.Count-1 do
        with Veranstaltung.TlnColl[i] do
          if (WkAktuell = Wettk) and (SBhn > StrToInt(StrtBahnEdit.Text)) then
            SBhn := 0;

    // MschWertg für alle Tln anpassen
    if (WkAktuell.MschWertg = mwKein) and (GetMschWertgRG <> mwKein) then
      for i:=0 to Veranstaltung.TlnColl.Count-1 do
      with Veranstaltung.TlnColl[i] do
        if WkAktuell = Wettk then MschWrtg := true
        else
    else
    if (WkAktuell.MschWertg <> mwKein) and (GetMschWertgRG = mwKein) then
      for i:=0 to Veranstaltung.TlnColl.Count-1 do
      with Veranstaltung.TlnColl[i] do
        if WkAktuell = Wettk then
        begin
          MschWrtg := false;
          MschMixWrtg := false;
        end;

    // WkBufColl.ClearSortItem(WkAktuell); nicht mehr nötig, weil Index unverändert
    // hier wird FocusedItem neu gesetzt weil Item verschwindet
    if Veranstaltung.Serie then NameStr := NameEdit.Text
                           else NameStr := StandTitelEdit.Text;
    if MschGrAlleEdit.Enabled then MschGrAlle := StrToIntDef(MschGrAlleEdit.Text,0)
                              else MschGrAlle := 3; // Default, sonst DIV 0
    if MschGrMaennerEdit.Enabled then MschGrMaenner := StrToIntDef(MschGrMaennerEdit.Text,0)
                                 else MschGrMaenner := 3; // Default, sonst DIV 0
    if MschGrFrauenEdit.Enabled then MschGrFrauen := StrToIntDef(MschGrFrauenEdit.Text,0)
                                else MschGrFrauen := 3; // Default, sonst DIV 0
    if MschGrMixedEdit.Enabled then MschGrMixed := StrToIntDef(MschGrMixedEdit.Text,0)
                               else MschGrMixed := 3; // Default, sonst DIV 0

    WkAktuell.SetWettkAllgDaten(NameStr,
                                WkAktuell.StreichErg[tmTln],WkAktuell.StreichErg[tmMsch],
                                WkAktuell.StreichOrt[tmTln],WkAktuell.StreichOrt[tmMsch],
                                WkAktuell.PflichtWkMode[tmTln],WkAktuell.PflichtWkMode[tmMsch],
                                WkAktuell.PflichtWkOrt1[tmTln],WkAktuell.PflichtWkOrt1[tmMsch],
                                WkAktuell.PflichtWkOrt2[tmTln],WkAktuell.PflichtWkOrt2[tmMsch],
                                WkAktuell.PunktGleichOrt[tmTln],WkAktuell.PunktGleichOrt[tmMsch],
                                GetMschWertgRG,
                                WkAktuell.SerWrtgJahr,
                                WkAktuell.SerWrtgMode[tmTln],WkAktuell.SerWrtgMode[tmMsch]);
    WkAktuell.SetWettkOrtDaten(StandTitelEdit.Text,
                               SondTitelEdit.Text,
                               DatumEdit.Text,
                               GetWettkArtRG,
                               StrToIntDef(AbschnZahlEdit.Text,0),
                               GetAbsRunden(wkAbs1),
                               GetAbsRunden(wkAbs2),
                               GetAbsRunden(wkAbs3),
                               GetAbsRunden(wkAbs4),
                               GetAbsRunden(wkAbs5),
                               GetAbsRunden(wkAbs6),
                               GetAbsRunden(wkAbs7),
                               GetAbsRunden(wkAbs8),
                               GetAbsName(wkAbs1),
                               GetAbsName(wkAbs2),
                               GetAbsName(wkAbs3),
                               GetAbsName(wkAbs4),
                               GetAbsName(wkAbs5),
                               GetAbsName(wkAbs6),
                               GetAbsName(wkAbs7),
                               GetAbsName(wkAbs8),
                               TlnTxtEdit.Text,
                               GetMschWrtgModeGB,
                               MschGrAlle,MschGrMaenner,MschGrFrauen,MschGrMixed,
                               StrToIntDef(SchwDistEdit.Text,0),
                               StrToIntDef(StrtBahnEdit.Text,0),
                               StrToIntDef(RundLaengeEdit.Text,0),
                               StrToIntDef(StartgeldEdit.Text,0),
                               DisqTxtEdit.Text);
    // WkBufColl.AddSortItem(WkAktuell);

    HauptFenster.LstFrame.UpdateMschTlnColBreite;
    HauptFenster.LstFrame.UpdateAkColBreite;
    HauptFenster.LstFrame.UpdateColWidths; // Cols spStartBahn anpassen

    NeuEingabe := false; // vor Update
    WettkGrid.CollectionUpdate;
    WettkGrid.FocusedItem := WkAktuell;
    WettkGrid.Refresh;
    SetWettkDaten;
    //if WettkGrid.CanFocus then WettkGrid.SetFocus;

    TriDatei.Modified := true;
    Result := true;
  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;
end; (* procedure TWettkDialog.WettkAendern *)


(*----------------------------------------------------------------------------*)
procedure TWettkDialog.WettkLoeschen;
(*----------------------------------------------------------------------------*)
// WkAktuell entfernen
var i : Integer;
begin
  if WkAktuell = nil then Exit;
  Refresh;
  if not NeuEingabe then
    if Veranstaltung.TlnColl.WettkTlnZahl(WkAktuell) > 0 then
      if TriaMessage(Self,'Für den gewählten Wettkampf wurden bereits '+
                      IntToStr(Veranstaltung.TlnColl.WettkTlnZahl(WkAktuell))+
                     ' Teilnehmer angemeldet.'+#13+
                     'Wettkampf und Teilnehmer löschen?',
                      mtConfirmation,[mbOk,mbCancel]) <> mrOk then Exit
      else // Tln + SGrp löschen
      begin
        HauptFenster.ProgressBarInit('Wettkampf und Teilnehmer werden gelöscht',
                                     Veranstaltung.TlnColl.Count+
                                     Veranstaltung.MannschColl.Count+
                                     Veranstaltung.SGrpColl.Count);
        Refresh;
        HauptFenster.LstFrame.TriaGrid.StopPaint := true;
        // 2003-1.8
        // Mannschaften vor Tln löschen, dabei wird Tln.Mannsch=nil gesetzt
        try
        for i:=Veranstaltung.MannschColl.Count-1 downto 0 do
        begin
          if Veranstaltung.MannschColl[i].Wettk = WkAktuell then
            Veranstaltung.MannschColl.ClearIndex(i);
          HauptFenster.ProgressBarStep(1);
        end;
        for i:=Veranstaltung.TlnColl.Count-1 downto 0 do
        begin
          if Veranstaltung.TlnColl[i].Wettk = WkAktuell then
            Veranstaltung.TlnColl.ClearIndex(i);
          HauptFenster.ProgressBarStep(1);
        end;
        for i:=Veranstaltung.SGrpColl.Count-1 downto 0 do
        begin
          if Veranstaltung.SGrpColl[i].Wettkampf = WkAktuell then
            Veranstaltung.SGrpColl.ClearIndex(i);
          HauptFenster.ProgressBarStep(1);
        end;
        finally
          HauptFenster.StatusBarClear;
          HauptFenster.LstFrame.TriaGrid.StopPaint := false;
        end;
      end
    else // TlnZahl = 0
      if Veranstaltung.SGrpColl.SGrpZahl(WkAktuell) > 0 then
        if TriaMessage(Self,'Für den gewählten Wettkampf wurden bereits '+
                        IntToStr(Veranstaltung.SGrpColl.SGrpZahl(WkAktuell))+
                       ' Startgruppen definiert.'+#13+
                       'Wettkampf und Startgruppen löschen?',
                        mtConfirmation,[mbOk,mbCancel]) <> mrOk then Exit
        else // SGrp löschen
        begin
          HauptFenster.LstFrame.TriaGrid.StopPaint := true;
          try
            for i:=Veranstaltung.SGrpColl.Count-1 downto 0 do
              if Veranstaltung.SGrpColl[i].Wettkampf = WkAktuell then
                Veranstaltung.SGrpColl.ClearIndex(i);
          finally
            HauptFenster.LstFrame.TriaGrid.StopPaint := false;
          end;
        end
      else // TlnZahl = 0; SGpZahl = 0
        if TriaMessage(Self,'Gewählter Wettkampf löschen?',
                        mtConfirmation,[mbOk,mbCancel]) <> mrOk then Exit;

  Refresh;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    if not NeuEingabe then TriDatei.Modified := true;
    NeuEingabe := false; // vor ClearItem
    if HauptFenster.SortWettk = WkAktuell then
      HauptFenster.SortWettk := WettkAlleDummy; // bleibt gültig
    WettkGrid.ClearItem(WkAktuell);   (* WkAktuell löschen *)

    if WettkGrid.ItemCount = 0 then
    begin
      NeuEingabe := true; // vor AddItem
      WettkGrid.AddItem(TWettkObj.Create(Veranstaltung,Veranstaltung.WettkColl,oaAdd));
    end;
    WettkGrid.CollectionUpdate;
    WettkGrid.Refresh;
    SetWettkDaten;
    if NeuEingabe then
      if NameEdit.CanFocus then NameEdit.SetFocus
      else if StandTitelEdit.CanFocus then StandTitelEdit.SetFocus
      else
    else if WettkGrid.CanFocus then WettkGrid.SetFocus;
    //Veranstaltung.Jahr := Veranstaltung.WettkColl.AkJahr{Str};
  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;
end;

// published Methoden

// WettkDialog Allgemein

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.FormShow(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if WettkGrid.Collection.IndexOf(HauptFenster.SortWettk) >= 0 then
    WettkGrid.FocusedItem := HauptFenster.SortWettk;
  SetWettkDaten;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  CanClose := true;
  // auch nach Änderung wird Dialog ohne Rückfrage geschlossen um
  // Probleme zu vermeiden bei Fehler in WettkGeaendert
  // auch nach Drucken von ESC-Taste, obwohl Cancel=false, unklar warum

  // neue Wettk ohne Eingaben wird gelöscht (WkNeu=nil nach Eingabe)
  if (ModalResult=mrCancel) and NeuEingabe then
  begin
    if HauptFenster.SortWettk = WkAktuell then
      HauptFenster.SortWettk := WettkAlleDummy; // bleibt gültig
    WettkGrid.ClearItem(WkAktuell);
  end;
  if Veranstaltung.WettkColl.Count = 0 then
    TriaMessage(Self,'Anmeldung von Teilnehmern ist nur möglich, '+#13+
                'wenn mindestens einen Wettkampf definiert wurde.',
                 mtInformation,[mbOk]);
end;


// WettkGrid

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.WettkLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not EingabeOK then Exit;
  if WettkGrid.CanFocus then WettkGrid.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.WettkGridClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var Wk : TWettkObj;
begin
  (* Exit beim Setzen von FocusedItem oder ItemIndex *)
  if not WettkGrid.EnableOnClick then Exit
  else WettkGrid.EnableOnClick := false;

  try
    Wk := WettkSelected;
    if (Wk=nil) or (WkAktuell=nil) then Exit;

    if WettkGeAendert then
    begin
      WettkGrid.ScrollBars := ssNone;
      case TriaMessage(Self,'Die Einstellungen für '+WkAktuell.Name+' wurden geändert.'+#13+
                       'Änderungen übernehmen?',
                        mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes : if WettkAendern then
                begin
                  WettkGrid.FocusedItem := Wk; // zurückgesetzt in WettkAendern
                  SetWettkDaten;
                end else WettkGrid.FocusedItem := WkAktuell;
        mrNo  : if (Wk<>WkAktuell) and NeuEingabe then WettkLoeschen
                else SetWettkDaten;
        else    WettkGrid.FocusedItem := WkAktuell;
      end;
    end else if (Wk<>WkAktuell) and NeuEingabe then WettkLoeschen
    else SetWettkDaten; (* hier wird auch WkAktuell neu gesetzt *)
    WettkGrid.SetFocus;

  finally
    WettkGrid.ScrollBars := ssVertical;
    WettkGrid.EnableOnClick := true;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.WettkGridDrawCell(Sender: TObject; ACol,ARow: Integer;
                                            Rect: TRect; State: TGridDrawState);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var Text : String;
begin
  Text := ''; // dummy leerzeile wenn itemcount = 0
  with WettkGrid do
  begin
    if (Collection <> nil) and (ARow < ItemCount) then (* FixedRows = 0 *)
      {if (ARow>0) or not NeuEingabe then} // Text='' für neue Wettk auf zeile 1
        Text := TWettkObj(Collection.SortItems[ARow]).Name;
    DrawCellText(Rect,Text,taLeftJustify);
  end;
end;

//WettkPageControl

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.WettkPageControlChanging(Sender: TObject;
                                                var AllowChange: Boolean);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// vor change ausgeführt
begin
  if EingabeOK then AllowChange := true
               else AllowChange := false;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.WettkPageControlChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// nach change ausgeführt
begin
  SetPage;
end;


// AllgemeinTS

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.AllgemeinTSShow(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if StandTitelEdit.CanFocus then StandTitelEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.NameLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if NameEdit.CanFocus then NameEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.NameEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DlgUpdating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.StandTitelEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DlgUpdating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.StandTitelLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if StandTitelEdit.CanFocus then StandTitelEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.DatumLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if DatumEdit.CanFocus then DatumEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.DatumEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DlgUpdating then SetButtons;
end;

// AbschnTS

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.AbschnTSShow(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if AbschnZahlEdit.CanFocus then AbschnZahlEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.AbschnZahlLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if AbschnZahlEdit.CanFocus then AbschnZahlEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.AbschnZahlEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// Text ändern in UpDownBtn.Click geht nicht, weil dann Position nicht mit
// geändert werden kann.
begin
  if not DlgUpdating  then
  begin
    UpdateAbschn(StrToIntDef(AbschnZahlEdit.Text,0));
    SetButtons;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.AbsNameLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var AbsCnt : TWkAbschnitt;
begin
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if Sender = AbsNameLabel[AbsCnt] then
    begin
      if AbsNameCB[AbsCnt].CanFocus then AbsNameCB[AbsCnt].SetFocus;
      Break;
    end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.AbsNameCBChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var AbsCnt : TWkAbschnitt;
begin
  // AbsNameArr updaten
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if Sender = AbsNameCB[AbsCnt] then
    begin
      if not StrGleich(AbsNameCB[AbsCnt].Text,'') then
        AbsNameArr[AbsCnt] := AbsNameCB[AbsCnt].Text;
      Break;
    end;

  if not DlgUpdating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.AbsRundenLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var AbsCnt : TWkAbschnitt;
begin
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if Sender = AbsRundenLabel[AbsCnt] then
    begin
      if AbsRundenEdit[AbsCnt].CanFocus then AbsRundenEdit[AbsCnt].SetFocus;
      Break;
    end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.AbsRundenEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DlgUpdating then SetButtons;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TWettkDialog.RundLaengeLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if RundLaengeEdit.CanFocus then RundLaengeEdit.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TWettkDialog.RundLaengeEditChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
 if not DlgUpdating then SetButtons;
end;


// WertungTS

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.WertungTSShow(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if WettkArtRG.CanFocus then WettkArtRG.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.WettkArtRGClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// DTU Schultour nur bei waEinzel
var AbsZahlNeu : Integer;
begin
  if not DlgUpdating then
  begin
    AbsZahlNeu := StrToIntDef(AbschnZahlEdit.Text,1);

    if (GetWettkArtRG<>waEinzel) and (WettkArtRG.ItemIndex>=0) then
    begin
      if GetMschWrtgModeGB = wmSchultour then
      begin
        TriaMessage(Self,'Diese Wettkampfart ist bei der "DTU Schultour" nicht möglich.',
                    mtInformation,[mbOk]);
        SetWettkArtRG(WettkArtAlt);
        Exit;
      end;

      if (GetWettkArtRG=waRndRennen) or (GetWettkArtRG=waStndRennen) then
        // Änderung AbschnZahlEdit wird in EventHandler geprüft
        if StrToIntDef(AbschnZahlEdit.Text,0) > 1 then
        begin
          if TriaMessage(Self,'Bei dieser Wettkampfart darf nur 1 '+
                         'Wettkampfabschnitt definiert sein.'+#13+#13+
                         'Abschnittszahl korrigieren?',
                         mtConfirmation,[mbOk,mbCancel]) <> mrOk then
          begin
            SetWettkArtRG(WettkArtAlt);
            Exit;
          end else
            AbsZahlNeu := 1; // in UpdateWettkAbschnGB(AbsZahlNeu) korrigiert
        end else
      else

      if GetWettkArtRG = waTlnStaffel then // nie bei Serie
      begin
        // Änderung AbschnZahlEdit wird in EventHandler geprüft
        if StrToIntDef(AbschnZahlEdit.Text,0) < 2 then
        begin
          if TriaMessage(Self,'Bei dieser Wettkampfart müssen mindestens 2 '+
                         'Wettkampfabschnitte definiert sein.'+#13+#13+
                         'Abschnittszahl korrigieren?',
                         mtConfirmation,[mbOk,mbCancel]) <> mrOk then
          begin
            SetWettkArtRG(WettkArtAlt);
            Exit;
          end else
            AbsZahlNeu := 2; // in UpdateWettkAbschnGB(AbsZahlNeu) korrigiert
        end;

        if ((GetMschWertgRG = mwMulti)or(GetMschWertgRG = mwEinzel)) and
           (MschWertgRG.ItemIndex>=0) then
          if TriaMessage(Self,'Bei dieser Wettkampfart ist keine Mannschaftswertung möglich.'+#13+#13+
                         'Mannschaftswertung ausschalten?',
                          mtConfirmation,[mbOk,mbCancel]) <> mrOk then
          begin
            SetWettkArtRG(WettkArtAlt);
            Exit;
          end else; // Korrektur in SetMschWrtg
      end
      else

      if GetWettkArtRG = waTlnTeam then // nie bei Serie
      begin
        // Änderung AbschnZahlEdit wird in EventHandler geprüft
        if StrToIntDef(AbschnZahlEdit.Text,0) > 1 then
        begin
          if TriaMessage(Self,'Bei dieser Wettkampfart darf nur 1 '+
                         'Wettkampfabschnitt definiert sein.'+#13+#13+
                         'Abschnittszahl korrigieren?',
                         mtConfirmation,[mbOk,mbCancel]) <> mrOk then
          begin
            SetWettkArtRG(WettkArtAlt);
            Exit;
          end else
            AbsZahlNeu := 1; // in UpdateWettkAbschnGB(AbsZahlNeu) korrigiert
        end;

        if ((GetMschWertgRG = mwMulti)or(GetMschWertgRG = mwEinzel)) and
           (MschWertgRG.ItemIndex>=0) then
          if TriaMessage(Self,'Bei dieser Wettkampfart ist keine Mannschaftswertung möglich.'+#13+#13+
                         'Mannschaftswertung ausschalten?',
                          mtConfirmation,[mbOk,mbCancel]) <> mrOk then
          begin
            SetWettkArtRG(WettkArtAlt);
            Exit;
          end else; // Korrektur in SetMschWrtg
      end
      else
      begin
        // waMschStaffel,waMschTeam
        if (GetMschWertgRG = mwMulti) and (MschWertgRG.ItemIndex>=0) then
          if Veranstaltung.Serie then
            if TriaMessage(Self,'Bei dieser Wettkampfart ist eine Mannschaftswertung mit '+
                           'mehreren Mannschaften pro Verein nicht möglich.'+#13+
                           'Dies gilt für alle Austragungsorte.'+#13+#13+
                           'Mannschaftswertung korrigieren?',
                            mtConfirmation,[mbOk,mbCancel]) <> mrOk then
            begin
              SetWettkArtRG(WettkArtAlt);
              Exit;
            end else  // Korrektur in SetMschWrtg
          else
            if TriaMessage(Self,'Bei dieser Wettkampfart ist eine Mannschaftswertung mit '+
                           'mehreren Mannschaften pro Verein nicht möglich.'+#13+#13+
                           'Mannschaftswertung korrigieren?',
                            mtConfirmation,[mbOk,mbCancel]) <> mrOk then
            begin
              SetWettkArtRG(WettkArtAlt);
              Exit;
            end else;  // Korrektur in SetMschWrtg

      end;
    end;

    if WettkArtRG.CanFocus then WettkArtRG.SetFocus;

    WettkArtAlt := GetWettkArtRG;
    UpdateWettkAbschnGB(AbsZahlNeu);
    UpdateTlnTxtCB;
    SetMschWrtg(GetMschWertgRG,GetMschWrtgModeGB,
                StrToIntDef(MschGrAlleEdit.Text,0),
                StrToIntDef(MschGrMaennerEdit.Text,0),
                StrToIntDef(MschGrFrauenEdit.Text,0),
                StrToIntDef(MschGrMixedEdit.Text,0));
    SetButtons;
  end;
end;

// TeilnehmerTS

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.TlnWertungTSShow(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if SondWrtgCB.CanFocus then SondWrtgCB.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.EditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DlgUpdating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.SondWrtgCBClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  UpdateSondTitelEdit;
  if SondWrtgCB.Checked then
    if SondTitelEdit.CanFocus then SondTitelEdit.SetFocus;
  if not DlgUpdating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.TlnTxtCBClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  UpdateTlnTxtEdit;
  if TlnTxtCB.Checked then
    if TlnTxtEdit.CanFocus then TlnTxtEdit.SetFocus;
  if not DlgUpdating then SetButtons;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TWettkDialog.StartgeldCBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  UpdateStartgeldEdit;
  if StartgeldCB.Checked then
    if StartgeldEdit.CanFocus then StartgeldEdit.SetFocus;
  if not DlgUpdating then SetButtons;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TWettkDialog.StartgeldLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if StartgeldEdit.CanFocus then StartgeldEdit.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TWettkDialog.DisqTxtCBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  UpdateDisqTxtEdit;
  if DisqTxtCB.Checked then
    if DisqTxtEdit.CanFocus then DisqTxtEdit.SetFocus;
  if not DlgUpdating then SetButtons;
end;


// MannschaftenTS

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.MannschWertungTSShow(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if MschWertgRG.CanFocus then MschWertgRG.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.MschWertgRGClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if MschWertgRG.CanFocus then MschWertgRG.SetFocus;
  if not DlgUpdating then
  begin
    // MschWrtgModeGB und MschGrGB anpassen
    SetMschWrtg(GetMschWertgRG,GetMschWrtgModeGB,
                StrToIntDef(MschGrAlleEdit.Text,0),
                StrToIntDef(MschGrMaennerEdit.Text,0),
                StrToIntDef(MschGrFrauenEdit.Text,0),
                StrToIntDef(MschGrMixedEdit.Text,0));
    SetButtons;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TWettkDialog.MschWrtgModeGBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  case GetMschWrtgModeGB of
    wmTlnPlatz  : if TlnPlatzRB.CanFocus then TlnPlatzRB.SetFocus;
    wmSchultour : if SchultourRB.CanFocus then SchultourRB.SetFocus;
    else if TlnZeitRB.CanFocus then TlnZeitRB.SetFocus;
  end;
  if not DlgUpdating then
  begin
    // MschWertgRG und MschGrGB anpassen
    SetMschWrtg(GetMschWertgRG,GetMschWrtgModeGB,
                StrToIntDef(MschGrAlleEdit.Text,0),
                StrToIntDef(MschGrMaennerEdit.Text,0),
                StrToIntDef(MschGrFrauenEdit.Text,0),
                StrToIntDef(MschGrMixedEdit.Text,0));
    SetButtons;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.MschGrLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if (Sender = MschGrGB) or (Sender = MschGrAlleLabel) then
    if MschGrAlleEdit.CanFocus then MschGrAlleEdit.SetFocus
    else
  else if Sender = MschGrMaennerLabel then
    if MschGrMaennerEdit.CanFocus then MschGrMaennerEdit.SetFocus
    else
  else if Sender = MschGrFrauenLabel then
    if MschGrFrauenEdit.CanFocus then MschGrFrauenEdit.SetFocus
    else
  else if Sender = MschGrMixedLabel then
    if MschGrMixedEdit.CanFocus then MschGrMixedEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.MschGrEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// EditMask = '09;0; '
begin
  if not DlgUpdating then SetButtons;
end;

// SchwimmTS

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.SchwimmTSShow(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if StrtBahnCB.CanFocus then StrtBahnCB.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.StrtBahnCBClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  UpdateStrtBahn;
  if StrtBahnCB.Checked then
    if StrtBahnEdit.CanFocus then StrtBahnEdit.SetFocus;
  if not DlgUpdating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.StrtBahnLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if StrtBahnEdit.CanFocus then StrtBahnEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.StrtBahnEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DlgUpdating then SetButtons;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.SchwDistCBClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  UpdateSchwDist;
  if SchwDistCB.Checked then
    if SchwDistEdit.CanFocus then SchwDistEdit.SetFocus;
  if not DlgUpdating then SetButtons;
end;


(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.SchwDistLabelClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if SchwDistEdit.CanFocus then SchwDistEdit.SetFocus;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.SchwDistEditChange(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DlgUpdating then SetButtons;
end;


// Buttons

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.UpButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
// Index ist gültig, wenn Button enabled
var Indx : Integer;
begin
  with WettkGrid do
  begin
    if not DisableButtons then
    try
      DisableButtons := true;
      Enabled := false;
      Indx := ItemIndex;
      Veranstaltung.WettkColl.List.Exchange(Indx,Indx-1);
      Veranstaltung.WettkColl.Sortieren(Veranstaltung.WettkColl.SortMode);
      FocusedItem := WkAktuell;
      SetButtons;
      TriDatei.Modified := true; // Datei wird sofort geändert
    finally
      DisableButtons := false;
      Enabled := true;
      Refresh;
    end;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.DownButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
var Indx : Integer;
begin
  with WettkGrid do
  begin
    if not DisableButtons then
    try
      DisableButtons := true;
      Enabled := false;
      Indx := ItemIndex;
      Veranstaltung.WettkColl.List.Exchange(Indx,Indx+1);
      Veranstaltung.WettkColl.Sortieren(Veranstaltung.WettkColl.SortMode);
      FocusedItem := WkAktuell;
      SetButtons;
      TriDatei.Modified := true; // Datei wird sofort geändert
    finally
      DisableButtons := false;
      Enabled := true;
      Refresh;
    end;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.NeuButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    WettkGrid.Enabled := false;
    WettkNeu;
  finally
    DisableButtons := false;
    WettkGrid.Enabled := true;
    WettkGrid.Refresh;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.AendButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    WettkGrid.Enabled := false;
    WettkAendern;
  finally
    DisableButtons := false;
    WettkGrid.Enabled := true;
    WettkGrid.Refresh;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.LoeschButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    WettkGrid.Enabled := false;
    WettkLoeschen;
  finally
    DisableButtons := false;
    WettkGrid.Enabled := true;
    WettkGrid.Refresh;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.OkButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    if WettkGeAendert then
      if WettkAendern then ModalResult := mrOk
      else ModalResult := mrNone
    else
      // Fehler nur bei Unstimmigkeit in alter Datei, kommt normal nicht vor
      if EingabeOK then ModalResult := mrOk
      else ModalResult := mrNone;
  finally
    DisableButtons := false;
  end;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.CancelButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  ModalResult := mrCancel; (* Prüfung in FormCloseQuery *)
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TWettkDialog.HilfeButtonClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  Application.HelpContext(0500);  // Wettkämpfe
end;


end.
