unit Unit39;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm39 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    procedure PopularALista(FList: TList);
  public
    { Public declarations }
  end;

var
  Form39: TForm39;

implementation

{$R *.dfm}

uses DB;

{
  Class Helper - Anonimous ComponentsLoop
  Amarildo Lacerda
}
type
  TComponentHelper = class Helper for TComponent
  public
    procedure ComponentsLoop(AProc: TProc<TComponent>; AChild: boolean = false);
    procedure ListLoop(AList: TList; AProc: TProc<TObject>);
  end;

  { TComponentHelper }

procedure TComponentHelper.ListLoop(AList: TList; AProc: TProc<TObject>);
var
  i: integer;
begin
  for i := 0 to AList.Count - 1 do
    AProc(AList[i]);
end;

procedure TComponentHelper.ComponentsLoop(AProc: TProc<TComponent>; AChild: boolean = false);
var
  i: integer;
begin
  if assigned(AProc) then
    for i := 0 to ComponentCount - 1 do
    begin
      AProc(Components[i]);
      if AChild and (Components[i].ComponentCount > 0) then
        Components[i].ComponentsLoop(AProc, AChild);
    end;
end;

procedure TForm39.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  ComponentsLoop(
    Procedure(AComp: TComponent)
    begin
      Memo1.Lines.Add(AComp.ClassName + '.' + AComp.name);

      // fecha todos os TDataset  (TQuery)
      if AComp is TDataset then
        with AComp as TDataset do
          close;

    end, false);

end;

procedure TForm39.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  ComponentsLoop(
    Procedure(AComp: TComponent)
    begin
      Memo1.Lines.Add(AComp.ClassName + '.' + AComp.name);
    end, true);

end;

procedure TForm39.Button3Click(Sender: TObject);
var
  FList: TList;
begin
  memo1.Lines.Clear;
  FList := TList.create;
  try
    PopularALista(FList);

    // fazer um LOOP usando Anonimous
    ListLoop(FList,
      procedure(AObj: TObject)
      begin
        memo1.Lines.Add( AObj.ClassName );
      end);

  finally
    FList.Free;
  end;
end;

procedure TForm39.PopularALista(FList: TList);
begin
  ComponentsLoop(
    procedure(cmp: TComponent)
    begin
      FList.Add(cmp);
    end);
end;

end.
