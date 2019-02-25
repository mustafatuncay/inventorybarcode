unit UntDlgTedarikciArama;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls;

type
  TFrmDlgTedarikciArama = class(TForm)
    PnlCaption: TPanel;
    Shape1: TShape;
    CapImage: TImage;
    Label1: TLabel;
    Panel4: TPanel;
    btnTamam: TSpeedButton;
    Btniptal: TSpeedButton;
    Panel2: TPanel;
    Label3: TLabel;
    BtnAra: TSpeedButton;
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
    ActTedarickiAdi:String;
    ActTedarickiID:Integer;
    iptal:Boolean;

  end;

var
  FrmDlgTedarikciArama: TFrmDlgTedarikciArama;

implementation

uses UntDm, ADODB,DB, UntGlobal;

{$R *.dfm}

procedure TFrmDlgTedarikciArama.BtniptalClick(Sender: TObject);
begin
  Iptal:=False;
  Self.Close;
end;
// ****
procedure TFrmDlgTedarikciArama.btnTamamClick(Sender: TObject);
begin
if  DM.QryArama.Active then
  if DM.QryArama.recordcount>0 then
  begin
    ActTedarickiID  :=Dm.QryArama.FieldValues['ID'];
    ActTedarickiAdi :=Dm.QryArama.FieldValues['FirmaAd'];
    iptal:=False;
    self.Close;
  end;
end;
// ***
procedure TFrmDlgTedarikciArama.BtnAraClick(Sender: TObject);
begin
with DM.QryArama do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * From Tedarikci  Where FirmaAd Like :Kriter ');
  Parameters.ParamByName('Kriter').Value:=txtKriter.Text+'%';
  Prepared ;
  open;
  (FieldByName('ID') as TNumericField).Visible:=False;
end;
end;
// ***
procedure TFrmDlgTedarikciArama.txtKriterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then BtnAra.Click;
end;

procedure TFrmDlgTedarikciArama.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click ;
end;

procedure TFrmDlgTedarikciArama.Grd1GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
if Acol>6 then HAlign:=taRightJustify;
end;

procedure TFrmDlgTedarikciArama.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Escape then Btniptal.Click;
end;

procedure TFrmDlgTedarikciArama.FormShow(Sender: TObject);
begin
  Caption:=proCaption;
  Dm.QryArama.Close;
  Dm.QryArama.SQL.Clear;
end;

end.
