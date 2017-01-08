object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Form8'
  ClientHeight = 49
  ClientWidth = 254
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
    Left = 8
    Top = 13
    Width = 70
    Height = 13
    Caption = 'Max. Threads:'
  end
  object Button1: TButton
    Left = 139
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Progresso'
    TabOrder = 0
    OnClick = Button1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 84
    Top = 8
    Width = 49
    Height = 22
    Increment = 5
    MaxValue = 100
    MinValue = 0
    TabOrder = 1
    Value = 25
  end
end
