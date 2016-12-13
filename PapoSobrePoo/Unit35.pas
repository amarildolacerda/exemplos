unit Unit35;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type


  IInterfaceBase = interface
     ['{BE1B71E0-44C0-4D04-82B5-C9A00ACEF840}']
     function GetText:string;
     procedure SetText( const AText:String );
     property Text:string read GetText write SetText;
  end;


  TMinhaClasse = class(TInterfacedObject, IInterfaceBase)
     strict private
      FText:string;
      function GetText:string;
      procedure SetText( const AText:String );
      property Text:string read GetText write SetText;
  end;

  TLetreiro = class(TInterfacedObject, IInterfaceBase)

  end;


  TForm35 = class(TForm,IInterfaceBase)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
     FMinhaClasse : IInterfaceBase;
     F1:TMinhaClasse;
     function GetText:string;
     procedure SetText( const AText:String );
  public
    { Public declarations }
  end;

var
  Form35: TForm35;

implementation

{$R *.dfm}

{ TMinhaClasse }

function TMinhaClasse.GetText: string;
begin
   result := FText;
end;

procedure TMinhaClasse.SetText(const AText: String);
begin
   FText := AText;
end;

{ TForm35 }

procedure TForm35.Button1Click(Sender: TObject);
begin
    // exemplo 1
    FMinhaClasse := TMinhaClasse.Create  as IInterfaceBase;

    // ou

    // exemplo 2
    FMinhaClasse :=  TLetreiro.Create as IInterfaceBase;

    FMinhaClasse.Text := 'a';

    showMessage(  FMinhaClasse.Text  );

    // nao requer
    // FMinhaClasse.free;     FMinhaClasse.disposeOf;

    // F2.text := 'a';

   F1:=TMinhaClasse.create;
   try

   finally
     F1.Free;
   end;

end;

function TForm35.GetText: string;
begin

end;

procedure TForm35.SetText(const AText: String);
begin

end;

end.
