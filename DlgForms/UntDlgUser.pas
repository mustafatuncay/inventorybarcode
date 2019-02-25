unit UntDlgUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls,
  DBAdvGrid, DBGrids, jpeg;

type
  TFrmDlgUser = class(TForm)
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
  FrmDlgUser: TFrmDlgUser;

implementation

uses UntDm, UntGlobal;

{$R *.dfm}

procedure TFrmDlgUser.BtnAraClick(Sender: TObject);
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
procedure TFrmDlgUser.txtKiriterKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=13 then BtnAra.Click;
end;
// ***
procedure TFrmDlgUser.BtniptalClick(Sender: TObject);
begin
  iptal:=True;
  Self.Close;
end;
// ***
procedure TFrmDlgUser.FormCreate(Sender: TObject);
begin
  iptal:=True;
with DM.QryArama do
  begin
    Close;
    SQL.Clear;
  end;
end;
// ***
procedure TFrmDlgUser.btnTamamClick(Sender: TObject);
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
procedure TFrmDlgUser.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

procedure TFrmDlgUser.FormShow(Sender: TObject);
begin
  Caption:=proCaption;
end;
// ***
procedure TFrmDlgUser.DBGrid1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

end.
