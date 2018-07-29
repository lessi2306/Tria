{*******************************************************}
{                                                       }
{       HTML Help helper functions                      }
{                                                       }
{       Copyright (c) 1999-2009 The Helpware Group      }
{                                                       }
{*******************************************************}

//{$IFDEF CONDITIONALEXPRESSIONS}    //valid for Delphi 6+
//  {$warn SYMBOL_PLATFORM off}
//  {$warn UNIT_PLATFORM off}
//{$ENDIF}
               

{ Korrektur XE2:
CompilerBefehl $warn SYMBOL_PLATFORM off scheint Absturz IDE zu verursachen
Warnings stattdessen in Project/Optionen ausschalten
Alle Compilerbefehle sicherheitshalber auskommentiert
--------------------------------------------------------------------------------
I just tried one of my D2010 projects in XE2, using hh_funcs.pas V2.1.
The call in hh_funcs.pas Application.OnHelp := HelpHook gets flagged with the error
"E2010 Incompatible types: 'NativeInt' and 'Integer'"
--------------------------------------------------------------------------------
To fix you need to change the function HelpHook parameters like this
(look NativeInt type below):
HelpHook(Command: Word; Data: To fix you need to change the function HelpHook parameters like this (look NativeInt type below):

HelpHook(Command: Word; Data: NativeInt; var CallHelp: Boolean): Boolean;; var CallHelp: Boolean): Boolean;
--------------------------------------------------------------------------------
There are a few more changes for XE3
162          function HelpHook(Command : Word; Data : Nativeint; Var CallHelp : Boolean) : Boolean;
700          function THookHelpSystem.HelpHook(Command: Word; Data: Nativeint; Var CallHelp: Boolean) : Boolean;
2858        DebugOut('!DecimalSeparator:      %s',[#9 + FormatSettings.DecimalSeparator]);
1511        var p: PWideChar;    //PAnsiChar;
}

{
========================================================
  hh_funcs.pas
  Version 2.1
  Html Help helper functions for Unicode

  Copyright (c) 1999-2010 The Helpware Group
  Email: support@helpware.net
  Web: http://www.helpware.net
  Platform: Unicode version D6, ... 2009
  Changes Notes: See hh_doc.txt

1.51
  Debug info now displays Operating system type and version
1.6 25-Sept-2001
  Add Window Media Player detection
  Update IE HH version numbers
1.7 20-Jan-2002
  In HHCloseAll() don't call HH_CLOSE_ALL unless HH API is available
1.8 24-Feb-2006
  Some minor additions only -- Changes Notes: See hh_doc.txt
    Download: http://helpware.net/delphi/delphikit.zip
    from Kit Home Page: http://helpware.net/delphi/
1.9 17/05/2007
  Some small double byte safe adjustments
2.0 16/05/2009
  Unicode - WideString and AnsiString versions of funcs.
  Note: Only Win2000/WinXP+ support Unicode.
2.1 3/12/2009
  Clean up for Delphi 2010

========================================================
}
unit hh_funcs;

interface

uses Windows,   //This line will not compile under Delphi 1 -- D1 is not supported
     SysUtils,
     Classes,
     Forms,
     ShellApi,
     Registry,
     FileCtrl;

//const Delphi2009Version=20;

//{$IFDEF CONDITIONALEXPRESSIONS}    //valid for Delphi 6+
//  {$IF CompilerVersion >= Delphi2009Version}      //Delphi 2009 + is now UNICODE..
//    {$DEFINE DELPHI_UNICODE}       //There is UNICODE define in Delphi but it may be redefined by some coders (UNICODE is common name)
//  {$IFEND}
//{$ENDIF}


{ >> Create conditional symbols.
     Note: This module is Delphi 2/3/4/5/.. compatible

     VER90     - Predefined by Delphi 2 compiler.
     VER100    - Predefined by Delphi 3 compiler.
     VER120    - Predefined by Delphi 4 compiler.
     VER130    - Predefined by Delphi 5 compiler.
     VER140    - Predefined by Delphi 6 compiler.
     VER150    - Predefined by Delphi 7 compiler.

     D3PLUS    - Compiler is Delphi 3 or greater
     D4PLUS    - Compiler is Delphi 4 or greater
}

//{$DEFINE D3PLUS}
//{$DEFINE D4PLUS}
//{$DEFINE D5PLUS}
//{$DEFINE D6PLUS}
//{$DEFINE D7PLUS}

//{$IFDEF VER90}        //Dephi 2
//  {$UNDEF D3PLUS}
//  {$UNDEF D4PLUS}
//  {$UNDEF D5PLUS}
//  {$UNDEF D6PLUS}
//  {$UNDEF D7PLUS}
//{$ENDIF}

//{$IFDEF VER100}       //Dephi 3
//  {$UNDEF D4PLUS}
//  {$UNDEF D5PLUS}
//  {$UNDEF D6PLUS}
//  {$UNDEF D7PLUS}
//{$ENDIF}

//{$IFDEF VER120}       //Dephi 4
//  {$UNDEF D5PLUS}
//  {$UNDEF D6PLUS}
//  {$UNDEF D7PLUS}
//{$ENDIF}

//{$IFDEF VER130}       //Dephi 5
//  {$UNDEF D6PLUS}
//  {$UNDEF D7PLUS}
//{$ENDIF}

//{$IFDEF VER140}       //Dephi 6
//  {$UNDEF D7PLUS}
//{$ENDIF}


{ Host Type }
type THostType = (htHHAPI, htKeyHHexe, htHHexe);

{ HH comand line prefix}
type TPrefixType = (ptNone, ptIE3, ptIE4);

{Exports}
procedure HHCloseAll;

function HHDisplayTopic(aChmFile, aTopic, aWinDef: AnsiString; aHostType: THostType): Integer; overload;
 function HHDisplayTopic(aChmFile, aTopic, aWinDef: WideString; aHostType: THostType): Integer; overload;
function HHelpContext(aChmFile: AnsiString; aContextID: DWord; aWinDef: AnsiString; aHostType: THostType): Integer; overload;
 function HHelpContext(aChmFile: WideString; aContextID: DWord; aWinDef: WideString; aHostType: THostType): Integer; overload;

function HHTopic(aCHMPath: AnsiString; aHostType: THostType): Integer; overload;
 function HHTopic(aCHMPath: WideString; aHostType: THostType): Integer; overload;
function HHContext(aChmPath: AnsiString; aContextId: Integer; aHostType: THostType): Integer; overload;
 function HHContext(aChmPath: WideString; aContextId: Integer; aHostType: THostType): Integer; overload;

function HHFormat(aChmFile, aTopic, aWinDef: AnsiString; aPrefixType: TPrefixType): AnsiString; overload;
 function HHFormat(aChmFile, aTopic, aWinDef: WideString; aPrefixType: TPrefixType): WideString; overload;
procedure HHSlitCmdStr(s: AnsiString; var aChmFile, aTopic, aWinDef: AnsiString); overload;  //typo kept for backward compatibility
 procedure HHSlitCmdStr(s: WideString; var aChmFile, aTopic, aWinDef: WideString); overload;  //typo kept for backward compatibility
procedure HHSplitCmdStr(s: AnsiString; var aChmFile, aTopic, aWinDef: AnsiString); overload;
 procedure HHSplitCmdStr(s: WideString; var aChmFile, aTopic, aWinDef: WideString); overload;

procedure HHShowError(err: Integer);


{Callbacks available for THookHelpSystem}
type
  THelpProcCallback1 = procedure (Data: Longint);
  THelpProcCallback2 = procedure (Data: Longint; X, Y: Integer);

{THookHelpSystem}
type
  THookHelpSystem = class(TObject)
  private
    FOldHelpEvent: THelpEvent;
    FChmFile: WideString;
    FWinDef: WideString;
    FHostType: THostType;
    FPopupXY: TPoint;
    // korrigiert für XE2 - Nativeint
    //function HelpHook(Command : Word; Data : Longint; Var CallHelp : Boolean) : Boolean;
    function HelpHook(Command : Word; Data : Nativeint; Var CallHelp : Boolean) : Boolean;
  public
    {Optional callback funcs called when Help events come in}
    HelpCallback1: THelpProcCallback1;
    HelpCallback2: THelpProcCallback2;
    FOKToCallOldHelpEvent: Boolean;

    constructor Create(aDefChmFile, aDefWinDef: AnsiString; aHostType: THostType); overload;
    constructor Create(aDefChmFile, aDefWinDef: WideString; aHostType: THostType); overload;
    destructor Destroy; override;

    function HelpContext(aContextId: DWord): Integer;
    function HelpTopic(aTopic: AnsiString): Integer; overload;
     function HelpTopic(aTopic: WideString): Integer; overload;
    function HelpTopic2(aChmFile, aTopic, aWinDef: AnsiString): Integer; overload;
     function HelpTopic2(aChmFile, aTopic, aWinDef: WideString): Integer; overload;
    function HelpTopic3(aChmPath: AnsiString): Integer; overload;
     function HelpTopic3(aChmPath: WideString): Integer; overload;

    property ChmFile: WideString read FChmFile write FChmFile;
    property WinDef: WideString read FWinDef write FWinDef;
    property HostType: THostType read FHostType write FHostType;
  end;

{General purpose Log File}
TDLogFile = class
private
  FFilename: WideString;
  FDebugMode: Boolean;
  FTimeStamp: Boolean;
  FHeaderDump: Boolean;
  FAppendMode: Boolean;
public
  //constructor Create(aFilename: AnsiString; aDebugMode: Boolean; aTimeStamp: Boolean; aHeaderDump, aAppendMode: Boolean); overload;
  constructor Create(aFilename: WideString; aDebugMode: Boolean; aTimeStamp: Boolean; aHeaderDump, aAppendMode: Boolean);
  destructor Destroy; override;
  procedure CopyLogTo(aNewFilename: WideString);  //not implemented

  procedure DebugOut(msgStr: WideString; const Args: array of const);
  procedure DebugOutA(msgStr: AnsiString; const Args: array of const);
  procedure DebugOut2(msgStr: WideString; const Args: array of const);

  procedure ReportErrorA( errStr: AnsiString; const Args: array of const );
  procedure ReportError( errStr: WideString; const Args: array of const );

  procedure Show;
  procedure Reset;
  function GetLogDir: WideString;

  property Filename: WideString read FFilename write FFilename;
  property DebugMode: Boolean read FDebugMode write FDebugMode;     //Only log if this is true
  property HeaderDump: Boolean read FHeaderDump write FHeaderDump;  //Used by Reset
  property AppendMode: Boolean read FAppendMode write FAppendMode;  //Used by Reset
end;


{ See Module initialization }
var
  { 'hhctrl.ocx' version info }
  _hhInstalled: Boolean = FALSE;          //Is Html Help 'hhctrl.ocx' installed
  _hhVerStr: String = '';                 //eg. '4.73.8252.1' or '' if not found
  _hhMajVer: word = 0;                    //eg. 4
  _hhMinVer: word = 0;                    //eg. 73
  _hhBuildNo: word = 0;                   //eg. 8252
  _hhSubBuildNo: word = 0;                //eg. 1
  _hhFriendlyVerStr: String = '';         //eg. '1.2'

  { 'Shdocvw.dll' version info }
  _ieInstalled: Boolean = FALSE;          //Is Internet Explorer Installed
  _ieVerStr: String = '';                 //eg. '5.00.0910.1309'
  _ieFriendlyVerStr: String = '';         //eg. 'Internet Explorer 5'

  { General }
  _RunDir: WideString = '';                   //applications run directory. Or Host EXE directory if part of DLL.
  _ModulePath: WideString;                    //If part of DLL this is the full path to the DLL
  _ModuleDir: WideString;                     //If part of DLL this is the DLL Dir and different from _RunDir
  _ModuleName: WideString;                    //If part of DLL this is the DLL name otherwise it is host exe name

  _RunDirA: AnsiString = '';                   //applications run directory. Or Host EXE directory if part of DLL.
  _ModulePathA: AnsiString;                    //If part of DLL this is the full path to the DLL
  _ModuleDirA: AnsiString;                     //If part of DLL this is the DLL Dir and different from _RunDir
  _ModuleNameA: AnsiString;                    //If part of DLL this is the DLL name otherwise it is host exe name

{ Debug Log file

  We always create this Debug Log Object - If debugging is enabled we fill it with stuff
  To make your own Log file change its properties, then call reset. Or Create your own Obj from scratch.
  Example:
    _HHDbgObj.DebugMode := true;       //Must force logging on to make logging work
    _HHDbgObj.Filename := _HHDbgObj.GetLogDir + '\MyLogfile.txt';   //new log filename
    _HHDbgObj.HeaderDump := true;      //Dump debug header on Reset call
    _HHDbgObj.AppendMode := false;     //Delete old file on reset
    _HHDbgObj.Reset;                   //Resets the Log file
}
var
  _HHDbgObj: TDLogFile = nil;

{ Host Apps - Live in the Windows Dir }
const
  HOST_HHEXE = 'HH.EXE';
  HOST_KEYHHEXE = 'KeyHH.EXE';

{ HH comand line prefix}
const
  HH_PREFIX_IE4 = 'ms-its:';             //IE4 and above compatible command line prefix
  HH_PREFIX_IE3 = 'mk:@MSITStore:';      //IE3 and above compatible command line prefix


{ HH Errors }
const
  HH_ERR_AllOK              = 0;
  HH_ERR_HHNotInstalled     = 1;     //Html Help is not installed on this PC
  HH_ERR_KeyHHexeNotFound   = 2;     //KeyHH.EXE was not found in the Windows folder
  HH_ERR_HHexeNotFound      = 3;     //HH.EXE was not found in the Windows folder


{ exports - General functions }

////* Rename

procedure DosToUnix(var filename: AnsiString); overload;
 procedure DosToUnix(var filename: WideString); overload;
procedure UnixToDos(var filename: AnsiString); overload;
 procedure UnixToDos(var filename: WideString); overload;
function StrPosC(const s: AnsiString; const find: AnsiString): Integer; overload;
 function StrPosC(const s: WideString; const find: WideString): Integer; overload;
function StrPosI(const s: AnsiString; const find: AnsiString): Integer; overload;
 function StrPosI(const s: WideString; const find: WideString): Integer; overload;
function StrRepC(var s: AnsiString;  const find, repl: AnsiString): Integer; overload;
 function StrRepC(var s: WideString;  const find, repl: WideString): Integer; overload;
 function StrRepC( var s: WideString;  const find, repl: AnsiString): Integer; overload;
function StrRepI(var s: AnsiString;  const find, repl: AnsiString): Integer; overload;
 function StrRepI( var s: WideString;  const find, repl: WideString): Integer; overload;
function StrRepCA(var s: AnsiString;  const find, repl: AnsiString): Integer; overload;
 function StrRepCA(var s: WideString;  const find, repl: WideString): Integer; overload;
function StrRepIA(var s: AnsiString;  const find, repl: AnsiString): Integer; overload;
 function StrRepIA(var s: WideString;  const find, repl: WideString): Integer; overload;
procedure StripL(var s: AnsiString; c: AnsiChar); overload;
 procedure StripL(var s: WideString; c: WideChar); overload;
 procedure StripL(var s: WideString; c: AnsiChar); overload;
procedure StripR(var s: AnsiString; c: AnsiChar); overload;
 procedure StripR(var s: WideString; c: WideChar); overload;
 procedure StripR(var s: WideString; c: AnsiChar); overload;
procedure StripLR(var s: AnsiString; c: AnsiChar); overload;
 procedure StripLR(var s: WideString; c: Widechar); overload;
 procedure StripLR(var s: WideString; c: AnsiChar); overload;
procedure StripStrR(var s: AnsiString; find: AnsiString); overload;
 procedure StripStrR(var s: WideString; find: WideString); overload;
procedure StripStrL(var s: AnsiString; find: AnsiString); overload;
 procedure StripStrL(var s: WideString; find: WideString); overload;
function MkStr(c: AnsiChar; count: Integer): AnsiString; overload;
 function MkStr(c: WideChar; count: Integer): WideString; overload;
function ChPosL(s: AnsiString; ch: AnsiChar): Integer; overload;
 function ChPosL(s: WideString; ch: WideChar): Integer; overload;
function ChPosR(s: AnsiString; ch: AnsiChar): Integer; overload;
 function ChPosR(s: WideString; ch: WideChar): Integer; overload;

function BoolToYN(b: Boolean): AnsiString;  //no need to for wide version

function LastDelimiter_(const Delimiters, S: AnsiString): Integer; overload;
 function LastDelimiter_(const Delimiters, S: WideString): Integer; overload;
function ExtractFilePath_(const FileName: AnsiString): AnsiString; overload;
 function ExtractFilePath_(const FileName: WideString): WideString; overload;
function ExtractFileName_(const FileName: AnsiString): AnsiString; overload;
 function ExtractFileName_(const FileName: Widestring): WideString; overload;

function GetWinDir: AnsiString;
 function GetWinDirW: WideString;
function GetWinSysDir: AnsiString;
 function GetWinSysDirW: WideString;
function GetWinTempDir: AnsiString;
 function GetWinTempDirW: WideString;

function VerCompare(va1, va2, va3, va4, vb1, vb2, vb3, vb4: Word): Integer;
function GetFileVer(aFilename: AnsiString; var aV1, aV2, aV3, aV4: word): AnsiString; overload;
 function GetFileVer(aFilename: WideString; var aV1, aV2, aV3, aV4: word): WideString; overload;
function GetFileVerStr(aFilename: AnsiString): AnsiString; overload;
 function GetFileVerStr(aFilename: WideString): WideString; overload;

function GetIExploreExePath: WideString;
function GetIEVer(var V1, V2, V3, V4: word): WideString;
function Check_HH_Version(x1, x2, x3, x4: Integer): Integer;
function Check_IE_Version(x1, x2, x3, x4: Integer): Integer;
function GetHHFriendlyVer: String;
function GetIEFriendlyVer: String;

function Check_WMP_Version(x1, x2, x3, x4: Integer): Integer;

function ShellExec(aFilename: AnsiString; aParams: AnsiString): Boolean; overload;
 function ShellExec(aFilename: WideString; aParams: WideString): Boolean; overload;
function GetLastErrorStr: String;

function GetRegStr(rootkey: HKEY; const key, dataName: String): String;
procedure PutRegStr(rootkey: HKEY; const key, name, value: String);
function RegKeyNameExists(rootkey: HKEY; const key, dataName: String): Boolean;

function ExpandEnvStr(const s: Ansistring): AnsiString; overload;
 function ExpandEnvStr(const s: WideString): WideString; overload;

procedure DebugOut(msgStr: WideString; const Args: array of const);
procedure DebugOut2(msgStr: WideString; const Args: array of const);
procedure ShowDebugFile;
procedure ResetDebugFile;

procedure ShowMessage2(aMsg: AnsiString); overload;
 procedure ShowMessage2(aMsg: WideString); overload;
function MessageBox2(aMsg: AnsiString; Uflags: UInt): Integer; overload;
 function MessageBox2(aMsg: WideString; Uflags: UInt): Integer; overload;
function YNBox2(aMsg: AnsiString): Boolean; overload;
 function YNBox2(aMsg: WideString): Boolean; overload;

function FileExists_(fName: AnsiString): Boolean; overload;
 function FileExists_(fName: WideString): Boolean; overload;
function FileSetAttr_(const FileName: AnsiString; Attr: Integer): Integer; overload;
 function FileSetAttr_(const FileName: WideString; Attr: Integer): Integer; overload;
function DirectoryExistsA(dir: AnsiString): Boolean;
 function DirectoryExists_(dir: WideString): Boolean;
function DirExistsA(dirName: AnsiString): Boolean;
 function DirExists(dirName: WideString): Boolean;
function IsDirWritableA(aDir: AnsiString): Boolean;
 function IsDirWritable(aDir: WideString): Boolean;

function ParamCountW: Integer;
function ParamStrW(Index: Integer): WideString;

function AnsiGetModuleFileName: AnsiString;
function WideGetModuleFileName: WideString;

procedure ReportErrorA( errStr: AnsiString; const Args: array of const );
procedure ReportError( errStr: WideString; const Args: array of const );

//{$IFDEF D3PLUS} // -- Delphi >=3
resourcestring
//{$ELSE}         // -- Delphi 2
//const
//{$ENDIF}

  //Error AnsiStrings
  st_HH_ERR_HHNotInstalled = 'MS Html Help is not installed on this PC.';
  st_HH_ERR_KeyHHexeNotFound = 'System file KeyHH.EXE was not found in the Windows folder.';
  st_HH_ERR_HHexeNotFound = 'System file HH.EXE was not found in the Windows folder.';
  st_HH_ERR_Unknown = 'Unknown error returned by HHelpContext';

  //For GetLastError
  st_GLE_FileNotFound = 'File Not Found';
  st_GLE_PathNotFound = 'Path Not Found';
  st_GLE_AccessDenied = 'Access Denied';
  st_GLE_InsufficientMemory = 'Insufficient Memory';
  st_GLE_MediaIsWriteProtected = 'Media Is Write Protected';
  st_GLE_DeviceNotReady = 'Device Not Ready';
  st_GLE_FileInUse = 'File In Use';
  st_GLE_DiskFull = 'Disk Full';
  st_GLE_WindowsVersionIncorrect = 'Windows Version Incorrect';
  st_GLE_NotAWindowsOrMSDosProgram = 'Not A Windows Or MSDos Program';
  st_GLE_CorruptFileOrDisk = 'Corrupt File Or Disk';
  st_GLE_CorruptRegistry = 'Corrupt Registry';
  st_GLE_GeneralFailure = 'General Failure';

{ Debug File Options }
var
  _DebugMode: Boolean = FALSE;
  _UnicodeSystem: Boolean = true;

{ WideString }
const
  WS_Space: WideString = ' ';
  WS_DosDel: WideString = '\';
  WS_UnixDel: WideString = '/';
  WC_Space: WideChar = ' ';
  WC_DosDel: WideChar = '\';
  WCS_UnixDel: WideChar = '/';

const
  PathDelimW: WideString = '\';
  DriveDelimW: WideString = ':';

  PathDelimA: AnsiString = AnsiChar('\');
  DriveDelimA: AnsiString = AnsiChar(':');

implementation

uses
  hh;  //HH API

var
  { Debug File Options}
  DBG_TIMESTAMP: Boolean = true;
  DBG_HEADERDUMP: Boolean = true;
  DBG_APPENDMODE: Boolean = false;
  DBG_FILENAME: WideString = '\HHDebug.txt';
  DBG_DIR: WideString = '';   //set to app dir in module init


function _IsSingleByte(const S: AnsiString; Index: Integer): Boolean;
begin
  Result := (not SysUtils.SysLocale.FarEast) and (SysUtils.ByteType(S, Index) = mbSingleByte);
end;

{Use this popup means we don't have to use Borland Dialogs Unit
 See MessageBox help for more
 Set Uflags = 0 for OK
}
function MessageBox2(aMsg: AnsiString; Uflags: UInt): Integer;
var sTitle: AnsiString;
begin
  sTitle := AnsiString(application.Title);
  Result := windows.MessageBoxA(0,PAnsiChar(aMsg), PAnsiChar(sTitle), Uflags);
end;
function MessageBox2(aMsg: WideString; Uflags: UInt): Integer;
var wTitle: WideString;
begin
  wTitle := application.Title;
  Result := windows.MessageBoxW(0,PWideChar(aMsg), PWideChar(wTitle), Uflags);
end;

procedure ShowMessage2(aMsg: AnsiString);
begin
  MessageBox2(aMsg, 0);
end;
procedure ShowMessage2(aMsg: WideString);
begin
  MessageBox2(aMsg, 0);
end;

function YNBox2(aMsg: AnsiString): Boolean;
var sTitle: AnsiString;
begin
  sTitle := AnsiString(application.Title);
  Result := windows.MessageBoxA(0,PAnsiChar(aMsg), PAnsiChar(sTitle), MB_YESNO or MB_ICONQUESTION) = IDYES;
end;
function YNBox2(aMsg: WideString): Boolean;
var wTitle: WideString;
begin
  wTitle := application.Title;
  Result := windows.MessageBoxW(0,PWideChar(aMsg), PWideChar(wTitle), MB_YESNO or MB_ICONQUESTION) = IDYES;
end;

//------------------------------------------------------------------------------
// More reliable FileExists in Ansi and Wide flavors
//------------------------------------------------------------------------------

function FileExists_(fName: AnsiString): Boolean;
var h: THandle; SearchRec: TWIN32FindDataA;
begin
  Result := false;
  If fName <> '' then
  begin
    h := FindFirstFileA(PAnsiChar(fName), SearchRec);
    Result := h <> INVALID_HANDLE_VALUE;
    if Result then
    begin
      result := (SearchRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY = 0);  //not a Directory (only looking for files)
      Windows.FindClose(h);
    end;
  end;
end;
function FileExists_(fName: WideString): Boolean;
var SearchRec: TWIN32FindDataW; h: THandle;
begin
  Result := false;
  if not _UnicodeSystem then
    result := FileExists_(AnsiString(fName))
  else
  If fName <> '' then
  begin
    h := FindFirstFileW(PWideChar(fName), SearchRec);
    Result := h <> INVALID_HANDLE_VALUE;
    if Result then
    begin
      result := (SearchRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY = 0);  //not a Directory (only looking for files)
      Windows.FindClose(h);
    end;
  end;
end;

function FileSetAttr_(const FileName: AnsiString; Attr: Integer): Integer;
begin
  Result := 0;
  if not SetFileAttributesA(PAnsiChar(FileName), Attr) then
    Result := GetLastError;
end;
function FileSetAttr_(const FileName: WideString; Attr: Integer): Integer;
begin
  Result := 0;
  if not SetFileAttributesW(PWideChar(FileName), Attr) then
    Result := GetLastError;
end;

function DirectoryExistsA(dir: AnsiString): Boolean;
var SearchRec: TWIN32FindDataA; h: THandle;
begin
  Result := false;
  StripR(dir, '\');
  If dir <> '' then
  begin
    h := FindFirstFileA(PAnsiChar(dir), SearchRec);
    Result := h <> INVALID_HANDLE_VALUE;
    if Result then
    begin
      result := (SearchRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0);  //a directory
      Windows.FindClose(h);
    end;
  end;
end;

function DirectoryExists_(dir: WideString): Boolean;
var SearchRec: TWIN32FindDataW; h: THandle;
begin
  if not _UnicodeSystem then
    result := DirectoryExistsA(AnsiString(dir))
  else
  begin
    Result := false;
    StripR(dir, WC_DosDel);
    If dir <> '' then
    begin
      h := FindFirstFileW(PWideChar(dir), SearchRec);
      Result := h <> INVALID_HANDLE_VALUE;
      if Result then
      begin
        result := (SearchRec.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <> 0);  //a directory
        Windows.FindClose(h);
      end;
    end;
  end;  
end;

function DirExistsA(dirName: AnsiString): Boolean;
begin
  result := DirectoryExistsA(dirName);
end;
function DirExists(dirName: WideString): Boolean;
begin
  result := DirectoryExists_(dirName);
end;


{---------------------------------------------------------------------]
  Hook Help System

  Delphi allows you to trap all help calls and redirect them
  to your own handler. Thus we get Html Help working under D3/4.

  Usage:

    var mHHelp: THookHelpSystem;

    procedure TMainForm.FormCreate(Sender: TObject);
    begin
      //Set CHM file, Window Definition to use if reqired and Mode of operation
      mHHelp := THookHelpSystem.Create(pathToCHM, '', htHHAPI);
      ...

    procedure TMainForm.FormDestroy(Sender: TObject);
    begin
      //Unhook and free
      mHHelp.Free;
      ...

  Show help in the normal way
  o Set "Form.HelpContext := xx" to display page sensitive help via F1 key.
  o Set "Control.HelpContext := xx" to display field sensitive help via F1 and "whats this" help.
  o Call Application.HelpContext(xx) to show help directly from a memu or help button.
  o Make sure that Topic xx, xx is a context ID, is defined in the CHM help file.
  eg. Application.HelpContext(1133)

  To display a topic by topic filename use
  mHHelp.HelpTopic('index.html');

[---------------------------------------------------------------------}

constructor THookHelpSystem.Create(aDefChmFile, aDefWinDef: AnsiString; aHostType: THostType);
begin
  inherited Create;
  FChmFile := WideString(aDefChmFile);
  FWinDef := WideString(aDefWinDef);
  FHostType := aHostType;

  {Hook in our help}
  FOldHelpEvent := Application.OnHelp;
  Application.OnHelp := HelpHook;
  FOKToCallOldHelpEvent := false;
  DebugOut2('THookHelpSystem.Create("%s","%s", %d)', [aDefChmFile, aDefWinDef, ord(aHostType)]);
end;
constructor THookHelpSystem.Create(aDefChmFile, aDefWinDef: WideString; aHostType: THostType);
begin
  inherited Create;
  FChmFile := aDefChmFile;
  FWinDef := aDefWinDef;
  FHostType := aHostType;

  {Hook in our help}
  FOldHelpEvent := Application.OnHelp;
  Application.OnHelp := HelpHook;
  FOKToCallOldHelpEvent := false;
  DebugOut2('THookHelpSystem.Create("%s","%s", %d)', [aDefChmFile, aDefWinDef, ord(aHostType)]);
end; { THookHelpSystem.Create }


destructor THookHelpSystem.Destroy;
begin
  {Must call this or get access violation}
  if FHostType = htHHAPI then
    HHCloseAll;

  {Unhook our help}
  Application.OnHelp := FOldHelpEvent;
  inherited destroy;
  DebugOut2('THookHelpSystem.Destroy',['']);
end; { THookHelpSystem.Destroy }

{ Debug aid - Commands to pass to WinHelp() }
function WinHelpCmdToStr(cmd: Integer): String;
begin
  case cmd of
    HELP_CONTEXT: result := 'HELP_CONTEXT';       { Display topic in ulTopic  }
    HELP_QUIT: result := 'HELP_QUIT';            { Terminate help  }
    HELP_INDEX: result := 'HELP_INDEX or HELP_CONTENTS';         { Display index  }
    HELP_HELPONHELP: result := 'HELP_HELPONHELP';    { Display help on using help  }
    HELP_SETINDEX: result := 'HELP_SETINDEX or HELP_SETCONTENTS';      { Set current Index for multi index help  }
    HELP_CONTEXTPOPUP: result := 'HELP_CONTEXTPOPUP';
    HELP_FORCEFILE: result := 'HELP_FORCEFILE';
    HELP_KEY: result := 'HELP_KEY';         { Display topic for keyword in offabData  }
    HELP_COMMAND: result := 'HELP_COMMAND';
    HELP_PARTIALKEY: result := 'HELP_PARTIALKEY';
    HELP_MULTIKEY: result := 'HELP_MULTIKEY';
    HELP_SETWINPOS: result := 'HELP_SETWINPOS';
    HELP_CONTEXTMENU: result := 'HELP_CONTEXTMENU';
    HELP_FINDER: result := 'HELP_FINDER';
    HELP_WM_HELP: result := 'HELP_WM_HELP';
    HELP_SETPOPUP_POS: result := 'HELP_SETPOPUP_POS';
  else result := '??';
  end;
  result := inttostr(cmd) + ' (' + result + ')';
end;


{ All application help calls to help come here }
// korrigiert für XE2 - Nativeint
//function THookHelpSystem.HelpHook(Command: Word; Data: Longint; Var CallHelp: Boolean) : Boolean;
function THookHelpSystem.HelpHook(Command: Word; Data: Nativeint; Var CallHelp: Boolean) : Boolean;
begin
  result := TRUE;
  DebugOut2('THookHelpSystem.HelpHook(%s, %d)',[WinHelpCmdToStr(Command), Data]);

  //new: 19/4/2003 - Call old help event
  if FOKToCallOldHelpEvent and Assigned(FOldHelpEvent) then
     result := FOldHelpEvent(Command, Data, CallHelp);

  CallHelp := false;
  case Command of
   Help_Context:      //help button
     begin
       if Assigned(HelpCallback1)
         then HelpCallback1(Data)           //Call back
         else Self.HelpContext( Data );     //Call help
     end;
   HELP_SETPOPUP_POS: //call #1 of F1 Popup (Whats This) help
     FPopupXY := SmallPointToPoint(TSmallPoint(Data));           //data = x,y pos for popup
   Help_ContextPopup: //call #2 of F1 Popup (Whats This) help
     begin
       if Assigned(HelpCallback2)
         then HelpCallback2(Data, FPopupXY.X, FPopupXY.Y)   //Call back
         else Self.HelpContext(Data);                       //Call help
     end
   else
     CallHelp := TRUE; //Default handling - WinHelp
  end;
end; { THookHelpSystem.HelpHook }


{ No need to call this directly. Instead call Application.HelpContext(xx) and it will call this
  function because of the hook we have installed.
  Uses ChmFile, WinDef & Hosttype specified by create}
function THookHelpSystem.HelpContext(aContextId: DWord): Integer;
begin
  result := HHelpContext(FChmFile, aContextId, FWinDef, FHostType);
  HHShowError(result);
end;

{Show a help topic - 1
 Uses ChmFile, Topic, WinDef & HostType specified by create}
function THookHelpSystem.HelpTopic(aTopic: AnsiString): Integer;
begin
  result := HHDisplayTopic(AnsiString(FChmFile), aTopic, AnsiString(FWinDef), FHostType);
  HHShowError(result);
end;
function THookHelpSystem.HelpTopic(aTopic: WideString): Integer;
begin
  result := HHDisplayTopic(FChmFile, aTopic, FWinDef, FHostType);
  HHShowError(result);
end;


{Show a help topic - 2
 overrides default Chm and WinDef - still uses initially specified Host Type}
function THookHelpSystem.HelpTopic2(aChmFile, aTopic, aWinDef: AnsiString): Integer;
begin
  result := HHDisplayTopic(aChmFile, aTopic, aWinDef, FHostType);
end;
function THookHelpSystem.HelpTopic2(aChmFile, aTopic, aWinDef: WideString): Integer;
begin
  result := HHDisplayTopic(aChmFile, aTopic, aWinDef, FHostType);
end;

{Show a help topic - 3
 overrides default Chm and WinDef - Specify a full path EG. c:\help\help.chm::/htm/topic.htm}
function THookHelpSystem.HelpTopic3(aChmPath: AnsiString): Integer;
begin
  Result := HHTopic(aCHMPath, FHostType);
end;
function THookHelpSystem.HelpTopic3(aChmPath: WideString): Integer;
begin
  Result := HHTopic(aCHMPath, FHostType);
end;


{ Show Error }
procedure HHShowError(err: Integer);
var s: String;
begin
  case err of
    HH_ERR_AllOK:            s := '';
    HH_ERR_HHNotInstalled:   s := st_HH_ERR_HHNotInstalled;
    HH_ERR_KeyHHexeNotFound: s := st_HH_ERR_KeyHHexeNotFound;
    HH_ERR_HHexeNotFound:    s := st_HH_ERR_HHexeNotFound;
    else                     s := st_HH_ERR_Unknown;
  end;
  if s <> '' then
  begin
    MessageBox2(s, MB_OK or MB_ICONWARNING);
    DebugOut2('HHShowError(%d), "%s"',[err, s]);
  end;
end;


{---------------------------------------------------------------------]
   HH Functions
[---------------------------------------------------------------------}

{ Call HHCloseAll if you are calling help using the HH API.
  It will tell the HH API to close all HH Windows opened by this application.

 Warning: if you are calling HH API function to display help you must call this before
   application shutdown or your application will crash

 Warning: Call this from the mainform OnCloseQuery NOT the OnDestroy.
   This gives more time for the HH API Close thread to return before closing the link to the DLL library.
}
procedure HHCloseAll;
begin
  if HH.HHCtrlHandle <> 0 then  //20-Jan-2001, Don't call HH API if no API available
  begin
    HH.HtmlHelp(0, nil, HH_CLOSE_ALL, 0);
    Sleep(0);   //17-Dec-2001 fix timing problem - bug where HH going off on a thread
  end;
end;


{ HHDisplayTopic()
  Display a Topic from the CHM file using a Window Definition
    aChmFile: In
      Name of compressed help file to display.
      Generally this should be full path as NT is less forgiving with relative paths.
    aTopic: In
      Path to html file in Chm file.
      Leave blank to display open the Chm at the default page
    aWinDef: In
      Specify a window definition. Leading slash will be added if missing.
      Leave blank to display open the Chm with the default window definition
      Note: not supported by some versions of HH.EXE and KeyHH.EXE
    aHostType: In
      Who will host the HH Window
      - htHHAPI:  This application will host via API calls.
      - htKeyHHexe:  Windows KeyHH.EXE will.
      - htHHexe:   Windows HH.EXE will.
    Returns:
      Possible returns
       0 = All OK
       HH_ERR_HHNotInstalled
       HH_ERR_KeyHHexeNotFound (aHostType = htKeyHHexe)
       HH_ERR_HHexeNotFound (aHostType = htHHexe)
  Other Info
      - No checking is done on any of the params.
        Caller should first verify that the chmFile exists.
  Example:
      HHDisplayTopic('windows.chm','about_magnify.htm','windefault', htHHAPI);
}
function HHDisplayTopic(aChmFile, aTopic, aWinDef: AnsiString; aHostType: THostType): Integer;
var target: AnsiString;
begin
  //Showmessage(format('%s, %s, %s, %d',[aChmFile, aTopic, aWinDef, ord(aHostType)]));
  DebugOut2('HHDisplayTopic("%s", %s, "%s", %d)', [aChmFile, aTopic, aWinDef, Ord(aHostType)]);

  if aHostType = htHHexe then  //Prefix required by early versions - use IE3 prefix
    target := HHFormat(aChmFile, aTopic, aWinDef, ptIE3)
  else                         //No prefix needed
    target := HHFormat(aChmFile, aTopic, aWinDef, ptNone);
  result := HHTopic( target, aHostType );
end;
function HHDisplayTopic(aChmFile, aTopic, aWinDef: WideString; aHostType: THostType): Integer;
var target: WideString;
begin
  //Showmessage(format('%s, %s, %s, %d',[aChmFile, aTopic, aWinDef, ord(aHostType)]));
  DebugOut2('HHDisplayTopic("%s", %s, "%s", %d)', [aChmFile, aTopic, aWinDef, Ord(aHostType)]);

  if aHostType = htHHexe then  //Prefix required by early versions - use IE3 prefix
    target := HHFormat(aChmFile, aTopic, aWinDef, ptIE3)
  else                         //No prefix needed
    target := HHFormat(aChmFile, aTopic, aWinDef, ptNone);
  result := HHTopic( target, aHostType );
end;


{
   HHTopic()
   Same as above except aCHMPath may be a combination
   chmfile, Topic, WinDef in the form chmfile::/Topic>WinDef
   Note: HH.EXE normally requires a path prefix.
}
function HHTopic(aCHMPath: AnsiString; aHostType: THostType): Integer;
var appPath: AnsiString; h: HWND;
begin
  DebugOut2('ShowTopic("%s", %d)', [aChmPath, Ord(aHostType)]);
  result := HH_ERR_AllOK;  {0}

  { Check HH Installed on this PC }
  if not _hhInstalled then
    result := HH_ERR_HHNotInstalled
  else
  case aHostType of

    //Host Type = This app using HH API
    htHHAPI:
      begin
        h := HH.HtmlHelpA(GetDesktopWindow, PAnsiChar(aCHMPath), HH_DISPLAY_TOPIC, 0);
        if h > 0 then
          SetForegroundWindow(h);
      end;

    //Host Type = KeyHH.EXE (must be installed)
    htKeyHHexe:
      begin
        appPath := GetWinDir + '\' + HOST_KEYHHEXE;
        if not FileExists_(appPath) then
          result := HH_ERR_KeyHHexeNotFound
        else
        begin
          { Pass the parameters to KeyHH.exe using "-win" for single window.
            hh path prefix is not required by KeyHH.EXE
          }
          ShellExec(appPath, AnsiString('-win ') + aCHMPath);
        end;
      end;

    //Host Type = HH.EXE (part of Html Help)
    htHHexe:
      begin
        appPath := GetWinDir + '\' + HOST_HHEXE;
        if not FileExists_(appPath) then
          result := HH_ERR_HHexeNotFound
        else
        begin
          { HH.EXE requires a prefix. }
          ShellExec(appPath, aCHMPath);
        end;
      end;
  end; {case}
  DebugOut2('  returned - %d', [result]);
end;
function HHTopic(aCHMPath: WideString; aHostType: THostType): Integer;
var appPath: WideString; h: HWND;
begin
  DebugOut2('ShowTopic("%s", %d)', [aChmPath, Ord(aHostType)]);
  result := HH_ERR_AllOK;  {0}

  { Check HH Installed on this PC }
  if not _hhInstalled then
    result := HH_ERR_HHNotInstalled
  else
  case aHostType of

    //Host Type = This app using HH API
    htHHAPI:
      begin
        h := HH.HtmlHelpW(GetDesktopWindow, PWideChar(aCHMPath), HH_DISPLAY_TOPIC, 0);
        if h > 0 then
          SetForegroundWindow(h);
      end;

    //Host Type = KeyHH.EXE (must be installed)
    htKeyHHexe:
      begin
        appPath := GetWinDirW + '\' + HOST_KEYHHEXE;
        if not FileExists_(appPath) then
          result := HH_ERR_KeyHHexeNotFound
        else
        begin
          { Pass the parameters to KeyHH.exe using "-win" for single window.
            hh path prefix is not required by KeyHH.EXE
          }
          ShellExec(appPath, '-win ' + aCHMPath);
        end;
      end;

    //Host Type = HH.EXE (part of Html Help)
    htHHexe:
      begin
        appPath := GetWinDirW + '\' + HOST_HHEXE;
        if not FileExists_(appPath) then
          result := HH_ERR_HHexeNotFound
        else
        begin
          { HH.EXE requires a prefix. }
          ShellExec(appPath, aCHMPath);
        end;
      end;
  end; {case}
  DebugOut2('  returned - %d', [result]);
end;



{ HHelpContext()
  Displays a help topic based on a mapped topic ID.

  Function documentation is the same as above except replace "aTopic" by...

    aContextID
      Specifies the numeric ID of the topic to display

  returns same errors

  Example:
     HHelpContext('windows.chm',200,'windefault', htHHAPI);
}
function HHelpContext(aChmFile: AnsiString; aContextID: DWord; aWinDef: AnsiString; aHostType: THostType): Integer;
var target: AnsiString;
begin
  DebugOut2('HHelpContext("%s", %d, "%s", %d)', [aChmFile, aContextID, aWinDef, Ord(aHostType)]);
  if aHostType = htHHexe //Prefix required by early versions - use IE3 prefix
    then target := HHFormat(aChmFile, AnsiString(''), aWinDef, ptIE3)
    else target := HHFormat(aChmFile, AnsiString(''), aWinDef, ptNone);  //No prefix needed
  result := HHContext( target, aContextID, aHostType );
end;
function HHelpContext(aChmFile: WideString; aContextID: DWord; aWinDef: WideString; aHostType: THostType): Integer;
var target: WideString;
begin
  DebugOut2('HHelpContext("%s", %d, "%s", %d)', [aChmFile, aContextID, aWinDef, Ord(aHostType)]);
  if aHostType = htHHexe //Prefix required by early versions - use IE3 prefix
    then target := HHFormat(aChmFile, WideString(''), aWinDef, ptIE3)
    else target := HHFormat(aChmFile, WideString(''), aWinDef, ptNone);  //No prefix needed
  result := HHContext( target, aContextID, aHostType );
end;


{
   HHContext()
   Same as above except aCHMPath may be a combination
   chmfile & WinDef in the form chmfile>WinDef
   Note: HH.EXE does not support context mapped help - use KeyHH.exe instead
}
function HHContext(aChmPath: AnsiString; aContextId: Integer; aHostType: THostType): Integer;
var appPath: AnsiString; h: HWND;
begin
  DebugOut2('ShowContext("%s", %d)', [aChmPath, Ord(aHostType)]);
  result := HH_ERR_AllOK;  {0}

  { Check HH Installed on this PC }
  if not _hhInstalled then
    result := HH_ERR_HHNotInstalled
  else
  case aHostType of

    //Host Type = This app using HH API
    htHHAPI:
      begin
        h := HH.HtmlHelpA(GetDesktopWindow, PAnsiChar(aChmPath), HH_HELP_CONTEXT, aContextID);
        if h > 0 then
          SetForegroundWindow(h);
      end;

    //Host Type = KeyHH.EXE (must be installed)
    htKeyHHexe:
      begin
        appPath := GetWinDir + '\' + HOST_KEYHHEXE;
        if not FileExists_(appPath) then
          result := HH_ERR_KeyHHexeNotFound
        else
        begin
          { Pass the parameters to KeyHH.exe
            using "-win" for single window and "-#mapid xx " for the context
            hh path prefix is not required by KeyHH.EXE
          }
          ShellExec(appPath, AnsiString('-win -#mapid ') + AnsiString(IntToStr(aContextID) + ' ') + aChmPath);
        end;
      end;

    //Host Type = HH.EXE (part of Html Help)
    htHHexe:
      begin
        appPath := GetWinDir + '\' + HOST_HHEXE;
        if not FileExists_(appPath) then
          result := HH_ERR_HHexeNotFound
        else
          ShellExec(appPath, '-mapid ' + AnsiString(IntToStr(aContextID) + ' ') + aChmPath);
      end;

  end; {case}
  DebugOut2('  returned - %d', [result]);
end;
function HHContext(aChmPath: WideString; aContextId: Integer; aHostType: THostType): Integer;
var appPath: WideString; h: HWND;
begin
  DebugOut2('ShowContext("%s", %d)', [aChmPath, Ord(aHostType)]);
  result := HH_ERR_AllOK;  {0}

  { Check HH Installed on this PC }
  if not _hhInstalled then
    result := HH_ERR_HHNotInstalled
  else
  case aHostType of

    //Host Type = This app using HH API
    htHHAPI:
      begin
        h := HH.HtmlHelpW(GetDesktopWindow, PWideChar(aChmPath), HH_HELP_CONTEXT, aContextID);
        if h > 0 then
          SetForegroundWindow(h);
      end;

    //Host Type = KeyHH.EXE (must be installed)
    htKeyHHexe:
      begin
        appPath := GetWinDirW + '\' + HOST_KEYHHEXE;
        if not FileExists_(appPath) then
          result := HH_ERR_KeyHHexeNotFound
        else
        begin
          { Pass the parameters to KeyHH.exe
            using "-win" for single window and "-#mapid xx " for the context
            hh path prefix is not required by KeyHH.EXE
          }
          ShellExec(appPath, '-win -#mapid ' + IntToStr(aContextID) + ' ' + aChmPath);
        end;
      end;

    //Host Type = HH.EXE (part of Html Help)
    htHHexe:
      begin
        appPath := GetWinDirW + '\' + HOST_HHEXE;
        if not FileExists_(appPath) then
          result := HH_ERR_HHexeNotFound
        else
          ShellExec(appPath, '-mapid ' + IntToStr(aContextID) + ' ' + aChmPath);
      end;

  end; {case}
  DebugOut2('  returned - %d', [result]);
end;



{
  This creates a command line suitable for use with HH.EXE, KeyHH or HHServer.EXE
    chmFile:
       Name of CHM file. Full or relative path.
    Topic:
       Html filename in Chm. Can be blank.
       Under IE4 this can include a bookmark.
    WinDef:
       Window Definition to use. Can be blank.
    aPrefixType:
       What to prefix string to add
       ptNone - No Prefix added
       ptIE3 - IE3 and above compatible prefix added - 'mk:@MSITStore:'
       ptIE4 - IE4 and above compatible prefix added - 'ms-its:'
  Result examples
    HHFormat('windows.chm', 'about_magnify.htm', 'windefault', ptIE3);
    => 'mk:@MSITStore:windows.chm::/about_magnify.htm>windefault'

    chmFile.chm
    chmFile.chm>WinDef
    Helpfile.chm::/Topic.htm>WinDef
    ms-its:chmFile.chm>WinDef
    mk:@MSITStore:Helpfile.chm::/Topic.htm>WinDef

}
function HHFormat(aChmFile, aTopic, aWinDef: AnsiString; aPrefixType: TPrefixType): AnsiString;
begin
  //  Rename all %20 to space
  StrRepCA( aChmFile, '%20', ' ');
  StrRepCA( aTopic, '%20', ' ');
  StrRepCA( aWinDef, '%20', ' ');

  StripLR(aChmFile, ' ');   StripLR(aTopic, ' ');   StripLR(aWinDef, ' ');  //no lead trail spaces

  {make chm and topic}
  if aTopic = '' then
    result := aChmFile
  else
  begin
    DosToUnix(aTopic);                    //Topics should always contain '/' unix slashes
    if not ((aTopic[1] = '/') and _IsSingleByte(aTopic, 1)) then              //we want a leading slash
      aTopic := '/' + aTopic;
    result := aTopic;
    if aChmFile <> '' then                //Allow no chmfile so we can format the topic
      result := aChmFile + '::' + result
  end;

  {add win definition}
  if aWinDef <> '' then
    result := result + '>' + aWinDef;

  {add prefix}
  case aPrefixType of
    ptIE3: result := HH_PREFIX_IE3 + result;
    ptIE4: result := HH_PREFIX_IE4 + result;
  end;
end;
function HHFormat(aChmFile, aTopic, aWinDef: WideString; aPrefixType: TPrefixType): WideString;
begin
  //  Rename all %20 to space
  StrRepCA( aChmFile, '%20', ' ');
  StrRepCA( aTopic, '%20', ' ');
  StrRepCA( aWinDef, '%20', ' ');

  StripLR(aChmFile, WC_Space);   StripLR(aTopic, WC_Space);   StripLR(aWinDef, WC_Space);  //no lead trail spaces

  {make chm and topic}
  if aTopic = '' then
    result := aChmFile
  else
  begin
    DosToUnix(aTopic);                    //Topics should always contain '/' unix slashes
    if not (aTopic[1] = '/') then
      aTopic := '/' + aTopic;
    result := aTopic;
    if aChmFile <> '' then                //Allow no chmfile so we can format the topic
      result := aChmFile + '::' + result
  end;

  {add win definition}
  if aWinDef <> '' then
    result := result + '>' + aWinDef;

  {add prefix}
  case aPrefixType of
    ptIE3: result := HH_PREFIX_IE3 + result;
    ptIE4: result := HH_PREFIX_IE4 + result;
  end;
end;



{
  Given a string s like
    mk:@MSITStore:aChmFile::aTopic>aWinDef
  eg.
    chmFile.chm
    chmFile.chm>WinDef
    Helpfile.chm::/Topic.htm>WinDef
    ms-its:chmFile.chm>WinDef
    mk:@MSITStore:Helpfile.chm::/Topic.htm>WinDef
  return the components
    aChmFile, aTopic, aWinDef
}
//Backward compatible Fix - Typo - Should be Split not Slit
procedure HHSlitCmdStr(s: AnsiString; var aChmFile, aTopic, aWinDef: AnsiString);
begin
  HHSplitCmdStr(s, aChmFile, aTopic, aWinDef);
end;
procedure HHSlitCmdStr(s: WideString; var aChmFile, aTopic, aWinDef: WideString);
begin
  HHSplitCmdStr(s, aChmFile, aTopic, aWinDef);
end;


procedure HHSplitCmdStr(s: AnsiString; var aChmFile, aTopic, aWinDef: AnsiString);
var i: Integer;
begin
   //  Replace all %20 to space
   StrRepCA( s, '%20', ' ');

   {Get WinDef}
   i := StrPosC(s, AnsiString('>'));
   if i > 0 then
   begin
     aWinDef := Copy(s, i+1, Maxint);
     SetLength(s, i-1);
   end;

   {Get Topic}
   i := StrPosC(s, AnsiString('::'));
   if i > 0 then
   begin
     aTopic := Copy(s, i+2, Maxint);
     SetLength(s, i-1);
     DosToUnix(aTopic);                    //Topics should always contain '/' unix slashes
   end;

   {Get chmFile}
   i := StrPosI(s, AnsiString('its:')); //'ms-its:'
   if i > 0 then
     aChmFile := Copy(s, i+length(AnsiString('its:')), Maxint)
   else
   begin
     i := StrPosI(s, AnsiString('store:'));  //'mk:@MSITStore:'
     if i > 0 then
       aChmFile := Copy(s, i+length(AnsiString('store:')), Maxint)
     else
       aChmFile := s;
   end;

   StripLR(aChmFile, ' ');
   StripLR(aTopic, ' ');
   StripLR(aWinDef, ' ');
end;
procedure HHSplitCmdStr(s: WideString; var aChmFile, aTopic, aWinDef: WideString);
var i: Integer;
begin
   //  Replace all %20 to space
   StrRepCA( s, '%20', ' ');

   {Get WinDef}
   i := StrPosC(s, '>');
   if i > 0 then
   begin
     aWinDef := Copy(s, i+1, Maxint);
     SetLength(s, i-1);
   end;

   {Get Topic}
   i := StrPosC(s, '::');
   if i > 0 then
   begin
     aTopic := Copy(s, i+2, Maxint);
     SetLength(s, i-1);
     DosToUnix(aTopic);                    //Topics should always contain '/' unix slashes
   end;

   {Get chmFile}
   i := StrPosI(s, 'its:'); //'ms-its:'
   if i > 0 then
     aChmFile := Copy(s, i+length('its:'), Maxint)
   else
   begin
     i := StrPosI(s, 'store:');  //'mk:@MSITStore:'
     if i > 0 then
       aChmFile := Copy(s, i+length('store:'), Maxint)
     else
       aChmFile := s;
   end;

   StripLR(aChmFile, WC_Space);
   StripLR(aTopic, WC_Space);
   StripLR(aWinDef, WC_Space);
end;


{---------------------------------------------------------------------]
   General Functions
[---------------------------------------------------------------------}

{ Sometimes safest to work in Unix / slashes }
procedure DosToUnix(var filename: AnsiString);
begin
  repeat until StrRepC(filename, '\', '/') = 0;
end;
procedure DosToUnix(var filename: WideString);
begin
  repeat until StrRepC(filename, '\', '/') = 0;
end;

procedure UnixToDos(var filename: AnsiString);
begin
  repeat until StrRepC(filename, '/', '\') = 0;
end;
procedure UnixToDos(var filename: WideString);
begin
  repeat until StrRepC(filename, '/', '\') = 0;
end;


{Find pos of sub string in string. Case Sensitive - returns 0 not found or 1..n}
function StrPosC(const s: AnsiString; const find: AnsiString): Integer;
var p: PAnsiChar;
begin
//{$IFDEF D3PLUS} // -- Delphi >=3
  p := AnsiStrPos( PAnsiChar(s) , PAnsiChar(find) );   //double byte safe
//{$ELSE}         // -- Delphi 2
//  p := StrPos( PAnsiChar(s) , PAnsiChar(find) );   //double byte safe
//{$ENDIF}
  if p = nil then
    result := 0
  else
    result := p - PAnsiChar(s) + 1;
end;
function StrPosC(const s: WideString; const find: WideString): Integer;
var i, LenFind: Integer; tmp: WideString;
begin
  result := 0;
  LenFind := Length(find);
  if LenFind > 0 then
    for i := 1 to length(s)-LenFind+1 do
    begin
      if s[i] = find[1] then  //first char match
      begin
        tmp := copy(s, i, LenFind);
        if tmp = find then begin
          result := i;
          break;
        end;
      end;
    end;
end;


{Same as Above only ignores case}
function StrPosI(const s: AnsiString; const find: AnsiString): Integer;
var s2, find2: AnsiString;
begin
//{$IFDEF DELPHI_UNICODE}
  s2 := AnsiString(AnsiUpperCase(WideString(s)));
  find2 := AnsiString(AnsiUpperCase(WideString(find)));
//{$ELSE}         // -- Delphi 2
//  s2 := AnsiUpperCase(s);
//  find2 := AnsiUpperCase(find);
//{$ENDIF}
  result := StrPosC(s2, find2);
end;
function StrPosI(const s: WideString; const find: WideString): Integer;
var s2, find2: WideString;
begin
  s2 := WideUpperCase(s);
  find2 := WideUpperCase(find);
  result := StrPosC(s2, find2);
end;



{returns pos where subString replacements was done - 0 = none done - Case Sensitive}
function StrRepC( var s: AnsiString;  const find, repl: AnsiString): Integer;
begin
  result := StrPosC(s, find);
  if result > 0 then     {found - replace}
  begin
    Delete( s, result, Length(find) );
    Insert( repl, s, result );
  end;
end;
function StrRepC( var s: WideString;  const find, repl: WideString): Integer;
begin
  result := StrPosC(s, find);
  if result > 0 then     {found - replace}
  begin
    Delete( s, result, Length(find) );
    Insert( repl, s, result );
  end;
end;
function StrRepC( var s: WideString;  const find, repl: AnsiString): Integer;
begin
  result := StrRepC(s, WideString(find), WideString(repl));
end;


{returns pos where subString replacements was done - 0 = none done - Ignore Sensitive}
function StrRepI( var s: AnsiString;  const find, repl: AnsiString): Integer;
begin
  result := StrPosI(s, find);
  if result > 0 then     {found - replace}
  begin
    Delete( s, result, Length(find) );
    Insert( repl, s, result );
  end;
end;
function StrRepI( var s: WideString;  const find, repl: WideString): Integer;
begin
  result := StrPosI(s, find);
  if result > 0 then     {found - replace}
  begin
    Delete( s, result, Length(find) );
    Insert( repl, s, result );
  end;
end;



{Replace all ocurrences (Ignore Case) - returns replacements done}
function StrRepIA( var s: AnsiString; const find, repl: AnsiString): Integer;
begin
  result := 0;
  repeat
    if StrRepI(s, find, repl) > 0 then
      inc(result)
    else
       break;
  until false;
end;
function StrRepIA( var s: WideString; const find, repl: WideString): Integer;
begin
  result := 0;
  repeat
    if StrRepI(s, find, repl) > 0 then
      inc(result)
    else
       break;
  until false;
end;


{Replace all ocurrences (Case Sensitive) - returns replacements done}
function StrRepCA( var s: AnsiString;  const find, repl: AnsiString): Integer;
begin
  result := 0;
  repeat
    if StrRepC(s, find, repl) > 0 then
      inc(result)
    else
       break;
  until false;
end;
function StrRepCA(var s: WideString;  const find, repl: WideString): Integer;
begin
  result := 0;
  repeat
    if StrRepC(s, find, repl) > 0 then
      inc(result)
    else
       break;
  until false;
end;

{Strip leading chars}
procedure StripL(var s: AnsiString; c: AnsiChar);
begin
  while (s <> '') and (s[1] = c) and _IsSingleByte(s, 1) do
    Delete(s, 1, 1);
end;
procedure StripL(var s: WideString; c: WideChar);
begin
  while (s <> '') and (s[1] = c) do
    Delete(s, 1, 1);
end;
procedure StripL(var s: WideString; c: AnsiChar);
begin
  StripL(s, WideChar(c));
end;

{Strip trailing chars}
procedure StripR(var s: AnsiString; c: AnsiChar);
var p: PAnsiChar;
begin
//{$IFDEF D3PLUS} // -- Delphi >=3
  repeat
    p := AnsiLastChar(S);    //nil if S = empty
    if (p <> nil) and (p = c) then
      SetLength(s, Length(s)-1)
    else
      break;
  until p = nil;
//{$ELSE}         // -- Delphi 2
//  repeat
//    if (s <> '') and (s[length(s)] = c) then
//      SetLength(s, Length(s)-1)
//    else
//      break;
//  until false;
//{$ENDIF}
end;
procedure StripR(var s: WideString; c: WideChar);
begin
  repeat
    if (s <> '') and (s[length(s)] = c) then
      SetLength(s, Length(s)-1)
    else
      break;
  until false;
end;
procedure StripR(var s: WideString; c: AnsiChar);
begin
  StripR(s, WideChar(c));
end;

{Strip leading and trailing chars}
procedure StripLR(var s: AnsiString; c: AnsiChar);
begin
  StripL(s, c);
  StripR(s, c);
end;
procedure StripLR(var s: WideString; c: Widechar);
begin
  StripL(s, c);
  StripR(s, c);
end;
procedure StripLR(var s: WideString; c: AnsiChar);
begin
  StripLR(s, WideChar(c));
end;

{Strip trailing string}
procedure StripStrR(var s: AnsiString; find: AnsiString);
var tmp: AnsiString;
begin
  if length(s) >= length(find) then
  begin
    tmp := copy(s, length(s) - length(find) + 1, length(find));
//{$IFDEF DELPHI_UNICODE}
    if AnsiCompareText(WideString(tmp), WideString(find)) = 0 then
      Setlength(s, length(s) - length(find));
//{$ELSE}
//    if CompareText(tmp, find) = 0 then
//      Setlength(s, length(s) - length(find));
//{$ENDIF}
  end;
end;
procedure StripStrR(var s: WideString; find: WideString);
var tmp: WideString;
begin
  if length(s) >= length(find) then
  begin
    tmp := copy(s, length(s) - length(find) + 1, length(find));
    if WideCompareText(tmp, find) = 0 then
      Setlength(s, length(s) - length(find));
  end;
end;

procedure StripStrL(var s: AnsiString; find: AnsiString);
var tmp: AnsiString;
begin
  if length(s) >= length(find) then
  begin
    tmp := copy(s, 1, length(find));
//{$IFDEF DELPHI_UNICODE}
    if AnsiCompareText(WideString(tmp), WideString(find)) = 0 then
      Setlength(s, length(s) - length(find));
//{$ELSE}
//    if CompareText(tmp, find) = 0 then
//      Setlength(s, length(s) - length(find));
//{$ENDIF}
  end;
end;
procedure StripStrL(var s: WideString; find: WideString);
var tmp: WideString;
begin
  if length(s) >= length(find) then
  begin
    tmp := copy(s, 1, length(find));
    if WideCompareText(tmp, find) = 0 then
      Setlength(s, length(s) - length(find));
  end;
end;


{Make string of chars}
function MkStr(c: AnsiChar; count: Integer): AnsiString;
var i: Integer;
begin
  result := '';
  for i := 1 to count do
    result := result + c;
end;
function MkStr(c: WideChar; count: Integer): WideString;
var i: Integer;
begin
  result := '';
  for i := 1 to count do
    result := result + c;
end;


function ChPosL(s: AnsiString; ch: AnsiChar): Integer;
var i: Integer;
begin
  result := 0;
  for i := 1 to length(s) do
    if (s[i] = ch) and _IsSingleByte(s, i) then begin
      result := i;
      break;
    end;
end;
function ChPosL(s: WideString; ch: WideChar): Integer;
var i: Integer;
begin
  result := 0;
  for i := 1 to length(s) do
    if s[i] = ch then begin
      result := i;
      break;
    end;
end;

function ChPosR(s: AnsiString; ch: AnsiChar): Integer;
var i: Integer;
begin
  result := 0;
  for i := length(s) downto 1 do
    if (s[i] = ch) and _IsSingleByte(s, i) then begin
      result := i;
      break;
    end;
end;
function ChPosR(s: WideString; ch: WideChar): Integer;
var i: Integer;
begin
  result := 0;
  for i := length(s) downto 1 do
    if (s[i] = ch) then begin
      result := i;
      break;
    end;
end;

function LastDelimiter_(const Delimiters, S: AnsiString): Integer;
var p, i: Integer;
begin
  result := 0;
  for i := length(s) downto 1 do
    for p := 1 to length(Delimiters) do
      if (s[i] = Delimiters[p]) and _IsSingleByte(s, i) then
      begin
        result := i;
        exit;
      end;
end;
function LastDelimiter_(const Delimiters, S: WideString): Integer;
var p, i: Integer;
begin
  result := 0;
  for i := length(s) downto 1 do
    for p := 1 to length(Delimiters) do
      if s[i] = Delimiters[p] then
      begin
        result := i;
        exit;
      end;
end;

{ Boolean to Yes / No }
function BoolToYN(b: Boolean): AnsiString;
begin
  if b then result := 'YES' else result := 'NO';
end;


function ExtractFilePath_(const FileName: AnsiString): AnsiString;
var I: Integer;
begin
  I := LastDelimiter_(PathDelimA + DriveDelimA, FileName);
  Result := Copy(FileName, 1, I);
end;
function ExtractFilePath_(const FileName: WideString): WideString;
var I: Integer;
begin
  I := LastDelimiter_(PathDelimW + DriveDelimW, FileName);
  Result := Copy(FileName, 1, I);
end;

function ExtractFileName_(const FileName: AnsiString): AnsiString;
var I: Integer;
begin
  I := LastDelimiter_(PathDelimA + DriveDelimA, FileName);
  Result := Copy(FileName, I + 1, MaxInt);
end;
function ExtractFileName_(const FileName: Widestring): WideString;
var I: Integer;
begin
  I := LastDelimiter_(PathDelimW + DriveDelimW, FileName);
  Result := Copy(FileName, I + 1, MaxInt);
end;


{Return Windows Dir}
function GetWinDir: AnsiString;
var path: array[0..260] of AnsiChar;
begin
  GetWindowsDirectoryA(path, SizeOf(path));
  result := path;
  StripR(result, '\');  //no trailing slash
end;
function GetWinDirW: WideString;
var path: array[0..260] of WideChar;
begin
  GetWindowsDirectoryW(path, SizeOf(path));
  result := path;
  StripR(result, WideChar('\'));  //no trailing slash
end;

{Return Windows System Dir}
function GetWinSysDir: AnsiString;
var path: array[0..260] of AnsiChar;
begin
  GetSystemDirectoryA(path, SizeOf(path));
  result := path;
  StripR(result, '\');  //no trailing slash
end;
function GetWinSysDirW: WideString;
var path: array[0..260] of WideChar;
begin
  GetSystemDirectoryW(path, SizeOf(path));
  result := path;
  StripR(result, WideChar('\'));  //no trailing slash
end;

{Get Windows Temp Dir - with no trailing slash}
function GetWinTempDir: AnsiString;
var dwLen: DWORD;
begin
  SetLength(result, 300);
  dwLen := GetTempPathA(300, @result[1]);
  SetLength(result, dwLen);
  StripR(result, '\');  //no trailing slash

  //problems
  if DirectoryExistsA(result) = FALSE then
    result := 'c:';
end;
function GetWinTempDirW: WideString;
var dwLen: DWORD;
begin
  SetLength(result, 300);
  dwLen := GetTempPathW(300, @result[1]);
  SetLength(result, dwLen);
  StripR(result, WideChar('\'));  //no trailing slash

  //problems
  if DirectoryExists_(result) = FALSE then
    result := 'c:';
end;



{
  Get the product version number from a file (exe, dll, ocx etc.)
  Return '' if info not available - eg. file not found
  eg. Returns '7.47.3456.0', aV1=7, aV2=47, aV3=3456 aV4=0
  ie. major.minor.release.build
}
function GetFileVer(aFilename: AnsiString; var aV1, aV2, aV3, aV4: word): AnsiString;
var  InfoSize: DWORD; Wnd: DWORD; VerBuf: Pointer; VerSize: DWORD; FI: PVSFixedFileInfo;
begin
  result := '';
  aV1 := 0;  aV2 := 0;  aV3 := 0;  aV4 := 0;

  if (aFilename = '') or (not FileExists_(aFilename)) then exit;  //don't continue if file not found

  InfoSize := GetFileVersionInfoSizeA(PAnsiChar(aFilename), Wnd);

    //Note: we strip out the resource info for our dll to keep it small
    //Result := SysErrorMessage(GetLastError);

  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfoA(PAnsiChar(aFilename), Wnd, InfoSize, VerBuf) then
      begin
        if VerQueryValueA(VerBuf, '\', Pointer(FI), VerSize) then
        begin
          aV1 := HiWord(FI^.dwFileVersionMS);
          aV2 := LoWord(FI^.dwFileVersionMS);
          aV3 := HiWord(FI^.dwFileVersionLS);
          aV4 := LoWord(FI^.dwFileVersionLS);
          result := AnsiString(IntToStr( HiWord(FI^.dwFileVersionMS) )) + '.' +
                    AnsiString(IntToStr( LoWord(FI^.dwFileVersionMS) )) + '.' +
                    AnsiString(IntToStr( HiWord(FI^.dwFileVersionLS) )) + '.' +
                    AnsiString(IntToStr( LoWord(FI^.dwFileVersionLS) ));
        end
      end
    finally
      FreeMem(VerBuf);
    end;
  end;
end;
function GetFileVer(aFilename: WideString; var aV1, aV2, aV3, aV4: word): WideString;
var  InfoSize: DWORD; Wnd: DWORD; VerBuf: Pointer; VerSize: DWORD; FI: PVSFixedFileInfo;
begin
  result := '';
  aV1 := 0;  aV2 := 0;  aV3 := 0;  aV4 := 0;

  if (aFilename = '') or (not FileExists_(aFilename)) then exit;  //don't continue if file not found

  InfoSize := GetFileVersionInfoSizeW(PWideChar(aFilename), Wnd);

    //Note: we strip out the resource info for our dll to keep it small
    //Result := SysErrorMessage(GetLastError);

  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfoW(PWideChar(aFilename), Wnd, InfoSize, VerBuf) then
      begin
        if VerQueryValueW(VerBuf, '\', Pointer(FI), VerSize) then
        begin
          aV1 := HiWord(FI^.dwFileVersionMS);
          aV2 := LoWord(FI^.dwFileVersionMS);
          aV3 := HiWord(FI^.dwFileVersionLS);
          aV4 := LoWord(FI^.dwFileVersionLS);
          result := IntToStr( HiWord(FI^.dwFileVersionMS) ) + '.' +
                    IntToStr( LoWord(FI^.dwFileVersionMS) ) + '.' +
                    IntToStr( HiWord(FI^.dwFileVersionLS) ) + '.' +
                    IntToStr( LoWord(FI^.dwFileVersionLS) );
        end
      end
    finally
      FreeMem(VerBuf);
    end;
  end;
end; //GetFileVer



{ Same as above but only returns version string }
function GetFileVerStr(aFilename: AnsiString): AnsiString;
var aV1, aV2, aV3, aV4: word;
begin
  result := GetFileVer(aFilename, aV1, aV2, aV3, aV4);
end;
function GetFileVerStr(aFilename: WideString): WideString;
var aV1, aV2, aV3, aV4: word;
begin
  result := GetFileVer(aFilename, aV1, aV2, aV3, aV4);
end;

function GetIExploreExePath: WideString;
  function FileExists_StripOuterStuff(var fn: WideString): Boolean;
  begin
    StripStrR(fn, '%1');
    StripLR(fn, ' ');
    StripLR(fn, ',');
    StripLR(fn, ' ');
    StripLR(fn, '"');
    result := FileExists_(fn);
  end;
var s: WideString;
begin
  result := '';
  //Try a few different registry location the tell us IExplore.exe's location

  s := ExpandEnvStr('%ProgramFiles%\Internet Explorer\IExplore.exe');   //normal location
  if FileExists_(s) then
    result := s;

  if result = '' then
  begin
    s := GetRegStr(HKEY_CLASSES_ROOT, 'Applications\iexplore.exe\shell\open\command', '');  //"C:\Program Files\Internet Explorer\IEXPLORE.EXE" %1
    if FileExists_StripOuterStuff(s) then
      result := s;
  end;
  if result = '' then
  begin
    s := GetRegStr(HKEY_CLASSES_ROOT, 'CLSID\{0002DF01-0000-0000-C000-000000000046}\LocalServer32', '');  //"C:\Program Files\Internet Explorer\IEXPLORE.EXE"
    if FileExists_StripOuterStuff(s) then
      result := s;
  end;
  if result = '' then
  begin
    s := GetRegStr(HKEY_CLASSES_ROOT, 'CLSID\{871C5380-42A0-1069-A2EA-08002B30309D}\shell\OpenHomePage\Command', '');  //"C:\Program Files\Internet Explorer\IEXPLORE.EXE"
    if FileExists_StripOuterStuff(s) then
      result := s;
  end;
  if result = '' then
  begin
    s := GetRegStr(HKEY_CLASSES_ROOT, 'CLSID\{871C5380-42A0-1069-A2EA-08002B30309D}\shell\OpenHomePage\Command', '');  //"C:\Program Files\Internet Explorer\IEXPLORE.EXE"
    if FileExists_StripOuterStuff(s) then
      result := s;
  end;
end;

function GetIEVer(var V1, V2, V3, V4: word): WideString;
begin
  result := GetFileVer(GetIExploreExePath, v1,v2,v3,v4);                     //for v 7+ we need to get version from iExplore.exe
  if (result = '') or (v1 <= 6) then
    result := GetFileVer(GetWinSysDirW + WideString('\Shdocvw.dll'), V1, V2, V3, V4); //for v 6- we need to get version from shdocvw.dll

  //trick -- Early versions of IE had only 3 numbers
  if (v1=4) and (v2<=70) and (v3=0) then
  begin
    v3 := v4;  v4 := 0;
    result := WideFormat('%d.%d.%d.%d',[v1,v2,v3,v4]);
  end;
end;

{
  Version Compare : returns -1 if Va < Vb, 0 if Va = Vb, 1 if Va > Vb
  eg. VerCompar(1,0,0,1, 1,0,0,2) will return -1
  eg. VerCompar(2,0,0,1, 1,0,6,90) will return 1 because 2.0.0.1 is > 1.0.6.90
}
function VerCompare(va1, va2, va3, va4, vb1, vb2, vb3, vb4: Word): Integer;
begin
  if (va1 = vb1) AND (va2 = vb2) AND (va3 = vb3) AND (va4 = vb4) then
    result := 0
  else if (va1 > vb1)
  or ((va1 = vb1) AND (va2 > vb2))
  or ((va1 = vb1) AND (va2 = vb2) AND (va3 > vb3))
  or ((va1 = vb1) AND (va2 = vb2) AND (va3 = vb3) AND (va4 > vb4)) then
    result := 1
  else
    result := -1;
end;


{ Get Friendly version numbers for HTML Help 'hhctrl.ocx'
    V1.0 is   4.72.7290 - IE4
    V1.1 is   4.72.7323
    V1.1a is  4.72.7325 - Windows98
    V1.1b is  4.72.8164 - MSDN
    V1.2 is   4.73.8252 - Adds extra search control & Favorites tab
    V1.21 is  4.73.8412 - Bug fixes
    V1.21a is 4.73.8474 - Quick update to fix FTS on CDROM
    V1.22 is  4.73.8561 - This release fixes three bugs in 1.21a that caused problems for Arabic, Hebrew, and Far East languages.
    V1.3 is   4.74.8702 - Win2000 Unicode support
    V1.31 is  4.74.8793 - Minor update
    V1.32 is  4.74.8875 - Windows ME+ IE5.5
    V1.33 is  4.74.9273 - Windows XP+ IE6.0
    V1.4 is   5.2.3626 - Windows XP SP1 - Moved to Windows Version numbering
    V1.4a is  5.2.3669 - Security update and fixes a problem with multi-page print introduced with 1.4 release. 

  return '' if hhctrl.ocx not found, otherwise a version string like '1.2'.

  Get up to date version info from http://helpware.net/htmlhelp/hh_info.htm
}
function GetHHFriendlyVer: String;
var  v1,v2,v3,v4: Word; fn, s: String;
begin
  fn := hh.GetPathToHHCtrlOCX;
  s := GetFileVer(fn, v1,v2,v3,v4);
  if s = '' then
    result := ''
  else
  if VerCompare( v1,v2,v3,v4, 5,2,3669,0) > 0 then
    result := '> 1.4a'
  else if VerCompare( v1,v2,v3,v4, 5,2,3669,0) >= 0 then
    result := '1.4a'
  else if VerCompare( v1,v2,v3,v4, 5,2,3626,0) >= 0 then
    result := '1.4'
  else if VerCompare( v1,v2,v3,v4, 4,74,9273,0) >= 0 then
    result := '1.33'
  else if VerCompare( v1,v2,v3,v4, 4,74,8857,0) >= 0 then
    result := '1.32'
  else if VerCompare( v1,v2,v3,v4, 4,74,8793,0) >= 0 then
    result := '1.31'
  else if VerCompare( v1,v2,v3,v4, 4,74,8702,0) >= 0 then
    result := '1.3'
  else if VerCompare( v1,v2,v3,v4, 4,73,8561,0) >= 0 then
    result := '1.22'
  else if VerCompare( v1,v2,v3,v4, 4,73,8474,0) >= 0 then
    result := '1.21a'
  else if VerCompare( v1,v2,v3,v4, 4,73,8412,0) >= 0 then
    result := '1.21'
  else if VerCompare( v1,v2,v3,v4, 4,73,8252,0) >= 0 then
    result := '1.2'
  else if VerCompare( v1,v2,v3,v4, 4,72,8164,0) >= 0 then
    result := '1.1b'
  else if VerCompare( v1,v2,v3,v4, 4,72,7325,0) >= 0 then
    result := '1.1a'
  else if VerCompare( v1,v2,v3,v4, 4,72,7323,0) >= 0 then
    result := '1.1'
  else if VerCompare( v1,v2,v3,v4, 4,72,7290,0) >= 0 then
    result := '1.0'
  else
    result := '< 1.0';
end;


{
  Check is IE Version x.x.x.x is installed.
  returns
    -1   ... A lesser version of x.x.x.x is installed.
     0   ... x.x.x.x is the version installed
    +1   ... A greater version of x.x.x.x is installed.

  Example
    if Check_IE_Version(4,70,1300,0) < 0 then
      ShowMessage('HtmlHelp requires that you installed IE3.02 or better.');
}
function Check_IE_Version(x1, x2, x3, x4: Integer): Integer;
var  v1,v2,v3,v4: Word; fn: AnsiString;
begin
  result := -1;
  fn := GetWinSysDir + '\Shdocvw.dll';
  if GetFileVer(fn, v1,v2,v3,v4) <> '' then
  begin
    //trick -- Early versions of IE had only 3 numbers
    if (v1=4) and (v2<=70) and (v3=0) then
    begin
      v3 := v4;  v4 := 0;
    end;

    result := VerCompare(v1,v2,v3,v4, x1,x2,x3,x4);  //Compare installed version with x.x.x.x 
  end;
end;

{
. MediaPlayer 6.4 = 22D6F312-B0F6-11D0-94AB-0080C74C7E95   //MediaPlayer.MediaPlayer.1
   InProc  C:\WINNT\System32\msdxm.ocx  (6.4.9.1117)  (6.4.9.1109)
. MediaPlayer 7.0 = 6BF52A52-394A-11d3-B153-00C04F79FAA6   //WMPlayer.OCX.7
   InProc  C:\WINNT\System32\wmp.ocx (7.1.0.3055)
}
function Check_WMP_Version(x1, x2, x3, x4: Integer): Integer;
var  v1,v2,v3,v4: Word; fn: AnsiString;
begin
  result := -1;

  if x1 = 6 then
    fn := GetWinSysDir + '\msdxm.ocx'           //6.4 player
  else if x1 >= 7 then
    fn := GetWinSysDir + '\wmp.ocx'             //7.x player
  else
    Exit;

  if GetFileVer(fn, v1,v2,v3,v4) <> '' then
    result := VerCompare(v1,v2,v3,v4, x1,x2,x3,x4);  //Compare installed version with x.x.x.x
end;

{ Get Friendly version numbers of IE (see above)
  return '' if Shdocvw.dll not found. otherwise a descriptive version string

  The following are the versions of Shdocvw.dll and the browser version that each represents
  <major version>.<minor version>.<build number>.<sub-build number>

  From http://support.microsoft.com/support/kb/articles/q164/5/39.asp
  or get up to date version info from http://helpware.net/htmlhelp/hh_info.htm

Shdocvw.dll -------------- May be different from the about box

   Version         Product
   --------------------------------------------------------------
   4.70.1155       Internet Explorer 3.0
   4.70.1158       Internet Explorer 3.0 (OSR2)
   4.70.1215       Internet Explorer 3.01
   4.70.1300       Internet Explorer 3.02
   4.71.1008.3     Internet Explorer 4.0 PP2
   4.71.1712.5     Internet Explorer 4.0
   4.72.2106.7     Internet Explorer 4.01
   4.72.3110.3     Internet Explorer 4.01 Service Pack 1
   4.72.3612.1707  Internet Explorer 4.01 SP2
   5.00.0518.5     Internet Explorer 5 Developer Preview (Beta 1)
   5.00.0910.1308  Internet Explorer 5 Beta (Beta 2)
   5.00.2014.213   Internet Explorer 5.0
   5.00.2314.1000  Internet Explorer 5.0a -- Released with Win98 SE and MSDN
   5.00.2614.3500  Internet Explorer 5.0b -- Contains Java VM and DCOM security patch as an update to Win98 SE
   5.00.2721.1400  Internet Explorer 5 with Update for "ImportExport - Favorites()" Security Issue installed
   5.0.2723.2900   Internet Explorer 5.0 with Update for "Server-side Page Reference Redirect" Issue installed.

   5.00.2919.800    Internet Explorer 5.01 (Windows 2000 RC1, build 5.00.2072)
   5.00.2919.3800   Internet Explorer 5.01 (Windows 2000 RC2, build 5.00.2128)
   5.00.2919.6307   Internet Explorer 5.01
   5.00.2919.6400   Internet Explorer 5.01 with Update for "Server-side Page Reference Redirect" Issue installed.
   5.50.3825.1300   Internet Explorer 5.5 Developer Preview (Beta)

   5.50.4030.2400   Internet Explorer 5.5 & Internet Tools Beta
   5.50.4134.0100   Windows Me (4.90.3000)
   5.50.4134.0600   Internet Explorer 5.5
   5.50.4308.2900   Internet Explorer 5.5 Advanced Security Privacy Beta
   5.50.4522.1800   Internet Explorer 5.5 Service Pack 1

   5.50.4522.1800 Internet Explorer 5.5 Service Pack 1
   5.50.4807.2300 Internet Explorer 5.5 Service Pack 2
   6.00.2462.0000 Internet Explorer 6 Public Preview (Beta)
   6.00.2479.0006 Internet Explorer 6 Public Preview (Beta) Refresh
   6.00.2600.0000 Internet Explorer 6 (Windows XP)
   6.00.2712.300  Internet Explorer 6 patched (Windows XP)   ?????
   6.0.2800.1106 Windows XP SP1

   6.00.2900.2180   Internet Explorer 6 for Windows XP SP2
   6.00.3663.0000   Internet Explorer 6 for Microsoft Windows Server 2003 RC1
   6.00.3718.0000   Internet Explorer 6 for Windows Server 2003 RC2
   6.00.3790.0000   Internet Explorer 6 for Windows Server 2003 (released)
   6.00.3790.1830   Internet Explorer 6 for Windows Server 2003 SP1 and Windows XP x64

From http://support.microsoft.com/kb/969393/
   For Internet Explorer 3.0 through 6.0, the browser is implemented in the Shdocvw.dll (Shell Document Object and Control Library) file.
   To determine the version of Internet Explorer 7, you must use the version of Iexplore.exe

}
function GetIEFriendlyVer: String;
var  v1,v2,v3,v4: Word; fn, s: String;
     x1,x2,x3,x4: Word; xIExplore: String;
begin
//{$IFDEF DELPHI_UNICODE}
  fn := GetWinSysDirW + '\Shdocvw.dll';
  s := GetFileVer(fn, v1,v2,v3,v4);
  xIExplore := GetFileVer(GetIExploreExePath, x1,x2,x3,x4);

  //trick -- Early versions of IE had only 3 numbers
  if (v1=4) and (v2<=70) and (v3=0) then
  begin
    v3 := v4;  v4 := 0;
    s := format('%d.%d.%d.%d',[v1,v2,v3,v4]);
  end;
//{$ELSE}         // -- Delphi 2
//  fn := GetWinSysDir + '\Shdocvw.dll';
//  s := GetFileVer(fn, v1,v2,v3,v4);
//  xIExplore := GetFileVer(AnsiString(GetIExploreExePath), x1,x2,x3,x4);
//
//  //trick -- Early versions of IE had only 3 numbers
//  if (v1=4) and (v2<=70) and (v3=0) then
//  begin
//    v3 := v4;  v4 := 0;
//    s := AnsiString(format('%d.%d.%d.%d',[v1,v2,v3,v4]));
//  end;
//{$ENDIF}

  if s = '' then
    result := ''
  else
  if x1 >= 7 then  //for v7 > we need to look in iexplore.exe, for v6 and older we look in shdocvw.dll
  begin
    result := 'Internet Explorer ' + xIExplore;
  end
  else if VerCompare( v1,v2,v3,v4, 6,0,3790,1830) < 0 then
    result := 'Internet Explorer 6'
  else if VerCompare( v1,v2,v3,v4, 6,00,3790,1830) >= 0 then
    result := 'Internet Explorer 6 for Windows Server 2003 SP1 and Windows XP x64'
  else if VerCompare( v1,v2,v3,v4, 6,00,3790,0000) >= 0 then
    result := 'Internet Explorer 6 (Windows Server 2003)'
  else if VerCompare( v1,v2,v3,v4, 6,00,3718,0000) >= 0 then
    result := 'Internet Explorer 6 (Windows Server 2003 RC2)'
  else if VerCompare( v1,v2,v3,v4, 6,00,3663,0000) >= 0 then
    result := 'Internet Explorer 6 (Windows Server 2003 RC1)'
  else if VerCompare( v1,v2,v3,v4, 6,00,2900,2180) >= 0 then
    result := 'Internet Explorer 6 (Windows XP SP2)'
  else if VerCompare( v1,v2,v3,v4, 6,00,2800,1106) >= 0 then
    result := 'Internet Explorer 6 SP1'
  else if VerCompare( v1,v2,v3,v4, 6,00,2712,300) >= 0 then
    result := 'Internet Explorer 6 (Windows XP + minor update)'
  else if VerCompare( v1,v2,v3,v4, 6,00,2600,0000) >= 0 then
    result := 'Internet Explorer 6 (Windows XP)'
  else if VerCompare( v1,v2,v3,v4, 6,00,2479,0006) >= 0 then
    result := 'Internet Explorer 6 Public Preview (Beta) Refresh'
  else if VerCompare( v1,v2,v3,v4, 6,00,2462,0000) >= 0 then
    result := 'Internet Explorer 6 Public Preview (Beta)'
  else if VerCompare( v1,v2,v3,v4, 5,50,4807,2300) >= 0 then
    result := 'Internet Explorer 5.5 Service Pack 2'
  else if VerCompare( v1,v2,v3,v4, 5,50,4522,1800) >= 0 then
    result := 'Internet Explorer 5.5 Service Pack 1'
  else if VerCompare( v1,v2,v3,v4, 5,50,4522,1800) >= 0 then
    result := 'Internet Explorer 5.5 Service Pack 1'
  else if VerCompare( v1,v2,v3,v4, 5,50,4308,2900) >= 0 then
    result := 'Internet Explorer 5.5 Advanced Security Privacy Beta'
  else if VerCompare( v1,v2,v3,v4, 5,50,4134,0600) >= 0 then
    result := 'Internet Explorer 5.5'
  else if VerCompare( v1,v2,v3,v4, 5,50,4134,0100) >= 0 then
    result := 'Internet Explorer 5.5 for Windows Me (4.90.3000)'
  else if VerCompare( v1,v2,v3,v4, 5,50,4030,2400) >= 0 then
    result := 'Internet Explorer 5.5 & Internet Tools Beta'
  else if VerCompare( v1,v2,v3,v4, 5,50,3825,1300) >= 0 then
    result := 'Internet Explorer 5.5 Developer Preview'
  else if VerCompare( v1,v2,v3,v4, 5,00,2919,6400) >= 0 then
    result := 'Internet Explorer 5.01'
  else if VerCompare( v1,v2,v3,v4, 5,00,2919,6307) >= 0 then
    result := 'Internet Explorer 5.01'
  else if VerCompare( v1,v2,v3,v4, 5,00,2919,3800) >= 0 then
    result := 'Internet Explorer 5.01 (Windows 2000 RC2, build 5.00.2128)'
  else if VerCompare( v1,v2,v3,v4, 5,00,2919,800) >= 0 then
    result := 'Internet Explorer 5.01 (Windows 2000 RC1, build 5.00.2072)'
  else if VerCompare( v1,v2,v3,v4, 5,00,2723,2900) >= 0 then
    result := 'Internet Explorer 5.0 updated'
  else if VerCompare( v1,v2,v3,v4, 5,00,2721,1400) >= 0 then
    result := 'Internet Explorer 5.0 updated'
  else if VerCompare( v1,v2,v3,v4, 5,00,2614,0) >= 0 then
    result := 'Internet Explorer 5.0b'
  else if VerCompare( v1,v2,v3,v4, 5,00,2314,0) >= 0 then
    result := 'Internet Explorer 5.0a'
  else if VerCompare( v1,v2,v3,v4, 5,00,2014,0) >= 0 then
    result := 'Internet Explorer 5.0'
  else if VerCompare( v1,v2,v3,v4, 5,00,0910,0) >= 0 then
    result := 'Internet Explorer 5 Beta (Beta 2)'
  else if VerCompare( v1,v2,v3,v4, 5,00,0518,0) >= 0 then
    result := 'Internet Explorer 5 Developer Preview (Beta 1)'
  else if VerCompare( v1,v2,v3,v4, 4,72,3612,0) >= 0 then
    result := 'Internet Explorer 4.01 Service Pack 2 (SP2)'
  else if VerCompare( v1,v2,v3,v4, 4,72,3110,0) >= 0 then
    result := 'Internet Explorer 4.01 Service Pack 1 (SP1)'
  else if VerCompare( v1,v2,v3,v4, 4,72,2106,0) >= 0 then
    result := 'Internet Explorer 4.01'
  else if VerCompare( v1,v2,v3,v4, 4,71,1712,0) >= 0 then
    result := 'Internet Explorer 4.0'
  else if VerCompare( v1,v2,v3,v4, 4,71,1008,0) >= 0 then
    result := 'Internet Explorer 4.0 Platform Preview 2.0 (PP2)'
  else if VerCompare( v1,v2,v3,v4, 4,71,544,0 ) >= 0 then
    result := 'Internet Explorer 4.0 Platform Preview 1.0 (PP1)'
  else if VerCompare( v1,v2,v3,v4, 4,70,1300,0) >= 0 then
    result := 'Internet Explorer 3.02'
  else if VerCompare( v1,v2,v3,v4, 4,70,1215,0) >= 0 then
    result := 'Internet Explorer 3.01'
  else if VerCompare( v1,v2,v3,v4, 4,70,1158,0) >= 0 then
    result := 'Internet Explorer 3.0 (OSR2)'
  else if VerCompare( v1,v2,v3,v4, 4,70,1155,0) >= 0 then
    result := 'Internet Explorer 3.0'
  else if VerCompare( v1,v2,v3,v4, 4,40,520,0 ) >= 0 then
    result := 'Internet Explorer 2.0'
  else if VerCompare( v1,v2,v3,v4, 4,40,308,0 ) >= 0 then
    result := 'Internet Explorer 1.0 (Plus!)'
  else
    result := '< Internet Explorer 1.0 (Plus!)';
end;


{
  Check is HtmlHelp Version x.x.x.x is installed.
  returns
    -1   ... A lesser version of x.x.x.x is installed.
     0   ... x.x.x.x is the version installed
    +1   ... A greater version of x.x.x.x is installed.

  Example
    if Check_HH_Version(4,73,8252,0) < 0 then
      ShowMessage('HtmlHelp 1.2 or greater is required. Please download a new version.');
}
function Check_HH_Version(x1, x2, x3, x4: Integer): Integer;
var  v1,v2,v3,v4: Word; fn: String;
begin
  result := -1;
  fn := hh.GetPathToHHCtrlOCX;
  if GetFileVer(fn, v1,v2,v3,v4) <> '' then
    result := VerCompare(v1,v2,v3,v4, x1,x2,x3,x4);
end;


{
  ShellExec()
  =============================
  Calls Windows shellexecute(h,'open',...)
  eg. Shellexec('mailto:robert.chandler@osi.varian.com', '');
  Returns TRUE if windows reports no errors
}
function ShellExec(aFilename: AnsiString; aParams: AnsiString): Boolean;
var h: THandle; handle: hWnd;
begin
  {
    Get Handle of parent window
  }
  if (Screen <> nil) AND (Screen.ActiveForm <> nil) AND (Screen.ActiveForm.handle <> 0) then
    handle := Screen.ActiveForm.handle
  else
  if Assigned(Application) AND Assigned(Application.Mainform) then
    handle := Application.Mainform.handle
  else
    handle := 0;

  h := ShellExecuteA(handle, 'open', PAnsiChar(aFilename), PAnsiChar(aParams), nil, SW_SHOWDEFAULT);
  result := (h > 32);  //success?
  if NOT result then
    ReportError('Function ShellExecute(%s)' + #13
              + 'Returned: %s', [aFilename+', '+aParams, GetLastErrorStr]);
end;
function ShellExec(aFilename: WideString; aParams: WideString): Boolean;
var h: THandle; handle: hWnd; Operation: WideString;
begin
  if (Screen <> nil) AND (Screen.ActiveForm <> nil) AND (Screen.ActiveForm.handle <> 0) then
    handle := Screen.ActiveForm.handle
  else
  if Assigned(Application) AND Assigned(Application.Mainform) then
    handle := Application.Mainform.handle
  else
    handle := 0;

  Operation := 'open';
  h := ShellExecuteW(handle, PWideChar(Operation), PWideChar(aFilename), PWideChar(aParams), nil, SW_SHOWDEFAULT);

  result := (h > 32);  //success?
  if NOT result then
    ReportError('Function ShellExecute(%s)' + #13
              + 'Returned: %s', [aFilename+', '+aParams, GetLastErrorStr]);
end;


{
  Return error description of last error
}
function GetLastErrorStr: String;
var ErrCode: Integer;
begin
  ErrCode := GetlastError;
  case ErrCode of
    ERROR_FILE_NOT_FOUND:	        result := st_GLE_FileNotFound;
    ERROR_PATH_NOT_FOUND:	        result := st_GLE_PathNotFound;
    ERROR_ACCESS_DENIED:          result := st_GLE_AccessDenied;
    ERROR_NOT_ENOUGH_MEMORY:      result := st_GLE_InsufficientMemory;
    ERROR_WRITE_PROTECT:          result := st_GLE_MediaIsWriteProtected;
    ERROR_NOT_READY:              result := st_GLE_DeviceNotReady;
    ERROR_SHARING_VIOLATION,
    ERROR_LOCK_VIOLATION:         result := st_GLE_FileInUse;
    ERROR_HANDLE_DISK_FULL,
    ERROR_DISK_FULL:              result := st_GLE_DiskFull;
    ERROR_OLD_WIN_VERSION:        result := st_GLE_WindowsVersionIncorrect;
    ERROR_APP_WRONG_OS:           result := st_GLE_NotAWindowsOrMSDosProgram;
    ERROR_EA_FILE_CORRUPT,
    ERROR_UNRECOGNIZED_VOLUME,
    ERROR_FILE_CORRUPT,
    ERROR_DISK_CORRUPT:           result := st_GLE_CorruptFileOrDisk;
    ERROR_BADDB,
    ERROR_INTERNAL_DB_CORRUPTION: result := st_GLE_CorruptRegistry;
  else                            result := st_GLE_GeneralFailure;
  end; {case}
  result := '[Error:'+IntToStr(ErrCode) + '] ' + result;
end;


{ %SYSTEMROOT%\System32\hhctrl.ocx --> C:\Windows\System32\hhctrl.ocx
  %ProgramFiles% --> c:\Program Files
  thanks George Tylutki - 100% Cotton Software - csoft@epix.net }
function ExpandEnvStr(const s: AnsiString): AnsiString;
var P: array[0..4096] of Ansichar;
begin
  ExpandEnvironmentStringsA(PAnsiChar(s), P, SizeOf(P));
  Result := P;
end;
function ExpandEnvStr(const s: WideString): WideString;
var P: array[0..4096] of WideChar;
begin
  ExpandEnvironmentStringsW(PWideChar(s), P, SizeOf(P));
  Result := P;
end;


{
  Get a value from the registry
  dataName = '' for default value.
  Returns '' if not found
}
function GetRegStr(rootkey: HKEY; const key, dataName: String): String;
var rg: TRegistry;
begin
  result := '';  //default return
  rg := TRegistry.Create;
  rg.RootKey :=  rootkey;

  if rg.OpenKeyReadOnly(key) AND rg.ValueExists(dataName) then //safer call under NT - Delphi 4 and above
  begin
    result := rg.ReadString(dataName);
    rg.CloseKey;
  end;
  rg.Free;

  //Expand %systemroot%
  Result := ExpandEnvStr(Result);
end;


function RegKeyNameExists(rootkey: HKEY; const key, dataName: String): Boolean;
var rg: TRegistry;
begin
  rg := TRegistry.Create;
  rg.RootKey :=  rootkey;
  Result := rg.OpenKeyReadOnly(key) AND rg.ValueExists(dataName); //safer call under NT - Delphi 4 only
  if Result then
    rg.CloseKey;
  rg.Free;
end;


{
  Creates a Key and addes a Value
  An absolute key begins with a backslash (\) and is a subkey of the root key.
}
procedure PutRegStr(rootkey: HKEY; const key, name, value: String);
var rg: TRegistry;
begin
  rg := TRegistry.Create;
  rg.RootKey :=  rootkey;
  if rg.OpenKey(key, TRUE {create if not found}) then
  begin
    rg.WriteString(name, value);
    rg.CloseKey;
  end;
  rg.Free;
end;


{
  Sometimes the only way we can test if a drive is writable is to write a test file.
  aDir is some Dir on a valid disk drive
}
function IsDirWritableA(aDir: AnsiString): Boolean;
var fn: AnsiString; h: THandle;
begin
  StripR(aDir, AnsiChar('\'));  //no trailing slash
  fn := aDir + AnsiString('\$_Temp_$.$$$');   //Any abnormal filename will do
  h := Windows.CreateFileA(PAnsiChar(fn), GENERIC_WRITE,
    FILE_SHARE_WRITE or FILE_SHARE_READ or FILE_SHARE_DELETE,
    nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  result := h <> INVALID_HANDLE_VALUE;
  if Result then
  begin
    Windows.CloseHandle(h);
    Windows.DeleteFileA(PAnsiChar(fn));
  end;
end;
function IsDirWritable(aDir: WideString): Boolean;
var fn: WideString; h: THandle;
begin
  if not _UnicodeSystem then
    result := IsDirWritableA(AnsiString(aDir))
  else
  begin
    StripR(aDir, WC_DosDel);  //no trailing slash
    fn := aDir + '\$_Temp_$.$$$';   //Any abnormal filename will do
    h := Windows.CreateFileW(PWideChar(fn), GENERIC_WRITE,
      FILE_SHARE_WRITE or FILE_SHARE_READ or FILE_SHARE_DELETE,
      nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    result := h <> INVALID_HANDLE_VALUE;
    if Result then
    begin
      Windows.CloseHandle(h);
      Windows.DeleteFileW(PWideChar(fn));
    end;
  end;
end;


{----------------------- Debug Log File -------------------------------}

{ Debug Log file. If no file is specified then the default
  folder and filename is used. If the folder is readonly
  then the Log file is created in the Windows Temp folder.

  dbg := TDLogFile.Create(filename, _DebugMode, false, false, false);
  dbg.Reset;
  dbg.debugout('text out',[])
  ...
  dbg.Free;
}
constructor TDLogFile.Create(aFilename: WideString; aDebugMode: Boolean; aTimeStamp: Boolean; aHeaderDump, aAppendMode: Boolean);
var Dir: WideString;
begin
  if aFilename = '' then
    aFilename := DBG_DIR + DBG_FILENAME      //these are prevalidated
  else
  begin
    //Valid Directory? If not default to Windows Temp Dir
    Dir := ExtractFilePath_(aFilename);
    StripR(Dir, WC_DosDel);
    if NOT (DirectoryExists_(Dir) and IsDirWritable(Dir)) then
      aFilename := GetWinTempDirW + WideString('\') + ExtractFileName_(aFilename);
  end;    

  Self.FFilename := aFilename;
  Self.FDebugMode := aDebugMode;
  Self.FTimeStamp := aTimeStamp;
  Self.FHeaderDump := aHeaderDump;
  Self.FAppendMode := aAppendMode;

  //Clear any file attributes
  if FileExists_(aFilename) then
    FileSetAttr_(aFilename, 0);

  Self.Reset;
end;

destructor TDLogFile.Destroy;
begin
end;

//Save the current log to another location
procedure TDLogFile.CopyLogTo(aNewFilename: WideString);
begin
  ShowMessage2('TDLogFile.CopyLogTo() func Not Implemented');
end;

procedure TDLogFile.DebugOutA(msgStr: AnsiString; const Args: array of const);
var f: TextFile; s, timedate: AnsiString;
begin
  {$I-}
  AssignFile(f, FFilename);
  if (not FileExists_(FFilename))
    then Rewrite(f)  //create
    else Append(f);

  if FTimeStamp
    then timedate := AnsiString(TimeToStr(now)) + AnsiString('   ')
    else timedate := AnsiString('');

  if ioresult = 0 then
  begin
    try
      if high(Args)<0                            //(Length(Args) = 0)  <-- Not supported by Delphi 3
        then s := msgStr
        else
//{$IFDEF DELPHI_UNICODE}
  s := AnsiString(format(WideString(msgStr), Args));
//{$ELSE}         // -- Delphi 2
//  s := format(msgStr, Args);
//{$ENDIF}

      if s = '-' then   //separator
        s := MkStr(AnsiChar('-'), 80);
      if s = '=' then   //separator
        s := MkStr(AnsiChar('='), 80);
      if (s <> '') and (s[1] in ['-', '=', '!'])
        then s := Copy(S, 2, maxint)
        else s := timedate + s;

      //write and flush it out
      system.Writeln(f, s);
      system.Flush(f);
    finally
      system.CloseFile(f);
    end;
  end;
end;

procedure TDLogFile.DebugOut(msgStr: WideString; const Args: array of const);
var h: THandle; ws, bom: WideString; dwRet, dwCreate: dword; timedate: String;
const UNICODE_BOM = WideChar($FEFF);
begin
  if not _UnicodeSystem then
  begin
    DebugOut(msgStr, Args);
    Exit;
  end;

  //UTF16 file required file BOM
  if not FileExists_(FFilename) then begin
    dwCreate := CREATE_ALWAYS;
    bom := UNICODE_BOM;
  end
  else begin
    dwCreate := OPEN_ALWAYS;
    bom := '';
  end;

  // Open the existing file, or if the file does not exist,
  // create a new file.
  h := Windows.CreateFileW(PWideChar(FFilename), GENERIC_WRITE,
     FILE_SHARE_WRITE or FILE_SHARE_READ or FILE_SHARE_DELETE,         //other apps can open it
     nil,                      //lpSecurityAttributes - not reqd
     dwCreate,                 //Opens, or creates if file does not exist
     FILE_ATTRIBUTE_NORMAL,    //Normal file attributes
      0);
  if h <> INVALID_HANDLE_VALUE then
  begin
    if FTimeStamp
      then timedate := TimeToStr(now) + '   '
      else timedate := '';

    try
      if high(Args)<0
        then ws := msgStr
        else
          try
            ws := WideFormat(msgStr, Args);
          except
            ws := msgStr;
          end;

      if ws <> '' then
      begin
        if ws = '-' then   //separator
          ws := MkStr('-', 80);
        if ws = '=' then   //separator
          ws := MkStr('=', 80);
      end;

      if (ws <> '') and ((ws[1] = '-') or (ws[1] = '=') or (ws[1] = '!'))
        then ws := Copy(ws, 2, maxint)
        else ws := timedate + ws;

      //Add UTF16 BOM + CR LF
      ws := bom + ws + WideChar(#13) + WideChar(#10);

      //Append to end of file
      SetFilePointer(h, 0, nil, FILE_END);
      WriteFile(h, ws[1], Length(ws)*2, dwRet, nil);
      FlushFileBuffers(h);
    finally
      Windows.CloseHandle(h);
    end;
  end;
end;

{Same as above but checks the debug flag before wrieting output}
procedure TDLogFile.DebugOut2(msgStr: WideString; const Args: array of const);
begin
  if FDebugMode then
    DebugOut(msgStr, Args);
end;

{All Errors reported here. Uses same format as the Delphi Format() function }
procedure TDLogFile.ReportErrorA( errStr: AnsiString; const Args: array of const );
var s: AnsiString;
begin
//{$IFDEF DELPHI_UNICODE}
  s := AnsiString(format(WideString(errStr), Args));
//{$ELSE}         // -- Delphi 2
//  s := format(errStr, Args);
//{$ENDIF}
  MessageBox2(s, MB_OK or MB_ICONWARNING);
  if FDebugMode then
    DebugOutA(s, ['']);
end;
procedure TDLogFile.ReportError( errStr: WideString; const Args: array of const );
var s: WideString;
begin
  if not _UnicodeSystem then
    ReportError(errStr, Args)
  else
  begin
    try
      s := WideFormat( errStr, Args);
    except
      s := errStr;
    end;
    MessageBox2(s, MB_OK or MB_ICONWARNING);
    if FDebugMode then
      DebugOut(s, ['']);
  end;    
end;

{Display Log file in default viewer}
procedure TDLogFile.Show;
begin
  if FileExists_(FFilename)
    then ShellExec(FFilename, '')
    else ShowMessage2('File not found'#13+FFilename+#13+'Debug Enabled = '+IntToStr(Integer(FDebugMode)));
end;


{ Returns a suitable Folder for the log file - No Trailing \
  With the current dir where this EXE or DLL lives (if writable)
  or the window temp dir
}
function TDLogFile.GetLogDir: WideString;
begin
  Result := DBG_DIR;
end;

//============== Wide versions of ParamCount and ParamStr ==================

function GetParamStrW(P: PWideChar; var Param: WideString): PWideChar;
var  i, Len: Integer; Start, S, Q: PWideChar;
begin
  while True do
  begin
    while (P[0] <> #0) and (P[0] <= ' ') do
      Inc(P);
    if (P[0] = '"') and (P[1] = '"') then Inc(P, 2) else Break;
  end;
  Len := 0;
  Start := P;
  while P[0] > ' ' do
  begin
    if P[0] = '"' then
    begin
      Inc(P);
      while (P[0] <> #0) and (P[0] <> '"') do
      begin
        Q := P + 1;
        Inc(Len, Q - P);
        P := Q;
      end;
      if P[0] <> #0 then
        Inc(P);
    end
    else
    begin
      Q := P + 1;
      Inc(Len, Q - P);
      P := Q;
    end;
  end;

  SetLength(Param, Len);

  P := Start;
  S := PWideChar(Param);
  i := 0;
  while P[0] > ' ' do
  begin
    if P[0] = '"' then
    begin
      Inc(P);
      while (P[0] <> #0) and (P[0] <> '"') do
      begin
        Q := P + 1;
        while P < Q do
        begin
          S[i] := P^;
          Inc(P);
          Inc(i);
        end;
      end;
      if P[0] <> #0 then Inc(P);
    end
    else
    begin
      Q := P + 1;
      while P < Q do
      begin
        S[i] := P^;
        Inc(P);
        Inc(i);
      end;
    end;
  end;
  Result := P;
end;

function ParamCountW: Integer;
var  P: PWideChar; S: WideString;
begin
  P := GetParamStrW(GetCommandLineW, S);
  Result := 0;
  while True do
  begin
    P := GetParamStrW(P, S);
    if S = '' then Break;
    Inc(Result);
  end;
end;

function ParamStrW(Index: Integer): WideString;
var  P: PWideChar;
begin
  if Index = 0 then
    Result := WideGetModuleFileName
  else
  begin
    P := GetCommandLineW;
    while True do
    begin
      P := GetParamStrW(P, Result);
      if (Index = 0) or (Result = '') then Break;
      Dec(Index);
    end;
  end;
end;

//==================

function AnsiGetModuleFileName: AnsiString;
var s: array[0..300] of AnsiChar;
begin
  GetModuleFileNameA(HInstance, s, SizeOf(s));
  result := s;
end;

function WideGetModuleFileName: WideString;
var ws: array[0..300] of WideChar;
begin
  GetModuleFileNameW(HInstance, ws, SizeOf(ws));
  result := ws;
end;

//==================

{Delete and start a new debug file
  FHeaderDump - Dump block of system info (usefull for debugging latter)
  FAppendMode - If false always delete any previous log file. If true prev log file will be appended to.
}
procedure TDLogFile.Reset;
var i: Integer; os, spack: String; ws: WideString;
begin
  if FileExists_(FFilename) and (not FAppendMode) then
  begin
    try
      if _UnicodeSystem
        then Windows.DeleteFileW(PWideChar(FFilename))
        else Windows.DeleteFileA(PAnsiChar(AnsiString(FFilename)));
    except
    end;
  end;

  if FDebugMode and FHeaderDump then
  begin
    DebugOut('=',['']);
    DebugOut('!Log File:             %s',[#9 + FFilename]);
    DebugOut('!Date:                 %s',[#9 + DateTimeToStr(now)]);
//{$IFDEF D3PLUS} // -- Delphi >=3
    if Win32CSDVersion <> ''
      then spack := Win32CSDVersion
      else spack := 'No Service Pack';

    if SysUtils.Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      if (Win32MajorVersion = 4) then
         os := 'Windows NT4'
      else if (Win32MajorVersion = 5) and (Win32MinorVersion = 0) then
         os := 'Windows 2000'
      else if (Win32MajorVersion = 5) and (Win32MinorVersion = 1) then
         os := 'Windows XP'
      else if (Win32MajorVersion = 6) and (Win32MinorVersion = 0) then
         os := 'Windows Vista'
      else if (Win32MajorVersion = 6) and (Win32MinorVersion = 1) then
         os := 'Windows 7'
      else
         os := 'Windows NT';
      DebugOut('!Operating System:      %s %d.%d (Build %d) %s',[#9+os,Win32MajorVersion, Win32MinorVersion, Win32BuildNumber, spack]);
    end
    else DebugOut('!Operating System:      %s %d.%d (Build %d) %s',[#9'Windows',Win32MajorVersion, Win32MinorVersion, Win32BuildNumber, spack]);

    DebugOut('!SysLocale.DefaultLCID: %s (%s)',[#9+'0x'+IntToHex(SysLocale.DefaultLCID, 4), inttostr(SysLocale.DefaultLCID)]);
    DebugOut('!SysLocale.PriLangID:   %s (%s)',[#9+'0x'+IntToHex(SysLocale.PriLangID, 4), inttostr(SysLocale.PriLangID)]);
    DebugOut('!SysLocale.SubLangID:   %s (%s)',[#9+'0x'+IntToHex(SysLocale.SubLangID, 4), inttostr(SysLocale.SubLangID)]);
//{$ENDIF}
    DebugOut('!DecimalSeparator:      %s',[#9+FormatSettings.DecimalSeparator]);

    DebugOut('-', ['']);
    DebugOut('!EXE Path =          %s',[#9 + ParamStrW(0)]);
    DebugOut('!EXE Version =       %s',[#9 + GetFileVerStr(ParamStrW(0))]);

    GetParamStrW(GetCommandLineW, ws);
    DebugOut('!Actual CmdLine =  %s',[#9 + ws]);
    ws := '';
    for i := 1 to ParamCountW do
    begin
      if ws <> '' then ws := ws + ' | ';
      ws := ws + ParamStrW(i)
    end;
    DebugOut('!Cmdline Param(s) =  %s',[#9 + ws]);
    DebugOut('!_RunDir =           %s',[#9 + _RunDir]);
    DebugOut('!_ModuleName =       %s',[#9 + _ModuleName]);
    DebugOut('!_ModuleDir =        %s',[#9 + _ModuleDir]);
    DebugOut('!_ModulePath =        %s',[#9 + _ModulePath]);
    DebugOut('!Module Version =       %s',[#9 + GetFileVerStr(_ModulePath)]);

    DebugOut('-', ['']);
    DebugOut('!_hhInstalled =      %s', [#9 + BoolToYN(_hhInstalled)]);
    DebugOut('!_hhVerStr =         %s', [#9 + _hhVerStr]);
    DebugOut('!_hhFriendlyVerStr = %s', [#9 + _hhFriendlyVerStr]);
    DebugOut('-', ['']);
    DebugOut('!_ieInstalled =      %s', [#9 + BoolToYN(_ieInstalled)]);
    DebugOut('!_ieVerStr =         %s', [#9 + _ieVerStr]);
    DebugOut('!_ieFriendlyVerStr = %s', [#9 + _ieFriendlyVerStr]);
    DebugOut('=', ['']);
  end;
end;



procedure DebugOut(msgStr: WideString; const Args: array of const);
begin
  _HHDbgObj.DebugOut(msgStr, Args);
end;

procedure DebugOut2(msgStr: WideString; const Args: array of const);
begin
  _HHDbgObj.DebugOut2(msgStr, Args);  //Only add to log if debug is enabled
end;

procedure ShowDebugFile;
begin
  _HHDbgObj.Show;           //Display Debug Log file
end;

procedure ResetDebugFile;
begin
  _HHDbgObj.Reset;
end;

procedure ReportErrorA(errStr: AnsiString; const Args: array of const );
begin
  _HHDbgObj.ReportErrorA(errStr, Args);  //Popup Warning and if debug enabled log it
end;
procedure ReportError(errStr: WideString; const Args: array of const );
begin
  _HHDbgObj.ReportError(errStr, Args);  //Popup Warning and if debug enabled log it
end;

{ Module initialization }
procedure ModuleInit;
var  v1,v2,v3,v4, i: Word;
begin
  _UnicodeSystem := (Win32Platform = VER_PLATFORM_WIN32_NT);

  //Get run dir & Progname - or DLL or EXE
  _ModulePath := WideGetModuleFileName;
  _ModuleDir := ExtractFilePath_(_ModulePath);
  _ModuleName := ExtractFileName_(_ModulePath);
  StripR(_ModuleDir, WC_DosDel);

  _ModulePathA := AnsiGetModuleFileName;
  _ModuleDirA := ExtractFilePath_(_ModulePathA);
  _ModuleNameA := ExtractFileName_(_ModulePathA);
  StripR(_ModuleDirA, '\');

  { get run dir }
  _RunDir := ExtractFilePath_(ParamStrW(0));
  _RunDirA := AnsiString(ExtractFilePath_(ParamStrW(0)));
  StripR(_RunDir, WC_DosDel);
  StripR(_RunDirA, '\');

  { Debug Dir is current dir, Or root of Windows dir if readonly. CD? }
  If IsDirWritable(_ModuleDir) then
    DBG_DIR := _ModuleDir        //Where EXE or DLL lives
  else
    DBG_DIR := GetWinTempDirW;    //Window Temp folder

  {debug mode enabled is file debug.debug found in the Modules dir OR a /debug or -debug cmdline switch}
  _DebugMode := FileExists_(_ModuleDir + '\debug.debug');
  if not _DebugMode then
     for i := 1 to ParamCountW do
       if (CompareText(ParamStrW(i), '/debug') = 0) or (CompareText(ParamStrW(i), '-debug') = 0) then
       begin
         _DebugMode := TRUE;
         break;
       end;

  {get version info of 'hhctrl.ocx' - returns '' and 0s if not found}
  _hhVerStr := GetFileVer(hh.GetPathToHHCtrlOCX, _hhMajVer, _hhMinVer, _hhBuildNo, _hhSubBuildNo);

  _hhInstalled := (_hhVerStr <> '');
  _hhFriendlyVerStr := GetHHFriendlyVer;

  {ie info}
  _ieVerStr := GetIEVer(v1,v2,v3,v4);
  _ieInstalled := (_ieVerStr <> '');
  _ieFriendlyVerStr := GetIEFriendlyVer;

  //Create Debug file - _DebugMode, TimeStamp:Yes, HeaderDump:Yes, AppendMode:No
  _HHDbgObj := TDLogFile.Create(DBG_DIR + DBG_FILENAME, _DebugMode, DBG_TIMESTAMP, DBG_HEADERDUMP, DBG_APPENDMODE);
end;


initialization
  ModuleInit;
finalization
  _HHDbgObj.Free;
end.
