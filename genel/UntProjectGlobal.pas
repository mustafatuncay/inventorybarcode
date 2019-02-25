unit UntProjectGlobal;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ImgList, ComCtrls, ToolWin,
  Mask, Db, DBClient, DBTables, ADODB,shellapi,QuickRpt,QRCtrls,
  Jpeg,AdvGrid,ComObj,registry,winsock,Variants, BaseGrid,  DBAdvGrd,printers, asgprint, asgprev ,
  Menus;


  type
  TRGBArray = array[0..32767] of TRGBTriple;
  PRGBArray = ^TRGBArray;
type tMTNDRM = (tNormal,tTBuyuk,tTKucuk);

//  type tarihparacasi = (Gun, Ay, Yil);

function  SayiYapar(TmpTxt:string):Double;
Function  GirdiKontrol(fForm : Tform ; Typ:string ):integer ;
procedure ResimYukleQRP(Fform:TQuickRep ; Field:string ; Target:string);
procedure LabelYukleQRP(Fform:TQuickRep ; Field:string ; Target:string;z:integer);
procedure ResimYukle(Fform:Tform ; Field:string;TmpDMQRY:TADOQuery);
procedure ResimKaydet(Fform:Tform ; Field:string);
function  baglan(txtip : TEdit;DBname,DBpass,DBuser:string): Boolean;
procedure convertoip(txt: TEdit);
procedure ResimAl(img:TBitmap;Field,Sql:string; TmpDMQRY:TADOQuery);
procedure SetDBimg(img:TBitmap;Field,Sql:string; TmpDMQRY:TADOQuery);
procedure GetDbimg(img:TImage;Field,Sql:string; TmpDMQRY:TADOQuery);
procedure menuyarat(frm:Tform);
procedure SetDBbinary(filename,Field:string;TmpDMQRY:TADOQuery);
procedure GetDBbinary(filename,Field:string;TmpDMQRY:TADOQuery);
procedure insertDBbinary(filename,Field,Sql:string; TmpDMQRY:TADOQuery);
procedure insertDbDosya(Dpath,filename:string; TmpDMQRY:TADOQuery);
procedure GetDbDosyalar(TmpDMQRY:TADOQuery);
function  datapart(t: string;tarih:TDate):string;

function   depoKalanmiktar(depokodu,urunkodu:string;miktar:Double):Double; // depodaki miktar - g�nderdimiz mikarf
function  DepoKalanMiktarBul(depokodu,urunkodu:string;miktar:Double):Boolean ;
procedure getwindirs();
Function  YTLDonustur(SAYINE:Double;MetinDRM:tMTNDRM):STRING;
Function  _Metne_Cevir_ (Number :Double):String;
function  HardDriveSerial : Cardinal;
function  Generator : String;

function  RoundC(x: currency): currency;


function  EncDec(str:string):string;
procedure FooterBas(QRep : TQuickRep );
procedure RaporYarat(QRep : TQuickRep; TmpQry:TAdoQuery; TmpGrid:TDBGrid;BColheader:TQRBand;BDetail:TQRBand;BPFooter:TQRBand);
Procedure AdvStrYazdir(FormAdi:TForm;TmpGrid:TAdvStringGrid;Islem:String;Sayfa:String);
Procedure AdvDBYazdir(FormAdi:TForm;TmpGrid:TDBAdvStringGrid;Islem:String;Sayfa:String);
//Procedure AdvDBExceleAktar(FormAdi:TForm;Grid:TDBAdvStringGrid);
//Procedure AdvStrExceleAktar(FormAdi:TForm;Grid:TAdvStringGrid);
procedure DBGridDenExcele(DBG:TDBGrid; FileName:String);
procedure RepSayfaNumarasi(QRep : TQuickRep; FormAdi:TForm;SatirSayisi:currency);
procedure sirala(tmpqry1: TADOQuery);
function  colonbultms(grd:TDBAdvStringGrid;capt:string):integer ;
procedure Grdalttoplam(grd:TDBAdvStringGrid;colname:array of string);
procedure MemoYukleQRP(Fform:TQuickRep ; Target:string);
function  fileisim(isim:string):string;
function  boyutal(iFile: integer): string;
Function DelTree(DirName : string): Boolean;
function IsInteger(const Str: String): Boolean;





var
path:string;
aktifform,PubPYonetim:Integer;
aktifhwnd:THandle;
maliyil:string;
Mbp:string;
serverip:string;
SirketID:Integer;
userDB:string;
UserID:integer;
Kullanici:string;
KullaniciAdi:string;
KullaniciSadi:string;
kayitliolduguDB:string;
KullaniciEmail:string;
KullaniciPerkodu:string;
KullaniciPerId:Integer;
KullaniciPerbolum:string;
gizlikotgor:Boolean;
sirketler : array of string;
sirketlerDb : array of string;
sirketsayisi:Integer;
CurrentPatika:String;

haklar:string;
TmpArsivGlobal:string;
GridFooter:Integer;

eskibinler,eskidate,eskidecimal:Char;


windir,shell32dir:string;

