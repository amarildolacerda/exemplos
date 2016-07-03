unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Memo2: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FRegistrou: boolean;
  public
    { Public declarations }
    procedure DoErro(Sender: TObject; msg: string);
    procedure DoSucesso(Sender: TObject; msg: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses System.LogEvents, System.Threading;

procedure TForm1.Button1Click(Sender: TObject);
var
  i: integer;
begin
  if not FRegistrou then
  begin
    // separa os tipos de mensagens que ira receber
    // se registra (subscriber) para receber ERROS  ( LOGs )
    LogEvents.register(self, DoErro, 0); // recebe os registro de ERROS
    // se registra para receber eventos de sucesso
    LogEvents.register(self, DoSucesso, 1); // registra para receber os sucessos
    FRegistrou := true;
  end;

  for i := 1 to 100 do
    TTask.create(
      procedure
      var
        n: integer;
      begin
        n := Random(10000);
        if n < 5000 then
          LogEvents.Log('Erro exemplo ' + intToStr(n))
          // use como padrão mensagem IDENTIFICADO = 0
        else
          LogEvents.DoMsg(nil, 1, 'LOG.....' + intToStr(n));
        // separar as mensagens de sucesso   (IDENTIFICADO=1)
      end).start;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  // retira o registro de recebimento de mensagem.
  LogEvents.unregister(self);
end;



procedure TForm1.Button2Click(Sender: TObject);
begin
  if not FRegistrou then
  begin
    // separa os tipos de mensagens que ira receber
    // se registra (subscriber) para receber ERROS  ( LOGs )
    LogEvents.register(self, DoErro, 0); // recebe os registro de ERROS
    // se registra para receber eventos de sucesso
    LogEvents.register(self, DoSucesso, 1); // registra para receber os sucessos
    FRegistrou := true;
  end;

  // usado metodo ANONIMOS para tratar exception internamente
  LogEvents.Run(
  procedure begin
       // força um exception
       raise Exception.Create('Error Message');
  end);


end;

procedure TForm1.DoErro(Sender: TObject; msg: string);
begin
  Memo1.lines.add(msg);
end;

procedure TForm1.DoSucesso(Sender: TObject; msg: string);
begin
  Memo2.lines.add(msg);
end;


end.
