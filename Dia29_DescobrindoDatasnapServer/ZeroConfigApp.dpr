program ZeroConfigApp;

uses
  Vcl.Forms,
  uZeroConfig in 'uZeroConfig.pas' {Form4};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
