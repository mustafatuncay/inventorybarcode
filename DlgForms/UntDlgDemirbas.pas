unit UntDlgDemirbas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls,
  DBAdvGrid, DBGrids, jpeg, DB, ADODB;

type
  TFrmDlgDemirbas = class(TForm)
    PnlCaption: TPanel;
    Shape1: TShape;
    CapImage: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    BtnAra: TSpeedButton;
    cmbKriter: TComboBox;
    txtKiriter: TEdit;
    Panel4: TPanel;
    btnTamam: TSpeedButton;
    Btniptal: TSpeedButton;
    DBGrid1: TDBGrid;
    Qry1: TADOQuery;
    ds1: TDataSource;
    procedure BtnAraClick(Sender: TObject);
    procedure txtKiriterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtniptalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure Grd1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    actCariKod,actTUnvan:String;
    ActBakiye:Double;
    iptal:Boolean;
    TmpStatus:string;
    { Public declarations }
  end;

var
  FrmDlgDemirbas: TFrmDlgDemirbas;

implementation

uses UntDm, UntGlobal;

{$R *.dfm}

procedure TFrmDlgDemirbas.BtnAraClick(Sender: TObject);
var TmpSql:String;
begin
TmpSql:='Select * from demirbaslar where ';

if cmbKriter.Text = 'Eþyanýn Cinsi' Then
TmpSql:=TmpSql+'esyacinsi like '''+txtKiriter.Text+'%'' ';
if cmbKriter.Text = 'Oda No' Then
TmpSql:=TmpSql+'odano = '''+trim(txtKiriter.Text)+''' ';
if cmbKriter.Text = 'Yýl' Then
TmpSql:=TmpSql+'DemirbasYil like '''+txtKiriter.Text+'%'' ';

if cmbKriter.Text = 'Demirbaþ No' Then
TmpSql:=TmpSql+'id = '''+txtKiriter.Text+''' ';

Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add(TmpSql);
Qry1.Open;
end;


procedure TFrmDlgDemirbas.txtKiriterKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=13 then BtnAra.Click;
end;
// ***
procedure TFrmDlgDemirbas.BtniptalClick(Sender: TObject);
begin
  iptal:=True;
  Self.Close;
end;
// ***
procedure TFrmDlgDemirbas.FormCreate(Sender: TObject);
begin
  iptal:=True;
with DM.QryArama do
  begin
    Close;
    SQL.Clear;
  end;
end;
// ***
procedure TFrmDlgDemirbas.btnTamamClick(Sender: TObject);
begin
if (qry1.Active=False) or (qry1.RecordCount=0) then exit
else
begin
  iptal :=False;
  Self.Close;
end;
end;
// ***
procedure TFrmDlgDemirbas.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

procedure TFrmDlgDemirbas.FormShow(Sender: TObject);
begin
  Caption:=proCaption;
end;
// ***
procedure TFrmDlgDemirbas.DBGrid1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

end.
