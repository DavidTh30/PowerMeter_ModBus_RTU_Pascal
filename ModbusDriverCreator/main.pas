unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, FileUtil, SpinEx, Forms, Controls,
  Graphics, Dialogs, DbCtrls, DBGrids, StdCtrls, Menus, Spin, ExtCtrls,
  ComCtrls, SerialPort, ModBusSerial, csvdocument, dbugintf, Tag, TypInfo,
  registry, Math;

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
    Button1: TButton;
    Button2: TButton;
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
    EditAddress: TSpinEdit;
    EditSymbol: TEdit;
    EditType: TComboBox;
    EditUnit: TEdit;
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
    MenuSaveAs: TMenuItem;
    MenuOpen: TMenuItem;
    MenuExit: TMenuItem;
    ModBusRTUDriver1: TModBusRTUDriver;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    SaveDialog1: TSaveDialog;
    SerialPortDriver1: TSerialPortDriver;
    SpinEditEx3: TSpinEditEx;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure B0MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BufDataset1AfterCancel(DataSet: TDataSet);
    procedure BufDataset1AfterDelete(DataSet: TDataSet);
    procedure BufDataset1AfterEdit(DataSet: TDataSet);
    procedure BufDataset1AfterInsert(DataSet: TDataSet);
    procedure BufDataset1AfterPost(DataSet: TDataSet);
    procedure BufDataset1AfterScroll(DataSet: TDataSet);
    procedure BufDataset1BeforeScroll(DataSet: TDataSet);
    procedure BufDataset1NewRecord(DataSet: TDataSet);
    procedure CheckBoxSwapBytesEditingDone(Sender: TObject);
    procedure CheckBoxSwapDwordsEditingDone(Sender: TObject);
    procedure CheckBoxSwapWordsEditingDone(Sender: TObject);
    procedure CheckBoxUseBitEditingDone(Sender: TObject);
    procedure Datasource1StateChange(Sender: TObject);
    procedure Datasource1UpdateData(Sender: TObject);
    procedure EditAddressEditingDone(Sender: TObject);
    procedure EditSymbolEditingDone(Sender: TObject);
    procedure EditTypeEditingDone(Sender: TObject);
    procedure EditUnitEditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuSaveAsClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1;
  OnBootFinish:boolean;
  BitNumber:int64;

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

procedure log(message_: string);
begin
  SendDebug(message_);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  s:TStringList;
begin

  OnBootFinish:=false;

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

  //showmessage(BufDataset1.FieldDefs.Count.ToString);

  with BufDataset1.FieldDefs do
  begin
    Add('Address', ftInteger, 0,false);
    Add('Symbol', ftString, 255);
    Add('Type', ftString, 255);
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
  end;
  BufDataset2.CreateDataset;

    BufDataset1.Append;
    BufDataset1.FieldByName('Address').AsInteger := 2999;
    BufDataset1.FieldByName('Symbol').AsString := 'CurrentA';
    BufDataset1.FieldByName('Type').AsString := 'pttFloat';
    BufDataset1.FieldByName('SwapBytes').AsBoolean := false;
    BufDataset1.FieldByName('SwapDwords').AsBoolean := false;
    BufDataset1.FieldByName('SwapWords').AsBoolean := false;
    BufDataset1.FieldByName('UseBit').AsBoolean := false;
    BufDataset1.FieldByName('BitNumber').AsLargeInt := 0;
    BufDataset1.FieldByName('Unit').AsString := 'A';
    BufDataset1.Post;

    BufDataset1.Append;
    BufDataset1.FieldByName('Address').AsInteger := 3201;
    BufDataset1.FieldByName('Symbol').AsString := 'Watt-Hours';
    BufDataset1.FieldByName('Type').AsString := 'pttInt64';
    BufDataset1.FieldByName('SwapBytes').AsBoolean := false;
    BufDataset1.FieldByName('SwapDwords').AsBoolean := true;
    BufDataset1.FieldByName('SwapWords').AsBoolean := true;
    BufDataset1.FieldByName('UseBit').AsBoolean := false;
    BufDataset1.FieldByName('BitNumber').AsLargeInt := 0;
    BufDataset1.FieldByName('Unit').AsString := 'Wh';
    BufDataset1.Post;


  BufDataset1.First;



  OnBootFinish:=true;
end;

procedure TForm1.EditSymbolEditingDone(Sender: TObject);
begin
  log({$I %LINE%}+' EditSymboldEditingDone');
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
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('Unit').AsString := EditUnit.Caption;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  i:integer;
begin
  OnBootFinish:=false;
  BufDataset1.Clear;
  BufDataset1.Fields.Clear;
  BufDataset1.FieldDefs.Clear;
  BufDataset2.Clear;
  BufDataset2.Fields.Clear;
  BufDataset2.FieldDefs.Clear;
  for i:=0 to DBGrid1.Columns.Count-1  do
  DBGrid1.Columns.Delete(0);
end;

procedure TForm1.EditAddressEditingDone(Sender: TObject);
begin
  log({$I %LINE%}+' EditAddressEditingDone');
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('Address').AsInteger := EditAddress.Value;
end;

procedure TForm1.BufDataset1AfterCancel(DataSet: TDataSet);
begin
  log({$I %LINE%}+' AfterCancel');
  BufDataset1AfterScroll(DataSet);
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
    if (sender is TShape) and (TShape(sender).Brush.Color = clGreen) then
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
end;

procedure TForm1.BufDataset1AfterEdit(DataSet: TDataSet);
begin
  log({$I %LINE%}+' AfterEdit');
end;

procedure TForm1.BufDataset1AfterInsert(DataSet: TDataSet);
begin
  log({$I %LINE%}+' AfterInsert');
