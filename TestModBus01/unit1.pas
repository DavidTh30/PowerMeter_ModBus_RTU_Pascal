unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  SpinEx, SerialPort, ModBusSerial, PLCTagNumber, PLCBlock, PLCBlockElement,
  HMIEdit, HMILabel, Tag, TypInfo, registry;

type

  { TForm1 }

  TForm1 = class(TForm)
    CmdConnect: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    ComboBox1: TComboBox;
    HMILabel1: THMILabel;
    HMILabel2: THMILabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ModBusRTUDriver1: TModBusRTUDriver;
    PageControl1: TPageControl;
    SerialPortDriver1: TSerialPortDriver;
    SpinEditEx1: TSpinEditEx;
    SpinEditEx2: TSpinEditEx;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Tag1: TPLCTagNumber;
    Tag2: TPLCTagNumber;
    procedure CmdConnectClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1EditingDone(Sender: TObject);
    procedure CheckBox2EditingDone(Sender: TObject);
    procedure CheckBox3EditingDone(Sender: TObject);
    procedure CheckBox4EditingDone(Sender: TObject);
    procedure CheckBox5EditingDone(Sender: TObject);
    procedure CheckBox6EditingDone(Sender: TObject);
    procedure ComboBox1EditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure ListBox2SelectionChange(Sender: TObject; User: boolean);
    procedure SpinEditEx1Change(Sender: TObject);
    procedure SpinEditEx1EditingDone(Sender: TObject);
    procedure SpinEditEx2Change(Sender: TObject);
    procedure SpinEditEx2EditingDone(Sender: TObject);
    procedure Tag1ValueChange(Sender: TObject);
    procedure Tag2ValueChange(Sender: TObject);
  private

  public
    procedure GetSerialPortExt();
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

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
  ComboBox1.Clear;

  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKeyReadOnly('HARDWARE\DEVICEMAP\SERIALCOMM') then
    begin
      reg.GetValueNames(l);

      for n := 0 to l.Count - 1 do
      begin
        pn := reg.ReadString(l[n]);
        //fn := findFriendlyName('\System\CurrentControlSet\Enum\', pn);
        ComboBox1.Items.Append(pn);
      end; // for n := 0 to l.Count - 1 ...

      //Result_ := v.CommaText;
    end; // if reg.OpenKeyReadOnly('HARDWARE\DEVICEMAP\SERIALCOMM') ...
  finally
    reg.Free;
    v.Free;
    l.Free;
  end; // try ...
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

procedure TForm1.CmdConnectClick(Sender: TObject);
begin
  if (ComboBox1.Text='') and (not SerialPortDriver1.Active) then exit;
  Tag1.AutoRead:= not Tag1.AutoRead;
  Tag2.AutoRead:= not Tag2.AutoRead;
  SerialPortDriver1.Active:= not SerialPortDriver1.Active;
  SerialPortDriver1.AcceptAnyPortName:=not SerialPortDriver1.AcceptAnyPortName;

  if (not SerialPortDriver1.Active) then CmdConnect.Caption:='Connect';
  if (SerialPortDriver1.Active) then CmdConnect.Caption:='Disconnect';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Tag1.MemAddress:=Tag1.MemAddress+1;
  Tag2.MemAddress:=Tag2.MemAddress+1;
  label1.Caption:='MemAddress: '+Tag1.MemAddress.ToString;
  label2.Caption:='MemAddress: '+Tag2.MemAddress.ToString;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if (Tag1.MemAddress -1) < 0 then exit;
  if (Tag2.MemAddress -1) < 0 then exit;
  Tag1.MemAddress:=Tag1.MemAddress-1;
  Tag2.MemAddress:=Tag2.MemAddress-1;
  label1.Caption:='MemAddress: '+Tag1.MemAddress.ToString;
  label2.Caption:='MemAddress: '+Tag2.MemAddress.ToString;
end;

procedure TForm1.CheckBox1EditingDone(Sender: TObject);
begin
  Tag1.SwapBytes:=CheckBox1.Checked;
end;

procedure TForm1.CheckBox2EditingDone(Sender: TObject);
begin
  Tag1.SwapDWords:=CheckBox2.Checked;
end;

procedure TForm1.CheckBox3EditingDone(Sender: TObject);
begin
  Tag1.SwapWords:=CheckBox3.Checked;
end;

procedure TForm1.CheckBox4EditingDone(Sender: TObject);
begin
  Tag2.SwapBytes:=CheckBox4.Checked;
