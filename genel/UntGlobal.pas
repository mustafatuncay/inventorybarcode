unit UntGlobal;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin,
  Mask, Db, DBClient, DBTables, ADODB,shellapi,QuickRpt,QRCtrls,
  Jpeg,AdvGrid,ComObj,registry,winsock,Variants, BaseGrid, DBAdvGrd,printers, asgprint, asgprev ,
  Menus,AdvToolBar;

type
  FisString = record
  BorcAlacak :String;
  Hesapkodu:String;
  BelgeNo:String;
  Aciklama:String;
  ParaBirimi:String;
  Miktar:Double;
end;
type
  Belgeler = record
  Tur :String;
  BelgeNo:String;
  Tutar:Double;
  Odeme:Double;
  RecID:String;
end;

type
  HExtre = record
  BA,HesapKod,HesapAdi,PBirimi:String;
  Tarih,BelgeNo,Aciklama      :String;
  HMiktar,MMiktar,Kur         :Double;
end;

type
  HakString = record
  Yonetici:Boolean;
  Gorme   :Boolean;
  Kayit   :Boolean;
  Degistir:Boolean;
  Sil     :Boolean;
  Yazdir  :Boolean;
end;
// ************************************************
function  sayilaravirgul(s:string) : String;
Function  ConvertString(actStr:String):String ;
Function  NumberToText(actNumber:String):String;
Function  onlar(x : String) : String ;
Function  yuzler(x : String) : String ;
Function  birler(x : String) : String ;
Function  NumberTokurus(Number:String):String;
function  GetLastNumber(LookUp:Integer):String ;
procedure UpdateLastNumber(LookUp:Integer; OldValue:String);
function  DMiktarKontrol(StokKod,DepoNo:String;miktar:Double):Boolean ;
procedure StokHareketi(StockCode,OpDate,OpNumber,OpDefinition,OpType,DepoID:String;HareketTur:Integer;Miktar:Double);
procedure StokHareketiSil(RecIDNo,StockCode,DepoID:String;EskiMiktar:Double;HareketTur:integer);// *** Add in 08.05.2005 for KOB� 2005
procedure GelirGiderKaydet(Tur,CekTip,HesapKod,Tarih,BelgeNo,Aciklama,BHesapNo,ProgCode:String;Banka:Boolean;Miktar:Double);
procedure GelirGiderSil(ActRecID,Tur:String;Banka:Boolean);
procedure BankaHareketKayit(Tur,Tip,BHesapNo,Tarih,BelgeNo,Aciklama,ProgCode:String;Miktar:Double);
procedure BankaHareketSil(actRecID,Tur,BHesapNo:String);
procedure CariHareketKayit(HareketTur,CariKod,OpType,OpDate,OpNumber,OpDefinition:String;Miktar:Double);
procedure CariHareketSil(actID:Integer);
procedure StokCikisSil(StockCode,OpType,OpNumber,DepoID:String);
procedure MalSatisSil(CariKod,InvoiceNumber,BelgeTuru:String;EskiMiktar:Double);
function  HataliBelgeNo(CariKod,FisTuru,BelgeNo:String):Boolean ;
function  SayiYapar(TmpTxt:string):Double;
Procedure AdvStrYazdir(FormAdi:TForm;TmpGrid:TAdvStringGrid;Islem:String;Sayfa:String);
Procedure AdvDBYazdir(FormAdi:TForm;TmpGrid:TDBAdvStringGrid;Islem:String;Sayfa:String);
Procedure AdvDBExceleAktar(FormAdi:TForm;Grid:TDBAdvStringGrid);
Procedure AdvStrExceleAktar(FormAdi:TForm;Grid:TAdvStringGrid);
Procedure GiderKaydet(HBGuncelle,HesapKod,Tarih,BelgeNo,Aciklama,BHesapNo,CekNo,ProgCode:String;Miktar:Double);
Procedure MsgUyari(Mesaj:String);
Function  MsgOnay(Mesaj:String):Boolean;
function  AutoBelgeNo():String;
function  Kur(Tip:String;Tarih:TDate;Sembol:string):String;
function  HareketKayit(CariKod,Tarih,BelgeNo,Aciklama,FisTuru,Kullanici:String;FTBorc,FTAlacak:Double;HEBilgi:array of HExtre; HSay:Integer):String;
function  Decrypt(Text : string; Key1, Key2, Key3, Key4 : Integer) : string;
function  Encrypt(Text : string; Key1, Key2, Key3, Key4 : Integer) : string;
procedure SayisalGoruntu(TmpQry:TADOQuery);
procedure LocalUrunGiris(StokKod,Tur,Tarih,BelgeNo,Aciklama,DepoNo:string;Miktar,Maliyet:Double);

procedure LocalUrunCikis(StokKod,Tur,Tarih,BelgeNo,Aciklama,DepoNo:string;Miktar:Double);
procedure KullaniciHaklari(FormTagNo:integer; TlBar:TAdvToolBar);
function crypto(s:string):string;


// ***** Genel Tan�mlamalar **************
var
Hakbilgi:array of HakString;
Fisbilgi  :array of fisString;
BelgeBilgi:array of Belgeler;
HesapExtre:array of HExtre;
ProCaption  :String;
maliyil:String;
GridFooter:Integer;
TmpKayitIsmi:String;
path:String;
ActPerNo      :String;
ActYonetici : Boolean;
ActSirket : String ;
ActKullanici :String ;
ActForm : Boolean; 
// ***************************************
implementation

uses DateUtils, UntDm, Math, UntOnay,StrUtils,UntUyari;



function crypto(s:string):string;
 var key:string; i:integer; c1,c2:integer;
 begin
  key:='Wxz19Shg13ykb2dSpX';
  result:='';
  for i:=1 to length(s) do
   begin
     c1:=ord(copy(s,i,1)[1]);
     c2:=ord(copy(key,(i mod length(key)+1),1)[1]);
     result:=result+chr(c1 Xor c2);
   end;
 end;

function sayilaravirgul(s:string) : String;
var
a,i:integer;
begin

i:=length(s);
if pos(',',s) <>0 then exit;
for a:=1 to i-1 do if (a mod 3)=0 then insert(',',s,i-a+1);
Result:=s;

end;


function Encrypt(Text : string; Key1, Key2, Key3, Key4 : Integer) : string;
var
 BufS, Hexa, Hexa1, Hexa2 : string;
 BufI, BufI2, Sc, Sl, Num1, Num2, Num3, Num4, Res1, Res2, Res3, Res4 : Integer;
begin
 Sl := Length(Text);
 Sc := 0;
 BufS := '';
 if (Key1 in [1 .. 120]) and (Key2 in [1 .. 120]) and (Key3 in [1 .. 120]) and (Key4 in [1 .. 120]) then
 begin
  BufI := Key1 * Key4;
  BufI2 := Key3 * Key2;
  BufI := BufI - BufI2;
  if BufI = 0 then
  begin
   Result := '';
   Exit;
  end;
 end
 else
 begin
  Result := '';
  Exit;
 end;
 repeat
  Inc(Sc);
  if Sc > Sl then Num1 := 0 else Num1 := Ord(Text[Sc]);
  Inc(Sc);
  if Sc > Sl then Num2 := 0 else Num2 := Ord(Text[Sc]);
  Inc(Sc);
  if Sc > Sl then Num3 := 0 else Num3 := Ord(Text[Sc]);
  Inc(sc);
  if Sc > Sl then Num4 := 0 else Num4 := Ord(Text[Sc]);
  Res1 := Num1 * Key1;
  BufI := Num2 * Key3;
  Res1 := Res1 + BufI;
  Res2 := Num1 * Key2;
  BufI := Num2 * Key4;
  Res2 := Res2 + BufI;
  Res3 := Num3 * Key1;
  BufI := Num4 * Key3;
  Res3 := Res3 + BufI;
  Res4 := Num3 * Key2;
  BufI := Num4 * Key4;
  Res4 := Res4 + BufI;
  for BufI := 1 to 4 do
  begin
   case BufI of
    1 : Hexa := IntToHex(Res1, 4);
    2 : Hexa := IntToHex(Res2, 4);
    3 : Hexa := IntToHex(Res3, 4);
    4 : Hexa := IntToHex(Res4, 4);
   end;
   Hexa1 := '$' + Hexa[1] + Hexa[2];
   Hexa2 := '$' + Hexa[3] + Hexa[4];
   if (Hexa1 = '$00') and (Hexa2 = '$00') then
   begin
    Hexa1 := '$FF';
    Hexa2 := '$FF';
   end;
   if Hexa1 = '$00' then Hexa1 := '$FE';
   if Hexa2 = '$00' then
   begin
    Hexa2 := Hexa1;
    Hexa1 := '$FD';
   end;
   BufS := BufS + Chr(StrToInt(Hexa1)) + Chr(StrToInt(Hexa2));
  end;
  until Sc >= Sl;
 Result := BufS;
end;

function Decrypt(Text : string; Key1, Key2, Key3, Key4 : Integer) : string;
var
 BufS, Hexa1, Hexa2 : string;
 BufI, BufI2, Divzr, Sc, Sl, Num1, Num2, Num3, Num4, Res1, Res2, Res3, Res4 : Integer;
begin
 Sl := Length(Text);
 Sc := 0;
 BufS := '';
 if (Key1 in [1 .. 120]) and (Key2 in [1 .. 120]) and (Key3 in [1 .. 120]) and (Key4 in [1 .. 120]) then
 begin
  Divzr := Key1 * Key4;
  BufI2 := Key3 * Key2;
  Divzr := Divzr - BufI2;
  if Divzr = 0 then
  begin
   Result := '';
   Exit;
  end;
 end
 else
 begin
  Result := '';
  Exit;
 end;
 repeat
  for BufI := 1 to 4 do
  begin
   Inc(Sc);
   Hexa1 := IntToHex(Ord(Text[Sc]), 2);
   Inc(Sc);
   Hexa2 := IntToHex(Ord(Text[Sc]), 2);
   if Hexa1 = 'FF' then
   begin
    Hexa1 := '00';
    Hexa2 := '00';
   end;
   if Hexa1 = 'FE' then Hexa1 := '00';
   if Hexa1 = 'FD' then
   begin
    Hexa1 := Hexa2;
    Hexa2 := '00';
   end;
   case BufI of
    1 : Res1 := StrToInt('$' + Hexa1 + Hexa2);
    2 : Res2 := StrToInt('$' + Hexa1 + Hexa2);
    3 : Res3 := StrToInt('$' + Hexa1 + Hexa2);
    4 : Res4 := StrToInt('$' + Hexa1 + Hexa2);
   end;
  end;
  BufI := Res1 * Key4;
  BufI2 := Res2 * Key3;
  Num1 := BufI - BufI2;
  Num1 := Num1 div Divzr;
  BufI := Res2 * Key1;
  BufI2 := Res1 * Key2;
  Num2 := BufI - BufI2;
  Num2 := Num2 div Divzr;
  BufI := Res3 * Key4;
  BufI2 := Res4 * Key3;
  Num3 := BufI - BufI2;
  Num3 := Num3 div Divzr;
  BufI := Res4 * Key1;
  BufI2 := Res3 * Key2;
  Num4 := BufI - BufI2;
  Num4 := Num4 div Divzr;
  BufS := BufS + Chr(Num1) + Chr(Num2) + Chr(Num3) + Chr(Num4);
  until Sc >= Sl;
 Result := BufS;
end;

procedure KullaniciHaklari(FormTagNo:integer; TlBar:TAdvToolBar);
var
  i:integer;
