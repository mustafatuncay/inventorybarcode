unit UntPersonel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Menus, DB, ADODB, StdCtrls, Buttons,
  Mask, ComCtrls,DateUtils;

type
  TFrmPersonel = class(TForm)
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
    Label4: TLabel;
    Label11: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    lblpersonelara: TLabel;
    Image6: TImage;
    Label7: TLabel;
    memaciklama: TMemo;
    Label12: TLabel;
    txtadi: TEdit;
    txtsoyadi: TEdit;
    txtgorevi: TEdit;
    txtcalistigiyer: TEdit;
    txttelno1: TEdit;
    txttelno2: TEdit;
    txtemail: TEdit;
    Label13: TLabel;
    txtkimlikno: TEdit;
    Label14: TLabel;
    txtodano: TEdit;
    CmbCinsiyet: TComboBox;
    Label15: TLabel;
    txttelno3: TEdit;
    Button4: TButton;
    BtnYeniKayit: TButton;
    BtnSil: TButton;
    BtnGuncelle: TButton;
    BtnKaydet: TButton;
    Dt1: TDateTimePicker;
    Label16: TLabel;
    TxtOdaAdi: TEdit;
    procedure btnkaydetClick(Sender: TObject);
    procedure btnsilClick(Sender: TObject);
    procedure btnyenikayitClick(Sender: TObject);
    procedure btnguncelleClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblpersonelaraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure btkaydet;
    procedure btguncelle;
    procedure btsil;
    procedure Temizle;
    procedure btcikis;
    { Public declarations }
  end;

var
  FrmPersonel: TFrmPersonel;

implementation

uses UntGlobal, UntDlgPersonel, UntProjectGlobal;

{$R *.dfm}

procedure TFrmPersonel.btkaydet;
var TmpSql:String;
begin

if trim(txtadi.Text) = '' Then begin
showmessage('Lütfen Personel Adýný Giriniz !!! ');
exit;
end;

