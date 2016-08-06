unit uZeroConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  storeware.idZeroConf, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FClient: TIdZeroConfClient;
  public
    { Public declarations }
    procedure DoReceberDados(Sender: TObject; AMessage: String);
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses IdStack;

procedure TForm4.Button1Click(Sender: TObject);
begin
  if not FClient.active then
    FClient.active := true;
  Memo1.Lines.Add('Envia comando de procurar servidor ('+FormatdateTime('hh:mm:ss',now)+')');
  FClient.BroadcastIP := '192.168.56.1';
  FClient.Send;
end;

procedure TForm4.DoReceberDados(Sender: TObject; AMessage: String);
begin
  Memo1.Lines.Add('Resposta('+FormatdateTime('hh:mm:ss',now)+'):'+AMessage);
  Memo1.Lines.Add('');
end;

procedure TForm4.FormCreate(Sender: TObject);
begin

  // incia o cliente
  FClient := TIdZeroConfClient.create(self);
  FClient.OnResponseEvent := DoReceberDados;

end;

end.
