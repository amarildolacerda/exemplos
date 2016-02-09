unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw;

type
  TForm33 = class(TForm)
    Button1: TButton;
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure Teste(Sender: TObject; const Text: string);
  end;

var
  Form33: TForm33;

implementation

uses ScriptIntf, ScriptTools, mfunctions;

var
  FScript: TJavaScript;

{$R *.dfm}

procedure TForm33.Button1Click(Sender: TObject);
var
  LString: TStringList;
begin
  LString := TStringList.Create;
  try
    LString.LoadFromFile(SlashDirEx(AppDir) + 'teste.js');
    FScript.Terminate;
    FScript.Lines := LString;
    FScript.Execute;
  finally
    FreeAndNil(LString);
  end;
end;

procedure TForm33.FormCreate(Sender: TObject);
begin
  // Create our javascript engine
  WebBrowser1.Navigate(SlashDirEx(AppDir) + 'teste.html');

  FScript := TJavaScript.Create(Self);
  FScript.WindowHandle := Handle;
  FScript.AddScriptlet(CreateComponentScriptlet(Self, 'Form'));
  FScript.AddScriptlet(CreateHostDelphiScriptlet(Teste));

  Button1Click(Sender);
//  FScript.OnError := ScriptError;
//  FScript.OnEnter := ScriptEnter;
//  FScript.OnLeave := ScriptLeave;
//  FScript.OnQueryContinue := ScriptQueryContinue;

end;

procedure TForm33.Teste(Sender: TObject; const Text: string);
begin
  showmessage('Ok!!!');
end;

end.
