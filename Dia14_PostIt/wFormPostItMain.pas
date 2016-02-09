unit wFormPostItMain;

interface

uses
  VCL.Forms, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, VCL.Graphics, VCL.Controls, VCL.ExtCtrls,
  JvNavigationPane, JvExControls, JvButton, JvExExtCtrls, JvExtComponent,
  JvCaptionPanel;

type
  TForm4 = class(TForm)
    FlowPanel1: TFlowPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    procedure AddOS(ACodigo:string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses JvStickerPanel, db_store;

var
  LStickerPanel: TJvStickerOS;

procedure TForm4.FormCreate(Sender: TObject);
begin
  ConnectDataBaseFromIni('SQLSupervisor', 'db', 'pdv.ini');
  AddOS('1');
  AddOS('2');
end;

procedure TForm4.AddOS(ACodigo:string);
begin
  with TJvStickerOS.create(self) do
  begin
    parent := FlowPanel1;
    Caption := 'OS: 123';
    Databasename := 'DB';
    codigoProduto := ACodigo;
    DefaultWidth := self.width - 50;
  end;
end;

end.
