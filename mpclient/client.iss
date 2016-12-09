; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "WOS Player"
#define MyAppToolName "MPCExporter" 
#define MyAppVersion "18.9.29"
#define MyAppPublisher "Winonetech"
#define MyAppURL "http://www.winonetech.com/"
#define MyAppExeName "JRShell.exe"
#define MyAppToolExeName "MPCExporter.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{F0A09664-0CE5-434B-8521-03C7AF7FF6B2}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}  
;AppVersion=LoadValueFromXML(MPClient\META-INF\AIR\application.xml, //application/versionNumber)
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={sd}\MPClient
DefaultGroupName={#MyAppName}
DisableDirPage=no
AllowNoIcons=yes
OutputBaseFilename=WOS Player
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
Source: "MPClient\Adobe AIR\*"; DestDir: "{app}\Adobe AIR"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "MPClient\META-INF\*"; DestDir: "{app}\META-INF"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "MPClient\mimetype"; DestDir: "{app}"; Flags: ignoreversion
Source: "MPClient\css.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "MPClient\MPClient.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "MPClient\MPClient.swf"; DestDir: "{app}"; Flags: ignoreversion
Source: "files\run.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "files\JRShell.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "files\JRShell.cfg.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "files\MPCExporter.xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "files\MPCExporter.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "led\*"; DestDir: "{app}\led"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files


[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{#MyAppToolName}"; Filename: "{app}\{#MyAppToolExeName}"
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
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var appWnd: HWND;
begin
   // 检查JRShell.exe进程是否在运行，是则关闭进程
   appWnd := FindWindowByClassName('WindowsForms10.Window.8.app.0.33c0d9d');
   if (appWnd <> 0) then
   begin
      PostMessage(appWnd, 18, 0, 0);       // quit
   end;
   
   // 检查MPClient.exe进程是否在运行，是则关闭进程
   appWnd := FindWindowByClassName('ApolloRuntimeContentWindow');
   if (appWnd <> 0) then
   begin
      PostMessage(appWnd, 18, 0, 0);       // quit
   end;
   // 检查MPClient.exe进程是否在运行，是则关闭进程
   appWnd := FindWindowByClassName('CabinetWClass');
   if (appWnd <> 0) then
   begin
      PostMessage(appWnd, 18, 0, 0);       // quit
   end;
   
   // 检查LedSendNew.exe进程是否在运行，是则关闭进程
   appWnd := FindWindowByWindowName('LedSendNew');
   if (appWnd <> 0) then
   begin
      PostMessage(appWnd, 18, 0, 0);       // quit
   end;
   
end;   


function LoadValueFromXML(const AFileName, APath: string): string;
var
  XMLNode: Variant;
  XMLDocument: Variant;  
begin
  Result := '';
  XMLDocument := CreateOleObject('Msxml2.DOMDocument.6.0');
  try
    XMLDocument.async := False;
    XMLDocument.load(AFileName);
    if (XMLDocument.parseError.errorCode <> 0) then
      MsgBox('The XML file could not be parsed. ' + 
        XMLDocument.parseError.reason, mbError, MB_OK)
    else
    begin
      XMLDocument.setProperty('SelectionLanguage', 'XPath');
      XMLNode := XMLDocument.selectSingleNode(APath);
      MsgBox(XMLNode.text, mbError, MB_OK);
      Result := XMLNode.text;
    end;
  except
    MsgBox('An error occured!' + #13#10 + GetExceptionMessage, mbError, MB_OK);
  end;
end;

[/code]
