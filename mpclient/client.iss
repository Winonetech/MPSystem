; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!


#define MyAppName "WOS Player o2o"
#define MyAppVersion "18.8.12"

#define MyAppPublisher "Winonetech"
#define MyAppURL "http://www.winonetech.com/"
#define MyAppExeName "MPClient.exe"
#define MyAppToolName "MPCExporter.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F0A09664-0CE5-434B-8521-03C7AF7FF6B2}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\MPClient
DefaultGroupName={#MyAppName}
DisableDirPage=no
AllowNoIcons=yes
OutputBaseFilename=WOS Player o2o
SetupIconFile=files\MPClient.ico
Compression=lzma
SolidCompression=yes
VersionInfoVersion={#MyAppVersion}
VersionInfoTextVersion={#MyAppVersion}
ShowLanguageDialog=yes

[Languages]
Name: "Chilese"; MessagesFile: "compiler:Default.isl"
Name: "English"; MessagesFile: "compiler:Languages/English.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1


[Files]

Source: "MPClient\assets\*"; DestDir: "{app}\assets"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "financeData\*"; DestDir: "{app}\financeData"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "MPClient\Adobe AIR\*"; DestDir: "{app}\Adobe AIR"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "MPClient\META-INF\*"; DestDir: "{app}\META-INF"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "MPClient\mimetype"; DestDir: "{app}"; Flags: ignoreversion
Source: "MPClient\MPClient.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "MPClient\MPClient.swf"; DestDir: "{app}"; Flags: ignoreversion
Source: "files\run.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "files\MPCExporter.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "files\MPCExporter.exe"; DestDir: "{app}"; Flags: ignoreversion

; NOTE: Don't use "Flags: ignoreversion" on any shared system files


[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{#MyAppToolName}"; Filename: "{app}\{#MyAppToolName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Registry] 
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "WOSPlayer"; ValueData: "{app}\{#MyAppExeName}"
Root: HKCU; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\{#MyAppExeName}"; ValueData: "~ RUNASADMIN"
Root: HKCU; Subkey: "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\{#MyAppToolName}"; ValueData: "~ RUNASADMIN"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[code]
 
//删除所有配置文件以达到干净卸载的目的 
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
    if CurUninstallStep = usUninstall then
      //删除 {app} 文件夹及其中所有文件
      DelTree(ExpandConstant('{app}'), True, True, True);
end;

[/code]
