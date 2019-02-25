unit UntMuhGlobal;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ImgList, ComCtrls, ToolWin,
  Mask, Db, DBClient, DBTables, ADODB, CurrEdit,shellapi,ToolEdit,StrUtils;

type
  FisString = record
  BorcAlacak :String;
  Hesapkodu:String;
  BelgeNo:String;
  Aciklama:String;
  ParaBirimi:String;
  Miktar:Double;
end;


type TkurTipi = (Alis,Satis ,Aktif);


Function  ConvertString(actStr:String):String ;

Procedure SetUserRights(fForm: Tform;actComp:integer);
procedure BtnPictures(fForm : Tform;actComp:integer);
procedure ToolBarCaptions(fForm : Tform;actComp:integer);
Function  NumberToText(actNumber:String):String;
Function  onlar(x : String) : String ;
Function  yuzler(x : String) : String ;
Function  birler(x : String) : String ;
//Function  ekle(tabloadi: String ; fieldlar:array of string; Degerler: array of string;fieldsayisi:integer) : String ;

 procedure  ekle(qryT: TADOQuery ; tabloadi: String ) ;
 procedure  sil(qrysors,qrydest: TADOQuery ;tabloadi: String;sorgu: String ) ;
 procedure  Guncelle(qryT: TADOQuery ; tabloadi: String;sorgu: String ) ;
 procedure tarihsaatAyarla(qryT: TADOQuery);
 procedure setButtonimage(btn:TSpeedButton;BmpName:string);
 procedure setimage(img:Timage;imgName:string);
 procedure seticon(img:Timage;imgName:string);
 procedure FrmResize(Sender: TObject);




procedure userlog(tabloadi:string;islem,id:integer);

procedure  yardimcihesaplar(qryT: TADOQuery ; anahesapkodu: String ;kirim:integer);
procedure  althesaplar(qryT: TADOQuery ; anahesapkodu,yardimcihesapkodu: String ;kirim:integer);
procedure  Yardimcialthesaplar(qryT: TADOQuery ; anahesapkodu,yardimcihesapkodu,altHesapkodu: String ;kirim:integer);

procedure ChangeCurrency(CurrencyEdit:TCurrencyEdit;sembol:string);


function Kodkontrol(Hesapkodu:string):Boolean ;
function KodtoAdi(Hesapkodu,kirim:string):string ;
function AditoKod(Hesapadi,kirim:string):string ;
procedure AdBul(Hesapkodu,kirim,AnaHesap:string;adi,parabirimi:TEdit);
procedure kodBul(Hesapadi,kirim,AnaHesap:string;kod,parabirimi:TEdit);

function KurGetir(Skur,Dkur,tip:string):Double ;

function KurGetirT(Skur,Dkur,tarih:string;Tipi:TkurTipi):Double ;

//procedure extreyeEkle(Shesap,Dhesap:string;SMiktar,DMiktar,DSMiktar,DDMiktar,kur:Double;Belgeno,aciklama,islemTarih,islem:string);

procedure extreyeEkle(Shesap,Dhesap:string;Miktar:Double;Belgeno,aciklama,islemTarih,islem,SBirimi,Dbirimi,fisyer:string);//,ispara

function MuhKarsilik(kur,tip:string;mikar:Double):Double ;
Function Hatalikirim(str:String):Boolean ;

procedure GeciciHesapBul(AnaHesap:string;kod,adi,parabirimi:TEdit);


function alankontrol(fForm  : Tform;actComp:integer):Boolean;


function isNotinteger(str:string):Boolean;
function isNotnumber(str:string):Boolean;



//function baglan(txtip : string): Boolean;overload;

procedure DevirHesaplariyarat();
procedure fisgoruntule(fisno:string);
function Yedekal():string ;
procedure ExecuteShellCommand(cmdline: string; hidden: Boolean);
Function IsTable(TableName: String): Boolean;

Function  NumberTokurus(Number:String):String;

procedure ondateexit(Sender: TObject);
Function hatalipath(str:string;kirim:Integer):Boolean;

Function Hesapkimin(str:string):Boolean;


function parabirimibul(hesap:string):string;



// *** Add in 04.12.2004 **********************
procedure HesapOlustur(anahesap,alt1,alt2,alt3,adi,aciklama,parabirimi:String);
procedure AltHesapOlustur(path,alt3,adi,aciklama,parabirimi,kimin:String);
procedure HesapGuncelle(taraf,path,parabirimi:String;Miktar:Double);
function  FisNoBul(FisTur:string):String ;
procedure HesapExtreyeKayit(Taraf,HesapKod,Belgeno,aciklama,islem,ParaBirimi,islemTarih,ISPara:string;Miktar:Double);
procedure HesapExtreyeKayitPB(Taraf,HesapKod,Belgeno,aciklama,islem,ParaBirimi,islemTarih,ISPara,Ktipi:string;Miktar:Double);
function FisYarat(rowsay:Integer; FisTur,FisYer,islemTarihi:String;bilgi:array of fisString;isPara:String):String ;
function FisYaratPB(rowsay:Integer; FisTur,FisYer,islemTarihi:String;bilgi:array of fisString;isPara,Ktipi:String):String ;

function  XKodKontrol(fForm : Tform ; TabloAdi:string ; FieldAdi:string ; Kelime:string ; MsgTmp : boolean):integer;//mustafa
// ************************************************

function Fisextrekayit(rowsay:Integer; FisTur,FisYer,islemTarihi:String;bilgi:array of fisString ;isPara,FisNo:String):String ;
function FisextrekayitPB(rowsay:Integer; FisTur,FisYer,islemTarihi:String;bilgi:array of fisString ;isPara,FisNo,Ktipi:String):String ;
procedure sirketbilgilerial();

var


Fisbilgi:array of fisString;



    uygula      :Boolean ;  //*** kullanýcý evet,Hayýr seçimi
    
    Look_No     :String;    //*** aranan Kart No
    Look_Name   :String;    //*** aranan Kart uzantýsý
// *** Update in 27.10.2003
    Look_Year   :String;
// *** Update in 29.10.2003
    OpNumber:Integer ;
// *** Update in 22.11.2003
    ProUserRights: array of string;
    ProRightCount:Integer ;
    actProUserName:String;
    actUserID:Double;


//fieldlar:array of string;
//Degerler: array of string;

fieldlar:array[1..30] of string;
Degerler: array[1..30] of string;


fieldsayisi:integer;


aktifhwnd:HWND;

TmpSiraNo:integer;

Moduller: array of string;
KullaniciSirketler: string;



kategoriselect:Boolean;


kdvaylar:string;

