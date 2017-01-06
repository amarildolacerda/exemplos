unit uProj_TParallel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm43 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure msg(texto: string);
  end;

var
  Form43: TForm43;

implementation

{$R *.dfm}

uses System.threading, System.Diagnostics;

procedure TForm43.Button1Click(Sender: TObject);
var
  st: TStopwatch;
begin

  st := TStopwatch.StartNew;
  st.Start;
  TParallel.For(1, 100,
    procedure(I: Integer)
    begin
      msg(datetimeToStr(now) + '-' + I.ToString);
      sleep(100);
      if I = 100 then
      begin
        st.Stop;
        msg('fim: ' + st.ElapsedMilliseconds.ToString);
      end;
    end);

  msg('Iniciou: ' + st.ElapsedMilliseconds.ToString);

end;

procedure TForm43.msg(texto: string);
begin
  TThread.Queue(nil,
    procedure
    begin
      Memo1.Lines.Add(texto);
    end);
end;

end.
