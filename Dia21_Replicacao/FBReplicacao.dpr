program FBReplicacao;

uses
  Vcl.Forms,
  uFBFormReplicacao in 'uFBFormReplicacao.pas' {Form41};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm41, Form41);
  Application.Run;
end.
