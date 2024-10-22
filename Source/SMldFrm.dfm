object SMldFrame: TSMldFrame
  Left = 0
  Top = 0
  Width = 836
  Height = 246
  HorzScrollBar.Visible = False
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  TabStop = True
  Visible = False
  object SMldFrmPanel: TPanel
    Left = 0
    Top = 0
    Width = 836
    Height = 246
    Align = alClient
    BevelWidth = 2
    ParentBackground = False
    TabOrder = 9
  end
  object SMldAendButton: TButton
    Left = 741
    Top = 36
    Width = 80
    Height = 25
    HelpContext = 104
    Caption = #220'&bernehmen'
    TabOrder = 2
    TabStop = False
    OnClick = SMldAendButtonClick
  end
  object SMldNeuButton: TButton
    Left = 741
    Top = 65
    Width = 80
    Height = 25
    HelpContext = 105
    Caption = '&Neu'
    TabOrder = 3
    TabStop = False
    OnClick = SMldNeuButtonClick
  end
  object SMldLoeschButton: TButton
    Left = 741
    Top = 94
    Width = 80
    Height = 25
    HelpContext = 106
    Caption = '&L'#246'schen'
    TabOrder = 4
    TabStop = False
    OnClick = SMldLoeschButtonClick
  end
  object HilfeButton: TButton
    Left = 741
    Top = 209
    Width = 80
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 7
    TabStop = False
    OnClick = HilfeButtonClick
  end
  object SMldCloseButton: TButton
    Left = 741
    Top = 180
    Width = 80
    Height = 25
    HelpContext = 102
    Caption = 'Schlie'#223'en'
    TabOrder = 6
    TabStop = False
    OnClick = SMldCloseButtonClick
  end
  object SMldGB: TGroupBox
    Left = 377
    Top = 32
    Width = 348
    Height = 202
    Caption = 'Vereinsmelder'
    TabOrder = 1
    object SMldNameLabel: TLabel
      Left = 15
      Top = 18
      Width = 32
      Height = 15
      HelpContext = 1503
      Caption = 'Name'
      FocusControl = SMldNameEdit
      OnClick = SMldNameLabelClick
    end
    object SMldVNameLabel: TLabel
      Left = 195
      Top = 18
      Width = 47
      Height = 15
      HelpContext = 1503
      Caption = 'Vorname'
      FocusControl = SMldVNameEdit
      OnClick = SMldVNameLabelClick
    end
    object SMldVereinlabel: TLabel
      Left = 15
      Top = 64
      Width = 100
      Height = 15
      HelpContext = 1504
      Caption = 'Verein/Mannschaft'
      FocusControl = SMldVereinCB
      OnClick = SMldVereinlabelClick
    end
    object SMldStrasseLabel: TLabel
      Left = 15
      Top = 110
      Width = 36
      Height = 15
      HelpContext = 1506
      Caption = 'Strasse'
      FocusControl = SMldStrasseEdit
      OnClick = SMldStrasseLabelClick
    end
    object SMldOrtLabel: TLabel
      Left = 83
      Top = 156
      Width = 17
      Height = 15
      HelpContext = 1506
      Caption = 'Ort'
      FocusControl = SMldOrtEdit
      OnClick = SMldOrtLabelClick
    end
    object SMldHausNrLabel: TLabel
      Left = 291
      Top = 110
      Width = 16
      Height = 15
      HelpContext = 1506
      Caption = 'Nr.'
      FocusControl = SMLdHausNrEdit
      OnClick = SMldHausNrLabelClick
    end
    object SMldPLZLabel: TLabel
      Left = 15
      Top = 156
      Width = 20
      Height = 15
      HelpContext = 1506
      Caption = 'PLZ'
      FocusControl = SMldPLZEdit
      OnClick = SMldPLZLabelClick
    end
    object SMldEMailLabel: TLabel
      Left = 195
      Top = 64
      Width = 34
      Height = 15
      HelpContext = 1503
      Caption = 'E-Mail'
      FocusControl = SMldEMailEdit
      OnClick = SMldEMailLabelClick
    end
    object SMldVNameEdit: TTriaEdit
      Left = 192
      Top = 32
      Width = 142
      Height = 21
      HelpContext = 1503
      TabOrder = 1
      Text = '012345678901234'
      OnChange = SMldEditChange
    end
    object SMldNameEdit: TTriaEdit
      Left = 12
      Top = 32
      Width = 168
      Height = 21
      HelpContext = 1503
      TabOrder = 0
      Text = '012345678901234567890'
      OnChange = SMldEditChange
    end
    object SMldVereinCB: TComboBox
      Left = 12
      Top = 78
      Width = 168
      Height = 23
      HelpContext = 1504
      AutoComplete = False
      DropDownCount = 16
      TabOrder = 2
      Text = '01234567890123456789'
      OnChange = SMldEditChange
    end
    object SMldStrasseEdit: TTriaEdit
      Left = 12
      Top = 124
      Width = 264
      Height = 21
      HelpContext = 1506
      TabOrder = 3
      Text = '012345678901234567890123456789'
      OnChange = SMldEditChange
    end
    object SMldOrtEdit: TTriaEdit
      Left = 80
      Top = 170
      Width = 254
      Height = 21
      HelpContext = 1506
      TabOrder = 6
      Text = '012345678901234567890123456789'
      OnChange = SMldEditChange
    end
    object SMLdHausNrEdit: TTriaEdit
      Left = 288
      Top = 124
      Width = 46
      Height = 21
      HelpContext = 1506
      TabOrder = 4
      Text = '01234'
      OnChange = SMldEditChange
    end
    object SMldPLZEdit: TTriaEdit
      Left = 12
      Top = 170
      Width = 56
      Height = 21
      HelpContext = 1506
      TabOrder = 5
      Text = 'D-700000'
      OnChange = SMldEditChange
    end
    object SMldEMailEdit: TTriaEdit
      Left = 192
      Top = 78
      Width = 142
      Height = 21
      HelpContext = 1506
      TabOrder = 7
      Text = 'tria@selten.de'
      OnChange = SMldEditChange
    end
  end
  object SMldHeaderPanel: TPanel
    Left = 2
    Top = 2
    Width = 832
    Height = 21
    Align = alCustom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Color = 13003057
    ParentBackground = False
    TabOrder = 8
    object SMldHeaderLabel: TLabel
      Left = 6
      Top = 3
      Width = 115
      Height = 15
      AutoSize = False
      Caption = 'Vereinsmeldung'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
  end
  object BtnPanel: TPanel
    Left = 794
    Top = 2
    Width = 42
    Height = 21
    Align = alCustom
    BevelOuter = bvNone
    Color = 13003057
    ParentBackground = False
    TabOrder = 10
    object biHelpBtn: TBitBtn
      Left = 2
      Top = 2
      Width = 18
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Glyph.Data = {
        BA040000424DBA0400000000000036040000280000000C0000000B0000000100
        08000000000084000000C40E0000C40E00000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
        A400000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0010FFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFF1000FFFF0000FFFFFFFFFFFF0000FF
        FF0000FFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = biHelpBtnClick
    end
    object biSystemBtn: TBitBtn
      Left = 22
      Top = 2
      Width = 18
      Height = 17
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Glyph.Data = {
        BA040000424DBA0400000000000036040000280000000C0000000B0000000100
        08000000000084000000130B0000130B00000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600FFFFFF00FCFCFC00F9F9F900F9F9F800F8F9F800F8F8F900F9F8F800F8F8
        F800F7F7F700F6F6F600F5F5F500F4F4F400F3F3F300F2F2F200F2F2EF00F0F0
        F000F3F4E600EFEFEF00EEEEEE00F1EFE800EDEDED00ECECEC00F4F3DB00EBEB
        EA00EAEAEA00E9E9E900E8E8E800F0EDD700E7E6E700E5E5E500CBEDDE00E4E4
        E400F7F2C000E2E2E200EDEACE00E6E6D800E1E1E200EBE8CF00E0E0E000DFDF
        DF00DEDEDE00EAEDB900DDDCDF00E6E3CA00E7DCD600DBDBDB00E0DED300DADA
        DA00E2DCD000D9D9D900D5D3E500DCDDCE00E1DBCF00D8D8D800E0DBCF00E1DB
        CE00F4EBA700EBE8B000E0DACE00D7D7D700E1D7D200DFD9CD00D6D6D600DFD9
        CB00DED8CD00D5D5D500DED8CA00CCCAEC00DCD9C800DEE2B500D4D4D400DED7
        C900D3D3D300F2E99B00D7D4CD00DCD5C600D1D1D100D0D0D000D8D3C700E3E0
        A900EEE59B00C5C4EA00B6DDBD00CFCFCF00DAD3C300CECECE00D9D2C100D3CF
        C700CCCCCC00E7E19700D4CEC300CBCBCB00D3D0BE00D7CFBE00DFDF9A00D5D9
        A900CACACA00BCBAED00D6D2B300D5D7A900C9C9C800E9DF9100E1DF9300C8C8
        C800D1CBBE00D4CCB900DADF9100C7C7C700D3CBB800C6C6C600D0CDB300C5C5
        C500CDC9B900D3C1C600D0CDAF00C4C4C400C3C4C400D0C8B700C4C3C400C3C3
        C300D1C8B400DADC8800C2C2C200CFC6B100CEC5B000CEC5AB00CBC3AF00CDC3
        AE00C5C0B500BDBDBD00DDBEAE00D4D28800AAA9E700CBC1AB00D0CB9400CAC0
        AB00CAC0A900C8BFAA00C9BFA800C5BFA900C4C3A000C9BEA700BEBAB100C8BD
        A600C4BCA600C7BCA400C6BBA200C9C78900C1B9A700B5B5B300C4B9A000C4B9
        9F00C0BC9900C1B79F00C0B6A000B7B3A900CCABB000AFAFAF009A9BDE00B5B0
        9F00ADACA800B6B29200AEA99F00C1B87A00B1AB97009092CD00BFB67100A7A4
        9D00B8B07E008588DD00AEAE7F00A6A195009F9E9C00B8B06B00A79F8D009997
        94009D988B00A8A273007D7DC6009F99820093929200AAA4640090909000A1A1
        5F0095908400A89C62006C70C800A19D5B009BA05700A2985E00928D77008988
        8400A0925B00938C5E0084807900565CCD0094895500837E6800595DB6003E45
        D70074716000454BB4006A69660076714F00474BA9002C35DD006C685B00383D
        A800645F54003B3FA1002A32BF001D26D9003A3F9D00625D4B002E34A000111B
        D0001720BD00514D46000B15BD00151EA50045402D003837330035332E002826
        2200131312000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000A0A0A0A0A0A
        0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A00000A0A0A0A00000A0A0A0A
        0A00000A0A00000A0A0A0A0A0A0A000000000A0A0A0A0A0A0A0A0A00000A0A0A
        0A0A0A0A0A0A000000000A0A0A0A0A0A0A00000A0A00000A0A0A0A0A00000A0A
        0A0A00000A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A}
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnClick = SMldCloseButtonClick
    end
  end
  object SMldSortGB: TGroupBox
    Left = 16
    Top = 162
    Width = 345
    Height = 72
    HelpContext = 1502
    TabOrder = 11
    object NameSortRB: TRadioButton
      Left = 14
      Top = 47
      Width = 137
      Height = 17
      HelpContext = 1502
      Caption = 'nach Name sortieren'
      TabOrder = 0
      OnClick = SMldSortRGClick
    end
    object VereinSortRB: TRadioButton
      Left = 195
      Top = 47
      Width = 130
      Height = 17
      HelpContext = 1502
      Caption = 'nach Verein sortieren'
      TabOrder = 1
      OnClick = SMldSortRGClick
    end
  end
  object SMldGrid: TTriaGrid
    Left = 16
    Top = 36
    Width = 345
    Height = 167
    HelpContext = 1501
    ColCount = 2
    FixedCols = 0
    RowCount = 16
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
    ScrollBars = ssBoth
    TabOrder = 0
    OnClick = SMldGridClick
    OnDrawCell = SMldGridDrawCell
    RowHeights = (
      14
      14
      14
      14
      14
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
  object AlleSMldLoeschButton: TButton
    Left = 741
    Top = 123
    Width = 80
    Height = 25
    HelpContext = 1507
    Caption = '&Alle L'#246'schen'
    TabOrder = 5
    TabStop = False
    OnClick = AlleSMldLoeschButtonClick
  end
end
