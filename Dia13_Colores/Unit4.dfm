object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 358
  ClientWidth = 757
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 632
    Top = 296
    Width = 23
    Height = 22
    Caption = '<'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 691
    Top = 296
    Width = 23
    Height = 22
    Caption = '>'
    OnClick = SpeedButton2Click
  end
  object Label1: TLabel
    Left = 525
    Top = 299
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object SpeedButton3: TJvImgBtn
    Left = 658
    Top = 295
    Width = 33
    Height = 25
    Caption = 'cl'
    TabOrder = 0
    OnClick = SpeedButton3Click
    Color = clHighlight
  end
end
