program Project17;

uses
  Vcl.Forms,
  Unit39 in 'Unit39.pas' {Form39};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm39, Form39);
  Application.Run;
end.
