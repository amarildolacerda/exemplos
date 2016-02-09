unit uClientRestServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm77 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    JsonString:string;
  end;

var
  Form77: TForm77;

implementation

{$R *.dfm}
uses Storeware_RestServer_interf, uJson;


procedure TForm77.Button1Click(Sender: TObject);
begin
   with TStoreware_RestServer.create(nil) do
   try
     Host := 'http://localhost:8886';
     Filial_Get(48);

     memo1.lines.clear;
     memo1.lines.add(ResponseText);

   finally
     free;
   end;
end;

procedure TForm77.Button2Click(Sender: TObject);
var
   obj_json : IJson;
begin
//   if JsonString='' then exit;


   obj_json := JSON.parse(memo1.lines.text);

   memo2.lines.Add( 'Rows = '+  obj_json.S['rows']    );

   memo2.lines.Add(' Result = '+obj_json.S['result'])


end;

end.
