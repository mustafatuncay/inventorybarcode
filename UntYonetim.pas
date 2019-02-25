unit UntYonetim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Grids, AdvObj, BaseGrid, AdvGrid, ExtCtrls,
  ComCtrls, DB, ADODB, DBGrids, Spin;

type
  TFrmYonetim = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    AdvListe: TAdvStringGrid;
    ChkLbHaklar: TCheckListBox;
    BtnKaydet: TButton;
    BtnGuncelle: TButton;
    BtnSil: TButton;
    BtnYeni: TButton;
    TxtKullaniciAdi: TEdit;
    TxtSifre: TEdit;
    TxtTekrarSifre: TEdit;
    ChkSelect: TCheckBox;
    Panel1: TPanel;
    Label6: TLabel;
    Qry1: TADOQuery;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    QryDemirbas: TADOQuery;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Label1: TLabel;
    CurrOdaNo: TSpinEdit;
    Button1: TButton;
    Button2: TButton;
    TabSheet3: TTabSheet;
    Txtodaadi: TEdit;
    cmbodaadi: TComboBox;
    BtnDegistir: TButton;
    Button3: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    cmbodano: TComboBox;
    BtnMalzeme: TButton;
    TabSheet4: TTabSheet;
    AdvAktarma: TAdvStringGrid;
    Panel3: TPanel;
    Button4: TButton;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    Label28: TLabel;
    CmbBolumAdi: TComboBox;
    Button6: TButton;
    qry2: TADOQuery;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    procedure BtnKaydetClick(Sender: TObject);
    procedure ChkSelectClick(Sender: TObject);
    procedure AdvListeDblClick(Sender: TObject);
    procedure BtnYeniClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSilClick(Sender: TObject);
    procedure BtnGuncelleClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BtnDegistirClick(Sender: TObject);
    procedure cmbodanoChange(Sender: TObject);
    procedure cmbodaadiChange(Sender: TObject);
    procedure BtnMalzemeClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CmbBolumAdiDropDown(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
  public
  procedure FitGrid(Grid: TDBGrid);
    procedure temizle;
    procedure CreateParams(var Params: TCreateParams); override;
      function  barkodver():string;
    { Public declarations }
  end;

var
  FrmYonetim: TFrmYonetim;

implementation

uses UntGlobal, UntDm, UntProjectGlobal;

{$R *.dfm}

procedure TFrmYonetim.AdvListeDblClick(Sender: TObject);
var TmpId:Integer;
begin

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select * from Yonetim where id=:id ');
Qry1.Parameters.ParamByName('id').Value    := AdvListe.Cells[3,AdvListe.Row] ;
Qry1.Prepared;
Qry1.Open;

TxtKullaniciAdi.Tag := Qry1.FieldByName('id').AsInteger  ;

TxtKullaniciAdi.Text := Qry1.FieldByName('KullaniciAdi').AsString ;
TxtSifre.Text        := Qry1.FieldByName('Sifre').AsString ;
TxtTekrarSifre.Text  := Qry1.FieldByName('Sifre').AsString ;


if Qry1.FieldByName('P1').AsInteger = 1 Then
   ChkLbHaklar.Checked[0]:= True
Else ChkLbHaklar.Checked[0]:= False ;

if Qry1.FieldByName('P2').AsInteger = 1 Then
   ChkLbHaklar.Checked[1]:= True
Else ChkLbHaklar.Checked[1]:= False ;

if Qry1.FieldByName('P3').AsInteger = 1 Then
   ChkLbHaklar.Checked[2]:= True
Else ChkLbHaklar.Checked[2]:= False ;

if Qry1.FieldByName('P4').AsInteger = 1 Then
   ChkLbHaklar.Checked[3]:= True
Else ChkLbHaklar.Checked[3]:= False ;

if Qry1.FieldByName('P5').AsInteger = 1 Then
   ChkLbHaklar.Checked[4]:= True
Else ChkLbHaklar.Checked[4]:= False ;

if Qry1.FieldByName('P6').AsInteger = 1 Then
   ChkLbHaklar.Checked[5]:= True
Else ChkLbHaklar.Checked[5]:= False ;

if Qry1.FieldByName('P7').AsInteger = 1 Then
   ChkLbHaklar.Checked[6]:= True
Else ChkLbHaklar.Checked[6]:= False ;

if Qry1.FieldByName('P8').AsInteger = 1 Then
   ChkLbHaklar.Checked[7]:= True
Else ChkLbHaklar.Checked[7]:= False ;


BtnKaydet.Enabled   := False ;
BtnGuncelle.Enabled := True ;
BtnSil.Enabled      := True ;

end;

function TFrmYonetim.barkodver: string;
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

procedure TFrmYonetim.BtnDegistirClick(Sender: TObject);
var TmpSql:String;
i:integer;
begin
TmpSql := 'Update demirbaslar set odaadi=:odaadi where odaadi=:odaadi2 ' ;

QryDemirbas.Close;
QryDemirbas.SQL.Clear;
QryDemirbas.SQL.Add(TmpSql);
QryDemirbas.Parameters.ParamByName('odaadi').Value := Txtodaadi.Text  ;
QryDemirbas.Parameters.ParamByName('odaadi2').Value := cmbodaadi.Text  ;
QryDemirbas.Prepared;
QryDemirbas.ExecSQL;


ShowMessage(' OK .. ');
end;

procedure TFrmYonetim.BtnGuncelleClick(Sender: TObject);
var TmpSql:String;
TmpPersonelId,TmpOgretmenId:integer;
begin

if trim(TxtKullaniciAdi.Text) = '' Then begin
showmessage('Lütfen , Kullanýcý Adýný Giriniz ... !!! ');
exit;
end;

if trim(TxtSifre.Text) = '' Then begin
showmessage('Lütfen , Þifre Giriniz ... !!! ');
exit;
end;

if trim(TxtTekrarSifre.Text) = '' Then begin
showmessage('Lütfen , Þifre için gerekli yerleri doldurunuz ... !!! ');
exit;
end;

if trim(TxtTekrarSifre.Text) <> trim(TxtSifre.Text) Then begin
showmessage('Lütfen , Þifrenizi Tekrar Giriniz ... !!! ');
TxtSifre.Clear;
TxtTekrarSifre.Clear;
TxtSifre.SetFocus;
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from Yonetim where id<>:id and KullaniciAdi=:KullaniciAdi ');
Qry1.Parameters.ParamByName('KullaniciAdi').Value := Trim(TxtKullaniciAdi.Text) ;
Qry1.Parameters.ParamByName('id').Value := TxtKullaniciAdi.Tag ;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
showmessage('Kullanýcý Adý Mevcut ...');
exit;
end;

TmpSql := 'Update Yonetim Set ' +

'KullaniciAdi=:KullaniciAdi,'+
'Sifre=:Sifre,'+
'P1=:P1,'+
'P2=:P2,'+
'P3=:P3,'+
'P4=:P4,'+
'P5=:P5,'+
'P6=:P6,'+
'P7=:P7, '+
'P8=:P8 '+

'Where id=:id ' ;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);

