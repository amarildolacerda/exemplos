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
begin
  strList.Clear;
  // Thread 1
  tthread.CreateAnonymousThread(
    procedure
    var
      x: integer;
    begin
      for x := 0 to random(1000) do
      begin
        strList.Add('X' + intToStr(x));
        tthread.Sleep(random(10));
      end;
      strList.Add('X-FIM');

      tthread.Queue(nil,
        procedure
        begin
          strList.AssingTo(Memo1.lines);
        end);

    end).start;

  // Thread 2
  tthread.CreateAnonymousThread(
    procedure
    var
      x: integer;
    begin
      for x := 0 to random(1000) do
      begin
        strList.Add('Z' + intToStr(x));
        tthread.Sleep(random(10));
      end;
      strList.Add('Z-FIM');

      tthread.Queue(nil,
        procedure
        begin
          strList.AssingTo(Memo1.lines);
        end);

    end).start;

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
