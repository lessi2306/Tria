unit ImpFeldDlg;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,  ExtCtrls,
  AllgConst, AllgComp, ImpDlg;

function GetOptionFeldType(FeldStr: String; Feld:TColType): TImpOption;

type
  TImpFeldDialog = class(TForm)
    FeldLabel: TLabel;
    InhaltLabel: TLabel;
    InhaltEdit: TTriaEdit;
    FeldEdit: TTriaEdit;
    WeiterButton: TButton;
    CancelButton: TButton;
    OptGB: TGroupBox;
    OptCB: TCheckBox;
  private

  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  ImpFeldDialog: TImpFeldDialog;

implementation

uses VistaFix, TriaMain;

{$R *.dfm}

(******************************************************************************)
function GetOptionFeldType(FeldStr: String; Feld:TColType): TImpOption;
(******************************************************************************)
begin
  Result := ioFehler;
  ImpFeldDialog:= TImpFeldDialog.Create(HauptFenster);
  try
    with ImpFeldDialog do
    begin
      FeldEdit.Text   := ImportDialog.GetFeldNameLang(Feld);
      InhaltEdit.Text := FeldStr;
      OptCB.Caption   := FeldEdit.Text;

      if ImportDialog.GetFeldStrValid(Feld,ioTrue) then
      begin
        OptCB.Checked := false;
        OptCB.Enabled := false;
      end else
      if ImportDialog.GetFeldStrValid(Feld,ioFalse) then
      begin
        OptCB.Checked := true;
        OptCB.Enabled := false;
      end else
      begin
        OptCB.Checked := true;
        OptCB.Enabled := true;
      end;

      if ShowModal = mrOk then
        if OptCB.Checked then Result := ioTrue
                         else Result := ioFalse;
    end;
  finally
    FreeAndNil(ImpFeldDialog);
  end;
end;

// public Methoden TTxtImpDialog

(*============================================================================*)
constructor TImpFeldDialog.Create(AOwner: TComponent);
(*============================================================================*)
begin
  inherited Create(AOwner);
  SetzeFonts(Font);
end;

end.

