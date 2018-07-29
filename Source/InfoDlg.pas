unit InfoDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,Math,
  Dialogs, StdCtrls, ExtCtrls, ShellApi, jpeg;

procedure ZeigeInfo;

  type
  TInfoDialog = class(TForm)
    OkButton: TButton;
    InfoPanel: TPanel;
    TriaImage: TImage;
    TriaLabel: TLabel;
    VersionLabel: TLabel;
    CopyRightLabel: TLabel;
    NameLabel: TLabel;
    DownLoadText: TLabel;
    procedure DownLoadTextClick(Sender: TObject);
    procedure LinkMouseEnter(Sender: TObject);
    procedure LinkMouseLeave(Sender: TObject);
    procedure LinkMouseDown(Sender: TObject; Button: TMouseButton;
                            Shift: TShiftState; X, Y: Integer);
    procedure LinkMouseUp(Sender: TObject; Button: TMouseButton;
                          Shift: TShiftState; X, Y: Integer);
    //procedure EMailTextClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  InfoDialog: TInfoDialog;

implementation

uses History, AllgConst,VistaFix, TriaMain, AllgObj;

{$R *.dfm}
             

(******************************************************************************)
procedure ZeigeInfo;
(******************************************************************************)
begin
  InfoDialog := TInfoDialog.Create(HauptFenster);
  try
    InfoDialog.ShowModal;
  finally
    FreeAndNil(InfoDialog);
  end;
end;

(*============================================================================*)
constructor TInfoDialog.Create(AOwner: TComponent);
(*============================================================================*)
begin
  inherited Create(AOwner);
  TriaLabel.Caption      := Application.Title;
  VersionLabel.Caption   := 'Version  ' + ProgVersion.JrNr;
  CopyRightLabel.Caption := 'Copyright © 1990 - ' + cnReleaseJahr;
  SetzeFonts(Font);
  SetzeFonts(TriaLabel.Font);
  SetzeFonts(DownLoadText.Font);
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TInfoDialog.DownLoadTextClick(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  ShellExecute(Application.Handle,'open',PChar(cnHomePage),
               nil,nil, sw_ShowNormal);
  // keine Fehlermeldung (wenn Result <= 32)
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TInfoDialog.LinkMouseEnter(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  Screen.Cursor := crHandPoint;    { Cursor als HandZeiger }
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TInfoDialog.LinkMouseLeave(Sender: TObject);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  Screen.Cursor := CursorAlt;  { Alten Zustand wiederherstellen }
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TInfoDialog.LinkMouseDown(Sender: TObject; Button: TMouseButton;
                                    Shift: TShiftState; X, Y: Integer);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  with Sender as TLabel do Font.Color := clRed;
end;

(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
procedure TInfoDialog.LinkMouseUp(Sender: TObject; Button: TMouseButton;
                                  Shift: TShiftState; X, Y: Integer);
(*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
begin
  with Sender as TLabel do Font.Color := clBlue;
end;


end.


