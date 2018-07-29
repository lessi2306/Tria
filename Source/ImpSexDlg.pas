unit ImpSexDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  AllgConst, AllgComp, ImpDlg;

function GetSexType(SexStr:String): TSex;

type
  TImpSexDialog = class(TForm)
    FeldLabel: TLabel;
    FeldEdit: TTriaEdit;
    InhaltLabel: TLabel;
    InhaltEdit: TTriaEdit;
    WeiterButton: TButton;
    CancelButton: TButton;
    SexRG: TRadioGroup;
  private

  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  ImpSexDialog: TImpSexDialog;

implementation

uses VistaFix, TriaMain;

{$R *.dfm}

//******************************************************************************
function GetSexType(SexStr:String): TSex;
//******************************************************************************
// SexStr kein Defaultstring, mindestens ein Geschlechtoption noch nicht definiert
const MStr = 'Männlich';
      WStr = 'Weiblich';
      XStr = 'Mixed';  // nur bei TlnStaffel und TlnTeam
      KStr = 'Kein';
var  Delta : Integer;

begin
  Result := cnSexBeide;
  ImpSexDialog:= TImpSexDialog.Create(HauptFenster);
  try
    with ImpSexDialog do
    begin
      FeldEdit.Text   := ImportDialog.GetFeldNameLang(spSex);
      InhaltEdit.Text := SexStr;

      SexRG.Items.Clear;
      if not ImportDialog.GetSexStrValid(cnMaennlich) then
        SexRG.Items.Add(MStr);
      if not ImportDialog.GetSexStrValid(cnWeiblich) then
        SexRG.Items.Add(WStr);
      if ((HauptFenster.SortWettk.WettkArt=waTlnStaffel)or(HauptFenster.SortWettk.WettkArt=waTlnStaffel)) and
          not ImportDialog.GetSexStrValid(cnMixed) then
        SexRG.Items.Add(XStr);
      if not ImportDialog.GetSexStrValid(cnkeinSex) then
        SexRG.Items.Add(KStr);
      if SexRG.Items.Count > 0 then // muss so sein
        SexRG.ItemIndex := 0;
      if SexRG.Items.Count > 1 then
        SexRG.Enabled := true
      else
        SexRG.Enabled := false;
      // Größe an ItemZahl anpassen
      Delta := (4 - SexRG.Items.Count) * 15;
      SexRG.Height := SexRG.Height - Delta;
      CancelButton.Top := CancelButton.Top - Delta;
      WeiterButton.Top := WeiterButton.Top - Delta;
      Height := Height - Delta;

      if ShowModal = mrOk then
        if SexRG.ItemIndex >= 0 then
          if SexRG.Items.IndexOf(MStr) = SexRG.ItemIndex then Result := cnMaennlich
          else
          if SexRG.Items.IndexOf(WStr) = SexRG.ItemIndex then Result := cnWeiblich
          else
          if (HauptFenster.SortWettk.WettkArt=waTlnStaffel) and
             (SexRG.Items.IndexOf(XStr) = SexRG.ItemIndex) then Result := cnMixed
          else
          if SexRG.Items.IndexOf(KStr) = SexRG.ItemIndex then Result := cnKeinSex;
    end;
  finally
    FreeAndNil(ImpSexDialog);
  end;
end;

// public Methoden TTxtImpDialog

(*============================================================================*)
constructor TImpSexDialog.Create(AOwner: TComponent);
(*============================================================================*)
begin
  inherited Create(AOwner);
  SetzeFonts(Font);
end;


end.
