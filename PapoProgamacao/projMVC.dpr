program projMVC;

uses
  System.StartUpCopy,
  FMX.Forms,
  app.main in 'View\app.main.pas' {AppMain} ,
  mvc.Controller in 'Struct\mvc.Controller.pas',
  mvc.Interf in 'Struct\mvc.Interf.pas',
  mvc.Model in 'Struct\mvc.Model.pas',
  mvc.ApplicationController in 'Struct\mvc.ApplicationController.pas';

{$R *.res}

begin
  ApplicationController.Run(TAppMain, AppMain,
    function: boolean
    begin
       result := true;
    end);

end.
