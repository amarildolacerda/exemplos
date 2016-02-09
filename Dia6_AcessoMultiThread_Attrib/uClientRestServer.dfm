object Form77: TForm77
  Left = 0
  Top = 0
  Caption = 'Form77'
  ClientHeight = 274
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 24
    Top = 64
    Width = 185
    Height = 202
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 216
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Ler Json'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Memo2: TMemo
    Left = 216
    Top = 64
    Width = 229
    Height = 202
    Lines.Strings = (
      'Memo2')
    TabOrder = 3
  end
end
