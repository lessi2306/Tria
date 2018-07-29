unit SGrpDlg;

interface             

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Grids, ExtCtrls,ComCtrls, Math,
  AllgComp,AllgConst,AllgFunc,DateiDlg,AllgObj,AkObj,WettkObj,TlnObj,
  VeranObj,SGrpObj,MannsObj;

procedure SGrpEingeben;

type
  TSGrpDialog = class(TForm)

  published
    SGrpLabel: TLabel;
    SGrpGrid: TTriaGrid;
    SGrpPageControl: TPageControl;
      AllgemeinTS: TTabSheet;
        NameEdit: TTriaEdit;
        NameLabel: TLabel;
        WettkCBLabel: TLabel;
        WettkCB: TComboBox;
        StartNrGB: TGroupBox;
          SnrVonLabel: TLabel;
          SnrVonEdit: TTriaMaskEdit;
          SnrVonUpDown: TTriaUpDown;
          SnrBisLabel: TLabel;
          SnrBisEdit: TTriaMaskEdit;
          SnrBisUpDown: TTriaUpDown;
        StarterGB: TGroupBox;
          StarterMaxLabel: TLabel;
          StarterIstLabel: TLabel;
          StarterMaxEdit: TTriaMaskEdit;
          StarterIstEdit: TTriaMaskEdit;
      StartMode1TS: TTabSheet;
        Abschnitt1GB: TGroupBox;
          Start1OhnePauseRB: TRadioButton;
          Start1MassenStartRB: TRadioButton;
          Start1JagdStartRB: TRadioButton;
          Start1DeltaEdit: TMinZeitEdit;
          Start1FormatLabel: TLabel;
          StartZeit1Label: TLabel;
          StartZeit1Edit: TUhrZeitEdit;
        Abschnitt2GB: TGroupBox;
          Start2OhnePauseRB: TRadioButton;
          Start2MassenStartRB: TRadioButton;
          Start2JagdStartRB: TRadioButton;
          StartZeit2Label: TLabel;
          StartZeit2Edit: TUhrZeitEdit;
        Abschnitt3GB: TGroupBox;
          Start3OhnePauseRB: TRadioButton;
          Start3MassenStartRB: TRadioButton;
          Start3JagdStartRB: TRadioButton;
          StartZeit3Label: TLabel;
          StartZeit3Edit: TUhrZeitEdit;
        Abschnitt4GB: TGroupBox;
          Start4OhnePauseRB: TRadioButton;
          Start4MassenStartRB: TRadioButton;
          Start4JagdStartRB: TRadioButton;
          StartZeit4Label: TLabel;
          StartZeit4Edit: TUhrZeitEdit;
      StartMode2TS: TTabSheet;
        Abschnitt5GB: TGroupBox;
          Start5OhnePauseRB: TRadioButton;
          Start5MassenStartRB: TRadioButton;
          Start5JagdStartRB: TRadioButton;
          StartZeit5Label: TLabel;
          StartZeit5Edit: TUhrZeitEdit;
        Abschnitt6GB: TGroupBox;
          Start6OhnePauseRB: TRadioButton;
          Start6MassenStartRB: TRadioButton;
          Start6JagdStartRB: TRadioButton;
          StartZeit6Label: TLabel;
          StartZeit6Edit: TUhrZeitEdit;
        Abschnitt7GB: TGroupBox;
          Start7OhnePauseRB: TRadioButton;
          Start7MassenStartRB: TRadioButton;
          Start7JagdStartRB: TRadioButton;
          StartZeit7Label: TLabel;
          StartZeit7Edit: TUhrZeitEdit;
        Abschnitt8GB: TGroupBox;
          Start8OhnePauseRB: TRadioButton;
          Start8MassenStartRB: TRadioButton;
          Start8JagdStartRB: TRadioButton;
          StartZeit8Label: TLabel;
          StartZeit8Edit: TUhrZeitEdit;

    AendButton: TButton;
    NeuButton: TButton;
    LoeschButton: TButton;
    OkButton: TButton;
    HilfeButton: TButton;
    CancelButton: TButton;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

  protected
    HelpFensterAlt : TWinControl;
    Updating       : Boolean;
    DisableButtons : Boolean;
    NeuEingabe     : Boolean;
    SGAktuell      : TSGrpObj;
    PageAktuell    : TTabSheet;
    Start1DeltaBuf : String;
    //NamefehltOK    : Boolean;
    StartZeitBuf       : array [wkAbs1..wkAbs8] of String;
    AbschnittGB        : array [wkAbs1..wkAbs8] of TGroupBox;
    StartOhnePauseRB   : array [wkAbs1..wkAbs8] of TRadioButton;
    StartMassenStartRB : array [wkAbs1..wkAbs8] of TRadioButton;
    StartJagdStartRB   : array [wkAbs1..wkAbs8] of TRadioButton;
    StartZeitLabel     : array [wkAbs1..wkAbs8] of TLabel;
    StartZeitEdit      : array [wkAbs1..wkAbs8] of TUhrZeitEdit;

    function    SGrpSelected: TSGrpObj;
    procedure   SetSGrpDaten;
    procedure   SetPage(Page:TTabSheet);
    procedure   SetButtons;
    procedure   SetAbschnittStartMode(Abs:TWkAbschnitt);
    function    GetAbschnittStartMode(Abs:TWkAbschnitt):TStartMode;
    function    WettkSelected: TWettkObj;
    procedure   SetWettkDaten;
    function    SGrpGeAendert: Boolean;
    function    SnrVorhanden(SG:TSGrpObj): Boolean;
    function    TlnSnrOutside(Tln:TTlnObj): Boolean;
    function    EingabeOK(Tab:TTabSheet): Boolean;
    function    SGrpNeu: Boolean;
    function    SGrpAendern: Boolean;
    procedure   SGrpLoeschen;
    function    StarterMaxStr(const Von,Bis: Integer): String;

  published
    // Event Handler Allgemein
    procedure FormShow(Sender: TObject);
    procedure SGrpLabelClick(Sender: TObject);
    procedure SGrpGridClick(Sender: TObject);
    procedure SGrpGridDrawCell(Sender: TObject; ACol, ARow: Integer;
                               Rect: TRect; State: TGridDrawState);
    procedure SGrpPageControlChanging(Sender: TObject;var AllowChange: Boolean);
    procedure SGrpPageControlChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    // Event Handler AllgemeinTS
    procedure AllgemeinTSShow(Sender: TObject);
    procedure NameEditChange(Sender: TObject);
    procedure WettkCBChange(Sender: TObject);
    procedure StartNrGBClick(Sender: TObject);
    procedure SnrVonLabelClick(Sender: TObject);
    procedure SnrEditChange(Sender: TObject);
    procedure SnrBisLabelClick(Sender: TObject);

    // Event Handler StartModeTS
    procedure StartMode1TSShow(Sender: TObject);
    procedure StartMode2TSShow(Sender: TObject);
    procedure AbschnittGBClick(Sender: TObject);
    procedure StartModeRBClick(Sender: TObject);
    procedure Start1DeltaEditChange(Sender: TObject);
    procedure Start1DeltaEditExit(Sender: TObject);
    procedure StartZeitLabelClick(Sender: TObject);
    procedure StartZeitEditChange(Sender: TObject);
    procedure StartZeitEditExit(Sender: TObject);

    // Event Handler Buttons
    procedure LoeschButtonClick(Sender: TObject);
    procedure NeuButtonClick(Sender: TObject);
    procedure AendButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);
  end;

