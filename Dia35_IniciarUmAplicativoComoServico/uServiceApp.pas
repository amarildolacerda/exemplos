{ *************************************************************************** }
{ }
{ Este código é um coletânea obtida no google sem autor definido              }
{ Alguns ponto foram alterados para atender a necessidade                     }
{ }
{ Amarildo Lacerda                                                            }
{ }
{ }
{ *************************************************************************** }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{ http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{ }
{ *************************************************************************** }

unit uServiceApp;

interface

uses
  Forms,Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr,
  WinSvc, Dialogs;


function IsServiceInstalled(DisplayName: string): Boolean;
function RestartServiceApp(Server: String; ServiceName: String): Boolean;
function StartServiceApp(Server: String; ServiceName: String): Boolean;
function ServiceGetStatusApp(sMachine, sService: string): integer;
// function ServiceDependenciesApp(Server: String; ServiceName: string): string;
// function ServiceStartNameApp(Server: String; ServiceName: string): string;
// function ServiceFileNameApp(Server: String; ServiceName: string): string;
// function QueryServiceConfigApp(Server: String; ServiceName: string; out MemToFree: integer): PQueryServiceConfig;
function QueryServiceStateApp(Server: String; ServiceName: String): integer;
function StopServiceApp(Server: String; ServiceName: String): Boolean;
function IsApplication: Boolean;
function FindSwitch(const Switch: string): Boolean;


var
  isRunningAsService: Boolean;

implementation

{ TServiceApp }
uses Registry;

function ServiceGetStatusApp(sMachine, sService: string): integer;
var
  //
  // service control
  // manager handle
  schm,
  //
  // service handle
  schs: SC_Handle;
  //
  // service status
  ss: TServiceStatus;
  //
  // current service status
  dwStat: Integer;
begin
  dwStat := -1;

  // connect to the service
  // control manager
  schm := OpenSCManager(PChar(sMachine), Nil, SC_MANAGER_CONNECT);

  // if successful...
  if (schm > 0) then
  begin
    // open a handle to
    // the specified service
    schs := OpenService(schm, PChar(sService),
      // we want to
      // query service status
      SERVICE_QUERY_STATUS);

    // if successful...
    if (schs > 0) then
    begin
      // retrieve the current status
      // of the specified service
      if (QueryServiceStatus(schs, ss)) then
      begin
        dwStat := ss.dwCurrentState;
      end;

      // close service handle
      CloseServiceHandle(schs);
    end;

    // close service control
    // manager handle
    CloseServiceHandle(schm);
  end;

  Result := dwStat;
end;

function GetLastErrorStr: string;
begin
  Result := IntToStr(GetLastError);
end;

function RestartServiceApp(Server: String; ServiceName: String): Boolean;
var n:integer;
begin
  n:= 0;
  result := false;
  while QueryServiceStateApp(Server, ServiceName) = SERVICE_START_PENDING do
  begin
    inc(n);
    if n>100 then begin
      result := false;
      exit;
    end;
    Sleep(1000);
  end;
  if QueryServiceStateApp(Server, ServiceName) = SERVICE_RUNNING then
    Result := StopServiceApp(Server, ServiceName);
  while QueryServiceStateApp(Server, ServiceName) = SERVICE_STOP_PENDING do
  begin
    inc(n);
    if n>30 then begin
      result := false;
      exit;
    end;
    Sleep(1000);
  end;
  if QueryServiceStateApp(Server, ServiceName) = SERVICE_STOPPED then
    Result := StartServiceApp(Server, ServiceName);
end;

function StartServiceApp(Server: String; ServiceName: String): Boolean;
var
  SCH: SC_Handle;
  SvcSCH: SC_Handle;
  Arg: PChar;
  n: Integer;
begin
  Result := False;
  for n := 1 to length(ServiceName) do
    if ServiceName[n] = ' ' then
      ServiceName[n] := '_';

  try
    SCH := OpenSCManager(PChar(Server), nil, SC_MANAGER_ALL_ACCESS);
    try
      if SCH = 0 then
      begin
        Raise Exception.Create('StartService OpenSCManager failed: ' +
          GetLastErrorStr);
        Exit;
      end;

      SvcSCH := OpenService(SCH, PChar(ServiceName), SERVICE_ALL_ACCESS);
      if SvcSCH = 0 then
      begin
        Raise Exception.Create('StartService OpenService failed: ' +
          GetLastErrorStr);
        Exit;
      end;

      try
        Arg := nil;
        if not WinSvc.StartService(SvcSCH, 0, Arg) then
        begin
          Raise Exception.Create('StartService failed: ' + GetLastErrorStr);
          Exit;
        end;

        Result := True;
      finally
        CloseServiceHandle(SvcSCH);
      end;
    finally
      CloseServiceHandle(SCH);
    end;
  finally
  end;
end;

function StopServiceApp(Server: String; ServiceName: String): Boolean;
var
  SCH: SC_Handle;
  SvcSCH: SC_Handle;
  ss: TServiceStatus;
begin
  Result := False;
  try
    SCH := OpenSCManager(PChar(Server), nil, SC_MANAGER_ALL_ACCESS);
    try
      if SCH = 0 then
      begin
        Raise Exception.Create('StopService OpenSCManager failed: ' +
          GetLastErrorStr);
        Exit;
      end;

      SvcSCH := OpenService(SCH, PChar(ServiceName), SERVICE_ALL_ACCESS);
      if SvcSCH = 0 then
      begin
        Raise Exception.Create('StopService OpenService failed: ' +
          GetLastErrorStr);
        Exit;
      end;

      try
        if not WinSvc.ControlService(SvcSCH, SERVICE_CONTROL_STOP, ss) then
        begin
          Raise Exception.Create('StopService failed: ' + GetLastErrorStr);
          Exit;
        end;

        Result := True;
      finally
        CloseServiceHandle(SvcSCH);
      end;
    finally
      CloseServiceHandle(SCH);
    end;
  finally
  end;
end;

{ SERVICE_STOPPED           : 'The service is not running.';
  SERVICE_START_PENDING     : 'The service is starting.';
  SERVICE_STOP_PENDING      : 'The service is stopping.';
  SERVICE_RUNNING           : 'The service is running.';
  SERVICE_CONTINUE_PENDING  : 'The service continue is pending.';
  SERVICE_PAUSE_PENDING     : 'The service pause is pending.';
  SERVICE_PAUSED            : 'The service is paused.';
  else
  'The service state is unknown';
}

function QueryServiceStateApp(Server: String; ServiceName: String): integer;
var
  SCH: SC_Handle;
  SvcSCH: SC_Handle;
  ss: TServiceStatus;
begin
  Result := 0;
  try
    SCH := OpenSCManager(PChar(Server), nil, SC_MANAGER_ALL_ACCESS);
    try
      if SCH = 0 then
      begin
        //Raise Exception.Create('QueryServiceStatus OpenSCManager failed: ' +
        //  GetLastErrorStr);
        Exit;
      end;

      SvcSCH := OpenService(SCH, PChar(ServiceName), SERVICE_ALL_ACCESS);
      if SvcSCH = 0 then
      begin
        Raise Exception.Create('QueryServiceStatus OpenService failed: ' +
          GetLastErrorStr);
        Exit;
      end;

      try
        if not WinSvc.QueryServiceStatus(SvcSCH, ss) then
        begin
          Raise Exception.Create('QueryServiceStatus failed: ' +
            GetLastErrorStr);
          Exit;
        end;

        Result := ss.dwCurrentState;
      finally
        CloseServiceHandle(SvcSCH);
      end;
    finally
      CloseServiceHandle(SCH);
    end;
  finally
  end;
end;

(*
  function QueryServiceConfigApp(Server: String; ServiceName: string; out MemToFree: integer): PQueryServiceConfig;
  var
  ServiceConfig: PQueryServiceConfig;
  R: DWORD;
  SCH   : SC_HANDLE;
  SvcSCH: SC_HANDLE;
  begin
  Result    := nil;
  MemToFree := 0;
  try
  SCH := OpenSCManager(PChar(Server), nil, SC_MANAGER_ALL_ACCESS);
  try
  if SCH = 0 then
  begin
  Raise Exception.Create('QueryServiceConfig OpenSCManager failed: ' + GetLastErrorStr);
  Exit;
  end;

  SvcSCH := OpenService(SCH, PChar(ServiceName), SERVICE_ALL_ACCESS);
  if SvcSCH = 0 then
  begin
  Raise Exception.Create('QueryServiceConfig OpenService failed: ' + GetLastErrorStr);
  Exit;
  end;

  try
  WinSvc.QueryServiceConfig(SvcSCH, nil, 0, R); // Get Buffer Length
  GetMem(ServiceConfig, R + 1);
  MemToFree := R + 1;
  try
  if not WinSvc.QueryServiceConfig(SvcSCH, ServiceConfig, R + 1, R) then // Get Buffer Length
  begin
  Raise Exception.Create('QueryServiceConfig failed: ' + GetLastErrorStr);
  Exit;
  end;
  Result := ServiceConfig;
  finally
  // Do this in calling function !!
  //          FreeMem(ServiceConfig);
  end;
  finally
  CloseServiceHandle(SvcSCH);
  end;
  finally
  CloseServiceHandle(SCH);
  end;
  finally
  end;
  end;
*)

(* function ServiceFileNameApp(Server: String; ServiceName: string): string;
  var
  ServiceConfig: PQueryServiceConfig;
  iMemToFree: integer;
  begin
  Result := '';
  try
  try
  ServiceConfig := QueryServiceConfig(Server, ServiceName, iMemToFree);
  Result := ServiceConfig.lpBinaryPathName;
  FreeMem(ServiceConfig, iMemToFree);
  except
  on E: Exception do
  raise Exception.Create('ServiceFileName failed: ' + E.Message);
  end;
  finally
  end;
  end;
*)

(*
  function ServiceStartNameApp(Server: String; ServiceName: string): string;
  var
  ServiceConfig: PQueryServiceConfig;
  iMemToFree: integer;
  begin
  Result := '';
  try
  try
  ServiceConfig := QueryServiceConfig(Server, ServiceName, iMemToFree);
  Result := ServiceConfig.lpServiceStartName;
  FreeMem(ServiceConfig, iMemToFree);
  except
  on E: Exception do
  raise Exception.Create('ServiceStartName failed: ' + E.Message);
  end;
  finally
  end;
  end;
*)

(*
  function ServiceDependenciesApp(Server: String; ServiceName: string): string;
  var
  ServiceConfig: PQueryServiceConfigA;
  DepList : PChar;
  Dep     : string;
  iMemToFree: integer;
  begin
  Result  := '';
  try
  try
  ServiceConfig := QueryServiceConfig(Server, ServiceName, iMemToFree);
  DepList := ServiceConfig.lpDependencies;
  if Assigned(DepList) then
  begin
  while DepList[0] <> #0 do
  begin
  Dep := DepList;

  if Result <> '' then
  Result := Result + ',';
  Result := Result + Dep;
  Inc(DepList, StrLen(DepList) + 1)
  end;
  end;
  FreeMem(ServiceConfig, iMemToFree);
  except
  on E: Exception do
  raise Exception.Create('ServiceDependencies failed: ' + E.Message);
  end;
  finally
  end;
  end;
*)
function ServiceGetStatus(sMachine, sService: string): dWord;
begin
  Result := QueryServiceStateApp(sMachine, sService);
end;
(*
  function ServiceGetStatus(sMachine, sService: string): dWord;
  var
  //
  // service control
  // manager handle
  schm,
  //
  // service handle
  schs: SC_Handle;
  //
  // service status
  ss: TServiceStatus;
  //
  // current service status
  dwStat: Integer;
  begin
  dwStat := -1;

  // connect to the service
  // control manager
  schm := OpenSCManager(PChar(sMachine), Nil, SC_MANAGER_CONNECT);

  // if successful...
  if (schm > 0) then
  begin
  // open a handle to
  // the specified service
  schs := OpenService(schm, PChar(sService),
  // we want to
  // query service status
  SERVICE_QUERY_STATUS);

  // if successful...
  if (schs > 0) then
  begin
  // retrieve the current status
  // of the specified service
  if (QueryServiceStatus(schs, ss)) then
  begin
  dwStat := ss.dwCurrentState;
  end;

  // close service handle
  CloseServiceHandle(schs);
  end;

  // close service control
  // manager handle
  CloseServiceHandle(schm);
  end;

  result := dwStat;
  end;
*)

function IsApplication: Boolean;
begin
  Result := (((FindCmdLineSwitch('standalone', ['-', '\', '/'], True))) or
    ((FindCmdLineSwitch('app', ['-', '\', '/'], True))));

  if (FindCmdLineSwitch('?', ['-', '\', '/'], True)) or
    (FindCmdLineSwitch('help', ['-', '\', '/'], True)) then
  begin
    raise Exception.Create('Opções'#13#10 +
      '/install   -   Instala o aplicativo como serviço windows' + #13 + #10 +
      '/uninstall -   Desinstala o aplicativo da lista de serviços' + #13 + #10
      + '/start     -   Iniciliza serviço' + #13 + #10 +
      '/stop      -   Para execução do serviço' + #13 + #10 +
      '/restart     -   Iniciliza serviço' + #13 + #10 +
      '/config    -   Abre janela de configuração do aplicativo' + #13 + #10 +
      '/app       -   Executa como Aplicativo (para serviço antes de ativar como app)'
      + #13 + #10 + '/?         -   Mostra lista de parametros');
  end

end;

function IsServiceInstalled(DisplayName: string): Boolean;
var
  // Mgr, Svc: Integer;
  // UserName, ServiceStartName: string;
  // Config: Pointer;
  // Size: dWord;
  n: Integer;
  FServiceName: String;
begin

  // if DisplayName <> '' then
  FServiceName := DisplayName;

  for n := 1 to length(FServiceName) do
    if FServiceName[n] = ' ' then
      FServiceName[n] := '_';

  Result := FindCmdLineSwitch('install', ['-', '\', '/'], True) or
    FindCmdLineSwitch('uninstall', ['-', '\', '/'], True) or
    FindCmdLineSwitch('start', ['-', '\', '/'], True) or
    FindCmdLineSwitch('restart', ['-', '\', '/'], True) or
    FindCmdLineSwitch('stop', ['-', '\', '/'], True);

  if Result then
  begin
    Exit;
  end;

  try
  Result := ServiceGetStatus('', FServiceName) > 0;
  except
     result := false;
  end;

end;


function FindSwitch(const Switch: string): Boolean;
begin
  Result := FindCmdLineSwitch(Switch, ['-', '/'], True);
end;


end.

