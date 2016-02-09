Unit Unit6;

Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, db_store, StdCtrls, DB, DBTables, Grids, DBGrids;

Type
  TForm6 = Class(TForm)
    ALQuery1: TALQuery;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button2: TButton;
    Button3: TButton;
    Label2: TLabel;
    Procedure FormCreate(Sender : TObject);
    Procedure Button1Click(Sender : TObject);
    Procedure Button2Click(Sender : TObject);
    procedure ALQuery1BeforeOpen(DataSet: TDataSet);
    procedure ALQuery1AfterInsert(DataSet: TDataSet);
    procedure Button3Click(Sender: TObject);
    procedure ALQuery1AfterEdit(DataSet: TDataSet);
  Private
    FDatabasename: String;
    FFilial: extended;
    FLote : integer;
    Procedure SetDatabasename(Const Value : String);
    Procedure SetFilial(Const Value : Integer);
    procedure AbrirPedido;
    { Private declarations }
  Public
    { Public declarations }
    Property Databasename: String Read FDatabasename Write SetDatabasename;
    Property Filial: extended Read FFilial Write SetFilial;
  End;

Var
  Form6: TForm6;

Implementation

{$R *.dfm}
uses stFunctions;

procedure TForm6.ALQuery1AfterEdit(DataSet: TDataSet);
begin
   //  asdfadf
end;

procedure TForm6.ALQuery1AfterInsert(DataSet: TDataSet);
begin
   alquery1.FieldByName('data').asdateTime := date;
   alquery1.fieldByName('sigcauthlote').asInteger := FLote;
end;

procedure TForm6.ALQuery1BeforeOpen(DataSet: TDataSet);
begin
  alQuery1.paramByName('dcto').asString := edit1.text;
  alQuery1.ParamByName('filial').value := Filial;
end;

Procedure TForm6.Button1Click(Sender : TObject);
Begin
   AbrirPedido;
End;

Procedure TForm6.Button2Click(Sender : TObject);
Begin
   AbrirPedido;
End;

procedure TForm6.Button3Click(Sender: TObject);
begin
   alquery1.append;
   // como nao fazer....  usar o AflerInsert para as inicializações padrao
   // alquery1.FieldByName('data').asDateTime := date;
   // alquery1.fieldByName('sigcauthlote').asInteger := FLote;
end;

Procedure TForm6.FormCreate(Sender : TObject);
Begin
  Databasename := 'Estoque';
  ConnectDataBaseFromIni('SQLEstoque', 'Estoque', 'estoque.ini', True);
  Filial := FilialCorrente;

  alquery1.ActiveSqlUpdate('sigcaut1','dcto=:OLD_dcto and filial=:OLD_filial and ordem=:OLD_ordem and sigcauthlote=:OLD_sigcauthlote ');
  alquery1.AutoTransction := true;
End;

Procedure TForm6.SetDatabasename(Const Value : String);
Begin
  FDatabasename := Value;
  DataBaseNameChange(self, value);
End;

Procedure TForm6.SetFilial(Const Value : Integer);
Begin
  FFilial := Value;
End;

procedure TForm6.AbrirPedido;
begin
  alquery1.close;
  alquery1.open;
end;

End.

