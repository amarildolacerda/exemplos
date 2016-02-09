unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, ValEdit, DB, JvMemoryDataset, DBGrids,
  JvExDBGrids, JvDBGrid, ComCtrls;

type
  TForm6 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Calcular: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    JvDBGrid1: TJvDBGrid;
    JvMemoryData1: TJvMemoryData;
    JvMemoryData1Destino: TStringField;
    JvMemoryData1Duracao: TStringField;
    DataSource1: TDataSource;
    JvMemoryData1Distancia: TStringField;
    procedure CalcularClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

uses googleApi;

procedure TForm6.CalcularClick(Sender: TObject);
var i:integer;
    gDis:TGoogleMapDistance;
begin
    gDis:=TGoogleMapDistance.create;
    try
       gDis.GetDistancia(LabeledEdit1.text,LabeledEdit2.text);
//       ValueListEditor1.Strings.text := gdis.text;
      JvMemoryData1.open;
      JvMemoryData1.EmptyTable;
      for I := 0 to gDis.Count - 1 do
      begin
        JvMemoryData1.Append;
        JvMemoryData1Destino.Value := gDis.items[i].endereco;
        JvMemoryData1Distancia.Value := gDis.Items[i].distancia_text;
        JvMemoryData1Duracao.Value := gDis.Items[i].duracao_text;
        JvMemoryData1.post;
      end;
        

    finally
      gDis.free;
    end;
end;

end.
