unit UntBarkodVeriAyar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, StdCtrls, Mask;

type
  TFrmBarkodVeriAyar = class(TForm)
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    F8menu: TSpeedButton;
    StatusBar1: TStatusBar;
    SpeedButton2: TSpeedButton;
    StaticText5: TStaticText;
    ComboBox2: TComboBox;
    StaticText6: TStaticText;
    StaticText8: TStaticText;
    ComboBox3: TComboBox;
    StaticText10: TStaticText;
    StaticText7: TStaticText;
    ComboBox4: TComboBox;
    StaticText9: TStaticText;
    ComboBox5: TComboBox;
    GroupBox5: TGroupBox;
    ComboBox6: TComboBox;
    StaticText1: TStaticText;
    StaticText3: TStaticText;
    GroupBox6: TGroupBox;
    ComboBox7: TComboBox;
    StaticText13: TStaticText;
    ComboBox8: TComboBox;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    StaticText2: TStaticText;
    StaticText4: TStaticText;
    ComboBox9: TComboBox;
    Edit1: TEdit;
    SpeedButton3: TSpeedButton;
    OD1: TOpenDialog;
    procedure F8menuClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure OD1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure ComboBox6Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBarkodVeriAyar: TFrmBarkodVeriAyar;
  Dosya_secildi:Boolean;
  function PDX_Remot_Set_Comm(Port : string;Baud : integer;DataBit,StopBit,Parity : Byte):integer; stdcall; external 'Remot.dll';  //stdcall;
  function PDX_Remot_Online():Longint; stdcall; external 'Remot.dll';  //stdcall;
  function PDX_Remot_Offline():Longint; stdcall; external 'Remot.dll';  //stdcall;
implementation

uses  Math, UntBarkodVeriAktar;

{$R *.dfm}

procedure TFrmBarkodVeriAyar.F8menuClick(Sender: TObject);
begin
FrmBarkodVeriAyar.FormStyle:=fsNormal;
FrmBarkodVeriAyar.Close;
end;

