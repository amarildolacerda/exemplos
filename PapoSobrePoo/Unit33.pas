unit Unit33;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, plugin.Manager, Vcl.Menus;

type
  TForm33 = class(TForm)
    MainMenu1: TMainMenu;
    Plugins1: TMenuItem;
    Instalarnovosplugins1: TMenuItem;
    itemPluginCarregados: TMenuItem;
    PluginManager1: TPluginManager;
    procedure Instalarnovosplugins1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form33: TForm33;

implementation

{$R *.dfm}

procedure TForm33.FormCreate(Sender: TObject);
begin
   PluginManager1.Active:=true;
end;

procedure TForm33.Instalarnovosplugins1Click(Sender: TObject);
begin
   PluginManager1.OpenDialog( PluginManager1.Filename );
end;

end.
