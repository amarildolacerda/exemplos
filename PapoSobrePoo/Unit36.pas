unit Unit36;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Unit39Interf,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type


  TInterfacedObjectHack = class(TInterfacedObject)
  public
    function _RefCount: integer;
  end;

  TMinhaClasse = class(TInterfacedObjectHack, IMinhaInterface)
  private
    FCaption: string;
    function GetCaption: string;
    procedure SetCaption(const AValue: string);
  public
    constructor create;
    destructor destroy; override;
  end;

  TForm36 = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FMinhaInterface: IMinhaInterface;
    FNumeroQualquer: integer;
    procedure SetNumeroQualquer(const Value: integer);
  public
    { Public declarations }
    property NumeroQualquer: integer read FNumeroQualquer write SetNumeroQualquer;
    function GetCaption: string;
    procedure SetCaption(const AValue: string);
    procedure Checar(AValue: IMinhaInterface);
  end;

var
  Form36: TForm36;

implementation

{$R *.dfm}

uses Unit37, Unit38;

{ TForm36 }

procedure TForm36.Checar(AValue: IMinhaInterface);
begin
  Memo1.Lines.Add('Checar: ' + AValue._RefCount.ToString);
end;

procedure TForm36.FormShow(Sender: TObject);
var
  LInterface: IMinhaInterface;
begin

 if FNumeroQualquer=0 then
  FMinhaInterface := TMinhaClasse37.create as IMinhaInterface
 else
  FMinhaInterface := TMinhaClasse38.create as IMinhaInterface;




  LInterface := TMinhaClasse.create as IMinhaInterface;
  Memo1.Lines.Add('Base: ' + LInterface._RefCount.ToString);

  Checar(LInterface);

  Memo1.Lines.Add('Depois Checar: ' + LInterface._RefCount.ToString);

  LInterface := nil;

  showmessage('fim');

end;

function TForm36.GetCaption: string;
begin
  result := self.Caption;
end;

procedure TForm36.SetCaption(const AValue: string);
begin
  self.Caption := AValue;
end;

procedure TForm36.SetNumeroQualquer(const Value: integer);
begin
  FNumeroQualquer := Value;
end;

{ TMinhaClasse }

constructor TMinhaClasse.create;
begin
  showmessage('constructor');
end;

destructor TMinhaClasse.destroy;
begin
  showmessage('destructor');
  inherited;
end;

function TMinhaClasse.GetCaption: string;
begin
  result := FCaption;
end;

procedure TMinhaClasse.SetCaption(const AValue: string);
begin
  FCaption := AValue;
end;

{ TInterfacedObjectHack }

function TInterfacedObjectHack._RefCount: integer;
begin
  result := RefCount;
end;

end.
