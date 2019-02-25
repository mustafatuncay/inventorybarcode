unit UntBarkodVeriAktar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,Comobj, Buttons, Gauges;

type
  TFrmBarkodVeriAktar = class(TForm)
    BdnLoad: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    BdnLoadFk: TButton;
    GroupBox1: TGroupBox;
    CBfmName: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Erec1: TEdit;
    Erec2: TEdit;
    Efd2: TEdit;
    Efd1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    StsBar1: TStatusBar;
    Memo1: TMemo;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo2: TMemo;
    Bconnect: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    OpenDialog1: TOpenDialog;
    SD1: TSaveDialog;
    Label10: TLabel;
    Gauge1: TGauge;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    SpeedButton3: TSpeedButton;
    procedure BdnLoadClick(Sender: TObject);
    procedure BdnLoadFkClick(Sender: TObject);
    procedure CBfmNameClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBRDelimiterClick(Sender: TObject);
    procedure CBFDelimiterClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BconnectClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SD1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBarkodVeriAktar: TFrmBarkodVeriAktar;
  gpFieldDe,gpRecDe,gpHeader,Formadi,Dosya:string;
  //lpBuffer : string;
  gpPause:boolean;
  lpBuffer : array[0..130] of Char;
  gpRecords: array [0..8] of string;
  gpFields : array [0..8] of string;
  gpFormNames : array [0..8] of string;
  Kayit_Tiklandi:Boolean;
  I,Result,Formno:integer;
  vStr:string;
  Buffer:array[0..255] of char;
  strBuff,vGetData : String;
  vRecNo:integer;
  vFormIndex : array[0..32] of Char;
  vvTmp: array[0..32] of Char;

function PDX_Download_Checkdata(): Longint; stdcall;  external 'Remot.dll';  //stdcall;
//function PDX_Remot_Set_Comm(Port : PChar;Baud : Longint;DataBit,StopBit,Parity : Byte):Longint; external 'Remot.dll';  //stdcall;
function PDX_Remot_Set_Comm(Port : string;Baud : integer;DataBit,StopBit,Parity : Byte):integer; stdcall; external 'Remot.dll';  //stdcall;
function PDX_Remot_Online():Longint; stdcall; external 'Remot.dll';  //stdcall;
function PDX_Remot_Offline():Longint; stdcall; external 'Remot.dll';  //stdcall;
function PDX_Wait_Time(WaitTime : Longint):Longint; stdcall; external 'Remot.dll';  //stdcall;
function PDX_Upload(FromIndex : PChar):Longint; stdcall; external 'Remot.dll';  //stdcall;
function PDX_Get_Field(lpBuffer : PChar):Longint; stdcall; external 'Remot.dll';  //stdcall;
//function PDX_Get_Field(lpBuffer : string):Longint; stdcall; external 'Remot.dll';  //stdcall;
//Function PDX_Get_Data(lpcommand:String;lpbuffer:String):Integer; stdcall; external 'Remot.dll';  //stdcall;
Function PDX_Get_Data(lpcommand:PChar;lpbuffer:PChar):Integer; stdcall; external 'Remot.dll';  //stdcall;
Function PDX_Upload_Finish():Integer; stdcall; external 'Remot.dll';
Function PDX_Upload_Pause():Integer; stdcall; external 'Remot.dll';
Function PDX_Upload_Continue():Integer; stdcall; external 'Remot.dll';
Function PDX_Upload_Deletedata(lpFormSelect:String):Integer; stdcall; external 'Remot.dll';
Function PDX_Download_Openfile(lpFileName : String):Integer; stdcall; external 'Remot.dll';
Function PDX_Download_Barcode():Integer; stdcall; external 'Remot.dll';
Function PDX_Download_Dataform():Integer; stdcall; external 'Remot.dll';
Function PDX_Download_Variable():Integer; stdcall; external 'Remot.dll';
Function PDX_Download_Constant():Integer; stdcall; external 'Remot.dll';
Function PDX_Download_Procdure():Integer; stdcall; external 'Remot.dll';
Function PDX_Download_Table():Integer; stdcall; external 'Remot.dll';
Function PDX_Download_Deletedata():Integer; stdcall; external 'Remot.dll';
Function PDX_Download_Freetask(lpFileName:String):Integer; stdcall; external 'Remot.dll';
Function PDX_Download_Finish():Integer; stdcall; external 'Remot.dll';
Function PDX_Get_Last_Error():Integer; stdcall; external 'Remot.dll';

