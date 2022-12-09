unit untConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.Samples.Spin, Vcl.Mask, Vcl.ExtCtrls, Winapi.ShellAPI, Vcl.Buttons,
  PngBitBtn, Vcl.WinXCtrls, System.IniFiles, Vcl.Themes;

type
  TfrmConfiguracoes = class(TForm)
    gpbArquivos: TGroupBox;
    cklFileTypes: TCheckListBox;
    gbOpcoes: TGroupBox;
    Label1: TLabel;
    edtHandBreakPath: TEdit;
    btnOpenCLI: TButton;
    btnHandBreakHelp: TButton;
    edtHandBreakParams: TLabeledEdit;
    btnExtraFlagsHelp: TButton;
    GroupBox1: TGroupBox;
    cbPreset: TComboBox;
    GroupBox2: TGroupBox;
    cbSemLegenda: TComboBox;
    GroupBox3: TGroupBox;
    spinProcessos: TSpinEdit;
    GroupBox4: TGroupBox;
    cbSoftware: TComboBox;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    edtFFMpegPath: TEdit;
    Button1: TButton;
    Button2: TButton;
    edtFFMpegParams: TLabeledEdit;
    Button3: TButton;
    hbDialog: TOpenDialog;
    ffmpegDialog: TOpenDialog;
    memParams: TMemo;
    btnOK: TPngBitBtn;
    VisualSwitch: TToggleSwitch;
    btnRestore: TPngBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure btnOpenCLIClick(Sender: TObject);
    procedure btnExtraFlagsHelpClick(Sender: TObject);
    procedure btnHandBreakHelpClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure SetStyle();
    procedure VisualSwitchClick(Sender: TObject);
    procedure LoadIni();
    procedure SaveIni();
    procedure btnRestoreClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ApplyConfig;
    procedure CheckSoftwareExists;
    procedure FormCreate(Sender: TObject);
    procedure cbSoftwareChange(Sender: TObject);
  private
    { Private declarations }
  public
    Loaded: Boolean;
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.dfm}

uses untPrincipal;

procedure TfrmConfiguracoes.ApplyConfig;
begin
  with frmPrincipal do begin
    if cbSoftware.ItemIndex = 0 then begin
      CLIPath := edtHandBreakPath.Text;
      BaseParams := edtHandBreakParams.Text;
    end else begin
      CLIPath := edtFFmpegPath.Text;
      BaseParams := edtFFMpegParams.Text;
    end;
    MaxProcesses := spinProcessos.Value;
    NoSubtitle := cbSemLegenda.ItemIndex;
    Preset := cbPreset.Items[cbPreset.ItemIndex];
    Software := cbSoftware.ItemIndex;
  end;
end;

