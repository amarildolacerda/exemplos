object Form33: TForm33
  Left = 0
  Top = 0
  Caption = 'Form33'
  ClientHeight = 221
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 40
    Top = 48
    object Plugins1: TMenuItem
      Caption = 'Plugins'
      object Instalarnovosplugins1: TMenuItem
        Caption = 'Instalar novos plugins'
        OnClick = Instalarnovosplugins1Click
      end
      object itemPluginCarregados: TMenuItem
        Caption = '-'
        object TMenuItem
        end
      end
    end
  end
  object PluginManager1: TPluginManager
    Filename = 'Plugin.ini'
    LocalPluginPath = '{app}\Plugins'
    MainMenu = MainMenu1
    MenuItem = itemPluginCarregados
    Active = False
    Left = 168
    Top = 64
  end
end
