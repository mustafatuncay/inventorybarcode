program Bkset;

uses
  Forms,
  UntBarkodVeriAktar in 'UntBarkodVeriAktar.pas' {FrmBarkodVeriAktar},
  UntBarkodVeriAyar in 'UntBarkodVeriAyar.pas' {FrmBarkodVeriAyar};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'VeriAktar';
  Application.CreateForm(TFrmBarkodVeriAktar, FrmBarkodVeriAktar);
  Application.CreateForm(TFrmBarkodVeriAyar, FrmBarkodVeriAyar);
  Application.Run;
end.
