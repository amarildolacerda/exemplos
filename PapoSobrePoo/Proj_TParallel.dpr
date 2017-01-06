program Proj_TParallel;

uses
  Vcl.Forms,
  uProj_TParallel in 'uProj_TParallel.pas' {Form43};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm43, Form43);
  Application.Run;
end.
