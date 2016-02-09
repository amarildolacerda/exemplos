object Form6CommitManual: TForm6CommitManual
  Left = 0
  Top = 0
  Caption = 'Form6CommitManual'
  ClientHeight = 417
  ClientWidth = 454
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
  object JvDBGrid1: TJvDBGrid
    Left = 40
    Top = 56
    Width = 376
    Height = 305
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
  object ALQuery1: TALQuery
    Active = False
    BeforePost = ALQuery1BeforePost
    AfterPost = ALQuery1AfterPost
    BeforeDelete = ALQuery1BeforeDelete
    AfterDelete = ALQuery1AfterDelete
    OnDeleteError = ALQuery1DeleteError
    OnPostError = ALQuery1PostError
    DatabaseName = 'SQLEstoque'
    SQL.Strings = (
      'Select grupo,nome from ctgrupo')
    UpdateMode = upWhereKeyOnly
    DisableShowError = False
    SQLFields = 'grupo,nome'
    SQLDBFile = 'ctgrupo'
    NewRecno = True
    Left = 56
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = ALQuery1
    Left = 24
    Top = 16
  end
end
