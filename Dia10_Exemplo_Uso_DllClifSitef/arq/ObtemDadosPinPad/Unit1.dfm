object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ObtemDadosPinPad'
  ClientHeight = 243
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 168
    Width = 46
    Height = 13
    Caption = 'Retorno :'
  end
  object btnEscreverPinPad: TButton
    Left = 56
    Top = 54
    Width = 89
    Height = 25
    Caption = 'Escreve PinPad'
    TabOrder = 0
    OnClick = btnEscreverPinPadClick
  end
  object btnIniciar: TButton
    Left = 56
    Top = 23
    Width = 89
    Height = 25
    Caption = 'Iniciar'
    Default = True
    TabOrder = 1
    OnClick = btnIniciarClick
  end
  object btTestarPinpad: TButton
    Left = 56
    Top = 86
    Width = 89
    Height = 25
    Caption = 'Testa PinPad'
    TabOrder = 2
    OnClick = btTestarPinpadClick
  end
  object btnDigitaCPF: TButton
    Left = 56
    Top = 117
    Width = 89
    Height = 25
    Caption = 'Digita CPF'
    TabOrder = 3
    OnClick = btnDigitaCPFClick
  end
  object edtRetorno: TEdit
    Left = 64
    Top = 187
    Width = 393
    Height = 21
    TabOrder = 4
  end
end
