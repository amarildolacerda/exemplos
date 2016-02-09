unit uForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm77 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form77: TForm77;

implementation

{$R *.dfm}

uses stFunctions;

procedure TForm77.Button1Click(Sender: TObject);
var attrib:TProdutoAttrib;
    i:integer;
begin
    // nao uaar

    GetProduto('1',attrib,'BD');

end;

end.
