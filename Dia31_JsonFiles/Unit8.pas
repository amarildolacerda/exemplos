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
    Button5: TButton;
    Button6: TButton;
    procedure LerClick(Sender: TObject);
    procedure GravarClick(Sender: TObject);
    procedure CriarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}
uses System.JsonFiles, REST.JSON;



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

type
   TJsonRttiSample = class
  private
    Fname: string;
    FdateInit: TDateTime;
    Fvalue: double;
    FLigic: Boolean;
    procedure SetdateInit(const Value: TDateTime);
    procedure SetLigic(const Value: Boolean);
    procedure Setname(const Value: string);
    procedure Setvalue(const Value: double);
     public
      property name:string read Fname write Setname;
      property  value:double read Fvalue write Setvalue;
      property  dateInit:TDateTime read FdateInit write SetdateInit;
      property  Ligic:Boolean read FLigic write SetLigic;
   end;

procedure TForm8.Button5Click(Sender: TObject);
var c : TJsonRttiSample;
    j : TJsonFiles;
begin
    c := TJsonRttiSample.create;
    j := TJsonFiles.Create('teste.json');
    try
       c.name := 'meu teste';
       c.value := 10.6;
       c.dateInit := now;
       c.Ligic := true;
       j.WriteObject('MinhaClass',c);
       memo1.Lines.Text:= j.ToJson ;
       j.UpdateFile;
    finally
       j.Free;
      c.Free;
    end;
end;

procedure TForm8.Button6Click(Sender: TObject);
var c:TJsonRttiSample;
begin
    c:=TJsonRttiSample.create;
    with TJsonFiles.Create('teste.json') do
    try
      ReadObject('MinhaClass',c);
      memo1.Lines.Text := TJson.ObjectToJsonString(c);
    finally
      free;
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

procedure TForm8.FormCreate(Sender: TObject);
begin
    with TJsonFiles.Create('teste.json') do
    try
       memo1.Lines.Text := ToJson;
    finally
      free;
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

{ TJsonRttiSample }

procedure TJsonRttiSample.SetdateInit(const Value: TDateTime);
begin
  FdateInit := Value;
end;

procedure TJsonRttiSample.SetLigic(const Value: Boolean);
begin
  FLigic := Value;
end;

procedure TJsonRttiSample.Setname(const Value: string);
begin
  Fname := Value;
end;

procedure TJsonRttiSample.Setvalue(const Value: double);
begin
  Fvalue := Value;
end;

end.
