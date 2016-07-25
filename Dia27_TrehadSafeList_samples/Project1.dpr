program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  Dia27_ThreadSafeLists in '..\Dia27_ThreadSafeLists.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
