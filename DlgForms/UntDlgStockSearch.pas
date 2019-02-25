unit UntDlgStockSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,  StdCtrls, Buttons, ExtCtrls,
  DBAdvGrid, DB, ADODB, DBGrids;

type
  TFrmDlgStockSearch = class(TForm)
    PnlCaption: TPanel;
    Shape1: TShape;
    CapImage: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    BtnAra: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    cmbKriter: TComboBox;
    txtKiriter: TEdit;
    Panel4: TPanel;
    btnTamam: TSpeedButton;
    Btniptal: TSpeedButton;
    DBGrid1: TDBGrid;
    StokQuery: TADOQuery;
    DSStokQuery: TDataSource;
    procedure BtniptalClick(Sender: TObject);
    procedure BtnAraClick(Sender: TObject);
    procedure txtKiriterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnTamamClick(Sender: TObject);
    procedure Grd1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    actStokKod,actStokAdi,actUnit,actKDV,actBarkod,actPBirim:String;
    ActHesapKod,ActHesapAdi,ActHPBirim:String;
    actStockAmount:Double;
    iptal:Boolean;
  end;

var
  FrmDlgStockSearch: TFrmDlgStockSearch;

implementation

uses UntDm,UntGlobal;

{$R *.dfm}

procedure TFrmDlgStockSearch.BtniptalClick(Sender: TObject);
begin
  iptal:=True;
  Self.Close;
end;
// ***
procedure TFrmDlgStockSearch.BtnAraClick(Sender: TObject);
begin
(*
Table Name	Stoklar
Field Name	Type	  Size	Definition
ID			                  Primary Key
StockCode	  Text	  5	    Stok Kodu
BarCode	    Text	  15	  Ürün Barkod Numarasý
PartName	  Text	  30	  Ürün Tanýmý
UnitPrice	  Number		    Birim Fiyatý
Quantity	  Number		    Miktar
Unit	      Text	  10	  Ölçü Birimi
Exchange	  Text	  10	  Para Birimi
KDV	        Number		    KDV Oraný %
StockAmount	Number		    Stok Giriþ Toplamý

StockType	  Text	  1	    Üretim =1 ,Diðer=0
*)
with StokQuery do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select SK.StockCode,SK.PartName,SK.StockAmount,SK.Unit,');
  SQL.Add('SK.BarCode,SK.KDV,SK.Exchange,SK.StokHesapNo,');
  SQL.Add('HP.HesapAdi,HP.PBirim From Hesaplar2007 as HP , Stok as SK');
  SQL.Add('Where HP.Hesapkod=SK.StokHesapNo ');
case cmbKriter.ItemIndex of
0 : SQL.Add('and SK.PartName   like :kriter ');
1 : SQL.Add('and SK.StockCode  like :kriter ');
2 : SQL.Add('and SK.BarCode    like :kriter ');
end;
  SQL.Add(' order by SK.StockCode Asc ');
  Parameters.ParamByName('kriter').Value:=txtKiriter.Text+'%' ;
  //ShowMessage(SQL.Text); fro debugging;
  Prepared;
  Open;
  (FieldByName('StockAmount') as  TNumericField ).DisplayFormat:='#,##0.000';
end;
end;
// ***
procedure TFrmDlgStockSearch.txtKiriterKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key=13 then BtnAra.Click;
end;
//***
procedure TFrmDlgStockSearch.btnTamamClick(Sender: TObject);
begin
if (StokQuery.Active=False) or (StokQuery.RecordCount=0) then
  Exit
else
begin
  actStokKod:=StokQuery.FieldValues['StockCode'];
  actStokAdi:=StokQuery.FieldValues['PartName'];
  actUnit   :=StokQuery.FieldValues['Unit'];
  actKDV    :=StokQuery.FieldValues['KDV'];
  actBarkod :=StokQuery.FieldValues['BarCode'];
  actStockAmount:=StokQuery.FieldValues['StockAmount'];
  actPBirim     :=StokQuery.FieldValues['Exchange'];
  ActHesapKod   :=StokQuery.FieldValues['StokHesapNo'];
  ActHesapAdi   :=StokQuery.FieldValues['HesapAdi'];
  ActHPBirim    :=StokQuery.FieldValues['PBirim'];
  iptal:=False;
  Self.Close;
end;
end;
// ***
procedure TFrmDlgStockSearch.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

procedure TFrmDlgStockSearch.FormCreate(Sender: TObject);
begin
  StokQuery.Close;
end;
// **
procedure TFrmDlgStockSearch.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Escape then Btniptal.Click;
end;
// ***
procedure TFrmDlgStockSearch.FormShow(Sender: TObject);
begin
  Caption:=proCaption;
end;
// ***
procedure TFrmDlgStockSearch.DBGrid1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

end.
