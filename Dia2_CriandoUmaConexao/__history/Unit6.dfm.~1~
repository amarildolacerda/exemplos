object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 313
  ClientWidth = 701
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
  object Button1: TButton
    Left = 32
    Top = 40
    Width = 129
    Height = 25
    Caption = 'Criar Conexao'
    TabOrder = 0
    OnClick = Button1Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 216
    Top = 72
    Width = 121
    Height = 21
    EditLabel.Width = 115
    EditLabel.Height = 13
    EditLabel.Caption = 'Qtde Conex'#245'es abertas'
    ReadOnly = True
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 32
    Top = 72
    Width = 129
    Height = 25
    Caption = 'abrir uma tabela'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 32
    Top = 103
    Width = 129
    Height = 25
    Caption = 'Commit usando Codigo'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object DBGrid1: TDBGrid
    Left = 216
    Top = 99
    Width = 457
    Height = 182
    DataSource = DataSource1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 32
    Top = 152
    Width = 129
    Height = 25
    Caption = 'Commit Automatico'
    TabOrder = 5
    OnClick = Button2Click
  end
  object ALQuery1: TALQuery
    Active = False
    BeforeOpen = ALQuery1BeforeOpen
    SQL.Strings = (
      'Select * from ctgrupo')
    UpdateMode = upWhereKeyOnly
    DisableShowError = False
    SQLFields = '*'
    SQLDBFile = 'CtGrupo'
    NewRecno = True
    Left = 32
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = ALQuery1
    Left = 168
    Top = 16
  end
end