var
  SGrpDialog: TSGrpDialog;

implementation

uses TriaMain,CmdProc,TlnErg,VistaFix;

{$R *.DFM}

//******************************************************************************
procedure SGrpEingeben;
//******************************************************************************
(* Definition von Startnummern, Zahl der Starter,Startzeit der Startgruppen *)
//(* SGrp <> nil bei StartZeit �nderung w�hrend Wettkampf *)
begin
  SGrpDialog := TSGrpDialog.Create(HauptFenster);
  try
    SGrpDialog.ShowModal;
  finally
    FreeAndNil(SGrpDialog);
  end;
  HauptFenster.RefreshAnsicht;
end;

// public Methoden

//==============================================================================
constructor TSGrpDialog.Create(AOwner: TComponent);
//==============================================================================
var SG : TSGrpObj;
    i : Integer;

//..............................................................................
procedure InitAbsArr;
begin
  //Abs1
  AbschnittGB[wkAbs1]        := Abschnitt1GB;
  StartOhnePauseRB[wkAbs1]   := Start1OhnePauseRB;
  StartMassenStartRB[wkAbs1] := Start1MassenStartRB;
  StartJagdStartRB[wkAbs1]   := Start1JagdStartRB;
  StartZeitLabel[wkAbs1]     := StartZeit1Label;
  StartZeitEdit[wkAbs1]      := StartZeit1Edit;
  //Abs2
  AbschnittGB[wkAbs2]        := Abschnitt2GB;
  StartOhnePauseRB[wkAbs2]   := Start2OhnePauseRB;
  StartMassenStartRB[wkAbs2] := Start2MassenStartRB;
  StartJagdStartRB[wkAbs2]   := Start2JagdStartRB;
  StartZeitLabel[wkAbs2]     := StartZeit2Label;
  StartZeitEdit[wkAbs2]      := StartZeit2Edit;
  //Abs3
  AbschnittGB[wkAbs3]        := Abschnitt3GB;
  StartOhnePauseRB[wkAbs3]   := Start3OhnePauseRB;
  StartMassenStartRB[wkAbs3] := Start3MassenStartRB;
  StartJagdStartRB[wkAbs3]   := Start3JagdStartRB;
  StartZeitLabel[wkAbs3]     := StartZeit3Label;
  StartZeitEdit[wkAbs3]      := StartZeit3Edit;
  //Abs4
  AbschnittGB[wkAbs4]        := Abschnitt4GB;
  StartOhnePauseRB[wkAbs4]   := Start4OhnePauseRB;
  StartMassenStartRB[wkAbs4] := Start4MassenStartRB;
  StartJagdStartRB[wkAbs4]   := Start4JagdStartRB;
  StartZeitLabel[wkAbs4]     := StartZeit4Label;
  StartZeitEdit[wkAbs4]      := StartZeit4Edit;
  //Abs5
  AbschnittGB[wkAbs5]        := Abschnitt5GB;
  StartOhnePauseRB[wkAbs5]   := Start5OhnePauseRB;
  StartMassenStartRB[wkAbs5] := Start5MassenStartRB;
  StartJagdStartRB[wkAbs5]   := Start5JagdStartRB;
  StartZeitLabel[wkAbs5]     := StartZeit5Label;
  StartZeitEdit[wkAbs5]      := StartZeit5Edit;
  //Abs6
  AbschnittGB[wkAbs6]        := Abschnitt6GB;
  StartOhnePauseRB[wkAbs6]   := Start6OhnePauseRB;
  StartMassenStartRB[wkAbs6] := Start6MassenStartRB;
  StartJagdStartRB[wkAbs6]   := Start6JagdStartRB;
  StartZeitLabel[wkAbs6]     := StartZeit6Label;
  StartZeitEdit[wkAbs6]      := StartZeit6Edit;
  //Abs7
  AbschnittGB[wkAbs7]        := Abschnitt7GB;
  StartOhnePauseRB[wkAbs7]   := Start7OhnePauseRB;
  StartMassenStartRB[wkAbs7] := Start7MassenStartRB;
  StartJagdStartRB[wkAbs7]   := Start7JagdStartRB;
  StartZeitLabel[wkAbs7]     := StartZeit7Label;
  StartZeitEdit[wkAbs7]      := StartZeit7Edit;
  //Abs8
  AbschnittGB[wkAbs8]        := Abschnitt8GB;
  StartOhnePauseRB[wkAbs8]   := Start8OhnePauseRB;
  StartMassenStartRB[wkAbs8] := Start8MassenStartRB;
  StartJagdStartRB[wkAbs8]   := Start8JagdStartRB;
  StartZeitLabel[wkAbs8]     := StartZeit8Label;
  StartZeitEdit[wkAbs8]      := StartZeit8Edit;
end;

//..............................................................................
begin
  inherited Create(AOwner);
  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  Updating       := false;
  DisableButtons := false;
  //NamefehltOK    := false;
  SGAktuell      := nil;
  SGrpGrid.Canvas.Font := SGrpGrid.Font;
  SGrpGrid.DefaultRowHeight := SGrpGrid.Canvas.TextHeight('Tg')+1;
  SGrpGrid.FixedRows := 1;
  SGrpGrid.FixedCols := 0;
  SGrpGrid.ColCount  := 6;

  InitAbsArr;

  if Veranstaltung.Serie then
    Caption := Caption + '  -  ' + Veranstaltung.OrtName;

  Veranstaltung.SGrpColl.Sortieren(Veranstaltung.OrtIndex,WettkAlleDummy);
  SGrpGrid.Init(Veranstaltung.SGrpColl,smSortiert,ssVertical,nil);

  with Veranstaltung.WettkColl do
  begin
    // kein Wettk voreinstellen, damit bewu�t gew�hlt werden muss
    if Count > 1 then WettkCB.Items.Append('<kein>');
    for i:=0 to Count-1 do WettkCB.Items.Append(Items[i].Name);
  end;

  SnrVonEdit.EditMask := '0999;0; ';
  SnrBisEdit.EditMask := '0999;0; ';
  SnrVonUpDown.Min := 1;
  SnrVonUpDown.Max := cnTlnMax;
  SnrBisUpDown.Min := 1;
  SnrBisUpDown.Max := cnTlnMax;

  // vorab neue SGrp erstellen, die bei Abbruch wieder gel�scht wird
  if SGrpGrid.ItemCount = 0 then
  begin
    SG := TSGrpObj.Create(Veranstaltung,Veranstaltung.SGrpColl,oaAdd);
    SG.Init('',WettkAlleDummy); // SnrVon=SnrBis=0, FreierSnrBereich in SetSGrpDaten
    NeuEingabe := true; // vor AddItem
    SGrpGrid.AddItem(SG);
  end else NeuEingabe := false;
  // SetSGrpDaten wird in FormShow aufgerufen
  // SetSGrpDaten kann in Init nicht benutzt werden wegen SetPage/FocusItem

  SGrpGrid.TabOrder := 0; (* Set Focus *)
  StartZeit1Edit.TabOrder := 0;

  CancelButton.Cancel := true;

  SGrpGrid.ColWidths[0] := Canvas.TextWidth(' SGrp-Name ');
  case ZeitFormat of
    zfSek         : SGrpGrid.ColWidths[1] := Canvas.TextWidth(' 00:00:00 ');
    zfZehntel     : SGrpGrid.ColWidths[1] := Canvas.TextWidth(' 00:00:00.0 ');
    zfHundertstel : SGrpGrid.ColWidths[1] := Canvas.TextWidth(' 00:00:00.00 ');
  end;

  SGrpGrid.ColWidths[2] := Canvas.TextWidth(' SnrVon ');
  SGrpGrid.ColWidths[3] := Canvas.TextWidth(' SnrBis ');
  SGrpGrid.ColWidths[4] := SGrpGrid.ClientWidth -
                           SGrpGrid.ColWidths[0] -
                           SGrpGrid.ColWidths[1] -
                           SGrpGrid.ColWidths[2] -
                           SGrpGrid.ColWidths[3] - 4;
  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);
