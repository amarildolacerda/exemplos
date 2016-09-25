program ProjAppService;

uses
  Vcl.SvcMgr,
  uServiceApp,
  System.SysUtils,
  UnitApp,
  UnitService in 'UnitService.pas' {AppService: TService};

const
  NomeServico = 'AppService';

{$R *.RES}

begin

  { parametros
      /app  -> executa como aplicativo
      /install -> instala como serviço
      /uninstall -> desinstala o serviço
  }


  if IsServiceInstalled(NomeServico) and
    (not(FindCmdLineSwitch('app', ['-', '\', '/'], true))) then
  begin         // é serviço
    try
     if not Application.DelayInitialize or Application.Installing then
        Application.Initialize;
      Application.CreateForm(TAppService, AppService);
      AppService.name := NomeServico;
      Application.Run;
    finally
    end;
  end
  else
  begin       // é app
      Application.CreateForm(TForm10, Form10);
      form10.ShowModal;
  end;

end.
