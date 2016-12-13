unit Unit28;

interface


type

    TClasseTerceiros = class

    private
       function f2:integer;
    protected
       function f1:integer;
    public

    end;


implementation

{ TClasseTerceiros }

function TClasseTerceiros.f1: integer;
begin
    result := 1;
end;

function TClasseTerceiros.f2: integer;
begin
    result := 2;
end;

end.
