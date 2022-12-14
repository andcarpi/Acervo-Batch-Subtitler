object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Encoder de Legenda - AcervoCursos - Dev by @andcarpi'
  ClientHeight = 551
  ClientWidth = 620
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pbSourceLocation: TGroupBox
    Left = 8
    Top = 8
    Width = 608
    Height = 57
    Caption = 'Localiza'#231#227'o dos V'#237'deos'
    TabOrder = 0
    object btnLoadSourcePath: TButton
      Left = 572
      Top = 24
      Width = 31
      Height = 25
      Margins.Right = 5
      Caption = '...'
      TabOrder = 1
      OnClick = btnLoadSourcePathClick
    end
    object edtSource: TEdit
      Left = 7
      Top = 25
      Width = 565
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ReadOnly = True
      TabOrder = 0
    end
  end
  object gb: TGroupBox
    Left = 8
    Top = 71
    Width = 608
    Height = 57
    Caption = 'Salvar em'
    TabOrder = 1
    object btnLocalParaSalvar: TButton
      Left = 570
      Top = 23
      Width = 31
      Height = 25
      Margins.Right = 5
      Caption = '...'
      TabOrder = 1
      OnClick = btnLocalParaSalvarClick
    end
    object edtOutput: TEdit
      Left = 7
      Top = 24
      Width = 563
      Height = 23
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      ReadOnly = True
      TabOrder = 0
    end
  end
  object btnEncode: TPngBitBtn
    Left = 404
    Top = 495
    Width = 103
    Height = 45
    Caption = 'Codificar'
    Enabled = False
    TabOrder = 2
    OnClick = btnEncodeClick
    PngImage.Data = {
      89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
      F80000000473424954080808087C086488000000097048597300000B1200000B
      1201D2DD7EFC0000001C74455874536F6674776172650041646F626520466972
      65776F726B7320435336E8BCB28C000002EF4944415478DAD5955D48936114C7
      F7BECE4D37F7C1A030E9A29C8B8AE822900AFAB0BA904028823024BA280ABC48
      29236265500A0612481214AB9BA00B8B204A53C8CCAEBAA80B318C988451C490
      4AE6DCF767BF1333DAEB86B9E8C2070EE77DCE7BDEFFFFFCCF739E4DC96432BA
      FFB994654560B7DB2B53A994323737E7FB6702ABD5BA221E8FAF077017DB5A70
      36A7D3E9B5AAAA3E4826938D4B22B0582CAB1289C43A006AB19D846AF01BE55D
      4949C92345516E610672BAF01648AB0B120056299501B085775B0939F19BD81B
      019BD1EBF5270D06C39B7038DC44CCCDFB59AABE829F06BC91D8D1F2F2F2AA60
      30E8CB21B0D96CFA5028748F8443C48C24EB00BB0661572C1673442291DBBCDB
      47FC0580F785183B4ECC4AEC2B3686BD25F60A05E3C41339042693695B341A7D
      FDA7223E0860BDC4C2F8BD581DE6C326059002461C0EC7587373F3B4DBEDFE05
      E8F178D4BEBE3EDDF0F0703A87A0A2A2A20ED92FB52D1325541CE3F13BB6120B
      B3178200B926AAAD91CED2BE8FC44254BE9AE713143BA825D80DC1A846C167FA
      BD9FE4F7F4F502BE13F0676D6D6D07FBFBFBCD5EAF771082EDE4B5007C335BE4
      10394798A4C78B1250C9101F8B2A2740A7784E969696F60036CBBE9EF80EC03E
      9127E723D3735AD4505403E736509040DA52CC9AC7E26C1A18D985044CD12887
      3DC0F31D2AD29E459A4A0348B7B255B5E028D1F9FDFEC38C78132A1BF00509BA
      F1E7B50010A810D4433058480124E7C0EB5E4C412FBE250F8103F70390517ADC
      CABD18D7E650403BCAAF2EA6A010810DF7450E317B09DB5D2E57E7C4C4C40282
      621508C18CB48AF510B00E26E5DD921598CDE61BFC8EB4E6912F97EC39D55D02
      F869BE3320E722049D791500BC87311D292B2BEBA1BF67963AA2B2849CBBD081
      82032878A2255803F0148FDF68C35D2C91BD13929391BEE352787D763F1F57A8
      5A46D800F831BEAF321A8D1BC0FA9043200BE6B3245D2FF64F488A80E832EDE9
      F81DD38271164EE45553942A45FE0DF0FCED677CA738C7C91CD265F5A79F6FFD
      04C1E221EF845BF51A0000000049454E44AE426082}
  end
  object gpbFileList: TGroupBox
    Left = 8
    Top = 134
    Width = 608
    Height = 355
    Caption = 'Lista de Arquivos'
    TabOrder = 3
    OnClick = gpbFileListClick
    DesignSize = (
      608
      355)
    object lblArquivosEncontrados: TLabel
      Left = 424
      Top = 0
      Width = 177
      Height = 17
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Color = clBtnFace
      ParentColor = False
      Transparent = True
    end
    object FileList2: TListView
      Left = 7
      Top = 19
      Width = 594
      Height = 326
      Checkboxes = True
      Columns = <
        item
          Width = 22
        end
        item
          Caption = 'Arquivo'
          Width = 445
        end
        item
          Caption = 'Status'
          Width = 100
        end
        item
          Caption = 'output'
          Width = 0
        end>
      Groups = <
        item
          Header = 'Aguardando'
          GroupID = 0
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end
        item
          Header = 'Processando'
          GroupID = 1
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end
        item
          Header = 'Encerrado'
          GroupID = 2
          State = [lgsNormal]
          HeaderAlign = taLeftJustify
          FooterAlign = taLeftJustify
          TitleImage = -1
        end>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object btnClose: TPngBitBtn
    Left = 513
    Top = 495
    Width = 103
    Height = 45
    Caption = '&Sair'
    TabOrder = 4
    OnClick = btnCloseClick
    PngImage.Data = {
      89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
      F80000000473424954080808087C086488000000097048597300000B1200000B
      1201D2DD7EFC00000016744558744372656174696F6E2054696D650031312F33
      302F3232EF9895340000001C74455874536F6674776172650041646F62652046
      697265776F726B7320435336E8BCB28C0000020F4944415478DAB5963D4FC240
      1CC6EF008138AA1B144C598D894AFC0CBEE020E06EDC5C8C2CC64131C2AE260E
      4E26EE020E2AFA19547471040D94D1D9180AD4E7A08572A5A562B8E4C95DEFAE
      CFAF77FF7B295514855825C9EF9F40B609C5A059B5FA1DCA425742B5FA65F53E
      3503C05844B60D45A069C8C3FAEBBAFC4065E80EBA00A8641B00F324B203688C
      D84B75280D48CA12006317B21CB466D3984FB75014A0BA19800D777548732DDD
      03103100D46939FEA7B9968EB4E96A01601E40F9137218BA3A1C05D26C2EF4B5
      316F6B422220650D70828A04D7E99B389D3B42B97C2909C235519438679E112A
      950D2918DC228DC6396AC6B9F7CF0048D08ACFC7D6F91314EA69A6B4204852B8
      139F40E01A5F1BD79B77DA04E1051FC08FE4035A64803D14D290DB30504A3380
      E88DF2A823305FD1D51947D74E32946480020AF3A6E1A2340B483F03669E8179
      CC22D86F0C5023833614A58FD4ED5EF7974A6CF792AA287A1559BE81F912B14E
      B25DC003F578A2FE62B10D0885BC4AAD960360D90EE0158539D32E5C407BA648
      1F788B29DA4721D57714C6D592673962F2A7204F92F6321539F302CCC33AA36E
      40B9C0A3ED196D610ED05EA6EA463BC5C32ED7C17AA3A94B78E0465301419568
      3C2AB0E1FA6CA2416DBD47456B98A33CEC3A7339CAE35A058CF6C2D181D8741D
      422E9BC6F6AE4C0EC24E57EDD2678BC0CB7519FED2E74053A4FBDB32A356DBFE
      6DF905659B295E4CC710590000000049454E44AE426082}
  end
  object Status: TProgressBar
    Left = 63
    Top = 495
    Width = 335
    Height = 45
    TabOrder = 5
    Visible = False
  end
  object btnConfigurar: TPngBitBtn
    Left = 8
    Top = 495
    Width = 49
    Height = 45
    TabOrder = 6
    OnClick = btnConfigurarClick
    PngImage.Data = {
      89504E470D0A1A0A0000000D494844520000001800000012080600000041EC1E
      9E000000017352474200AECE1CE9000003EB4944415478DA63642002585B5887
      7370739CDFBB77EF2D5343E3665149F139DBB66D7B488C5E465C12D1D1D17C2F
      5EBC50001A7A49595EE13F1717E7252E4EAE236FDEBECD929490CC3972F2F854
      6B33CB9CA3A78E4F21CB02756595377FFEFC11C625CFC4C4F4E3DFBF7F1CEADA
      5AEA40DFDC22DA026F373763532BAB8B2B972E7BF2EBD72F7190181FBFC04209
      3191899CECEC1FDF7CF860F9EAC5ABEEDF7F7E4B82E4E4E4E5BC7FFCF82170FC
      D4A9654459A0A2A0F8EFFFFFFF6071760ECEEB0AB2D2E177EF3F38FAF7EF5F1E
      A0ABFF0069563E3EBE650202FCF31E3D7ABC07A64F425222F5E8891373085AE0
      E5EA6A72F3D6EDD32C2C2C1FC545C5D39EBF7CBE445553431514A90D0D0D2CF5
      F5F57F8DF5F5677EFDFA2D54525222F4F1E327BB816A3FDDBC7B879FA00F7435
      352FFEFEFD47E6F7EFDF427AC0B0BD74F5DA4D233353F6D5AB57FFCACDCD65DF
      B165EB17A0B2FF0626C6D2776EDC9CC0C4CCF2F5EB97CF0140F5A25CDC5CC765
      A5A5F3B6EDDE7D06A7056A4A4A5FFEFEFDC70D624B4B4AC77CFEF231BCB2AE2E
      302C2CEC2F482C2D2D8D75EFCE5DBF9899997F46C5C5F22C59B0F097A8B858D1
      AB172FFB191919FF898B89561C3D75AA1B6F1081922430AC7F090A0ACDFFFFEF
      CF596E5EDED7DFBE7CF53D75FE5CB29DB575D0D3274FD782D4C52626302F9EBF
      E0AF9898A4F5AB57CF8F8A8A8AB59D3873AA1A6F1069AB6BDC04A60835A06BFE
      4B4A4BA57DFDF4C55559432DE7DCA9D3AF5859593F0183820FAE565F4FE2D9C3
      C713D839D90FBE78FE623AD051BF813E283D72F2E4449C1668AAAABD07A6124E
      2066D7373652B878F6DC03904B376FDCD8F2E1DDFB4A74D7E96B69CA3E7DF5AA
      F2CD9BB7591C1C1C37A4A4245376EFDF7F146F10B93939D9DDBD7BEF201B1BDB
      737E01FE8E776FDFB5002D93D5D6D6FEFCE8D123EE4B172E44BE7FFB6E264CBD
      868EB6F287576F328F9E3E594A543E505554FA0DCCA12C20363737F761607A6F
      79FEFCC55660B0FD656462FA2E2C266AF0FBC70F5BA0C58B617AB43435CC3E7F
      FEFC5F544AEA3C30C5FDC56B013022BDC4A5A44E5F3C77FEEEDF3F7F7841A943
      4844B856494565311F0BCB9F07CF5E29FEFDF5EDCD97AF3F74DFBC7BB3065DBF
      A2A282ED9E03078EE0B400EE2A758D1B3F7FFC50C725AF2027ABFDEDE74F9357
      2F5F2D04F18149F73B30A2BF80CAAF3B0FEE3313B420D4C747EEE5FBF7264EAE
      AE1B80E9FD0F0B0BEB4B1666E673DF7F7CF7121313AD3B7EFA74B383AD43C2E3
      470FE6B3B0B27CB971FB361F28F569A9A9DFBC76EBA63A410B9081B9A9691D3F
      2FEF915DFBF6ED33D63758292C24D8B76BFFFE93B1B1B1DCC70E1DFEC2CECEFE
      0C68A83451914C2AB0B1B17178F9F4D96E7636F6E7576E5E974397070008F7B6
      22615D578C0000000049454E44AE426082}
  end
  object odDialog: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Title = 'Selecione o Diret'#243'rio'
    Left = 336
    Top = 224
  end
  object hbDialog: TOpenDialog
    FileName = 'handbreakcli.exe'
    Filter = 'HandBreakCLI|*.exe'
    Title = 'Localiza'#231#227'o do HandBreakCLI'
    Left = 256
    Top = 222
  end
  object timerCoding: TTimer
    Enabled = False
    Interval = 100
    OnTimer = timerCodingTimer
    Left = 408
    Top = 223
  end
  object timerCheckFinish: TTimer
    Enabled = False
    Interval = 100
    OnTimer = timerCheckFinishTimer
    Left = 480
    Top = 223
  end
end
