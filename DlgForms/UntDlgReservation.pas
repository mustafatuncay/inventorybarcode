unit UntDlgReservation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls,
  DBAdvGrid, DBGrids, jpeg, DB, ADODB;

type
  TFrmDlgReservation = class(TForm)
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
  FrmDlgReservation: TFrmDlgReservation;

implementation

uses UntDm, UntGlobal;

{$R *.dfm}

procedure TFrmDlgReservation.BtnAraClick(Sender: TObject);
begin
Qry1.Close;
Qry1.SQL.Clear;
Qry1.SQL.Add('Select * from clients where status in ('''+TmpStatus+''') ');
case cmbKriter.ItemIndex of
0 : Qry1.SQL.Add('and name  like :kriter ');
1 : Qry1.SQL.Add('and surname like :kriter ');
end;
Qry1.SQL.Add(' order by name ');
Qry1.Parameters.ParamByName('kriter').Value:=txtKiriter.Text+'%' ;
Qry1.Prepared;
Qry1.Open;
end;


procedure TFrmDlgReservation.txtKiriterKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=13 then BtnAra.Click;
end;
// ***
procedure TFrmDlgReservation.BtniptalClick(Sender: TObject);
begin
  iptal:=True;
  Self.Close;
end;
// ***
procedure TFrmDlgReservation.FormCreate(Sender: TObject);
begin
  iptal:=True;
with DM.QryArama do
  begin
    Close;
    SQL.Clear;
  end;
end;
// ***
procedure TFrmDlgReservation.btnTamamClick(Sender: TObject);
begin
if (qry1.Active=False) or (qry1.RecordCount=0) then exit
else
begin
  iptal :=False;
  Self.Close;
end;
end;
// ***
procedure TFrmDlgReservation.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

procedure TFrmDlgReservation.FormShow(Sender: TObject);
begin
  Caption:=proCaption;
end;
// ***
procedure TFrmDlgReservation.DBGrid1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;

end.
