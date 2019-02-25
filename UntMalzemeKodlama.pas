unit UntMalzemeKodlama;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Menus, DB, ADODB, StdCtrls, Buttons,
  Mask, Grids, BaseGrid, AdvGrid, ComCtrls,
  DBAdvGrid, DBGrids, AdvObj, tmsAdvGridExcel, asgprev, MoneyEdit;

type
  TFrmMalzemeKodlama = class(TForm)
    Label2: TLabel;
    Panel1: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Image4: TImage;
    LblStatus: TLabel;
    Panel2: TPanel;
    Image3: TImage;
    Panel4: TPanel;
    Image1: TImage;
    Panel5: TPanel;
    Qry1: TADOQuery;
    Panel3: TPanel;
    Ds1: TDataSource;
    AdvDBList: TDBAdvGrid;
    PopupMenu1: TPopupMenu;
    AttachDelete: TMenuItem;
    Qry2: TADOQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label9: TLabel;
    Label12: TLabel;
    TxtGrupKodu1: TEdit;
    TxtGrupAdi1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TxtTurKodu1: TEdit;
    TxtTurAdi1: TEdit;
    CmbGrupKodu1: TComboBox;
    CmbGrupAdi1: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    TxtCesitKodu1: TEdit;
    TxtCesitAdi1: TEdit;
    CmbGrupKodu2: TComboBox;
    CmbGrupAdi2: TComboBox;
    CmbTurKodu1: TComboBox;
    CmbTurAdi1: TComboBox;
    BtnKaydet3: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    BtnKaydet2: TButton;
    BtnKaydet1: TButton;
    Button1: TButton;
    Button5: TButton;
    GridExcelListe: TAdvGridExcelIO;
    PreviewListe: TAdvPreviewDialog;
    SaveDialog1: TSaveDialog;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmbGrupKodu1DropDown(Sender: TObject);
    procedure CmbGrupKodu1Change(Sender: TObject);
    procedure CmbGrupAdi1Change(Sender: TObject);
    procedure CmbGrupKodu2Change(Sender: TObject);
    procedure CmbGrupAdi2Change(Sender: TObject);
    procedure CmbGrupKodu2DropDown(Sender: TObject);
    procedure CmbTurKodu1Change(Sender: TObject);
    procedure CmbTurAdi1Change(Sender: TObject);
    procedure CmbGrupAdi2DropDown(Sender: TObject);
    procedure AttachDeleteClick(Sender: TObject);
    procedure CmbTurKodu1DropDown(Sender: TObject);
    procedure CmbTurAdi1DropDown(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AdvDBListCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure AdvDBListDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtnKaydet3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BtnKaydet2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BtnKaydet1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure btkaydet1;
    procedure btkaydet2;
    procedure btkaydet3;
    procedure temizle;
    procedure btyeni;
    procedure btcikis;
    procedure turgetir;
    procedure grupgetir;
    procedure listele;
    { Public declarations }
  end;

var
  FrmMalzemeKodlama: TFrmMalzemeKodlama;

implementation

uses UntDlgDemirbas, UntGlobal;

{$R *.dfm}

procedure TFrmMalzemeKodlama.btkaydet1;
var TmpSql,mid:string;
i:integer;
begin

if trim(TxtGrupKodu1.Text) = '' Then begin
showmessage('Lütfen Gurup Kodunu Giriniz !!! ');
exit;
end;

if trim(TxtGrupAdi1.Text) = '' Then begin
showmessage('Lütfen Gurup Adýný Giriniz !!! ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from malzemekodlari where grup=:grup ');
Qry1.Parameters.ParamByName('grup').Value := trim(TxtGrupKodu1.Text)  ;
qry1.Prepared;
qry1.Open;

if qry1.RecordCount <> 0 Then begin
showmessage('Mevcut Gurup, Lütfen Deðiþtiriniz !!!');
exit;
end;

TmpSql := 'insert into malzemekodlari (grup,cesit,tur,adi) ' +
'Values (:grup,:cesit,:tur:adi) ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('grup').Value := trim(TxtGrupKodu1.Text) ;
Qry1.Parameters.ParamByName('cesit').Value :='';
Qry1.Parameters.ParamByName('tur').Value :='' ;
Qry1.Parameters.ParamByName('adi').Value  := trim(TxtGrupAdi1.Text) ;
qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := 'Kaydedildi ... ';
TxtGrupKodu1.Clear;
TxtGrupAdi1.Clear;
end;


procedure TFrmMalzemeKodlama.temizle;
begin
TxtGrupKodu1.Clear;
TxtGrupAdi1.Clear;
CmbGrupKodu1.Clear;
CmbGrupAdi1.Clear;
CmbGrupKodu2.Clear;
CmbGrupAdi2.Clear;
TxtTurKodu1.Clear;
TxtTurAdi1.Clear;
CmbTurKodu1.Clear;
CmbTurAdi1.Clear;
TxtCesitKodu1.Clear;
TxtCesitAdi1.Clear;

BtnKaydet1.Enabled:=True;
BtnKaydet2.Enabled:=True;
BtnKaydet3.Enabled:=True;



end;

procedure TFrmMalzemeKodlama.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = Vk_F5 then btyeni;
if key = VK_ESCAPE then btcikis;
end;

procedure TFrmMalzemeKodlama.btcikis;
begin
close;
end;

procedure TFrmMalzemeKodlama.btyeni;
begin
temizle;
LblStatus.Caption := 'Alanlar Yenilendi .... ';
end;

procedure TFrmMalzemeKodlama.btkaydet2;
var TmpSql,mid:string;
i:integer;
begin

if trim(CmbGrupKodu1.Text) = '' Then begin
showmessage('Lütfen Gurup Kodunu Seçiniz !!! ');
exit;
end;

if trim(CmbGrupAdi1.Text) = '' Then begin
showmessage('Lütfen Gurup Adýný Seçiniz !!! ');
exit;
end;


if trim(TxtTurKodu1.Text) = '' Then begin
showmessage('Lütfen Tür Kodunu Giriniz !!! ');
exit;
end;

if trim(TxtTurAdi1.Text) = '' Then begin
showmessage('Lütfen Tür Adýný Giriniz !!! ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from malzemekodlari where grup=:grup and tur=:tur ');
Qry1.Parameters.ParamByName('grup').Value := trim(CmbGrupKodu1.Text)  ;
Qry1.Parameters.ParamByName('tur').Value := trim(TxtTurKodu1.Text)  ;
qry1.Prepared;
qry1.Open;

if qry1.RecordCount <> 0 Then begin
showmessage('Mevcut Tür, Lütfen Deðiþtiriniz !!!');
exit;
end;

TmpSql := 'insert into malzemekodlari (grup,tur,cesit,adi) ' +
'Values (:grup,:tur,:adi) ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('grup').Value := trim(CmbGrupKodu1.Text) ;
Qry1.Parameters.ParamByName('tur').Value  := trim(TxtTurKodu1.Text) ;
Qry1.Parameters.ParamByName('cesit').Value :='';
Qry1.Parameters.ParamByName('adi').Value  := trim(TxtTurAdi1.Text) ;
qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := 'Kaydedildi ... ';
TxtTurKodu1.Clear;
TxtTurAdi1.Clear;
end;

procedure TFrmMalzemeKodlama.btkaydet3;
var TmpSql,mid:string;
i:integer;
begin

if trim(CmbGrupKodu2.Text) = '' Then begin
showmessage('Lütfen Gurup Kodunu Seçiniz !!! ');
exit;
end;

if trim(CmbGrupAdi2.Text) = '' Then begin
showmessage('Lütfen Gurup Adýný Seçiniz !!! ');
exit;
end;


if trim(CmbTurKodu1.Text) = '' Then begin
showmessage('Lütfen Tür Kodunu Seçiniz !!! ');
exit;
end;

if trim(CmbTurAdi1.Text) = '' Then begin
showmessage('Lütfen Tür Adýný Seçiniz !!! ');
exit;
end;

if trim(TxtCesitKodu1.Text) = '' Then begin
showmessage('Lütfen Çeþit Kodunu Giriniz !!! ');
exit;
end;

if trim(TxtCesitAdi1.Text) = '' Then begin
showmessage('Lütfen Çeþit Adýný Giriniz !!! ');
exit;
end;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from malzemekodlari where grup=:grup and tur=:tur and cesit=:cesit ');
Qry1.Parameters.ParamByName('grup').Value := trim(CmbGrupKodu2.Text)  ;
Qry1.Parameters.ParamByName('tur').Value := trim(CmbTurKodu1.Text)  ;
Qry1.Parameters.ParamByName('cesit').Value := trim(TxtCesitKodu1.Text)  ;
qry1.Prepared;
qry1.Open;

if qry1.RecordCount <> 0 Then begin
showmessage('Mevcut Çeþit, Lütfen Deðiþtiriniz !!!');
exit;
end;

TmpSql := 'insert into malzemekodlari (grup,tur,cesit,adi) ' +
'Values (:grup,:tur,:cesit,:adi) ';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('grup').Value := trim(CmbGrupKodu2.Text) ;
Qry1.Parameters.ParamByName('tur').Value  := trim(CmbTurKodu1.Text) ;
Qry1.Parameters.ParamByName('cesit').Value  := trim(TxtCesitKodu1.Text) ;
Qry1.Parameters.ParamByName('adi').Value  := trim(TxtCesitAdi1.Text) ;
qry1.Prepared;
qry1.ExecSQL;

LblStatus.Caption := 'Kaydedildi ... ';
TxtCesitKodu1.Clear;
TxtCesitAdi1.Clear;

end;


procedure TFrmMalzemeKodlama.CmbGrupKodu1DropDown(Sender: TObject);
var i:integer;
begin
CmbGrupKodu1.Clear;
CmbGrupAdi1.Clear;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select grup,adi from malzemekodlari where tur = '' '' and cesit = '' '' order by grup');
qry1.Open;

if qry1.recordcount = 0 Then exit;

for i:=0 To qry1.RecordCount-1 do begin
CmbGrupKodu1.Items.Add(qry1.fieldbyname('grup').asstring);
CmbGrupAdi1.Items.Add(qry1.fieldbyname('Adi').asstring);
Qry1.Next;
end;

end;

procedure TFrmMalzemeKodlama.CmbGrupKodu1Change(Sender: TObject);
begin
CmbGrupAdi1.ItemIndex:=CmbGrupKodu1.ItemIndex;
end;

procedure TFrmMalzemeKodlama.CmbGrupAdi1Change(Sender: TObject);
begin
CmbGrupKodu1.ItemIndex:=CmbGrupAdi1.ItemIndex;
end;

procedure TFrmMalzemeKodlama.CmbGrupKodu2Change(Sender: TObject);
begin
CmbGrupAdi2.ItemIndex:=CmbGrupKodu2.ItemIndex;


end;

procedure TFrmMalzemeKodlama.CmbGrupAdi2Change(Sender: TObject);
begin
CmbGrupKodu2.ItemIndex:=CmbGrupAdi2.ItemIndex;

end;

procedure TFrmMalzemeKodlama.CmbGrupKodu2DropDown(Sender: TObject);
begin
grupgetir;
end;

procedure TFrmMalzemeKodlama.CmbTurKodu1Change(Sender: TObject);
begin
CmbTurAdi1.ItemIndex:=CmbTurKodu1.ItemIndex;
end;

procedure TFrmMalzemeKodlama.CmbTurAdi1Change(Sender: TObject);
begin
CmbTurKodu1.ItemIndex:=CmbTurAdi1.ItemIndex;
end;

procedure TFrmMalzemeKodlama.turgetir;
var i:integer;
begin
CmbTurKodu1.Clear;
CmbTurAdi1.Clear;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select tur,adi from malzemekodlari where grup ='''+CmbGrupKodu2.Text+''' and tur <> '' '' and cesit = '' '' order by tur');
qry1.Open;

if qry1.recordcount = 0 Then exit;

for i:=0 To qry1.RecordCount-1 do begin
CmbTurKodu1.Items.Add(qry1.fieldbyname('tur').asstring);
CmbTurAdi1.Items.Add(qry1.fieldbyname('Adi').asstring);
Qry1.Next;
end;

end;

procedure TFrmMalzemeKodlama.grupgetir;
var i:integer;
begin
CmbGrupKodu2.Clear;
CmbGrupAdi2.Clear;
CmbTurKodu1.Clear;
CmbTurAdi1.Clear;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select grup,adi from malzemekodlari where tur = '' '' and cesit = '' '' order by grup');
qry1.Open;

if qry1.recordcount = 0 Then exit;

for i:=0 To qry1.RecordCount-1 do begin
CmbGrupKodu2.Items.Add(qry1.fieldbyname('grup').asstring);
CmbGrupAdi2.Items.Add(qry1.fieldbyname('Adi').asstring);
Qry1.Next;
end;
end;

procedure TFrmMalzemeKodlama.CmbGrupAdi2DropDown(Sender: TObject);
begin
grupgetir;
end;

procedure TFrmMalzemeKodlama.AttachDeleteClick(Sender: TObject);
Var TmpSql:String;
begin

TmpSql:= 'Select * from malzemekodlari where id <> 0 ' ;

if qry2.fieldbyname('grup').asstring <> '' Then
TmpSql:= TmpSql + ' and grup = '''+qry2.fieldbyname('grup').asstring+'''  ' ;

if qry2.fieldbyname('tur').asstring <> '' Then
TmpSql:= TmpSql + ' and tur = '''+qry2.fieldbyname('tur').asstring+'''  ' ;

if qry2.fieldbyname('cesit').asstring <> '' Then
TmpSql:= TmpSql + ' and cesit = '''+qry2.fieldbyname('cesit').asstring+'''  ' ;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.open;

if Qry1.RecordCount > 1 Then Begin
showmessage('Kayýt Silinemiyor !!!... ');
exit;
End;

qry2.Delete;

LblStatus.Caption := 'Kayýt Silindi ... ';
end;

procedure TFrmMalzemeKodlama.listele;
var i:integer;
begin
qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select id, grup,tur,cesit,adi from malzemekodlari order by grup,tur,cesit ');
qry2.Open;

AdvDBList.AutoNumberCol(0);


end;

procedure TFrmMalzemeKodlama.CmbTurKodu1DropDown(Sender: TObject);
begin
turgetir;
end;

procedure TFrmMalzemeKodlama.CmbTurAdi1DropDown(Sender: TObject);
begin
turgetir;
end;

procedure TFrmMalzemeKodlama.FormShow(Sender: TObject);
begin
PageControl1.TabIndex := 0 ;
end;

procedure TFrmMalzemeKodlama.AdvDBListCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
CanEdit:=False;
if (acol=1) and (AdvDBList.Cells[ACol,ARow]<>'') Then CanEdit := True;
if (acol=2) and (AdvDBList.Cells[ACol,ARow]<>'') Then CanEdit := True;
if (acol=3) and (AdvDBList.Cells[ACol,ARow]<>'') Then CanEdit := True;
if (acol=4) and (AdvDBList.Cells[ACol,ARow]<>'') Then CanEdit := True;

end;

procedure TFrmMalzemeKodlama.AdvDBListDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin

if (AdvDBList.Cells[1,ARow]<>'') and (AdvDBList.Cells[2,ARow]='') and (AdvDBList.Cells[3,ARow]='') Then begin
AdvDBList.RowFontColor[ARow] := clRed;
AdvDBList.FontStyles[1,ARow] := [fsBold];
AdvDBList.FontStyles[4,ARow] := [fsBold];
end;

if (AdvDBList.Cells[1,ARow]<>'') and (AdvDBList.Cells[2,ARow]<>'') and (AdvDBList.Cells[3,ARow]='') Then begin
AdvDBList.RowFontColor[ARow] := clBlue;
AdvDBList.FontStyles[1,ARow] := [fsBold];
AdvDBList.FontStyles[2,ARow] := [fsBold];
AdvDBList.FontStyles[4,ARow] := [fsBold];
end;



end;

procedure TFrmMalzemeKodlama.BtnKaydet3Click(Sender: TObject);
begin
btkaydet3;
listele;
end;

procedure TFrmMalzemeKodlama.Button2Click(Sender: TObject);
begin
close;
end;

procedure TFrmMalzemeKodlama.Button3Click(Sender: TObject);
begin
listele;
end;

procedure TFrmMalzemeKodlama.Button4Click(Sender: TObject);
begin
temizle;
LblStatus.Caption := 'Alanlar Yenilendi .... ';
end;

procedure TFrmMalzemeKodlama.Button5Click(Sender: TObject);
begin
if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
    GridExcelListe.XLSExport(SaveDialog1.FileName+'.xls','Tablo')
end;

procedure TFrmMalzemeKodlama.BtnKaydet1Click(Sender: TObject);
begin
btkaydet1;
listele;
end;

procedure TFrmMalzemeKodlama.BtnKaydet2Click(Sender: TObject);
begin
BtKaydet2;
listele;
end;

procedure TFrmMalzemeKodlama.Button1Click(Sender: TObject);
begin
PreviewListe.Execute;
end;

end.
