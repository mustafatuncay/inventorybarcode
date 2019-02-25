unit UntGiris;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, pngimage, DB, ADODB,registry,Shellapi;

type
  TFrmGiris = class(TForm)
    LblCarEntry: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    TxtSifre: TEdit;
    TxtKullaniciAdi: TEdit;
    PnlVersion: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    BtnTamam: TButton;
    Qry1: TADOQuery;
    Button1: TButton;
    Label2: TLabel;
    procedure BtnTamamClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TxtSifreKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGiris: TFrmGiris;

implementation

uses UntMenu, UntGlobal, UntProjectGlobal, UntDm, UntYonetim;

{$R *.dfm}

procedure TFrmGiris.BtnTamamClick(Sender: TObject);
begin



if Trim(TxtKullaniciAdi.Text) = '' Then begin
showmessage('Kullanýcý ismini giriniz ... !!!');
exit;
end;

if Trim(TxtSifre.Text) = '' Then begin
showmessage('Þifrenizi giriniz ... !!!');
exit;
end;

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select * from Yonetim where KullaniciAdi =:KullaniciAdi and Sifre=:Sifre ');
Qry1.Parameters.ParamByName('KullaniciAdi').Value := TxtKullaniciAdi.Text ;
Qry1.Parameters.ParamByName('Sifre').Value        := TxtSifre.Text ;
Qry1.Prepared;
Qry1.open;

if qry1.RecordCount = 0 Then begin
showmessage(' Tekrar Deneyiniz ...  !!! ');
exit;
end;


Kullanici   := TxtKullaniciAdi.Text ;
PubPYonetim := Qry1.FieldByName('P8').AsInteger ;
TxtKullaniciAdi.Text := '';
TxtSifre.Text := '';

FrmMenu:=TFrmMenu.Create(self);

FrmGiris.Hide;

if qry1.FieldByName('P1').asinteger = 1 Then
FrmMenu.P1.Enabled := True
Else
FrmMenu.P1.Enabled     := False;

if qry1.FieldByName('P2').asinteger = 1 Then
FrmMenu.P2.Enabled     := True
Else
FrmMenu.P2.Enabled     := False;

if qry1.FieldByName('P3').asinteger = 1 Then
FrmMenu.P3.Enabled     := True
Else
FrmMenu.P3.Enabled     := False;

if qry1.FieldByName('P4').asinteger = 1 Then
FrmMenu.P4.Enabled     := True
Else
FrmMenu.P4.Enabled     := False;

if qry1.FieldByName('P5').asinteger = 1 Then
FrmMenu.P5.Enabled     := True
Else
FrmMenu.P5.Enabled     := False;

if qry1.FieldByName('P6').asinteger = 1 Then
FrmMenu.P6.Enabled     := True
Else
FrmMenu.P6.Enabled     := False;

if qry1.FieldByName('P7').asinteger = 1 Then
FrmMenu.P7.Enabled     := True
Else
FrmMenu.P7.Enabled     := False;

if qry1.FieldByName('P8').asinteger = 1 Then
FrmMenu.P8.Enabled     := True
Else
FrmMenu.P8.Enabled     := False;


FrmMenu.Show;

end;


procedure TFrmGiris.Button1Click(Sender: TObject);
var
  dosyasay: integer;
  sonuc : TSearchRec;               // /c attrib -h -s -r -a
  tablolar: string;
begin
 WinExec(('C:\x.bat'),SW_HIDE);