// UYGULAMA MOD�L� de�i�ken tan�mlar� (Ba�lad�)

 //   path:string;
 // i� se� formundan
  

 //  TalepKod :  (Yeni Proje A� ) Talep edilen i�lerin kodunu tutmaya yar�yor
     TalepKod : array[0..14] of string;

 //  TmpTalepKod :  Ge�ici Olarak Talep edilen i�lerin kodunu tutmaya yar�yor
     TmpTalepKod :string;

 //  IsDurumKod : (Yeni Proje A� )  i� durum  kodunu tutmaya yar�yor
     IsDurumKod :   array[0..5] of String = ('00','01','02','03','04','05');
     ArrYapilan :   array[0..9] of String  = ('A','B','C','D','E','F','G','H','I','j');
 //  IsDurum :  i� durum  kodunu n string hali
     IsDurum :   array[0..5] of String = ('Teklifi Verilmemi�','Teklifi Verilmi� Beklemede','OK Alm�� ve Beklemede','Ba�lam�� ve Devam Eden ��ler','Tamamlanm�� ��ler','�ptaldaki ��ler');

 // ProjeSe� formunun geldi�i form
     GeldigiForm : string;

     TmpClick:integer;


     TmpIsYerininAdi: string;

     TmpKayitIsmi,TmpSirketEmail : string;
     TmpTelefon : string;
     reg : Tregistry;
     HardDriveText: string;

   TmpSirketSicilNo,TmpAdres,TmpKayitNo,TmpStatu,TmpSSNo,Tmpfax,  Tmpfaaliyetturu: string;
   const tirnak = '''';







const ytl_ = ' NOKTA ';
const krs_ = '';


//Resourcestring
// ytl_ = ' NOKTA ';
// krs_ = '';

 {Resourcestring
 ytl_ = ' YTL';
 krs_ = ' YKR';  }


implementation

uses UntDm, DateUtils;

function IsInteger(const Str: String): Boolean;
var
  E, I: Integer;
begin
  Val(Str, I, E);
  Result := E = 0;
end;

Function DelTree(DirName : string): Boolean;
var
  SHFileOpStruct : TSHFileOpStruct;
  DirBuf : array [0..255] of char;
begin
  try
   Fillchar(SHFileOpStruct,Sizeof(SHFileOpStruct),0) ;
   FillChar(DirBuf, Sizeof(DirBuf), 0 ) ;
   StrPCopy(DirBuf, DirName) ;
   with SHFileOpStruct do begin
    Wnd := 0;
    pFrom := @DirBuf;
    wFunc := FO_DELETE;
    fFlags := FOF_ALLOWUNDO;
    fFlags := fFlags or FOF_NOCONFIRMATION;
    fFlags := fFlags or FOF_SILENT;
   end; 
    Result := (SHFileOperation(SHFileOpStruct) = 0) ;
   except
    Result := False;
  end;
end;


function boyutal(iFile: integer): string;
type
  TFileSizeEx = function(dw: integer; pszBuf: PChar; cchBuf: integer): PChar; stdcall;
var
  shlwapi_handle: THandle;
  iFile_FileSize: integer;
  Calculate_Size: TFileSizeEx;
  lpSize: array [0..50] of char;
begin
  if iFile > 0 then
begin
  iFile_FileSize := GetFileSize(iFile, nil);
  shlwapi_handle := LoadLibrary('shlwapi.dll');
if shlwapi_handle = 0 then
  Result:=InttoStr(iFile_FileSize) //+' bytes'
else
begin
  @Calculate_Size := GetProcAddress(shlwapi_handle, 'StrFormatByteSizeA');
if @Calculate_Size = nil then
  Result := InttoStr(iFile_FileSize) //+ ' bytes'
else
begin
  Calculate_Size(iFile_FileSize, lpSize, 50);
  Result := lpSize;
end;
end;
end
else
  Result := 'File Not Found';
  FreeLibrary(shlwapi_handle);
end;

function fileisim(isim: string): string;
var i:integer;
TmpStr : String;
begin

for i:=0 to length(isim) do begin
if isim[i]<> '\' then TmpStr:=TmpStr+isim[i]
Else TmpStr:='';
end;

result:=TmpStr;
end;




function SayiYapar(TmpTxt:string):Double;
var i:integer;
    TmpSayi:string;
    Isaret :char;
    begin
Result :=0;
Isaret := ThousandSeparator;
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



procedure ResimKaydet(Fform:Tform ; Field:string);
var
  jpeg: TJPEGImage;
  Stream: TMemoryStream;
  BlobField: TBlobField;
  MS: TMemoryStream;
  J1: TJPEGImage;
  i:integer;
begin

//Resim Kaydetme i�lemi (Ba�lad�)

BlobField := dm.Qrylist.FieldByName(Field) as TBlobField;

  jpeg := TJPEGImage.Create;
  try

  for i:=0 to  fform.ComponentCount-1 do
      begin
        if fform.components[i] is TImage then
           begin
             if TImage(fform.components[i]).Tag = 1 then
                 if (TImage(fform.components[i]).Picture.Graphic is TJPegImage) then
                     jpeg.Assign (TImage(fform.components[i]).Picture.Graphic);
            end;
      end;
    Stream := TMemoryStream.Create;
    try
       jpeg.SaveToStream (Stream);
       BlobField.LoadFromStream (Stream);
   finally
      Stream.Free;
    end;
  finally
    jpeg.Free;


  end;


//Resim Kaydetme i�lemi (Bitti)

end;


procedure ResimYukle(Fform:Tform ; Field:string; TmpDMQRY:TADOQuery);
var
  jpeg: TJPEGImage;
  Stream: TMemoryStream;
  BlobField: TBlobField;
  MS: TMemoryStream;
  J1: TJPEGImage;
   i:integer;
begin

// Resim Y�kleme ��lemi Ba�lad�
             J1 := TJPEGImage.Create;
               MS := TMemoryStream.Create;
               try
                 with TmpDMQRY do
                 begin
                 TBlobField(Fieldbyname(Field)).SaveToStream(MS);
                 end;

                 MS.Seek(0,soFromBeginning);

                 with J1 do begin
                   PixelFormat := jf24Bit;
                   Scale := jsFullSize;
                   Grayscale := False;
                   Performance := jpBestQuality;
                   ProgressiveDisplay := True;
                   ProgressiveEncoding := True;
                   LoadFromStream(MS);
                 end;

                 for i:=0 to  fform.ComponentCount-1 do
                     begin
                     if fform.components[i] is TImage then
                        begin
                        if TImage(fform.components[i]).Tag = 1 then

                        if MS.Size >0 then
                           TImage(fform.components[i]).Picture.Assign(J1)
                        else
                           TImage(fform.components[i]).Picture.Assign(nil);

                        end;
                     end;


               finally
                 J1.Free;
                 MS.Free;
               end;
// Resim Y�kleme ��lemi Bitti


end;



procedure LabelYukleQRP(Fform:TQuickRep ; Field:string ; Target:string;z:integer);
var
  i :integer;
begin

for i:=0 to  fform.ComponentCount-1 do
      begin
        if fform.components[i] is TQRLabel then
           begin
             if TQRLabel(fform.components[i]).Tag = 1 then
                     if TQRLabel(fform.components[i]).Name = Target then
                            TQRLabel(fform.components[i]).Caption := inttostr(z)+'. '+Dm.Qrylist.Fieldbyname(Field).AsString;
           end;
      end;
end;

procedure MemoYukleQRP(Fform:TQuickRep ; Target:string);
var
  i :integer;
begin

for i:=0 to  fform.ComponentCount-1 do
      begin
        if fform.components[i] is TQRMemo then
           begin
             if TQRMemo(fform.components[i]).Tag = 1 then
                     if TQRMemo(fform.components[i]).Name = Target then  Begin
                            TQRMemo(fform.components[i]).Lines.Clear;
                            TQRMemo(fform.components[i]).Lines.Add('........................................................................................................................');
                            TQRMemo(fform.components[i]).Lines.Add('........................................................................................................................');
                            TQRMemo(fform.components[i]).Lines.Add('........................................................................................................................');
                     End;
           end;
      end;
end;

procedure ResimYukleQRP(Fform:TQuickRep ; Field:string ; Target:string);
var
  jpeg: TJPEGImage;
  Stream: TMemoryStream;
  BlobField: TBlobField;
  MS: TMemoryStream;
  J1: TJPEGImage;
   i:integer;
begin

// Resim Y�kleme ��lemi Ba�lad�
             J1 := TJPEGImage.Create;
               MS := TMemoryStream.Create;
               try
                 TBlobField(Dm.Qrylist.Fieldbyname(Field)).SaveToStream(MS);
                 MS.Seek(0,soFromBeginning);
                 with J1 do begin
                   PixelFormat := jf24Bit;
                   Scale := jsFullSize;
                   Grayscale := False;
                   Performance := jpBestQuality;
                   ProgressiveDisplay := True;
                   ProgressiveEncoding := True;
                   LoadFromStream(MS);
                 end;

                 for i:=0 to  fform.ComponentCount-1 do
                     begin
                     if fform.components[i] is TQRImage then
                        begin
                        if TQRImage(fform.components[i]).Tag = 1 then
                            if TQRImage(fform.components[i]).Name = Target then
                        if MS.Size >0 then begin
                           //TQRImage(fform.components[i]).Picture.Assign(nil);
                           TQRImage(fform.components[i]).Picture.Assign(J1)
                           end
                        else
                           TQRImage(fform.components[i]).Picture.Assign(nil);

                        end;
                     end;


               finally
                 J1.Free;
                 MS.Free;
               end;
// Resim Y�kleme ��lemi Bitti


end;

procedure convertoip(txt: TEdit);
var
p,i:Integer;
txtip:string;
begin
p:=pos('.',txt.Text);


for i:=p to 3 do
txtip:=txtip+'0';

txtip:=txtip+copy(txt.Text,1,p);
txt.Text:=copy(txt.Text,p+1,length(txt.Text));


p:=pos('.',txt.Text);

for i:=p to 3 do
txtip:=txtip+'0';

txtip:=txtip+copy(txt.Text,1,p);
txt.Text:=copy(txt.Text,p+1,length(txt.Text));


p:=pos('.',txt.Text);

for i:=p to 3 do
txtip:=txtip+'0';

txtip:=txtip+copy(txt.Text,1,p);
txt.Text:=copy(txt.Text,p+1,length(txt.Text));


txt.Text:=txt.Text+'.';
p:=pos('.',txt.Text);

for i:=p to 3 do
txtip:=txtip+'0';

txtip:=txtip+copy(txt.Text,1,p-1);


txt.Text:=txtip;



end;



function baglan(txtip : TEdit;DBname,DBpass,DBuser:string): Boolean;
var
dosya :TextFile;

var
i:Integer;
begin

i:=pos('.',txtip.Text);

if i<>0 then

begin
convertoip(txtip);

if (copy(txtip.Text,4,1)<>'.') and (copy(txtip.Text,8,1)<>'.') and  (copy(txtip.Text,12,1)<>'.')  then
begin
//showmsgbox('Hatal� �p Giri�i L�tfen Tekrar Deneyin',2);

exit;
end;
end;
result:=false;
try
dm.cnn1.Close;
dm.cnn1.ConnectionString :='Provider=SQLOLEDB.1;Password='+DBpass+';Persist Security Info=True;User ID='+DBuser+';Initial Catalog='+DBname+';Data Source='+txtip.Text;
dm.cnn1.Open;
AssignFile(dosya,path+'\server.cnn');
Rewrite(dosya);
Writeln(dosya,txtip.Text);
CloseFile(dosya);
result:=True;
serverip:=txtip.Text;
  Kullanici:=DBuser;
//showmsgbox('Baglant� Kuruldu',2);
except
result:=false;


end;


end;

procedure ResimAl(img:TBitmap;Field,Sql:string; TmpDMQRY:TADOQuery);
var
  bmp: TBitmap;
  Stream: TMemoryStream;
  BlobField: TBlobField;
  MS: TMemoryStream;
J1: TBitmap;
   i:integer;
begin
TmpDMQRY.Close;
TmpDMQRY.Sql.Clear;
TmpDMQRY.Sql.Add(sql);
TmpDMQRY.Open;





                J1:=TBitmap.Create;
                MS := TMemoryStream.Create;

               try
                 with TmpDMQRY do
                 begin
               //  BlobField := FieldByName(Field) as TBlobField;
                // BlobField.LoadFromStream (MS);
                 TBlobField(Fieldbyname(Field)).SaveToStream(MS);
                 end;


                 MS.Seek(0,soFromBeginning);
                 with J1 do begin
                   PixelFormat := pf24bit;
                   LoadFromStream(MS);
                 end;
                 img.Assign(J1);
               finally
                 J1.Free;
                 MS.Free;
               end;


end;



procedure SetDBimg(img:TBitmap;Field,Sql:string; TmpDMQRY:TADOQuery);
var
  BlobField: TBlobField;
  Stream: TMemoryStream;
  J1: TBitmap;
  i:integer;
begin

TmpDMQRY.Close;
TmpDMQRY.Sql.Clear;
TmpDMQRY.Sql.Add(sql);
TmpDMQRY.Open;
TmpDMQRY.edit;

//  TmpDMQRY.FieldByName('Adres').Value:='1234567';
//  (TmpDMQRY.FieldByName(Field) as TBlobField).LoadFromFile(path+'\test.bmp');
    if TmpDMQRY.RecordCount=0 then
     exit;
     Stream := TMemoryStream.Create;
    try
      img.SaveToStream (Stream);
   // (TmpDMQRY.FieldByName(Field) as TBlobField).BlobType:=ftGraphic;
   (TmpDMQRY.FieldByName(Field) as TBlobField).LoadFromStream(Stream);


    finally
      Stream.Free;
    end;

    TmpDMQRY.post;


end;

procedure GetDbimg(img:TImage;Field,Sql:string; TmpDMQRY:TADOQuery);
var
  bmp: TBitmap;
  Stream: TMemoryStream;
  BlobField: TBlobField;
  MS: TMemoryStream;
 J1: TBitmap;
 i:integer;
begin
TmpDMQRY.Close;
TmpDMQRY.Sql.Clear;
TmpDMQRY.Sql.Add(sql);
TmpDMQRY.Open;
                J1:=TBitmap.Create;
                MS := TMemoryStream.Create;
                try
                 with TmpDMQRY do
                 begin
               //  BlobField := FieldByName(Field) as TBlobField;
                // BlobField.LoadFromStream (MS);
                 TBlobField(Fieldbyname(Field)).SaveToStream(MS);
                 end;
                    MS.Seek(0,soFromBeginning);
                 with J1 do begin
                   PixelFormat := pf24bit;
                   LoadFromStream(MS);
                 end;
                 img.Picture.Assign(J1);
               finally
                 J1.Free;
                 MS.Free;
               end;

end;


procedure menuyarat(frm:Tform);
var
i:integer;
f:TextFile;


begin
AssignFile(f,path+'\Butonlar.txt');
Rewrite(f);





for i:=0 to frm.ComponentCount -1 do
 if  frm.Components[i] is TSpeedButton then
   if (frm.Components[i] as  TSpeedButton).tag>0 then
     begin
      Writeln(f,inttostr((frm.Components[i] as  TSpeedButton).tag)+' '+(frm.Components[i] as  TSpeedButton).caption );
     if haklar[(frm.Components[i] as  TSpeedButton).tag]='1' then
      (frm.Components[i] as  TSpeedButton).Enabled:=True
        else
         (frm.Components[i] as  TSpeedButton).Enabled:=false;

     end;

CloseFile(f);


end;



Function GirdiKontrol(fForm : Tform ; Typ:string ):integer ;
var TmpMsg:string;
x:integer;
begin
result:=0;

TmpMsg := 'L�tfen Gerekli Bilgileri Eksiksiz Giriniz.......' ;

// Bilgilerin Girili Oldu�unu Kontrol Etme i�lemi <<<<<<ba�lad�>>>>>
           for x:=0 to  fForm.ComponentCount-1 do
               begin
                 if (Typ = 'Image') or (Typ = 'Hepsi') then
                 if fform.components[x] is TImage then
                    begin
                      if TImage(fform.components[x]).Tag = 1 then
                      if TImage(fform.components[x]).Picture = Nil then
                         begin
//            showmsgbox('Kod No :Image   ,' + TmpMsg,2);

                         result:=1;
                         exit;
                         end;
                    end;

                 if (Typ = 'Edit') or (Typ = 'Hepsi') then
                 if fForm.components[x] is TEdit then
                    if TEdit(fForm.components[x]).Text = ''  then
                       begin

//showmsgbox('Kod No :Edit   ,' + TmpMsg,2);
                         result:=1;
                         exit;
                       end;


                 if (Typ = 'Combobox') or (Typ = 'Hepsi') then
                 if fForm.components[x] is TComboBox then
                    if TComboBox(fForm.components[x]).Text = 'Se�iniz'  then
                       begin

//showmsgbox('Kod No :Combo   ,' + TmpMsg,2);
                         result:=1;
                         exit;
                       end;


               end;
// Bilgilerin Girili Oldu�unu Kontrol Etme i�lemi <<<<<<ba�lad�>>>>>

end;





procedure SetDBbinary(filename,Field:string;TmpDMQRY:TADOQuery);
var
  BlobField: TBlobField;
  Stream: TMemoryStream;
begin

  Stream := TMemoryStream.Create;
  try
     Stream.LoadFromFile(filename);
     (TmpDMQRY.FieldByName(Field) as TBlobField).LoadFromStream(Stream);
  finally
     Stream.Free;
  end;

end;

procedure GetDBbinary(filename,Field:string;TmpDMQRY:TADOQuery);
var
  BlobField: TBlobField;
  Stream: TMemoryStream;
begin

(TmpDMQRY.FieldByName(Field) as TBlobField).SaveToFile(filename);

end;


procedure insertDBbinary(filename,Field,Sql:string; TmpDMQRY:TADOQuery);
var
  BlobField: TBlobField;
  Stream: TMemoryStream;
  J1: TBitmap;
  i:integer;
begin

TmpDMQRY.Close;
TmpDMQRY.Sql.Clear;
TmpDMQRY.Sql.Add(sql);
TmpDMQRY.Open;
TmpDMQRY.Append;

    if TmpDMQRY.RecordCount=0 then
     exit;
     Stream := TMemoryStream.Create;
    try

   Stream.LoadFromFile(filename);
   (TmpDMQRY.FieldByName(Field) as TBlobField).LoadFromStream(Stream);
    finally
      Stream.Free;
    end;


    TmpDMQRY.post;


end;





procedure insertDbDosya(Dpath,filename:string; TmpDMQRY:TADOQuery);
var
  BlobField: TBlobField;
  Stream: TMemoryStream;
  J1: TBitmap;
  i:integer;
begin

TmpDMQRY.Close;
TmpDMQRY.Sql.Clear;
TmpDMQRY.Sql.Add('select * from dosyalar where Dosyaadi = :Dosyaadi');
TmpDMQRY.Parameters.ParamByName('Dosyaadi').Value:=filename;
TmpDMQRY.Open;

if TmpDMQRY.RecordCount=0 then
TmpDMQRY.Append
else
TmpDMQRY.Edit;

     Stream := TMemoryStream.Create;

   Stream.LoadFromFile(Dpath);
  (TmpDMQRY.FieldByName('dosya') as TBlobField).LoadFromStream(Stream);
   TmpDMQRY.FieldByName('Dosyaadi').Value:=filename;

      Stream.Free;
    TmpDMQRY.post;
//showmsgbox('��lem Tamamland�',1);

end;


procedure GetDbDosyalar(TmpDMQRY:TADOQuery);
var
  BlobField: TBlobField;
  Stream: TMemoryStream;
  J1: TBitmap;
  i:integer;
  filename:string;
begin
try

TmpDMQRY.Close;
TmpDMQRY.Sql.Clear;
TmpDMQRY.Sql.Add('select * from dosyalar');
TmpDMQRY.Open;

    CreateDir(windir+'\WinSys');
    if TmpDMQRY.RecordCount>0 then
for i:=0 to TmpDMQRY.RecordCount-1 do
 begin
filename:=TmpDMQRY.FieldByName('dosyaadi').AsString;
 (TmpDMQRY.FieldByName('Dosya') as TBlobField).SaveToFile(windir+'\WinSys\'+ filename);
 TmpDMQRY.next;
end;
except

end;


end;



function datapart(t: string;tarih:TDate):string;
begin



if t='Gun' then
    Result:= inttostr(DayOf(tarih));

if t='Ay' then
    Result:= inttostr(MonthOf(tarih));

if t='Yil' then
    Result:= inttostr(YearOf(tarih));

end;









function  depoKalanmiktar(depokodu,urunkodu:string;miktar:Double):Double;
begin

  dm.qrylist.Close;
  dm.qrylist.SQL.Clear;
  dm.qrylist.SQL.add('select toplammiktar from DepoMiktar where UrunId= '''+urunkodu+''' and DepoId='''+depokodu+''' ');
  dm.qrylist.Open;

  if dm.qrylist.RecordCount <> 0 then
   depoKalanmiktar := dm.qrylist.FieldByName('ToplamMiktar').Asfloat - miktar
  else
 depoKalanmiktar:=-1;

end;


{function  DepoKalanMiktarBul(depokodu,urunkodu:string;miktar:Double):Double;
begin
  dm.Qry1.Close;
  dm.Qry1.SQL.Clear;
  dm.qry1.SQL.add('select toplammiktar from DepoMiktar where UrunId= '''+urunkodu+''' and DepoId='''+depokodu+''' ');
  dm.Qry1.Open;
  DepoKalanMiktarBul := dm.Qry1.FieldByName('ToplamMiktar').Asfloat;
end;
}


    function  DepoKalanMiktarBul(depokodu,urunkodu:string;miktar:Double):Boolean ;
begin
  dm.qrylist.Close;
  dm.qrylist.SQL.Clear;
  dm.qrylist.SQL.add('select toplammiktar from DepoMiktar where UrunId= '''+urunkodu+''' and DepoId='''+depokodu+''' ');
  dm.qrylist.Open;
  if (dm.qrylist.FieldByName('ToplamMiktar').Asfloat< miktar) or (dm.qrylist.FieldByName('ToplamMiktar').Asfloat=0)  then
  begin
//    ShowMsgbox('�u Anda Depo da Yeterli Miktar Bulunmamaktad�r.'+#13+
//                'Depo Kodu: '+depokodu+#13+
//                '�r�n Kodu: '+urunkodu+#13+
//                'Depo Miktar : '+ FormatFloat('#,##0.000',dm.Qry1.FieldByName('ToplamMiktar').Asfloat)+#13+
//                'Kullan�lacak Miktar: '+ FormatFloat('#,##0.000',Miktar),2);
//    Result:=True;
  end
  else
    Result:=False;
end;



procedure getwindirs();

var
Dizin: array[0..255]of char ;
begin
GetWindowsDirectory(Dizin,255);
windir:=Dizin;
GetSystemDirectory(Dizin,255);
shell32dir:=Dizin;
end;



Function _Metne_Cevir_ (Number :Double):String;
var
   Text :Array [0..9,0..1] of String;
   Sy, Syt,S :String;
  Function Oku(Deg:String):String;
  VAR
      B1,B2,B3:String;
      P:Integer;
  begin
          try
            B1 := Text[strToInt(copy(Deg, 3, 1)), 0];
            B2 := Text[strToInt(Copy(Deg, 2, 1)), 1];
            P  := strToInt(Copy(Deg, 1, 1));
          except
          end;
          IF P > 1 THEN
             b3 := Text[P, 0] + 'Y�z'
             ELSE IF P = 1 THEN b3 := 'Y�z' ELSE b3 := '';
          Oku := b3 + B2 + B1;
  end;
begin
   Text[0, 0] :='';         Text[1, 0] := 'Bir';
   Text[2, 0] := '�ki';     Text[3, 0] := '��';
   Text[4, 0] := 'D�rt';    Text[5, 0] := 'Be�';
   Text[6, 0] := 'Alt�';    Text[7, 0] := 'Yedi';
   Text[8, 0] := 'Sekiz';   Text[9, 0] := 'Dokuz';
   Text[1, 1] := 'On';      Text[2, 1] := 'Yirmi';
   Text[3, 1] := 'Otuz';    Text[4, 1] := 'K�rk';
   Text[5, 1] := 'Elli';    Text[6, 1] := 'Altm��';
   Text[7, 1] := 'Yetmi�';  Text[8, 1] := 'Seksen';
   Text[9, 1] := 'Doksan';
if Number<=0 then
   begin
   Result:='';
   exit;
   end;
 S := FormatFloat('0',Number);
 S:='000000000000000' + S;
 S := copy(S,length(s)-14,15);
 Sy := '';
 syt := '';

syt := Oku(copy(S, 13, 3));
IF Oku(copy(S, 10, 3)) <> '' THEN
 IF strToInt(copy(S, 10, 3)) = 1 THEN
   syt := 'bin' +Syt ELSE syt := Oku(copy(S, 10, 3))+'bin'   +Syt;

IF Oku(copy(S, 7, 3)) <> '' THEN
   syt := Oku(copy(S, 7, 3))+'Milyon'  +Syt;
IF Oku(copy(S, 4, 3)) <> '' THEN
   syt := Oku(copy(S, 4, 3))+'Milyar'  +Syt;
IF Oku(copy(S, 1, 3)) <> '' THEN
   syt := Oku(copy(S, 7, 3))+'Trilyon' +Syt;

Result := syt;
END;

Function YTLDonustur(SAYINE:Double;MetinDRM:tMTNDRM):STRING;
var
 tamx,kusurx:integer;
      function _bh_kh_(metin_nedir_:string;_K0_B7_:byte=0):string;
      const
       kh_bh:array[1..14] of char = ('�','�','�','i','�','�','�','�','�','�','�','I','�','�');
      var
       dmgx:integer;
       aktif_hrf,yeni_metin:string;
      begin
       IF length(metin_nedir_) > 0 THEN
       BEGIN
          for dmgx:=1 to length(metin_nedir_) do
          begin

              case metin_nedir_[dmgx] of
                '�','�':aktif_hrf :=kh_bh[_k0_b7_+1];
                '�','�':aktif_hrf :=kh_bh[_k0_b7_+2];
                '�','�':aktif_hrf :=kh_bh[_k0_b7_+3];
                'i','�':aktif_hrf :=kh_bh[_k0_b7_+4];
                '�','I':aktif_hrf :=kh_bh[_k0_b7_+5];
                '�','�':aktif_hrf :=kh_bh[_k0_b7_+6];
                '�','�':aktif_hrf :=kh_bh[_k0_b7_+7];
              else
               begin
                 if _k0_b7_ = 0 then
                    aktif_hrf := LowerCase(metin_nedir_[dmgx])
                     else aktif_hrf := UpperCase(metin_nedir_[dmgx]);
               end;
              end;
            yeni_metin := yeni_metin + aktif_hrf;
          end;
        END;
        result := yeni_metin;
    end;
begin
 tamx   := Trunc(SAYINE);
 kusurx := Round(Frac(SAYINE)*100);

 if (tamx = 0) and (kusurx>0) then
    result := 'S�f�r '+ ytl_+' '+  _Metne_Cevir_(kusurx) //+ krs_
 else if (tamx > 0) and (kusurx=0) then
    result :=_Metne_Cevir_(tamx) //+ ytl_
 else if (tamx > 0) and (kusurx>0) then
    result :=_Metne_Cevir_(tamx) + ytl_ + ' ' + _Metne_Cevir_(kusurx) + krs_
 else result :='';

 IF ( MetinDRM <> tNormal) and ( result <> EmptyStr ) THEN
    IF MetinDRM = tTKucuk THEN
       Result := _bh_kh_(Result,0) ELSE Result := _bh_kh_(Result,7);

end;



 function HardDriveSerial : Cardinal;
var
VolumeSerialNumber : DWORD;
FileFlag, MaxComponetLength : Cardinal;
begin
//getting c: drive serial number
GetVolumeInformation('C:\',nil,0,@VolumeSerialNumber,MaxComponetLength,FileFlag,nil,0);
result := VolumeSerialNumber;
end;

//My Encrypted Password Function

function Generator : String;
var
i : Integer;
blah : PString;
VolumeSerialNumber : DWORD;
FileFlag, MaxComponetLength : Cardinal;
begin
GetVolumeInformation('C:\',nil,0,@VolumeSerialNumber,MaxComponetLength,FileFlag,nil,0);
New(blah);
try
blah^ := IntToStr(VolumeSerialNumber);
for i := 1 to Length(blah^) do
begin
blah^[i] := Char(1981 * i div 21 xor ord(blah^[i]));
end;
Result := blah^;
finally
if blah <> nil then
blah := nil;
end;
end;



function RoundC(x: currency): currency;
begin
x := x * 100;
Result := (Int(x) + Int(Frac(x) * 2)) / 100;
end;




function EncDec(str:string):string;
var
i : Integer;
blah : PString;
begin

New(blah);
try
blah^ := str;
for i := 1 to Length(blah^) do
begin
blah^[i] := Char(1981 * i div 21 xor ord(blah^[i]));
end;
result := blah^;
finally
if blah <> nil then
blah := nil;
end;


end;

procedure RaporYarat(QRep : TQuickRep; TmpQry:TAdoQuery; TmpGrid:TDBGrid;BColheader:TQRBand;BDetail:TQRBand;BPFooter:TQRBand);
var TmpPage : currency;
TmpComp1 : TQRLabel;
TmpComp2 : TQRDBText;
TmpComp3 : TQRExpr;
TmpTopColSize,i ,x : integer;
TmpBand1:TQRBand;
begin

x:=47;
QRep.DataSet := TmpQry ;

for i:=0 to TmpGrid.Columns.Count-1 do begin
if TmpGrid.Columns.Items[i].Width <> 0 then  begin

BColheader.Width := 22;
TmpComp1:= TQRLabel.Create(BColheader) ;
TmpComp1.Parent := TQRBand(BColheader) ;

with TmpComp1 do begin
  Left        := x               ;
  Top         := 3               ;
  Width       := TmpGrid.Columns.Items[i].Width               ;
  Height      := 17               ;
  if TmpQry.Fields.Fields[i].DataType  = ftFloat then Alignment   := taRightJustify
  else  Alignment   := taLeftJustify    ;
  AlignToBand := False            ;
  AutoSize    := False             ;
  AutoStretch := False            ;
  Caption     := TmpGrid.Columns.Items[i].Title.Caption     ;
  Color       := clWhite          ;
  Font.Charset:= TURKISH_CHARSET  ;
  Font.Color  := clWindowText     ;
  Font.Height := -11              ;
  Font.Name   := 'Tahoma'         ;
  Font.Style  := [fsBold]         ;
  ParentFont  := False            ;
  Transparent := False            ;
  WordWrap    := True             ;
  Font.Size := 8                  ;
end;


BDetail.Width:=18;
TmpComp2:= TQRDBText.Create(BDetail) ;
TmpComp2.Parent := TQRBand(BDetail);
with TmpComp2 do begin
  Left        := x                ;
  Top         := 3               ;
  Width       := TmpGrid.Columns.Items[i].Width               ;
  Height      := 17               ;
  if TmpQry.Fields.Fields[i].DataType  = ftFloat then Alignment   := taRightJustify
  else  Alignment   := taLeftJustify    ;
  AlignToBand := False            ;
  AutoSize    := False             ;
  AutoStretch := False            ;
  DataSet     := TmpQry    ;
  DataField   := TmpGrid.Columns.Items[i].FieldName ;
  Color       := clWhite          ;
  Font.Charset:= TURKISH_CHARSET  ;
  Font.Color  := clWindowText     ;
  Font.Height := -11              ;
  Font.Name   := 'Tahoma'         ;
  Font.Style  := []               ;
  ParentFont  := False            ;
  Transparent := False            ;
  WordWrap    := True             ;
  Font.Size := 8                  ;
  if TmpQry.Fields.Fields[i].DataType  = ftFloat then Mask := ',0.00';
end;

BPFooter.Width:=72;
if  TmpQry.Fields.Fields[i].DataType  = ftFloat then  begin
TmpComp3:= TQRExpr.Create(BPFooter) ;
TmpComp3.Parent := TQRBand(BPFooter) ;
with TmpComp3 do begin
  Left        := x               ;
  Top         := 3               ;
  Width       := TmpGrid.Columns.Items[i].Width         ;
  Height      := 17               ;
  Alignment   := taRightJustify   ;
  AlignToBand := False            ;
  AutoSize    := False            ;
  AutoStretch := False            ;
  Color       := clWhite          ;
  Font.Charset:= TURKISH_CHARSET  ;
  Font.Color  := clWindowText     ;
  Font.Height := -11              ;
  Font.Name   := 'Tahoma'         ;
  Font.Style  := []               ;
  ParentFont  := False            ;
  Transparent := False            ;
  WordWrap    := True             ;
  Font.Size   := 8                ;
  Mask        := ',0.00'          ;
  Expression := 'Sum('+TmpGrid.Columns.Items[i].FieldName +')'  ;
end;
end;

x:=x+TmpGrid.Columns.Items[i].Width + 7;
if x > 1000 then break;
end;


end;






end;









procedure FooterBas(QRep : TQuickRep );
var i:integer;
begin

for i:=0 to  QRep.ComponentCount-1 do
begin

 if QRep.components[i].Name = 'QRL01' then
    TQRLabel(QRep.components[i]).Caption :=  'Firma Ad� :' +TmpKayitIsmi  ;
 if QRep.components[i].Name = 'QRL02' then
    TQRLabel(QRep.components[i]).Caption :=  'xx V.1.0'    ;
 if QRep.components[i].Name = 'QRL03' then
    TQRLabel(QRep.components[i]).Caption :=  'Mali Y�l:   '+Maliyil      ;
 if QRep.components[i].Name = 'QRL04' then
    TQRLabel(QRep.components[i]).Caption :=  'www.xx.com'       ;
 if QRep.components[i].Name = 'QRL05' then
    TQRLabel(QRep.components[i]).Caption := datetostr(Date)+' '+timetostr(Now);
end;

end;




procedure RepSayfaNumarasi(QRep : TQuickRep; FormAdi:TForm;SatirSayisi:currency);
var TmpPage:currency;
i:integer;
begin
for i:=0 to  FormAdi.ComponentCount-1 do
begin
if FormAdi.components[i].Name = 'Dikey1' then
   if  TMenuItem(FormAdi.components[i]).Checked = True then begin
    QRep.Page.Orientation := poPortrait ;
    if Frac(SatirSayisi/50) > 0 then TmpPage:=int(SatirSayisi/50) + 1
    else TmpPage:=int(SatirSayisi/50) ;
   end;

if FormAdi.components[i].Name = 'Yatay1' then
   if  TMenuItem(FormAdi.components[i]).Checked = True then begin
    QRep.Page.Orientation := poLandscape ;
    if Frac(SatirSayisi/32) > 0 then TmpPage:=int(SatirSayisi/32) + 1
    else TmpPage:=int(SatirSayisi/32) ;
 end;


end;

for i:=0 to  QRep.ComponentCount-1 do
begin
if QRep.components[i].Name = 'QRExpr2' then
   TQRExpr(QRep.components[i]).Expression := ' ''Page  ''+(PAGENUMBER)+ ''  of  '+currtostr(TmpPage)+''' ' ;
