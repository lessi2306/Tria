; Tria SETUP SCRIPT
; Compiler Error: Der Prozess kann nicht auf die Datei zugreifen, Datei wird benutzt:  
; McAfee Echtzeit-Scan abschalten
; bei einer neuen Version müssen nur folgende Definitionen angepasst werden:
#define MyAppVerName "Tria - 11.5.8"
#define MyAppOutputBaseFilename "tria_1158_setup"
#define MyAppExeDir "D:\Tria\Projekte-XE2\Tria-Projekt\Setup"

; Tria Definitionen
#define MyAppName "Tria"
#define MyAppDefaultDirName "Tria"
#define MyAppId "Tria"
#define MyAppPublisher "Gerhard Selten"
#define MyAppURL "http://www.selten.de"
#define MyAppExeName "Tria.exe"
#define MyAppFileExt1 ".tri"
#define MyAppFileExt2 ".~tri"
#define MyAppFileExts ".tri/.~tri"
#define MyAppFileType "tria2003datei"
#define MyAppFileName "Tria Datei"
#define MyAppMutexName "TriaMutexName"

[Setup]
AppId={#MyAppId}
AppName={#MyAppName}
AppVerName={#MyAppVerName}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppMutex={#MyAppMutexName}
DefaultDirName={pf}\{#MyAppDefaultDirName}
DefaultGroupName={#MyAppDefaultDirName}
OutputDir={#MyAppExeDir}
LicenseFile={#MyAppExeDir}\TriaLizens.rtf
OutputBaseFilename={#MyAppOutputBaseFilename}
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma
SolidCompression=yes
ChangesAssociations=yes
PrivilegesRequired=admin

[Languages]
;Name: ger; MessagesFile: compiler:Languages\German.isl
Name: ger; MessagesFile: {#MyAppExeDir}\Tria-German.isl

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}
; GroupDescription: Symbole:
;Name: quicklaunchicon; Description: {cm:CreateQuickLaunchIcon}; GroupDescription: Symbole:  geht nicht bei Windows 7
Name: associate; Description: {cm:AssocFileExtension,{#MyAppName},{#MyAppFileExts}}
; GroupDescription: Dateitypen:

[Files]
Source: {#MyAppExeDir}\Tria.chm; DestDir: {app}; Flags: ignoreversion
Source: {#MyAppExeDir}\Tria.exe; DestDir: {app}; Flags: ignoreversion
Source: {#MyAppExeDir}\readme_tri.htm; DestDir: {app}; Flags: ignoreversion isreadme

[Icons]
Name: {group}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; WorkingDir: "{app}"
Name: {group}\{cm:UninstallProgram,{#MyAppName}}; Filename: {uninstallexe}
Name: {commondesktop}\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: desktopicon
;Name: {commonappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: quicklaunchicon

[Registry]
Root: HKCR; Subkey: {#MyAppFileExt1}; ValueType: string; ValueName: ; ValueData: {#MyAppFileType}; Flags: uninsdeletevalue; Tasks: associate
Root: HKCR; Subkey: {#MyAppFileExt2}; ValueType: string; ValueName: ; ValueData: {#MyAppFileType}; Flags: uninsdeletevalue; Tasks: associate
Root: HKCR; Subkey: {#MyAppFileType}; ValueType: string; ValueName: ; ValueData: {#MyAppFileName}; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; Subkey: {#MyAppFileType}\DefaultIcon; ValueType: string; ValueName: ; ValueData: {app}\{#MyAppExeName},0; Tasks: associate
Root: HKCR; Subkey: {#MyAppFileType}\shell\open\command; ValueType: string; ValueName: ; ValueData: """{app}\{#MyAppExeName}"" ""%1"""; Tasks: associate

[Run]
Filename: {app}\{#MyAppExeName}; Description: {cm:LaunchProgram,{#MyAppName}}; Flags: nowait postinstall skipifsilent
