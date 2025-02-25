object ZtLoeschDialog: TZtLoeschDialog
  Left = 256
  Top = 307
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Eingelesene Zeiten l'#246'schen'
  ClientHeight = 375
  ClientWidth = 402
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
  object WettkLabel: TLabel
    Left = 19
    Top = 20
    Width = 59
    Height = 15
    HelpContext = 2301
    Caption = 'Wettkampf'
    OnClick = WettkLabelClick
  end
  object WettkCB: TComboBox
    Left = 16
    Top = 36
    Width = 371
    Height = 23
    HelpContext = 2301
    AutoComplete = False
    Style = csDropDownList
    TabOrder = 0
    OnChange = WettkCBChange
  end
  object AbschnittGB: TGroupBox
    Left = 16
    Top = 159
    Width = 371
    Height = 161
    HelpContext = 2302
    Caption = 'Wettkampfabschnitt'
    TabOrder = 1
    object Abschn1Edit: TTriaEdit
      Left = 91
      Top = 32
      Width = 75
      Height = 19
      HelpContext = 2302
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 8
      Text = 'Schwimm'
      OnClick = AbschnEditClick
    end
    object Abschn2Edit: TTriaEdit
      Left = 91
      Top = 64
      Width = 75
      Height = 19
      HelpContext = 2302
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 9
      Text = 'Bike'
      OnClick = AbschnEditClick
    end
    object Abschn3Edit: TTriaEdit
      Left = 91
      Top = 96
      Width = 75
      Height = 19
      HelpContext = 2302
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 10
      Text = 'Run'
      OnClick = AbschnEditClick
    end
    object Abschn4Edit: TTriaEdit
      Left = 92
      Top = 128
      Width = 75
      Height = 19
      HelpContext = 2302
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 11
      Text = 'Run'
      OnClick = AbschnEditClick
    end
    object Abschn1CB: TCheckBox
      Left = 16
      Top = 34
      Width = 72
      Height = 17
      HelpContext = 2302
      Caption = 'Abschn. 1'
      TabOrder = 0
    end
    object Abschn2CB: TCheckBox
      Left = 16
      Top = 66
      Width = 72
      Height = 17
      HelpContext = 2302
      Caption = 'Abschn. 2'
      TabOrder = 1
    end
    object Abschn3CB: TCheckBox
      Left = 16
      Top = 98
      Width = 72
      Height = 17
      HelpContext = 2302
      Caption = 'Abschn. 3'
      TabOrder = 2
    end
    object Abschn4CB: TCheckBox
      Left = 16
      Top = 130
      Width = 72
      Height = 17
      HelpContext = 2302
      Caption = 'Abschn. 4'
      TabOrder = 3
    end
    object Abschn5CB: TCheckBox
      Left = 204
      Top = 34
      Width = 72
      Height = 17
      HelpContext = 2302
      Caption = 'Abschn. 5'
      TabOrder = 4
    end
    object Abschn5Edit: TTriaEdit
      Left = 279
      Top = 32
      Width = 75
      Height = 19
      HelpContext = 2302
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 12
      Text = 'Schwimm'
      OnClick = AbschnEditClick
    end
    object Abschn6CB: TCheckBox
      Left = 204
      Top = 66
      Width = 72
      Height = 17
      HelpContext = 2302
      Caption = 'Abschn. 6'
      TabOrder = 5
    end
    object Abschn6Edit: TTriaEdit
      Left = 279
      Top = 64
      Width = 75
      Height = 19
      HelpContext = 2302
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 13
      Text = 'Bike'
      OnClick = AbschnEditClick
    end
    object Abschn7Edit: TTriaEdit
      Left = 279
      Top = 96
      Width = 75
      Height = 19
      HelpContext = 2302
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 14
      Text = 'Run'
      OnClick = AbschnEditClick
    end
    object Abschn7CB: TCheckBox
      Left = 204
      Top = 98
      Width = 72
      Height = 17
      HelpContext = 2302
      Caption = 'Abschn. 7'
      TabOrder = 6
    end
    object Abschn8CB: TCheckBox
      Left = 204
      Top = 130
      Width = 72
      Height = 17
      HelpContext = 2302
      Caption = 'Abschn. 8'
      TabOrder = 7
    end
    object Abschn8Edit: TTriaEdit
      Left = 279
      Top = 128
      Width = 75
      Height = 19
      HelpContext = 2302
      TabStop = False
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 15
      Text = 'Run'
      OnClick = AbschnEditClick
    end
  end
  object OkButton: TButton
    Left = 150
    Top = 333
    Width = 75
    Height = 25
    HelpContext = 2304
    Caption = 'OK'
    Default = True
    TabOrder = 2
    TabStop = False
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 231
    Top = 333
    Width = 75
    Height = 25
    HelpContext = 2303
    Caption = 'Abbrechen'
    ModalResult = 2
    TabOrder = 3
    TabStop = False
  end
  object HilfeButton: TButton
    Left = 312
    Top = 333
    Width = 75
    Height = 25
    HelpContext = 101
    Caption = '&Hilfe'
    TabOrder = 4
    TabStop = False
    OnClick = HilfeButtonClick
  end
  object EinzelStartGB: TGroupBox
    Left = 16
    Top = 78
    Width = 371
    Height = 59
    HelpContext = 2305
    Caption = 'Startzeit '
    TabOrder = 5
    object EinzelStartCB: TCheckBox
      Left = 16
      Top = 29
      Width = 189
      Height = 17
      HelpContext = 2305
      Caption = 'Einzelstart Abschnitt 1'
      TabOrder = 0
    end
  end
end
