unit ct1;

interface

uses
Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
OleCtrls, SHDocVw, MSHTML, ExtCtrls, Variants, uCapturaClickEvent,
  frBrowser_EventClick;

type


  TForm1 = class(TForm)
    Panel1: TPanel;
    Browser_ClickEvent: TBrowser_ClickEvent1;
    procedure FormCreate(Sender: TObject);
  private
  public
  { Public declarations }
  end;


var
Form1: TForm1;

implementation

{$R *.DFM}


procedure TForm1.FormCreate(Sender: TObject);
begin
  Browser_ClickEvent.WebBrowser1.Navigate('C:\Fontes\treinamento\Dia9_Exemplo_Delphi_com_JavaScript\teste.html');

end;

end.

