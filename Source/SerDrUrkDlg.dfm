object SerDrUrkDialog: TSerDrUrkDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biHelp]
  Caption = 'Seriendruck Urkunden'
  ClientHeight = 382
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object WettkLabel: TLabel
    Left = 23
    Top = 26
    Width = 59
    Height = 15
    HelpContext = 3603
    Caption = 'Wettkampf'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object KlasseLabel: TLabel
    Left = 23
    Top = 79
    Width = 82
    Height = 15
    HelpContext = 3603
    Caption = 'Wertungsklasse'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ImpDateiEdit: TTriaEdit
    Left = 20
    Top = 42
    Width = 237
    Height = 21
    HelpContext = 3001
    TabStop = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    Text = 'Wettkampfname'
  end
  object TriaEdit1: TTriaEdit
    Left = 20
    Top = 95
    Width = 237
    Height = 21
    HelpContext = 3001
    TabStop = False
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    Text = 'Klasse'
  end
  object RngBereichGB: TGroupBox
    Left = 20
    Top = 140
    Width = 237
    Height = 78
    Caption = 'Platzierungen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object RngBisLabel: TLabel
      Left = 148
      Top = 48
      Width = 15
      Height = 15
      HelpContext = 2507
      Caption = 'bis'
    end
    object RngAlleRB: TRadioButton
      Left = 20
      Top = 25
      Width = 113
      Height = 17
      HelpContext = 2507
      Caption = 'Alle '
      TabOrder = 0
      TabStop = True
    end
    object RngVonBisRB: TRadioButton
      Left = 20
      Top = 48
      Width = 66
      Height = 17
      HelpContext = 2507
      Caption = 'Platz von'
      TabOrder = 1
      TabStop = True
      OnClick = RngVonBisRBClick
    end
    object RngVonEdit: TTriaMaskEdit
      Left = 88
      Top = 45
      Width = 39
      Height = 22
      HelpContext = 2507
      EditMask = '9999;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 2
      Text = '0000'
      OnChange = RngVonBisEditClick
      OnClick = RngVonBisEditClick
      UpDown = RngVonUpDown
    end
    object RngBisEdit: TTriaMaskEdit
      Left = 165
      Top = 45
      Width = 39
      Height = 22
      HelpContext = 2507
      EditMask = '9999;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 4
      Text = '0000'
      OnChange = RngVonBisEditClick
      OnClick = RngVonBisEditClick
      UpDown = RngBisUpDown
    end
    object RngVonUpDown: TTriaUpDown
      Left = 127
      Top = 44
      Width = 16
      Height = 24
      HelpContext = 2507
      Min = 1
      Max = 99
      Position = 88
      TabOrder = 3
      OnClick = RngUpDownClick
      Edit = RngVonEdit
    end
    object RngBisUpDown: TTriaUpDown
      Left = 204
      Top = 44
      Width = 16
      Height = 24
      HelpContext = 2507
      Min = 1
      Max = 99
      Position = 88
      TabOrder = 5
      OnClick = RngUpDownClick
      Edit = RngBisEdit
    end
  end
  object SnrBereichGB: TGroupBox
    Left = 20
    Top = 244
    Width = 237
    Height = 78
    Caption = 'Startnummern'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object SnrBisLabel: TLabel
      Left = 128
      Top = 48
      Width = 15
      Height = 15
      HelpContext = 2508
      Caption = 'bis'
    end
    object SnrAlleRB: TRadioButton
      Left = 20
      Top = 24
      Width = 113
      Height = 17
      HelpContext = 2508
      Caption = 'Alle '
      TabOrder = 0
      TabStop = True
      OnClick = SnrAlleRBClick
    end
    object SnrVonBisRB: TRadioButton
      Left = 20
      Top = 48
      Width = 41
      Height = 17
      HelpContext = 2508
      Caption = 'Von'
      TabOrder = 1
      TabStop = True
      OnClick = SnrVonBisRBClick
    end
    object SnrVonEdit: TTriaMaskEdit
      Left = 62
      Top = 45
      Width = 39
      Height = 22
      HelpContext = 2508
      EditMask = '9999;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 2
      Text = '0000'
      OnChange = SnrVonBisEditClick
      OnClick = SnrVonBisEditClick
      UpDown = SnrVonUpDown
    end
    object SnrBisEdit: TTriaMaskEdit
      Left = 145
      Top = 45
      Width = 39
      Height = 22
      HelpContext = 2508
      EditMask = '9999;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 4
      Text = '0000'
      OnChange = SnrVonBisEditClick
      OnClick = SnrVonBisEditClick
      UpDown = SnrBisUpDown
    end
    object SnrVonUpDown: TTriaUpDown
      Left = 101
      Top = 44
      Width = 16
      Height = 24
      HelpContext = 2508
      Min = 1
      Max = 99
      Position = 88
      TabOrder = 3
      OnClick = SnrUpDownClick
      Edit = SnrVonEdit
    end
    object SnrBisUpDown: TTriaUpDown
      Left = 184
      Top = 44
      Width = 16
      Height = 24
      HelpContext = 2508
      Min = 1
      Max = 99
      Position = 88
      TabOrder = 5
      Edit = SnrBisEdit
    end
  end
  object OkButton: TButton
    Left = 20
    Top = 342
    Width = 75
    Height = 25
    HelpContext = 2512
    Caption = 'OK'
    Default = True
    TabOrder = 4
    TabStop = False
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 101
    Top = 342
    Width = 75
    Height = 25
    HelpContext = 2511
    Cancel = True
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 5
    TabStop = False
  end
  object HilfeButton: TButton
    Left = 182
    Top = 342
    Width = 75
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 6
    TabStop = False
  end
end
