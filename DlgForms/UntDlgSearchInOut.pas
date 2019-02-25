unit UntDlgSearchInOut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls,
  DBGrids;

type
  TFrmDlgSearchInOut = class(TForm)
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
    DBGrid1: TDBGrid;
    procedure BtniptalClick(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure BtnAraClick(Sender: TObject);
    procedure txtKriterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ActGCode,ActGDefinition,ActKTur,ActRezCode:String;
    ActGType:integer;
    Uygula:Boolean;

  end;

var
  FrmDlgSearchInOut: TFrmDlgSearchInOut;

implementation

uses  UntGlobal, UntDm, DB;

{$R *.dfm}

procedure TFrmDlgSearchInOut.BtniptalClick(Sender: TObject);
begin
  Uygula:=False;
  Self.Close;
end;
// ****
procedure TFrmDlgSearchInOut.btnTamamClick(Sender: TObject);
begin
if  DM.QryArama.Active then
  if DM.QryArama.recordcount>0 then
  begin
    ActGCode       :=Dm.QryArama.FieldByName('GCode').AsString;
    ActGDefinition :=Dm.QryArama.FieldByName('GDefinition').AsString;
    ActKTur        :=Dm.QryArama.FieldByName('KTur').AsString;
    ActRezCode     :=Dm.QryArama.FieldByName('RezCode').AsString;
    ActGType       :=Dm.QryArama.FieldByName('GType').AsInteger;
    Uygula:=True;
    self.Close;
  end;
end;
// ***
procedure TFrmDlgSearchInOut.BtnAraClick(Sender: TObject);
var
  QryStr:string;
begin
with DM.QryArama do
begin
  Close;
  SQL.Clear;
  Close;
  SQL.Clear;
  SQL.Add('Select *,IIf(GType=0,''Giderler'',''Gelirler'') as KTur ');
  SQL.Add('From InOutInfo2005 Where ');
  case cmbKriter.ItemIndex of
  0: qryStr:='  GCode  like :Kriter ';      // Hesap kod
  1: qryStr:='  GDefinition  like :Kriter ';// Taným
end;
  SQL.Add(qryStr);
  SQL.Add(' Order By Gcode Asc ');
  Parameters.ParamByName('Kriter').Value:=txtKriter.Text+'%';
  Prepared ;
  open;
end;
end;
// ***
procedure TFrmDlgSearchInOut.txtKriterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then BtnAra.Click;
end;
// ***
procedure TFrmDlgSearchInOut.FormShow(Sender: TObject);
begin
  Caption:=proCaption;
  with DM.QryArama do
  begin
    Close;
    SQL.Clear;
  end;
end;
// ***
procedure TFrmDlgSearchInOut.DBGrid1DblClick(Sender: TObject);
begin
  btnTamam.Click ;
end;

end.