end;

procedure TForm1.BufDataset1AfterPost(DataSet: TDataSet);
begin
  log({$I %LINE%}+' AfterPost');
end;

procedure TForm1.BufDataset1AfterScroll(DataSet: TDataSet);
var
  i:integer;
  CurrentObj: TComponent;
begin
  log({$I %LINE%}+' AfterScroll');
  if not OnBootFinish then exit;

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

procedure TForm1.BufDataset1BeforeScroll(DataSet: TDataSet);
begin
  log({$I %LINE%}+' BeforeScroll');
end;

procedure TForm1.BufDataset1NewRecord(DataSet: TDataSet);
begin
  log({$I %LINE%}+' NewRecord');
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

procedure TForm1.Datasource1StateChange(Sender: TObject);
begin
  log({$I %LINE%}+' Datasource1StateChange');
  if BufDataset1.State in [dsEdit, dsInsert] then
  begin
    DBGrid1.Enabled:=false;
    DBNavigator1.VisibleButtons := DBNavigator1.VisibleButtons - [nbFirst, nbPrior, nbNext, nbLast, nbInsert,nbDelete];
    EditAddress.Enabled:=true;
    EditSymbol.Enabled:=true;
    EditType.Enabled:=true;
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
    DBGrid1.Enabled:=true;
    DBNavigator1.VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbInsert,nbDelete,nbEdit,nbPost,nbCancel];
    EditAddress.Enabled:=false;
    EditSymbol.Enabled:=false;
    EditType.Enabled:=false;
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

procedure TForm1.MenuOpenClick(Sender: TObject);
var
  i:integer;
  S_Name, Directory_:string;
  CSV: TCSVDocument;
  Row, Col: Integer;
  Loop1:integer;

begin
  Directory_:=ExtractFilePath(ParamStr(0));
  OpenDialog1.InitialDir:=ExtractFilePath(ParamStr(0));
  OpenDialog1.FileName:=FormatDateTime('DD MM YYYY hh nn ss',Now)+'.CSV';
  OpenDialog1.Filter:='csv';
  OpenDialog1.Filter := 'CSV files (*.csv)|*.csv|Text files (*.txt)|*.txt|All files (*.*)|*.*';
  OpenDialog1.DefaultExt := 'csv';
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
            Add('Address', ftInteger, 0,false);
            Add('Symbol', ftString, 255);
            Add('Type', ftString, 255);
            Add('SwapBytes', ftBoolean, 0,false);
            Add('SwapDwords', ftBoolean, 0,false);
            Add('SwapWords', ftBoolean, 0,false);
            Add('UseBit', ftBoolean, 0,false);
            Add('BitNumber', ftLargeint, 0,false);
            Add('Unit', ftString, 20);
          end;
          BufDataset1.CreateDataset;
        end;

        if (CSV.Cells[0, Row]='[DriverInfo]') then break;

        if (Row > 0) and (CSV.ColCount[Row]>8) then
        begin
          BufDataset1.Append;
          BufDataset1.FieldByName('Address').AsInteger := StrToInt(CSV.Cells[0, Row]);
          BufDataset1.FieldByName('Symbol').AsString := CSV.Cells[1, Row];
          BufDataset1.FieldByName('Type').AsString := CSV.Cells[2, Row];
          BufDataset1.FieldByName('SwapBytes').AsBoolean := StrToBool(CSV.Cells[3, Row]);
          BufDataset1.FieldByName('SwapDwords').AsBoolean := StrToBool(CSV.Cells[4, Row]);
          BufDataset1.FieldByName('SwapWords').AsBoolean := StrToBool(CSV.Cells[5, Row]);
          BufDataset1.FieldByName('UseBit').AsBoolean := StrToBool(CSV.Cells[6, Row]);
          BufDataset1.FieldByName('BitNumber').AsLargeInt := StrToInt(CSV.Cells[7, Row]);
          BufDataset1.FieldByName('Unit').AsString := CSV.Cells[8, Row];
          BufDataset1.Post;
        end;

      end;
    end;
    finally
      CSV.Free;
      OnBootFinish:=true;
    end;
  end;
end;

procedure TForm1.MenuSaveAsClick(Sender: TObject);
var
  i:integer;
  fileout : TextFile;
  S_Name, Directory_:string;
  Txt:String;

begin

  Directory_:=ExtractFilePath(ParamStr(0));
  SaveDialog1.InitialDir:=ExtractFilePath(ParamStr(0));
  SaveDialog1.FileName:=FormatDateTime('DD MM YYYY hh nn ss',Now)+'.CSV';
  SaveDialog1.Filter:='csv';
  SaveDialog1.Filter := 'CSV files (*.csv)|*.csv|Text files (*.txt)|*.txt|All files (*.*)|*.*';
  SaveDialog1.DefaultExt := 'csv';
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
    while not BufDataset1.EOF do
    begin
      Txt:='';
      for i := 0 to BufDataset1.FieldCount - 1 do
      begin
        Txt:=Txt+BufDataset1.FieldByName(BufDataset1.Fields[i].FieldName).AsString;
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
    Txt:='Drv_Name='+Drv_Name.Caption;
    writeln(fileout, Txt);
    Txt:='Drv_SN='+Drv_SN.Caption;
    writeln(fileout, Txt);
    Txt:='Drv_Ver='+Drv_Ver.Caption;
    writeln(fileout, Txt);
    Txt:='Drv_Other_Information='+Drv_Other_Information.Caption;
    writeln(fileout, Txt);
    Txt:='Drv_CreatDate='+Drv_CreatDate.Caption;
    writeln(fileout, Txt);

    CloseFile(fileout);
    BufDataset1.First;
  end;

end;

end.

