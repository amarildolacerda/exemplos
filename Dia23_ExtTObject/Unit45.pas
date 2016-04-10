unit Unit45;

interface

uses
  Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Classes.Helper,
  Vcl.StdCtrls;

type

//  [TFireEventAttribute]
  TObjectNew = class(TObjectExt)
   public
  end;

  TForm45 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    FObject:TObjectNew;
  public
    { Public declarations }
  end;

var
  Form45: TForm45;

implementation

{$R *.dfm}
//uses
//system.uJson;

procedure TForm45.Button1Click(Sender: TObject);
begin
    FObject.FireEvent();
end;

procedure TForm45.Button2Click(Sender: TObject);
begin
   FObject.Run<TObject>(Sender,
      procedure (sender:TObject) begin
          showMessage('Run');
      end);
end;

procedure TForm45.Button3Click(Sender: TObject);
begin
  FObject.Anonimous<TForm>(self,
      procedure (sender:TForm) begin
          showMessage('Anonimous');
      end);
end;

procedure TForm45.Button4Click(Sender: TObject);
begin
  FObject.Synchronize<TForm>(self,
      procedure (sender:TForm) begin
          showMessage('Synchronize');
      end);

end;

procedure TForm45.Button5Click(Sender: TObject);
begin
  FObject.Queue<TForm>(self,
      procedure (sender:TForm) begin
          showMessage('Queue');
      end);

end;

procedure TForm45.FormCreate(Sender: TObject);
begin
   FObject := TObjectNew.Create;
   FObject.OnFireEvent := procedure (sender:TObject)
                       begin
                         showmessage('Evento');
                       end;
end;

end.
