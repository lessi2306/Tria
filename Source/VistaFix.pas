unit VistaFix;
{
Creating Windows Vista Ready Applications with Delphi 2006
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

function  IsWindowsVista: Boolean;
procedure SetzeFonts(const AFont: TFont);
function  SetzeVistaFilter(AFileTypes:TFileTypeItems; AFilter: String): Boolean;

const
  VistaFont = 'Segoe UI';      // Vista default
  TestFont  = 'Segoe Script';  // nur f�r Test
  XPFont    = 'Tahoma';        // XP default
  AltFont   = 'MS Sans Serif'; // default f�r �ltere Systeme

implementation


{###############################################################################
Fix f�r Vista-Fonts
################################################################################

Default Fonts
- Vista:  Name = Segoe IU, Size = 9
- XP:     Name = Tahoma, Size = 8
- �lter:  Name = MS Sans Serif, Size = 8

Alle Defaults f�r Vista gesetzt. Wenn <> Vista Fonts auf Tahoma und Size-1 setzen
}

procedure SetzeFonts(const AFont: TFont);
begin
  if not IsWindowsVista or (Screen.Fonts.IndexOf(AFont.Name) < 0) then
    if not SameText(AFont.Name, XPFont) and
       (Screen.Fonts.IndexOf(XPFont) >= 0) then
    begin
      AFont.Size := AFont.Size - 1;
      AFont.Name := XPFont;
    end else
    if not SameText(AFont.Name, AltFont) and
       (Screen.Fonts.IndexOf(AltFont) >= 0) then
    begin
      AFont.Size := AFont.Size - 1;
      AFont.Name := AltFont;
    end else
  {else AFont.Name := TestFont}; // nur f�r Test
end;

function IsWindowsVista: Boolean;
var
  VerInfo: TOSVersioninfo;
begin
  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  Result :=  GetVersionEx(VerInfo) and (VerInfo.dwMajorVersion >= 6);
end;

//------------------------------------------------------------------------------
function SetzeVistaFilter(AFileTypes:TFileTypeItems; AFilter: String): Boolean;
//------------------------------------------------------------------------------
// Filter: 'Tria Dateien (*.tri)|*.tri|Alle Dateien (*.*)|*.*',//Filter: String
var L, I, N : Integer;
    Name, Mask : String;
//..............................................................................
function SetzeStrings: Boolean;
// Setze Name und Mask, angefangen bei AFilter[I]
// Result true, wenn beide vorhanden
var Pos : Integer;
begin
  Result := false;
  Name := '';
  Mask := '';
  Pos := FindDelimiter('|', AFilter,I);
  if Pos > 0 then // DisplayName vorhanden
  begin
    Name := Copy(AFilter,I,Pos-I);
    I := Pos+1;
    if (Trim(Name)<>'') and (I < L) then
    begin
      Pos := FindDelimiter('|', AFilter,I);
      if Pos > 0 then // auch FileMask vorhanden
      begin
        Mask := Copy(AFilter,I,Pos-I);
        I := Pos+1;
        if Trim(Mask)<>'' then Result := true;
      end else
      begin
        Mask := Copy(AFilter,I,L-I+1); // letzter Eintrag
        I := L+1; // kein weiterer Aufruf
        if Trim(Mask)<>'' then Result := true;
      end;
    end;
  end;
end;

//..............................................................................
begin
  Result := false;
  if not Assigned(AFileTypes) then Exit;
  I := 1;
  L := Length(AFilter);
  N := 0;
  AFileTypes.Clear;
  while I < L do
    if SetzeStrings then // I auf n�chste Pos gesetzt
    begin
      with AFileTypes do
        with Add do begin DisplayName := Name; FileMask := Mask; end;
      Inc(N);
    end;
  if N > 0 then Result := true;
end;

end.
