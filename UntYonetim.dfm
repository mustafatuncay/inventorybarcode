object FrmYonetim: TFrmYonetim
  Left = 0
  Top = 0
  ClientHeight = 669
  ClientWidth = 1219
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 1219
    Height = 628
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Kullan'#305'c'#305' Haklar'#305
      object Label2: TLabel
        Left = 523
        Top = 4
        Width = 43
        Height = 13
        Caption = 'Haklar :'
      end
      object Label3: TLabel
        Left = 47
        Top = 14
        Width = 73
        Height = 13
        Caption = 'Kullan'#305'c'#305' Ad'#305' :'
      end
      object Label4: TLabel
        Left = 87
        Top = 42
        Width = 32
        Height = 13
        Caption = #350'ifre :'
      end
      object Label5: TLabel
        Left = 13
        Top = 70
        Width = 110
        Height = 13
        Caption = #350'ifreyi Tekrarlay'#305'n :'
      end
      object AdvListe: TAdvStringGrid
        Left = 3
        Top = 139
        Width = 479
        Height = 278
        Cursor = crDefault
        Align = alCustom
        ColCount = 3
        RowCount = 2
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        OnDblClick = AdvListeDblClick
        HoverRowCells = [hcNormal, hcSelected]
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ColumnHeaders.Strings = (
          ''
          'Kullan'#305'c'#305' Ad'#305
          #350'ifre')
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Clear')
        FixedColWidth = 40
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SortSettings.DefaultFormat = ssAutomatic
        Version = '7.8.7.0'
        ColWidths = (
          40
          158
          170)
      end
      object ChkLbHaklar: TCheckListBox
        Left = 505
        Top = 23
        Width = 241
        Height = 402
        ItemHeight = 13
        Items.Strings = (
          'Malzeme Kodlar'#305
          'Demirba'#351' Kay'#305'tlar'#305
          'Personel Kay'#305'tlar'#305
          'Sabit Tan'#305'mlar'
          'Zimmet'
          'Raporlar'
          'Demirba'#351' Say'#305'm Kontrol'
          'Y'#246'netim')
        TabOrder = 1
      end
      object BtnKaydet: TButton
        Left = 10
        Top = 108
        Width = 75
        Height = 25
        Caption = 'Kaydet'
        TabOrder = 2
        OnClick = BtnKaydetClick
      end
      object BtnGuncelle: TButton
        Left = 91
        Top = 108
        Width = 75
        Height = 25
        Caption = 'G'#252'ncelle'
        Enabled = False
        TabOrder = 3
        OnClick = BtnGuncelleClick
      end
      object BtnSil: TButton
        Left = 172
        Top = 108
        Width = 75
        Height = 25
        Caption = 'Sil'
        Enabled = False
        TabOrder = 4
        OnClick = BtnSilClick
      end
      object BtnYeni: TButton
        Left = 253
        Top = 108
        Width = 75
        Height = 25
        Caption = 'Yeni'
        TabOrder = 5
        OnClick = BtnYeniClick
      end
      object TxtKullaniciAdi: TEdit
        Left = 123
        Top = 11
        Width = 239
        Height = 21
        TabOrder = 6
      end
      object TxtSifre: TEdit
        Left = 124
        Top = 39
        Width = 238
        Height = 21
        PasswordChar = '*'
        TabOrder = 7
      end
      object TxtTekrarSifre: TEdit
        Left = 124
        Top = 67
        Width = 238
        Height = 21
        PasswordChar = '*'
        TabOrder = 8
      end
      object ChkSelect: TCheckBox
        Left = 505
        Top = 3
        Width = 17
        Height = 17
        TabOrder = 9
        OnClick = ChkSelectClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Demirba'#351' Kay'#305'tlar'#305
      ImageIndex = 1
      object DBGrid1: TDBGrid
        Left = 0
        Top = 83
        Width = 1211
        Height = 517
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1211
        Height = 83
        Align = alTop
        TabOrder = 1
        object Label1: TLabel
          Left = 16
          Top = 32
          Width = 45
          Height = 13
          Caption = 'Oda No :'
        end
        object CurrOdaNo: TSpinEdit
          Left = 67
          Top = 29
          Width = 121
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object Button1: TButton
          Left = 248
          Top = 27
          Width = 75
          Height = 25
          Caption = 'Listele'
          TabOrder = 1
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 416
          Top = 27
          Width = 201
          Height = 25
          Caption = 'Demirbas Detaylari Tamamla'
          TabOrder = 2
          OnClick = Button2Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Ayarlar'
      ImageIndex = 2
      object Label7: TLabel
        Left = 144
        Top = 115
        Width = 49
        Height = 13
        Caption = 'Oda Ad'#305' :'
      end
      object Label8: TLabel
        Left = 117
        Top = 190
        Width = 76
        Height = 13
        Caption = 'Yeni Oda Ad'#305' :'
      end
      object Label9: TLabel
        Left = 148
        Top = 91
        Width = 45
        Height = 13
        Caption = 'Oda No :'
      end
      object Txtodaadi: TEdit
        Left = 200
        Top = 187
        Width = 217
        Height = 21
        TabOrder = 0
      end
      object cmbodaadi: TComboBox
        Left = 199
        Top = 112
        Width = 217
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cmbodaadiChange
      end
      object BtnDegistir: TButton
        Left = 200
        Top = 214
        Width = 75
        Height = 25
        Caption = 'Degistir'
        TabOrder = 2
        OnClick = BtnDegistirClick
      end
      object Button3: TButton
        Left = 194
        Top = 52
        Width = 75
        Height = 25
        Caption = 'Listele'
        TabOrder = 3
        OnClick = Button3Click
      end
      object cmbodano: TComboBox
        Left = 200
        Top = 88
        Width = 75
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        OnChange = cmbodanoChange
      end
      object BtnMalzeme: TButton
        Left = 216
        Top = 376
        Width = 193
        Height = 25
        Caption = 'Malzeme Kodu Yukle'
        TabOrder = 5
        OnClick = BtnMalzemeClick
      end
      object Button8: TButton
        Left = 601
        Top = 51
        Width = 280
        Height = 25
        Caption = 'Demirba'#351'lar'#305' Ya'#351'land'#305'r'
        TabOrder = 6
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 601
        Top = 110
        Width = 280
        Height = 25
        Caption = 'Button9'
        TabOrder = 7
        OnClick = Button9Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Demirba'#351'lar'#305' Y'#252'kle'
      ImageIndex = 3
      object AdvAktarma: TAdvStringGrid
        Left = 0
        Top = 82
        Width = 1211
        Height = 518
        Cursor = crDefault
        Align = alClient
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
        ScrollBars = ssBoth
        TabOrder = 0
        HoverRowCells = [hcNormal, hcSelected]
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDown.TextChecked = 'Checked'
        FilterDropDown.TextUnChecked = 'Unchecked'
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Clear')
        FixedRowHeight = 22
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SortSettings.DefaultFormat = ssAutomatic
        Version = '7.8.7.0'
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1211
        Height = 82
        Align = alTop
        TabOrder = 1
        object Label28: TLabel
          Left = 318
          Top = 28
          Width = 66
          Height = 16
          Caption = 'B'#246'l'#252'm Ad'#305
          Color = clWhite
          Font.Charset = TURKISH_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
        object Button4: TButton
          Left = 43
          Top = 24
          Width = 75
          Height = 25
          Caption = 'Exceli A'#231
          TabOrder = 0
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 124
          Top = 24
          Width = 184
          Height = 25
          Caption = 'Demirba'#351'lar'#305' Sisteme Y'#252'kle'
          TabOrder = 1
          OnClick = Button5Click
        end
        object CmbBolumAdi: TComboBox
          Left = 390
          Top = 26
          Width = 283
          Height = 21
          ItemHeight = 13
          TabOrder = 2
          OnDropDown = CmbBolumAdiDropDown
          Items.Strings = (
            'Poliklinik'
            'Thalasamia'
            'Ayaktan Tan'#305
            'Diyabet'
            'N'#252'kleer T'#305'p'
            'Onkoloji'
            'Anabina')
        end
        object Button6: TButton
          Left = 763
          Top = 24
          Width = 246
          Height = 25
          Caption = 'Demirba'#351'lar'#305' Adetlerine G'#246're Kaydet'
          TabOrder = 3
          OnClick = Button6Click
        end
        object Button7: TButton
          Left = 124
          Top = 51
          Width = 184
          Height = 25
          Caption = 'Demirba'#351'lar'#305' Sisteme Y'#252'kle   2'
          TabOrder = 4
          OnClick = Button7Click
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1219
    Height = 41
    Align = alTop
    TabOrder = 1
    object Label6: TLabel
      Left = 7
      Top = 7
      Width = 244
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = 'Y'#214'NET'#304'M AYARLARI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
  end
  object Qry1: TADOQuery
    Connection = Dm.cnn1
    Parameters = <>
    Left = 552
    Top = 65528
  end
  object QryDemirbas: TADOQuery
    Connection = Dm.cnn1
    Parameters = <>
    Left = 736
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = QryDemirbas
    Left = 552
    Top = 40
  end
  object OpenDialog1: TOpenDialog
    Left = 1024
    Top = 72
  end
  object qry2: TADOQuery
    Connection = Dm.cnn1
    Parameters = <>
    Left = 608
    Top = 65528
  end
end
