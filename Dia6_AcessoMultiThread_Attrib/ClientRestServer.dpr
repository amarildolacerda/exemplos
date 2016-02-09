program ClientRestServer;

uses
  Forms,
  uClientRestServer in 'uClientRestServer.pas' {Form77};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm77, Form77);
  Application.Run;
end.
