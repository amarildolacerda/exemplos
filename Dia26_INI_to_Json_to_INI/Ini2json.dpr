program Ini2json;

uses
  Vcl.Forms,
  Unit8 in 'Unit8.pas' {Form8},
  System.IniFiles.Helper in 'C:\fontes\Comum\System.IniFiles.Helper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm8, Form8);
  Application.Run;
end.