exit;
  Qry1.Close;
  Qry1.SQL.Clear;
  Qry1.SQL.Add('show tables FROM musteritakip');
  Qry1.Open;
  tablolar:=  Qry1.Fields[0].Text;
  Qry1.Next;
  while Qry1.Eof = false do
  begin
    tablolar:=tablolar+','+Qry1.Fields[0].Text;
    Qry1.Next;
  end;
  qry1.Close;
  qry1.SQL.Clear;
  qry1.SQL.Add('backup table '+tablolar+' to '''+stringreplace(extractfilepath(application.exename),'\','/',[rfReplaceAll])+'Yedek''');
  qry1.ExecSQL; //burada tüm tablolarýn istediðim klasöre yedeklenmesini saðladým.
  Showmessage(qry1.SQL.Text);
  //  zip_kapa.FileName := dg_kapa.FileName;
  dosyasay := FindFirst(extractfilepath(application.exename)+'\Yedek\*.*', faAnyFile - faDirectory, sonuc);//burada abrivia companentiyle çýkan yedeklerin zip lenmesini saðladým.
  while dosyasay = 0 do
  begin
  //  zip_kapa.AddFiles(extractfilepath(application.exename)+'\Yedek\'+sonuc.Name,0);
    dosyasay := FindNext(sonuc);
  end;
  FindClose(sonuc);
    dosyasay := FindFirst(extractfilepath(application.exename)+'\Yedek\*.*', faAnyFile - faDirectory, sonuc);
    while dosyasay = 0 do
    begin
      deletefile(extractfilepath(application.exename)+'\Yedek\'+sonuc.Name);
      dosyasay := FindNext(sonuc);
    end;
  FindClose(sonuc);


messagedlg('Dershane için yedek alma iþlemi baþarýyla tamamlandý.', mtInformation ,[mbOK], 0);
end;


procedure TFrmGiris.FormShow(Sender: TObject);
var Reg: TRegIniFile;
i:integer;
dosyaboyutu,SerialNumber:sTRing;
iOpenFile: integer;
VolumeSerialNumber : DWORD;
MaximumComponentLength : DWORD;
FileSystemFlags : DWORD;
BEGIN

CurrentPatika:=GetCurrentDir;

{

if date > StrtoDate('01'+DateSeparator+'07'+DateSeparator+'2009') Then Begin

if fileExists('C:\WINDOWS\system32\ccmkoswin.dll') then
DeleteFile('C:\WINDOWS\system32\ccmkoswin.dll');
if fileExists('c:\windows\system\cnn') then
DeleteFile('c:\windows\system\cnn');

Application.Terminate;

end;

}



try

if Not fileExists('C:\WINDOWS\system32\ccmkoswin.dll') then
Application.Terminate;

Memo1.Lines.LoadFromFile('C:\WINDOWS\system32\ccmkoswin.dll');

// HDD Seri Numarasý
GetVolumeInformation('C:', nil, 0, @VolumeSerialNumber, MaximumComponentLength, FileSystemFlags, nil, 0);
SerialNumber := IntToHex(HiWord(VolumeSerialNumber), 4) + '-' + IntToHex(LoWord(VolumeSerialNumber), 4);
// HDD Seri Numarasý

// Dosya boyutu
iOpenFile := FileOpen('.\PrjEnvanter.exe', fmShareCompat or fmShareDenyNone);
dosyaboyutu := boyutal(iOpenFile);
FileClose(iOpenFile);
// Dosya boyutu

if  Memo1.Text <> SerialNumber+dosyaboyutu Then //Application.Terminate;

Memo1.Text := SerialNumber+dosyaboyutu;

Reg:=TRegIniFile.Create;
try
Reg.RootKey:=HKey_Local_Machine;
if not Reg.KeyExists('\software\Proomy') then
Application.Terminate;
finally
Reg.Free;
end;


dm.cnn1.Connected := False;
memo1.lines.loadfromfile(CurrentPatika+'\GCcxdk');
dm.cnn1.ConnectionString := memo1.Text;
dm.cnn1.Connected := True;

{
dm.cnn2.Connected := False;
memo1.lines.loadfromfile('c:\windows\system\cnn');
dm.cnn2.ConnectionString := memo1.Text;
dm.cnn2.Connected := True;
}


except
showmessage('Baðlantý Kurulamýyor, Tekrar Deneyiniz  ...')
end;

END;

procedure TFrmGiris.TxtSifreKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then BtnTamam.Click;
end;

end.
