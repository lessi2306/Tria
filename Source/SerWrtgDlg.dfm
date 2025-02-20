object SerWrtgDialog: TSerWrtgDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Serienwertung definieren'
  ClientHeight = 666
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object WettkCBLabel: TLabel
    Left = 21
    Top = 24
    Width = 59
    Height = 15
    HelpContext = 1001
    Caption = 'Wettkampf'
    OnClick = WettkCBLabelClick
  end
  object WettkCB: TComboBox
    Left = 84
    Top = 21
    Width = 448
    Height = 23
    HelpContext = 1001
    AutoComplete = False
    Style = csDropDownList
    TabOrder = 0
    OnChange = WettkCBChange
  end
  object TabControl1: TTabControl
    Left = 16
    Top = 71
    Width = 516
    Height = 545
    TabOrder = 1
    Tabs.Strings = (
      'Teilnehmer'
      'Mannschaften')
    TabIndex = 0
    OnChange = TabControl1Change
    OnChanging = TabControl1Changing
    object SerWrtgGB: TGroupBox
      Left = 16
      Top = 34
      Width = 484
      Height = 165
      Caption = 'Wertungsoptionen '
      TabOrder = 0
      OnClick = SerWrtgGBClick
      object StreichErgLabel: TLabel
        Left = 8
        Top = 33
        Width = 92
        Height = 15
        Caption = 'Streichergebnisse'
        OnClick = StreichErgLabelClick
      end
      object StreichOrtLabel: TLabel
        Left = 166
        Top = 33
        Width = 106
        Height = 15
        Caption = 'Mindestwettk'#228'mpfe'
        OnClick = StreichOrtLabelClick
      end
      object PflichtWkLabel: TLabel
        Left = 8
        Top = 70
        Width = 97
        Height = 15
        Caption = 'Pflichtwettk'#228'mpfe'
        OnClick = PflichtWkLabelClick
      end
      object PunktGleichOrtLabel: TLabel
        Left = 8
        Top = 133
        Width = 180
        Height = 15
        Caption = 'Bei gleichem Rang gilt Wertung in'
        OnClick = PunktGleichOrtLabelClick
      end
      object AkJahrLabel1: TLabel
        Left = 336
        Top = 27
        Width = 79
        Height = 15
        Caption = 'Wettkampfjahr'
        OnClick = AkJahrLabelClick
      end
      object AkJahrLabel2: TLabel
        Left = 336
        Top = 40
        Width = 86
        Height = 15
        Caption = 'f'#252'r Altersklassen'
        OnClick = AkJahrLabelClick
      end
      object StreichErgEdit: TTriaMaskEdit
        Left = 103
        Top = 30
        Width = 24
        Height = 22
        HelpContext = 1002
        EditMask = '09;0; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 0
        Text = '0'
        OnChange = StreichErgEditChange
        UpDown = StreichErgUpDown
      end
      object PunktGleichOrtDB: TComboBox
        Left = 194
        Top = 130
        Width = 281
        Height = 23
        HelpContext = 1003
        AutoComplete = False
        Style = csDropDownList
        TabOrder = 7
        OnChange = OrtDBChange
        OnClick = OrtDBChange
      end
      object PflichtWkOrt1DB: TComboBox
        Left = 194
        Top = 67
        Width = 281
        Height = 23
        HelpContext = 1004
        AutoComplete = False
        Style = csDropDownList
        TabOrder = 5
        OnChange = OrtDBChange
        OnClick = OrtDBChange
      end
      object PflichtWkOrt2DB: TComboBox
        Left = 194
        Top = 93
        Width = 281
        Height = 23
        HelpContext = 1004
        AutoComplete = False
        Style = csDropDownList
        TabOrder = 6
        OnChange = OrtDBChange
        OnClick = OrtDBChange
      end
      object PflichtWkArtDB: TComboBox
        Left = 110
        Top = 67
        Width = 79
        Height = 23
        HelpContext = 1004
        AutoComplete = False
        Style = csDropDownList
        TabOrder = 4
        OnChange = PflichtWkArtDBChange
        Items.Strings = (
          '0'
          '1'
          '1 von 2'
          '2')
      end
      object StreichErgUpDown: TTriaUpDown
        Left = 127
        Top = 29
        Width = 16
        Height = 24
        HelpContext = 1002
        Max = 8
        TabOrder = 1
        Edit = StreichErgEdit
      end
      object StreichOrtEdit: TTriaMaskEdit
        Left = 275
        Top = 30
        Width = 24
        Height = 22
        HelpContext = 1005
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
        OnChange = StreichOrtEditChange
        UpDown = StreichOrtUpDown
      end
      object StreichOrtUpDown: TTriaUpDown
        Left = 299
        Top = 29
        Width = 16
        Height = 24
        HelpContext = 1002
        Max = 8
        TabOrder = 3
        Edit = StreichOrtEdit
      end
      object AkJahrCB: TComboBox
        Left = 424
        Top = 30
        Width = 51
        Height = 23
        HelpContext = 1006
        AutoComplete = False
        Style = csDropDownList
        DropDownCount = 10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnChange = AkJahrCBChange
      end
    end
    object WertungPanel: TPanel
      Left = 124
      Top = 31
      Width = 297
      Height = 23
      BevelEdges = []
      BevelOuter = bvNone
      Caption = '(Staffel- und Teamwettbewerbe werden nicht gewertet)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object WertungsPunkteGB: TGroupBox
      Left = 16
      Top = 213
      Width = 484
      Height = 317
      Caption = 'Berechnungsoptionen'
      TabOrder = 1
      object WrtgPktGB: TGroupBox
        Left = 242
        Top = 130
        Width = 135
        Height = 176
        Caption = 'Punkte pro Platzierung'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object RngVonLabel: TLabel
          Left = 18
          Top = 30
          Width = 48
          Height = 15
          Caption = 'Platz von'
        end
        object PktVonLabel: TLabel
          Left = 8
          Top = 95
          Width = 60
          Height = 15
          Caption = 'Punkte von'
        end
        object RngBisLabel: TLabel
          Left = 49
          Top = 56
          Width = 15
          Height = 15
          Caption = 'bis'
        end
        object PktBisLabel: TLabel
          Left = 49
          Top = 147
          Width = 15
          Height = 15
          Caption = 'bis'
        end
        object PktVonEdit: TTriaMaskEdit
          Left = 70
          Top = 92
          Width = 40
          Height = 22
          HelpContext = 1012
          EditMask = '0999;0; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          TabOrder = 2
          OnChange = WrtgPktRecChange
          UpDown = PktVonUpDown
        end
        object PktIncrEdit: TTriaMaskEdit
          Left = 70
          Top = 118
          Width = 40
          Height = 22
          HelpContext = 1012
          EditMask = '0999;0; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          TabOrder = 4
          OnChange = WrtgPktRecChange
          UpDown = PktIncrUpDown
        end
        object RngBisEdit: TTriaMaskEdit
          Left = 70
          Top = 53
          Width = 40
          Height = 22
          HelpContext = 1011
          EditMask = '0999;0; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          TabOrder = 1
          OnChange = WrtgPktRecChange
          UpDown = RngBisUpDown
        end
        object PktIncrCB: TComboBox
          Left = 8
          Top = 118
          Width = 57
          Height = 23
          HelpContext = 1012
          AutoComplete = False
          Style = csDropDownList
          TabOrder = 3
          OnChange = WrtgPktRecChange
          Items.Strings = (
            'Inkr.'
            'Dekr.')
        end
        object RngVonEdit: TTriaMaskEdit
          Left = 70
          Top = 27
          Width = 40
          Height = 22
          HelpContext = 1011
          EditMask = '0999;0; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          TabOrder = 0
          OnChange = WrtgPktRecChange
          UpDown = RngVonUpDown
        end
        object RngVonUpDown: TTriaUpDown
          Left = 110
          Top = 26
          Width = 16
          Height = 24
          HelpContext = 1011
          TabOrder = 5
          Edit = RngVonEdit
        end
        object RngBisUpDown: TTriaUpDown
          Left = 110
          Top = 52
          Width = 16
          Height = 24
          HelpContext = 1011
          TabOrder = 6
          Edit = RngBisEdit
        end
        object PktVonUpDown: TTriaUpDown
          Left = 110
          Top = 91
          Width = 16
          Height = 24
          HelpContext = 1012
          TabOrder = 7
          Edit = PktVonEdit
        end
        object PktIncrUpDown: TTriaUpDown
          Left = 110
          Top = 117
          Width = 16
          Height = 24
          HelpContext = 1012
          TabOrder = 8
          Edit = PktIncrEdit
        end
        object PktBisEdit: TTriaEdit
          Left = 70
          Top = 144
          Width = 40
          Height = 22
          HelpContext = 1012
          TabStop = False
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          Text = '0000'
        end
      end
      object AendButton: TButton
        Left = 389
        Top = 136
        Width = 86
        Height = 25
        HelpContext = 1020
        Caption = #196'n&dern'
        TabOrder = 2
        TabStop = False
        OnClick = AendButtonClick
      end
      object DefaultButton: TButton
        Left = 389
        Top = 281
        Width = 86
        Height = 25
        HelpContext = 1023
        Caption = '&Standard Liste'
        TabOrder = 7
        TabStop = False
        OnClick = DefaultButtonClick
      end
      object EinfuegButton: TButton
        Left = 389
        Top = 254
        Width = 86
        Height = 25
        HelpContext = 1022
        Caption = 'Liste &einf'#252'gen'
        TabOrder = 6
        TabStop = False
        OnClick = EinfuegButtonClick
      end
      object KopierButton: TButton
        Left = 389
        Top = 227
        Width = 86
        Height = 25
        HelpContext = 1021
        Caption = 'Liste &kopieren'
        TabOrder = 5
        TabStop = False
        OnClick = KopierButtonClick
      end
      object LoeschButton: TButton
        Left = 389
        Top = 190
        Width = 86
        Height = 25
        HelpContext = 106
        Caption = '&L'#246'schen'
        TabOrder = 4
        TabStop = False
        OnClick = LoeschButtonClick
      end
      object NeuButton: TButton
        Left = 389
        Top = 163
        Width = 86
        Height = 25
        HelpContext = 105
        Caption = '&Neu'
        TabOrder = 3
        TabStop = False
        OnClick = NeuButtonClick
      end
      object WrtgPktHeaderGrid: TStringGrid
        Left = 24
        Top = 136
        Width = 204
        Height = 41
        HelpContext = 1010
        TabStop = False
        Color = clBtnFace
        DefaultColWidth = 37
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        TabOrder = 8
        OnClick = WrtgPktHeaderGridClick
        ColWidths = (
          37
          37
          37
          37
          37)
      end
      object WrtgPktGrid: TStringGrid
        Left = 24
        Top = 152
        Width = 204
        Height = 154
        HelpContext = 1010
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        DefaultColWidth = 37
        DefaultRowHeight = 17
        FixedCols = 0
        RowCount = 4
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
        ScrollBars = ssVertical
        TabOrder = 0
        OnClick = WrtgPktGridClick
      end
      object SerPktRngUpRB: TRadioButton
        Left = 8
        Top = 60
        Width = 215
        Height = 17
        HelpContext = 1007
        Caption = 'Punkte entsprechend der Platzierung'
        TabOrder = 9
        OnClick = SerPktRBClick
      end
      object SerPktRngDownRB: TRadioButton
        Left = 8
        Top = 89
        Width = 215
        Height = 17
        HelpContext = 1008
        Caption = 'Punkte umgekehrt zur Platzierung'
        TabOrder = 10
        OnClick = SerPktRBClick
      end
      object SerPktFlexRB: TRadioButton
        Left = 8
        Top = 118
        Width = 215
        Height = 17
        HelpContext = 1009
        Caption = 'Punkte nach folgender Definition:'
        TabOrder = 11
        OnClick = SerPktRBClick
      end
      object WrtgPktGBPanel: TPanel
        Left = 250
        Top = 115
        Width = 120
        Height = 15
        Alignment = taLeftJustify
        BevelEdges = []
        BevelOuter = bvNone
        Caption = 'Punkte pro Platzierung'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object RngUpCB: TCheckBox
        Left = 228
        Top = 60
        Width = 251
        Height = 17
        HelpContext = 1007
        Caption = 'Punkte <nicht gewertet> gleich f'#252'r alle Orte'
        TabOrder = 13
        OnClick = SerPktRBClick
      end
      object RngDwnCB: TCheckBox
        Left = 228
        Top = 89
        Width = 251
        Height = 17
        HelpContext = 1008
        Caption = 'Punkte <Platz 1> gleich f'#252'r alle Orte'
        TabOrder = 14
        OnClick = SerPktRBClick
      end
      object SerWrtgZeitRB: TRadioButton
        Left = 8
        Top = 31
        Width = 215
        Height = 17
        HelpContext = 1013
        Caption = 'Serienwertung durch Zeitaddition'
        TabOrder = 15
        OnClick = SerPktRBClick
      end
    end
  end
  object UebernehmButton: TButton
    Left = 212
    Top = 627
    Width = 79
    Height = 25
    HelpContext = 1024
    Caption = #220'&bernehmen'
    TabOrder = 3
    TabStop = False
    OnClick = UebernehmButtonClick
  end
  object OkButton: TButton
    Left = 296
    Top = 627
    Width = 75
    Height = 25
    HelpContext = 103
    Caption = 'OK'
    TabOrder = 4
    TabStop = False
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 377
    Top = 627
    Width = 75
    Height = 25
    HelpContext = 102
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 5
    TabStop = False
  end
  object HilfeButton: TButton
    Left = 457
    Top = 627
    Width = 75
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 6
    TabStop = False
    OnClick = HilfeButtonClick
  end
  object UebernehmAlleButton: TButton
    Left = 16
    Top = 627
    Width = 159
    Height = 25
    HelpContext = 1024
    Caption = '&F'#252'r alle Wettk. '#220'bernehmen'
    TabOrder = 2
    TabStop = False
    OnClick = UebernehmAlleButtonClick
  end
end
