unit Unit25;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm25 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form25: TForm25;

implementation

{$R *.dfm}

uses System.DateUtils;

type
  TMyData = record
    data: TDatetime;
    function month: integer;
    function day:integer;
    constructor create(AData: TDatetime);
    procedure SomarDia( ADias:integer);
  end;

  TMinhaClass = class
  private
    Fidade: integer;
    function Getitems(idx: integer): string;
    procedure Setitems(idx: integer; const Value: string);
    procedure Setidade(const Value: integer);
  public
    property items[idx: integer]: string read Getitems write Setitems;
    property idade: integer read Fidade write Setidade;
  end;

type
  // T = array[1000..1024] of integer;

  TMeuArray = array [1 .. 24] of TMyData; // TValue

  TMeuArrayDinamico = array of integer;

  // TTask;


function Sum(const A: array of integer): integer;
var
  I: integer;
begin
  Result := 0;
  for I := Low(A) to High(A) do
    Result := Result + A[I];
end;


procedure TForm25.FormCreate(Sender: TObject);
var
  ma: TMeuArray;
  I: integer;
  m2: TMeuArrayDinamico;
begin

  //caption := sum([1,1,1,1]).ToString   ;



  // ma[1] := TMyData.create( date -30  );

  ma[1].data := date;
  ma[1].SomarDia(10);
  caption := ma[1].day.ToString;

  { ma[1] := 2222;
    for I := Low(ma) to  High(ma) do
    begin
    ma[I] := 1;
    end;

    ma[2] := 444;
  }

 (* SetLength(m2, 10);
  m2[0] := 1;

  caption := m2[0].ToString;
    *)
end;


{ TMinhaClass }

function TMinhaClass.Getitems(idx: integer): string;
begin

end;

procedure TMinhaClass.Setidade(const Value: integer);
begin
  Fidade := Value;
end;

procedure TMinhaClass.Setitems(idx: integer; const Value: string);
begin

end;

{ TMyData }

constructor TMyData.create(AData: TDatetime);
begin
  data := AData;
end;

function TMyData.day: integer;
begin
  Result := dayOf(Data);
end;

function TMyData.month: integer;
begin
  Result := monthOf(data);
end;

procedure TMyData.SomarDia(ADias: integer);
begin
   data := data + ADias;
end;

end.
