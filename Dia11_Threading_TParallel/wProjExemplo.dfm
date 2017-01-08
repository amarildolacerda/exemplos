object Form44: TForm44
  Left = 0
  Top = 0
  Caption = 'Form44'
  ClientHeight = 201
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 385
    Height = 177
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 432
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Executar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 432
    Top = 33
    Width = 169
    Height = 17
    Caption = 'usar WaitForAll  do  Helper'
    TabOrder = 2
  end
end
