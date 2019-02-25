unit UntSabitTanimlar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Menus, DB, ADODB, StdCtrls, Buttons,
  Mask, Grids, DBGrids, BaseGrid, AdvGrid, DBAdvGrid, AdvObj, tmsAdvGridExcel;

type
  TFrmSabitTanimlar = class(TForm)
    Label2: TLabel;
    Panel1: TPanel;
    Image2: TImage;
    Label1: TLabel;
    Image4: TImage;
    LblStatus: TLabel;
    Panel3: TPanel;
    Label4: TLabel;
    Label3: TLabel;
    TxtTanim: TEdit;
    Panel4: TPanel;
    Image1: TImage;
    Panel5: TPanel;
    Qry1: TADOQuery;
    CmbKriter: TComboBox;
    Ds1: TDataSource;
    Qry2: TADOQuery;
    AdvDbList: TDBAdvGrid;
    Panel2: TPanel;
    Image3: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    GridExcelListe: TAdvGridExcelIO;
    SaveDialog1: TSaveDialog;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure btcikis;
    procedure btsil;
    procedure btkaydet;
    procedure btlistele;
    { Public declarations }
  end;

var
  FrmSabitTanimlar: TFrmSabitTanimlar;

implementation

uses UntGlobal;

{$R *.dfm}

procedure TFrmSabitTanimlar.btcikis;
begin
close;
end;

procedure TFrmSabitTanimlar.btsil;
begin
if Qry2.Active = False Then Exit;

qry2.Delete;

LblStatus.Caption := 'Kayýt Silindi ...';
end;

procedure TFrmSabitTanimlar.btkaydet;
begin

if trim(TxtTanim.Text) = '' Then Begin
showmessage('Lütfen Tanýmý Giriniz ...');
exit;
End;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('insert into SabitTanimlar (Kriter,Tanim) values ('''+CmbKriter.Text+''','''+Trim(TxtTanim.Text)+''') ');
qry1.ExecSQL ;


LblStatus.Caption := 'Kaydedildi ....';
btlistele;
end;

procedure TFrmSabitTanimlar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_ESCAPE then Btcikis;
if key = VK_F2 then btkaydet;
if key = VK_F4 then btsil;
end;

procedure TFrmSabitTanimlar.btlistele;
var TmpSql : String;
begin

TmpSql := 'Select * from SabitTanimlar where id <>  0 ' ;

{if CmbKriter.Text = 'Eþyanýn Tanýmý' Then
TmpSql := TmpSql + 'and kriter = '''+CmbKriter.Text+'''' ;

if CmbKriter.Text = 'Ýlgili Bakanlýk' Then
TmpSql := TmpSql + 'and kriter = '''+CmbKriter.Text+'''' ;

if CmbKriter.Text = 'Þube' Then
TmpSql := TmpSql + 'and kriter = '''+CmbKriter.Text+'''' ;

if CmbKriter.Text = 'Bakanlýk ve Daire Kodu' Then
}
TmpSql := TmpSql + 'and kriter = '''+CmbKriter.Text+'''' ;



qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);
qry2.Open;

AdvDbList.AutoNumberCol(0); 
end;

procedure TFrmSabitTanimlar.Button1Click(Sender: TObject);
begin
btlistele;
end;

procedure TFrmSabitTanimlar.Button2Click(Sender: TObject);
begin
btkaydet;
end;

procedure TFrmSabitTanimlar.Button3Click(Sender: TObject);
begin
btsil;
end;

procedure TFrmSabitTanimlar.Button4Click(Sender: TObject);
begin
btcikis;
end;

procedure TFrmSabitTanimlar.Button6Click(Sender: TObject);
begin
if SaveDialog1.Execute then
  if SaveDialog1.FileName<>'' then
    GridExcelListe.XLSExport(SaveDialog1.FileName+'.xls','Tablo')
end;

end.
