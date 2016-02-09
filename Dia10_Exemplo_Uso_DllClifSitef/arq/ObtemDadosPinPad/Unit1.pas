unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnEscreverPinPad: TButton;
    btnIniciar: TButton;
    btTestarPinpad: TButton;
    btnDigitaCPF: TButton;
    edtRetorno: TEdit;
    Label1: TLabel;
    procedure btnDigitaCPFClick(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
    procedure btTestarPinpadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEscreverPinPadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FDll: THandle;
    function CapturaCPF : string;
  end;

  function VerificaPresencaPinPad () : integer; far; stdcall;
            external 'CliSiTef32I.dll';

  function EscreveMensagemPinPad (MsgDisplay : PAnsiChar): integer; far; stdcall;
            external 'CliSiTef32I.dll';

  function ObtemDadoPinPadDiretoEx (ChaveAcesso: PAnsichar;
                                     Identificador: PAnsichar;
                                     Entrada: PAnsichar;
                                     Saida: PAnsichar
                                    ): integer; far; stdcall;
                                    external 'CliSiTef32I.dll';

  function ObtemDadoPinPadEx (ChaveAcesso: PAnsichar;
                                Identificador: PAnsiChar;
                                Entrada: PAnsiChar
                             ): integer; far; stdcall;
                                external 'CliSiTef32I.dll';

function ConfiguraIntSiTefInterativo (
           pEnderecoIP: PAnsiChar;
           pCodigoLoja: PAnsiChar;
           pNumeroTerminal: PAnsiChar;
           ConfiguraResultado: smallint
         ): integer; far; stdcall;
            external 'CliSiTef32I.dll';

function IniciaFuncaoSiTefInterativo (
           Modalidade: integer;
           pValor: PansiChar;
           pNumeroCuponFiscal: PansiChar;
           pDataFiscal: PansiChar;
           pHorario: PansiChar;
           pOperador: PansiChar;
           pRestricoes: PansiChar
         ): integer; far; stdcall;
            external 'CliSiTef32I.dll';

procedure FinalizaTransacaoSiTefInterativo (
            smallint: Word;
            pNumeroCuponFiscal: PansiChar;
            pDataFiscal: PansiChar;
            pHorario: PansiChar
          ); far; stdcall;
            external 'CliSiTef32I.dll';

function ContinuaFuncaoSiTefInterativo (
           var ProximoComando: Integer;
           var TipoCampo: Integer;
           var TamanhoMinimo: smallint;
           var TamanhoMaximo: smallint;
           pBuffer: PansiChar;
           TamMaxBuffer: Integer;
           ContinuaNavegacao: Integer
         ): integer; far; stdcall;
            external 'CliSiTef32I.dll';

var
  Form1: TForm1;

const
  IP = '127.0.0.1';
  IDLOJA = '00000000';
  TERMINAL = 'SE000001';
  MSG =' ** Teste ** ';

implementation

{$R *.dfm}

procedure TForm1.btnDigitaCPFClick(Sender: TObject);
begin
  edtRetorno.Text := CapturaCPF;
end;

procedure TForm1.btnEscreverPinPadClick(Sender: TObject);
var
  iRtn : Integer;
begin
   iRtn := EscreveMensagemPinPad (MSG);

   edtRetorno.Text := IntToStr(iRtn);
end;

procedure TForm1.btnIniciarClick(Sender: TObject);
var
  lRetorno : Integer;
begin
  lRetorno := -1;

  lRetorno:= ConfiguraIntSiTefInterativo (PAnsiChar(IP), PAnsiChar(IDLOJA), PAnsiChar(AnsiString(TERMINAL)), 0);

  case lRetorno of
    0 : edtRetorno.Text := '0 - Sitef Configurado.';
    1 : edtRetorno.Text := '1 - Endereço IP inválido ou não resolvido';
    2 : edtRetorno.Text := '2 - Código da loja inválido';
    3 : edtRetorno.Text := '3 - Código de terminal inválido';
    6 : edtRetorno.Text := '6 - Erro na inicialização do Tcp/Ip';
    7 : edtRetorno.Text := '7 - Falta de memória';
    8 : edtRetorno.Text := '8 - Não encontrou a CliSiTef ou ela está com problemas';
    9 : edtRetorno.Text := '9 - Configuração de servidores SiTef foi excedida.';
    10: edtRetorno.Text := '10 -  Erro de acesso na pasta CliSiTef (possível falta de permissão para escrita)';
    11: edtRetorno.Text := '11 - Dados inválidos passados pela automação.';
    12: edtRetorno.Text := '12 - Modo seguro não ativo (possível falta de configuração no servidor SiTef do arquivo .cha).';
    13: edtRetorno.Text := '13 - Caminho DLL inválido (o caminho completo das bibliotecas está muito grande).';
  end;

  if lRetorno = 0 then
  begin
    btnEscreverPinPad.Enabled := True;
    btTestarPinpad.Enabled := True;
    btnDigitaCPF.Enabled := True;
  end;
end;

procedure TForm1.btTestarPinpadClick(Sender: TObject);
var
  lRetorno : Integer;
begin
  lRetorno := VerificaPresencaPinpad();

  case lRetorno of
    1 : edtRetorno.Text := '1 - Existe um PinPad conectado ao micro.';
    0 : edtRetorno.Text := '0 - Não existe um PinPad conectado ao micro.';
    -1: edtRetorno.Text := '(-1) - Biblioteca de acesso não encontrada.';
  end;

end;

function TForm1.CapturaCPF: string;
var
  lMsg1: Ansistring;
  lSaida: array [0..16] of ansichar;
  lResult: integer;
begin
  lSaida := '';

  lMsg1 := ' **** COLOQUE A CHAVE AQUI *****';
  lMsg1 := lMsg1 + ' **** COLOQUE A CHAVE AQUI *****';
  lMsg1 := lMsg1 +' **** COLOQUE A CHAVE AQUI *****';
  lMsg1 := lMsg1 + ' **** COLOQUE A CHAVE AQUI *****'+ chr(0);

  lResult := ObtemDadoPinPadDiretoEx(PAnsiChar('##W*ges(527)'),
                                      '08.754.527.0001-13',
                                      '011111CPF                             CONFIRME O CPF  |xxx.xxx.xxx-xx ',
                                      lSaida);
  if (lResult = 0) then
    result := 'Campo de saída: ' + lSaida
  else
    result := IntToStr(lResult);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  btnEscreverPinPad.Enabled := False;
  btTestarPinpad.Enabled := False;
  btnDigitaCPF.Enabled := False;
end;

end.