begin
if ActYonetici=True then exit;
SetLength(Hakbilgi,2);
with  dm.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * from Haklar Where ');
  SQL.Add('PerNo='+ActPerNo+' and TagNo='+IntToStr(FormTagNo));
  Open;
  for i :=0  to TlBar.ControlCount-1  do
  begin
    if TlBar.Controls[i].Name ='BtnEkle'     then TlBar.Controls[i].Visible:=FieldByName('Kayit').AsBoolean;
    if TlBar.Controls[i].Name ='BtnDegistir' then TlBar.Controls[i].Visible:=FieldByName('Degistir').AsBoolean;
    if TlBar.Controls[i].Name ='BtnSil'      then TlBar.Controls[i].Visible:=FieldByName('Sil').AsBoolean;
    if TlBar.Controls[i].Name ='BtnYazdir'   then TlBar.Controls[i].Visible:=FieldByName('Yazdir').AsBoolean;
  end;
  end;

end;

// ***************************************

// ***
{
procedure UrunCikis(actUrunKod,BelgeNo,UrunBirim:string;Miktar:Double);
// Urun ��k�� yap�l�yor...
var
  DepoID:String;
  Cmiktar,CBirimMaliyet,CtoplamMaliyet,
  KMiktar,KToplamMaliyet,KBirimMaliyet:Double;
begin
with dm.QryArama do
begin
  // Tan�ml� Depoyu bul...
  Close;
  SQL.Clear ;
  SQL.Add('Select DepoKodu From ProjeDepolar where ProjeKod=:bul ');
  Parameters.ParamByName('bul').Value :='01';
  Prepared;
  open;
  DepoID:=FieldValues['DepoKodu'];
  // ----------
  Close;
  SQL.Clear ;
  SQL.add('Select * from stokhesaplari  Where UrunKodu=:kodbul');
  Parameters.ParamByName('kodbul').Value :=actUrunKod;
  Open;
  Edit;
    FieldByName('tarih').AsDateTime  :=Date;
    FieldByName('aciklama').AsString :='�retim ��in Stok ��k�� ';
    FieldByName('Belgeno').AsString  :=BelgeNo;
    FieldByName('IslemTuru').AsString:='Stok ��k��';
    FieldByName('Birim').AsString    :=UrunBirim;
    Cmiktar        :=Miktar;
    CBirimMaliyet  :=FieldByName('KBirimMaliyet').AsFloat;
    CtoplamMaliyet :=FieldByName('KBirimMaliyet').AsFloat*Cmiktar;
    KMiktar        :=FieldByName('Kmiktar').AsFloat-Cmiktar;
    KToplamMaliyet :=FieldByName('KToplamMaliyet').AsFloat-CtoplamMaliyet;
    if KMiktar=0 then
      KBirimMaliyet  :=0
    else
      KBirimMaliyet  :=KtoplamMaliyet/Kmiktar;
    FieldByName('Kmiktar').AsFloat       := Kmiktar;
    FieldByName('KBirimMaliyet').AsFloat := KBirimMaliyet;
    FieldByName('KToplamMaliyet').AsFloat:= KtoplamMaliyet;
    FieldByName('UrunKodu').AsString     := actUrunKod;
  Post;
  // *** Stok Extre
  Close;
  SQL.Clear;
  SQL.add('Select * from stokhesaplariextre'+ maliyil +' where  UrunKodu=:kbul');
  Parameters.ParamByName('kbul').Value :=actUrunKod;
  Open;
  Append;
    FieldByName('tarih').AsDateTime      := Date;
    FieldByName('aciklama').AsString     := '�retim ��in Stok ��k��';
    FieldByName('Belgeno').AsString      := BelgeNo;
    FieldByName('IslemTuru').AsString    := '�retim ��k��';
    FieldByName('Birim').AsString        := UrunBirim;
    FieldByName('Gmiktar').AsFloat       := 0;
    FieldByName('GBirimMaliyet').AsFloat := 0;
    FieldByName('GToplamMaliyet').AsFloat:= 0;
    FieldByName('Cmiktar').AsFloat       := Cmiktar;
    FieldByName('CBirimMaliyet').AsFloat := CBirimMaliyet;
    FieldByName('CtoplamMaliyet').AsFloat:= CToplamMaliyet;
    FieldByName('Kmiktar').AsFloat       := Kmiktar;
    FieldByName('KBirimMaliyet').AsFloat := KBirimMaliyet;
    FieldByName('KToplamMaliyet').AsFloat:= KtoplamMaliyet;
    FieldByName('UrunKodu').AsString     := actUrunKod;
  Post;
  // *** Stok herketlerini ba�lat....
  Close;
  SQL.Clear;
  SQL.add('Select * from Urun Where Kod=:kodbul');
  Parameters.ParamByName('kodbul').Value :=actUrunKod;
  Open;
  Edit;
    FieldByName('Miktar').Asfloat :=FieldByName('Miktar').Asfloat-Miktar;
  post;
  Close;
  SQL.Clear;
  SQL.add('select * from StokExtre'+maliyil );
  Open;
  Append;
    //FieldByName('StokId').AsString  :='-';
    FieldByName('UrunId').AsString  :=actUrunKod ;
    FieldByName('aciklama').AsString:='�retim ��in Stok ��k��';;
    FieldByName('DepoId').AsString  :=DepoID;
    FieldByName('Tarih').Asdatetime :=date ;
    FieldByName('Cikis').AsFloat    :=Miktar;
  Post;
  Close;
  SQL.Clear;
  SQL.add('Select * from DepoMiktar where UrunID=:UrunID and  DepoId=:DepoID');
  Parameters.ParamByName('UrunID').Value :=actUrunKod;
  Parameters.ParamByName('DepoID').Value :=DepoID;
  Open;
  Edit;
    FieldByName('KayitTarihi').Asdatetime := date;
    FieldByName('ToplamMiktar').Asfloat   := FieldByName('ToplamMiktar').Asfloat - Miktar ;
  Post;
  // *** Stok Hareketleri Bitti..
  end;
end;
// ***
}
// ***
procedure tmpLocalUrunCikis(StokKod,Tur,Tarih,BelgeNo,Aciklama,DepoNo:string;Miktar:Double);
(*var
  GMiktar,GBirimMaliyet,GtoplamMaliyet,
  KMiktar,KToplamMaliyet,KBirimMaliyet,
  ActKMiktar,ActKToplamMaliyet:Double;   *)
begin
{
procedure UrunCikis(actUrunKod,BelgeNo,UrunBirim:string;Miktar:Double);
// Urun ��k�� yap�l�yor...
var
  DepoID:String;
  Cmiktar,CBirimMaliyet,CtoplamMaliyet,
  KMiktar,KToplamMaliyet,KBirimMaliyet:Double;
begin
with dm.Qry2 do
begin
  // Tan�ml� Depoyu bul... �retim Deposunda mal �ekiliyor...
  Close;
  SQL.Clear ;
  SQL.Add('Select DepoKodu From ProjeDepolar where ProjeKod=:bul ');
  Parameters.ParamByName('bul').Value :='05';
  Prepared;
  open;
  DepoID:=FieldValues['DepoKodu'];
  // ----------
  Close;
  SQL.Clear ;
  SQL.add('Select * from stokhesaplari  Where UrunKodu=:kodbul');
  Parameters.ParamByName('kodbul').Value :=actUrunKod;
  Open;
  Edit;
    FieldByName('tarih').AsDateTime  :=Date;
    FieldByName('aciklama').AsString :='ARGE ��in Stok ��k�� ';
    FieldByName('Belgeno').AsString  :=BelgeNo;
    FieldByName('IslemTuru').AsString:='Stok ��k��';
    FieldByName('Birim').AsString    :=UrunBirim;
    Cmiktar        :=Miktar;
    CBirimMaliyet  :=FieldByName('KBirimMaliyet').AsFloat;
    CtoplamMaliyet :=FieldByName('KBirimMaliyet').AsFloat*Cmiktar;
    KMiktar        :=FieldByName('Kmiktar').AsFloat-Cmiktar;
    KToplamMaliyet :=FieldByName('KToplamMaliyet').AsFloat-CtoplamMaliyet;
    if KMiktar=0 then
      KBirimMaliyet  :=0
    else
      KBirimMaliyet  :=KtoplamMaliyet/Kmiktar;
    FieldByName('Kmiktar').AsFloat       := Kmiktar;
    FieldByName('KBirimMaliyet').AsFloat := KBirimMaliyet;
    FieldByName('KToplamMaliyet').AsFloat:= KtoplamMaliyet;
    FieldByName('UrunKodu').AsString     := actUrunKod;
  Post;
  // *** Stok Extre
  Close;
  SQL.Clear;
  SQL.add('Select * from stokhesaplariextre'+ maliyil +' where  UrunKodu=:kbul');
  Parameters.ParamByName('kbul').Value :=actUrunKod;
  Open;
  Append;
    FieldByName('tarih').AsDateTime      := Date;
    FieldByName('aciklama').AsString     := 'AR-GE ��in Stok ��k��';
    FieldByName('Belgeno').AsString      := BelgeNo;
    FieldByName('IslemTuru').AsString    := 'ARGE �retim ��k��';
    FieldByName('Birim').AsString        := UrunBirim;
    FieldByName('Gmiktar').AsFloat       := 0;
    FieldByName('GBirimMaliyet').AsFloat := 0;
    FieldByName('GToplamMaliyet').AsFloat:= 0;
    FieldByName('Cmiktar').AsFloat       := Cmiktar;
    FieldByName('CBirimMaliyet').AsFloat := CBirimMaliyet;
    FieldByName('CtoplamMaliyet').AsFloat:= CToplamMaliyet;
    FieldByName('Kmiktar').AsFloat       := Kmiktar;
    FieldByName('KBirimMaliyet').AsFloat := KBirimMaliyet;
    FieldByName('KToplamMaliyet').AsFloat:= KtoplamMaliyet;
    FieldByName('UrunKodu').AsString     := actUrunKod;
  Post;
  // *** Stok herketlerini ba�lat....
  Close;
  SQL.Clear;
  SQL.add('Select * from Urun Where Kod=:kodbul');
  Parameters.ParamByName('kodbul').Value :=actUrunKod;
  Open;
  Edit;
    FieldByName('Miktar').Asfloat :=FieldByName('Miktar').Asfloat-Miktar;
  post;
  Close;
  SQL.Clear;
  SQL.add('select * from StokExtre'+maliyil );
  Open;
  Append;
    //FieldByName('StokId').AsString  :='-';
    FieldByName('UrunId').AsString  :=actUrunKod ;
    FieldByName('aciklama').AsString:='ARGE ��in Stok ��k��';;
    FieldByName('DepoId').AsString  :=DepoID;
    FieldByName('Tarih').Asdatetime :=date ;
    FieldByName('Cikis').AsFloat    :=Miktar;
  Post;
  Close;
  SQL.Clear;
  SQL.add('Select * from DepoMiktar where UrunID=:UrunID and  DepoId=:DepoID');
  Parameters.ParamByName('UrunID').Value :=actUrunKod;
  Parameters.ParamByName('DepoID').Value :=DepoID;
  Open;
  Edit;
    FieldByName('KayitTarihi').Asdatetime := date;
    FieldByName('ToplamMiktar').Asfloat   := FieldByName('ToplamMiktar').Asfloat - Miktar ;
  Post;
  // *** Stok Hareketleri Bitti..
  end;
end;
  //  ID,StokKod,Tur,Tarih,BelgeNo,Aciklama,GMiktar,GBMaliyet,GTMaliyet,CMiktar
  //  CBMaliyet,CTMaliyet,KMiktar,KBMaliyet,KTMaliyet
try
  if not dm.ado1.InTransaction then dm.ado1.BeginTrans;
with dm.QryArama do
begin
  // *** stok tablosundaki de�erleri g�ncelle...
  Close;
  SQL.Clear;
  SQL.add('Select KMiktar,KBMaliyet,KTMaliyet from Stok where StockCode=:kodbul');
  Parameters.ParamByName('kodbul').Value :=StokKod;
  Open;
  // *** degerleri oku
  ActKMiktar        :=FieldByName('KMiktar').AsFloat;
  ActKToplamMaliyet :=FieldByName('KTMaliyet').AsFloat ;
  // *** hesaplamalar� yap
      GMiktar         :=Miktar;
    if GMiktar =0 then
      GBirimMaliyet :=0
    else
//      GBirimMaliyet :=Maliyet/GMiktar;
//    GToplamMaliyet  :=Maliyet;
      KMiktar       :=ActKMiktar+GMiktar;
      KToplamMaliyet:=ActKToplamMaliyet+GToplamMaliyet;
    if KMiktar=0 then
      KBirimMaliyet :=0
    else
      KBirimMaliyet :=KToplamMaliyet/KMiktar;
    // *** G�ncelleme i�lemini yap;
  Close;
  SQL.Clear;
    // stok Tablosunu G�ncelle
  Close;
  SQL.Clear;
  SQL.Add('Update Stok Set  KMiktar=:KMiktar,KBMaliyet=:KBMaliyet,KTMaliyet=:KTMaliyet,StockAmount=StockAmount+:yeni Where StockCode=:Bul ');
  Parameters.ParamByName('Yeni').Value      :=Miktar;
  Parameters.ParamByName('bul').Value       :=StokKod;
  Parameters.ParamByName('KMiktar').Value   :=KMiktar;
  Parameters.ParamByName('KBMaliyet').Value :=KBirimMaliyet;
  Parameters.ParamByName('KTMaliyet').Value :=KToplamMaliyet;
  Prepared ;
  ExecSQL;
  // *** Maliyet tablosuna yazd�r
  Close;
  SQL.Clear;
  SQL.add('Insert Into  StokMaliyetleri2007 ');
  SQL.Add('(StokKod,Tur,Tarih,BelgeNo,Aciklama,GMiktar,GBMaliyet,GTMaliyet,CMiktar,');
  SQL.Add('CBMaliyet,CTMaliyet,KMiktar,KBMaliyet,KTMaliyet)');
  SQL.Add('Values');
  SQL.Add('(:StokKod,:Tur,:Tarih,:BelgeNo,:Aciklama,:GMiktar,:GBMaliyet,:GTMaliyet,:CMiktar,');
  SQL.Add(':CBMaliyet,:CTMaliyet,:KMiktar,:KBMaliyet,:KTMaliyet)');
  Parameters.ParamByName('StokKod').Value   :=StokKod;
  Parameters.ParamByName('Tur').Value       :=Tur;
  Parameters.ParamByName('Tarih').Value     :=Tarih;
  Parameters.ParamByName('BelgeNo').Value   :=BelgeNo;
  Parameters.ParamByName('Aciklama').Value  :=Aciklama;
    Parameters.ParamByName('Gmiktar').Value :=GMiktar;
  Parameters.ParamByName('GBMaliyet').Value :=GBirimMaliyet;
  Parameters.ParamByName('GTMaliyet').Value :=GToplamMaliyet;
    Parameters.ParamByName('Cmiktar').Value :=0;
  Parameters.ParamByName('CBMaliyet').Value :=0;
  Parameters.ParamByName('CTMaliyet').Value :=0;
    Parameters.ParamByName('KMiktar').Value :=KMiktar;
  Parameters.ParamByName('KBMaliyet').Value :=KBirimMaliyet;
  Parameters.ParamByName('KTMaliyet').Value :=KtoplamMaliyet;
  ExecSQL;
  // *** Depo Miktarlar�n� G�ncelle
  Close;
  SQL.Clear;
  SQL.Add('Select * From DepoMiktar where DepoNo=:DepoNo and StokKod=:Bul ');
  Parameters.ParamByName('bul').Value   :=StokKod;
  Parameters.ParamByName('DepoNo').Value:=DepoNo;
  Prepared ;
  Open;
  if recordcount=0 then
  begin
    Append;
      FieldByName('StokKod').AsString :=StokKod;
      FieldByName('DepoNo').AsString  :=DepoNo;
      FieldByName('DGiris').AsFloat   :=FieldByName('DGiris').AsFloat + Miktar ;
    post;
  end
  else
  begin
    Edit;
      FieldByName('DGiris').AsFloat :=FieldByName('DGiris').AsFloat + Miktar;
    post;
  end;
  // *** Stok Extreye Yaz...
  Close;
  SQL.Clear;
  SQL.Add('Insert Into StokExtre2007'+maliyil);
  SQL.Add('(Tur,StokKod,Tarih,BelgeNo,Aciklama,Giris,Cikis,DepoNo)');
  SQL.Add('Values ');
  SQL.Add('(:Tur,:StokKod,:Tarih,:BelgeNo,:Aciklama,:Giris,:Cikis,:DepoNo)');
//,,,,,,,
    Parameters.ParamByName('Tur').Value     :=Tur;
    Parameters.ParamByName('StokKod').Value :=StokKod;
    Parameters.ParamByName('Tarih').Value   :=Tarih;
    Parameters.ParamByName('BelgeNo').Value :=BelgeNo;
    Parameters.ParamByName('Aciklama').Value:=Aciklama;
    Parameters.ParamByName('Giris').Value   :=Miktar;
    Parameters.ParamByName('Cikis').Value   :=0;
    Parameters.ParamByName('DepoNo').Value  :=DepoNo ;
  Prepared;
  ExecSQL;
end;
  dm.ado1.CommitTrans;
except
  dm.ado1.RollbackTrans;
  ShowMessage('HATA00001');
end;
}
end;

