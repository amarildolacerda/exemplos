unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm8 = class(TForm)
    Memo1: TMemo;
    Ler: TButton;
    Gravar: TButton;
    Criar: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure LerClick(Sender: TObject);
    procedure GravarClick(Sender: TObject);
    procedure CriarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}
uses System.JsonFiles, IniFiles, IniFilesEx;



procedure TForm8.Button1Click(Sender: TObject);
var
  j:TJsonFiles;
begin
    j:=TJsonFiles.Create('teste.json');
    try
      j.ReadSections( memo1.Lines );
    finally
      j.Free;
    end;
end;

procedure TForm8.Button2Click(Sender: TObject);
var
  j:TJsonFiles;
begin

    j:=TJsonFiles.Create('teste.json');
    try
      j.ReadSection('Pedido', memo1.Lines );
    finally
      j.Free;
    end;

end;

procedure TForm8.Button3Click(Sender: TObject);
var
  j:TJsonFiles;
begin
    j:=TJsonFiles.Create('teste.json');
    try
      j.ReadSectionValues('Pedido',memo1.lines);
    finally
      j.Free;
    end;
    {with TIniFile.Create('pedido.ini') do
    try
      ReadSectionValues('Config',memo1.lines);
    finally
      Free;
    end;}
end;


procedure TForm8.Button4Click(Sender: TObject);
var j:TJsonFiles;
begin
    memo1.Lines.Clear;
    j:=TJsonFiles.Create('teste.json');
    try
    // testar string
    memo1.Lines.Add('Vendedor: '+ j.ReadString('Pedido','Vendedor','yyy' ) );
    // testar datetime
    memo1.Lines.Add('DataAcesso: '+ dateTimeToStr( j.ReadDatetime('Pedido','DataAcesso',now )) );

    // testar integer
    memo1.Lines.Add('MaximoParcelas: '+ IntToStr( j.ReadInteger('Financiamento','MaximoParcelas',11)) );

    // testar numerico
    memo1.Lines.Add('ValorMaximoParcelas: '+ FloatToStr( j.ReadFloat('Financiamento','ValorMaximoParcelas',10.5)) );

    finally
      j.Free;
    end;
end;

procedure TForm8.CriarClick(Sender: TObject);
var
  j:TJsonFiles;
begin
    j:=TJsonFiles.Create('teste.json');
    try
      j.WriteString('Pedido','Vendedor','001'); // inseri nova linha
      j.WriteString('Pedido','Vendedor','002'); // faz update da linha
      j.WriteString('Pedido','Caixa','xxx'); // faz update da linha
      j.WriteDateTime('Pedido','DataAcesso',now);
      j.WriteInteger('Financiamento','MaximoParcelas',10);
      j.WriteBool('Financiamento','PegaCartao',true);
      memo1.Lines.Text := j.ToJson;
    finally
      j.Free;
    end;
end;

procedure TForm8.GravarClick(Sender: TObject);
var
  j:TJsonFiles;
begin
    j:=TJsonFiles.Create('teste.json');
    try
      j.FromJson( memo1.Lines.text );
      j.UpdateFile;
      memo1.Lines.Text := j.ToJson;
    finally
      j.Free;
    end;
end;

procedure TForm8.LerClick(Sender: TObject);
var
  j:TJsonFiles;
begin
    j:=TJsonFiles.Create('teste.json');
    try
      memo1.Lines.Text := j.ToJson;
    finally
      j.Free;
    end;
end;

end.
