object SGrpDialog: TSGrpDialog
  Left = 403
  Top = 407
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Startgruppen definieren'
  ClientHeight = 451
  ClientWidth = 536
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
  object SGrpLabel: TLabel
    Left = 16
    Top = 8
    Width = 69
    Height = 15
    HelpContext = 1101
    Caption = 'Startgruppen'
    FocusControl = SGrpGrid
    OnClick = SGrpLabelClick
  end
  object CancelButton: TButton
    Left = 360
    Top = 414
    Width = 77
    Height = 25
    HelpContext = 102
    Caption = 'Abbrechen'
    TabOrder = 1
    TabStop = False
    OnClick = CancelButtonClick
  end
  object OkButton: TButton
    Left = 273
    Top = 414
    Width = 77
    Height = 25
    HelpContext = 103
    Caption = 'OK'
    Default = True
    TabOrder = 3
    TabStop = False
    OnClick = OkButtonClick
  end
  object SGrpPageControl: TPageControl
    Left = 12
    Top = 168
    Width = 512
    Height = 230
    ActivePage = AllgemeinTS
    TabOrder = 2
    TabStop = False
    OnChange = SGrpPageControlChange
    OnChanging = SGrpPageControlChanging
    object AllgemeinTS: TTabSheet
      Caption = 'Allgemein'
      OnShow = AllgemeinTSShow
      object WettkCBLabel: TLabel
        Left = 16
        Top = 74
        Width = 59
        Height = 15
        HelpContext = 1201
        Caption = 'Wettkampf'
      end
      object NameLabel: TLabel
        Left = 16
        Top = 29
        Width = 32
        Height = 15
        Caption = 'Name'
      end
      object WettkCB: TComboBox
        Left = 80
        Top = 71
        Width = 409
        Height = 23
        HelpContext = 1202
        AutoComplete = False
        Style = csDropDownList
        TabOrder = 1
        OnChange = WettkCBChange
      end
      object StartNrGB: TGroupBox
        Left = 16
        Top = 119
        Width = 239
        Height = 66
        HelpContext = 1203
        Caption = 'Startnummernbereich'
        TabOrder = 2
        OnClick = StartNrGBClick
        object SnrVonLabel: TLabel
          Left = 32
          Top = 34
          Width = 20
          Height = 15
          Caption = 'Von'
          FocusControl = SnrVonEdit
          OnClick = SnrVonLabelClick
        end
        object SnrBisLabel: TLabel
          Left = 145
          Top = 34
          Width = 15
          Height = 15
          Caption = 'Bis'
          FocusControl = SnrBisEdit
          OnClick = SnrBisLabelClick
        end
        object SnrVonEdit: TTriaMaskEdit
          Left = 56
          Top = 30
          Width = 42
          Height = 22
          EditMask = '0999;0; '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          TabOrder = 0
          Text = '0'
          OnChange = SnrEditChange
          UpDown = SnrVonUpDown
        end
        object SnrBisEdit: TTriaMaskEdit
          Left = 163
          Top = 30
          Width = 42
          Height = 22
          EditMask = '0999;0; '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          TabOrder = 1
          Text = '0'
          OnChange = SnrEditChange
          UpDown = SnrBisUpDown
        end
        object SnrVonUpDown: TTriaUpDown
          Left = 98
          Top = 29
          Width = 16
          Height = 24
          TabOrder = 2
          Edit = SnrVonEdit
        end
        object SnrBisUpDown: TTriaUpDown
          Left = 205
          Top = 29
          Width = 16
          Height = 24
          TabOrder = 3
          Edit = SnrBisEdit
        end
      end
      object StarterGB: TGroupBox
        Left = 272
        Top = 119
        Width = 217
        Height = 66
        Caption = 'Anzahl Starter'
        TabOrder = 3
        object StarterMaxLabel: TLabel
          Left = 32
          Top = 34
          Width = 22
          Height = 15
          HelpContext = 1204
          Caption = 'Max'
        end
        object StarterIstLabel: TLabel
          Left = 142
          Top = 34
          Width = 12
          Height = 15
          HelpContext = 1205
          Caption = 'Ist'
        end
        object StarterMaxEdit: TTriaMaskEdit
          Left = 57
          Top = 30
          Width = 42
          Height = 22
          HelpContext = 1204
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
        object StarterIstEdit: TTriaMaskEdit
          Left = 158
          Top = 30
          Width = 42
          Height = 22
          HelpContext = 1205
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
      object NameEdit: TTriaEdit
        Left = 80
        Top = 26
        Width = 93
        Height = 22
        HelpContext = 1201
        TabOrder = 0
        Text = 'SGrp-Name'
        OnChange = NameEditChange
      end
    end
    object StartMode1TS: TTabSheet
      Caption = 'Start - Abschnitte 1-4'
      ImageIndex = 1
      OnShow = StartMode1TSShow
      object Abschnitt1GB: TGroupBox
        Left = 8
        Top = 14
        Width = 116
        Height = 177
        HelpContext = 1301
        Caption = 'Abschnitt 1'
        TabOrder = 0
        OnClick = AbschnittGBClick
        object Start1FormatLabel: TLabel
          Left = 75
          Top = 101
          Width = 35
          Height = 15
          HelpContext = 1301
          Caption = 'mm:ss'
        end
        object StartZeit1Label: TLabel
          Left = 13
          Top = 130
          Width = 42
          Height = 15
          HelpContext = 1301
          Caption = 'Startzeit'
          OnClick = StartZeitLabelClick
        end
        object Start1MassenStartRB: TRadioButton
          Left = 10
          Top = 56
          Width = 81
          Height = 17
          HelpContext = 1301
          Caption = 'Massenstart'
          TabOrder = 1
          TabStop = True
          OnClick = StartModeRBClick
        end
        object Start1JagdStartRB: TRadioButton
          Left = 10
          Top = 82
          Width = 76
          Height = 17
          HelpContext = 1301
          Caption = 'Jagdstart'
          TabOrder = 2
          TabStop = True
          OnClick = StartModeRBClick
        end
        object Start1DeltaEdit: TMinZeitEdit
          Left = 27
          Top = 98
          Width = 48
          Height = 21
          HelpContext = 1301
          EditMask = '!90:00;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          TabOrder = 3
          Text = '00:00'
          OnChange = Start1DeltaEditChange
          OnExit = Start1DeltaEditExit
        end
        object StartZeit1Edit: TUhrZeitEdit
          Left = 10
          Top = 145
          Width = 94
          Height = 21
          HelpContext = 1301
          EditMask = '!90:00:00,00;1;_'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 11
          ParentFont = False
          TabOrder = 4
          Text = '00:00:00,00'
          OnChange = StartZeitEditChange
          OnExit = StartZeitEditExit
        end
        object Start1OhnePauseRB: TRadioButton
          Left = 10
          Top = 30
          Width = 96
          Height = 17
          HelpContext = 1301
          Caption = 'Einzelstart'
          TabOrder = 0
          TabStop = True
          OnClick = StartModeRBClick
        end
      end
      object Abschnitt2GB: TGroupBox
        Left = 132
        Top = 14
        Width = 116
        Height = 177
        HelpContext = 1302
        Caption = 'Abschnitt 2'
        TabOrder = 1
        OnClick = AbschnittGBClick
        object StartZeit2Label: TLabel
          Left = 13
          Top = 130
          Width = 42
          Height = 15
          HelpContext = 1302
          Caption = 'Startzeit'
          OnClick = StartZeitLabelClick
        end
        object Start2MassenStartRB: TRadioButton
          Left = 10
          Top = 56
          Width = 81
          Height = 17
          HelpContext = 1302
          Caption = 'Massenstart'
          TabOrder = 1
          TabStop = True
          OnClick = StartModeRBClick
        end
        object Start2JagdStartRB: TRadioButton
          Left = 10
          Top = 82
          Width = 81
          Height = 17
          HelpContext = 1302
          Caption = 'Jagdstart'
          TabOrder = 2
          TabStop = True
          OnClick = StartModeRBClick
        end
        object StartZeit2Edit: TUhrZeitEdit
          Left = 10
          Top = 145
          Width = 94
          Height = 21
          HelpContext = 1302
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
          OnChange = StartZeitEditChange
          OnExit = StartZeitEditExit
        end
        object Start2OhnePauseRB: TRadioButton
          Left = 10
          Top = 30
          Width = 89
          Height = 17
          HelpContext = 1302
          Caption = 'Ohne Pause'
          TabOrder = 0
          TabStop = True
          OnClick = StartModeRBClick
        end
      end
      object Abschnitt3GB: TGroupBox
        Left = 256
        Top = 14
        Width = 116
        Height = 177
        HelpContext = 1302
        Caption = 'Abschnitt 3'
        TabOrder = 2
        OnClick = AbschnittGBClick
        object StartZeit3Label: TLabel
          Left = 13
          Top = 130
          Width = 42
          Height = 15
          HelpContext = 1302
          Caption = 'Startzeit'
          OnClick = StartZeitLabelClick
        end
        object Start3MassenStartRB: TRadioButton
          Left = 10
          Top = 56
          Width = 81
          Height = 17
          HelpContext = 1302
          Caption = 'Massenstart'
          TabOrder = 1
          TabStop = True
          OnClick = StartModeRBClick
        end
        object Start3JagdStartRB: TRadioButton
          Left = 10
          Top = 82
          Width = 76
          Height = 17
          HelpContext = 1302
          Caption = 'Jagdstart'
          TabOrder = 2
          TabStop = True
          OnClick = StartModeRBClick
        end
        object StartZeit3Edit: TUhrZeitEdit
          Left = 10
          Top = 145
          Width = 94
          Height = 21
          HelpContext = 1302
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
          OnChange = StartZeitEditChange
          OnExit = StartZeitEditExit
        end
        object Start3OhnePauseRB: TRadioButton
          Left = 10
          Top = 30
          Width = 89
          Height = 17
          HelpContext = 1302
          Caption = 'Ohne Pause'
          TabOrder = 0
          TabStop = True
          OnClick = StartModeRBClick
        end
      end
      object Abschnitt4GB: TGroupBox
        Left = 380
        Top = 14
        Width = 116
        Height = 177
        HelpContext = 1302
        Caption = 'Abschnitt 4'
        TabOrder = 3
        OnClick = AbschnittGBClick
        object StartZeit4Label: TLabel
          Left = 13
          Top = 130
          Width = 42
          Height = 15
          HelpContext = 1302
          Caption = 'Startzeit'
          OnClick = StartZeitLabelClick
        end
        object Start4MassenStartRB: TRadioButton
          Left = 10
          Top = 56
          Width = 81
          Height = 17
          HelpContext = 1302
          Caption = 'Massenstart'
          TabOrder = 1
          TabStop = True
          OnClick = StartModeRBClick
        end
        object Start4JagdStartRB: TRadioButton
          Left = 10
          Top = 82
          Width = 76
          Height = 17
          HelpContext = 1302
          Caption = 'Jagdstart'
          TabOrder = 2
          TabStop = True
          OnClick = StartModeRBClick
        end
        object StartZeit4Edit: TUhrZeitEdit
          Left = 10
          Top = 145
          Width = 94
          Height = 21
          HelpContext = 1302
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
          OnChange = StartZeitEditChange
          OnExit = StartZeitEditExit
        end
        object Start4OhnePauseRB: TRadioButton
          Left = 10
          Top = 30
          Width = 89
          Height = 17
          HelpContext = 1302
          Caption = 'Ohne Pause'
          TabOrder = 0
          TabStop = True
          OnClick = StartModeRBClick
        end
      end
    end
    object StartMode2TS: TTabSheet
      Caption = 'Start - Abschnitte 5-8'
      ImageIndex = 2
      OnShow = StartMode2TSShow
      object Abschnitt6GB: TGroupBox
        Left = 132
        Top = 31
        Width = 116
        Height = 160
        HelpContext = 1302
        Caption = 'Abschnitt 6'
        TabOrder = 1
        OnClick = AbschnittGBClick
        object StartZeit6Label: TLabel
          Left = 13
          Top = 114
          Width = 42
          Height = 15
          HelpContext = 1302
          Caption = 'Startzeit'
          OnClick = StartZeitLabelClick
        end
        object Start6MassenStartRB: TRadioButton
          Left = 10
          Top = 61
          Width = 81
          Height = 17
          HelpContext = 1302
          Caption = 'Massenstart'
          TabOrder = 1
          TabStop = True
          OnClick = StartModeRBClick
        end
        object Start6JagdStartRB: TRadioButton
          Left = 10
          Top = 87
          Width = 81
          Height = 17
          HelpContext = 1302
          Caption = 'Jagdstart'
          TabOrder = 2
          TabStop = True
          OnClick = StartModeRBClick
        end
        object StartZeit6Edit: TUhrZeitEdit
          Left = 10
          Top = 128
          Width = 94
          Height = 21
          HelpContext = 1302
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
          OnChange = StartZeitEditChange
          OnExit = StartZeitEditExit
        end
        object Start6OhnePauseRB: TRadioButton
          Left = 10
          Top = 35
          Width = 89
          Height = 17
          HelpContext = 1302
          Caption = 'Ohne Pause'
          TabOrder = 0
          TabStop = True
          OnClick = StartModeRBClick
        end
      end
      object Abschnitt7GB: TGroupBox
        Left = 256
        Top = 31
        Width = 116
        Height = 160
        HelpContext = 1302
        Caption = 'Abschnitt 7'
        TabOrder = 2
        OnClick = AbschnittGBClick
        object StartZeit7Label: TLabel
          Left = 13
          Top = 114
          Width = 42
          Height = 15
          HelpContext = 1302
          Caption = 'Startzeit'
          OnClick = StartZeitLabelClick
        end
        object Start7MassenStartRB: TRadioButton
          Left = 10
          Top = 61
          Width = 81
          Height = 17
          HelpContext = 1302
          Caption = 'Massenstart'
          TabOrder = 1
          TabStop = True
          OnClick = StartModeRBClick
        end
        object Start7JagdStartRB: TRadioButton
          Left = 10
          Top = 87
          Width = 76
          Height = 17
          HelpContext = 1302
          Caption = 'Jagdstart'
          TabOrder = 2
          TabStop = True
          OnClick = StartModeRBClick
        end
        object StartZeit7Edit: TUhrZeitEdit
          Left = 10
          Top = 128
          Width = 94
          Height = 21
          HelpContext = 1302
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
          OnChange = StartZeitEditChange
          OnExit = StartZeitEditExit
        end
        object Start7OhnePauseRB: TRadioButton
          Left = 10
          Top = 35
          Width = 89
          Height = 17
          HelpContext = 1302
          Caption = 'Ohne Pause'
          TabOrder = 0
          TabStop = True
          OnClick = StartModeRBClick
        end
      end
      object Abschnitt8GB: TGroupBox
        Left = 380
        Top = 31
        Width = 116
        Height = 160
        HelpContext = 1302
        Caption = 'Abschnitt 8'
        TabOrder = 3
        OnClick = AbschnittGBClick
        object StartZeit8Label: TLabel
          Left = 13
          Top = 114
          Width = 42
          Height = 15
          HelpContext = 1302
          Caption = 'Startzeit'
          OnClick = StartZeitLabelClick
        end
        object Start8MassenStartRB: TRadioButton
          Left = 10
          Top = 61
          Width = 81
          Height = 17
          HelpContext = 1302
          Caption = 'Massenstart'
          TabOrder = 1
          TabStop = True
          OnClick = StartModeRBClick
        end
        object Start8JagdStartRB: TRadioButton
          Left = 10
          Top = 87
          Width = 76
          Height = 17
          HelpContext = 1302
          Caption = 'Jagdstart'
          TabOrder = 2
          TabStop = True
          OnClick = StartModeRBClick
        end
        object StartZeit8Edit: TUhrZeitEdit
          Left = 10
          Top = 128
          Width = 94
          Height = 21
          HelpContext = 1302
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
          OnChange = StartZeitEditChange
          OnExit = StartZeitEditExit
        end
        object Start8OhnePauseRB: TRadioButton
          Left = 10
          Top = 35
          Width = 89
          Height = 17
          HelpContext = 1302
          Caption = 'Ohne Pause'
          TabOrder = 0
          TabStop = True
          OnClick = StartModeRBClick
        end
      end
      object Abschnitt5GB: TGroupBox
        Left = 8
        Top = 31
        Width = 116
        Height = 160
        HelpContext = 1302
        Caption = 'Abschnitt 5'
        TabOrder = 0
        OnClick = AbschnittGBClick
        object StartZeit5Label: TLabel
          Left = 13
          Top = 114
          Width = 42
          Height = 15
          HelpContext = 1302
          Caption = 'Startzeit'
          OnClick = StartZeitLabelClick
        end
        object Start5MassenStartRB: TRadioButton
          Left = 10
          Top = 61
          Width = 81
          Height = 17
          HelpContext = 1302
          Caption = 'Massenstart'
          TabOrder = 1
          TabStop = True
          OnClick = StartModeRBClick
        end
        object Start5JagdStartRB: TRadioButton
          Left = 10
          Top = 87
          Width = 81
          Height = 17
          HelpContext = 1302
          Caption = 'Jagdstart'
          TabOrder = 2
          TabStop = True
          OnClick = StartModeRBClick
        end
        object StartZeit5Edit: TUhrZeitEdit
          Left = 10
          Top = 128
          Width = 94
          Height = 21
          HelpContext = 1302
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
          OnChange = StartZeitEditChange
          OnExit = StartZeitEditExit
        end
        object Start5OhnePauseRB: TRadioButton
          Left = 10
          Top = 35
          Width = 89
          Height = 17
          HelpContext = 1302
          Caption = 'Ohne Pause'
          TabOrder = 0
          TabStop = True
          OnClick = StartModeRBClick
        end
      end
    end
  end
  object SGrpGrid: TTriaGrid
    Left = 12
    Top = 24
    Width = 418
    Height = 124
    HelpContext = 1101
    ColCount = 4
    RowCount = 16
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
    ScrollBars = ssBoth
    TabOrder = 0
    OnClick = SGrpGridClick
    OnDrawCell = SGrpGridDrawCell
    ColWidths = (
      51
      39
      39
      105)
  end
  object AendButton: TButton
    Left = 443
    Top = 24
    Width = 81
    Height = 25
    HelpContext = 104
    Caption = #220'&bernehmen'
    TabOrder = 4
    TabStop = False
    OnClick = AendButtonClick
  end
  object NeuButton: TButton
    Left = 443
    Top = 59
    Width = 81
    Height = 25
    HelpContext = 105
    Caption = '&Neu'
    TabOrder = 5
    TabStop = False
    OnClick = NeuButtonClick
  end
  object LoeschButton: TButton
    Left = 443
    Top = 94
    Width = 81
    Height = 25
    HelpContext = 106
    Caption = '&L'#246'schen'
    TabOrder = 6
    TabStop = False
    OnClick = LoeschButtonClick
  end
  object HilfeButton: TButton
    Left = 447
    Top = 414
    Width = 77
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 7
    TabStop = False
    OnClick = HilfeButtonClick
  end
end
