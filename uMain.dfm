object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'ETN nanopool Viewer'
  ClientHeight = 392
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
  object pnltop: TPanel
    Left = 0
    Top = 0
    Width = 587
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 136
    ExplicitTop = 80
    ExplicitWidth = 185
    object lbladdress: TLabel
      Left = 8
      Top = 11
      Width = 57
      Height = 18
      Caption = 'Address:'
    end
    object edtaddress: TEdit
      Left = 71
      Top = 10
      Width = 506
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object grpbalance: TGroupBox
    Left = 8
    Top = 47
    Width = 571
    Height = 74
    Caption = 'Balance'
    TabOrder = 1
    object lblbalance: TLabel
      Left = 16
      Top = 32
      Width = 5
      Height = 18
    end
  end
  object grphashrate: TGroupBox
    Left = 8
    Top = 127
    Width = 571
    Height = 98
    Caption = 'Hashrate'
    TabOrder = 2
    object lblcurrenthash: TLabel
      Left = 16
      Top = 32
      Width = 5
      Height = 18
    end
    object lblavghash: TLabel
      Left = 16
      Top = 56
      Width = 5
      Height = 18
    end
  end
  object pnlbottom: TPanel
    Left = 0
    Top = 351
    Width = 587
    Height = 41
    Align = alBottom
    TabOrder = 3
    ExplicitLeft = 296
    ExplicitTop = 328
    ExplicitWidth = 185
    object btnrefresh: TButton
      Left = 502
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 0
      OnClick = btnrefreshClick
    end
  end
  object grpprices: TGroupBox
    Left = 8
    Top = 231
    Width = 265
    Height = 114
    Caption = '1 ETN is worth:'
    TabOrder = 4
    object lblPriceBTC: TLabel
      Left = 16
      Top = 32
      Width = 5
      Height = 18
    end
    object lblPriceUSD: TLabel
      Left = 16
      Top = 56
      Width = 5
      Height = 18
    end
    object lblPriceEUR: TLabel
      Left = 16
      Top = 80
      Width = 5
      Height = 18
    end
  end
  object http: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KH' +
      'TML, like Gecko) Chrome/63.0.3239.132 Safari/537.36'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 488
    Top = 64
  end
  object tmrRequests: TTimer
    Interval = 60000
    OnTimer = tmrRequestsTimer
    Left = 384
    Top = 64
  end
end
