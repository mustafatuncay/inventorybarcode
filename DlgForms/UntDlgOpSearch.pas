unit UntDlgOpSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls;

type
  TFrmDlgOpSearch = class(TForm)
    PnlCaption: TPanel;
    Shape1: TShape;
    CapImage: TImage;
    Label1: TLabel;
    Panel4: TPanel;
    btnTamam: TSpeedButton;
    Btniptal: TSpeedButton;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    BtnAra: TSpeedButton;
    cmbKriter: TComboBox;
    txtKriter: TEdit;
    procedure BtniptalClick(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure BtnAraClick(Sender: TObject);
    procedure txtKriterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Grd1DblClick(Sender: TObject);
    procedure Grd1GetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TabloAdi,KriterSonuc,actStockCode:String;
    Uygula:Boolean;

  end;

var
  FrmDlgOpSearch: TFrmDlgOpSearch;

implementation

uses UntDm, ADODB,DB, UntGlobal;

{$R *.dfm}

procedure TFrmDlgOpSearch.BtniptalClick(Sender: TObject);
begin
  Uygula:=False;
  Self.Close;
end;
// ****
procedure TFrmDlgOpSearch.btnTamamClick(Sender: TObject);
begin
if  DM.QryArama.Active then
  if DM.QryArama.recordcount>0 then
  begin
    KriterSonuc:=Dm.QryArama.FieldValues['ID'];
    Uygula:=True;
    self.Close;
  end;
end;

procedure TFrmDlgOpSearch.BtnAraClick(Sender: TObject);
var
  QryStr:string;
begin
with DM.QryArama do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select a.*,(Select DepoAdi From Depo Where DepoNo=a.DepoID)as DepoAdi From '+TabloAdi+' as a ');
case cmbKriter.ItemIndex of
0: qryStr:='  Where a.OpNumber like :Kriter and StockCode=:Bul' ; // Belge No
1: qryStr:='  Where a.OpType   like :Kriter and StockCode=:Bul' ; // Hareket Türü
2: qryStr:='  Where a.OpDefinition like :Kriter  and StockCode=:Bul' ;//Açýklama
end;
  SQL.Add(qryStr);
  Parameters.ParamByName('Kriter').Value:=txtKriter.Text+'%';
  Parameters.ParamByName('Bul').Value:=actStockCode;
  Prepared ;
  open;
  (FieldByName('InValue') as TNumericField ).DisplayFormat:='#,##0.000';
  (FieldByName('OutValue')as TNumericField ).DisplayFormat:='#,##0.000';
end;
end;
// ***
procedure TFrmDlgOpSearch.txtKriterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then BtnAra.Click;
end;

procedure TFrmDlgOpSearch.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click ;
end;

procedure TFrmDlgOpSearch.Grd1GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
if Acol>6 then HAlign:=taRightJustify;
end;

procedure TFrmDlgOpSearch.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Escape then Btniptal.Click;
end;

procedure TFrmDlgOpSearch.FormShow(Sender: TObject);
begin
Caption:=proCaption;
end;

end.