Qry1.Parameters.ParamByName('KullaniciAdi').Value   := Trim(TxtKullaniciAdi.Text) ;
Qry1.Parameters.ParamByName('Sifre').Value          := Trim(TxtSifre.Text) ;

if ChkLbHaklar.Checked[0] Then
Qry1.Parameters.ParamByName('P1').Value    := 1
Else Qry1.Parameters.ParamByName('P1').Value := 0;

if ChkLbHaklar.Checked[1] Then
Qry1.Parameters.ParamByName('P2').Value    := 1
Else Qry1.Parameters.ParamByName('P2').Value := 0;

if ChkLbHaklar.Checked[2] Then
Qry1.Parameters.ParamByName('P3').Value    := 1
Else Qry1.Parameters.ParamByName('P3').Value := 0;

if ChkLbHaklar.Checked[3] Then
Qry1.Parameters.ParamByName('P4').Value      := 1
Else Qry1.Parameters.ParamByName('P4').Value := 0;

if ChkLbHaklar.Checked[4] Then
Qry1.Parameters.ParamByName('P5').Value    := 1
Else Qry1.Parameters.ParamByName('P5').Value := 0;

if ChkLbHaklar.Checked[5] Then
Qry1.Parameters.ParamByName('P6').Value    := 1
Else Qry1.Parameters.ParamByName('P6').Value := 0;

if ChkLbHaklar.Checked[6] Then
Qry1.Parameters.ParamByName('P7').Value    := 1
Else Qry1.Parameters.ParamByName('P7').Value := 0;

if ChkLbHaklar.Checked[7] Then
Qry1.Parameters.ParamByName('P8').Value      := 1
Else Qry1.Parameters.ParamByName('P8').Value := 0;

