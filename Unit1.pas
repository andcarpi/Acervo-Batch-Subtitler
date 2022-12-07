unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FileCtrl, Vcl.Buttons,
  PngBitBtn, System.IOUtils, System.Types, Vcl.Mask, Vcl.ExtCtrls, Winapi.ShellAPI,
  Vcl.CheckLst;

type
  TfrmPrincipal = class(TForm)
    pbSourceLocation: TGroupBox;
    edtSource: TEdit;
    Button1: TButton;
    odDialog: TFileOpenDialog;
    gb: TGroupBox;
    Button2: TButton;
    edtOutput: TEdit;
    PngBitBtn1: TPngBitBtn;
    gpbFileList: TGroupBox;
    fileList: TCheckListBox;
    lblArquivosEncontrados: TLabel;
    GroupBox3: TGroupBox;
    edtHandBreak: TEdit;
    Button3: TButton;
    Label1: TLabel;
    hbDialog: TOpenDialog;
    Label2: TLabel;
    cbSemLegenda: TComboBox;
    edtFiltro: TLabeledEdit;
    cbPreset: TComboBox;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure PngBitBtn1Click(Sender: TObject);
    function GenerateOutputFile(InputFile: String): String;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    HandBreakPath: String;
    function BuildParams(sourcefile, outputFile: String): String;
    procedure FixDirectory(outputFile: String);
    procedure LoadFiles();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

function TfrmPrincipal.BuildParams(sourcefile, outputFile: String): String;
var
  FParams: String;
begin
  FParams := '-i "#inputfile#" -Z "#preset#" --srt-file "#subtitlefile#" --srt-burn "1" -o "#outputfile#';
  FParams := StringReplace(FParams, '#inputfile#', sourcefile, []);
  FParams := StringReplace(FParams, '#subtitlefile#', ChangeFileExt(sourcefile, '.srt'), []);
  FParams := StringReplace(FParams, '#outputfile#', outputFile, []);
  FParams := StringReplace(FParams, '#preset#', cbPreset.Text, []);
  Result := FParams;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin

  if odDialog.Execute then begin
    edtSource.Text := odDialog.FileName;
    edtOutput.Text := edtSource.Text + '\Legendado';
    LoadFiles();
  end;

end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
begin
if hbDialog.Execute then
  edtHandBreak.Text := hbDialog.FileName;

end;

procedure TfrmPrincipal.FixDirectory(outputFile: String);
begin
  if not DirectoryExists(ExtractFileDir(outputFile)) then
    CreateDir(ExtractFileDir(outputFile));
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  HandBreakPath := 'F:\OneDrive - Unesp\Área de Trabalho\Vidoe\HandBrakeCLI.exe';

end;

function TfrmPrincipal.GenerateOutputFile(InputFile: String): String;
var
  outputFile: String;
begin
  outputFile := InputFile;
  Delete(outputFile, 1, Length(edtSource.Text));
  outputFile := edtOutput.Text + outPutFile;
  result := outPutFile;

end;

procedure TfrmPrincipal.LoadFiles;
var
  S: TStringDynArray;
  I: Integer;
begin
  fileList.Clear;
  S := TDirectory.GetFiles(edtSource.Text, edtFiltro.Text ,TSearchOption.soAllDirectories);
  lblArquivosEncontrados.Caption := 'Arquivos Encontrados: ' + IntToStr(Length(S));
  for I := 0 to Length(S)-1 do begin
    fileList.Items.Add(S[i]);
  end;
  fileList.CheckAll(cbChecked);

end;

procedure TfrmPrincipal.PngBitBtn1Click(Sender: TObject);
var
  S: TStringDynArray;
  I: Integer;
  Params, outputFile: String;
begin
  S := TDirectory.GetFiles(edtSource.Text, edtFiltro.Text ,TSearchOption.soAllDirectories);
  for I := 0 to Length(S)-1 do begin
    outputFile := GenerateOutputFile(S[i]);
    Params := BuildParams(S[i], outputFile);
    FixDirectory(outputFile);
    ShellExecute(0, 'open', PChar(HandBreakPath), PChar(Params), nil, SW_HIDE);

   // Memo1.Lines.Add(S[i]);
   // Memo1.Lines.Add(GenerateOutputFile(S[i]));
  end;

end;

end.
