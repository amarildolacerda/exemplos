unit Unit44;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IPPeerClient,
  REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.FMTBcd, Data.SqlExpr, Vcl.Grids, Vcl.DBGrids, REST.Social, REST.FDSocial,
  Social.Dropbox, Vcl.Buttons;

type
  TForm44 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    RESTSocialClientDataset1: TRESTSocialClientDataset;
    SpeedButton1: TSpeedButton;
    FDMemTable1: TFDMemTable;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    FDMemTable2: TFDMemTable;
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form44: TForm44;

implementation

{$R *.dfm}
uses Data.DB.Helper, System.uJson;

procedure TForm44.Button1Click(Sender: TObject);
var restCli:TRESTSocialClientDataset;
begin
   // criando no codigo
   restCli := TRESTSocialClientDataset.Create(nil);
   // endereço http do servidor
   restCli.BaseURL := 'http://localhost:8080';
   // caminho base de acesso ao servico
   restCli.Resource := '/datasnap/rest/TServerMethods1/GetCliente/{cnpj}';
   // nome e parametros do serviço
   // identificação da resposta
   restCli.RootElement := 'result.cliente';
   restCli.Get();
   memo1.Lines.text := restCli.ResponseText;
   DataSource1.DataSet := restCli.DataSet;

end;

procedure TForm44.SpeedButton1Click(Sender: TObject);
begin
   RESTSocialClientDataset1.Execute;
   Memo1.Lines.add( RESTSocialClientDataset1.ResponseText );
   DataSource1.DataSet := RESTSocialClientDataset1.DataSet;


   RESTSocialClientDataset1.WriteToDataset('result.adicional',FDMemTable2);
   DataSource2.DataSet := FDMemTable2;

end;

end.