Qry1.Parameters.ParamByName('id').Value := TxtKullaniciAdi.Tag ;

Qry1.Prepared;
Qry1.ExecSQL ;

showmessage('Güncellendi... ' );

Temizle;


end;
procedure TFrmYonetim.BtnKaydetClick(Sender: TObject);
var TmpSql:String;
TmpPersonelId,TmpOgretmenId:integer;
begin

if trim(TxtKullaniciAdi.Text) = '' Then begin
showmessage('Lütfen , Kullanýcý Adýný Giriniz ... !!! ');
exit;
end;

if trim(TxtSifre.Text) = '' Then begin
showmessage('Lütfen , Þifre Giriniz ... !!! ');
exit;
end;

if trim(TxtTekrarSifre.Text) = '' Then begin
showmessage('Lütfen , Þifre için gerekli yerleri doldurunuz ... !!! ');
exit;
end;

if trim(TxtTekrarSifre.Text) <> trim(TxtSifre.Text) Then begin
showmessage('Lütfen , Þifrenizi Tekrar Giriniz ... !!! ');
TxtSifre.Clear;
TxtTekrarSifre.Clear;
TxtSifre.SetFocus;
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from Yonetim where KullaniciAdi=:KullaniciAdi ');
Qry1.Parameters.ParamByName('KullaniciAdi').Value := Trim(TxtKullaniciAdi.Text) ;
qry1.Prepared;
qry1.open;
if qry1.RecordCount <> 0 then Begin
showmessage('Kullanýcý Adý Mevcut ...');
exit;
end;

TmpSql := 'Insert Into Yonetim ' +
'(KullaniciAdi,Sifre,P1,P2,P3,P4,P5,P6,P7,P8) '+
' Values'+
'(:KullaniciAdi,:Sifre,:P1,:P2,:P3,:P4,:P5,:P6,:P7,:P8) ';

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);

Qry1.Parameters.ParamByName('KullaniciAdi').Value          := Trim(TxtKullaniciAdi.Text) ;
Qry1.Parameters.ParamByName('Sifre').Value                 := Trim(TxtSifre.Text) ;

if ChkLbHaklar.Checked[0] Then
Qry1.Parameters.ParamByName('P1').Value    := 1
Else Qry1.Parameters.ParamByName('P1').Value := 0;

if ChkLbHaklar.Checked[1] Then
Qry1.Parameters.ParamByName('P2').Value    := 1
Else Qry1.Parameters.ParamByName('P2').Value := 0;

if ChkLbHaklar.Checked[2] Then
Qry1.Parameters.ParamByName('P3').Value    := 1
Else Qry1.Parameters.ParamByName('P3').Value := 0;

if ChkLbHaklar.Checked[3] Then
Qry1.Parameters.ParamByName('P4').Value    := 1
Else Qry1.Parameters.ParamByName('P4').Value := 0;

if ChkLbHaklar.Checked[4] Then
Qry1.Parameters.ParamByName('P5').Value    := 1
Else Qry1.Parameters.ParamByName('P5').Value := 0;

if ChkLbHaklar.Checked[5] Then
Qry1.Parameters.ParamByName('P6').Value    := 1
Else Qry1.Parameters.ParamByName('P6').Value := 0;

if ChkLbHaklar.Checked[6] Then
Qry1.Parameters.ParamByName('P7').Value    := 1
Else Qry1.Parameters.ParamByName('P7').Value := 0;

if ChkLbHaklar.Checked[7] Then
Qry1.Parameters.ParamByName('P8').Value    := 1
Else Qry1.Parameters.ParamByName('P8').Value := 0;


Qry1.Prepared;
Qry1.ExecSQL;

showmessage('Kaydedildi ... ');

Temizle;

end;


procedure TFrmYonetim.BtnMalzemeClick(Sender: TObject);
var TmpSql:String;
i:integer;
begin
dm.Qry2.Close;
dm.Qry2.SQL.Clear;
dm.Qry2.SQL.Add('Select * from malzemekodlari ');
dm.Qry2.open;


for i:=1 to Dm.Qry2.RecordCount do begin

