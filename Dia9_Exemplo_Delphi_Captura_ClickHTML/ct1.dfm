object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 293
  ClientWidth = 426
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
  object Panel1: TPanel
    Left = 72
    Top = 24
    Width = 185
    Height = 41
    Caption = 'Panel1'
    TabOrder = 0
  end
  inline Browser_ClickEvent: TBrowser_ClickEvent1
    Left = 0
    Top = 0
    Width = 426
    Height = 293
    Align = alClient
    TabOrder = 1
    ExplicitLeft = -52
    ExplicitTop = -72
    inherited WebBrowser1: TWebBrowser
      Width = 426
      Height = 293
      ControlData = {
        4C000000072C0000481E00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