const tirnak = '''';






implementation



uses DateUtils, UntDm, Untmesajlar, Variants, untRepMahsup, untlokalkurlar,
  UntProjectGlobal, Math;
// ***

procedure ExecuteShellCommand(cmdline: string; hidden: Boolean);
const
flags: array[Boolean] of Integer = (SW_SHOWNORMAL, SW_HIDE);
var
cmdbuffer: array[0..MAX_PATH] of Char;
begin
GetEnvironmentVariable('COMSPEC', cmdBUffer, SizeOf(cmdBuffer));
ShellExecute(0,'open',cmdbuffer, PChar('/c' + cmdline), nil, flags[hidden]);
end;




function ConvertString(actStr:String):String ;
var
    x,u:Integer;
    a,tmp:string;
begin
    tmp:='';
    u:=length(actstr);
    for x := 1 to u  do
        begin
            a:=copy(actstr,x,1);
            if a <> '.'  then
                tmp:=tmp+a;
        end;
     ConvertString:=trim(tmp);
end;
// ***
procedure ToolBarCaptions(fForm : Tform;actComp:integer);
// *** Formlardaki toolbar baþlýklarýný yazdýr;
// *** Create Date : 20.05.2004
// *** Last Update :
var
    i,x:Integer ;
    StringList: TStrings;
    caps:  array[1..10] of integer;
begin
    x:=0;
    StringList := TStringList.Create;
    try
        with StringList do begin
            Add('Yeni Kayýt');
            Add('Deðiþtir');
            Add('Sil');
            Add('Arama');
            Add('Raporlar');
            Add('Yardým');
            Add('Çýkýþ');
        end;
    for i:=0 to fForm.ComponentCount -1 do
        if  (fForm.Components[i] is TToolButton )   then
            begin
                x:=x+1;
                caps[x]:=i;
            end;
        for i :=1  to x  do
            TToolButton(fForm.Components[caps[i]]).Caption :=StringList.Strings[i-1];
    finally
    StringList.free;
  end;
end;
// ***
procedure BtnPictures(fForm : Tform;actComp:integer);
// *** Formlardaki sabit resimleri görüntüler
// *** Create Date : 08.04.2004
// *** Last Update :
var
    mm : TIcon;
    pos, i:integer;
begin
    mm := TIcon.Create;
    for i:=0 to fForm.ComponentCount -1 do
    begin
        if  (fForm.Components[i] is TImage) And (fForm.Components[i].tag >= 10)  then
            begin
                pos:=fForm.Components[i].tag-10;
 //               dm.ImageList1.GetIcon(pos,mm) ;
                TImage(fForm.Components[i]).Picture.Assign(mm);
            end
     end;
    mm.Free ;
end;
// ***




// ***
procedure SetUserRights(fForm : Tform;actComp:integer);
var
i,x:integer;
begin
if actComp=1 then
begin
    for i:=0 to fForm.ComponentCount -1 do
    begin
    // *** Butonlarý kontrol et
    if  fForm.Components[i] is TButton  then
        for x:=1  to ProRightCount  do
            if StrToInt(ProUserRights[x])= TButton(fForm.Components[i]).Tag then
                TButton(fForm.Components[i]).Enabled:=True;
    end;
end;
end;
// ***
Function yuzler(x : String) : String;
Begin
case StrToInt(x) of
0   : yuzler := ''          ;
1   : yuzler := 'yüz '      ;
2   : yuzler := 'ikiyüz '   ;
3   : yuzler := 'üçyüz '    ;
4   : yuzler := 'dörtyüz '  ;
5   : yuzler := 'beþyüz '   ;
6   : yuzler := 'altýyüz '  ;
7   : yuzler := 'yediyüz '  ;
8   : yuzler := 'sekizyüz ' ;
9   : yuzler := 'dokuzyüz ' ;
end;
end;
// ***
Function onlar(x : String) : String ;
Begin
case StrToInt(x) of
0   : onlar := ''       ;
1   : onlar := 'on '    ;
2   : onlar := 'yirmi ' ;
3   : onlar := 'otuz '  ;
4   : onlar := 'kýrk '  ;
5   : onlar := 'elli '  ;
6   : onlar := 'atmýþ ' ;
7   : onlar := 'yetmiþ ';
8   : onlar := 'seksen ';
9   : onlar := 'doksan ';
end ;
end;
// ***
Function birler(x : String) : String;
begin
case StrToInt(x) of
0   : birler := ''      ;
1   : birler := 'bir '  ;
2   : birler := 'iki '  ;
3   : birler := 'üç '   ;
4   : birler := 'dört ' ;
5   : birler := 'beþ '  ;
6   : birler := 'altý ' ;
7   : birler := 'yedi ' ;
8   : birler := 'sekiz ';
9   : birler := 'dokuz ';
end;
end;
// ***
Function  NumberToText(actNumber:String):String;
Var
    W:array of String;
    tmp, newNumber:String ;
    Hane,R01,R02,R03,R04,R05 :String;
    digit1,digit2,digit3:String;
    say,x  :integer;
begin
SetLength(w,16);
NewNumber:='000000000000000'+actNumber ;
say:=0;
for  x:=length(NewNumber) downto 1 do
begin
   say:=say+1;
   if say < 16 then w[say]:=copy(NewNumber,x,1);
end;
for  x:=15  downto 1  do
  tmp:=tmp+ w[x];
//*********************
digit3 := yuzler(w[15]);
digit2 := onlar (w[14]);
digit1 := birler(w[13]);
Hane   := ' Trilyon  ';
If (digit3 = '') And (digit2 = '') And (digit1 = '') Then Hane := '';
R05 := digit3 + digit2 + digit1 + Hane;
//*********************
digit3 := yuzler(w[12]);
digit2 := onlar (w[11]);
digit1 := birler(w[10]);
Hane   := ' Milyar  ';
If (digit3 = '') And (digit2 = '') And (digit1 = '') Then Hane := '';
R04 := digit3 + digit2 + digit1 + Hane;
//*********************
digit3 := yuzler(w[9]);
digit2 := onlar (w[8]);
digit1 := birler(w[7]);
Hane   := ' Milyon  ';
If (digit3 = '') And (digit2 = '') And (digit1 = '') Then Hane := '';
R03 := digit3 + digit2 + digit1 + Hane;
//*********************
digit3 := yuzler(w[6]);
digit2 := onlar (w[5]);
digit1 := birler(w[4]);
Hane   := ' Bin  ';
If (digit3 = '') And (digit2 = '') And (digit1 = '') Then Hane := '';
If (digit3 = '') And (digit2 = '') And (digit1 = 'bir ') Then digit1 := '';
R02 := digit3 + digit2 + digit1 + Hane;
//*********************
digit3 := yuzler(w[3]);
digit2 := onlar (w[2]);
digit1 := birler(w[1]);
R01    := digit3 + digit2 + digit1 ;
// ******
  NumberToText:=R05+R04+R03+R02+R01;
end;



procedure  ekle(qryT: TADOQuery; tabloadi: String ) ;
var
i:integer;
sql:string;
begin


sql:='insert into ' + tabloadi +' (';
for i:=1 to fieldsayisi do
sql:=sql+fieldlar[i]+',';

sql:=copy(sql,0,length(sql)-1);
sql:=sql+') values (';


  for i:=1 to fieldsayisi do
  sql:=sql+Degerler[i]+',';

  sql:=copy(sql,0,length(sql)-1);
  sql:=sql+')';


qryT.Close;
qryT.SQL.Clear;
qryT.SQL.Add(sql) ;
qryT.ExecSQL;




end;

procedure  sil(qrysors,qrydest: TADOQuery ;tabloadi: String;sorgu: String ) ;
var
i:integer;
sql:string;
begin


sql:='select * from ' + tabloadi + ' where ' +sorgu;
qrysors.Close;
qrysors.SQL.Clear;
qrysors.SQL.Add(sql) ;
qrysors.open;


qrydest.Close;
qrydest.SQL.Clear;
qrydest.SQL.Add('Select * from silinenler') ;
qrydest.open;



qrydest.Insert;

showmsgbox(inttostr(qrydest.FieldCount),2);
qrydest.Fields.FieldByNumber(2).AsString := tabloadi;
 for i:=3  to qrysors.FieldCount do
  qrydest.Fields.FieldByNumber(i).AsString := qrysors.Fields.FieldByNumber(i-2).AsString;

  qrydest.Post;



sql:='delete  from ' + tabloadi + ' where ' +sorgu;
//showmsgbox(sql);
qrysors.Close;
qrysors.SQL.Clear;
qrysors.SQL.Add(sql) ;
qrysors.ExecSQL;




 end;

  procedure  Guncelle(qryT: TADOQuery ; tabloadi: String;sorgu: String ) ;
var
i:integer;
sql:string;
begin

sql:='update ' +tabloadi +' set ';
for i:=1 to fieldsayisi do
sql:=sql+ fieldlar[i]+'=' +Degerler[i]+',';

sql:=copy(sql,0,length(sql)-1)+ ' where ' +sorgu ;

qryT.Close;
qryT.SQL.Clear;
qryT.SQL.Add(sql) ;
qryT.ExecSQL;



end;

procedure tarihsaatAyarla(qryT: TADOQuery);
var
p:integer;
t:TSystemTime;

begin

qryT.Close;
qryT.SQL.Clear;
qryT.SQL.Add('select  getdate() as date') ;
qryT.open;

t.wYear:=YearOf(qryT.FieldByName('date').AsDateTime );
t.wMonth:=monthof(qryT.FieldByName('date').AsDateTime);
t.wDay:=dayof(qryT.FieldByName('date').AsDateTime);
t.wSecond:=SecondOf(qryT.FieldByName('date').AsDateTime);
t.wMinute:=MinuteOf(qryT.FieldByName('date').AsDateTime);
t.wHour:=HourOf(qryT.FieldByName('date').AsDateTime);
 SetLocalTime(t);



//showmsgbox(qryT.FieldByName('date').AsString);

 end;


procedure setButtonimage(btn:TSpeedButton;BmpName:string);
begin
end;

procedure setimage(img:Timage;imgName:string);
var
imgB:TBitmap;
begin
imgB:=TBitmap.Create;
imgB.LoadFromFile(path+'\Button\'+imgName);
img.Picture.Bitmap:=imgB;
end;


procedure seticon(img:Timage;imgName:string);
var
imgB:Ticon;
begin
imgB:=Ticon.Create;
imgB.LoadFromFile(path+'\icons\'+imgName);
img.Picture.Icon:=imgb;
end;


procedure FrmResize(Sender: TObject);
begin
aktifhwnd:=(sender as TForm).Handle;
end;

//anahesaplar
procedure  yardimcihesaplar(qryT: TADOQuery ; anahesapkodu: String ;kirim:integer);
begin
 with qryT  do
   begin
      close;
      SQL.Clear;
      SQL.Add('Select Adi,anahesap,path from Hesap_plani'+maliyil+' where anahesap= :anahesap') ;
      if kirim>0 then
      begin
      SQL.Add('and kirim= :kirim');
      Parameters.ParamByName('kirim').Value:=kirim;
      end;

      Parameters.ParamByName('anahesap').Value:=anahesapkodu;
      Prepared;
      Open;
   end;

end;

procedure  althesaplar(qryT: TADOQuery ; anahesapkodu,yardimcihesapkodu: String;kirim:integer );
begin
 with qryT  do
   begin
      close;
      SQL.Clear;
      SQL.Add('Select Adi,anahesap,path from Hesap_plani'+maliyil+' where  anahesap= :anahesap and alt1 = :alt1') ;

      if kirim>0 then
      begin
      SQL.Add('and kirim= :kirim');
      Parameters.ParamByName('kirim').Value:=kirim;
      end;

      Parameters.ParamByName('anahesap').Value:=anahesapkodu;
      Parameters.ParamByName('alt1').Value:=yardimcihesapkodu;
      Prepared;
      Open;
   end;
end;


procedure  Yardimcialthesaplar(qryT: TADOQuery ; anahesapkodu,yardimcihesapkodu,altHesapkodu: String;kirim:integer );
begin
 with qryT  do
   begin
      close;
      SQL.Clear;
      SQL.Add('Select Adi,anahesap,path from Hesap_plani'+maliyil+' where  anahesap= :anahesap and alt1 = :alt1 and alt2 = :alt2') ;
      if kirim>0 then
      begin
      SQL.Add('and kirim= :kirim');
      Parameters.ParamByName('kirim').Value:=kirim;
      end;
      Parameters.ParamByName('anahesap').Value:=anahesapkodu;
      Parameters.ParamByName('alt1').Value:=yardimcihesapkodu;
      Parameters.ParamByName('alt2').Value:=altHesapkodu;
      Prepared;
      Open;
   end;
end;

procedure  HesapListele(qryT: TADOQuery ; path: String;kirim:integer);
begin
 with qryT  do
   begin
      close;
      SQL.Clear;
      SQL.Add('Select * from Hesap_plani'+maliyil+' where  path like :path') ;
      Parameters.ParamByName('path').Value:=  path + '%';
      Prepared;
      Open;
   end;
end;


procedure userlog(tabloadi:string;islem,id:integer);
var
maxid:integer;
  begin

{  with dm.Qry2  do
      begin

case islem of
1:
begin   // yeni kayýt eklme
        close;
        SQL.Clear;
        SQL.Add('select max(Id) as maxid from ');
        SQL.Add(tabloadi);
        Prepared;
        open;
        maxid:=FieldValues['maxid'];

        close;
        SQL.Clear;
        SQL.Add('insert into ');
        SQL.Add(tabloadi+'log');
        SQL.Add('(userId,Islem,tarih,recno) values (:userId,:Islem,:tarih,:recno)');
        Parameters.ParamByName('userId').Value:=UserID;
        Parameters.ParamByName('Islem').Value:=islem;
        Parameters.ParamByName('tarih').Value:=date;
        Parameters.ParamByName('recno').Value:=maxid;
        Prepared;
        ExecSQL;
    end;
2:
   begin // güncelleme
        close;
        SQL.Clear;
        SQL.Add('insert into ');
        SQL.Add(tabloadi+'log');
        SQL.Add('(userId,Islem,tarih,recno) values (:userId,:Islem,:tarih,:recno)');
        Parameters.ParamByName('userId').Value:=UserID;
        Parameters.ParamByName('Islem').Value:=islem;
        Parameters.ParamByName('tarih').Value:=date;
        Parameters.ParamByName('recno').Value:=id;
        Prepared;
        ExecSQL;
   end;
3:
  begin
        close;
        SQL.Clear;
        SQL.Add('select max(Id) as maxid from silinenler');
        Prepared;
        open;
        maxid:=FieldValues['maxid'];

        close;
        SQL.Clear;
        SQL.Add('insert into ');
        SQL.Add(tabloadi+'log');
        SQL.Add('(userId,Islem,tarih,recno) values (:userId,:Islem,:tarih,:recno)');
        Parameters.ParamByName('userId').Value:=UserID;
        Parameters.ParamByName('Islem').Value:=islem;
        Parameters.ParamByName('tarih').Value:=date;
        Parameters.ParamByName('recno').Value:=maxid;
        Prepared;
        ExecSQL;
    end;

    end;
  end;
 }
end;


procedure ChangeCurrency(CurrencyEdit:TCurrencyEdit;sembol:string);
begin
CurrencyEdit.DisplayFormat:=',0.00 '+sembol+';-,0.00 '+sembol;

end;


function Kodkontrol(Hesapkodu:string):Boolean ;
begin

  with dm.qryarama do
  begin
  close;
  sql.clear;
  sql.Add('select path from Hesap_plani'+maliyil+' where path = :Hesapkodu');
  Parameters.ParamByName('Hesapkodu').Value:=Hesapkodu;
  open;

  if recordcount= 0 then
       result:=true
       else
       result:=false;
  end;
end;


function KodtoAdi(Hesapkodu,kirim:string):string ;
begin

  with dm.qryarama do
  begin
  close;
  sql.clear;
  sql.Add('select adi from Hesap_plani'+maliyil+' where path = :Hesapkodu and kirim = :kirim');
  Parameters.ParamByName('Hesapkodu').Value:=Hesapkodu;
  Parameters.ParamByName('kirim').Value:=kirim;
  open;

  if recordcount= 0 then
     result:=''
       else
     result:=FieldByName('adi').AsString;

  end;
end;

function AditoKod(Hesapadi,kirim:string):string ;
begin

  with dm.qryarama do
  begin
  close;
  sql.clear;
  sql.Add('select path from Hesap_plani'+maliyil+' where adi = :Hesapadi and kirim = :kirim');
  Parameters.ParamByName('Hesapadi').Value:=Hesapadi;
  Parameters.ParamByName('kirim').Value:=kirim;
  open;

  if recordcount= 0 then
       result:=''
       else
     result:=FieldByName('path').AsString;

  end;




end;

procedure AdBul(Hesapkodu,kirim,AnaHesap:string;adi,parabirimi:TEdit);
begin

  with dm.qryarama do
  begin
  close;
  sql.clear;
  sql.Add('select adi,parabirimi from Hesap_plani'+maliyil+' where path = :Hesapkodu and kirim = :kirim ' +AnaHesap );
  Parameters.ParamByName('Hesapkodu').Value:=Hesapkodu;
  Parameters.ParamByName('kirim').Value:=kirim;
//   Parameters.ParamByName('AnaHesap').Value:=AnaHesap;
  open;

  if recordcount= 0 then
    begin
     adi.Text:='';
     parabirimi.text:='';
    end
       else
       begin
        adi.Text:=FieldByName('adi').AsString;;
        parabirimi.text:=FieldByName('parabirimi').AsString;
     end;
end;
end;



procedure kodBul(Hesapadi,kirim,AnaHesap:string;kod,parabirimi:TEdit);
begin

  with dm.qryarama do
  begin
  close;
  sql.clear;
  sql.Add('select path,parabirimi from Hesap_plani'+maliyil+' where  adi= :Hesapadi and kirim = :kirim ' + AnaHesap );
  Parameters.ParamByName('Hesapadi').Value:=Hesapadi;
  Parameters.ParamByName('kirim').Value:=kirim;
//  Parameters.ParamByName('AnaHesap').Value:=AnaHesap;
  open;

  if recordcount= 0 then
    begin
     kod.Text:='';
     parabirimi.text:='';
    end
       else
       begin
        kod.Text:=FieldByName('path').AsString;;
        parabirimi.text:=FieldByName('parabirimi').AsString;
     end;
end;
end;

function KurGetir(Skur,Dkur,tip:string):Double ;
begin
if Skur=Dkur then
begin
     Result:=1;
     exit;
end;

 KurGetir:=FrmlokalKurlar.lokalkur(Skur,Dkur,tip);


end;

                                     //
function KurGetirT(Skur,Dkur,tarih:string;Tipi:TkurTipi):Double ;
var
tip:string;
begin
if Skur=Dkur then
begin
     Result:=1;
     exit;
end;

if tipi=Alis then
tip:='Alis'
else
if tipi=Satis then
tip:='Satis'
else if tipi=Aktif then
tip:='Aktif';


with dm.QryArama do
  begin
  close;
  sql.Clear;
  sql.Add('select');
  sql.Add(tip);
  sql.Add('from gunlukkurlar'+maliyil);
  sql.Add('where ssembol= :ssembol and dsembol= :dsembol');
  sql.Add('and tarih= :tarih');

  Parameters.ParamByName('ssembol').Value:=skur;
  Parameters.ParamByName('dsembol').Value:=dkur;
  Parameters.ParamByName('tarih').Value:=StrToDate(tarih);

  open;

 if recordcount<>0 then
 KurGetirT:=Fields.Fields[0].AsFloat
  else
    begin
      close;
      sql.Clear;
      sql.Add('select');
      sql.Add(tip);
      sql.Add('from gunlukkurlar'+maliyil);
      sql.Add('where ssembol= :ssembol and dsembol= :dsembol');
      sql.Add('and tarih< :tarih  order by tarih');

  Parameters.ParamByName('ssembol').Value:=skur;
  Parameters.ParamByName('dsembol').Value:=dkur;
  Parameters.ParamByName('tarih').Value:=StrToDate(tarih);
  open;

 if recordcount<>0 then
  KurGetirT:=Fields.Fields[0].AsFloat

    end;



  end;





end;



procedure extreyeEkle(Shesap,Dhesap:string;Miktar:Double;Belgeno,aciklama,islemTarih,islem,SBirimi,Dbirimi,fisyer:string);//ispara
var
Malacak,Mborc,Dalacak,Dborc,Miktar1,Miktar2:Double;

begin

try

hesapextreyekayit( 'A',Shesap,belgeno,aciklama,islem,sbirimi,islemTarih,SBirimi,miktar);
hesapextreyekayit('B',Dhesap,belgeno,aciklama,islem,Dbirimi,islemTarih,SBirimi,miktar);


SetLength(Fisbilgi,3);
Fisbilgi[1].Aciklama:=Aciklama;
Fisbilgi[1].BelgeNo:=belgeno;
Fisbilgi[1].BorcAlacak:='A';
Fisbilgi[1].Hesapkodu:=Shesap;
Fisbilgi[1].Miktar:=Miktar;
Fisbilgi[1].ParaBirimi:=sbirimi;


Fisbilgi[2].Aciklama:=Aciklama;
Fisbilgi[2].BelgeNo:=belgeno;
Fisbilgi[2].BorcAlacak:='B';
Fisbilgi[2].Hesapkodu:=Dhesap;
Fisbilgi[2].Miktar:=Miktar;
Fisbilgi[2].ParaBirimi:=dbirimi;

fisgoruntule(FisYarat(2,'Ms',fisyer,islemtarih,Fisbilgi,sbirimi));
//          end;
     except
      msgbox(8,0);
     end;


end;

function MuhKarsilik(kur,tip:string;mikar:Double):Double ;
begin
Result:=KurGetir(kur,mbp,tip)*mikar;
end;

Function Hatalikirim(str:String):Boolean ;
begin
if (Length(str)<>4) then
begin
Result:=true;
showmsgbox('Hatalý kýrým',2);
end
else
if not( str[1]  in ['0'..'9']) or not(str[2]  in ['0'..'9']) or not(str[3]  in ['0'..'9']) or not(str[4]  in ['0'..'9']) then
begin
Result:=true;
showmsgbox('Hatalý kýrým',2);
end
else
begin
Result:=false;

end;



end;

function alankontrol(fForm  : Tform;actComp:integer):Boolean;
var
i,j:integer;
begin
     Result:=false;
     for i:=0 to fForm.ComponentCount -1 do
     begin
         if actComp  = 1 then
             if  fForm.Components[i] is TEdit then
                 if (TEdit(fForm.Components[i]).text ='') and (TEdit(fForm.Components[i]).Tag <>-1) then
                 begin
                 if TEdit(fForm.Components[i]).Enabled = true then
                 (fForm.Components[i] as  TEdit).SetFocus;
                 if not Result then
                 msgbox(1,2);

                 Result:=true;
                 //exit;
                 end;


          if actComp  = 2 then
             if  fForm.Components[i] is TLabel then
                 if (TLabel(fForm.Components[i]).Caption ='') and (TLabel(fForm.Components[i]).Tag <>-1) then
                 begin
                 msgbox(1,2);
                  Result:=true;
                 // exit;
                 end;
          if actComp  = 3 then
             if  fForm.Components[i] is TComboBox then
                 if (TComboBox(fForm.Components[i]).text ='') and (TComboBox(fForm.Components[i]).Tag <>-1) then
                 begin
                 if TComboBox(fForm.Components[i]).Enabled = true then
                 (fForm.Components[i] as  TComboBox).SetFocus;
                 msgbox(1,2);
                 Result:=true;
                 // exit;
                 end;

      end;

          if actComp  = 4 then
             if  fForm.Components[i] is TCurrencyEdit then
                 if (TCurrencyEdit(fForm.Components[i]).Value =0) and (TCurrencyEdit(fForm.Components[i]).Tag <>-1) then
                 begin
                 if TCurrencyEdit(fForm.Components[i]).Enabled = true then
                 (fForm.Components[i] as  TCurrencyEdit).SetFocus;
                 if not Result then
                 msgbox(1,2);
                 Result:=true;

                 end;



   {  for i:=0 to fForm.ComponentCount -1 do
      begin
         if actComp  = 1 then
             if  fForm.Components[i] is TEdit then
                 if (TEdit(fForm.Components[i]).text ='') and (TEdit(fForm.Components[i]).Tag <>-1) then
                 begin
               for j:=0 to fForm.ComponentCount -1 do
                if  fForm.Components[j] is TEdit then
                 begin
                 if (TEdit(fForm.Components[j]).text ='') and (TEdit(fForm.Components[j]).Tag <>-1) then
                 begin
                  if TEdit(fForm.Components[j]).TabOrder > TEdit(fForm.Components[i]).TabOrder then
                           begin
                           if (TEdit(fForm.Components[i]).Visible = true) then
                               TEdit(fForm.Components[i]).SetFocus
                           end
                           else
                           begin
                           if (TEdit(fForm.Components[j]).Visible = true) then
                              TEdit(fForm.Components[j]).SetFocus
                           end;
                 end;

                 end;
        end;



 end;}
 end;

 procedure GeciciHesapBul(AnaHesap:string;kod,adi,parabirimi:TEdit);
var
path:string;
 begin
 with dm.qryarama do
  begin
  close;
  sql.clear;

  sql.Add('select HesapKodu from GeciciHesaplar where  AnaHesap = :AnaHesap ');
  Parameters.ParamByName('AnaHesap').Value:=AnaHesap;
      open;
   if recordcount<> 0 then
   begin
   path:=FieldByName('HesapKodu').AsString;

    close;
    sql.clear;
    sql.Add('select adi,parabirimi from Hesap_plani'+maliyil+' where  path= :path '  );
    Parameters.ParamByName('path').Value:=path;
    open;

        if recordcount= 0 then
        begin
         kod.Text:='';
         adi.Text:='';
         parabirimi.text:='';
        end
         else
         begin
          kod.Text:=path;
          adi.Text:=FieldByName('adi').AsString;
          parabirimi.text:=FieldByName('parabirimi').AsString;
       end;
    end;
   end;
 end;

function isNotinteger(str:string):Boolean;
var
x:Integer;
 begin
   try
    x:=StrToInt(str);
    Result:=false;
   except
   Result:=true;
  end;




  end;

function isNotnumber(str:string):Boolean;
  var
x,i:Integer;
 begin

 for i:=1 to length(str) do
    if not( str[i] in ['0'..'9',DecimalSeparator]) then
    begin
    Result:=false;
    exit;
    end;

   Result:=true;



end;







{function baglan(txtip :string): Boolean; overload
var
dosya :TextFile;
var
i:Integer;
begin

i:=pos('.',txtip);

if i<>0 then

begin


if (copy(txtip,4,1)<>'.') and (copy(txtip,8,1)<>'.') and  (copy(txtip,12,1)<>'.')  then
begin
showmsgbox('Hatalý Ýp Giriþi Lütfen Tekrar Deneyin');
exit;
end;
end;
result:=false;
try
dm.ado1.Close;
dm.ado1.ConnectionString :='Provider=SQLOLEDB.1;Password=aslan;Persist Security Info=True;User ID=aslan;Initial Catalog=Aslan;Data Source='+txtip;
dm.ado1.Open;
AssignFile(dosya,path+'server.cnn');
Rewrite(dosya);
Writeln(dosya,txtip);
CloseFile(dosya);
result:=True;
showmsgbox('Baglantý Kuruldu');
except
result:=false;
end;

end; }


procedure DevirHesaplariyarat();

var
sql1,yil,tirnak:string;
i:Integer;
begin
tirnak:='''';
sql1:='';
 with dm.Qry1  do
        begin
          close;
          SQL.Clear;
          SQL.Add('select max(yil)as Myil from yil ');
          open;
          yil:=inttostr(FieldValues['Myil']+1);
          close;
          SQL.Clear;

          close;
          SQL.Clear;
          SQL.Add('insert into yil (yil,aktif) values(:yil,:aktif)');
          Parameters.ParamByName('yil').Value:=yil;
          Parameters.ParamByName('aktif').Value:=0;
          ExecSQL;

