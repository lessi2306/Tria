unit MruObj;

interface

uses Windows,Classes,ActnMenus,ActnMan,ActnList,SysUtils,Dialogs,
     IniFiles,Registry,
     AllgConst,AllgFunc;

type


  TMruListe = class(TObject)
  private
    FOwner      : TComponent;
    FMenuBar    : TActionMainMenuBar;
    FStartPos   : Integer;
    function    PfadToCaption(const Pfad:String; Idx:Integer): String;
    function    PfadVorhanden: Boolean;
    function    GetItem(const Indx:Integer):String;//liefert Pfad der Datei
  public
    PfadListe  : Array[1..cnMruMaxCount] of String;
    constructor Create(OwnerNeu:TComponent;MenuNeu:TActionMainMenuBar);
    procedure   Init;
    function    PfadIndex(const Pfad:String): Integer;
    procedure   EntferneDatei(const DatIdx:Integer);
    procedure   AddiereDatei(const Pfad:String);
    property    Items[const Indx: Integer]: String read GetItem; default;
  end;

implementation

//------------------------------------------------------------------------------
function TMruListe.PfadToCaption(const Pfad:String; Idx:Integer): String;
//------------------------------------------------------------------------------
begin
  Result := '';
  if (Idx >= 1) and (Idx <= cnMruMaxCount) then
  begin
    if Length(Pfad) > 50 then
      Result := Copy(Pfad,1,3)+' ... '+Copy(Pfad,Length(Pfad)-40+1,40)
    else Result := Pfad;
    Result := ErsetzeEinfachUnd(Result);
    if Result <> '' then
      Result := '&'+IntToStr(Idx)+'  ' + Result + '            '; 
  end;
end;

//------------------------------------------------------------------------------
function TMruListe.PfadVorhanden: Boolean;
//------------------------------------------------------------------------------
begin
  Result := PfadListe[1] <> '';
end;

//------------------------------------------------------------------------------
function TMruListe.GetItem(const Indx:Integer):String;
//------------------------------------------------------------------------------
// zuerst MruListe aktualisieren und dann Pfad liefern (wenn Datei vorhanden)
begin
  Result := '';
  if (Indx >= 1) and (Indx <= cnMruMaxCount) then
  begin
    Result := PfadListe[Indx];
    if Result <> '' then
      if not SysUtils.FileExists(Result) then
      begin
        TriaMessage('Die Datei  "'+Result+'"'+#13+
                   'wurde nicht gefunden.',
                   mtInformation,[mbOk]);
        EntferneDatei(Indx);
        Result := '';
      end else
        if Indx <> 1 then
        begin
          EntferneDatei(Indx);
          AddiereDatei(Result);
        end;
  end;
end;

//==============================================================================
constructor TMruListe.Create(OwnerNeu:TComponent;MenuNeu:TActionMainMenuBar);
//==============================================================================
var
  i : Integer;
begin
  inherited Create;
  for i:=1 to cnMruMaxCount do PfadListe[i] := '';

  FStartPos := 0;
  FOwner := OwnerNeu;
  FMenuBar := MenuNeu;
  // Invisible MenuItems als Dummy für Liste
  // FStartPos auf TrennStrich vor 4 (=cnMaxCount) MruDatei-Einträge
  for i:=0 to FMenuBar.ActionControls[0].ActionClient.Items.Count-1 do
    if not FMenuBar.ActionControls[0].ActionClient.Items[i].Visible then
    begin
      FStartPos := i;
      Break;
    end;
end;

//==============================================================================
procedure TMruListe.Init;
//==============================================================================
var
  i : Integer;
begin
  for i:=1 to cnMruMaxCount do
  begin
    if PfadListe[i]<>'' then
      with FMenuBar.ActionControls[0].ActionClient.Items[FStartPos+i] do
      begin
        Caption := PfadToCaption(PfadListe[i],i);
        Visible := true;
      end;
  end;
  if PfadVorhanden then // Trennstrich
    FMenuBar.ActionControls[0].ActionClient.Items[FStartPos].Visible := true
  else
    FMenuBar.ActionControls[0].ActionClient.Items[FStartPos].Visible := false;
end;

//==============================================================================
function TMruListe.PfadIndex(const Pfad:String): Integer;
//==============================================================================
var i : Integer;
begin
  for i:=1 to cnMruMaxCount do
    if TxtGleich(Pfad,PfadListe[i]) then
    begin
      Result := i;
      Exit;
    end;
  Result := -1;
end;

//==============================================================================
procedure TMruListe.EntferneDatei(const DatIdx:Integer);
//==============================================================================
var
  i : Integer;
begin
  if (DatIdx >= 1) and (DatIdx <= cnMruMaxCount) then
    for i:=DatIdx to cnMruMaxCount do
    begin
      if i < cnMruMaxCount then PfadListe[i] := PfadListe[i+1]
                           else PfadListe[i] := ''; // letzte Pos. immer leer
      with FMenuBar.ActionControls[0].ActionClient.Items[FStartPos+i] do
        if PfadListe[i] <> '' then
        begin
          Caption := PfadToCaption(PfadListe[i],i);
          Visible := true;
        end else
        begin
          Caption := '';
          Visible := false;
        end;
    end;
    if PfadVorhanden then // Trennstrich setzen
      FMenuBar.ActionControls[0].ActionClient.Items[FStartPos].Visible := true
    else FMenuBar.ActionControls[0].ActionClient.Items[FStartPos].Visible := false;
end;

//==============================================================================
procedure TMruListe.AddiereDatei(const Pfad:String);
//==============================================================================
var
  i : Integer;
begin
  if Trim(Pfad) = '' then Exit;
  // prüfe ob bereits vorhanden
  i := PfadIndex(Pfad);
  if i=1 then Exit  // vorhanden an Pos. 1, keine weitere Aktion
  else if i>1 then EntferneDatei(i); // vorhanden an Pos. i

  for i:=cnMruMaxCount downto 1 do
  begin
    if i=1 then PfadListe[i] := Trim(Pfad)
           else PfadListe[i] := PfadListe[i-1];
    with FMenuBar.ActionControls[0].ActionClient.Items[FStartPos+i] do
    begin
      if PfadListe[i] <> '' then
      begin
        Caption := PfadToCaption(PfadListe[i],i);
        Visible := true;
      end else
      begin
        Caption := '';
        Visible := false;
      end;
    end;
  end;
  if PfadVorhanden then // Trennstrich setzen
    FMenuBar.ActionControls[0].ActionClient.Items[FStartPos].Visible := true
  else FMenuBar.ActionControls[0].ActionClient.Items[FStartPos].Visible := false;
end;


end.
