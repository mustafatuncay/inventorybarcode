object FrmBarkod: TFrmBarkod
  Left = 611
  Top = 199
  BorderStyle = bsDialog
  ClientHeight = 156
  ClientWidth = 164
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 145
    Height = 113
  end
  object Button2: TButton
    Left = 368
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Uygula'
    TabOrder = 0
    Visible = False
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 336
    Top = 120
    Width = 121
    Height = 21
    MaxLength = 12
    TabOrder = 1
    Text = '982227982227'
    Visible = False
  end
  object Button3: TButton
    Left = 368
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Yazd'#305'r'
    TabOrder = 2
    Visible = False
    OnClick = Button3Click
  end
  object ListBox1: TListBox
    Left = 456
    Top = 16
    Width = 209
    Height = 217
    ItemHeight = 13
    TabOrder = 3
  end
  object Button1: TButton
    Left = 480
    Top = 120
    Width = 166
    Height = 25
    Caption = 'Mevcut Printerleri Listele'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button4: TButton
    Left = 472
    Top = 152
    Width = 166
    Height = 25
    Caption = 'Default Printer Olarak Tan'#305'mla'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 241
    Top = 132
    Width = 25
    Height = 25
    Caption = 'Se'#231'ili Barkodlar'#305' Yazd'#305'r'
    TabOrder = 6
    Visible = False
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 16
    Top = 127
    Width = 129
    Height = 25
    Caption = 'Se'#231'ili Barkodlar'#305' Yazd'#305'r'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 200
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Button7'
    TabOrder = 8
    Visible = False
    OnClick = Button7Click
  end
  object ComboBox1: TComboBox
    Left = 190
    Top = 32
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 9
    Text = 'ComboBox1'
    Visible = False
  end
  object Button8: TButton
    Left = 43
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Yaz'#305'c'#305' Se'#231
    TabOrder = 10
    Visible = False
    OnClick = Button8Click
  end
  object Barcode1: TBarcode
    InputText = '7257327'
    OutputOptions = [opBox]
    Scale = 1.000000000000000000
    ShowText = False
    Symbology = syCode128
    Left = 216
    Top = 112
  end
  object PrintDialog1: TPrintDialog
    Left = 280
    Top = 72
  end
end
