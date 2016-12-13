unit Unit29;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Unit30,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm29 = class(TForm)
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FClasse:TMinhaClasse;
  public
    { Public declarations }
    procedure msg( txt:String);

  end;

var
  Form29: TForm29;

implementation

{$R *.dfm}

procedure TForm29.FormCreate(Sender: TObject);
begin
    FClasse:=TMinhaClasse.create;
end;

procedure TForm29.FormDestroy(Sender: TObject);
begin
   FClasse.DisposeOf;
end;

procedure TForm29.FormShow(Sender: TObject);
var v:integer;
begin
     v := 10;
     FClasse.Numero := 10;
     msg( v.ToString+'|'+  FClasse.Numero.ToString );


    //msg(FClasse.items[0]);


    //msg(FClasse[0]);

    //if FClasse.Cor=cAzul then
    //  msg('Azul');

end;

procedure TForm29.msg(txt: String);
begin
   panel1.caption := txt;
end;

end.
