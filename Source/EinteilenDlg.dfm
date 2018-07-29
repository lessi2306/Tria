object EinteilenDialog: TEinteilenDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Teilnehmer einteilen'
  ClientHeight = 514
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object WettkCBLabel: TLabel
    Left = 19
    Top = 23
    Width = 59
    Height = 15
    HelpContext = 3701
    Caption = 'Wettkampf'
    OnClick = WettkCBLabelClick
  end
  object SGrpGridLabel: TLabel
    Left = 210
    Top = 84
    Width = 62
    Height = 15
    HelpContext = 3703
    Caption = 'Startgruppe'
    FocusControl = SGrpGrid
    OnClick = SGrpGridLabelClick
  end
  object SBhnLabel: TLabel
    Left = 266
    Top = 202
    Width = 51
    Height = 15
    HelpContext = 3705
    Caption = 'Startbahn'
    FocusControl = SBhnGrid
    OnClick = SBhnLabelClick
  end
  object WettkCB: TComboBox
    Left = 16
    Top = 38
    Width = 498
    Height = 23
    HelpContext = 3701
    AutoComplete = False
    Style = csDropDownList
    TabOrder = 0
    OnChange = WettkCBChange
  end
  object SGrpGrid: TTriaGrid
    Left = 214
    Top = 99
    Width = 300
    Height = 87
    HelpContext = 3703
    ColCount = 5
    DefaultRowHeight = 17
    FixedCols = 0
    RowCount = 12
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
    ScrollBars = ssBoth
    TabOrder = 1
    OnClick = SGrpGridClick
    OnDrawCell = SGrpGridDrawCell
    ColWidths = (
      61
      44
      42
      47
      64)
  end
  object SnrBereichGB: TGroupBox
    Left = 16
    Top = 364
    Width = 230
    Height = 93
    HelpContext = 3706
    Caption = 'Startnummern zuteilen'
    TabOrder = 2
    object SnrBisLabel: TLabel
      Left = 114
      Top = 50
      Width = 15
      Height = 15
      HelpContext = 3706
      Caption = 'bis'
    end
    object SnrVonLabel: TLabel
      Left = 12
      Top = 50
      Width = 20
      Height = 15
      HelpContext = 3706
      Caption = 'von'
    end
    object SnrVonEdit: TTriaMaskEdit
      Left = 36
      Top = 47
      Width = 39
      Height = 22
      HelpContext = 3706
      EditMask = '0999;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 0
      UpDown = SnrVonUpDown
    end
    object SnrBisEdit: TTriaMaskEdit
      Left = 132
      Top = 47
      Width = 39
      Height = 22
      HelpContext = 3706
      EditMask = '0999;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 2
      UpDown = SnrBisUpDown
    end
    object SnrVonUpDown: TTriaUpDown
      Left = 75
      Top = 46
      Width = 16
      Height = 24
      HelpContext = 3706
      Min = 1
      Max = 99
      Position = 88
      TabOrder = 1
      Edit = SnrVonEdit
    end
    object SnrBisUpDown: TTriaUpDown
      Left = 171
      Top = 46
      Width = 16
      Height = 24
      HelpContext = 3706
      Min = 1
      Max = 99
      Position = 88
      TabOrder = 3
      Edit = SnrBisEdit
    end
  end
  object OkButton: TButton
    Left = 263
    Top = 473
    Width = 77
    Height = 25
    HelpContext = 3708
    Caption = '&Einteilen'
    Default = True
    TabOrder = 3
    TabStop = False
    OnClick = OkButtonClick
  end
  object HilfeButton: TButton
    Left = 437
    Top = 473
    Width = 77
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 4
    TabStop = False
    OnClick = HilfeButtonClick
  end
  object CancelButton: TButton
    Left = 350
    Top = 473
    Width = 77
    Height = 25
    HelpContext = 102
    Caption = '&Schlie'#223'en'
    ModalResult = 2
    TabOrder = 5
    TabStop = False
  end
  object SBhnGrid: TStringGrid
    Left = 263
    Top = 217
    Width = 117
    Height = 122
    HelpContext = 3705
    ColCount = 2
    DefaultRowHeight = 17
    FixedCols = 0
    RowCount = 12
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
    ScrollBars = ssVertical
    TabOrder = 6
    OnClick = SBhnGridClick
    ColWidths = (
      47
      62)
  end
  object SGrpGB: TGroupBox
    Left = 16
    Top = 93
    Width = 183
    Height = 93
    HelpContext = 3702
    Caption = 'Startgruppen zuteilen'
    TabOrder = 7
    object SGrpAlleRB: TRadioButton
      Left = 12
      Top = 35
      Width = 113
      Height = 17
      HelpContext = 3702
      Caption = 'Alle Startgruppen'
      TabOrder = 0
      OnClick = SGrpRBClick
    end
    object SGrpMarkiertRB: TRadioButton
      Left = 12
      Top = 65
      Width = 159
      Height = 17
      HelpContext = 3702
      Caption = 'Nur markierte Startgruppe'
      TabOrder = 1
      OnClick = SGrpRBClick
    end
  end
  object SBhnGB: TGroupBox
    Left = 16
    Top = 211
    Width = 230
    Height = 128
    HelpContext = 3704
    Caption = 'Startbahnen zuteilen'
    TabOrder = 8
    object TlnProBahnLabel2: TLabel
      Left = 109
      Top = 100
      Width = 110
      Height = 15
      HelpContext = 3704
      Caption = 'Teilnehmer pro Bahn'
      OnClick = TlnProBahnLabelClick
    end
    object TlnProBahnLabel1: TLabel
      Left = 14
      Top = 100
      Width = 45
      Height = 15
      HelpContext = 3704
      Caption = 'Maximal'
      OnClick = TlnProBahnLabelClick
    end
    object SBhnMarkiertRB: TRadioButton
      Left = 12
      Top = 65
      Width = 169
      Height = 17
      HelpContext = 3704
      Caption = 'Nur markierte Startbahn'
      TabOrder = 0
      OnClick = SBhnRBClick
    end
    object TlnProBahnEdit: TTriaMaskEdit
      Left = 64
      Top = 97
      Width = 25
      Height = 22
      HelpContext = 3704
      EditMask = '09;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 1
      UpDown = TlnProBahnUpDown
    end
    object TlnProBahnUpDown: TTriaUpDown
      Left = 89
      Top = 96
      Width = 16
      Height = 24
      HelpContext = 3704
      Max = 0
      TabOrder = 2
      Edit = TlnProBahnEdit
    end
    object SBhnAlleRB: TRadioButton
      Left = 14
      Top = 35
      Width = 111
      Height = 17
      HelpContext = 3704
      Caption = 'Alle Startbahnen'
      TabOrder = 3
      OnClick = SBhnRBClick
    end
  end
  object UebersichtGB: TGroupBox
    Left = 263
    Top = 364
    Width = 251
    Height = 93
    HelpContext = 3709
    Caption = 'Gew'#228'hlte Teilnehmer in Liste'
    TabOrder = 9
    object NichtEingeteiltLabel: TLabel
      Left = 44
      Top = 35
      Width = 117
      Height = 15
      HelpContext = 3709
      Caption = '- noch nicht eingeteilt'
    end
    object EingeteiltLabel: TLabel
      Left = 44
      Top = 65
      Width = 95
      Height = 15
      HelpContext = 3709
      Caption = '- bereits eingeteilt'
    end
    object NichtEingeteiltEdit: TTriaMaskEdit
      Left = 166
      Top = 31
      Width = 42
      Height = 22
      HelpContext = 3709
      TabStop = False
      Color = clBtnFace
      EditMask = '9999;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object EingeteiltEdit: TTriaMaskEdit
      Left = 166
      Top = 61
      Width = 42
      Height = 22
      HelpContext = 3709
      TabStop = False
      Color = clBtnFace
      EditMask = '9999;0; '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = '0'
    end
  end
  object EinteilungBeibehaltenCB: TCheckBox
    Left = 16
    Top = 477
    Width = 225
    Height = 17
    HelpContext = 3707
    Caption = 'bestehende Einteilungen beibehalten'
    TabOrder = 10
  end
end
