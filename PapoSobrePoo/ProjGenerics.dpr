program ProjGenerics;

uses
  Vcl.Forms,
  uGenerics in 'uGenerics.pas' {Form41};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm41, Form41);
  Application.Run;
end.
