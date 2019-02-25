unit UntKullaniciListesi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,  Buttons, DB, ADODB,  AdvToolBar, AdvToolBarStylers,
  Mask, ToolEdit, CurrEdit, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, dxPSGlbl, dxPSUtl, dxPSEngn,
  dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSCore, dxPScxCommon, dxPScxGridLnk, Grids, DBGrids;

type
  TFrmKullaniciListesi = class(TForm)
    DSPerQuery: TDataSource;
    PerQuery: TADOQuery;
    AdvToolBarFantasyStyler1: TAdvToolBarFantasyStyler;
    Panel4: TPanel;
    Image9: TImage;
    Panel3: TPanel;
    Image2: TImage;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    BtnKapat: TAdvToolBarButton;
    BtnSil: TAdvToolBarButton;
    BtnDegistir: TAdvToolBarButton;
    BtnEkle: TAdvToolBarButton;
    BtnYazdir: TAdvToolBarButton;
    Label16: TLabel;
    Label17: TLabel;
    pnlIslem: TPanel;
    PnlCaption: TPanel;
    Shape1: TShape;
    CapImage: TImage;
    lblCaption: TLabel;
    BtnUygula: TSpeedButton;
    BtnIptal: TSpeedButton;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    txtKullaniciAdi: TEdit;
    Label6: TLabel;
    txtSifre: TEdit;
    DBGrid1: TDBGrid;
    ds1: TDataSource;
    qry1: TADOQuery;
    procedure BtnEkleClick(Sender: TObject);
    procedure BtnDegistirClick(Sender: TObject);
    procedure BtnSilClick(Sender: TObject);
    procedure BtnKapatClick(Sender: TObject);
    procedure BtnYazdirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnIptalClick(Sender: TObject);
    procedure BtnUygulaClick(Sender: TObject);
    procedure Panel4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Tmpid:string;
    procedure Islem(Durum:Boolean;Baslik:String);
    procedure SetGridView();
    procedure PersonelKayit();
    procedure PersonelDegistir();
    procedure PersonelSil();
  end;

var
  FrmKullaniciListesi: TFrmKullaniciListesi;
  ActPerID:string;

implementation

uses  UntDm,UntGlobal, UntOnay;

{$R *.dfm}
// ***
function KullaniciAdi(bak:String):Boolean;
begin
with dm.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * from Kullanici Where KullaniciAdi=:bak ');
  Parameters.ParamByName('bak').Value :=bak;
  Open;
   if  RecordCount=0 then
    KullaniciAdi:=True
  else
  begin
   showmessage('Kullanýcý Adý Daha Önceden Kullanýlmýþtýr.');
   KullaniciAdi:=False;
  end;
end;
end;
// ***    
procedure TFrmKullaniciListesi.SetGridView();
begin

with qry1 do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * From Kullanici');
  Open;
end;

end;

// ***
procedure TFrmKullaniciListesi.BtnEkleClick(Sender: TObject);
begin
  Islem(True,'Kaydet');
  txtKullaniciAdi.Text:='';
  txtSifre.Text     :='';
end;
// ***
procedure TFrmKullaniciListesi.BtnDegistirClick(Sender: TObject);
begin
  // *** Personel Bilgi Deðiþtirme
  with qry1 do
  begin
    txtKullaniciAdi.Text:=FieldByName('KullaniciAdi').AsString;
    txtSifre.Text     :=FieldByName('Sifre').AsString     ;
    Tmpid:=FieldByName('id').AsString;
  end;
  Islem(True,'Güncelle');
end;
// ***
procedure TFrmKullaniciListesi.BtnSilClick(Sender: TObject);
begin
  // *** Personel Silme
  with qry1 do
  begin
    txtKullaniciAdi.Text:=FieldByName('KullaniciAdi').AsString;
    txtSifre.Text     :=FieldByName('Sifre').AsString     ;
    Tmpid:=FieldByName('iD').AsString;
  end;
  Islem(True,'Sil');
end;
// ***
procedure TFrmKullaniciListesi.BtnKapatClick(Sender: TObject);
begin
  Self.Close;
end;
// ***
procedure TFrmKullaniciListesi.BtnYazdirClick(Sender: TObject);
begin

end;
// ***
procedure TFrmKullaniciListesi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Panel4.Enabled=True then
begin
  if (key = vk_F4) and (BtnEkle.Visible=True)     then   BtnEkle.Click;
  if (key = vk_F5) and (BtnDegistir.Visible=True) then   BtnDegistir.Click;
  if (key = vk_F6) and (BtnSil.Visible=True)      then   BtnSil.Click;
  if (key = vk_F8) and (BtnYazdir.Visible=True)   then   BtnYazdir.Click;
  if key=vk_F10 then BtnKapat.Click;
