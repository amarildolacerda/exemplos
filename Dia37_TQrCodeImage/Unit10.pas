unit Unit10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm10 = class(TForm)
    Image1: TImage;
    LabeledEdit1: TLabeledEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

// usando ACBR
uses ACBrDelphiZXingQRCode;
// se nao usa ACBR, pode usar o component original :   https://github.com/debenu/DelphiZXingQRCode/


procedure QrCodeToCanvas(AWidth, AHeight: Integer; ATexto:String; ACanvas: TCanvas);
var
  bitmap: TBitmap;
  qr: TDelphiZXingQRCode;
  r: Integer;
  c: Integer;
  scala: Double;
begin
  bitmap := TBitmap.create;
  try
    qr := TDelphiZXingQRCode.create;
    try
      qr.Data := ATexto;

      // ajuta o tamanho do bitmap para o tamanho do qrcode
      bitmap.SetSize(qr.Rows, qr.Columns);

      // copia o qrcode para o bitmap
      for r := 0 to qr.Rows - 1 do
        for c := 0 to qr.Columns - 1 do
          if qr.IsBlack[r, c] then
            bitmap.Canvas.Pixels[c, r] := clBlack
          else
            bitmap.Canvas.Pixels[c, r] := clWhite;

      // prepara para redimensionar o qrcode para o tamanho do canvas
      if (AWidth < bitmap.Height) then
      begin
        scala := AWidth / bitmap.Width;
      end
      else
      begin
        scala := AHeight / bitmap.Height;
      end;

      // transfere o bitmap para a imagem
      ACanvas.StretchDraw(Rect(0, 0, Trunc(scala * bitmap.Width),
        Trunc(scala * bitmap.Height)), bitmap);

    finally
      qr.Free;
    end;
  finally
    bitmap.Free;
  end;
end;

// transferindo o QRCode para a imagem (Canvas)
procedure TForm10.Button1Click(Sender: TObject);
begin
  QrCodeToCanvas(Image1.Width, Image1.Height,LabeledEdit1.Text, Image1.Canvas);
end;




end.
