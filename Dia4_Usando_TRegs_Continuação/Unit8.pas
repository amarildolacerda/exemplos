unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, db_STORE, Grids, DBGrids, JvMemoryDataset, StdCtrls,
  qst_financeiro;

type
  TForm8 = class(TForm)
    ALQuery1: TALQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    JvMemoryData1: TJvMemoryData;
    JvMemoryData1dcto: TStringField;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button2: TButton;
    Label1: TLabel;
    JvMDCheque: TJvMemoryData;
    DSCheque: TDataSource;
    DBGCheque: TDBGrid;
    ALQCheque: TALQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ALQuery1AfterOpen(DataSet: TDataSet);
    procedure ALQChequeAfterOpen(DataSet: TDataSet);
  private
    FDatabasename: string;
    FFilial: extended;

    procedure SetDatabasename(const Value: string);
    procedure SetFilial(const Value: integer);
    { Private declarations }
  public
    { Public declarations }
    property Databasename:string read FDatabasename write SetDatabasename;
    property Filial: extended read FFilial write SetFilial;
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

uses
  mFunctions;

var
  RegChq: TRegCheque;
  RegSig02: TRegCaixa;


procedure TForm8.ALQChequeAfterOpen(DataSet: TDataSet);
begin
    JvMDCheque.Close;
    JvMDCheque.LoadFromDataSet(ALQCheque,0,lmCopy  );
    JvMDCheque.open;
end;

procedure TForm8.ALQuery1AfterOpen(DataSet: TDataSet);
begin
    JvMemoryData1.close;
    JvMemoryData1.LoadFromDataSet(alquery1,0,lmCopy  );
    JvMemoryData1.open;



end;

procedure TForm8.Button1Click(Sender: TObject);
begin
  if not Assigned (RegSig02) then
   RegSig02:= TRegCaixa.Create(nil);

   RegSig02.DatabaseName:= FDatabasename;
   RegSig02.Filial:=FFilial;

   RegSig02.Operacao:='211';
   RegSig02.Conta:='399';

   RegSig02.Data:=Date;
   RegSig02.Dcto:=Edit1.Text;
   RegSig02.IDRefer:=StrToFloatEx(Edit1.Text);
   RegSig02.PrtSerie:='DESENV05';
   RegSig02.NotaFiscal:=Edit3.Text;

   RegSig02.Execute;


  if not Assigned (RegChq) then
   RegChq:=  TRegCheque.Create(Nil);


   RegChq.tipo:=tpcPDV;
   RegChq.DatabaseName:= FDatabasename;
   RegChq.Filial:= FFilial;
   RegChq.Compensacao:='1';
   RegChq.Banco:='399';
   RegChq.Agencia:='0909';
   RegChq.cheque:='2555';
   RegChq.CMC7:='';
   RegChq.dcto:='11';
   RegChq.CliFor:=1;
   RegChq.NomeEmitente:='AMARILDO FERNANDES';
   RegChq.Valor:=100.00;
   RegChq.DataBoa:=Date;
   RegChq.Emissao:=Date;

   RegChq.IDControl:= RegSig02.idLcto;
   RegChq.IDRefer:= RegSig02.IDRefer;
   RegChq.OrdemSig02Cp:= RegSig02.Ordem;
   RegChq.Execute;


  alquery1.reopen;
  ALQCheque.reopen;

end;

procedure TForm8.Button2Click(Sender: TObject);
begin
    alquery1.first;
    while alquery1.eof=false do
    begin
      alquery1.delete;
    end;
    alquery1.reopen;

    ALQCheque.first;
    while ALQCheque.eof=false do
    begin
      ALQCheque.delete;
    end;
    ALQCheque.reopen;

end;

procedure TForm8.FormCreate(Sender: TObject);
begin
   Databasename := 'Estoque';
   filial := FilialCorrente;

   ConnectDataBaseFromIni('SqlEstoque','Estoque','Estoque.ini',true);

   ALQuery1.ActiveSqlUpdate('Sig02','DATA=:OLD_DATA and DCTO=:OLD_DCTO and Filial=:OLD_FILIAL '+
      'and IDREFER=:OLD_IDREFER and PRTSERIE=:OLD_PRTSERIE');


   ALQCheque.ActiveSqlUpdate('pdvcheq','FILIAL=:OLD_FILIAL and IDREFER=:OLD_IDREFER and '+
    'PRTSERIE=:OLD_PRTSERIE' );

end;

procedure TForm8.FormShow(Sender: TObject);
begin
    alquery1.open;
    ALQCheque.open;

end;

procedure TForm8.SetDatabasename(const Value: string);
begin
  FDatabasename := Value;
  DataBaseNameChange(self,value);
end;

procedure TForm8.SetFilial(const Value: integer);
begin
  FFilial := Value;
end;



initialization

finalization
  if Not Assigned (RegChq) then
   begin
     RegChq.Free;
     RegChq:=nil;
   end;

// ou
{
  if RegChq <> nil then
     rRegChq.Free;

 ou
  freeAndNil(RegChq);

}

  if not Assigned (RegSig02) then
   begin
     RegSig02.Free;
     RegSig02:=nil;
   end;


end.
