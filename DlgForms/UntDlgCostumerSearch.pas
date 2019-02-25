unit UntDlgCostumerSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls,
  DBAdvGrid, DBGrids;

type
  TFrmDlgCostumerSearch = class(TForm)
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
    { Public declarations }
  end;

var
  FrmDlgCostumerSearch: TFrmDlgCostumerSearch;

implementation

uses UntDm, UntGlobal;

{$R *.dfm}

procedure TFrmDlgCostumerSearch.BtnAraClick(Sender: TObject);
begin
with dm.QryArama do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select CariKod ,TUnvan ,(InValue-OutValue) as bakiye from CariHesap ');
case cmbKriter.ItemIndex of
0 : SQL.Add('where TUnvan  like :kriter ');
1 : SQL.Add('where CariKod like :kriter ');
end;
  SQL.Add(' order by Carikod Asc; ');
  Parameters.ParamByName('kriter').Value:=txtKiriter.Text+'%' ;
  Prepared;
  Open;
end;
end;
// ***
procedure TFrmDlgCostumerSearch.txtKiriterKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=13 then BtnAra.Click;
end;
// ***
procedure TFrmDlgCostumerSearch.BtniptalClick(Sender: TObject);
begin
  iptal:=True;
  Self.Close;
end;
// ***
procedure TFrmDlgCostumerSearch.FormCreate(Sender: TObject);
begin
  iptal:=True;
with DM.QryArama do
  begin
    Close;
    SQL.Clear;
  end;
end;
// ***
procedure TFrmDlgCostumerSearch.btnTamamClick(Sender: TObject);
begin
if (Dm.QryArama.Active=False) or (Dm.QryArama.RecordCount=0) then
  exit
else
begin
  iptal     :=False;
  actCariKod:=dm.QryArama.FieldValues['CariKod'];
  actTUnvan :=dm.QryArama.FieldValues['TUnvan'];
  ActBakiye :=dm.QryArama.FieldValues['Bakiye'];
  Self.Close;
end;
end;
// ***
procedure TFrmDlgCostumerSearch.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

procedure TFrmDlgCostumerSearch.FormShow(Sender: TObject);
begin
  Caption:=proCaption;
end;
// ***
procedure TFrmDlgCostumerSearch.DBGrid1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

end.
