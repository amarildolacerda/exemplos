unit Unit31;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm31 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MensagemEvent(msg: string);
    procedure DoNotifyEvent( const msg:string);
  end;

var
  Form31: TForm31;

implementation

{$R *.dfm}

uses Unit32;

procedure TForm31.Button1Click(Sender: TObject);
begin
  with TForm32.Create(self) do
    try
      OnMensagem := DoNotifyEvent;
      Connection := self;

      showmodal;

    finally
      free;
    end;
end;

procedure TForm31.DoNotifyEvent( const msg:string);
begin
    mensagemEvent(msg);
end;

procedure TForm31.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  MensagemEvent('Down: ' + Key.ToString);
end;

procedure TForm31.FormKeyPress(Sender: TObject; var Key: Char);
begin
  MensagemEvent('Press: ' + Key);

end;

procedure TForm31.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  MensagemEvent('UP: ' + Key.ToString);

end;

procedure TForm31.MensagemEvent(msg: string);
begin
  Memo1.Lines.Add(msg);
end;

end.
