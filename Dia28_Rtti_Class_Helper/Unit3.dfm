object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 699
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 240
    Top = 46
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 240
    Top = 312
    Width = 31
    Height = 13
    Caption = 'Label2'
  end
  object Button1: TButton
    Left = 43
    Top = 40
    Width = 174
    Height = 25
    Caption = 'RTTI Properties'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 368
    Top = 80
    Width = 337
    Height = 21
    Enabled = False
    TabOrder = 1
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 630
    Top = 155
    Width = 75
    Height = 25
    Caption = 'aplicar'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ListBox1: TListBox
    Left = 43
    Top = 71
    Width = 302
    Height = 202
    ItemHeight = 13
    TabOrder = 3
    OnClick = ListBox1Click
  end
  object Edit2: TEdit
    Left = 368
    Top = 155
    Width = 249
    Height = 21
    TabOrder = 4
    Text = 'Edit2'
  end
  object Button3: TButton
    Left = 43
    Top = 309
    Width = 174
    Height = 25
    Caption = 'RTTI Fields'
    TabOrder = 5
    OnClick = Button3Click
  end
  object ListBox2: TListBox
    Left = 43
    Top = 340
    Width = 302
    Height = 234
    ItemHeight = 13
    TabOrder = 6
    OnClick = ListBox1Click
  end
  object Button4: TButton
    Left = 464
    Top = 272
    Width = 241
    Height = 25
    Caption = 'Invoke Click do Button1'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 464
    Top = 336
    Width = 241
    Height = 25
    Caption = 'Testando propriedade que n'#227'o existe'
    TabOrder = 8
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 368
    Top = 397
    Width = 129
    Height = 25
    Caption = 'RTTI Methods'
    TabOrder = 9
    OnClick = Button6Click
  end
  object ListBox3: TListBox
    Left = 368
    Top = 428
    Width = 337
    Height = 146
    ItemHeight = 13
    TabOrder = 10
  end
end
