program Proj_Task_TParallel;

uses
  Vcl.Forms,
  wProjExemplo in 'wProjExemplo.pas' {Form44},
  Threading in '..\..\dxe6\Threading.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm44, Form44);
  Application.Run;
end.
