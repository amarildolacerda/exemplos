object Form43: TForm43
  Left = 0
  Top = 0
  Caption = 'Form43'
  ClientHeight = 473
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 369
    Height = 457
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Iniciar: TButton
    Left = 416
    Top = 40
    Width = 161
    Height = 41
    Caption = 'Iniciar'
    TabOrder = 1
    OnClick = IniciarClick
  end
end
