unit Unit23;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm23 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form23: TForm23;

implementation

{$R *.dfm}

procedure TForm23.Button1Click(Sender: TObject);
var
  i: integer;
begin

  i := Random(100000);
  Memo1.Lines.Add(i.ToString);

end;

function somar5(value: integer): integer; forward;

procedure TForm23.Button2Click(Sender: TObject);
var
  i: integer;
begin
  i := somar5(1);

  while i < 500 do
  begin

    if i < 5 then
      continue;

    if i > 12 then
      break;

    inc(i);
  end;
end;

function CalcularDias: integer;
begin
  result := somar5(2);
end;

function somar5(value: integer): integer;
begin
  result := value + 5;
end;


var
  i: integer;


function DoubleTheValue(var value: integer): integer;
begin
  value := value * 2; // compiler error  Result := Value;
end;


function DoubleTheValue2(value: integer): integer;
begin
  value := value * 2; // compiler error  Result := Value;
end;


procedure TForm23.FormCreate(Sender: TObject);
begin
  Randomize;

  i := 5555;
  doubleTheValue(i);


  memo1.Lines.Add( i.ToString  );

end;

end.
