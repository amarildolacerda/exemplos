unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm8 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}
uses System.IniFiles, System.IniFiles.Helper, Data.QueryIntf;

procedure TForm8.Button1Click(Sender: TObject);
begin
 if OpenDialog1.execute then
    begin
       with TIniFile.create(OpenDialog1.fileName) do
       try
          memo1.lines.text := toJson;
       finally
         free;
       end;


    end;
end;

end.
