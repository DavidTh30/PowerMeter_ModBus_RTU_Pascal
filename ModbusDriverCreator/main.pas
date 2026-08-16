unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, FileUtil, SpinEx, Forms, Controls,
  Graphics, Dialogs, DbCtrls, DBGrids, StdCtrls, Menus, Spin, ExtCtrls,
  ComCtrls, SerialPort, ModBusSerial, csvdocument, dbugintf, Tag, PLCTagNumber,
  TypInfo, registry, Math, IniFiles, strutils;

type

  { TForm1 }

  TForm1 = class(TForm)
    B0: TShape;
    B1: TShape;
    B10: TShape;
    B11: TShape;
    B12: TShape;
    B13: TShape;
    B14: TShape;
    B15: TShape;
    B16: TShape;
    B17: TShape;
    B18: TShape;
    B19: TShape;
    B2: TShape;
    B20: TShape;
    B21: TShape;
    B22: TShape;
    B23: TShape;
    B24: TShape;
    B25: TShape;
    B26: TShape;
    B27: TShape;
    B28: TShape;
    B29: TShape;
    B3: TShape;
    B30: TShape;
    B31: TShape;
    B4: TShape;
    B5: TShape;
    B6: TShape;
    B7: TShape;
    B8: TShape;
    B9: TShape;
    BufDataset1: TBufDataset;
    BufDataset2: TBufDataset;
    CmdClearList: TButton;
    CmdRandomSerial: TButton;
    Button2: TButton;
    CmdInitDriver: TButton;
    CheckBoxSwapBytes: TCheckBox;
    CheckBoxSwapDwords: TCheckBox;
    CheckBoxSwapWords: TCheckBox;
    CheckBoxUseBit: TCheckBox;
    CmdConnect: TButton;
    Datasource2: TDataSource;
    DBGrid2: TDBGrid;
    EditCom: TComboBox;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Device_MFG: TEdit;
    Device_Model: TEdit;
    Device_Name: TEdit;
    Device_SN: TEdit;
    Device_Ver: TEdit;
    Drv_CreatDate: TEdit;
    Drv_Name: TEdit;
    Drv_Other_Information: TEdit;
    Drv_SN: TEdit;
    Drv_Ver: TEdit;
    Datasource1: TDatasource;
    EditSymbol: TEdit;
    EditType: TComboBox;
    EditRegisterType: TComboBox;
    EditUnit: TEdit;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuNew: TMenuItem;
    MenuSaveAs: TMenuItem;
    MenuOpen: TMenuItem;
    MenuExit: TMenuItem;
    ModBusRTUDriver1: TModBusRTUDriver;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    SaveDialog1: TSaveDialog;
    SerialPortDriver1: TSerialPortDriver;
    SpinEditNode: TSpinEditEx;
    EditAddress: TSpinEditEx;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Tag1: TPLCTagNumber;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    CmdMoveFirst: TToolButton;
    ToolButton10: TToolButton;
    CmdDelete: TToolButton;
    ToolButton12: TToolButton;
    CmdEdit: TToolButton;
    ToolButton14: TToolButton;
    CmdPost: TToolButton;
    ToolButton16: TToolButton;
    CmdCancel: TToolButton;
    ToolButton2: TToolButton;
    CmdPrior: TToolButton;
    ToolButton4: TToolButton;
    CmdMoveNext: TToolButton;
    ToolButton6: TToolButton;
    CmdMoveLast: TToolButton;
    ToolButton8: TToolButton;
    CmdInsert: TToolButton;
    procedure B0MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BufDataset1AfterCancel(DataSet: TDataSet);
    procedure BufDataset1AfterDelete(DataSet: TDataSet);
    procedure BufDataset1AfterEdit(DataSet: TDataSet);
    procedure BufDataset1AfterInsert(DataSet: TDataSet);
    procedure BufDataset1AfterPost(DataSet: TDataSet);
    procedure BufDataset1AfterScroll(DataSet: TDataSet);
    procedure BufDataset1BeforeEdit(DataSet: TDataSet);
    procedure BufDataset1BeforeInsert(DataSet: TDataSet);
    procedure BufDataset1BeforePost(DataSet: TDataSet);
    procedure BufDataset1BeforeScroll(DataSet: TDataSet);
    procedure BufDataset1CalcFields(DataSet: TDataSet);
    procedure BufDataset1NewRecord(DataSet: TDataSet);
    procedure CmdCancelClick(Sender: TObject);
    procedure CmdClearListClick(Sender: TObject);
    procedure CmdMoveNextClick(Sender: TObject);
    procedure CmdPostClick(Sender: TObject);
    procedure CmdRandomSerialClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CmdInitDriverClick(Sender: TObject);
    procedure CheckBoxSwapBytesEditingDone(Sender: TObject);
    procedure CheckBoxSwapDwordsEditingDone(Sender: TObject);
    procedure CheckBoxSwapWordsEditingDone(Sender: TObject);
    procedure CheckBoxUseBitEditingDone(Sender: TObject);
    procedure CmdConnectClick(Sender: TObject);
    procedure Datasource1StateChange(Sender: TObject);
    procedure Datasource1UpdateData(Sender: TObject);
    procedure EditAddressEditingDone(Sender: TObject);
    procedure EditComEditingDone(Sender: TObject);
    procedure EditRegisterTypeEditingDone(Sender: TObject);
    procedure EditSymbolEditingDone(Sender: TObject);
    procedure EditTypeEditingDone(Sender: TObject);
    procedure EditUnitEditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuNewClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuSaveAsClick(Sender: TObject);
    procedure SpinEditNodeEditingDone(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CmdInsertClick(Sender: TObject);
    procedure CmdDeleteClick(Sender: TObject);
    procedure CmdEditClick(Sender: TObject);
    procedure CmdMoveFirstClick(Sender: TObject);
    procedure CmdMoveLastClick(Sender: TObject);
    procedure CmdPriorClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    procedure GetSerialPortExt();
  end; 

var
  Form1: TForm1;
  OnBootFinish:boolean;
  BitNumber:int64;
  Version_:string;

implementation

{$R *.lfm}

{ TForm1 }

Function StrToBoolV2(BoolS_:string):boolean;
begin
  if((LowerCase(BoolS_)='true')or(LowerCase(BoolS_)='1')or
     (LowerCase(BoolS_)='one')or(LowerCase(BoolS_)='t')or
     (LowerCase(BoolS_)='a')or(LowerCase(BoolS_)='on')or
     (LowerCase(BoolS_)='ok')or(LowerCase(BoolS_)='out')) then
  result:= true
  else
  result:= false;
end;

procedure TForm1.GetSerialPortExt();
var
  reg  : TRegistry;
  l,v  : TStringList;
  n    : integer;
  pn: string;
  //fn: string;
  //Result_:string;

  function findFriendlyName(key: string; port: string): string;
  var
    r : TRegistry;
    k : TStringList;
    i : Integer;
    ck: string;
    rs: string;
  begin
    r := TRegistry.Create;
    k := TStringList.Create;

    r.RootKey := HKEY_LOCAL_MACHINE;
    r.OpenKeyReadOnly(key);
    r.GetKeyNames(k);
    r.CloseKey;

    try
      for i := 0 to k.Count - 1 do
      begin
        ck := key + k[i] + '\'; // current key
        // looking for "PortName" stringvalue in "Device Parameters" subkey
        if r.OpenKeyReadOnly(ck + 'Device Parameters') then
        begin
          if r.ReadString('PortName') = port then
          begin
            //Memo1.Lines.Add('--> ' + ck);
            r.CloseKey;
            r.OpenKeyReadOnly(ck);
            rs := r.ReadString('FriendlyName');
            Break;
          end // if r.ReadString('PortName') = port ...
        end  // if r.OpenKeyReadOnly(ck + 'Device Parameters') ...
        // keep looking on subkeys for "PortName"
        else // if not r.OpenKeyReadOnly(ck + 'Device Parameters') ...
        begin
          if r.OpenKeyReadOnly(ck) and r.HasSubKeys then
          begin
            rs := findFriendlyName(ck, port);
            if rs <> '' then Break;
          end; // if not (r.OpenKeyReadOnly(ck) and r.HasSubKeys) ...
        end; // if not r.OpenKeyReadOnly(ck + 'Device Parameters') ...
      end; // for i := 0 to k.Count - 1 ...
      result := rs;
    finally
      r.Free;
      k.Free;
    end; // try ...
  end; // function findFriendlyName ...

begin
  v      := TStringList.Create;
  l      := TStringList.Create;
  reg    := TRegistry.Create;
  //Result_ := '';
  EditCom.Clear;

  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKeyReadOnly('HARDWARE\DEVICEMAP\SERIALCOMM') then
    begin
      reg.GetValueNames(l);

      for n := 0 to l.Count - 1 do
      begin
        pn := reg.ReadString(l[n]);
        //fn := findFriendlyName('\System\CurrentControlSet\Enum\', pn);
        EditCom.Items.Append(pn);
      end; // for n := 0 to l.Count - 1 ...

      //Result_ := v.CommaText;
    end; // if reg.OpenKeyReadOnly('HARDWARE\DEVICEMAP\SERIALCOMM') ...
  finally
    reg.Free;
    v.Free;
    l.Free;
  end; // try ...
end;

function RandomSerial(): string;
var
  serial: string;
  i: integer;
  chars: string;
begin
  application.ProcessMessages;
  Randomize; // Initialize random number generator
  application.ProcessMessages;
  chars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  serial := '';

  for i := 1 to 10 do // Generates a 10-character serial number
    serial := serial + chars[Random(Length(chars)) + 1];

  Result :=serial;
end;

function StringToHex(const InputStr: string): string;
begin
  if InputStr = '' then Exit('');

  // Each character requires 2 hex digits
  SetLength(Result, Length(InputStr) * 2);

  // Pass the raw memory buffers to BinToHex
  BinToHex(PChar(InputStr), PChar(Result), Length(InputStr));
end;

procedure PopulateEnumList(out AList: TStringList);
var
  T_TagType: TTagType;
begin
  AList := TStringList.Create;

  for T_TagType := Low(TTagType) to High(TTagType) do
  begin
    AList.Add(GetEnumName(TypeInfo(TTagType), Ord(T_TagType)));
  end;

end;

procedure log(message_: string);
begin
  SendDebug(message_);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  s:TStringList;
begin
  Version_:=Form1.Caption;
  OnBootFinish:=false;

  GetSerialPortExt();

  BufDataset1.Clear;
  BufDataset1.Fields.Clear;
  BufDataset1.FieldDefs.Clear;
  BufDataset2.Clear;
  BufDataset2.Fields.Clear;
  BufDataset2.FieldDefs.Clear;
  for i:=0 to DBGrid1.Columns.Count-1  do
  DBGrid1.Columns.Delete(0);

  PopulateEnumList(s);
  EditType.Items := s;
  s.Free;
  EditType.ItemIndex:=0;

  //showmessage(BufDataset1.FieldDefs.Count.ToString);

  with BufDataset1.FieldDefs do
  begin
    Add('Address', ftInteger, 0,false);
    Add('Symbol', ftString, 255);
    Add('Type', ftString, 255);
    Add('RegisterType', ftString, 255);
    Add('SwapBytes', ftBoolean, 0,false);
    Add('SwapDwords', ftBoolean, 0,false);
    Add('SwapWords', ftBoolean, 0,false);
    Add('UseBit', ftBoolean, 0,false);
    Add('BitNumber', ftLargeint, 0,false);
    Add('Unit', ftString, 20);
  end;
  BufDataset1.CreateDataset;

  with BufDataset2.FieldDefs do
  begin
    Add('Symbol', ftString, 255);
    Add('Result', ftString, 255);
    Add('Unit', ftString, 20);
    Add('Obj', ftString, 600);
    Add('UseBit', ftLargeint, 0, false);
  end;
  BufDataset2.CreateDataset;

    //BufDataset1.Append;
    //BufDataset1.FieldByName('Address').AsInteger := 2999;
    //BufDataset1.FieldByName('Symbol').AsString := 'CurrentA';
    //BufDataset1.FieldByName('Type').AsString := 'pttFloat';
    //BufDataset1.FieldByName('RegisterType').AsString := 'Holding Registers';
    //BufDataset1.FieldByName('SwapBytes').AsBoolean := false;
    //BufDataset1.FieldByName('SwapDwords').AsBoolean := false;
    //BufDataset1.FieldByName('SwapWords').AsBoolean := false;
    //BufDataset1.FieldByName('UseBit').AsBoolean := false;
    //BufDataset1.FieldByName('BitNumber').AsLargeInt := 0;
    //BufDataset1.FieldByName('Unit').AsString := 'A';
    //BufDataset1.Post;
    //
    //BufDataset1.Append;
    //BufDataset1.FieldByName('Address').AsInteger := 3201;
    //BufDataset1.FieldByName('Symbol').AsString := 'Watt-Hours';
    //BufDataset1.FieldByName('Type').AsString := 'pttInt64';
    //BufDataset1.FieldByName('RegisterType').AsString := 'Holding Registers';
    //BufDataset1.FieldByName('SwapBytes').AsBoolean := false;
    //BufDataset1.FieldByName('SwapDwords').AsBoolean := true;
    //BufDataset1.FieldByName('SwapWords').AsBoolean := true;
    //BufDataset1.FieldByName('UseBit').AsBoolean := false;
    //BufDataset1.FieldByName('BitNumber').AsLargeInt := 0;
    //BufDataset1.FieldByName('Unit').AsString := 'Wh';
    //BufDataset1.Post;


  BufDataset1.First;

  CmdPost.Enabled:=false;
  CmdCancel.Enabled:=false;
  if BufDataset1.RecordCount = 0 then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
    CmdDelete.Enabled:=false;
  end
  else
  begin
    CmdMoveFirst.Enabled:=true;
    CmdPrior.Enabled:=true;
    CmdMoveNext.Enabled:=true;
    CmdMoveLast.Enabled:=true;
    CmdDelete.Enabled:=true;
  end;

  if BufDataset1.BOF then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
  end;
  if BufDataset1.EOF then
  begin
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
  end;

  if BufDataset1.State in [dsEdit, dsInsert] then
  begin
    CmdPost.Enabled:=true;
    CmdCancel.Enabled:=true;
  end
  else
  begin
    CmdPost.Enabled:=false;
    CmdCancel.Enabled:=false;
  end;

  OnBootFinish:=true;
end;

procedure TForm1.EditSymbolEditingDone(Sender: TObject);
begin
  EditSymbol.Caption:=DelChars(EditSymbol.Caption, ',');
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('Symbol').AsString := EditSymbol.Caption;
end;

procedure TForm1.EditTypeEditingDone(Sender: TObject);
begin
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('Type').AsString := EditType.Items[EditType.ItemIndex];
end;

procedure TForm1.EditUnitEditingDone(Sender: TObject);
begin
  EditUnit.Caption:=DelChars(EditUnit.Caption, ',');
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('Unit').AsString := EditUnit.Caption;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  i,i2:integer;
  CurrentObj: TComponent;
begin
  timer1.Enabled:=false;

  OnBootFinish:=false;
  BufDataset1.Clear;
  BufDataset1.Fields.Clear;
  BufDataset1.FieldDefs.Clear;
  BufDataset2.Clear;
  BufDataset2.Fields.Clear;
  BufDataset2.FieldDefs.Clear;
  for i:=0 to DBGrid1.Columns.Count-1  do
  DBGrid1.Columns.Delete(0);

  for i := 0 to ComponentCount - 1 do
  begin
    if i>(ComponentCount - 1) then i2:= (ComponentCount - 1);
    if i<=(ComponentCount - 1) then i2:=i;
    CurrentObj := Components[i2];
    if (CurrentObj is TPLCTagNumber)then
    begin
      log({$I %LINE%}+' Found TPLCTagNumber: '+TPLCTagNumber(CurrentObj).Name);
      TPLCTagNumber(CurrentObj).AutoRead:=false;
      TPLCTagNumber(CurrentObj).DestroyComponents;
      TPLCTagNumber(CurrentObj).Free;
    end;
  end;
  SerialPortDriver1.Active:= false;
  SerialPortDriver1.AcceptAnyPortName:=false;
end;

procedure TForm1.EditAddressEditingDone(Sender: TObject);
begin
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('Address').AsInteger := EditAddress.Value;
end;

procedure TForm1.EditComEditingDone(Sender: TObject);
begin
  SerialPortDriver1.COMPort:=EditCom.Text;
end;

procedure TForm1.EditRegisterTypeEditingDone(Sender: TObject);
begin
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('RegisterType').AsString := EditRegisterType.Items[EditRegisterType.ItemIndex];
end;

procedure TForm1.BufDataset1AfterCancel(DataSet: TDataSet);
begin
  log({$I %LINE%}+' AfterCancel');
  BufDataset1AfterScroll(DataSet);

  CmdPost.Enabled:=false;
  CmdCancel.Enabled:=false;
  CmdEdit.Enabled:=true;

  if BufDataset1.RecordCount = 0 then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
    CmdDelete.Enabled:=false;
  end
  else
  begin
    CmdMoveFirst.Enabled:=true;
    CmdPrior.Enabled:=true;
    CmdMoveNext.Enabled:=true;
    CmdMoveLast.Enabled:=true;
    CmdDelete.Enabled:=true;
  end;
  if BufDataset1.BOF then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
  end;
  if BufDataset1.EOF then
  begin
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
  end;
end;

procedure TForm1.B0MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
  CurrentObj: TComponent;
begin
  log({$I %LINE%}+' MouseUp');
  if BufDataset1.State in [dsEdit, dsInsert] then
  begin
    if (sender is TShape) and (TShape(sender).Brush.Color = clGreen) and (LeftStr(TShape(sender).Name,1)='B') then
    begin
      TShape(sender).Brush.Color := clWhite;
      BufDataset1.FieldByName('BitNumber').AsLargeInt := 0;
      exit;
    end;
    if sender is TShape then TShape(sender).Brush.Color := clGreen;

    for i := 0 to ComponentCount - 1 do
    begin
      CurrentObj := Components[i];
      if (CurrentObj is TShape) and (CurrentObj.Name <> TShape(sender).Name) and
      (LeftStr(CurrentObj.Name,1)='B') then TShape(CurrentObj).Brush.Color := clWhite;
    end;

    i:=StrToInt(RightStr(TShape(sender).Name,Length(TShape(sender).Name)-1));
    BitNumber:= round(Power(2,i));
    BufDataset1.FieldByName('BitNumber').AsLargeInt := BitNumber;
    //showmessage(BitNumber.ToString);
  end;
end;

procedure TForm1.BufDataset1AfterDelete(DataSet: TDataSet);
begin
  log({$I %LINE%}+' AfterDelete');
  BufDataset1AfterScroll(DataSet);

  CmdPost.Enabled:=false;
  CmdCancel.Enabled:=false;
  CmdEdit.Enabled:=true;

  if BufDataset1.RecordCount = 0 then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
    CmdDelete.Enabled:=false;
  end
  else
  begin
    CmdMoveFirst.Enabled:=true;
    CmdPrior.Enabled:=true;
    CmdMoveNext.Enabled:=true;
    CmdMoveLast.Enabled:=true;
    CmdDelete.Enabled:=true;
  end;
  if BufDataset1.BOF then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
  end;
  if BufDataset1.EOF then
  begin
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
  end;
end;

procedure TForm1.BufDataset1AfterEdit(DataSet: TDataSet);
begin
  log({$I %LINE%}+' AfterEdit');
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
end;

procedure TForm1.BufDataset1AfterInsert(DataSet: TDataSet);
begin
  log({$I %LINE%}+' AfterInsert');

    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;

    CmdEdit.Enabled:=false;
end;

procedure TForm1.BufDataset1AfterPost(DataSet: TDataSet);
begin
  log({$I %LINE%}+' AfterPost');

  CmdPost.Enabled:=false;
  CmdCancel.Enabled:=false;
  CmdEdit.Enabled:=true;

  if BufDataset1.RecordCount = 0 then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
    CmdDelete.Enabled:=false;
  end
  else
  begin
    CmdMoveFirst.Enabled:=true;
    CmdPrior.Enabled:=true;
    CmdMoveNext.Enabled:=true;
    CmdMoveLast.Enabled:=true;
    CmdDelete.Enabled:=true;
  end;
  if BufDataset1.BOF then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
  end;
  if BufDataset1.EOF then
  begin
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
  end;
end;

procedure TForm1.BufDataset1AfterScroll(DataSet: TDataSet);
var
  i:integer;
  CurrentObj: TComponent;
begin
  log({$I %LINE%}+' AfterScroll');
  if not OnBootFinish then exit;
  if BufDataset1.State in [dsEdit, dsInsert] then exit;

  log({$I %LINE%}+' Update');
  EditAddress.Value:= BufDataset1.FieldByName('Address').AsInteger;
  EditSymbol.Caption:= BufDataset1.FieldByName('Symbol').AsString;
  EditUnit.Caption:= BufDataset1.FieldByName('Unit').AsString;
  CheckBoxSwapBytes.Checked:=BufDataset1.FieldByName('SwapBytes').AsBoolean;
  CheckBoxSwapDwords.Checked:=BufDataset1.FieldByName('SwapDwords').AsBoolean;
  CheckBoxSwapWords.Checked:=BufDataset1.FieldByName('SwapWords').AsBoolean;
  CheckBoxUseBit.Checked:=BufDataset1.FieldByName('UseBit').AsBoolean;

  if EditType.Items.Count > 0 then
  for i := 0 to EditType.Items.Count-1 do
  begin
    if BufDataset1.FieldByName('Type').AsString = EditType.Items[i] then
    begin
      EditType.ItemIndex:=i;
      break;
    end;
  end;

  if EditRegisterType.Items.Count > 0 then
  for i := 0 to EditRegisterType.Items.Count-1 do
  begin
    if BufDataset1.FieldByName('RegisterType').AsString = EditRegisterType.Items[i] then
    begin
      EditRegisterType.ItemIndex:=i;
      break;
    end;
  end;

  for i := 0 to ComponentCount - 1 do
  begin
    CurrentObj := Components[i];
    if (CurrentObj is TShape) and (LeftStr(CurrentObj.Name,1)='B') then TShape(CurrentObj).Brush.Color := clWhite;
  end;

  if (BufDataset1.FieldByName('BitNumber').AsLargeInt = 1) then B0.Brush.Color := clgreen;

  if (BufDataset1.FieldByName('BitNumber').AsLargeInt>0) then
  if (BufDataset1.FieldByName('BitNumber').AsLargeInt<=2147483648) then
  if ((BufDataset1.FieldByName('BitNumber').AsLargeInt mod 2) = 0)then
  begin
    for i := 0 to 31 do
    begin
      BitNumber:= round(Power(2,i));
      if BitNumber = BufDataset1.FieldByName('BitNumber').AsLargeInt then
      begin
        CurrentObj := Self.FindComponent('B'+i.ToString);
        if (CurrentObj <> nil) then TShape(CurrentObj).Brush.Color := clgreen;
        break;
      end;
    end;
  end;
end;

procedure TForm1.BufDataset1BeforeEdit(DataSet: TDataSet);
begin
  log({$I %LINE%}+' BeforeEdit(');
end;

procedure TForm1.BufDataset1BeforeInsert(DataSet: TDataSet);
begin
  log({$I %LINE%}+' BeforeInsert');
end;

procedure TForm1.BufDataset1BeforePost(DataSet: TDataSet);
begin
  log({$I %LINE%}+' BeforePost');
end;

procedure TForm1.BufDataset1BeforeScroll(DataSet: TDataSet);
begin
  log({$I %LINE%}+' BeforeScroll');
end;

procedure TForm1.BufDataset1CalcFields(DataSet: TDataSet);
begin
  log({$I %LINE%}+' CalcFields');
end;

procedure TForm1.BufDataset1NewRecord(DataSet: TDataSet);
begin
  log({$I %LINE%}+' NewRecord');
end;

procedure TForm1.CmdCancelClick(Sender: TObject);
begin
  BufDataset1.Cancel;
end;

procedure TForm1.CmdClearListClick(Sender: TObject);
var
  i, i2: integer;
  CurrentObj: TComponent;
  DynamicTag: TPLCTagNumber;
  addrStr:String;
begin
  timer1.Enabled:=false;

  BufDataset2.Clear;
  BufDataset2.Fields.Clear;
  BufDataset2.FieldDefs.Clear;
  for i:=0 to DBGrid2.Columns.Count-1  do
    DBGrid2.Columns.Delete(0);

  with BufDataset2.FieldDefs do
  begin
    Add('Symbol', ftString, 255);
    Add('Result', ftString, 255);
    Add('Unit', ftString, 20);
    Add('Obj', ftString, 600);
    Add('UseBit', ftLargeint, 0, false);
  end;
  BufDataset2.CreateDataset;

  for i := 0 to ComponentCount - 1 do
  begin
    if i>(ComponentCount - 1) then i2:= (ComponentCount - 1);
    if i<=(ComponentCount - 1) then i2:=i;
    CurrentObj := Components[i2];
    if (CurrentObj is TPLCTagNumber)then
    begin
      log({$I %LINE%}+' Found TPLCTagNumber: '+TPLCTagNumber(CurrentObj).Name);
      TPLCTagNumber(CurrentObj).AutoRead:=false;
      TPLCTagNumber(CurrentObj).DestroyComponents;
      TPLCTagNumber(CurrentObj).Free;
    end;
  end;

  SerialPortDriver1.Active:= false;
  SerialPortDriver1.AcceptAnyPortName:=false;

  if (not SerialPortDriver1.Active) then CmdConnect.Caption:='Connect';
  if (SerialPortDriver1.Active) then CmdConnect.Caption:='Disconnect';

end;

procedure TForm1.CmdMoveNextClick(Sender: TObject);
begin
  BufDataset1.Next;
  CmdPost.Enabled:=false;
  CmdCancel.Enabled:=false;
  if BufDataset1.RecordCount = 0 then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
    CmdDelete.Enabled:=false;
  end
  else
  begin
    CmdMoveFirst.Enabled:=true;
    CmdPrior.Enabled:=true;
    CmdMoveNext.Enabled:=true;
    CmdMoveLast.Enabled:=true;
    CmdDelete.Enabled:=true;
  end;

  if BufDataset1.BOF then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
  end;
  if BufDataset1.EOF then
  begin
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
  end;
end;

procedure TForm1.CmdPostClick(Sender: TObject);
begin
  if BufDataset1.State in [dsEdit, dsInsert] then
  begin
    EditSymbol.Caption:=DelChars(EditSymbol.Caption, ',');
    EditUnit.Caption:=DelChars(EditUnit.Caption, ',');
    BufDataset1.FieldByName('Address').AsInteger := EditAddress.Value;
    BufDataset1.FieldByName('Symbol').AsString := EditSymbol.Caption;
    BufDataset1.FieldByName('Type').AsString := EditType.Items[EditType.ItemIndex];
    BufDataset1.FieldByName('RegisterType').AsString := EditRegisterType.Items[EditRegisterType.ItemIndex];
    BufDataset1.FieldByName('Unit').AsString := EditUnit.Caption;
    BufDataset1.FieldByName('SwapBytes').AsBoolean := CheckBoxSwapBytes.Checked;
    BufDataset1.FieldByName('SwapDwords').AsBoolean := CheckBoxSwapDwords.Checked;
    BufDataset1.FieldByName('SwapWords').AsBoolean := CheckBoxSwapWords.Checked;
    BufDataset1.FieldByName('UseBit').AsBoolean := CheckBoxUseBit.Checked;
    BufDataset1.FieldByName('BitNumber').AsLargeInt := BitNumber;
  end;
  BufDataset1.Post;

  CmdPost.Enabled:=false;
  CmdCancel.Enabled:=false;
end;

procedure TForm1.CmdRandomSerialClick(Sender: TObject);
begin
  Drv_SN.Caption:=RandomSerial();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Drv_CreatDate.Caption:= FormatDateTime('DD/MM/YYYY hh:nn:ss',Now);
end;

procedure TForm1.CmdInitDriverClick(Sender: TObject);
var
  i, i2: integer;
  CurrentObj: TComponent;
  DynamicTag: TPLCTagNumber;
  addrStr:String;
begin
  if BufDataset1.State in [dsEdit, dsInsert] then
  begin
    showmessage('Under editing config driver');
    exit;
  end;

  timer1.Enabled:=false;

  BufDataset2.Clear;
  BufDataset2.Fields.Clear;
  BufDataset2.FieldDefs.Clear;
  for i:=0 to DBGrid2.Columns.Count-1  do
    DBGrid2.Columns.Delete(0);

  with BufDataset2.FieldDefs do
  begin
    Add('Symbol', ftString, 255);
    Add('Result', ftString, 255);
    Add('Unit', ftString, 20);
    Add('Obj', ftString, 600);
    Add('UseBit', ftLargeint, 0, false);
  end;
  BufDataset2.CreateDataset;

  if (EditCom.Text='') and (not SerialPortDriver1.Active) then
  begin
    showmessage('No comport found');
    //exit;
  end;

  for i := 0 to ComponentCount - 1 do
  begin
    if i>(ComponentCount - 1) then i2:= (ComponentCount - 1);
    if i<=(ComponentCount - 1) then i2:=i;
    CurrentObj := Components[i2];
    if (CurrentObj is TPLCTagNumber)then
    begin
      log({$I %LINE%}+' Found TPLCTagNumber: '+TPLCTagNumber(CurrentObj).Name);
      TPLCTagNumber(CurrentObj).AutoRead:=false;
      TPLCTagNumber(CurrentObj).DestroyComponents;
      TPLCTagNumber(CurrentObj).Free;
    end;
  end;

  SerialPortDriver1.Active:= false;
  SerialPortDriver1.AcceptAnyPortName:=false;

  if (not SerialPortDriver1.Active) then CmdConnect.Caption:='Connect';
  if (SerialPortDriver1.Active) then CmdConnect.Caption:='Disconnect';


  OnBootFinish:=false;
  BufDataset1.First;
  i2:=0;
  while not BufDataset1.EOF do
  begin
    DynamicTag := TPLCTagNumber.Create(Self);

    addrStr:='H'+RightStr(StringToHex(BufDataset1.FieldByName('Symbol').AsString),10);
    CurrentObj := Self.FindComponent(addrStr);
    if (CurrentObj <> nil) then
    begin
      addrStr:=addrStr+i2.ToString; //+RandomSerial()
      i2:=i2+1;
      //showmessage({$I %LINE%}+chr(13)+addrStr);
    end;
    //showmessage({$I %LINE%}+chr(13)+addrStr);
    DynamicTag.Name:=addrStr;
    DynamicTag.ProtocolDriver:=ModBusRTUDriver1;
    DynamicTag.UpdateTime:=500;
    DynamicTag.AutoRead:=false;
    DynamicTag.AutoWrite:=false;
    DynamicTag.PLCStation:=SpinEditNode.Value;
    DynamicTag.MemAddress:=BufDataset1.FieldByName('Address').AsInteger;
    DynamicTag.TagType:=TTagType(GetEnumValue(TypeInfo(TTagType), BufDataset1.FieldByName('Type').AsString));
    //if DynamicTag.TagType = pttfloat then showmessage('ok');
    if BufDataset1.FieldByName('RegisterType').AsString = 'Coils (Outputs)' then DynamicTag.MemReadFunction:=1;
    if BufDataset1.FieldByName('RegisterType').AsString = 'Inputs' then DynamicTag.MemReadFunction:=2;
    if BufDataset1.FieldByName('RegisterType').AsString = 'Holding Registers' then DynamicTag.MemReadFunction:=3;
    if BufDataset1.FieldByName('RegisterType').AsString = 'Input Registers' then DynamicTag.MemReadFunction:=4;
    DynamicTag.SwapBytes:=BufDataset1.FieldByName('SwapBytes').AsBoolean;
    DynamicTag.SwapDWords:=BufDataset1.FieldByName('SwapDwords').AsBoolean;
    DynamicTag.SwapWords:=BufDataset1.FieldByName('SwapWords').AsBoolean;

    if not (BufDataset2.State in [dsEdit, dsInsert]) then
    BufDataset2.Edit;
    BufDataset2.Append;

    BufDataset2.FieldByName('Symbol').AsString := BufDataset1.FieldByName('Symbol').AsString;
    BufDataset2.FieldByName('Result').AsString := '';
    BufDataset2.FieldByName('Unit').AsString := BufDataset1.FieldByName('Unit').AsString;
    BufDataset2.FieldByName('Obj').AsString := DynamicTag.Name;

    if (BufDataset1.FieldByName('UseBit').AsBoolean) and (BufDataset1.FieldByName('BitNumber').AsLargeInt>0) then
    begin
      BufDataset2.FieldByName('UseBit').AsLargeInt := BufDataset1.FieldByName('BitNumber').AsLargeInt;
    end;

    BufDataset2.Post;

    BufDataset1.Next;
  end;
  OnBootFinish:=true;


end;

procedure TForm1.CheckBoxSwapBytesEditingDone(Sender: TObject);
begin
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('SwapBytes').AsBoolean := CheckBoxSwapBytes.Checked;
end;

procedure TForm1.CheckBoxSwapDwordsEditingDone(Sender: TObject);
begin
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('SwapDwords').AsBoolean := CheckBoxSwapDwords.Checked;
end;

procedure TForm1.CheckBoxSwapWordsEditingDone(Sender: TObject);
begin
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('SwapWords').AsBoolean := CheckBoxSwapWords.Checked;
end;

procedure TForm1.CheckBoxUseBitEditingDone(Sender: TObject);
begin
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('UseBit').AsBoolean := CheckBoxUseBit.Checked;
end;

procedure TForm1.CmdConnectClick(Sender: TObject);
var
  i:integer;
  CurrentObj: TComponent;
begin
  timer1.Enabled:=false;

  if (EditCom.Text='') and (not SerialPortDriver1.Active) then
  begin
    showmessage('No comport found');
    exit;
  end;

  for i := 0 to ComponentCount - 1 do
  begin
    CurrentObj := Components[i];
      if (CurrentObj is TPLCTagNumber)then
      begin
        log({$I %LINE%}+' Found TPLCTagNumber: '+TPLCTagNumber(CurrentObj).Name);
        TPLCTagNumber(CurrentObj).AutoRead:=not TPLCTagNumber(CurrentObj).AutoRead;
      end;
  end;
  SerialPortDriver1.Active:= not SerialPortDriver1.Active;
  SerialPortDriver1.AcceptAnyPortName:=not SerialPortDriver1.AcceptAnyPortName;

  if (not SerialPortDriver1.Active) then
  begin
    CmdConnect.Caption:='Connect';
    timer1.Enabled:=false;
  end;
  if (SerialPortDriver1.Active) then
  begin
    CmdConnect.Caption:='Disconnect';
    timer1.Enabled:=true;
  end;
end;

procedure TForm1.Datasource1StateChange(Sender: TObject);
begin
  log({$I %LINE%}+' Datasource1StateChange');


  if BufDataset1.State = dsInactive then log({$I %LINE%}+' dsInactive');
  if BufDataset1.State = dsBrowse then log({$I %LINE%}+' dsBrowse');
  if BufDataset1.State = dsEdit then log({$I %LINE%}+' dsEdit');
  if BufDataset1.State = dsInsert then log({$I %LINE%}+' dsInsert');
  if BufDataset1.State = dsSetKey then log({$I %LINE%}+' dsSetKey');
  if BufDataset1.State = dsCalcFields then log({$I %LINE%}+' dsCalcFields');
  if BufDataset1.State = dsFilter then log({$I %LINE%}+' dsFilter');
  if BufDataset1.State = dsNewValue then log({$I %LINE%}+' dsNewValue');
  if BufDataset1.State = dsOldValue then log({$I %LINE%}+' dsOldValue');
  if BufDataset1.State = dsCurValue then log({$I %LINE%}+' dsCurValue');
  if BufDataset1.State = dsBlockRead then log({$I %LINE%}+' dsBlockRead');
  if BufDataset1.State = dsInternalCalc then log({$I %LINE%}+' dsInternalCalc');
  if BufDataset1.State = dsOpening then log({$I %LINE%}+' dsOpening');
  if BufDataset1.State = dsRefreshFields then log({$I %LINE%}+' dsRefreshFields');

  if not OnBootFinish then exit;

  if BufDataset1.State in [dsEdit, dsInsert] then
  begin
    CmdPost.Enabled:=true;
    CmdCancel.Enabled:=true;
    CmdEdit.Enabled:=false;

    DBGrid1.Enabled:=false;
    DBNavigator1.VisibleButtons := DBNavigator1.VisibleButtons - [nbFirst, nbPrior, nbNext, nbLast, nbInsert,nbDelete];
    EditAddress.Enabled:=true;
    EditSymbol.Enabled:=true;
    EditType.Enabled:=true;
    EditRegisterType.Enabled:=true;
    EditUnit.Enabled:=true;
    CheckBoxSwapBytes.Enabled:=true;
    CheckBoxSwapDwords.Enabled:=true;
    CheckBoxSwapWords.Enabled:=true;
    CheckBoxUseBit.Enabled:=true;
    Label14.Enabled:=true;
    Label15.Enabled:=true;
    Label16.Enabled:=true;
    Label17.Enabled:=true;
    B0.Enabled:=true;
    B1.Enabled:=true;
    B2.Enabled:=true;
    B3.Enabled:=true;
    B4.Enabled:=true;
    B5.Enabled:=true;
    B6.Enabled:=true;
    B7.Enabled:=true;
    B8.Enabled:=true;
    B9.Enabled:=true;
    B10.Enabled:=true;
    B11.Enabled:=true;
    B12.Enabled:=true;
    B13.Enabled:=true;
    B14.Enabled:=true;
    B15.Enabled:=true;
    B16.Enabled:=true;
    B17.Enabled:=true;
    B18.Enabled:=true;
    B19.Enabled:=true;
    B20.Enabled:=true;
    B21.Enabled:=true;
    B22.Enabled:=true;
    B23.Enabled:=true;
    B24.Enabled:=true;
    B25.Enabled:=true;
    B26.Enabled:=true;
    B27.Enabled:=true;
    B28.Enabled:=true;
    B29.Enabled:=true;
    B30.Enabled:=true;
    B31.Enabled:=true;
  end
  else
  begin
    CmdPost.Enabled:=false;
    CmdCancel.Enabled:=false;
    CmdEdit.Enabled:=true;

    DBGrid1.Enabled:=true;
    DBNavigator1.VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbInsert,nbDelete,nbEdit,nbPost,nbCancel];
    EditAddress.Enabled:=false;
    EditSymbol.Enabled:=false;
    EditType.Enabled:=false;
    EditRegisterType.Enabled:=false;
    EditUnit.Enabled:=false;
    CheckBoxSwapBytes.Enabled:=false;
    CheckBoxSwapDwords.Enabled:=false;
    CheckBoxSwapWords.Enabled:=false;
    CheckBoxUseBit.Enabled:=false;
    Label14.Enabled:=false;
    Label15.Enabled:=false;
    Label16.Enabled:=false;
    Label17.Enabled:=false;
    B0.Enabled:=false;
    B1.Enabled:=false;
    B2.Enabled:=false;
    B3.Enabled:=false;
    B4.Enabled:=false;
    B5.Enabled:=false;
    B6.Enabled:=false;
    B7.Enabled:=false;
    B8.Enabled:=false;
    B9.Enabled:=false;
    B10.Enabled:=false;
    B11.Enabled:=false;
    B12.Enabled:=false;
    B13.Enabled:=false;
    B14.Enabled:=false;
    B15.Enabled:=false;
    B16.Enabled:=false;
    B17.Enabled:=false;
    B18.Enabled:=false;
    B19.Enabled:=false;
    B20.Enabled:=false;
    B21.Enabled:=false;
    B22.Enabled:=false;
    B23.Enabled:=false;
    B24.Enabled:=false;
    B25.Enabled:=false;
    B26.Enabled:=false;
    B27.Enabled:=false;
    B28.Enabled:=false;
    B29.Enabled:=false;
    B30.Enabled:=false;
    B31.Enabled:=false;
  end;
