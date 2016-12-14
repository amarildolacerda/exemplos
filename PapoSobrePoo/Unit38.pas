unit Unit38;

interface

uses Unit39Interf;

Type

  TMinhaClasse38 = class(TInterfacedObject, IMinhaInterface)
  private
    FCaption: string;
    procedure SetCaption(const Value: string);
    function GetCaption: string;
    function _RefCount:integer;
  public
    property Caption: string read GetCaption write SetCaption;
  end;

implementation

{ TMinhaClasse38 }

function TMinhaClasse38.GetCaption: string;
begin
   result := FCaption;
end;

procedure TMinhaClasse38.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

function TMinhaClasse38._RefCount: integer;
begin

end;

end.
