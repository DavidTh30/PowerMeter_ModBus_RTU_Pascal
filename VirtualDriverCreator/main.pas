unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, FileUtil, SpinEx, Forms, Controls,
  Graphics, Dialogs, DbCtrls, DBGrids, StdCtrls, Menus, Spin, ExtCtrls,
  ComCtrls, SerialPort, ModBusSerial, csvdocument, dbugintf, Tag, TypInfo, registry;

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
    CheckBoxUseBit: TCheckBox;
    CmdConnect: TButton;
    Datasource2: TDataSource;
    DBGrid2: TDBGrid;
    EditMax: TSpinEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Drv_CreatDate: TEdit;
    Drv_Name: TEdit;
    Drv_Other_Information: TEdit;
    Drv_SN: TEdit;
    Drv_Ver: TEdit;
    Datasource1: TDatasource;
    EditMin: TSpinEdit;
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
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuSaveAs: TMenuItem;
    MenuOpen: TMenuItem;
    MenuExit: TMenuItem;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    SaveDialog1: TSaveDialog;
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
    procedure Datasource1StateChange(Sender: TObject);
    procedure Datasource1UpdateData(Sender: TObject);
    procedure EditMinEditingDone(Sender: TObject);
    procedure EditSymbolEditingDone(Sender: TObject);
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

  //showmessage(BufDataset1.FieldDefs.Count.ToString);

  with BufDataset1.FieldDefs do
  begin
    Add('Address', ftInteger, 0,false);
    Add('Symbol', ftWideString, 255);
    Add('Type', ftWideString, 255);
    Add('SwapBytes', ftBoolean, 0,false);
    Add('SwapDwords', ftBoolean, 0,false);
    Add('SwapWords', ftBoolean, 0,false);
    Add('UseBit', ftBoolean, 0,false);
    Add('BitNumber', ftInteger, 0,false);
    Add('Unit', ftWideString, 20);
  end;
  BufDataset1.CreateDataset;

  with BufDataset2.FieldDefs do
  begin
    Add('Symbol', ftWideString, 255);
    Add('Result', ftWideString, 255);
    Add('Unit', ftWideString, 20);
  end;
  BufDataset2.CreateDataset;

    BufDataset1.Append;
    BufDataset1.FieldByName('Address').AsInteger := 2999;
    BufDataset1.FieldByName('Symbol').AsWideString := 'CurrentA';
    BufDataset1.FieldByName('Type').AsWideString := 'pttFloat';
    BufDataset1.FieldByName('SwapBytes').AsBoolean := false;
    BufDataset1.FieldByName('SwapDwords').AsBoolean := false;
    BufDataset1.FieldByName('SwapWords').AsBoolean := false;
    BufDataset1.FieldByName('UseBit').AsBoolean := false;
    BufDataset1.FieldByName('BitNumber').AsInteger := 0;
    BufDataset1.FieldByName('Unit').AsWideString := 'A';
    BufDataset1.Post;

    BufDataset1.Append;
    BufDataset1.FieldByName('Address').AsInteger := 3201;
    BufDataset1.FieldByName('Symbol').AsWideString := 'Watt-Hours';
    BufDataset1.FieldByName('Type').AsWideString := 'pttInt64';
    BufDataset1.FieldByName('SwapBytes').AsBoolean := false;
    BufDataset1.FieldByName('SwapDwords').AsBoolean := true;
    BufDataset1.FieldByName('SwapWords').AsBoolean := true;
    BufDataset1.FieldByName('UseBit').AsBoolean := false;
    BufDataset1.FieldByName('BitNumber').AsInteger := 0;
    BufDataset1.FieldByName('Unit').AsWideString := 'Wh';
    BufDataset1.Post;


  BufDataset1.First;



  OnBootFinish:=true;
end;

procedure TForm1.EditSymbolEditingDone(Sender: TObject);
begin
  log({$I %LINE%}+' EditSymboldEditingDone');
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('Symbol').AsWideString := EditSymbol.Caption;
end;

