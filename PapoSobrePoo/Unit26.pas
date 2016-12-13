unit Unit26;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm26 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ExecuteAfterInit(sender:TObject);
  public
    { Public declarations }
  end;

  TBancoParaCarrosDePasseio = class;

  TCarroDePasseio = class
  private
    FBanco: TBancoParaCarrosDePasseio;
  public
    constructor create(AValor: boolean); virtual;
    procedure init; virtual;
  end;

  TCarroDePasseio1 = class(TCarroDePasseio)
  private
    FList: TStringList;
    FData: TDatetime;
    FBanco: TBancoParaCarrosDePasseio;
    FafterInit: TNotifyevent;
    function Getitems(idx: integer): string;
    procedure Setitems(idx: integer; const Value: string);
    procedure SetafterInit(const Value: TNotifyevent);
  public
    procedure init; override;
    constructor create(AValor: boolean); overload; override;
    constructor create(AValor: integer; AData: TDatetime); overload;
    property Banco: TBancoParaCarrosDePasseio read FBanco write FBanco;
    function count: integer;
    property items[idx: integer]: string read Getitems write Setitems;
    property afterInit: TNotifyevent read FafterInit write SetafterInit;
  end;

  TBancoParaCarrosDePasseio = class
  strict private
    FPrivate1: string;
  private type
    TPintura = class
      cor: integer;
      procedure initPintura;
    end;
  public
    procedure init;
  end;

var
  Form26: TForm26;

implementation

{$R *.dfm}

procedure TForm26.ExecuteAfterInit(sender: TObject);
begin
    showmessage('teste');
end;

procedure TForm26.FormCreate(Sender: TObject);
var
  btn, btn1: TButton;
var
  LPintura: TBancoParaCarrosDePasseio.TPintura;
begin

  LPintura := TBancoParaCarrosDePasseio.TPintura.create;
  try
    LPintura.cor := 111;
    caption := LPintura.cor.ToString;
  finally
    LPintura.Free;
  end;

  with TCarroDePasseio1.create(true) do
    try
      afterInit :=   ExecuteAfterInit;
      init;
    finally
      DisposeOf;
    end;

  btn := TButton.create(self);
  btn.Parent := Panel1;
  btn.caption := 'MeuBotao';
  // btn.Top := 10;
  // btn.Left := 10;

  btn1 := TButton.create(self);
  btn1.Parent := Panel1;
  btn1.caption := 'MeuBotao,,,,,,,,,,,,,';
  btn1.Left := 100;

  with TButton.create(self) do
  begin
    Parent := Panel1;
    Left := 100;
    top := 100;
    caption := 'botao com with';
  end;

end;

{ TBancoParaCarrosDePasseio }

procedure TBancoParaCarrosDePasseio.init;
var
  LPintura: TPintura;
begin
  // TPintura
end;

{ TCarroDePasseio }

constructor TCarroDePasseio.create(AValor: boolean);
begin

end;

procedure TCarroDePasseio.init;
begin
  // FBanco.FPrivate1 := 'asss';
end;

{ TCarroDePasseio1 }

constructor TCarroDePasseio1.create(AValor: boolean);
begin
  inherited create(AValor);
  // faz outra operaçcao.
end;

function TCarroDePasseio1.count: integer;
begin
  result := FList.count;
end;

constructor TCarroDePasseio1.create(AValor: integer; AData: TDatetime);
begin
  inherited create(false);
  FData := AData;
end;

function TCarroDePasseio1.Getitems(idx: integer): string;
begin
  result := FList[idx];
end;

procedure TCarroDePasseio1.init;
begin
  inherited;
  if assigned(afterInit) then
     afterInit(self);
end;

procedure TCarroDePasseio1.SetafterInit(const Value: TNotifyevent);
begin
  FafterInit := Value;
end;

procedure TCarroDePasseio1.Setitems(idx: integer; const Value: string);
begin
  FList[idx] := Value;
end;

{ TBancoParaCarrosDePasseio.TPintura }

procedure TBancoParaCarrosDePasseio.TPintura.initPintura;
begin

end;

end.
