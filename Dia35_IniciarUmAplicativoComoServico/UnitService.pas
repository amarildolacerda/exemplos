unit UnitService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs;

type
  TAppService = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  AppService: TAppService;

implementation

{$R *.dfm}
uses UnitApp;

var LAppForm : TForm10;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  AppService.Controller(CtrlCode);
end;

function TAppService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TAppService.ServiceStart(Sender: TService; var Started: Boolean);
begin
    LAppForm := TForm10.create(nil);
    LAppForm.execute;
end;

procedure TAppService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
    LAppForm.free;
end;

end.
