program prjJava;

uses
  Forms,
  uMain in 'uMain.pas' {Form33},
  ScriptIntf in '..\..\Integracao_HTML\JavaScript\ScriptIntf.pas',
  ScriptTools in '..\..\Integracao_HTML\JavaScript\ScriptTools.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm33, Form33);
  Application.Run;
end.