TmpSql := 'insert malzemekodlari set grup=:grup, tur=:tur, cesit=:cesit, adi=:adi ' ;
QryDemirbas.Close;
QryDemirbas.SQL.Clear;
QryDemirbas.SQL.Add(TmpSql);
QryDemirbas.Parameters.ParamByName('grup').Value :=Dm.qry2.fieldbyname('grup').asstring  ;
QryDemirbas.Parameters.ParamByName('tur').Value := Dm.qry2.fieldbyname('tur').asstring  ;
QryDemirbas.Parameters.ParamByName('cesit').Value := Dm.qry2.fieldbyname('cesit').asstring   ;
QryDemirbas.Parameters.ParamByName('adi').Value := Dm.qry2.fieldbyname('adi').asstring   ;
QryDemirbas.Prepared;
QryDemirbas.ExecSQL;


Dm.Qry2.Next;
end;

ShowMessage(' OK .. ');
end;

procedure TFrmYonetim.BtnSilClick(Sender: TObject);
begin
if TxtKullaniciAdi.Tag = 0 Then begin
showmessage('Kayýt Mevcut Deðil ... !!! ');
exit;
end;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Delete from Yonetim where id =:id');
Qry1.Parameters.ParamByName('id').Value := TxtKullaniciAdi.Tag ;
Qry1.Prepared;
Qry1.ExecSQL;

showmessage('Kayýt Silindi ...');

Temizle;
end;

procedure TFrmYonetim.BtnYeniClick(Sender: TObject);
begin
Temizle;
end;

procedure TFrmYonetim.Button1Click(Sender: TObject);
var TmpSql:String;
begin
TmpSql := 'Select grupadi,turadi,cesitadi,esyacinsi,kiymet,demirbasyil,odano,OdaAdi,'+
' aciklama,KimdenSatin,SatinAlmaTarih,FaturaNo ' +
' from demirbaslar where id <> 0 ';


TmpSql := TmpSql + ' and odano = :odano ';


TmpSql := TmpSql + ' and aktarildi <> ''Y'' and elverislidegil <> ''Y'' ';


QryDemirbas.Close;
QryDemirbas.SQL.Clear;
QryDemirbas.SQL.Add(TmpSql);
QryDemirbas.Parameters.ParamByName('odano').Value := CurrOdaNo.Value ;
QryDemirbas.Open;

FitGrid(DBGrid1);

end;

procedure TFrmYonetim.Button2Click(Sender: TObject);
var i:integer;
begin

QryDemirbas.Close;
QryDemirbas.SQL.Clear;
QryDemirbas.SQL.Add('Select * from demirbaslar ');
QryDemirbas.Open;

for i:=1 to QryDemirbas.RecordCount do begin

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('update demirbasdetaylari set barkodno=:barkodno,odano=:odano,esyacinsi=:esyacinsi where demirbasid=:demirbasid');
Qry1.Parameters.ParamByName('barkodno').Value   := QryDemirbas.FieldByName('barkod').AsString;
Qry1.Parameters.ParamByName('odano').Value      := QryDemirbas.FieldByName('odano').AsString;
Qry1.Parameters.ParamByName('esyacinsi').Value  := QryDemirbas.FieldByName('esyacinsi').AsString;
Qry1.Parameters.ParamByName('demirbasid').Value := QryDemirbas.FieldByName('id').AsString;
Qry1.Prepared;
qry1.ExecSQL;

QryDemirbas.Next;
end;









end;

procedure TFrmYonetim.Button3Click(Sender: TObject);
var TmpSql:String;
i:integer;
begin
TmpSql := 'Select distinct odano,odaadi from demirbaslar ' ;

QryDemirbas.Close;
QryDemirbas.SQL.Clear;
QryDemirbas.SQL.Add(TmpSql);
QryDemirbas.Open;
cmbodaadi.Clear;
cmbodano.Clear;
for i:=1 to QryDemirbas.RecordCount do begin
cmbodano.Items.Add(QryDemirbas.FieldByName('Odano').AsString);
cmbodaadi.Items.Add(QryDemirbas.FieldByName('OdaAdi').AsString);
QryDemirbas.Next;
end;


end;

procedure TFrmYonetim.Button4Click(Sender: TObject);
begin

AdvAktarma.ClearRows(0,AdvAktarma.RowCount-1);
AdvAktarma.RowCount := 2;

OpenDialog1.Execute;
if OpenDialog1.FileName<>'' then
AdvAktarma.LoadFromXLS(OpenDialog1.FileName);


end;

procedure TFrmYonetim.Button5Click(Sender: TObject);
var TmpSql,TmpMaxid,TmpBarcode:String;
i:integer;
begin

for i:=1 to AdvAktarma.RowCount - 1 do begin