end;

//==============================================================================
destructor TSGrpDialog.Destroy;
//==============================================================================
begin
  HelpFenster := HelpFensterAlt;
  inherited Destroy;
end;

// protected Methoden

//------------------------------------------------------------------------------
function TSGrpDialog.SGrpSelected: TSGrpObj;
//------------------------------------------------------------------------------
begin
  Result := TSGrpObj(SGrpGrid.FocusedItem);
end;

//------------------------------------------------------------------------------
procedure TSGrpDialog.SetSGrpDaten;
//------------------------------------------------------------------------------
var AbsCnt : TWkAbschnitt;
    ErsteFreieSnr,LetzteFreieSnr : Integer;
begin
  SGAktuell := SGrpSelected;
  if SGAktuell = nil then Exit;
  Updating := true;

  NameEdit.Text := SGAktuell.Name;

  if (SGAktuell.Wettkampf<>nil) and
     (SGAktuell.Wettkampf<>WettkAlleDummy) and
     (Veranstaltung.WettkColl.IndexOf(SGAktuell.Wettkampf) >= 0) and
     (WettkCB.Items.Count > 1) then
    WettkCB.ItemIndex := Veranstaltung.WettkColl.IndexOf(SGAktuell.Wettkampf)+1
  else WettkCB.ItemIndex := 0;

  SetWettkDaten; // Wettkdaten vor StartMode wegen Enable/Disable Abschn

  ErsteFreieSnr  := 0;
  LetzteFreieSnr := 0;
  if NeuEingabe and
     (SGAktuell.StartnrVon = 0) and (SGAktuell.StartnrBis = 0) and
     Veranstaltung.SGrpColl.FreierSnrBereich(ErsteFreieSnr,LetzteFreieSnr) then
  begin
    SnrVonEdit.Text := IntToStr(ErsteFreieSnr);
    SnrBisEdit.Text := IntToStr(LetzteFreieSnr);
    StarterMaxEdit.Text := StarterMaxStr(ErsteFreieSnr,LetzteFreieSnr);
    StarterIstEdit.Text := '0';
  end else
  begin
    SnrVonEdit.Text := IntToStr(SGAktuell.StartnrVon);
    SnrBisEdit.Text := IntToStr(SGAktuell.StartnrBis);
    StarterMaxEdit.Text := StarterMaxStr(SGAktuell.StartnrVon,SGAktuell.StartnrBis);
    StarterIstEdit.Text := IntToStr(Veranstaltung.TlnColl.SGrpTlnZahl(SGAktuell));
  end;


  for AbsCnt:=wkAbs1 to wkAbs8 do
  begin
    StartZeitEdit[AbsCnt].InitEditMask;
    if AbsCnt=wkAbs1 then Start1DeltaEdit.InitEditMask;
    if AbschnittGB[AbsCnt].Enabled then // in SetWettkDaten
    begin
      StartJagdStartRB[AbsCnt].Enabled   := true;
      StartMassenStartRB[AbsCnt].Enabled := true;
      if AbsCnt <> wkAbs1 then // wkAbs1 in SetWettkDaten
        StartOhnePauseRB[AbsCnt].Enabled := true;
      case SGAktuell.StartModus[AbsCnt] of
        stJagdStart:
        begin
          StartJagdStartRB[AbsCnt].Checked := true;
          StartZeitEdit[AbsCnt].Text := UhrZeitStr(SGAktuell.StartZeit[AbsCnt]);
          if AbsCnt=wkAbs1 then
            Start1DeltaEdit.Text := MinZeitStr(SGAktuell.Start1Delta);
        end;
        stMassenStart:
        begin
          StartMassenStartRB[AbsCnt].Checked := true;
          StartZeitEdit[AbsCnt].Text := UhrZeitStr(SGAktuell.StartZeit[AbsCnt]);
          if AbsCnt=wkAbs1 then
            Start1DeltaEdit.Text := MinZeitStr(0);
        end;
        else // stOhnePause
        begin
          if StartOhnePauseRB[AbsCnt].Enabled then // stOhnePause:
          begin
            StartOhnePauseRB[AbsCnt].Checked := true;
            StartZeitEdit[AbsCnt].Text := '';
          end else // nur wkAbs1, stMassenStart:
          begin
            StartMassenStartRB[AbsCnt].Checked := true;
            StartZeitEdit[AbsCnt].Text := UhrZeitStr(SGAktuell.StartZeit[AbsCnt]);
          end;
          if AbsCnt=wkAbs1 then
            Start1DeltaEdit.Text := MinZeitStr(0);
        end;
      end
    end else
    begin
      StartOhnePauseRB[AbsCnt].Enabled   := false;
      StartOhnePauseRB[AbsCnt].Checked   := false;
      StartMassenStartRB[AbsCnt].Enabled := false;
      StartMassenStartRB[AbsCnt].Checked := false;
      StartJagdStartRB[AbsCnt].Enabled   := false;
      StartJagdStartRB[AbsCnt].Checked   := false;
    end;

    StartZeitEdit[AbsCnt].TextAlt := StartZeitEdit[AbsCnt].Text;
    StartZeitBuf[AbsCnt]          := StartZeitEdit[AbsCnt].Text;
    if AbsCnt=wkAbs1 then
      Start1DeltaBuf := Start1DeltaEdit.Text;

    SetAbschnittStartMode(AbsCnt);  // kein Click Event ausgel�st
  end;

  SetButtons;
  SetPage(PageAktuell);
  Updating := false;
  Refresh;
end; (* procedure TSGrpDialog.SetSGrpDaten *)

//------------------------------------------------------------------------------
procedure TSGrpDialog.SetButtons;
//------------------------------------------------------------------------------
begin
  OkButton.Enabled := true;

  if NeuEingabe then
    if not SGrpGeAendert then
    begin
      NeuButton.Enabled := false;
      AendButton.Enabled := false;
      if SGrpGrid.ItemCount=1 then LoeschButton.Enabled := false
                              else LoeschButton.Enabled := true;
      AendButton.Default := false;
      OkButton.Default := true;
    end else
    begin
      NeuButton.Enabled := false;  // neu, von SMldDlg
      AendButton.Enabled := true;  //
      LoeschButton.Enabled := true;//
      AendButton.Default := true;  //pr�fen!!!!, auch bei anderen Dlg
      OkButton.Default := false;   //
    end
  else // keine NeuEingabe
    if not SGrpGeAendert then
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
  //CommandTrailer; // bei SMldDlg, damit Men�Buttons gesetzt werden
end;

//------------------------------------------------------------------------------
procedure TSGrpDialog.SetPage(Page:TTabSheet);
//------------------------------------------------------------------------------
begin
  if Page = PageAktuell then Exit;  (* damit nicht Focussiert wird *)
  PageAktuell := Page;
  SGrpPageControl.ActivePage := PageAktuell;
  //Taborder bestimmt welcher Focussiert wird
  if NameEdit.CanFocus then NameEdit.SetFocus;
  if StartZeit1Edit.CanFocus then StartZeit1Edit.SetFocus;
  // korrigiert: Massenstart darf nicht selektiert werden !!
