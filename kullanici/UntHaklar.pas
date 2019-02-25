unit UntHaklar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, ADODB, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvToolBar, StdCtrls, ExtCtrls,
  AdvToolBarStylers, Grids, BaseGrid, AdvGrid, Buttons, ComCtrls, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxCommon, dxPScxGridLnk,
  dxPSBaseGridLnk, dxPSGrLnks, dxPSStdGrLnk;

type
  TFrmHaklar = class(TForm)
    AdvToolBarFantasyStyler1: TAdvToolBarFantasyStyler;
    Panel4: TPanel;
    Panel3: TPanel;
    Image2: TImage;
    Label16: TLabel;
    Label17: TLabel;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    BtnKapat: TAdvToolBarButton;
    BtnEkle: TAdvToolBarButton;
    BtnYazidr: TAdvToolBarButton;
    Panel1: TPanel;
    GrdHaklar: TAdvStringGrid;
    pnlIslem: TPanel;
    Label4: TLabel;
    BtnArama: TSpeedButton;
    txtKullaniciAdi: TEdit;
    StatusBar1: TStatusBar;
    PrintPreview: TdxComponentPrinter;
    PrintPreviewLink1: TdxStringGridReportLink;
    procedure GrdHaklarCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure GrdHaklarGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure BtnKapatClick(Sender: TObject);
    procedure BtnEkleClick(Sender: TObject);
    procedure BtnAramaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtnYazidrClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Haklar();
  end;

var
  FrmHaklar: TFrmHaklar;

implementation

uses UntDm, UntDlgUserSearch, UntGlobal;

{$R *.dfm}

// ***
procedure TFrmHaklar.GrdHaklarCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
if Acol <> 2 then
  CanEdit:=True
else
  CanEdit:=False;
end;
// **
procedure TFrmHaklar.GrdHaklarGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (Acol<>2) and (ARow>0) then HAlign:=taCenter;
end;
// ***
procedure TFrmHaklar.BtnKapatClick(Sender: TObject);
begin
  self.Close;
end;
// ***
procedure TFrmHaklar.BtnEkleClick(Sender: TObject);
var
  i:integer;
begin
if txtKullaniciAdi.Text='' then
begin
  showmessage('Lütfen Kullanýcý Seçimi Yapýnýz.');
  Exit;
end;
with dm.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Delete * from Haklar Where ');
  SQL.Add('PerNo='+inttostr(txtKullaniciAdi.tag));
  ExecSQL;
  for i :=1  to GrdHaklar.RowCount-1 do
  begin
    if (GrdHaklar.Cells[1,i]='Y')  then
    begin
      Close;
      SQL.Clear;
      SQL.Add('Insert into Haklar ');
      SQL.Add('(PerNo,Sira,Gorme,Kayit,Degistir,Sil,Yazdir,TagNo) Values');
      SQL.Add('(:PerNo,:Sira,:Gorme,:Kayit,:Degistir,:Sil,:Yazdir,:TagNo)');
      Parameters.ParamByName('PerNo').Value   :=txtKullaniciAdi.tag;
      Parameters.ParamByName('Sira').Value    :=i;
      Parameters.ParamByName('Gorme').Value   :=GrdHaklar.Cells[1,i];
      Parameters.ParamByName('Kayit').Value   :=GrdHaklar.Cells[3,i];
      Parameters.ParamByName('Degistir').Value:=GrdHaklar.Cells[4,i];
      Parameters.ParamByName('Sil').Value     :=GrdHaklar.Cells[5,i];
      Parameters.ParamByName('Yazdir').Value  :=GrdHaklar.Cells[6,i];
      Parameters.ParamByName('TagNo').Value   :=GrdHaklar.Cells[7,i];
      Prepared;
      ExecSQL;
    end;
  end;
end;
end;
// ***
procedure TFrmHaklar.BtnAramaClick(Sender: TObject);
begin
  // *** Personel Arama
  FrmDlgUserSearch:=TFrmDlgUserSearch.Create(Self);
  FrmDlgUserSearch.ShowModal;
  if not FrmDlgUserSearch.iptal then
  begin
    txtKullaniciAdi.Text:=FrmDlgUserSearch.AKullanici;
    txtKullaniciAdi.Tag :=FrmDlgUserSearch.ARecID;
    Haklar;
  end;
  FrmDlgUserSearch.Release;
