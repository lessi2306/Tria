unit ZtLoeschDlg;

interface          

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math,
  AllgComp,AllgConst,AllgFunc,AllgObj,WettkObj,TlnObj;

procedure ZtErfLoeschen;

type
  TZtLoeschDialog = class(TForm)
    WettkLabel: TLabel;
    WettkCB: TComboBox;
    EinzelStartGB: TGroupBox;
      EinzelStartCB: TCheckBox;
    AbschnittGB: TGroupBox;
      Abschn1CB: TCheckBox;
      Abschn2CB: TCheckBox;
      Abschn3CB: TCheckBox;
      Abschn4CB: TCheckBox;
      Abschn5CB: TCheckBox;
      Abschn6CB: TCheckBox;
      Abschn7CB: TCheckBox;
      Abschn8CB: TCheckBox;
      Abschn1Edit: TTriaEdit;
      Abschn2Edit: TTriaEdit;
      Abschn3Edit: TTriaEdit;
      Abschn4Edit: TTriaEdit;
      Abschn5Edit: TTriaEdit;
      Abschn6Edit: TTriaEdit;
      Abschn7Edit: TTriaEdit;
      Abschn8Edit: TTriaEdit;
    OkButton: TButton;
    CancelButton: TButton;
    HilfeButton: TButton;
    procedure WettkLabelClick(Sender: TObject);
    procedure WettkCBChange(Sender: TObject);
    procedure AbschnEditClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure HilfeButtonClick(Sender: TObject);
  protected
    HelpFensterAlt: TWinControl;
    AbschnCB   : array[wkAbs1..wkAbs8] of TCheckBox;
    AbschnEdit : array[wkAbs1..wkAbs8] of TTriaEdit;
    function  GetWettk: TWettkObj;
    procedure SetAbschnitt;
    function  SetAbschnArr: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  end;

var
  ZtLoeschDialog: TZtLoeschDialog;

implementation

uses VeranObj, TriaMain,ZtEinlDlg,DateiDlg,VistaFix,SGrpObj;

{$R *.dfm}


//******************************************************************************
procedure ZtErfLoeschen;
//******************************************************************************
var i : Integer;
    AbsCnt : TWkAbschnitt;
begin
  ZtLoeschDialog:= TZtLoeschDialog.Create(HauptFenster);
  try
    if ZtLoeschDialog.ShowModal = mrOk then
    begin
      HauptFenster.RefreshAnsicht;
      if TriaMessage('Alle eingelese Zeiten für  '+ZtErfAbschnString+'  löschen?',
                      mtConfirmation,[mbOk,mbCancel]) = mrOk then
      begin
        HauptFenster.LstFrame.TriaGrid.StopPaint := true;
        for i:=0 to Veranstaltung.TlnColl.Count-1 do
          with Veranstaltung.TlnColl[i] do
            if (ZtErfWettkampf = WettkAlleDummy) or (ZtErfWettkampf = Wettk) then
              for AbsCnt:=wkAbs0 to wkAbs8 do
                if ZtErfAbschnArr[AbsCnt] then
                  ErfZeitenLoeschen(AbsCnt);
        ZtErfWettkampf.ErgModified := true; // immer, unabhängig vom Status
        TriDatei.Modified := true;
      end;
    end;
  finally
    HauptFenster.LstFrame.TriaGrid.StopPaint := false;
    FreeAndNil(ZtLoeschDialog);
  end;
  //refresh
end;

(******************************************************************************)
(*           Methoden von TZtLoeschDialog                                     *)
(******************************************************************************)

// public Methoden

//==============================================================================
constructor TZtLoeschDialog.Create(AOwner: TComponent);
//==============================================================================
var i: Integer;
begin
  inherited Create(AOwner);
  if not HelpDateiVerfuegbar then
  begin
    BorderIcons := [biSystemMenu];
    HilfeButton.Enabled := false;
  end;

  // Init Arrays
  AbschnCB[wkAbs1] := Abschn1CB;
  AbschnCB[wkAbs2] := Abschn2CB;
  AbschnCB[wkAbs3] := Abschn3CB;
  AbschnCB[wkAbs4] := Abschn4CB;
  AbschnCB[wkAbs5] := Abschn5CB;
  AbschnCB[wkAbs6] := Abschn6CB;
  AbschnCB[wkAbs7] := Abschn7CB;
  AbschnCB[wkAbs8] := Abschn8CB;
  AbschnEdit[wkAbs1] := Abschn1Edit;
  AbschnEdit[wkAbs2] := Abschn2Edit;
  AbschnEdit[wkAbs3] := Abschn3Edit;
  AbschnEdit[wkAbs4] := Abschn4Edit;
  AbschnEdit[wkAbs5] := Abschn5Edit;
  AbschnEdit[wkAbs6] := Abschn6Edit;
  AbschnEdit[wkAbs7] := Abschn7Edit;
  AbschnEdit[wkAbs8] := Abschn8Edit;

  with Veranstaltung.WettkColl do
  begin
    if (Count > 1) and (AlleAbschnGleich) then
      WettkCB.Items.AddObject('Alle Wettkämpfe',WettkAlleDummy);
    for i:=0 to Count-1 do
      WettkCB.Items.AddObject(Items[i].Name,Items[i]);
  end;
  WettkCB.ItemIndex := 0;
  if (GetWettk=WettkAlleDummy) and (HauptFenster.SortWettk<>WettkAlleDummy) then
    WettkCB.ItemIndex := WettkCB.Items.IndexOfObject(HauptFenster.SortWettk);
  if WettkCB.ItemIndex < 0 then WettkCB.ItemIndex := 0;

  WettkCB.Taborder := 0;
  SetAbschnitt;
  CancelButton.Cancel := true;
  HelpFensterAlt := HelpFenster;
  HelpFenster := Self;
  SetzeFonts(Font);
