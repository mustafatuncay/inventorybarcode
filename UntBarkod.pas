unit UntBarkod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Barcode,WinSpool,Printers;

type
  TFrmBarkod = class(TForm)
    Image1: TImage;
    Button2: TButton;
    Edit2: TEdit;
    Button3: TButton;
    ListBox1: TListBox;
    Button1: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Barcode1: TBarcode;
    Button7: TButton;
    ComboBox1: TComboBox;
    Button8: TButton;
    PrintDialog1: TPrintDialog;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SetDefaultPrinter(PrinterName: String);
    { Public declarations }
  end;

var
  FrmBarkod: TFrmBarkod;

implementation

uses WinTypes, WinProcs,IniFiles, UntRapor, AdvGrid,
  UntGlobal;

{$R *.dfm}




procedure TFrmBarkod.Button2Click(Sender: TObject);

begin


Barcode1.inputText:= Edit2.Text ;
Image1.Picture := nil;
//Barcode1.DrawBarcode(Image1.Canvas);

end;

procedure TFrmBarkod.Button3Click(Sender: TObject);
begin
{
with printer do
     begin
        BeginDoc;

        Canvas.TextOut(20, 10, 'Barcode Printing');
        Canvas.TextOut(20, 30, 'Mustafa Tuncay');

        // Height of barcode: 40mm
        barcode1.Height := ConvertMmToPixelsY(10);
        //barcode1.Height := ConvertInchToPixelsY(1.5);

        // Modulwidth: 0.5mm
        Barcode1.Modul  := ConvertMmToPixelsX(0.5);

        barcode1.Top    := ConvertMmToPixelsY(10.0);
        barcode1.Left   := ConvertMmToPixelsX(2.0);

        Barcode1.DrawBarcode(Canvas);

        EndDoc;
      end;
      }

end;

procedure TFrmBarkod.Button1Click(Sender: TObject);
var
printer:tprinter;
begin
     printer:=tprinter.create;
     listbox1.items.assign(printer.printers)
end;

procedure TFrmBarkod.Button4Click(Sender: TObject);
begin

//showmessage(ListBox1.Items.Strings[ListBox1.ItemIndex]);
SetDefaultPrinter(ListBox1.Items.Strings[ListBox1.ItemIndex]);


end;


procedure TFrmBarkod.SetDefaultPrinter(PrinterName: String);
var
   I: Integer;
   Device : PChar;
   Driver : Pchar;
   Port   : Pchar;
   HdeviceMode: Thandle;
   aPrinter : TPrinter;
begin
  Printer.PrinterIndex := -1;
  getmem( device, 255);
  getmem( Driver, 255);
  getmem( Port, 255);
  aPrinter := TPrinter.create;
  for I := 0 to Printer.printers.Count-1 do
  begin
    if Printer.printers[i] = PrinterName then
    begin
      aprinter.printerindex := i;
      aPrinter.getprinter( device, driver, port, HdeviceMode);
      StrCat(Device, ',');
      StrCat(Device, Driver );
      StrCat(Device, Port );
      WriteProfileString('windows', 'device', Device );
      StrCopy( Device, 'windows' );
      SendMessage(HWND_BROADCAST, WM_WININICHANGE, 0, Longint(@Device));
   end;
  end;
  freemem( device, 255);
  freemem( Driver, 255);
  freemem( Port, 255);
  aPrinter.free;
end;

procedure TFrmBarkod.Button5Click(Sender: TObject);
var i,x,tt:integer;
TmpStr1,TmpStr2:String;
begin


with printer do
     begin
        //printer.printerindex := printer.Printers.IndexOf('Label Dr 200 (4 inch model)') ;

        BeginDoc;

        Canvas.Font.Name := 'Tahoma';
        Canvas.Font.Size := 5;

        Canvas.TextOut(30, 40, 'Burhan Nalbantoðlu Devlet Hastanesi');

        TmpStr1:='12345'   ;

        for x:=1 to  length(TmpStr1) do begin
        TmpStr2:= TmpStr2 + TmpStr1[x];
        if  x=50 Then begin
        Canvas.TextOut(30, 60, TmpStr2);
        TmpStr2:='';
        end;
        end;

        if length(TmpStr1)>50 Then
           Canvas.TextOut(30, 75, TmpStr2);

        if length(TmpStr1)<50 Then
           Canvas.TextOut(30, 60, TmpStr2);


        Canvas.TextOut(30, 95, 'Oda No: xx Demirbaþ No: yy ');


      //  Barcode1.Bitmap.Width := 10;
      //  Barcode1.Height := 10;

         Canvas.Brush.Bitmap := Barcode1.Bitmap;
        //Image1.Picture.Bitmap := Barcode1.Bitmap;
         //Image1.Canvas.Draw(c);

        //Canvas.TextOut(30, 235, '**');
        EndDoc;
      end;

      exit;




if  MsgOnay('Barkod Yazdýrma Ýþlemi Baþlasýn Mý ?') = False Then  Exit;




