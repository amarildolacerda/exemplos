program Project5;

uses
  Forms,
  wGoogleCalculoDistancias in '..\..\Comum\wGoogleCalculoDistancias.pas' {GoogleCalculoDistancias};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TGoogleCalculoDistancias, GoogleCalculoDistancias);
  Application.Run;
end.
