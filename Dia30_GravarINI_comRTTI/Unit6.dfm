object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 495
  ClientWidth = 916
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
    Left = 24
    Top = 64
    Width = 401
    Height = 385
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 488
    Top = 64
    Width = 401
    Height = 385
    Lines.Strings = (
      'Memo2')
    TabOrder = 1
  end
  object Button1: TButton
    Left = 32
    Top = 33
    Width = 107
    Height = 25
    Caption = 'Ler Atributos (RTTI)'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 145
    Top = 33
    Width = 107
    Height = 25
    Caption = 'RTTI - Gravar INI'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 601
    Top = 33
    Width = 107
    Height = 25
    Caption = 'Ler INI'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 488
    Top = 33
    Width = 107
    Height = 25
    Caption = 'RTTI - Ler Object'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 258
    Top = 33
    Width = 107
    Height = 25
    Caption = 'Gravar Memo'
    TabOrder = 6
    OnClick = Button5Click
  end
end
