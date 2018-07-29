object RfidEinlDialog: TRfidEinlDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'RFID-Codes importieren'
  ClientHeight = 336
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object DateiLabel: TLabel
    Left = 19
    Top = 14
    Width = 51
    Height = 13
    HelpContext = 2101
    Caption = 'Dateiname'
  end
  object DateiEdit: TEdit
    Left = 16
    Top = 30
    Width = 276
    Height = 21
    HelpContext = 2101
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 4
    Text = 'DateiEdit'
  end
  object FormatGB: TGroupBox
    Left = 16
    Top = 73
    Width = 307
    Height = 152
    Caption = 'Zeilenformat'
    TabOrder = 0
    object SnrLabel1: TLabel
      Left = 16
      Top = 72
      Width = 62
      Height = 13
      HelpContext = 2102
      Caption = 'Startnummer'
    end
    object RfidLabel1: TLabel
      Left = 16
      Top = 115
      Width = 53
      Height = 13
      HelpContext = 2102
      Caption = 'RFID-Code'
    end
    object SnrLabel2: TLabel
      Left = 88
      Top = 72
      Width = 30
      Height = 13
      HelpContext = 2102
      Caption = 'Spalte'
    end
    object RfidLabel2: TLabel
      Left = 88
      Top = 115
      Width = 30
      Height = 13
      HelpContext = 2102
      Caption = 'Spalte'
    end
    object TrennZeichenLabel: TLabel
      Left = 175
      Top = 71
      Width = 64
      Height = 13
      HelpContext = 2102
      Caption = 'Trennzeichen'
    end
    object SnrEdit: TTriaMaskEdit
      Left = 120
      Top = 68
      Width = 24
      Height = 22
      HelpContext = 2102
      EditMask = '09;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 1
      Text = '0'
      UpDown = SnrPosUpDown
    end
    object SnrPosUpDown: TTriaUpDown
      Left = 144
      Top = 67
      Width = 16
      Height = 24
      HelpContext = 2102
      Min = 1
      Max = 99
      TabOrder = 2
      Edit = SnrEdit
    end
    object RfidEdit: TTriaMaskEdit
      Left = 120
      Top = 111
      Width = 24
      Height = 22
      HelpContext = 2102
      EditMask = '09;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 2
      ParentFont = False
      TabOrder = 4
      Text = '0'
      UpDown = TriaUpDown1
    end
    object TriaUpDown1: TTriaUpDown
      Left = 144
      Top = 110
      Width = 16
      Height = 24
      HelpContext = 2102
      Min = 1
      Max = 99
      TabOrder = 5
      Edit = RfidEdit
    end
    object HeaderCB: TCheckBox
      Left = 16
      Top = 31
      Width = 277
      Height = 17
      HelpContext = 2102
      Caption = 'Kopfzeile mit Feldnamen vorhanden (wird ignoriert)'
      TabOrder = 0
    end
    object TrennZeichenCB: TComboBox
      Left = 242
      Top = 66
      Width = 47
      Height = 21
      HelpContext = 2102
      Style = csDropDownList
      DropDownCount = 4
      ItemIndex = 3
      TabOrder = 3
      Text = 'TAB'
      Items.Strings = (
        '";"'
        '","'
        '" "'
        'TAB')
    end
  end
  object OkButton: TButton
    Left = 75
    Top = 295
    Width = 75
    Height = 25
    HelpContext = 2105
    Caption = 'Importieren'
    Default = True
    TabOrder = 2
    TabStop = False
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 162
    Top = 295
    Width = 75
    Height = 25
    HelpContext = 2104
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 3
    TabStop = False
  end
  object LoeschenGB: TGroupBox
    Left = 16
    Top = 240
    Width = 307
    Height = 42
    TabOrder = 1
    object LoeschenCB: TCheckBox
      Left = 16
      Top = 12
      Width = 225
      Height = 17
      HelpContext = 2103
      Caption = 'Alle bislang definierten RFID-Codes l'#246'schen'
      TabOrder = 0
    end
  end
  object DateiBtn: TBitBtn
    Left = 298
    Top = 29
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
    TabOrder = 5
    OnClick = DateiBtnClick
  end
  object HilfeButton: TButton
    Left = 248
    Top = 295
    Width = 75
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 6
    TabStop = False
    OnClick = HilfeButtonClick
  end
end