for i:=1 to FrmRapor.AdvDemirbas.RowCount - 1 do begin


if FrmRapor.AdvDemirbas.Cells[1,i] ='Y' Then begin
TmpStr2:='';
TmpStr1:='';


Barcode1.InputText:= FrmRapor.AdvDemirbas.Cells[2,i] ;
Image1.Picture := nil;



with printer do
     begin
        //printer.printerindex := printer.Printers.IndexOf('Label Dr 200 (4 inch model)') ;

        BeginDoc;
        Canvas.Font.Name := 'Tahoma';
        Canvas.Font.Size := 5;

        Canvas.TextOut(30, 40, 'Burhan Nalbantoðlu Devlet Hastanesi');

        TmpStr1:=FrmRapor.AdvDemirbas.Cells[3,i];

        for x:=1 to  length(TmpStr1) do begin
        TmpStr2:= TmpStr2 + TmpStr1[x];
        if  x=50 Then begin
        Canvas.TextOut(30, 60, TmpStr2);
        TmpStr2:='';
        end;
        end;

        if length(TmpStr1)>50 Then
           Canvas.TextOut(30, 75, TmpStr2);

        if length(TmpStr1)<50 Then
           Canvas.TextOut(30, 60, TmpStr2);


        Canvas.TextOut(30, 95, 'Oda No: '+FrmRapor.AdvDemirbas.Cells[6,i]+', Demirbaþ No: '+FrmRapor.AdvDemirbas.Cells[0,i]);

        Image1.Picture.Bitmap := Barcode1.Bitmap;

        //Canvas.TextOut(30, 235, '**');
        EndDoc;
      end;
end;



end;

end;

procedure TFrmBarkod.Button6Click(Sender: TObject);
var i:integer;
begin
Printer.PrinterIndex  :=  Printer.Printers.IndexOf('Argox OS-214 plus series PPLA');


for i:=1 to FrmRapor.AdvDemirbas.RowCount - 1 do begin

if FrmRapor.AdvDemirbas.Cells[1,i] ='Y' Then begin

//http://www.delphifaq.com/faq/f729.shtml
//http://stackoverflow.com/questions/7777870/printing-real-dimensions-of-an-image

Barcode1.InputText :=  FrmRapor.AdvDemirbas.Cells[2,i] ;

Printer.BeginDoc;
Printer.Canvas.Font.Name := 'Tahoma';
Printer.Canvas.Font.Size := 7;

Printer.Canvas.TextOut(40, 0, 'Dr. Burhan Nalbantoðlu Devlet Hastanesi');
Printer.Canvas.TextOut(40, 22, FrmRapor.AdvDemirbas.Cells[12,i]);    //bölüm
Printer.Canvas.TextOut(40, 44, FrmRapor.AdvDemirbas.Cells[4,i]);     // Demirbas Adi
Printer.Canvas.TextOut(40, 67, 'Oda Adý: '+FrmRapor.AdvDemirbas.Cells[10,i] );
Printer.Canvas.TextOut(40, 90, 'Oda No: '+FrmRapor.AdvDemirbas.Cells[9,i]+', Demirbaþ No: '+FrmRapor.AdvDemirbas.Cells[0,i]);
Printer.Canvas.StretchDraw(Rect (40,120,350,180), Barcode1.Bitmap);

Canvas.Brush.Bitmap := Barcode1.Bitmap;

Printer.EndDoc;
end;

end;
end;

procedure TFrmBarkod.Button7Click(Sender: TObject);
const
  {
   The TPrinterDefaults structure specifies the default data type,
   environment, initialization data, and access rights for a printer.
  }
  Defaults: TPrinterDefaults = (pDatatype: nil;
    pDevMode: nil;
    DesiredAccess: STANDARD_RIGHTS_REQUIRED or PRINTER_ACCESS_USE);
var
  hPrinter: THandle;
  Device: array[0..255] of char;
  Driver: array[0..255] of char;
  Port: array[0..255] of char;
  hDeviceMode: THandle;
  RetVal: Boolean;
begin
  Printer.PrinterIndex := Combobox1.ItemIndex;
  { Retrieve information about the specified printer }
  Printer.GetPrinter(Device,
    Driver,
    Port,
    hDeviceMode);
  { Retrieve a handle identifying the specified printer or print }
  if not OpenPrinter(@Device, hPrinter, @Defaults) then
    RaiseLastWin32Error;
  try
    { Display a printer-properties property sheet for the specified printer }
    PrinterProperties(Handle, hPrinter);
  finally
    { Close the specified printer object }
    ClosePrinter(hPrinter);
  end;
end;

procedure TFrmBarkod.Button8Click(Sender: TObject);
begin
PrintDialog1.Execute();
end;

procedure TFrmBarkod.FormCreate(Sender: TObject);
begin
 { Show available printers in a Combobox }
  Combobox1.Items := Printer.Printers;
  Combobox1.ItemIndex := 0;
end;

end.


