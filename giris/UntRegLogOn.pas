unit UntRegLogOn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, ToolEdit, CurrEdit, RxGIF, jpeg,
  Buttons, ComCtrls, XPMan, DB, ADODB;

type
  TFrmRegLogOn = class(TForm)
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    Image1: TImage;
    SalerID01: TEdit;
    SalerID02: TEdit;
    SalerID03: TEdit;
    SalerID04: TEdit;
    GroupBox1: TGroupBox;
    lblProID01: TLabel;
    lblProID02: TLabel;
    lblProID03: TLabel;
    lblProID04: TLabel;
    Image3: TImage;
    txtInput01: TEdit;
    txtInput02: TEdit;
    txtInput03: TEdit;
    txtInput04: TEdit;
    GroupBox2: TGroupBox;
    lblProID05: TLabel;
    lblProID06: TLabel;
    lblProID07: TLabel;
    lblProID08: TLabel;
    Image4: TImage;
    txtInput05: TEdit;
    txtInput06: TEdit;
    txtInput07: TEdit;
    txtInput08: TEdit;
    BtnRegOkey: TSpeedButton;
    BtnRegCancel: TSpeedButton;
    lblVersiyon: TLabel;
    Panel2: TPanel;
    Label3: TLabel;
    txtkullanici: TEdit;
    Label4: TLabel;
    txtsifre: TEdit;
    BtnStart: TSpeedButton;
    BtnClose: TSpeedButton;
    Label13: TLabel;
    Qry1: TADOQuery;
    procedure BtnStartClick(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
  private

  public
    { Public declarations }
    ActLogon:Boolean;
  end;

var
  FrmRegLogOn: TFrmRegLogOn;
      icounter:integer;

implementation

uses UntDm, UntGlobal, UntUyari, menu;




{$R *.dfm}

procedure TFrmRegLogOn.BtnStartClick(Sender: TObject);
var TmpSql : String;
begin
TmpSql:= 'Select * from Kullanici where kullaniciadi = '''+txtkullanici.Text+''' and sifre = '''+Encrypt(txtsifre.Text,1,2,3,4)+''' ' ;

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.Open;

if qry1.RecordCount = 0 Then begin
MsgUyari('Yanlýþ Kullanýcý veya Þifre !!! ');
Exit;
end;

Self.Hide;

FrmMenu:=TFrmMenu.Create(Self);
FrmMenu.ShowModal;
FrmMenu.free;

end;

procedure TFrmRegLogOn.BtnCloseClick(Sender: TObject);
begin
Application.Terminate;
end;

end.