end;

procedure TForm1.Datasource1UpdateData(Sender: TObject);
begin
  log({$I %LINE%}+' Datasource1UpdateData');
  if OnBootFinish then
  if BufDataset1.State in [dsEdit, dsInsert] then
  begin
    //log({$I %LINE%}+' Cancel');
    //BufDataset1.Cancel;
    //BufDataset1.CancelUpdates;
  end;
end;

procedure TForm1.MenuExitClick(Sender: TObject);
begin
  halt;
end;

procedure TForm1.MenuNewClick(Sender: TObject);
var
  i:integer;
  CurrentObj: TComponent;
begin
  OnBootFinish:=false;
  BufDataset1.Clear;
  BufDataset1.Fields.Clear;
  BufDataset1.FieldDefs.Clear;
  for i:=0 to DBGrid1.Columns.Count-1  do
    DBGrid1.Columns.Delete(0);

  form1.Caption:=Version_;

  Device_Name.Caption:='';
  Device_MFG.Caption:='';
  Device_Model.Caption:='';
  Device_SN.Caption:='';
  Device_Ver.Caption:='';

  Drv_Name.Caption:='';
  Drv_SN.Caption:=RandomSerial();
  Drv_Ver.Caption:='0.1';
  Drv_Other_Information.Caption:='';
  Drv_CreatDate.Caption:=FormatDateTime('DD/MM/YYYY hh:nn:ss',Now);

  EditAddress.Value:=0;
  EditSymbol.Caption:='';
  EditType.ItemIndex:=0;
  EditRegisterType.ItemIndex:=2;
  EditUnit.Caption:='';
  CheckBoxSwapBytes.Checked:=false;
  CheckBoxSwapDwords.Checked:=false;
  CheckBoxSwapWords.Checked:=false;
  CheckBoxUseBit.Checked:=false;
  EditRegisterType.ItemIndex:=2;

  for i := 0 to 31 do
  begin

    CurrentObj := Self.FindComponent('B'+i.ToString);
    if (CurrentObj <> nil) then TShape(CurrentObj).Brush.Color := clWhite;

  end;

  with BufDataset1.FieldDefs do
  begin
    Add('Address', ftInteger, 0,false);
    Add('Symbol', ftString, 255);
    Add('Type', ftString, 255);
    Add('RegisterType', ftString, 255);
    Add('SwapBytes', ftBoolean, 0,false);
    Add('SwapDwords', ftBoolean, 0,false);
    Add('SwapWords', ftBoolean, 0,false);
    Add('UseBit', ftBoolean, 0,false);
    Add('BitNumber', ftLargeint, 0,false);
    Add('Unit', ftString, 20);
  end;
  BufDataset1.CreateDataset;

  CmdPost.Enabled:=false;
  CmdCancel.Enabled:=false;
  if BufDataset1.RecordCount = 0 then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
    CmdDelete.Enabled:=false;
  end;

  OnBootFinish:=true;