end;

//==============================================================================
destructor TZtLoeschDialog.Destroy;
//==============================================================================
begin
  HelpFenster := HelpFensterAlt;
  inherited Destroy;
end;

// protected Methoden

//------------------------------------------------------------------------------
function TZtLoeschDialog.GetWettk: TWettkObj;
//------------------------------------------------------------------------------
begin
  if WettkCB.ItemIndex >= 0 then
    Result := TWettkObj(WettkCB.Items.Objects[WettkCB.ItemIndex])
  else Result := WettkAlleDummy;
end;

//------------------------------------------------------------------------------
procedure TZtLoeschDialog.SetAbschnitt;
//------------------------------------------------------------------------------
var AbsCnt : TWkAbschnitt;
begin
  if Veranstaltung.SGrpColl.WettkStartModus(GetWettk,wkAbs1) = stOhnePause then
    EinzelStartCB.Enabled := true
  else
  begin
    EinzelStartCB.Checked := false;
    EinzelStartCB.Enabled := false;
  end;
  for AbsCnt:=wkAbs1 to wkAbs8 do
  begin
    AbschnEdit[AbsCnt].Text := GetWettk.AbschnName[AbsCnt];
    if GetWettk.AbschnZahl >= Integer(AbsCnt) then
    begin
      AbschnEdit[AbsCnt].Enabled := true;
      AbschnCB[AbsCnt].Enabled   := true;
    end else
    begin
      AbschnEdit[AbsCnt].Enabled := false;
      AbschnCB[AbsCnt].Enabled   := false;
      AbschnCB[AbsCnt].Checked   := false; // löschen wenn disabled
    end;
  end;

  if GetWettk.AbschnZahl=1 then
  begin
    AbschnEdit[wkAbs1].Text    := '';
    AbschnEdit[wkAbs1].Enabled := false; // nur Edit disabled
    if not EinzelStartCB.Enabled then
      AbschnCB[wkAbs1].Checked := true;  // bei 1 Abs. immer checked
  end;
end;

//------------------------------------------------------------------------------
function TZtLoeschDialog.SetAbschnArr: Boolean;
//------------------------------------------------------------------------------
var AbsCnt : TWkAbschnitt;
begin
  Result := false;
  if EinzelStartCB.Checked then
  begin
    ZtErfAbschnArr[wkAbs0] := true;
    Result := true;
  end
  else ZtErfAbschnArr[wkAbs0] := false;

  for AbsCnt:=wkAbs1 to wkAbs8 do
    if AbschnCB[AbsCnt].Checked then
    begin
      ZtErfAbschnArr[AbsCnt] := true;
      Result := true;
    end
    else ZtErfAbschnArr[AbsCnt] := false;
end;

// Event Handler

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtLoeschDialog.WettkLabelClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if WettkCB.CanFocus then WettkCB.SetFocus;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtLoeschDialog.WettkCBChange(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  SetAbschnitt;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtLoeschDialog.AbschnEditClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
var AbsCnt : TWkAbschnitt;
begin
  for AbsCnt:=wkAbs1 to wkAbs8 do
    if Sender = AbschnEdit[AbsCnt] then
    begin
      AbschnCB[AbsCnt].Checked := not AbschnCB[AbsCnt].Checked;
      Break;
    end;
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtLoeschDialog.OkButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  if SetAbschnArr then
  begin
    ZtErfWettkampf := GetWettk;
    ModalResult := mrOk
  end else
    TriaMessage(Self,'Es muss mindestens einen Abschnitt gewählt werden.',mtInformation,[mbOk]);
end;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
procedure TZtLoeschDialog.HilfeButtonClick(Sender: TObject);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
begin
  Application.HelpContext(2300);  // Zeiten löschen
end;

end.

