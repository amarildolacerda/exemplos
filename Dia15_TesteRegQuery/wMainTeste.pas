unit wMainTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.ExtCtrls, DBNav98, FireDAC.Comp.DataSet, FireDAC.Comp.Client, fireTables,
  db_STORE, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, QST_FINANCEIRO;

type
  TForm6 = class(TForm)
    JvDBGrid1: TJvDBGrid;
    ALQuery1: TALQuery;
    DataSource1: TDataSource;
    DBNav981: TDBNav98;
    StdRegQuery1: TStdRegQuery;
    procedure FormCreate(Sender: TObject);
    procedure StdRegQuery1AfterPost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure ALQuery1AfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.ALQuery1AfterPost(DataSet: TDataSet);
begin
  showmessage('QryAfterPost');
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  ConnectDataBaseFromIni('wbainterno', 'db', 'pdv.ini');
  ALQuery1.ActiveSqlUpdate('ctgrupo', 'grupo');
end;

procedure TForm6.FormShow(Sender: TObject);
begin

  ALQuery1.DataBaseName := 'db';
  StdRegQuery1.Query := ALQuery1;
  ALQuery1.Open;

end;

procedure TForm6.StdRegQuery1AfterPost(DataSet: TDataSet);
begin
  showmessage('RegAfterPost');
end;

end.
