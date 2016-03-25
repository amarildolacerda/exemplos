program Project28;

uses
  Vcl.Forms,
  Unit35 in 'Unit35.pas' {Form35},
  System.SysUtils.Helpers in 'C:\fontes\Comum\System.SysUtils.Helpers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm35, Form35);
  Application.Run;
end.
