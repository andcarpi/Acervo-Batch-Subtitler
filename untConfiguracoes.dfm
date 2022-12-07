object frmConfiguracoes: TfrmConfiguracoes
  Left = 0
  Top = 0
  Caption = 'Configura'#231#245'es'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object gpbArquivos: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 121
    Caption = 'Tipos de Arquivos para Input'
    TabOrder = 0
    object cklFileTypes: TCheckListBox
      Left = 7
      Top = 18
      Width = 178
      Height = 89
      Columns = 2
      ItemHeight = 15
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
    Top = 135
    Width = 608
    Height = 162
    Caption = 'Linha de Comando'
    TabOrder = 1
    object Label1: TLabel
      Left = 7
      Top = 23
      Width = 215
      Height = 15
      Caption = 'Local do CLI (Handbreak, FFMPEG, etc...)'
    end
    object edtHandBreak: TEdit
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
    end
    object btnHandBreakHelp: TButton
      Left = 572
      Top = 39
      Width = 31
      Height = 25
      Margins.Right = 5
      Caption = '?'
      TabOrder = 2
    end
    object edtExtraFlags: TLabeledEdit
      Left = 5
      Top = 84
      Width = 566
      Height = 23
      EditLabel.Width = 60
      EditLabel.Height = 15
      EditLabel.Caption = 'Par'#226'metros'
      TabOrder = 3
      Text = 
        '-i "#inputfile#" -Z "#preset#" --srt-file "#subtitlefile#" --srt' +
        '-burn "1" -o "#outputfile#"'
    end
    object btnExtraFlagsHelp: TButton
      Left = 572
      Top = 83
      Width = 31
      Height = 25
      Margins.Right = 5
      Caption = '?'
      TabOrder = 4
    end
  end
  object GroupBox1: TGroupBox
    Left = 207
    Top = 8
    Width = 162
    Height = 57
    Caption = 'Preset de Qualidade'
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
    Left = 207
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
    Left = 375
    Top = 8
    Width = 162
    Height = 58
    Caption = 'Processos Simult'#226'neos'
    TabOrder = 4
    object SpinEdit1: TSpinEdit
      Left = 16
      Top = 21
      Width = 130
      Height = 24
      MaxLength = 2
      MaxValue = 0
      MinValue = 20
      TabOrder = 0
      Value = 4
    end
  end
  object GroupBox4: TGroupBox
    Left = 375
    Top = 71
    Width = 162
    Height = 58
    Caption = 'Software'
    TabOrder = 5
    object ComboBox1: TComboBox
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
end
