unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm10 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

uses System.uJson, System.Json, Data.Db_store;

type
    TMeuRecord = record
      codigo:string;
      data:TDateTime;
      valor1:double;
      hora:TTime;
      valor2:Currency;
      valor3:Double;
      verdadeiro:boolean;
      Endereco:string;
    end;

procedure TForm10.FormCreate(Sender: TObject);
var r :TMeuRecord;
begin
     memo1.Lines.clear;
     memo1.Lines.Add('Valor4 esta no JSON e nao existe no RECORD');
     // carrega o JSON para um RECORD (TMeuRecord)
     memo1.Lines.Add('-----------------------------------------');
     memo1.Lines.Add('JSON para RECORD');
     memo1.Lines.Add('-----------------------------------------');
     r := TJsonObject.ToRecord<TMeuRecord>('{"codigo":"1","data":"2016-09-03T00:00:00","hora":"23:00:00", "valor1":10, "valor2":2, "valor3":3, "valor4":9999, "verdadeiro":"False"} ');

     memo1.Lines.Add('Endereco existe no RECORD e nao esta no JSON');
     memo1.Lines.Add('-----------------------------------------');
     memo1.Lines.Add('RECORD para JSON');
     memo1.Lines.Add('-----------------------------------------');

     // converte o RECORD para JSON
     memo1.Lines.add(  TJsonObject.FromRecord ( r ).ToJSON);


end;

end.
