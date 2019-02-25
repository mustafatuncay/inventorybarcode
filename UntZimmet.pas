unit UntZimmet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Menus, DB, ADODB, StdCtrls, Buttons,
  Mask, Grids, BaseGrid, AdvGrid, DBGrids, AdvObj,DateUtils;

type
  TFrmZimmet = class(TForm)
    Label2: TLabel;
    Panel1: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Image4: TImage;
    LblStatus: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Image1: TImage;
    Panel5: TPanel;
    Qry1: TADOQuery;
    PopupMenu1: TPopupMenu;
    AttachDelete: TMenuItem;
    Panel7: TPanel;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Image6: TImage;
    lblpersonelara: TLabel;
    Label23: TLabel;
    txtadi: TEdit;
    txtsoyadi: TEdit;
    txtgorevi: TEdit;
    txtodano: TEdit;
    Panel6: TPanel;
    Image8: TImage;
    Label7: TLabel;
    BtnListele: TSpeedButton;
    CmbKriter: TComboBox;
    TxtKelime: TEdit;
    AdvEsya: TAdvStringGrid;
    Panel2: TPanel;
    Image3: TImage;
    Qry2: TADOQuery;
    Ds1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    AdvZimmet: TAdvStringGrid;
    PopupMenu2: TPopupMenu;
    PersonelOdaNoDeitir1: TMenuItem;
    EyaOdaNoDeitir1: TMenuItem;
    EyavePersonelOdaNoDeitir1: TMenuItem;
    procedure BtnListeleClick(Sender: TObject);
    procedure lblpersonelaraClick(Sender: TObject);
    procedure AdvEsyaCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvEsyaCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure AdvZimmetCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure FormShow(Sender: TObject);
    procedure PersonelOdaNoDeitir1Click(Sender: TObject);
    procedure EyaOdaNoDeitir1Click(Sender: TObject);
    procedure EyavePersonelOdaNoDeitir1Click(Sender: TObject);
  private
    { Private declarations }
  public
   procedure temizle; { Public declarations }
   procedure cikis;
   procedure kaydet;
   procedure kayitgetir;
   procedure sil;
  end;

var
  FrmZimmet: TFrmZimmet;

implementation

uses UntDlgPersonel, UntGlobal;

{$R *.dfm}

procedure TFrmZimmet.BtnListeleClick(Sender: TObject);
var i:integer;
TmpSql:String;
begin

AdvEsya.ClearRows(1,AdvEsya.RowCount-1);
AdvEsya.RowCount := 2;
AdvEsya.AddCheckBox(1,0,False,True);
AdvEsya.Cells[0,0]:='Demirbaþ No';
AdvEsya.Cells[2,0]:='Eþyanýn Cinsi';
AdvEsya.Cells[3,0]:='Oda No';
AdvEsya.RowColor[0]:=clSilver;
AdvEsya.FontStyles[0,0]:=[fsBold];
AdvEsya.FontStyles[2,0]:=[fsBold];
AdvEsya.FontStyles[3,0]:=[fsBold];



TmpSql:='select * from demirbaslar where (elverislidegil <> ''Y'' and aktarildi <> ''Y'') ' ;

if CmbKriter.Text = 'Eþya Cinsi' then
TmpSql := TmpSql + ' and  esyacinsi like :esyacinsi ' ;

if CmbKriter.Text = 'Oda No' then
TmpSql := TmpSql + ' and  odano = :odano ' ;

if CmbKriter.Text = 'Demirbaþ No' then
TmpSql := TmpSql + ' and  id = :id ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
if CmbKriter.Text = 'Eþya Cinsi' then
Qry1.Parameters.ParamByName('esyacinsi').Value := trim(TxtKelime.Text)+'%' ;
if CmbKriter.Text = 'Oda No' then
Qry1.Parameters.ParamByName('odano').Value := trim(TxtKelime.Text) ;

if CmbKriter.Text = 'Demirbaþ No' then
Qry1.Parameters.ParamByName('id').Value := strtoint(TxtKelime.Text) ;


qry1.Prepared;
qry1.open;

if qry1.RecordCount = 0 Then Exit;

AdvEsya.RowCount :=  Qry1.RecordCount+1;

for i:=1 to Qry1.recordcount do begin
AdvEsya.Cells[0,i]:=Qry1.fieldbyname('id').AsString;
AdvEsya.AddCheckBox(1,i,False,True);
AdvEsya.Cells[2,i]:=Qry1.fieldbyname('esyacinsi').AsString;
AdvEsya.Cells[3,i]:=Qry1.fieldbyname('odano').AsString;
AdvEsya.Cells[4,i]:=Qry1.fieldbyname('barkod').AsString;

