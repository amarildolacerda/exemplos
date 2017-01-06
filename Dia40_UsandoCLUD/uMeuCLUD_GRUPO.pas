unit uMeuCLUD_GRUPO;
 {
   autor: KZUCA;
   data: 05/01/2017 16:34:11;
 ------------------------------------------------------------------------
   CODIGO GERADO AUTOMATICAMENTE POR: TabelaTORecordPascal
   NAO ADICINAR NOVOS METODOS NESTA UNIT
   SE NECESSARIO CRIAR NOVA UNIT   <unitBASE> com o codigo gerado automático E IMPLEMENTAR POR HERANÇA OU HELPER em nova unit
  }

{$I delphi.inc}
interface

uses System.Classes,  System.SysUtils, System.Classes.Helper,
{$ifdef VCL}{Windows,Messages,DllFunctions,}{$else} FMX.mFunctions,
{$endif} System.JSON, Data.dbFunctions, Data.Attributes,
 DB, Data.db_store, Data.db_store_types, System.uJson,
Data.DsCollection, System.Generics.Collections;


Type
[Description('Armazena os atributo para a tabela Ctgrupo')]
  TCtgrupo_Attrib=Record  // Colunas para a tabela ctgrupo
 private
[Hide]
  achei:boolean;
 public
    [VarChar(32)]
    Bmp : String;
    [VarChar(10)]
    [FieldRequired('Grupo','Valor obrigatório, não pode ficar sem informação')]
    [PrimaryKey]
    Grupo : String;
    [VarChar(50)]
    Nome : String;
    Comissao : Double;
    Dtatualiz : TDateTime;
    [VarChar(10)]
    Setor : String;
    [VarChar(1)]
    Producao : String;
    [VarChar(1)]
    Issintetico : String;
    [VarChar(10)]
    Sintetico : String;
    [VarChar(1)]
    Controle_Sobras : String;
  Public
    DatabaseName:String;
    function ToJson:String;
    function asJson:TJSONObject;
    function Colunas:String;
    procedure PreencheDados(qry: TDataset); // preenche os atributos
    procedure AtribuiQueryFields(qry:TDataset); // passa os atributos para os fields da query
    procedure FillParams(prms:TParamsBase);
    function GetWhere:String;
    function Insert:boolean;
    function Update:Boolean;
    function Delete:boolean;
    procedure ValidateRecord;
    procedure FromJson(AJson:String);
    procedure Assing(Source:TCtgrupo_Attrib);
  End;

Type
  [TableRecordSet('ctgrupo')]
  TCtgrupoItem = class(TDsObjectListItemRec<TCtgrupo_Attrib>)
    public
      function ToJson:String;override;
      procedure FromJson(AJson:string);override;
  end;

  // items para Ctgrupo
  [Description('Implementa funcionalidade de acesso a tabela: Ctgrupo')]
  [Table('ctgrupo')]
  [Index('CTGRUPO','CTGRUPOSINT','SINTETICO',False)]
  TCtgrupoItems = class(TDsObjectList<TCtgrupoItem>)
    private
    protected
      FReloadDatetime:TDatetime; // marca data para proxima recarga dos dados
    public
      destructor destroy;override;
      function Find(AGrupo: String):integer; //localiza chave na lista e retorna a posição
      function FindItem(AGrupo: String):TCtgrupoItem;
      function Add:TCtgrupoItem;overload;
      function ToJson:String; override;
      procedure Load(atualizar:boolean=false); //carrega o conteúdo todo da tabela para a lista
      procedure AppendToDataset(qry:TDataset); //transfere os itens da lista para o dataset
      procedure PreencheDados(qry: TDataset; var attrib: TCtgrupo_Attrib); // gera a listra com base no attributo
  //    procedure GetLookupDataset(ds: TDataset);  // preenche um lookup com os dados
      procedure AtribuiDadosDaQuery(qry:TDataset); // carrega os dados do dataset para a lista
      procedure AtribuiQueryFields(qry:TDataset; attrib:TCtgrupo_Attrib); // preenche um record do data com o attributo passado
      function Fields: TCtgrupo_Attrib;
      function Localiza(AGrupo: String): TCtgrupo_Attrib;
      procedure PreencheCamposDataSet(AQry: TDataSet; ACampo: string = '');
      procedure AppendJsonItem(AJson:string);override;
    end;

