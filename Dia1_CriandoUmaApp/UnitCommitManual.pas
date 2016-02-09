unit UnitCommitManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, DB, DBTables, db_STORE;

type
  TForm6CommitManual = class(TForm)
    ALQuery1: TALQuery;
    DataSource1: TDataSource;
    JvDBGrid1: TJvDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ALQuery1BeforePost(DataSet: TDataSet);
    procedure ALQuery1AfterPost(DataSet: TDataSet);
    procedure ALQuery1PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure ALQuery1BeforeDelete(DataSet: TDataSet);
    procedure ALQuery1AfterDelete(DataSet: TDataSet);
    procedure ALQuery1DeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private
    FDatabasename: string;
    procedure SetDatabasename(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property Databasename:string read FDatabasename write SetDatabasename;
  end;

var
  Form6CommitManual: TForm6CommitManual;

implementation

{$R *.dfm}

procedure TForm6CommitManual.ALQuery1AfterDelete(DataSet: TDataSet);
begin
  // commit manual
  CommitTransaction(fDatabasename);
end;

procedure TForm6CommitManual.ALQuery1AfterPost(DataSet: TDataSet);
begin
   CommitTransaction(fDatabasename) ;
end;

procedure TForm6CommitManual.ALQuery1BeforeDelete(DataSet: TDataSet);
begin
  StartTransaction(FDatabasename);
end;

procedure TForm6CommitManual.ALQuery1BeforePost(DataSet: TDataSet);
begin
   StartTransaction( FDatabasename );
end;

procedure TForm6CommitManual.ALQuery1DeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  RollbackTransaction(FDatabasename);
end;

procedure TForm6CommitManual.ALQuery1PostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
   RollbackTransaction(fDatabasename);
end;

procedure TForm6CommitManual.FormCreate(Sender: TObject);
begin
    Databasename := 'SQLEstoque';
    alquery1.ActiveSqlUpdate('ctgrupo','grupo=:OLD_grupo and nome=:OLD_nome' );

    // aplica controle de transacao automatica
    //    alquery1.AutoTransction := true;



end;

procedure TForm6CommitManual.FormShow(Sender: TObject);
begin
 if not alquery1.active then
 begin
    alquery1.databasename := FDatabasename;
    alquery1.open;
 end;

end;

procedure TForm6CommitManual.SetDatabasename(const Value: string);
begin
  FDatabasename := Value;
end;

end.