end;

procedure TForm1.MenuOpenClick(Sender: TObject);
var
  i:integer;
  S_Name, Directory_, CurrentFile:string;
  CSV: TCSVDocument;
  Row, Col: Integer;
  Loop1:integer;
  MyIni: TIniFile;
begin
  Directory_:=ExtractFilePath(ParamStr(0));
  OpenDialog1.InitialDir:=ExtractFilePath(ParamStr(0));
  OpenDialog1.FileName:='*.drv';
  OpenDialog1.Filter:='drv';
  OpenDialog1.Filter := 'DRV files (*.drv)|*.drv|Text files (*.txt)|*.txt|All files (*.*)|*.*';
  OpenDialog1.DefaultExt := 'drv';
  OpenDialog1.FilterIndex := 1;
  if OpenDialog1.Execute then
  begin

    S_Name:= OpenDialog1.FileName;
    if not FileExists(S_Name) then
    begin
      showmessage('File not Exists');
      exit;
    end;

    CSV := TCSVDocument.Create;
    try
      CSV.Delimiter := ',';
      CSV.LoadFromFile(S_Name);

      if CSV.RowCount > 0 then
      begin
        OnBootFinish:=false;

        CurrentFile := ExtractFileName(S_Name);
        form1.Caption:=Version_+' ['+CurrentFile+']';
        BufDataset1.Clear;
        BufDataset1.Fields.Clear;
        BufDataset1.FieldDefs.Clear;
        for i:=0 to DBGrid1.Columns.Count-1  do
          DBGrid1.Columns.Delete(0);
        //showmessage(BufDataset1.FieldDefs.Count.ToString + '/' + CSV.RowCount.ToString + '/' + CSV.ColCount[0].ToString);

      for Row := 0 to CSV.RowCount - 1 do
      begin

        if Row = 0 then
        begin
          with BufDataset1.FieldDefs do
          begin
            if (CSV.Cells[0, Row] <> 'Address') or
               (CSV.Cells[1, Row] <> 'Symbol') or
               (CSV.Cells[2, Row] <> 'Type') or
               (CSV.Cells[3, Row] <> 'RegisterType') or
               (CSV.Cells[4, Row] <> 'SwapBytes') or
               (CSV.Cells[5, Row] <> 'SwapDwords') or
               (CSV.Cells[6, Row] <> 'SwapWords') or
               (CSV.Cells[7, Row] <> 'UseBit') or
               (CSV.Cells[8, Row] <> 'BitNumber') or
               (CSV.Cells[9, Row] <> 'Unit') then
            begin
              showmessage('File Error');
              MenuNewClick(Sender);
              exit;
            end;

            Add('Address', ftInteger, 0,false);
            Add('Symbol', ftString, 255);
            Add('Type', ftString, 255);
            Add('RegisterType', ftString, 255);
            Add('SwapBytes', ftBoolean, 0,false);
            Add('SwapDwords', ftBoolean, 0,false);
            Add('SwapWords', ftBoolean, 0,false);
            Add('UseBit', ftBoolean, 0,false);
            Add('BitNumber', ftLargeint, 0,false);
            Add('Unit', ftString, 20);
          end;
          BufDataset1.CreateDataset;
          //BufDataset1.First;
        end;

        if (CSV.Cells[0, Row]='[DriverInfo]') then break;

        if (Row > 0) and (CSV.ColCount[Row]>9) then
        begin
          if not (BufDataset1.State in [dsEdit, dsInsert]) then
            BufDataset1.Edit;
          BufDataset1.Append;
          BufDataset1.FieldByName('Address').AsInteger := StrToInt(CSV.Cells[0, Row]);
          BufDataset1.FieldByName('Symbol').AsString := CSV.Cells[1, Row];
          BufDataset1.FieldByName('Type').AsString := CSV.Cells[2, Row];
          BufDataset1.FieldByName('RegisterType').AsString := CSV.Cells[3, Row];
          BufDataset1.FieldByName('SwapBytes').AsBoolean := StrToBoolV2(CSV.Cells[4, Row]);
          BufDataset1.FieldByName('SwapDwords').AsBoolean := StrToBoolV2(CSV.Cells[5, Row]);
          BufDataset1.FieldByName('SwapWords').AsBoolean := StrToBoolV2(CSV.Cells[6, Row]);
          BufDataset1.FieldByName('UseBit').AsBoolean := StrToBoolV2(CSV.Cells[7, Row]);
          BufDataset1.FieldByName('BitNumber').AsLargeInt := StrToInt('0'+CSV.Cells[8, Row]);
          BufDataset1.FieldByName('Unit').AsString := CSV.Cells[9, Row];
          BufDataset1.Post;
        end;

      end;
    end;
    finally
      CSV.Free;
      OnBootFinish:=true;
      BufDataset1.First;
    end;

    if BufDataset1.RecordCount = 0 then
    begin
      CmdMoveFirst.Enabled:=false;
      CmdPrior.Enabled:=false;
      CmdMoveNext.Enabled:=false;
      CmdMoveLast.Enabled:=false;
      CmdDelete.Enabled:=false;
    end
    else
    begin
      CmdMoveFirst.Enabled:=true;
      CmdPrior.Enabled:=true;
      CmdMoveNext.Enabled:=true;
      CmdMoveLast.Enabled:=true;
      CmdDelete.Enabled:=true;
    end;
    if BufDataset1.BOF then
    begin
      CmdMoveFirst.Enabled:=false;
      CmdPrior.Enabled:=false;
    end;
    if BufDataset1.EOF then
    begin
      CmdMoveNext.Enabled:=false;
      CmdMoveLast.Enabled:=false;
    end;

    MyIni := TIniFile.Create(S_Name);
    try
      Device_Name.Caption:=MyIni.ReadString('DriverInfo', 'Device_Name', '');
      Device_MFG.Caption:=MyIni.ReadString('DriverInfo', 'Device_MFG', '');
      Device_Model.Caption:=MyIni.ReadString('DriverInfo', 'Device_Model', '');
      Device_SN.Caption:=MyIni.ReadString('DriverInfo', 'Device_SN', '');
      Device_Ver.Caption:=MyIni.ReadString('DriverInfo', 'Device_Ver', '');

      Drv_Name.Caption:=MyIni.ReadString('DriverInfo', 'Drv_Name', '');
      Drv_SN.Caption:=MyIni.ReadString('DriverInfo', 'Drv_SN', '');
      Drv_Ver.Caption:=MyIni.ReadString('DriverInfo', 'Drv_Ver', '');
      Drv_Other_Information.Caption:=MyIni.ReadString('DriverInfo', 'Drv_Other_Information', '');
      Drv_CreatDate.Caption:=MyIni.ReadString('DriverInfo', 'Drv_CreatDate', '');
    finally
      // Always free the object
      MyIni.Free;
    end;

  end;
