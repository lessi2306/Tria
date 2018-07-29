object ImportDialog: TImportDialog
  Left = 265
  Top = 279
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Import aus Textdatei'
  ClientHeight = 458
  ClientWidth = 753
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
  object FeldLabel: TLabel
    Left = 14
    Top = 95
    Width = 144
    Height = 15
    HelpContext = 3602
    Caption = 'Zuordnung der Datenfelder'
  end
  object VorschauLabel: TLabel
    Left = 304
    Top = 95
    Width = 84
    Height = 15
    HelpContext = 3603
    Caption = 'Importvorschau'
  end
  object PflichtfeldLabel: TLabel
    Left = 13
    Top = 416
    Width = 277
    Height = 15
    Caption = 'die mit  *  gekennzeichneten Felder sind Pflichtfelder'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGrayText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ImpDateiLabel: TLabel
    Left = 13
    Top = 26
    Width = 62
    Height = 15
    HelpContext = 3603
    Caption = 'Importdatei'
  end
  object ExcelSheetLabel: TLabel
    Left = 304
    Top = 1
    Width = 68
    Height = 15
    HelpContext = 3603
    Caption = 'Tabellenblatt'
  end
  object TextErkZeichenLabel: TLabel
    Left = 551
    Top = 79
    Width = 123
    Height = 15
    HelpContext = 3603
    Caption = 'Texterkennungszeichen'
  end
  object FeldValueListEditor: TValueListEditor
    Left = 10
    Top = 111
    Width = 278
    Height = 298
    HelpContext = 3602
    DefaultColWidth = 118
    DefaultRowHeight = 19
    ScrollBars = ssVertical
    TabOrder = 3
    TitleCaptions.Strings = (
      'Tria Datenfeld'
      'Feldname in Importdatei')
    OnClick = FeldValueListEditorClick
    OnStringsChange = FeldValueListEditorStringsChange
    ColWidths = (
      118
      154)
  end
  object HilfeButton: TButton
    Left = 666
    Top = 422
    Width = 75
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 8
    TabStop = False
    OnClick = HilfeButtonClick
  end
  object CancelButton: TButton
    Left = 583
    Top = 422
    Width = 75
    Height = 25
    HelpContext = 3606
    Caption = 'Abbrechen'
    TabOrder = 7
    TabStop = False
    OnClick = CancelButtonClick
  end
  object ImportButton: TButton
    Left = 475
    Top = 422
    Width = 101
    Height = 25
    HelpContext = 3605
    Caption = 'Daten &Importieren'
    TabOrder = 6
    TabStop = False
    OnClick = ImportButtonClick
  end
  object VorschauGrid: TStringGrid
    Left = 300
    Top = 111
    Width = 441
    Height = 298
    HelpContext = 3603
    ColCount = 4
    DefaultColWidth = 99
    DefaultRowHeight = 19
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goThumbTracking]
    TabOrder = 4
    OnClick = VorschauGridClick
  end
  object PruefButton: TButton
    Left = 387
    Top = 422
    Width = 81
    Height = 25
    HelpContext = 3604
    Caption = 'Daten &Pr'#252'fen'
    TabOrder = 5
    TabStop = False
    OnClick = PruefButtonClick
  end
  object ExcelSheetCB: TComboBox
    Left = 300
    Top = 72
    Width = 249
    Height = 23
    Style = csDropDownList
    TabOrder = 2
    OnChange = ExcelSheetCBChange
  end
  object ImpDateiEdit: TTriaEdit
    Left = 10
    Top = 42
    Width = 257
    Height = 21
    HelpContext = 3001
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 9
    Text = 'Import'
  end
  object TextErkZeichenCB: TComboBox
    Left = 679
    Top = 76
    Width = 62
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = '<kein>'
    OnChange = TextErkZeichenCBChange
    Items.Strings = (
      '<kein>'
      '"'
      #39)
  end
  object TrennzeichenRG: TRadioGroup
    Left = 300
    Top = 20
    Width = 441
    Height = 45
    Caption = 'Trennzeichen in Importdatei'
    Columns = 5
    ItemIndex = 0
    Items.Strings = (
      'Semikolon'
      'Tabstopp'
      'Komma'
      'Leerzeichen'
      'Anderes')
    TabOrder = 0
    TabStop = True
    OnClick = TrennzeichenRGClick
  end
  object SonstEdit: TTriaEdit
    Left = 714
    Top = 37
    Width = 19
    Height = 21
    HelpContext = 3651
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 1
    ParentFont = False
    TabOrder = 10
    OnChange = TrennzeichenRGClick
    OnClick = TrennzeichenRGClick
  end
  object ExcelApplication: TExcelApplication
    AutoConnect = False
    ConnectKind = ckNewInstance
    AutoQuit = False
    Left = 40
    Top = 184
  end
  object ExcelWorkSheet: TExcelWorksheet
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 216
    Top = 184
  end
  object ExcelWorkbook: TExcelWorkbook
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 128
    Top = 184
  end
end
