object ZtEinlDialog: TZtEinlDialog
  Left = 189
  Top = 661
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Zeiterfassungsdatei einlesen'
  ClientHeight = 595
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 15
  object WettkLabel: TLabel
    Left = 19
    Top = 216
    Width = 59
    Height = 15
    HelpContext = 2201
    Caption = 'Wettkampf'
    OnClick = WettkLabelClick
  end
  object DateiLabel: TLabel
    Left = 107
    Top = 21
    Width = 57
    Height = 15
    HelpContext = 2201
    Caption = 'Dateiname'
    OnClick = DateiLabelClick
  end
  object FormatLabel: TLabel
    Left = 19
    Top = 21
    Width = 44
    Height = 15
    Caption = 'Dateityp'
    OnClick = FormatLabelClick
  end
  object AbschnittGB: TGroupBox
    Left = 16
    Top = 337
    Width = 387
    Height = 140
    HelpContext = 2202
    Caption = 'Stoppzeiten'
    TabOrder = 4
    object Abschn1Edit: TTriaEdit
      Left = 88
      Top = 28
      Width = 87
      Height = 19
      HelpContext = 2202
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
      Text = 'Schwimm'
      OnClick = AbschnEditClick
    end
    object Abschn2Edit: TTriaEdit
      Left = 88
      Top = 55
      Width = 87
      Height = 19
      HelpContext = 2202
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
      Text = 'Bike'
      OnClick = AbschnEditClick
    end
    object Abschn3Edit: TTriaEdit
      Left = 88
      Top = 82
      Width = 87
      Height = 19
      HelpContext = 2202
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 10
      Text = 'Run'
      OnClick = AbschnEditClick
    end
    object Abschn4Edit: TTriaEdit
      Left = 88
      Top = 109
      Width = 87
      Height = 19
      HelpContext = 2202
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 11
      Text = 'Kanu'
      OnClick = AbschnEditClick
    end
    object Abschn1CB: TCheckBox
      Left = 16
      Top = 30
      Width = 72
      Height = 17
      HelpContext = 2202
      Caption = 'Abschn. 1'
      TabOrder = 0
    end
    object Abschn2CB: TCheckBox
      Left = 16
      Top = 57
      Width = 72
      Height = 17
      HelpContext = 2202
      Caption = 'Abschn. 2'
      TabOrder = 1
    end
    object Abschn3CB: TCheckBox
      Left = 16
      Top = 84
      Width = 72
      Height = 17
      HelpContext = 2202
      Caption = 'Abschn. 3'
      TabOrder = 2
    end
    object Abschn4CB: TCheckBox
      Left = 16
      Top = 111
      Width = 72
      Height = 17
      HelpContext = 2202
      Caption = 'Abschn. 4'
      TabOrder = 3
    end
    object Abschn5CB: TCheckBox
      Left = 210
      Top = 30
      Width = 72
      Height = 17
      HelpContext = 2202
      Caption = 'Abschn. 5'
      TabOrder = 4
    end
    object Abschn5Edit: TTriaEdit
      Left = 283
      Top = 28
      Width = 87
      Height = 19
      HelpContext = 2202
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 12
      Text = 'Abs. 5'
      OnClick = AbschnEditClick
    end
    object Abschn6Edit: TTriaEdit
      Left = 283
      Top = 55
      Width = 87
      Height = 19
      HelpContext = 2202
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 13
      Text = 'Abs. 6'
      OnClick = AbschnEditClick
    end
    object Abschn6CB: TCheckBox
      Left = 210
      Top = 57
      Width = 72
      Height = 17
      HelpContext = 2202
      Caption = 'Abschn. 6'
      TabOrder = 5
    end
    object Abschn7CB: TCheckBox
      Left = 210
      Top = 84
      Width = 72
      Height = 17
      HelpContext = 2202
      Caption = 'Abschn. 7'
      TabOrder = 6
    end
    object Abschn7Edit: TTriaEdit
      Left = 283
      Top = 82
      Width = 87
      Height = 19
      HelpContext = 2202
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 14
      Text = 'Abs. 7'
      OnClick = AbschnEditClick
    end
    object Abschn8Edit: TTriaEdit
      Left = 283
      Top = 109
      Width = 87
      Height = 19
      HelpContext = 2202
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 15
      Text = 'Abs. 8'
      OnClick = AbschnEditClick
    end
    object Abschn8CB: TCheckBox
      Left = 210
      Top = 111
      Width = 72
      Height = 17
      HelpContext = 2202
      Caption = 'Abschn. 8'
      TabOrder = 7
    end
  end
  object OkButton: TButton
    Left = 124
    Top = 555
    Width = 114
    Height = 25
    HelpContext = 2205
    Caption = 'Daten einlesen'
    Default = True
    TabOrder = 5
    TabStop = False
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 245
    Top = 555
    Width = 75
    Height = 25
    HelpContext = 2204
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 6
    TabStop = False
  end
  object WettkCB: TComboBox
    Left = 16
    Top = 232
    Width = 387
    Height = 23
    HelpContext = 2201
    AutoComplete = False
    Style = csDropDownList
    TabOrder = 3
    OnChange = WettkCBChange
  end
  object HilfeButton: TButton
    Left = 328
    Top = 555
    Width = 75
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 7
    TabStop = False
    OnClick = HilfeButtonClick
  end
  object DateiCB: TComboBox
    Left = 101
    Top = 36
    Width = 271
    Height = 23
    HelpContext = 2207
    AutoComplete = False
    AutoCloseUp = True
    Style = csDropDownList
    TabOrder = 1
  end
  object DateiBtn: TBitBtn
    Left = 378
    Top = 35
    Width = 25
    Height = 25
    HelpContext = 2210
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C000000000000000000000000000000000000000000001F7C1F7C
      1F7C1F7C1F7C0000000000420042004200420042004200420042004200001F7C
      1F7C1F7C1F7C0000E07F00000042004200420042004200420042004200420000
      1F7C1F7C1F7C0000FF7FE07F0000004200420042004200420042004200420042
      00001F7C1F7C0000E07FFF7FE07F000000420042004200420042004200420042
      004200001F7C0000FF7FE07FFF7FE07F00000000000000000000000000000000
      0000000000000000E07FFF7FE07FFF7FE07FFF7FE07FFF7FE07F00001F7C1F7C
      1F7C1F7C1F7C0000FF7FE07FFF7FE07FFF7FE07FFF7FE07FFF7F00001F7C1F7C
      1F7C1F7C1F7C0000E07FFF7FE07F00000000000000000000000000001F7C1F7C
      1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
      000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C0000
      1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    TabOrder = 2
    OnClick = DateiBtnClick
  end
  object EinzelStartGB: TGroupBox
    Left = 16
    Top = 273
    Width = 387
    Height = 48
    HelpContext = 2206
    Caption = 'Startzeit '
    TabOrder = 8
    object EinzelStartCB: TCheckBox
      Left = 16
      Top = 23
      Width = 354
      Height = 17
      HelpContext = 2206
      Caption = 'Einzelstart Abschnitt 1'
      TabOrder = 0
    end
  end
  object LetzterTlnCB: TCheckBox
    Left = 32
    Top = 518
    Width = 338
    Height = 17
    HelpContext = 2208
    Caption = 'Zuletzt erfasster Teilnehmer fokussieren'
    TabOrder = 9
  end
  object ZeitenBehaltenCB: TCheckBox
    Left = 32
    Top = 489
    Width = 362
    Height = 17
    HelpContext = 2209
    Caption = 'Bislang eingelesene Zeiten behalten'
    TabOrder = 10
  end
  object FormatCB: TComboBox
    Left = 16
    Top = 36
    Width = 78
    Height = 23
    HelpContext = 2211
    AutoComplete = False
    Style = csDropDownList
    TabOrder = 0
    OnChange = FormatCBChange
  end
  object FormatGB: TGroupBox
    Left = 16
    Top = 77
    Width = 387
    Height = 121
    Caption = 'Dateiformat'
    TabOrder = 11
    object SnrPosLabel1: TLabel
      Left = 221
      Top = 30
      Width = 70
      Height = 15
      HelpContext = 2212
      Caption = 'Startnummer'
    end
    object ZeitPosLabel1: TLabel
      Left = 221
      Top = 60
      Width = 37
      Height = 15
      HelpContext = 2212
      Caption = 'Uhrzeit'
    end
    object ZeitFormLabel: TLabel
      Left = 221
      Top = 90
      Width = 56
      Height = 15
      HelpContext = 2212
      Caption = 'Zeitformat'
    end
    object SnrPosLabel2: TLabel
      Left = 294
      Top = 30
      Width = 32
      Height = 15
      HelpContext = 2212
      Caption = 'Spalte'
    end
    object ZeitPosLabel2: TLabel
      Left = 294
      Top = 60
      Width = 32
      Height = 15
      Caption = 'Spalte'
    end
    object TrennZeichenLabel: TLabel
      Left = 16
      Top = 60
      Width = 100
      Height = 15
      HelpContext = 2212
      Caption = 'Trennzeichen-Zeile'
    end
    object TrennZeitLabel: TLabel
      Left = 16
      Top = 90
      Width = 95
      Height = 15
      HelpContext = 2814
      Caption = 'Trennzeichen-Zeit'
    end
    object SnrPosEdit: TTriaMaskEdit
      Left = 330
      Top = 27
      Width = 24
      Height = 22
      HelpContext = 2212
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
      UpDown = SnrPosUpDown
    end
    object SnrPosUpDown: TTriaUpDown
      Left = 354
      Top = 26
      Width = 16
      Height = 24
      HelpContext = 2212
      Min = 1
      Max = 99
      TabOrder = 1
      Edit = SnrPosEdit
    end
    object ZeitPosEdit: TTriaMaskEdit
      Left = 330
      Top = 57
      Width = 24
      Height = 22
      HelpContext = 2212
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
      UpDown = ZeitPosUpDown
    end
    object ZeitPosUpDown: TTriaUpDown
      Left = 354
      Top = 56
      Width = 16
      Height = 24
      HelpContext = 2212
      Min = 1
      Max = 99
      TabOrder = 3
      Edit = ZeitPosEdit
    end
    object HeaderCB: TCheckBox
      Left = 16
      Top = 30
      Width = 159
      Height = 17
      HelpContext = 2212
      Caption = 'Kopfzeile (wird ignoriert)'
      TabOrder = 4
    end
    object ZeitFormCB: TComboBox
      Left = 283
      Top = 87
      Width = 87
      Height = 23
      HelpContext = 2212
      AutoComplete = False
      Style = csDropDownList
      DropDownCount = 3
      ItemIndex = 2
      TabOrder = 5
      Text = 'Hundertstel'
      OnChange = WettkCBChange
      Items.Strings = (
        'Sekunde'
        'Zehntel'
        'Hundertstel')
    end
    object TrennZeichenCB: TComboBox
      Left = 120
      Top = 54
      Width = 55
      Height = 23
      HelpContext = 2212
      Style = csDropDownList
      DropDownCount = 4
      ItemIndex = 3
      TabOrder = 6
      Text = 'TAB'
      Items.Strings = (
        '";"'
        '","'
        '" "'
        'TAB')
    end
    object TrennZeitCB: TComboBox
      Left = 120
      Top = 87
      Width = 55
      Height = 23
      HelpContext = 2814
      Style = csDropDownList
      DropDownCount = 2
      ItemIndex = 1
      MaxLength = 1
      TabOrder = 7
      Text = 'ohne'
      Items.Strings = (
        '":"'
        'ohne')
    end
  end
end