function GetCtgrupo_Items(db:string):TCtgrupoItems; // retorna a lista
function GetCtgrupoAttrib( AGrupo: String;var attrib: TCtgrupo_Attrib;db:string='Estoque'):boolean; // procura na lista, se nao encontrar, carrega do banco de dados

Implementation

const tabela:string = 'Ctgrupo';

{ obtem formatação ToJson para attrib }
function TCtgrupo_Attrib.AsJson:TJSONObject;
begin
    result := TJson.FromRecord<TCtgrupo_Attrib>(self);

end;

function TCtgrupo_Attrib.ToJson:String;
begin result := AsJson.ToString; end;


function TCtgrupo_Attrib.Colunas:String;
var
  str: TStringList;
Begin
  str := TStringList.create;
  try
    TObject.&ContextGetRecordFieldsList<TCtgrupo_Attrib>(str,self);
    str.Delimiter := ',';
    result := str.DelimitedText;
  finally
    str.Free;
  end;
End;

procedure TCtgrupo_Attrib.FillParams(prms:TParamsBase);
Begin
   ValidateRecord();
   TALQuery.FillParams<TCtgrupo_Attrib>(self,prms);

End;

function TCtgrupo_Attrib.GetWhere:String;
Begin
  result := 'grupo = :OLD_Grupo';
End;

function TCtgrupo_Attrib.insert:boolean;
 var qry:TAlQuery;
Begin
  qry := createQuery(databasename);
  try
    qry.sql.text := CreateQueryInsertFromString('ctgrupo',colunas) ;
     fillParams(qry.params);
     qry.execSql;
     result := qry.RowsAffected>0;
  finally
    qry.free;
  end;
End;

function TCtgrupo_Attrib.update:boolean;
 var qry:TAlQuery;
Begin
  qry := createQuery(databasename);
  try
    qry.sql.text := CreateQueryUpdateFromString('ctgrupo',colunas,GetWhere) ;
     fillParams(qry.params);
     qry.execSql;
     result := qry.RowsAffected>0;
  finally
    qry.free;
  end;
End;

procedure TCtgrupo_Attrib.FromJson(AJson:String);
 var J:TJsonObject;
   function fillJSON(aNome:string):variant;
   var s:string;
   begin
     j.TryGetValue<string>(aNome,s);
   result := s;
 end;
begin
     j := TJsonObject.ParseJSONValue(AJson) as TJsonObject;
     j.ToRecord<TCtgrupo_Attrib>(self);
     ValidateRecord();
end;

procedure TCtgrupo_Attrib.Assing(Source:TCtgrupo_Attrib);
Begin
 self := Source;//   assingSource
End;

function TCtgrupo_Attrib.delete:boolean;
 var qry:TAlQuery;
Begin
  qry := createQuery(databasename);
  try
    qry.sql.text := CreateDeleteSql('ctgrupo',GetWhere) ;
     fillParams(qry.params);
     qry.execSql;
     result := qry.RowsAffected>0;
  finally
    qry.free;
  end;
End;

 procedure TCtgrupo_Attrib.ValidateRecord;
  begin
    TValidateAttribute.ValidateRecord<TCtgrupo_Attrib>(self);
  end;



procedure TCtgrupoItem.FromJson(AJson:string);
Begin
   dados.FromJson(AJson);
End;

procedure TCtgrupoItems.AppendJsonItem(AJson:string);
 var it : TCtgrupoItem;
Begin
   inherited;
   it := add;
   it.FromJson(AJson);
End;
//gerar json codigo para a lista de linhas
function TCtgrupoItems.ToJson:String;
var i:integer;
    j:TJSONObject;
    A:TJSONArray;
begin
 with lock do TRY
  j := TJSONObject.create;
  A := TJSONArray.create;
  j.addPair( TJsonPair.create('table','Ctgrupo'));
  j.addPair( 'rows', TJsonNumber.create(count));
  for i := 0 to Count - 1 do
    begin
       a.addElement( items[i].dados.asJson );
    end;
   j.addPair(TJsonPair.create('result',a));
    result := j.ToString();
 Finally   Unlock;   end;
