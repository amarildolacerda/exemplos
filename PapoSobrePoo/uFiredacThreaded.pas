unit uFiredacThreaded;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, Data.DB, Vcl.ExtCtrls, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  Vcl.StdCtrls, FireDAC.Stan.Pool;

type
  TForm43 = class(TForm)
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Timer1: TTimer;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    Button1: TButton;
    FDConnection1: TFDConnection;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form43: TForm43;

implementation

{$R *.dfm}

uses System.Threading, System.Generics.collections;

type

  TFDMinhasConnections = class(TThreadList<TFDConnection>)
  public
    function Acquire(AConnectionName: string): TFDConnection;
    procedure Release(AConnection: TFDConnection);
  end;

var
  FConnectionManager: TFDMinhasConnections;

procedure TForm43.Button1Click(Sender: TObject);
begin

  TParallel.&For(1, 100,
    procedure(i: integer)
    var
      conn: TFDConnection;
    begin
      try
        conn := FConnectionManager.Acquire('SQLEstoque');
        try
          with TFDQuery.create(nil) do
            try
              // ConnectionName := 'SQLEstoque';
              connection := conn;
              sql.text :=
                'update ctgrupo set bmp=:bmp, comissao=:comissao where grupo=:grupo';
              paramByName('bmp').asString := DateTimeToStr(now);
              paramByName('grupo').asString := formatFloat('00', i);
              paramByName('comissao').AsInteger := i;
              execSql;

            finally
              free;
            end;
        finally
          FConnectionManager.Release(conn);
          // FDManager1.ReleaseConnection(conn);
        end;
      except
        // nao pode comer exceptions. - abra o olho.
      end;
    end);

end;

procedure TForm43.Timer1Timer(Sender: TObject);
begin
  tthread.Queue(nil,
    procedure
    var
      conn: TFDConnection;
    begin
      // conn := FDQuery1.connection;
      // FConnectionManager.Release(conn);
      try
        FDQuery1.Close;
        if FDQuery1.connection <> nil then
        begin
          conn := FConnectionManager.Acquire('SQLEstoque');
          FDQuery1.connection := conn;
        end;
        FDQuery1.sql.text := 'select bmp,comissao,grupo,nome from ctgrupo';
        FDQuery1.Open;
      finally
        // FConnectionManager.Release(conn);
      end;
    end);

  with FConnectionManager.LockList do
    try
      caption := count.ToString;
    finally
      FConnectionManager.UnlockList;
    end;

end;

{ TFDMinhasConnections }

function TFDMinhasConnections.Acquire(AConnectionName: string): TFDConnection;
begin
  result := TFDConnection.create(nil);
  add(result);
  result.ConnectionDefName := AConnectionName;
  result.LoginPrompt := false;
  result.Open;
end;

procedure TFDMinhasConnections.Release(AConnection: TFDConnection);
begin
  Remove(AConnection);
  AConnection.free;
end;

initialization

FConnectionManager := TFDMinhasConnections.create;

finalization

FConnectionManager.free;

end.
