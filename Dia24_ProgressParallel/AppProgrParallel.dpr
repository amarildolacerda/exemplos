program AppProgrParallel;

uses
  Vcl.Forms,
  Unit8 in 'Unit8.pas' {Form8},
  System.LogEvents in 'C:\fontes\Comum\System.LogEvents.pas',
  System.LogEvents.Progress in 'C:\fontes\Comum\System.LogEvents.Progress.pas' {ProgressEvents};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
