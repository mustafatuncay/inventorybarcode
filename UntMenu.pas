unit UntMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons,registry, ComCtrls, DB, ADODB;

type
  TFrmMenu = class(TForm)
    Image2: TImage;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    P2: TLabel;
    P3: TLabel;
    P6: TLabel;
    P5: TLabel;
    P4: TLabel;
    P1: TLabel;
    Panel1: TPanel;
    Label7: TLabel;
    Memo1: TMemo;
    P7: TLabel;
    Label8: TLabel;
    Image9: TImage;
    Image10: TImage;
    P8: TLabel;
    Image8: TImage;
    Timer1: TTimer;
    Qry1: TADOQuery;
    procedure P2Click(Sender: TObject);
    procedure P3Click(Sender: TObject);
    procedure P6Click(Sender: TObject);
    procedure P5Click(Sender: TObject);
    procedure P4Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure P7Click(Sender: TObject);
    procedure P8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

uses UntDemirbasKayit, UntZimmet, UntRapor, UntSabitTanimlar, UntPersonel,
  UntMalzemeKodlama, UntDm, UntProjectGlobal, UntGlobal, UntSayimKontrol,printers,
  UntBarkod, UntYonetim, UntGiris;

{$R *.dfm}

procedure TFrmMenu.P2Click(Sender: TObject);
begin
FrmDemirbasKayit:=TFrmDemirbasKayit.Create(self);
FrmDemirbasKayit.temizle;
FrmDemirbasKayit.ShowModal;
FrmDemirbasKayit.Free;
end;

procedure TFrmMenu.P3Click(Sender: TObject);
begin
FrmPersonel:=TFrmPersonel.Create(self);
FrmPersonel.ShowModal;
FrmPersonel.Free;
end;

procedure TFrmMenu.P6Click(Sender: TObject);
begin
FrmRapor:=TFrmRapor.Create(self);
FrmRapor.ShowModal;
FrmRapor.Free;
end;

procedure TFrmMenu.P5Click(Sender: TObject);
begin
{
FrmBarkod:=TFrmBarkod.Create(self);
FrmBarkod.ShowModal;
FrmBarkod.Free;

exit;
}

FrmZimmet:=TFrmZimmet.Create(self);
FrmZimmet.ShowModal;
FrmZimmet.Free;
end;

procedure TFrmMenu.P4Click(Sender: TObject);
begin
FrmSabitTanimlar:=TFrmSabitTanimlar.Create(self);
FrmSabitTanimlar.ShowModal;
FrmSabitTanimlar.Free;
end;

procedure TFrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FrmGiris.Close;
end;

procedure TFrmMenu.P1Click(Sender: TObject);
begin
FrmMalzemeKodlama:=TFrmMalzemeKodlama.Create(self);
FrmMalzemeKodlama.ShowModal;
FrmMalzemeKodlama.Free;
end;

procedure TFrmMenu.P7Click(Sender: TObject);
begin
FrmSayimKontrol:=TFrmSayimKontrol.Create(self);
FrmSayimKontrol.ShowModal;
FrmSayimKontrol.Free;
end;

procedure TFrmMenu.P8Click(Sender: TObject);
begin
FrmYonetim:=TFrmYonetim.Create(self);



FrmYonetim.TabSheet2.TabVisible:=False;
FrmYonetim.TabSheet3.TabVisible:=False;
FrmYonetim.TabSheet4.TabVisible:=False;


FrmYonetim.ShowModal;
FrmYonetim.Free;
end;

procedure TFrmMenu.Timer1Timer(Sender: TObject);
var x:integer;
begin
//TxtMesaj.Text := IntToStr(StrToInt(TxtMesaj.Text) + 1);
//BtnDoviz.Click;
x:=0;
try

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select id from lastnumbers');
qry1.Prepared;
qry1.Open;


except
 x:=1;
end;


if x=1 then  begin
dm.Cnn1.Close;
Try
dm.Cnn1.Open();
except

End;
end;


end;
end.