end;

//------------------------------------------------------------------------------
procedure TSGrpDialog.SetAbschnittStartMode(Abs:TWkAbschnitt);
//------------------------------------------------------------------------------
// wird in OnClick Methoden der RB aufgerufen
begin
  if Abs = wkAbs1 then
    if Start1JagdStartRB.Checked then
    begin
      Start1DeltaEdit.Text      := Start1DeltaBuf;
      Start1DeltaEdit.Enabled   := true;
      Start1FormatLabel.Enabled := true;
    end else
    begin
      Start1DeltaBuf            := Start1DeltaEdit.Text;
      Start1DeltaEdit.Text      := MinZeitStr(0);
      Start1DeltaEdit.Enabled   := false;
      Start1FormatLabel.Enabled := false;
    end;

  if (not AbschnittGB[Abs].Enabled) or StartOhnePauseRB[Abs].Checked then
  begin
    StartZeitBuf[Abs]           := StartZeitEdit[Abs].Text;
    StartZeitEdit[Abs].Text     := '';
    StartZeitEdit[Abs].TextAlt  := StartZeitEdit[Abs].Text;
    StartZeitLabel[Abs].Enabled := false;
    StartZeitEdit[Abs].Enabled  := false;
  end else
  begin
    StartZeitEdit[Abs].Text     := StartZeitBuf[Abs];
    StartZeitEdit[Abs].TextAlt  := StartZeitEdit[Abs].Text;
    StartZeitLabel[Abs].Enabled := true;
    StartZeitEdit[Abs].Enabled  := true;
  end;

  if not Updating then SetButtons;
end;

//----------------------------------------------------------------------------//
function TSGrpDialog.GetAbschnittStartMode(Abs:TWkAbschnitt): TStartMode;
//----------------------------------------------------------------------------//
begin
  if StartMassenStartRB[Abs].Checked then Result := stMassenStart
  else if StartJagdstartRB[Abs].Checked then Result := stJagdStart
  else if StartOhnePauseRB[Abs].Checked then Result := stOhnePause
  else // kein check, sollte nicht vorkommen
  if Abs = wkabs1 then Result := stMassenStart
                  else Result := stOhnePause;
end;

//------------------------------------------------------------------------------
function TSGrpDialog.WettkSelected: TWettkObj;
//------------------------------------------------------------------------------
begin
  if WettkCB.Items.Count = 1 then Result := Veranstaltung.WettkColl[0]
  else
  if (WettkCB.ItemIndex > 0) and
     (WettkCB.ItemIndex <= Veranstaltung.WettkColl.Count) then
    Result := Veranstaltung.WettkColl[WettkCB.ItemIndex-1]
  else Result := WettkAlleDummy;
end;

//------------------------------------------------------------------------------
procedure TSGrpDialog.SetWettkDaten;
//------------------------------------------------------------------------------
var Wettk : TWettkObj;
    Zahl  : Integer;
    AbsCnt : TWkAbschnitt;
begin
  Wettk := WettkSelected;

  if Wettk.WettkArt = waMschStaffel then
  begin
    StartMode1TS.Caption := 'Start - Teilnehmer 1-4';
    StartMode2TS.Caption := 'Start - Teilnehmer 5-8';

    Zahl := Wettk.MschGroesse[cnSexBeide];
    for AbsCnt:=wkAbs1 to wkAbs8 do
      AbschnittGB[AbsCnt].Caption := 'Teiln. ' + IntToStr(Integer(AbsCnt))+
                                     ', Abschn. 1';
  end else
  begin
    StartMode1TS.Caption := 'Start - Abschnitte 1-4';
    StartMode2TS.Caption := 'Start - Abschnitte 5-8';

    Zahl := Wettk.AbSchnZahl;
    for AbsCnt:=wkAbs1 to wkAbs8 do
      AbschnittGB[AbsCnt].Caption := 'Abschnitt ' + IntToStr(Integer(AbsCnt));
  end;

  for AbsCnt:=wkAbs8 downto wkAbs2 do // Rest wird in SetSGrpDaten gesetzt
    if Zahl < Integer(AbsCnt) then AbschnittGB[AbsCnt].Enabled := false
                              else AbschnittGB[AbsCnt].Enabled := true;

  if Wettk.MschWettk then // Einzelstart nur bei Einzelwettk
  begin
    if StartOhnePauseRB[wkAbs1].Checked then
    begin
      StartMassenStartRB[wkAbs1].Checked := true;
      StartZeitEdit[wkAbs1].Text := UhrZeitStr(SGAktuell.StartZeit[wkAbs1]);
      Start1DeltaEdit.Text := MinZeitStr(0);
    end;
    StartOhnePauseRB[wkAbs1].Enabled := false
  end else
    StartOhnePauseRB[wkAbs1].Enabled := true;

end;

//------------------------------------------------------------------------------
function TSGrpDialog.SGrpGeAendert: Boolean;
//------------------------------------------------------------------------------
//..............................................................................
function AbsArrGeAendert: Boolean;
var AbsCnt: TWkAbschnitt;
begin
  Result := true;
  for AbsCnt:=wkAbs1 to wkAbs8 do
  with SGAktuell do
    if (StartModus[AbsCnt] <> GetAbschnittStartMode(AbsCnt)) or
       (StartModus[AbsCnt] <> stOhnePause)and
        not StartZeitEdit[AbsCnt].ZeitGleich(UhrZeitStr(StartZeit[AbsCnt])) or
       (AbsCnt=wkAbs1)and(StartModus[AbsCnt]=stJagdStart)and
        not Start1DeltaEdit.ZeitGleich(MinZeitStr(Start1Delta)) then Exit;
  Result := false;
end;

//..............................................................................
begin
  if SGAktuell = nil then Result := false
  else with SGAktuell do
    Result := (not StrGleich(SGAktuell.Name, NameEdit.Text)) or
              (Wettkampf <> WettkSelected) or
               AbsArrGeAendert or
              (StartnrVon <> StrToIntDef(SnrVonEdit.Text,0)) or
              (StartnrBis <> StrToIntDef(SnrBisEdit.Text,0));
end;

//------------------------------------------------------------------------------
function TSGrpDialog.SnrVorhanden(SG:TSGrpObj): Boolean;
//------------------------------------------------------------------------------
(* pr�fen ob eingetragene Snr in SGrp=SG bereits vergeben wurden *)
var i : integer;
begin
  Result := false;
  if (SG.StartnrVon=0) or
     (StrToIntDef(SnrVonEdit.Text,0)<=0) or (StrToIntDef(SnrBisEdit.Text,0)<=0) then Exit;

  for i:=StrToIntDef(SnrVonEdit.Text,0) to StrToIntDef(SnrBisEdit.Text,0) do
    if (i>=SG.StartnrVon) and (i<=SG.StartnrBis) then
    begin
      Result := true;
      Exit;
    end;
end;

//------------------------------------------------------------------------------
function TSGrpDialog.TlnSnrOutside(Tln:TTlnObj): Boolean;
//------------------------------------------------------------------------------
begin
  with Tln do
    Result := (SGrp = SGAktuell) and (Snr > 0) and
              ((Snr < StrToIntDef(SnrVonEdit.Text,0)) or (Snr > StrToIntDef(SnrBisEdit.Text,0)));
