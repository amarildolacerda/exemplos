object Form10: TForm10
  Left = 0
  Top = 0
  Caption = 'Form10'
  ClientHeight = 726
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 400
    Top = 107
    Width = 113
    Height = 102
  end
  object LabeledEdit1: TLabeledEdit
    Left = 56
    Top = 80
    Width = 457
    Height = 21
    EditLabel.Width = 61
    EditLabel.Height = 13
    EditLabel.Caption = 'LabeledEdit1'
    TabOrder = 0
    Text = 'teste meu qrcode'
  end
  object Button1: TButton
    Left = 56
    Top = 107
    Width = 75
    Height = 25
    Caption = 'Atualizar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object QuickRep1: TQuickRep
    Left = 32
    Top = 280
    Width = 705
    Height = 249
    DataSet = MemoryTable1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Continuous = False
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrinterSettings.PrintQuality = 0
    PrinterSettings.Collate = 0
    PrinterSettings.ColorOption = 0
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsNormal
    PreviewWidth = 500
    PreviewHeight = 500
    PrevInitialZoom = qrZoomToFit
    PreviewDefaultSaveType = stQRP
    PreviewLeft = 0
    PreviewTop = 0
    object DetailBand1: TQRBand
      Left = 38
      Top = 38
      Width = 629
      Height = 139
      AlignToBottom = False
      TransparentBand = False
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        367.770833333333400000
        1664.229166666667000000)
      PreCaluculateBandHeight = False
      KeepOnOnePage = False
      ZebraEnabled = False
      ZebraColor = clBlack
      BandType = rbDetail
      object qrDBQRCode1: TqrDBQRCode
        Left = 440
        Top = 16
        Width = 105
        Height = 105
        Size.Values = (
          277.812500000000000000
          1164.166666666667000000
          42.333333333333340000
          277.812500000000000000)
        XLColumn = 0
      end
      object QRDBText1: TQRDBText
        Left = 48
        Top = 40
        Width = 70
        Height = 17
        Size.Values = (
          44.979166666666670000
          127.000000000000000000
          105.833333333333300000
          185.208333333333300000)
        XLColumn = 0
        Alignment = taLeftJustify
        AlignToBand = False
        Color = clWhite
        DataSet = MemoryTable1
        Transparent = False
        ExportAs = exptText
        WrapStyle = BreakOnSpaces
        FullJustify = False
        MaxBreakChars = 0
        FontSize = 10
      end
    end
  end
  object Preview: TButton
    Left = 72
    Top = 249
    Width = 75
    Height = 25
    Caption = 'Preview'
    TabOrder = 3
    OnClick = PreviewClick
  end
  object MemoryTable1: TMemoryTable
    Active = True
    FieldDefs = <
      item
        Name = 'Texto'
        DataType = ftString
        Size = 255
      end>
    EnableDelete = False
    Left = 584
    Top = 136
    object MemoryTable1Texto: TStringField
      FieldName = 'Texto'
      Size = 255
    end
  end
end
