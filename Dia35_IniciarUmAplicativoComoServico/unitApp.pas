unit UnitApp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm10 = class(TForm)
    Timer1: TTimer;
    Memo1: TMemo;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FContador: integer;
    FServico: Boolean;
    FLock: TObject;
    { Private declarations }
  public
    { Public declarations }
    procedure Log(texto: string);
    procedure Execute;
    procedure Init;
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.Execute;
begin // procedure a ser executa quando estiver chamando como serviço
  // nao executa o SHOW do formulário
  FServico := true;
  Init;
end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  FContador := 0;
  FServico := false;
  FLock := TObject.create;
end;

procedure TForm10.FormDestroy(Sender: TObject);
begin
  FLock.Free;
end;

procedure TForm10.FormShow(Sender: TObject);
begin
  // quando é executa como Aplicativo, usa o show para dar inicio ao funcinamento
  FServico := false;
  Init;
end;

procedure TForm10.Init;
begin
  Timer1.Enabled := true;
end;

procedure WriteLogText(AArquivo: string; ATexto: string);
var
  Lf: textfile;
  LS: string;
begin
  AssignFile(Lf, AArquivo);
  try
{$I-}
    Append(Lf);
{$I+}
    if IOResult <> 0 then
      Rewrite(Lf);
    WriteLn(Lf, ATexto);
  finally
    CloseFile(Lf);
  end;
end;

procedure TForm10.Log(texto: string);
  procedure LogServico;
  begin
     System.TMonitor.Enter(FLock);  // controle de acesso ao arquivo de LOG
     try
        WriteLogText( ExtractFilePath(ParamStr(0))+ '\AppService.log',DatetimeToStr(now)+'-'+texto);
     finally
        System.TMonitor.Exit(FLock);
     end;
  end;

begin
  if FServico then
    LogServico
  else
    TThread.Queue(nil,
      procedure // sincroniza a escrita no memo1 - previne chamada multi-thread
      begin
        Memo1.Lines.Add(texto); // mostra o texto em um memo.
      end);
end;

procedure TForm10.Timer1Timer(Sender: TObject);
begin
  inc(FContador);
  Log('Chamada: ' + intToStr(FContador));
end;

end.