end;

//------------------------------------------------------------------------------
function TSGrpDialog.EingabeOK(Tab:TTabSheet): Boolean;
//------------------------------------------------------------------------------
var i,j     : Integer;
    SGrpBuf : TSGrpObj;
    AbsCnt  : TWkAbschnitt;
    ModiUebernehmen : Boolean;
    Abs1ModeAlt : TStartMode;
begin
  Result := false;

  // Fehler wenn Name bereits vorhanden, kein Name ('') zulassen
  if Trim(NameEdit.Text) <> '' then
    for i:=0 to Veranstaltung.SGrpColl.Count-1 do
    begin
      SGrpBuf := Veranstaltung.SGrpColl[i];
      if (SGrpBuf.WkOrtIndex = Veranstaltung.OrtIndex) and
         (SGrpBuf <> SGAktuell) and
          StrGleich(SGrpBuf.Name,NameEdit.Text) then
      begin
        TriaMessage(Self,'Name ist bereits vorhanden.',mtInformation,[mbOk]);
        SGrpPageControl.ActivePage := AllgemeinTS;
        if NameEdit.CanFocus then NameEdit.SetFocus;
        Exit;
      end;
    end;

  if WettkSelected = WettkAlleDummy then
  begin
    TriaMessage(Self,'Wettkampf fehlt.',mtInformation,[mbOk]);
    SGrpPageControl.ActivePage := AllgemeinTS;
    if WettkCB.CanFocus then WettkCB.SetFocus;
    Exit;
  end;

  // Startnummern (Validate wird bei Enter-Taste nicht aufgerufen, nur bei Exit-Comp)
  if (Tab = nil) or
     (Tab=AllgemeinTS)and(SGrpPageControl.ActivePage=AllgemeinTS) then
  begin
    if not SnrVonEdit.ValidateEdit then Exit;
    if not SnrBisEdit.ValidateEdit then Exit;
    if (StrToIntDef(SnrVonEdit.Text,0) > StrToIntDef(SnrBisEdit.Text,0)) or
       (StrToIntDef(SnrVonEdit.Text,0) < SnrVonUpDown.Min) or
       (StrToIntDef(SnrBisEdit.Text,0) > SnrBisUpDown.Max) then
    begin
      TriaMessage(Self,'Der Startnummernbereich ist ung�ltig.',mtInformation,[mbOk]);
      if SnrVonEdit.CanFocus then SnrVonEdit.SetFocus;
      Exit;
    end;
  end;

  if (GetAbschnittStartMode(wkAbs1) = stJagdStart) and
     ((Tab=nil) or
      (Tab=StartMode1TS)and(SGrpPageControl.ActivePage = StartMode1TS)) then
  begin
    if not Start1DeltaEdit.ValidateEdit then Exit;
    if Start1DeltaEdit.Wert <= 0 then
    begin
      TriaMessage(Self,'Zeitabstand f�r Jagdstart (1. Abschnitt) fehlt.',
                   mtInformation,[mbOk]);
      if Start1DeltaEdit.CanFocus then Start1DeltaEdit.SetFocus;
      Exit;
    end;
  end;

  for AbsCnt:=wkAbs1 to wkAbs8 do
    if (GetAbschnittStartMode(AbsCnt) <> stOhnePause) and
       ((Tab=nil) or
        (Tab=StartMode1TS)and(SGrpPageControl.ActivePage = StartMode1TS)and
        (AbsCnt <= wkAbs4) or
        (Tab=StartMode2TS)and(SGrpPageControl.ActivePage = StartMode2TS)and
         (AbsCnt > wkAbs4)) then
    begin
      if not StartZeitEdit[AbsCnt].ValidateEdit then Exit;
      if (StartZeitEdit[AbsCnt].Wert < 0) then
      begin
        TriaMessage(Self,'Startzeit ('+IntToStr(integer(AbsCnt))+'. Abschnitt) fehlt.',
                    mtInformation,[mbOk]);
        if StartZeitEdit[AbsCnt].CanFocus then StartZeitEdit[AbsCnt].SetFocus;
        Exit;
      end;
    end;

  // Warnung wenn eingetragene Snr bereits vergeben wurden und keine �berlappung zugelassen
  // �berlappung erlaubt um �nderungen zu erleichtern,
  // Tln k�nnen aber nicht mit gleicher Snr eingeteilt werden
  if not SnrUeberlapp then
    for i:=0 to Veranstaltung.SGrpColl.Count-1 do
    begin
      SGrpBuf := Veranstaltung.SGrpColl[i];
      if (SGrpBuf.WkOrtIndex = Veranstaltung.OrtIndex) and
         (SGrpBuf<>SGAktuell) and SnrVorhanden(SGrpBuf) then
        case TriaMessage(Self,'Startnummernbereich �berlappt mit der einer anderen Startgruppe.'+#13+#13+
                              '�berlappung zulassen?',
                              mtConfirmation,[mbYesToAll,mbYes,mbNo]) of
          mrYes: Break;
          mrYesToAll:
          begin
            SnrUeberlapp := true;
            Break;
          end;
          else
          begin
            SGrpPageControl.ActivePage := AllgemeinTS;
            if SnrVonEdit.CanFocus then SnrVonEdit.SetFocus;
            Exit;
          end;
        end;
    end;

  for i:=0 to Veranstaltung.TlnColl.Count-1 do
    if TlnSnrOutside(Veranstaltung.TlnColl[i]) then
      if TriaMessage(Self,'F�r diese Startgruppe wurden Startnummern au�erhalb'+#13+
                     'des definierten Bereiches an Teilnehmern vergeben.'+#13+#13+
                     'Startnummernbereich beibehalten?',
                     mtConfirmation,[mbYes,mbNo]) <> mrYes then
      begin
        SGrpPageControl.ActivePage := AllgemeinTS;
        if SnrVonEdit.CanFocus then SnrVonEdit.SetFocus;
        Exit;
      end else Break;

  // pr�fe ob Startmodi gleich f�r alle SGrp in Wettk
  // am Ende, damit Modi nur ge�ndert werden wenn alles Ok ist
  ModiUebernehmen := false;
  for i:=0 to Veranstaltung.SGrpColl.Count-1 do
  begin
    SGrpBuf := Veranstaltung.SGrpColl[i];
    if (SGrpBuf.WkOrtIndex = Veranstaltung.OrtIndex) and
       (SGrpBuf.Wettkampf = WettkSelected) and
       (SGrpBuf <> SGAktuell) then
      for AbsCnt:=wkAbs1 to wkAbs8 do
        if (SGrpBuf.StartModus[AbsCnt] <> GetAbschnittStartMode(AbsCnt)) and
          ((Tab=nil) or
           (Tab=StartMode1TS)and(SGrpPageControl.ActivePage = StartMode1TS)and
           (AbsCnt <= wkAbs4) or
           (Tab=StartMode2TS)and(SGrpPageControl.ActivePage = StartMode2TS)and
           (AbsCnt > wkAbs4)) then
          if TriaMessage(Self,'Die Startmodi m�ssen f�r alle Startgruppen eines Wettkampfes gleich sein.' +#13+
                         'Startmodi f�r alle �bernehmen?',
                          mtConfirmation,[mbOk,mbCancel]) <> mrOk then
          begin
            if AbsCnt <= wkAbs4 then SGrpPageControl.ActivePage := StartMode1TS
                                else SGrpPageControl.ActivePage := StartMode2TS;
            if StartMassenStartRB[AbsCnt].Checked then
              if StartMassenStartRB[AbsCnt].CanFocus then StartMassenStartRB[AbsCnt].SetFocus
              else
            else
            if StartJagdStartRB[AbsCnt].Checked then
              if StartJagdStartRB[AbsCnt].CanFocus then StartJagdStartRB[AbsCnt].SetFocus
              else
            else
            if StartOhnePauseRB[AbsCnt].Enabled and StartOhnePauseRB[AbsCnt].CanFocus then
			        StartOhnePauseRB[AbsCnt].SetFocus;
            Exit;
          end else
          begin
            ModiUebernehmen := true;
            Break;
          end;
    if ModiUebernehmen then Break;
  end;
  if ModiUebernehmen then
    for i:=0 to Veranstaltung.SGrpColl.Count-1 do
    begin
      SGrpBuf := Veranstaltung.SGrpColl[i];
      if (SGrpBuf.WkOrtIndex = Veranstaltung.OrtIndex) and
         (SGrpBuf.Wettkampf = WettkSelected) then // auch SGAktuell
        for AbsCnt:=wkAbs1 to wkAbs8 do
          if SGrpBuf.StartModus[AbsCnt] <> GetAbschnittStartMode(AbsCnt) then
          begin
            Abs1ModeAlt := SGrpBuf.StartModus[wkAbs1];
            SGrpBuf.StartModus[AbsCnt] := GetAbschnittStartMode(AbsCnt);
            if SGrpBuf.StartModus[AbsCnt] <> stOhnePause then
              if SGrpBuf.StartZeit[AbsCnt] < 0 then
                SGrpBuf.StartZeit[AbsCnt] := StartZeitEdit[AbsCnt].Wert
              else // Startzeit behalten
            else SGrpBuf.StartZeit[AbsCnt] := -1;
            if SGrpBuf.StartModus[AbsCnt] = stJagdStart then
              if SGrpBuf.Start1Delta <= 0 then
                SGrpBuf.Start1Delta := Start1DeltaEdit.Wert
              else // Delta behalten
            else SGrpBuf.Start1Delta := 0;
            if (AbsCnt=wkAbs1)and // EinzelStartzeiten l�schen
               ((SGrpBuf.StartModus[wkAbs1]=stOhnePause)or(Abs1ModeAlt=stOhnePause)) then
              Veranstaltung.TlnColl.ClearTlnStrtZeit(WettkSelected,SGrpBuf);
            // sicherheitshalber immer, wegen EinzelStartZeit und SGrp.ErstZeiten
            for j:=0 to Veranstaltung.WettkColl.Count-1 do
              Veranstaltung.WettkColl[j].ErgModified := true;
            TriDatei.Modified := true;
          end;
    end;

  Result := true;
