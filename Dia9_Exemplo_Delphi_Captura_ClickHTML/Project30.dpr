program Project30;

uses
  Forms,
  ct1 in 'ct1.pas' {Form1},
  uCapturaClickEvent in '..\..\Integracao_HTML\uCapturaClickEvent.pas',
  frBrowser_EventClick in '..\..\Comum_Frames\frBrowser_EventClick.pas' {Browser_ClickEvent1: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
