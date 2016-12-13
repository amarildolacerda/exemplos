program Project13;

uses
  Vcl.Forms,
  Unit33 in 'Unit33.pas' {Form33};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm33, Form33);
  Application.Run;
end.