end;

procedure TForm1.MenuSaveAsClick(Sender: TObject);
var
  i:integer;
  fileout : TextFile;
  S_Name, Directory_, CurrentFile:string;
  Txt:String;
  FileName_:string;
  s:string;
begin

  FileName_:=FormatDateTime('DD MM YYYY hh nn ss',Now);

  Directory_:=ExtractFilePath(ParamStr(0));
  SaveDialog1.InitialDir:=ExtractFilePath(ParamStr(0));
  SaveDialog1.FileName:=FileName_+'.drv';
  SaveDialog1.Filter:='drv';
  SaveDialog1.Filter := 'DRV files (*.drv)|*.drv|Text files (*.txt)|*.txt|All files (*.*)|*.*';
  SaveDialog1.DefaultExt := 'drv';
  SaveDialog1.FilterIndex := 1;
  if SaveDialog1.Execute then
  begin
    S_Name:= SaveDialog1.FileName;
    //showmessage(S_Name);
    if FileExists(S_Name) then
    begin
      if MessageDlg('Confirmation', 'Do you want to proceed?', mtConfirmation, [mbYes, mbNo], 0) = 7 then
      begin
        //showmessage('exit');
        exit;
      end;
    end;
    //showmessage('Save');

    try
      AssignFile(fileout, S_Name);
    except
      on E: EInOutError do
      begin
        showmessage('AssignFile: '+E.ClassName+'/'+ E.Message+'/'+IntToStr(E.ErrorCode));
        exit;
      end;
    end;

    //if FileExists(S_Name) then
    //try
    //  Append(fileout);
    //except
    //  on E: EInOutError do
    //  begin
    //    showmessage('Append: '+E.ClassName+'/'+ E.Message+'/'+IntToStr(E.ErrorCode));
    //    exit;
    //  end;
    //end;

    //if not FileExists(S_Name) then
    //begin
      try
        rewrite (fileout);
        Txt:='';
        for i := 0 to BufDataset1.FieldCount - 1 do
        begin
          Txt:=Txt+BufDataset1.Fields[i].FieldName;
          if i<(BufDataset1.FieldCount - 1) then Txt:=Txt+',';
        end;
        writeln(fileout, Txt);
      except
        on E: EInOutError do
        begin
          showmessage('Append: '+E.ClassName+'/'+ E.Message+'/'+IntToStr(E.ErrorCode));
          exit;
        end;
      end;
    //end;

    OnBootFinish:=false;
    BufDataset1.First;
    CurrentFile := ExtractFileName(S_Name);
    form1.Caption:=Version_+' ['+CurrentFile+']';

    while not BufDataset1.EOF do
    begin
      Txt:='';
      for i := 0 to BufDataset1.FieldCount - 1 do
      begin
        s:=BufDataset1.FieldByName(BufDataset1.Fields[i].FieldName).AsString;
        if (BufDataset1.Fields[i].FieldName = 'Type') then
        if BufDataset1.FieldByName('Type').AsString = ''then  s:=EditType.Items[0];
        if (BufDataset1.Fields[i].FieldName = 'RegisterType') then
        if BufDataset1.FieldByName('RegisterType').AsString = ''then  s:=EditRegisterType.Items[2];
        Txt:=Txt+s;
        if i<(BufDataset1.FieldCount - 1) then Txt:=Txt+',';
      end;
      //log({$I %LINE%}+' '+Txt);
      writeln(fileout, Txt);
      BufDataset1.Next;
    end;
    OnBootFinish:=true;

    Txt:='[DriverInfo]';
    writeln(fileout, Txt);
    Txt:='Device_Name='+Device_Name.Caption;
    writeln(fileout, Txt);
    Txt:='Device_MFG='+Device_MFG.Caption;
    writeln(fileout, Txt);
    Txt:='Device_Model='+Device_Model.Caption;
    writeln(fileout, Txt);
    Txt:='Device_SN='+Device_SN.Caption;
    writeln(fileout, Txt);
    Txt:='Device_Ver='+Device_Ver.Caption;
    writeln(fileout, Txt);
    if Trim(Drv_Name.Caption)='' then Drv_Name.Caption:=FileName_;
    Txt:='Drv_Name='+Drv_Name.Caption;
    writeln(fileout, Txt);
    if Trim(Drv_SN.Caption)='' then Drv_SN.Caption:=RandomSerial();
    Txt:='Drv_SN='+Drv_SN.Caption;
    writeln(fileout, Txt);
    if Trim(Drv_Ver.Caption)='' then Drv_Ver.Caption:='0.1';
    Txt:='Drv_Ver='+Drv_Ver.Caption;
    writeln(fileout, Txt);
    Txt:='Drv_Other_Information='+Drv_Other_Information.Caption;
    writeln(fileout, Txt);
    if Trim(Drv_CreatDate.Caption)='' then Drv_CreatDate.Caption:= FormatDateTime('DD/MM/YYYY hh:nn:ss',Now);
    Txt:='Drv_CreatDate='+Drv_CreatDate.Caption;
    writeln(fileout, Txt);

    CloseFile(fileout);
    BufDataset1.First;
  end;

