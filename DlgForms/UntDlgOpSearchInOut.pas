unit UntDlgOpSearchInOut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls;

type
  TFrmDlgOpSearchInOut = class(TForm)
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
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    AramaStr,KriterSonuc,ActOpNumber,ActOpDefinition,ActOutValue,ActOpDate:String;
    Uygula:Boolean;

  end;

var
  FrmDlgOpSearchInOut: TFrmDlgOpSearchInOut;

implementation

uses UntDm, ADODB,DB, UntGlobal;

{$R *.dfm}

procedure TFrmDlgOpSearchInOut.BtniptalClick(Sender: TObject);
begin
  Uygula:=False;
  Self.Close;
end;
// ****
procedure TFrmDlgOpSearchInOut.btnTamamClick(Sender: TObject);
begin
if  DM.QryArama.Active then
  if DM.QryArama.recordcount>0 then
  begin
    KriterSonuc:=Dm.QryArama.FieldValues['ID'];
    ActOpNumber:=Dm.QryArama.FieldValues['OpNumber'];
    ActOpDefinition:=Dm.QryArama.FieldValues['OpDefinition'];
    ActOutValue:=Dm.QryArama.FieldValues['OutValue'];
    ActOpDate:=Dm.QryArama.FieldValues['OpDate'];
    Uygula:=True;
    self.Close;
  end;
end;
// ***
procedure TFrmDlgOpSearchInOut.BtnAraClick(Sender: TObject);
var
  QryStr:string;
begin
with DM.QryArama do
begin
  Close;
  SQL.Clear;
  Close;
  SQL.Clear;
  SQL.Add('Select a.*,(Select BHesapNo From Bank  Where BHesapNo=a.BHesapNo)as HesapNo,');
  SQl.Add('(Select BHesapAd From Bank  Where BHesapNo=a.BHesapNo)as BankaAdi From InOutExtre2005 as a');
  SQL.Add(' Where GCode=:Bul and ');
case cmbKriter.ItemIndex of
0: qryStr:='  a.OpNumber      like :Kriter '; // Belge No
1: qryStr:='  a.OpDefinition  like :Kriter ';//Açýklama
end;
  SQL.Add(qryStr);
  Parameters.ParamByName('Kriter').Value:=txtKriter.Text+'%';
  Parameters.ParamByName('Bul').Value:=AramaStr;
  Prepared ;
  open;
  (FieldByName('InValue') as TNumericField ).DisplayFormat:='#,##0.000';
  (FieldByName('OutValue')as TNumericField ).DisplayFormat:='#,##0.000';
end;
end;
// ***
procedure TFrmDlgOpSearchInOut.txtKriterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then BtnAra.Click;
end;
// ***
procedure TFrmDlgOpSearchInOut.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click ;
end;
// ***
procedure TFrmDlgOpSearchInOut.Grd1GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if Acol>5 then HAlign:=taRightJustify;
end;

procedure TFrmDlgOpSearchInOut.FormShow(Sender: TObject);
begin
  Caption:=proCaption;
with DM.QryArama do
begin
  Close;
  SQL.Clear;
end;
end;

end.
