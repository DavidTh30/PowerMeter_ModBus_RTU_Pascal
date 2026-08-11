unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  SerialPort, ModBusSerial, PLCTagNumber, PLCBlock, PLCBlockElement, HMIEdit,
  HMILabel, Tag, TypInfo;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    HMILabel1: THMILabel;
    HMILabel2: THMILabel;
    Label1: TLabel;
    ListBox1: TListBox;
    ModBusRTUDriver1: TModBusRTUDriver;
    PageControl1: TPageControl;
    SerialPortDriver1: TSerialPortDriver;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Tag1: TPLCTagNumber;
    Tag2: TPLCTagNumber;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1EditingDone(Sender: TObject);
    procedure CheckBox2EditingDone(Sender: TObject);
    procedure CheckBox3EditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

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

procedure TForm1.Button1Click(Sender: TObject);
begin
  Tag1.AutoRead:= not Tag1.AutoRead;
  Tag2.AutoRead:= not Tag2.AutoRead;
  SerialPortDriver1.Active:= not SerialPortDriver1.Active;
  SerialPortDriver1.AcceptAnyPortName:=not SerialPortDriver1.AcceptAnyPortName;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Tag1.MemAddress:=Tag1.MemAddress+1;
  Tag2.MemAddress:=Tag2.MemAddress+1;
  label1.Caption:=Tag1.MemAddress.ToString;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Tag1.MemAddress:=Tag1.MemAddress-1;
  Tag2.MemAddress:=Tag2.MemAddress-1;
  label1.Caption:=Tag1.MemAddress.ToString;
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

  if ListBox1.Count > 0 then
  for i := 0 to ListBox1.Count-1 do
  begin
    if GetEnumName(TypeInfo(TTagType), Ord(Tag1.TagType)) = ListBox1.Items[i] then ListBox1.ItemIndex:=i;
  end;
  if s<> nil then
  begin
    s.Free;
    s:=nil;
  end;

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

end.

