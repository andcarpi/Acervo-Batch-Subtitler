unit untConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.Samples.Spin, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmConfiguracoes = class(TForm)
    gpbArquivos: TGroupBox;
    cklFileTypes: TCheckListBox;
    gbOpcoes: TGroupBox;
    Label1: TLabel;
    edtHandBreak: TEdit;
    btnOpenCLI: TButton;
    btnHandBreakHelp: TButton;
    edtExtraFlags: TLabeledEdit;
    btnExtraFlagsHelp: TButton;
    GroupBox1: TGroupBox;
    cbPreset: TComboBox;
    GroupBox2: TGroupBox;
    cbSemLegenda: TComboBox;
    GroupBox3: TGroupBox;
    SpinEdit1: TSpinEdit;
    GroupBox4: TGroupBox;
    ComboBox1: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.dfm}

end.