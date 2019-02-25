unit UntDlgInvoiceSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrd, StdCtrls, Buttons, ExtCtrls;

type
  TFrmDlgInvoiceSearch = class(TForm)
    PnlCaption: TPanel;
    Shape1: TShape;
    CapImage: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    BtnAra: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    cmbKriter: TComboBox;
    txtKiriter: TEdit;
    Grd1: TDBAdvStringGrid;
    Panel4: TPanel;
    btnTamam: TSpeedButton;
    Btniptal: TSpeedButton;
    procedure BtniptalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDlgInvoiceSearch: TFrmDlgInvoiceSearch;

implementation

uses UntGlobal;

{$R *.dfm}

procedure TFrmDlgInvoiceSearch.BtniptalClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFrmDlgInvoiceSearch.FormShow(Sender: TObject);
begin
Caption:=proCaption;
end;

end.
