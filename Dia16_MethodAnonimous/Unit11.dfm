object Form11: TForm11
  Left = 0
  Top = 0
  Caption = 'Form11'
  ClientHeight = 256
  ClientWidth = 717
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
  object Memo1: TMemo
    Left = 432
    Top = 16
    Width = 265
    Height = 217
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 48
    Top = 24
    Width = 129
    Height = 25
    Caption = 'Simples'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 48
    Top = 80
    Width = 129
    Height = 25
    Caption = 'Thread Anonima'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 48
    Top = 160
    Width = 129
    Height = 25
    Caption = 'Anonimous'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 216
    Top = 24
    Width = 129
    Height = 25
    Caption = 'DB Anonimous'
    TabOrder = 4
    OnClick = Button4Click
  end
end
