program ProjFiredacThreaded;

uses
  Vcl.Forms,
  uFiredacThreaded in 'uFiredacThreaded.pas' {Form43};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm43, Form43);
  Application.Run;
end.
