unit Unit32;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type

  TMensagemEvent =  procedure(const msg:string) of object;

  TForm32 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
  private
    FConnection: TObject;
    FOnMensagem: TMensagemEvent;
    procedure SetConnection(const Value: TObject);
    procedure SetOnMensagem(const Value: TMensagemEvent);
    { Private declarations }
  public
    { Public declarations }
    property Connection:TObject read FConnection write SetConnection;
    property OnMensagem: TMensagemEvent read FOnMensagem write SetOnMensagem;
  end;

{var
  Form32: TForm32;
}


implementation

{$R *.dfm}

procedure TForm32.Button1Click(Sender: TObject);
begin
    FOnMensagem('click');
end;

procedure TForm32.FormCreate(Sender: TObject);
begin
   // FOnMensagem('onFormCreate');

end;

procedure TForm32.FormResize(Sender: TObject);
begin
  caption := self.Width.ToString;
end;

procedure TForm32.FormShow(Sender: TObject);
begin
    if not assigned(FConnection) then
        FOnMensagem('esqueceu de inicializar a conexão');
    FOnMensagem('onShow: '+FConnection.ClassName);

end;

procedure TForm32.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
   FOnMensagem(key);
end;

procedure TForm32.SetConnection(const Value: TObject);
begin
  FConnection := Value;
end;

procedure TForm32.SetOnMensagem(const Value: TMensagemEvent);
begin
  FOnMensagem := Value;
end;

end.
