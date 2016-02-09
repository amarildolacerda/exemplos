unit wMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, uDockForm, ComCtrls, JvExControls, JvSticker,
  JvDrawImage, JvPaintFX, JvWizardRouteMapList, JvWizardRouteMapSteps, JvWizard,
  JvWizardRouteMapNodes;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    Edit1: TEdit;
    Memo2: TMemo;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Button2: TButton;
    JvWizard1: TJvWizard;
    JvWizardRouteMapNodes1: TJvWizardRouteMapNodes;
    JvWizardRouteMapSteps1: TJvWizardRouteMapSteps;
    JvWizardRouteMapList1: TJvWizardRouteMapList;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FDockServer:TDockFormServer;
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}





procedure TForm5.Button1Click(Sender: TObject);
var frm:TDockableForm ;
begin

    frm := TDockableForm.create(self,'TesteDockableSeccao');  // pode utilizar qualquer formulario que
                                        // tenha um DockLink criado (client)
    frm.Caption := frm.DockLink.IniSeccao;
    frm.Color := TColor(  Random($FFFFFF)  );



    // registra o formulario para o servidor
    FDockServer.RegisterDockClient(frm,frm.DockLink);

    // Mostra o Formulario

    frm.DockLink.Show;


end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  CreateDockableFormFromPageControl(self,FDockServer,PageControl2);
end;

procedure TForm5.FormCreate(Sender: TObject);

begin


   // cria o servidor de Dock
   FDockServer := TDockFormServer.create(self);


   // nomeia qual componente pode ser DockSite;
   FDockServer.AddDockSites(Panel1);
   FDockServer.AddDockSites(PageControl1);
   FDockServer.AddDockSites(PageControl2);




end;

procedure TForm5.FormDestroy(Sender: TObject);
begin
   FDockServer.free;
end;

end.
