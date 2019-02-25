program PrjEnvanter;

uses
  Forms,
  UntMenu in 'UntMenu.pas' {FrmMenu},
  UntZimmet in 'UntZimmet.pas' {FrmZimmet},
  UntDm in 'genel\UntDm.pas' {Dm: TDataModule},
  UntGlobal in 'genel\UntGlobal.pas',
  UntUyari in 'DlgForms\UntUyari.pas' {FrmUyari},
  UntOnay in 'DlgForms\UntOnay.pas' {FrmOnay},
  UntRapor in 'UntRapor.pas' {FrmRapor},
  UntSabitTanimlar in 'UntSabitTanimlar.pas' {FrmSabitTanimlar},
  UntPersonel in 'UntPersonel.pas' {FrmPersonel},
  UntMalzemeKodlama in 'UntMalzemeKodlama.pas' {FrmMalzemeKodlama},
  UntDlgPersonel in 'DlgForms\UntDlgPersonel.pas' {FrmDlgPersonel},
  UntRepAlk1Arka in 'UntRepAlk1Arka.pas' {RepAlk1Arka: TQuickRep},
  UntRepAlk4 in 'UntRepAlk4.pas' {RepAlk4: TQuickRep},
  UntDemirbasKayit in 'UntDemirbasKayit.pas' {FrmDemirbasKayit},
  UntProjectGlobal in 'genel\UntProjectGlobal.pas',
  UntDlgDemirbas in 'DlgForms\UntDlgDemirbas.pas' {FrmDlgDemirbas},
  UntBarkod in 'UntBarkod.pas' {FrmBarkod},
  UntAlk4 in 'UntAlk4.pas' {FrmAlk4},
  UntSayimKontrol in 'UntSayimKontrol.pas' {FrmSayimKontrol},
  UntAlk1 in 'UntAlk1.pas' {FrmAlk1},
  UntBarkodVeriAktar in 'UntBarkodVeriAktar.pas' {FrmBarkodVeriAktar},
  UntBarkodVeriAyar in 'UntBarkodVeriAyar.pas' {FrmBarkodVeriAyar},
  UntRepTutanak in 'UntRepTutanak.pas' {RepTutanak: TQuickRep},
  UntRepPersonel in 'UntRepPersonel.pas' {RepPersonel: TQuickRep},
  UntRepZimmet in 'UntRepZimmet.pas' {RepZimmet: TQuickRep},
  UntRepMf7 in 'UntRepMf7.pas' {RepMf7: TQuickRep},
  UntRepBos in 'UntRepBos.pas' {RepBos: TQuickRep},
  UntRepAlk1 in 'UntRepAlk1.pas' {RepAlk1: TQuickRep},
  UntGiris in 'UntGiris.pas' {FrmGiris},
  UntYonetim in 'UntYonetim.pas' {FrmYonetim},
  UntRepDemirbasGunlugu in 'UntRepDemirbasGunlugu.pas' {RepDemirbasGunlugu: TQuickRep},
  UntRepRapor2 in 'UntRepRapor2.pas' {RepRapor2: TQuickRep},
  UntRepRapor3 in 'UntRepRapor3.pas' {RepRapor3: TQuickRep};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFrmGiris, FrmGiris);
  Application.CreateForm(TFrmBarkodVeriAyar, FrmBarkodVeriAyar);
  Application.Run;
end.
