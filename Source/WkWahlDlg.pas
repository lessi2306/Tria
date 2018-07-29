unit WkWahlDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  WettkObj;

type
  TWkWahlDialog = class(TForm)
    WettkCB: TComboBox;
    Label2: TLabel;
    OkButton: TButton;
    CancelButton: TButton;
    Label1: TLabel;
  private
    { Private-Deklarationen }
  public
    constructor Create(AOwner: TComponent); override;
    function WettkSelected: TWettkObj;
  end;

var
  WkWahlDialog: TWkWahlDialog;

implementation

uses TriaMain,VeranObj,AllgConst,VistaFix;

{$R *.dfm}

// public Methoden

(*============================================================================*)
constructor TWkWahlDialog.Create(AOwner: TComponent);
(*============================================================================*)
var i : Integer;
begin
  inherited Create(AOwner);
  with Veranstaltung.WettkColl do
    for i:=0 to Count-1 do WettkCB.Items.Append(Items[i].Name);
  WettkCB.ItemIndex := 0;
  SetzeFonts(Font);
end;

(*============================================================================*)
function TWkWahlDialog.WettkSelected: TWettkObj;
(*============================================================================*)
begin
  if (WettkCB.ItemIndex >= 0) and
     (WkWahlDialog.WettkCB.ItemIndex < Veranstaltung.WettkColl.Count) then
    Result := Veranstaltung.WettkColl[WettkCB.ItemIndex]
  else Result := nil;
end;


end.

