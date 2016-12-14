unit Unit37;

interface

uses Unit39Interf;

Type

  TMinhaClasse37 = class(TInterfacedObject, IMinhaInterface)
  private
    Fcaption: string;
    procedure Setcaption(const Value: string);
    function getCaption: string;
    function _RefCount:integer;
  public
    property caption: string read getcaption write Setcaption;
  end;

implementation

{ TMinhaClasse37 }

function TMinhaClasse37.getcaption: string;
begin
  result := Fcaption;
end;

procedure TMinhaClasse37.Setcaption(const Value: string);
begin
  Fcaption := Value;
end;

function TMinhaClasse37._RefCount: integer;
begin

end;

end.
