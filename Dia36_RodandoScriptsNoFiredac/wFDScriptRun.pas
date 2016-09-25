unit wFDScriptRun;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, SynEdit,
  Vcl.FileCtrl, JvDriveCtrls, SynEditHighlighter, SynHighlighterSQL,
  FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Comp.Script,
  FireDAC.VCLUI.Script, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls,
  FireDAC.Comp.UI, System.ImageList, Vcl.ImgList;

type
  TForm10 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    JvFileListBox1: TJvFileListBox;
    Panel3: TPanel;
    SynEdit1: TSynEdit;
    Splitter1: TSplitter;
    SynEdit2: TSynEdit;
    SynSQLSyn1: TSynSQLSyn;
    FDScript1: TFDScript;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    Action1: TAction;
    ImageList1: TImageList;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Action2: TAction;
    Action3: TAction;
    procedure JvFileListBox1Click(Sender: TObject);
    procedure FDScript1BeforeExecute(Sender: TObject);
    procedure FDScript1AfterExecute(Sender: TObject);
    procedure FDScript1Error(ASender, AInitiator: TObject;
      var AException: Exception);
    procedure Action1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SynEdit1Change(Sender: TObject);
    procedure FDScript1SpoolPut(AEngine: TFDScript; const AMessage: string;
      AKind: TFDScriptOutputKind);
    procedure FDScript1ConsolePut(AEngine: TFDScript; const AMessage: string;
      AKind: TFDScriptOutputKind);
    procedure Action3Execute(Sender: TObject);
  private
    { Private declarations }
    FCurrenteFileName: string;
    FBaseCaption: String;
    FAlterou: boolean;
    procedure SetAlterou(const Value: boolean);
    procedure executar(AArquivo: string);
  public
    { Public declarations }
    procedure msg(txt: string);
    property Alterou: boolean read FAlterou write SetAlterou;
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

uses Data.fireTables;

procedure TForm10.Action1Execute(Sender: TObject);
begin
  if FDScript1.Connection = nil then
    raise Exception.Create('Falta definir a conexão');

  SynEdit2.Lines.Clear;
  msg('Carregando');
  FDScript1.SQLScripts.Clear;
  with FDScript1.SQLScripts.Add do
  begin
    SQL.Text := SynEdit1.Lines.Text;
  end;
  FDScript1.ExecuteAll;

end;

procedure TForm10.Action2Execute(Sender: TObject);
begin
  if FCurrenteFileName = '' then
    raise Exception.Create('Não esta editando um arquivo');

  SynEdit1.Lines.SaveToFile(FCurrenteFileName);
  Alterou := false;
end;

procedure TForm10.Action3Execute(Sender: TObject);
var
  i: integer;
begin
  SynEdit2.Lines.Clear;

  if JvFileListBox1.SelCount > 0 then
  begin
    for i := 0 to JvFileListBox1.Items.Count - 1 do
      if JvFileListBox1.Selected[i] then
        executar(JvFileListBox1.Items[i]);
  end;
end;

procedure TForm10.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.Text <> '' then
    FDScript1.Connection := FireSession.FindDataBase(ComboBox1.Text);
end;

procedure TForm10.executar(AArquivo: string);
begin
  FCurrenteFileName := AArquivo;
  Alterou := false;

  SynEdit1.Lines.LoadFromFile(AArquivo);
  msg('------------------------------------------------------------------------');
  msg('Carregando: ' + AArquivo);
  msg('------------------------------------------------------------------------');
  FDScript1.SQLScripts.Clear;
  with FDScript1.SQLScripts.Add do
  begin
    SQL.Text := SynEdit1.Lines.Text;
  end;
  FDScript1.ExecuteAll;
  application.ProcessMessages;

end;

procedure TForm10.FDScript1AfterExecute(Sender: TObject);
begin
  msg('Fim');
end;

procedure TForm10.FDScript1BeforeExecute(Sender: TObject);
begin
  msg('Inicio ----------------------------------------------------------------');
end;

procedure TForm10.FDScript1ConsolePut(AEngine: TFDScript;
  const AMessage: string; AKind: TFDScriptOutputKind);
begin
  msg(AMessage);
end;

procedure TForm10.FDScript1Error(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  msg(AException.Message);
end;

procedure TForm10.FDScript1SpoolPut(AEngine: TFDScript; const AMessage: string;
  AKind: TFDScriptOutputKind);
begin
  msg(AMessage);
end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  ComboBox1.Text := '';
  FireSession.GetAliasNames(ComboBox1.Items);
end;

procedure TForm10.FormShow(Sender: TObject);
begin
  FBaseCaption := Caption;
  SynEdit2.Lines.Clear;
  SynEdit1.Lines.Clear;
end;

procedure TForm10.JvFileListBox1Click(Sender: TObject);
begin
  Alterou := false;
  FCurrenteFileName := JvFileListBox1.FileName;
  Caption := FBaseCaption + ' - ' + ExtractFileName(FCurrenteFileName);
  SynEdit1.Lines.LoadFromFile(JvFileListBox1.FileName);
  SynEdit2.Lines.Clear;
end;

procedure TForm10.msg(txt: string);
begin
  if (pos('DESCRIBE',txt)>0) or  (pos('Problematic key value is',txt)>0) or (POS('DROP', txt) > 0) or (POS('already exists', txt) > 0) or (POS('store duplicate', txt) > 0) then
    exit;

  SynEdit2.Lines.Add(txt);
end;

procedure TForm10.SetAlterou(const Value: boolean);
begin
  FAlterou := Value;
  Caption := FBaseCaption + ' - ' + ExtractFileName(FCurrenteFileName);
  if Value then
    Caption := Caption + ' * ';
end;

procedure TForm10.SynEdit1Change(Sender: TObject);
begin
  Alterou := true;
end;

end.
