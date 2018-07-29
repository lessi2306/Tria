object KlassenDialog: TKlassenDialog
  Left = 295
  Top = 239
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Wertungsklassen definieren'
  ClientHeight = 479
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object WettkCBLabel: TLabel
    Left = 16
    Top = 23
    Width = 59
    Height = 15
    HelpContext = 3401
    Caption = 'Wettkampf'
    OnClick = WettkCBLabelClick
  end
  object TabControl1: TTabControl
    Left = 10
    Top = 61
    Width = 523
    Height = 366
    TabOrder = 1
    Tabs.Strings = (
      'Klassen f'#252'r Teilnehmerwertung'
      'Klassen f'#252'r Mannschaftswertung')
    TabIndex = 0
    OnChange = TabControl1Change
    OnChanging = TabControlChanging
    object TabControl2: TTabControl
      Left = 0
      Top = 38
      Width = 523
      Height = 327
      TabOrder = 0
      Tabs.Strings = (
        'Alle Teilnehmer'
        'Pro Geschlecht'
        'Altersklassen'
        'Sonderklassen')
      TabIndex = 0
      OnChange = TabControl2Change
      OnChanging = TabControlChanging
      object TabControl3: TTabControl
        Left = 0
        Top = 41
        Width = 523
        Height = 285
        TabOrder = 0
        Tabs.Strings = (
          'M'#228'nnlich'
          'Weiblich')
        TabIndex = 0
        OnChange = TabControl3Change
        OnChanging = TabControlChanging
        object AkGridLabel: TLabel
          Left = 17
          Top = 37
          Width = 60
          Height = 15
          Caption = 'Klassenliste'
        end
        object AkGrid: TTriaGrid
          Left = 12
          Top = 52
          Width = 234
          Height = 220
          HelpContext = 3402
          ColCount = 4
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
          ScrollBars = ssBoth
          TabOrder = 0
          OnClick = AkGridClick
          OnDrawCell = TlnAkMGridDrawCell
          ColWidths = (
            64
            64
            64
            64)
          RowHeights = (
            24
            24
            24
            24
            24)
        end
        object KopierButton: TButton
          Left = 403
          Top = 150
          Width = 105
          Height = 25
          HelpContext = 3406
          Caption = 'Liste &kopieren'
          TabOrder = 2
          TabStop = False
          OnClick = KopierButtonClick
        end
        object KlasseGB: TGroupBox
          Left = 259
          Top = 45
          Width = 132
          Height = 227
          Caption = 'Klasse'
          TabOrder = 1
          object NameLabel: TLabel
            Left = 15
            Top = 28
            Width = 68
            Height = 15
            Caption = 'Bezeichnung'
          end
          object VonLabel: TLabel
            Left = 15
            Top = 127
            Width = 48
            Height = 15
            Caption = 'Alter von'
          end
          object BisLabel: TLabel
            Left = 15
            Top = 178
            Width = 43
            Height = 15
            Caption = 'Alter bis'
          end
          object KuerzelLabel: TLabel
            Left = 15
            Top = 78
            Width = 32
            Height = 15
            Caption = 'K'#252'rzel'
          end
          object NameEdit: TTriaEdit
            Left = 12
            Top = 43
            Width = 109
            Height = 22
            HelpContext = 3403
            TabOrder = 0
            Text = 'M'#228'nnl. Jugend U20'
            OnChange = EditChange
          end
          object VonEdit: TTriaMaskEdit
            Left = 12
            Top = 142
            Width = 37
            Height = 22
            HelpContext = 3404
            EditMask = '09;0; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 2
            Text = '0'
            OnChange = EditChange
            UpDown = VonUpDown
          end
          object BisEdit: TTriaMaskEdit
            Left = 12
            Top = 193
            Width = 36
            Height = 22
            HelpContext = 3405
            EditMask = '09;0; '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Courier New'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
            Text = '0'
            OnChange = EditChange
            UpDown = BisUpDown
          end
          object KuerzelEdit: TTriaEdit
            Left = 12
            Top = 93
            Width = 52
            Height = 22
            HelpContext = 3411
            MaxLength = 3
            TabOrder = 1
            Text = 'WK U12'
            OnChange = EditChange
          end
          object VonUpDown: TTriaUpDown
            Left = 49
            Top = 141
            Width = 16
            Height = 24
            Max = 99
            TabOrder = 4
            Edit = VonEdit
          end
          object BisUpDown: TTriaUpDown
            Left = 48
            Top = 192
            Width = 16
            Height = 24
            Max = 99
            TabOrder = 5
            Edit = BisEdit
          end
        end
        object EinfuegButton: TButton
          Left = 403
          Top = 179
          Width = 105
          Height = 25
          HelpContext = 3407
          Caption = 'Liste &einf'#252'gen'
          TabOrder = 3
          TabStop = False
          OnClick = EinfuegButtonClick
        end
        object DTU_Button: TButton
          Left = 403
          Top = 218
          Width = 105
          Height = 25
          HelpContext = 3412
          Caption = 'DTU-Altersklassen'
          TabOrder = 4
          TabStop = False
          OnClick = DefaultButtonClick
        end
        object DLV_Button: TButton
          Left = 403
          Top = 247
          Width = 105
          Height = 25
          HelpContext = 3413
          Caption = 'DLV-Altersklassen'
          TabOrder = 5
          TabStop = False
          OnClick = DefaultButtonClick
        end
        object AendButton: TButton
          Left = 403
          Top = 52
          Width = 105
          Height = 25
          HelpContext = 3410
          Caption = #196'n&dern'
          TabOrder = 6
          TabStop = False
          OnClick = AendButtonClick
        end
        object NeuButton: TButton
          Left = 403
          Top = 81
          Width = 105
          Height = 25
          HelpContext = 105
          Caption = '&Neu'
          TabOrder = 7
          TabStop = False
          OnClick = NeuButtonClick
        end
        object LoeschButton: TButton
          Left = 403
          Top = 110
          Width = 105
          Height = 25
          HelpContext = 106
          Caption = '&L'#246'schen'
          TabOrder = 8
          TabStop = False
          OnClick = LoeschButtonClick
        end
      end
    end
  end
  object CancelButton: TButton
    Left = 376
    Top = 441
    Width = 75
    Height = 25
    HelpContext = 102
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 4
    TabStop = False
  end
  object OkButton: TButton
    Left = 293
    Top = 441
    Width = 75
    Height = 25
    HelpContext = 103
    Caption = 'OK'
    TabOrder = 3
    TabStop = False
    OnClick = OkButtonClick
  end
  object HilfeButton: TButton
    Left = 458
    Top = 441
    Width = 75
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 5
    TabStop = False
    OnClick = HilfeButtonClick
  end
  object WettkCB: TComboBox
    Left = 79
    Top = 20
    Width = 454
    Height = 23
    HelpContext = 3401
    AutoComplete = False
    Style = csDropDownList
    TabOrder = 0
    OnChange = WettkCBChange
  end
  object UebernehmButton: TButton
    Left = 181
    Top = 441
    Width = 105
    Height = 25
    HelpContext = 3409
    Caption = 'Liste '#252'bernehmen'
    TabOrder = 2
    TabStop = False
    OnClick = UebernehmButtonClick
  end
end