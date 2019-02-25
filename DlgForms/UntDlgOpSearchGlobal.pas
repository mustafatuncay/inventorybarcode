unit UntDlgOpSearchGlobal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls;

type
  TFrmDlgOpSearchGlobal = class(TForm)
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
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    aramaSQL,KriterSonucID:String;
    Uygula:Boolean;

  end;

var
  FrmDlgOpSearchGlobal: TFrmDlgOpSearchGlobal;

implementation

uses UntDm, ADODB,DB;

{$R *.dfm}

procedure TFrmDlgOpSearchGlobal.BtniptalClick(Sender: TObject);
begin
  Uygula:=False;
  Self.Close;
end;
// ****
procedure TFrmDlgOpSearchGlobal.btnTamamClick(Sender: TObject);
begin
if  DM.QryArama.Active then
  if DM.QryArama.recordcount>0 then
  begin
    KriterSonucID:=Dm.QryArama.FieldValues['BKayitNo'];
    Uygula:=True;
    self.Close;
  end;
end;

procedure TFrmDlgOpSearchGlobal.BtnAraClick(Sender: TObject);
var
  QryStr:string;
begin
with DM.QryArama do
begin
  Close;
  SQL.Clear;
  SQL.Add(aramaSQL);
case cmbKriter.ItemIndex of
0: qryStr:='  Where OpNumber like :Kriter ' ; // Belge No
1: qryStr:='  Where OpDefinition like :Kriter ' ;//Açýklama
end;
  SQL.Add(qryStr);
  Parameters.ParamByName('Kriter').Value:=txtKriter.Text+'%';
  Prepared ;
  open;
end;
  Grd1.AutoSize:=True;
  Grd1.AutoSizeRows(True,1);


end;
// ***
procedure TFrmDlgOpSearchGlobal.txtKriterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then BtnAra.Click;
end;

procedure TFrmDlgOpSearchGlobal.Grd1DblClick(Sender: TObject);
begin
  btnTamam.Click ;
end;

procedure TFrmDlgOpSearchGlobal.Grd1GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
if Acol>6 then HAlign:=taRightJustify;
end;

procedure TFrmDlgOpSearchGlobal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Escape then Btniptal.Click;
end;

end.