if trim(txtsoyadi.Text) = '' Then begin
showmessage('Lütfen Personel Soyadýný Giriniz !!! ');
exit;
end;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from PersonelBilgisi where adi='''+Trim(txtadi.Text)+''' and soyadi = '''+Trim(txtsoyadi.Text)+''' ');
qry1.open;
if Qry1.RecordCount <> 0  Then begin
showmessage('Mevcut Personel Kaydý, Lütfen Personel Ýsmini ve Soyismini Deðiþtiriniz !!! ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from PersonelBilgisi where kimlikno = '''+Trim(txtkimlikno.Text)+''' ');
qry1.open;
if Qry1.RecordCount <> 0  Then begin
showmessage('Mevcut Personel Kaydý, Lütfen Kimlik No Bilgisini Deðiþtiriniz !!! ');
exit;
end;

TmpSql:='insert into PersonelBilgisi ' +
'(adi,soyadi,kimlikno,gorevi,calistigiyer,telno1,telno2,telno3,email,dogumyili,cinsiyet,odano,aciklama,OdaAdi,Kullanici,Yapilanis) ' +
'Values ( :adi,:soyadi,:kimlikno,:gorevi,:calistigiyer,:telno1,:telno2,:telno3,:email,:dogumyili,:cinsiyet,:odano,:aciklama,:OdaAdi,:Kullanici,:Yapilanis)' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('adi').Value          := Trim(txtadi.Text) ;
Qry1.Parameters.ParamByName('soyadi').Value       := Trim(txtsoyadi.Text) ;
Qry1.Parameters.ParamByName('kimlikno').Value     := Trim(txtkimlikno.Text) ;
Qry1.Parameters.ParamByName('gorevi').Value       := Trim(txtgorevi.Text) ;
Qry1.Parameters.ParamByName('calistigiyer').Value := Trim(txtcalistigiyer.Text) ;
Qry1.Parameters.ParamByName('telno1').Value       := Trim(txttelno1.Text) ;
Qry1.Parameters.ParamByName('telno2').Value       := Trim(txttelno2.Text) ;
Qry1.Parameters.ParamByName('telno3').Value       := Trim(txttelno3.Text) ;
Qry1.Parameters.ParamByName('email').Value        := Trim(txtemail.Text) ;

Qry1.Parameters.ParamByName('dogumyili').Value := IntToStr(YearOf(Dt1.Date))+'-'+
                                                    IntToStr(MonthOf(Dt1.Date))+'-'+
                                                    IntToStr(DayOf(Dt1.Date));


Qry1.Parameters.ParamByName('cinsiyet').Value     := Trim(CmbCinsiyet.Text) ;
Qry1.Parameters.ParamByName('odano').Value        := Trim(txtodano.Text) ;
Qry1.Parameters.ParamByName('aciklama').Value     := Trim(memaciklama.Text) ;

Qry1.Parameters.ParamByName('OdaAdi').Value       := Trim(TxtOdaAdi.Text) ;
Qry1.Parameters.ParamByName('Kullanici').Value    := Kullanici ;
Qry1.Parameters.ParamByName('Yapilanis').Value    := 'Kayýt' ;


qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := txtadi.Text+'   '+txtsoyadi.Text+ '   , Kaydedildi ... ';

end;

procedure TFrmPersonel.btnkaydetClick(Sender: TObject);
begin
BtKaydet;
end;

procedure TFrmPersonel.btguncelle;
var TmpSql:String;
begin

if trim(txtadi.Text) = '' Then begin
showmessage('Lütfen Personel Adýný Giriniz !!! ');
exit;
end;

if trim(txtsoyadi.Text) = '' Then begin
showmessage('Lütfen Personel Soyadýný Giriniz !!! ');
exit;
end;



qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from PersonelBilgisi where id <> '''+IntToStr(lblpersonelara.Tag)+''' and adi='''+Trim(txtadi.Text)+''' and soyadi = '''+Trim(txtsoyadi.Text)+''' ');
qry1.open;
if Qry1.RecordCount <> 0  Then begin
showmessage('Mevcut Personel Kaydý, Lütfen Personel Ýsmini ve Soyismini Deðiþtiriniz !!! ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from PersonelBilgisi where id <> '''+IntToStr(lblpersonelara.Tag)+''' and kimlikno = '''+Trim(txtkimlikno.Text)+''' ');
qry1.open;
if Qry1.RecordCount <> 0  Then begin
showmessage('Mevcut Personel Kaydý, Lütfen Kimlik No Bilgisini Deðiþtiriniz !!! ');
exit;
end;



TmpSql:='update PersonelBilgisi set ' +

' adi          = :adi, ' +
' soyadi       = :soyadi, ' +
' kimlikno     = :kimlikno, ' +
' gorevi       = :gorevi, ' +
' calistigiyer = :calistigiyer, ' +
' telno1       = :telno1, ' +
' telno2       = :telno2, ' +
' telno3       = :telno3, ' +
' email        = :email, ' +
' dogumyili    = :dogumyili, ' +
' cinsiyet     = :cinsiyet, ' +
' odano        = :odano, ' +
' aciklama     = :aciklama,  ' +

' OdaAdi       = :OdaAdi, ' +
' Kullanici    = :Kullanici, ' +
' Yapilanis    = :Yapilanis  ' +


' where id = '''+IntToStr(lblpersonelara.Tag)+'''  ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('adi').Value          := Trim(txtadi.Text) ;
Qry1.Parameters.ParamByName('soyadi').Value       := Trim(txtsoyadi.Text) ;
Qry1.Parameters.ParamByName('kimlikno').Value     := Trim(txtkimlikno.Text) ;
Qry1.Parameters.ParamByName('gorevi').Value       := Trim(txtgorevi.Text) ;
Qry1.Parameters.ParamByName('calistigiyer').Value := Trim(txtcalistigiyer.Text) ;
Qry1.Parameters.ParamByName('telno1').Value       := Trim(txttelno1.Text) ;
Qry1.Parameters.ParamByName('telno2').Value       := Trim(txttelno2.Text) ;
Qry1.Parameters.ParamByName('telno3').Value       := Trim(txttelno3.Text) ;
Qry1.Parameters.ParamByName('email').Value        := Trim(txtemail.Text) ;

Qry1.Parameters.ParamByName('dogumyili').Value := IntToStr(YearOf(Dt1.Date))+'-'+
                                                    IntToStr(MonthOf(Dt1.Date))+'-'+
                                                    IntToStr(DayOf(Dt1.Date));


Qry1.Parameters.ParamByName('cinsiyet').Value     := Trim(CmbCinsiyet.Text) ;
Qry1.Parameters.ParamByName('odano').Value        := Trim(txtodano.Text) ;
Qry1.Parameters.ParamByName('aciklama').Value     := Trim(memaciklama.Text) ;

Qry1.Parameters.ParamByName('OdaAdi').Value       := Trim(TxtOdaAdi.Text) ;
Qry1.Parameters.ParamByName('Kullanici').Value    := Kullanici ;
Qry1.Parameters.ParamByName('Yapilanis').Value    := 'Guncelleme' ;

qry1.Prepared;
qry1.ExecSQL;





qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Update Zimmet set peradi=:peradi,persoyadi=:persoyadi where perid='''+IntToStr(lblpersonelara.Tag)+''' ');
Qry1.Parameters.ParamByName('peradi').Value          := Trim(txtadi.Text) ;
Qry1.Parameters.ParamByName('persoyadi').Value       := Trim(txtsoyadi.Text) ;
qry1.Prepared;
qry1.ExecSql;


LblStatus.Caption := txtadi.Text+'   '+txtsoyadi.Text+ '   , Güncellendi  ... ';

end;

procedure TFrmPersonel.btsil;
begin

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from Zimmet where perid='''+IntToStr(lblpersonelara.Tag)+''' ');
qry1.open;

if qry1.RecordCount<>0 then begin
showmessage('Mevcut Personelin Zimmet bölümünde kaydý bulunmakta  ....Kayýt Silinemiyor  ');
exit;
end;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from PersonelBilgisi where id='''+IntToStr(lblpersonelara.Tag)+''' ');
qry1.ExecSQL;








temizle;
end;

procedure TFrmPersonel.btnsilClick(Sender: TObject);
begin
if MsgOnay('Kaydý Silmek Ýstediðinize Emin Misiniz ?')=False Then  exit;

BtSil;
end;

procedure TFrmPersonel.Temizle;
begin
lblpersonelara.Tag:=0;
txtadi.Clear;
txtsoyadi.Clear;
txtkimlikno.Clear;
txtgorevi.Clear;
txtcalistigiyer.Clear;
txttelno1.Clear;
txttelno2.Clear;
txttelno3.Clear;
txtemail.Clear;
dt1.Date:=date;
txtodano.Clear;
memaciklama.Clear;


btnkaydet.Enabled := True;
btnguncelle.Enabled := False;
btnsil.Enabled := False;

LblStatus.Caption := 'Yeni Kayýt Giriniz ...';
end;

procedure TFrmPersonel.btnyenikayitClick(Sender: TObject);
begin
Temizle;
end;

procedure TFrmPersonel.btnguncelleClick(Sender: TObject);
begin
BtGuncelle;
end;

procedure TFrmPersonel.btcikis;
begin
close;
end;

procedure TFrmPersonel.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TFrmPersonel.lblpersonelaraClick(Sender: TObject);
begin
FrmDlgPersonel:=TFrmDlgPersonel.Create(self);
FrmDlgPersonel.ShowModal;

if FrmDlgPersonel.iptal =False then begin
temizle;

lblpersonelara.Tag   := FrmDlgPersonel.Qry1.fieldbyname('id').AsInteger;

txtadi.Text           :=  FrmDlgPersonel.Qry1.fieldbyname('adi').AsString;
txtsoyadi.Text        :=  FrmDlgPersonel.Qry1.fieldbyname('soyadi').AsString;
txtkimlikno.Text      :=  FrmDlgPersonel.Qry1.fieldbyname('kimlikno').AsString;
txtgorevi.Text        :=  FrmDlgPersonel.Qry1.fieldbyname('gorevi').AsString;
txtcalistigiyer.Text  :=  FrmDlgPersonel.Qry1.fieldbyname('calistigiyer').AsString;
txttelno1.Text        :=  FrmDlgPersonel.Qry1.fieldbyname('telno1').AsString;
txttelno2.Text        :=  FrmDlgPersonel.Qry1.fieldbyname('telno2').AsString;
txttelno3.Text        :=  FrmDlgPersonel.Qry1.fieldbyname('telno3').AsString;
txtemail.Text         :=  FrmDlgPersonel.Qry1.fieldbyname('email').AsString;
Dt1.date              :=  FrmDlgPersonel.Qry1.fieldbyname('dogumyili').AsDateTime;
CmbCinsiyet.Text      :=  FrmDlgPersonel.Qry1.fieldbyname('cinsiyet').AsString;
txtodano.Text         :=  FrmDlgPersonel.Qry1.fieldbyname('odano').AsString;
memaciklama.Text      :=  FrmDlgPersonel.Qry1.fieldbyname('aciklama').AsString;
TxtOdaAdi.Text       :=   FrmDlgPersonel.Qry1.fieldbyname('OdaAdi').AsString;


BtnKaydet.Enabled:=False;
BtnSil.Enabled:=True;
BtnGuncelle.Enabled:=True;
BtnYeniKayit.Enabled := True;
LblStatus.Caption := 'Mevcut Kaydý Silip Güncelleyebilirsiniz, Yeni Kayýt Ýçin Yeni Kayýt Tuþuna Basýnýz .... ';

end;


FrmDlgPersonel.Free;
end;


procedure TFrmPersonel.FormShow(Sender: TObject);
begin
Dt1.Date:=date;
end;

procedure TFrmPersonel.Button4Click(Sender: TObject);
begin
btcikis;
end;

end.
