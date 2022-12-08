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
    PngBitBtn1: TPngBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure btnOpenCLIClick(Sender: TObject);
    procedure btnExtraFlagsHelpClick(Sender: TObject);
    procedure btnHandBreakHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure SetStyle();
    procedure VisualSwitchClick(Sender: TObject);
    procedure LoadIni();
    procedure SaveIni();
    procedure PngBitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    Loaded: Boolean;
    Save: Boolean;
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.dfm}

uses untPrincipal;

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
  Save := True;
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
  end;
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

procedure TfrmConfiguracoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
if not Save then
  Application.Terminate;
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  Loaded := False;
  Save := False;
  LoadIni;
  cklFileTypes.CheckAll(cbChecked);
end;

procedure TfrmConfiguracoes.LoadIni;
var
   Ini: TIniFile;
begin
  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
  try
    cbPreset.ItemIndex := Ini.ReadInteger('Op��es', 'Preset', 0);
    cbSemLegenda.ItemIndex := Ini.ReadInteger('Op��es', 'SemLegendas', 0);
    cbSoftware.ItemIndex := Ini.ReadInteger('Op��es', 'Software', 0);
    spinProcessos.Value := Ini.ReadInteger('Op��es', 'MaximoProcessos', 4);
    edtHandBreakPath.Text := Ini.ReadString('HandBreak', 'Path', '');
    edtHandBreakParams.Text := Ini.ReadString('HandBreak', 'Params', '-i "#inputfile#" -Z "#preset#" --srt-file "#subtitlefile#" --srt-burn "1" -o "#outputfile#"');
    edtFFMpegPath.Text := Ini.ReadString('FFMPEG', 'Path', '');
    edtFFMpegParams.Text := Ini.ReadString('FFMPEG', 'Params', '-i "#inputfile#" -vf subtitles="#subtitlefile#" -c:a copy "#outputfile#"');
    if Ini.ReadString('Op��es', 'Visual', 'Windows') = 'Windows' then
      VisualSwitch.State := tssOff
    else
      VisualSwitch.State := tssOn;
    Loaded:= True;
  finally
    Ini.Free;
  end;

end;

procedure TfrmConfiguracoes.PngBitBtn1Click(Sender: TObject);
begin
cbPreset.ItemIndex := 5;
cbSemLegenda.ItemIndex := 0;
cbSoftware.ItemIndex := 0;
spinProcessos.Value := 4;
edtHandBreakPath.Text := '';
edtHandBreakParams.Text := '-i "#inputfile#" -Z "#preset#" --srt-file "#subtitlefile#" --srt-burn "1" -o "#outputfile#"';
edtFFMpegPath.Text := '';
edtFFMpegParams.Text := '-i "#inputfile#" -vf subtitles="#subtitlefile#" -c:a copy "#outputfile#"';
end;

procedure TfrmConfiguracoes.SaveIni;
var
   Ini: TIniFile;
begin
  Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
  try
    Ini.WriteInteger('Op��es', 'Preset', cbPreset.ItemIndex);
    Ini.WriteInteger('Op��es', 'SemLegendas', cbSemLegenda.ItemIndex);
    Ini.WriteInteger('Op��es', 'Software', cbSoftware.ItemIndex);
    Ini.WriteInteger('Op��es', 'MaximoProcessos', spinProcessos.Value);
    Ini.WriteString('HandBreak', 'Path', edtHandBreakPath.Text);
    Ini.WriteString('HandBreak', 'Params', edtHandBreakParams.Text);
    Ini.WriteString('FFMPEG', 'Path', edtFFMpegPath.Text);
    Ini.WriteString('FFMPEG', 'Params', edtFFMpegParams.Text);
    if VisualSwitch.State = tssOff then
      Ini.WriteString('Op��es', 'Visual', 'Windows')
    else
      Ini.WriteString('Op��es', 'Visual', 'Onyx Blue');
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

