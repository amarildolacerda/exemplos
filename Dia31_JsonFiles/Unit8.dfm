object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Form8'
  ClientHeight = 698
  ClientWidth = 694
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
    Left = 40
    Top = 128
    Width = 609
    Height = 513
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Ler: TButton
    Left = 271
    Top = 41
    Width = 148
    Height = 25
    Caption = 'Ler'
    TabOrder = 1
    OnClick = LerClick
  end
  object Gravar: TButton
    Left = 425
    Top = 41
    Width = 192
    Height = 25
    Caption = 'Gravar'
    TabOrder = 2
    OnClick = GravarClick
  end
  object Criar: TButton
    Left = 40
    Top = 41
    Width = 225
    Height = 25
    Caption = 'Criar'
    TabOrder = 3
    OnClick = CriarClick
  end
  object Button1: TButton
    Left = 43
    Top = 72
    Width = 222
    Height = 25
    Caption = 'Sections'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 271
    Top = 72
    Width = 148
    Height = 25
    Caption = 'Section'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 427
    Top = 73
    Width = 190
    Height = 25
    Caption = 'Values'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 43
    Top = 100
    Width = 222
    Height = 25
    Caption = 'Ler Itens'
    TabOrder = 7
    OnClick = Button4Click
  end
end
