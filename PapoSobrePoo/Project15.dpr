program Project15;

uses
  Vcl.Forms,
  Unit35 in 'Unit35.pas' {Form35};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm35, Form35);
  Application.Run;
end.
