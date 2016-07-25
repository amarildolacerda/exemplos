unit unit_Samples;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.ThreadSafe, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox,
  FMX.Memo;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    // private
    { Private declarations }
  private
    strList: TThreadSafeStringList;
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
  x: integer;
  t1, t2: TThread;
begin
  strList.Clear;
  // Thread 1
  t1 := TThread.CreateAnonymousThread(
    procedure
    var
      x: integer;
    begin
      for x := 0 to random(1000) do
      begin
        strList.Add('X' + intToStr(x));
        TThread.Sleep(random(10));
      end;
      strList.Add('X-FIM');

    end);
  t1.start;

  // Thread 2
  t2 := TThread.CreateAnonymousThread(
    procedure
    var
      x: integer;
    begin
      for x := 0 to random(1000) do
      begin
        strList.Add('Z' + intToStr(x));
        TThread.Sleep(random(10));
      end;
      strList.Add('Z-FIM');
      TThread.Queue(nil,
        procedure
        begin
          strList.AssingTo(Memo1.lines);
        end);

    end);
  t2.start;



end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  strList := TThreadSafeStringList.create;

end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  strList.free;
end;

end.
