object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Form8'
  ClientHeight = 516
  ClientWidth = 514
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
    Left = 32
    Top = 16
    Width = 75
    Height = 25
    Caption = 'abrir'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 32
    Top = 56
    Width = 449
    Height = 193
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'ini'
    Left = 248
    Top = 8
  end
end
