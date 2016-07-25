program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  unit_Samples in 'unit_Samples.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
