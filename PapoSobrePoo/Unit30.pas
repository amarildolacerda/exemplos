unit Unit30;

interface

uses
  System.Classes;

//uses System.Classes;

type

// {$VARPROPSETTER ON}

  TCores = (cAzul, cAmarelo);

  TMinhaClasse = class
  private
    FNumero: integer;
    FItems:TStringList;
    FCores:TCores;
    FCor:  TCores;
    function GetNumero: integer;
    procedure SetNumero(const Value: integer);
    function GetItems(idx: integer): string;
    procedure SetItems(idx: integer; const Value: string);
    procedure SetCor(const Value: TCores);
    function GetCor: TCores;
  public
    constructor create;//override;
    destructor destroy;override;
    property Numero: integer read GetNumero write SetNumero;
    property Items[ idx:integer] :string read GetItems write SetItems;


  published
    property Cor:TCores read GetCor write SetCor stored cAmarelo;

  end;

implementation

{ TMinhaClasse }

constructor TMinhaClasse.create;
begin
  inherited;
  FCor := cAmarelo;
  FItems := TStringList.Create;
  FItems.Add('tstst');
end;

destructor TMinhaClasse.destroy;
begin
  FItems.Free;
  inherited;
end;

function TMinhaClasse.GetCor: TCores;
begin
    result := FCores;
end;

function TMinhaClasse.GetItems(idx: integer): string;
begin
   result := FItems[idx];
end;

function TMinhaClasse.GetNumero: integer;
begin
  Result := FNumero;
end;

procedure TMinhaClasse.SetCor(const Value: TCores);
begin
  FCor := Value;
end;

procedure TMinhaClasse.SetItems(idx: integer; const Value: string);
begin
    FItems[idx] := value;
end;

procedure TMinhaClasse.SetNumero(const Value: integer);
begin
  Value := Value +1;
  FNumero := Value;
end;

end.
