object ImpFeldDialog: TImpFeldDialog
  Left = 284
  Top = 151
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Datenpr'#252'fung'
  ClientHeight = 221
  ClientWidth = 209
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
  object InhaltEdit: TTriaEdit
    Left = 70
    Top = 57
    Width = 124
    Height = 21
    HelpContext = 3672
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
    Text = 'M'#228'nnlich'
  end
  object FeldEdit: TTriaEdit
    Left = 70
    Top = 20
    Width = 124
    Height = 21
    HelpContext = 3671
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
    Text = 'Mannschaftswertung'
  end
  object WeiterButton: TButton
    Left = 16
    Top = 180
    Width = 75
    Height = 25
    HelpContext = 103
    Caption = '&Weiter'
    Default = True
    ModalResult = 1
    TabOrder = 3
    TabStop = False
  end
  object CancelButton: TButton
    Left = 119
    Top = 180
    Width = 75
    Height = 25
    HelpContext = 102
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 4
    TabStop = False
  end
  object OptGB: TGroupBox
    Left = 16
    Top = 104
    Width = 178
    Height = 57
    HelpContext = 3673
    Caption = 'W'#228'hle Option'
    TabOrder = 0
    object OptCB: TCheckBox
      Left = 12
      Top = 28
      Width = 149
      Height = 17
      Caption = 'Mannschaftswertung'
      TabOrder = 0
    end
  end
end
