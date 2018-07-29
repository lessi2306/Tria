object TlnDialog: TTlnDialog
  Left = 65
  Top = 370
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Teilnehmerdaten'
  ClientHeight = 484
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClick = ZeitnahmeLabelClick
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object WettkLabel: TLabel
    Left = 15
    Top = 109
    Width = 59
    Height = 15
    HelpContext = 1408
    Caption = 'Wettkampf'
    FocusControl = WettkCB
    OnClick = WettkLabelClick
  end
  object MannschLabel: TLabel
    Left = 214
    Top = 59
    Width = 63
    Height = 15
    HelpContext = 1407
    Caption = 'Mannschaft'
    OnClick = MannschLabelClick
  end
  object JgLabel: TLabel
    Left = 532
    Top = 9
    Width = 31
    Height = 15
    HelpContext = 1403
    Caption = 'Jahrg.'
    FocusControl = JgEdit
    OnClick = JgLabelClick
  end
  object VNameLabel: TLabel
    Left = 214
    Top = 9
    Width = 47
    Height = 15
    HelpContext = 1401
    Caption = 'Vorname'
    FocusControl = VNameEdit
    OnClick = VNameLabelClick
  end
  object NameLabel: TLabel
    Left = 15
    Top = 9
    Width = 32
    Height = 15
    HelpContext = 1401
    Caption = 'Name'
    FocusControl = NameEdit
    OnClick = NameLabelClick
  end
  object SexLabel: TLabel
    Left = 416
    Top = 9
    Width = 58
    Height = 15
    HelpContext = 1402
    Caption = 'Geschlecht'
    FocusControl = SexCB
    OnClick = SexLabelClick
  end
  object AlterLabel: TLabel
    Left = 605
    Top = 9
    Width = 25
    Height = 15
    HelpContext = 1404
    Caption = 'Alter'
    OnClick = ZeitnahmeLabelClick
  end
  object VereinLabel: TLabel
    Left = 15
    Top = 59
    Width = 54
    Height = 15
    HelpContext = 1407
    Caption = 'Verein/Ort'
    OnClick = VereinLabelClick
  end
  object KlasseGB: TGroupBox
    Left = 414
    Top = 60
    Width = 218
    Height = 87
    HelpContext = 1405
    Caption = 'Klasseneinteilung'
    TabOrder = 17
    OnEnter = EingabeEnter
    object AkLabel: TLabel
      Left = 12
      Top = 32
      Width = 61
      Height = 15
      HelpContext = 1405
      Caption = 'Altersklasse'
      OnClick = ZeitnahmeLabelClick
    end
    object SondAkLabel: TLabel
      Left = 12
      Top = 59
      Width = 68
      Height = 15
      HelpContext = 1405
      Caption = 'Sonderklasse'
      OnClick = ZeitnahmeLabelClick
    end
    object AkEdit: TTriaEdit
      Left = 84
      Top = 29
      Width = 122
      Height = 21
      HelpContext = 1405
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
      Text = 'M'#228'nnl. Jugend B'
      OnEnter = EingabeEnter
      OnKeyDown = NavKeyDown
    end
    object SondAkEdit: TTriaEdit
      Left = 84
      Top = 56
      Width = 122
      Height = 21
      HelpContext = 1405
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
      Text = 'U23 weiblich'
      OnEnter = EingabeEnter
      OnKeyDown = NavKeyDown
    end
  end
  object OkButton: TButton
    Left = 389
    Top = 445
    Width = 75
    Height = 25
    HelpContext = 103
    Caption = 'OK'
    TabOrder = 13
    TabStop = False
    OnClick = OkButtonClick
    OnKeyDown = NavKeyDown
  end
  object CancelButton: TButton
    Left = 473
    Top = 445
    Width = 75
    Height = 25
    HelpContext = 102
    Caption = 'Abbrechen'
    TabOrder = 14
    TabStop = False
    OnClick = CancelButtonClick
    OnKeyDown = NavKeyDown
  end
  object WettkCB: TComboBox
    Left = 12
    Top = 124
    Width = 384
    Height = 23
    HelpContext = 1408
    AutoComplete = False
    Style = csDropDownList
    TabOrder = 5
    OnChange = EingabeChange
    OnEnter = EingabeEnter
    OnKeyDown = NavKeyDown
  end
  object JgEdit: TTriaMaskEdit
    Left = 529
    Top = 24
    Width = 40
    Height = 23
    HelpContext = 1403
    EditMask = '9999;0; '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    TabOrder = 3
    Text = '2009'
    OnChange = EingabeChange
    OnEnter = EingabeEnter
    OnKeyDown = NavKeyDown
    UpDown = JgUpDown
  end
  object VNameEdit: TTriaEdit
    Left = 211
    Top = 24
    Width = 185
    Height = 23
    HelpContext = 1401
    TabOrder = 1
    Text = '012345678901234'
    OnChange = EingabeChange
    OnEnter = EingabeEnter
    OnKeyDown = NavKeyDown
  end
  object NameEdit: TTriaEdit
    Left = 12
    Top = 24
    Width = 185
    Height = 23
    HelpContext = 1401
    TabOrder = 0
    Text = '01234567890123456789012'
    OnChange = EingabeChange
    OnEnter = EingabeEnter
    OnKeyDown = NavKeyDown
  end
  object AendButton: TButton
    Left = 301
    Top = 445
    Width = 79
    Height = 25
    HelpContext = 104
    Caption = #220'&bernehmen'
    TabOrder = 12
    TabStop = False
    OnClick = AendButtonClick
    OnKeyDown = NavKeyDown
  end
  object NextAnmButton: TButton
    Left = 46
    Top = 445
    Width = 119
    Height = 25
    HelpContext = 1409
    Caption = '&N'#228'chste Anmeldung'
    TabOrder = 7
    TabStop = False
    OnClick = NextAnmButtonClick
    OnKeyDown = NavKeyDown
  end
  object SexCB: TComboBox
    Left = 414
    Top = 24
    Width = 94
    Height = 23
    HelpContext = 1402
    AutoComplete = False
    Style = csDropDownList
    TabOrder = 2
    OnChange = EingabeChange
    OnEnter = EingabeEnter
    OnKeyDown = NavKeyDown
    Items.Strings = (
      'm'#228'nnlich'
      'weiblich')
  end
  object AlterEdit: TTriaEdit
    Left = 605
    Top = 24
    Width = 27
    Height = 23
    HelpContext = 1404
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 16
    Text = ' 99'
    OnEnter = EingabeEnter
    OnKeyDown = NavKeyDown
  end
  object HilfeButton: TButton
    Left = 557
    Top = 445
    Width = 75
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 15
    TabStop = False
    OnClick = HilfeButtonClick
    OnKeyDown = NavKeyDown
  end
  object TlnFirstBtn: TBitBtn
    Left = 12
    Top = 445
    Width = 25
    Height = 25
    Hint = 'zum Anfang'
    HelpContext = 1410
    Glyph.Data = {
      AA040000424DAA04000000000000360000002800000013000000130000000100
      18000000000074040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080000000FFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF808080000000000000000000FFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      808080000000000000000000000000000000FFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF80808000000000000000
      0000000000000000000000000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      000000000000FFFFFFFFFFFF8080800000000000000000000000000000000000
      00000000000000000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF00000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFF
      FFFFFFFF80808000000000000000000000000000000000000000000000000000
      0000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFF
      FFFFFFFFFFFF808080000000000000000000000000000000000000000000FFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF808080000000000000000000000000000000FFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFF808080000000000000000000FFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF808080000000FFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000}
    TabOrder = 8
    TabStop = False
    OnClick = TlnFirstBtnClick
    OnKeyDown = NavKeyDown
  end
  object TlnBackBtn: TBitBtn
    Left = 37
    Top = 445
    Width = 25
    Height = 25
    Hint = 'zur'#252'ck'
    HelpContext = 1410
    Glyph.Data = {
      AA040000424DAA04000000000000360000002800000013000000130000000100
      18000000000074040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080000000FFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF808080000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080
      000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80808000000000000000000000
      0000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF8080800000000000000000000000000000000000000000
      00000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFF000000000000000000000000000000000000000000000000000000000000
      000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FF808080000000000000000000000000000000000000000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF808080000000000000000000000000000000000000000000FFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFF808080000000000000000000000000000000FFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF808080000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF808080000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000}
    TabOrder = 9
    TabStop = False
    OnClick = TlnBackBtnClick
    OnKeyDown = NavKeyDown
  end
  object TlnNextBtn: TBitBtn
    Left = 62
    Top = 445
    Width = 25
    Height = 25
    Hint = 'weiter'
    HelpContext = 1410
    Glyph.Data = {
      AA040000424DAA04000000000000360000002800000013000000130000000100
      18000000000074040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF000000808080FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000808080FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000808080
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000080
      8080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFF0000000000000000000000000000000000000000000000000000
      00808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFF000000000000000000000000000000000000000000000000000000000000
      000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF0000
      00000000000000000000000000000000000000000000000000808080FFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
      000000000000000000000000000000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000
      0000000000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000808080FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFF000000808080FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000}
    TabOrder = 10
    TabStop = False
    OnClick = TlnNextBtnClick
    OnKeyDown = NavKeyDown
  end
  object TlnlastBtn: TBitBtn
    Left = 87
    Top = 445
    Width = 25
    Height = 25
    Hint = 'zum Ende'
    HelpContext = 1410
    Glyph.Data = {
      AA040000424DAA04000000000000360000002800000013000000130000000100
      18000000000074040000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000808080FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFF000000000000000000808080FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFF000000000000000000000000000000808080FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFF000000000000000000000000000000000000000000808080FF
      FFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFF0000000000000000000000000000000000000000000000000000008080
      80FFFFFFFFFFFF000000000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00
      0000000000000000000000000000000000000000000000000000000000000000
      FFFFFF000000000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF0000000000
      00000000000000000000000000000000000000000000808080FFFFFFFFFFFF00
      0000000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000000000000000
      000000000000000000000000808080FFFFFFFFFFFFFFFFFFFFFFFF0000000000
      00FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00000000000000000000000000
      0000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFF000000000000000000808080FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFF000000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000}
    TabOrder = 11
    TabStop = False
    OnClick = TlnLastBtnClick
    OnKeyDown = NavKeyDown
  end
  object JgUpDown: TTriaUpDown
    Left = 569
    Top = 24
    Width = 16
    Height = 24
    TabOrder = 18
    OnClick = JgUpDownClick
    OnEnter = EingabeEnter
  end
  object TlnPageControl: TPageControl
    Left = 12
    Top = 168
    Width = 624
    Height = 262
    ActivePage = EinteilungTS
    TabOrder = 6
    TabStop = False
    OnChange = TlnPageControlChange
    OnChanging = TlnPageControlChanging
    OnEnter = EingabeEnter
    object AnmeldungTS: TTabSheet
      Caption = 'Anmeldung'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object AdresseGB: TGroupBox
        Left = 12
        Top = 15
        Width = 282
        Height = 204
        Caption = 'Adresse'
        TabOrder = 0
        object StrasseLabel: TLabel
          Left = 15
          Top = 22
          Width = 33
          Height = 15
          HelpContext = 1602
          Caption = 'Stra'#223'e'
          FocusControl = StrasseEdit
          OnClick = StrasseLabelClick
        end
        object PLZLabel: TLabel
          Left = 15
          Top = 65
          Width = 20
          Height = 15
          HelpContext = 1602
          Caption = 'PLZ'
          FocusControl = PLZEdit
          OnClick = PLZLabelClick
        end
        object HausNrLabel: TLabel
          Left = 235
          Top = 22
          Width = 16
          Height = 15
          HelpContext = 1602
          Caption = 'Nr.'
          FocusControl = HausNrEdit
          OnClick = HausNrLabelClick
        end
        object OrtLabel: TLabel
          Left = 79
          Top = 65
          Width = 17
          Height = 15
          HelpContext = 1602
          Caption = 'Ort'
          FocusControl = OrtEdit
          OnClick = OrtLabelClick
        end
        object EMailLabel: TLabel
          Left = 15
          Top = 108
          Width = 34
          Height = 15
          HelpContext = 1602
          Caption = 'E-Mail'
          FocusControl = EMailEdit
          OnClick = EMailLabelClick
        end
        object SMldLabel: TLabel
          Left = 15
          Top = 151
          Width = 85
          Height = 15
          HelpContext = 1601
          Caption = 'Vereinsmeldung'
          FocusControl = SMldCB
          OnClick = SMldLabelClick
        end
        object StrasseEdit: TTriaEdit
          Left = 12
          Top = 37
          Width = 212
          Height = 21
          HelpContext = 1602
          TabOrder = 0
          Text = '012345678901234567890123456789'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object PLZEdit: TTriaEdit
          Left = 12
          Top = 80
          Width = 56
          Height = 21
          HelpContext = 1602
          TabOrder = 2
          Text = 'D-700000'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object HausNrEdit: TTriaEdit
          Left = 232
          Top = 37
          Width = 38
          Height = 21
          HelpContext = 1602
          TabOrder = 1
          Text = '01234'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object OrtEdit: TTriaEdit
          Left = 76
          Top = 80
          Width = 194
          Height = 21
          HelpContext = 1602
          TabOrder = 3
          Text = '012345678901234567890123456789'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object EMailEdit: TTriaEdit
          Left = 12
          Top = 123
          Width = 258
          Height = 21
          HelpContext = 1602
          TabOrder = 4
          Text = 'tria@selten.de'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object SMldCB: TComboBox
          Left = 12
          Top = 166
          Width = 258
          Height = 23
          HelpContext = 1601
          AutoComplete = False
          Style = csDropDownList
          DropDownCount = 16
          TabOrder = 5
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
      end
      object AllgemeinGB: TGroupBox
        Left = 307
        Top = 15
        Width = 293
        Height = 204
        Caption = 'Allgemein'
        TabOrder = 1
        object MldZeitLabel: TLabel
          Left = 159
          Top = 22
          Width = 51
          Height = 15
          HelpContext = 1603
          Caption = 'Meldezeit'
          FocusControl = MldZeitEdit
          OnClick = MldZeitLabelClick
        end
        object MldZeitLabel2: TLabel
          Left = 230
          Top = 40
          Width = 52
          Height = 15
          Caption = 'hh:mm:ss'
        end
        object LandLabel: TLabel
          Left = 15
          Top = 22
          Width = 26
          Height = 15
          HelpContext = 1606
          Caption = 'Land'
          FocusControl = LandEdit
          ShowAccelChar = False
          OnClick = LandLabelClick
        end
        object StartgeldLabel: TLabel
          Left = 15
          Top = 65
          Width = 47
          Height = 15
          HelpContext = 602
          Caption = 'Startgeld'
          FocusControl = StartgeldEdit
          OnClick = StartgeldLabelClick
        end
        object StartgeldLabel2: TLabel
          Left = 72
          Top = 83
          Width = 21
          Height = 15
          Caption = 'EUR'
        end
        object KommentLabel: TLabel
          Left = 15
          Top = 151
          Width = 63
          Height = 15
          HelpContext = 1602
          Caption = 'Kommentar'
          FocusControl = KommentEdit
          OnClick = KommentLabelClick
        end
        object RfidCodeLabel: TLabel
          Left = 15
          Top = 108
          Width = 176
          Height = 15
          Caption = 'RFID Chip Code (10 Hex-Zeichen)'
          FocusControl = RfidCodeEdit
          OnClick = RfidCodeLabelClick
        end
        object MldZeitEdit: TStundenZeitEdit
          Left = 156
          Top = 37
          Width = 72
          Height = 21
          HelpContext = 1603
          EditMask = '!90:00:00;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 8
          ParentFont = False
          TabOrder = 1
          Text = '00:00:00'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object LandEdit: TTriaEdit
          Left = 12
          Top = 37
          Width = 38
          Height = 21
          HelpContext = 1604
          MaxLength = 4
          TabOrder = 0
          Text = 'abcd'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object StartgeldEdit: TTriaMaskEdit
          Left = 12
          Top = 80
          Width = 56
          Height = 21
          HelpContext = 1605
          EditMask = '!990,00;0;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 6
          ParentFont = False
          TabOrder = 2
          Text = '00000'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object RfidCodeEdit: TTriaEdit
          Left = 12
          Top = 123
          Width = 271
          Height = 21
          HelpContext = 1606
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = 'mmmmmmmmmmmmmmmmmmmmmmmm'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object KommentEdit: TTriaEdit
          Left = 12
          Top = 166
          Width = 271
          Height = 21
          HelpContext = 1607
          TabOrder = 4
          Text = '01234567890123456789012345'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
      end
    end
    object OptionenTS: TTabSheet
      Caption = 'Optionen'
      ImageIndex = 9
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object AllgOptionGB: TGroupBox
        Left = 434
        Top = 76
        Width = 162
        Height = 128
        Caption = 'Allgemein'
        TabOrder = 2
        OnClick = EingabeChange
        object UrkDruckCB: TCheckBox
          Left = 12
          Top = 33
          Width = 139
          Height = 17
          HelpContext = 1624
          Caption = 'Urkunde drucken'
          TabOrder = 0
          OnClick = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
      end
      object AusKonkGB: TGroupBox
        Left = 217
        Top = 76
        Width = 200
        Height = 128
        Caption = 'Au'#223'er Konkurrenz (a.K.)'
        TabOrder = 1
        OnClick = EingabeChange
        object AusKonkAllgCB: TCheckBox
          Left = 12
          Top = 33
          Width = 166
          Height = 17
          HelpContext = 1625
          Caption = 'Alle Einzelwertungen'
          TabOrder = 0
          OnClick = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object AusKonkAltKlCB: TCheckBox
          Left = 12
          Top = 66
          Width = 170
          Height = 17
          HelpContext = 1625
          Caption = 'Altersklassen-Einzelwertung'
          TabOrder = 1
          OnClick = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object AusKonkSondKlCB: TCheckBox
          Left = 12
          Top = 99
          Width = 174
          Height = 17
          HelpContext = 1625
          Caption = 'Sonderklassen-Einzelwertung'
          TabOrder = 2
          OnClick = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
      end
      object WrtgGB: TGroupBox
        Left = 16
        Top = 43
        Width = 184
        Height = 161
        Caption = 'Wertungen'
        TabOrder = 0
        object MschWrtgCB: TCheckBox
          Left = 12
          Top = 33
          Width = 139
          Height = 17
          HelpContext = 1621
          Caption = 'Mannschaftswertung'
          TabOrder = 0
          OnClick = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object MixMschCB: TCheckBox
          Left = 12
          Top = 66
          Width = 138
          Height = 17
          HelpContext = 1626
          Caption = 'Mixed Mannschaft'
          TabOrder = 1
          OnClick = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object SondWrtgCB: TCheckBox
          Left = 12
          Top = 99
          Width = 139
          Height = 17
          HelpContext = 1622
          Caption = 'Sonderwertung'
          TabOrder = 2
          OnClick = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object SerWrtgCB: TCheckBox
          Left = 12
          Top = 132
          Width = 138
          Height = 17
          HelpContext = 1623
          Caption = 'Serienwertung'
          TabOrder = 3
          OnClick = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
      end
    end
    object StaffelTS: TTabSheet
      Caption = 'Staffel'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Tln1NameLabel: TLabel
        Left = 206
        Top = 37
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '1'
        FocusControl = Tln1NameEdit
        OnClick = NameLabelClick
      end
      object Tln1VNameLabel: TLabel
        Left = 449
        Top = 38
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '1'
        FocusControl = Tln1VNameEdit
        OnClick = VNameLabelClick
      end
      object Tln2NameLabel: TLabel
        Left = 206
        Top = 59
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '2'
        FocusControl = Tln2NameEdit
        OnClick = NameLabelClick
      end
      object Tln2VNameLabel: TLabel
        Left = 449
        Top = 59
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '2'
        FocusControl = Tln2VNameEdit
        OnClick = VNameLabelClick
      end
      object Tln3NameLabel: TLabel
        Left = 206
        Top = 81
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '3'
        FocusControl = Tln3NameEdit
        OnClick = NameLabelClick
      end
      object Tln3VNameLabel: TLabel
        Left = 449
        Top = 81
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '3'
        FocusControl = Tln3VNameEdit
        OnClick = VNameLabelClick
      end
      object Tln4NameLabel: TLabel
        Left = 206
        Top = 103
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '4'
        FocusControl = Tln4NameEdit
        OnClick = NameLabelClick
      end
      object Tln4VNameLabel: TLabel
        Left = 449
        Top = 103
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '4'
        FocusControl = Tln4VNameEdit
        OnClick = VNameLabelClick
      end
      object Tln8NameLabel: TLabel
        Left = 206
        Top = 202
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '8'
        FocusControl = Tln8NameEdit
        OnClick = NameLabelClick
      end
      object Tln8VNameLabel: TLabel
        Left = 449
        Top = 202
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '8'
        FocusControl = Tln8VNameEdit
        OnClick = VNameLabelClick
      end
      object Tln5NameLabel: TLabel
        Left = 206
        Top = 136
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '5'
        FocusControl = Tln5NameEdit
        OnClick = NameLabelClick
      end
      object Tln5VNameLabel: TLabel
        Left = 449
        Top = 136
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '5'
        FocusControl = Tln5VNameEdit
        OnClick = VNameLabelClick
      end
      object Tln6VNameLabel: TLabel
        Left = 449
        Top = 158
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '6'
        FocusControl = Tln6VNameEdit
        OnClick = VNameLabelClick
      end
      object Tln6NameLabel: TLabel
        Left = 206
        Top = 158
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '6'
        FocusControl = Tln6NameEdit
        OnClick = NameLabelClick
      end
      object Tln7NameLabel: TLabel
        Left = 206
        Top = 180
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '7'
        FocusControl = Tln7NameEdit
        OnClick = NameLabelClick
      end
      object Tln7VNameLabel: TLabel
        Left = 449
        Top = 180
        Width = 8
        Height = 15
        HelpContext = 1401
        AutoSize = False
        Caption = '7'
        FocusControl = Tln7VNameEdit
        OnClick = VNameLabelClick
      end
      object StTlnNameLabel: TLabel
        Left = 218
        Top = 19
        Width = 32
        Height = 15
        Caption = 'Name'
      end
      object StTlnVNameLabel: TLabel
        Left = 461
        Top = 19
        Width = 47
        Height = 15
        Caption = 'Vorname'
      end
      object Text1Label: TLabel
        Left = 12
        Top = 107
        Width = 137
        Height = 15
        Caption = 'Ein Staffel-Teilnehmer pro'
      end
      object Text2Label: TLabel
        Left = 12
        Top = 128
        Width = 119
        Height = 15
        Caption = 'Wettkampf-Abschnittt'
      end
      object Tln1NameEdit: TTriaEdit
        Left = 215
        Top = 34
        Width = 169
        Height = 21
        HelpContext = 1651
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 12
        Text = '01234567890123456789012'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln1VNameEdit: TTriaEdit
        Left = 458
        Top = 34
        Width = 121
        Height = 21
        HelpContext = 1651
        TabStop = False
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 15
        Text = '012345678901234'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln2NameEdit: TTriaEdit
        Left = 215
        Top = 56
        Width = 169
        Height = 21
        HelpContext = 1652
        TabOrder = 0
        Text = '01234567890123456789012'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln2VNameEdit: TTriaEdit
        Left = 458
        Top = 56
        Width = 121
        Height = 21
        HelpContext = 1652
        TabOrder = 1
        Text = '012345678901234'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln3NameEdit: TTriaEdit
        Left = 215
        Top = 78
        Width = 169
        Height = 21
        HelpContext = 1652
        TabOrder = 2
        Text = '01234567890123456789012'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln3VNameEdit: TTriaEdit
        Left = 458
        Top = 78
        Width = 121
        Height = 21
        HelpContext = 1652
        TabOrder = 3
        Text = '012345678901234'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln4NameEdit: TTriaEdit
        Left = 215
        Top = 100
        Width = 169
        Height = 21
        HelpContext = 1652
        TabOrder = 4
        Text = '01234567890123456789012'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln4VNameEdit: TTriaEdit
        Left = 458
        Top = 100
        Width = 121
        Height = 21
        HelpContext = 1652
        TabOrder = 5
        Text = '012345678901234'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln8NameEdit: TTriaEdit
        Left = 215
        Top = 199
        Width = 169
        Height = 21
        HelpContext = 1652
        TabOrder = 13
        Text = '01234567890123456789012'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln8VNameEdit: TTriaEdit
        Left = 458
        Top = 199
        Width = 121
        Height = 21
        HelpContext = 1652
        TabOrder = 14
        Text = '012345678901234'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln5NameEdit: TTriaEdit
        Left = 215
        Top = 133
        Width = 169
        Height = 21
        HelpContext = 1651
        TabOrder = 6
        Text = '01234567890123456789012'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln5VNameEdit: TTriaEdit
        Left = 458
        Top = 133
        Width = 121
        Height = 21
        HelpContext = 1651
        TabOrder = 7
        Text = '012345678901234'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln6VNameEdit: TTriaEdit
        Left = 458
        Top = 155
        Width = 121
        Height = 21
        HelpContext = 1652
        TabOrder = 9
        Text = '012345678901234'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln6NameEdit: TTriaEdit
        Left = 215
        Top = 155
        Width = 169
        Height = 21
        HelpContext = 1652
        TabOrder = 8
        Text = '01234567890123456789012'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln7NameEdit: TTriaEdit
        Left = 215
        Top = 177
        Width = 169
        Height = 21
        HelpContext = 1652
        TabOrder = 10
        Text = '01234567890123456789012'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Tln7VNameEdit: TTriaEdit
        Left = 458
        Top = 177
        Width = 121
        Height = 21
        HelpContext = 1652
        TabOrder = 11
        Text = '012345678901234'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
    end
    object EinteilungTS: TTabSheet
      Caption = 'Einteilung'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SGrpGridLabel: TLabel
        Left = 15
        Top = 9
        Width = 62
        Height = 15
        HelpContext = 1701
        Caption = 'Startgruppe'
        FocusControl = SGrpGrid
        OnClick = SGrpGridLabelClick
      end
      object SBhnLabel: TLabel
        Left = 331
        Top = 9
        Width = 51
        Height = 15
        HelpContext = 1702
        Caption = 'Startbahn'
        FocusControl = SBhnGrid
        OnClick = SBhnLabelClick
      end
      object SnrLabel: TLabel
        Left = 461
        Top = 9
        Width = 70
        Height = 15
        HelpContext = 1703
        Caption = 'Startnummer'
        FocusControl = SnrEdit
        OnClick = SnrLabelClick
      end
      object SGrpGrid: TTriaGrid
        Left = 12
        Top = 24
        Width = 300
        Height = 197
        HelpContext = 1701
        ColCount = 5
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 12
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssBoth
        TabOrder = 0
        OnClick = EingabeChange
        OnDrawCell = SGrpGridDrawCell
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
        ColWidths = (
          61
          44
          42
          47
          64)
      end
      object SnrEdit: TTriaMaskEdit
        Left = 461
        Top = 24
        Width = 70
        Height = 22
        HelpContext = 1703
        EditMask = '9999;0; '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 2
        Text = '0'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object SBhnGrid: TStringGrid
        Left = 326
        Top = 24
        Width = 117
        Height = 197
        HelpContext = 1702
        ColCount = 2
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 12
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssVertical
        TabOrder = 1
        OnClick = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
        ColWidths = (
          47
          62)
      end
      object SnrGrid: TStringGrid
        Left = 461
        Top = 45
        Width = 70
        Height = 176
        HelpContext = 1703
        ColCount = 1
        DefaultColWidth = 68
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 12
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssVertical
        TabOrder = 3
        OnClick = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
    end
    object StrafenTS: TTabSheet
      Caption = 'Zusatzangaben'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ZeitStrafeGB: TGroupBox
        Left = 14
        Top = 76
        Width = 328
        Height = 54
        Caption = 'Zeitstrafe'
        TabOrder = 1
        object ZeitStrafeLabel: TLabel
          Left = 283
          Top = 24
          Width = 35
          Height = 15
          HelpContext = 2001
          Caption = 'mm:ss'
        end
        object ZeitStrafeCB: TCheckBox
          Left = 14
          Top = 24
          Width = 213
          Height = 17
          HelpContext = 2001
          Caption = 'Teilnehmer erh'#228'lt eine Zeitstrafe von'
          TabOrder = 0
          OnClick = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object ZeitStrafeEdit: TMinZeitEdit
          Left = 233
          Top = 21
          Width = 47
          Height = 21
          HelpContext = 2001
          EditMask = '!90:00;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          TabOrder = 1
          Text = '00:00'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
      end
      object DisqGB: TGroupBox
        Left = 14
        Top = 140
        Width = 584
        Height = 81
        Caption = 'Disqualifikation'
        TabOrder = 2
        object DisqNameLabel: TLabel
          Left = 160
          Top = 51
          Width = 68
          Height = 15
          HelpContext = 2002
          Caption = 'Bezeichnung'
          OnClick = DisqNameLabelClick
        end
        object DisqCheckBox: TCheckBox
          Left = 14
          Top = 24
          Width = 217
          Height = 17
          HelpContext = 2002
          Caption = 'Teilnehmer wird disqualifiziert wegen'
          TabOrder = 0
          OnClick = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object DisqGrundEdit: TEdit
          Left = 233
          Top = 21
          Width = 335
          Height = 23
          HelpContext = 2002
          AutoSelect = False
          TabOrder = 1
          Text = '0123456789012345678901234'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
        object DisqNameEdit: TEdit
          Left = 233
          Top = 48
          Width = 46
          Height = 21
          HelpContext = 2002
          AutoSelect = False
          AutoSize = False
          MaxLength = 4
          TabOrder = 2
          Text = 'wwww'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
      end
      object ZeitGutschrGB: TGroupBox
        Left = 14
        Top = 12
        Width = 328
        Height = 54
        Caption = 'Zeitgutschrift'
        TabOrder = 0
        object ZeitGutschrLabel2: TLabel
          Left = 283
          Top = 24
          Width = 35
          Height = 15
          HelpContext = 2003
          Caption = 'mm:ss'
          OnClick = ZeitGutschrLabelClick
        end
        object ZeitGutschrLabel: TLabel
          Left = 12
          Top = 24
          Width = 214
          Height = 15
          HelpContext = 2003
          Caption = 'Teilnehmer erh'#228'lt eine Zeitgutschrift von'
          OnClick = ZeitGutschrLabelClick
        end
        object ZeitGutschrEdit: TMinZeitEdit
          Left = 233
          Top = 21
          Width = 47
          Height = 21
          HelpContext = 2003
          EditMask = '!90:00;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          Text = '00:00'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
      end
      object ReststreckeGB: TGroupBox
        Left = 357
        Top = 12
        Width = 241
        Height = 54
        Caption = 'Stundenrennen'
        TabOrder = 3
        object ReststreckeLabel2: TLabel
          Left = 132
          Top = 24
          Width = 11
          Height = 15
          HelpContext = 2004
          Caption = 'm'
          OnClick = ReststreckeLabelClick
        end
        object ReststreckeLabel1: TLabel
          Left = 17
          Top = 24
          Width = 59
          Height = 15
          HelpContext = 2004
          Caption = 'Reststrecke'
          OnClick = ReststreckeLabelClick
        end
        object ReststreckeEdit: TTriaMaskEdit
          Left = 81
          Top = 21
          Width = 48
          Height = 22
          HelpContext = 2004
          EditMask = '09999;0; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
          Text = '0'
          OnChange = EingabeChange
          OnEnter = EingabeEnter
          OnKeyDown = NavKeyDown
        end
      end
    end
    object Zeitnahme1TS: TTabSheet
      Caption = 'Zeitnahme 1-4'
      ImageIndex = 2
      OnEnter = EingabeEnter
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object StartZeit1Label: TLabel
        Left = 5
        Top = 53
        Width = 51
        Height = 15
        Caption = 'Startzeit*)'
      end
      object Zeitnahme1Label: TLabel
        Left = 5
        Top = 97
        Width = 58
        Height = 15
        Caption = 'Stoppzeit*)'
      end
      object Abs1Label: TLabel
        Left = 68
        Top = 35
        Width = 94
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Abschn. 1'
        FocusControl = Abs1ZeitEdit
        ShowAccelChar = False
        OnClick = AbsLabelClick
      end
      object Abs2Label: TLabel
        Left = 179
        Top = 35
        Width = 94
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Abschn. 2'
        FocusControl = Abs2ZeitEdit
        ShowAccelChar = False
        OnClick = AbsLabelClick
      end
      object Abs3Label: TLabel
        Left = 290
        Top = 35
        Width = 94
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Abschn. 3'
        FocusControl = Abs3ZeitEdit
        ShowAccelChar = False
        OnClick = AbsLabelClick
      end
      object EndZeit1Label: TLabel
        Left = 514
        Top = 144
        Width = 94
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Endzeit'
        OnClick = ZeitnahmeLabelClick
      end
      object DisqStatus1Label: TLabel
        Left = 514
        Top = 182
        Width = 94
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '(disqualifiziert)'
        OnClick = ZeitnahmeLabelClick
      end
      object StrafZeit1Label: TLabel
        Left = 514
        Top = 79
        Width = 94
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Strafzeit'
        OnClick = ZeitnahmeLabelClick
      end
      object Loesch1Label2: TLabel
        Left = 20
        Top = 210
        Width = 416
        Height = 15
        Caption = 
          'der Entf-Taste oder Leertaste gel'#246'scht werden (00:00:00 ist eine' +
          ' g'#252'ltige Uhrzeit).'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = ZeitnahmeLabelClick
      end
      object Abs4Label: TLabel
        Left = 401
        Top = 35
        Width = 94
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Abschn. 4'
        FocusControl = Abs4ZeitEdit
        ShowAccelChar = False
        OnClick = AbsLabelClick
      end
      object Loesch1Label1: TLabel
        Left = 5
        Top = 196
        Width = 461
        Height = 15
        Caption = 
          '*)  Start- und Stoppzeiten werden grunds'#228'tzlich als Uhrzeiten be' +
          'trachtet. Sie k'#246'nnen mit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = ZeitnahmeLabelClick
      end
      object Ergebnis1Label: TLabel
        Left = 5
        Top = 156
        Width = 61
        Height = 15
        Caption = 'Abschnitts-'
      end
      object Gutschrift1Label: TLabel
        Left = 514
        Top = 35
        Width = 94
        Height = 15
        HelpContext = 1821
        Alignment = taCenter
        AutoSize = False
        Caption = 'Zeitgutschrift'
        OnClick = ZeitnahmeLabelClick
      end
      object Runden1Label: TLabel
        Left = 5
        Top = 119
        Width = 41
        Height = 15
        Caption = 'Runden'
      end
      object Zeit1Label: TLabel
        Left = 5
        Top = 167
        Width = 56
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'zeit'
      end
      object Abs4Grid: TTriaGrid
        Left = 356
        Top = 115
        Width = 201
        Height = 117
        HelpContext = 1822
        ColCount = 3
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 8
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssBoth
        TabOrder = 18
        Visible = False
        OnClick = AbsGridClick
        OnDrawCell = AbsGridDrawCell
        OnEnter = EingabeEnter
        ColWidths = (
          42
          82
          64)
      end
      object Abs3Grid: TTriaGrid
        Left = 253
        Top = 115
        Width = 201
        Height = 117
        HelpContext = 1822
        ColCount = 3
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 8
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssBoth
        TabOrder = 17
        Visible = False
        OnClick = AbsGridClick
        OnDrawCell = AbsGridDrawCell
        OnEnter = EingabeEnter
        ColWidths = (
          42
          82
          64)
      end
      object Abs2Grid: TTriaGrid
        Left = 135
        Top = 115
        Width = 201
        Height = 117
        HelpContext = 1822
        ColCount = 3
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 8
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssBoth
        TabOrder = 16
        Visible = False
        OnClick = AbsGridClick
        OnDrawCell = AbsGridDrawCell
        OnEnter = EingabeEnter
        ColWidths = (
          42
          82
          64)
      end
      object Abs1Grid: TTriaGrid
        Left = 25
        Top = 115
        Width = 201
        Height = 117
        HelpContext = 1822
        ColCount = 3
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 8
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssBoth
        TabOrder = 15
        Visible = False
        OnClick = AbsGridClick
        OnDrawCell = AbsGridDrawCell
        OnEnter = EingabeEnter
        ColWidths = (
          42
          82
          64)
      end
      object Abs1ErgEdit: TTriaEdit
        Left = 68
        Top = 159
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs2ErgEdit: TTriaEdit
        Left = 179
        Top = 159
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs3ErgEdit: TTriaEdit
        Left = 290
        Top = 159
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object EndZeit1Edit: TTriaEdit
        Left = 514
        Top = 159
        Width = 94
        Height = 21
        HelpContext = 1811
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs1ZeitEdit: TUhrZeitEdit
        Left = 68
        Top = 94
        Width = 94
        Height = 21
        HelpContext = 1804
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 1
        Text = '00:00:00,00'
        OnChange = EingabeChange
        OnClick = AbsZeitEditClick
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs2ZeitEdit: TUhrZeitEdit
        Left = 179
        Top = 94
        Width = 94
        Height = 21
        HelpContext = 1804
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 2
        Text = '00:00:00,00'
        OnChange = EingabeChange
        OnClick = AbsZeitEditClick
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs3ZeitEdit: TUhrZeitEdit
        Left = 290
        Top = 94
        Width = 94
        Height = 21
        HelpContext = 1804
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 3
        Text = '00:00:00,00'
        OnChange = EingabeChange
        OnClick = AbsZeitEditClick
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object StrafZeit1Edit: TTriaEdit
        Left = 514
        Top = 94
        Width = 94
        Height = 21
        HelpContext = 1807
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        Text = '   00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs4ZeitEdit: TUhrZeitEdit
        Left = 401
        Top = 94
        Width = 94
        Height = 21
        HelpContext = 1804
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 9
        Text = '00:00:00,00'
        OnChange = EingabeChange
        OnClick = AbsZeitEditClick
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs4ErgEdit: TTriaEdit
        Left = 401
        Top = 159
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 10
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs1Btn: TBitBtn
        Left = 162
        Top = 94
        Width = 15
        Height = 21
        HelpContext = 1820
        Glyph.Data = {
          F6000000424DF600000000000000360000002800000007000000080000000100
          180000000000C0000000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF00
          0000FF00FFFF00FF000000000000000000FF00FFFF00FF000000FF00FF000000
          000000000000000000000000FF00FF0000000000000000000000000000000000
          00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Spacing = 0
        TabOrder = 11
        OnClick = AbsBtnClick
      end
      object Abs2Btn: TBitBtn
        Left = 273
        Top = 94
        Width = 15
        Height = 21
        HelpContext = 1820
        Glyph.Data = {
          F6000000424DF600000000000000360000002800000007000000080000000100
          180000000000C0000000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF00
          0000FF00FFFF00FF000000000000000000FF00FFFF00FF000000FF00FF000000
          000000000000000000000000FF00FF0000000000000000000000000000000000
          00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Spacing = 0
        TabOrder = 12
        OnClick = AbsBtnClick
      end
      object Abs3Btn: TBitBtn
        Left = 384
        Top = 94
        Width = 15
        Height = 21
        HelpContext = 1820
        Glyph.Data = {
          F6000000424DF600000000000000360000002800000007000000080000000100
          180000000000C0000000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF00
          0000FF00FFFF00FF000000000000000000FF00FFFF00FF000000FF00FF000000
          000000000000000000000000FF00FF0000000000000000000000000000000000
          00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Spacing = 0
        TabOrder = 13
        OnClick = AbsBtnClick
      end
      object Abs4Btn: TBitBtn
        Left = 495
        Top = 94
        Width = 15
        Height = 21
        HelpContext = 1820
        Glyph.Data = {
          F6000000424DF600000000000000360000002800000007000000080000000100
          180000000000C0000000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF00
          0000FF00FFFF00FF000000000000000000FF00FFFF00FF000000FF00FF000000
          000000000000000000000000FF00FF0000000000000000000000000000000000
          00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Spacing = 0
        TabOrder = 14
        OnClick = AbsBtnClick
      end
      object Gutschrift1Edit: TTriaEdit
        Left = 514
        Top = 50
        Width = 94
        Height = 21
        HelpContext = 1821
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 19
        Text = '   00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs1StZeitEdit: TUhrZeitEdit
        Left = 68
        Top = 50
        Width = 94
        Height = 21
        HelpContext = 1801
        TabStop = False
        Color = clBtnFace
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = '00:00:00,00'
        OnChange = EingabeChange
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs2StZeitEdit: TUhrZeitEdit
        Left = 179
        Top = 51
        Width = 94
        Height = 21
        HelpContext = 1802
        TabStop = False
        Color = clBtnFace
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        ReadOnly = True
        TabOrder = 20
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs3StZeitEdit: TUhrZeitEdit
        Left = 290
        Top = 50
        Width = 94
        Height = 21
        HelpContext = 1802
        TabStop = False
        Color = clBtnFace
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        ReadOnly = True
        TabOrder = 21
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs4StZeitEdit: TUhrZeitEdit
        Left = 401
        Top = 51
        Width = 94
        Height = 21
        HelpContext = 1802
        TabStop = False
        Color = clBtnFace
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        ReadOnly = True
        TabOrder = 22
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs1RndEdit: TTriaEdit
        Left = 68
        Top = 116
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 23
        Text = '0000'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs2RndEdit: TTriaEdit
        Left = 179
        Top = 116
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 24
        Text = '0000'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs3RndEdit: TTriaEdit
        Left = 290
        Top = 116
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 25
        Text = '0000'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs4RndEdit: TTriaEdit
        Left = 401
        Top = 116
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 26
        Text = '0000'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
    end
    object Zeitnahme2TS: TTabSheet
      Caption = 'Zeitnahme 5-8'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object StartZeit2Label: TLabel
        Left = 5
        Top = 53
        Width = 51
        Height = 15
        Caption = 'Startzeit*)'
      end
      object Abs5Label: TLabel
        Left = 68
        Top = 35
        Width = 86
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Abschn. 5'
        FocusControl = Abs5ZeitEdit
        ShowAccelChar = False
        OnClick = AbsLabelClick
      end
      object Abs6Label: TLabel
        Left = 179
        Top = 35
        Width = 86
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Abschn. 6'
        FocusControl = Abs6ZeitEdit
        ShowAccelChar = False
        OnClick = AbsLabelClick
      end
      object Abs7Label: TLabel
        Left = 290
        Top = 35
        Width = 86
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Abschn. 7'
        FocusControl = Abs7ZeitEdit
        ShowAccelChar = False
        OnClick = AbsLabelClick
      end
      object Abs8Label: TLabel
        Left = 401
        Top = 35
        Width = 86
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Abschn. 8'
        FocusControl = Abs8ZeitEdit
        ShowAccelChar = False
        OnClick = AbsLabelClick
      end
      object Gutschrift2Label: TLabel
        Left = 514
        Top = 35
        Width = 86
        Height = 15
        HelpContext = 1821
        Alignment = taCenter
        AutoSize = False
        Caption = 'Zeitgutschrift'
        OnClick = ZeitnahmeLabelClick
      end
      object Zeitnahme2Label: TLabel
        Left = 5
        Top = 97
        Width = 58
        Height = 15
        Caption = 'Stoppzeit*)'
      end
      object Ergebnis2Label: TLabel
        Left = 5
        Top = 156
        Width = 61
        Height = 15
        Caption = 'Abschnitts-'
      end
      object DisqStatus2Label: TLabel
        Left = 514
        Top = 182
        Width = 94
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '(disqualifiziert)'
        OnClick = ZeitnahmeLabelClick
      end
      object Loesch2Label1: TLabel
        Left = 5
        Top = 196
        Width = 501
        Height = 15
        Caption = 
          '*)  Start- und Stoppzeiten werden grunds'#228'tzlich als Uhrzeiten be' +
          'trachtet. Die Stoppzeit kann mit'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = ZeitnahmeLabelClick
      end
      object Loesch2Label2: TLabel
        Left = 20
        Top = 210
        Width = 416
        Height = 15
        Caption = 
          'der Entf-Taste oder Leertaste gel'#246'scht werden (00:00:00 ist eine' +
          ' g'#252'ltige Uhrzeit).'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = ZeitnahmeLabelClick
      end
      object StrafZeit2Label: TLabel
        Left = 514
        Top = 79
        Width = 94
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Strafzeit'
        OnClick = ZeitnahmeLabelClick
      end
      object EndZeit2Label: TLabel
        Left = 514
        Top = 144
        Width = 94
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Endzeit'
        OnClick = ZeitnahmeLabelClick
      end
      object Runden2Label: TLabel
        Left = 5
        Top = 119
        Width = 41
        Height = 15
        Caption = 'Runden'
      end
      object Zeit2Label: TLabel
        Left = 5
        Top = 167
        Width = 56
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'zeit'
      end
      object Abs8Grid: TTriaGrid
        Left = 356
        Top = 115
        Width = 201
        Height = 117
        HelpContext = 1822
        ColCount = 3
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 8
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssBoth
        TabOrder = 18
        Visible = False
        OnClick = AbsGridClick
        OnDrawCell = AbsGridDrawCell
        OnEnter = EingabeEnter
        ColWidths = (
          42
          82
          64)
      end
      object Abs7Grid: TTriaGrid
        Left = 253
        Top = 115
        Width = 201
        Height = 117
        HelpContext = 1822
        ColCount = 3
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 8
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssBoth
        TabOrder = 17
        Visible = False
        OnClick = AbsGridClick
        OnDrawCell = AbsGridDrawCell
        OnEnter = EingabeEnter
        ColWidths = (
          42
          82
          64)
      end
      object Abs6Grid: TTriaGrid
        Left = 135
        Top = 115
        Width = 201
        Height = 117
        HelpContext = 1822
        ColCount = 3
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 8
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssBoth
        TabOrder = 16
        Visible = False
        OnClick = AbsGridClick
        OnDrawCell = AbsGridDrawCell
        OnEnter = EingabeEnter
        ColWidths = (
          42
          82
          64)
      end
      object Abs5Grid: TTriaGrid
        Left = 25
        Top = 115
        Width = 201
        Height = 117
        HelpContext = 1822
        ColCount = 3
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 8
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssBoth
        TabOrder = 15
        Visible = False
        OnClick = AbsGridClick
        OnDrawCell = AbsGridDrawCell
        OnEnter = EingabeEnter
        ColWidths = (
          42
          82
          64)
      end
      object Gutschrift2Edit: TTriaEdit
        Left = 514
        Top = 50
        Width = 94
        Height = 21
        HelpContext = 1821
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = '   00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs5ZeitEdit: TUhrZeitEdit
        Left = 68
        Top = 94
        Width = 94
        Height = 21
        HelpContext = 1804
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 1
        Text = '00:00:00,00'
        OnChange = EingabeChange
        OnClick = AbsZeitEditClick
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs5Btn: TBitBtn
        Left = 162
        Top = 94
        Width = 15
        Height = 21
        HelpContext = 1820
        Glyph.Data = {
          F6000000424DF600000000000000360000002800000007000000080000000100
          180000000000C0000000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF00
          0000FF00FFFF00FF000000000000000000FF00FFFF00FF000000FF00FF000000
          000000000000000000000000FF00FF0000000000000000000000000000000000
          00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Spacing = 0
        TabOrder = 2
        OnClick = AbsBtnClick
      end
      object Abs6ZeitEdit: TUhrZeitEdit
        Left = 179
        Top = 94
        Width = 94
        Height = 21
        HelpContext = 1804
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 3
        Text = '00:00:00,00'
        OnChange = EingabeChange
        OnClick = AbsZeitEditClick
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs6Btn: TBitBtn
        Left = 273
        Top = 94
        Width = 15
        Height = 21
        HelpContext = 1820
        Glyph.Data = {
          F6000000424DF600000000000000360000002800000007000000080000000100
          180000000000C0000000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF00
          0000FF00FFFF00FF000000000000000000FF00FFFF00FF000000FF00FF000000
          000000000000000000000000FF00FF0000000000000000000000000000000000
          00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Spacing = 0
        TabOrder = 4
        OnClick = AbsBtnClick
      end
      object Abs7ZeitEdit: TUhrZeitEdit
        Left = 290
        Top = 94
        Width = 94
        Height = 21
        HelpContext = 1804
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 5
        Text = '00:00:00,00'
        OnChange = EingabeChange
        OnClick = AbsZeitEditClick
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs7Btn: TBitBtn
        Left = 384
        Top = 94
        Width = 15
        Height = 21
        HelpContext = 1820
        Glyph.Data = {
          F6000000424DF600000000000000360000002800000007000000080000000100
          180000000000C0000000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF00
          0000FF00FFFF00FF000000000000000000FF00FFFF00FF000000FF00FF000000
          000000000000000000000000FF00FF0000000000000000000000000000000000
          00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Spacing = 0
        TabOrder = 6
        OnClick = AbsBtnClick
      end
      object Abs8ZeitEdit: TUhrZeitEdit
        Left = 401
        Top = 94
        Width = 94
        Height = 21
        HelpContext = 1804
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        TabOrder = 7
        Text = '00:00:00,00'
        OnChange = EingabeChange
        OnClick = AbsZeitEditClick
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs8Btn: TBitBtn
        Left = 495
        Top = 94
        Width = 15
        Height = 21
        HelpContext = 1820
        Glyph.Data = {
          F6000000424DF600000000000000360000002800000007000000080000000100
          180000000000C0000000130B0000130B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FF000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF00
          0000FF00FFFF00FF000000000000000000FF00FFFF00FF000000FF00FF000000
          000000000000000000000000FF00FF0000000000000000000000000000000000
          00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
        Spacing = 0
        TabOrder = 8
        OnClick = AbsBtnClick
      end
      object StrafZeit2Edit: TTriaEdit
        Left = 514
        Top = 94
        Width = 94
        Height = 21
        HelpContext = 1807
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
        Text = '   00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs5ErgEdit: TTriaEdit
        Left = 68
        Top = 159
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 10
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs6ErgEdit: TTriaEdit
        Left = 179
        Top = 159
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 11
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs7ErgEdit: TTriaEdit
        Left = 290
        Top = 159
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 12
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs8ErgEdit: TTriaEdit
        Left = 401
        Top = 159
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 13
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object EndZeit2Edit: TTriaEdit
        Left = 514
        Top = 159
        Width = 94
        Height = 21
        HelpContext = 1811
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 14
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs5StZeitEdit: TUhrZeitEdit
        Left = 68
        Top = 50
        Width = 94
        Height = 21
        HelpContext = 1802
        TabStop = False
        Color = clBtnFace
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        ReadOnly = True
        TabOrder = 19
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs6StZeitEdit: TUhrZeitEdit
        Left = 179
        Top = 50
        Width = 94
        Height = 21
        HelpContext = 1802
        TabStop = False
        Color = clBtnFace
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        ReadOnly = True
        TabOrder = 20
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs7StZeitEdit: TUhrZeitEdit
        Left = 290
        Top = 50
        Width = 94
        Height = 21
        HelpContext = 1802
        TabStop = False
        Color = clBtnFace
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        ReadOnly = True
        TabOrder = 21
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs8StZeitEdit: TUhrZeitEdit
        Left = 401
        Top = 50
        Width = 94
        Height = 21
        HelpContext = 1802
        TabStop = False
        Color = clBtnFace
        EditMask = '!90:00:00,00;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 11
        ParentFont = False
        ReadOnly = True
        TabOrder = 22
        Text = '00:00:00,00'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs5RndEdit: TTriaEdit
        Left = 68
        Top = 116
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 23
        Text = '0000'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs6RndEdit: TTriaEdit
        Left = 179
        Top = 116
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 24
        Text = '0000'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs7RndEdit: TTriaEdit
        Left = 290
        Top = 116
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 25
        Text = '0000'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
      object Abs8RndEdit: TTriaEdit
        Left = 401
        Top = 116
        Width = 94
        Height = 21
        HelpContext = 1808
        TabStop = False
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 26
        Text = '0000'
        OnEnter = EingabeEnter
        OnKeyDown = NavKeyDown
      end
    end
    object WertgTS: TTabSheet
      Caption = 'Wertung'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object TagesRngGB: TGroupBox
        Left = 16
        Top = 36
        Width = 581
        Height = 180
        Caption = 'Platzierungen'
        TabOrder = 0
        object AlleRngLabel: TLabel
          Left = 12
          Top = 45
          Width = 82
          Height = 15
          Caption = 'Alle Teilnehmer'
        end
        object AkRngLabel: TLabel
          Left = 12
          Top = 113
          Width = 30
          Height = 15
          Caption = 'TW25'
        end
        object Abs1RngLabel: TLabel
          Left = 174
          Top = 26
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs1'
          ShowAccelChar = False
        end
        object Abs2RngLabel: TLabel
          Left = 222
          Top = 26
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs2'
          ShowAccelChar = False
        end
        object Abs3RngLabel: TLabel
          Left = 270
          Top = 26
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs3'
          ShowAccelChar = False
        end
        object EndRngLabel: TLabel
          Left = 112
          Top = 26
          Width = 40
          Height = 15
          Caption = 'Gesamt'
          ShowAccelChar = False
        end
        object SondRngLabel: TLabel
          Left = 12
          Top = 147
          Width = 86
          Height = 15
          Caption = 'Aktive m'#228'nnlich'
        end
        object Abs4RngLabel: TLabel
          Left = 318
          Top = 26
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs4'
          ShowAccelChar = False
        end
        object SexRngLabel: TLabel
          Left = 12
          Top = 79
          Width = 79
          Height = 15
          Caption = 'Pro Geschlecht'
        end
        object Abs5RngLabel: TLabel
          Left = 380
          Top = 26
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs5'
          ShowAccelChar = False
        end
        object Abs6RngLabel: TLabel
          Left = 428
          Top = 26
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs6'
          ShowAccelChar = False
        end
        object Abs7RngLabel: TLabel
          Left = 476
          Top = 26
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs7'
          ShowAccelChar = False
        end
        object Abs8RngLabel: TLabel
          Left = 524
          Top = 26
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs8'
          ShowAccelChar = False
        end
        object AlleEndRngEdit: TTriaEdit
          Left = 112
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1901
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnKeyDown = NavKeyDown
        end
        object AkEndRngEdit: TTriaEdit
          Left = 112
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1905
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AlleAbs1RngEdit: TTriaEdit
          Left = 174
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnKeyDown = NavKeyDown
        end
        object AlleAbs2RngEdit: TTriaEdit
          Left = 222
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnKeyDown = NavKeyDown
        end
        object AlleAbs3RngEdit: TTriaEdit
          Left = 270
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          OnKeyDown = NavKeyDown
        end
        object AkAbs1RngEdit: TTriaEdit
          Left = 174
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AkAbs2RngEdit: TTriaEdit
          Left = 222
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AkAbs3RngEdit: TTriaEdit
          Left = 270
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SondEndRngEdit: TTriaEdit
          Left = 112
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1909
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SondAbs1RngEdit: TTriaEdit
          Left = 174
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          OnKeyDown = NavKeyDown
        end
        object SondAbs2RngEdit: TTriaEdit
          Left = 222
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
          OnKeyDown = NavKeyDown
        end
        object SondAbs3RngEdit: TTriaEdit
          Left = 270
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
          OnKeyDown = NavKeyDown
        end
        object AlleAbs4RngEdit: TTriaEdit
          Left = 318
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 12
          OnKeyDown = NavKeyDown
        end
        object AkAbs4RngEdit: TTriaEdit
          Left = 318
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SondAbs4RngEdit: TTriaEdit
          Left = 318
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 14
          OnKeyDown = NavKeyDown
        end
        object SexEndRngEdit: TTriaEdit
          Left = 112
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1903
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 15
          OnKeyDown = NavKeyDown
        end
        object SexAbs1RngEdit: TTriaEdit
          Left = 174
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 16
          OnKeyDown = NavKeyDown
        end
        object SexAbs2RngEdit: TTriaEdit
          Left = 222
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 17
          OnKeyDown = NavKeyDown
        end
        object SexAbs3RngEdit: TTriaEdit
          Left = 270
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 18
          OnKeyDown = NavKeyDown
        end
        object SexAbs4RngEdit: TTriaEdit
          Left = 318
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 19
          OnKeyDown = NavKeyDown
        end
        object AlleAbs8RngEdit: TTriaEdit
          Left = 524
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 20
          OnKeyDown = NavKeyDown
        end
        object AlleAbs7RngEdit: TTriaEdit
          Left = 476
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 21
          OnKeyDown = NavKeyDown
        end
        object AlleAbs6RngEdit: TTriaEdit
          Left = 428
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 22
          OnKeyDown = NavKeyDown
        end
        object AlleAbs5RngEdit: TTriaEdit
          Left = 380
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 23
          OnKeyDown = NavKeyDown
        end
        object SexAbs5RngEdit: TTriaEdit
          Left = 380
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 24
          OnKeyDown = NavKeyDown
        end
        object SexAbs6RngEdit: TTriaEdit
          Left = 428
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 25
          OnKeyDown = NavKeyDown
        end
        object SexAbs7RngEdit: TTriaEdit
          Left = 476
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 26
          OnKeyDown = NavKeyDown
        end
        object SexAbs8RngEdit: TTriaEdit
          Left = 524
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 27
          OnKeyDown = NavKeyDown
        end
        object AkAbs8RngEdit: TTriaEdit
          Left = 524
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 28
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AkAbs7RngEdit: TTriaEdit
          Left = 476
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 29
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AkAbs6RngEdit: TTriaEdit
          Left = 428
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 30
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AkAbs5RngEdit: TTriaEdit
          Left = 380
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 31
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SondAbs5RngEdit: TTriaEdit
          Left = 380
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 32
          OnKeyDown = NavKeyDown
        end
        object SondAbs6RngEdit: TTriaEdit
          Left = 428
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 33
          OnKeyDown = NavKeyDown
        end
        object SondAbs7RngEdit: TTriaEdit
          Left = 476
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 34
          OnKeyDown = NavKeyDown
        end
        object SondAbs8RngEdit: TTriaEdit
          Left = 524
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 35
          OnKeyDown = NavKeyDown
        end
      end
    end
    object SondWertgTS: TTabSheet
      Caption = 'Sonderwertung'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object TagesRngSWGB: TGroupBox
        Left = 16
        Top = 36
        Width = 581
        Height = 180
        Caption = 'Platzierungen'
        TabOrder = 0
        object AlleRngSWLabel: TLabel
          Left = 12
          Top = 45
          Width = 82
          Height = 15
          Caption = 'Alle Teilnehmer'
        end
        object AkRngSWLabel: TLabel
          Left = 12
          Top = 113
          Width = 30
          Height = 15
          Caption = 'TW25'
        end
        object Abs1RngSWLabel: TLabel
          Left = 174
          Top = 27
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs1'
          ShowAccelChar = False
        end
        object Abs2RngSWLabel: TLabel
          Left = 222
          Top = 27
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs2'
          ShowAccelChar = False
        end
        object Abs3RngSWLabel: TLabel
          Left = 270
          Top = 27
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs3'
          ShowAccelChar = False
        end
        object EndRngSWLabel: TLabel
          Left = 112
          Top = 27
          Width = 40
          Height = 15
          Caption = 'Gesamt'
          ShowAccelChar = False
        end
        object SondRngSWLabel: TLabel
          Left = 12
          Top = 147
          Width = 86
          Height = 15
          Caption = 'Aktive m'#228'nnlich'
        end
        object Abs4RngSWLabel: TLabel
          Left = 318
          Top = 27
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs4'
          ShowAccelChar = False
        end
        object SexRngSWLabel: TLabel
          Left = 12
          Top = 79
          Width = 79
          Height = 15
          Caption = 'Pro Geschlecht'
        end
        object Abs5RngSWLabel: TLabel
          Left = 380
          Top = 27
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs5'
          ShowAccelChar = False
        end
        object Abs6RngSWLabel: TLabel
          Left = 428
          Top = 27
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs6'
          ShowAccelChar = False
        end
        object Abs7RngSWLabel: TLabel
          Left = 476
          Top = 27
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs7'
          ShowAccelChar = False
        end
        object Abs8RngSWLabel: TLabel
          Left = 524
          Top = 27
          Width = 40
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = 'Abs8'
          ShowAccelChar = False
        end
        object AlleEndRngSWEdit: TTriaEdit
          Left = 112
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1901
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnKeyDown = NavKeyDown
        end
        object AkEndRngSWEdit: TTriaEdit
          Left = 112
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1905
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AlleAbs1RngSWEdit: TTriaEdit
          Left = 174
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnKeyDown = NavKeyDown
        end
        object AlleAbs2RngSWEdit: TTriaEdit
          Left = 222
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnKeyDown = NavKeyDown
        end
        object AlleAbs3RngSWEdit: TTriaEdit
          Left = 270
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          OnKeyDown = NavKeyDown
        end
        object AkAbs1RngSWEdit: TTriaEdit
          Left = 174
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AkAbs2RngSWEdit: TTriaEdit
          Left = 222
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AkAbs3RngSWEdit: TTriaEdit
          Left = 270
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SondEndRngSWEdit: TTriaEdit
          Left = 112
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1909
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SondAbs1RngSWEdit: TTriaEdit
          Left = 174
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          OnKeyDown = NavKeyDown
        end
        object SondAbs2RngSWEdit: TTriaEdit
          Left = 222
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
          OnKeyDown = NavKeyDown
        end
        object SondAbs3RngSWEdit: TTriaEdit
          Left = 270
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
          OnKeyDown = NavKeyDown
        end
        object AlleAbs4RngSWEdit: TTriaEdit
          Left = 318
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 12
          OnKeyDown = NavKeyDown
        end
        object AkAbs4RngSWEdit: TTriaEdit
          Left = 318
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SondAbs4RngSWEdit: TTriaEdit
          Left = 318
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 14
          OnKeyDown = NavKeyDown
        end
        object SexEndRngSWEdit: TTriaEdit
          Left = 112
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1903
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 15
          OnKeyDown = NavKeyDown
        end
        object SexAbs1RngSWEdit: TTriaEdit
          Left = 174
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 16
          OnKeyDown = NavKeyDown
        end
        object SexAbs2RngSWEdit: TTriaEdit
          Left = 222
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 17
          OnKeyDown = NavKeyDown
        end
        object SexAbs3RngSWEdit: TTriaEdit
          Left = 270
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 18
          OnKeyDown = NavKeyDown
        end
        object SexAbs4RngSWEdit: TTriaEdit
          Left = 318
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 19
          OnKeyDown = NavKeyDown
        end
        object AlleAbs8RngSWEdit: TTriaEdit
          Left = 524
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 20
          OnKeyDown = NavKeyDown
        end
        object AlleAbs7RngSWEdit: TTriaEdit
          Left = 476
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 21
          OnKeyDown = NavKeyDown
        end
        object AlleAbs6RngSWEdit: TTriaEdit
          Left = 428
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 22
          OnKeyDown = NavKeyDown
        end
        object AlleAbs5RngSWEdit: TTriaEdit
          Left = 380
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1902
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 23
          OnKeyDown = NavKeyDown
        end
        object SexAbs5RngSWEdit: TTriaEdit
          Left = 380
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 24
          OnKeyDown = NavKeyDown
        end
        object SexAbs6RngSWEdit: TTriaEdit
          Left = 428
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 25
          OnKeyDown = NavKeyDown
        end
        object SexAbs7RngSWEdit: TTriaEdit
          Left = 476
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 26
          OnKeyDown = NavKeyDown
        end
        object SexAbs8RngSWEdit: TTriaEdit
          Left = 524
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1904
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 27
          OnKeyDown = NavKeyDown
        end
        object AkAbs8RngSWEdit: TTriaEdit
          Left = 524
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 28
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AkAbs7RngSWEdit: TTriaEdit
          Left = 476
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 29
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AkAbs6RngSWEdit: TTriaEdit
          Left = 428
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 30
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object AkAbs5RngSWEdit: TTriaEdit
          Left = 380
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1906
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 31
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SondAbs5RngSWEdit: TTriaEdit
          Left = 380
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 32
          OnKeyDown = NavKeyDown
        end
        object SondAbs6RngSWEdit: TTriaEdit
          Left = 428
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 33
          OnKeyDown = NavKeyDown
        end
        object SondAbs7RngSWEdit: TTriaEdit
          Left = 476
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 34
          OnKeyDown = NavKeyDown
        end
        object SondAbs8RngSWEdit: TTriaEdit
          Left = 524
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1921
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 35
          OnKeyDown = NavKeyDown
        end
      end
    end
    object SerWertgTS: TTabSheet
      Caption = 'Serienwertung'
      ImageIndex = 8
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SerRngGB: TGroupBox
        Left = 259
        Top = 36
        Width = 264
        Height = 179
        Caption = 'Gesamt-Serienwertung'
        TabOrder = 0
        object SeriePktLabel: TLabel
          Left = 164
          Top = 27
          Width = 37
          Height = 15
          HelpContext = 1912
          Caption = 'Punkte'
        end
        object SerieRngLabel: TLabel
          Left = 117
          Top = 27
          Width = 27
          Height = 15
          HelpContext = 1913
          Caption = 'Rang'
        end
        object SerieAlleLabel: TLabel
          Left = 12
          Top = 45
          Width = 82
          Height = 15
          Caption = 'Alle Teilnehmer'
        end
        object SerieSexLabel: TLabel
          Left = 12
          Top = 79
          Width = 79
          Height = 15
          Caption = 'Pro Geschlecht'
        end
        object SerieAkLabel: TLabel
          Left = 12
          Top = 113
          Width = 30
          Height = 15
          Caption = 'TW25'
        end
        object SerieSkLabel: TLabel
          Left = 12
          Top = 147
          Width = 86
          Height = 15
          Caption = 'Aktive m'#228'nnlich'
        end
        object SerieRngAlleEdit: TEdit
          Left = 112
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1913
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SeriePktAlleEdit: TEdit
          Left = 162
          Top = 42
          Width = 88
          Height = 21
          HelpContext = 1912
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          Text = '3859:00:00'
          OnKeyDown = NavKeyDown
        end
        object SerieRngSkEdit: TEdit
          Left = 112
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1913
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SeriePktSkEdit: TEdit
          Left = 162
          Top = 144
          Width = 48
          Height = 21
          HelpContext = 1912
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          Text = '00000'
          OnKeyDown = NavKeyDown
        end
        object SerieRngAkEdit: TEdit
          Left = 112
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1913
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SeriePktAkEdit: TEdit
          Left = 162
          Top = 110
          Width = 48
          Height = 21
          HelpContext = 1912
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          Text = '00000'
          OnKeyDown = NavKeyDown
        end
        object SerieRngSexEdit: TEdit
          Left = 112
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1913
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SeriePktSexEdit: TEdit
          Left = 162
          Top = 76
          Width = 48
          Height = 21
          HelpContext = 1912
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          Text = '00000'
          OnKeyDown = NavKeyDown
        end
      end
      object TagesSerRngGB: TGroupBox
        Left = 16
        Top = 36
        Width = 225
        Height = 180
        Caption = 'Tages-Serienwertung'
        TabOrder = 1
        object AlleRngSerTgLabel: TLabel
          Left = 12
          Top = 45
          Width = 82
          Height = 15
          Caption = 'Alle Teilnehmer'
        end
        object AkRngSerTgLabel: TLabel
          Left = 12
          Top = 113
          Width = 30
          Height = 15
          Caption = 'TW25'
        end
        object SondRngSerTgLabel: TLabel
          Left = 12
          Top = 147
          Width = 86
          Height = 15
          Caption = 'Aktive m'#228'nnlich'
        end
        object SexRngSerTgLabel: TLabel
          Left = 12
          Top = 79
          Width = 79
          Height = 15
          Caption = 'Pro Geschlecht'
        end
        object EndRngSerLabel: TLabel
          Left = 117
          Top = 26
          Width = 27
          Height = 15
          Alignment = taCenter
          Caption = 'Rang'
          ShowAccelChar = False
        end
        object EndPktSerLabel: TLabel
          Left = 164
          Top = 27
          Width = 37
          Height = 15
          HelpContext = 1912
          Caption = 'Punkte'
        end
        object AlleRngSerTgEdit: TTriaEdit
          Left = 112
          Top = 42
          Width = 40
          Height = 21
          HelpContext = 1911
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnKeyDown = NavKeyDown
        end
        object SexRngSerTgEdit: TTriaEdit
          Left = 112
          Top = 76
          Width = 40
          Height = 21
          HelpContext = 1911
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnKeyDown = NavKeyDown
        end
        object AkRngSerTgEdit: TTriaEdit
          Left = 112
          Top = 110
          Width = 40
          Height = 21
          HelpContext = 1911
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          Text = '0000'
          OnKeyDown = NavKeyDown
        end
        object SondRngSerTgEdit: TTriaEdit
          Left = 112
          Top = 144
          Width = 40
          Height = 21
          HelpContext = 1911
          TabStop = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnKeyDown = NavKeyDown
        end
        object AllePktSerTgEdit: TEdit
          Left = 162
          Top = 42
          Width = 48
          Height = 21
          HelpContext = 1912
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          Text = '12345'
          OnKeyDown = NavKeyDown
        end
        object SexPktSerTgEdit: TEdit
          Left = 162
          Top = 76
          Width = 48
          Height = 21
          HelpContext = 1912
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          Text = '00000'
          OnKeyDown = NavKeyDown
        end
        object AkPktSerTgEdit: TEdit
          Left = 162
          Top = 110
          Width = 48
          Height = 21
          HelpContext = 1912
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          Text = '00000'
          OnKeyDown = NavKeyDown
        end
        object SondPktSerTgEdit: TEdit
          Left = 162
          Top = 144
          Width = 48
          Height = 21
          HelpContext = 1912
          TabStop = False
          AutoSelect = False
          AutoSize = False
          BiDiMode = bdLeftToRight
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Pitch = fpFixed
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          Text = '00000'
          OnKeyDown = NavKeyDown
        end
      end
    end
  end
  object MannschLookUpEdit: TTriaLookUpEdit
    Left = 211
    Top = 74
    Width = 185
    Height = 23
    HelpContext = 1407
    TabOrder = 4
    OnChange = EingabeChange
    OnEnter = EingabeEnter
    OnKeyDown = NavKeyDown
  end
  object MannschLookUpBtn: TTriaLookUpBtn
    Left = 377
    Top = 76
    Width = 17
    Height = 19
    Glyph.Data = {
      F6000000424DF600000000000000360000002800000007000000080000000100
      180000000000C0000000130B0000130B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FF000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF00
      0000FF00FFFF00FF000000000000000000FF00FFFF00FF000000FF00FF000000
      000000000000000000000000FF00FF0000000000000000000000000000000000
      00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
      0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
    TabOrder = 19
    TabStop = False
    OnKeyDown = NavKeyDown
  end
  object MannschLookUpGrid: TTriaLookUpGrid
    Left = 211
    Top = 97
    Width = 185
    Height = 16
    HelpContext = 1407
    TabStop = False
    MaxRows = 0
    DefaultDrawing = True
    Options = []
    TabOrder = 20
    OnKeyDown = NavKeyDown
    OnGetRowText = MannschLookUpGridGetRowText
  end
  object VereinLookUpEdit: TTriaLookUpEdit
    Left = 12
    Top = 74
    Width = 185
    Height = 23
    HelpContext = 1407
    TabOrder = 21
    OnChange = EingabeChange
    OnEnter = EingabeEnter
    OnKeyDown = NavKeyDown
  end
  object VereinLookUpBtn: TTriaLookUpBtn
    Left = 178
    Top = 76
    Width = 17
    Height = 19
    Glyph.Data = {
      F6000000424DF600000000000000360000002800000007000000080000000100
      180000000000C0000000130B0000130B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FF000000FF00FFFF00FFFF00FF000000FF00FFFF00FFFF00FF00
      0000FF00FFFF00FF000000000000000000FF00FFFF00FF000000FF00FF000000
      000000000000000000000000FF00FF0000000000000000000000000000000000
      00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
      0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000}
    TabOrder = 22
    TabStop = False
    OnKeyDown = NavKeyDown
  end
  object VereinLookUpGrid: TTriaLookUpGrid
    Left = 12
    Top = 97
    Width = 185
    Height = 16
    HelpContext = 1407
    TabStop = False
    MaxRows = 0
    DefaultDrawing = True
    Options = []
    TabOrder = 23
    OnKeyDown = NavKeyDown
    OnGetRowText = VereinLookUpGridGetRowText
  end
end