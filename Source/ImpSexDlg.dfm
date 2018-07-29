object ImpSexDialog: TImpSexDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Datenpr'#252'fung'
  ClientHeight = 271
  ClientWidth = 197
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
    Left = 16
    Top = 23
    Width = 51
    Height = 15
    Caption = 'Datenfeld'
  end
  object InhaltLabel: TLabel
    Left = 16
    Top = 60
    Width = 30
    Height = 15
    Caption = 'Inhalt'
  end
  object FeldEdit: TTriaEdit
    Left = 70
    Top = 20
    Width = 108
    Height = 21
    HelpContext = 3671
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
    Text = 'Geschlecht'
  end
  object InhaltEdit: TTriaEdit
    Left = 70
    Top = 57
    Width = 108
    Height = 21
    HelpContext = 3672
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
    Text = 'M'#228'nnlich'
  end
  object WeiterButton: TButton
    Left = 16
    Top = 231
    Width = 75
    Height = 25
    HelpContext = 103
    Caption = '&Weiter'
    Default = True
    ModalResult = 1
    TabOrder = 2
    TabStop = False
  end
  object CancelButton: TButton
    Left = 103
    Top = 231
    Width = 75
    Height = 25
    HelpContext = 102
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 3
    TabStop = False
  end
  object SexRG: TRadioGroup
    Left = 16
    Top = 99
    Width = 162
    Height = 118
    Caption = 'W'#228'hle Geschlecht'
    Items.Strings = (
      'M'#228'nnlich'
      'Weiblich'
      'Mixed'
      'Kein')
    TabOrder = 4
  end
end