if trim(AdvAktarma.Cells[9,i]) <> '' Then begin


TmpSql:='insert into demirbaslar ' +
'(grupkodu,turkodu,cesitkodu,grupadi,turadi,cesitadi,Bolum,esyacinsi,model,kiymet,kurumkodu,odano,'+
'OdaAdi,Kullanici,Yapilanis,Adet,edinilmedegeri,Aktarildi,ElverisliDegil,Bolum2) ' +
'Values ( ' +
':grupkodu,:turkodu,:cesitkodu,:grupadi,:turadi,:cesitadi,:Bolum,:esyacinsi,:model,:kiymet,:kurumkodu,:odano,'+
':OdaAdi,:Kullanici,:Yapilanis,:Adet,:edinilmedegeri,:Aktarildi,:ElverisliDegil,:Bolum2'+
')';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('grupkodu').Value    := AdvAktarma.Cells[0,i] ;
Qry1.Parameters.ParamByName('grupadi').Value     := AdvAktarma.Cells[1,i] ;
Qry1.Parameters.ParamByName('turkodu').Value     := AdvAktarma.Cells[2,i] ;
Qry1.Parameters.ParamByName('turadi').Value      := AdvAktarma.Cells[3,i] ;
Qry1.Parameters.ParamByName('cesitkodu').Value   := AdvAktarma.Cells[4,i] ;
Qry1.Parameters.ParamByName('cesitadi').Value    := AdvAktarma.Cells[5,i] ;
Qry1.Parameters.ParamByName('Bolum').Value       := AdvAktarma.Cells[6,i] ;
Qry1.Parameters.ParamByName('OdaAdi').Value      := AdvAktarma.Cells[7,i] ;
Qry1.Parameters.ParamByName('odano').Value       := AdvAktarma.Cells[8,i] ;
Qry1.Parameters.ParamByName('esyacinsi').Value   := AdvAktarma.Cells[9,i] ;
Qry1.Parameters.ParamByName('model').Value       := AdvAktarma.Cells[10,i] ;
if AdvAktarma.Cells[11,i]<>'' then
Qry1.Parameters.ParamByName('Adet').Value      := AdvAktarma.Cells[11,i]
else
Qry1.Parameters.ParamByName('Adet').Value      := 0 ;

if AdvAktarma.Cells[12,i]<>'' then
Qry1.Parameters.ParamByName('edinilmedegeri').Value := AdvAktarma.Cells[12,i]
Else
Qry1.Parameters.ParamByName('edinilmedegeri').Value := 0;

if AdvAktarma.Cells[13,i]<>'' then
Qry1.Parameters.ParamByName('kiymet').Value      := AdvAktarma.Cells[13,i]
else
Qry1.Parameters.ParamByName('kiymet').Value      := 0 ;

Qry1.Parameters.ParamByName('kurumkodu').Value      := '01-01' ;
Qry1.Parameters.ParamByName('Kullanici').Value      := Kullanici ;
Qry1.Parameters.ParamByName('Yapilanis').Value      := 'Kayýt' ;
Qry1.Parameters.ParamByName('Aktarildi').Value      := 'N' ;
Qry1.Parameters.ParamByName('ElverisliDegil').Value := 'N' ;
Qry1.Parameters.ParamByName('Bolum2').Value := CmbBolumAdi.Text ;

qry1.Prepared;
qry1.ExecSQL;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select max(id) as id  from demirbaslar ');
qry1.Open;
TmpMaxid := qry1.FieldByName('id').AsString;

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

end;

ShowMessage(' Kaydedildi ...');


end;

procedure TFrmYonetim.Button6Click(Sender: TObject);
var TmpSql,TmpMaxid,TmpBarcode:String;
i,x:integer;
begin

qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select * from demirbaslar ');
qry2.Open;


for i:=1 to Qry2.RecordCount do begin
if qry2.FieldByName('Adet').Asinteger >1 Then begin

TmpSql:='update demirbaslar set kiymet=:kiymet  where  esyacinsi=:esyacinsi and Bolum=:=Bolum and OdaAdi=:OdaAdi' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('Bolum').Value       := qry2.FieldByName('Bolum').Asstring ;
Qry1.Parameters.ParamByName('OdaAdi').Value      := qry2.FieldByName('OdaAdi').Asstring ;
Qry1.Parameters.ParamByName('esyacinsi').Value   := qry2.FieldByName('esyacinsi').Asstring ;

