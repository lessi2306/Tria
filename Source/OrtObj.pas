unit OrtObj;

interface

uses
  Windows,Classes,SysUtils,Dialogs,Controls,Math,
  AllgConst,Allgfunc,AllgObj;

type

  TOrtObj = class(TTriaObj)
  protected
    FName     : String;
    procedure   SetName(NameNeu:String);
    function    GetBPObjType: Word; override;
  public
    constructor Create(Veranst:Pointer;Coll:TTriaObjColl;Add:TOrtAdd);override;
    function    Load: Boolean; override;
    function    Store: Boolean; override;
    procedure   OrtCollAdd; override;
    procedure   OrtCollClear(Indx:Integer); override;
    procedure   OrtCollExch(Idx1,Idx2:Integer); override;
    function    ObjSize: Integer; override;
    property    Name: string read FName write SetName;
  end;

  TOrtCollection = class(TTriaObjColl)
  protected
    function    GetBPObjType: Word; override;
    function    GetPItem(Indx:Integer): TOrtObj;
    procedure   SetPItem(Indx:Integer; Item:TOrtObj);
    function    GetSortItem(Indx:Integer): TOrtObj;
  public
    constructor Create(Veranst:Pointer);
    function    SortString(Item: Pointer): String; override;
    procedure   ClearIndex(Indx:Integer); override;
    function    AddItem(Item:Pointer): Integer; override;
    procedure   OrtCollExch(Idx1,Idx2:Integer); override;
    property    Items[Indx: Integer]: TOrtObj read GetPItem write SetPItem; default;
    property    SortItems[Indx:Integer]:TOrtObj read GetSortItem;
  end;


implementation

uses VeranObj,TriaMain,MannsObj,WettkObj,SGrpObj,SMldObj,TlnObj;

(******************************************************************************)
(* Methoden von TOrtObj                                                       *)
(******************************************************************************)

// protected Methoden

//------------------------------------------------------------------------------
function TOrtObj.GetBPObjType: Word;
//------------------------------------------------------------------------------
(* Object Types aus Version 7.4 Stream Registration Records *)
begin
  Result := rrOrtObj;
end;

//------------------------------------------------------------------------------
procedure TOrtObj.SetName(NameNeu:String);
//------------------------------------------------------------------------------
begin
  FName := NameNeu;
  //if VPtr=Veranstaltung then HauptFenster.InitOrtListe; ==> in OrtDialog
end;

// public Methoden

//==============================================================================
constructor TOrtObj.Create(Veranst:Pointer;Coll:TTriaObjColl;Add:TOrtAdd);
//==============================================================================
begin
  inherited Create(Veranst,Coll,Add);
  FName := '' {1.11.01 cnDefaultOrt};
end;

//==============================================================================
function TOrtObj.Load: Boolean;
//==============================================================================
begin
  Result := false;

  try
    if FVPtr <> EinlVeranst then Exit;
    if not inherited Load then Exit;
    TriaStream.ReadStr(FName);
  except
    Exit;
  end;

  Result := true;
end;

//==============================================================================
function TOrtObj.Store: Boolean;
//==============================================================================
begin
  Result := false;
  try
    if not inherited Store then Exit;
    TriaStream.WriteStr(FName);
  except
    Exit;
  end;
  Result := true;
end;

//==============================================================================
procedure TOrtObj.OrtCollAdd;
//==============================================================================
begin
  // nicht verwendet
end;

//==============================================================================
procedure TOrtObj.OrtCollClear(Indx:Integer);
//==============================================================================
begin
  // nicht verwendet
end;

//==============================================================================
procedure TOrtObj.OrtCollExch(Idx1,Idx2:Integer);
//==============================================================================
begin
  // nicht verwendet
end;

//==============================================================================
function TOrtObj.ObjSize: Integer;
//==============================================================================
begin
  Result := cnSizeOfString; //FName
end;

//==============================================================================
(* Methoden von TOrtCollection                                                *)
//==============================================================================

// protected Methoden

//------------------------------------------------------------------------------
function TOrtCollection.GetBPObjType: Word;
//------------------------------------------------------------------------------
(* Object Types aus Version 7.4 Stream Registration Records *)
begin
  Result := rrOrtColl;
end;

