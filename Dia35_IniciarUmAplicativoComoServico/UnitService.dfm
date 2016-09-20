object AppService: TAppService
  OldCreateOrder = False
  DisplayName = 'AppService'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end
