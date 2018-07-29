object UpdateDialog: TUpdateDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Internet Update'
  ClientHeight = 283
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 56
    Top = 80
    Width = 188
    Height = 15
    Caption = 'Momentan verwenden Sie Version:  '
  end
  object Label1a: TLabel
    Left = 257
    Top = 80
    Width = 34
    Height = 15
    Caption = '10.1.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 56
    Top = 150
    Width = 394
    Height = 15
    Caption = 
      'Klicken Sie auf "Weiter", um zu pr'#252'fen ob eine neuere Version ve' +
      'rf'#252'gbar ist.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 56
    Top = 105
    Width = 190
    Height = 15
    Caption = 'Aktuelle Version auf  www.selten.de:'
  end
  object Label2a: TLabel
    Left = 257
    Top = 105
    Width = 34
    Height = 15
    Caption = '10.1.1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 56
    Top = 203
    Width = 127
    Height = 15
    Caption = '0 KB von  700 KB kopiert'
  end
  object Label5: TLabel
    Left = 56
    Top = 168
    Width = 34
    Height = 15
    Caption = 'Label5'
  end
  object WeiterBtn: TButton
    Left = 305
    Top = 248
    Width = 75
    Height = 25
    Caption = '&Weiter >'
    Default = True
    TabOrder = 0
    OnClick = WeiterBtnClick
  end
  object TrennPanel: TPanel
    Left = 0
    Top = 48
    Width = 474
    Height = 2
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 1
  end
  object StartPanel: TPanel
    Left = 0
    Top = 0
    Width = 474
    Height = 48
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    BevelOuter = bvNone
    BevelWidth = 5
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object Image: TImage
      Left = 8
      Top = 8
      Width = 32
      Height = 32
      AutoSize = True
    end
    object TitelLabel: TLabel
      Left = 56
      Top = 16
      Width = 133
      Height = 20
      Caption = 'Tria Version pr'#252'fen'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 230
    Width = 474
    Height = 2
    BevelOuter = bvLowered
    TabOrder = 3
  end
  object ProgressBar: TProgressBar
    Left = 56
    Top = 180
    Width = 362
    Height = 17
    TabOrder = 4
  end
  object CancelBtn: TButton
    Left = 391
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    TabOrder = 5
    OnClick = CancelBtnClick
  end
  object IdHTTP: TIdHTTP
    OnWork = IdHTTPWork
    OnWorkBegin = IdHTTPWorkBegin
    AllowCookies = True
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 81
    Top = 240
  end
  object XMLDocument: TXMLDocument
    Left = 24
    Top = 240
    DOMVendorDesc = 'MSXML'
  end
  object IdAntiFreeze: TIdAntiFreeze
    IdleTimeOut = 50
    OnlyWhenIdle = False
    Left = 142
    Top = 240
  end
end
