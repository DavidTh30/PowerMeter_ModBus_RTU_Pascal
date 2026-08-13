unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, BufDataset, FileUtil, Forms, Controls, Graphics,
  Dialogs, DbCtrls, DBGrids, StdCtrls, Menus, csvdocument;

type

  { TForm1 }

  TForm1 = class(TForm)
    BufDataset1: TBufDataset;
    Datasource1: TDatasource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuSaveAs: TMenuItem;
    MenuOpen: TMenuItem;
    MenuExit: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
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

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin

  BufDataset1.Clear;
  BufDataset1.Fields.Clear;
  BufDataset1.FieldDefs.Clear;
  for i:=0 to DBGrid1.Columns.Count-1  do
  DBGrid1.Columns.Delete(0);

  //showmessage(BufDataset1.FieldDefs.Count.ToString);

  with BufDataset1.FieldDefs do
  begin
    Add('Address', ftInteger, 0,false);
    Add('Symbold', ftWideString, 255);
    Add('Type', ftWideString, 255);
    Add('SwapBytes', ftBoolean, 0,false);
    Add('SwapDwords', ftBoolean, 0,false);
    Add('SwapWords', ftBoolean, 0,false);
    Add('UseBit', ftBoolean, 0,false);
    Add('BitNumber', ftInteger, 0,false);
  end;
  BufDataset1.CreateDataset;

    BufDataset1.Append;
    BufDataset1.FieldByName('Address').AsInteger := 2999;
    BufDataset1.FieldByName('Symbold').AsWideString := 'CurrentA';
    BufDataset1.FieldByName('Type').AsWideString := 'pttFloat';
    BufDataset1.FieldByName('SwapBytes').AsBoolean := false;
    BufDataset1.FieldByName('SwapDwords').AsBoolean := false;
    BufDataset1.FieldByName('SwapWords').AsBoolean := false;
    BufDataset1.FieldByName('UseBit').AsBoolean := false;
    BufDataset1.FieldByName('Address').AsInteger := 0;
    BufDataset1.Post;

    BufDataset1.Append;
    BufDataset1.FieldByName('Address').AsInteger := 3201;
    BufDataset1.FieldByName('Symbold').AsWideString := 'Wh';
    BufDataset1.FieldByName('Type').AsWideString := 'pttInt64';
    BufDataset1.FieldByName('SwapBytes').AsBoolean := false;
    BufDataset1.FieldByName('SwapDwords').AsBoolean := true;
    BufDataset1.FieldByName('SwapWords').AsBoolean := true;
    BufDataset1.FieldByName('UseBit').AsBoolean := false;
    BufDataset1.FieldByName('Address').AsInteger := 0;
    BufDataset1.Post;

  BufDataset1.First;

end;

procedure TForm1.MenuExitClick(Sender: TObject);
begin
  halt;
end;

procedure TForm1.MenuOpenClick(Sender: TObject);
var
  i:integer;
  fileout : TextFile;
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