Qry1.Parameters.ParamByName('edinilmedegeri').Value := qry2.FieldByName('edinilmedegeri').Asstring ;
Qry1.Parameters.ParamByName('kiymet').Value         := qry2.FieldByName('kiymet').Asstring ;

Qry1.Parameters.ParamByName('kurumkodu').Value      := '01-01' ;
Qry1.Parameters.ParamByName('Kullanici').Value      := Kullanici ;
Qry1.Parameters.ParamByName('Yapilanis').Value      := 'Kayýt' ;
Qry1.Parameters.ParamByName('Aktarildi').Value      := 'N' ;
Qry1.Parameters.ParamByName('ElverisliDegil').Value := 'N' ;
Qry1.Parameters.ParamByName('Bolum2').Value := qry2.FieldByName('Bolum2').Asstring ;

qry1.Prepared;
qry1.ExecSQL;




end;
end;







exit;



for i:=1 to Qry2.RecordCount do begin

if qry2.FieldByName('Adet').Asinteger >1 Then begin

for x :=2 to qry2.FieldByName('Adet').Asinteger   do  begin

TmpSql:='insert into demirbaslar ' +
'(grupkodu,turkodu,cesitkodu,grupadi,turadi,cesitadi,Bolum,esyacinsi,model,kiymet,kurumkodu,odano,'+
'OdaAdi,Kullanici,Yapilanis,Adet,edinilmedegeri,Aktarildi,ElverisliDegil,Bolum2) ' +
'Values ( ' +
':grupkodu,:turkodu,:cesitkodu,:grupadi,:turadi,:cesitadi,:Bolum,:esyacinsi,:model,:kiymet,:kurumkodu,:odano,'+
':OdaAdi,:Kullanici,:Yapilanis,:Adet,:edinilmedegeri,:Aktarildi,:ElverisliDegil,:Bolum2'+
')';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('grupkodu').Value    := qry2.FieldByName('grupkodu').Asstring ;
Qry1.Parameters.ParamByName('grupadi').Value     := qry2.FieldByName('grupadi').Asstring ;
Qry1.Parameters.ParamByName('turkodu').Value     := qry2.FieldByName('turkodu').Asstring ;
Qry1.Parameters.ParamByName('turadi').Value      := qry2.FieldByName('turadi').Asstring ;
Qry1.Parameters.ParamByName('cesitkodu').Value   := qry2.FieldByName('cesitkodu').Asstring ;
Qry1.Parameters.ParamByName('cesitadi').Value    := qry2.FieldByName('cesitadi').Asstring ;
Qry1.Parameters.ParamByName('Bolum').Value       := qry2.FieldByName('Bolum').Asstring ;
Qry1.Parameters.ParamByName('OdaAdi').Value      := qry2.FieldByName('OdaAdi').Asstring ;
Qry1.Parameters.ParamByName('odano').Value       := qry2.FieldByName('odano').Asstring ;
Qry1.Parameters.ParamByName('esyacinsi').Value   := qry2.FieldByName('esyacinsi').Asstring ;
Qry1.Parameters.ParamByName('model').Value       := qry2.FieldByName('model').Asstring ;
Qry1.Parameters.ParamByName('Adet').Value        := 1 ;

Qry1.Parameters.ParamByName('edinilmedegeri').Value := qry2.FieldByName('edinilmedegeri').Asstring ;
Qry1.Parameters.ParamByName('kiymet').Value         := qry2.FieldByName('kiymet').Asstring ;

Qry1.Parameters.ParamByName('kurumkodu').Value      := '01-01' ;
Qry1.Parameters.ParamByName('Kullanici').Value      := Kullanici ;
Qry1.Parameters.ParamByName('Yapilanis').Value      := 'Kayýt' ;
Qry1.Parameters.ParamByName('Aktarildi').Value      := 'N' ;
Qry1.Parameters.ParamByName('ElverisliDegil').Value := 'N' ;
Qry1.Parameters.ParamByName('Bolum2').Value := qry2.FieldByName('Bolum2').Asstring ;

qry1.Prepared;
qry1.ExecSQL;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select max(id) as id  from demirbaslar ');
qry1.Open;
TmpMaxid := qry1.FieldByName('id').AsString;

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
end;
qry2.next;


end;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Update demirbaslar set Adet = ''1'' ' );
qry1.ExecSQL;

ShowMessage(' Kaydedildi ...');


end;


procedure TFrmYonetim.Button7Click(Sender: TObject);
var TmpSql,TmpMaxid,TmpBarcode:String;
i,x:integer;
begin

