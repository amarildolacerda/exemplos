Unit Unit6;

Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, db_STORE, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids;

Type
  TForm6 = Class(TForm)
    Button1: TButton;
    ALQuery1: TALQuery;
    LabeledEdit1: TLabeledEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button2: TButton;
    Procedure FormCreate(Sender : TObject);
    Procedure Button1Click(Sender : TObject);
    Procedure BitBtn1Click(Sender : TObject);
    Procedure BitBtn2Click(Sender : TObject);
    procedure ALQuery1BeforeOpen(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
  Private
    FDatabasename: string;
    procedure SetDatabasename(const Value: string);
    { Private declarations }
  Public
    { Public declarations }
    property Databasename:string read FDatabasename write SetDatabasename;
  End;

Var
  Form6: TForm6;

Implementation

{$R *.dfm}
Uses iniFiles, mFunctions;

procedure TForm6.ALQuery1BeforeOpen(DataSet: TDataSet);
begin
   // exemplo como altera os parametros antes de abrir a tabela.
   // alquery1.DatabaseName := FDatabasename;
end;

Procedure TForm6.BitBtn1Click(Sender : TObject);
Begin
  With createQuery('Estoque', 'ctgrupo', 'grupo=:grupo') Do
    Try
      paramByName('grupo').asString := '001';
      open;
    Finally
      free;
    End;

  LabeledEdit1.text := intToStr(Session.DatabaseCount);

End;

Procedure TForm6.BitBtn2Click(Sender : TObject);
Var qry: TALQuery;
Begin
  qry := createQuery('Estoque', 'ctgrupo', 'grupo=:codigogrupo');
  Try
    qry.ActiveSqlUpdate('ctgrupo', 'grupo');  // cria links TUpdateSQL
    qry.paramByName('codigogrupo').asString := '001';  // inicia o parametro grupo
    qry.open;   // abre a tabela

    qry.edit; // abre o registor

    qry.FieldByName('nome').asString := 'TESTE '+DateTimeToStr(now);

        // antes do post;
    qry.StartTransaction; // inicia transacao
    Try
      qry.post; // envia o Update para o Banco
      qry.CommitTransaction; // commit na transaçao
    Except
      qry.RollBackTransaction;
    End;

  Finally
    qry.free;  // nao pode esquecer deste....
  End;


  ALQuery1.reopen;

End;

Procedure TForm6.Button1Click(Sender : TObject);
Var bd: TDatabase;
Begin


  // cria uma conexao para SQLEstoque com base na configuracao d Estoque.ini
  bd := ConnectDataBaseFromIni('SQLEstoque', 'Estoque', 'estoque.ini', True);

 // bd.Connected := true;  // nao precisa faze a conexao no codigo, o componente faz automatico.


  // cria uma conexao para SQLSupervisor.
  ConnectDatabaseFromIni('SQLSupervisor', 'Supervisor', 'supervisor.ini', False);


  // LEMBRETE...!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // se o banco for o mesmo para os dois alias,
  // a conexão podera ser reproveitada e os dois alias apontar para a mesma conexao;



  LabeledEdit1.text := intToStr(Session.DatabaseCount);

    // se precisar do Usuario / Senha do Banco de dados...

  okDlg('Usuario do BD: ' + DBLoginDoUsuario + ' Senha: ' + DBSenhaDoUsuario);





End;

procedure TForm6.Button2Click(Sender: TObject);
Var qry: TALQuery;
Begin
  qry := createQuery('Estoque', 'ctgrupo', 'grupo=:codigogrupo');
  Try
    //qry.AutoTransction := true;
    qry.ActiveSqlUpdate('ctgrupo', 'grupo');  // cria links TUpdateSQL
    qry.paramByName('codigogrupo').asString := '001';  // inicia o parametro grupo
    qry.open;   // abre a tabela

    qry.edit; // abre o registor

    qry.FieldByName('nome').asString := 'TESTE '+DateTimeToStr(now);

        // antes do post;
      qry.post; // envia o Update para o Banco

  Finally
    //qry.free;  // nao pode esquecer deste....
  End;


  //ALQuery1.reopen;


end;

Procedure TForm6.FormCreate(Sender : TObject);
Var ini: TIniFile;
  rt: String;
Begin


  databasename := 'Estoque';

  LabeledEdit1.text := intToStr(Session.DatabaseCount);


  // sem usar variavel
  With TIniFile.create('Supervisor.ini') Do
    Try
      rt := readString('Config', 'Usuario', '');

    Finally
      free;   // nao pode esquecer de liberar a memoria (jamais)
    End;



  // inicializando objeto com uma variavel associado
  ini := TIniFile.create('estoque.ini');
  Try
    rt := ini.readString('Config', 'Usuario', '');


  Finally
    freeAndNil(ini);
    ini := Nil;  // corrige bug no delphi 2007 que nao poe NIL usando FreeAndNil
  End;



  // uso misto de variavel e acesso de memoria direto
  ini := TIniFile.create('estoque.ini');
  With ini Do
    Try
      rt := readString('Config', 'Usuario', '');


    Finally
      free;
      ini := Nil;
    End;




End;

procedure TForm6.SetDatabasename(const Value: string);
begin
  FDatabasename := Value;

  // troca os Databasename de todos dos TQuery que estao no FORM (desiging)
  DataBaseNameChange(self,value);
end;

End.

