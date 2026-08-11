unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  SerialPort, ModBusSerial, PLCTagNumber, PLCBlock, PLCBlockElement, HMIEdit,
  HMILabel, Tag;

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
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

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
  Tag2.SwapBytes:=CheckBox1.Checked;
end;

procedure TForm1.CheckBox2EditingDone(Sender: TObject);
begin
  Tag1.SwapDWords:=CheckBox2.Checked;
  Tag2.SwapDWords:=CheckBox2.Checked;
end;

procedure TForm1.CheckBox3EditingDone(Sender: TObject);
begin
  Tag1.SwapWords:=CheckBox3.Checked;
  Tag2.SwapWords:=CheckBox3.Checked;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Tag1.AutoRead:=false;
  Tag2.AutoRead:=false;
  SerialPortDriver1.AcceptAnyPortName:=false;
  SerialPortDriver1.Active:=false;
end;

end.

