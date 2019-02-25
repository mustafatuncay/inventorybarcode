unit UntRepTutanak;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRepTutanak = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRExpr1: TQRExpr;
    QRDBText7: TQRDBText;
    QRLabel10: TQRLabel;
    QRBand4: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel6: TQRLabel;
    QrlTeslimAlanAdi: TQRLabel;
    QrlTeslimAlanSoyadi: TQRLabel;
    QrlTeslimEdenAdi: TQRLabel;
    QrlTeslimEdenSoyadi: TQRLabel;
    QRLabel7: TQRLabel;
    QrlTarih: TQRLabel;
  private

  public

  end;

var
  RepTutanak: TRepTutanak;

implementation

uses UntRapor;

{$R *.DFM}

end.
