object Form34: TForm34
  Left = 0
  Top = 0
  Caption = 'Form34'
  ClientHeight = 376
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 383
    Height = 41
    Align = alTop
    Caption = 'Meu Plugin para Acessar o Mongo'
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 8
    Top = 47
    Width = 265
    Height = 314
    Caption = 'Panel2'
    TabOrder = 1
    object MongoEdit1: TMongoEdit
      Left = 16
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'MongoEdit1'
      MongoCampo = 'Codigo'
      AutoInc = True
      CampoChave = True
    end
    object MongoEdit2: TMongoEdit
      Left = 16
      Top = 43
      Width = 233
      Height = 21
      TabOrder = 1
      Text = 'MongoEdit2'
      MongoCampo = 'Descricao'
      AutoInc = False
      CampoChave = False
    end
    object MongoCalendarView1: TMongoCalendarView
      Left = 16
      Top = 70
      Width = 233
      Height = 227
      Date = 42714.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      HeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      HeaderInfo.DaysOfWeekFont.Color = clWindowText
      HeaderInfo.DaysOfWeekFont.Height = -13
      HeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      HeaderInfo.DaysOfWeekFont.Style = []
      HeaderInfo.Font.Charset = DEFAULT_CHARSET
      HeaderInfo.Font.Color = clWindowText
      HeaderInfo.Font.Height = -20
      HeaderInfo.Font.Name = 'Segoe UI'
      HeaderInfo.Font.Style = []
      ParentFont = False
      TabOrder = 2
      MongoCampo = 'Data'
      MongoTipoCampo = Texto
    end
  end
  object Button1: TButton
    Left = 288
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Inserir'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 117
    Width = 75
    Height = 25
    Caption = 'Atualizar'
    TabOrder = 3
    OnClick = Button2Click
  end
  object MongoConexao1: TMongoConexao
    Database = 'Plugins'
    Host = 'localhost'
    Porta = 27017
    Ativar = True
    Left = 72
    Top = 8
  end
  object MongoQuery1: TMongoQuery
    MongoConexao = MongoConexao1
    Ativar = True
    Collection = 'MinhaCollection'
    Left = 24
    Top = 8
  end
  object ActionList1: TActionList
    Left = 336
    Top = 16
    object MongoInsert1: TVCLMongoInsert
      Category = 'MongoVCL Components'
      Caption = 'Inserir'
      MongoQuery = MongoQuery1
      Layout = Panel2
    end
    object MongoUpdate1: TVCLMongoUpdate
      Category = 'MongoVCL Components'
      Caption = 'Atualizar'
      MongoQuery = MongoQuery1
      Layout = Panel2
    end
    object MongoLimpar1: TVCLMongoLimpar
      Category = 'MongoVCL Components'
      Caption = 'MongoLimpar1'
      MongoQuery = MongoQuery1
      Layout = Panel2
    end
  end
end
