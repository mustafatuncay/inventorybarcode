unit UntDm;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDm = class(TDataModule)
    cnn1: TADOConnection;
    Qrylist: TADOQuery;
    Qrylist2: TADOQuery;
    QryArama: TADOQuery;
    Cnn2: TADOConnection;
    Qry2: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

end.
