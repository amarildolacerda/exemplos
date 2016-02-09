unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, DB, DBTables, db_STORE,
  ExtCtrls, DBNav98, StdCtrls;

type
  TForm6 = class(TForm)
    ALQuery1: TALQuery;
    DataSource1: TDataSource;
    JvDBGrid1: TJvDBGrid;
    DBNav981: TDBNav98;
    Edit1: TEdit;
    StaticText1: TStaticText;
    Button1: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ALQuery1BeforeOpen(DataSet: TDataSet);
    procedure DBNav981Localizar(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Button1Click(Sender: TObject);
  private
    FDatabasename: string;
    FFilial: extended;
    procedure SetDatabasename(const Value: string);
    procedure SetFilial(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    property Databasename:string read FDatabasename write SetDatabasename;
    property Filial: extended read FFilial write SetFilial;
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}
uses mFunctions, uTab_Ctgrupo, stFunctions;

procedure TForm6.ALQuery1BeforeOpen(DataSet: TDataSet);
begin
    //alquery1.ParamByName('filial').asInteger := filial;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
  with GetCtgrupo_Items(FDatabasename) do
  begin
    //close;
    //open;

  end;
end;

procedure TForm6.DataSource1DataChange(Sender: TObject; Field: TField);
var attrib : TCtgrupoItem;
   prod :TProdutoAttrib;
begin
//    function GetCtgrupoAttrib( grupo:variant;var attrib: TCtgrupoItem;db:string='Estoque'):boolean;
   if getCtGrupoAttrib(alquery1.fieldByName('Grupo').asString,attrib,fDatabasename) then
   begin
      StaticText1.caption := attrib.Nome;
   end;



   GetProduto( alquery1.FieldByName('codigo').asString,prod,fDatabasename,false  );
   Label1.caption := FloatToStr(prod.PrecoVenda);


end;

procedure TForm6.DBNav981Localizar(Sender: TObject);
begin
  OkDlg('chamou evento loalizar');
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
    FDatabasename := 'SQLEstoque';
    FFilial := FilialCorrente;


    alquery1.SQLDBFile := 'ctprod a';
    alquery1.SQLFields := 'a.codigo, a.grupo, a.nome, a.setor,a.unidade,a.precovenda';
    alquery1.ActiveSqlUpdate('ctprod','codigo' );


    // aplica controle de transacao automatica
    alquery1.AutoTransction := true;



end;

procedure TForm6.FormShow(Sender: TObject);
begin
 if not alquery1.active then
 begin

    alquery1.databasename := FDatabasename;
    alquery1.open;



 end;

end;

procedure TForm6.SetDatabasename(const Value: string);
begin
  FDatabasename := Value;
end;

procedure TForm6.SetFilial(const Value: Integer);
begin
  FFilial := Value;
end;

end.
