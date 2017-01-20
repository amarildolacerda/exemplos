unit app.main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  mvc.Interf,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  TAppMain = class(TForm, IView, IThis<TObject>)
  private
    { Private declarations }
    FController: IController;
  protected
    procedure SetController(const AController: IController);
    function This:TObject;

  public
    { Public declarations }
  end;

var
  AppMain: TAppMain;

implementation

{$R *.fmx}
{ TForm45 }

procedure TAppMain.SetController(const AController: IController);
begin
  FController := AController;
end;

function TAppMain.This: TObject;
begin
   result := self;
end;

end.
