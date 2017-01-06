program ProjListas;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFMXListas in 'uFMXListas.pas' {Form41};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm41, Form41);
  Application.Run;
end.