function DownLoadTask(pFileName:string):String;
procedure GetData();

implementation
uses Unit2;
//function PDX_Download_Checkdata; external 'Remot.dll';  //
//function PDX_Remot_Set_Comm;external 'Remot.dll';
//function PDX_Remot_Online;external 'Remot.dll';
//function PDX_Remot_Offline;external 'Remot.dll';
//function PDX_Wait_Time;external 'Remot.dll';
//function PDX_Upload;external 'Remot.dll';
//function PDX_Get_Field;external 'Remot.dll';

{$R *.dfm}

procedure TFrmBarkodVeriAktar.BdnLoadClick(Sender: TObject);
var vFileName:string;
    vStatus:String;
begin
    vFileName:='';
    with openDialog1 do
    begin
       InitialDir := ExtractFilePath(Application.ExeName );
       if Execute then
       begin
          vFileName:=FileName;
          If PDX_Remot_Online = 0 Then Showmessage('³s½u¥¢±Ñ!µLªk¤U¸ü!')
          else
          begin
            vStatus:=DownLoadTask(vFileName);
            if vStatus = 'F' then showmessage('Task¤U¸ü¥¢±Ñ!');
            if vStatus = '' then showmessage('Task¤U¸ü§¹¦¨!');
            PDX_Remot_OffLine;
          end;
       end;
    end;
end;

procedure TFrmBarkodVeriAktar.BdnLoadFkClick(Sender: TObject);
var vFileName:string;
begin
    vFileName:='';
    with openDialog1 do
    begin
       InitialDir := ExtractFilePath(Application.ExeName );
       if Execute then
       begin
          vFileName:=FileName;
          If PDX_Remot_Online = 0 Then Showmessage('³s½u¥¢±Ñ!µLªk¤U¸ü!')
          else PDX_Download_Freetask(vFileName);
          PDX_Remot_OffLine;
       end;
    end;
end;

function DownLoadTask(pFileName:string):string;
var vStatus:string;
    vFileCt:integer;
    vIsGoon:boolean;