end;

//------------------------------------------------------------------------------
function TSGrpDialog.SGrpNeu: Boolean;
//------------------------------------------------------------------------------
var ErsteFreieSnr, LetzteFreieSnr : Integer;
    SG : TSGrpObj;
begin
  Result := false;

  // ge�nderte Daten �bernehmen
  if SGrpGeAendert then
    if NeuEingabe then
      if not SGrpAendern then Exit
      else
    else
    case TriaMessage(Self,'Die Einstellungen der markierten Startgruppe wurden ge�ndert.'+#13+
                     '�nderungen �bernehmen?',
                      mtConfirmation,[mbYes,mbNo,mbCancel]) of
      mrYes : if not SGrpAendern then Exit;
      mrNo  : ;
      else    Exit;
    end;

  if Veranstaltung.SGrpColl.Count >= cnSGrpMax then
  begin
    TriaMessage(Self,'Maximale Startgruppenzahl erreicht.',mtInformation,[mbOk]);
    Exit;
  end;
  if not SnrUeberlapp then
    if not Veranstaltung.SGrpColl.FreierSnrBereich(ErsteFreieSnr,LetzteFreieSnr) then
      if TriaMessage(Self,'Alle Startnummern sind belegt.' +#13+#13+
                     '�berlappende Startnummernbereiche zulassen?',
                     mtConfirmation,[mbYes,mbNo]) <> mrYes then Exit
                                                           else SnrUeberlapp := true;

  Refresh;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    SG := TSGrpObj.Create(Veranstaltung,Veranstaltung.SGrpColl,oaAdd);
    SG.Init('',WettkAlleDummy); // SnrVon=SnrBis=0, FreierSnrBereich in SetSGrpDaten
    NeuEingabe := true;  // vor AddItem
    SGrpGrid.AddItem(SG);
    SGrpGrid.FocusedItem := SG;
    SetSGrpDaten; (* SGAktuell gesetzt *)
    SetPage(AllgemeinTS);
    if NameEdit.CanFocus then NameEdit.SetFocus;
    Result := true;
  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;
end;

//------------------------------------------------------------------------------
function TSGrpDialog.SGrpAendern: Boolean;
//------------------------------------------------------------------------------
// SGAktuell �ndern
var j,Zeit1Delta : Integer;
    ZeitArr : TAbsZeitArr;   // abs1..8
    ModeArr : TStartModeArr; // abs1..8
    AbsCnt  : TWkAbschnitt;
    ModeAbs1Alt : TStartMode;
//..............................................................................
procedure TlnWettkAendern;
var i : Integer;
begin
  for i:=0 to Veranstaltung.TlnColl.Count-1 do
    with Veranstaltung.TlnColl[i] do
      if SGrp = SGAktuell then Wettk := WettkSelected;
end;
//..............................................................................
begin
  Result := false;
  // abfragen ob Wettk der eingeteilte Tln ge�ndert werden soll und
  // Mannsch.Wettk auch �ndern (Version 7.66)
  if (SGAktuell=nil) or not EingabeOk(nil) then Exit;

  (* gepr�fte Daten �bernehmen *)
  if not NeuEingabe and Veranstaltung.TlnColl.SGrpBelegt(SGAktuell) and
     (WettkSelected<>SGAktuell.Wettkampf) then
    if TriaMessage(Self,'In der markierten Startgruppe wurden bereits Teilnehmer eingeteilt.'+#13+
                   'Wettkampf f�r alle eingeteilte Teilnehmer �ndern?',
                    mtConfirmation,[mbOk,mbCancel]) = mrOk then
    begin
      HauptFenster.LstFrame.TriaGrid.StopPaint := true;
      TlnWettkAendern;
    end else
    begin
      SetSGrpDaten;
      if SGrpGrid.CanFocus then SGrpGrid.SetFocus;
      Exit;
    end;

  Refresh;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try

    if GetAbschnittStartMode(wkAbs1) = stJagdStart then
      Zeit1Delta := Start1DeltaEdit.Wert
    else Zeit1Delta := 0;
    for AbsCnt := wkAbs1 to wkAbs8 do
    begin
      if GetAbschnittStartMode(AbsCnt) = stOhnePause then
        ZeitArr[AbsCnt] := -1
      else ZeitArr[AbsCnt] := StartZeitEdit[AbsCnt].Wert;
      ModeArr[AbsCnt] := GetAbschnittStartMode(AbsCnt);
    end;
    ModeAbs1Alt := SGAktuell.StartModus[wkAbs1];

    SGAktuell.Init(Trim(NameEdit.Text), WettkSelected,
                   Zeit1Delta, ZeitArr, ModeArr,
                   StrToIntDef(SnrVonEdit.Text,0), StrToIntDef(SnrBisEdit.Text,0));
    NeuEingabe := false; // vor Update
    SGrpGrid.CollectionUpdate;
    SGrpGrid.Refresh;
    SGrpGrid.FocusedItem := SGAktuell;
    SetSGrpDaten;
    if SGrpGrid.CanFocus then SGrpGrid.SetFocus;
    if (ModeAbs1Alt <> SGAktuell.StartModus[wkAbs1]) and
       ((SGAktuell.StartModus[wkAbs1] = stOhnePause) or
        (ModeAbs1Alt = stOhnePause)) then // EinzelStart
      Veranstaltung.TlnColl.ClearTlnStrtZeit(WettkSelected,SGAktuell);
    // sicherheitshalber immer, wegen EinzelStartZeit und SGrp.ErstZeiten
    for j:=0 to Veranstaltung.WettkColl.Count-1 do
      Veranstaltung.WettkColl[j].ErgModified := true;
    TriDatei.Modified := true;
    Result := true;
  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;