end;
  if (key=vk_escape) and (pnlIslem.Visible=True) then islem(False,'---');
end;
// ***
procedure TFrmKullaniciListesi.Islem(Durum: Boolean; Baslik: String);
begin
  panel4.Enabled    :=not durum;
  pnlIslem.Visible  :=Durum;
  BtnUygula.Caption :=Baslik;
 
  if BtnUygula.Caption='Kaydet'   then txtKullaniciAdi.SetFocus;
  if BtnUygula.Caption='Kaydet'   then lblCaption.Caption:='Yeni Kullanýcý  Ekle   ';
  if BtnUygula.Caption='Güncelle' then lblCaption.Caption:='Kullanýcý Bilgisini Deðiþtir  ';
  if BtnUygula.Caption='Sil'      then lblCaption.Caption:='Kullanýcý Bilgisini Sil  ';
end;
// ***
procedure TFrmKullaniciListesi.BtnIptalClick(Sender: TObject);
begin
  Islem(False,'--');
end;
// ***
procedure TFrmKullaniciListesi.BtnUygulaClick(Sender: TObject);
begin
  if BtnUygula.Caption='Kaydet'   then PersonelKayit;
  if BtnUygula.Caption='Güncelle' then PersonelDegistir;
  if BtnUygula.Caption='Sil'      then PersonelSil;
end;
// ***
procedure TFrmKullaniciListesi.PersonelKayit;
begin
// *** kontroller
if Length(trim(txtKullaniciAdi.Text))=0 then
begin
  showmessage('Kullanýcý Adý Giriniz.');
  txtKullaniciAdi.SetFocus;
  exit;
end;
if Length(trim(txtSifre.Text))=0 then
begin
  showmessage('Þifrenizi Giriniz.');
  txtSifre.SetFocus;
  exit;
end;
if KullaniciAdi(Trim(txtKullaniciAdi.Text))=False then Exit;
with qry1 do
begin
  Close;
  SQL.Clear;
  SQL.Add('Insert Into  Kullanici (KullaniciAdi,Sifre)  ');
  SQL.Add('Values(:KullaniciAdi,:Sifre) ');
  Parameters.ParamByName('KullaniciAdi').Value:=txtKullaniciAdi.Text;
  Parameters.ParamByName('Sifre').Value    :=txtSifre.Text;
  Prepared ;
  ExecSQL;
end;
  SetGridView;
end;
// ***
procedure TFrmKullaniciListesi.PersonelDegistir;
begin
// *** kontroller
if Length(trim(txtKullaniciAdi.Text))=0 then
begin
  showmessage('Kullanýcý Adý Giriniz.');
  txtKullaniciAdi.SetFocus;
  exit;
end;
if Length(trim(txtSifre.Text))=0 then
begin
  showmessage('Þifrenizi Giriniz.');
  txtSifre.SetFocus;
  exit;
end;
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * From Kullanici Where kullaniciadi=:Actkullaniciadi and RecID<>'+ ActPerID );
  Parameters.ParamByName('Actkullaniciadi').Value    :=txtKullaniciAdi.Text;
  Prepared ;
  Open;
  if recordcount>0 then
  begin
    showmessage('Kullanici Adi Kullanýlmýþtýr.');
    exit;
  end;
  Close;
  SQL.Clear;
  SQL.Add('Select * From Kullanici Where  KullaniciAdi=:ActKullanici and RecID<>'+ ActPerID );
  Parameters.ParamByName('ActKullanici').Value:=Trim(txtKullaniciAdi.Text);
  Prepared ;
  Open;
  if recordcount>0 then
  begin
    showmessage('Kullanýcý Adý  Kullanýlmýþtýr.');
    exit;
  end;
  Close;
  SQL.Clear;
  SQL.Add('Select * From Kullanici Where RecID='+ActPerID);
  Prepared ;
  Open;
  Edit;
    FieldByName('KullaniciAdi').AsString:=txtKullaniciAdi.Text;
    FieldByName('Sifre').AsString     :=txtSifre.Text;
  Post;
end;
  Islem(False,'---');
  SetGridView;
end;
// **
procedure TFrmKullaniciListesi.PersonelSil;
begin
 // if Onay('Kullanýcý Silinecektir.'+#13+'Devam Etmek Ýstiyor Musunuz ?')=False then exit;
  with DM.Qrylist do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Delete * From Haklar Where Kullaniciid='+Tmpid);
    ExecSQL;
    Close;
    SQL.Clear;
    SQL.Add('Delete * From Kullanici Where id='+Tmpid);
    ExecSQL;
  end;
  Islem(False,'---');
  SetGridView;
end;
// ***
procedure TFrmKullaniciListesi.Panel4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 ReleaseCapture;
 self.perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TFrmKullaniciListesi.FormShow(Sender: TObject);
begin
SetGridView;
end;

end.