for i:=1 to AdvAktarma.RowCount - 1 do begin

if trim(AdvAktarma.Cells[2,i]) <> '' Then begin

for x:=1 to strtoint(AdvAktarma.Cells[3,i]) do begin

TmpSql:='insert into demirbaslar ' +
'(  kamerano,Bolum,esyacinsi,Adet,edinilmedegeri,kiymet, kurumkodu, Kullanici,Yapilanis, Aktarildi, ElverisliDegil, Bolum2  ) ' +
'Values ( ' +
':kamerano,:Bolum,:esyacinsi,:Adet,:edinilmedegeri,:kiymet, :kurumkodu, :Kullanici,:Yapilanis, :Aktarildi, :ElverisliDegil, :Bolum2'+
')';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('kamerano').Value    := AdvAktarma.Cells[0,i] ;
Qry1.Parameters.ParamByName('Bolum').Value       := AdvAktarma.Cells[1,i] ;
Qry1.Parameters.ParamByName('esyacinsi').Value   := 'KAMERA - '+AdvAktarma.Cells[2,i] ;
Qry1.Parameters.ParamByName('Adet').Value        := '1'  ;
Qry1.Parameters.ParamByName('edinilmedegeri').Value := AdvAktarma.Cells[4,i] ;
Qry1.Parameters.ParamByName('kiymet').Value      := AdvAktarma.Cells[5,i];
Qry1.Parameters.ParamByName('kurumkodu').Value      := '01-01' ;
Qry1.Parameters.ParamByName('Kullanici').Value      := Kullanici ;
Qry1.Parameters.ParamByName('Yapilanis').Value      := 'Kayýt' ;
Qry1.Parameters.ParamByName('Aktarildi').Value      := 'N' ;
Qry1.Parameters.ParamByName('ElverisliDegil').Value := 'N' ;
Qry1.Parameters.ParamByName('Bolum2').Value := CmbBolumAdi.Text ;

qry1.Prepared;
qry1.ExecSQL;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select max(id) as id  from demirbaslar ');
qry1.Open;
TmpMaxid := qry1.FieldByName('id').AsString;

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

end;

end;

ShowMessage(' Kaydedildi ...');


end;

procedure TFrmYonetim.Button8Click(Sender: TObject);
begin
//grupkodu, turkodu, cesitkodu, grupadi, turadi, cesitadi, esyacinsi, kiymet,
//kurumkodu, demirbasno, odano, aciklama, barkod, elverislidegil, aktarildi, aktarilanyer,
//aktarilanizahat, elverislidegilizahat, kimdensatin, SatinAlmaTarihi, FaturaNo, odaadi,
//kullanici, yapilanis, adet, Sube, bolum, DemirbasTurleri, AmortOrani, demirbassayi,
// demirbasyil, satinalmatarih, model, edinilmedegeri, bolum2, id, devletbarkod, serino, insansayisi,
//duraksayisi, kamerano,

//YaslanmaYil, yaslanmaedinilmedegeri, yaslanmaoran


//update demirbaslar set yaslanmaedinilmedegeri=edinilmedegeri where  yaslanmaedinilmedegeri is Null


qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('update demirbaslar set YaslanmaYil=:YaslanmaYil,yaslanmaedinilmedegeri=(edinilmedegeri-(edinilmedegeri*0.1)), yaslanmaoran=:yaslanmaoran ');
qry2.Parameters.ParamByName('YaslanmaYil').Value :=  '1';
qry2.Parameters.ParamByName('yaslanmaoran').Value :=   '10' ;
Qry2.Prepared;
qry2.ExecSql;

showmessage('ok');


end;

procedure TFrmYonetim.Button9Click(Sender: TObject);
var i:integer;
begin
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select grupkodu,grupadi,turkodu,turadi,cesitkodu,cesitadi from demirbaslar  ');
qry1.Open;


for i := 1 to Qry1.RecordCount do begin
if (qry1.FieldByName('grupkodu').AsString <> '') and (qry1.FieldByName('turkodu').AsString <> '')  and (qry1.FieldByName('cesitkodu').AsString <> '')  then begin

qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select id from malzemekodlari where grup=:grup and tur=:tur and cesit=:cesit');
qry2.Parameters.ParamByName('grup').Value   :=  qry1.FieldByName('grupkodu').AsString ;
qry2.Parameters.ParamByName('tur').Value    :=  qry1.FieldByName('turkodu').AsString ;
qry2.Parameters.ParamByName('cesit').Value  :=  qry1.FieldByName('cesitkodu').AsString ;
Qry2.Prepared;
qry2.Open;