end; (* procedure TSGrpDialog.SGrpAendern *)

//------------------------------------------------------------------------------
procedure TSGrpDialog.SGrpLoeschen;
//------------------------------------------------------------------------------
// SGAktuell entfernen
procedure TlnSGrpLoeschen;
var i:Integer;
begin
  for i:=0 to Veranstaltung.TlnColl.Count-1 do
    with Veranstaltung.TlnColl[i] do if SGrp=SGAktuell then EinteilungLoeschen;
end;

begin
  if SGAktuell = nil then Exit;
  Refresh;
  if not NeuEingabe and Veranstaltung.SGrpColl.TlnGestartet(SGAktuell) then
    if TriaMessage(Self,'In der markierten Startgruppe sind bereits Teilnehmer gestartet.'+#13+
                   'Einteilung und Zeiten dieser Teilnehmer l�schen?',
                    mtConfirmation,[mbOk,mbCancel]) = mrOk then
    begin
      Refresh;
      HauptFenster.LstFrame.TriaGrid.StopPaint := true;
      TlnSGrpLoeschen;
    end
    else Exit
  else if not NeuEingabe and Veranstaltung.TlnColl.SGrpBelegt(SGAktuell) then
    if TriaMessage(Self,'In der markierten Startgruppe sind bereits Teilnehmer eingeteilt.'+#13+
                   'Einteilung dieser Teilnehmer l�schen?',
                    mtConfirmation,[mbOk,mbCancel]) = mrOk then
    begin
      Refresh;
      HauptFenster.LstFrame.TriaGrid.StopPaint := true;
      TlnSGrpLoeschen;
    end
    else Exit
  else if not NeuEingabe and (TriaMessage(Self,'Markierte Startgruppe l�schen?',
                             mtConfirmation,[mbOk,mbCancel]) <> mrOk) then Exit;

  Refresh;
  HauptFenster.LstFrame.TriaGrid.StopPaint := true;
  try
    if not NeuEingabe then TriDatei.Modified := true;
    NeuEingabe := false; // vor ClearItem
    SGrpGrid.ClearItem(SGAktuell);   (* SGAktuell l�schen *)

    if SGrpGrid.ItemCount = 0 then
    begin
      NeuEingabe := true; // vor AddItem
      SGrpGrid.AddItem(TSGrpObj.Create(Veranstaltung,Veranstaltung.SGrpColl,oaAdd));
    end;
    SGrpGrid.CollectionUpdate;
    SGrpGrid.Refresh;
    SetSGrpDaten;
    if NeuEingabe then
      if NameEdit.CanFocus then NameEdit.SetFocus
      else
    else if SGrpGrid.CanFocus then SGrpGrid.SetFocus;
  finally
    HauptFenster.CommandDataUpdate;
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
  end;
end;  (* procedure TSGrpDialog.SGrpLoeschen *)

//------------------------------------------------------------------------------
function TSGrpDialog.StarterMaxStr(const Von, Bis: Integer): String;
//------------------------------------------------------------------------------
begin
  if Bis - Von >= 0 then Result := IntToStr(Bis - Von + 1)
                    else Result := '0';
end;