//close;
//SQL.Clear;
//sql1:='if exists (select * from dbo.sysobjects where id = object_id(N'+ tirnak+'[dbo].[HesapExtre]'+ tirnak+') and OBJECTPROPERTY(id, N'+ tirnak+'IsUserTable'+ tirnak+') = 1)';
//sql1:=sql1 + 'drop table [dbo].[HesapExtre'+ yil+ '] ';
//SQL.Add(sql1);
//ExecSQL;


{sql1:=sql1 +'CREATE TABLE [dbo].[HesapExtre' +yil+ '] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[hedef] [varchar] (16) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[tarih] [datetime] NULL ,';
sql1:=sql1 +'	[Aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Borc] [float] DEFAULT 0 NOT NULL ,';
sql1:=sql1 +'	[alacak] [float] DEFAULT 0 NOT NULL ,';
sql1:=sql1 +'	[belgeno] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[islem] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[kaynak] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Dborc] [float] DEFAULT 0 NOT NULL ,';
sql1:=sql1 +'	[Dalacak] [float]DEFAULT 0 NOT NULL ,';
sql1:=sql1 +'	[islemtarih] [datetime] NULL ,';
sql1:=sql1 +'	[kur] [float] NULL ,';
sql1:=sql1 +'	[Onay] [varchar] (2) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';}

close;
SQL.Clear;
sql1:='';
sql1:=sql1 +'CREATE TABLE [ArGeBoyaLabTest'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[TestID] [int] NULL ,';
sql1:=sql1 +'	[UretimNoID] [int] NULL ,';
sql1:=sql1 +'	[R1] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R2] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R3] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R4] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R5] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R6] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R7] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R8] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R9] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R10] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R11] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R12] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R13] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R14] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R15] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R16] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R17] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R18] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R19] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R20] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;

