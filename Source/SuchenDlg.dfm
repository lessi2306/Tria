object SuchenDialog: TSuchenDialog
  Left = 145
  Top = 607
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Suchen und Ersetzen'
  ClientHeight = 240
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object SuchButton: TButton
    Left = 415
    Top = 202
    Width = 85
    Height = 25
    Caption = '&Weitersuchen'
    TabOrder = 3
    OnClick = SuchButtonClick
  end
  object AllesButton: TButton
    Left = 235
    Top = 202
    Width = 85
    Height = 25
    Caption = '&Alle ersetzen'
    TabOrder = 1
    OnClick = AllesButtonClick
  end
  object SuchTabControl: TTabControl
    Left = 12
    Top = 12
    Width = 490
    Height = 178
    TabOrder = 0
    Tabs.Strings = (
      'Suchen'
      'Ersetzen')
    TabIndex = 0
    OnChange = SuchTabControlChange
    object SuchenNachLabel: TLabel
      Left = 10
      Top = 50
      Width = 71
      Height = 15
      Caption = 'Suchen nach:'
      FocusControl = SuchenNachCB
      OnClick = SuchenNachLabelClick
    end
    object SuchenInLabel: TLabel
      Left = 10
      Top = 93
      Width = 55
      Height = 15
      Caption = 'Suchen in:'
      OnClick = SuchenInLabelClick
    end
    object ErsetzenLabel: TLabel
      Left = 10
      Top = 136
      Width = 80
      Height = 15
      Caption = 'Ersetzen durch:'
      FocusControl = ErsetzenCB
      OnClick = ErsetzenLabelClick
    end
    object SuchenNachCB: TComboBox
      Left = 94
      Top = 47
      Width = 128
      Height = 23
      AutoComplete = False
      AutoCloseUp = True
      TabOrder = 0
      OnChange = SuchChange
    end
    object SuchenInCB: TComboBox
      Left = 94
      Top = 90
      Width = 128
      Height = 23
      AutoComplete = False
      Style = csDropDownList
      DropDownCount = 16
      TabOrder = 1
      OnChange = SuchChange
    end
    object ErsetzenCB: TComboBox
      Left = 94
      Top = 133
      Width = 128
      Height = 23
      AutoComplete = False
      AutoCloseUp = True
      TabOrder = 2
    end
    object OptionenGB: TGroupBox
      Left = 233
      Top = 39
      Width = 243
      Height = 120
      Caption = 'Optionen'
      TabOrder = 3
      object GrossKleinCB: TCheckBox
        Left = 8
        Top = 22
        Width = 230
        Height = 17
        Caption = 'Gro'#223'-/Kleinschreibung ber'#252'cksichtigen'
        TabOrder = 0
        OnClick = SuchChange
      end
      object GanzCB: TCheckBox
        Left = 8
        Top = 46
        Width = 230
        Height = 17
        Caption = 'Nur ganze W'#246'rter suchen'
        TabOrder = 1
        OnClick = SuchChange
      end
      object BestaetigenCB: TCheckBox
        Left = 8
        Top = 94
        Width = 225
        Height = 17
        Caption = 'Ersetzen nur nach Best'#228'tigung'
        TabOrder = 2
      end
      object StartStrCB: TCheckBox
        Left = 8
        Top = 70
        Width = 225
        Height = 17
        Caption = 'Nur '#220'bereinstimmung am Wortanfang'
        TabOrder = 3
      end
    end
  end
  object ErsetzButton: TButton
    Left = 330
    Top = 202
    Width = 75
    Height = 25
    Caption = '&Ersetzen'
    TabOrder = 2
    OnClick = ErsetzButtonClick
  end
end
