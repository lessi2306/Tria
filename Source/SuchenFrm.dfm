object SuchenForm: TSuchenForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Suchen und Ersetzen'
  ClientHeight = 211
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SuchTabControl: TTabControl
    Left = 12
    Top = 12
    Width = 490
    Height = 152
    TabOrder = 0
    Tabs.Strings = (
      'Suchen'
      'Ersetzen')
    TabIndex = 0
    OnChange = SuchTabControlChange
    object SuchenNachLabel: TLabel
      Left = 10
      Top = 49
      Width = 69
      Height = 13
      Caption = 'Suchen nach:'
      FocusControl = SuchenNachCB
      OnClick = SuchenNachLabelClick
    end
    object SuchenInLabel: TLabel
      Left = 10
      Top = 83
      Width = 54
      Height = 13
      Caption = 'Suchen in:'
      OnClick = SuchenInLabelClick
    end
    object ErsetzenLabel: TLabel
      Left = 10
      Top = 118
      Width = 79
      Height = 13
      Caption = 'Ersetzen durch:'
      FocusControl = ErsetzenCB
      OnClick = ErsetzenLabelClick
    end
    object SuchenNachCB: TComboBox
      Left = 94
      Top = 46
      Width = 128
      Height = 21
      AutoComplete = False
      AutoCloseUp = True
      TabOrder = 0
    end
    object SuchenInCB: TComboBox
      Left = 94
      Top = 80
      Width = 128
      Height = 21
      AutoComplete = False
      Style = csDropDownList
      DropDownCount = 16
      TabOrder = 1
    end
    object ErsetzenCB: TComboBox
      Left = 94
      Top = 115
      Width = 128
      Height = 21
      AutoComplete = False
      AutoCloseUp = True
      TabOrder = 2
    end
    object OptionenGB: TGroupBox
      Left = 233
      Top = 39
      Width = 243
      Height = 100
      Caption = 'Optionen'
      TabOrder = 3
      object GrossKleinCheckB: TCheckBox
        Left = 8
        Top = 22
        Width = 230
        Height = 17
        Caption = 'Gro'#223'-/Kleinschreibung ber'#252'cksichtigen'
        TabOrder = 0
      end
      object GanzCheckB: TCheckBox
        Left = 8
        Top = 48
        Width = 230
        Height = 17
        Caption = 'Nur ganze W'#246'rter suchen'
        TabOrder = 1
      end
      object BestaetigenCB: TCheckBox
        Left = 8
        Top = 74
        Width = 225
        Height = 17
        Caption = 'Ersetzen nur nach Best'#228'tigung'
        TabOrder = 2
      end
    end
  end
  object AllesButton: TButton
    Left = 152
    Top = 176
    Width = 85
    Height = 25
    Caption = '&Alle ersetzen'
    TabOrder = 1
    TabStop = False
    OnClick = AllesButtonClick
  end
  object ErsetzButton: TButton
    Left = 247
    Top = 176
    Width = 75
    Height = 25
    Caption = '&Ersetzen'
    TabOrder = 2
    TabStop = False
    OnClick = ErsetzButtonClick
  end
  object SuchButton: TButton
    Left = 332
    Top = 176
    Width = 85
    Height = 25
    Caption = '&Weitersuchen'
    Default = True
    TabOrder = 3
    TabStop = False
    OnClick = SuchButtonClick
  end
  object CancelButton: TButton
    Left = 427
    Top = 176
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 4
    TabStop = False
    OnClick = CancelButtonClick
  end
end