AdvEsya.Cells[5,i]:=Qry1.fieldbyname('bolum').AsString;
AdvEsya.Cells[6,i]:=Qry1.fieldbyname('bolum2').AsString;

Qry1.Next;
end;


end;

procedure TFrmZimmet.lblpersonelaraClick(Sender: TObject);
begin
FrmDlgPersonel:=TFrmDlgPersonel.Create(self);
FrmDlgPersonel.ShowModal;

if FrmDlgPersonel.iptal =False then begin
temizle;

lblpersonelara.Tag   := FrmDlgPersonel.Qry1.fieldbyname('id').AsInteger;

txtadi.Text           :=  FrmDlgPersonel.Qry1.fieldbyname('adi').AsString;
txtsoyadi.Text        :=  FrmDlgPersonel.Qry1.fieldbyname('soyadi').AsString;
txtgorevi.Text        :=  FrmDlgPersonel.Qry1.fieldbyname('gorevi').AsString;
txtodano.Text         :=  FrmDlgPersonel.Qry1.fieldbyname('odano').AsString;


//LblStatus.Caption := 'Mevcut Kaydý Silip Güncelleyebilirsiniz, Yeni Kayýt Ýçin Yeni Kayýt Tuþuna Basýnýz .... ';
kayitgetir;
end;


FrmDlgPersonel.Free;
end;

procedure TFrmZimmet.PersonelOdaNoDeitir1Click(Sender: TObject);
var TmpOdaNo,TmpSql:String;
i:integer;
begin

TmpOdaNo:= InputBox('','Lütfen Personel Oda Numarasýný Giriniz ...','') ;

if Trim(TmpOdaNo) = '' then exit;


                                                //esyaodano

for i:=1 to AdvZimmet.RowCount-1 do begin

if AdvZimmet.Cells[1,i]<>'Y' then Continue;

TmpSql := 'Update zimmet set perodano=:perodano where id=:id' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('perodano').Value := TmpOdaNo ;
Qry1.Parameters.ParamByName('id').Value       := AdvZimmet.Cells[9,i];
qry1.Prepared;
qry1.ExecSQL;



qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Update PersonelBilgisi set odano=:odano where id='''+IntToStr(lblpersonelara.Tag)+''' ');
Qry1.Parameters.ParamByName('odano').Value          := TmpOdaNo ;
qry1.Prepared;
qry1.ExecSql;


qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := AdvZimmet.Cells[6,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := AdvZimmet.Cells[8,i]  ;
Qry1.Parameters.ParamByName('tarih').Value := IntToStr(YearOf(date))+'-'+
                                              IntToStr(MonthOf(Date))+'-'+
                                              IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('yapilanis').Value     := AdvZimmet.Cells[2,i]+' '+AdvZimmet.Cells[3,i]+ ' kiþi ' + TmpOdaNo +' Nolu Odaya Alýndý';
qry1.Prepared;
qry1.ExecSQL;

end;


kayitgetir;
end;

procedure TFrmZimmet.temizle;
begin
txtadi.Clear;
txtsoyadi.Clear;
txtgorevi.Clear;
txtodano.Clear;

TxtKelime.Clear;

//AdvEsya.ClearRows(1,AdvEsya.RowCount-1);
//AdvEsya.RowCount := 2;

end;

procedure TFrmZimmet.AdvEsyaCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
CanEdit:=False;
if acol=1 Then CanEdit := True;
end;

procedure TFrmZimmet.AdvEsyaCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
var i:integer;
begin
if (acol=1) and (arow=0) Then begin

for i:=1 to AdvEsya.RowCount do
AdvEsya.Cells[1,i]:=AdvEsya.Cells[1,0];


end;
end;

procedure TFrmZimmet.AdvZimmetCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
CanEdit:=False;
if acol=1 Then CanEdit := True;
end;

procedure TFrmZimmet.cikis;
begin
close;
end;

procedure TFrmZimmet.EyaOdaNoDeitir1Click(Sender: TObject);
var TmpOdaNo,TmpSql:String;
i:integer;
begin

TmpOdaNo:= InputBox('','Lütfen Eþya Oda Numarasýný Giriniz ...','') ;

if Trim(TmpOdaNo) = '' then exit;


                                                //

for i:=1 to AdvZimmet.RowCount-1 do begin

if AdvZimmet.Cells[1,i]<>'Y' then Continue;

TmpSql := 'Update zimmet set esyaodano=:esyaodano where id=:id' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('esyaodano').Value := TmpOdaNo ;
Qry1.Parameters.ParamByName('id').Value       := AdvZimmet.Cells[9,i];
qry1.Prepared;
qry1.ExecSQL;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Update Demirbaslar set odano=:odano where barkod='''+AdvZimmet.Cells[8,i]+''' ');
Qry1.Parameters.ParamByName('odano').Value          := TmpOdaNo ;
qry1.Prepared;
qry1.ExecSql;




qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := AdvZimmet.Cells[6,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := AdvZimmet.Cells[8,i]  ;
Qry1.Parameters.ParamByName('tarih').Value         := Now ;
Qry1.Parameters.ParamByName('yapilanis').Value     :=  TmpOdaNo +' Nolu Odaya Alýndý (Eþya)';
qry1.Prepared;
qry1.ExecSQL;

end;


kayitgetir;
end;

procedure TFrmZimmet.EyavePersonelOdaNoDeitir1Click(Sender: TObject);
var TmpOdaNo,TmpSql:String;
i:integer;
begin

TmpOdaNo:= InputBox('','Lütfen Personel ve Eþya Oda Numarasýný Giriniz ...','') ;

if Trim(TmpOdaNo) = '' then exit;


                                                //esyaodano

for i:=1 to AdvZimmet.RowCount-1 do begin

if AdvZimmet.Cells[1,i]<>'Y' then Continue;

TmpSql := 'Update zimmet set perodano=:perodano, esyaodano=:esyaodano where id=:id' ;
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('perodano').Value  := TmpOdaNo ;
Qry1.Parameters.ParamByName('esyaodano').Value := TmpOdaNo ;
Qry1.Parameters.ParamByName('id').Value        := AdvZimmet.Cells[9,i];
qry1.Prepared;
qry1.ExecSQL;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Update Demirbaslar set odano=:odano where barkod='''+AdvZimmet.Cells[8,i]+''' ');
Qry1.Parameters.ParamByName('odano').Value          := TmpOdaNo ;
qry1.Prepared;
qry1.ExecSql;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Update PersonelBilgisi set odano=:odano where id='''+IntToStr(lblpersonelara.Tag)+''' ');
Qry1.Parameters.ParamByName('odano').Value          := TmpOdaNo ;
qry1.Prepared;
qry1.ExecSql;


qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := AdvZimmet.Cells[6,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := AdvZimmet.Cells[8,i]  ;
Qry1.Parameters.ParamByName('tarih').Value         := Now ;
Qry1.Parameters.ParamByName('yapilanis').Value     := AdvZimmet.Cells[2,i]+' '+AdvZimmet.Cells[3,i]+ ' kiþi ve Eþya  ' + TmpOdaNo +' Nolu Odaya Alýndý';
qry1.Prepared;
qry1.ExecSQL;

end;


kayitgetir;
end;

procedure TFrmZimmet.kaydet;
var i,x:integer;
TmpSql:String;
begin
x:=0;

for i:=1 to AdvEsya.RowCount-1 do begin
if AdvEsya.Cells[1,i]='Y' Then Begin

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('Select peradi,persoyadi from zimmet where demirbasid='''+AdvEsya.Cells[0,i]+'''');
qry1.Open;

if Qry1.RecordCount <> 0 Then begin
showmessage('"'+AdvEsya.Cells[2,i]+'"'+' Demirbaþ '+Qry1.FieldByname('peradi').asstring+' '+Qry1.FieldByname('persoyadi').asstring+' isimli '
+' Personele Zimmetli, Tekrar Zimmetlenemez ... ');
continue;
end;

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('Select id from zimmet where perid='''+IntToStr(lblpersonelara.Tag)+''' and demirbasid='''+AdvEsya.Cells[0,i]+'''');
qry1.Open;

if Qry1.RecordCount <> 0 Then continue;


TmpSql := 'insert into zimmet (perid,demirbasid,peradi,persoyadi,pergorevi,perodano,esyanincinsi,esyaodano,barkod,bolum1,bolum2) ' +
'values (:perid,:demirbasid,:peradi,:persoyadi,:pergorevi,:perodano,:esyanincinsi,:esyaodano,:barkod,:bolum1,:bolum2) ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('perid').Value        := lblpersonelara.Tag ;
Qry1.Parameters.ParamByName('demirbasid').Value   := AdvEsya.Cells[0,i] ;
Qry1.Parameters.ParamByName('peradi').Value       := txtadi.Text ;
Qry1.Parameters.ParamByName('persoyadi').Value    := txtsoyadi.Text ;
Qry1.Parameters.ParamByName('pergorevi').Value    := txtgorevi.Text ;
Qry1.Parameters.ParamByName('perodano').Value     := txtodano.Text ;
Qry1.Parameters.ParamByName('esyanincinsi').Value := AdvEsya.Cells[2,i] ;
Qry1.Parameters.ParamByName('esyaodano').Value    := AdvEsya.Cells[3,i] ;
Qry1.Parameters.ParamByName('barkod').Value       := AdvEsya.Cells[4,i] ;

Qry1.Parameters.ParamByName('bolum1').Value       := AdvEsya.Cells[5,i] ;
Qry1.Parameters.ParamByName('bolum2').Value       := AdvEsya.Cells[6,i] ;

qry1.Prepared;
qry1.ExecSQL;
x:=x+1;

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := AdvEsya.Cells[2,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := AdvEsya.Cells[4,i]  ;
Qry1.Parameters.ParamByName('tarih').Value         := Now ;
Qry1.Parameters.ParamByName('yapilanis').Value     := txtadi.Text+' '+txtsoyadi.Text+ ' kiþiye zimmet yapýlmýþtýr.';
qry1.Prepared;
qry1.ExecSQL;

end;
end;

LblStatus.Caption := inttostr(x)+ ' Zimmet Kaydedildi ...' ;

end;

procedure TFrmZimmet.kayitgetir;
var i:integer;
begin

AdvZimmet.ClearRows(1,AdvZimmet.RowCount-1);
//AdvZimmet.RowCount := 2;


qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select * from zimmet where perid = '''+inttostr(lblpersonelara.tag)+''' ');
qry2.Open;

if Qry2.RecordCount = 0 Then Exit;

AdvZimmet.RowCount :=  Qry2.RecordCount+1;

for i:=1 to Qry2.RecordCount  do  begin

AdvZimmet.AddCheckBox(1,i,False,True);
AdvZimmet.Cells[2,i]:=Qry2.fieldbyname('PerAdi').AsString;
AdvZimmet.Cells[3,i]:=Qry2.fieldbyname('PerSoyadi').AsString;
AdvZimmet.Cells[4,i]:=Qry2.fieldbyname('PerGorevi').AsString;
AdvZimmet.Cells[5,i]:=Qry2.fieldbyname('PerOdaNo').AsString;
AdvZimmet.Cells[6,i]:=Qry2.fieldbyname('EsyaninCinsi').AsString;
AdvZimmet.Cells[7,i]:=Qry2.fieldbyname('EsyaOdaNo').AsString;
AdvZimmet.Cells[8,i]:=Qry2.fieldbyname('Barkod').AsString;
AdvZimmet.Cells[9,i]:=Qry2.fieldbyname('id').AsString;

Qry2.Next;
end;

AdvZimmet.AutoNumberCol(0);

end;

procedure TFrmZimmet.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = Vk_F5 then temizle;
if key = VK_ESCAPE then cikis;
if key = VK_F2 then kaydet;
if key = VK_F4 then sil;
end;

procedure TFrmZimmet.FormShow(Sender: TObject);
begin
AdvZimmet.ColWidths[9]:=1;
end;

procedure TFrmZimmet.sil;
var TmpEsyaninnCinsi,TmpBarkod,TmpYapilanis:string;
i:integer;
begin






for i:=1 to  AdvZimmet.RowCount-1 do begin

if AdvZimmet.Cells[1,i]<>'Y' then continue;


TmpEsyaninnCinsi := AdvZimmet.Cells[6,i] ;
TmpBarkod := AdvZimmet.Cells[8,i] ;
TmpYapilanis := AdvZimmet.Cells[2,i]+' '+AdvZimmet.Cells[3,i]+ ' kiþinin zimmeti silinmiþtir';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete from zimmet where id='''+AdvZimmet.Cells[9,i]+''' ');
qry1.ExecSQL;



qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := TmpEsyaninnCinsi ;
Qry1.Parameters.ParamByName('barkodno').Value      := TmpBarkod ;
Qry1.Parameters.ParamByName('tarih').Value         := Now ;
Qry1.Parameters.ParamByName('yapilanis').Value     := TmpYapilanis ;
qry1.Prepared;
qry1.ExecSQL;




end;

end;

procedure TFrmZimmet.Button1Click(Sender: TObject);
begin
if MsgOnay('Kaydý Silmek Ýstediðinize Emin Misiniz ?')=False Then  exit;

sil;

kayitgetir;
end;

procedure TFrmZimmet.Button2Click(Sender: TObject);
begin
kaydet;
kayitgetir;
end;

procedure TFrmZimmet.Button3Click(Sender: TObject);
begin
cikis;
end;

end.