procedure TFrmBarkodVeriAyar.SpeedButton1Click(Sender: TObject);
begin
  FrmBarkodVeriAktar.Memo1.lines[0]:=Statictext5.Caption+'='+Combobox1.Text;
  FrmBarkodVeriAktar.Memo1.lines[1]:=Statictext6.Caption+'='+Combobox2.Text;
  FrmBarkodVeriAktar.Memo1.lines[2]:=Statictext10.Caption+'='+Combobox3.Text;
  FrmBarkodVeriAktar.Memo1.lines[3]:=Statictext7.Caption+'='+Combobox4.Text;
  FrmBarkodVeriAktar.Memo1.lines[4]:=Statictext9.Caption+'='+Combobox5.Text;
  FrmBarkodVeriAktar.Memo1.lines[5]:=Statictext4.Caption+'='+Combobox9.Text;
  FrmBarkodVeriAktar.Memo1.lines[6]:=Statictext1.Caption+'='+Combobox6.Text;
  FrmBarkodVeriAktar.Memo1.lines[7]:=Statictext13.Caption+'='+Combobox7.Text;
  FrmBarkodVeriAktar.Memo1.lines[8]:=Statictext14.Caption+'='+Combobox8.Text;
  FrmBarkodVeriAktar.Memo1.lines[9]:=Statictext2.Caption+'='+Edit1.Text;
  FrmBarkodVeriAktar.Memo1.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'Ayar.set');

  FrmBarkodVeriAktar.memo1.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'Ayar.set');
  FrmBarkodVeriAktar.Label6.Caption:=Trim(Copy(FrmBarkodVeriAktar.Memo1.Lines[0],pos('=',FrmBarkodVeriAktar.Memo1.Lines[0])+1,(Length(FrmBarkodVeriAktar.Memo1.Lines[0]))-pos('=',FrmBarkodVeriAktar.memo1.Lines[0])+1));
  FrmBarkodVeriAktar.Label7.Caption:=Trim(Copy(FrmBarkodVeriAktar.Memo1.Lines[1],pos('=',FrmBarkodVeriAktar.Memo1.Lines[1])+1,(Length(FrmBarkodVeriAktar.Memo1.Lines[1]))-pos('=',FrmBarkodVeriAktar.memo1.Lines[1])+1));
  FrmBarkodVeriAktar.Label8.Caption:=Trim(Copy(FrmBarkodVeriAktar.Memo1.Lines[2],pos('=',FrmBarkodVeriAktar.Memo1.Lines[2])+1,(Length(FrmBarkodVeriAktar.Memo1.Lines[2]))-pos('=',FrmBarkodVeriAktar.memo1.Lines[2])+1));
  FrmBarkodVeriAktar.Label9.Caption:=Trim(Copy(FrmBarkodVeriAktar.Memo1.Lines[3],pos('=',FrmBarkodVeriAktar.Memo1.Lines[3])+1,(Length(FrmBarkodVeriAktar.Memo1.Lines[3]))-pos('=',FrmBarkodVeriAktar.memo1.Lines[3])+1));
  FrmBarkodVeriAktar.Label10.Caption:=Trim(Copy(FrmBarkodVeriAktar.Memo1.Lines[5],pos('=',FrmBarkodVeriAktar.Memo1.Lines[5])+1,(Length(FrmBarkodVeriAktar.Memo1.Lines[5]))-pos('=',FrmBarkodVeriAktar.memo1.Lines[5])+1));
  FrmBarkodVeriAktar.SD1.FileName:=Trim(Copy(FrmBarkodVeriAktar.Memo1.Lines[9],pos('=',FrmBarkodVeriAktar.Memo1.Lines[9])+1,(Length(FrmBarkodVeriAktar.Memo1.Lines[9]))-pos('=',FrmBarkodVeriAktar.memo1.Lines[9])+1));
  FrmBarkodVeriAktar.Label12.Caption:=Trim(Copy(FrmBarkodVeriAktar.Memo1.Lines[6],pos('=',FrmBarkodVeriAktar.Memo1.Lines[6])+1,(Length(FrmBarkodVeriAktar.Memo1.Lines[6]))-pos('=',FrmBarkodVeriAktar.memo1.Lines[6])+1));
  FrmBarkodVeriAktar.Label13.Caption:=Trim(Copy(FrmBarkodVeriAktar.Memo1.Lines[7],pos('=',FrmBarkodVeriAktar.Memo1.Lines[7])+1,(Length(FrmBarkodVeriAktar.Memo1.Lines[7]))-pos('=',FrmBarkodVeriAktar.memo1.Lines[7])+1));

end;

procedure TFrmBarkodVeriAyar.SpeedButton2Click(Sender: TObject);
begin
  PDX_Remot_Set_Comm(ComboBox1.Text,StrToInt(ComboBox2.Text),8,0,0);
  PDX_Remot_Online;
  result := PDX_Get_Data('RX', Buffer);
  If result = 0 Then
   Begin
     Showmessage('Zebex PDL20-16 el terminali ile iletiþim saðlanamadý.Lütfen Zebex PDL20-16'+#13+' El Terminalinin açýk ve ana ekranda olduðunu kontrol ediniz.');
   End;
   PDX_Remot_Offline();
end;

procedure TFrmBarkodVeriAyar.SpeedButton3Click(Sender: TObject);
begin
  OD1.Execute;
  If Dosya_secildi Then
  Begin
    If Od1.FilterIndex=1 Then
    Begin
      Edit1.Text:=OD1.FileName+'.TXT';
      ComboBox6.Text:='TXT';
    End;
    If Od1.FilterIndex=2 Then
    Begin
      Edit1.Text:=OD1.FileName+'.CSV';
      ComboBox6.Text:='CSV';
    End;
    If Od1.FilterIndex=3 Then
    Begin
      Edit1.Text:=OD1.FileName+'.XLS';
      ComboBox6.Text:='XLS';
    End;
  End;
end;

procedure TFrmBarkodVeriAyar.OD1CanClose(Sender: TObject; var CanClose: Boolean);
begin
  Dosya_secildi:=True;
end;

procedure TFrmBarkodVeriAyar.ComboBox6Change(Sender: TObject);
begin
  Edit1.Text:=Copy(Edit1.Text,1,Length(Edit1.Text)-3)+ComboBox6.Text;
  OD1.FilterIndex:=ComboBox6.ItemIndex+1;
end;

end.