end;

procedure TForm1.SpinEditNodeEditingDone(Sender: TObject);
var
  i: integer;
  CurrentObj: TComponent;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    CurrentObj := Components[i];
    if (CurrentObj is TPLCTagNumber)then
    begin
      log({$I %LINE%}+' Found TPLCTagNumber: '+TPLCTagNumber(CurrentObj).Name);
      TPLCTagNumber(CurrentObj).PLCStation:=SpinEditNode.Value;
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i: integer;
  CurrentObj: TComponent;
  i64_1,i64_2,i64_3: int64;
begin
  BufDataset2.First;
  while not BufDataset2.EOF do
  begin

    CurrentObj := Self.FindComponent(BufDataset2.FieldByName('Obj').AsString);
    if (CurrentObj is TPLCTagNumber) then
    begin
      if not (BufDataset2.State in [dsEdit, dsInsert]) then BufDataset2.Edit;

      if BufDataset2.FieldByName('UseBit').AsLargeInt = 0 then
      begin
        if IsNaN(TPLCTagNumber(CurrentObj).Value) then
        begin
        i64_1:=Round(TPLCTagNumber(CurrentObj).ValueRaw);
        i64_2:=Round(TPLCTagNumber(CurrentObj).Value);

        end;
        BufDataset2.FieldByName('Result').AsString := TPLCTagNumber(CurrentObj).Value.ToString;
      end;

      if BufDataset2.FieldByName('UseBit').AsLargeInt <> 0 then
      begin
        i64_1:=BufDataset2.FieldByName('UseBit').AsLargeInt;
        i64_2:=Round(TPLCTagNumber(CurrentObj).Value);
        i64_3:=i64_1 and i64_2;
        if BufDataset2.FieldByName('UseBit').AsLargeInt = i64_3 then
          BufDataset2.FieldByName('Result').AsString := 'True'
        else
          BufDataset2.FieldByName('Result').AsString := 'false';
      end;

      BufDataset2.Post;
    end;

    BufDataset2.Next;
  end;
