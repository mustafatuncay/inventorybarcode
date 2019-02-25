unit UntUyari;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, GIFImg;

type
  TFrmUyari = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    lblCaption: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      ActCaption:string;
  end;

var
  FrmUyari: TFrmUyari;

implementation

{$R *.dfm}


// ***
procedure TFrmUyari.FormCreate(Sender: TObject);
begin
  lblCaption.Caption:= ActCaption;
end;
// ***
procedure TFrmUyari.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ReleaseCapture;
Perform(WM_SYSCOMMAND,$F012,0);
end;

procedure TFrmUyari.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 Then   Self.Close;
end;

procedure TFrmUyari.Button1Click(Sender: TObject);
begin
  Self.Close;
end;

end.
