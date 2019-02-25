unit UntDlgUserSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ImgList, Grids, DBGrids, BaseGrid,
  AdvGrid, DBAdvGrd, DBAdvGrid, DB, ADODB;

type
  TFrmDlgUserSearch = class(TForm)
    PnlCaption: TPanel;
    Shape1: TShape;
    CapImage: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    BtnAra: TSpeedButton;
    Label2: TLabel;
    txtKiriter: TEdit;
    Panel4: TPanel;
    btnTamam: TSpeedButton;
    BtnIptal: TSpeedButton;
    Grd1: TDBAdvGrid;
    DSQryPersonel: TDataSource;
    QryPersonel: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnIptalClick(Sender: TObject);
    procedure BtnAraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure Grd1DblClick(Sender: TObject);
    procedure txtKiriterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  AKullanici:String;
  ARecID    :integer;
  iptal:Boolean;
  end;

var
  FrmDlgUserSearch: TFrmDlgUserSearch;

implementation

uses UntDm,  UntGlobal;

{$R *.dfm}

procedure TFrmDlgUserSearch.FormCreate(Sender: TObject);
begin
  Caption:=ProCaption;
  iptal:=true;

end;
// ***
procedure TFrmDlgUserSearch.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_Escape then   Btniptal.Click ;
end;
// ***
procedure TFrmDlgUserSearch.BtnIptalClick(Sender: TObject);
begin
  self.Close;
  iptal:=true;
end;
// ***
procedure TFrmDlgUserSearch.BtnAraClick(Sender: TObject);
begin
with QryPersonel  do
begin
  close;
  SQL.Clear;
  SQL.Add('Select * from Kullanici  Where ');
  SQL.Add(' kullaniciadi like :kriter order by kullaniciadi  Asc ');
  Parameters.ParamByName('kriter').Value:=txtKiriter.Text + '%' ;
  Prepared;
  Open;
end;
end;
// ***
procedure TFrmDlgUserSearch.FormShow(Sender: TObject);
begin
with QryPersonel  do
begin
  Close;
  SQL.Clear;
end;
end;
// ***
procedure TFrmDlgUserSearch.btnTamamClick(Sender: TObject);
begin
if (QryPersonel.Active =False) or (QryPersonel.RecordCount=0) then Exit;
  AKullanici:=QryPersonel.FieldValues['KullaniciAdi'];
  ARecID    :=QryPersonel.FieldValues['RecID'];
  iptal:=false;
  self.Close;
end;
// ***
procedure TFrmDlgUserSearch.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click;
end;
// ***
procedure TFrmDlgUserSearch.txtKiriterKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = 13 then  btnaraClick(sender);
end;
end.
