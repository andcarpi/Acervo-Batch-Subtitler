object frmConfiguracoes: TfrmConfiguracoes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Configura'#231#245'es'
  ClientHeight = 515
  ClientWidth = 626
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object gpbArquivos: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 121
    Caption = 'Tipos de Arquivos para Input'
    TabOrder = 0
    object cklFileTypes: TCheckListBox
      Left = 7
      Top = 18
      Width = 242
      Height = 89
      Columns = 2
      ItemHeight = 17
      Items.Strings = (
        'MP4'
        'M4V'
        'MKV'
        'MOV'
        'MPG '
        'MPEG'
        'AVI'
        'WMV'
        'FLV'
        'WEBM')
      TabOrder = 0
    end
  end
  object gbOpcoes: TGroupBox
    Left = 8
    Top = 223
    Width = 608
    Height = 114
    Caption = 'HandBreak'
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 23
      Width = 90
      Height = 15
      Caption = 'Local do Arquivo'
    end
    object edtHandBreakPath: TEdit
      Left = 5
      Top = 40
      Width = 536
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ReadOnly = True
      TabOrder = 0
    end
    object btnOpenCLI: TButton
      Left = 542
      Top = 39
      Width = 31
      Height = 25
      Margins.Right = 5
      Caption = '...'
      TabOrder = 1
      OnClick = btnOpenCLIClick
    end
    object btnHandBreakHelp: TButton
      Left = 572
      Top = 39
      Width = 31
      Height = 25
      Margins.Right = 5
      Caption = '?'
      TabOrder = 2
      OnClick = btnHandBreakHelpClick
    end
    object edtHandBreakParams: TLabeledEdit
      Left = 5
      Top = 84
      Width = 566
      Height = 23
      EditLabel.Width = 60
      EditLabel.Height = 15
      EditLabel.Caption = 'Par'#226'metros'
      TabOrder = 3
      Text = 
        '-i "#inputfile#" -Z "#preset#" --srt-codeset utf-8 --srt-file "#' +
        'subtitlefile#" --srt-burn "1" -o "#outputfile#"'
    end
    object btnExtraFlagsHelp: TButton
      Left = 572
      Top = 83
      Width = 31
      Height = 25
      Margins.Right = 5
      Caption = '?'
      TabOrder = 4
      OnClick = btnExtraFlagsHelpClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 282
    Top = 8
    Width = 162
    Height = 57
    Hint = 'HandBrake Apenas'
    Caption = 'Preset de Qualidade'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object cbPreset: TComboBox
      Left = 16
      Top = 21
      Width = 130
      Height = 23
      Style = csDropDownList
      ItemIndex = 5
      TabOrder = 0
      Text = 'Fast 720p30'
      Items.Strings = (
        'Very Fast 1080p30'
        'Very Fast 720p30'
        'Very Fast 576p25'
        'Very Fast 480p30'
        'Fast 1080p30'
        'Fast 720p30'
        'Fast 576p25'
        'Fast 480p30'
        'HQ 1080p30 Surround'
        'HQ 720p30 Surround'
        'HQ 576p25 Surround'
        'HQ 480p30 Surround'
        'Super HQ 1080p30 Surround'
        'Super HQ 720p30 Surround'
        'Super HQ 576p25 Surround'
        'Super HQ 480p30 Surround')
    end
  end
  object GroupBox2: TGroupBox
    Left = 282
    Top = 71
    Width = 162
    Height = 58
    Caption = 'Arquivos Sem Legenda'
    TabOrder = 3
    object cbSemLegenda: TComboBox
      Left = 16
      Top = 21
      Width = 130
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Ignorar'
      Items.Strings = (
        'Ignorar'
        'Copiar'
        'Codificar Sem Legenda')
    end
  end
  object GroupBox3: TGroupBox
    Left = 454
    Top = 8
    Width = 162
    Height = 58
    Caption = 'Processos Simult'#226'neos'
    TabOrder = 4
    object spinProcessos: TSpinEdit
      Left = 16
      Top = 21
      Width = 130
      Height = 24
      MaxLength = 2
      MaxValue = 20
      MinValue = 1
      TabOrder = 0
      Value = 4
    end
  end
  object GroupBox4: TGroupBox
    Left = 454
    Top = 71
    Width = 162
    Height = 58
    Caption = 'Software'
    TabOrder = 5
    object cbSoftware: TComboBox
      Left = 16
      Top = 21
      Width = 130
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'HandBreakCLI'
      OnChange = cbSoftwareChange
      Items.Strings = (
        'HandBreakCLI'
        'FFMPEG')
    end
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 343
    Width = 608
    Height = 114
    Caption = 'FFMPEG'
    TabOrder = 6
    object Label2: TLabel
      Left = 7
      Top = 23
      Width = 90
      Height = 15
      Caption = 'Local do Arquivo'
    end
    object edtFFMpegPath: TEdit
      Left = 5
      Top = 40
      Width = 536
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ReadOnly = True
      TabOrder = 0
    end
    object Button1: TButton
      Left = 542
      Top = 39
      Width = 31
      Height = 25
      Margins.Right = 5
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 572
      Top = 39
      Width = 31
      Height = 25
      Margins.Right = 5
      Caption = '?'
      TabOrder = 2
      OnClick = Button2Click
    end
    object edtFFMpegParams: TLabeledEdit
      Left = 5
      Top = 84
      Width = 566
      Height = 23
      EditLabel.Width = 60
      EditLabel.Height = 15
      EditLabel.Caption = 'Par'#226'metros'
      TabOrder = 3
      Text = 
        '-i "#inputfile#" -c:v libx264 -crf 20 -movflags +faststart -vf s' +
        'ubtitles="#subtitlefile#" -c:a aac -b:a 160k -y "#outputfile#"'
    end
    object Button3: TButton
      Left = 572
      Top = 83
      Width = 31
      Height = 25
      Margins.Right = 5
      Caption = '?'
      TabOrder = 4
      OnClick = Button3Click
    end
  end
  object memParams: TMemo
    Left = 8
    Top = 135
    Width = 436
    Height = 83
    Lines.Strings = (
      
        'Nos par'#226'metros, s'#227'o aplicadas as substitui'#231#245'es dos valores a seg' +
        'uir:'
      '#inputfile# -  Recebe o nome do arquivo a ser processado'
      '#outputfile# - Recebe o arquivo de destino'
      '#subtitlefile# - Recebe o nome do arquivo de legenda'
      
        '#preset# - Recebe o preset seleciona na op'#231#227'o Preset de Qualidad' +
        'e')
    ReadOnly = True
    TabOrder = 7
  end
  object btnOK: TPngBitBtn
    Left = 508
    Top = 467
    Width = 103
    Height = 40
    Caption = 'OK'
    TabOrder = 8
    OnClick = btnOKClick
  end
  object VisualSwitch: TToggleSwitch
    Left = 129
    Top = 463
    Width = 101
    Height = 44
    AutoSize = False
    StateCaptions.CaptionOn = 'Escuro'
    StateCaptions.CaptionOff = 'Claro'
    SwitchHeight = 30
    SwitchWidth = 60
    TabOrder = 9
    ThumbColor = clBtnShadow
    ThumbWidth = 25
    OnClick = VisualSwitchClick
  end
  object btnRestore: TPngBitBtn
    Left = 8
    Top = 467
    Width = 107
    Height = 40
    Caption = 'Restaurar Padr'#245'es'
    TabOrder = 10
    OnClick = btnRestoreClick
  end
  object gbVisProcessos: TGroupBox
    Left = 456
    Top = 135
    Width = 162
    Height = 58
    Caption = 'Visualizar Processos'
    TabOrder = 11
    object cbVisualizar: TComboBox
      Left = 16
      Top = 21
      Width = 130
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'N'#227'o'
      OnChange = cbSoftwareChange
      Items.Strings = (
        'N'#227'o'
        'Sim')
    end
  end
  object hbDialog: TOpenDialog
    FileName = 'handbreakcli.exe'
    Filter = 'HandBreakCLI|*.exe'
    Title = 'Localiza'#231#227'o do HandBreakCLI'
    Left = 296
    Top = 142
  end
  object ffmpegDialog: TOpenDialog
    FileName = 'ffmpeg.exe'
    Filter = 'ffmpeg|ffmpeg.exe'
    Title = 'Localiza'#231#227'o do FFMPEG'
    Left = 392
    Top = 142
  end
end
