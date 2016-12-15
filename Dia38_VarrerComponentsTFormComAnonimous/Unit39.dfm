object Form39: TForm39
  Left = 0
  Top = 0
  Caption = 'Form39'
  ClientHeight = 385
  ClientWidth = 502
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
    Top = 168
    Width = 441
    Height = 153
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 286
    Top = 336
    Width = 75
    Height = 25
    Caption = '[ GO ]'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 390
    Top = 336
    Width = 75
    Height = 25
    Caption = '[ GO GO ]'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 8
    Top = 16
    Width = 457
    Height = 146
    Alignment = taLeftJustify
    TabOrder = 3
    object Label1: TLabel
      Left = 16
      Top = 17
      Width = 433
      Height = 129
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'Como varrer os componentes de um formul'#225'rio com Anonimous Method' +
        's'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object Button3: TButton
    Left = 32
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Usando TList'
    TabOrder = 4
    OnClick = Button3Click
  end
end