if qry2.RecordCount =0 then begin
qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('insert into malzemekodlari (grup,tur,cesit,adi)  values (:grup,:tur,:cesit,:adi) ');
qry2.Parameters.ParamByName('grup').Value :=  qry1.FieldByName('grupkodu').AsString ;
qry2.Parameters.ParamByName('tur').Value :=   qry1.FieldByName('turkodu').AsString ;
qry2.Parameters.ParamByName('cesit').Value := qry1.FieldByName('cesitkodu').AsString ;
qry2.Parameters.ParamByName('adi').Value :=   qry1.FieldByName('cesitadi').AsString ;
Qry2.Prepared;
qry2.ExecSql;
end;


end;
qry1.Next;
end;


showmessage('OK');

end;

procedure TFrmYonetim.ChkSelectClick(Sender: TObject);
var i:integer;
begin

for i := 0 to ChkLbHaklar.Items.Count - 1 do begin
    ChkLbHaklar.Checked[i] := ChkSelect.Checked ;
end;

end;

procedure TFrmYonetim.CmbBolumAdiDropDown(Sender: TObject);
var i:integer;
begin

exit;

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

procedure TFrmYonetim.cmbodaadiChange(Sender: TObject);
begin
cmbodano.ItemIndex := cmbodaadi.ItemIndex;

end;

procedure TFrmYonetim.cmbodanoChange(Sender: TObject);
begin
cmbodaadi.ItemIndex := cmbodano.ItemIndex;

end;

procedure TFrmYonetim.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle   := Params.ExStyle or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;

end;

procedure TFrmYonetim.FitGrid(Grid: TDBGrid);
const
  C_Add=3;
var
  ds: TDataSet;
  bm: TBookmark;
  i: Integer;
  w: Integer;
  a: Array of Integer;
begin
  ds := Grid.DataSource.DataSet;
  if Assigned(ds) then
  begin
    ds.DisableControls;
    bm := ds.GetBookmark;
    try
      ds.First;
      SetLength(a, Grid.Columns.Count);
      while not ds.Eof do
      begin
        for I := 0 to Grid.Columns.Count - 1 do
        begin
          if Assigned(Grid.Columns[i].Field) then
          begin
            w :=  Grid.Canvas.TextWidth(ds.FieldByName(Grid.Columns[i].Field.FieldName).DisplayText);
            if a[i] < w  then
               a[i] := w ;
          end;
        end;
        ds.Next;
      end;
      for I := 0 to Grid.Columns.Count - 1 do
        Grid.Columns[i].Width := a[i] + C_Add;
        ds.GotoBookmark(bm);
    finally
      ds.FreeBookmark(bm);
      ds.EnableControls;
    end;
  end;
end;


procedure TFrmYonetim.FormClose(Sender: TObject; var Action: TCloseAction);
begin

Action := caFree;
FrmYonetim:= nil;

end;

procedure TFrmYonetim.FormShow(Sender: TObject);
begin
Temizle;
end;

procedure TFrmYonetim.temizle;
var i:integer;
begin

TxtKullaniciAdi.Tag:=0;

TxtKullaniciAdi.Clear;
TxtSifre.Clear;
TxtTekrarSifre.Clear;

ChkSelect.Checked := False;

for i:=0 to ChkLbHaklar.Items.Count-1 do
ChkLbHaklar.Checked[i] := False ;

AdvListe.ClearRows(1,AdvListe.RowCount-1);
AdvListe.RowCount := 2 ;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select id,KullaniciAdi,Sifre from Yonetim ');
Qry1.Open;

if Qry1.RecordCount <> 0  then
AdvListe.RowCount := Qry1.RecordCount + 1;

for i:=1 to Qry1.RecordCount do begin

AdvListe.Cells[1,i] := Qry1.FieldByName('KullaniciAdi').AsString ;
AdvListe.Cells[2,i] := Qry1.FieldByName('Sifre').AsString ;
AdvListe.Cells[3,i] := Qry1.FieldByName('id').AsString ;

Qry1.Next;
end;

AdvListe.AutoNumberCol(0);

BtnKaydet.Enabled   := True ;
BtnGuncelle.Enabled := False ;
BtnSil.Enabled      := False ;
end;

end.