procedure LocalUrunGiris(StokKod,Tur,Tarih,BelgeNo,Aciklama,DepoNo:string;Miktar,Maliyet:Double);
var
  GMiktar,GBirimMaliyet,GtoplamMaliyet,
  KMiktar,KToplamMaliyet,KBirimMaliyet,
  ActKMiktar,ActKToplamMaliyet:Double;
begin
  //  ID,StokKod,Tur,Tarih,BelgeNo,Aciklama,GMiktar,GBMaliyet,GTMaliyet,CMiktar
  //  CBMaliyet,CTMaliyet,KMiktar,KBMaliyet,KTMaliyet
try
  if not dm.cnn1.InTransaction then dm.cnn1.BeginTrans;
with dm.Qrylist do
begin
  // *** stok tablosundaki de�erleri g�ncelle...
  Close;
  SQL.Clear;
  SQL.add('Select KMiktar,KBMaliyet,KTMaliyet from Stok where StockCode=:kodbul');
  Parameters.ParamByName('kodbul').Value :=StokKod;
  Open;
  // *** degerleri oku
  ActKMiktar        :=FieldByName('KMiktar').AsFloat;
  ActKToplamMaliyet :=FieldByName('KTMaliyet').AsFloat ;
  // *** hesaplamalar� yap
      GMiktar         :=Miktar;
    if GMiktar =0 then
      GBirimMaliyet :=0
    else
      GBirimMaliyet :=Maliyet/GMiktar;
    GToplamMaliyet  :=Maliyet;
      KMiktar       :=ActKMiktar+GMiktar;
      KToplamMaliyet:=ActKToplamMaliyet+GToplamMaliyet;
    if KMiktar=0 then
      KBirimMaliyet :=0
    else
      KBirimMaliyet :=KToplamMaliyet/KMiktar;
    // *** G�ncelleme i�lemini yap;
  Close;
  SQL.Clear;
    // stok Tablosunu G�ncelle
  Close;
  SQL.Clear;
  SQL.Add('Update Stok Set  KMiktar=:KMiktar,KBMaliyet=:KBMaliyet,KTMaliyet=:KTMaliyet,StockAmount=StockAmount+:yeni Where StockCode=:Bul ');
  Parameters.ParamByName('Yeni').Value      :=Miktar;
  Parameters.ParamByName('bul').Value       :=StokKod;
  Parameters.ParamByName('KMiktar').Value   :=KMiktar;
  Parameters.ParamByName('KBMaliyet').Value :=KBirimMaliyet;
  Parameters.ParamByName('KTMaliyet').Value :=KToplamMaliyet;
  Prepared ;
  ExecSQL;
  // *** Maliyet tablosuna yazd�r
  Close;
  SQL.Clear;
  SQL.add('Insert Into  StokMaliyetleri2007 ');
  SQL.Add('(StokKod,Tur,Tarih,BelgeNo,Aciklama,GMiktar,GBMaliyet,GTMaliyet,CMiktar,');
  SQL.Add('CBMaliyet,CTMaliyet,KMiktar,KBMaliyet,KTMaliyet)');
  SQL.Add('Values');
  SQL.Add('(:StokKod,:Tur,:Tarih,:BelgeNo,:Aciklama,:GMiktar,:GBMaliyet,:GTMaliyet,:CMiktar,');
  SQL.Add(':CBMaliyet,:CTMaliyet,:KMiktar,:KBMaliyet,:KTMaliyet)');
  Parameters.ParamByName('StokKod').Value   :=StokKod;
  Parameters.ParamByName('Tur').Value       :=Tur;
  Parameters.ParamByName('Tarih').Value     :=Tarih;
  Parameters.ParamByName('BelgeNo').Value   :=BelgeNo;
  Parameters.ParamByName('Aciklama').Value  :=Aciklama;
    Parameters.ParamByName('Gmiktar').Value :=GMiktar;
  Parameters.ParamByName('GBMaliyet').Value :=GBirimMaliyet;
  Parameters.ParamByName('GTMaliyet').Value :=GToplamMaliyet;
    Parameters.ParamByName('Cmiktar').Value :=0;
  Parameters.ParamByName('CBMaliyet').Value :=0;
  Parameters.ParamByName('CTMaliyet').Value :=0;
    Parameters.ParamByName('KMiktar').Value :=KMiktar;
  Parameters.ParamByName('KBMaliyet').Value :=KBirimMaliyet;
  Parameters.ParamByName('KTMaliyet').Value :=KtoplamMaliyet;
  ExecSQL;
  // *** Depo Miktarlar�n� G�ncelle
  Close;
  SQL.Clear;
  SQL.Add('Select * From DepoMiktar where DepoNo=:DepoNo and StokKod=:Bul ');
  Parameters.ParamByName('bul').Value   :=StokKod;
  Parameters.ParamByName('DepoNo').Value:=DepoNo;
  Prepared ;
  Open;
  if recordcount=0 then
  begin
    Append;
      FieldByName('StokKod').AsString :=StokKod;
      FieldByName('DepoNo').AsString  :=DepoNo;
      FieldByName('DGiris').AsFloat   :=FieldByName('DGiris').AsFloat + Miktar ;
    post;
  end
  else
  begin
    Edit;
      FieldByName('DGiris').AsFloat :=FieldByName('DGiris').AsFloat + Miktar;
    post;
  end;
  // *** Stok Extreye Yaz...
  Close;
  SQL.Clear;
  SQL.Add('Insert Into StokExtre2007'+maliyil);
  SQL.Add('(Tur,StokKod,Tarih,BelgeNo,Aciklama,Giris,Cikis,DepoNo)');
  SQL.Add('Values ');
  SQL.Add('(:Tur,:StokKod,:Tarih,:BelgeNo,:Aciklama,:Giris,:Cikis,:DepoNo)');
    Parameters.ParamByName('Tur').Value     :=Tur;
    Parameters.ParamByName('StokKod').Value :=StokKod;
    Parameters.ParamByName('Tarih').Value   :=Tarih;
    Parameters.ParamByName('BelgeNo').Value :=BelgeNo;
    Parameters.ParamByName('Aciklama').Value:=Aciklama;
    Parameters.ParamByName('Giris').Value   :=Miktar;
    Parameters.ParamByName('Cikis').Value   :=0;
    Parameters.ParamByName('DepoNo').Value  :=DepoNo ;
  Prepared;
  ExecSQL;
