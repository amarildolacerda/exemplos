unit uFMXListas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid.Style,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, FMX.Bind.Grid, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.ObjectScope,
  FMX.ScrollBox, FMX.Grid, FMX.Edit;

type

  TBaseClass = Class
  public
    Nome: string;
  End;

  TBaseClass2 = class(TBaseClass)

  end;

  TListaBase = class(TObjectList<TBaseClass2>)
  public
    function Add: TBaseClass2; overload;
    function Find(const AText: string): Integer;
  end;

  TForm41 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    AdapterBindSource1: TAdapterBindSource;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceAdapterBindSource1: TLinkGridToDataSource;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AdapterBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    FLista: TListaBase;
  public
    { Public declarations }
  end;

var
  Form41: TForm41;

implementation

{$R *.fmx}

procedure TForm41.AdapterBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  FLista := TListaBase.create(true);
  ABindSourceAdapter := TListBindSourceAdapter<TBaseClass2>.create(self,
    FLista, false);
end;

procedure TForm41.Button1Click(Sender: TObject);
{ var
  obj: TBaseClass;
}
begin

  { obj := TBaseClass.create;
    obj.Nome := 'List: ' + datetimeToStr(now);
    FLista.Add(obj);
  }
  with FLista.Add do
  begin
    // nome := 'Lista2: '+ datetimeToStr(now);

    Nome := Edit2.Text;

  end;

  AdapterBindSource1.InternalAdapter.Refresh;

  Edit1.Text := FLista.Count.ToString;

end;

procedure TForm41.Button2Click(Sender: TObject);
begin
  if StringGrid1.Row >= 0 then
    FLista.Delete(StringGrid1.Row);
  AdapterBindSource1.InternalAdapter.Refresh;

  Edit1.Text := FLista.Count.ToString;

end;

procedure TForm41.Button3Click(Sender: TObject);
var
  it: TBaseClass;
  i: Integer;
begin

  i := FLista.Find(Edit2.Text);
  if i >= 0 then
    StringGrid1.Row := i;
  { i :=-1;
    for it in FLista do
    begin
    inc(i);
    if it.Nome = edit2.text then
    begin

    StringGrid1.Row :=  i;
    edit1.Text := i.ToString;
    exit;
    end;
    end;
  }

end;

procedure TForm41.Button4Click(Sender: TObject);
begin
  FLista.Clear;
  AdapterBindSource1.InternalAdapter.Refresh;

end;

procedure TForm41.Button5Click(Sender: TObject);
var obj:TBaseClass2;
begin
    obj:=TBaseClass2.create;
    obj.Nome := dateTimeToStr(now);
    fLista.Insert( StringGrid1.Row, obj   );
      AdapterBindSource1.InternalAdapter.Refresh;

    end;

procedure TForm41.FormDestroy(Sender: TObject);
begin
  FLista.Free;
end;

{ TListaBase }

function TListaBase.Add: TBaseClass2;
begin
  result := TBaseClass2.create;
  inherited Add(result);
end;

function TListaBase.Find(const AText: string): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
    if items[i].Nome = AText then
    begin
      result := i;
      exit;
    end;
end;

end.
