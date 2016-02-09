unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, db_STORE, Grids, DBGrids, JvMemoryDataset, StdCtrls,
  qst_financeiro;

type
  TForm7 = class(TForm)
    ALQuery1: TALQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    JvMemoryData1: TJvMemoryData;
    JvMemoryData1dcto: TStringField;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button2: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ALQuery1AfterOpen(DataSet: TDataSet);
  private
    FDatabasename: string;
    FFilial: extended;
    reg : TRegSigcAut2;
    procedure SetDatabasename(const Value: string);
    procedure SetFilial(const Value: integer);
    { Private declarations }
  public
    { Public declarations }
    property Databasename:string read FDatabasename write SetDatabasename;
    property Filial: extended read FFilial write SetFilial;
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

uses mFunctions;

//var
//    reg2 : TRegSigcAut2;


procedure TForm7.ALQuery1AfterOpen(DataSet: TDataSet);
begin
    JvMemoryData1.close;
    JvMemoryData1.LoadFromDataSet(alquery1,0,lmCopy  );
    JvMemoryData1.open;

end;

procedure TForm7.Button1Click(Sender: TObject);
begin

//  if reg2=nil then
//     reg2 := TRegSigcAut2.create(nil);


//  if reg=nil then


   if not assigned(reg) then
     reg := TRegSigcAut2.Create( self );

   reg.DatabaseName := FDatabasename;
   reg.Filial := FFilial;
   reg.Registrado := 'N';
   reg.Operacao := '111';
   reg.Valor := 10;
   reg.Historico := 'REG EXEMPLO';
   reg.Preco:= 10;
   reg.Qtde := 1;
   reg.Liquido := 10;
   reg.Codigo := '1';
   reg.Dcto := edit1.text;


   reg.Execute;
   if reg.idLcto=0 then
     okDlg('Falhou');



  try

  finally
     reg.free;
     reg := nil;
  end;


  alquery1.reopen;

end;

procedure TForm7.Button2Click(Sender: TObject);
begin
    alquery1.first;
    while alquery1.eof=false do
    begin
      alquery1.delete;
    end;

    alquery1.reopen;

end;

procedure TForm7.FormCreate(Sender: TObject);
begin
   Databasename := 'Estoque';
   filial := FilialCorrente;

   ConnectDataBaseFromIni('SqlEstoque','Estoque','estoque.ini',true);
   alquery1.ActiveSqlUpdate('sigcaut2','filial=:OLD_filial and data=:OLD_data and '+
     'prtserie = :OLD_prtserie and dcto = :OLD_dcto and ordem = :OLD_ordem');

end;

procedure TForm7.FormShow(Sender: TObject);
begin
    alquery1.open;



end;

procedure TForm7.SetDatabasename(const Value: string);
begin
  FDatabasename := Value;
  DataBaseNameChange(self,value);
end;

procedure TForm7.SetFilial(const Value: integer);
begin
  FFilial := Value;
end;



initialization

finalization

//if reg2<>nil then
//  reg2.free;

    // ou

//  freeAndNil(reg2);


end.