begin
    vIsGoon:=true;
    vStatus:='';
    vFileCt:=0;
  With FrmBarkodVeriAktar do
  begin
    StsBar1.Panels[1].Text := 'Program Yükleniyor..';
    Application.ProcessMessages;
    StsBar1.Panels[1].Text := 'Form veriliyor kontrol ediliyor..';
    Application.ProcessMessages;
    if vIsGoon then
    begin
      If PDX_Download_Checkdata = 2 Then
      begin
            if MessageDlg('El Terminalinde program ve veri mevcut, silinsin mi?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
                PDX_Download_Deletedata;
            End
            Else
            begin
               StsBar1.Panels[1].Text := 'Program yüklemesi kesildi....';
               Application.ProcessMessages;
               vStatus:='Q';
               vIsGoon:=False;
            End;
      End;
    end;
    PDX_Wait_Time(10000);
    PDX_Download_Openfile(pFileName);
    if vIsGoon then
    begin
       StsBar1.Panels[1].Text := 'Barkodlar ve ayarlarý yükleniyor....';
       Application.ProcessMessages;
       If PDX_Download_Barcode = 1 Then vFileCt:=vFileCt+1 //chkDownTask(0) = 1
       Else
       begin
          StsBar1.Panels[1].Text := 'Program yükleme hatasý ...';
          Application.ProcessMessages;
          vIsGoon:=False;
          vStatus:='F';
       End;
    End;

    //Download data form
    if vIsGoon then
    begin
       StsBar1.Panels[1].Text := 'Veri Formlarý Yükleniyor ...';
       Application.ProcessMessages;
       If PDX_Download_Dataform = 1 Then vFileCt:=vFileCt+1    //chkDownTask(1).Value = 1
       Else        //Download ¿ù»~
       begin
           //Downloadfaile;
          StsBar1.Panels[1].Text := 'Program yükleme hatasý ...';
          Application.ProcessMessages;
          vIsGoon:=False;
          vStatus:='F';
       end;
    End;

    //Download variable
    if vIsGoon then
    begin
       If PDX_Download_Variable = 1 Then vFileCt:=vFileCt+1   //chkDownTask(2).Value = 1
       Else
       begin   //Download ¿ù»~
          //Downloadfaile;
          StsBar1.Panels[1].Text := 'Program yükleme hatasý ...';
          Application.ProcessMessages;
          vIsGoon:=False;
          vStatus:='F';
       End;
    End;
    //Download constant
    if vIsGoon then
    begin
       StsBar1.Panels[1].Text := 'Sabitler Yükleniyor ....';
       Application.ProcessMessages;
       If PDX_Download_Constant = 1 Then vFileCt:=vFileCt+1     //chkDownTask(3).Value = 1
       Else
       begin
          //Downloadfaile;
          StsBar1.Panels[1].Text := 'Program yükleme hatasý ...';
          Application.ProcessMessages;
          vIsGoon:=False;
          vStatus:='F';
       end;
    End;
    //Download procedure
    if vIsGoon then
    begin
       StsBar1.Panels[1].Text := 'Prosedürler Yükleniyor ....';
       Application.ProcessMessages;
       If PDX_Download_Procdure = 1 Then vFileCt:=vFileCt+1      //  chkDownTask(4).Value = 1
       Else
       begin
          //Downloadfaile;
          StsBar1.Panels[1].Text := 'Program yükleme hatasý ...';
          Application.ProcessMessages;
          vIsGoon:=False;
          vStatus:='F';
       End;
    End;
    //Download table
    if vIsGoon then
    begin
       StsBar1.Panels[1].Text := 'Tablolar Yükleniyor ....';
       Application.ProcessMessages;
       If PDX_Download_Table = 1 Then vFileCt:=vFileCt+1      //    chkDownTask(5).Value = 1
       Else
       begin
          //Downloadfaile;
          StsBar1.Panels[1].Text := 'Program yükleme hatasý ...';
          Application.ProcessMessages;
          vIsGoon:=False;
          vStatus:='F';
       end;
    End;

    PDX_Download_Finish;
    vFileCt:=vFileCt+1;
    StsBar1.Panels[1].Text := 'Program yüklemesi tamamlandý ....';
    Application.ProcessMessages;
    PDX_Remot_Offline;
    PDX_Wait_Time(1000);
    DownLoadTask:=vStatus;
  end;
end;

procedure TFrmBarkodVeriAktar.CBfmNameClick(Sender: TObject);
begin
        //CBfmName.text:= gpFormNames[CBfmName.itemindex];
        Erec1.text := gpRecords[CBfmName.itemindex];
        Efd1.text := gpFields[CBfmName.itemindex];
        SpeedButton1.Enabled:=True;
end;
procedure GetData();
var vGetData,vRecData:string;
    vTmp:array[0..126] of Char;
    iNum,vInfoIndex:integer;
begin
  with FrmBarkodVeriAktar do
  begin
    gpFieldDe:=Label13.Caption;
    vInfoIndex:=0;
    iNum:=1;
    vInfoIndex:=CBfmName.ItemIndex;
    while gpPause do
    begin
        iNum:=strToInt(Efd2.text)+1;
        If iNum=strToInt(Efd1.text)+1 Then
        begin
            inum:=1;
            Erec2.text:=intToStr(strToInt(Erec2.text)+1);
            Gauge1.Progress:=Gauge1.Progress+1;
        End;
        Efd2.text := intToStr(iNum);
        If (strToInt(Erec1.Text) = strToInt(Erec2.Text)) Then
        begin
            PDX_Upload_Finish();
            gpPause := False;
            StsBar1.Panels[1].Text := 'Veri alýmý tamamlandý ....';
            Application.ProcessMessages;
            Gauge1.Hide;
            break;
        End;
        vTmp := '';
        //PDX_Upload_Continue;
        //PDX_Upload_Pause;
        //PDX_Upload_Continue;
        StsBar1.Panels[1].Text := 'El Terminalinden Veriler Alýnýyor ....';
        Application.ProcessMessages;
        If PDX_Get_Field(vTmp) = 0 Then
        begin
            PDX_Upload_Finish();
            gpPause := False;
            StsBar1.Panels[1].Text := 'Veri alýmý tamamlandý ....';
            Application.ProcessMessages;
        End;
        vGetData := trim(vTmp);
        //strPCopy(vTmp,trim(gpRecords[CBfmName.itemindex]));
        vGetData := copy(vGetData,1, Length(vGetData));
        If iNum=1 Then vRecData:='';
        If iNum=strToInt(Efd1.text) Then
        begin
            vRecData:=vRecData+vGetData+gpRecDe;
            Memo2.Lines.add(vRecData);
        end
        Else If iNum = 1 Then vRecData := vGetData + gpFieldDe
        else vRecData := vRecData + vGetData + gpFieldDe;
    end;
    Erec2.text := '';
    Efd2.Text  := '';

  end;
End;


procedure TFrmBarkodVeriAktar.Button3Click(Sender: TObject);
var
    vvTmp: array[0..64] of Char;
begin
  PDX_Remot_OnLine();
  PDX_Wait_Time(10000);
end;

procedure TFrmBarkodVeriAktar.FormCreate(Sender: TObject);
begin
  Dosya:=ExtractFilePath(ParamStr(0))+'Ayar.set';
  If Not FileExists(dosya) Then
  Begin
    showmessage('Ayar.SET adlý dosya bulunamadý.'+#13+'Lütfen kontrol ediniz.');
    Halt;
  End
  Else
  Begin
    memo1.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'Ayar.set');
    Label6.Caption:=Trim(Copy(Memo1.Lines[0],pos('=',Memo1.Lines[0])+1,(Length(Memo1.Lines[0]))-pos('=',memo1.Lines[0])+1));
    Label7.Caption:=Trim(Copy(Memo1.Lines[1],pos('=',Memo1.Lines[1])+1,(Length(Memo1.Lines[1]))-pos('=',memo1.Lines[1])+1));
    Label8.Caption:=Trim(Copy(Memo1.Lines[2],pos('=',Memo1.Lines[2])+1,(Length(Memo1.Lines[2]))-pos('=',memo1.Lines[2])+1));
    Label9.Caption:=Trim(Copy(Memo1.Lines[3],pos('=',Memo1.Lines[3])+1,(Length(Memo1.Lines[3]))-pos('=',memo1.Lines[3])+1));
    Label10.Caption:=Trim(Copy(Memo1.Lines[5],pos('=',Memo1.Lines[5])+1,(Length(Memo1.Lines[5]))-pos('=',memo1.Lines[5])+1));
    SD1.FileName:=Trim(Copy(Memo1.Lines[9],pos('=',Memo1.Lines[9])+1,(Length(Memo1.Lines[9]))-pos('=',memo1.Lines[9])+1));
    Label11.Caption:=Sd1.FileName;
    Label12.Caption:=Trim(Copy(Memo1.Lines[6],pos('=',Memo1.Lines[6])+1,(Length(Memo1.Lines[6]))-pos('=',memo1.Lines[6])+1));
    Label13.Caption:=Trim(Copy(Memo1.Lines[7],pos('=',Memo1.Lines[7])+1,(Length(Memo1.Lines[7]))-pos('=',memo1.Lines[7])+1));
  End;
end;

procedure TFrmBarkodVeriAktar.CBRDelimiterClick(Sender: TObject);
begin
   gpRecDe:=chr(13)+chr(10);
end;

procedure TFrmBarkodVeriAktar.CBFDelimiterClick(Sender: TObject);
begin
   gpFieldDe:=Label13.Caption;
end;

procedure TFrmBarkodVeriAktar.Button1Click(Sender: TObject);
begin
  PDX_Remot_Offline();
end;

procedure TFrmBarkodVeriAktar.BconnectClick(Sender: TObject);
begin
   memo1.Lines.LoadFromFile('Comm.set');
   Form2.ComboBox1.Text:=Memo1.Lines[0];
   Form2.ComboBox2.Text:=Memo1.Lines[1];
   Form2.ComboBox3.Text:=Memo1.Lines[2];
   Form2.ComboBox4.Text:=Memo1.Lines[3];
   Form2.SpeedButton2Click(Sender);
   Erec1.text := '';
   Efd1.text := '';
   Erec2.text := '';
   Efd2.text := '';
   CBfmName.Clear;
   PDX_Remot_Online();
   result := PDX_Get_Data('RX', Buffer);
   If result = 0 Then
   begin
      BConnect.Enabled := True;
   End;
   PDX_Remot_Offline();
   For I := 0 To 8 do
    begin
        gpFormNames[I]:=trim(copy(Buffer, i * 17 + 1, 8));
        vStr:=copy(gpFormNames[I], 1, 1);
        If Ord(vStr[1]) > 128 Then
        begin
            break;
        end
        Else
        begin
            CBfmName.Items.Add(gpFormNames[I]);
        End;
        gpRecords[I]:=copy(Buffer, i * 17 + 9, 5);
        gpFields[I]:=copy(Buffer, i * 17 + 15, 2);
    end;
    if length(gpFormNames[0])> 1 then
    begin
       CBfmName.Text:=gpFormNames[0];
       Erec1.Text :=gpRecords[0];
       Efd1.Text :=gpFields[0];
       CBfmName.ItemIndex:=0;
       gpRecDe:=chr(13)+chr(10);
       SpeedButton1.Enabled:=True;
    end;
end;

procedure TFrmBarkodVeriAktar.SpeedButton1Click(Sender: TObject);
begin
  Efd2.Text :='0';
  vRecNo:= 0;
  vRecNo:=StrToInt(Erec1.text);
  //if (PDX_Download_Checkdata() = 2) then  // There are data in pdx
  if (vRecNo > 0) then
  begin
      PDX_Remot_Online();
      Memo2.Clear;
      strPcopy(vFormIndex,intToStr(CBfmName.itemindex));
      PDX_Upload(vFormIndex);
      PDX_Get_Field(vvTmp);
      vGetData := Trim(vvTmp);
      //If CkFheader.Checked Then gpHeader:= vGetData;
      Erec2.Text := '0';
      EFd2.Text := '0';
      gpPause := True;
      GetData;
//      If CBdelData.Checked Then PDX_Upload_Deletedata(vFormIndex);
      PDX_Remot_Offline();
      StsBar1.Panels[1].Text := 'Veri alýmý tamamlandý ....';
      Application.ProcessMessages;
  end;
  SpeedButton1.Enabled:=False;
end;

procedure TFrmBarkodVeriAktar.SpeedButton2Click(Sender: TObject);
Var yer:Integer;
begin
  memo1.Lines.LoadFromFile(ExtractFilePath(ParamStr(0))+'Ayar.set');
  Form2.ComboBox1.Text:=Trim(Copy(Memo1.Lines[0],pos('=',Memo1.Lines[0])+1,(Length(Memo1.Lines[0]))-pos('=',memo1.Lines[0])+1));
  Form2.ComboBox2.Text:=Trim(Copy(Memo1.Lines[1],pos('=',Memo1.Lines[1])+1,(Length(Memo1.Lines[1]))-pos('=',memo1.Lines[1])+1));
  Form2.ComboBox3.Text:=Trim(Copy(Memo1.Lines[2],pos('=',Memo1.Lines[2])+1,(Length(Memo1.Lines[2]))-pos('=',memo1.Lines[2])+1));
  Form2.ComboBox4.Text:=Trim(Copy(Memo1.Lines[3],pos('=',Memo1.Lines[3])+1,(Length(Memo1.Lines[3]))-pos('=',memo1.Lines[3])+1));
  Form2.ComboBox5.Text:=Trim(Copy(Memo1.Lines[4],pos('=',Memo1.Lines[4])+1,(Length(Memo1.Lines[4]))-pos('=',memo1.Lines[4])+1));
  Form2.ComboBox6.Text:=Trim(Copy(Memo1.Lines[6],pos('=',Memo1.Lines[6])+1,(Length(Memo1.Lines[6]))-pos('=',memo1.Lines[6])+1));
  Form2.Edit1.Text:=Trim(Copy(Memo1.Lines[9],pos('=',Memo1.Lines[9])+1,(Length(Memo1.Lines[9]))-pos('=',memo1.Lines[9])+1));
  Form2.ComboBox7.Text:=Trim(Copy(Memo1.Lines[7],pos('=',Memo1.Lines[7])+1,(Length(Memo1.Lines[7]))-pos('=',memo1.Lines[7])+1));
  Form2.ComboBox8.Text:=Trim(Copy(Memo1.Lines[8],pos('=',Memo1.Lines[8])+1,(Length(Memo1.Lines[8]))-pos('=',memo1.Lines[8])+1));
  Form2.ComboBox9.Text:=Trim(Copy(Memo1.Lines[5],pos('=',Memo1.Lines[5])+1,(Length(Memo1.Lines[5]))-pos('=',memo1.Lines[5])+1));
  Form2.Showmodal;
end;

procedure TFrmBarkodVeriAktar.SpeedButton3Click(Sender: TObject);
var vFileName,vStatus:String;
begin
    vFileName:='';
    with openDialog1 do
    begin
       InitialDir := ExtractFilePath(Application.ExeName );
       if Execute then
       begin
          vFileName:=FileName;
          ////Entry the remote mode
          If PDX_Remot_Online = 0 Then Showmessage('Baðlantý hatasý! Program yüklenemiyor..!')
          else
          begin
            vStatus:=DownLoadTask(vFileName);
            if vStatus = 'F' then showmessage('Program yükleme hatasý.!');
            if vStatus = '' then showmessage('Program yüklemesi baþarýlý.!');
            PDX_Remot_OffLine;
          end;
       end;
    end;
end;

procedure TFrmBarkodVeriAktar.SD1CanClose(Sender: TObject; var CanClose: Boolean);
begin
  Kayit_Tiklandi:=True;
end;

procedure TFrmBarkodVeriAktar.SpeedButton7Click(Sender: TObject);
Var 
 Excel, Kitap, Sayfa: Variant;
 satir,alansayisi,sutun,ayirac:Integer;
begin
   PDX_Remot_Set_Comm(Label6.Caption,StrToInt(Label7.Caption),8,0,0);
   PDX_Remot_Online();
   result := PDX_Get_Data('RX', Buffer);
   PDX_Remot_Offline();
   If result = 0 Then
   Begin
     Showmessage('Zebex PDL20-16 el terminali ile iletiþim saðlanamadý.Lütfen Zebex PDL20-16'+#13+' El Terminalinin açýk ve ana ekranda olduðunu kontrol ediniz.');
     Halt;
   End
   Else
   begin
   Formno:=StrToInt(Label10.Caption);
   Formadi:=trim(copy(Buffer, Formno * 17 + 1, 8));
   ShowMessage(Formadi+' Adlý Dosyanýn Bilgileri Alýnacak..');
   Sleep(100);
   vStr:=copy(Formadi, 1, 1);
   If Vstr='ÿ' Then
   Begin
     Showmessage('Form Numarasý yanlýþ belirlenmiþ.'+#13+'Lütfen kontrol ediniz.');
   End
   Else
   Begin
     Erec1.Text:=copy(Buffer, formno * 17 + 9, 5);
     Efd1.Text:=copy(Buffer, Formno * 17 + 15, 2);
     Efd2.Text :='0';
     vRecNo:= 0;
     vRecNo:=StrToInt(Erec1.text);
     Gauge1.Progress:=0;
    if (vRecNo > 0) then
    begin
      Gauge1.Show;
      Gauge1.MaxValue:=StrToInt(Erec1.text);
      PDX_Remot_Online();
      Memo2.Clear;
      strPcopy(vFormIndex,intToStr(Formno));
      PDX_Upload(vFormIndex);
      PDX_Get_Field(vvTmp);
      vGetData := Trim(vvTmp);
//      If CkFheader.Checked Then gpHeader:= vGetData;
      Erec2.Text := '0';
      EFd2.Text := '0';
      gpPause := True;
      GetData;
      PDX_Remot_Offline();
      StsBar1.Panels[1].Text := 'Veri alýmý tamamlandý.';
      If Label12.Caption='TXT' Then
      Begin
        memo2.Lines.SaveToFile(sd1.FileName);
      End;
      If Label12.Caption='CSV' Then
      Begin
        memo2.Lines.SaveToFile(sd1.FileName);
      End;
      If Label12.Caption='XLS' Then
      Begin
        Excel:= Createoleobject('Excel.application');
        Excel.Visible := False;
        kitap := Excel.Workbooks.Add;
        Sayfa := Kitap.Worksheets[1];
        For satir := 0 to Memo2.lines.Count-1 do
        Begin
        alansayisi:=1;
        While Pos(';',Memo2.Lines[satir])>0 Do
        Begin
           ayirac:= Pos(';',Memo2.Lines[satir]);
           sayfa.Cells[satir+1,alansayisi]:=Copy(Memo2.lines[satir],1,ayirac-1);
           Memo2.Lines[satir]:=Copy(Memo2.lines[satir],ayirac+1,Length(Memo2.Lines[satir])-ayirac);
           alansayisi:=alansayisi+1;
        End;
        sayfa.Cells[satir+1,alansayisi]:=Memo2.Lines[Satir];
        End;
        Sayfa.Columns.Autofit;
        kitap.saveas(sd1.filename);
        EXCEL.DisplayAlerts := False;
        EXCEL.Quit;
        EXCEL := Unassigned;
      End;
      Application.ProcessMessages;
  end;
  End;
End;
end;

procedure TFrmBarkodVeriAktar.SpeedButton6Click(Sender: TObject);
begin
  Halt;
end;

end.
