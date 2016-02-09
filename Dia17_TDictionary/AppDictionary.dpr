program AppDictionary;

uses
  Vcl.Forms,
  uDictionary in 'uDictionary.pas' {Form25};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm25, Form25);
  Application.Run;
end.
