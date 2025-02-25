object ZtEinlReport: TZtEinlReport
  Left = 255
  Top = 424
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Einlesen beendet'
  ClientHeight = 427
  ClientWidth = 884
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
  object AktionsLabel: TLabel
    Left = 16
    Top = 72
    Width = 102
    Height = 15
    Caption = 'Eingelesen wurden:'
  end
  object OKGridLabel: TLabel
    Left = 16
    Top = 134
    Width = 78
    Height = 15
    Caption = #220'bernommen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NOkGridLabel: TLabel
    Left = 443
    Top = 134
    Width = 109
    Height = 15
    Caption = 'Nicht '#252'bernommen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ZeitformatLabel: TLabel
    Left = 16
    Top = 96
    Width = 470
    Height = 15
    AutoSize = False
    Caption = 'Eingelesen in Hundertstel-Sekunden,  '#252'bernommen in Sekunden '
  end
  object WettkLabel1: TLabel
    Left = 16
    Top = 16
    Width = 62
    Height = 15
    Caption = 'Wettkampf:'
  end
  object AbschnLabel1: TLabel
    Left = 16
    Top = 40
    Width = 54
    Height = 15
    Caption = 'Abschnitt:'
  end
  object WettkLabel2: TLabel
    Left = 89
    Top = 16
    Width = 34
    Height = 15
    Caption = 'Wettk.'
  end
  object AbschnLabel2: TLabel
    Left = 89
    Top = 40
    Width = 43
    Height = 15
    Caption = 'Abschn.'
  end
  object SortGB: TGroupBox
    Left = 277
    Top = 386
    Width = 337
    Height = 27
    TabOrder = 4
    object ZeitSortRB: TRadioButton
      Left = 14
      Top = 5
      Width = 139
      Height = 17
      Caption = 'nach Uhrzeit sortieren'
      TabOrder = 0
      OnClick = SortRGClick
    end
    object SnrSortRB: TRadioButton
      Left = 159
      Top = 5
      Width = 174
      Height = 17
      Caption = 'nach Startnummer sortieren'
      TabOrder = 1
      OnClick = SortRGClick
    end
  end
  object Panel2: TPanel
    Left = 270
    Top = 149
    Width = 97
    Height = 223
    BevelOuter = bvNone
    TabOrder = 5
  end
  object OkButton: TButton
    Left = 797
    Top = 386
    Width = 75
    Height = 27
    Caption = 'Schlie'#223'en'
    Default = True
    ModalResult = 1
    TabOrder = 2
    TabStop = False
  end
  object SpeichernButton: TButton
    Left = 12
    Top = 386
    Width = 118
    Height = 27
    Caption = 'Report speichern...'
    TabOrder = 3
    OnClick = SpeichernButtonClick
  end
  object OkGrid: TTriaGrid
    Left = 12
    Top = 149
    Width = 417
    Height = 223
    ColCount = 5
    RowCount = 8
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
    ScrollBars = ssBoth
    TabOrder = 0
    OnDrawCell = OkGridDrawCell
    RowHeights = (
      14
      14
      14
      14
      14
      24
      23
      24)
  end
  object NOkGrid: TTriaGrid
    Left = 440
    Top = 149
    Width = 432
    Height = 223
    ColCount = 3
    RowCount = 8
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect, goThumbTracking]
    ScrollBars = ssBoth
    TabOrder = 1
    OnDrawCell = NOkGridDrawCell
    RowHeights = (
      14
      14
      14
      14
      14
      24
      24
      24)
  end
end
