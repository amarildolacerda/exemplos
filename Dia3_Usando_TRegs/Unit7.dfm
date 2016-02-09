object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 402
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 216
    Top = 171
    Width = 389
    Height = 29
    Caption = 'Exemplo de registro:   TRegSigcAut2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 219
    Width = 697
    Height = 183
    Align = alBottom
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 544
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Inserir'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 64
    Top = 26
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 64
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 64
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 64
    Top = 192
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'Edit4'
  end
  object Button2: TButton
    Left = 544
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 6
    OnClick = Button2Click
  end
  object ALQuery1: TALQuery
    Active = False
    AfterOpen = ALQuery1AfterOpen
    DatabaseName = 'SQLEstoque'
    SQL.Strings = (
      'Select * from sigcaut2'
      'Where (data = '#39'today'#39')')
    UpdateMode = upWhereKeyOnly
    DisableShowError = False
    SQLFields = '*'
    SQLDBFile = 'sigcaut2'
    SQLWhere = 'data = '#39'today'#39
    NewRecno = True
    Left = 24
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = JvMemoryData1
    Left = 624
    Top = 40
  end
  object JvMemoryData1: TJvMemoryData
    FieldDefs = <>
    DatasetClosed = True
    Left = 624
    Top = 8
    object JvMemoryData1dcto: TStringField
      FieldName = 'dcto'
      Size = 10
    end
  end
end
