object Form44: TForm44
  Left = 0
  Top = 0
  Caption = 'Form44'
  ClientHeight = 294
  ClientWidth = 776
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 16
    Top = 27
    Width = 337
    Height = 22
    Caption = 'Execute (Comp)'
    OnClick = SpeedButton1Click
  end
  object Button1: TButton
    Left = 383
    Top = 24
    Width = 361
    Height = 25
    Caption = 'Executa (by Code)'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 55
    Width = 361
    Height = 231
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 383
    Top = 55
    Width = 385
    Height = 139
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 383
    Top = 200
    Width = 385
    Height = 86
    DataSource = DataSource2
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 600
    Top = 88
  end
  object RESTSocialClientDataset1: TRESTSocialClientDataset
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://localhost:8080'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Resource = '/datasnap/rest/TServerMethods1/GetCliente/{cnpj}'
    RequestMethod = rmGET
    RootElement = 'result.cliente'
    DataSet = FDMemTable1
    Left = 72
    Top = 120
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 504
    Top = 88
  end
  object DataSource2: TDataSource
    DataSet = FDMemTable2
    Left = 600
    Top = 192
  end
  object FDMemTable2: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 504
    Top = 200
  end
end