close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [ArGeBoyaUretim'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[UretimNo] [int] NULL ,';
sql1:=sql1 +'	[UrunKod] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[PartiNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[SpektNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[SpektID] [int] NULL ,';
sql1:=sql1 +'	[Miktar] [float] NULL ,';
sql1:=sql1 +'	[GMiktar] [float] NULL ,';
sql1:=sql1 +'	[HMaddeTarih] [datetime] NULL ,';
sql1:=sql1 +'	[HMaddeBasla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HMaddeBitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[ImalatTarih] [datetime] NULL ,';
sql1:=sql1 +'	[ImalatBasla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[ImalatBitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HMadde] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Imalat] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Durum] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Testler] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';


SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';
sql1:=sql1 +'CREATE TABLE [ArGeBoyaUretimBilgi'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[UretimNo] [int] NULL ,';
sql1:=sql1 +'	[HMaddeKodu] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HMaddeAdi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Miktar] [float] NULL ,';
sql1:=sql1 +'	[GMiktar] [float] NULL ,';
sql1:=sql1 +'	[GGirdiNo] [int] NULL ,';
sql1:=sql1 +'	[Haziranlayan] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Kazan] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Sicaklik] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[PH] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Devir] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';


sql1:=sql1 +'CREATE TABLE [ArGeTozLabTest'+yil+'] (';
sql1:=sql1 +'	[ID] [int] NOT NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[TestID] [int] NULL ,';
sql1:=sql1 +'	[UretimNoID] [int] NULL ,';
sql1:=sql1 +'	[R1] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R2] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R3] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R4] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R5] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R6] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R7] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R8] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R9] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R10] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R11] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R12] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R13] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R14] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R15] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R16] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R17] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R18] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R19] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R20] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';


SQL.Add(sql1);
ExecSQL;




close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [ArGeTozUretim'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[UretimNo] [int] NULL ,';
sql1:=sql1 +'	[UrunKod] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[PartiNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[SpektNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[SpektID] [int] NULL ,';
sql1:=sql1 +'	[Miktar] [float] NULL ,';
sql1:=sql1 +'	[GMiktar] [float] NULL ,';
sql1:=sql1 +'	[HMaddeTarih] [datetime] NULL ,';
sql1:=sql1 +'	[HMaddeBasla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HMaddeBitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[ImalatTarih] [datetime] NULL ,';
sql1:=sql1 +'	[ImalatBasla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[ImalatBitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HMadde] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Imalat] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Durum] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Testler] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;



close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [ArGeTozUretimBilgi'+yil+'] (';
sql1:=sql1 +'	[ID] [int] NULL ,';
sql1:=sql1 +'	[UretimNo] [int] NULL ,';
sql1:=sql1 +'	[HMaddeKodu] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HMaddeAdi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Miktar] [float] NULL ,';
sql1:=sql1 +'	[GMiktar] [float] NULL ,';
sql1:=sql1 +'	[GGirdiNo] [int] NULL ,';
sql1:=sql1 +'	[Haziranlayan] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Kazan] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Sicaklik] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[PH] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Devir] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';
sql1:=sql1 +'CREATE TABLE [BoyaADegistir'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[ADNo] [int] NULL ,';
sql1:=sql1 +'	[ADFormNo] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[IslemTarihi] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[DepoKodu] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[TNeden] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Teslim] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Talep] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Emir] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Depo] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;

close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [BoyaADegistirBilgi'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[ADNo] [int] NULL ,';
sql1:=sql1 +'	[Yer] [varchar] (2) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[LT01] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[LT25] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[LT75] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[LT15] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[SDisi] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[LAB] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [BoyaADolum'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[AFormNo] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tip] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[LT01] [float] NULL ,';
sql1:=sql1 +'	[LT25] [float] NULL ,';
sql1:=sql1 +'	[LT75] [float] NULL ,';
sql1:=sql1 +' [LT15] [float] NULL ,';
sql1:=sql1 +'	[SDisi] [float] NULL ,';
sql1:=sql1 +'	[LAB] [float] NULL , ';
sql1:=sql1 +'	[Fire] [float] NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;

close;
SQL.Clear;
sql1:='';
sql1:=sql1 +'CREATE TABLE [BoyaADolumIslem'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[AFormNo] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Ad] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tip] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[Basla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Bitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Toplam] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [BoyaAmbalajForm'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[UretimNoID] [int] NULL ,';
sql1:=sql1 +'	[AFormNo] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Dansite] [float] NULL ,';
sql1:=sql1 +'	[Onay] [int] NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;



close;
SQL.Clear;
sql1:='';


sql1:=sql1 +' CREATE TABLE [BoyaLabTest'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[TestID] [int] NULL ,';
sql1:=sql1 +'	[UretimNoID] [int] NULL ,';
sql1:=sql1 +'	[R1] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R2] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R3] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R4] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R5] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R6] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R7] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R8] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R9] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R10] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R11] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R12] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R13] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R14] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R15] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R16] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R17] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R18] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R19] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R20] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';


SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';
sql1:=sql1 +'CREATE TABLE [BoyaUretim'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[UretimNo] [int] NULL ,';
sql1:=sql1 +'	[UrunKod] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[PartiNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[SpektNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[SpektID] [int] NULL ,';
sql1:=sql1 +'	[Miktar] [float] NULL ,';
sql1:=sql1 +'	[GMiktar] [float] NULL ,';
sql1:=sql1 +'	[HMaddeTarih] [datetime] NULL ,';
sql1:=sql1 +'	[HMaddeBasla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HMaddeBitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[ImalatTarih] [datetime] NULL ,';
sql1:=sql1 +'	[ImalatBasla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[ImalatBitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[AmbalajTarih] [datetime] NULL ,';
sql1:=sql1 +'	[AmbalajBasla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[AmbalajBitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL , ';
sql1:=sql1 +'	[HMadde] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Imalat] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Ambalaj] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Durum] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Testler] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[ToplamMaliyet] [float] NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;

close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [BoyaUretimBilgi'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[UretimNo] [int] NULL ,';
sql1:=sql1 +'	[HMaddeKodu] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HMaddeAdi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Miktar] [float] NULL ,';
sql1:=sql1 +'	[GMiktar] [float] NULL ,';
sql1:=sql1 +'	[GGirdiNo] [int] NULL ,';
sql1:=sql1 +'	[Haziranlayan] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Kazan] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Sicaklik] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[PH] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Devir] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [Fatura'+yil+'] (';
sql1:=sql1 +'	[ID] [int] NOT NULL ,';
sql1:=sql1 +'	[MHGHesapKodu] [varchar] (17) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[MHSHesapKodu] [varchar] (17) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[FaturaNo] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[AlinanMalHizmet] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[KDVOrani] [float] NULL ,';
sql1:=sql1 +'	[FaturaTutariKDVDahil] [float] NULL ,';
sql1:=sql1 +'	[FaturaTutari] [float] NULL ,';
sql1:=sql1 +'	[KDVTutari] [float] NULL ,';
sql1:=sql1 +'	[NetTutar] [float] NULL ,';
sql1:=sql1 +'	[IndirimOrani] [float] NULL ,';
sql1:=sql1 +'	[IndirimTutari] [float] NULL ,';
sql1:=sql1 +'	[Tur] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [FaturaBilgi'+yil+'] (';
sql1:=sql1 +'	[ID] [int] NOT NULL ,';
sql1:=sql1 +'	[Cinsi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tutari] [float] NULL ,';
sql1:=sql1 +'	[KDVOrani] [float] NULL ,';
sql1:=sql1 +'	[Iskonto] [float] NULL ,';
sql1:=sql1 +'	[KdvTutari] [float] NULL ,';
sql1:=sql1 +'	[Aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;

close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [FisBilgi'+yil+'] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[fisno] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[fistur] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[fisyeri] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[toplamborc] [float] NULL ,';
sql1:=sql1 +'	[toplamalacak] [float] NULL ,';
sql1:=sql1 +'	[islemtarihi] [datetime] NULL ,';
sql1:=sql1 +'	[kullanici] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[LastNo] [int] NULL';
sql1:=sql1 +') ON [PRIMARY]';


SQL.Add(sql1);
ExecSQL;

close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [FisExtre'+yil+'] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[FisId] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HesapKod] [varchar] (16) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[ParaBirimi] [varchar] (4) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[BelgeNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[IslemTur] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HPBBorc] [float] NULL ,';
sql1:=sql1 +'	[HPBAlacak] [float] NULL ,';
sql1:=sql1 +'	[MPBBorc] [float] NULL ,';
sql1:=sql1 +'	[MPBAlacak] [float] NULL ,';
sql1:=sql1 +'	[Kur] [float] NULL ,';
sql1:=sql1 +'	[BorcAlacak] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;

{
close;
SQL.Clear;
sql1:='';
sql1:=sql1 +'CREATE TABLE [Gecicihesaplar'+yil+'] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[HesapKodu] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[anahesap] [varchar] (3) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;
}

close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [Hesap_plani'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[anahesap] [varchar] (3) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[alt1] [varchar] (3) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[alt2] [varchar] (3) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[alt3] [varchar] (4) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[path] [varchar] (17) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[adi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[borc] [float] NULL CONSTRAINT [DF_Hesap_plani2004_borc] DEFAULT (0),';
sql1:=sql1 +'	[alacak] [float] NULL CONSTRAINT [DF_Hesap_plani2004_alacak_1] DEFAULT (0),';
sql1:=sql1 +'	[aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[parabirimi] [varchar] (3) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[kirim] [smallint] NULL ,';
sql1:=sql1 +'	[kimin] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Aktif] [smallint] NULL ,';
sql1:=sql1 +'	[Dborc] [float] NULL CONSTRAINT [DF_Hesap_plani2004_Dborc_1] DEFAULT (0),';
sql1:=sql1 +'	[Dalacak] [float] NULL CONSTRAINT [DF_Hesap_plani2004_Dalacak_1] DEFAULT (0)';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [Hesapextre'+yil+'] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[Hesapkodu] [varchar] (16) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[tarih] [datetime] NULL ,';
sql1:=sql1 +'	[Aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Borc] [float] NOT NULL CONSTRAINT [DF_Hesapextre_Borc] DEFAULT (0),';
sql1:=sql1 +'	[alacak] [float] NOT NULL CONSTRAINT [DF_Hesapextre_alacak] DEFAULT (0),';
sql1:=sql1 +'	[belgeno] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[islem] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Dborc] [float] NOT NULL CONSTRAINT [DF_Hesapextre_Dborc] DEFAULT (0),';
sql1:=sql1 +'	[Dalacak] [float] NOT NULL CONSTRAINT [DF_Hesapextre_Dalacak] DEFAULT (0),';
sql1:=sql1 +'	[islemtarih] [datetime] NULL ,';
sql1:=sql1 +'	[kur] [float] NULL ,';
sql1:=sql1 +'	[Onay] [varchar] (2) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Kimin] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[operator] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';


sql1:=sql1 +'CREATE TABLE [irsaliye'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[plaka] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[irsaliyeNo] [int] NULL ,';
sql1:=sql1 +'	[Urun] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[Miktar] [float] NULL ,';
sql1:=sql1 +'	[adres] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tartimid] [int] NULL ,';
sql1:=sql1 +'	[Geldigi] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Gittigi] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Nakliyeci] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[chk] [bit] NOT NULL ,';
sql1:=sql1 +'	[faturano] [int] NULL , ';
sql1:=sql1 +'	[carihesapno] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[nakliyebolge] [int] NULL ,';
sql1:=sql1 +'	[operator] [int] NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;

close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [ithalathesabi'+yil+'] (';
sql1:=sql1 +'	[Id] [int] NULL ,';
sql1:=sql1 +'	[hesapno] [varchar] (16) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[cinsi] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[tedarikci] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[gumrukcu] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[nakliyeci] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[tarih] [datetime] NULL ,';
sql1:=sql1 +'	[ithalatno] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [Makbuz'+yil+'] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[tipi] [int] NULL ,';
sql1:=sql1 +'	[kullaniciAdi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[ToplamTutar] [float] NULL ,';
sql1:=sql1 +'	[PersonelAdi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[parabirimi] [varchar] (4) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[islemtarihi] [datetime] NULL ,';
sql1:=sql1 +'	[Musterihesapno] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Kasa] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[belgeno] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Musteri] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;



close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [MakbuzKrediKarti'+yil+'] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[bankaadi] [char] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[makbuzno] [int] NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;



close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [RenklendirmeSparisi'+yil+'] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[MusteriAdi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[MusteriKayitno] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Renkkodu] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Miktar] [float] NULL ,';
sql1:=sql1 +'	[tarih] [datetime] NULL ,';
sql1:=sql1 +'	[teslimTarihi] [datetime] NULL ,';
sql1:=sql1 +'	[uretildi] [tinyint] NULL ,';
sql1:=sql1 +'	[UrunKodu] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[UrunAdi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[birim] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[siparistarihi] [datetime] NULL ,';
sql1:=sql1 +'	[aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [Satisfaturabilgi'+yil+'] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[faturano] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Barkod] [varchar] (30) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Birim] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Miktar] [float] NULL ,';
sql1:=sql1 +'	[BirimFiyat] [float] NULL ,';
sql1:=sql1 +'	[urunparabirimi] [varchar] (4) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Fiyat] [float] NULL ,';
sql1:=sql1 +'	[indOrani] [float] NULL ,';
sql1:=sql1 +'	[indirim] [float] NULL ,';
sql1:=sql1 +'	[NetTutar] [float] NULL ,';
sql1:=sql1 +'	[KDVOrani] [float] NULL ,';
sql1:=sql1 +'	[KDVTutari] [float] NULL ,';
sql1:=sql1 +'	[ToplamTutar] [float] NULL ,';
sql1:=sql1 +'	[islemtarihi] [datetime] NULL ,';                   //2004
sql1:=sql1 +'	[durum] [smallint] NULL CONSTRAINT [DF_Satisfaturabilgi'+yil+'_durum] DEFAULT (0)';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [SatisFaturasi'+yil+'] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[HesapNo] [varchar] (16) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HesapParaBirimi] [varchar] (4) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[SicilNo] [varchar] (30) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Düzenleyen] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[FaturaVadesi] [int] NULL ,';
sql1:=sql1 +'	[SonodemeTarihi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[ToplamFiyat] [float] NULL ,';
sql1:=sql1 +'	[Toplamindirim] [float] NULL ,';
sql1:=sql1 +'	[KDV3] [float] NULL ,';
sql1:=sql1 +'	[KDV5] [float] NULL ,';
sql1:=sql1 +'	[KDV15] [float] NULL , ';
sql1:=sql1 +'	[ToplamKDV] [float] NULL ,';
sql1:=sql1 +'	[GenelToplam] [float] NULL ,';
sql1:=sql1 +'	[userId] [int] NULL ,';
sql1:=sql1 +'	[NetTutar] [float] NULL ,';
sql1:=sql1 +'	[faturano] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Odemesekli] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[islemtarihi] [datetime] NULL ,';
sql1:=sql1 +'	[parabirimi] [varchar] (4) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[musterikodu] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[tarih] [datetime] NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;



close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [StokExtre'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[UrunId] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[DepoId] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[Aciklama] [varchar] (200) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Giris] [float] NULL ,';
sql1:=sql1 +'	[Cikis] [float] NULL ,';
sql1:=sql1 +'	[yer] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[islem] [varchar] (4) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[borc] [float] NULL ,';
sql1:=sql1 +'	[alacak] [float] NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [StokHesaplariextre'+yil+'] (';
sql1:=sql1 +'	[Id] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[tarih] [datetime] NULL ,';
sql1:=sql1 +'	[aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Belgeno] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[islemTuru] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Satici] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Birim] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Gmiktar] [float] NULL ,';
sql1:=sql1 +'	[GBirimMaliyet] [float] NULL ,';
sql1:=sql1 +'	[GToplamMaliyet] [float] NULL ,';
sql1:=sql1 +'	[Cmiktar] [float] NULL ,';
sql1:=sql1 +'	[CBirimMaliyet] [float] NULL ,';
sql1:=sql1 +'	[CtoplamMaliyet] [float] NULL ,';
sql1:=sql1 +'	[Kmiktar] [float] NULL ,';
sql1:=sql1 +'	[KBirimMaliyet] [float] NULL ,';
sql1:=sql1 +'	[KtoplamMaliyet] [float] NULL ,';
sql1:=sql1 +'	[urunkodu] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [TozADegistir'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[ADNo] [int] NULL ,';
sql1:=sql1 +'	[ADFormNo] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[IslemTarihi] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[DepoKodu] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[TNeden] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Teslim] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Talep] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Emir] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Depo] [varchar] (25) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;



close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [TozADegistirBilgi'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[ADNo] [int] NULL ,';
sql1:=sql1 +'	[RYer] [int] NULL ,';
sql1:=sql1 +'	[CYer] [int] NULL ,';
sql1:=sql1 +'	[UEbat] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tur] [char] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[UMiktar] [float] NULL';
sql1:=sql1 +') ON [PRIMARY]';


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [TozADolum'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[AFormNo] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tip] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[AmbalajTipi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[AMiktar] [float] NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;



close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [TozADolumIslem'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[AFormNo] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Ad] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tip] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[Basla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Bitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Toplam] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';

SQL.Add(sql1);
ExecSQL;



close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [TozAmbalajForm'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[UretimNoID] [int] NULL ,';
sql1:=sql1 +'	[AFormNo] [varchar] (20) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Dansite] [float] NULL ,';
sql1:=sql1 +'	[Onay] [int] NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;


close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [TozLabTest'+yil+'] (';
sql1:=sql1 +'	[ID] [int] NOT NULL ,';
sql1:=sql1 +'	[Tarih] [datetime] NULL ,';
sql1:=sql1 +'	[TestID] [int] NULL ,';
sql1:=sql1 +'	[UretimNoID] [int] NULL ,';
sql1:=sql1 +'	[R1] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R2] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R3] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R4] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R5] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R6] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R7] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R8] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R9] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R10] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R11] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R12] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R13] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R14] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R15] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R16] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R17] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R18] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R19] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[R20] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;




close;
SQL.Clear;
sql1:='';


sql1:=sql1 +'CREATE TABLE [TozUretim'+yil+'] (';
sql1:=sql1 +'	[ID] [int] IDENTITY (1, 1) NOT NULL ,';
sql1:=sql1 +'	[UretimNo] [int] NULL ,';
sql1:=sql1 +'	[UrunKod] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[PartiNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[SpektNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[SpektID] [int] NULL ,';
sql1:=sql1 +'	[PMiktar] [float] NULL ,';
sql1:=sql1 +'	[PBatch] [int] NULL ,';
sql1:=sql1 +'	[GMiktar] [float] NULL ,';
sql1:=sql1 +'	[GBatch] [int] NULL ,';
sql1:=sql1 +'	[UretimTarih] [datetime] NULL ,';
sql1:=sql1 +'	[UretimBasla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[UretimBitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[AmbalajTarih] [datetime] NULL ,';
sql1:=sql1 +'	[AmbalajBasla] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[AmbalajBitir] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL , ';
sql1:=sql1 +'	[Uretim] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Ambalaj] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Durum] [varchar] (1) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Testler] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';



close;
SQL.Clear;
sql1:='';

sql1:=sql1 +'CREATE TABLE [TozUretimBilgi'+yil+'] (';
sql1:=sql1 +'	[UretimNo] [int] NULL ,';
sql1:=sql1 +'	[HMaddeKodu] [varchar] (10) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[HMaddeAdi] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Miktar] [float] NULL ,';
sql1:=sql1 +'	[GMiktar] [float] NULL ,';
sql1:=sql1 +'	[GGirdiNo] [int] NULL ,';
sql1:=sql1 +'	[Haziranlayan] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Kazan] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Sicaklik] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[PH] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Devir] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL ,';
sql1:=sql1 +'	[Aciklama] [varchar] (50) COLLATE SQL_Latin1_General_CP1254_CI_AS NULL';
sql1:=sql1 +') ON [PRIMARY]';
SQL.Add(sql1);
ExecSQL;


end;


end;
procedure fisgoruntule(fisno:string);
begin


          with dm.Qry1  do
           begin
           close;
           SQL.Clear;
           SQL.Add('Select f.* ,(select adi from Hesap_plani'+maliyil+' where path = f.hesapkod) as hesapadi');
           SQL.Add('from fisextre'+maliyil+' as f where ( MPBborc<>0  or MPBalacak=0 )  and fisId = :fisno');
           Parameters.ParamByName('fisno').Value:=fisno;
           Prepared;
           open;
         end;

          with dm.Qry2  do
           begin
           close;
           SQL.Clear;
           SQL.Add('Select f.* ,(select adi from Hesap_plani'+maliyil+' where path = f.hesapkod) as hesapadi');
           SQL.Add('from fisextre'+maliyil+' as f where MPBalacak<>0 and fisId = :fisno');

//        or MPBborc=0

           Parameters.ParamByName('fisno').Value:=fisno;
           Prepared;
           open;
         end;

       with dm.QryArama  do
           begin
           close;
           SQL.Clear;
           SQL.Add('Select * from fisbilgi'+maliyil+' where fisno = :fisno');
           Parameters.ParamByName('fisno').Value:=fisno;
           Prepared;
           open;
         end;

        (dm.Qry1.FieldByName('MPBborc') as TNumericField).DisplayFormat:='#,##0.00';
        (dm.Qry1.FieldByName('HPBborc') as TNumericField).DisplayFormat:='#,##0.00';
        (dm.Qry2.FieldByName('MPBalacak') as TNumericField).DisplayFormat:='#,##0.00';
        (dm.Qry2.FieldByName('HPBalacak') as TNumericField).DisplayFormat:='#,##0.00';

        (dm.QryArama.FieldByName('toplamborc') as TNumericField).DisplayFormat:='#,##0.00';
        (dm.QryArama.FieldByName('toplamalacak') as TNumericField).DisplayFormat:='#,##0.00';




RepMahsup:=TRepMahsup.Create(nil);
RepMahsup.lblyazdiran.Caption:=Kullanici;

with RepMahsup do
begin
QRLFirmaAdi.Caption := 'Firma Adý :' +TmpKayitIsmi ;
QRLMaiyil.Caption := 'Mali Yýl:   '+Maliyil ;
QRLIsim.Caption := ProCaption;
QRLWeb.Caption :=  programWeb;
QRLTarih.Caption :=  datetostr(Date)+' '+timetostr(Now);
end;



RepMahsup.PreviewModal;
RepMahsup.Free;


end;


function Yedekal():string ;

var
tmp:string;
begin
Result:='';
try
 with dm.Qry1  do
        begin
          close;
          SQL.Clear;
SQL.Add('BACKUP DATABASE aslan TO DISK=');
tmp:=IntToStr(YearOf(now));
tmp:=tmp+IntToStr(MonthOf(now));
tmp:=tmp+IntToStr(dayOf(now));
tmp:=tmp+IntToStr(HourOf(now));
tmp:=tmp+IntToStr(MinuteOf(now));
tmp:=tmp+IntToStr(SecondOf(now));
SQL.Add(tirnak+'c:\starbackup\'+userDB+ tmp + '.star'+tirnak);
SQL.Add('WITH NOINIT, NOUNLOAD, SKIP, STATS=1');
ExecSQL;
Result:='c:\starbackup\'+userDB+ tmp + '.star';
  end;
except
Result:='';
end;





end;

Function IsTable(TableName: String): Boolean;
Begin
 Result := False;
    Try
      dm.Qry1.Sql.Clear;
      dm.Qry1.Sql.Add('Select *');
      dm.Qry1.Sql.Add('From '+TableName);
      dm.Qry1.Open;
      Result := True;
    Except
     Result := False;
    End;
End;


Function  NumberTokurus(Number:String):String;
Var
    w,y,o,b:String;
    tmp, newNumber:String ;
    Hane,R01,R02,R03,R04,R05 :String;

    say,i  :integer;
begin
y:='';
o:='';
b:='';
//if copy(number,1,1)<>'0' then
//y:=yuzler(copy(number,i,1));


if copy(number,1,1)<>'0' then
o:=onlar(copy(number,1,1));
if copy(number,2,1)<>'0' then
b:=birler(copy(number,2,1));


NumberTokurus:=o+b;

end;




procedure ondateexit(Sender: TObject);

begin


  try

//  if  copy((sender as TDateEdit).Text,3,2)) in kdvaylar then

//pos  deyim ornek 3, gibi eger varsa kilitle 




  (sender as TDateEdit).Text:=copy((sender as TDateEdit).Text,0,length((sender as TDateEdit).Text)-1)+maliyil;
   FrmlokalKurlar.dtmtarih.Date:=StrToDate((sender as TDateEdit).Text);
   FrmlokalKurlar.dtmtarihChange(sender);
  except
 showmsgbox('Lütfen Geçerli Bir Tarih Giriþi Yapýnýz',2);
(sender as TDateEdit).SetFocus;


 end;

end;








Function hatalipath(str:string;kirim:Integer):Boolean;
var
i,n:Integer;
begin

{if kirim=0 then
n:=3
else
if kirim=1 then
n:=7
else
if kirim=2 then
n:=11
else
n:=16;}

//if (Length(str)<>n) then

if (kirim<>3) and  (kirim<>7) and (kirim<>11) and (kirim<>16) then
   begin
    Result:=true;
    showmsgbox('Hatalý HesapKodu',2);
    exit;
   end
 else
   begin

    for i:=1 to Length(str) do
      if (str[i] in ['0'..'9','.'])  then
      Result:=false
      else
      begin
        Result:=true;
        showmsgbox('Hatalý HesapKodu',2);
        exit;
      end;
  end;


end;

Function Hesapkimin(str:string):Boolean;
begin
 Result := False;
    Try
      dm.Qry1.Sql.Clear;
      dm.Qry1.Sql.Add('Select ID');
      dm.Qry1.Sql.Add('From hesap_plani'+maliyil);
      dm.Qry1.Sql.Add('where kimin = :kimin');
      dm.Qry1.Parameters.ParamByName('kimin').Value:=str;
      dm.Qry1.Open;
      Result := True;
    Except
     Result := False;
    End;


end;

procedure HesapOlustur(anahesap,alt1,alt2,alt3,adi,aciklama,parabirimi:String);
var
  tmp:string;
begin
try
tmp:='insert into Hesap_plani' + maliyil +
     ' (anahesap,alt1,alt2,alt3,path,adi,borc,alacak,aciklama,parabirimi,kirim,kimin,Aktif,Dborc,Dalacak) ' +
     'Values (:anahesap,:alt1,:alt2,:alt3,:path,:adi,:borc,:alacak,:aciklama,:parabirimi,:kirim,:kimin,:Aktif,:Dborc,:Dalacak) ' ;
if not dm.ado1.InTransaction then  dm.ADO1.BeginTrans ;
  with dm.Qry2 do
  begin
  close;
  SQL.Clear;
  SQL.Add(tmp);
  Parameters.ParamByName('anahesap').Value  :=anahesap;
  Parameters.ParamByName('alt1').Value      :=alt1;
  Parameters.ParamByName('alt2').Value      :=alt2;
  Parameters.ParamByName('alt3').Value      :=alt3;
  Parameters.ParamByName('path').Value      :=anahesap+'.'+ alt1+'.'+ alt2+'.' +alt3;
  Parameters.ParamByName('adi').Value       :=adi;
  Parameters.ParamByName('aciklama').Value  :=aciklama;
  Parameters.ParamByName('parabirimi').Value:=parabirimi;
  Parameters.ParamByName('kirim').Value     :=3;
  Parameters.ParamByName('borc').Value      :=0;
  Parameters.ParamByName('alacak').Value    :=0;
  Parameters.ParamByName('kimin').Value     :='-';
  Parameters.ParamByName('Aktif').Value     :='1';
  Parameters.ParamByName('Dborc').Value     :=0;
  Parameters.ParamByName('Dalacak').Value   :=0;
  Prepared;
  ExecSQL;
end;
    dm.Ado1.CommitTrans;
except
  dm.Ado1.RollbackTrans;
  msgbox(8,1);
end;
end;
//***
procedure AltHesapOlustur(path,alt3,adi,aciklama,parabirimi,kimin:String);
var
  tmp,actAnahesap,actAlt1,actAlt2:string;
begin
with dm.Qry1  do
begin
  close;
  SQL.Clear;
  SQL.Add('Select AnaHesap,Alt1,Alt2,Alt3 From hesap_plani'+maliyil+'  where Path=:bak ');
  Parameters.ParamByName('bak').Value :=path;
  Prepared;
  open;
  actAnahesap :=FieldValues['AnaHesap'];
  actAlt1     :=FieldValues['Alt1'];
  actAlt2     :=FieldValues['Alt2'];
end;
try
tmp:='insert into Hesap_plani' + maliyil +
     ' (anahesap,alt1,alt2,alt3,path,adi,borc,alacak,aciklama,parabirimi,kirim,kimin,Aktif,Dborc,Dalacak) ' +
     'Values (:anahesap,:alt1,:alt2,:alt3,:path,:adi,:borc,:alacak,:aciklama,:parabirimi,:kirim,:kimin,:Aktif,:Dborc,:Dalacak) ' ;
if not dm.ado1.InTransaction then  dm.ADO1.BeginTrans ;
  with dm.Qry2 do
  begin
  close;
  SQL.Clear;
  SQL.Add(tmp);
  Parameters.ParamByName('anahesap').Value  :=actAnahesap;
  Parameters.ParamByName('alt1').Value      :=actAlt1;
  Parameters.ParamByName('alt2').Value      :=actAlt2;
  Parameters.ParamByName('alt3').Value      :=alt3;
  Parameters.ParamByName('path').Value      :=actAnahesap+'.'+ actAlt1+'.'+ actAlt2+'.'+alt3;
  Parameters.ParamByName('adi').Value       :=adi;
  Parameters.ParamByName('aciklama').Value  :=aciklama;
  Parameters.ParamByName('parabirimi').Value:=parabirimi;
  Parameters.ParamByName('kirim').Value     :=3;
  Parameters.ParamByName('borc').Value      :=0;
  Parameters.ParamByName('alacak').Value    :=0;
  Parameters.ParamByName('kimin').Value     :=kimin;
  Parameters.ParamByName('Aktif').Value     :='1';
  Parameters.ParamByName('Dborc').Value     :=0;
  Parameters.ParamByName('Dalacak').Value   :=0;
  Prepared;
  ExecSQL;
end;
    dm.Ado1.CommitTrans;
except
  dm.Ado1.RollbackTrans;
  msgbox(8,1);
end;
end;
// ***
procedure HesapGuncelle(taraf,path,parabirimi:String;Miktar:Double );
begin
try
  if not dm.ado1.InTransaction then   dm.ADO1.BeginTrans ;
  with dm.Qry1 do
  begin
    Close;
    SQL.Clear ;
    SQL.Add('Update Hesap_plani' + maliyil +' Set Borc=Borc+:Borc,Alacak=Alacak+:Alacak,DBorc=DBorc+:DBorc,DAlacak=DAlacak+:DAlacak  ');
    SQL.Add('Where Path=:path ');
    Parameters.ParamByName('path').Value:=path;
    if (taraf='A') or (taraf='a') then
      begin
        Parameters.ParamByName('DAlacak').Value  :=Miktar;
        if mbp=ParaBirimi then
           Parameters.ParamByName('Alacak').Value:=Miktar
        else
           Parameters.ParamByName('Alacak').Value:=KurGetir(mbp,ParaBirimi ,'A')* miktar ;
        Parameters.ParamByName('Borc').Value     :=0;
        Parameters.ParamByName('DBorc').Value    :=0;
      end
    else
      begin
        Parameters.ParamByName('DBorc').Value  :=Miktar;
        if mbp=ParaBirimi then
           Parameters.ParamByName('Borc').Value:=Miktar
        else
           Parameters.ParamByName('Borc').Value:=KurGetir(mbp,ParaBirimi ,'A')* miktar ;
        Parameters.ParamByName('Alacak').Value :=0;
        Parameters.ParamByName('DAlacak').Value:=0;
      end;
    ExecSQL ;
  end;
    dm.Ado1.CommitTrans;
except
  dm.Ado1.RollbackTrans;
  msgbox(8,0);
end;
end;
// ***

function FisNoBul(FisTur:string):String ;
var
yil,ay,gun:string;
begin
//tarihsaatAyarla(dm.Qry2);



dm.qry1.Close;
dm.qry1.SQL.Clear;
dm.qry1.SQL.Add('select  getdate() as date') ;
dm.qry1.open;

yil:=IntToStr(YearOf(dm.qry1.FieldByName('date').AsDateTime ));
ay:=IntToStr(monthof(dm.qry1.FieldByName('date').AsDateTime));
gun:=IntToStr(dayof(dm.qry1.FieldByName('date').AsDateTime));




with dm.Qry2 do
  begin
    close;
    SQL.Clear;
    SQL.Add('select max(lastno)as fisno from fisbilgi'+ maliyil+' where FisTur =:FisTur  ') ;
    SQL.Add('and year(tarih) = year(getdate()) '   );
    SQL.Add('and month(tarih) = month(getdate()) ' );
    SQL.Add('and day(tarih) = day(getdate())  ');
    Parameters.ParamByName('FisTur').Value :=FisTur;
    open;
    if varisnull(FieldValues['fisno']) then
      Result:= FisTur +
               Rightstr('00'+yil,2)+
               Rightstr('00'+ay,2)+
               Rightstr('00'+gun,2) + '0001'
    else
      Result:= FisTur +
               Rightstr('00'+yil,2)+
               Rightstr('00'+ay,2)+
               Rightstr('00'+gun,2) +
               RightStr('0000'+inttostr(FieldValues['fisno']+1),4);
end;
end;
//
procedure HesapExtreyeKayit(Taraf,HesapKod,Belgeno,aciklama,islem,ParaBirimi,islemTarih,ISPara:string;Miktar:Double);
var
  HesapPBMiktar,MuhPBMiktar:Double ;
  Mborc,DBorc,Malacak,Dalacak:Double ;

begin
  HesapPBMiktar :=RoundTo( KurGetir(isPara,ParaBirimi,'A')* Miktar,-2);
  MuhPBMiktar   :=RoundTo(KurGetir(isPara,mbp,'A') * Miktar,-2);
  try
    if not dm.ado1.InTransaction then   dm.ADO1.BeginTrans ;
    with dm.Qry1 do
    begin
      Close;
      SQL.Clear ;
      SQL.Add('insert into Hesapextre'+ maliyil +' (HesapKodu,tarih,islemtarih,Aciklama,belgeno,borc,alacak,Dborc,Dalacak,islem,kur,operator) ' );
      SQL.Add('  values (:HesapKodu,getdate(),:islemtarih,:Aciklama,:belgeno,:borc,:alacak,:Dborc,:Dalacak,:islem,:kur,:operator)');
      Parameters.ParamByName('HesapKodu').Value  :=HesapKod ;
//      Parameters.ParamByName('tarih').Value     :=date;
      Parameters.ParamByName('islemtarih').Value:=islemTarih;
      Parameters.ParamByName('Aciklama').Value  :=aciklama;
      Parameters.ParamByName('belgeno').Value   :=BelgeNo;
      Parameters.ParamByName('islem').Value     :=islem ;        // MS TS TD
      Parameters.ParamByName('kur').Value       :=KurGetir(mbp,ParaBirimi ,'A');
      Parameters.ParamByName('operator').Value  :=Kullanici;
      if (taraf='A') or (taraf='a') then
      begin
        Parameters.ParamByName('DAlacak').Value := HesapPBMiktar;
        Parameters.ParamByName('Alacak').Value  :=MuhPBMiktar;
        Parameters.ParamByName('borc').Value    :=0;
        Parameters.ParamByName('Dborc').Value   :=0;
Mborc:=0;
DBorc:=0;
Malacak:=RoundTo(MuhPBMiktar,-2);
Dalacak:=RoundTo(HesapPBMiktar,-2);
     end
      else
      begin
        Parameters.ParamByName('DBorc').Value  :=RoundTo(HesapPBMiktar,-2);
        Parameters.ParamByName('Borc').Value   :=RoundTo(MuhPBMiktar,-2);
        Parameters.ParamByName('alacak').Value :=0;
        Parameters.ParamByName('DAlacak').Value:=0;
        Mborc:=RoundTo(MuhPBMiktar,-2);
        DBorc:=RoundTo(HesapPBMiktar,-2);
        Malacak:=0;
        Dalacak:=0;
      end;
      Prepared;
      ExecSQL;
          close;
          SQL.Clear;
          SQL.Add('update Hesap_plani'+maliyil+' set borc=borc + :borc,Dborc=Dborc + :Dborc,alacak=alacak + :alacak,Dalacak=Dalacak + :Dalacak where path = :path');
          Parameters.ParamByName('borc').Value:=Mborc;
          Parameters.ParamByName('Dborc').Value:=DBorc;
          Parameters.ParamByName('alacak').Value:=Malacak;
          Parameters.ParamByName('Dalacak').Value:=Dalacak;
          Parameters.ParamByName('path').Value:=HesapKod;
          Prepared;
          ExecSQL;
  end;


  dm.Ado1.CommitTrans;
  except
  dm.Ado1.RollbackTrans;
  msgbox(8,0);
end;end ;




/////////**************////////
procedure HesapExtreyeKayitPB(Taraf,HesapKod,Belgeno,aciklama,islem,ParaBirimi,islemTarih,ISPara,Ktipi:string;Miktar:Double);
var
  HesapPBMiktar,MuhPBMiktar:Double ;
  Mborc,DBorc,Malacak,Dalacak:Double ;

begin
  HesapPBMiktar :=RoundTo( KurGetir(isPara,ParaBirimi,Ktipi)* Miktar,-2);
  MuhPBMiktar   :=RoundTo(KurGetir(isPara,mbp,Ktipi) * Miktar,-2);
  try
    if not dm.ado1.InTransaction then   dm.ADO1.BeginTrans ;
    with dm.Qry1 do
    begin
      Close;
      SQL.Clear ;
      SQL.Add('insert into Hesapextre'+ maliyil +' (HesapKodu,tarih,islemtarih,Aciklama,belgeno,borc,alacak,Dborc,Dalacak,islem,kur,operator) ' );
      SQL.Add('  values (:HesapKodu,getdate(),:islemtarih,:Aciklama,:belgeno,:borc,:alacak,:Dborc,:Dalacak,:islem,:kur,:operator)');
      Parameters.ParamByName('HesapKodu').Value  :=HesapKod ;
//    Parameters.ParamByName('tarih').Value     :=date;
      Parameters.ParamByName('islemtarih').Value:=islemTarih;
      Parameters.ParamByName('Aciklama').Value  :=aciklama;
      Parameters.ParamByName('belgeno').Value   :=BelgeNo;
      Parameters.ParamByName('islem').Value     :=islem ;        // MS TS TD
      Parameters.ParamByName('kur').Value       :=KurGetir(mbp,ParaBirimi ,Ktipi);
      Parameters.ParamByName('operator').Value  :=Kullanici;
      if (taraf='A') or (taraf='a') then
      begin
        Parameters.ParamByName('DAlacak').Value := HesapPBMiktar;
        Parameters.ParamByName('Alacak').Value  :=MuhPBMiktar;
        Parameters.ParamByName('borc').Value    :=0;
        Parameters.ParamByName('Dborc').Value   :=0;
Mborc:=0;
DBorc:=0;
Malacak:=RoundTo(MuhPBMiktar,-2);
Dalacak:=RoundTo(HesapPBMiktar,-2);
     end
      else
      begin
        Parameters.ParamByName('DBorc').Value  :=RoundTo(HesapPBMiktar,-2);
        Parameters.ParamByName('Borc').Value   :=RoundTo(MuhPBMiktar,-2);
        Parameters.ParamByName('alacak').Value :=0;
        Parameters.ParamByName('DAlacak').Value:=0;
        Mborc:=RoundTo(MuhPBMiktar,-2);
        DBorc:=RoundTo(HesapPBMiktar,-2);
        Malacak:=0;
        Dalacak:=0;
      end;
      Prepared;
      ExecSQL;
          close;
          SQL.Clear;
          SQL.Add('update Hesap_plani'+maliyil+' set borc=borc + :borc,Dborc=Dborc + :Dborc,alacak=alacak + :alacak,Dalacak=Dalacak + :Dalacak where path = :path');
          Parameters.ParamByName('borc').Value:=Mborc;
          Parameters.ParamByName('Dborc').Value:=DBorc;
          Parameters.ParamByName('alacak').Value:=Malacak;
          Parameters.ParamByName('Dalacak').Value:=Dalacak;
          Parameters.ParamByName('path').Value:=HesapKod;
          Prepared;
          ExecSQL;
  end;


  dm.Ado1.CommitTrans;
  except
  dm.Ado1.RollbackTrans;
  msgbox(8,0);
end;end ;
//////////***************///////////////



// ***
function FisYarat(rowsay:Integer; FisTur,FisYer,islemTarihi:String;bilgi:array of fisString ;isPara:String):String ;
var
FisNo:String;
AToplam,BToplam,Malacak,Mborc,Dborc,Dalacak :Double;
HPBAlacak ,HPBBorc,MPBAlacak ,MPBBorc ,Miktar1,m2,Miktar2:Double;
i:Integer;
begin
FisNo :=FisNoBul(FisTur);
Result :=FisNo;
AToplam :=0;
BToplam :=0;
for  i:=1  to rowsay  do
begin
  if (bilgi[i].BorcAlacak ='A') or (bilgi[i].BorcAlacak ='a') then
     begin
         AToplam:=AToplam + RoundTo(KurGetir(isPara,mbp,'A')*bilgi[i].Miktar,-2);
    end
  else
     begin
         BToplam:=BToplam +RoundTo( KurGetir(isPara,mbp,'A')*bilgi[i].Miktar,-2);
     end;
end;
// *** Fiþ Bilgi Kayýt
AToplam:=RoundTo(AToplam,-2);
AToplam:=RoundTo(BToplam,-2);


try
  if not dm.ado1.InTransaction then   dm.ADO1.BeginTrans ;
  with dm.Qry1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into fisbilgi'+ maliyil + ' (fisno,tarih,fistur,fisyeri,toplamborc,toplamalacak,islemtarihi,kullanici,lastno)');
    SQL.Add(' values (:fisno,GetDate(),:fistur,:fisyeri,:toplamborc,:toplamalacak,:islemtarihi,:kullanici,:lastno)');
    Parameters.ParamByName('fisno').Value       :=FisNo;
    Parameters.ParamByName('fistur').Value      :=FisTur;
    Parameters.ParamByName('fisyeri').Value     :=FisYer;
    Parameters.ParamByName('toplamborc').Value  :=BToplam;
    Parameters.ParamByName('toplamalacak').Value:=AToplam  ;
    Parameters.ParamByName('islemtarihi').Value :=islemTarihi ;
    Parameters.ParamByName('kullanici').Value   :=Kullanici;
    Parameters.ParamByName('lastno').Value      :=StrToInt(RightStr(FisNo,4)) ;
    ExecSQL;
  end;
    dm.Ado1.CommitTrans;
except
  dm.Ado1.RollbackTrans;
  msgbox(8,0);
end;
// **** Extre Kayýt;
for i :=1  to rowsay  do
begin
                                 // 1 $ ? TL
            Miktar1 :=RoundTo( KurGetir(isPara,bilgi[i].ParaBirimi,'A')*bilgi[i].Miktar,-2);
            Miktar2 :=RoundTo(KurGetir(isPara,mbp,'A')*bilgi[i].Miktar,-2);

    if (bilgi[i].BorcAlacak ='A') or (bilgi[i].BorcAlacak ='a') then
    begin
 MPBAlacak :=Miktar2;     HPBAlacak :=Miktar1;       HPBBorc   := 0 ;     MPBBorc   :=0 ;
  end
    else
    begin
      HPBBorc   :=Miktar1;  MPBAlacak :=0;       MPBBorc   :=Miktar2 ;      HPBAlacak :=0;
    end ;
try
  if not dm.ado1.InTransaction then   dm.ADO1.BeginTrans ;
  with dm.Qry1 do
  begin
    Close;
    SQL.Clear ;
    SQL.Add('insert into fisextre'+ maliyil + ' (FisId,Hesapkod,parabirimi,Aciklama,Belgeno,Islemtur,Hpbborc,Hpbalacak,Mpbborc,Mpbalacak,Kur)');
    SQL.Add(' values (:FisId,:Hesapkod,:parabirimi,:Aciklama,:Belgeno,:Islemtur,:Hpbborc,:Hpbalacak,:Mpbborc,:Mpbalacak,:Kur)');
    Parameters.ParamByName('FisId').Value     :=FisNo;
    Parameters.ParamByName('Hesapkod').Value  :=bilgi[i].Hesapkodu ;
    Parameters.ParamByName('parabirimi').Value:=bilgi[i].ParaBirimi ;
    Parameters.ParamByName('Aciklama').Value  :=bilgi[i].Aciklama ;
    Parameters.ParamByName('Belgeno').Value   :=bilgi[i].BelgeNo ;
    Parameters.ParamByName('Islemtur').Value  :=FisTur ;
    Parameters.ParamByName('HPBBorc').Value   :=RoundTo(HPBBorc,-2) ;
    Parameters.ParamByName('HPBAlacak').Value :=RoundTo(HPBAlacak,-2);
    Parameters.ParamByName('MPBBorc').Value   :=RoundTo(MPBBorc,-2);
    Parameters.ParamByName('MPBAlacak').Value :=RoundTo(MPBAlacak,-2);
    if  Mbp<>bilgi[i].ParaBirimi then
      Parameters.ParamByName('Kur').Value :=KurGetir(Mbp,bilgi[i].ParaBirimi,'A')
    else
      Parameters.ParamByName('Kur').Value :='1';
    Prepared;
    ExecSQL;
  end;
    dm.Ado1.CommitTrans;
except
  dm.Ado1.RollbackTrans;
  msgbox(8,0);

    end;
end;
end;
///////***************/

function FisYaratPB(rowsay:Integer; FisTur,FisYer,islemTarihi:String;bilgi:array of fisString ;isPara,Ktipi:String):String ;
var
FisNo:String;
AToplam,BToplam,Malacak,Mborc,Dborc,Dalacak :Double;
HPBAlacak ,HPBBorc,MPBAlacak ,MPBBorc ,Miktar1,m2,Miktar2:Double;
i:Integer;
begin
FisNo :=FisNoBul(FisTur);
Result :=FisNo;
AToplam :=0;
BToplam :=0;
for  i:=1  to rowsay  do
begin
  if (bilgi[i].BorcAlacak ='A') or (bilgi[i].BorcAlacak ='a') then
     begin
         AToplam:=AToplam + RoundTo(KurGetir(isPara,mbp,Ktipi)*bilgi[i].Miktar,-2);
    end
  else
     begin
         BToplam:=BToplam +RoundTo( KurGetir(isPara,mbp,Ktipi)*bilgi[i].Miktar,-2);
     end;
end;
// *** Fiþ Bilgi Kayýt
AToplam:=RoundTo(AToplam,-2);
AToplam:=RoundTo(BToplam,-2);


try
  if not dm.ado1.InTransaction then   dm.ADO1.BeginTrans ;
  with dm.Qry1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into fisbilgi'+ maliyil + ' (fisno,tarih,fistur,fisyeri,toplamborc,toplamalacak,islemtarihi,kullanici,lastno)');
    SQL.Add(' values (:fisno,GetDate(),:fistur,:fisyeri,:toplamborc,:toplamalacak,:islemtarihi,:kullanici,:lastno)');
    Parameters.ParamByName('fisno').Value       :=FisNo;
    Parameters.ParamByName('fistur').Value      :=FisTur;
    Parameters.ParamByName('fisyeri').Value     :=FisYer;
    Parameters.ParamByName('toplamborc').Value  :=BToplam;
    Parameters.ParamByName('toplamalacak').Value:=AToplam  ;
    Parameters.ParamByName('islemtarihi').Value :=islemTarihi ;
    Parameters.ParamByName('kullanici').Value   :=Kullanici;
    Parameters.ParamByName('lastno').Value      :=StrToInt(RightStr(FisNo,4)) ;
    ExecSQL;
  end;
    dm.Ado1.CommitTrans;
except
  dm.Ado1.RollbackTrans;
  msgbox(8,0);
end;
// **** Extre Kayýt;
for i :=1  to rowsay  do
begin
                                 // 1 $ ? TL
            Miktar1 :=RoundTo( KurGetir(isPara,bilgi[i].ParaBirimi,Ktipi)*bilgi[i].Miktar,-2);
            Miktar2 :=RoundTo(KurGetir(isPara,mbp,Ktipi)*bilgi[i].Miktar,-2);

    if (bilgi[i].BorcAlacak ='A') or (bilgi[i].BorcAlacak ='a') then
    begin
 MPBAlacak :=Miktar2;     HPBAlacak :=Miktar1;       HPBBorc   := 0 ;     MPBBorc   :=0 ;
  end
    else
    begin
      HPBBorc   :=Miktar1;  MPBAlacak :=0;       MPBBorc   :=Miktar2 ;      HPBAlacak :=0;
    end ;
try
  if not dm.ado1.InTransaction then   dm.ADO1.BeginTrans ;
  with dm.Qry1 do
  begin
    Close;
    SQL.Clear ;
    SQL.Add('insert into fisextre'+ maliyil + ' (FisId,Hesapkod,parabirimi,Aciklama,Belgeno,Islemtur,Hpbborc,Hpbalacak,Mpbborc,Mpbalacak,Kur)');
    SQL.Add(' values (:FisId,:Hesapkod,:parabirimi,:Aciklama,:Belgeno,:Islemtur,:Hpbborc,:Hpbalacak,:Mpbborc,:Mpbalacak,:Kur)');
    Parameters.ParamByName('FisId').Value     :=FisNo;
    Parameters.ParamByName('Hesapkod').Value  :=bilgi[i].Hesapkodu ;
    Parameters.ParamByName('parabirimi').Value:=bilgi[i].ParaBirimi ;
    Parameters.ParamByName('Aciklama').Value  :=bilgi[i].Aciklama ;
    Parameters.ParamByName('Belgeno').Value   :=bilgi[i].BelgeNo ;
    Parameters.ParamByName('Islemtur').Value  :=FisTur ;
    Parameters.ParamByName('HPBBorc').Value   :=RoundTo(HPBBorc,-2) ;
    Parameters.ParamByName('HPBAlacak').Value :=RoundTo(HPBAlacak,-2);
    Parameters.ParamByName('MPBBorc').Value   :=RoundTo(MPBBorc,-2);
    Parameters.ParamByName('MPBAlacak').Value :=RoundTo(MPBAlacak,-2);
    if  Mbp<>bilgi[i].ParaBirimi then
      Parameters.ParamByName('Kur').Value :=KurGetir(Mbp,bilgi[i].ParaBirimi,Ktipi)
    else
      Parameters.ParamByName('Kur').Value :='1';
    Prepared;
    ExecSQL;
  end;
    dm.Ado1.CommitTrans;
except
  dm.Ado1.RollbackTrans;
  msgbox(8,0);

    end;
end;
end;


//////////////////*******















function  XKodKontrol(fForm : Tform ; TabloAdi:string ; FieldAdi:string ; Kelime:string ; MsgTmp : boolean):integer;
var TmpSql:string;
begin

TmpSql := 'select * from ' + TabloAdi + ' WHERE   ' + FieldAdi + ' = ''' + Kelime + '''  ';

{
TmpSql := 'select * from ' + TabloAdi + ' WHERE  ' ;
TmpSql := ' + FieldAdi + ' = ''' + Kelime + '''  ';
 }


//showmsgbox(TmpSql);
    Dm.Qry1.Close;
    Dm.Qry1.SQL.Clear;
    Dm.Qry1.SQL.Add(TmpSql);
    Dm.Qry1.Open;

if  Dm.Qry1.RecordCount <> 0 then
    begin
      result:=1;
      if MsgTmp = True then   showmsgbox('Kayýt Mevcut... ',2);
    end
else
  begin
  if MsgTmp = True then  showmsgbox('Kayýt Mevcut Deðil... ',2);
  end;


end;


function parabirimibul(hesap:string):string;
var
Qryx:TADOQuery;
  begin

  Qryx:=TADOQuery.Create(nil);
Qryx.Connection:=dm.ado1;

 with Qryx do
   begin
    Close;
    SQL.Clear;
    SQL.Add('select parabirimi from hesap_plani'+maliyil +' where  path = :path');
    Parameters.ParamByName('path').Value:=hesap;
    Open;

    if Recordcount>0 then
    Result:= FieldByName('parabirimi').AsString;

    free;
   end;



  end;





function Fisextrekayit(rowsay:Integer; FisTur,FisYer,islemTarihi:String;bilgi:array of fisString ;isPara,FisNo:String):String ;
var

AToplam,BToplam,Malacak,Mborc,Dborc,Dalacak :Double;
HPBAlacak ,HPBBorc,MPBAlacak ,MPBBorc ,Miktar1,m2,Miktar2:Double;
i:Integer;
begin
//:=FisNoBul(FisTur);
Result :=FisNo;
{AToplam :=0;
BToplam :=0;
for  i:=1  to rowsay  do
begin
  if (bilgi[i].BorcAlacak ='A') or (bilgi[i].BorcAlacak ='a') then
     begin
         AToplam:=AToplam + RoundTo(KurGetir(isPara,mbp,'A')*bilgi[i].Miktar,-2);
    end
  else
     begin
         BToplam:=BToplam +RoundTo( KurGetir(isPara,mbp,'A')*bilgi[i].Miktar,-2);
     end;
end;
// *** Fiþ Bilgi Kayýt
AToplam:=RoundTo(AToplam,-2);
AToplam:=RoundTo(BToplam,-2);


try
  if not dm.ado1.InTransaction then   dm.ADO1.BeginTrans ;
  with dm.Qry1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into fisbilgi'+ maliyil + ' (fisno,tarih,fistur,fisyeri,toplamborc,toplamalacak,islemtarihi,kullanici,lastno)');
    SQL.Add(' values (:fisno,GetDate(),:fistur,:fisyeri,:toplamborc,:toplamalacak,:islemtarihi,:kullanici,:lastno)');
    Parameters.ParamByName('fisno').Value       :=FisNo;
    Parameters.ParamByName('fistur').Value      :=FisTur;
    Parameters.ParamByName('fisyeri').Value     :=FisYer;
    Parameters.ParamByName('toplamborc').Value  :=BToplam;
    Parameters.ParamByName('toplamalacak').Value:=AToplam  ;
    Parameters.ParamByName('islemtarihi').Value :=islemTarihi ;
    Parameters.ParamByName('kullanici').Value   :=Kullanici;
    Parameters.ParamByName('lastno').Value      :=StrToInt(RightStr(FisNo,4)) ;
    ExecSQL;
  end;
    dm.Ado1.CommitTrans;
except
  dm.Ado1.RollbackTrans;
  msgbox(8,0);
end;}
// **** Extre Kayýt;
for i :=1  to rowsay  do
begin
                                 // 1 $ ? TL
            Miktar1 :=RoundTo( KurGetir(isPara,bilgi[i].ParaBirimi,'A')*bilgi[i].Miktar,-2);
            Miktar2 :=RoundTo(KurGetir(isPara,mbp,'A')*bilgi[i].Miktar,-2);

    if (bilgi[i].BorcAlacak ='A') or (bilgi[i].BorcAlacak ='a') then
    begin
 MPBAlacak :=Miktar2;     HPBAlacak :=Miktar1;       HPBBorc   := 0 ;     MPBBorc   :=0 ;
  end
    else
    begin
      HPBBorc   :=Miktar1;  MPBAlacak :=0;       MPBBorc   :=Miktar2 ;      HPBAlacak :=0;
    end ;
try
  if not dm.ado1.InTransaction then   dm.ADO1.BeginTrans ;
  with dm.Qry1 do
  begin
    Close;
    SQL.Clear ;
    SQL.Add('insert into fisextre'+ maliyil + ' (FisId,Hesapkod,parabirimi,Aciklama,Belgeno,Islemtur,Hpbborc,Hpbalacak,Mpbborc,Mpbalacak,Kur)');
    SQL.Add(' values (:FisId,:Hesapkod,:parabirimi,:Aciklama,:Belgeno,:Islemtur,:Hpbborc,:Hpbalacak,:Mpbborc,:Mpbalacak,:Kur)');
    Parameters.ParamByName('FisId').Value     :=FisNo;
    Parameters.ParamByName('Hesapkod').Value  :=bilgi[i].Hesapkodu ;
    Parameters.ParamByName('parabirimi').Value:=bilgi[i].ParaBirimi ;
    Parameters.ParamByName('Aciklama').Value  :=bilgi[i].Aciklama ;
    Parameters.ParamByName('Belgeno').Value   :=bilgi[i].BelgeNo ;
    Parameters.ParamByName('Islemtur').Value  :=FisTur ;
    Parameters.ParamByName('HPBBorc').Value   :=RoundTo(HPBBorc,-2) ;
    Parameters.ParamByName('HPBAlacak').Value :=RoundTo(HPBAlacak,-2);
    Parameters.ParamByName('MPBBorc').Value   :=RoundTo(MPBBorc,-2);
    Parameters.ParamByName('MPBAlacak').Value :=RoundTo(MPBAlacak,-2);
    if  Mbp<>bilgi[i].ParaBirimi then
      Parameters.ParamByName('Kur').Value :=KurGetir(Mbp,bilgi[i].ParaBirimi,'A')
    else
      Parameters.ParamByName('Kur').Value :='1';
    Prepared;
    ExecSQL;
  end;
    dm.Ado1.CommitTrans;
except
  dm.Ado1.RollbackTrans;
  msgbox(8,0);

    end;
end;
end;




function FisextrekayitPB(rowsay:Integer; FisTur,FisYer,islemTarihi:String;bilgi:array of fisString ;isPara,FisNo,Ktipi:String):String ;
var

AToplam,BToplam,Malacak,Mborc,Dborc,Dalacak :Double;
HPBAlacak ,HPBBorc,MPBAlacak ,MPBBorc ,Miktar1,m2,Miktar2:Double;
i:Integer;
begin

Result :=FisNo;

for i :=1  to rowsay  do
begin
                                 // 1 $ ? TL
            Miktar1 :=RoundTo( KurGetir(isPara,bilgi[i].ParaBirimi,Ktipi)*bilgi[i].Miktar,-2);
            Miktar2 :=RoundTo(KurGetir(isPara,mbp,Ktipi)*bilgi[i].Miktar,-2);

    if (bilgi[i].BorcAlacak ='A') or (bilgi[i].BorcAlacak ='a') then
    begin
 MPBAlacak :=Miktar2;     HPBAlacak :=Miktar1;       HPBBorc   := 0 ;     MPBBorc   :=0 ;
  end
    else
    begin
      HPBBorc   :=Miktar1;  MPBAlacak :=0;       MPBBorc   :=Miktar2 ;      HPBAlacak :=0;
    end ;
try
  if not dm.ado1.InTransaction then   dm.ADO1.BeginTrans ;
  with dm.Qry1 do
  begin
    Close;
    SQL.Clear ;
    SQL.Add('insert into fisextre'+ maliyil + ' (FisId,Hesapkod,parabirimi,Aciklama,Belgeno,Islemtur,Hpbborc,Hpbalacak,Mpbborc,Mpbalacak,Kur)');
    SQL.Add(' values (:FisId,:Hesapkod,:parabirimi,:Aciklama,:Belgeno,:Islemtur,:Hpbborc,:Hpbalacak,:Mpbborc,:Mpbalacak,:Kur)');
    Parameters.ParamByName('FisId').Value     :=FisNo;
    Parameters.ParamByName('Hesapkod').Value  :=bilgi[i].Hesapkodu ;
    Parameters.ParamByName('parabirimi').Value:=bilgi[i].ParaBirimi ;
    Parameters.ParamByName('Aciklama').Value  :=bilgi[i].Aciklama ;
    Parameters.ParamByName('Belgeno').Value   :=bilgi[i].BelgeNo ;
    Parameters.ParamByName('Islemtur').Value  :=FisTur ;
    Parameters.ParamByName('HPBBorc').Value   :=RoundTo(HPBBorc,-2) ;
    Parameters.ParamByName('HPBAlacak').Value :=RoundTo(HPBAlacak,-2);
    Parameters.ParamByName('MPBBorc').Value   :=RoundTo(MPBBorc,-2);
    Parameters.ParamByName('MPBAlacak').Value :=RoundTo(MPBAlacak,-2);
    if  Mbp<>bilgi[i].ParaBirimi then
      Parameters.ParamByName('Kur').Value :=KurGetir(Mbp,bilgi[i].ParaBirimi,Ktipi)
    else
      Parameters.ParamByName('Kur').Value :='1';
    Prepared;
    ExecSQL;
  end;
    dm.Ado1.CommitTrans;
except
  dm.Ado1.RollbackTrans;
  msgbox(8,0);

    end;
end;
end;
// ***
procedure sirketbilgilerial();
var
i:integer;
begin
TmpFooterSize:=100;


tarihsaatAyarla(dm.Qry1);

     with dm.Qry1  do
          begin
          close;
          SQL.Clear;
          SQL.Add('SET DATEFORMAT ''dmy'' ');
          ExecSQL;






          close;
          SQL.Clear;
          SQL.Add('select * from sirket') ;
          open;

//    self.Color:=FieldValues['renk'];
//    SirketID:=FieldValues['sirketkod'];
//    self.lblcaption.Caption:=FieldValues['Isyerininadi'];

  TmpSirketSicilNo :=  fieldbyname('SicilNumarasi').asstring ;
  TmpKayitIsmi     :=  fieldbyname('KayitIsmi').asstring ;
  TmpAdres         :=  fieldbyname('Adres').asstring ;
  TmpTelefon       :=  fieldbyname('Telefon').asstring ;
  TmpIsYerininAdi  :=  fieldbyname('IsYerininAdi').asstring ;
  TmpKayitNo       :=  fieldbyname('KayitNo').asstring ;
  TmpStatu         :=  fieldbyname('Statu').asstring ;
  TmpSSNo          :=  fieldbyname('SSNO').asstring ;
  Tmpfax           :=  fieldbyname('fax').asstring ;
  Tmpfaaliyetturu:=  fieldbyname('faaliyetturu').asstring;
  TmpsirketEmail:=   fieldbyname('email').asstring;
      sirketrenk:=   fieldbyname('renk').AsInteger;



//    Resimal(BtnLogo.Glyph,'logo','select * from sirket',dm.Qry2);

        close;
        SQL.Clear;
        SQL.Add('select max(yil)as yil from yil');
        open;
      maliyil:= FieldByName('yil').AsString;

        TmpArsivGlobal := maliyil;


      dm.Qry1.Close;
      dm.Qry1.sql.Clear;
      dm.Qry1.sql.add ('select ay from kdvbeyan where  yil= '+maliyil);
      dm.Qry1.open;

    for i:=0 to dm.Qry1.RecordCount-1 do
    begin
    kdvaylar:=kdvaylar+dm.Qry1.FieldByName('ay').AsString+',' ;
    end;

    kdvaylar:=copy(kdvaylar,1,length(kdvaylar)-1);




          close;
          SQL.Clear;
          SQL.Add('select * from maillist') ;
          open;


         mailhost :=  fieldbyname('host').asstring ;
         mailpassword :=  fieldbyname('password').asstring ;
         mailuser :=  fieldbyname('email').asstring ;



     end;


end;


end.

