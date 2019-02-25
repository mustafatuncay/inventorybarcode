object FrmGiris: TFrmGiris
  Left = 0
  Top = 0
  ClientHeight = 391
  ClientWidth = 694
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LblCarEntry: TLabel
    Left = 124
    Top = 183
    Width = 126
    Height = 22
    Cursor = crHandPoint
    Caption = 'Kullan'#305'c'#305' Ad'#305' :'
    Font.Charset = HEBREW_CHARSET
    Font.Color = 6052956
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 197
    Top = 227
    Width = 55
    Height = 22
    Cursor = crHandPoint
    Caption = #350'ifre :'
    Font.Charset = HEBREW_CHARSET
    Font.Color = 6052956
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel
    Left = 0
    Top = 364
    Width = 694
    Height = 27
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 'Designed && Programmed by  Mustafa Tuncay  -  0548 826 6903'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clSilver
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
    ExplicitLeft = 21
    ExplicitTop = 343
    ExplicitWidth = 438
  end
  object TxtSifre: TEdit
    Left = 256
    Top = 224
    Width = 270
    Height = 32
    BevelKind = bkSoft
    BorderStyle = bsNone
    Color = 13303807
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = TxtSifreKeyPress
  end
  object TxtKullaniciAdi: TEdit
    Left = 256
    Top = 180
    Width = 270
    Height = 31
    BevelKind = bkSoft
    BorderStyle = bsNone
    Color = 13303807
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object PnlVersion: TPanel
    Left = 8
    Top = 316
    Width = 28
    Height = 21
    Caption = '2'
    TabOrder = 2
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 694
    Height = 146
    Align = alTop
    BevelInner = bvRaised
    BevelKind = bkTile
    Color = -1
    ParentBackground = False
    TabOrder = 3
    object Label2: TLabel
      Left = 20
      Top = 49
      Width = 661
      Height = 42
      Caption = 'Burhan Nalbanto'#287'lu Devlet Hastanesi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -35
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Memo1: TMemo
      Left = 35
      Top = 97
      Width = 25
      Height = 33
      TabOrder = 0
      Visible = False
    end
  end
  object BtnTamam: TButton
    Left = 427
    Top = 284
    Width = 99
    Height = 29
    Caption = 'TAMAM'
    TabOrder = 4
    OnClick = BtnTamamClick
  end
  object Button1: TButton
    Left = 20
    Top = 152
    Width = 101
    Height = 25
    Caption = 'Yedek Deneme'
    TabOrder = 5
    Visible = False
    OnClick = Button1Click
  end
  object Qry1: TADOQuery
    Connection = Dm.cnn1
    Parameters = <>
    Left = 24
    Top = 16
  end
end
