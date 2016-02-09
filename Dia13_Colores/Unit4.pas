unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, JvExStdCtrls, JvButton, JvCtrls;

type
  TForm4 = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TJvImgBtn;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure mudou;
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses uColores;




procedure TForm4.FormCreate(Sender: TObject);
var
  i: integer;
  x: integer;
  pn: TPanel;
  pnx: TPanel;
  k: integer;
  lb:TLabel;
  c:integer;
  s:string;

begin

  for i := 0 to 4 do
  begin
    pn := TPanel.Create(self);
    pn.Parent := self;
    pn.Align := altop;
    pn.ParentColor := false;
    pn.Top := k;
    inc(k, 50);
    for x := 0 to 4 do
    begin
    pnx := TPanel.Create(pn);
    pnx.ParentBackground := false;
    // pnx.Transparent := false;
    // pnx.ParentColor := false;

    pnx.Parent := pn;
    pnx.Width := trunc(Width div 5);
    pnx.Align := alLeft;
    pnx.caption := 'Y=' + intToStr(i) + ' X=' + intToStr(x);
    pnx.Color := getColores(i, x);
    pnx.Font.Color := InvertColores(pnx.Color);


    lb := TLabel.create(pnx);
    lb.transparent := false;
    lb.parent :=pnx;
    lb.align := alBottom;
    lb.Color := EscurecerColores(pnx.Color);

    end;
  end;

  color := GetRandomColores;

end;

procedure TForm4.SpeedButton1Click(Sender: TObject);
begin
    color := lighter(color,10);
    mudou;
end;

procedure TForm4.SpeedButton2Click(Sender: TObject);
begin
   color := darker(color,10);
   mudou;
end;

procedure TForm4.SpeedButton3Click(Sender: TObject);
begin
      color := SpeedButton3.color;
      SpeedButton3.color := GetRandomColores;
      mudou;
end;

procedure TForm4.mudou;
begin
    Label1.Caption := ColorToString(color);
end;

end.
