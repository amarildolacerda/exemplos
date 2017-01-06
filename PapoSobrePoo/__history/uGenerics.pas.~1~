unit uGenerics;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Generics.collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type

  // fazer um lista de carros
  {
    1.  usando TCollection
    2.         TList / TObjectList
    3.         Generics

  }

  TForm41 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    procedure ExemploGenericsRecord;
    { Private declarations }
  public
    { Public declarations }
    procedure ExemploCollection;
    procedure ExemploList;
    procedure ExemploObjectList;
    procedure ExemploGenerics;

  end;

var
  Form41: TForm41;

implementation

{$R *.dfm}

uses System.Contnrs;

// exemplo com collection

Type
  // TCollectionItemClass = class of TCollectionItem ;

  TCarrosItem = class(TCollectionItem)
  public
    modelo: string;
    placa: string;
    ano: integer;
    cor: TColor;
  end;

  TListaCarroItems = class(TCollection)
  public
    function Add: TCarrosItem;
  end;

  // TList
  TCarrosListItem = class
  public
    modelo: string;
    placa: string;
    ano: integer;
    cor: TColor;
  end;


  TCarrosListItemRec = Record
  public
    modelo: string;
    placa: string;
    ano: integer;
    cor: TColor;
  end;


procedure TForm41.Button1Click(Sender: TObject);
begin
  ExemploCollection;
end;

procedure TForm41.Button2Click(Sender: TObject);
begin
  ExemploList;
end;

procedure TForm41.Button3Click(Sender: TObject);
begin
  ExemploObjectList;
end;

procedure TForm41.Button4Click(Sender: TObject);
begin
  ExemploGenerics;
end;

procedure TForm41.Button5Click(Sender: TObject);
begin
  ExemploGenericsRecord;
end;

procedure TForm41.ExemploCollection;
var
  LCarros: TListaCarroItems;
  LItem: TObject;

  LItem2, LItem3: TCarrosItem;
  i:integer;
begin
  LCarros := TListaCarroItems.create(TCarrosItem);
  try

    LItem := LCarros.Add;
    TCarrosItem(LItem).modelo := 'passat';

    // showMessage( LCarros.Count.ToString +' - '+ TCarrosItem(LItem).Modelo );

    LItem2 := TCarrosItem(LCarros.Add);
    LItem2.modelo := 'volks';

    showMessage(LCarros.Count.ToString + ' - ' + LItem2.modelo);

    LItem3 := LCarros.Add;
    LItem3.modelo := 'fiat 147';

    //showMessage(LCarros.Count.ToString + ' - ' + LItem3.modelo);

    for I := 0 to LCarros.Count-1 do
      begin
        //....
      caption := ( LCarros.Items[I] as TCarrosItem).modelo;///
      end;
  finally
    LCarros.Free;
  end;
end;

procedure TForm41.ExemploGenerics;
var
  LCarros: TObjectList<TCarrosListItem>;
  LItem: TCarrosListItem;
  i:integer;
  it: TCarrosListItem;
begin
  LCarros := TObjectList<TCarrosListItem>.create(true);
  try
    LItem := TCarrosListItem.create;
    LCarros.Add(LItem);


    /// ou com FOR
    for I := 0 to LCarros.count-1 do
    begin
     caption := LCarros.Items[i].modelo;
    end;


    // ou com FORIN
    for it in LCarros do
    begin
      caption := it.modelo;
    end;



  finally
    LCarros.Free;
  end;

end;



procedure TForm41.ExemploGenericsRecord;
var
  LCarros: TList<TCarrosListItemRec>;
  LItem: TCarrosListItemRec;
  i:integer;
  it: TCarrosListItemRec;
begin
  LCarros := TList<TCarrosListItemRec>.create;
  try
    LItem.modelo := 'passat geracao 3';
    LCarros.Add(LItem);


    /// ou com FOR
    for I := 0 to pred(LCarros.count) do
    begin
     caption := LCarros.Items[i].modelo;
    end;


    // ou com FORIN
    for it in LCarros do
    begin
      caption :=Caption +'|'+ it.modelo;
    end;



  finally
    LCarros.Free;
  end;

end;


procedure TForm41.ExemploList;
var
  LList: TList;
  LItem: TCarrosListItem;
  L: TObject;
  i:integer;
begin
  LList := TList.create;
  try
    LItem := TCarrosListItem.create;
    LItem.modelo := 'passat2';

    LList.Add(LItem);

    showMessage(LList.Count.ToString + ' - ' + LItem.modelo);


    for I := 0 to LList.Count-1 do
      begin
       caption :=  TCarrosListItem(LList.Items[i]).modelo; //

      end;

    while LList.Count > 0 do
    begin
      try
        L := LList.Items[0];
        L.Free;
        LList.Delete(0);
      except
        break;
      end;
    end;

  finally
    LList.Free;
  end;
end;

procedure TForm41.ExemploObjectList;
var
  LList: TObjectList;
  LItem: TCarrosListItem;
  L: TObject;
begin
  LList := TObjectList.create(true);
  try
    LItem := TCarrosListItem.create;
    LItem.modelo := 'passat2';

    LList.Add(LItem);

    showMessage(LList.Count.ToString + ' - ' + LItem.modelo);

    { while LList.Count > 0 do
      begin
      try
      L := LList.Items[0];
      L.Free;
      LList.Delete(0);
      except
      break;
      end;
      end;
    }
  finally
    LList.Free;
  end;
end;

{ TListaCarroItems }

function TListaCarroItems.Add: TCarrosItem;
begin
  result := (Inherited Add) as TCarrosItem;
end;

end.
