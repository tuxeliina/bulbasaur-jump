#define MyAppName "Bulbasaur Jump"
#define MyAppVersion "1.0"
#define MyAppPublisher "soosh"
#define MyAppURL "https://s00.sh"
#define MyAppExeName "bulbahop.exe"
#define DoubleAmp(Value) StringChange(Value, "&", "&&")

[Setup]
AppId={{F7E65915-5827-44B7-8849-52A5DA795128}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\bulbasaur-jump
SetupIconFile=C:\Users\Eliina\programmering2\bulbasaur-jump\game.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
DisableProgramGroupPage=yes
LicenseFile=C:\Users\Eliina\programmering2\bulbasaur-jump\LICENSE.md
InfoBeforeFile=C:\Users\Eliina\programmering2\bulbasaur-jump\README.md
PrivilegesRequired=lowest
OutputBaseFilename=bulbasaur-jump-setup
Compression=lzma2/ultra64
SolidCompression=yes
LZMAUseSeparateProcess=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\src\game.ico"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\src\game.ico"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#DoubleAmp(MyAppName)}}"; Flags: nowait postinstall skipifsilent
