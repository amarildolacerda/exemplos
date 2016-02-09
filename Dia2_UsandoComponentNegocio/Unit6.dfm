object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 411
  ClientWidth = 783
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 22
    Height = 13
    Caption = 'Dcto'
  end
  object Label2: TLabel
    Left = 39
    Top = 364
    Width = 698
    Height = 39
    Caption = 'Este formulario '#233' um exemplo de como nao fazer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 40
    Top = 43
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 172
    Top = 39
    Width = 109
    Height = 25
    Caption = 'Abrir o Pedido'
    TabOrder = 1
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 40
    Top = 104
    Width = 697
    Height = 257
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 680
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Reflesh'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 172
    Top = 70
    Width = 173
    Height = 25
    Caption = 'Novo Item - como nao fazer'
    TabOrder = 4
    OnClick = Button3Click
  end
  object ALQuery1: TALQuery
    Active = False
    BeforeOpen = ALQuery1BeforeOpen
    AfterInsert = ALQuery1AfterInsert
    AfterEdit = ALQuery1AfterEdit
    DatabaseName = 'SQLEstoque'
    SQL.Strings = (
      'Select * from sigcaut1'
      'Where (dcto=:dcto and filial=:filial)')
    UpdateMode = upWhereKeyOnly
    DisableShowError = False
    SQLFields = '*'
    SQLDBFile = 'sigcaut1'
    SQLWhere = 'dcto=:dcto and filial=:filial'
    NewRecno = True
    Left = 312
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dcto'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'filial'
        ParamType = ptUnknown
      end>
  end
  object DataSource1: TDataSource
    DataSet = ALQuery1
    Left = 360
    Top = 40
  end
end
