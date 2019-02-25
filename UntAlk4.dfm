object FrmAlk4: TFrmAlk4
  Left = 346
  Top = 300
  ClientHeight = 182
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 31
    Width = 90
    Height = 13
    Caption = 'Aktar'#305'laca'#287#305' Yer'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 76
    Width = 37
    Height = 13
    Caption = #304'zahat'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object txtyer: TEdit
    Left = 16
    Top = 47
    Width = 369
    Height = 21
    TabOrder = 0
  end
  object txtizahat: TEdit
    Left = 16
    Top = 92
    Width = 369
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 16
    Top = 136
    Width = 361
    Height = 33
    Caption = 'Se'#231'ili Demirba'#351'lar'#305' Belirtilen Yere Aktar'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Qry1: TADOQuery
    Connection = Dm.cnn1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 328
    Top = 6
  end
end