end;

procedure TForm1.CmdInsertClick(Sender: TObject);
begin
  DBGrid1.Enabled:=false;
  BufDataset1.Insert;
end;

procedure TForm1.CmdDeleteClick(Sender: TObject);
begin
  if BufDataset1.RecordCount = 0 then exit;
  if MessageDlg('Confirmation', 'Do you want to delete?', mtConfirmation, [mbYes, mbNo], 0) = 7 then
  begin
    //showmessage('exit');
    exit;
  end;
  BufDataset1.Delete;
end;

procedure TForm1.CmdEditClick(Sender: TObject);
begin
  DBGrid1.Enabled:=false;
  BufDataset1.Edit;
end;

procedure TForm1.CmdMoveFirstClick(Sender: TObject);
begin
  BufDataset1.First;

  CmdPost.Enabled:=false;
  CmdCancel.Enabled:=false;
  if BufDataset1.RecordCount = 0 then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
    CmdDelete.Enabled:=false;
  end
  else
  begin
    CmdMoveFirst.Enabled:=true;
    CmdPrior.Enabled:=true;
    CmdMoveNext.Enabled:=true;
    CmdMoveLast.Enabled:=true;
    CmdDelete.Enabled:=true;
  end;

  if BufDataset1.BOF then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
  end;
  if BufDataset1.EOF then
  begin
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
  end;