end;
// ***
procedure TFrmHaklar.Haklar;
var
  i,r,y:integer;
  tmp:string;
  modul:array of integer;
begin
  GrdHaklar.RemoveAllNodes;
  GrdHaklar.ClearRows(1,GrdHaklar.RowCount);
  GrdHaklar.MergeCells(0,0,2,1);
with dm.Qrylist do
begin
  close;
  SQL.Clear;
  SQL.Add('Select Count(TanimNo) as toplam From Moduller ');
  SQL.Add(' Group By ModulNo  Order by ModulNo  Asc');
  Open;
  SetLength(modul,RecordCount+1);
  for  i:=1  to RecordCount do
  begin
    modul[i]:=FieldByName('Toplam').AsInteger;
    next;
  end;
  close;
  SQL.Clear;
  SQL.Add('Select ModulNo,TanimNo,Tanim From Moduller ');
  SQL.Add('Order by ModulNo,TanimNo  Asc');
  Open;
  GrdHaklar.RowCount:=RecordCount+1;
  r:=0;
  for  i:=1  to RecordCount do
  begin
    if tmp<> FieldByName('ModulNo').AsString then
    begin
      tmp:=FieldByName('ModulNo').AsString;
      r:=r+1;
      GrdHaklar.AddNode(i,modul[r]);
      GrdHaklar.AddCheckBox(1,i,False,True);
      GrdHaklar.RowColor[i]:=clInfoBk;
    end;
    if FieldByName('TanimNo').AsInteger <> 0 then
    begin
      GrdHaklar.AddCheckBox(1,i,False,True);
      GrdHaklar.AddCheckBox(3,i,False,True);
      GrdHaklar.AddCheckBox(4,i,False,True);
      GrdHaklar.AddCheckBox(5,i,False,True);
      GrdHaklar.AddCheckBox(6,i,False,True);
    end;
    GrdHaklar.Cells[2,i]:=FieldByName('Tanim').AsString;
    GrdHaklar.Cells[7,i]:=FieldByName('ModulNo').AsString+FieldByName('TanimNo').AsString;;
    next;
  end;
  // *** Kullanýcý Haklarýný oku
  Close;
  SQL.Clear;
  SQL.Add('Select * from Haklar Where ');
  SQL.Add('PerNo='+ IntToStr(txtKullaniciAdi.tag));
  Open;
  for i :=1  to RecordCount  do
  begin
    y:=FieldByName('sira').AsInteger;
    GrdHaklar.Cells[1,y]:=FieldByName('Gorme').AsString;
    GrdHaklar.Cells[3,y]:=FieldByName('Kayit').AsString;
    GrdHaklar.Cells[4,y]:=FieldByName('Degistir').AsString;
    GrdHaklar.Cells[5,y]:=FieldByName('Sil').AsString;
    GrdHaklar.Cells[6,y]:=FieldByName('Yazdir').AsString;
    GrdHaklar.Cells[7,y]:=FieldByName('TagNo').AsString;
    next;
  end;
end;
end;


procedure TFrmHaklar.FormShow(Sender: TObject);
var
region: HRgn;
begin
  StatusBar1.SimplePanel:=True;
  StatusBar1.SimpleText:=ProCaption;
  region:=CreateRoundRectRgn(1, 1,Width ,Height , 20, 20);
  SetWindowRgn(handle, region, true);
end;

procedure TFrmHaklar.Image9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ReleaseCapture;
 self.perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmHaklar.BtnYazidrClick(Sender: TObject);
var
  capStr:string;

begin
  capStr:='Kayýt No :'+IntToStr(txtKullaniciAdi.tag)+'    Kullanýcý Adý :' + txtKullaniciAdi.Text;
 PrintPreviewLink1.ReportTitleText:=capStr;
 PrintPreviewLink1.PrinterPage.Orientation:=poPortrait;
 PrintPreviewLink1.PrinterPage.PageHeader.RightTitle .Clear;
  PrintPreviewLink1.PrinterPage.PageHeader.RightTitle.Add( 'Döküm Tarihi:'+ FormatDateTime('dd.mm.yyyy',date));
 PrintPreviewLink1.PrinterPage.PageFooter.CenterTitle.Clear;
  PrintPreviewLink1.PrinterPage.PageFooter.CenterTitle.Add(ProCaption);
 PrintPreview.Preview(True,PrintPreviewLink1);
end;

end.