end;
  dm.cnn1.CommitTrans;
except
  dm.cnn1.RollbackTrans;
  ShowMessage('HATA00001');
end;
end;

procedure LocalUrunCikis(StokKod,Tur,Tarih,BelgeNo,Aciklama,DepoNo:string;Miktar:Double);
var
  CMiktar,CBirimMaliyet,CToplamMaliyet,
  KMiktar,KBirimMaliyet,KToplamMaliyet,
  ActKMiktar,ActKBirimMaliyet,ActKToplamMaliyet:Double;
begin
  //  ID,StokKod,Tur,Tarih,BelgeNo,Aciklama,GMiktar,GBMaliyet,GTMaliyet,CMiktar
  //  CBMaliyet,CTMaliyet,KMiktar,KBMaliyet,KTMaliyet
try
if not dm.cnn1.InTransaction then dm.cnn1.BeginTrans;
with dm.Qrylist do
begin
  // *** stok tablosundaki de�erleri g�ncelle...
  Close;
  SQL.Clear;
  SQL.add('Select KMiktar,KBMaliyet,KTMaliyet from Stok where StockCode=:kodbul');
  Parameters.ParamByName('kodbul').Value :=StokKod;
  Open;
  // *** degerleri oku
  CMiktar        :=Miktar;
  CBirimMaliyet  :=FieldByName('KBMaliyet').AsFloat;
  CToplamMaliyet :=CBirimMaliyet*CMiktar;

  KMiktar        :=FieldByName('KMiktar').AsFloat - CMiktar;
  KToplamMaliyet :=FieldByName('KTMaliyet').AsFloat - CToplamMaliyet ;
  if KMiktar =0 then
    KBirimMaliyet :=0
  else
    KBirimMaliyet :=KToplamMaliyet/KMiktar;
    // *** G�ncelleme i�lemini yap;
  Close;
  SQL.Clear;
    // stok Tablosunu G�ncelle
  Close;
  SQL.Clear;
  SQL.Add('Update Stok Set KMiktar=:KMiktar,KBMaliyet=:KBMaliyet,KTMaliyet=:KTMaliyet,');
  SQL.Add('StockAmount=StockAmount-:yeni Where StockCode=:Bul ');
  Parameters.ParamByName('Yeni').Value      :=Miktar;
  Parameters.ParamByName('bul').Value       :=StokKod;
  Parameters.ParamByName('KMiktar').Value   :=KMiktar;
  Parameters.ParamByName('KBMaliyet').Value :=KBirimMaliyet;
  Parameters.ParamByName('KTMaliyet').Value :=KToplamMaliyet;
  Prepared ;
  ExecSQL;
  // *** Maliyet tablosuna yazd�r
  Close;
  SQL.Clear;
  SQL.add('Insert Into  StokMaliyetleri2007 ');
  SQL.Add('(StokKod,Tur,Tarih,BelgeNo,Aciklama,GMiktar,GBMaliyet,GTMaliyet,CMiktar,');
  SQL.Add('CBMaliyet,CTMaliyet,KMiktar,KBMaliyet,KTMaliyet)');
  SQL.Add('Values');
  SQL.Add('(:StokKod,:Tur,:Tarih,:BelgeNo,:Aciklama,:GMiktar,:GBMaliyet,:GTMaliyet,:CMiktar,');
  SQL.Add(':CBMaliyet,:CTMaliyet,:KMiktar,:KBMaliyet,:KTMaliyet)');
  Parameters.ParamByName('StokKod').Value   :=StokKod;
  Parameters.ParamByName('Tur').Value       :=Tur;
  Parameters.ParamByName('Tarih').Value     :=Tarih;
  Parameters.ParamByName('BelgeNo').Value   :=BelgeNo;
  Parameters.ParamByName('Aciklama').Value  :=Aciklama;
    Parameters.ParamByName('Gmiktar').Value :=0;
  Parameters.ParamByName('GBMaliyet').Value :=0;
  Parameters.ParamByName('GTMaliyet').Value :=0;
    Parameters.ParamByName('Cmiktar').Value :=CMiktar;;
  Parameters.ParamByName('CBMaliyet').Value :=CBirimMaliyet;
  Parameters.ParamByName('CTMaliyet').Value :=CToplamMaliyet;
    Parameters.ParamByName('KMiktar').Value :=KMiktar;
  Parameters.ParamByName('KBMaliyet').Value :=KBirimMaliyet;
  Parameters.ParamByName('KTMaliyet').Value :=KtoplamMaliyet;
  ExecSQL;
  // *** Depo Miktarlar�n� G�ncelle
  Close;
  SQL.Clear;
  SQL.Add('Select * From DepoMiktar where DepoNo=:DepoNo and StokKod=:Bul ');
  Parameters.ParamByName('bul').Value   :=StokKod;
  Parameters.ParamByName('DepoNo').Value:=DepoNo;
  Prepared ;
  Open;
  if recordcount=0 then
  begin
    Append;
      FieldByName('StokKod').AsString :=StokKod;
      FieldByName('DepoNo').AsString  :=DepoNo;
      FieldByName('DCikis').AsFloat   :=FieldByName('DCikis').AsFloat + Miktar ;
    post;
  end
  else
  begin
    Edit;
      FieldByName('DCikis').AsFloat :=FieldByName('DCikis').AsFloat + Miktar;
    post;
  end;
  // *** Stok Extreye Yaz...
  Close;
  SQL.Clear;
  SQL.Add('Insert Into StokExtre2007'+maliyil);
  SQL.Add('(Tur,StokKod,Tarih,BelgeNo,Aciklama,Giris,Cikis,DepoNo)');
  SQL.Add('Values ');
  SQL.Add('(:Tur,:StokKod,:Tarih,:BelgeNo,:Aciklama,:Giris,:Cikis,:DepoNo)');
    Parameters.ParamByName('Tur').Value     :=Tur;
    Parameters.ParamByName('StokKod').Value :=StokKod;
    Parameters.ParamByName('Tarih').Value   :=Tarih;
    Parameters.ParamByName('BelgeNo').Value :=BelgeNo;
    Parameters.ParamByName('Aciklama').Value:=Aciklama;
    Parameters.ParamByName('Giris').Value   :=0;
    Parameters.ParamByName('Cikis').Value   :=Miktar;
    Parameters.ParamByName('DepoNo').Value  :=DepoNo ;
  Prepared;
  ExecSQL;
end;
  dm.cnn1.CommitTrans;
except
  dm.cnn1.RollbackTrans;
  ShowMessage('HATA00001');
end;
end;
// ***
Procedure MsgUyari(Mesaj:String);
begin
{ *** Genel Uyar�lar� Buradan yap�yoruz..;
  *** Create Date : 27.02.2006
  *** Last Update :}
  FrmUyari:=TFrmUyari.Create(Application);
  FrmUyari.lblCaption.Caption:=Mesaj;
  FrmUyari.ShowModal;
  FrmUyari.Release;
end;
// ***
function GetLastNumber(LookUp:Integer):String ;
var
  tmp,MySQL:string;
