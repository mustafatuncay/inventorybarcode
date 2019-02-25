unit UntRepBos;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  TRepBos = class(TQuickRep)
    QRBand2: TQRBand;
    QRDBSiraNo: TQRDBText;
  private

  public

  end;

var
  RepBos: TRepBos;

implementation

uses UntAlk1, UntRapor, UntDm;

{$R *.DFM}

end.
