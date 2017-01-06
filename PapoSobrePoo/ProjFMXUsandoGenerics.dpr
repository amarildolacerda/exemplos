program ProjFMXUsandoGenerics;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFMXUsandoGenerics in 'uFMXUsandoGenerics.pas' {Form41};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm41, Form41);
  Application.Run;
end.