//------------------------------------------------------------------------------
function TOrtCollection.GetPItem(Indx:Integer): TOrtObj;
//------------------------------------------------------------------------------
begin
  Result := TOrtObj(inherited GetPItem(Indx));
end;

//------------------------------------------------------------------------------
procedure TOrtCollection.SetPItem(Indx:Integer; Item:TOrtObj);
//------------------------------------------------------------------------------
begin
  inherited SetPItem(Indx,Item);
end;

//------------------------------------------------------------------------------
function TOrtCollection.GetSortItem(Indx:Integer): TOrtObj;
//------------------------------------------------------------------------------
begin
  Result := TOrtObj(inherited GetSortItem(Indx));
end;

// public Methoden

//==============================================================================
constructor TOrtCollection.Create(Veranst:Pointer);
//==============================================================================
begin
  inherited Create(Veranst,TOrtObj);
  FStepProgressBar := true;
  AddItem(TOrtObj.Create(Veranst,Self,oaAdd)); //DefaultOrt für Einzelveranst.
end;

//==============================================================================
procedure TOrtCollection.ClearIndex(Indx:Integer);
//==============================================================================
begin
  if Indx<0 then Exit;
  (* Default Ort einfügen *)
  if (Fitems.Count=1) and (Indx=0) then
  begin
    inherited ClearIndex(Indx);
    inherited AddItem(TOrtObj.Create(FVPtr,Self,oaAdd));
    //Result := 0;
    //GetPItem(0).Name := '' {1.11.01 cnDefaultOrt};
  end else
  begin
    if Assigned(VPtr) then with TVeranstObj(VPtr) do
    begin
      if OrtIndex >= Indx then OrtIndex := Max(OrtIndex-1,0);
      WettkColl.OrtCollClear(Indx);
      SGrpColl.OrtCollClear(Indx);
      TlnColl.OrtCollClear(Indx);
      MannschColl.OrtCollClear(Indx);
    end;
    inherited ClearIndex(Indx);
  end;
  //if FVPtr=Veranstaltung then HauptFenster.InitOrtListe; ==>in OrtDialog
end;

//==============================================================================
function TOrtCollection.AddItem(Item:Pointer): Integer;
//==============================================================================
begin
  Result := -1;
  if Item=nil then Exit;
  (* Default Ort löschen beim ersten eingefügten OrtObj *)
  if (Count=1) and (GetPItem(0).Name = ''{1.11.01 cnDefaultOrt}) then
  begin
    inherited ClearIndex(0);
    Result := inherited AddItem(Item);
  end else
  begin
    if Assigned(VPtr) then with TVeranstObj(VPtr) do
    begin
      (* neuer Ort in alle OrtCollections anhängen, wenn Einträge vorhanden *)
      if Assigned(WettkColl)   then WettkColl.OrtCollAdd;
      if Assigned(SGrpColl)    then SGrpColl.OrtCollAdd;
      if Assigned(TlnColl)     then TlnColl.OrtCollAdd;
      if Assigned(MannschColl) then MannschColl.OrtCollAdd;
    end;
    Result := inherited AddItem(Item);
  end;
  // if FVPtr=Veranstaltung then HauptFenster.UpdateListe;  ==> in OrtDialog
end;

//==============================================================================
procedure TOrtCollection.OrtCollExch(Idx1,Idx2:Integer);
//==============================================================================
begin
  if (Idx1<0) or (Idx1>Count-1) then Exit;
  if (Idx2<0) or (Idx2>Count-1) then Exit;
  List.Exchange(Idx1,Idx2);
  if Assigned(VPtr) then with TVeranstObj(VPtr) do
  begin
    if Assigned(WettkColl)   then WettkColl.OrtCollExch(Idx1,Idx2);
    if Assigned(SGrpColl)    then SGrpColl.OrtCollExch(Idx1,Idx2);
    if Assigned(TlnColl)     then TlnColl.OrtCollExch(Idx1,Idx2);
    if Assigned(MannschColl) then MannschColl.OrtCollExch(Idx1,Idx2);
  end;
end;

//==============================================================================
function TOrtCollection.SortString(Item:Pointer): String;
//==============================================================================
begin
  Result := TOrtObj(Item).Name;
end;


end.
