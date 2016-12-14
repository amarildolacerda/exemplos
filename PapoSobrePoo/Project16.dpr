program Project16;

uses
  Vcl.Forms,
  Unit36 in 'Unit36.pas' {Form36},
  System.Classes.Helper in 'C:\Fontes\Comum\System.Classes.Helper.pas',
  Unit37 in 'Unit37.pas',
  Unit38 in 'Unit38.pas',
  Unit39Interf in 'Unit39Interf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm36, Form36);
  Application.Run;
end.
