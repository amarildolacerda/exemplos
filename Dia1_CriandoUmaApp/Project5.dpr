program Project5;

uses
  Forms,
  db_store,
  Unit6 in 'Unit6.pas';

{$R *.res}

begin
  Application.Initialize;


  ConnectDataBaseFromIni('SQLEstoque','Estoque','estoque.ini',true);


  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TForm6, Form6);
  Form6.Databasename := 'Estoque';


  Application.Run;
end.