procedure TForm1.EditMinEditingDone(Sender: TObject);
begin
  log({$I %LINE%}+' EditAddressEditingDone');
  if BufDataset1.State in [dsEdit, dsInsert] then
  BufDataset1.FieldByName('Address').AsInteger := EditMin.Value;
end;

procedure TForm1.BufDataset1AfterCancel(DataSet: TDataSet);
begin
  log({$I %LINE%}+' AfterCancel');
end;

procedure TForm1.B0MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  log({$I %LINE%}+' MouseUp');
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
begin
  log({$I %LINE%}+' AfterScroll');
  EditMin.Value:= BufDataset1.FieldByName('Address').AsInteger;
  EditSymbol.Caption:= BufDataset1.FieldByName('Symbol').AsWideString;
  EditUnit.Caption:= BufDataset1.FieldByName('Unit').AsWideString;
  CheckBoxSwapBytes.Checked:=BufDataset1.FieldByName('SwapBytes').AsBoolean;
  CheckBoxSwapDwords.Checked:=BufDataset1.FieldByName('SwapDwords').AsBoolean;
  CheckBoxSwapWords.Checked:=BufDataset1.FieldByName('SwapWords').AsBoolean;
  CheckBoxUseBit.Checked:=BufDataset1.FieldByName('UseBit').AsBoolean;

  if EditType.Items.Count > 0 then
  for i := 0 to EditType.Items.Count-1 do
  begin
    if BufDataset1.FieldByName('Type').AsWideString = EditType.Items[i] then
    begin
      EditType.ItemIndex:=i;
      break;
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

procedure TForm1.Datasource1StateChange(Sender: TObject);
begin
  log({$I %LINE%}+' Datasource1StateChange');
  if BufDataset1.State in [dsEdit, dsInsert] then
  begin
    EditMin.Enabled:=true;
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
    EditMin.Enabled:=false;
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
          for Col := 0 to CSV.ColCount[Row] - 1 do
          begin
            if BufDataset1.FieldDefs.Count<(Col+1) then
            if BufDataset1.FieldDefs.IndexOf(CSV.Cells[Col, Row]) < 0 then
            BufDataset1.FieldDefs.Add(CSV.Cells[Col, Row], ftWideString,255);
          end;
          BufDataset1.CreateDataset;
        end;

        if Row > 0 then
        begin
          BufDataset1.Append;
          //showmessage(BufDataset1.FieldDefs.Count.ToString + '/' + CSV.ColCount[Row].ToString);
          Loop1:=BufDataset1.FieldDefs.Count;
          if CSV.ColCount[Row] < Loop1 then Loop1 := CSV.ColCount[Row];
          for Col := 0 to Loop1 - 1 do
          begin
            //if BufDataset1.FieldDefs.Count>=(Col+1) then showmessage(Col.ToString + ':'+BufDataset1.Fields[Col].FieldName+':' + CSV.Cells[Col, Row]);
            if BufDataset1.FieldDefs.Count>=(Col+1) then BufDataset1.Fields[Col].AsWideString :=CSV.Cells[Col, Row];
          end;
          BufDataset1.Post;
        end;

      end;

    end;
    finally
      CSV.Free;
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

    if FileExists(S_Name) then
    try
      Append(fileout);
    except
      on E: EInOutError do
      begin
        showmessage('Append: '+E.ClassName+'/'+ E.Message+'/'+IntToStr(E.ErrorCode));
        exit;
      end;
    end;

    if not FileExists(S_Name) then
    begin
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
    end;

    BufDataset1.First;
    while not BufDataset1.EOF do
    begin
      Txt:='';
      for i := 0 to BufDataset1.FieldCount - 1 do
      begin
        Txt:=Txt+BufDataset1.FieldByName(BufDataset1.Fields[i].FieldName).AsAnsiString;
        if i<(BufDataset1.FieldCount - 1) then Txt:=Txt+',';
      end;
      writeln(fileout, Txt);
      BufDataset1.Next;
    end;
    CloseFile(fileout);
    BufDataset1.First;
  end;

end;

end.