(******************************************************************************)
(*  Event Handler Allgemein                                                   *)
(******************************************************************************)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.FormShow(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  SetSGrpDaten;
  SetPage(AllgemeinTS);
  if SGrpGrid.CanFocus then SGrpGrid.SetFocus;
  PageAktuell := SGrpPageControl.ActivePage;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.SGrpLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if DisableButtons or
     SGrpGeAendert and not EingabeOK(SGrpPageControl.ActivePage) then Exit;
  if SGrpGrid.CanFocus then SGrpGrid.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.SGrpGridClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var SG : TSGrpObj;
begin
  (* Exit beim Setzen von FocusedItem oder ItemIndex *)
  if not SGrpGrid.EnableOnClick then Exit
  else SGrpGrid.EnableOnClick := false; // wird sonst mehrfach aufgerufen beim Scrollen

  try
    SG := SGrpSelected;
    if (SG = nil) or (SGAktuell = nil) or (SG=SGAktuell) then Exit;

    if SGrpGeAendert then
    begin
      SGrpGrid.Scrollbars := ssNone; // weiterscrollen verhindern, Folgefehler!
      case TriaMessage(Self,'Die Startgruppen-Einstellungen wurden ge�ndert.'+#13+
                       '�nderungen �bernehmen?',
                        mtConfirmation,[mbYes,mbNo,mbCancel]) of
        mrYes : if SGrpAendern then
                begin
                  SGrpGrid.FocusedItem := SG; // zur�ckgesetzt in SGrpAendern
                  SetSGrpDaten;
                end else SGrpGrid.FocusedItem := SGAktuell;
        mrNo  : if (SG<>SGAktuell) and NeuEingabe then SGrpLoeschen
                else SetSGrpDaten;
        else    SGrpGrid.FocusedItem := SGAktuell;
      end;
    end
    else if (SG<>SGAktuell) and NeuEingabe then SGrpLoeschen
    else SetSGrpDaten; (* hier wird auch SGAktuell neu gesetzt *)

  finally
    SGrpGrid.Scrollbars := ssVertical;
    SGrpGrid.EnableOnClick := true;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.SGrpGridDrawCell(Sender: TObject; ACol,ARow: Integer;
                                            Rect: TRect; State: TGridDrawState);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var Text : String;
    SGrp : TSGrpObj;
    Ausrichtung: TAlignment;
begin
  {if (ACol=0) and (ARow=WettkGrid.Row) then ZeigeWettkText;}
  Text := ''; // dummy leerzeile wenn itemcount = 0
  Ausrichtung := taLeftJustify;
  with SGrpGrid do
  begin
    if Collection <> nil then
      if ARow=0 then (* �berschrift *)
      begin
        case ACol of
          0:  Text := 'Name';
          1:  Text := 'Startzeit';
          2:  Text := 'SnrVon';
          3:  Text := 'SnrBis';
          4:  Text := 'Wettkampf';
        end;
      end
      else if ARow < ItemCount  + 1 then (* FixedRows = 1 *)
      begin
        SGrp := TSGrpObj(Collection.SortItems[ARow-1]);
        // neue SGrp immer 1.Zeile (InitValue, Text='')
        case ACol of
          0: begin
               Text := SGrp.Name;
               Ausrichtung := taLeftJustify;
             end;
          1: begin
               Text := UhrZeitStr(SGrp.StartZeit[wkAbs1]);
               Ausrichtung := taRightJustify;
             end;
          2: begin
               if SGrp.StartNrVon > 0 then
                 Text := Strng(SGrp.StartNrVon,4);
               Ausrichtung := taRightJustify;
             end;
          3: begin
               if SGrp.StartNrBis > 0 then
                 Text := Strng(SGrp.StartNrBis,4);
               Ausrichtung := taRightJustify;
             end;
          4: begin
               if SGrp.Wettkampf <> WettkAlleDummy then
                 Text := SGrp.Wettkampf.Name;
               Ausrichtung := taLeftJustify;
             end;
        end;
      end;
    DrawCellText(Rect,Text,Ausrichtung);
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.SGrpPageControlChanging(Sender: TObject;
                                              var AllowChange: Boolean);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// vor change ausgef�hrt
begin
  if Updating or not DisableButtons or not SGrpGeAendert or
    EingabeOK(SGrpPageControl.ActivePage) then AllowChange := true
  else AllowChange := false;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.SGrpPageControlChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// nach change ausgef�hrt
begin
  SetPage(SGrpPageControl.ActivePage);
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var i : Integer;
begin
  CanClose := false;
  if (SGrpGrid.ItemCount > 0) and not NeuEingabe then
  for i:=0 to Veranstaltung.WettkColl.Count-1 do
    if Veranstaltung.SGrpColl.SGrpZahl(Veranstaltung.WettkColl[i]) = 0 then
      if TriaMessage(Self,'F�r Wettkampf  "'+ Veranstaltung.WettkColl[i].Name +
                     '"  wurde keine Startgruppe definiert.',
                      mtWarning,[mbOk,mbCancel]) <> mrOk then Exit
      else Break;
  CanClose := true;
  // neue SGrp ohne Eingaben wird gel�scht
  if (ModalResult=mrCancel)and NeuEingabe then SGrpGrid.ClearItem(SGAktuell);
end;

(******************************************************************************)
(*  Event Handler AllgemeinTS                                                 *)
(******************************************************************************)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.AllgemeinTSShow(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if NameEdit.CanFocus then NameEdit.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.NameEditChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then SetButtons;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.WettkCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  SetWettkDaten;
  if not Updating then SetButtons;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.StartNrGBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if SnrVonEdit.CanFocus then SnrVonEdit.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.SnrVonLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if SnrVonEdit.CanFocus then SnrVonEdit.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.SnrEditChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  StarterMaxEdit.Text := StarterMaxStr(StrToIntDef(SnrVonEdit.Text,0),StrToIntDef(SnrBisEdit.Text,0));
  if not Updating then SetButtons;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.SnrBisLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if SnrBisEdit.CanFocus then SnrBisEdit.SetFocus;
end;


(******************************************************************************)
(*  Event Handler StartMode1TS                                                *)
(******************************************************************************)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.StartMode1TSShow(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if Start1MassenStartRB.Checked then
    if StartZeit1Edit.CanFocus then StartZeit1Edit.SetFocus
    else
  else
  if Start1JagdStartRB.Checked then
    if Start1DeltaEdit.CanFocus then Start1DeltaEdit.SetFocus
    else
  else
    if Start1OhnePauseRB.CanFocus then Start1OhnePauseRB.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.StartMode2TSShow(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if Start5OhnePauseRB.Checked then
    if Start5OhnePauseRB.CanFocus then Start5OhnePauseRB.SetFocus
    else
  else
    if StartZeit5Edit.CanFocus then StartZeit5Edit.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.AbschnittGBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var AbsCnt : TWkAbschnitt;
begin
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if Sender = AbschnittGB[AbsCnt] then
    begin
      if not StartOhnePauseRB[AbsCnt].Checked then
        if StartZeitEdit[AbsCnt].CanFocus then StartZeitEdit[AbsCnt].SetFocus;
      Exit;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.StartModeRBClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var AbsCnt : TWkAbschnitt;
begin
  if not Updating then
    for AbsCnt:=wkAbs1 to wkAbs8 do
      if Sender = StartMassenStartRB[AbsCnt] then
      begin
        SetAbschnittStartMode(AbsCnt);
        if StartZeitEdit[AbsCnt].CanFocus then StartZeitEdit[AbsCnt].SetFocus;
        Exit;
      end else
      if Sender = StartJagdStartRB[AbsCnt] then
      begin
        SetAbschnittStartMode(AbsCnt);
        if AbsCnt=wkAbs1 then
          if Start1DeltaEdit.CanFocus then Start1DeltaEdit.SetFocus
          else
        else
          if StartZeitEdit[AbsCnt].CanFocus then StartZeitEdit[AbsCnt].SetFocus;
        Exit;
      end else
      if Sender = StartOhnePauseRB[AbsCnt] then
      begin
        SetAbschnittStartMode(AbsCnt);
        Exit;
      end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.Start1DeltaEditChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not Updating then SetButtons;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.Start1DeltaEditExit(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  Start1DeltaBuf := Start1DeltaEdit.Text;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.StartZeitLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var AbsCnt : TWkAbschnitt;
begin
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if Sender = StartZeitEdit[AbsCnt] then
    begin
      if StartZeitEdit[AbsCnt].CanFocus then StartZeitEdit[AbsCnt].SetFocus;
      Exit;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.StartZeitEditChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var AbsCnt : TWkAbschnitt;
begin
  if not Updating then
    for AbsCnt:=wkAbs1 to wkAbs8 do
      if Sender = StartZeitEdit[AbsCnt] then
      begin
        if StartZeitEdit[AbsCnt].Modified or
          (StartZeitEdit[AbsCnt].Text <> StartZeitEdit[AbsCnt].TextAlt) then
        begin
          StartZeitEdit[AbsCnt].TextAlt := StartZeitEdit[AbsCnt].Text;
          SetButtons;
        end;
        Exit;
      end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.StartZeitEditExit(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var AbsCnt : TWkAbschnitt;
begin
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if Sender = StartZeitEdit[AbsCnt] then
    begin
      StartZeitBuf[AbsCnt] := StartZeitEdit[AbsCnt].Text;
      Exit;
    end;
end;


(******************************************************************************)
(*  Event Handler Buttons                                                     *)
(******************************************************************************)

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.AendButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    SGrpGrid.Enabled := false;
    if SGrpGeAendert then SGrpAendern;
  finally
    DisableButtons := false;
    SGrpGrid.Enabled := true;
    SGrpGrid.Refresh;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.NeuButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    SGrpGrid.Enabled := false;
    SGrpNeu;
  finally
    DisableButtons := false;
    SGrpGrid.Enabled := true;
    SGrpGrid.Refresh;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.LoeschButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if not DisableButtons then
  try
    DisableButtons := true;
    SGrpGrid.Enabled := false;
    SGrpLoeschen;
  finally
    DisableButtons := false;
    SGrpGrid.Enabled := true;
    SGrpGrid.Refresh;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.OkButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin             
  // verhindern, dass w�hrend Ausgabe ein 2. Mal Ok gedruckt wird
  if not DisableButtons then
  try
    DisableButtons := true;
    SGrpGrid.Enabled := false;
    if not EingabeOk(nil) then Exit;
    if SGrpGeAendert and not SGrpAendern then Exit;
    ModalResult := mrOk;
  finally
    DisableButtons := false;
    SGrpGrid.Enabled := true;
  end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.CancelButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  ModalResult := mrCancel; (* Pr�fung in FormCloseQuery *)
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TSGrpDialog.HilfeButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  Application.HelpContext(1100);  // Startgruppen
end;


end.