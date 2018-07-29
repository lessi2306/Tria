object AusgDialog: TAusgDialog
  Left = 0
  Top = 375
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Ausgabe'
  ClientHeight = 737
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object KlassenLabel: TLabel
    Left = 15
    Top = 293
    Width = 89
    Height = 15
    Caption = 'Wertungsklassen'
    OnClick = KlassenLabelClick
  end
  object WettkLabel: TLabel
    Left = 15
    Top = 171
    Width = 65
    Height = 15
    Caption = 'Wettk'#228'mpfe'
    OnClick = WettkLabelClick
  end
  object DruckerLabel: TLabel
    Left = 15
    Top = 16
    Width = 41
    Height = 15
    Caption = 'Drucker'
    OnClick = DruckerLabelClick
  end
  object CancelButton: TButton
    Left = 244
    Top = 698
    Width = 75
    Height = 25
    HelpContext = 2511
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 15
    TabStop = False
  end
  object OkButton: TButton
    Left = 159
    Top = 698
    Width = 75
    Height = 25
    HelpContext = 2512
    Caption = 'OK'
    Default = True
    TabOrder = 11
    TabStop = False
    OnClick = OkButtonClick
  end
  object HilfeButton: TButton
    Left = 329
    Top = 698
    Width = 75
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 13
    TabStop = False
    OnClick = HilfeButtonClick
  end
  object KlassenCLB: TCheckListBox
    Left = 12
    Top = 309
    Width = 150
    Height = 261
    HelpContext = 2502
    OnClickCheck = KlassenCLBClickCheck
    ItemHeight = 15
    Items.Strings = (
      'Alle Teilnehmer'
      'M'#228'nner'
      'Frauen'
      'Mixed'
      'TM11'
      'TW11'
      'TM13'
      'TW13')
    TabOrder = 4
    OnClick = KlassenCLBClick
  end
  object AnzeigeGB: TGroupBox
    Left = 178
    Top = 518
    Width = 226
    Height = 52
    Caption = 'Internet Browser'
    TabOrder = 8
    object AnzeigeCB: TCheckBox
      Left = 12
      Top = 24
      Width = 197
      Height = 17
      HelpContext = 2509
      Caption = 'Datei anzeigen'
      TabOrder = 0
    end
  end
  object RngBereichGB: TGroupBox
    Left = 178
    Top = 424
    Width = 226
    Height = 78
    Caption = 'Platzierungen'
    TabOrder = 7
    object RngBisLabel: TLabel
      Left = 140
      Top = 48
      Width = 15
      Height = 15
      HelpContext = 2507
      Caption = 'bis'
      OnClick = RngBisLabelClick
    end
    object RngAlleRB: TRadioButton
      Left = 12
      Top = 24
      Width = 113
      Height = 17
      HelpContext = 2507
      Caption = 'Alle '
      TabOrder = 0
      TabStop = True
      OnClick = RngAlleRBClick
    end
    object RngVonBisRB: TRadioButton
      Left = 12
      Top = 48
      Width = 66
      Height = 17
      HelpContext = 2507
      Caption = 'Platz von'
      TabOrder = 1
      TabStop = True
      OnClick = RngVonBisRBClick
      OnEnter = RngVonBisRBEnter
    end
    object RngVonEdit: TTriaMaskEdit
      Left = 80
      Top = 45
      Width = 39
      Height = 22
      HelpContext = 2507
      EditMask = '0999;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 2
      Text = '0'
      OnChange = RngEditClick
      OnClick = RngEditClick
      UpDown = RngVonUpDown
    end
    object RngBisEdit: TTriaMaskEdit
      Left = 157
      Top = 45
      Width = 39
      Height = 22
      HelpContext = 2507
      EditMask = '0999;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 4
      Text = '0'
      OnChange = RngEditClick
      OnClick = RngEditClick
      UpDown = RngBisUpDown
    end
    object RngVonUpDown: TTriaUpDown
      Left = 119
      Top = 44
      Width = 16
      Height = 24
      HelpContext = 2507
      Min = 1
      Max = 9999
      Position = 88
      TabOrder = 3
      Edit = RngVonEdit
    end
    object RngBisUpDown: TTriaUpDown
      Left = 196
      Top = 44
      Width = 16
      Height = 24
      HelpContext = 2507
      Min = 1
      Max = 9999
      Position = 88
      TabOrder = 5
      Edit = RngBisEdit
    end
  end
  object LayoutGB: TGroupBox
    Left = 178
    Top = 305
    Width = 226
    Height = 101
    Caption = 'Layout'
    TabOrder = 6
    object AkNewPageCB: TCheckBox
      Left = 12
      Top = 48
      Width = 209
      Height = 17
      HelpContext = 2515
      Caption = 'Jede Wertungsklasse auf neuer Seite'
      TabOrder = 1
      OnClick = AkNewPageCBClick
    end
    object OptTlnSpalteCB: TCheckBox
      Left = 12
      Top = 72
      Width = 197
      Height = 17
      HelpContext = 2504
      Caption = 'Optionale Spalte "Land" einf'#252'gen'
      TabOrder = 2
    end
    object WkNewPageCB: TCheckBox
      Left = 12
      Top = 24
      Width = 201
      Height = 17
      HelpContext = 2503
      Caption = 'Jeder Wettkampf auf neuer Seite'
      TabOrder = 0
      OnClick = WkNewPageCBClick
    end
  end
  object Panel1: TPanel
    Left = 12
    Top = 684
    Width = 392
    Height = 2
    BevelOuter = bvLowered
    TabOrder = 14
  end
  object AlleKlassenCB: TCheckBox
    Left = 15
    Top = 587
    Width = 143
    Height = 17
    HelpContext = 2513
    Caption = 'Alle Klassen ausw'#228'hlen'
    TabOrder = 5
    OnClick = AlleKlassenCBClick
  end
  object WettkCLB: TCheckListBox
    Left = 12
    Top = 187
    Width = 392
    Height = 89
    HelpContext = 2501
    OnClickCheck = WettkCLBClickCheck
    ItemHeight = 15
    Items.Strings = (
      'Alle Wettk'#228'mpfe'
      'Wettkampf 1'
      'Wettkampf 2'
      'Wettkampf 3'
      'Wettkampf 4'
      'Wettkampf 5')
    TabOrder = 3
    OnClick = WettkCLBClick
  end
  object VorschauButton: TButton
    Left = 12
    Top = 698
    Width = 75
    Height = 25
    HelpContext = 2516
    Caption = 'Vorschau'
    TabOrder = 10
    OnClick = VorschauButtonClick
  end
  object SerienDrGB: TGroupBox
    Left = 178
    Top = 584
    Width = 226
    Height = 78
    Caption = 'Seriendruck Urkunden'
    TabOrder = 9
    object TextAnzeigenCB: TCheckBox
      Left = 130
      Top = 48
      Width = 70
      Height = 17
      HelpContext = 2518
      Caption = 'Anzeigen'
      TabOrder = 2
    end
    object TextDateiRB: TRadioButton
      Left = 12
      Top = 48
      Width = 113
      Height = 17
      HelpContext = 2517
      Caption = 'Textdatei erstellen '
      TabOrder = 1
      OnClick = TextDateiRBClick
    end
    object WordRB: TRadioButton
      Left = 12
      Top = 24
      Width = 185
      Height = 17
      HelpContext = 2517
      Caption = 'Urkunden mit Word erstellen'
      TabOrder = 0
      OnClick = WordRBClick
    end
  end
  object DruckerBtn: TButton
    Left = 312
    Top = 30
    Width = 92
    Height = 25
    HelpContext = 2510
    Caption = 'Einstellungen...'
    TabOrder = 12
    TabStop = False
    OnClick = DruckerBtnClick
  end
  object DrBereichGB: TGroupBox
    Left = 12
    Top = 75
    Width = 224
    Height = 80
    Caption = 'Druckbereich'
    TabOrder = 2
    object PgBisLabel: TLabel
      Left = 143
      Top = 51
      Width = 15
      Height = 15
      HelpContext = 2505
      Caption = 'bis'
      OnClick = PgBisLabelClick
    end
    object PgAlleRB: TRadioButton
      Left = 12
      Top = 26
      Width = 113
      Height = 17
      HelpContext = 2505
      Caption = 'Alle Seiten'
      TabOrder = 0
      OnClick = PgAlleRBClick
    end
    object PgVonBisRB: TRadioButton
      Left = 12
      Top = 51
      Width = 73
      Height = 17
      HelpContext = 2505
      Caption = 'Seiten von'
      TabOrder = 1
      OnClick = PgVonBisRBClick
      OnEnter = PgVonBisRBEnter
    end
    object PgVonEdit: TTriaMaskEdit
      Left = 87
      Top = 48
      Width = 32
      Height = 22
      HelpContext = 2505
      EditMask = '099;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      Text = '0'
      OnClick = PgEditClick
      UpDown = PgVonUpDown
    end
    object PgBisEdit: TTriaMaskEdit
      Left = 161
      Top = 48
      Width = 32
      Height = 22
      HelpContext = 2505
      EditMask = '099;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 4
      Text = '0'
      OnClick = PgEditClick
      UpDown = PgBisUpDown
    end
    object PgVonUpDown: TTriaUpDown
      Left = 119
      Top = 47
      Width = 17
      Height = 24
      HelpContext = 2505
      Min = 1
      Max = 999
      Position = 888
      TabOrder = 3
      Edit = PgVonEdit
    end
    object PgBisUpDown: TTriaUpDown
      Left = 193
      Top = 47
      Width = 17
      Height = 24
      HelpContext = 2505
      Min = 1
      Max = 999
      Position = 88
      TabOrder = 5
      Edit = PgBisEdit
    end
  end
  object ExemplareGB: TGroupBox
    Left = 254
    Top = 75
    Width = 150
    Height = 80
    Caption = 'Exemplare'
    TabOrder = 1
    object AnzahlLabel: TLabel
      Left = 12
      Top = 26
      Width = 36
      Height = 15
      HelpContext = 2506
      Caption = 'Anzahl'
    end
    object AnzahlEdit: TTriaMaskEdit
      Left = 53
      Top = 23
      Width = 32
      Height = 22
      HelpContext = 2506
      EditMask = '099;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      Text = '0'
      OnChange = AnzahlEditChange
      UpDown = AnzahlUpDown
    end
    object AnzahlUpDown: TTriaUpDown
      Left = 85
      Top = 22
      Width = 17
      Height = 24
      HelpContext = 2506
      Min = 1
      Max = 999
      Position = 88
      TabOrder = 1
      Edit = AnzahlEdit
    end
    object SortierCB: TCheckBox
      Left = 53
      Top = 51
      Width = 71
      Height = 17
      HelpContext = 2506
      Caption = 'Sortieren'
      TabOrder = 2
    end
  end
  object DruckerCB: TComboBox
    Left = 12
    Top = 31
    Width = 290
    Height = 23
    AutoComplete = False
    AutoCloseUp = True
    Sorted = True
    TabOrder = 0
  end
  object ExcelApplication: TExcelApplication
    AutoConnect = False
    ConnectKind = ckNewInstance
    AutoQuit = False
    Left = 144
    Top = 213
  end
  object ExcelWorkBook: TExcelWorkbook
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 235
    Top = 213
  end
  object ExcelWorkSheet: TExcelWorksheet
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 326
    Top = 213
  end
  object PrintDialog: TPrintDialog
    Left = 24
    Top = 624
  end
end