begin
(*'***************************
'*** Get Last Numbers for Field Keys
'Table Name  LastNumbers
'Field Name      Type    Size   Definition
'ID                             Primary Key
'BHLastNumber    Text    5      Bank Hesab�
'CHLastNumber    Text    5      Cari Hesap
'STLastNumber    Text    5      Stok Numaras�
'MKLastNumber    Text    5      Makbuz Numaras�
'PRLastNumber    Text    5      �retim Rapor Numaras�
'SFLastNumber    Text    5      Sat�� Fi�i Numaras�
'*************************** *)
tmp :='00001';
case LookUp of
0: MySQL :='Select BHLastNumber from LastNumbers ' ;//  '*** Bank Hesab�
1: MySQL :='Select CHLastNumber from LastNumbers ' ;// '*** Cari Hesap
2: MySQL :='Select STLastNumber from LastNumbers ' ;// Stok Numaras�
3: MySQL :='Select MKLastNumber from LastNumbers ' ;// Makbuz Numaras�
4: MySQL :='Select PRLastNumber from LastNumbers ' ;// �retim Rapor Numaras�
5: MySQL :='Select SFLastNumber from LastNumbers ' ;// Sat�� Fi�i Numaras�
6: MySQL :='Select MSLastNumber from LastNumbers ' ;// Mahsup Fi�i Numaras�
end;
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add(MySQL);
  Prepared ;
  Open;
  if varisnull(Fields[0].Value) then
    Result:=tmp
  else
    Result:=Fields[0].Value;
end;
end;
// ***
procedure UpdateLastNumber(LookUp:Integer; OldValue:String);
var
  NewValue,MySQL:string;
begin
{'***************************
'*** Update Last Numbers for Field Keys
'Table Name  LastNumbers
'Field Name      Type    Size   Definition
'ID                             Primary Key
'BHLastNumber    Text    5      Bank Hesab�
'CHLastNumber    Text    5      Cari Hesap
'STLastNumber    Text    5      Stok Numaras�
'MKLastNumber    Text    5      Makbuz Numaras�
'PRLastNumber    Text    5      �retim Rapor Numaras�
'SFLastNumber    Text    5      Sat�� Fi�i Numaras�
'*************************** }
NewValue := RightStr ('00000'+ IntToStr(StrToInt(OldValue) + 1), 5);
case LookUp of
0: MySQL :='Update LastNumbers Set BHLastNumber =:bul';
1: MySQL :='Update LastNumbers Set CHLastNumber =:bul';
2: MySQL :='Update LastNumbers Set STLastNumber =:bul';
3: MySQL :='Update LastNumbers Set MKLastNumber =:bul';
4: MySQL :='Update LastNumbers Set PRLastNumber =:bul';
5: MySQL :='Update LastNumbers Set SFLastNumber =:bul';
6: MySQL :='Update LastNumbers Set MSLastNumber =:bul';
end;
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add(MySQL);
  Parameters.ParamByName('bul').Value :=NewValue;
  Prepared ;
  ExecSQL;
end;
end;
// ***
function HareketKayit(CariKod,Tarih,BelgeNo,Aciklama,FisTuru,Kullanici:String;FTBorc,FTAlacak:Double;HEBilgi:array of HExtre; HSay:Integer):String;
var
ActFisNo:String;
i:Integer;

begin
ActFisNo:=GetLastNumber(6);
UpdateLastNumber(6,ActFisNo); 
//FisNo :=FisNoBul(FisTur);
try
  //HesapFisBilgi2007
  // RecID	FisNo	BelgeNo,Tarih	Aciklama	MBorc	MAlacak	FisTuru	Kullanici	IslemTarihi LastNo
  if not dm.cnn1.InTransaction then   dm.cnn1.BeginTrans ;
  with dm.Qrylist do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into HesapFisBilgi2007'+ maliyil );
    SQL.Add('(FisNo,BelgeNo,Tarih,Aciklama,MBorc,MAlacak,FisTuru,Kullanici)');
    SQL.Add('values ');
    SQL.Add('(:FisNo,:BelgeNo,:Tarih,:Aciklama,:MBorc,:MAlacak,:FisTuru,:Kullanici)');
    Parameters.ParamByName('FisNo').Value     :=ActFisNo;
    Parameters.ParamByName('BelgeNo').Value   :=BelgeNo;
    Parameters.ParamByName('Tarih').Value     :=Tarih;
    Parameters.ParamByName('Aciklama').Value  :=Aciklama;
    Parameters.ParamByName('MBorc').Value     :=FTBorc  ;
    Parameters.ParamByName('MAlacak').Value   :=FTAlacak ;
    Parameters.ParamByName('FisTuru').Value   :=FisTuru;
    Parameters.ParamByName('Kullanici').Value :=Kullanici;
    ExecSQL;
    // *** Hesap Hareketini Kaydet...
    // Hesap kareket tablosu
    // BorcAlacak	HesapKod	HesapAdi PBirimi	Tarih	BelgeNo	Aciklama		HBorc	HAlacak	MBorc	MAlacak	Kur	FisTuru	MFisNo	IslemTipi	LinkNo
    for i :=1  to HSay  do
    begin
      Close;
      SQL.Clear ;
      SQL.Add('insert into HesapHareket2007'+ maliyil );
      SQL.Add('(BorcAlacak,HesapKod,HesapAdi,PBirimi,Tarih,BelgeNo,Aciklama,');
      SQL.Add('HBorc,HAlacak,MBorc,MAlacak,Kur,MFisNo,CariKod)');
      SQL.Add(' values ');
      SQL.Add('(:BorcAlacak,:HesapKod,:HesapAdi,:PBirimi,:Tarih,:BelgeNo,:Aciklama,');
      SQL.Add(':HBorc,:HAlacak,:MBorc,:MAlacak,:Kur,:MFisNo,:CariKod);');
      Parameters.ParamByName('CariKod').Value   :=CariKod;
      Parameters.ParamByName('BorcAlacak').Value:=HEBilgi[i].BA;
      Parameters.ParamByName('HesapKod').Value  :=HEBilgi[i].HesapKod ;
      Parameters.ParamByName('HesapAdi').Value  :=HEBilgi[i].HesapAdi ;
      Parameters.ParamByName('PBirimi').Value   :=HEBilgi[i].PBirimi ;
      Parameters.ParamByName('Tarih').Value     :=HEBilgi[i].Tarih  ;
      Parameters.ParamByName('BelgeNo').Value   :=HEBilgi[i].BelgeNo ;
      Parameters.ParamByName('Aciklama').Value  :=HEBilgi[i].Aciklama;
      if  HEBilgi[i].BA='B' then
      begin
        Parameters.ParamByName('HBorc').Value     :=RoundTo(HEBilgi[i].HMiktar,-2) ;
        Parameters.ParamByName('HAlacak').Value   :=0;
        Parameters.ParamByName('MBorc').Value     :=RoundTo(HEBilgi[i].MMiktar,-2);
        Parameters.ParamByName('MAlacak').Value   :=0;
      end
      else
      begin
        Parameters.ParamByName('HBorc').Value     :=0;
        Parameters.ParamByName('HAlacak').Value   :=RoundTo(HEBilgi[i].HMiktar,-2);
        Parameters.ParamByName('MBorc').Value     :=0;
        Parameters.ParamByName('MAlacak').Value   :=RoundTo(HEBilgi[i].MMiktar,-2);
      end;
      Parameters.ParamByName('Kur').Value       :=RoundTo(HEBilgi[i].Kur,-3);
      Parameters.ParamByName('MFisNo').Value    :=ActFisNo;
      Prepared;
      ExecSQL;
    end;
 end;
    Result:=ActFisNo;
    dm.cnn1.CommitTrans;
except
  dm.cnn1.RollbackTrans;
  showmessage('Hesap Hareket Kay�t Hatas�..');
end;
end;
// ***
function Kur(Tip:String;Tarih:TDate;Sembol:string):String;
begin
if Sembol='YTL' then
begin
  Result:= FormatFloat(',0.000',1);
  exit;
end;
with dm.Qrylist do
begin
  Close;
  SQL.Clear ;
  SQL.Add('Select '+tip+' From GunlukKurlar Where Tarih='''+datetostr(Tarih)+''' and  Sembol='''+Sembol+''' ');
  Open;
  Result:= FormatFloat(',0.000',FieldByName(tip).AsFloat);
end;
end;
// **
procedure SayisalGoruntu(TmpQry:TADOQuery);
var i:integer;
begin
for i:=0 to TmpQry.Fields.Count-1 do
if (TmpQry.Fields.Fields[i].DataType  = ftFloat) or
   (TmpQry.Fields.Fields[i].DataType  = ftCurrency) then
  (TmpQry.Fields.Fields[i] as TNumericField).DisplayFormat := ',0.00' ;
end;
// ***
function AutoBelgeNo():String;
begin
  Result:=FormatDateTime('mmdd',Date)+FormatDateTime('hhmmss',Now)
end;
// ***

// ***
Function MsgOnay(Mesaj:String):Boolean;
begin
{ *** Kullan�c� Onaylar�n� buradan yap�yoruz...
  *** Create Date : 02.03.2006
  *** Last Update :}
  FrmOnay:=TFrmOnay.Create(Application);
  FrmOnay.lblCaption.Caption:=Mesaj;
  FrmOnay.ShowModal;
    Result:=FrmOnay.ActOnay;
  FrmOnay.Release;
end;
// ***
Procedure GiderKaydet(HBGuncelle,HesapKod,Tarih,BelgeNo,Aciklama,BHesapNo,CekNo,ProgCode:String;Miktar:Double);
begin
{ *** Gelir Kay�tlar� Yapar;
  *** Create Date : 08.09.2005
  *** Last Update :
table : ID	GCode	OpDate	OpNumber	OpDefinition	InValue	OutValue	BHesapNo	ProgCode,CekNo }
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select Top 1 * from InOutExtre2005 ');
  open;
  Append;
    FieldByName('GCode').AsString       :=HesapKod;
    FieldByName('OpDate').AsString      :=Tarih;
    FieldByName('OpNumber').AsString    :=BelgeNo;
    FieldByName('OpDefinition').AsString:=Aciklama;
    FieldByName('InValue').AsFloat      :=0;
    FieldByName('OutValue').AsFloat     :=Miktar;
    FieldByName('BHesapNo').AsString    :=BHesapNo;
    FieldByName('CekNo').AsString       :=CekNo;
    FieldByName('ProgCode').AsString    :=ProgCode;
  post;
// *** Hesaplar�n� Bakiyelerini g�ncelle ...
//   GCode	GDefinition	GType	InValue	OutValue	RezCode
if HBGuncelle='Evet' then
begin
  Close;
  SQL.Clear;
  SQL.Add('Update InOutInfo2005 Set OutValue=OutValue+:Amount ');
  SQL.Add('Where GCode=:Bul');
  Parameters.ParamByName('Amount').Value:=Miktar;
  Parameters.ParamByName('Bul').Value   :=HesapKod;
  Prepared ;
  ExecSQL;
end;
end;
end;
// ***
Procedure GiderSil(HBGuncelle,HesapKod,Tarih,BelgeNo,Aciklama,BHesapNo,CekNo,ProgCode:String;Miktar:Double);
begin
{ *** Gelir Silme i�lemi Yapar;
  *** Create Date : 08.09.2005
  *** Last Update :
table : ID	GCode	OpDate	OpNumber	OpDefinition	InValue	OutValue	BHesapNo	ProgCode,CekNo }
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select Top 1 * from InOutExtre2005 ');
  open;
  Append;
    FieldByName('GCode').AsString       :=HesapKod;
    FieldByName('OpDate').AsString      :=Tarih;
    FieldByName('OpNumber').AsString    :=BelgeNo;
    FieldByName('OpDefinition').AsString:=Aciklama;
    FieldByName('InValue').AsFloat      :=Miktar;
    FieldByName('OutValue').AsFloat     :=0;
    FieldByName('BHesapNo').AsString    :=BHesapNo;
    FieldByName('CekNo').AsString :=CekNo;
    FieldByName('ProgCode').AsString:=ProgCode;
  post;
// *** Hesaplar�n� Bakiyelerini g�ncelle ...
//   GCode	GDefinition	GType	InValue	OutValue	RezCode
if HBGuncelle='Evet' then
begin
  Close;
  SQL.Clear;
  SQL.Add('Update InOutInfo2005 Set InValue=InValue+:Amount ');
  SQL.Add('Where GCode=:Bul');
  Parameters.ParamByName('Amount').Value:=Miktar;
  Parameters.ParamByName('Bul').Value   :=HesapKod;
  Prepared ;
  ExecSQL;
end;
end;
end;

Procedure AdvStrExceleAktar(FormAdi:TForm;Grid:TAdvStringGrid);
//var SaveDlg:TSaveDialog;
//    GridExcel :TAdvGridExcelIO;
begin
{SaveDlg := TSaveDialog.Create(FormAdi);
SaveDlg.Filter := 'Excel' ;
SaveDlg.Execute;
Grid.FixedColor:=clWhite;
GridExcel:= TAdvGridExcelIO.Create(Formadi);
with GridExcel do begin
  AdvStringGrid := Grid ;
//  KeepExcelCellFormat := False ;
  UseUnicode := False   ;
//  MergeEmptyRightCells := False ;
  GridStartRow := 0 ;
  GridStartCol := 0 ;
end;

if SaveDlg.FileName <> '' then
GridExcel.XLSExport(SaveDlg.FileName+'.xls','Sheet1');
}
end;

Procedure AdvDBExceleAktar(FormAdi:TForm;Grid:TDBAdvStringGrid);
//var SaveDlg:TSaveDialog;
//    GridExcel :TAdvGridExcelIO;
begin
{
SaveDlg := TSaveDialog.Create(FormAdi);
SaveDlg.Filter := 'Excel' ;
SaveDlg.Execute;

Grid.FixedColor:=clWhite;

GridExcel:= TAdvGridExcelIO.Create(Formadi);
with GridExcel do begin
  AdvStringGrid := Grid ;
//  KeepExcelCellFormat := False ;
  UseUnicode := False   ;
//  MergeEmptyRightCells := False ;
  GridStartRow := 0 ;
  GridStartCol := 0 ;
end;
if SaveDlg.FileName <> '' then
GridExcel.XLSExport(SaveDlg.FileName+'.xls','Sheet1');
}
end;

Procedure AdvStrYazdir(FormAdi:TForm;TmpGrid:TAdvStringGrid;Islem:String;Sayfa:String);
var AdvPrev:TAdvPreviewDialog;
begin
TmpGrid.PrintSettings.Title := ppBottomLeft ;
TmpGrid.PrintSettings.PageNr := ppBottomRight ;
TmpGrid.PrintSettings.PagePrefix := 'Sayfa' ;
TmpGrid.PrintSettings.FooterSize := 100 +GridFooter ;
TmpGrid.PrintSettings.FooterFont.Charset := TURKISH_CHARSET ;
TmpGrid.PrintSettings.FooterFont.Color := clSilver  ;
TmpGrid.PrintSettings.FooterFont.Height := -11 ;
TmpGrid.PrintSettings.FooterFont.Name := 'Tahoma' ;
TmpGrid.PrintSettings.FooterFont.Style := [] ;
TmpGrid.PrintSettings.RepeatFixedRows := True ;
TmpGrid.PrintSettings.PrintGraphics := True;
TmpGrid.PrintSettings.NoAutoSize := True   ;
TmpGrid.PrintSettings.NoAutoSizeRow := True ;


if Sayfa = 'Yatay' then begin
printer.Orientation := poLandscape ;
TmpGrid.PrintSettings.Orientation := poLandscape ;

TmpGrid.PrintSettings.TitleLines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '--------------------------------------------------------');
TmpGrid.PrintSettings.TitleLines.Add('Firma Ad� :' +TmpKayitIsmi+'                                                                                                 '+
                                        '                                         Mali Y�l:   '+Maliyil);
TmpGrid.PrintSettings.TitleLines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '--------------------------------------------------------');
TmpGrid.PrintSettings.TitleLines.Add('xx V.1.0 ');
end;
if Sayfa = 'Dikey' then begin
printer.Orientation := poPortrait ;
TmpGrid.PrintSettings.Orientation := poPortrait ;
TmpGrid.PrintSettings.TitleLines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '--------------------------------------------------------');
TmpGrid.PrintSettings.TitleLines.Add('Firma Ad� :' +TmpKayitIsmi+'                                                                                                 '+
                                        '              Mali Y�l:   '+Maliyil);
TmpGrid.PrintSettings.TitleLines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '--------------------------------------------------------');
TmpGrid.PrintSettings.TitleLines.Add('xx V.1.0 ');
end;

AdvPrev :=TAdvPreviewDialog.Create(FormAdi);
with AdvPrev do  begin
  DialogCaption := '�nizleme' ;
  DialogPrevBtn := '�nceki'  ;
  DialogNextBtn := 'Sonraki'   ;
  DialogPrintBtn := 'Yazd�r';
  DialogCloseBtn := 'Kapat' ;
  Grid := TmpGrid ;
  PreviewFast := False ;
  PreviewWidth := 350 ;
  PreviewHeight := 300 ;
  PreviewLeft := 100  ;
  PreviewTop := 100 ;
  PreviewCenter := False   ;
  PrinterSetupDialog := False ;
  PrintSelectedRows := False ;
  PrintSelectedCols := False ;
  PrintSelection := False   ;
end;

if Islem = 'Yazd�r' then TmpGrid.Print;
if Islem = 'G�r�nt�le' then AdvPrev.Execute;

end;


Procedure AdvDBYazdir(FormAdi:TForm;TmpGrid:TDBAdvStringGrid;Islem:String;Sayfa:String);
var AdvPrev:TAdvPreviewDialog;
begin

TmpGrid.PrintSettings.Title := ppBottomLeft ;
TmpGrid.PrintSettings.PageNr := ppBottomRight ;
TmpGrid.PrintSettings.PagePrefix := 'Sayfa' ;
TmpGrid.PrintSettings.FooterSize := 130 +GridFooter;
TmpGrid.PrintSettings.FooterFont.Charset := TURKISH_CHARSET ;
TmpGrid.PrintSettings.FooterFont.Color := clSilver  ;
TmpGrid.PrintSettings.FooterFont.Height := -11 ;
TmpGrid.PrintSettings.FooterFont.Name := 'Tahoma' ;
TmpGrid.PrintSettings.FooterFont.Style := [] ;
TmpGrid.PrintSettings.RepeatFixedRows := True ;
TmpGrid.PrintSettings.PrintGraphics := True;
TmpGrid.PrintSettings.NoAutoSize := True   ;
TmpGrid.PrintSettings.NoAutoSizeRow := True ;



if Sayfa = 'Yatay' then begin
printer.Orientation := poLandscape ;
TmpGrid.PrintSettings.Orientation := poLandscape ;

TmpGrid.PrintSettings.TitleLines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '--------------------------------------------------------');
TmpGrid.PrintSettings.TitleLines.Add('Firma Ad� :' +TmpKayitIsmi+'                                                                                                 '+
                                        '                                         Mali Y�l:   '+Maliyil);
TmpGrid.PrintSettings.TitleLines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '--------------------------------------------------------');
TmpGrid.PrintSettings.TitleLines.Add('xx V.1.0 ');
end;




if Sayfa = 'Dikey' then begin
printer.Orientation := poPortrait ;
TmpGrid.PrintSettings.Orientation := poPortrait ;

TmpGrid.PrintSettings.TitleLines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '--------------------------------------------------------');
TmpGrid.PrintSettings.TitleLines.Add('Firma Ad� :' +TmpKayitIsmi+'                                                                                                 '+
                                        '              Mali Y�l:   '+Maliyil);
TmpGrid.PrintSettings.TitleLines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '----------------------------------------------------------------------------------------------------------------------------------------------------------------'+
                                        '--------------------------------------------------------');
TmpGrid.PrintSettings.TitleLines.Add('xx V.1.0 ');
end;

AdvPrev :=TAdvPreviewDialog.Create(FormAdi);
with AdvPrev do  begin
  DialogCaption := '�nizleme' ;
  DialogPrevBtn := '�nceki'  ;
  DialogNextBtn := 'Sonraki'   ;
  DialogPrintBtn := 'Yazd�r';
  DialogCloseBtn := 'Kapat' ;
  Grid := TmpGrid ;
  PreviewFast := False ;
  PreviewWidth := 500 ;
  PreviewHeight := 500 ;
  PreviewLeft := 100  ;
  PreviewTop := 100 ;
  PreviewCenter := False   ;
  PrinterSetupDialog := False ;
  PrintSelectedRows := False ;
  PrintSelectedCols := False ;
  PrintSelection := False   ;
end;
if Islem = 'Yazd�r' then TmpGrid.Print;
if Islem = 'G�r�nt�le' then AdvPrev.Execute;
end;


function SayiYapar(TmpTxt:string):Double;
var i:integer;
    TmpSayi:string;
    begin
Result :=0;
TmpSayi:='';
if  length(TmpTxt)=0 then
       exit;

for i:=0 to length(TmpTxt) do
  begin
    if TmpTxt[i] in ['0'..'9', DecimalSeparator] then
       TmpSayi := TmpSayi + TmpTxt[i];
  end;
if  TmpSayi<>'' then
Result:=StrToFloat(TmpSayi);

end;

function  HataliBelgeNo(CariKod,FisTuru,BelgeNo:String):Boolean ;
begin
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * from InvoiceExtre2005 ');
  SQL.Add('Where CariKod=:ActCariKod and InvoiceType=:ActInvoiceType And InvoiceNumber=:ActInvoiceNumber');
  Parameters.ParamByName('ActCariKod').Value        :=CariKod;
  Parameters.ParamByName('ActInvoiceType').Value    :=FisTuru;
  Parameters.ParamByName('ActInvoiceNumber').Value  :=BelgeNo;
  Prepared ;
  Open;
  if recordcount=0 then
     Result :=False
  else
  begin
    FrmUyari:=TFrmUyari.Create(Application);
    FrmUyari.lblCaption.Caption:='Belge No Daha �nce Kullan�lm��t�r.';
    FrmUyari.ShowModal;
    FrmUyari.Release;
    Result :=True;
  end;
end;
end;

procedure StokCikisSil(StockCode,OpType,OpNumber,DepoID:String);
// *** Stok Hareket Kay�tlar�n� G�nceller Yapar;
// *** Create Date : 29.05.2005
// *** Last Update :
var
  ActID:integer;
  EskiMiktar:Double;
begin
maliyil:='2005';
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select ID,OutValue From StockExtre'+maliyil +' Where ');
  SQL.Add('StockCode=:StockCode and OpType=:OpType and OpNumber=:OpNumber');
  Parameters.ParamByName('StockCode').Value :=StockCode;
  Parameters.ParamByName('OpType').Value    :=OpType;
  Parameters.ParamByName('OpNumber').Value  :=OpNumber;
  Prepared;
  Open;
  ActID     :=FieldByName('ID').AsInteger;
  EskiMiktar:=FieldByName('OutValue').AsFloat;
  // depolar� G�ncelle
  Close;
  SQL.Clear;
  SQL.Add('Update DepoMiktar Set DCikis=DCikis-:EskiMiktar ' );
  SQL.Add('where DepoNo=:DepoNo and StokKod=:Bul ');
  Parameters.ParamByName('bul').Value:=StockCode;
  Parameters.ParamByName('DepoNo').Value:=DepoID;
  Parameters.ParamByName('EskiMiktar').Value:=EskiMiktar;
  Prepared ;
  ExecSQL;
  // stok Tablosunu G�ncelle
  Close;
  SQL.Clear;
  SQL.Add('Update Stock Set  StockAmount=StockAmount+:yeni Where StockCode=:Bul ');
  Parameters.ParamByName('Yeni').Value:=EskiMiktar;
  Parameters.ParamByName('bul').Value :=StockCode;
  Prepared ;
  ExecSQL;
  // *** Stock Extreden sil
  Close;
  SQL.Clear;
  SQL.Add('Delete *  From StockExtre'+maliyil +' Where ID=:ActID');
  Parameters.ParamByName('ActID').Value :=ActID;
  Prepared ;
  ExecSQL;
end;
end;

procedure CariHareketKayit(HareketTur,CariKod,OpType,OpDate,OpNumber,OpDefinition:String;Miktar:Double);
// *** Cari Hesaba ve extreye kaydet
// *** Create Date : 23.05.2005
// *** Last Update :
// HareketTur:'B' bor� ;HareketTur:'A' alacak
// OpType:'MS' mal sat��,NK Nakit �deme,CK �ek �deme
// CariExtre2005 :ID	CariKod	OpStatus	OpDate	OpNumber	OpDefinition	InValue	OutValue
// CariHesap:CariKod ,	InValue	,OutValue
var
  Durum:String;
begin
with DM.Qrylist do
begin
if (HareketTur='B') or (HareketTur='b') then
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * from CariExtre2005 ');
  Prepared ;
  Open;
  Append;
    FieldByName('CariKod').AsString       :=CariKod;
    FieldByName('OpStatus').AsString      :='S';
    FieldByName('OpDate').AsString        :=OpDate;
    FieldByName('OpType').AsString        :=OpType;
    FieldByName('OpNumber').AsString      :=OpNumber;
    FieldByName('OpDefinition').AsString  :=OpDefinition;
    FieldByName('InValue').AsFloat        :=Miktar;
    FieldByName('OutValue').AsFloat       :=0;
  post;
  Close;
  SQL.Clear;
  SQL.Add('Update CariHesap Set InValue=InValue+:actInValue Where CariKod=:actCariKod ');
  Parameters.ParamByName('actInValue').Value:=Miktar;
  Parameters.ParamByName('actCariKod').Value:=CariKod;
  Prepared ;
  ExecSQL;
end
else
begin
  // *** ��lem tarihi kontrol et..
  if StrToDate(OpDate)<= date then
    durum:='+'
  else
    durum:='-';
  Close;
  SQL.Clear;
  SQL.Add('Select * from CariExtre2005 ');
  Prepared ;
  Open;
  Append;
    FieldByName('CariKod').AsString       :=CariKod;
    if  OpType='CK' then
      FieldByName('OpStatus').AsString:=durum
    else
      FieldByName('OpStatus').AsString:='*';
    FieldByName('OpDate').AsString        :=OpDate;
    FieldByName('OpType').AsString        :=OpType;
    FieldByName('OpNumber').AsString      :=OpNumber;
    FieldByName('OpDefinition').AsString  :=OpDefinition;
    FieldByName('InValue').AsFloat        :=0;
    FieldByName('OutValue').AsFloat       :=Miktar;
  post;
// CariHesap:CariKod ,	InValue	,OutValue
  Close;
  SQL.Clear;
  SQL.Add('Update CariHesap Set OutValue=OutValue+:actOutValue Where CariKod=:actCariKod ');
  Parameters.ParamByName('actOutValue').Value:=Miktar;
  Parameters.ParamByName('actCariKod').Value:=CariKod;
  Prepared ;
  ExecSQL;
end;
end;
end;

procedure MalSatisSil(CariKod,InvoiceNumber,BelgeTuru:String;EskiMiktar:Double);
// *** Cari Hesab ve extreden kay�t  Mal Sat�� Bilgisi silme
// *** Create Date : 29.05.2005
// *** Last Update :
// CariExtre2005 :ID	CariKod	OpStatus	OpDate	OpNumber	OpDefinition	InValue	OutValue
// CariHesap:CariKod ,	InValue	,OutValue
begin
with DM.Qrylist do
begin
// mal sat�� i�lemi  Silme
  Close;
  SQL.Clear;
  SQL.Add('Update CariHesap Set InValue=InValue-:actInValue Where CariKod=:actCariKod ');
  Parameters.ParamByName('actInValue').Value:=EskiMiktar;
  Parameters.ParamByName('actCariKod').Value:=CariKod;
  Prepared ;
  ExecSQL;
// *** Cari Extreden silme i�lemi
  Close;
  SQL.Clear;
  SQL.Add('Delete * from CariExtre2005 Where  ');
  SQL.Add('OpType=:ActOpType and  CariKod=:ActCariKod and OpNumber=:ActOpNumber');
  Parameters.ParamByName('ActOpType').Value  :='MS';
  Parameters.ParamByName('ActCariKod').Value :=CariKod;
  Parameters.ParamByName('ActOpNumber').Value:=InvoiceNumber;
  Prepared ;
  ExecSQL;
end;
end;

procedure CariHareketSil(actID:Integer);
// *** Cari Hesab ve extreden kay�t silme
// *** Create Date : 23.05.2005
// *** Last Update :
// HareketTur:'B' bor� ;HareketTur:'A' alacak
// OpType:'MS' mal sat��,NK Nakit �deme,CK �ek �deme
// CariExtre2005 :ID	CariKod	OpStatus	OpDate	OpNumber	OpDefinition	InValue	OutValue
// CariHesap:CariKod ,	InValue	,OutValue
var
  EskiMiktar:Double;
  CariKod,OpType,OpDate,InvoiceNumber,OpNumber:String;
begin
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * from InvoicePayment2005 Where ID=:actID');
  Parameters.ParamByName('actID').Value:=actID;
  Prepared ;
  Open;
  EskiMiktar:=FieldByName('OpAmount').AsFloat;
  OpType    :=FieldByName('OpType').AsString;
  CariKod   :=FieldByName('CariKod').AsString;
  OpDate    :=FieldByName('OpDate').AsString;
  OpNumber  :=FieldByName('OpNumber').AsString;
  InvoiceNumber  :=FieldByName('InvoiceNumber').AsString;

// *** i�lemleri yap
if  OpType='MS' then // mal sat�� i�lemi  Silme
begin
  Close;
  SQL.Clear;
  SQL.Add('Update CariHesap Set InValue=InValue-:actInValue Where CariKod=:actCariKod ');
  Parameters.ParamByName('actInValue').Value:=EskiMiktar;
  Parameters.ParamByName('actCariKod').Value:=CariKod;
  Prepared ;
  ExecSQL;
end;
if OpType='NK' then  // nakit odeme
begin
  Close;
  SQL.Clear;
  SQL.Add('Update CariHesap Set OutValue=OutValue-:actOutValue Where CariKod=:actCariKod ');
  Parameters.ParamByName('actOutValue').Value :=EskiMiktar;
  Parameters.ParamByName('actCariKod').Value  :=CariKod;
  Prepared ;
  ExecSQL;
end;
if (OpType='CK') and (StrToDate(OpDate)<= date) then
begin
  Close;
  SQL.Clear;
  SQL.Add('Update CariHesap Set OutValue=OutValue-:actOutValue Where CariKod=:actCariKod ');
  Parameters.ParamByName('actOutValue').Value :=EskiMiktar;
  Parameters.ParamByName('actCariKod').Value  :=CariKod;
  Prepared ;
  ExecSQL;
end;
// *** Cari Extreden silme i�lemini yap   cek no kullan CK ise
  Close;
  SQL.Clear;
  SQL.Add('Delete * from CariExtre2005 Where  ');
  SQL.Add('OpType=:ActOpType and  CariKod=:ActCariKod and OpNumber=:ActOpNumber');
  Parameters.ParamByName('ActOpType').Value  :=OpType;
  Parameters.ParamByName('ActCariKod').Value :=CariKod;
  if (OpType='CK') then
    Parameters.ParamByName('ActOpNumber').Value:=OpNumber
  else
    Parameters.ParamByName('ActOpNumber').Value:=InvoiceNumber;
  Prepared ;
  ExecSQL;
// *** InvoicePayment2005 den silme i�lemini yap
  Close;
  SQL.Clear;
  SQL.Add('Delete * from InvoicePayment2005 Where  ID=:ActID ');
  Parameters.ParamByName('ActID').Value  :=ActID;
  Prepared ;
  ExecSQL;
end;
end;

function DMiktarKontrol(StokKod,DepoNo:String;miktar:Double):Boolean ;
// *** Depo Miktar Kontrolu Yapar;
// *** Create Date : 01.05.2005
// *** Last Update :
begin
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select (DGiris-DCikis) as Fark From DepoMiktar Where DepoNo=:DepoNo and StokKod=:StokKod');
  Parameters.ParamByName('DepoNo').Value:=DepoNo;
  Parameters.ParamByName('StokKod').Value:=StokKod ;
  Prepared ;
  open;
  if recordcount=0 then
  begin
    FrmUyari:=TFrmUyari.Create(Application);
    FrmUyari.lblCaption.Caption:='�r�n Depoda Kay�tl� De�il.';
    FrmUyari.ShowModal;
    FrmUyari.Release;
    Result :=False;
    exit;
  end;
  if FieldByName('fark').AsFloat < Miktar then
    begin
      FrmUyari:=TFrmUyari.Create(Application);
      FrmUyari.lblCaption.Caption:=StokKod +' Kodlu �r�n i�in Depoda Yeterli Miktar Yok.'+#13+
                                  '�u Anki Depo Miktar� :'+FormatFloat(',0.000',FieldByName('fark').AsFloat)  ;
      FrmUyari.ShowModal;
      FrmUyari.Release;
      Result :=False;
    end
  else
    Result:=True;
end;
end;

procedure StokHareketi(StockCode,OpDate,OpNumber,OpDefinition,OpType,DepoID:String;HareketTur:Integer;Miktar:Double);
// *** Stok Hareket Kay�tlar� Yapar;
// *** Create Date : 01.05.2005
// *** Last Update : 31.03.2007 tablo adi� ve field isimleri...
// HareketTur=0 stok giri� / HareketTur=1 stok ��k��
// OpType:VS Veresiye Sat��

begin
maliyil:='2007';
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * From StokExtre'+maliyil);
  Prepared ;
  Open;
  Append;
    FieldByName('Stokkod').AsString :=StockCode;
    FieldByName('Tarih').AsString   :=OpDate;
    FieldByName('BelgeNo').AsString :=OpNumber;
    FieldByName('tur').AsString     :=OpType;
    FieldByName('Aciklama').AsString:=OpDefinition;
    if HareketTur=0 then
    begin
      FieldByName('Giris').AsFloat :=Miktar;
      FieldByName('Cikis').AsFloat :=0;
    end
    else
    begin
      FieldByName('Giris').AsFloat :=0;
      FieldByName('Cikis').AsFloat :=Miktar;
    end;
    FieldByName('DepoNo').AsString :=DepoID ;
  post;
  // depolar� G�ncelle
  Close;
  SQL.Clear;
  SQL.Add('Select * From DepoMiktar where DepoNo=:DepoNo and StokKod=:Bul ');
  Parameters.ParamByName('bul').Value   :=StockCode;
  Parameters.ParamByName('DepoNo').Value:=DepoID;
  Prepared ;
  Open;
  if recordcount=0 then
  begin
    Append;
    FieldByName('StokKod').AsString :=StockCode;
    FieldByName('DepoNo').AsString  :=DepoID;
    if HareketTur=0 then
      FieldByName('DGiris').AsFloat :=FieldByName('DGiris').AsFloat + Miktar
    else
      FieldByName('DCikis').AsFloat :=FieldByName('DCikis').AsFloat + Miktar;
    post;
  end
  else
  begin
    Edit;
    if HareketTur=0 then
      FieldByName('DGiris').AsFloat :=FieldByName('DGiris').AsFloat + Miktar
    else
      FieldByName('DCikis').AsFloat :=FieldByName('DCikis').AsFloat + Miktar;
    post;
  end;
  // stok Tablosunu G�ncelle
  Close;
  SQL.Clear;
  if HareketTur=0 then
    SQL.Add('Update Stok Set  StockAmount=StockAmount+:yeni Where StockCode=:Bul ')
  else
    SQL.Add('Update Stok Set  StockAmount=StockAmount-:yeni Where StockCode=:Bul ');
  Parameters.ParamByName('Yeni').Value:=Miktar;
  Parameters.ParamByName('bul').Value :=StockCode;
  Prepared ;
  ExecSQL;
end;
end;

procedure StokHareketiSil(RecIDNo,StockCode,DepoID:String;EskiMiktar:Double;HareketTur:integer);
// *** Stok Hareket Kay�tlar�n� G�nceller Yapar;
// *** Create Date : 08.05.2005
// *** Last Update :  01.12.2005
begin
maliyil:='2005';
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Delete * From StockExtre'+maliyil +' Where ID='+ RecIDNo);
  ExecSQL;
  // depolar� G�ncelle
  Close;
  SQL.Clear;
  SQL.Add('Select * From DepoMiktar where DepoNo=:DepoNo and StokKod=:Bul ');
  Parameters.ParamByName('bul').Value   :=StockCode;
  Parameters.ParamByName('DepoNo').Value:=DepoID;
  Prepared ;
  Open;
  Edit;
    if HareketTur=0 then
      FieldByName('DGiris').AsFloat :=FieldByName('DGiris').AsFloat - EskiMiktar
    else
      FieldByName('DCikis').AsFloat :=FieldByName('DCikis').AsFloat - EskiMiktar;
  post;
  // stok Tablosunu G�ncelle
  Close;
  SQL.Clear;
  if HareketTur=0 then
    SQL.Add('Update Stock Set  StockAmount=StockAmount-:yeni Where StockCode=:Bul ')
  else
    SQL.Add('Update Stock Set  StockAmount=StockAmount+:yeni Where StockCode=:Bul ');
  Parameters.ParamByName('Yeni').Value:=EskiMiktar;
  Parameters.ParamByName('bul').Value :=StockCode;
  Prepared ;
  ExecSQL;
end;
end;

procedure GelirGiderKaydet(Tur,CekTip,HesapKod,Tarih,BelgeNo,Aciklama,BHesapNo,ProgCode:String;Banka:Boolean;Miktar:Double);
{ *** Gelir Kay�tlar� Yapar;
  *** Create Date : 08.05.2005
  *** Last Update : 12.05.2005/20.05.2005/07.09.2005
  Tur='Gider' -->  Gider ��lemi, Tur='Gelir' --> Gelir ��lemi
ID	GCode	OpDate	OpNumber	OpDefinition	InValue	OutValue	BHesapNo	ProgCode }
var
  Durum:String;
begin
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * from InOutExtre2005 ');
  Prepared ;
  open;
  Append;
    FieldByName('GCode').AsString       :=HesapKod;
    FieldByName('OpDate').AsString      :=Tarih;
    FieldByName('OpNumber').AsString    :=BelgeNo;
    FieldByName('OpDefinition').AsString:=Aciklama;
    if Tur ='Gelir' then
    begin
      FieldByName('InValue').AsFloat :=Miktar;
      FieldByName('OutValue').AsFloat:=0;
    end
    else
    begin
      FieldByName('InValue').AsFloat :=0;
      FieldByName('OutValue').AsFloat:=Miktar;
    end;
    if Banka=True then
      FieldByName('BHesapNo').AsString :=BHesapNo
    else
      FieldByName('BHesapNo').AsString :='---';
    FieldByName('ProgCode').AsString:=ProgCode;
  post;
  // *** Hesaplar�n� Bakiyelerini g�ncelle ...
  //   GCode	GDefinition	GType	InValue	OutValue	RezCode
  Close;
  SQL.Clear;
  if Tur ='Gelir' then SQL.Add('Update InOutInfo2005 Set InValue=InValue+:Amount ') ;
  if Tur ='Gider' then SQL.Add('Update InOutInfo2005 Set OutValue=OutValue+:Amount ');
  SQL.Add('Where GCode=:Bul');
  Parameters.ParamByName('Amount').Value:=Miktar;
  Parameters.ParamByName('Bul').Value   :=HesapKod;
  Prepared ;
  ExecSQL;
  // *** E�er Banka ile �li�ki varsa Banka Extreye Yazd�r ;
  // ID	Durum	BHesapNo	OpDate	OpNumber	OpDefinition	InValue	OutValue	ProgCode
if Banka=True then
begin
    if date>=StrToDate(Tarih) then
      durum:='+'
    else
      durum:='-';
  Close;
  SQL.Clear;
  SQL.Add('Select * From BankExtre2005');
  Prepared ;
  Open;
  Append;
    FieldByName('Durum').AsString       :=Durum;
    FieldByName('BHesapNo').AsString    :=BHesapNo;
    FieldByName('OpDate').AsString      :=Tarih;
    FieldByName('OpNumber').AsString    :=BelgeNo;
    FieldByName('OpDefinition').AsString:=Aciklama;
    if Tur ='Gelir' then
    begin
      FieldByName('InValue').AsFloat:=Miktar;
      FieldByName('OutValue').AsFloat:=0;
    end
    else
    begin
      FieldByName('InValue').AsFloat:=0;
      FieldByName('OutValue').AsFloat:=Miktar;
    end;
   FieldByName('ProgCode').AsString:=ProgCode;
   FieldByName('RType').AsString    :=CekTip;
   Post;
   Close;
   Sql.Clear;
   if Tur ='Gelir' then
   begin
    SQL.Add('Update Bank Set Borc=Borc+:Amount ');
    SQL.Add('Where BHesapNo=:Bul');
    Parameters.ParamByName('Amount').Value :=Miktar;
    Parameters.ParamByName('Bul').Value    :=BHesapNo;
    Prepared ;
    ExecSQL;
   end;
   if (Durum='+') and  (Tur ='Gider') then
   begin
    SQL.Add('Update Bank Set Alacak=Alacak+:Amount ');
    SQL.Add('Where BHesapNo=:Bul');
    Parameters.ParamByName('Amount').Value :=Miktar;
    Parameters.ParamByName('Bul').Value    :=BHesapNo;
    Prepared ;
    ExecSQL;
   end;
end;
end;
end;

procedure GelirGiderSil(ActRecID,Tur:String;Banka:Boolean);
// *** Gelir Kay�tlar�n� G�nceller ;
// *** Create Date : 08.05.2005
// *** Last Update : 12.05.2005
var
  HesapKod,Tarih,BelgeNo,BHesapNo:String;
  EskiMiktar,Miktar:Double;
begin
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * from InOutExtre2005 Where ID=:Bul');
  Parameters.ParamByName('Bul').Value:=ActRecID;
  Prepared ;
  Open;
    HesapKod:=FieldByName('GCode').AsString;
    Tarih   :=FieldByName('OpDate').AsString;
    BelgeNo :=FieldByName('OpNumber').AsString;
    Miktar  :=FieldByName('InValue').AsFloat + FieldByName('OutValue').AsFloat;
    BHesapNo:=FieldByName('BHesapNo').AsString;
  (* Hesaplar�n� Bakiyelerini g�ncelle ...
     GCode	GDefinition	GType	InValue	OutValue	RezCode *)
  Close;
  SQL.Clear;
  SQL.Add('Select * From InOutInfo2005 Where GCode=:Bul');
  Parameters.ParamByName('Bul').Value   :=HesapKod;
  Prepared;
  Open;
  Edit;
    EskiMiktar:=FieldByName('InValue').AsFloat + FieldByName('OutValue').AsFloat;
    if Tur ='Gelir' then
      FieldByName('InValue').AsFloat:=EskiMiktar-Miktar
    else
      FieldByName('OutValue').AsFloat:=EskiMiktar-Miktar;
  post;
  // *** E�er Banka ile �li�ki varsa Banka Hesaplar�n� g�ncelle;
  {ID	Durum	BHesapNo	OpDate	OpNumber	OpDefinition	InValue	OutValue	ProgCode }
if Banka=True then
begin
  Close;
  SQL.Clear;
  SQL.Add('Delete * From BankExtre2005 Where OpNumber=:BelgeNo And BHesapNo=:BHesapNo');
  Parameters.ParamByName('BelgeNo').Value :=BelgeNo;
  Parameters.ParamByName('BHesapNo').Value:=BHesapNo;
  Prepared ;
  ExecSQL;
  Close;
  SQL.Clear;
  if Tur ='Gelir' then
  begin
    SQL.Add('Update Bank Set Borc=Borc-:Amount ');
    SQL.Add('Where BHesapNo=:Bul');
    Parameters.ParamByName('Amount').Value :=Miktar;
    Parameters.ParamByName('Bul').Value    :=BHesapNo;
    Prepared ;
    ExecSQL;
  end;
  if (Tur ='Gider') and (date>=StrToDate(Tarih)) then
  begin
    SQL.Add('Update Bank Set Alacak=Alacak-:Amount Where BHesapNo=:Bul');
    Parameters.ParamByName('Amount').Value :=Miktar;
    Parameters.ParamByName('Bul').Value    :=BHesapNo;
    Prepared ;
    ExecSQL;
  end;
end;
  Close;
  SQL.Clear;
  SQL.Add('Delete * from InOutExtre2005 Where ID=:Bul');
  Parameters.ParamByName('Bul').Value:=ActRecID;
  Prepared ;
  ExecSQL;
end;
end;

procedure BankaHareketKayit(Tur,Tip,BHesapNo,Tarih,BelgeNo,Aciklama,ProgCode:String;Miktar:Double);
{ *** Banka Hareket Kay�tlar� Yapar;
  Tur=1 ise Yat�r�m,Tur=0 ise �ek
  Tip =NY :Nakit Yat�r�m,Tip =KC :Kendi �ekimiz,Tip =MC :M��teri �eki
  *** Create Date : 08.05.2005
  *** Last Update : 11.05.2005 program codu eklendi..
  *** Last Update : 29.05.2005 M��teri �ek Atarma i�in kontrol eklendi..}
var
  durum:String;
begin
with DM.Qrylist do
begin
  if date>=StrToDate(Tarih) then
      durum:='+'
    else
      durum:='-';
  Close;
  SQL.Clear;
  SQL.Add('Select * From BankExtre2005');
  Prepared ;
  Open;
  Append;
  if  Tur='1' then
    FieldByName('Durum').AsString       :='*'
  else
    FieldByName('Durum').AsString       :=Durum;
    FieldByName('BHesapNo').AsString    :=BHesapNo;
    FieldByName('OpDate').AsString      :=Tarih;
    FieldByName('OpNumber').AsString    :=BelgeNo;
    FieldByName('OpDefinition').AsString:=Aciklama;
    if Tur ='1' then
    begin    // Yat�r�m
      FieldByName('InValue').AsFloat:=Miktar;
      FieldByName('OutValue').AsFloat:=0;
    end
    else
    begin   // �ek
      if Tip='KC' then
      begin // Kendi �ekimiz
        FieldByName('InValue').AsFloat:=0;
        FieldByName('OutValue').AsFloat:=Miktar;
      end
      else
      begin // M�steri �eki
        FieldByName('InValue').AsFloat:=Miktar;
        FieldByName('OutValue').AsFloat:=0;
      end
    end;
    FieldByName('ProgCode').AsString :=ProgCode;
    FieldByName('RType').AsString    :=Tip;
   Post;
   Close;
   Sql.Clear;
  if Tur ='1' then
  begin
    SQL.Add('Update Bank Set Borc=Borc+:Amount Where BHesapNo=:Bul');
    Parameters.ParamByName('Amount').Value :=Miktar;
    Parameters.ParamByName('Bul').Value    :=BHesapNo;
    Prepared ;
    ExecSQL;
  end ;
  if (Tur ='0') and (Durum='+') and (Tip='MC')  then
  begin
    SQL.Add('Update Bank Set Borc=Borc+:Amount Where BHesapNo=:Bul');
    Parameters.ParamByName('Amount').Value :=Miktar;
    Parameters.ParamByName('Bul').Value    :=BHesapNo;
    Prepared ;
    ExecSQL;
  end ;
  if (Tur ='0') and (Durum='+') and (Tip='KC')  then
  begin
    SQL.Add('Update Bank Set Alacak=Alacak+:Amount Where BHesapNo=:Bul');
    Parameters.ParamByName('Amount').Value :=Miktar;
    Parameters.ParamByName('Bul').Value    :=BHesapNo;
    Prepared ;
    ExecSQL;
  end;
end;
end;

procedure BankaHareketSil(actRecID,Tur,BHesapNo:String);
{ *** Banka Hareket Kay�tlar�ni Siler;
  Tur=1 ise Yat�r�m,Tur=0 ise �ek
  Tip =NY :Nakit Yat�r�m,Tip =KC :Kendi �ekimiz,Tip =MC :M��teri �eki
  *** Create Date : 08.05.2005
  *** Last Update : }
var
  durum:String;
  EskiMiktar:Double;
begin
with DM.Qrylist do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * From BankExtre2005 Where ID='+actRecID);
  Prepared ;
  Open;
  EskiMiktar:=FieldByName('InValue').AsFloat+FieldByName('OutValue').AsFloat;
  durum     :=FieldByName('Durum').AsString;
  Close;
  SQL.Clear;
 if Tur ='1' then
  begin
    SQL.Add('Update Bank Set Borc=Borc-:Amount Where BHesapNo=:Bul');
    Parameters.ParamByName('Amount').Value :=EskiMiktar;
    Parameters.ParamByName('Bul').Value    :=BHesapNo;
    Prepared ;
    ExecSQL;
  end
  else
  if Durum='+' then
  begin
    SQL.Add('Update Bank Set Alacak=Alacak-:Amount Where BHesapNo=:Bul');
    Parameters.ParamByName('Amount').Value :=EskiMiktar;
    Parameters.ParamByName('Bul').Value    :=BHesapNo;
    Prepared ;
    ExecSQL;
  end;

    Close;
  SQL.Clear;
  SQL.Add('Delete * from BankExtre2005 ');
  SQL.Add('Where ID='+ActRecID);
  Prepared ;
  ExecSQL;
end;
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


Function yuzler(x : String) : String;
Begin
case StrToInt(x) of
0   : yuzler := ''          ;
1   : yuzler := 'y�z '      ;
2   : yuzler := 'ikiy�z '   ;
3   : yuzler := '��y�z '    ;
4   : yuzler := 'd�rty�z '  ;
5   : yuzler := 'be�y�z '   ;
6   : yuzler := 'alt�y�z '  ;
7   : yuzler := 'yediy�z '  ;
8   : yuzler := 'sekizy�z ' ;
9   : yuzler := 'dokuzy�z ' ;
end;
end;

Function onlar(x : String) : String ;
Begin
case StrToInt(x) of
0   : onlar := ''       ;
1   : onlar := 'on '    ;
2   : onlar := 'yirmi ' ;
3   : onlar := 'otuz '  ;
4   : onlar := 'k�rk '  ;
5   : onlar := 'elli '  ;
6   : onlar := 'atm�� ' ;
7   : onlar := 'yetmi� ';
8   : onlar := 'seksen ';
9   : onlar := 'doksan ';
end ;
end;

Function birler(x : String) : String;
begin
case StrToInt(x) of
0   : birler := ''      ;
1   : birler := 'bir '  ;
2   : birler := 'iki '  ;
3   : birler := '�� '   ;
4   : birler := 'd�rt ' ;
5   : birler := 'be� '  ;
6   : birler := 'alt� ' ;
7   : birler := 'yedi ' ;
8   : birler := 'sekiz ';
9   : birler := 'dokuz ';
end;
end;

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

  NumberToText:=R05+R04+R03+R02+R01;
end;




Function  NumberTokurus(Number:String):String;
Var
    y,o,b:String;
begin
y:='';
o:='';
b:='';
  if copy(number,1,1)<>'0' then
    o:=onlar(copy(number,1,1));
  if copy(number,2,1)<>'0' then
    b:=birler(copy(number,2,1));
  NumberTokurus:=o+b;
end;

end.