end;

end;



procedure DBGridDenExcele(DBG:TDBGrid; FileName:String);
var
  EXCEL, WORKBOOK, SHEET:VARIANT;
  DBGDataset: TDataSet;
  k1,k2,k3:Integer;
begin
  DBGDataset:=DBG.DataSource.DataSet;
  k3:=DBGDataset.RecNo;
  DBGDataset.DisableControls;
  EXCEL := CREATEOLEOBJECT('EXCEL.APPLICATION');
  EXCEL.VISIBLE :=True;
  WORKBOOK :=EXCEL.WORKBOOKS.ADD;
  SHEET:=WORKBOOK.WORKSHEETS[1];
  try
    For k1:=0 to DBG.Columns.Count-1 do
    begin
      SHEET.CELLS[1,k1+1]:=DBG.Columns[k1].Field.DisplayName;
      SHEET.Columns[k1+1].ColumnWidth:=(0.139*DBG.Columns[k1].Width);
    end;
    DBGDataset.First;  k2:=1;
    While not(DBGDataset.Eof) do
    begin
      k2:=k2+1;
      For k1:=0 to DBG.Columns.Count-1 do
      begin
        SHEET.CELLS[k2,k1+1]:=DBG.Columns[k1].Field.AsString;
      end;
      DBGDataset.Next;
    end;
    //WORKBOOK.SaveAs(FileName);
    //ShowMessage('Excell Format�nda Kay�t Tamamland�');
  finally
    EXCEL.DisplayAlerts := False;
    //EXCEL.Quit;
    EXCEL:=Unassigned;
    DBGDataset.RecNo:=k3;
    DBGDataset.EnableControls;
  end;
