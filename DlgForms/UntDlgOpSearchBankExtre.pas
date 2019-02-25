unit UntDlgOpSearchBankExtre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls;

type
  TFrmDlgOpSearchBankExtre = class(TForm)
    PnlCaption: TPanel;
    Shape1: TShape;
    CapImage: TImage;
    Label1: TLabel;
    Grd1: TDBAdvStringGrid;
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
    KriterSonuc,actBHesapNo:String;
    Uygula:Boolean;

  end;

var
  FrmDlgOpSearchBankExtre: TFrmDlgOpSearchBankExtre;

implementation

uses UntDm, ADODB,DB, UntGlobal;

{$R *.dfm}

procedure TFrmDlgOpSearchBankExtre.BtniptalClick(Sender: TObject);
begin
  Uygula:=False;
  Self.Close;
end;
// ***
procedure TFrmDlgOpSearchBankExtre.btnTamamClick(Sender: TObject);
begin
if  DM.QryArama.Active then
  if DM.QryArama.recordcount>0 then
  begin
    KriterSonuc:=Dm.QryArama.FieldValues['ID'];
    Uygula:=True;
    self.Close;
  end;
end;
// ***
procedure TFrmDlgOpSearchBankExtre.BtnAraClick(Sender: TObject);
var
  QryStr:string;
begin
with DM.QryArama do
begin
  Close;
  SQL.Clear;
  SQL.Add('Select * From BankExtre2005  ');
case cmbKriter.ItemIndex of
0: qryStr:='  Where OpNumber like :Kriter and BHesapNo=:Bul' ; // Belge No
1: qryStr:='  Where OpType   like :Kriter and BHesapNo=:Bul' ; // Hareket Türü
2: qryStr:='  Where OpDefinition like :Kriter  and BHesapNo=:Bul' ;//Açýklama
end;
  SQL.Add(qryStr);
  Parameters.ParamByName('Kriter').Value:=txtKriter.Text+'%';
  Parameters.ParamByName('Bul').Value:=actBHesapNo;
  Prepared ;
  open;
  (FieldByName('InValue') as TNumericField ).DisplayFormat:='#,##0.000';
  (FieldByName('OutValue')as TNumericField ).DisplayFormat:='#,##0.000';
end;
end;
// ***
procedure TFrmDlgOpSearchBankExtre.txtKriterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then BtnAra.Click;
end;
//
procedure TFrmDlgOpSearchBankExtre.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click ;
end;

procedure TFrmDlgOpSearchBankExtre.Grd1GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
if Acol>6 then HAlign:=taRightJustify;
end;

procedure TFrmDlgOpSearchBankExtre.FormShow(Sender: TObject);
begin
Caption:=proCaption;
end;

end.
