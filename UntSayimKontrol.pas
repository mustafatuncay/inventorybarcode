unit UntSayimKontrol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DB, ADODB,
  StdCtrls, Mask, ExtCtrls, asgprev, asgprint, DBGrids,
  Menus, QuickRpt, AdvObj,DateUtils;

type
  TFrmSayimKontrol = class(TForm)
    AdvListe: TAdvStringGrid;
    Qry1: TADOQuery;
    Panel3: TPanel;
    Label7: TLabel;
    MemAciklama: TMemo;
    AdvGridPrintSettingsDialog1: TAdvGridPrintSettingsDialog;
    AdvPreviewDialog1: TAdvPreviewDialog;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    mnSe1: TMenuItem;
    Shape6: TShape;
    Label1: TLabel;
    Label2: TLabel;
    txtyer: TEdit;
    txtizahat: TEdit;
    ChkOdalaraGore: TCheckBox;
    AdvTmp: TAdvStringGrid;
    PrintDialog1: TPrintDialog;
    QRCompositeReport1: TQRCompositeReport;
    Qry2: TADOQuery;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure AdvListeCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure mnSe1Click(Sender: TObject);
    procedure QRCompositeReport1AddReports(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
     procedure BarkodlariEslestir;
     Procedure BarkodlariEslestirOdalaraGore;
    { Public declarations }
  end;

var
  FrmSayimKontrol: TFrmSayimKontrol;

implementation

uses UntBarkodVeriAktar, StrUtils, UntRepMf7, UntRepAlk1, UntGlobal,printers,
  UntRepAlk4, UntRepAlk1Arka, UntRepBos;

{$R *.dfm}

procedure TFrmSayimKontrol.AdvListeCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
CanEdit:=False;
if acol=1 Then CanEdit := True;
end;

procedure TFrmSayimKontrol.mnSe1Click(Sender: TObject);
begin
AdvListe.CheckAll(1) ;
end;

procedure TFrmSayimKontrol.BarkodlariEslestir;
var TmpSql,y:String;
i,x,tt:integer;
begin

AdvListe.ClearRows(1,AdvListe.RowCount-1);
AdvListe.RowCount := 2;
tt:=0;

for i:=0 to AdvTmp.RowCount-1 do begin
y := '';



for x:=0 to i-1 do
if AdvTmp.Cells[1,x] = AdvTmp.Cells[1,i] Then
y:='var';

if y='var' Then continue;

if i <> AdvTmp.RowCount-1 Then
AdvListe.AddRow;

tt:=tt+1;

TmpSql:=' Select * from demirbaslar where barkod ='''+LeftStr(AdvTmp.Cells[1,i],12)+''' ' ;

qry1.Close;
Qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.Open;

if qry1.RecordCount = 0 Then begin
AdvListe.Cells[0,tt] := AdvTmp.Cells[0,i] ;
AdvListe.Cells[2,tt] := LeftStr(AdvTmp.Cells[1,i],12) ;
AdvListe.Cells[4,tt] := 'Kayýtlarda Mevcut Deðil .... !!!' ;
Continue;
end;

AdvListe.Cells[4,tt] := 'Okundu ...!!! ' ;

AdvListe.Cells[0,tt] := AdvTmp.Cells[0,i] ;
AdvListe.AddCheckBox(1,tt,False,True);
AdvListe.Cells[2,tt] := LeftStr(AdvTmp.Cells[1,i],12) ;
AdvListe.Cells[3,tt] := qry1.fieldbyname('esyacinsi').AsString;

if  qry1.fieldbyname('elverislidegil').AsString = 'Y' Then
AdvListe.Cells[4,tt] := 'Kullanýma Elveriþli Deðil Listesinde ...!!! ' ;

if  qry1.fieldbyname('aktarildi').AsString = 'Y' Then
AdvListe.Cells[4,tt] :=AdvListe.Cells[4,tt]+ 'Demirbaþ Aktarýldý : '+ qry1.fieldbyname('AktarilanYer').AsString +' ...!!! ' ;

if  qry1.fieldbyname('odano').AsString <> AdvTmp.Cells[0,i] Then
AdvListe.Cells[4,tt] := AdvListe.Cells[4,tt]+'Demirbaþ Kayýtlarda '+ qry1.fieldbyname('odano').AsString +' Nolu Odada Gözüküyor...!!! ' ;

AdvListe.Cells[5,tt]  := qry1.fieldbyname('grupkodu').AsString;
AdvListe.Cells[6,tt]  := qry1.fieldbyname('turkodu').AsString;
AdvListe.Cells[7,tt]  := qry1.fieldbyname('cesitkodu').AsString;
AdvListe.Cells[8,tt]  := qry1.fieldbyname('grupadi').AsString;
AdvListe.Cells[9,tt]  := qry1.fieldbyname('turadi').AsString;
AdvListe.Cells[10,tt] := qry1.fieldbyname('cesitadi').AsString;
AdvListe.Cells[11,tt] := qry1.fieldbyname('esyacinsi').AsString;
AdvListe.Cells[12,tt] := qry1.fieldbyname('kiymet').AsString;
AdvListe.Cells[13,tt] := qry1.fieldbyname('kurumkodu').AsString;
AdvListe.Cells[14,tt] := qry1.fieldbyname('demirbassayi').AsString;
AdvListe.Cells[15,tt] := qry1.fieldbyname('demirbasyil').AsString;
AdvListe.Cells[16,tt] := qry1.fieldbyname('odano').AsString;
AdvListe.Cells[17,tt] := qry1.fieldbyname('aciklama').AsString;
AdvListe.Cells[18,tt] := qry1.fieldbyname('id').AsString;
end;




end;


procedure TFrmSayimKontrol.BarkodlariEslestirOdalaraGore;
var TmpSql,y,TmpOda:String;
i,x,z,TmpMevcut:integer;
begin

AdvListe.ClearRows(1,AdvListe.RowCount-1);
AdvListe.RowCount := 2;

{
for i:=0 to AdvTmp.RowCount-1 do  begin
y:='';

for x:=0 to i-1 do
if AdvTmp.Cells[0,i] = AdvTmp.Cells[0,x] then y:='var';

if y='var' Then continue;

TmpOda:=TmpOda+','+AdvTmp.Cells[0,i];
end;



TmpOda:=RightStr(TmpOda,length(TmpOda)-1);
}

TmpOda := AdvTmp.Cells[0,0];

qry1.Close;
Qry1.SQL.Clear;
qry1.SQL.Add(' Select * from demirbaslar where odano in ('+TmpOda+') order by odano ');
qry1.Open;

AdvListe.RowCount := qry1.RecordCount + 1;

for i:=1 To qry1.RecordCount do begin
AdvListe.Cells[0,i]   := Qry1.fieldbyname('odano').AsString;
AdvListe.AddCheckBox(1,i,False,True);
AdvListe.Cells[2,i]   := Qry1.fieldbyname('barkod').AsString;
AdvListe.Cells[3,i]   := Qry1.fieldbyname('esyacinsi').AsString;
AdvListe.Cells[4,i]   := ' Okunmayan Demirbaþ ... ';
AdvListe.Cells[5,i]   := qry1.fieldbyname('grupkodu').AsString;
AdvListe.Cells[6,i]   := qry1.fieldbyname('turkodu').AsString;
AdvListe.Cells[7,i]   := qry1.fieldbyname('cesitkodu').AsString;
AdvListe.Cells[8,i]   := qry1.fieldbyname('grupadi').AsString;
AdvListe.Cells[9,i]   := qry1.fieldbyname('turadi').AsString;
AdvListe.Cells[10,i]  := qry1.fieldbyname('cesitadi').AsString;
AdvListe.Cells[11,i]  := qry1.fieldbyname('esyacinsi').AsString;
AdvListe.Cells[12,i]  := qry1.fieldbyname('kiymet').AsString;
AdvListe.Cells[13,i]  := qry1.fieldbyname('kurumkodu').AsString;
AdvListe.Cells[14,i]  := qry1.fieldbyname('demirbassayi').AsString;
AdvListe.Cells[15,i]  := qry1.fieldbyname('demirbasyil').AsString;
AdvListe.Cells[16,i]  := qry1.fieldbyname('odano').AsString;
AdvListe.Cells[17,i]  := qry1.fieldbyname('aciklama').AsString;
AdvListe.Cells[18,i]  := qry1.fieldbyname('id').AsString;
AdvListe.Cells[19,i]  := qry1.fieldbyname('elverislidegil').AsString;
AdvListe.Cells[20,i]  := qry1.fieldbyname('aktarildi').AsString;
AdvListe.Cells[21,i]  := qry1.fieldbyname('AktarilanYer').AsString;
qry1.Next;
end;

for i:=0 to AdvTmp.RowCount-1 do begin
  y := '';
  TmpMevcut:=0;

  for x:=0 to i-1 do
    if AdvTmp.Cells[1,x] = AdvTmp.Cells[1,i] Then
      y:='var';

  if y='var' Then continue;

  for z:=1 to AdvListe.RowCount-1 do begin

    if AdvListe.Cells[2,z] = LeftStr(AdvTmp.Cells[1,i],12) Then begin

        AdvListe.Cells[4,z] := 'Okundu ...!!! ' ;

    if AdvListe.Cells[19,z] = 'Y' Then
      AdvListe.Cells[4,z] := AdvListe.Cells[4,z] + 'Kullanýma Elveriþli Deðil Listesinde ...!!! ' ;

    if AdvListe.Cells[20,z] = 'Y' Then
      AdvListe.Cells[4,z] :=AdvListe.Cells[4,z]+ 'Demirbaþ Aktarýldý : '+ AdvListe.Cells[21,z] +' ...!!! ' ;

    if qry1.fieldbyname('odano').AsString <> AdvTmp.Cells[0,i] Then
      AdvListe.Cells[4,z] := AdvListe.Cells[4,z]+'Demirbaþ Kayýtlarda '+ AdvListe.Cells[0,z] +' Nolu Odada Gözüküyor...!!! ' ;

    TmpMevcut:=1;
    end;
  end;



if TmpMevcut <> 1 Then begin


TmpSql:=' Select * from demirbaslar where barkod ='''+LeftStr(AdvTmp.Cells[1,i],12)+''' ' ;
qry1.Close;
Qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
qry1.Open;

if qry1.RecordCount = 0 Then begin
AdvListe.AddRow;
AdvListe.Cells[0,AdvListe.RowCount-1] := AdvTmp.Cells[0,i] ;
AdvListe.Cells[2,AdvListe.RowCount-1] := LeftStr(AdvTmp.Cells[1,i],12) ;
AdvListe.Cells[4,AdvListe.RowCount-1] := 'Kayýtlarda Mevcut Deðil .... !!!' ;
Continue;
end
Else Begin
AdvListe.AddRow;
AdvListe.Cells[0,AdvListe.RowCount-1] := AdvTmp.Cells[0,i] ;
AdvListe.Cells[2,AdvListe.RowCount-1] := LeftStr(AdvTmp.Cells[1,i],12) ;
AdvListe.Cells[4,AdvListe.RowCount-1] := 'Demirbaþ Kayýtlarda '+ qry1.fieldbyname('odano').AsString +' Nolu Odada Gözüküyor...!!! ' ;
Continue;
End;


end;





end;




end;


procedure TFrmSayimKontrol.QRCompositeReport1AddReports(Sender: TObject);
begin
with QRCompositeReport1.Reports do
 begin
   Add(RepAlk1);
   Add(RepBos);
   Add(RepAlk1Arka);
end;

end;

procedure TFrmSayimKontrol.Button1Click(Sender: TObject);
begin
FrmBarkodVeriAktar:=TFrmBarkodVeriAktar.Create(self);
FrmBarkodVeriAktar.ShowModal;

{
if FileExists('C:\gg.xls') Then begin
AdvTmp.LoadFromXLS('C:\gg.xls');
DeleteFile('C:\gg.xls');
end;
}


FrmBarkodVeriAktar.Free;
end;

procedure TFrmSayimKontrol.Button2Click(Sender: TObject);
begin
if ChkOdalaraGore.Checked = True Then
BarkodlariEslestirOdalaraGore
Else
BarkodlariEslestir;
end;

procedure TFrmSayimKontrol.Button3Click(Sender: TObject);
var TmpSql:String;
 i:integer;
begin
//////////////////////////KAYIT YAPILIR////////////////////////////////////////////////////////7777777

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete From demirbaslarrapor');
qry1.ExecSQL;

for i:=1 To AdvListe.RowCount -1 Do begin

if AdvListe.Cells[2,i] = '' Then Continue;
if AdvListe.Cells[1,i] <> 'Y' Then Continue;

TmpSql:='insert into demirbaslarrapor ' +
'(grupkodu,turkodu,cesitkodu,grupadi,turadi,cesitadi,esyacinsi,kiymet,kurumkodu,demirbassayi,demirbasyil,odano,aciklama,idx) ' +
'Values ( ' +
':grupkodu,:turkodu,:cesitkodu,:grupadi,:turadi,:cesitadi,:esyacinsi,:kiymet,:kurumkodu,:demirbassayi,:demirbasyil,:odano,:aciklama,:idx'+
')';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('grupkodu').Value     := AdvListe.Cells[5,i] ;
Qry1.Parameters.ParamByName('turkodu').Value      := AdvListe.Cells[6,i] ;
Qry1.Parameters.ParamByName('cesitkodu').Value    := AdvListe.Cells[7,i] ;
Qry1.Parameters.ParamByName('grupadi').Value      := AdvListe.Cells[8,i] ;
Qry1.Parameters.ParamByName('turadi').Value       := AdvListe.Cells[9,i] ;
Qry1.Parameters.ParamByName('cesitadi').Value     := AdvListe.Cells[10,i] ;
Qry1.Parameters.ParamByName('esyacinsi').Value    := AdvListe.Cells[11,i] ;
Qry1.Parameters.ParamByName('kiymet').Value       := AdvListe.Cells[12,i] ;
Qry1.Parameters.ParamByName('kurumkodu').Value    := AdvListe.Cells[13,i] ;
Qry1.Parameters.ParamByName('demirbassayi').Value := AdvListe.Cells[14,i] ;
Qry1.Parameters.ParamByName('demirbasyil').Value  := AdvListe.Cells[15,i] ;
Qry1.Parameters.ParamByName('odano').Value        := AdvListe.Cells[16,i] ;
Qry1.Parameters.ParamByName('aciklama').Value     := AdvListe.Cells[17,i] ;
Qry1.Parameters.ParamByName('idx').Value          := AdvListe.Cells[18,i] ;
qry1.Prepared;
qry1.ExecSQL;

end;




/////////////////////////////////////////////////////////////////////////////////////////7777


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select distinct odano From demirbaslarrapor');
qry1.Open;
for i:=1 to qry1.RecordCount do begin

RepMf7:=TRepMf7.Create(self);

TmpSql := 'Select * from SabitTanimlar where kriter = ''Ýlgili Bakanlýk'' ' ;
qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);
qry2.Open;

RepMf7.QRLilgilibakanlik.Caption := qry2.FieldByName('Tanim').AsString ;


TmpSql := 'Select * from SabitTanimlar where kriter = ''Þube'' ' ;
qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);
qry2.Open;

RepMf7.QRLSube.Caption := qry2.FieldByName('Tanim').AsString ;


TmpSql := 'Select * from SabitTanimlar where kriter = ''Bakanlýk ve Daire Kodu'' ' ;
qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add(TmpSql);
qry2.Open;

RepMf7.QRLBakanlikveDaire.Caption := qry2.FieldByName('Tanim').AsString ;

qry2.Close;
qry2.SQL.Clear;
qry2.SQL.Add('Select * From demirbaslarrapor where odano = '''+qry1.fieldbyname('odano').asstring+''' ');
qry2.Open;

RepMf7.QRLOdaNo.Caption := qry1.fieldbyname('odano').asstring ;

RepMf7.DataSet := Qry2;
RepMf7.QRDBEsyaCinsi.DataSet := QRy2;
RepMf7.QRDBGrupKodu.DataSet := Qry2;
RepMf7.QRDBTurKodu.DataSet := Qry2;
RepMf7.QRDBCesitKodu.DataSet := Qry2;
RepMf7.QRDBId.DataSet:=Qry2;
RepMf7.QRDBKiymet.DataSet := Qry2;
RepMf7.QRDBKurum.DataSet := qry2;
RepMf7.QRDBDemirbasSayi.DataSet := Qry2;
RepMf7.QRDBDemirbasYil.DataSet := Qry2;
RepMf7.QRDBId.DataField := 'idx';
RepMf7.Preview;
RepMf7.Free;
end;




end;


procedure TFrmSayimKontrol.Button4Click(Sender: TObject);
var TmpT,TmpK,TmpRow,rr:integer;
TmpSql,y:String;
i,x,z:integer;
begin

{
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete From demirbaslarrapor');
qry1.ExecSQL;
}


for i:=1 to AdvListe.RowCount-1 do begin


if AdvListe.Cells[1,i] <> 'Y' Then Continue;

/////////////ELVERÝÞLÝ DEÐÝL LÝSTESÝNE KAYDET//////////////////////////////777
TmpSql:='update demirbaslar set elverislidegil = ''Y'', elverislidegilizahat =:elverislidegilizahat where barkod ='''+AdvListe.Cells[2,i]+''' ';

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('elverislidegilizahat').Value     := ' Kullaným Dýþý ';
qry1.Prepared;
qry1.ExecSQL;

AdvListe.Cells[4,i] := 'Kullanýma Elveriþli Deðil Listesine Aktarýldý ...!!! ' ;

/////////////DEMÝRBAÞ GÜNLÜÐÜNE KAYDET///////////////////////////////77
qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := AdvListe.Cells[3,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := AdvListe.Cells[2,i]  ;
Qry1.Parameters.ParamByName('tarih').Value := IntToStr(YearOf(date))+'-'+
                                              IntToStr(MonthOf(Date))+'-'+
                                              IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('yapilanis').Value     := 'Kullanýma Elveriþli Deðil Bölümüne Aktarýldý';
qry1.Prepared;
qry1.ExecSQL;

////////////////////////////////////////////77
End;




//////////////////////////KAYIT YAPILIR////////////////////////////////////////////////////////7777777



{8

for i:=1 To AdvListe.RowCount -1 Do begin

if AdvListe.Cells[2,i] = '' Then Continue;
if AdvListe.Cells[1,i] <> 'Y' Then Continue;

TmpSql:='insert into demirbaslarrapor ' +
'(grupkodu,turkodu,cesitkodu,grupadi,turadi,cesitadi,esyacinsi,kiymet,kurumkodu,demirbassayi,demirbasyil,odano,aciklama,idx) ' +
'Values ( ' +
':grupkodu,:turkodu,:cesitkodu,:grupadi,:turadi,:cesitadi,:esyacinsi,:kiymet,:kurumkodu,:demirbassayi,:demirbasyil,:odano,:aciklama,:idx'+
')';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('grupkodu').Value     := AdvListe.Cells[5,i] ;
Qry1.Parameters.ParamByName('turkodu').Value      := AdvListe.Cells[6,i] ;
Qry1.Parameters.ParamByName('cesitkodu').Value    := AdvListe.Cells[7,i] ;
Qry1.Parameters.ParamByName('grupadi').Value      := AdvListe.Cells[8,i] ;
Qry1.Parameters.ParamByName('turadi').Value       := AdvListe.Cells[9,i] ;
Qry1.Parameters.ParamByName('cesitadi').Value     := AdvListe.Cells[10,i] ;
Qry1.Parameters.ParamByName('esyacinsi').Value    := AdvListe.Cells[11,i] ;
Qry1.Parameters.ParamByName('kiymet').Value       := AdvListe.Cells[12,i] ;
Qry1.Parameters.ParamByName('kurumkodu').Value    := AdvListe.Cells[13,i] ;
Qry1.Parameters.ParamByName('demirbassayi').Value := AdvListe.Cells[14,i] ;
Qry1.Parameters.ParamByName('demirbasyil').Value  := AdvListe.Cells[15,i] ;
Qry1.Parameters.ParamByName('odano').Value        := AdvListe.Cells[16,i] ;
Qry1.Parameters.ParamByName('aciklama').Value     := AdvListe.Cells[17,i] ;
Qry1.Parameters.ParamByName('idx').Value          := AdvListe.Cells[18,i] ;
qry1.Prepared;
qry1.ExecSQL;

end;

}


/////////////////////////////////////////////////////////////////////////////////////////7777
{
qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * From demirbaslarrapor');
qry1.Open;

RepAlk1:=TRepAlk1.Create(self);
RepAlk1.Prepare;
z:=RepAlk1.QRPrinter.PageCount;
RepAlk1.Free;
}
TmpRow:=0;
for i:=1 to AdvListe.RowCount - 1 do
if AdvListe.Cells[1,i] = 'Y' Then
TmpRow:=TmpRow+1;


TmpT:=1;
TmpK:=1;
rr:=0;

if 20 >= TmpRow Then begin
TmpK := TmpRow ;
TmpT := 1 ;
end
Else Begin
TmpT := strtoint(currtostr(int(TmpRow / 20))) + 1 ;
TmpK := TmpRow mod 20 ;
end;


For i := 1 to TmpT do Begin
RepAlk1:=TRepAlk1.Create(self);
RepBos:=TRepBos.Create(self);
RepAlk1Arka:=TRepAlk1Arka.Create(self);

For z:=1 to 20 do Begin

if i=TmpT Then
if TmpK<z Then
continue;

if z=1 Then Begin
rr:=rr+1;
RepAlk1.C0R0.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R0.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R0.Caption := '1';
RepAlk1.C3R0.Caption := '';
RepAlk1.C4R0.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R0.Caption := 'Kullaným Dýþý';
end;

if z=2 Then Begin
rr:=rr+1;
RepAlk1.C0R1.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R1.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R1.Caption := '1';
RepAlk1.C3R1.Caption := '';
RepAlk1.C4R1.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R1.Caption := 'Kullaným Dýþý';
end;

if z=3 Then Begin
rr:=rr+1;
RepAlk1.C0R2.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R2.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R2.Caption := '1';
RepAlk1.C3R2.Caption := '';
RepAlk1.C4R2.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R2.Caption := 'Kullaným Dýþý';
end;

if z=4 Then Begin
rr:=rr+1;
RepAlk1.C0R3.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R3.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R3.Caption := '1';
RepAlk1.C3R3.Caption := '';
RepAlk1.C4R3.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R3.Caption := 'Kullaným Dýþý';
end;

if z=5 Then Begin
rr:=rr+1;
RepAlk1.C0R4.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R4.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R4.Caption := '1';
RepAlk1.C3R4.Caption := '';
RepAlk1.C4R4.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R4.Caption := 'Kullaným Dýþý';
end;

if z=6 Then Begin
rr:=rr+1;
RepAlk1.C0R5.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R5.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R5.Caption := '1';
RepAlk1.C3R5.Caption := '';
RepAlk1.C4R5.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R5.Caption := 'Kullaným Dýþý';
end;

if z=7 Then Begin
rr:=rr+1;
RepAlk1.C0R6.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R6.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R6.Caption := '1';
RepAlk1.C3R6.Caption := '';
RepAlk1.C4R6.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R6.Caption := 'Kullaným Dýþý';
end;


if z=8 Then Begin
rr:=rr+1;
RepAlk1.C0R7.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R7.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R7.Caption := '1';
RepAlk1.C3R7.Caption := '';
RepAlk1.C4R7.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R7.Caption := 'Kullaným Dýþý';
end;


if z=9 Then Begin
rr:=rr+1;
RepAlk1.C0R8.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R8.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R8.Caption := '1';
RepAlk1.C3R8.Caption := '';
RepAlk1.C4R8.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R8.Caption := 'Kullaným Dýþý';
end;

if z=10 Then Begin
rr:=rr+1;
RepAlk1.C0R9.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R9.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R9.Caption := '1';
RepAlk1.C3R9.Caption := '';
RepAlk1.C4R9.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R9.Caption := 'Kullaným Dýþý';
end;

if z=11 Then Begin
rr:=rr+1;
RepAlk1.C0R10.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R10.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R10.Caption := '1';
RepAlk1.C3R10.Caption := '';
RepAlk1.C4R10.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R10.Caption := 'Kullaným Dýþý';
end;

if z=12 Then Begin
rr:=rr+1;
RepAlk1.C0R11.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R11.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R11.Caption := '1';
RepAlk1.C3R11.Caption := '';
RepAlk1.C4R11.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R11.Caption := 'Kullaným Dýþý';
end;

if z=13 Then Begin
rr:=rr+1;
RepAlk1.C0R12.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R12.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R12.Caption := '1';
RepAlk1.C3R12.Caption := '';
RepAlk1.C4R12.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R12.Caption := 'Kullaným Dýþý';
end;

if z=14 Then Begin
rr:=rr+1;
RepAlk1.C0R13.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R13.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R13.Caption := '1';
RepAlk1.C3R13.Caption := '';
RepAlk1.C4R13.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R13.Caption := 'Kullaným Dýþý';
end;

if z=15 Then Begin
rr:=rr+1;
RepAlk1.C0R14.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R14.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R14.Caption := '1';
RepAlk1.C3R14.Caption := '';
RepAlk1.C4R14.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R14.Caption := 'Kullaným Dýþý';
end;

if z=16 Then Begin
rr:=rr+1;
RepAlk1.C0R15.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R15.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R15.Caption := '1';
RepAlk1.C3R15.Caption := '';
RepAlk1.C4R15.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R15.Caption := 'Kullaným Dýþý';
end;

if z=17 Then Begin
rr:=rr+1;
RepAlk1.C0R16.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R16.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R16.Caption := '1';
RepAlk1.C3R16.Caption := '';
RepAlk1.C4R16.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R16.Caption := 'Kullaným Dýþý';
end;

if z=18 Then Begin
rr:=rr+1;
RepAlk1.C0R17.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R17.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R17.Caption := '1';
RepAlk1.C3R17.Caption := '';
RepAlk1.C4R17.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R17.Caption := 'Kullaným Dýþý';
end;

if z=19 Then Begin
rr:=rr+1;
RepAlk1.C0R18.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R18.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R18.Caption := '1';
RepAlk1.C3R18.Caption := '';
RepAlk1.C4R18.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R18.Caption := 'Kullaným Dýþý';
end;

if z=20 Then Begin
rr:=rr+1;
RepAlk1.C0R19.Caption := AdvListe.Cells[18,rr];
RepAlk1.C1R19.Caption := AdvListe.Cells[11,rr];
RepAlk1.C2R19.Caption := '1';
RepAlk1.C3R19.Caption := '';
RepAlk1.C4R19.Caption := AdvListe.Cells[12,rr];
RepAlk1.C5R19.Caption := 'Kullaným Dýþý';
end;

End;

QRCompositeReport1.Preview;

RepAlk1.Free;
RepBos.Free;
RepAlk1Arka.Free;

End;














end;


procedure TFrmSayimKontrol.Button5Click(Sender: TObject);
var TmpSql,y:String;
i,x:integer;
begin

if txtyer.text='' Then begin
showmessage('Lütfen Aktarýlacaðý Yeri Giriniz ....');
Exit;
end;

if txtizahat.text='' Then begin
showmessage('Lütfen Ýzahatý Giriniz ....');
Exit;
end;

if MessageDlg('Seçili Demirbaþlar Baþka Daireye Aktarýlacak , Devam etmek istiyormusunuz ?',mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;


qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Delete From demirbaslarrapor');
qry1.ExecSQL;

for i:=1 to AdvListe.RowCount-1 do begin


if AdvListe.Cells[1,i] <> 'Y' Then Continue;

/////////////DEMÝRBASÝ AKTAR//////////////////////////////777
TmpSql:='update demirbaslar set aktarildi = ''Y'', AktarilanYer =:AktarilanYer, Aktarilanizahat=:Aktarilanizahat  where id ='''+AdvListe.Cells[18,i]+''' ';

qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('AktarilanYer').Value     := txtyer.text ;
Qry1.Parameters.ParamByName('Aktarilanizahat').Value  := txtizahat.text ;
qry1.Prepared;
qry1.ExecSQL;


qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  :=  AdvListe.Cells[3,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      :=  AdvListe.Cells[2,i]  ;
Qry1.Parameters.ParamByName('tarih').Value         :=  Now ;
Qry1.Parameters.ParamByName('yapilanis').Value     :=  ' Aktarma : ' +txtyer.Text;
qry1.Prepared;
qry1.ExecSQL;


AdvListe.Cells[4,i] := txtyer.text+'  Daireye Aktarýldý ...!!! ' ;

/////////////DEMÝRBAÞ GÜNLÜÐÜNE KAYDET///////////////////////////////77
qry1.Close;
qry1.SQL.clear;
qry1.SQL.Add('insert into demirbasgunlugu (esyanincinsi,barkodno,tarih,yapilanis) values(:esyanincinsi,:barkodno,:tarih,:yapilanis) ');
Qry1.Parameters.ParamByName('esyanincinsi').Value  := AdvListe.Cells[3,i] ;
Qry1.Parameters.ParamByName('barkodno').Value      := AdvListe.Cells[2,i]  ;
Qry1.Parameters.ParamByName('tarih').Value := IntToStr(YearOf(date))+'-'+
                                              IntToStr(MonthOf(Date))+'-'+
                                              IntToStr(DayOf(Date));
Qry1.Parameters.ParamByName('yapilanis').Value     := 'Kullanýma Elveriþli Deðil Bölümüne Aktarýldý';
qry1.Prepared;
qry1.ExecSQL;

////////////////////////////////////////////77
End;




//////////////////////////KAYIT YAPILIR////////////////////////////////////////////////////////7777777





for i:=1 To AdvListe.RowCount -1 Do begin

if AdvListe.Cells[2,i] = '' Then Continue;
if AdvListe.Cells[1,i] <> 'Y' Then Continue;

TmpSql:='insert into demirbaslarrapor ' +
'(grupkodu,turkodu,cesitkodu,grupadi,turadi,cesitadi,esyacinsi,kiymet,kurumkodu,demirbassayi,demirbasyil,odano,aciklama,aktarilanyer,aktarilanizahat,idx) ' +
'Values ( ' +
':grupkodu,:turkodu,:cesitkodu,:grupadi,:turadi,:cesitadi,:esyacinsi,:kiymet,:kurumkodu,:demirbassayi,:demirbasyil,:odano,:aciklama,:aktarilanyer,:aktarilanizahat,:idx'+
')';

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add(TmpSql);
Qry1.Parameters.ParamByName('grupkodu').Value     := AdvListe.Cells[5,i] ;
Qry1.Parameters.ParamByName('turkodu').Value      := AdvListe.Cells[6,i] ;
Qry1.Parameters.ParamByName('cesitkodu').Value    := AdvListe.Cells[7,i] ;
Qry1.Parameters.ParamByName('grupadi').Value      := AdvListe.Cells[8,i] ;
Qry1.Parameters.ParamByName('turadi').Value       := AdvListe.Cells[9,i] ;
Qry1.Parameters.ParamByName('cesitadi').Value     := AdvListe.Cells[10,i] ;
Qry1.Parameters.ParamByName('esyacinsi').Value    := AdvListe.Cells[11,i] ;
Qry1.Parameters.ParamByName('kiymet').Value       := AdvListe.Cells[12,i] ;
Qry1.Parameters.ParamByName('kurumkodu').Value    := AdvListe.Cells[13,i] ;
Qry1.Parameters.ParamByName('demirbassayi').Value := AdvListe.Cells[14,i] ;
Qry1.Parameters.ParamByName('demirbasyil').Value  := AdvListe.Cells[15,i] ;
Qry1.Parameters.ParamByName('odano').Value        := AdvListe.Cells[16,i] ;
Qry1.Parameters.ParamByName('aciklama').Value     := AdvListe.Cells[17,i] ;

Qry1.Parameters.ParamByName('aktarilanyer').Value        := txtyer.text ;
Qry1.Parameters.ParamByName('aktarilanizahat').Value     := txtizahat.text ;

Qry1.Parameters.ParamByName('idx').Value          := AdvListe.Cells[18,i] ;
qry1.Prepared;
qry1.ExecSQL;

end;




/////////////////////////////////////////////////////////////////////////////////////////7777

qry1.Close;
qry1.SQL.Clear;
qry1.SQL.Add('Select * From demirbaslarrapor');
qry1.Open;


RepAlk4:=TRepAlk4.Create(self);
RepAlk4.DataSet := qRY1;
RepAlk4.QRDBEsyaCinsi.DataSet := Qry1;
RepAlk4.QRDBKiymet.DataSet := Qry1;
RepAlk4.QRDBizahat.DataSet := Qry1;
RepAlk4.QRDBSiraNo.DataSet := Qry1;
RepAlk4.QRDBSiraNo.DataField := 'idx' ;

RepAlk4.Preview;
RepAlk4.Free;



end;

procedure TFrmSayimKontrol.Button6Click(Sender: TObject);
begin
AdvListe.PrintSettings.TitleLines.Clear;
AdvListe.PrintSettings.TitleLines.Add('Burhan Nalbantoðlu Devlet Hastanesi');


//AdvListe.PrintSettings.TitleLines.Add('');



AdvPreviewDialog1.Execute;
end;

procedure TFrmSayimKontrol.Edit1Change(Sender: TObject);
begin
showmessage('');
end;

end.