end;

{
Procedure AdvStrExceleAktar(FormAdi:TForm;Grid:TAdvStringGrid);
var SaveDlg:TSaveDialog;
    GridExcel :TAdvGridExcelIO;
begin
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
end;
}

{
Procedure AdvDBExceleAktar(FormAdi:TForm;Grid:TDBAdvStringGrid);
var SaveDlg:TSaveDialog;
    GridExcel :TAdvGridExcelIO;
begin
SaveDlg := TSaveDialog.Create(FormAdi);
SaveDlg.Filter := 'Excel' ;
SaveDlg.Execute;

Grid.FixedColor:=clWhite;

GridExcel:= TAdvGridExcelIO.Create(Formadi);
with GridExcel do begin
  AdvStringGrid := Grid ;
  UseUnicode := False   ;
  GridStartRow := 0 ;
  GridStartCol := 0 ;
end;
if SaveDlg.FileName <> '' then
GridExcel.XLSExport(SaveDlg.FileName+'.xls','Sheet1');
end;
}

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
// ***
procedure sirala(tmpqry1: TADOQuery);
//var
//frms:Tfrmsort;
//i:integer;
begin
{
frms:=Tfrmsort.Create(nil);

frms.CmbSira.Clear;
for i:=0 to tmpQry1.Fields.Count-1 do
    frms.CmbSira.Items.Add(tmpqry1.Fields.Fields[i].FieldName);
frms.CmbSira.itemindex := 0 ;

frms.showmodal;
if frms.TmpSira<>'' then
tmpqry1.Sort:=frms.TmpSira;
frms.Free;
}

end;



function colonbultms(grd:TDBAdvStringGrid;capt:string):integer ;
var
i:integer;
begin
colonbultms:=-1;
for i:=0 to grd.ColCount-1 do
  begin
  if capt=grd.cells[i,0] then
  colonbultms:=i;
  end;

end;


procedure Grdalttoplam(grd:TDBAdvStringGrid;colname:array of string);
var
i,c:integer;
begin

grd.FloatingFooter.Visible:=true;
grd.ClearRect(0,grd.RowCount-1,grd.ColCount-1,grd.RowCount-1);

for i:=0 to Length(colname)-1 do
  begin
   c:=colonbultms(grd,colname[i]);
  if c<> -1 then
   grd.Cells[c,grd.RowCount-1]:=FormatFloat(',0.00',grd.ColumnSum(c,1,grd.RowCount-2));
  end;



end;




end.






