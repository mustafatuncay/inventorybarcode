object FrmBarkodVeriAktar: TFrmBarkodVeriAktar
  Left = 213
  Top = 288
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 136
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = TURKISH_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label6: TLabel
    Left = 584
    Top = 48
    Width = 50
    Height = 16
    AutoSize = False
    Caption = 'Com1'
    Color = 8421631
    ParentColor = False
  end
  object Label7: TLabel
    Left = 584
    Top = 68
    Width = 50
    Height = 16
    AutoSize = False
    Caption = '9600'
    Color = 8421631
    ParentColor = False
  end
  object Label8: TLabel
    Left = 584
    Top = 87
    Width = 50
    Height = 16
    AutoSize = False
    Caption = '8'
    Color = 8421631
    ParentColor = False
  end
  object Label9: TLabel
    Left = 584
    Top = 107
    Width = 50
    Height = 16
    AutoSize = False
    Caption = '1'
    Color = 8421631
    ParentColor = False
  end
  object Bconnect: TSpeedButton
    Left = 326
    Top = 510
    Width = 150
    Height = 36
    Hint = 'Yap'#305'lan Ayarlar'#305' Kaydet'
    Caption = 'Form Bilgilerini Al '
    Flat = True
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    Glyph.Data = {
      76060000424D7606000000000000360400002800000018000000180000000100
      0800000000004002000000000000000000000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A6000020400000206000002080000020A0000020C0000020E000004000000040
      20000040400000406000004080000040A0000040C0000040E000006000000060
      20000060400000606000006080000060A0000060C0000060E000008000000080
      20000080400000806000008080000080A0000080C0000080E00000A0000000A0
      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
      20004000400040006000400080004000A0004000C0004000E000402000004020
      20004020400040206000402080004020A0004020C0004020E000404000004040
      20004040400040406000404080004040A0004040C0004040E000406000004060
      20004060400040606000406080004060A0004060C0004060E000408000004080
      20004080400040806000408080004080A0004080C0004080E00040A0000040A0
      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
      20008000400080006000800080008000A0008000C0008000E000802000008020
      20008020400080206000802080008020A0008020C0008020E000804000008040
      20008040400080406000804080008040A0008040C0008040E000806000008060
      20008060400080606000806080008060A0008060C0008060E000808000008080
      20008080400080806000808080008080A0008080C0008080E00080A0000080A0
      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFF0000
      000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFF00F7F7F7F7F7F7F7F7F7
      F700FFFFFFFFFFFFFFFFFFFFFFFF00F7FFFFF7F9F9F7FFFFF700FFFFFFFFFFFF
      FFFFFFFFFFFFFF00F7F7F7F7F7F7F7F7F7F700FFFFFFFFFFFFFFFFFFFFFFFF00
      F7FFFFF7FFFFF7FFFFF700FFFFFFFFFFFFFFFFFFFFFFFF00F7F7F7F7F7F7F7F7
      F7F700FFFFFFFFFFFFFFFFFFFFFFFFFF00F7FFFFF7FFFFF7FFFFF700FFFFFFFF
      FFFFFFFFFFFFFFFF00F7F7F7F7F7F7F7F7F7F700FFFFFFFFFFFFFFFFFFFFFFFF
      00F7FFFFF7FFFFF7FFFFF700FFFFFFFFFFFFFFFFFFFFFFFFFF00F7F7F7F7F7F7
      F7F7F7F700FFFFFFFFFFFFFFFFFFFFFFFF00F70404F7FFFFF70404F700FFFFFF
      FFFFFFFFFFFFFFFFFF00F7F7F7F7F7F7F7F7F7F70000FFFFFFFFFFFFFFFFFFFF
      FF00F7F7F7F7F7F7F7F7F7F7F7F700FFFFFFFFFFFFFFFFFFFF00F7F7F7F7F7F7
      F7F7F7F7F7F700FFFFFFFFFFFFFFFFFFFFFF00F7F7F7F7F7F7F7F7F7F7F7F700
      FFFFFFFFFFFFFFFFFFFF00F708080808080808080808F700FFFFFFFFFFFFFFFF
      FFFF00F708080808080808080808F700FFFFFFFFFFFFFFFFFFFFFF00F7080808
      08080808080808F700FFFFFFFFFFFFFFFFFFFF00F708080808080808080808F7
      00FFFFFFFFFFFFFFFFFFFF00F708080808080808080808F700FFFFFFFFFFFFFF
      FFFFFFFF00F708080808080808080808F700FFFFFFFFFFFFFFFFFFFF00F70808
      0808080808080808F700FFFFFFFFFFFFFFFFFFFF00F7F7F7F7F7F7F7F7F7F7F7
      F700FFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000}
    ParentFont = False
    OnClick = BconnectClick
  end
  object SpeedButton1: TSpeedButton
    Left = 918
    Top = 532
    Width = 150
    Height = 34
    Hint = 'Yap'#305'lan Ayarlar'#305' Kaydet'
    Caption = 'Verileri Al         '
    Enabled = False
    Flat = True
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    Glyph.Data = {
      A6020000424DA602000000000000660000002800000018000000180000000100
      08000000000040020000520B0000520B00000C0000000C000000005803000073
      0300EA841100F48F4000FFA150000048C00000D4E000FFF4E000FF00FF0006F4
      FF006AFFFF00FFFFFF0008080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0804040404040404040408080808080808080808080808080804070707070707
      0707080808080808080808080808080808030707070707070707080808080808
      080808080808080808030B0B0B0B0B0B0B0B0808080808080808080808080808
      08030B0B0B0B0B0B0B0B080808080808080808080808080808030B0B0B0B0B0B
      0B0B050505050505050505080808000808020B0B0B0B0B0B0B0B0A0A050A0A0A
      0A0A050808080000080202020202020202020906050909090906050808080000
      0008080808080808080809060509090909060500000000000000080808080808
      0808090605090909090605000000000001010808080808080808090605090909
      0906050808080101010808080808080808080606050606060606050808080101
      0802020202020202020205050505050505050508080801080802070707070707
      0707080808080808080808080808080808030707070707070707080808080808
      080808080808080808030B0B0B0B0B0B0B0B0808080808080808080808080808
      08030B0B0B0B0B0B0B0B080808080808080808080808080808030B0B0B0B0B0B
      0B0B080808080808080808080808080808020B0B0B0B0B0B0B0B080808080808
      0808080808080808080202020202020202020808080808080808080808080808
      08080808080808080808}
    ParentFont = False
    Visible = False
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 35
    Top = 359
    Width = 72
    Height = 57
    Hint = 'Yap'#305'lan Ayarlar'#305' Kaydet'
    Caption = 'Ayarlar'
    Flat = True
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    Glyph.Data = {
      2E050000424D2E05000000000000EE0200002800000018000000180000000100
      08000000000040020000C30E0000C30E0000AE000000AE000000C0400000C048
      0000C0500000EA6A0000F4730000B6500300C0500300C0500600CA500600C058
      0600CA580600C0580B00A15011008F40160058502A00CA732A006A5848005848
      50007B60500058485800311C6000485860007B606000846A600040606A008F73
      6A008F7B6A003860730098847300A1847300FFB6730098847B00A1847B00A18F
      7B00AB8F7B00C0987B00232A8400A18F8400B6988400FFC08400FFCA8400232A
      8F006A508F000B6A8F00AB988F00E0B68F00CAC08F00FFC08F00FFCA8F00FFD4
      8F000B6A9800487B9800E0B69800EAB69800FFCA9800FFD49800FFE098006A58
      A100006AA100588FA100B6ABA100CAB6A100E0C0A100FFCAA100EAD4A100FFD4
      A100FFE0A1005048AB001C84AB00C0B6AB00CAB6AB00FFD4AB00FFE0AB00FFEA
      AB00000BB600030BB6002331B6003138B600037BB6000B7BB6001684B600318F
      B600CAB6B600CAC0B600EACAB600F4CAB600FFD4B600FFE0B6000B1CC0006A6A
      C0007373C000007BC000037BC000068FC000318FC000988FC0002A98C0003198
      C0004898C00050A1C00073ABC000D4B6C000D4CAC000FFE0C000FFEAC0000316
      CA000616CA000084CA00038FCA000698CA003198CA009898CA0048A1CA0060A1
      CA008FB6CA00B6C0CA00D4CACA00F4E0CA00FFE0CA00FFEACA000616D400008F
      D400038FD4000698D4000B98D40011A1D400ABC0D400FFEAD400FFF4D400FFFF
      D4000016E0000316E0000638E0000098E00003A1E0002AC0E00031CAE000A1CA
      E000ABCAE000E0E0E000EAE0E000F4EAE000FFEAE000FFF4E000FFFFE00000AB
      EA00E0EAEA00FFF4EA00FFFFEA00001CF4000331F4000340F40000ABF40000B6
      F40016CAF40023CAF400EAEAF400EAF4F400F4F4F400FFF4F400FFFFF400FF00
      FF000011FF000016FF00001CFF000338FF000650FF000658FF0000B6FF0000C0
      FF0003D4FF00D4EAFF00F4FFFF00FFFFFF00A1A1A1A1A1A1A1A1A1A1A1A1A1A1
      A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1
      A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1
      3315A13218A1A1A1A14B4A24A1A1A1A1A1A1A1A1A1A1A1A1851BA14E4EA1A1A1
      A1A4A429A1A1A1A1A1A1A1A10B0B070EA96C2B793A0C07070D83A31406050505
      01A1A1A10B7F93735DA9996B3B565647346AA22A312F271E01A1A1A10B9FADAD
      6491984F757F7777546AA239423F362701A1A1A10B93ADAD8B7B98517F7F7777
      546AA23948413F2F01A1A1A10B93ADAD9C6D98518E8E7F776583A2434847412F
      01A1A1A10B93ADAD9C7B99518E8F8E805F95A44C4747473601A1A1A10B93ADAD
      9C7CA85E93938F905A97A5585457563601A1A1A10B93ADAD9C7CA86193939390
      59A7A66A5457674101A1A1A10B93ADAD9C7DA8619FADA0945F84964D67773E2D
      01A1A1A10B93ADAD927D9962AD66528C451113168067122301A1A1A10B93AD9E
      639AAA6C721917191F212117261D102D01A1A1A10B93AD8A879B6D9144203C19
      455353452517225701A1A1A10B93AD8988607E5B621D1C1C252C2C251F3D8F67
      01A1A1A10B9FAD9D7050AB71AB9E9CADAC8B8B8B93A0937601A1A1A10B374242
      412E404848484842484842423737312701A1A1A1060303030303030303030303
      030303030303030301A1A1A10F00010101010101010101010101010101010101
      0FA1A1A1A10A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0AA1A1A1A1A1A1A1A1
      A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1}
    Layout = blGlyphTop
    ParentFont = False
    OnClick = SpeedButton2Click
  end
  object Label10: TLabel
    Left = 584
    Top = 29
    Width = 50
    Height = 16
    AutoSize = False
    Caption = '0'
    Color = 8421631
    ParentColor = False
  end
  object Gauge1: TGauge
    Left = 5
    Top = 7
    Width = 356
    Height = 25
    ForeColor = clBlue
    MaxValue = 0
    Progress = 0
    Visible = False
  end
  object SpeedButton6: TSpeedButton
    Left = 198
    Top = 39
    Width = 67
    Height = 57
    Hint = 'Programdan '#199#305'k'#305#351
    Caption = #199#305'k'#305#351
    Flat = True
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    Glyph.Data = {
      6E030000424D6E030000000000002E0100002800000018000000180000000100
      08000000000040020000110F0000110F00003E0000003E000000A1400000B640
      0000C0400000C0480000C0500000CA500000CA580000D4580000D4600000E060
      0000EA600000F4600000F46A0000FF6A00008F3803002A2A2A001C5031001C58
      3100405038001C603800236038004860380016584000166040001C6040003160
      4000166A4000236A400073484800985048002A604800116A4800166A48001673
      48002A6A5000117350001673500023735000117B50007B7B5000FFAB50000B7B
      5800117B58000B84580011845800A18458000B846000068F60000B8F60006A6A
      6A0006986A00F4A16A00F4B68F00FFCA8F00EAC0AB00F4C0AB00FFE0B600F4CA
      C000FFD4C000FFE0D400FF00FF00FFFFFF003C3C3C3C3C3C3C3C3C3C3C3C3C3C
      3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
      3C3C3C3C3C3C3C3C3C3C1C0F0F3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C1C
      0F0F00000F1C1C1C1C1C1C1C1C1C3C3C3C3C3C3C3C1C0F00000E00010F323232
      32323232321C3C3C3C3C3C3C1C000000010101010F32323232323030301C3C3C
      3C3C3C3C1C010101010103030F323030302E2B2A251C3C3C3C3C3C3C1C010303
      030303030F202A2A2A262324221C3C3C3C3C3C3C1C030303040404030F162324
      21242020241C3C3C3C3C3C3C1C030404040404060F24201A1813181B1E1C3C3C
      3C3C3C3C1C040404060628060F10141411141912121C3C3C3C3C3C3C1C060606
      063538280F1212111515272D331C3C3C3C3C3C3C1C060606060635060F333333
      33333333331C3C3C3C3C3C3C1C060608080808080F33333333333333331C3C3C
      3C3C3C3C1C080808080808080F33333B3B3B3A33331C3C3C3C3C3C3C1C080909
      08080A0A0F363B3B3A39363B331C3C3C3C3C3C3C1C0D0A0A0A0A0A0A0F333437
      3B393734331C3C3C3C3C3C3C1C060D0D0C0B0A0A0F33333336363633331C3C3C
      3C3C3C3C3C1D1D060D0A0C0D0F33333333333333331C3C3C3C3C3C3C3C3C3C1D
      1D060D0D0F3131313131313131313C3C3C3C3C3C3C3C3C3C3C1D1D1D1D3C3C3C
      3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
      3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C
      3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C}
    Layout = blGlyphTop
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton6Click
  end
  object SpeedButton7: TSpeedButton
    Left = 93
    Top = 39
    Width = 67
    Height = 57
    Hint = 'Verileri Al'
    Caption = 'Verileri Al'
    Flat = True
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    Glyph.Data = {
      A6020000424DA602000000000000660000002800000018000000180000000100
      08000000000040020000520B0000520B00000C0000000C000000005803000073
      0300EA841100F48F4000FFA150000048C00000D4E000FFF4E000FF00FF0006F4
      FF006AFFFF00FFFFFF0008080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0808080808080808080808080808080808080808080808080808080808080808
      0804040404040404040408080808080808080808080808080804070707070707
      0707080808080808080808080808080808030707070707070707080808080808
      080808080808080808030B0B0B0B0B0B0B0B0808080808080808080808080808
      08030B0B0B0B0B0B0B0B080808080808080808080808080808030B0B0B0B0B0B
      0B0B050505050505050505080808000808020B0B0B0B0B0B0B0B0A0A050A0A0A
      0A0A050808080000080202020202020202020906050909090906050808080000
      0008080808080808080809060509090909060500000000000000080808080808
      0808090605090909090605000000000001010808080808080808090605090909
      0906050808080101010808080808080808080606050606060606050808080101
      0802020202020202020205050505050505050508080801080802070707070707
      0707080808080808080808080808080808030707070707070707080808080808
      080808080808080808030B0B0B0B0B0B0B0B0808080808080808080808080808
      08030B0B0B0B0B0B0B0B080808080808080808080808080808030B0B0B0B0B0B
      0B0B080808080808080808080808080808020B0B0B0B0B0B0B0B080808080808
      0808080808080808080202020202020202020808080808080808080808080808
      08080808080808080808}
    Layout = blGlyphTop
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton7Click
  end
  object Label11: TLabel
    Left = 640
    Top = 387
    Width = 568
    Height = 16
    AutoSize = False
    Color = 8421631
    ParentColor = False
    Visible = False
  end
  object Label12: TLabel
    Left = 584
    Top = 131
    Width = 50
    Height = 16
    AutoSize = False
    Caption = '1'
    Color = 8421631
    ParentColor = False
  end
  object Label13: TLabel
    Left = 584
    Top = 152
    Width = 50
    Height = 16
    AutoSize = False
    Caption = '1'
    Color = 8421631
    ParentColor = False
  end
  object SpeedButton3: TSpeedButton
    Left = 133
    Top = 359
    Width = 72
    Height = 57
    Hint = 'Yap'#305'lan Ayarlar'#305' Kaydet'
    Caption = 'Y'#252'kle'
    Flat = True
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    Glyph.Data = {
      2E050000424D2E05000000000000EE0200002800000018000000180000000100
      08000000000040020000C30E0000C30E0000AE000000AE000000C0400000C048
      0000C0500000EA6A0000F4730000B6500300C0500300C0500600CA500600C058
      0600CA580600C0580B00A15011008F40160058502A00CA732A006A5848005848
      50007B60500058485800311C6000485860007B606000846A600040606A008F73
      6A008F7B6A003860730098847300A1847300FFB6730098847B00A1847B00A18F
      7B00AB8F7B00C0987B00232A8400A18F8400B6988400FFC08400FFCA8400232A
      8F006A508F000B6A8F00AB988F00E0B68F00CAC08F00FFC08F00FFCA8F00FFD4
      8F000B6A9800487B9800E0B69800EAB69800FFCA9800FFD49800FFE098006A58
      A100006AA100588FA100B6ABA100CAB6A100E0C0A100FFCAA100EAD4A100FFD4
      A100FFE0A1005048AB001C84AB00C0B6AB00CAB6AB00FFD4AB00FFE0AB00FFEA
      AB00000BB600030BB6002331B6003138B600037BB6000B7BB6001684B600318F
      B600CAB6B600CAC0B600EACAB600F4CAB600FFD4B600FFE0B6000B1CC0006A6A
      C0007373C000007BC000037BC000068FC000318FC000988FC0002A98C0003198
      C0004898C00050A1C00073ABC000D4B6C000D4CAC000FFE0C000FFEAC0000316
      CA000616CA000084CA00038FCA000698CA003198CA009898CA0048A1CA0060A1
      CA008FB6CA00B6C0CA00D4CACA00F4E0CA00FFE0CA00FFEACA000616D400008F
      D400038FD4000698D4000B98D40011A1D400ABC0D400FFEAD400FFF4D400FFFF
      D4000016E0000316E0000638E0000098E00003A1E0002AC0E00031CAE000A1CA
      E000ABCAE000E0E0E000EAE0E000F4EAE000FFEAE000FFF4E000FFFFE00000AB
      EA00E0EAEA00FFF4EA00FFFFEA00001CF4000331F4000340F40000ABF40000B6
      F40016CAF40023CAF400EAEAF400EAF4F400F4F4F400FFF4F400FFFFF400FF00
      FF000011FF000016FF00001CFF000338FF000650FF000658FF0000B6FF0000C0
      FF0003D4FF00D4EAFF00F4FFFF00FFFFFF00A1A1A1A1A1A1A1A1A1A1A1A1A1A1
      A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1
      A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1
      3315A13218A1A1A1A14B4A24A1A1A1A1A1A1A1A1A1A1A1A1851BA14E4EA1A1A1
      A1A4A429A1A1A1A1A1A1A1A10B0B070EA96C2B793A0C07070D83A31406050505
      01A1A1A10B7F93735DA9996B3B565647346AA22A312F271E01A1A1A10B9FADAD
      6491984F757F7777546AA239423F362701A1A1A10B93ADAD8B7B98517F7F7777
      546AA23948413F2F01A1A1A10B93ADAD9C6D98518E8E7F776583A2434847412F
      01A1A1A10B93ADAD9C7B99518E8F8E805F95A44C4747473601A1A1A10B93ADAD
      9C7CA85E93938F905A97A5585457563601A1A1A10B93ADAD9C7CA86193939390
      59A7A66A5457674101A1A1A10B93ADAD9C7DA8619FADA0945F84964D67773E2D
      01A1A1A10B93ADAD927D9962AD66528C451113168067122301A1A1A10B93AD9E
      639AAA6C721917191F212117261D102D01A1A1A10B93AD8A879B6D9144203C19
      455353452517225701A1A1A10B93AD8988607E5B621D1C1C252C2C251F3D8F67
      01A1A1A10B9FAD9D7050AB71AB9E9CADAC8B8B8B93A0937601A1A1A10B374242
      412E404848484842484842423737312701A1A1A1060303030303030303030303
      030303030303030301A1A1A10F00010101010101010101010101010101010101
      0FA1A1A1A10A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0AA1A1A1A1A1A1A1A1
      A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1A1}
    Layout = blGlyphTop
    ParentFont = False
    OnClick = SpeedButton3Click
  end
  object BdnLoad: TButton
    Left = 1296
    Top = 456
    Width = 113
    Height = 33
    Caption = 'Download Task'
    TabOrder = 0
    Visible = False
    OnClick = BdnLoadClick
  end
  object Button2: TButton
    Left = 1005
    Top = 576
    Width = 113
    Height = 33
    Caption = 'Delete Table'
    TabOrder = 1
    Visible = False
  end
  object Button3: TButton
    Left = 904
    Top = 288
    Width = 81
    Height = 25
    Caption = 'OnLine'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 1048
    Top = 216
    Width = 81
    Height = 24
    TabOrder = 3
    Text = '1'
  end
  object BdnLoadFk: TButton
    Left = 1285
    Top = 528
    Width = 113
    Height = 33
    Caption = 'Download Free Task'
    TabOrder = 4
    Visible = False
    OnClick = BdnLoadFkClick
  end
  object GroupBox1: TGroupBox
    Left = 560
    Top = 192
    Width = 241
    Height = 129
    Caption = 'Form Durumlar'#305
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 81
      Height = 16
      Caption = 'Form Adlar'#305
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 53
      Height = 16
      Caption = 'Kay'#305'tlar'
    end
    object Label3: TLabel
      Left = 16
      Top = 96
      Width = 50
      Height = 16
      Caption = 'Alanlar'
    end
    object CBfmName: TComboBox
      Left = 112
      Top = 25
      Width = 121
      Height = 24
      ItemHeight = 16
      TabOrder = 0
      OnClick = CBfmNameClick
    end
    object Erec1: TEdit
      Left = 111
      Top = 64
      Width = 49
      Height = 24
      Enabled = False
      TabOrder = 1
    end
    object Erec2: TEdit
      Left = 180
      Top = 64
      Width = 49
      Height = 24
      Enabled = False
      TabOrder = 2
    end
    object Efd2: TEdit
      Left = 179
      Top = 96
      Width = 49
      Height = 24
      Enabled = False
      TabOrder = 3
    end
    object Efd1: TEdit
      Left = 110
      Top = 96
      Width = 49
      Height = 24
      Enabled = False
      TabOrder = 4
    end
  end
  object Edit2: TEdit
    Left = 1112
    Top = 304
    Width = 81
    Height = 24
    TabOrder = 6
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 896
    Top = 224
    Width = 81
    Height = 25
    Caption = 'OffLine'
    TabOrder = 7
    OnClick = Button1Click
  end
  object StsBar1: TStatusBar
    Left = 0
    Top = 111
    Width = 374
    Height = 25
    Panels = <
      item
        Text = 'Durum : '
        Width = 50
      end
      item
        Width = 50
      end>
    ParentFont = True
    UseSystemFont = False
  end
  object Memo1: TMemo
    Left = 8
    Top = 584
    Width = 1233
    Height = 89
    TabOrder = 9
    Visible = False
  end
  object Memo2: TMemo
    Left = 648
    Top = 417
    Width = 569
    Height = 144
    TabOrder = 10
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Task File|*.TSL'
    Left = 456
    Top = 160
  end
  object SD1: TSaveDialog
    Filter = 'Metin Dosyas'#305'|*.TXT|Microsoft Excel Dosyas'#305'|*.XLS'
    FilterIndex = 0
    OnCanClose = SD1CanClose
    Left = 776
    Top = 104
  end
end
