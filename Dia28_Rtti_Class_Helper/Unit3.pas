unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    ListBox1: TListBox;
    Edit2: TEdit;
    Button3: TButton;
    ListBox2: TListBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ListBox3: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
uses System.Classes.helper, System.TypInfo;

procedure TForm3.Button1Click(Sender: TObject);
begin
   Button1.GetPropertiesList( ListBox1.Items, [mvPublished] );   // pega uma lista de properiedades do Button1
   edit2.Text := Button1.Properties['Caption'].AsString;   // pega o valor da propriedade caption

   Label1.Caption := intToStr( button1.PropertyCount  );

end;

procedure TForm3.Button2Click(Sender: TObject);
begin
   button1.Properties[ 'Caption' ] := edit2.Text;  // altera a proprieda do Caption
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  button1.GetFieldsList( ListBox2.Items, [mvPrivate,mvPublic]  );

  label2.Caption := IntToStr(  Button1.FieldsCount   );

end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  button1.InvokeMethod('Click',[]);  // executa Click do button1
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
   if button1.Properties['xxxx'].IsEmpty then
      showmessage('não existe a propriedade');
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
   button1.GetMethodsList( ListBox3.items );
end;

procedure TForm3.ListBox1Click(Sender: TObject);
begin
  edit1.Text := ListBox1.Items[ ListBox1.ItemIndex ];
end;

end.