procedure TfrmConfiguracoes.btnExtraFlagsHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('https://handbrake.fr/docs/en/latest/cli/command-line-reference.html'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmConfiguracoes.btnHandBreakHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('https://handbrake.fr/downloads2.php'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmConfiguracoes.btnOKClick(Sender: TObject);
begin
  SaveIni;
  ApplyConfig;
  Close;
end;

procedure TfrmConfiguracoes.btnOpenCLIClick(Sender: TObject);
begin
if hbDialog.Execute then
  edtHandBreakPath.Text := hbDialog.FileName;
end;

procedure TfrmConfiguracoes.Button1Click(Sender: TObject);
begin
if ffmpegDialog.Execute then
  edtFFmpegPath.Text := ffmpegDialog.FileName;
end;

procedure TfrmConfiguracoes.Button2Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('https://github.com/BtbN/FFmpeg-Builds/releases'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmConfiguracoes.Button3Click(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar('https://ffmpeg.org/ffmpeg.html'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmConfiguracoes.cbSoftwareChange(Sender: TObject);
begin
  cbPreset.Enabled := (cbSoftware.ItemIndex = 0);
end;

procedure TfrmConfiguracoes.CheckSoftwareExists;
begin
  if cbSoftware.ItemIndex = 0 then
    if not FileExists(edtHandBreakPath.Text) then
      edtHandBreakPath.Text := '';
  if cbSoftware.ItemIndex = 1 then
    if not FileExists(edtFFMpegPath.Text) then
      edtFFMpegPath.Text := '';

end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  Loaded := False;
  LoadIni;
  ApplyConfig;
  cklFileTypes.CheckAll(cbChecked);
  frmPrincipal.CheckConfig();
end;

procedure TfrmConfiguracoes.LoadIni;
var
   Ini: TIniFile;
begin
  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.ini' ) );
  try
    cbPreset.ItemIndex := Ini.ReadInteger('Opções', 'Preset', 5);
    cbSemLegenda.ItemIndex := Ini.ReadInteger('Opções', 'SemLegendas', 0);
    cbSoftware.ItemIndex := Ini.ReadInteger('Opções', 'Software', 0);
    cbPreset.Enabled := (cbSoftware.ItemIndex = 0);
    spinProcessos.Value := Ini.ReadInteger('Opções', 'MaximoProcessos', 4);
    edtHandBreakPath.Text := Ini.ReadString('HandBreak', 'Path', ExtractFilePath(Application.ExeName) + 'HandBrakeCLI.exe');
    edtHandBreakParams.Text := Ini.ReadString('HandBreak', 'Params', '-i "#inputfile#" -Z "#preset#" --srt-file "#subtitlefile#" --srt-burn "1" -o "#outputfile#"');
    edtFFMpegPath.Text := Ini.ReadString('FFMPEG', 'Path', ExtractFilePath(Application.ExeName) + 'ffmpeg.exe');
    edtFFMpegParams.Text := Ini.ReadString('FFMPEG', 'Params', '-i "#inputfile#" -c:v libx264 -crf 20 -movflags +faststart -vf subtitles="#subtitlefile#" -c:a aac -b:a 160k -y "#outputfile#"');
    if Ini.ReadString('Opções', 'Visual', 'Windows') = 'Windows' then
      VisualSwitch.State := tssOff
    else
      VisualSwitch.State := tssOn;
    Loaded:= True;
  finally
    Ini.Free;
  end;

end;

procedure TfrmConfiguracoes.btnRestoreClick(Sender: TObject);
begin
cbPreset.ItemIndex := 5;
cbSemLegenda.ItemIndex := 0;
cbSoftware.ItemIndex := 0;
spinProcessos.Value := 4;
edtHandBreakPath.Text := '';
edtHandBreakParams.Text := '-i "#inputfile#" -Z "#preset#" --srt-file "#subtitlefile#" --srt-burn "1" -o "#outputfile#"';
edtFFMpegPath.Text := '';
edtFFMpegParams.Text := '-i "#inputfile#" -c:v libx264 -crf 20 -movflags +faststart -vf subtitles="#subtitlefile#" -c:a aac -b:a 160k -y "#outputfile#"';
end;

procedure TfrmConfiguracoes.SaveIni;
var
   Ini: TIniFile;
begin
  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.ini' ) );
  try
    Ini.WriteInteger('Opções', 'Preset', cbPreset.ItemIndex);
    Ini.WriteInteger('Opções', 'SemLegendas', cbSemLegenda.ItemIndex);
    Ini.WriteInteger('Opções', 'Software', cbSoftware.ItemIndex);
    Ini.WriteInteger('Opções', 'MaximoProcessos', spinProcessos.Value);
    Ini.WriteString('HandBreak', 'Path', edtHandBreakPath.Text);
    Ini.WriteString('HandBreak', 'Params', edtHandBreakParams.Text);
    Ini.WriteString('FFMPEG', 'Path', edtFFMpegPath.Text);
    Ini.WriteString('FFMPEG', 'Params', edtFFMpegParams.Text);
    if VisualSwitch.State = tssOff then
      Ini.WriteString('Opções', 'Visual', 'Windows')
    else
      Ini.WriteString('Opções', 'Visual', 'Onyx Blue');
  finally
    Ini.Free;
  end;

end;

procedure TfrmConfiguracoes.SetStyle;
begin
  SaveIni;
  ShellExecute(Handle, nil, PChar(Application.ExeName), nil, nil, SW_SHOWNORMAL);
  Application.Terminate;
end;

procedure TfrmConfiguracoes.VisualSwitchClick(Sender: TObject);
begin
  if Loaded then
    SetStyle;
end;

end.

