program Encoder;



uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  untEncodeThread in 'untEncodeThread.pas',
  untConfiguracoes in 'untConfiguracoes.pas' {frmConfiguracoes},
  Vcl.Themes,
  Vcl.Styles,
  Vcl.Dialogs,
  System.IniFiles,
  System.SysUtils;

{$R *.res}
var
  Ini: TiniFile;
  Skin: String;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
  Skin := Ini.ReadString('Opções', 'Visual', 'Windows');
  Ini.Free;
  TStyleManager.TrySetStyle(Trim(Skin));
  Application.Title := 'AcervoCursos - Encoder de Legenda';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmConfiguracoes, frmConfiguracoes);
  Application.Run;
end.
