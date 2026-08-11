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
    HMILabel7: THMILabel;
    HMILabel8: THMILabel;
    N3_PM5300_Active_Power_Total: TPLCTagNumber;
    Button1: TButton;
    HMILabel1: THMILabel;
    HMILabel2: THMILabel;
    HMILabel3: THMILabel;
    HMILabel4: THMILabel;
    HMILabel5: THMILabel;
    HMILabel6: THMILabel;
    Label1: TLabel;
    ModBusRTUDriver1: TModBusRTUDriver;
    N3_PM5300_EnergyDeliveredIntoLoad: TPLCTagNumber;
    PageControl1: TPageControl;
    SerialPortDriver1: TSerialPortDriver;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    N3_PM5300_Current_A: TPLCTagNumber;
    N3_PM5300_Current_B: TPLCTagNumber;
    N3_PM5300_Current_C: TPLCTagNumber;
    N3_PM5300_Current_N: TPLCTagNumber;
    N3_PM5300_Current_AVG: TPLCTagNumber;
    N3_PM5300_Current_G: TPLCTagNumber;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
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
  N3_PM5300_Current_A.AutoRead:= not N3_PM5300_Current_A.AutoRead;
  N3_PM5300_Current_B.AutoRead:= not N3_PM5300_Current_B.AutoRead;
  SerialPortDriver1.Active:= not SerialPortDriver1.Active;
  SerialPortDriver1.AcceptAnyPortName:=not SerialPortDriver1.AcceptAnyPortName;
end;



procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  N3_PM5300_Current_A.AutoRead:=false;
  N3_PM5300_Current_B.AutoRead:=false;
  N3_PM5300_Current_C.AutoRead:=false;
  N3_PM5300_Current_N.AutoRead:=false;
  N3_PM5300_Current_G.AutoRead:=false;
  N3_PM5300_Current_AVG.AutoRead:=false;
  N3_PM5300_Active_Power_Total.AutoRead:=false;
  N3_PM5300_EnergyDeliveredIntoLoad.AutoRead:=false;
  SerialPortDriver1.AcceptAnyPortName:=false;
  SerialPortDriver1.Active:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.

