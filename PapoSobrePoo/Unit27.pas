unit Unit27;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm27 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form27: TForm27;

implementation

{$R *.dfm}

uses Unit28;

type

  TClasseTerceiroHack = class(TClasseTerceiros)
  public
  end;

  TClasseTerceiroHelper = class helper for TClasseTerceiros
  public
    function f3: integer;
  end;

procedure TForm27.FormCreate(Sender: TObject);
var
  ct: TObject;
  f: Double;
  i: integer;
begin
  { ct := TClasseTerceiroHack.Create;

    if ct is TClasseTerceiros then
    begin
    caption :=  (ct as TClasseTerceiroHack).f3.ToString;
    end;

  }
  try

    try
    i := 0;
    caption := 'semerro';

    if i = 0 then
      raise Exception.Create('I nao pode ser zero');

    f := 10 / i;

    caption := f.ToString;

    finally
      caption := 'xxxxx';
    end;

  except
    on e: Exception do
    begin
      // logar em arquivo
      // DebugLog(e.message);
      caption := e.message;
      raise;
    end;
  end;

end;

{ TClasseTerceiroHack }

function TClasseTerceiroHelper.f3: integer;
begin
  result := 3;
end;

end.
