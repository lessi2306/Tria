unit ImpFmtDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AllgComp, ExtCtrls;

type
  TImpFmtDialog = class(TForm)
    DateiRG: TRadioGroup;
    DateiLabel: TLabel;
    DateiEdit: TTriaEdit;
    OkButton: TButton;
    CancelButton: TButton;
    //procedure HilfeButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ImpFmtDialog: TImpFmtDialog;

implementation

uses VistaFix;

{$R *.dfm}

procedure TImpFmtDialog.FormCreate(Sender: TObject);
begin
  SetzeFonts(Font);
end;

{procedure TImpFmtDialog.HilfeButtonClick(Sender: TObject);
begin
  Application.HelpContext(100);  // Wähle Format DateiImport
end;}

end.

