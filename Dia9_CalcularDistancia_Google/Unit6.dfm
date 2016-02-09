object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 389
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 32
    Top = 48
    Width = 513
    Height = 21
    EditLabel.Width = 97
    EditLabel.Height = 13
    EditLabel.Caption = 'Endere'#231'o de Origem'
    TabOrder = 0
    Text = 'Av. Paulista, Sao Paulo'
  end
  object LabeledEdit2: TLabeledEdit
    Left = 32
    Top = 96
    Width = 513
    Height = 21
    EditLabel.Width = 99
    EditLabel.Height = 13
    EditLabel.Caption = 'Endere'#231'o de Destino'
    TabOrder = 1
    Text = 'Rua Domingos Luiz, Sao Paulo'
  end
  object Calcular: TButton
    Left = 470
    Top = 123
    Width = 75
    Height = 25
    Caption = 'Calcular'
    TabOrder = 2
    OnClick = CalcularClick
  end
  object PageControl1: TPageControl
    Left = 32
    Top = 123
    Width = 432
    Height = 258
    ActivePage = TabSheet1
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Localidades'
      object JvDBGrid1: TJvDBGrid
        Left = 0
        Top = 0
        Width = 424
        Height = 230
        Align = alClient
        BorderStyle = bsNone
        DataSource = DataSource1
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        BevelInner = bvNone
        BevelOuter = bvNone
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Expanded = False
            FieldName = 'Destino'
            Width = 230
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Distancia'
            Width = 78
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Duracao'
            Width = 80
            Visible = True
          end>
      end
    end
  end
  object JvMemoryData1: TJvMemoryData
    FieldDefs = <
      item
        Name = 'Destino'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Duracao'
        DataType = ftString
        Size = 30
      end>
    DatasetClosed = True
    Left = 152
    Top = 16
    object JvMemoryData1Destino: TStringField
      FieldName = 'Destino'
      Size = 255
    end
    object JvMemoryData1Distancia: TStringField
      DisplayLabel = 'Dist'#226'ncia'
      FieldName = 'Distancia'
    end
    object JvMemoryData1Duracao: TStringField
      DisplayLabel = 'Dura'#231#227'o'
      DisplayWidth = 19
      FieldName = 'Duracao'
      Size = 30
    end
  end
  object DataSource1: TDataSource
    DataSet = JvMemoryData1
    Left = 224
    Top = 32
  end
end
