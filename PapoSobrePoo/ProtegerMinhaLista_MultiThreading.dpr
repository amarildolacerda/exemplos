program ProtegerMinhaLista_MultiThreading;

uses
  Vcl.Forms,
  uProtegerMinhaLista_MultiThreading in 'uProtegerMinhaLista_MultiThreading.pas' {Form43};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm43, Form43);
  Application.Run;
end.