end;

procedure TForm1.CmdMoveLastClick(Sender: TObject);
begin
  BufDataset1.Last;
  CmdPost.Enabled:=false;
  CmdCancel.Enabled:=false;
  if BufDataset1.RecordCount = 0 then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
    CmdDelete.Enabled:=false;
  end
  else
  begin
    CmdMoveFirst.Enabled:=true;
    CmdPrior.Enabled:=true;
    CmdMoveNext.Enabled:=true;
    CmdMoveLast.Enabled:=true;
    CmdDelete.Enabled:=true;
  end;

  if BufDataset1.BOF then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
  end;
  if BufDataset1.EOF then
  begin
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
  end;
end;

procedure TForm1.CmdPriorClick(Sender: TObject);
begin
  BufDataset1.Prior;
  CmdPost.Enabled:=false;
  CmdCancel.Enabled:=false;
  if BufDataset1.RecordCount = 0 then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
    CmdDelete.Enabled:=false;
  end
  else
  begin
    CmdMoveFirst.Enabled:=true;
    CmdPrior.Enabled:=true;
    CmdMoveNext.Enabled:=true;
    CmdMoveLast.Enabled:=true;
    CmdDelete.Enabled:=true;
  end;

  if BufDataset1.BOF then
  begin
    CmdMoveFirst.Enabled:=false;
    CmdPrior.Enabled:=false;
  end;
  if BufDataset1.EOF then
  begin
    CmdMoveNext.Enabled:=false;
    CmdMoveLast.Enabled:=false;
  end;
end;

end.