end;

procedure TForm1.CheckBox5EditingDone(Sender: TObject);
begin
  Tag2.SwapDWords:=CheckBox5.Checked;
end;

procedure TForm1.CheckBox6EditingDone(Sender: TObject);
begin
  Tag2.SwapWords:=CheckBox6.Checked;
end;

procedure TForm1.ComboBox1EditingDone(Sender: TObject);
begin
  SerialPortDriver1.COMPort:=ComboBox1.Text;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Tag1.AutoRead:=false;
  Tag2.AutoRead:=false;
  SerialPortDriver1.AcceptAnyPortName:=false;
  SerialPortDriver1.Active:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  s:TStringList;
  i:integer;

begin
  PopulateEnumList(s);
  ListBox1.Items := s;
  ListBox2.Items := s;

  if ListBox1.Count > 0 then
  for i := 0 to ListBox1.Count-1 do
  begin
    if GetEnumName(TypeInfo(TTagType), Ord(Tag1.TagType)) = ListBox1.Items[i] then ListBox1.ItemIndex:=i;
  end;

  if ListBox2.Count > 0 then
  for i := 0 to ListBox2.Count-1 do
  begin
    if GetEnumName(TypeInfo(TTagType), Ord(Tag2.TagType)) = ListBox2.Items[i] then ListBox2.ItemIndex:=i;
  end;

  if s<> nil then
  begin
    s.Free;
    s:=nil;
  end;

  GetSerialPortExt();

  ComboBox1.ItemIndex:=-1;
  label1.Caption:='MemAddress: '+Tag1.MemAddress.ToString;
  label2.Caption:='MemAddress: '+Tag2.MemAddress.ToString;

  CheckBox1.Checked:=Tag1.SwapBytes;
  CheckBox2.Checked:=Tag1.SwapDWords;
  CheckBox3.Checked:=Tag1.SwapWords;

  CheckBox4.Checked:=Tag2.SwapBytes;
  CheckBox5.Checked:=Tag2.SwapDWords;
  CheckBox6.Checked:=Tag2.SwapWords;
end;

procedure TForm1.ListBox1SelectionChange(Sender: TObject; User: boolean);
var
  T_TagType: TTagType;
begin
  for T_TagType := Low(TTagType) to High(TTagType) do
  begin
    if GetEnumName(TypeInfo(TTagType), Ord(T_TagType)) = ListBox1.Items[ListBox1.ItemIndex] then Tag1.TagType:=T_TagType;
  end;
end;

procedure TForm1.ListBox2SelectionChange(Sender: TObject; User: boolean);
var
  T_TagType: TTagType;
begin
  for T_TagType := Low(TTagType) to High(TTagType) do
  begin
    if GetEnumName(TypeInfo(TTagType), Ord(T_TagType)) = ListBox2.Items[ListBox2.ItemIndex] then Tag2.TagType:=T_TagType;
  end;
end;

procedure TForm1.SpinEditEx1Change(Sender: TObject);
begin
  SpinEditEx1EditingDone(Sender);
end;

procedure TForm1.SpinEditEx1EditingDone(Sender: TObject);
begin
  Tag1.MemAddress:=SpinEditEx1.Value;
  label1.Caption:='MemAddress: '+Tag1.MemAddress.ToString;
  label2.Caption:='MemAddress: '+Tag2.MemAddress.ToString;
end;

procedure TForm1.SpinEditEx2Change(Sender: TObject);
begin
  SpinEditEx2EditingDone(Sender);
end;

procedure TForm1.SpinEditEx2EditingDone(Sender: TObject);
begin
  Tag2.MemAddress:=SpinEditEx2.Value;
  label1.Caption:='MemAddress: '+Tag1.MemAddress.ToString;
  label2.Caption:='MemAddress: '+Tag2.MemAddress.ToString;
end;

procedure TForm1.Tag1ValueChange(Sender: TObject);
begin

  //// Convert Byte to 8-bit binary
  //s:='';
  //for j := 7 downto 0 do
  //begin
  //  if (ByteVal and (1 shl j)) <> 0 then
  //    s := s + '1'
  //else
  //    s := s + '0';
  //end;

  Label3.Caption:= BinStr(Round(Tag1.Value), 16);
end;

procedure TForm1.Tag2ValueChange(Sender: TObject);
begin
  Label4.Caption:= BinStr(Round(Tag2.Value), 16);
end;

end.

