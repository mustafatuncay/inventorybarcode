unit UntOnay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, GIFImg;

type
  TFrmOnay = class(TForm)
    Label1: TLabel;
    lblCaption: TLabel;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure BtnIptalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      ActOnay:Boolean;
      ActCaption:string;
  end;

var
  FrmOnay: TFrmOnay;

implementation

{$R *.dfm}

procedure TFrmOnay.BtnIptalClick(Sender: TObject);
begin
end;
// ***
procedure TFrmOnay.FormCreate(Sender: TObject);
begin
    lblCaption.Caption:= ActCaption;
end;
// ***
procedure TFrmOnay.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(WM_SYSCOMMAND,$F012,0);
end;

procedure TFrmOnay.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 Then   Self.Close;
end;

procedure TFrmOnay.Button2Click(Sender: TObject);
begin
  ActOnay:=False;
  Self.Close;
end;

procedure TFrmOnay.Button1Click(Sender: TObject);
begin
 ActOnay:=True;
  Self.Close;
end;

end.
