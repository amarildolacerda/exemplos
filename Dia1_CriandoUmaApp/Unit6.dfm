object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 417
  ClientWidth = 683
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object JvDBGrid1: TJvDBGrid
    Left = 0
    Top = 97
    Width = 683
    Height = 320
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
  end
  object DBNav981: TDBNav98
    Left = 0
    Top = 0
    Width = 683
    Height = 97
    Cursor = crHandPoint
    Align = alTop
    TabOrder = 1
    BevelOuter = bvNone
    Caption = ' '
    BtnAlign = alNone
    Flat = True
    DataSource = DataSource1
    OnLocalizar = DBNav981Localizar
    DisableMsgDelete = False
    Position = alNone
    KeepFilter = False
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Edit1: TEdit
      Left = 110
      Top = 4
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'Edit1'
    end
    object StaticText1: TStaticText
      Left = 237
      Top = 8
      Width = 59
      Height = 17
      Caption = 'StaticText1'
      TabOrder = 2
    end
    object Button1: TButton
      Left = 472
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object ALQuery1: TALQuery
    Active = False
    BeforeOpen = ALQuery1BeforeOpen
    DatabaseName = 'SQLEstoque'
    SQL.Strings = (
      'Select codigo,nome,unidade,grupo,setor,precovenda from ctprod')
    UpdateMode = upWhereKeyOnly
    DisableShowError = False
    SQLFields = 'codigo,nome,unidade,grupo,setor,precovenda'
    SQLDBFile = 'ctprod'
    NewRecno = True
    Left = 8
    Top = 192
  end
  object DataSource1: TDataSource
    DataSet = ALQuery1
    OnDataChange = DataSource1DataChange
    Left = 8
    Top = 160
  end
end
