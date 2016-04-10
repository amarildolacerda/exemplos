program Project38;

uses
  Vcl.Forms,
  Unit45 in 'Unit45.pas' {Form45},
  System.Classes.Helper in '..\..\Comum\System.Classes.Helper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm45, Form45);
  Application.Run;
end.
