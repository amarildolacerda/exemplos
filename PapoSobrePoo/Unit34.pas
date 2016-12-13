unit Unit34;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCalendars,
  mongo.Anniversary.CalendarView, mongo.VCL.MongoEdit, mongo.VCL.Actions,
  System.Actions, Vcl.ActnList, mongo.Query, mongo.Conexao, Vcl.ExtCtrls;

type
  TForm34 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    MongoConexao1: TMongoConexao;
    MongoQuery1: TMongoQuery;
    ActionList1: TActionList;
    MongoInsert1: TVCLMongoInsert;
    MongoUpdate1: TVCLMongoUpdate;
    MongoLimpar1: TVCLMongoLimpar;
    MongoEdit1: TMongoEdit;
    MongoEdit2: TMongoEdit;
    MongoCalendarView1: TMongoCalendarView;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form34: TForm34;

implementation

{$R *.dfm}

Uses plugin.interf, plugin.MenuItem, plugin.Service;

procedure TForm34.Button1Click(Sender: TObject);
begin
   MongoInsert1.ExecuteTarget(nil);
end;

procedure TForm34.Button2Click(Sender: TObject);
begin
  MongoUpdate1.ExecuteTarget(nil);
end;

initialization
    RegisterPlugin(  TPluginMenuItemService.Create(TForm34,'itemMenuItem',1,'Cadastro do Mongo'  )    );

end.
