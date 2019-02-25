unit UntRepAlk1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB, ADODB;

type
  TRepAlk1 = class(TQuickRep)
    QRBand3: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel11: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape11: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
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
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRMemo1: TQRMemo;
    QRLabel15: TQRLabel;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    QRLabel16: TQRLabel;
    C0R0: TQRLabel;
    C0R1: TQRLabel;
    C0R2: TQRLabel;
    C0R3: TQRLabel;
    C0R4: TQRLabel;
    C0R5: TQRLabel;
    C0R6: TQRLabel;
    C0R7: TQRLabel;
    C0R8: TQRLabel;
    C0R9: TQRLabel;
    C0R10: TQRLabel;
    C0R11: TQRLabel;
    C0R12: TQRLabel;
    C0R13: TQRLabel;
    C0R14: TQRLabel;
    C0R15: TQRLabel;
    C0R16: TQRLabel;
    C0R17: TQRLabel;
    C0R18: TQRLabel;
    C0R19: TQRLabel;
    C1R0: TQRLabel;
    C1R1: TQRLabel;
    C1R2: TQRLabel;
    C1R3: TQRLabel;
    C1R4: TQRLabel;
    C1R5: TQRLabel;
    C1R6: TQRLabel;
    C1R7: TQRLabel;
    C1R8: TQRLabel;
    C1R9: TQRLabel;
    C1R10: TQRLabel;
    C1R11: TQRLabel;
    C1R12: TQRLabel;
    C1R13: TQRLabel;
    C1R14: TQRLabel;
    C1R15: TQRLabel;
    C1R16: TQRLabel;
    C1R17: TQRLabel;
    C1R18: TQRLabel;
    C1R19: TQRLabel;
    C2R0: TQRLabel;
    C2R1: TQRLabel;
    C2R2: TQRLabel;
    C2R3: TQRLabel;
    C2R4: TQRLabel;
    C2R5: TQRLabel;
    C2R6: TQRLabel;
    C2R7: TQRLabel;
    C2R8: TQRLabel;
    C2R9: TQRLabel;
    C2R10: TQRLabel;
    C2R11: TQRLabel;
    C2R12: TQRLabel;
    C2R13: TQRLabel;
    C2R14: TQRLabel;
    C2R15: TQRLabel;
    C2R16: TQRLabel;
    C2R17: TQRLabel;
    C2R18: TQRLabel;
    C2R19: TQRLabel;
    C3R0: TQRLabel;
    C3R1: TQRLabel;
    C3R2: TQRLabel;
    C3R3: TQRLabel;
    C3R4: TQRLabel;
    C3R5: TQRLabel;
    C3R6: TQRLabel;
    C3R7: TQRLabel;
    C3R8: TQRLabel;
    C3R9: TQRLabel;
    C3R10: TQRLabel;
    C3R11: TQRLabel;
    C3R12: TQRLabel;
    C3R13: TQRLabel;
    C3R14: TQRLabel;
    C3R15: TQRLabel;
    C3R16: TQRLabel;
    C3R17: TQRLabel;
    C3R18: TQRLabel;
    C3R19: TQRLabel;
    C4R0: TQRLabel;
    C4R1: TQRLabel;
    C4R2: TQRLabel;
    C4R3: TQRLabel;
    C4R4: TQRLabel;
    C4R5: TQRLabel;
    C4R6: TQRLabel;
    C4R7: TQRLabel;
    C4R8: TQRLabel;
    C4R9: TQRLabel;
    C4R10: TQRLabel;
    C4R11: TQRLabel;
    C4R12: TQRLabel;
    C4R13: TQRLabel;
    C4R14: TQRLabel;
    C4R15: TQRLabel;
    C4R16: TQRLabel;
    C4R17: TQRLabel;
    C4R18: TQRLabel;
    C4R19: TQRLabel;
    C5R0: TQRLabel;
    C5R1: TQRLabel;
    C5R2: TQRLabel;
    C5R3: TQRLabel;
    C5R4: TQRLabel;
    C5R5: TQRLabel;
    C5R6: TQRLabel;
    C5R7: TQRLabel;
    C5R8: TQRLabel;
    C5R9: TQRLabel;
    C5R10: TQRLabel;
    C5R11: TQRLabel;
    C5R12: TQRLabel;
    C5R13: TQRLabel;
    C5R14: TQRLabel;
    C5R15: TQRLabel;
    C5R16: TQRLabel;
    C5R17: TQRLabel;
    C5R18: TQRLabel;
    C5R19: TQRLabel;
  private

  public

  end;

var
  RepAlk1: TRepAlk1;

implementation

uses UntAlk1, UntRapor, UntDm;

{$R *.DFM}

end.
