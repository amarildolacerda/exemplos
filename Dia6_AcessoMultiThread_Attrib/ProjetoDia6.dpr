program ProjetoDia6;

uses
  Forms,
  uForm in 'uForm.pas' {Form77};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm77, Form77);
  Application.Run;
end.
