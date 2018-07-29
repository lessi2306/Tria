object WkWahlDialog: TWkWahlDialog
  Left = 269
  Top = 359
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'W'#228'hle Wettkampf'
  ClientHeight = 143
  ClientWidth = 352
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
  object Label2: TLabel
    Left = 16
    Top = 50
    Width = 186
    Height = 15
    Caption = 'W'#228'hle Wettkampf f'#252'r Datenimport:'
  end
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 318
    Height = 15
    Caption = 'Daten werden nur f'#252'r einen einzelnen Wettkampf importiert.'
  end
  object WettkCB: TComboBox
    Left = 16
    Top = 66
    Width = 320
    Height = 23
    HelpContext = 2201
    AutoComplete = False
    Style = csDropDownList
    TabOrder = 0
  end
  object OkButton: TButton
    Left = 176
    Top = 105
    Width = 75
    Height = 25
    HelpContext = 2205
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    TabStop = False
  end
  object CancelButton: TButton
    Left = 261
    Top = 105
    Width = 75
    Height = 25
    HelpContext = 2204
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 2
    TabStop = False
  end
end
