unit uJanelaProgressMutilThreading;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  System.LogEvents.Progress,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm43 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure LogProgressEvent(Sender: TObject; ATipo: TLogEventType;
      msg: string; APosition: double);

  public
    { Public declarations }
  end;

var
  Form43: TForm43;

implementation

{$R *.dfm}

Uses System.LogEvents, System.Threading;

procedure TForm43.Button1Click(Sender: TObject);
var
  n: integer;
  i: integer;
  j:integer;
begin
  j := 0;
  for i := 0 to 1000 do
  begin
    TTask.create(
      procedure
      begin
        n := random(1000);
        LogEvents.DoProgress(self, 0, etPreparing, 'Iniciado');
        TThread.Sleep(n);

        inc(j);
        LogEvents.DoProgress(self, 0, etFinished, 'Terminei '+j.ToString + 'I: '+i.ToString  );

      end).start;
  end;

end;

procedure TForm43.FormCreate(Sender: TObject);
begin
  LogEvents.register(self, LogProgressEvent, 0);

  LogEvents.DoProgress(self, 0, etCreating, 'Iniciado');
end;

procedure TForm43.LogProgressEvent(Sender: TObject; ATipo: TLogEventType;
msg: string; APosition: double);
//var n:double;
begin

   try
   // n := 9999 / 0;
    raise Exception.Create('Error Message');
    Memo1.lines.Add(msg);
   except
    on e:exception do
      memo1.Lines.Add(e.message);
   end;

end;

end.
