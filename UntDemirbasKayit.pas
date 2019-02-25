unit UntDemirbasKayit;

interface

uses
  Windows, DB, ADODB, StdCtrls, Controls, Mask,
  Graphics, jpeg, ExtCtrls, Classes,Forms,SysUtils , Messages,
   Variants,Dialogs,  Menus,Buttons, ComCtrls, Grids, AdvObj, BaseGrid, AdvGrid,
  MoneyEdit,DateUtils;

                    




type
  TFrmDemirbasKayit = class(TForm)
    Label2: TLabel;
    Panel1: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Image4: TImage;
    LblStatus: TLabel;
    Panel2: TPanel;
    Image3: TImage;
    Panel3: TPanel;
    Panel4: TPanel;
    Image1: TImage;
    Panel5: TPanel;
    Qry1: TADOQuery;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    CmbGrupKodu: TComboBox;
    CmbGrupAdi: TComboBox;
    CmbTurKodu: TComboBox;
    CmbTurAdi: TComboBox;
    Image6: TImage;
    LblDemirbasAra: TLabel;
    CmbCesitKodu: TComboBox;
    CmbCesitAdi: TComboBox;
    TxtKurumKodu: TEdit;
    CmbDemirbasYil: TComboBox;
    lblYeniDemNo: TLabel;
    LblBarkodNo: TLabel;
    BtnKaydet: TButton;
    BtnGuncelle: TButton;
    BtnSil: TButton;
    BtnYeniKayit: TButton;
    Button4: TButton;
    CurrKiymet: TEdit;
    CurrDemirbasSayi: TEdit;
    CurrOdaNo: TEdit;
    CurrYeniDemNo: TEdit;
    TxtKimdenSatin: TEdit;
    Label3: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    TxtFaturaNo: TEdit;
    DtSatinAlma: TDateTimePicker;
    Label19: TLabel;
    TxtOdaAdi: TEdit;
    Label4: TLabel;
    CmbEsyaninCinsi: TComboBox;
    Label7: TLabel;
    MemAciklama: TMemo;
    PnlDemirbasDetay: TPanel;
    AdvDemirbasDetaylari: TAdvStringGrid;
    PnlDemirbasDetaylari: TPanel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    BitBtn10: TBitBtn;
    Button1: TButton;
    TxtMalzemeAdi: TEdit;
    TxtAlimYeri: TEdit;
    CurrAdet: TMoneyEdit;
    CurrYil: TMoneyEdit;
    CurrFiyat: TMoneyEdit;
    Panel6: TPanel;
    Label20: TLabel;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button2: TButton;
    TxtDevletBarkod: TEdit;
    Label27: TLabel;
    CmbBolumAdi: TComboBox;
    Label28: TLabel;
    Label26: TLabel;
    CurrAdetEsas: TMoneyEdit;
    TxtBolumAdi2: TEdit;
    Label29: TLabel;
    Label30: TLabel;
    TxtSeriNo: TEdit;
    Label31: TLabel;
    Txtinsansayisi: TEdit;
    Label32: TLabel;
    txtduraksayisi: TEdit;
    txtkameranolabel: TLabel;
    txtkamerano: TEdit;
    procedure LblDemirbasAraClick(Sender: TObject);
    procedure CmbGrupKoduDropDown(Sender: TObject);
    procedure CmbGrupAdiChange(Sender: TObject);
    procedure CmbGrupKoduChange(Sender: TObject);
    procedure CmbGrupAdiDropDown(Sender: TObject);
    procedure CmbTurKoduChange(Sender: TObject);
    procedure CmbTurAdiChange(Sender: TObject);
    procedure CmbCesitKoduChange(Sender: TObject);
    procedure CmbCesitAdiChange(Sender: TObject);
    procedure CmbTurKoduDropDown(Sender: TObject);
    procedure CmbTurAdiDropDown(Sender: TObject);
    procedure CmbCesitKoduDropDown(Sender: TObject);
    procedure CmbCesitAdiDropDown(Sender: TObject);
    procedure CmbEsyaninCinsiDropDown(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnKaydetClick(Sender: TObject);
    procedure BtnGuncelleClick(Sender: TObject);
    procedure BtnSilClick(Sender: TObject);
    procedure BtnYeniKayitClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AdvDemirbasDetaylariDblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CmbBolumAdiDropDown(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DemirbasDetaylariListele ;
    procedure grupgetir;
    procedure turgetir;
    procedure cesitgetir;
    procedure btkaydet;
    procedure temizle;
    procedure btguncelle;
    procedure btsil;
    procedure btcikis;
    function  barkodver():string;

    { Public declarations }
  end;

var
  FrmDemirbasKayit: TFrmDemirbasKayit;

implementation

uses  UntGlobal, UntDlgDemirbas, UntProjectGlobal;

{$R *.dfm}

procedure TFrmDemirbasKayit.LblDemirbasAraClick(Sender: TObject);

begin

FrmDlgDemirbas:=TFrmDlgDemirbas.Create(self);
FrmDlgDemirbas.ShowModal;

if FrmDlgDemirbas.iptal = False then begin

temizle;
LblDemirbasAra.Tag   := FrmDlgDemirbas.Qry1.fieldbyname('id').AsInteger;

{CmbGrupKodu.Items.Add(FrmDlgDemirbas.Qry1.fieldbyname('grupkodu').AsString);
CmbGrupKodu.ItemIndex := 0;

CmbTurKodu.Items.Add(FrmDlgDemirbas.Qry1.fieldbyname('turkodu').AsString);
CmbTurKodu.ItemIndex := 0 ;

CmbCesitKodu.Items.Add(FrmDlgDemirbas.Qry1.fieldbyname('cesitkodu').AsString);
CmbCesitKodu.ItemIndex := 0 ;

CmbGrupAdi.Items.Add(FrmDlgDemirbas.Qry1.fieldbyname('grupadi').AsString);
CmbGrupAdi.ItemIndex := 0 ;

CmbTurAdi.Items.Add(FrmDlgDemirbas.Qry1.fieldbyname('turadi').AsString);
CmbTurAdi.ItemIndex := 0 ;

CmbCesitAdi.Items.Add(FrmDlgDemirbas.Qry1.fieldbyname('cesitadi').AsString);
CmbCesitAdi.ItemIndex := 0 ;
}


FrmDemirbasKayit.CmbGrupKodu.Text  :=  FrmDlgDemirbas.Qry1.fieldbyname('grupkodu').AsString;
FrmDemirbasKayit.CmbTurKodu.Text   :=  FrmDlgDemirbas.Qry1.fieldbyname('turkodu').AsString;
FrmDemirbasKayit.CmbCesitKodu.text :=  FrmDlgDemirbas.Qry1.fieldbyname('cesitkodu').AsString;
FrmDemirbasKayit.CmbGrupAdi.text   :=  FrmDlgDemirbas.Qry1.fieldbyname('grupadi').AsString ;
FrmDemirbasKayit.CmbTurAdi.text    :=  FrmDlgDemirbas.Qry1.fieldbyname('turadi').AsString ;
FrmDemirbasKayit.CmbCesitAdi.Text  :=  FrmDlgDemirbas.Qry1.fieldbyname('cesitadi').AsString ;



CmbEsyaninCinsi.Text := FrmDlgDemirbas.Qry1.fieldbyname('esyacinsi').AsString;
CurrKiymet.Text      := FrmDlgDemirbas.Qry1.fieldbyname('edinilmedegeri').AsString;
TxtKurumKodu.Text    := FrmDlgDemirbas.Qry1.fieldbyname('kurumkodu').AsString;
CurrDemirbasSayi.Text:= FrmDlgDemirbas.Qry1.fieldbyname('demirbassayi').AsString;
CmbDemirbasYil.Text  := FrmDlgDemirbas.Qry1.fieldbyname('demirbasyil').AsString;
CurrOdaNo.Text       := FrmDlgDemirbas.Qry1.fieldbyname('odano').AsString;
MemAciklama.Text     := FrmDlgDemirbas.Qry1.fieldbyname('aciklama').AsString;
LblBarkodNo.Caption  := FrmDlgDemirbas.Qry1.fieldbyname('barkod').AsString;
TxtOdaAdi.Text       := FrmDlgDemirbas.Qry1.fieldbyname('OdaAdi').AsString;
CurrAdetEsas.Value   := FrmDlgDemirbas.Qry1.fieldbyname('Adet').AsCurrency;

TxtKimdenSatin.Text  := FrmDlgDemirbas.Qry1.fieldbyname('KimdenSatin').AsString;
TxtFaturaNo.Text     := FrmDlgDemirbas.Qry1.fieldbyname('FaturaNo').AsString;


TxtDevletBarkod.Text := FrmDlgDemirbas.Qry1.fieldbyname('DevletBarkod').AsString;
CmbBolumAdi.Text     := FrmDlgDemirbas.Qry1.fieldbyname('Bolum').AsString;
TxtBolumAdi2.Text    := FrmDlgDemirbas.Qry1.fieldbyname('Bolum2').AsString;
TxtSeriNo.Text       := FrmDlgDemirbas.Qry1.fieldbyname('SeriNo').AsString;

Txtinsansayisi.Text  := FrmDlgDemirbas.Qry1.fieldbyname('insansayisi').AsString;
Txtduraksayisi.Text  := FrmDlgDemirbas.Qry1.fieldbyname('duraksayisi').AsString;
Txtkamerano.Text     := FrmDlgDemirbas.Qry1.fieldbyname('kamerano').AsString;





BtnKaydet.Enabled:=False;
CurrYeniDemNo.Enabled :=False;
lblYeniDemNo.Enabled := False;

BtnSil.Enabled:=True;
BtnGuncelle.Enabled:=True;
BtnYeniKayit.Enabled := True;
LblStatus.Caption := 'Mevcut Kaydý Silip Güncelleyebilirsiniz, Yeni Kayýt Ýçin Yeni Kayýt Tuþuna Basýnýz .... ';

end;


DemirbasDetaylariListele;
if LblDemirbasAra.Tag <>0 then PnlDemirbasDetay.Visible := True;


FrmDlgDemirbas.Free;
end;

procedure TFrmDemirbasKayit.grupgetir;
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

procedure TFrmDemirbasKayit.CmbGrupKoduDropDown(Sender: TObject);
begin
grupgetir;
end;

procedure TFrmDemirbasKayit.CmbGrupAdiChange(Sender: TObject);
begin
CmbGrupKodu.ItemIndex:=CmbGrupAdi.ItemIndex;
end;

procedure TFrmDemirbasKayit.CmbGrupKoduChange(Sender: TObject);
begin
CmbGrupAdi.ItemIndex:=CmbGrupKodu.ItemIndex;
end;

procedure TFrmDemirbasKayit.CmbGrupAdiDropDown(Sender: TObject);
begin
grupgetir;
end;

procedure TFrmDemirbasKayit.CmbTurKoduChange(Sender: TObject);
begin
CmbTurAdi.ItemIndex:=CmbTurKodu.ItemIndex;
end;

procedure TFrmDemirbasKayit.CmbTurAdiChange(Sender: TObject);
begin
CmbTurKodu.ItemIndex:=CmbTurAdi.ItemIndex;
end;

procedure TFrmDemirbasKayit.CmbCesitKoduChange(Sender: TObject);
begin
CmbCesitAdi.ItemIndex:=CmbCesitKodu.ItemIndex;
end;

procedure TFrmDemirbasKayit.CmbBolumAdiDropDown(Sender: TObject);
var i:integer;
begin
CmbBolumAdi.Clear;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select Tanim from sabittanimlar where kriter = ''Bölüm Adý'' ');
qry1.Open;

if qry1.recordcount = 0 Then exit;

for i:=0 To qry1.RecordCount-1 do begin
CmbBolumAdi.Items.Add(qry1.fieldbyname('Tanim').asstring);
Qry1.Next;
end;

end;

procedure TFrmDemirbasKayit.CmbCesitAdiChange(Sender: TObject);
begin
CmbCesitKodu.ItemIndex:=CmbCesitAdi.ItemIndex;
end;

procedure TFrmDemirbasKayit.turgetir;
var i:integer;
begin
CmbTurKodu.Clear;
CmbTurAdi.Clear;
CmbCesitKodu.Clear;
CmbCesitAdi.Clear;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select tur,adi from malzemekodlari where grup ='''+CmbGrupKodu.Text+''' and tur <> '' '' and cesit = '' '' order by grup');
qry1.Open;

if qry1.recordcount = 0 Then exit;

for i:=0 To qry1.RecordCount-1 do begin
CmbTurKodu.Items.Add(qry1.fieldbyname('tur').asstring);
CmbTurAdi.Items.Add(qry1.fieldbyname('Adi').asstring);
Qry1.Next;
end;

end;

procedure TFrmDemirbasKayit.CmbTurKoduDropDown(Sender: TObject);
begin
turgetir;
end;

procedure TFrmDemirbasKayit.DemirbasDetaylariListele;
var TmpSql:String;
i:integer;
begin

AdvDemirbasDetaylari.ClearRows(1,AdvDemirbasDetaylari.RowCount-1);
AdvDemirbasDetaylari.RowCount:=2;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from DemirbasDetaylari where Demirbasid = '''+inttostr(LblDemirbasAra.Tag)+''' order by MalzemeAdi ');
qry1.Open;

if Qry1.RecordCount<>0 then AdvDemirbasDetaylari.RowCount := Qry1.RecordCount + 1 ;
for i:=1 to qry1.RecordCount do begin

AdvDemirbasDetaylari.Cells[1,i] := Qry1.FieldByName('MalzemeAdi').AsString ;
AdvDemirbasDetaylari.Cells[2,i] := Qry1.FieldByName('Adet').AsString ;
AdvDemirbasDetaylari.Cells[3,i] := Qry1.FieldByName('AlimYeri').AsString ;
AdvDemirbasDetaylari.Cells[4,i] := Qry1.FieldByName('Yil').AsString ;
AdvDemirbasDetaylari.Cells[5,i] := Qry1.FieldByName('Fiyat').AsString ;
AdvDemirbasDetaylari.Cells[6,i] := Qry1.FieldByName('id').AsString ;

Qry1.Next;
end;



end;

procedure TFrmDemirbasKayit.CmbTurAdiDropDown(Sender: TObject);
begin
turgetir;
end;

procedure TFrmDemirbasKayit.cesitgetir;
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

procedure TFrmDemirbasKayit.CmbCesitKoduDropDown(Sender: TObject);
begin
cesitgetir;
end;

procedure TFrmDemirbasKayit.CmbCesitAdiDropDown(Sender: TObject);
begin
cesitgetir;
end;

procedure TFrmDemirbasKayit.btkaydet;
var TmpSql,TmpMaxid,TmpBarcode:String;
i:integer;
begin

if CurrDemirbasSayi.text='' then CurrDemirbasSayi.text :='0' ;

if CurrAdetEsas.Value=0 then begin
ShowMessage('Adet Sayýsý ''0'' Olamaz');
exit;
end;

if CurrAdetEsas.Value>1 then
if MessageDlg('Demirbaþ adet sayýsý kadar çoðaltýlacak , Devam etmek istiyormusunuz ?',mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;


if trim(CmbEsyaninCinsi.Text) = '' Then begin
showmessage('Lütfen Eþyanýn Cinsini Belirleyiniz !!! ');
exit;
end;


for i:=1 to StrToInt(CurrAdetEsas.Text) do begin

TmpSql:='insert into demirbaslar ' +
'(grupkodu,turkodu,cesitkodu,grupadi,turadi,cesitadi,esyacinsi,edinilmedegeri,kurumkodu,demirbassayi,demirbasyil,odano,'+
'aciklama,KimdenSatin,SatinAlmaTarih,FaturaNo,OdaAdi,Kullanici,Yapilanis,Adet,Aktarildi,ElverisliDegil,DevletBarkod,Bolum,bolum2,'+
'SeriNo,insansayisi,duraksayisi,kamerano,yaslanmaedinilmedegeri) ' +
'Values ( ' +
':grupkodu,:turkodu,:cesitkodu,:grupadi,:turadi,:cesitadi,:esyacinsi,:edinilmedegeri,:kurumkodu,:demirbassayi,:demirbasyil,:odano,'+
':aciklama,:KimdenSatin,:SatinAlmaTarih,:FaturaNo,:OdaAdi,:Kullanici,:Yapilanis,:Adet,:Aktarildi,:ElverisliDegil,:DevletBarkod,:Bolum,'+
':bolum2,:SeriNo,:insansayisi,:duraksayisi,:kamerano,:yaslanmaedinilmedegeri'+
')';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('grupkodu').Value    := CmbGrupKodu.Text ;
Qry1.Parameters.ParamByName('turkodu').Value     := CmbTurKodu.Text ;
Qry1.Parameters.ParamByName('cesitkodu').Value   := CmbCesitKodu.Text ;
Qry1.Parameters.ParamByName('grupadi').Value     := CmbGrupAdi.Text ;
Qry1.Parameters.ParamByName('turadi').Value      := CmbTurAdi.Text ;
Qry1.Parameters.ParamByName('cesitadi').Value    := CmbCesitAdi.Text ;
Qry1.Parameters.ParamByName('esyacinsi').Value   := Trim(CmbEsyaninCinsi.Text) ;
Qry1.Parameters.ParamByName('edinilmedegeri').Value      := CurrKiymet.text ;
Qry1.Parameters.ParamByName('kurumkodu').Value   := trim(TxtKurumKodu.Text) ;
Qry1.Parameters.ParamByName('demirbassayi').Value:= CurrDemirbasSayi.text ;
Qry1.Parameters.ParamByName('demirbasyil').Value := CmbDemirbasYil.Text ;
Qry1.Parameters.ParamByName('odano').Value       := CurrOdaNo.text ;
Qry1.Parameters.ParamByName('aciklama').Value    := trim(MemAciklama.Text) ;
Qry1.Parameters.ParamByName('KimdenSatin').Value   := trim(TxtKimdenSatin.Text) ;

Qry1.Parameters.ParamByName('SatinAlmaTarih').Value := IntToStr(YearOf(DtSatinAlma.Date))+'-'+
                                                       IntToStr(MonthOf(DtSatinAlma.Date))+'-'+
                                                       IntToStr(DayOf(DtSatinAlma.Date));

Qry1.Parameters.ParamByName('FaturaNo').Value      := trim(TxtFaturaNo.Text) ;

Qry1.Parameters.ParamByName('OdaAdi').Value       := Trim(TxtOdaAdi.Text) ;
Qry1.Parameters.ParamByName('Kullanici').Value    := Kullanici ;
Qry1.Parameters.ParamByName('Yapilanis').Value    := 'Kayýt' ;

Qry1.Parameters.ParamByName('Adet').Value    := 1 ;

Qry1.Parameters.ParamByName('Aktarildi').Value      := 'N' ;
Qry1.Parameters.ParamByName('ElverisliDegil').Value := 'N' ;

Qry1.Parameters.ParamByName('DevletBarkod').Value := TxtDevletBarkod.Text ;
Qry1.Parameters.ParamByName('Bolum').Value := CmbBolumAdi.Text ;
Qry1.Parameters.ParamByName('Bolum2').Value := TxtBolumAdi2.Text ;

Qry1.Parameters.ParamByName('SeriNo').Value := TxtSeriNo.Text ;

Qry1.Parameters.ParamByName('insansayisi').Value := Txtinsansayisi.Text ;
Qry1.Parameters.ParamByName('duraksayisi').Value := Txtduraksayisi.Text ;
Qry1.Parameters.ParamByName('kamerano').Value    := Txtkamerano.Text ;
Qry1.Parameters.ParamByName('yaslanmaedinilmedegeri').Value    := CurrKiymet.text ;




qry1.Prepared;
qry1.ExecSQL;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select max(id) as id  from demirbaslar ');
qry1.Open;
TmpMaxid := qry1.FieldByName('id').AsString;
LblDemirbasAra.Tag := qry1.FieldByName('id').AsInteger;

AdvDemirbasDetaylari.ClearRows(1,AdvDemirbasDetaylari.RowCount-1);
AdvDemirbasDetaylari.RowCount:=2;
//PnlDemirbasDetay.Visible:=True;

TmpBarcode := barkodver ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Update demirbaslar set barkod = '''+TmpBarcode+''' where id = '''+TmpMaxid+''' ');
qry1.ExecSQL;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Update LastNumbers set demirbasid = '''+TmpMaxid+''' ');
qry1.ExecSQL;
end;






qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from SabitTanimlar where Kriter = ''Eþyanýn Tanýmý'' and Tanim = '''+Trim(CmbEsyaninCinsi.Text)+''' ');
qry1.open ;
if qry1.RecordCount = 0 Then Begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('insert into SabitTanimlar (Kriter,Tanim) values (''Eþyanýn Tanýmý'','''+Trim(CmbEsyaninCinsi.Text)+''') ');
qry1.ExecSQL ;

end;

LblBarkodNo.Caption := TmpBarcode ;
ShowMessage(' Kaydedildi ...');
{
BtnKaydet.Enabled:=False;
CurrYeniDemNo.Enabled :=False;
lblYeniDemNo.Enabled := False;
}

end;


procedure TFrmDemirbasKayit.AdvDemirbasDetaylariDblClick(Sender: TObject);
begin
PnlDemirbasDetaylari.Visible := True ;

Button1.Enabled:=False;
Button2.Enabled:=True;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * from DemirbasDetaylari  where id=:id  ');
Qry1.Parameters.ParamByName('id').Value := AdvDemirbasDetaylari.Cells[6,AdvDemirbasDetaylari.Row] ;
qry1.Prepared;
qry1.Open;

TxtMalzemeAdi.Tag  := Qry1.FieldByName('id').AsInteger          ;
TxtMalzemeAdi.Text := Qry1.FieldByName('MalzemeAdi').asstring  ;
CurrAdet.Value     := Qry1.FieldByName('Adet').AsInteger       ;
TxtAlimYeri.Text   := Qry1.FieldByName('Alimyeri').asstring    ;
CurrYil.Value      := Qry1.FieldByName('Yil').AsInteger        ;
CurrFiyat.Value    := Qry1.FieldByName('Fiyat').AsCurrency     ;



end;

function TFrmDemirbasKayit.barkodver(): string;
var  Tmpid,TmpBarkod:String;
i:integer;
begin
TmpBarkod := '10';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select max(id) as id from demirbaslar');
qry1.Open;

Tmpid := qry1.FieldByName('id').AsString;

for i:=1 to 10-length(Tmpid) do begin
TmpBarkod := TmpBarkod+'0';
end;

TmpBarkod := TmpBarkod+Tmpid;

result:=TmpBarkod;

end;

procedure TFrmDemirbasKayit.temizle;
begin

AdvDemirbasDetaylari.ClearRows(1,AdvDemirbasDetaylari.RowCount-1);
AdvDemirbasDetaylari.RowCount:=2;

LblDemirbasAra.Tag:=0;
CurrAdetEsas.text := '0';
CurrYeniDemNo.text := '0';
CmbGrupKodu.Clear;
CmbGrupAdi.Clear;
CmbTurKodu.Clear;
CmbTurAdi.Clear;
CmbCesitKodu.Clear;
CmbCesitAdi.Clear;
CmbEsyaninCinsi.Clear;
CurrKiymet.text :='0';
CurrDemirbasSayi.text := '0';
CurrOdaNo.text := '0';
MemAciklama.Clear;

BtnGuncelle.Enabled := False;
BtnSil.Enabled:=False;
BtnKaydet.Enabled := True;
CurrYeniDemNo.Enabled :=True;
lblYeniDemNo.Enabled := True;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select  demirbasid from LastNumbers ');
qry1.open;
CurrYeniDemNo.text:= inttostr(qry1.FieldByName('demirbasid').AsInteger+1) ;

LblStatus.Caption := 'Yeni Kayýt Giriniz ...';

TxtKimdenSatin.Clear;
TxtOdaAdi.clear;

end;

procedure TFrmDemirbasKayit.CmbEsyaninCinsiDropDown(Sender: TObject);
var i:integer;
begin

CmbEsyaninCinsi.Clear;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select Tanim from sabittanimlar where kriter = ''Eþyanýn Tanýmý'' ');
qry1.Open;

if qry1.recordcount = 0 Then exit;

for i:=0 To qry1.RecordCount-1 do begin
CmbEsyaninCinsi.Items.Add(qry1.fieldbyname('Tanim').asstring);
Qry1.Next;
end;






end;

procedure TFrmDemirbasKayit.btguncelle;
var TmpSql:String;
i:integer;
begin

if trim(CmbEsyaninCinsi.Text) = '' Then begin
showmessage('Lütfen Eþyanýn Cinsini Belirleyiniz !!! ');
exit;
end;

if CurrAdetEsas.Value=0 then begin
ShowMessage('Adet Sayýsý ''0'' Olamaz');
exit;
end;

if CurrAdetEsas.Value>1 then begin
ShowMessage('Adet Sayýsý ''1'' den fazla Olamaz');
exit;
end;




if CurrDemirbasSayi.Text='' then CurrDemirbasSayi.Text := '0' ;


TmpSql:='update demirbaslar set ' +

' grupkodu    = ''' +CmbGrupKodu.Text+ ''', ' +
' turkodu     = ''' +CmbTurKodu.Text+ ''', ' +
' cesitkodu   = ''' +CmbCesitKodu.Text+ ''', ' +
' grupadi     = ''' +CmbGrupAdi.Text+ ''', ' +
' turadi      = ''' +CmbTurAdi.Text+ ''', ' +
' cesitadi    = ''' +CmbCesitAdi.Text+ ''', ' +
' esyacinsi   = ''' +trim(CmbEsyaninCinsi.Text)+ ''', ' +
' edinilmedegeri = ''' +CurrKiymet.Text+ ''', ' +
' kurumkodu   = ''' +Trim(TxtKurumKodu.Text)+ ''', ' +
' demirbassayi= ''' +CurrDemirbasSayi.Text+ ''', ' +
' demirbasyil = ''' +CmbDemirbasYil.Text+ ''', ' +
' odano       = ''' +CurrOdaNo.Text+ ''', ' +
' aciklama    = ''' +Trim(MemAciklama.Text)+ ''', ' +

' KimdenSatin    = ''' +Trim(TxtKimdenSatin.Text)+ ''', ' +
' SatinAlmaTarih =:SatinAlmaTarih, ' +
' FaturaNo       = ''' +Trim(TxtFaturaNo.Text)+ ''', ' +

' OdaAdi    = '''+Trim(TxtOdaAdi.Text)+''', ' +
' Kullanici = '''+Kullanici+''', ' +
' Yapilanis = ''Guncelleme'', ' +
' DevletBarkod = '''+TxtDevletBarkod.Text+''', ' +
' Bolum        = '''+CmbBolumAdi.Text+''', ' +
' Bolum2       = '''+TxtBolumAdi2.Text+''', ' +
' SeriNo       = '''+TxtSeriNo.Text+''', ' +

' insansayisi   = '''+Txtinsansayisi.Text+''', ' +
' duraksayisi   = '''+Txtduraksayisi.Text+''', ' +
' kamerano      = '''+Txtkamerano.Text+''' ' +

' where id = '''+IntToStr(LblDemirbasAra.tag)+ ''' ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);

Qry1.Parameters.ParamByName('SatinAlmaTarih').Value := IntToStr(YearOf(DtSatinAlma.Date))+'-'+
                                                       IntToStr(MonthOf(DtSatinAlma.Date))+'-'+
                                                       IntToStr(DayOf(DtSatinAlma.Date));
qry1.Prepared;
qry1.ExecSQL;


LblStatus.Caption := CmbEsyaninCinsi.Text+ '   , Güncellendi ... ';

end;

procedure TFrmDemirbasKayit.btsil;
begin


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from Zimmet where demirbasid='''+IntToStr(LblDemirbasAra.Tag)+''' ');
qry1.open;

if qry1.RecordCount<>0 then begin
showmessage('Mevcut Demirbaþýn Zimmet bölümünde kaydý bulunmakta  ....Kayýt Silinemiyor  ');
exit;
end;



qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from demirbaslar where id='''+IntToStr(LblDemirbasAra.Tag)+''' ');
qry1.ExecSQL;



qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := CmbEsyaninCinsi.Text ;
Qry1.Parameters.ParamByName('barkodno').Value      := LblBarkodNo.Caption  ;

Qry1.Parameters.ParamByName('tarih').Value := IntToStr(YearOf(date))+'-'+
                                              IntToStr(MonthOf(Date))+'-'+
                                              IntToStr(DayOf(Date));

Qry1.Parameters.ParamByName('yapilanis').Value     := 'Demirbaþ Silindi ';
qry1.Prepared;
qry1.ExecSQL;


temizle;
end;

procedure TFrmDemirbasKayit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

if Key=13 then begin
Key:=0;
Perform(WM_NEXTDLGCTL,byte(Shift=[ssShift]),0);
end;

if key = Vk_F5 then temizle;
if key = VK_ESCAPE then Btcikis;
if key = VK_F2 then btkaydet;
if key = VK_F3 then btguncelle;
if key = VK_F4 then btsil;
end;

procedure TFrmDemirbasKayit.BitBtn10Click(Sender: TObject);
begin
PnlDemirbasDetaylari.Visible := False ;

end;

procedure TFrmDemirbasKayit.BitBtn1Click(Sender: TObject);
begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from DemirbasDetaylari where id='''+AdvDemirbasDetaylari.Cells[6,AdvDemirbasDetaylari.Row]+''' ');
qry1.ExecSQL;


ShowMessage('Kayýt Silindi ...');

DemirbasDetaylariListele;

end;

procedure TFrmDemirbasKayit.BitBtn2Click(Sender: TObject);
begin
PnlDemirbasDetaylari.Visible := True ;
Button1.Enabled:=True;
Button2.Enabled:=False;

end;

procedure TFrmDemirbasKayit.btcikis;
begin
close;
end;

procedure TFrmDemirbasKayit.BtnKaydetClick(Sender: TObject);
begin
btkaydet;
end;

procedure TFrmDemirbasKayit.BtnGuncelleClick(Sender: TObject);
begin
btguncelle;
end;

procedure TFrmDemirbasKayit.BtnSilClick(Sender: TObject);
begin
if MsgOnay('Kaydý Silmek Ýstediðinize Emin Misiniz ?')=False Then  exit;
btsil;
end;

procedure TFrmDemirbasKayit.BtnYeniKayitClick(Sender: TObject);
begin

BtnGuncelle.Enabled := False;
BtnSil.Enabled:=False;
BtnKaydet.Enabled := True;
CurrYeniDemNo.Enabled :=True;
lblYeniDemNo.Enabled := True;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select  demirbasid from LastNumbers ');
qry1.open;
CurrYeniDemNo.text:= inttostr(qry1.FieldByName('demirbasid').AsInteger+1) ;

LblStatus.Caption := 'Yeni Kayýt Giriniz ...';



//temizle;
end;

procedure TFrmDemirbasKayit.Button1Click(Sender: TObject);
var TmpSql,TmpMaxid:String;
begin

if trim(TxtMalzemeAdi.Text) = '' Then begin
showmessage('Lütfen MAlzeme Adýný Belirleyiniz !!! ');
exit;
end;



TmpSql:='insert into DemirbasDetaylari ' +
'(MalzemeAdi,Adet,Alimyeri,Yil,Fiyat,Demirbasid,elverislidegil,BarkodNo) ' +
'Values ( ' +
':MalzemeAdi,:Adet,:Alimyeri,:Yil,:Fiyat,:Demirbasid,:elverislidegil,:BarkodNo'+
')';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('MalzemeAdi').Value  := TxtMalzemeAdi.Text ;
Qry1.Parameters.ParamByName('Adet').Value        := CurrAdet.Value ;
Qry1.Parameters.ParamByName('Alimyeri').Value    := TxtAlimYeri.Text ;
Qry1.Parameters.ParamByName('Yil').Value         := CurrYil.Value ;
Qry1.Parameters.ParamByName('Fiyat').Value       := CurrFiyat.Value ;
Qry1.Parameters.ParamByName('Demirbasid').Value  := LblDemirbasAra.Tag  ;
Qry1.Parameters.ParamByName('elverislidegil').Value := 'N' ;
Qry1.Parameters.ParamByName('BarkodNo').Value  := LblBarkodNo.Caption   ;
qry1.Prepared;
qry1.ExecSQL;


showmessage('Kaydedildi ... ');

DemirbasDetaylariListele;

TxtMalzemeAdi.Clear ;
CurrAdet.Value  := 0 ;
TxtAlimYeri.Clear ;
CurrYil.Value := 0 ;
CurrFiyat.Value := 0 ;

PnlDemirbasDetaylari.Visible := False ;



end;

procedure TFrmDemirbasKayit.Button2Click(Sender: TObject);
var TmpSql,TmpMaxid:String;
begin

if trim(TxtMalzemeAdi.Text) = '' Then begin
showmessage('Lütfen MAlzeme Adýný Belirleyiniz !!! ');
exit;
end;


TmpSql:='Update DemirbasDetaylari Set ' +
' MalzemeAdi=:MalzemeAdi,Adet=:Adet,Alimyeri=:Alimyeri,Yil=:Yil,Fiyat=:Fiyat,Demirbasid=:Demirbasid,BarkodNo=:BarkodNo ' +
' Where id=:id ' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('MalzemeAdi').Value  := TxtMalzemeAdi.Text ;
Qry1.Parameters.ParamByName('Adet').Value        := CurrAdet.Value ;
Qry1.Parameters.ParamByName('Alimyeri').Value    := TxtAlimYeri.Text ;
Qry1.Parameters.ParamByName('Yil').Value         := CurrYil.Value ;
Qry1.Parameters.ParamByName('Fiyat').Value       := CurrFiyat.Value ;
Qry1.Parameters.ParamByName('Demirbasid').Value  := LblDemirbasAra.Tag  ;
Qry1.Parameters.ParamByName('BarkodNo').Value    := LblBarkodNo.Caption  ;
Qry1.Parameters.ParamByName('id').Value  := TxtMalzemeAdi.Tag   ;

qry1.Prepared;
qry1.ExecSQL;


showmessage('Güncellendi ... ');

DemirbasDetaylariListele;

TxtMalzemeAdi.Clear ;
CurrAdet.Value  := 0 ;
TxtAlimYeri.Clear ;
CurrYil.Value := 0 ;
CurrFiyat.Value := 0 ;

PnlDemirbasDetaylari.Visible := False ;



end;




procedure TFrmDemirbasKayit.Button4Click(Sender: TObject);
begin
BtCikis;
end;

end.
