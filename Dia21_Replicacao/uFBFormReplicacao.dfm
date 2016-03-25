object Form41: TForm41
  Left = 0
  Top = 0
  Caption = 'Form41'
  ClientHeight = 381
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 31
    Width = 554
    Height = 309
    ActivePage = TabSheet1
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Origem (Publisher)'
      ExplicitLeft = 8
      ExplicitTop = 28
      ExplicitWidth = 554
      object Label1: TLabel
        Left = 8
        Top = 19
        Width = 50
        Height = 13
        Caption = 'Conn.Def.'
      end
      object SpeedButton3: TSpeedButton
        Left = 271
        Top = 16
        Width = 58
        Height = 22
        Caption = '-->'
        OnClick = SpeedButton3Click
      end
      object Label2: TLabel
        Left = 8
        Top = 77
        Width = 32
        Height = 13
        Caption = 'Tabela'
      end
      object SpeedButton4: TSpeedButton
        Left = 271
        Top = 70
        Width = 58
        Height = 22
        Caption = '-->'
        OnClick = SpeedButton4Click
      end
      object SpeedButton5: TSpeedButton
        Left = 352
        Top = 232
        Width = 185
        Height = 22
        Caption = 'Gerar Estrutura'
        OnClick = SpeedButton5Click
      end
      object ComboBox1: TComboBox
        Left = 64
        Top = 16
        Width = 201
        Height = 21
        TabOrder = 0
        Text = 'ComboBox1'
      end
      object ComboBox2: TComboBox
        Left = 64
        Top = 71
        Width = 201
        Height = 21
        Enabled = False
        TabOrder = 1
      end
      object ListBox1: TListBox
        Left = 64
        Top = 98
        Width = 201
        Height = 180
        Enabled = False
        ItemHeight = 13
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Destino (Subscriptor)'
      ImageIndex = 1
      ExplicitWidth = 765
      object Label3: TLabel
        Left = 16
        Top = 27
        Width = 50
        Height = 13
        Caption = 'Conn.Def.'
      end
      object SpeedButton6: TSpeedButton
        Left = 279
        Top = 24
        Width = 58
        Height = 22
        Caption = '-->'
        OnClick = SpeedButton6Click
      end
      object Label4: TLabel
        Left = 16
        Top = 85
        Width = 32
        Height = 13
        Caption = 'Tabela'
      end
      object SpeedButton7: TSpeedButton
        Left = 279
        Top = 78
        Width = 58
        Height = 22
        Caption = '-->'
        OnClick = SpeedButton7Click
      end
      object SpeedButton8: TSpeedButton
        Left = 352
        Top = 240
        Width = 185
        Height = 22
        Caption = 'Gerar Estrutura'
        OnClick = SpeedButton8Click
      end
      object ComboBox3: TComboBox
        Left = 72
        Top = 24
        Width = 201
        Height = 21
        TabOrder = 0
        Text = 'ComboBox1'
      end
      object ComboBox4: TComboBox
        Left = 72
        Top = 79
        Width = 201
        Height = 21
        Enabled = False
        TabOrder = 1
      end
      object ListBox2: TListBox
        Left = 72
        Top = 101
        Width = 201
        Height = 180
        Enabled = False
        ItemHeight = 13
        TabOrder = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Executar'
      ImageIndex = 2
      ExplicitWidth = 765
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    Color = clBtnHighlight
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 773
  end
  object Panel2: TPanel
    Left = 0
    Top = 340
    Width = 554
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Color = clBtnHighlight
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 342
    ExplicitWidth = 773
    DesignSize = (
      554
      41)
    object SpeedButton1: TSpeedButton
      Left = 444
      Top = 6
      Width = 97
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'Pr'#243'ximo'
      Flat = True
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 341
      Top = 6
      Width = 97
      Height = 22
      Anchors = [akTop, akRight]
      Caption = 'Anterior'
      Flat = True
      OnClick = SpeedButton2Click
    end
  end
  object FConnOrigem: TFDConnection
    Left = 16
    Top = 328
  end
  object FDManager1: TFDManager
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 80
    Top = 328
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 16
    Top = 272
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 16
    Top = 216
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 16
    Top = 152
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 112
    Top = 160
  end
  object FConnDestino: TFDConnection
    Left = 208
    Top = 344
  end
end
