program Notify_Error_in_Threads;

uses
  Vcl.Forms,
  System.LogEvents in 'C:\fontes\Comum\System.LogEvents.pas',
  System.LogEvents.Progress in 'C:\fontes\Comum\System.LogEvents.Progress.pas' {ProgressEvents},
  Unit1 in '..\Dia24_ProgressParallel\Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
