unit UnitQuickReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, QuickRpt,
  Data.DB, Datasnap.DBClient, QRCtrls, qrQrCode, Datasnap.Provider,
  JvMemoryDataset, MemTable;

type
  TForm10 = class(TForm)
    Image1: TImage;
    LabeledEdit1: TLabeledEdit;
    Button1: TButton;
    QuickRep1: TQuickRep;
    Preview: TButton;
    DetailBand1: TQRBand;
    qrDBQRCode1: TqrDBQRCode;
    MemoryTable1: TMemoryTable;
    MemoryTable1Texto: TStringField;
    QRDBText1: TQRDBText;
    procedure Button1Click(Sender: TObject);
    procedure PreviewClick(Sender: TObject);
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


// transferindo o QRCode para a imagem (Canvas)
procedure TForm10.Button1Click(Sender: TObject);
begin
  QrCodeToCanvas(Image1.Width, Image1.Height,LabeledEdit1.Text, Image1.Canvas);
end;




procedure TForm10.FormCreate(Sender: TObject);
begin

   qrDBQRCode1.Datafield := 'texto';
   QRDBText1.DataField := 'texto';


   qrDBQrCode1.Dataset := MemoryTable1;
   with MemoryTable1 do
   begin
     append;
     fieldByName('texto').asString := 'meu texto qrcode 1 ';
     Post;

     append;
     fieldByName('texto').asString := 'meu texto qrcode 2 ';
     Post;
     append;
     fieldByName('texto').asString := 'meu texto qrcode 3 ';
     Post;
     append;
     fieldByName('texto').asString := 'meu texto qrcode 4 ';
     Post;
     append;
     fieldByName('texto').asString := 'meu texto qrcode 5 ';
     Post;




     first;
   end;
end;

procedure TForm10.PreviewClick(Sender: TObject);
begin
 quickrep1.preview;
end;

end.
