﻿unit PrevFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ComCtrls, ToolWin, StdCtrls, Mask, AllgComp, ActnMan, ActnCtrls,
  ExtCtrls;

type

  TPrevFrame = class(TFrame)
    PrevScrollBox: TScrollBox;
    PrevPanel: TPanel;
    PrevUpDown: TTriaUpDown;
    PrevSeiteEdit: TTriaMaskEdit;
    PrevSeiteLabel: TLabel;
    PrevVonText: TLabel;
    procedure PrevSeiteEditChange(Sender: TObject);
    procedure PrevSeiteLabelClick(Sender: TObject);
  private
    Updating : Boolean;
  public
    SeiteAktuell : Integer;
    constructor Create(AOwner: TComponent); override;
    procedure   Oeffnen(SeiteVon,SeiteBis:Integer);
    procedure   Schliessen;
  end;

implementation

uses Math, rpdefine,
     AllgConst,AllgFunc,TriaMain,CmdProc,RaveUnit,AusgDlg,VeranObj;

{$R *.dfm}

// public Methoden

(*============================================================================*)
constructor TPrevFrame.Create(AOwner: TComponent);
(*============================================================================*)
begin
  inherited Create(AOwner);
  Align := alClient;
  Updating := false;
end;

(*============================================================================*)
procedure TPrevFrame.Oeffnen(SeiteVon,SeiteBis:Integer);
(*============================================================================*)
// Aktivierung nach PreviewCommand
begin
  Updating := true;
  with HauptFenster.PrevFrame do
  begin
    PrevUpDown.Min := SeiteVon;
    PrevUpDown.Max := Min(SeiteBis,cnSeiteMax);
    if PrevUpDown.Max < 10 then PrevSeiteEdit.EditMask := '0;0; '
    else if PrevUpDown.Max < 100 then PrevSeiteEdit.EditMask := '09;0; '
    else PrevSeiteEdit.EditMask := '099;0; '; // cnSeiteMax = 999
    SeiteAktuell := SeiteVon; 
    PrevSeiteEdit.Text := IntToStr(SeiteVon);
    PrevVonText.Caption := 'von '+IntToStr(SeiteBis);
    HauptFenster.PrevStart.Enabled := false;
    HauptFenster.PrevBack.Enabled := false;
    if PrevUpDown.Min = PrevUpDown.Max then
    begin
      HauptFenster.PrevNext.Enabled := false;
      HauptFenster.PrevLast.Enabled := false;
    end else
    begin
      HauptFenster.PrevNext.Enabled := true;
      HauptFenster.PrevLast.Enabled := true;
    end;
    
    PrevScrollBox.Refresh;
    HauptFenster.LstFrame.Visible := false;
    HauptFenster.ActionToolBar.Visible := false;
    Visible := true;
    HauptFenster.PrevToolBar.Left := PrevVonText.Left + PrevVonText.Width;
    HauptFenster.PrevToolBar.Visible := true;
    PrevSeiteEdit.SetFocus;
  end;

  with RaveForm.RvRenderPreview do //nach Definition PrevScrollBox, wegen Zoomfactor
  begin
    ScrollBox     := HauptFenster.PrevFrame.PrevScrollBox;
    NDRStream     := TriaNDRStream;
    MarginPercent := 2.5;
    ShadowDepth   :=  5;
    FirstPage     := SeiteVon;
    LastPage      := SeiteBis;
    Render;
    ZoomFactor := ZoomPageWidthFactor - (ShadowDepth +3) / 10;
  end;
  Updating := false;
end;

(*============================================================================*)
procedure TPrevFrame.Schliessen;
(*============================================================================*)
begin
  HauptFenster.PrevToolBar.Visible := false;
  HauptFenster.PrevFrame.Visible := false;
  HauptFenster.ActionToolBar.Visible := true;
  HauptFenster.LstFrame.Visible := true;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TPrevFrame.PrevSeiteLabelClick(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if PrevSeiteEdit.CanFocus then PrevSeiteEdit.SetFocus;
end;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
procedure TPrevFrame.PrevSeiteEditChange(Sender: TObject);
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
begin
  if Updating then Exit;
  SeiteAktuell := StrToIntDef(PrevSeiteEdit.Text,0);
  if SeiteAktuell > PrevUpDown.Min then
  begin
    HauptFenster.PrevStart.Enabled := true;
    HauptFenster.PrevBack.Enabled := true;
  end else
  begin
    HauptFenster.PrevStart.Enabled := false;
    HauptFenster.PrevBack.Enabled := false;
  end;
  if SeiteAktuell < PrevUpDown.Max then
  begin
    HauptFenster.PrevLast.Enabled := true;
    HauptFenster.PrevNext.Enabled := true;
  end else
  begin
    HauptFenster.PrevLast.Enabled := false;
    HauptFenster.PrevNext.Enabled := false;
  end;

  RaveForm.RvRenderPreview.RenderPage(SeiteAktuell-PrevUpDown.Min+1);
  PrevScrollBox.Refresh;
end;


end.
