unit Unit6_UsandoDataChange_do_Datasource;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, DB, DBTables, db_STORE,
  ExtCtrls, DBNav98, StdCtrls;

type
  TForm6 = class(TForm)
    ALQuery1: TALQuery;
    DataSource1: TDataSource;
    JvDBGrid1: TJvDBGrid;
    DBNav981: TDBNav98;
    Edit1: TEdit;
    StaticText1: TStaticText;
    ALQuery2: TALQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ALQuery1BeforeOpen(DataSet: TDataSet);
    procedure DBNav981Localizar(Sender: TObject);
    procedure ALQuery2BeforeOpen(DataSet: TDataSet);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    FDatabasename: string;
    FFilial: extended;
    procedure SetDatabasename(const Value: string);
    procedure SetFilial(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    property Databasename:string read FDatabasename write SetDatabasename;
    property Filial: extended read FFilial write SetFilial;
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}
uses mFunctions;

procedure TForm6.ALQuery1BeforeOpen(DataSet: TDataSet);
begin
    //alquery1.ParamByName('filial').asInteger := filial;
end;

procedure TForm6.ALQuery2BeforeOpen(DataSet: TDataSet);
begin
   alquery2.ParamByName('grupo').asString := alquery1.FieldByName('grupo').asString;
end;

procedure TForm6.DataSource1DataChange(Sender: TObject; Field: TField);
begin

  if (alquery2.active=false) or ( alquery1.fieldByName('grupo').AsString <> alquery2.FieldByName('grupo').asString) then
  begin
    alquery2.close;
    alquery2.open;
    StaticText1.caption := alquery2.fieldByName('nome').AsString;
  end;

end;

procedure TForm6.DBNav981Localizar(Sender: TObject);
begin
  OkDlg('chamou evento loalizar');
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
    FDatabasename := 'SQLEstoque';
    FFilial := FilialCorrente;


    alquery1.SQLDBFile := 'ctprod a';
    alquery1.SQLFields := 'a.codigo, a.grupo, a.nome, a.setor,a.unidade,a.precovenda';
    alquery1.ActiveSqlUpdate('ctprod','codigo' );


    // aplica controle de transacao automatica
    alquery1.AutoTransction := true;



end;

procedure TForm6.FormShow(Sender: TObject);
begin
 if not alquery1.active then
 begin

    alquery2.databasename := FDatabasename;
    alquery1.databasename := FDatabasename;
    alquery1.open;



 end;

end;

procedure TForm6.SetDatabasename(const Value: string);
begin
  FDatabasename := Value;
end;

procedure TForm6.SetFilial(const Value: Integer);
begin
  FFilial := Value;
end;

end.
