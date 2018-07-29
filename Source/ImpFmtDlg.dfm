object ImpFmtDialog: TImpFmtDialog
  Left = 276
  Top = 301
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'W'#228'hle Dateiformat f'#252'r Import'
  ClientHeight = 177
  ClientWidth = 282
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
  object DateiLabel: TLabel
    Left = 11
    Top = 20
    Width = 54
    Height = 15
    HelpContext = 1405
    Caption = 'Quelldatei'
  end
  object DateiRG: TRadioGroup
    Left = 8
    Top = 78
    Width = 265
    Height = 52
    HelpContext = 3661
    Caption = 'Format der Quelldatei'
    Columns = 3
    Items.Strings = (
      'Tria Datei'
      'Textdatei'
      'Excel Datei')
    TabOrder = 0
  end
  object DateiEdit: TTriaEdit
    Left = 8
    Top = 35
    Width = 265
    Height = 21
    HelpContext = 3601
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
    Text = 'Dateiname'
  end
  object OkButton: TButton
    Left = 115
    Top = 142
    Width = 75
    Height = 25
    HelpContext = 103
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    TabStop = False
  end
  object CancelButton: TButton
    Left = 198
    Top = 142
    Width = 75
    Height = 25
    HelpContext = 102
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 3
    TabStop = False
  end
end
