unit mvc.ApplicationController;

interface

uses {$IFDEF FMX} FMX.Forms, {$ELSE} VCL.Forms, {$ENDIF} System.Classes,
  System.SysUtils, mvc.Interf;

type

  TApplicationController = class(TInterfacedObject, IApplicationController)
  public
    procedure Run(AClass: TComponentClass; var reference;
      AFunc: TFunc<boolean>);
    class function New: IApplicationController;
  end;

function ApplicationController: IApplicationController;

implementation

var
  FApplication: IApplicationController;

function ApplicationController: IApplicationController;
begin
  result := FApplication;
end;

{ TApplicationController }

class function TApplicationController.New: IApplicationController;
begin
  result := TApplicationController.Create;
end;

procedure TApplicationController.Run(AClass: TComponentClass; var reference;
  AFunc: TFunc<boolean>);
var
  rt: boolean;
begin
  application.Initialize;

  rt := true;
  if assigned(AFunc) then
    rt := AFunc;

  if rt then
  begin
    application.CreateForm(AClass, reference);
    application.Run;
  end;


end;

initialization

FApplication := TApplicationController.New;

end.
