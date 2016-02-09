object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Form5'
  ClientHeight = 525
  ClientWidth = 982
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
  object Panel1: TPanel
    Left = 24
    Top = 8
    Width = 529
    Height = 281
    Caption = 'Panel1'
    TabOrder = 0
    object JvWizard1: TJvWizard
      Left = 1
      Top = 1
      Width = 527
      Height = 279
      ButtonBarHeight = 42
      ButtonStart.Caption = 'To &Start Page'
      ButtonStart.NumGlyphs = 1
      ButtonStart.Width = 85
      ButtonLast.Caption = 'To &Last Page'
      ButtonLast.NumGlyphs = 1
      ButtonLast.Width = 85
      ButtonBack.Caption = '< &Back'
      ButtonBack.NumGlyphs = 1
      ButtonBack.Width = 75
      ButtonNext.Caption = '&Next >'
      ButtonNext.NumGlyphs = 1
      ButtonNext.Width = 75
      ButtonFinish.Caption = '&Finish'
      ButtonFinish.NumGlyphs = 1
      ButtonFinish.Width = 75
      ButtonCancel.Caption = 'Cancel'
      ButtonCancel.NumGlyphs = 1
      ButtonCancel.ModalResult = 2
      ButtonCancel.Width = 75
      ButtonHelp.Caption = '&Help'
      ButtonHelp.NumGlyphs = 1
      ButtonHelp.Width = 75
      ShowRouteMap = True
      ExplicitLeft = 32
      ExplicitTop = 24
      ExplicitWidth = 100
      ExplicitHeight = 41
      DesignSize = (
        527
        279)
      object JvWizardRouteMapNodes1: TJvWizardRouteMapNodes
        Left = 0
        Top = 0
        Width = 305
        Height = 237
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
      end
      object JvWizardRouteMapSteps1: TJvWizardRouteMapSteps
        Left = 305
        Top = 0
        Width = 145
        Height = 237
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ExplicitLeft = 384
        ExplicitTop = 48
        ExplicitHeight = 0
      end
      object JvWizardRouteMapList1: TJvWizardRouteMapList
        Left = 450
        Top = 0
        Width = 145
        Height = 237
        ActiveFont.Charset = DEFAULT_CHARSET
        ActiveFont.Color = clWindowText
        ActiveFont.Height = -11
        ActiveFont.Name = 'Tahoma'
        ActiveFont.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clNavy
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = [fsUnderline]
        ExplicitLeft = 480
        ExplicitTop = 56
        ExplicitHeight = 0
      end
    end
  end
  object Button1: TButton
    Left = 24
    Top = 306
    Width = 233
    Height = 25
    Caption = 'Cria Novo Formulario'
    TabOrder = 1
    OnClick = Button1Click
  end
  object PageControl1: TPageControl
    Left = 559
    Top = 8
    Width = 426
    Height = 281
    TabOrder = 2
  end
  object PageControl2: TPageControl
    Left = 559
    Top = 295
    Width = 415
    Height = 178
    ActivePage = TabSheet1
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object Label1: TLabel
        Left = 40
        Top = 13
        Width = 31
        Height = 13
        Caption = 'Label1'
      end
      object Edit1: TEdit
        Left = 40
        Top = 32
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
      end
      object Memo2: TMemo
        Left = 208
        Top = 32
        Width = 185
        Height = 105
        Lines.Strings = (
          'Memo2')
        TabOrder = 1
      end
      object GroupBox1: TGroupBox
        Left = 40
        Top = 59
        Width = 162
        Height = 78
        Caption = 'GroupBox1'
        TabOrder = 2
      end
    end
  end
  object Button2: TButton
    Left = 848
    Top = 475
    Width = 126
    Height = 25
    Caption = 'Torna Dockable'
    TabOrder = 4
    OnClick = Button2Click
  end
end
