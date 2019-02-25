unit UntRapor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Menus, DB, ADODB, StdCtrls, Buttons,
  Mask, Grids, DBGrids, ComCtrls, BaseGrid,
  AdvGrid, asgprev, asgprint, QuickRpt,
  tmsAdvGridExcel, AdvObj,DateUtils,StrUtils, pngimage;

type
  TFrmRapor = class(TForm)
    Label2: TLabel;
    LblStatus: TLabel;
    Panel4: TPanel;
    Image1: TImage;
    Panel5: TPanel;
    Image5: TImage;
    Label9: TLabel;
    Image6: TImage;
    Panel1: TPanel;
    Qry1: TADOQuery;
    ds1: TDataSource;
    Ds2: TDataSource;
    Qry2: TADOQuery;
    Ds3: TDataSource;
    Qry3: TADOQuery;
    Ds4: TDataSource;
    Qry4: TADOQuery;
    PopupMenu1: TPopupMenu;
    mnSe1: TMenuItem;
    BarkodBas1: TMenuItem;
    KullanmayaElveriliDeil1: TMenuItem;
    Dem1: TMenuItem;
    DemirbaKaytFormu1: TMenuItem;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    ElveriliOlmayanlarMevcutDemirbalaraGeiAl1: TMenuItem;
    SeiliKullanmaDemirbalarYazdrMF71: TMenuItem;
    mnSe2: TMenuItem;
    Ds5: TDataSource;
    Qry5: TADOQuery;
    AdvPreviewDialog1: TAdvPreviewDialog;
    AdvGridPrintSettingsDialog1: TAdvGridPrintSettingsDialog;
    PrintDialog1: TPrintDialog;
    QRCompositeReport1: TQRCompositeReport;
    AdvGridExcelIO1: TAdvGridExcelIO;
    SeiliDemirbalarBakaOdayaAktarma1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel8: TPanel;
    LblAktarilanYer: TLabel;
    txtesya: TEdit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    CmbGrupKodu: TComboBox;
    CmbGrupAdi: TComboBox;
    CmbTurKodu: TComboBox;
    CmbTurAdi: TComboBox;
    CmbCesitKodu: TComboBox;
    CmbCesitAdi: TComboBox;
    RbMevcutDemirbaslar: TRadioButton;
    RbElverisliOlmayanlar: TRadioButton;
    RbAktarilanlar: TRadioButton;
    txtaktarilanyer: TEdit;
    Panel2: TPanel;
    LblMesaj: TLabel;
    AdvDemirbas: TAdvStringGrid;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel9: TPanel;
    Panel7: TPanel;
    TxtKelime2: TEdit;
    CmbKriter2: TComboBox;
    DBGrid2: TDBGrid;
    Panel10: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    TxtPersonel: TEdit;
    CmbPersonel: TComboBox;
    CmbDemirbas: TComboBox;
    TxtDemirbas: TEdit;
    Panel11: TPanel;
    DBGrid3: TDBGrid;
    Panel6: TPanel;
    Label5: TLabel;
    CmbDemirbas2: TComboBox;
    TxtDemirbas2: TEdit;
    Panel12: TPanel;
    DBGrid4: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    TxtYazdirKelime1: TEdit;
    TxtYazdirKelime2: TEdit;
    ChkGrupOlmayan: TCheckBox;
    TabSheet5: TTabSheet;
    Panel3: TPanel;
    AdvDemirbasDetay: TAdvStringGrid;
    Button9: TButton;
    ChkKullanimaElverisli: TCheckBox;
    Label6: TLabel;
    TxtEsyaCinsi: TEdit;
    Label7: TLabel;
    TxtBarkodNo: TEdit;
    PopupMenu4: TPopupMenu;
    KullamnaElveriliOlarakaretle1: TMenuItem;
    Label8: TLabel;
    TxtOdaNo: TEdit;
    SeiliDemirbaDetaylarnBakaBarkodaAktar1: TMenuItem;
    Button10: TButton;
    AdvPreviewDialog2: TAdvPreviewDialog;
    Label10: TLabel;
    Label11: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    txtbarkod: TEdit;
    txtoda: TEdit;
    txtbolum1: TEdit;
    txtbolum2: TEdit;
    ChkCheck: TCheckBox;
    Label20: TLabel;
    TxtOdaAdi: TEdit;
    Button11: TButton;
    SaveDialog1: TSaveDialog;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    PnlTutanak: TPanel;
    Button15: TButton;
    TxtTeslimEdenAdi: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    TxtTeslimEdenSoyadi: TEdit;
    TxtTeslimAlanAdi: TEdit;
    Label24: TLabel;
    Label25: TLabel;
    TxtTeslimAlanSoyadi: TEdit;
    Image2: TImage;
    TabSheet6: TTabSheet;
    Panel13: TPanel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Button16: TButton;
    TxtTEsyaCinsi: TEdit;
    TxtTBarkodNo: TEdit;
    TxtTTutanakid: TEdit;
    Button17: TButton;
    AdvTutanak: TAdvStringGrid;
    AdvPreviewDialog3: TAdvPreviewDialog;
    Label29: TLabel;
    TxtSeriNo: TEdit;
    Label30: TLabel;
    TxtAciklama: TEdit;
    SeiliDemirbalarSil1: TMenuItem;
    Label31: TLabel;
    TxtTaciklama: TEdit;
    ChkTarih: TCheckBox;
    Dt1: TDateTimePicker;
    Dt2: TDateTimePicker;
    ChkDemirbasDetaylari: TCheckBox;
    ChkTurOlmayan: TCheckBox;
    ChkCesitOlmayan: TCheckBox;
    CmbSiralama: TComboBox;
    Label32: TLabel;
    RbS1: TRadioButton;
    RbS2: TRadioButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmbGrupKoduChange(Sender: TObject);
    procedure CmbGrupAdiChange(Sender: TObject);
    procedure CmbTurKoduChange(Sender: TObject);
    procedure CmbTurAdiChange(Sender: TObject);
    procedure CmbCesitKoduChange(Sender: TObject);
    procedure CmbCesitAdiChange(Sender: TObject);
    procedure CmbGrupKoduDropDown(Sender: TObject);
    procedure CmbGrupAdiDropDown(Sender: TObject);
    procedure CmbTurKoduDropDown(Sender: TObject);
    procedure CmbTurAdiDropDown(Sender: TObject);
    procedure CmbCesitKoduDropDown(Sender: TObject);
    procedure CmbCesitAdiDropDown(Sender: TObject);
    procedure AdvDemirbasCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure mnSe1Click(Sender: TObject);
    procedure BarkodBas1Click(Sender: TObject);
    procedure KullanmayaElveriliDeil1Click(Sender: TObject);
    procedure RbElverisliOlmayanlarClick(Sender: TObject);
    procedure RbMevcutDemirbaslarClick(Sender: TObject);
    procedure RbAktarilanlarClick(Sender: TObject);
    procedure Dem1Click(Sender: TObject);
    procedure ElveriliOlmayanlarMevcutDemirbalaraGeiAl1Click(
      Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtesyaChange(Sender: TObject);
    procedure txtaktarilanyerChange(Sender: TObject);
    procedure DemirbaKaytFormu1Click(Sender: TObject);
    procedure SeiliKullanmaDemirbalarYazdrMF71Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure mnSe2Click(Sender: TObject);
    procedure QRCompositeReport1AddReports(Sender: TObject);
    procedure SeiliDemirbalarBakaOdayaAktarma1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure AdvDemirbasCellsChanged(Sender: TObject; R: TRect);
    procedure KullamnaElveriliOlarakaretle1Click(Sender: TObject);
    procedure SeiliDemirbaDetaylarnBakaBarkodaAktar1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure ChkCheckClick(Sender: TObject);
    procedure TxtOdaAdiChange(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure AdvDemirbasGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure AdvDemirbasDblClick(Sender: TObject);
    procedure SeiliDemirbalarSil1Click(Sender: TObject);
  private
    FReport: TCustomQuickRep;

    { Private declarations }
  public

  procedure grupgetir;
  procedure turgetir;
  procedure cesitgetir;

  var  PubTemp:integer;
    { Public declarations }
  end;

var
  FrmRapor: TFrmRapor;

implementation

uses UntBarkod, UntAlk1, UntAlk4, UntGlobal, UntRepMf7, UntRepAlk1,
  UntRepAlk4, UntRepPersonel, UntRepZimmet, UntRepDemirbasGunlugu,
  UntRepAlk1Arka, UntRepBos, UntProjectGlobal, UntRepRapor2, UntRepRapor3,
  UntRepTutanak, UntDemirbasKayit;

{$R *.dfm}

procedure TFrmRapor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_ESCAPE then close;
end;

procedure TFrmRapor.CmbGrupKoduChange(Sender: TObject);
begin
AdvDemirbas.ClearRows(1,AdvDemirbas.RowCount-1);
AdvDemirbas.RowCount := 2;

CmbGrupAdi.ItemIndex:=CmbGrupKodu.ItemIndex;
end;

procedure TFrmRapor.CmbGrupAdiChange(Sender: TObject);
begin
CmbGrupKodu.ItemIndex:=CmbGrupAdi.ItemIndex;
end;

procedure TFrmRapor.CmbTurKoduChange(Sender: TObject);
begin
AdvDemirbas.ClearRows(1,AdvDemirbas.RowCount-1);
AdvDemirbas.RowCount := 2;

CmbTurAdi.ItemIndex:=CmbTurKodu.ItemIndex;
end;

procedure TFrmRapor.CmbTurAdiChange(Sender: TObject);
begin
CmbTurKodu.ItemIndex:=CmbTurAdi.ItemIndex;
end;

procedure TFrmRapor.CmbCesitKoduChange(Sender: TObject);
begin
AdvDemirbas.ClearRows(1,AdvDemirbas.RowCount-1);
AdvDemirbas.RowCount := 2;

CmbCesitAdi.ItemIndex:=CmbCesitKodu.ItemIndex;
end;

procedure TFrmRapor.ChkCheckClick(Sender: TObject);
var i:integer;
begin

if ChkCheck.Checked = True then begin
for i:=1 to AdvDemirbas.RowCount-1 do begin
if AdvDemirbas.Cells[0,i] <> '' then
AdvDemirbas.Cells[1,i] := 'Y';
end;
end
else begin
for i:=1 to AdvDemirbas.RowCount-1 do begin
if AdvDemirbas.Cells[0,i] <> '' then
AdvDemirbas.Cells[1,i] := 'N';
end;
end;





end;

procedure TFrmRapor.CmbCesitAdiChange(Sender: TObject);
begin
CmbCesitKodu.ItemIndex:=CmbCesitAdi.ItemIndex;
end;

procedure TFrmRapor.grupgetir;
var i:integer;
begin
CmbGrupKodu.Clear;
CmbGrupAdi.Clear;
CmbTurKodu.Clear;
CmbTurAdi.Clear;
CmbCesitKodu.Clear;
CmbCesitAdi.Clear;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select grup,adi from malzemekodlari where tur = '' '' and cesit = '' '' order by grup');
qry1.Open;

if qry1.recordcount = 0 Then exit;

for i:=0 To qry1.RecordCount-1 do begin
CmbGrupKodu.Items.Add(qry1.fieldbyname('grup').asstring);
CmbGrupAdi.Items.Add(qry1.fieldbyname('Adi').asstring);
Qry1.Next;
end;
end;

procedure TFrmRapor.Image2Click(Sender: TObject);
begin
PnlTutanak.Visible := False;
end;

procedure TFrmRapor.CmbGrupKoduDropDown(Sender: TObject);
begin
grupgetir;
end;

procedure TFrmRapor.CmbGrupAdiDropDown(Sender: TObject);
begin
grupgetir;
end;

procedure TFrmRapor.turgetir;
var i:integer;
begin
CmbTurKodu.Clear;
CmbTurAdi.Clear;
CmbCesitKodu.Clear;
CmbCesitAdi.Clear;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select tur,adi from malzemekodlari where grup ='''+CmbGrupKodu.Text+''' and tur <> '' '' and cesit = '' '' order by tur');
qry1.Open;

if qry1.recordcount = 0 Then exit;

for i:=0 To qry1.RecordCount-1 do begin
CmbTurKodu.Items.Add(qry1.fieldbyname('tur').asstring);
CmbTurAdi.Items.Add(qry1.fieldbyname('Adi').asstring);
Qry1.Next;
end;

end;

procedure TFrmRapor.CmbTurKoduDropDown(Sender: TObject);
begin
turgetir;
end;

procedure TFrmRapor.CmbTurAdiDropDown(Sender: TObject);
begin
turgetir;
end;

procedure TFrmRapor.cesitgetir;
var i:integer;
begin
CmbCesitKodu.Clear;
CmbCesitAdi.Clear;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select cesit,adi from malzemekodlari where Grup = '''+CmbGrupKodu.Text+''' and Tur ='''+CmbTurKodu.Text+''' and  cesit <> '' '' order by tur');
qry1.Open;

if qry1.recordcount = 0 Then exit;

for i:=0 To qry1.RecordCount-1 do begin
CmbCesitKodu.Items.Add(qry1.fieldbyname('cesit').asstring);
CmbCesitAdi.Items.Add(qry1.fieldbyname('Adi').asstring);
Qry1.Next;
end;
end;

procedure TFrmRapor.CmbCesitKoduDropDown(Sender: TObject);
begin
cesitgetir;
end;

procedure TFrmRapor.CmbCesitAdiDropDown(Sender: TObject);
begin
cesitgetir;
end;

procedure TFrmRapor.AdvDemirbasCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
CanEdit:=False;
if acol in [1,2,6,7,8] Then CanEdit := True;
end;

procedure TFrmRapor.mnSe1Click(Sender: TObject);
var i:integer;
begin

for i:=1 to AdvDemirbas.RowCount do begin
if AdvDemirbas.Cells[2,i]<>'' then AdvDemirbas.Cells[1,i]:='Y';
end;

end;

procedure TFrmRapor.AdvDemirbasCellsChanged(Sender: TObject; R: TRect);
begin
if PubTemp = 1 then exit;

if AdvDemirbas.Cells[0,AdvDemirbas.Row]<>'' then begin
if AdvDemirbas.Col=6 then begin
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('update demirbaslar set kiymet = '''+AdvDemirbas.Cells[6,AdvDemirbas.Row]+ '''  where id ='''+AdvDemirbas.Cells[0,AdvDemirbas.Row]+''' ');
qry1.ExecSQL;
end;

if AdvDemirbas.Col=7 then begin
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('update demirbaslar set KimdenSatin = '''+AdvDemirbas.Cells[7,AdvDemirbas.Row]+ '''  where id ='''+AdvDemirbas.Cells[0,AdvDemirbas.Row]+''' ');
qry1.ExecSQL;
end;

if AdvDemirbas.Col=8 then begin
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('update demirbaslar set demirbasyil = '''+AdvDemirbas.Cells[8,AdvDemirbas.Row]+ '''  where id ='''+AdvDemirbas.Cells[0,AdvDemirbas.Row]+''' ');
qry1.ExecSQL;
end;
end;







if AdvDemirbas.Cells[0,AdvDemirbas.Row]='' then begin
if AdvDemirbas.Col=6 then begin
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('update DemirbasDetaylari set Fiyat = '''+AdvDemirbas.Cells[6,AdvDemirbas.Row]+ '''  where id ='''+AdvDemirbas.Cells[12,AdvDemirbas.Row]+''' ');
qry1.ExecSQL;
end;

if AdvDemirbas.Col=7 then begin
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('update DemirbasDetaylari set Alimyeri = '''+AdvDemirbas.Cells[7,AdvDemirbas.Row]+ '''  where id ='''+AdvDemirbas.Cells[12,AdvDemirbas.Row]+''' ');
qry1.ExecSQL;
end;

if AdvDemirbas.Col=8 then begin
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('update DemirbasDetaylari set Yil = '''+AdvDemirbas.Cells[8,AdvDemirbas.Row]+ '''  where id ='''+AdvDemirbas.Cells[12,AdvDemirbas.Row]+''' ');
qry1.ExecSQL;
end;

end;


end;

procedure TFrmRapor.AdvDemirbasDblClick(Sender: TObject);
begin

qry3.Close;
qry3.SQL.clear;
qry3.SQL.Add('Select * from demirbaslar where id=:id');
Qry3.Parameters.ParamByName('id').Value  :=  AdvDemirbas.Cells[0,AdvDemirbas.Row] ;
qry3.Prepared;
qry3.open;

FrmDemirbasKayit:=TFrmDemirbasKayit.Create(self);
//////////////////////////////////////////////////////////////////////////////////////////7


FrmDemirbasKayit.temizle;
FrmDemirbasKayit.LblDemirbasAra.Tag   := Qry3.fieldbyname('id').AsInteger;

FrmDemirbasKayit.CmbGrupKodu.Text     := Qry3.fieldbyname('grupkodu').AsString;
FrmDemirbasKayit.CmbTurKodu.Text      := Qry3.fieldbyname('turkodu').AsString;
FrmDemirbasKayit.CmbCesitKodu.text    := Qry3.fieldbyname('cesitkodu').AsString;
FrmDemirbasKayit.CmbGrupAdi.text      := Qry3.fieldbyname('grupadi').AsString ;
FrmDemirbasKayit.CmbTurAdi.text       := Qry3.fieldbyname('turadi').AsString ;
FrmDemirbasKayit.CmbCesitAdi.Text     := Qry3.fieldbyname('cesitadi').AsString ;
FrmDemirbasKayit.CmbEsyaninCinsi.Text := Qry3.fieldbyname('esyacinsi').AsString;
FrmDemirbasKayit.CurrKiymet.Text      := Qry3.fieldbyname('edinilmedegeri').AsString;
FrmDemirbasKayit.TxtKurumKodu.Text    := Qry3.fieldbyname('kurumkodu').AsString;
FrmDemirbasKayit.CurrDemirbasSayi.Text:= Qry3.fieldbyname('demirbassayi').AsString;
FrmDemirbasKayit.CmbDemirbasYil.Text  := Qry3.fieldbyname('demirbasyil').AsString;
FrmDemirbasKayit.CurrOdaNo.Text       := Qry3.fieldbyname('odano').AsString;
FrmDemirbasKayit.MemAciklama.Text     := Qry3.fieldbyname('aciklama').AsString;
FrmDemirbasKayit.LblBarkodNo.Caption  := Qry3.fieldbyname('barkod').AsString;
FrmDemirbasKayit.TxtOdaAdi.Text       := Qry3.fieldbyname('OdaAdi').AsString;
FrmDemirbasKayit.CurrAdetEsas.Value   := Qry3.fieldbyname('Adet').AsCurrency;
FrmDemirbasKayit.TxtKimdenSatin.Text  := Qry3.fieldbyname('KimdenSatin').AsString;
FrmDemirbasKayit.TxtFaturaNo.Text     := Qry3.fieldbyname('FaturaNo').AsString;
FrmDemirbasKayit.TxtDevletBarkod.Text := Qry3.fieldbyname('DevletBarkod').AsString;
FrmDemirbasKayit.CmbBolumAdi.Text     := Qry3.fieldbyname('Bolum').AsString;
FrmDemirbasKayit.TxtBolumAdi2.Text    := Qry3.fieldbyname('Bolum2').AsString;
FrmDemirbasKayit.TxtSeriNo.Text       := Qry3.fieldbyname('SeriNo').AsString;
FrmDemirbasKayit.Txtinsansayisi.Text  := Qry3.fieldbyname('insansayisi').AsString;
FrmDemirbasKayit.Txtduraksayisi.Text  := Qry3.fieldbyname('duraksayisi').AsString;
FrmDemirbasKayit.Txtkamerano.Text     := Qry3.fieldbyname('kamerano').AsString;

FrmDemirbasKayit.BtnKaydet.Enabled:=False;
FrmDemirbasKayit.CurrYeniDemNo.Enabled :=False;
FrmDemirbasKayit.lblYeniDemNo.Enabled := False;
FrmDemirbasKayit.BtnSil.Enabled:=True;
FrmDemirbasKayit.BtnGuncelle.Enabled:=True;
FrmDemirbasKayit.BtnYeniKayit.Enabled := True;
FrmDemirbasKayit.LblStatus.Caption := 'Mevcut Kaydý Silip Güncelleyebilirsiniz, Yeni Kayýt Ýçin Yeni Kayýt Tuþuna Basýnýz .... ';

FrmDemirbasKayit.DemirbasDetaylariListele;
if FrmDemirbasKayit.LblDemirbasAra.Tag <>0 then FrmDemirbasKayit.PnlDemirbasDetay.Visible := True;

//////////////////////////////////////////////////////////////////////////////////////////7

FrmDemirbasKayit.ShowModal;
FrmDemirbasKayit.Free;
end;

procedure TFrmRapor.AdvDemirbasGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
if ACol=6 then HAlign := taRightJustify;

end;

procedure TFrmRapor.BarkodBas1Click(Sender: TObject);
begin

FrmBarkod:=TFrmBarkod.Create(self);
FrmBarkod.ShowModal;
FrmBarkod.Free;




end;

procedure TFrmRapor.KullamnaElveriliOlarakaretle1Click(Sender: TObject);
var TmpSql,TmpStr:String;
begin
TmpSql:='update DemirbasDetaylari set elverislidegil = ''N'', elverislidegilizahat =:elverislidegilizahat where id ='''+AdvDemirbasDetay.Cells[9,AdvDemirbasDetay.Row]+''' ';
qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('elverislidegilizahat').Value  := ' Kullaným Dýþý ';
qry1.Prepared;
qry1.ExecSQL;
TmpStr :=
' Demirbas Detay - Kullanýma Elveriþli Bölümüne Aktarýldý, '+
' Barkod No : '+AdvDemirbasDetay.Cells[6,AdvDemirbasDetay.Row]+', id : '+AdvDemirbasDetay.Cells[9,AdvDemirbasDetay.Row] ;


qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := AdvDemirbasDetay.Cells[1,AdvDemirbasDetay.Row] ;
Qry1.Parameters.ParamByName('barkodno').Value      := AdvDemirbasDetay.Cells[6,AdvDemirbasDetay.Row]  ;
Qry1.Parameters.ParamByName('tarih').Value := IntToStr(YearOf(date))+'-'+
                                              IntToStr(MonthOf(Date))+'-'+
                                              IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('yapilanis').Value     := TmpStr;
qry1.Prepared;
qry1.ExecSQL;

Showmessage('Ýþlem Tamam...');
end;

procedure TFrmRapor.KullanmayaElveriliDeil1Click(Sender: TObject);
var TmpSql,TmpStr:String;
i:integer;
begin

for i:=1 to FrmRapor.AdvDemirbas.RowCount - 1 do begin

if FrmRapor.AdvDemirbas.Cells[1,i] <> 'Y' Then Continue;




if FrmRapor.AdvDemirbas.Cells[2,i] <> ''Then begin
TmpSql:='update demirbaslar set elverislidegil = ''Y'', elverislidegilizahat =:elverislidegilizahat where id ='''+FrmRapor.AdvDemirbas.Cells[0,i]+''' ';

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('elverislidegilizahat').Value  := ' Kullaným Dýþý ';
qry1.Prepared;
qry1.ExecSQL;
TmpStr :=
' Kullanýma Elveriþli Deðil Bölümüne Aktarýldý, '+
' Barkod No : '+FrmRapor.AdvDemirbas.Cells[0,i] ;

end
Else begin

TmpSql:='update DemirbasDetaylari set elverislidegil = ''Y'', elverislidegilizahat =:elverislidegilizahat where id ='''+FrmRapor.AdvDemirbas.Cells[12,i]+''' ';
qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('elverislidegilizahat').Value  := ' Kullaným Dýþý ';
qry1.Prepared;
qry1.ExecSQL;
TmpStr :=
' Kullanýma Elveriþli Deðil Bölümüne Aktarýldý, '+
' Barkod No : '+FrmRapor.AdvDemirbas.Cells[13,i]+', id : '+FrmRapor.AdvDemirbas.Cells[12,i] ;

end;

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := FrmRapor.AdvDemirbas.Cells[4,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := FrmRapor.AdvDemirbas.Cells[2,i]  ;
Qry1.Parameters.ParamByName('tarih').Value         := Now ;
Qry1.Parameters.ParamByName('yapilanis').Value     := TmpStr;
qry1.Prepared;
qry1.ExecSQL;

end;
showmessage('Ýþlem Tamamlandý ....');

end;

procedure TFrmRapor.RbElverisliOlmayanlarClick(Sender: TObject);
begin
AdvDemirbas.ClearRows(1,AdvDemirbas.RowCount-1);
AdvDemirbas.RowCount := 2;

if RbElverisliOlmayanlar.Checked = True Then Begin
AdvDemirbas.PopupMenu:=PopupMenu2;
End;
LblAktarilanYer.Visible:=False;
txtaktarilanyer.Visible := False;
end;

procedure TFrmRapor.RbMevcutDemirbaslarClick(Sender: TObject);
begin
AdvDemirbas.ClearRows(1,AdvDemirbas.RowCount-1);
AdvDemirbas.RowCount := 2;

if RbMevcutDemirbaslar.Checked = True Then Begin
AdvDemirbas.PopupMenu:=PopupMenu1;
End;

LblAktarilanYer.Visible:=False;
txtaktarilanyer.Visible := False;
end;

procedure TFrmRapor.RbAktarilanlarClick(Sender: TObject);
begin

AdvDemirbas.ClearRows(1,AdvDemirbas.RowCount-1);
AdvDemirbas.RowCount := 2;

if RbAktarilanlar.Checked = True Then Begin
AdvDemirbas.PopupMenu:=PopupMenu3;
End;

LblAktarilanYer.Visible:=True;
txtaktarilanyer.Visible := True;
end;

procedure TFrmRapor.Dem1Click(Sender: TObject);
begin
FrmAlk4:=TFrmAlk4.Create(self);
FrmAlk4.ShowModal;
FrmAlk4.Free;
end;

procedure TFrmRapor.TxtOdaAdiChange(Sender: TObject);
begin
AdvDemirbas.ClearRows(1,AdvDemirbas.RowCount-1);
AdvDemirbas.RowCount := 2;

end;

procedure TFrmRapor.ElveriliOlmayanlarMevcutDemirbalaraGeiAl1Click(
  Sender: TObject);
var TmpSql:String;
i:integer;
begin

for i:=1 to FrmRapor.AdvDemirbas.RowCount - 1 do begin

if FrmRapor.AdvDemirbas.Cells[1,i] <> 'Y' Then Continue;

TmpSql:='update demirbaslar set elverislidegil = ''N'' where id ='''+FrmRapor.AdvDemirbas.Cells[0,i]+''' ';

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
qry1.ExecSQL;


qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := FrmRapor.AdvDemirbas.Cells[3,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := FrmRapor.AdvDemirbas.Cells[2,i]  ;
Qry1.Parameters.ParamByName('tarih').Value         := Now ;
Qry1.Parameters.ParamByName('yapilanis').Value     := ' Kullanýma Elveriþli Bölümünden Mevcut Demirbaþlara Geri Alýndý ';
qry1.Prepared;
qry1.ExecSQL;





end;
showmessage('Ýþlem Tamamlandý ....');
end;

procedure TFrmRapor.MenuItem7Click(Sender: TObject);
var TmpSql:String;
i:integer;
begin

for i:=1 to FrmRapor.AdvDemirbas.RowCount - 1 do begin

if FrmRapor.AdvDemirbas.Cells[1,i] <> 'Y' Then Continue;

TmpSql:='update demirbaslar set aktarildi = ''N'' where id ='''+FrmRapor.AdvDemirbas.Cells[0,i]+''' ';

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
qry1.ExecSQL;


qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := FrmRapor.AdvDemirbas.Cells[3,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := FrmRapor.AdvDemirbas.Cells[2,i]  ;
Qry1.Parameters.ParamByName('tarih').Value         := Now ;
Qry1.Parameters.ParamByName('yapilanis').Value     := ' Geri Alma Ýþlemi, Aktarma : ' +FrmRapor.Qry2.FieldByName('AktarilanYer').AsString;  
qry1.Prepared;
qry1.ExecSQL;


end;
showmessage('Ýþlem Tamamlandý ....');
end;

procedure TFrmRapor.FormShow(Sender: TObject);
begin
PageControl1.TabIndex := 0 ;
end;

procedure TFrmRapor.txtesyaChange(Sender: TObject);
begin
AdvDemirbas.ClearRows(1,AdvDemirbas.RowCount-1);
AdvDemirbas.RowCount := 2;

end;

procedure TFrmRapor.txtaktarilanyerChange(Sender: TObject);
begin
AdvDemirbas.ClearRows(1,AdvDemirbas.RowCount-1);
AdvDemirbas.RowCount := 2;
end;

procedure TFrmRapor.DemirbaKaytFormu1Click(Sender: TObject);
var TmpSql:string;
begin

RepMf7:=TRepMf7.Create(self);

TmpSql := 'Select * from SabitTanimlar where kriter = ''Ýlgili Bakanlýk'' ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.Open;

RepMf7.QRLilgilibakanlik.Caption := qry1.FieldByName('Tanim').AsString ;


TmpSql := 'Select * from SabitTanimlar where kriter = ''Þube'' ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.Open;

RepMf7.QRLSube.Caption := qry1.FieldByName('Tanim').AsString ;


TmpSql := 'Select * from SabitTanimlar where kriter = ''Bakanlýk ve Daire Kodu'' ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.Open;

RepMf7.QRLBakanlikveDaire.Caption := qry1.FieldByName('Tanim').AsString ;

if trim(txtoda.Text) <> '' Then
RepMf7.QRLOdaNo.Caption := txtoda.Text ;

RepMf7.Preview;
RepMf7.Free;
end;

procedure TFrmRapor.SeiliKullanmaDemirbalarYazdrMF71Click(Sender: TObject);
var TmpT,TmpK,TmpRow,z,i,rr:integer;
begin
TmpRow := AdvDemirbas.RowCount - 1 ;

TmpT:=1;
TmpK:=1;
rr:=0;

if 20 >= TmpRow Then begin
TmpK := TmpRow ;
TmpT := 1 ;
end
Else Begin
TmpT := strtoint(currtostr(int(TmpRow / 20))) + 1 ;
TmpK := TmpRow mod 20 ;
end;


For i := 1 to TmpT do Begin
RepAlk1:=TRepAlk1.Create(self);
RepBos:=TRepBos.Create(self);
RepAlk1Arka:=TRepAlk1Arka.Create(self);

For z:=1 to 20 do Begin

if i=TmpT Then
if TmpK<z Then
continue;

if z=1 Then Begin
rr:=rr+1;
RepAlk1.C0R0.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R0.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R0.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R0.Caption := '';
RepAlk1.C4R0.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R0.Caption := 'Kullaným Dýþý';
end;

if z=2 Then Begin
rr:=rr+1;
RepAlk1.C0R1.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R1.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R1.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R1.Caption := '';
RepAlk1.C4R1.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R1.Caption := 'Kullaným Dýþý';
end;

if z=3 Then Begin
rr:=rr+1;
RepAlk1.C0R2.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R2.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R2.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R2.Caption := '';
RepAlk1.C4R2.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R2.Caption := 'Kullaným Dýþý';
end;

if z=4 Then Begin
rr:=rr+1;
RepAlk1.C0R3.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R3.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R3.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R3.Caption := '';
RepAlk1.C4R3.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R3.Caption := 'Kullaným Dýþý';
end;

if z=5 Then Begin
rr:=rr+1;
RepAlk1.C0R4.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R4.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R4.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R4.Caption := '';
RepAlk1.C4R4.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R4.Caption := 'Kullaným Dýþý';
end;

if z=6 Then Begin
rr:=rr+1;
RepAlk1.C0R5.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R5.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R5.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R5.Caption := '';
RepAlk1.C4R5.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R5.Caption := 'Kullaným Dýþý';
end;

if z=7 Then Begin
rr:=rr+1;
RepAlk1.C0R6.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R6.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R6.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R6.Caption := '';
RepAlk1.C4R6.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R6.Caption := 'Kullaným Dýþý';
end;


if z=8 Then Begin
rr:=rr+1;
RepAlk1.C0R7.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R7.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R7.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R7.Caption := '';
RepAlk1.C4R7.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R7.Caption := 'Kullaným Dýþý';
end;


if z=9 Then Begin
rr:=rr+1;
RepAlk1.C0R8.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R8.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R8.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R8.Caption := '';
RepAlk1.C4R8.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R8.Caption := 'Kullaným Dýþý';
end;

if z=10 Then Begin
rr:=rr+1;
RepAlk1.C0R9.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R9.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R9.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R9.Caption := '';
RepAlk1.C4R9.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R9.Caption := 'Kullaným Dýþý';
end;

if z=11 Then Begin
rr:=rr+1;
RepAlk1.C0R10.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R10.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R10.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R10.Caption := '';
RepAlk1.C4R10.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R10.Caption := 'Kullaným Dýþý';
end;

if z=12 Then Begin
rr:=rr+1;
RepAlk1.C0R11.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R11.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R11.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R11.Caption := '';
RepAlk1.C4R11.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R11.Caption := 'Kullaným Dýþý';
end;

if z=13 Then Begin
rr:=rr+1;
RepAlk1.C0R12.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R12.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R12.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R12.Caption := '';
RepAlk1.C4R12.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R12.Caption := 'Kullaným Dýþý';
end;

if z=14 Then Begin
rr:=rr+1;
RepAlk1.C0R13.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R13.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R13.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R13.Caption := '';
RepAlk1.C4R13.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R13.Caption := 'Kullaným Dýþý';
end;

if z=15 Then Begin
rr:=rr+1;
RepAlk1.C0R14.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R14.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R14.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R14.Caption := '';
RepAlk1.C4R14.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R14.Caption := 'Kullaným Dýþý';
end;

if z=16 Then Begin
rr:=rr+1;
RepAlk1.C0R15.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R15.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R15.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R15.Caption := '';
RepAlk1.C4R15.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R15.Caption := 'Kullaným Dýþý';
end;

if z=17 Then Begin
rr:=rr+1;
RepAlk1.C0R16.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R16.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R16.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R16.Caption := '';
RepAlk1.C4R16.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R16.Caption := 'Kullaným Dýþý';
end;

if z=18 Then Begin
rr:=rr+1;
RepAlk1.C0R17.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R17.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R17.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R17.Caption := '';
RepAlk1.C4R17.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R17.Caption := 'Kullaným Dýþý';
end;

if z=19 Then Begin
rr:=rr+1;
RepAlk1.C0R18.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R18.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R18.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R18.Caption := '';
RepAlk1.C4R18.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R18.Caption := 'Kullaným Dýþý';
end;

if z=20 Then Begin
rr:=rr+1;
RepAlk1.C0R19.Caption := AdvDemirbas.Cells[0,rr];
RepAlk1.C1R19.Caption := AdvDemirbas.Cells[4,rr];
RepAlk1.C2R19.Caption := AdvDemirbas.Cells[5,rr];
RepAlk1.C3R19.Caption := '';
RepAlk1.C4R19.Caption := AdvDemirbas.Cells[6,rr];
RepAlk1.C5R19.Caption := 'Kullaným Dýþý';
end;

End;

QRCompositeReport1.Preview;

RepAlk1.Free;
RepBos.Free;
RepAlk1Arka.Free;

End;










end;

procedure TFrmRapor.MenuItem8Click(Sender: TObject);
begin
RepAlk4:=TRepAlk4.Create(self);
RepAlk4.QRLAktarilanYer.Caption :=Qry2.fieldbyname('AktarilanYer').AsString; ;
RepAlk4.Preview;
RepAlk4.Free;
end;

procedure TFrmRapor.mnSe2Click(Sender: TObject);
var i:integer;
begin

for i:=1 to AdvDemirbas.RowCount do
AdvDemirbas.Cells[1,i]:='Y';


end;

procedure TFrmRapor.QRCompositeReport1AddReports(Sender: TObject);
begin

with QRCompositeReport1.Reports do
 begin
   Add(RepAlk1);
   Add(RepBos);
   Add(RepAlk1Arka);
end;

end;



procedure TFrmRapor.SeiliDemirbaDetaylarnBakaBarkodaAktar1Click(
  Sender: TObject);
var TmpBarkodNo,TmpSql,TmpOdaNo,Tmpesyacinsi,TmpDemirbasid:String;
i:integer;
begin

TmpBarkodNo := InputBox('','Lütfen Aktarýlacak Barkod Numarasýný Giriniz ...','') ;

TmpSql:='Select id,odano,esyacinsi from Demirbaslar where barkod=:barkod ' ;
qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
qry1.Parameters.ParamByName('barkod').Value:= TmpBarkodNo;
qry1.Prepared;
qry1.open;
if qry1.RecordCount = 0 then begin
ShowMessage('Geçersiz Barkod No ..');
exit;
end;

TmpOdaNo     := qry1.FieldByName('odano').AsString;
Tmpesyacinsi := qry1.FieldByName('esyacinsi').AsString;
TmpDemirbasid:= qry1.FieldByName('id').AsString;

for i:=1 to FrmRapor.AdvDemirbas.RowCount - 1 do begin
if AdvDemirbas.Cells[0,i]='0' then begin

if AdvDemirbas.Cells[1,i] <> 'Y' Then Continue;

TmpSql:='update DemirbasDetaylari set BarkodNo=:BarkodNo,odano=:odano,esyacinsi=:esyacinsi,demirbasid=:demirbasid where id ='''+FrmRapor.AdvDemirbas.Cells[12,i]+''' ' ;
qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
qry1.Parameters.ParamByName('BarkodNo').Value := TmpBarkodNo;
qry1.Parameters.ParamByName('OdaNo').Value    := TmpOdaNo;
qry1.Parameters.ParamByName('esyacinsi').Value:= Tmpesyacinsi;
qry1.Parameters.ParamByName('demirbasid').Value:= TmpDemirbasid;
qry1.Prepared;
qry1.ExecSQL;

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := AdvDemirbas.Cells[4,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := ''  ;
Qry1.Parameters.ParamByName('tarih').Value         := Now ;
Qry1.Parameters.ParamByName('yapilanis').Value     := AdvDemirbas.Cells[13,i]+'Barkod no, '+TmpBarkodNo  + ' Barkod no olarak deðiþtirildi ';
qry1.Prepared;
qry1.ExecSQL;

end;
end;

showmessage('Ýþlem Tamamlandý .');

end;

procedure TFrmRapor.SeiliDemirbalarBakaOdayaAktarma1Click(Sender: TObject);
var TmpSql,TmpOdaNo,TmpOdaAdi,TmpAciklama, TmpPid,TmpPadi,TmpPsoyadi,TmpPgorevi,TmpPodano:String;
i,x:integer;
begin

x:=0;
TmpOdaNo    := InputBox('','Lütfen Oda Numarasýný Giriniz ...','') ;
TmpOdaAdi   := InputBox('','Lütfen Oda Adýný Giriniz ...','') ;
TmpAciklama := InputBox('','Lütfen Açýklamayý Yazýnýz ...','') ;

if (trim(TmpOdaNo) = '') or (trim(TmpOdaAdi)='') Then exit;



if isinteger(TmpOdaNo) = False Then begin
showmessage('Lütfen Sayý Giriniz ');
exit;
end;



qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('select id,adi,soyadi,gorevi,odano from PersonelBilgisi where odano=:odano ');
Qry1.Parameters.ParamByName('odano').Value := trim(TmpOdaNo) ;
qry1.Prepared;
qry1.open;

if qry1.RecordCount=0 then begin
x:=1;
if MessageDlg('Belirtilen odaya ait personel bulunamamýþtýr, devam etmek istiyormusunuz  ?',mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
end;


if x=0 then begin

TmpPid      := qry1.FieldByName('id').AsString ;
TmpPadi     := qry1.FieldByName('adi').AsString ;
TmpPsoyadi  := qry1.FieldByName('soyadi').AsString ;
TmpPgorevi  := qry1.FieldByName('gorevi').AsString ;
TmpPodano   := qry1.FieldByName('odano').AsString ;


end;



for i:=1 to FrmRapor.AdvDemirbas.RowCount - 1 do begin

if FrmRapor.AdvDemirbas.Cells[1,i] <> 'Y' Then Continue;

TmpSql:='update demirbaslar set odano=:odano , OdaAdi=:OdaAdi, aciklama=:aciklama where id=:id ' ;
qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('odano').Value     := trim(TmpOdaNo) ;
Qry1.Parameters.ParamByName('OdaAdi').Value     := trim(TmpOdaAdi) ;
Qry1.Parameters.ParamByName('aciklama').Value     := ', '+TmpAciklama ;
Qry1.Parameters.ParamByName('id').Value     := FrmRapor.AdvDemirbas.Cells[0,i] ;
qry1.ExecSQL;


if x=0 then begin

TmpSql:='Update Zimmet set perid=:perid,peradi=:peradi,persoyadi=:persoyadi,pergorevi=:pergorevi,'+
'perodano=:perodano,esyaodano=:esyaodano where demirbasid =:demirbasid ' ;
qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('perid').Value     := TmpPid ;
Qry1.Parameters.ParamByName('peradi').Value    := TmpPadi ;
Qry1.Parameters.ParamByName('persoyadi').Value := TmpPsoyadi ;
Qry1.Parameters.ParamByName('pergorevi').Value := TmpPgorevi ;
Qry1.Parameters.ParamByName('perodano').Value  := TmpPodano ;
Qry1.Parameters.ParamByName('esyaodano').Value := trim(TmpOdaNo)  ;
Qry1.Parameters.ParamByName('demirbasid').Value := FrmRapor.AdvDemirbas.Cells[0,i] ;
qry1.Prepared;
qry1.ExecSQL;

end
Else begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('delete from Zimmet where demirbasid=:demirbasid ');
Qry1.Parameters.ParamByName('demirbasid').Value := FrmRapor.AdvDemirbas.Cells[0,i] ;
qry1.Prepared;
qry1.ExecSQL;



end;



qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := FrmRapor.AdvDemirbas.Cells[4,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := FrmRapor.AdvDemirbas.Cells[2,i]  ;
Qry1.Parameters.ParamByName('tarih').Value := IntToStr(YearOf(date))+'-'+
                                              IntToStr(MonthOf(Date))+'-'+
                                              IntToStr(DayOf(Date));

Qry1.Parameters.ParamByName('yapilanis').Value     := trim(TmpOdaNo)  + ' oda no olarak deðiþtirildi, Zimmetten silindi '+TmpAciklama;
qry1.Prepared;
qry1.ExecSQL;




end;



MsgUyari('Ýþlem Tamamlandý ....');

end;
procedure TFrmRapor.SeiliDemirbalarSil1Click(Sender: TObject);
var i:integer;
begin

if MsgOnay('Kaydý/larý Silmek Ýstediðinize Emin Misiniz ?')=False Then  exit;

for i:=1 to AdvDemirbas.RowCount - 1 do begin
if AdvDemirbas.Cells[1,i] = 'Y' then begin
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from demirbaslar where id=:id ');
qry1.Parameters.ParamByName('id').Value := AdvDemirbas.Cells[0,i];
qry1.Prepared;
qry1.ExecSQL;

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := AdvDemirbas.Cells[4,i];
Qry1.Parameters.ParamByName('barkodno').Value      := AdvDemirbas.Cells[2,i];

Qry1.Parameters.ParamByName('tarih').Value := IntToStr(YearOf(date))+'-'+
                                              IntToStr(MonthOf(Date))+'-'+
                                              IntToStr(DayOf(Date));

Qry1.Parameters.ParamByName('yapilanis').Value     := 'Demirbaþ Silindi ';
qry1.Prepared;
qry1.ExecSQL;

end;
end;

MsgUyari('Kayýtlar Silindi');

end;

procedure TFrmRapor.Button10Click(Sender: TObject);
begin
AdvDemirbasDetay.PrintSettings.TitleLines.Clear;
AdvDemirbasDetay.PrintSettings.TitleLines.Add('Burhan Nalbantoðlu Devlet Hastanesi');

AdvDemirbasDetay.PrintSettings.TitleLines.Add('Demirbaþ Detay');

if ChkKullanimaElverisli.Checked=True then
AdvDemirbasDetay.PrintSettings.TitleLines.Add('Kullanýma Elveriþli Olmayan Demirbaþ Detaylar');


if Trim(TxtYazdirKelime1.Text) <> '' then
AdvDemirbasDetay.PrintSettings.TitleLines.Add(Trim(TxtYazdirKelime1.Text));



AdvPreviewDialog2.Execute;
end;

procedure TFrmRapor.Button11Click(Sender: TObject);
begin
SaveDialog1.Execute;
AdvGridExcelIO1.XLSExport(SaveDialog1.FileName+'.xls');

end;

procedure TFrmRapor.Button12Click(Sender: TObject);

var i:integer;
TmpKriter:String;
begin

for i:= 1 to AdvDemirbas.RowCount-1 do begin
if AdvDemirbas.Cells[1,i]='Y' then
TmpKriter := TmpKriter + ' id = ' + AdvDemirbas.Cells[0,i]+' or ' ;
end;

Qry2.Filtered := False;
Qry2.Filter   := LeftStr(TmpKriter,length(TmpKriter)-3) ;
Qry2.Filtered := TRUE;


RepRapor2:=TRepRapor2.Create(self);

if RbMevcutDemirbaslar.Checked then
RepRapor2.QRLabel13.Caption :='Mevcut Demirbaþlar';

if RbElverisliOlmayanlar.Checked then
RepRapor2.QRLabel13.Caption :='Kullanýma Elveriþli Olmayan Demirbaþlar';

if RbAktarilanlar.Checked then
RepRapor2.QRLabel13.Caption :='Aktarýlan Demirbaþlar';

RepRapor2.QRLabel14.Caption :=Trim(TxtYazdirKelime1.Text);

RepRapor2.Preview;
RepRapor2.Free;

Qry2.Filtered := False;
end;

procedure TFrmRapor.Button13Click(Sender: TObject);
var i:integer;
TmpKriter:String;
begin

for i:= 1 to AdvDemirbas.RowCount-1 do begin
if AdvDemirbas.Cells[1,i]='Y' then
TmpKriter := TmpKriter + ' id = ' + AdvDemirbas.Cells[0,i]+' or ' ;
end;

Qry2.Filtered := False;
Qry2.Filter   := LeftStr(TmpKriter,length(TmpKriter)-3) ;
Qry2.Filtered := TRUE;


RepRapor3:=TRepRapor3.Create(self);

if RbMevcutDemirbaslar.Checked then
RepRapor3.QRLabel1.Caption :='Mevcut Demirbaþlar';

if RbElverisliOlmayanlar.Checked then
RepRapor3.QRLabel1.Caption :='Kullanýma Elveriþli Olmayan Demirbaþlar';

if RbAktarilanlar.Checked then
RepRapor3.QRLabel1.Caption :='Aktarýlan Demirbaþlar';

RepRapor3.QRLabel10.Caption :=Trim(TxtYazdirKelime1.Text);

RepRapor3.Preview;
RepRapor3.Free;
Qry2.Filtered := False;
end;

procedure TFrmRapor.Button14Click(Sender: TObject);

begin
PnlTutanak.Visible := True;

end;

procedure TFrmRapor.Button15Click(Sender: TObject);
var i,Tutanakid:integer;
TmpKriter,TmpSql:String;
begin



for i:= 1 to AdvDemirbas.RowCount-1 do begin
if AdvDemirbas.Cells[1,i]='Y' then
TmpKriter := TmpKriter + ' id = ' + AdvDemirbas.Cells[0,i]+' or ' ;
end;

Qry2.Filtered := False;
Qry2.Filter   := LeftStr(TmpKriter,length(TmpKriter)-3) ;
Qry2.Filtered := TRUE;


//if  assigned(RepTutanak) then
RepTutanak:=TRepTutanak.Create(self);

RepTutanak.QRLabel6.Caption :=Trim(TxtYazdirKelime1.Text);

RepTutanak.QrlTeslimEdenAdi.Caption :=Trim(TxtTeslimEdenAdi.Text);
RepTutanak.QrlTeslimEdenSoyadi.Caption :=Trim(TxtTeslimEdenSoyadi.Text);
RepTutanak.QrlTeslimAlanAdi.Caption :=Trim(TxtTeslimAlanAdi.Text);
RepTutanak.QrlTeslimAlanSoyadi.Caption :=Trim(TxtTeslimAlanSoyadi.Text);
RepTutanak.QrlTarih.Caption :=DateToStr(Date);

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('select tutanakid from LastNumbers  ');
qry1.open;
Tutanakid := qry1.FieldByName('tutanakid').AsInteger ;

for i:= 1 to AdvDemirbas.RowCount-1 do begin
if AdvDemirbas.Cells[1,i]='Y' then begin

TmpSql:='insert into tutanak ' +
'(Aciklama, barkod, EsyaCinsi, Adet, TeslimEdenAdi, TeslimEdenSoyadi, TeslimAlanAdi, TeslimAlanSoyadi,Tarih,tutanakid) ' +
'Values ( :Aciklama, :barkod, :EsyaCinsi, :Adet, :TeslimEdenAdi, :TeslimEdenSoyadi, :TeslimAlanAdi, :TeslimAlanSoyadi,:Tarih,:tutanakid)' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Aciklama').Value         := Trim(TxtYazdirKelime1.Text) ;
Qry1.Parameters.ParamByName('barkod').Value           := AdvDemirbas.Cells[2,i];
Qry1.Parameters.ParamByName('EsyaCinsi').Value        := AdvDemirbas.Cells[4,i] ;
Qry1.Parameters.ParamByName('Adet').Value             := AdvDemirbas.Cells[5,i]  ;
Qry1.Parameters.ParamByName('TeslimEdenAdi').Value    := Trim(TxtTeslimEdenAdi.Text) ;
Qry1.Parameters.ParamByName('TeslimEdenSoyadi').Value := Trim(TxtTeslimEdenSoyadi.Text) ;
Qry1.Parameters.ParamByName('TeslimAlanAdi').Value    := Trim(TxtTeslimAlanAdi.Text) ;
Qry1.Parameters.ParamByName('TeslimAlanSoyadi').Value := Trim(TxtTeslimAlanSoyadi.Text) ;
Qry1.Parameters.ParamByName('Tarih').Value := IntToStr(YearOf(Date))+'-'+
                                                       IntToStr(MonthOf(Date))+'-'+
                                                       IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('tutanakid').Value := Tutanakid ;
qry1.Prepared;
qry1.ExecSQL;
end;
end;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Update LastNumbers set tutanakid =Tutanakid + 1 ');
qry1.ExecSQL;


RepTutanak.Preview;
RepTutanak.Free;
Qry2.Filtered := False;


PnlTutanak.Visible := False;
end;

procedure TFrmRapor.Button16Click(Sender: TObject);
var TmpSql : String;
i:integer;
begin

AdvTutanak.ClearRows(1,AdvTutanak.RowCount-1);
AdvTutanak.RowCount := 2;

TmpSql := 'Select * from tutanak where id <> 0 ';

if TxtTTutanakid.Text <> '' Then
TmpSql := TmpSql + ' and tutanakid=:tutanakid ';
if TxtTEsyaCinsi.Text <> '' Then
TmpSql := TmpSql + ' and EsyaCinsi like :EsyaCinsi ';
if TxtTBarkodNo.Text <> '' Then
TmpSql := TmpSql + ' and barkod like :barkod ';

if TxtTaciklama.Text <> '' Then
TmpSql := TmpSql + ' and Aciklama like :Aciklama ';

if ChkTarih.Checked = True Then
TmpSql := TmpSql + ' and Tarih between :dt1 and :dt2 ';

TmpSql := TmpSql + ' order by tutanakid ';

qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);

if TxtTTutanakid.Text <> '' Then
Qry2.Parameters.ParamByName('tutanakid').Value := TxtTTutanakid.Text ;

if TxtTEsyaCinsi.Text <> '' Then
Qry2.Parameters.ParamByName('EsyaCinsi').Value := trim(TxtTEsyaCinsi.Text)+'%' ;

if TxtTBarkodNo.Text <> '' Then
Qry2.Parameters.ParamByName('barkod').Value := '%'+trim(TxtTBarkodNo.Text) ;

if TxtTaciklama.Text <> '' Then
Qry2.Parameters.ParamByName('Aciklama').Value := '%'+trim(TxtTaciklama.Text)+'%' ;


if ChkTarih.Checked = True Then begin
Qry2.Parameters.ParamByName('dt1').Value := IntToStr(YearOf(dt1.date))+'-'+
                                              IntToStr(MonthOf(dt1.Date))+'-'+
                                              IntToStr(DayOf(dt1.Date));

Qry2.Parameters.ParamByName('dt2').Value := IntToStr(YearOf(dt2.date))+'-'+
                                              IntToStr(MonthOf(dt2.Date))+'-'+
                                              IntToStr(DayOf(dt2.Date));
end;


qry2.Prepared;
qry2.Open;


if Qry2.RecordCount <> 0 Then AdvTutanak.RowCount :=  Qry2.RecordCount + 1;


for i:=1 to Qry2.RecordCount  do  begin
AdvTutanak.Cells[1,i]:=Qry2.fieldbyname('Aciklama').AsString;
AdvTutanak.Cells[2,i]:=Qry2.fieldbyname('barkod').AsString;
AdvTutanak.Cells[3,i]:=Qry2.fieldbyname('EsyaCinsi').AsString;
AdvTutanak.Cells[4,i]:=Qry2.fieldbyname('Adet').AsString;
AdvTutanak.Cells[5,i]:=Qry2.fieldbyname('TeslimEdenAdi').AsString;
AdvTutanak.Cells[6,i]:=Qry2.fieldbyname('TeslimEdenSoyadi').AsString;
AdvTutanak.Cells[7,i]:=Qry2.fieldbyname('TeslimAlanAdi').AsString;
AdvTutanak.Cells[8,i]:=Qry2.fieldbyname('TeslimAlanSoyadi').AsString;
AdvTutanak.Cells[9,i]:=Qry2.fieldbyname('tarih').AsString;
AdvTutanak.Cells[10,i]:=Qry2.fieldbyname('tutanakid').AsString;

AdvTutanak.Cells[11,i]:=Qry2.fieldbyname('id').AsString;

Qry2.Next;

end;

AdvTutanak.AutoNumberCol(0);


end;


procedure TFrmRapor.Button17Click(Sender: TObject);
begin
AdvTutanak.PrintSettings.TitleLines.Clear;
AdvTutanak.PrintSettings.TitleLines.Add('Burhan Nalbantoðlu Devlet Hastanesi');

AdvTutanak.PrintSettings.TitleLines.Add('Tutanak Kayýtlarý');

AdvPreviewDialog3.Execute;
end;

procedure TFrmRapor.Button1Click(Sender: TObject);
var TmpSql:String;
begin

TmpSql:='Select * from demirbasgunlugu where id <> 0 ';

if CmbDemirbas2.Text = 'Eþyanýn Cinsi' Then
TmpSql := TmpSql + ' and esyanincinsi like :esyanincinsi ';
if CmbDemirbas2.Text = 'Barkod No' Then
TmpSql := TmpSql + ' and barkodno = :barkodno ';

TmpSql := TmpSql + ' Order by tarih desc'  ;

qry5.Close;
qry5.SQL.Clear;
qry5.SQL.Add(TmpSql);

if CmbDemirbas2.Text = 'Eþyanýn Cinsi' Then
Qry5.Parameters.ParamByName('esyanincinsi').Value := trim(TxtDemirbas2.Text)+'%' ;
if CmbDemirbas2.Text = 'Barkod No' Then
Qry5.Parameters.ParamByName('barkodno').Value := trim(TxtDemirbas2.Text) ;
qry5.Prepared;
qry5.Open;





end;

procedure TFrmRapor.Button2Click(Sender: TObject);
begin
RepDemirbasGunlugu:=TRepDemirbasGunlugu.Create(self);
RepDemirbasGunlugu.Preview;
RepDemirbasGunlugu.Free;
end;

procedure TFrmRapor.Button3Click(Sender: TObject);
var TmpSql : String;
i,x,y:integer;
TmpFiyat:Currency;
begin
PubTemp := 1;

y:=0;
TmpFiyat:=0;
AdvDemirbas.ClearRows(1,AdvDemirbas.RowCount-1);
AdvDemirbas.RowCount := 2;
ChkCheck.Checked := False ;
                                                              //kiymet
TmpSql := 'Select id,barkod,demirbassayi,esyacinsi,Adet,edinilmedegeri,KimdenSatin,demirbasyil,odano,OdaAdi,AktarilanYer,Bolum,Bolum2,yaslanmaedinilmedegeri '+
' from demirbaslar where id <> 0 ';

if ChkGrupOlmayan.Checked = True then
TmpSql := TmpSql + ' and (grupkodu is Null  OR  grupkodu='''') ';
if ChkTurOlmayan.Checked = True then
TmpSql := TmpSql + ' and (Turkodu is Null  OR  Turkodu='''') ';
if ChkCesitOlmayan.Checked = True then
TmpSql := TmpSql + ' and (cesitkodu is Null  OR  cesitkodu='''') ';

if trim(CmbGrupKodu.Text) <> '' Then
TmpSql := TmpSql + ' and grupkodu =  '''+ CmbGrupKodu.Text  +''' ';
if trim(CmbTurKodu.Text) <> '' Then
TmpSql := TmpSql + ' and turkodu =   '''+ CmbTurKodu.Text   +''' ';
if trim(CmbCesitKodu.Text) <> '' Then
TmpSql := TmpSql + ' and cesitkodu = '''+ CmbCesitKodu.Text +''' ';

if trim(txtesya.Text) <> '' Then
TmpSql := TmpSql + ' and esyacinsi like :esyacinsi ';
if Trim(txtbarkod.Text) <> '' Then
TmpSql := TmpSql + ' and barkod like :barkod ';
if trim(txtoda.Text) <> '' Then
TmpSql := TmpSql + ' and odano = :odano ';
if trim(txtodaAdi.Text) <> '' Then
TmpSql := TmpSql + ' and odaadi like :odaadi ';

if trim(txtbolum1.Text) <> '' Then
TmpSql := TmpSql + ' and bolum like :bolum ';

if trim(txtbolum2.Text) <> ''  Then
TmpSql := TmpSql + ' and bolum2 like :bolum2 ';

if trim(TxtSeriNo.Text) <> ''  Then
TmpSql := TmpSql + ' and serino like :serino ';

if trim(TxtAciklama.Text) <> ''  Then
TmpSql := TmpSql + ' and aciklama like :aciklama ';

if RbMevcutDemirbaslar.Checked = True Then
TmpSql := TmpSql + ' and aktarildi <> ''Y'' and elverislidegil <> ''Y'' ';
if RbElverisliOlmayanlar.Checked = True Then
TmpSql := TmpSql + ' and elverislidegil = ''Y'' ';
if RbAktarilanlar.Checked = True Then
TmpSql := TmpSql + ' and aktarildi = ''Y'' and AktarilanYer like :AktarilanYer ';

if CmbSiralama.Text = 'Seri No' then
TmpSql := TmpSql + ' order by id ' ;

if CmbSiralama.Text = 'Barkod No' then
TmpSql := TmpSql + ' order by barkod ' ;

if CmbSiralama.Text = 'Eþya Cinsi' then
TmpSql := TmpSql + ' order by esyacinsi ' ;

if CmbSiralama.Text = 'Bölüm Adý 1' then
TmpSql := TmpSql + ' order by bolum ' ;

if CmbSiralama.Text = 'Bölüm Adý 2' then
TmpSql := TmpSql + ' order by bolum2 ' ;


if RbS1.Checked = True then
TmpSql := TmpSql + ' desc ' ;
if RbS2.Checked = True then
TmpSql := TmpSql + ' asc ' ;




qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);
if trim(txtesya.Text) <> '' Then
Qry2.Parameters.ParamByName('esyacinsi').Value := txtesya.Text+'%' ;
if Trim(txtbarkod.Text) <> '' Then
Qry2.Parameters.ParamByName('barkod').Value := '%'+trim(txtbarkod.Text) ;
if trim(txtoda.Text) <> '' Then
Qry2.Parameters.ParamByName('odano').Value := trim(txtoda.Text) ;
if trim(txtodaAdi.Text) <> '' Then
Qry2.Parameters.ParamByName('odaadi').Value := '%'+ trim(txtodaAdi.Text)+'%'  ;

if RbAktarilanlar.Checked = True Then
Qry2.Parameters.ParamByName('AktarilanYer').Value := trim(txtaktarilanyer.Text)+'%' ;

if trim(txtbolum1.Text) <> '' Then
Qry2.Parameters.ParamByName('bolum').Value := trim(txtbolum1.Text)+'%' ;
if trim(txtbolum2.Text) <> ''  Then
Qry2.Parameters.ParamByName('bolum2').Value := trim(txtbolum2.Text)+'%' ;

if trim(TxtSeriNo.Text) <> ''  Then
Qry2.Parameters.ParamByName('serino').Value := trim(TxtSeriNo.Text)+'%' ;

if trim(TxtAciklama.Text) <> ''  Then
Qry2.Parameters.ParamByName('aciklama').Value := '%'+trim(TxtAciklama.Text)+'%' ;

qry2.Prepared;
qry2.Open;

LblMesaj.Caption := inttostr(Qry2.RecordCount)+'  Adet Kayýt Listelenmiþtir .';
if Qry2.RecordCount = 0 Then Exit;



for i:=1 to Qry2.RecordCount  do  begin
AdvDemirbas.AddRow; y:=y+1;

AdvDemirbas.Cells[0,y]:=Qry2.fieldbyname('id').AsString;
AdvDemirbas.AddCheckBox(1,y,False,True);
AdvDemirbas.Cells[2,y]:=Qry2.fieldbyname('barkod').AsString;
AdvDemirbas.Cells[3,y]:=Qry2.fieldbyname('demirbassayi').AsString;
AdvDemirbas.Cells[4,y]:=Qry2.fieldbyname('esyacinsi').AsString;
AdvDemirbas.Cells[5,y]:=Qry2.fieldbyname('Adet').AsString;
AdvDemirbas.Cells[6,y]:=FormatFloat('#,##0.00',Qry2.fieldbyname('yaslanmaedinilmedegeri').AsCurrency);
AdvDemirbas.Cells[7,y]:=Qry2.fieldbyname('KimdenSatin').AsString;
AdvDemirbas.Cells[8,y]:=Qry2.fieldbyname('demirbasyil').AsString;
AdvDemirbas.Cells[9,y]:=Qry2.fieldbyname('odano').AsString;
AdvDemirbas.Cells[10,y]:=Qry2.fieldbyname('OdaAdi').AsString;
if RbAktarilanlar.Checked = True Then
AdvDemirbas.Cells[11,y]:=Qry2.fieldbyname('AktarilanYer').AsString;
AdvDemirbas.Cells[12,y]:=Qry2.fieldbyname('Bolum').AsString;
AdvDemirbas.Cells[13,y]:=Qry2.fieldbyname('Bolum2').AsString;



TmpFiyat  := TmpFiyat + Qry2.fieldbyname('yaslanmaedinilmedegeri').AsCurrency;


if ChkDemirbasDetaylari.Checked = True then begin

TmpSql := 'Select * from DemirbasDetaylari  where demirbasid=:demirbasid ' ;
if RbElverisliOlmayanlar.Checked = True Then
TmpSql := TmpSql + ' and elverislidegil = ''Y'' ';

if RbMevcutDemirbaslar.Checked = True Then
TmpSql := TmpSql + ' and  elverislidegil <> ''Y'' ';

TmpSql := TmpSql + ' Order By MalzemeAdi ';

qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Demirbasid').Value := Qry2.fieldbyname('id').AsString ;
qry1.Prepared;
qry1.Open;

for x :=1 to Qry1.RecordCount do begin

AdvDemirbas.AddRow;
y:=y+1;
AdvDemirbas.RowColor[y]:= $00FFE2BB ;
AdvDemirbas.Cells[0,y]:='0';
AdvDemirbas.AddCheckBox(1,y,False,True);
AdvDemirbas.Cells[4,y]:=Qry1.fieldbyname('MalzemeAdi').AsString;
AdvDemirbas.Cells[5,y]:=Qry1.fieldbyname('Adet').AsString;
AdvDemirbas.Cells[6,y]:=Qry1.fieldbyname('Fiyat').AsString;
AdvDemirbas.Cells[7,y]:=Qry1.fieldbyname('Alimyeri').AsString;
AdvDemirbas.Cells[8,y]:=Qry1.fieldbyname('Yil').AsString;
AdvDemirbas.Cells[12,y]:=Qry1.fieldbyname('id').AsString;
AdvDemirbas.Cells[13,y]:=Qry2.fieldbyname('barkod').AsString;

TmpFiyat  := TmpFiyat + Qry1.fieldbyname('Fiyat').AsCurrency;
qry1.Next;
end;

end;

Qry2.Next;

end;


AdvDemirbas.AddRow;
y:=y+1;
AdvDemirbas.RowColor[y]:= clYellow ;
AdvDemirbas.Cells[6,y]:= currtostr(TmpFiyat);

PubTemp := 0;
end;

procedure TFrmRapor.Button4Click(Sender: TObject);
begin

AdvDemirbas.PrintSettings.TitleLines.Clear;
AdvDemirbas.PrintSettings.TitleLines.Add('Burhan Nalbantoðlu Devlet Hastanesi');

if RbMevcutDemirbaslar.Checked then
AdvDemirbas.PrintSettings.TitleLines.Add('Mevcut Demirbaþlar');

if RbElverisliOlmayanlar.Checked then
AdvDemirbas.PrintSettings.TitleLines.Add('Kullanýma Elveriþli Olmayan Demirbaþlar');

if RbAktarilanlar.Checked then
AdvDemirbas.PrintSettings.TitleLines.Add('Aktarýlan Demirbaþlar');

AdvDemirbas.PrintSettings.TitleLines.Add(Trim(TxtYazdirKelime1.Text));



AdvPreviewDialog1.Execute;
end;

procedure TFrmRapor.Button5Click(Sender: TObject);
var TmpSql : String;
begin
TmpSql := 'Select * from PersonelBilgisi where id <> 0 ';

if CmbKriter2.Text = 'Adý' Then
TmpSql := TmpSql + ' and adi like :adi ';
if CmbKriter2.Text = 'Soyadý' Then
TmpSql := TmpSql + ' and soyadi like :soyadi ';
if CmbKriter2.Text = 'Kimlik No' Then
TmpSql := TmpSql + ' and kimlikno like :kimlikno ';
if CmbKriter2.Text = 'Oda No' Then
TmpSql := TmpSql + ' and odano = :odano ';

qry3.Close;
qry3.SQL.Clear;
qry3.SQL.Add(TmpSql);
if CmbKriter2.Text = 'Adý' Then
Qry3.Parameters.ParamByName('adi').Value := trim(TxtKelime2.Text)+'%' ;
if CmbKriter2.Text = 'Soyadý' Then
Qry3.Parameters.ParamByName('soyadi').Value := trim(TxtKelime2.Text)+'%' ;
if CmbKriter2.Text = 'Kimlik No' Then
Qry3.Parameters.ParamByName('kimlikno').Value := trim(TxtKelime2.Text)+'%' ;
if CmbKriter2.Text = 'Oda No' Then
Qry3.Parameters.ParamByName('odano').Value := trim(TxtKelime2.Text) ;
qry3.Prepared;
qry3.Open;

end;
procedure TFrmRapor.Button6Click(Sender: TObject);
begin
RepPersonel:=TRepPersonel.Create(self);
RepPersonel.Preview;
RepPersonel.Free;
end;

procedure TFrmRapor.Button7Click(Sender: TObject);
var TmpSql:String;
begin

TmpSql:='Select * from zimmet where id <> 0 ';

if CmbDemirbas.Text = 'Eþyanýn Cinsi' Then
TmpSql := TmpSql + ' and esyanincinsi like :esyanincinsi ';
if CmbDemirbas.Text = 'Barkod No' Then
TmpSql := TmpSql + ' and barkod = :barkod ';
if CmbDemirbas.Text = 'Oda No' Then
TmpSql := TmpSql + ' and esyaodano like :esyaodano ';

if CmbPersonel.Text = 'Adý' Then
TmpSql := TmpSql + ' and peradi like :peradi ';
if CmbPersonel.Text = 'Soyadý' Then
TmpSql := TmpSql + ' and persoyadi like :persoyadi ';
if CmbPersonel.Text = 'Oda No' Then
TmpSql := TmpSql + ' and perodano = :perodano ';


qry4.Close;
qry4.SQL.Clear;
qry4.SQL.Add(TmpSql);

if CmbDemirbas.Text = 'Eþyanýn Cinsi' Then
Qry4.Parameters.ParamByName('esyanincinsi').Value := trim(TxtDemirbas.Text)+'%' ;
if CmbDemirbas.Text = 'Barkod No' Then
Qry4.Parameters.ParamByName('barkod').Value := trim(TxtDemirbas.Text)+'%' ;
if CmbDemirbas.Text = 'Oda No' Then
Qry4.Parameters.ParamByName('esyaodano').Value := trim(TxtDemirbas.Text) ;

if CmbPersonel.Text = 'Adý' Then
Qry4.Parameters.ParamByName('peradi').Value := trim(TxtPersonel.Text)+'%' ;
if CmbPersonel.Text = 'Soyadý' Then
Qry4.Parameters.ParamByName('persoyadi').Value := trim(TxtPersonel.Text)+'%' ;
if CmbPersonel.Text = 'Oda No' Then
Qry4.Parameters.ParamByName('perodano').Value := trim(TxtPersonel.Text) ;

qry4.Prepared;
qry4.Open;



end;

procedure TFrmRapor.Button8Click(Sender: TObject);
var TmpPageCount:String;
begin

RepZimmet:=TRepZimmet.Create(self);

RepZimmet.Prepare;
TmpPageCount := IntToStr(RepZimmet.QRPRinter.PageCount) ;
RepZimmet.QRExpr4.Expression := ' IF(PAGENUMBER = '''+TmpPageCount+''' ,''Bu zimmet '+TmpPageCount+' sayfadan olusmaktadýr'','' '') ' ;

RepZimmet.QrlYazdirKelime.Caption :=Trim(TxtYazdirKelime2.Text);

RepZimmet.PreviewModal;
RepZimmet.Free;
end;





procedure TFrmRapor.Button9Click(Sender: TObject);
var TmpSql : String;
i:integer;
begin

AdvDemirbasDetay.ClearRows(1,AdvDemirbasDetay.RowCount-1);
AdvDemirbasDetay.RowCount := 2;

TmpSql := 'Select * from DemirbasDetaylari where id <> 0 ';

if TxtOdaNo.Text <> '' Then
TmpSql := TmpSql + ' and odano=:odano ';
if TxtEsyaCinsi.Text <> '' Then
TmpSql := TmpSql + ' and MalzemeAdi like :MalzemeAdi ';
if TxtBarkodNo.Text <> '' Then
TmpSql := TmpSql + ' and BarkodNo like :BarkodNo ';
if ChkKullanimaElverisli.Checked = True Then
TmpSql := TmpSql + ' and elverislidegil = ''Y'' ';

TmpSql := TmpSql + ' order by MalzemeAdi ';

qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);

if TxtOdaNo.Text <> '' Then
Qry2.Parameters.ParamByName('OdaNo').Value := TxtOdaNo.Text ;

if TxtEsyaCinsi.Text <> '' Then
Qry2.Parameters.ParamByName('MalzemeAdi').Value := trim(TxtEsyaCinsi.Text)+'%' ;

if TxtBarkodNo.Text <> '' Then
Qry2.Parameters.ParamByName('BarkodNo').Value := '%'+trim(TxtBarkodNo.Text) ;

qry2.Prepared;
qry2.Open;


if Qry2.RecordCount <> 0 Then AdvDemirbasDetay.RowCount :=  Qry2.RecordCount + 1;


for i:=1 to Qry2.RecordCount  do  begin

AdvDemirbasDetay.Cells[1,i]:=Qry2.fieldbyname('MalzemeAdi').AsString;
AdvDemirbasDetay.Cells[2,i]:=Qry2.fieldbyname('Adet').AsString;
AdvDemirbasDetay.Cells[3,i]:=Qry2.fieldbyname('Alimyeri').AsString;
AdvDemirbasDetay.Cells[4,i]:=Qry2.fieldbyname('Yil').AsString;
AdvDemirbasDetay.Cells[5,i]:=Qry2.fieldbyname('Fiyat').AsString;
AdvDemirbasDetay.Cells[6,i]:=Qry2.fieldbyname('BarkodNo').AsString;
AdvDemirbasDetay.Cells[7,i]:=Qry2.fieldbyname('esyacinsi').AsString;
AdvDemirbasDetay.Cells[8,i]:=Qry2.fieldbyname('OdaNo').AsString;
AdvDemirbasDetay.Cells[9,i]:=Qry2.fieldbyname('id').AsString;

Qry2.Next;

end;

AdvDemirbasDetay.AutoNumberCol(0);


end;


end.
