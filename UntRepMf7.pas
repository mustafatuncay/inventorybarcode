unit UntRepMf7;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TRepMf7 = class(TQuickRep)
    QRBand2: TQRBand;
    QRDBEsyaCinsi: TQRDBText;
    QRDBGrupKodu: TQRDBText;
    QRDBTurKodu: TQRDBText;
    QRDBCesitKodu: TQRDBText;
    QRDBId: TQRDBText;
    QRBand3: TQRBand;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRBand4: TQRBand;
    QRMemo1: TQRMemo;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBKiymet: TQRDBText;
    QRDBKurum: TQRDBText;
    QRLAdet: TQRLabel;
    QRDBDemirbasSayi: TQRDBText;
    QRDBDemirbasYil: TQRDBText;
    QRLabel6: TQRLabel;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape6: TQRShape;
    QRShape5: TQRShape;
    QRShape4: TQRShape;
    QRShape3: TQRShape;
    QRShape2: TQRShape;
    QRShape1: TQRShape;
    QRMemo2: TQRMemo;
    QRMemo3: TQRMemo;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRLilgilibakanlik: TQRLabel;
    QRLabel7: TQRLabel;
    QRLSube: TQRLabel;
    QRLOdaNo: TQRLabel;
    QRLBakanlikveDaire: TQRLabel;
    QRExpr1: TQRExpr;
  private

  public

  end;

var
  RepMf7: TRepMf7;

implementation

uses UntRapor;

{$R *.DFM}

end.
