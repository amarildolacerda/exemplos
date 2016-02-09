program PostIt;

uses
  Vcl.Forms,
  wFormPostItMain in 'wFormPostItMain.pas' {Form4},
  JvStickerPanel in '..\..\Encomendas\JvStickerPanel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
