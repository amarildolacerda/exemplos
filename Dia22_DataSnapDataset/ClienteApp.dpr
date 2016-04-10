program ClienteApp;

uses
  Vcl.Forms,
  Unit44 in 'Unit44.pas' {Form44};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm44, Form44);
  Application.Run;
end.
