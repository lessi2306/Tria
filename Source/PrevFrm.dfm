object PrevFrame: TPrevFrame
  Left = 0
  Top = 0
  Width = 774
  Height = 45
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  Visible = False
  object PrevScrollBox: TScrollBox
    Left = 0
    Top = 27
    Width = 774
    Height = 18
    HorzScrollBar.Tracking = True
    Align = alClient
    TabOrder = 1
  end
  object PrevPanel: TPanel
    Left = 0
    Top = 0
    Width = 774
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object PrevVonText: TLabel
      Left = 82
      Top = 7
      Width = 41
      Height = 15
      Caption = 'von 888'
    end
    object PrevSeiteLabel: TLabel
      Left = 5
      Top = 6
      Width = 25
      Height = 15
      Caption = 'Seite'
    end
  end
  object PrevUpDown: TTriaUpDown
    Left = 63
    Top = 1
    Width = 14
    Height = 24
    Hint = 'W'#228'hle angezeigte Seite'
    HelpContext = 3301
    Min = 1
    Max = 9999
    Position = 888
    TabOrder = 3
    Edit = PrevSeiteEdit
  end
  object PrevSeiteEdit: TTriaMaskEdit
    Left = 33
    Top = 2
    Width = 30
    Height = 22
    Hint = 'W'#228'hle angezeigte Seite'
    HelpContext = 3301
    EditMask = '999;0; '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    MaxLength = 3
    ParentFont = False
    TabOrder = 0
    Text = '888'
    OnChange = PrevSeiteEditChange
    UpDown = PrevUpDown
  end
end
