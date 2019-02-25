object FrmSayimKontrol: TFrmSayimKontrol
  Left = 273
  Top = 121
  ClientHeight = 697
  ClientWidth = 958
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object AdvListe: TAdvStringGrid
    Left = 0
    Top = 201
    Width = 958
    Height = 496
    Cursor = crDefault
    Align = alClient
    DefaultRowHeight = 21
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing]
    ParentFont = False
    PopupMenu = PopupMenu1
    ScrollBars = ssBoth
    TabOrder = 0
    HoverRowCells = [hcNormal, hcSelected]
    OnCanEditCell = AdvListeCanEditCell
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    CellNode.TreeColor = clSilver
    ColumnHeaders.Strings = (
      'Oda No'
      ''
      'Barkod No'
      'E'#351'yan'#305'n Cinsi'
      'A'#231#305'klama')
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.ControlStyle = csWinXP
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
    FilterDropDown.Font.Name = 'MS Sans Serif'
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
    FixedColWidth = 65
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Title = ppTopCenter
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'MS Sans Serif'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'MS Sans Serif'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = TURKISH_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -16
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = [fsBold]
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'MS Sans Serif'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'MS Sans Serif'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurence'
    SearchFooter.HintFindPrev = 'Find previous occurence'
    SearchFooter.HintHighlight = 'Highlight occurences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SortSettings.DefaultFormat = ssAutomatic
    SortSettings.Column = 0
    Version = '7.2.8.0'
    ColWidths = (
      65
      29
      140
      226
      476)
    object AdvTmp: TAdvStringGrid
      Left = 624
      Top = 40
      Width = 273
      Height = 361
      Cursor = crDefault
      ColCount = 2
      DefaultRowHeight = 21
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      Visible = False
      HoverRowCells = [hcNormal, hcSelected]
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Tahoma'
      ActiveCellFont.Style = [fsBold]
      CellNode.TreeColor = clSilver
      ControlLook.FixedGradientHoverFrom = clGray
      ControlLook.FixedGradientHoverTo = clWhite
      ControlLook.FixedGradientDownFrom = clGray
      ControlLook.FixedGradientDownTo = clSilver
      ControlLook.ControlStyle = csWinXP
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
      FilterDropDown.Font.Name = 'MS Sans Serif'
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
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = [fsBold]
      FloatFormat = '%.2f'
      PrintSettings.DateFormat = 'dd/mm/yyyy'
      PrintSettings.Font.Charset = DEFAULT_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -11
      PrintSettings.Font.Name = 'MS Sans Serif'
      PrintSettings.Font.Style = []
      PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
      PrintSettings.FixedFont.Color = clWindowText
      PrintSettings.FixedFont.Height = -11
      PrintSettings.FixedFont.Name = 'MS Sans Serif'
      PrintSettings.FixedFont.Style = []
      PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -11
      PrintSettings.HeaderFont.Name = 'MS Sans Serif'
      PrintSettings.HeaderFont.Style = []
      PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -11
      PrintSettings.FooterFont.Name = 'MS Sans Serif'
      PrintSettings.FooterFont.Style = []
      PrintSettings.PageNumSep = '/'
      SearchFooter.FindNextCaption = 'Find &next'
      SearchFooter.FindPrevCaption = 'Find &previous'
      SearchFooter.Font.Charset = DEFAULT_CHARSET
      SearchFooter.Font.Color = clWindowText
      SearchFooter.Font.Height = -11
      SearchFooter.Font.Name = 'MS Sans Serif'
      SearchFooter.Font.Style = []
      SearchFooter.HighLightCaption = 'Highlight'
      SearchFooter.HintClose = 'Close'
      SearchFooter.HintFindNext = 'Find next occurence'
      SearchFooter.HintFindPrev = 'Find previous occurence'
      SearchFooter.HintHighlight = 'Highlight occurences'
      SearchFooter.MatchCaseCaption = 'Match case'
      SortSettings.DefaultFormat = ssAutomatic
      SortSettings.Column = 0
      Version = '7.2.8.0'
      ColWidths = (
        64
        166)
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 958
    Height = 201
    Align = alTop
    BevelOuter = bvNone
    Color = 11908533
    TabOrder = 1
    object Label7: TLabel
      Left = 32
      Top = 432
      Width = 59
      Height = 16
      Caption = 'A'#231#305'klama'
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
    object Shape1: TShape
      Left = 182
      Top = 18
      Width = 54
      Height = 3
      Brush.Color = clNone
    end
    object Shape2: TShape
      Left = 217
      Top = 52
      Width = 22
      Height = 3
      Brush.Color = clNone
    end
    object Shape3: TShape
      Left = 215
      Top = 19
      Width = 3
      Height = 105
      Brush.Color = clNone
    end
    object Shape4: TShape
      Left = 217
      Top = 87
      Width = 22
      Height = 3
      Brush.Color = clNone
    end
    object Shape6: TShape
      Left = 217
      Top = 121
      Width = 22
      Height = 3
      Brush.Color = clNone
    end
    object Label1: TLabel
      Left = 242
      Top = 140
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
      Left = 294
      Top = 165
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
    object MemAciklama: TMemo
      Left = 94
      Top = 432
      Width = 643
      Height = 65
      Font.Charset = TURKISH_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object txtyer: TEdit
      Left = 334
      Top = 139
      Width = 369
      Height = 17
      BorderStyle = bsNone
      TabOrder = 1
    end
    object txtizahat: TEdit
      Left = 334
      Top = 164
      Width = 369
      Height = 17
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      TabOrder = 2
    end
    object ChkOdalaraGore: TCheckBox
      Left = 407
      Top = 11
      Width = 90
      Height = 17
      Caption = 'Odalara G'#246're'
      Checked = True
      Font.Charset = TURKISH_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 3
    end
    object Button1: TButton
      Left = 39
      Top = 7
      Width = 137
      Height = 25
      Caption = 'Barkodlar'#305' Oku'
      TabOrder = 4
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 240
      Top = 8
      Width = 161
      Height = 25
      Caption = 'Barkodlar'#305' E'#351'le'#351'tir'
      TabOrder = 5
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 240
      Top = 40
      Width = 321
      Height = 25
      Caption = 'Se'#231'ili Demirba'#351'lara Demirba'#351' Kay'#305't Formu Yazd'#305'r (MF 7)'
      TabOrder = 6
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 240
      Top = 75
      Width = 321
      Height = 25
      Caption = 'Se'#231'ili Demirba'#351'lar Kullan'#305'ma Elveri'#351'li  De'#287'il  (ALK 1)'
      TabOrder = 7
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 240
      Top = 109
      Width = 321
      Height = 25
      Caption = 'Se'#231'ili Demirba'#351'lar'#305' Ba'#351'ka Daireye Aktar  (ALK 4)'
      TabOrder = 8
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 872
      Top = 168
      Width = 75
      Height = 25
      Caption = 'Yazd'#305'r'
      TabOrder = 9
      OnClick = Button6Click
    end
  end
  object Qry1: TADOQuery
    Connection = Dm.cnn1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 824
    Top = 160
  end
  object AdvGridPrintSettingsDialog1: TAdvGridPrintSettingsDialog
    Grid = AdvListe
    Options = [psBorders, psGeneral, psFonts, psDateTime, psTitle, psPages, psMargins, psSpacing, psOrientation, psSaveSettings]
    PrintDimensions = pdmm
    Left = 816
    Top = 88
  end
  object AdvPreviewDialog1: TAdvPreviewDialog
    CloseAfterPrint = False
    DialogCaption = 'Preview'
    DialogPrevBtn = 'Previous'
    DialogNextBtn = 'Next'
    DialogPrintBtn = 'Print'
    DialogCloseBtn = 'Close'
    Grid = AdvListe
    PreviewFast = False
    PreviewWidth = 350
    PreviewHeight = 300
    PreviewLeft = 100
    PreviewTop = 100
    PreviewCenter = False
    Left = 784
    Top = 88
  end
  object DataSource1: TDataSource
    DataSet = Qry1
    Left = 672
    Top = 64
  end
  object PopupMenu1: TPopupMenu
    Left = 688
    Top = 8
    object mnSe1: TMenuItem
      Caption = 'T'#252'm'#252'n'#252' Se'#231
      OnClick = mnSe1Click
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 856
    Top = 32
  end
  object QRCompositeReport1: TQRCompositeReport
    OnAddReports = QRCompositeReport1AddReports
    Options = [FirstPageHeader, LastPageFooter, Compression]
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrinterSettings.Orientation = poPortrait
    PrinterSettings.PaperSize = Letter
    ReportTitle = 'Composite Report'
    PageCount = 0
    Left = 752
    Top = 19
  end
  object Qry2: TADOQuery
    Connection = Dm.cnn1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 728
    Top = 72
  end
end