end;


Function TCtgrupoItems.Add:TCtgrupoItem;
Begin
 with lock do TRY
  result := TCtgrupoItem.create;
  add(result);
  result.dados.DatabaseName := self.DatabaseName;
 Finally   Unlock;   end;
End;

Destructor TCtgrupoItems.destroy;
Begin
   inherited destroy;
End;
function TCtgrupoItems.Fields:TCtgrupo_Attrib;
begin
  fillchar(result,sizeof(TCtgrupo_Attrib),#0);
  if (not eof) and (not bof) then
    begin
 with lock do TRY
     result := items[recNo].Dados;
 Finally   Unlock;   end;
     result.achei := true;
    end;
end;

function TCtgrupoItems.Localiza(AGrupo: String): TCtgrupo_Attrib;
var i:integer;
begin
    FillChar(result,sizeof(TCtgrupo_Attrib),#0);
    i := find(AGrupo);
    if i>=0 then
      begin
 with lock do TRY
         result := items[i].Dados;
 Finally   Unlock;   end;
         result.achei := true;
      end;
end;

procedure TCtgrupoItems.PreencheCamposDataSet(AQry: TDataSet; ACampo: string = '');
  procedure PreencheField(AField: string; ADataType: TFieldType; ASize: Integer);
  begin
    if AQry.FieldDefs.IndexOf(AField) = - 1 then
      AQry.FieldDefs.Add(AField, ADataType, ASize);
  end;
begin
  if (Trim(ACampo) = '') or (SameText(UpperCase(ACampo), 'BMP')) then
    PreencheField('BMP',ftString,32);
  if (Trim(ACampo) = '') or (SameText(UpperCase(ACampo), 'GRUPO')) then
    PreencheField('GRUPO',ftString,10);
  if (Trim(ACampo) = '') or (SameText(UpperCase(ACampo), 'NOME')) then
    PreencheField('NOME',ftString,50);
  if (Trim(ACampo) = '') or (SameText(UpperCase(ACampo), 'COMISSAO')) then
    PreencheField('COMISSAO',ftFloat,0);
  if (Trim(ACampo) = '') or (SameText(UpperCase(ACampo), 'DTATUALIZ')) then
    PreencheField('DTATUALIZ',ftDatetime,0);
  if (Trim(ACampo) = '') or (SameText(UpperCase(ACampo), 'SETOR')) then
    PreencheField('SETOR',ftString,10);
  if (Trim(ACampo) = '') or (SameText(UpperCase(ACampo), 'PRODUCAO')) then
    PreencheField('PRODUCAO',ftString,1);
  if (Trim(ACampo) = '') or (SameText(UpperCase(ACampo), 'ISSINTETICO')) then
    PreencheField('ISSINTETICO',ftString,1);
  if (Trim(ACampo) = '') or (SameText(UpperCase(ACampo), 'SINTETICO')) then
    PreencheField('SINTETICO',ftString,10);
  if (Trim(ACampo) = '') or (SameText(UpperCase(ACampo), 'CONTROLE_SOBRAS')) then
    PreencheField('CONTROLE_SOBRAS',ftString,1);
end;

function TCtgrupoItems.FindItem(AGrupo: String):TCtgrupoItem;
 var i:integer;
Begin
  result := nil;
  i := find(AGrupo);
 with lock do TRY
  if i>=0 then result := items[i];
 Finally   Unlock;   end;
End;

procedure TCtgrupoItems.Load(atualizar:boolean=false);
var qry:TAlQuery;
begin
 if not atualizar then
   if now < FReloadDatetime then exit;

   //if not assigned(dataset) then begin
     qry := createQuery(Databasename);
   try
     qry.sqlDbFile := tabela;
     qry.open;
 with lock do TRY
    Clear;
 Finally   Unlock;   end;
    AtribuiDadosDaQuery(qry);
    FReloadDatetime:= now+StrToTime('00:30:00');
    First;
   Finally
    qry.free;
   end;
  //end;
end;

procedure TCtgrupoItems.AppendToDataset(qry: TDataset);
var i:integer;
begin
 with lock do TRY
   for I := 0 to Count - 1 do
   begin
     qry.append;
     AtribuiQueryFields(qry,items[i].Dados);
     qry.post;
   end;
 Finally   Unlock;   end;
end;

procedure TCtgrupo_Attrib.AtribuiQueryFields(qry:TDataset);
begin
  TAlQuery.FillFields<TCtgrupo_Attrib>(self,qry);
end;

procedure TCtgrupoItems.AtribuiQueryFields(qry:TDataset; attrib:TCtgrupo_Attrib);
begin
   attrib.AtribuiQueryFields(qry);
end;

function TCtgrupoItems.Find(AGrupo: String):integer;
   var i:integer;
begin
     result := -1;
 with lock do TRY
     for i:=0 to count - 1 do
      begin
        with TCtgrupoItem(items[i]).dados  do
        if (Grupo=AGrupo) then
        begin
           result := i;
           FRecAtual:=i;
           exit;
        end;
      end;
 Finally   Unlock;   end;
end;

 var LCtgrupo: TCtgrupoItems;

 // funcao de busca
function GetCtgrupo_Items(db:string):TCtgrupoItems;
begin
  if not assigned(LCtgrupo) then
  begin
    LCtgrupo := TCtgrupoItems.create();
  end;
  if db<>'' then  LCtgrupo.databasename := db;
  result := LCtgrupo;
end;

function GetCtgrupoAttrib( AGrupo: String;var attrib: TCtgrupo_Attrib;db:string='Estoque'):boolean;
var achou:integer; qry:TAlQuery;
begin
  result := false;
  fillchar(attrib,sizeof(attrib),#0);
  GetCtgrupo_Items(db);

    achou:= LCtgrupo.find(AGrupo);
    if achou>=0 then
       begin
 with LCtgrupo.lock do Try
         attrib := TCtgrupoItem(items[achou]).dados;
    finally  LCtgrupo.unlock; end;
         attrib.achei := true;
         result := true;
         exit;
       end
       else
       begin
         qry := createquery(db,'Ctgrupo','GRUPO = :GRUPO');
         try
           with qry do begin
           ParamByName('GRUPO').value := AGrupo
           end;
           qry.open;
           while qry.eof=false do
           begin
             with TCtgrupoItem(LCtgrupo.add) do
             begin
               LCtgrupo.PreencheDados(qry,dados);
               Dados.achei := true;
               Attrib := Dados;
               result := true;
             end;
             qry.next;
           end;
         finally
           qry.Free;
         end;
       end;
end;

procedure TCtgrupo_Attrib.PreencheDados(qry:TDataset);
begin
   TAlQuery.FieldToRecord<TCtgrupo_Attrib>(self,qry);
end;

procedure TCtgrupoItems.PreencheDados(qry: TDataset; var attrib: TCtgrupo_Attrib);
begin
    try
      attrib.PreencheDados(qry);
    finally
    end;
end;

{procedure TCtgrupoItems.GetLookupDataset(ds: TDataset);
var i:integer;
begin
 with lock do TRY
 if count=0 then Load(true); for I := 0 to Count - 1 do
begin
    ds.append;
    ds.FieldByName('codigo').Value := TCtgrupoItem(Items[I]).dados.Codigo;
    ds.FieldByName('nome').Value := TCtgrupoItem(Items[I]).dados.Nome;
    ds.Post;
 end;
 Finally   Unlock;   end;
end;}

procedure TCtgrupoItems.AtribuiDadosDaQuery(qry:TDataset);
var attrib:TCtgrupo_Attrib;book:TBookMark;
begin
   // passa os valor do Dataset para a lista

   book :=qry.GetBookmark;
   try
     qry.DisableControls;
     qry.first;
     with qry do
     while qry.eof=false do begin
          with TCtgrupoItem(add) do
          begin
             PreencheDados(qry,dados);
             dados.achei := true;
             Attrib := dados;
          end;
          qry.next;
     end;
   RecNo(); // reposiciona o recordset
  finally
    qry.GotoBookmark(book);
    qry.FreeBookMark(book);
    qry.EnableControls;
  end;
end;

function TCtgrupoItem.ToJson():String;
begin
   result := dados.ToJson;
end;

initialization


finalization
 FreeAndNil(LCtgrupo);



end.
