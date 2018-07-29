unit FastRep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass;

type
  TFastReport = class(TForm)
    frxReport1: TfrxReport;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FastReport: TFastReport;

implementation

{$R *.dfm}

end.
