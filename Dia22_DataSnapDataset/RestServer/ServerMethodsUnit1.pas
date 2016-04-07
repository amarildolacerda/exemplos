unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
  Data.FireDACJSONReflect,
  Datasnap.DSServer, Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin;

type
{$METHODINFO ON}
  TServerMethods1 = class(TDataModule)
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
  private
    { Private declarations }
  public
    { Public declarations }
    // original criado pelo DELPHI
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;

    // passa o codigo do cliente e retorna os dados do cliente
    function GetCliente(codigo: int64): TJSONValue;  // exemplo retornando um JSONObject
    function GetCliente2(codigo: int64): TFDJSONDataSets;  // usando Reflection

    // retorna na mesma resposta CLIENTE + ITENS
    function GetNotaFiscal(ANumero: integer): TFDJSONDataSets;

  end;
{$METHODINFO OFF}

implementation

{$R *.dfm}

uses System.StrUtils, FireDAC.ObjectDataSet, Data.db.helper;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;


type
  TClientes = class
  private
    FCodigo: int64;
    FNome: string;
    FCidade: string;
    FDebitos: double;
    FEndereco: string;
    FEstado: String;
    procedure SetCidade(const Value: string);
    procedure SetCodigo(const Value: int64);
    procedure SetDebitos(const Value: double);
    procedure SetEndereco(const Value: string);
    procedure SetEstado(const Value: String);
    procedure SetNome(const Value: string);
  public
    property codigo: int64 read FCodigo write SetCodigo;
    property Nome: string read FNome write SetNome;
    property Cidade: string read FCidade write SetCidade;
    property Estado: String read FEstado write SetEstado;
    property Endereco: string read FEndereco write SetEndereco;
    property Debitos: double read FDebitos write SetDebitos;
  end;

  TNotaFiscalItens = class
  private
    FPreco: double;
    FCodigo: string;
    FQtde: double;
    FNome: string;
    procedure SetCodigo(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetPreco(const Value: double);
    procedure SetQtde(const Value: double);
  public
    property codigo: string read FCodigo write SetCodigo;
    property Nome: string read FNome write SetNome;
    property Qtde: double read FQtde write SetQtde;
    property Preco: double read FPreco write SetPreco;
  end;

function TServerMethods1.GetCliente(codigo: int64): TJSONValue;
// TFDJSONDataSets;
var
  ds: TObjectDataSet;
  cli: TClientes;
begin
  // buscar os dados no banco de dados com codigo passado pelo cliente...

  // resposta para o cliente;

  // meus dados no firedac
  // usei um ObjectDataset somento para não precisar criar uma conexão e um query
  ds := TObjectDataSet.Create(self, TClientes);  // usa RTTI para mapear coluna do TDataset
  try
    ds.Open;
    ds.append;
    with ds do
    begin
      FieldByName('codigo').Value := 1;
      FieldByName('nome').Value := 'Embarcadero SA';
      FieldByName('Endereco').Value := 'Rua...xxxx...,10';
      FieldByName('Cidade').Value := 'Sao Paulo';
      FieldByName('Estado').Value := 'SP';
      FieldByName('Debitos').Value := 100000.12;
    end;
    ds.Post;

    // retorna um JsonObject
    Result := TJSONObject.ParseJSONValue(ds.ToJson);
  finally
    ds.Free;
  end;
end;


// retorna um objeto FireDAC JSON  Reflection
// isto estabelece uma boa integração entre aplicativos que usam FireDAC nos clientes.
// se o cliente não for FireDAC... talves seja interessante pensar em retornar um
//   formato mais generico

function TServerMethods1.GetCliente2(codigo: int64): TFDJSONDataSets;
var
  ds: TObjectDataSet;
  cli: TClientes;
begin
  // buscar os dados no banco de dados com codigo passado pelo cliente...

  // resposta para o cliente;
  Result := TFDJSONDataSets.Create;
  // meus dados no firedac
  // usei um ObjectDataset somento para não precisar criar uma conexão e um query
  ds := TObjectDataSet.Create(nil, TClientes);
  try
    ds.Open;
    ds.append;
    with ds do
    begin
      FieldByName('codigo').Value := 1;
      FieldByName('nome').Value := 'Embarcadero SA';
      FieldByName('Endereco').Value := 'Rua...xxxx...,10';
      FieldByName('Cidade').Value := 'Sao Paulo';
      FieldByName('Estado').Value := 'SP';
      FieldByName('Debitos').Value := 100000.12;
    end;
    ds.Post;

    TFDJSONDataSetsWriter.ListAdd(Result, 'CLIENTE', ds);
  finally
    // ds.Free;   -- eh destruido pelo Writer
  end;
end;


// retornando mais de uma tabala na mesma consulta
// retorna  CLIENTE  e ITENS da nota fiscal
function TServerMethods1.GetNotaFiscal(ANumero: integer): TFDJSONDataSets;
var
  ds: TObjectDataSet;
  cli: TClientes;
  dsItens: TObjectDataSet;
  itens: TNotaFiscalItens;
begin
  // buscar os dados no banco de dados com codigo passado pelo cliente...

  // resposta para o cliente;
  Result := TFDJSONDataSets.Create;
  // meus dados no firedac
  // usei um ObjectDataset somento para não precisar criar uma conexão e um query
  ds := TObjectDataSet.Create(nil, TClientes);
  try
    ds.Open;
    ds.append;
    with ds do
    begin
      FieldByName('codigo').Value := 1;
      FieldByName('nome').Value := 'Embarcadero SA';
      FieldByName('Endereco').Value := 'Rua...xxxx...,10';
      FieldByName('Cidade').Value := 'Sao Paulo';
      FieldByName('Estado').Value := 'SP';
      FieldByName('Debitos').Value := 100000.12;
    end;
    ds.Post;

    TFDJSONDataSetsWriter.ListAdd(Result, 'CLIENTE', ds);

    // usa RTTI para mapear o objeto para TFDMemTable
    dsItens := TObjectDataSet.Create(nil, TNotaFiscalItens);
    dsItens.Open;
    itens := TNotaFiscalItens.Create;
    with itens do
    begin
      codigo := '000001';
      Nome := 'Margarina';
      Qtde := 2;
      Preco := 8.5;
    end;
    dsItens.ObjectList.Add(itens);  // adiciona o objeto ao ObjectDataSet

    with itens do
    begin
      codigo := '000002';
      Nome := 'Pao Frances';
      Qtde := 1;
      Preco := 15;
    end;
    dsItens.ObjectList.Add(itens);

    TFDJSONDataSetsWriter.ListAdd(Result, 'ITENS', dsItens);

  finally
    // ds.Free;   -- eh destruido pelo Writer
  end;
end;


{ TClientes }

procedure TClientes.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TClientes.SetCodigo(const Value: int64);
begin
  FCodigo := Value;
end;

procedure TClientes.SetDebitos(const Value: double);
begin
  FDebitos := Value;
end;

procedure TClientes.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TClientes.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TClientes.SetNome(const Value: string);
begin
  FNome := Value;
end;

{ TNotaFiscalItens }

procedure TNotaFiscalItens.SetCodigo(const Value: string);
begin
  FCodigo := Value;
end;

procedure TNotaFiscalItens.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TNotaFiscalItens.SetPreco(const Value: double);
begin
  FPreco := Value;
end;

procedure TNotaFiscalItens.SetQtde(const Value: double);
begin
  FQtde := Value;
end;

end.
