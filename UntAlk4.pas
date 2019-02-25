unit UntAlk4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB,DateUtils;

type
  TFrmAlk4 = class(TForm)
    txtyer: TEdit;
    Label1: TLabel;
    Qry1: TADOQuery;
    Label2: TLabel;
    txtizahat: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAlk4: TFrmAlk4;

implementation

uses UntRapor, UntGlobal;

{$R *.dfm}

procedure TFrmAlk4.Button1Click(Sender: TObject);
var TmpSql:String;
i:integer;
begin

for i:=1 to FrmRapor.AdvDemirbas.RowCount - 1 do begin

if FrmRapor.AdvDemirbas.Cells[1,i] <> 'Y' Then Continue;

TmpSql:='update demirbaslar set aktarildi = ''Y'', AktarilanYer =:AktarilanYer, Aktarilanizahat=:Aktarilanizahat  where id ='''+FrmRapor.AdvDemirbas.Cells[0,i]+''' ';

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('AktarilanYer').Value     := txtyer.text ;
Qry1.Parameters.ParamByName('Aktarilanizahat').Value  := txtizahat.text ;
qry1.Prepared;
qry1.ExecSQL;


qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := FrmRapor.AdvDemirbas.Cells[4,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := FrmRapor.AdvDemirbas.Cells[2,i]  ;
Qry1.Parameters.ParamByName('tarih').Value := IntToStr(YearOf(date))+'-'+
                                              IntToStr(MonthOf(Date))+'-'+
                                              IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('yapilanis').Value     := ' Aktarma : ' +txtyer.Text;
qry1.Prepared;
qry1.ExecSQL;


end;
showmessage('Ýþlem Tamamlandý ....');

end;

end.
