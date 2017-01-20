object Form43: TForm43
  Left = 0
  Top = 0
  Caption = 'Form43'
  ClientHeight = 470
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 56
    Width = 513
    Height = 377
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 552
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Executar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object FDQuery1: TFDQuery
    ConnectionName = 'SQLEstoque'
    SQL.Strings = (
      'select * from ctgrupo')
    Left = 96
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 160
    Top = 8
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 296
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 368
    Top = 16
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 456
    Top = 16
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=SQLEstoque')
    Left = 600
    Top = 296
  end
end
