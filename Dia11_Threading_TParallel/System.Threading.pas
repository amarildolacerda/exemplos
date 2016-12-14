unit System.Threading;

{ Wrap for System.Threading }

interface

Uses SysUtils, Classes, System.SyncObjs,
  WinApi.Windows;

type

  TInteratorEvent = procedure(sender: TObject; index: integer) of object;

  TThreadPool = Class // dummy para compatibilidade de codigo com XE7
  public
    MaxWorkerThreads: integer;
    class function Default: TThreadPool; static;
  end;

  TParallel = class sealed
  public type
    TLoopResult = record
    private
      FCompleted: Boolean;
      // FLowestBreakIteration: Variant;
    public
      property Completed: Boolean read FCompleted;
      // property LowestBreakIteration: Variant read FLowestBreakIteration;
    end;
  public
    class function &For(ALowInclusive, AHighInclusive: integer;
      const Proc: TProc<integer>): TLoopResult; overload;
    class function ForWorker(sender: TObject; AEvent: TInteratorEvent;
      ALowInclusive, AHighInclusive: integer; const Proc: TProc<integer>)
      : TLoopResult; overload;

  end;

  TTaskStatus = (Created, WaitingToRun, Running, Completed, WaitingForChildren,
    Canceled, tsException);

  { TPDVCargaItem }
Type

  TThreadTasked = class(TThread) // nao usar.... somente para compatibilidade
  public
    procedure Cancel;
    function Status: TTaskStatus;
  end;


  ITask = interface
    ['{8E2DC915-6BA3-4500-8DF9-B603CA79CF8F}']
    procedure Start;
    function Handle: THandle;
    function Status: TTaskStatus;
    function WaitFor(Timeout: LongWord = INFINITE): Cardinal;
    function Wait(Timeout: LongWord = INFINITE): Boolean;
  end;

  IFuture<T> = interface
    function Value: T;
    procedure StartFuture;
    function WaitFor(Timeout: LongWord = INFINITE): Cardinal;
  end;

  TTask = record
  private

    type
    TThreadLocal = class(TThread)
    public
      FProc: TProc;
      procedure execute; override;
    end;

    TThreadTask<T> = class(TInterfacedObject, ITask, IFuture<T>)
    private
      AThread: TThread;
      FTProc: TProc;
      FEvent: TEvent;
      FTaskStatus: TTaskStatus;
    public
      FResult: T;
      FFunc: TFunc<T>;
      FObject:TObject;
      FObjectNotifyEvent:TNotifyEvent;
      function Value: T;
      procedure execute; virtual;
      procedure Start;
      procedure StartFuture;
      function Handle: THandle;
      constructor create;
      destructor destroy; override;
      function Status: TTaskStatus;
      function WaitFor(Timeout: LongWord = INFINITE): Cardinal;
      function Wait(Timeout: LongWord = INFINITE): Boolean;
      procedure ExecuteFuture; virtual;
    end;
  private
  public
    class function create(Proc: TProc): ITask;overload; static;
    class function create(AObj:TObject;AEvent:TNotifyEvent):ITask;overload;static;
    class function Future<T>(func: TFunc<T>): IFuture<T>; static;
    class function WaitForAll(const Tasks: array of ITask;
      Timeout: LongWord = INFINITE): Boolean; static;
    class function WaitForAny(const Tasks: array of ITask): Boolean; static;
    // class procedure Run(Proc: TProc);overload;  static;
    class function Run(Proc: TProc): ITask; overload; static;
    class function CurrentTask: TThreadTasked; static;
  end;

implementation

Uses AsyncCalls;

procedure TThreadTasked.Cancel;
begin
  Terminate
end;

{ TTask }
constructor TTask.TThreadTask<T>.create;
begin
  inherited create;
  FEvent := TEvent.create(nil, false, false, 'TaskThreading');
  FTaskStatus := Created;
end;

destructor TTask.TThreadTask<T>.destroy;
begin
  // FEvent.SetEvent;
  FreeAndNil(AThread);
  FreeAndNil(FEvent);
  inherited destroy;
end;

procedure TTask.TThreadTask<T>.execute;
begin
  FTaskStatus := Running;
  try
    if assigned(FTProc) then
       FTProc
    else
      if assigned(FObjectNotifyEvent) then
         FObjectNotifyEvent(FObject);
  finally
    if assigned(FEvent) then
      FEvent.SetEvent;
    FTaskStatus := TTaskStatus.Completed;
  end;
end;

function TTask.TThreadTask<T>.Handle: THandle;
begin
  result := FEvent.Handle;
end;

procedure TTask.TThreadTask<T>.Start;
//var
//  A: TThread;
begin
//  A := TThread.CreateAnonymousThread(execute); // testado - OK;
  FTaskStatus := TTaskStatus.WaitingToRun;
//  A.start;
  TThread.Synchronize(nil,execute);  // para forcar isolamento de acesso
end;



procedure TTask.TThreadTask<T>.StartFuture;
begin
  AThread := TThreadTasked.CreateAnonymousThread(ExecuteFuture);
  AThread.FreeOnTerminate := false;
  FTaskStatus := TTaskStatus.WaitingToRun;
  AThread.Start; // testado OK;
end;

function TTask.TThreadTask<T>.Status: TTaskStatus;
begin
  result := FTaskStatus;
end;

function TTask.TThreadTask<T>.Wait(Timeout: LongWord): Boolean;
var
  rt: Cardinal;
begin
  rt := WaitForSingleObject(Handle, Timeout);
  result := (rt = WAIT_OBJECT_0);
end;

function TTask.TThreadTask<T>.WaitFor(Timeout: LongWord = INFINITE): Cardinal;
begin
  if assigned(AThread) then
  begin
    result := WaitForSingleObject(AThread.Handle, Timeout);
    // if result<>WAIT_OBJECT_0 then  -- verifica no XE7 qual o comportamento quando ocorre timeout. (termina ?)
    // AThread.Terminate;
  end;
end;

class function TTask.create(Proc: TProc): ITask;
var
  FThread: TThreadTask<Boolean>;
begin
  FThread := TThreadTask<Boolean>.create;
  FThread.FTProc := Proc;
  result := FThread;
end;

class function TTask.create(AObj: TObject; AEvent: TNotifyEvent): ITask;
var
  FThread: TThreadTask<Boolean>;
begin
  FThread := TThreadTask<Boolean>.create;
  FThread.FObjectNotifyEvent := AEvent;
  FThread.FObject := AObj;
{  FThread.FTProc := procedure
                    begin
                       AEvent(AObj);
                    end;
}
  result := FThread;
end;

class function TTask.CurrentTask: TThreadTasked;
begin
  result := TThreadTasked(TThread.CurrentThread);
end;

class function TTask.Future<T>(func: TFunc<T>): IFuture<T>;
var
  FThread: TThreadTask<T>;
begin
  FThread := TThreadTask<T>.create;
  FThread.FFunc := func;
  FThread.StartFuture;
  result := FThread; // testado OK;
end;

class function TTask.Run(Proc: TProc): ITask;
begin
  result := TTask.create(Proc);
  result.Start;
end;

{ class Procedure TTask.Run(Proc: TProc);
  begin
  TThread.CreateAnonymousThread(
  procedure
  begin
  Proc;
  end).Start;
  end;
}

class function TTask.WaitForAll(const Tasks: array of ITask;
  Timeout: LongWord = INFINITE): Boolean;
var
  i: integer;
  n: integer;
  r: word;
begin
  result := false;
  n := getTickCount;
  r := Timeout;
  for i := low(Tasks) to high(Tasks) do
    if Tasks[i].Status in [TTaskStatus.WaitingToRun, TTaskStatus.Running] then
    begin
      Tasks[i].WaitFor(r);
      r := r - (getTickCount - n);
      if r < 0 then
        break;
    end;
  result := true;
end;

class function TTask.WaitForAny(const Tasks: array of ITask): Boolean;
var
  i: integer;
begin
  result := false;
  if Length(Tasks) > 0 then
    while result = false do
      for i := low(Tasks) to high(Tasks) do
        if (Tasks[i].Status in [TTaskStatus.Completed]) then
        begin
          result := true;
          exit;
        end;
end;

{ TParallel }

type
  TAsyncCallsHelper = class helper for TAsyncCalls
    class function CreateAnonymousThreadInteger(AProc: TProc<integer>;
      i: integer): IAsyncCall;
  end;

class function TParallel.&For(ALowInclusive, AHighInclusive: integer;
  const Proc: TProc<integer>): TLoopResult;
begin
  result := TParallel.ForWorker(nil, TInteratorEvent(nil), ALowInclusive,
    AHighInclusive, Proc); // testado OK
end;


// class function ForWorker(Sender: TObject; AEvent: TIteratorEvent; AStateEvent: TIteratorStateEvent; const AProc: TProc<Integer>; const AProcWithState: TProc<Integer, TLoopState>; ALowInclusive, AHighExclusive, AStride: Integer; APool: TThreadPool): TLoopResult; static;

class function TParallel.ForWorker(sender: TObject; AEvent: TInteratorEvent;
  ALowInclusive, AHighInclusive: integer; const Proc: TProc<integer>)
  : TLoopResult;
var
  tsk: array of IAsyncCall;
  i, n, k: integer;
  cnt: integer;
  A: IAsyncCall;
begin
  result.FCompleted := false;
  n := AHighInclusive - ALowInclusive + 1;
  if n <= 0 then
    exit;
  SetLength(tsk, AHighInclusive - ALowInclusive + 1);
  cnt := low(tsk);
  for i := ALowInclusive to AHighInclusive do
  begin
    tsk[cnt] := TAsyncCalls.CreateAnonymousThreadInteger(
      procedure(x: integer)
      begin
        Proc(x);
        if assigned(AEvent) then
          AEvent(sender, k);
      end, i);
    inc(cnt);
  end;
  AsyncMultiSync(tsk);
end;

{ TThreadHelper }

class function TAsyncCallsHelper.CreateAnonymousThreadInteger
  (AProc: TProc<integer>; i: integer): IAsyncCall;
begin
  result := TAsyncCalls.Invoke(
    procedure
    begin
      AProc(i);
    end);
end;

{ TTask.TThreadTaskFuture }

procedure TTask.TThreadTask<T>.ExecuteFuture;
begin
  FTaskStatus := Running;
  try
    FResult := FFunc();
  finally
    FEvent.SetEvent;
    FTaskStatus := TTaskStatus.Completed;
  end;
end;

function TTask.TThreadTask<T>.Value: T;
begin
  AThread.WaitFor;
  result := FResult; // testado OK
end;

{ TThreadPool }
var
  FThreadedPool: TThreadPool;

class function TThreadPool.Default: TThreadPool;
begin
  if not assigned(FThreadedPool) then
  begin
    FThreadedPool := TThreadPool.create;
    FThreadedPool.MaxWorkerThreads := GetMaxAsyncCallThreads;
  end;

  result := FThreadedPool;
end;

{ TTask.TThreadLocal }

procedure TTask.TThreadLocal.execute;
begin
  inherited;
  FProc;
end;

function TThreadTasked.Status: TTaskStatus;
begin
  if Terminated then
    result := TTaskStatus.Canceled;
  if Suspended then
    result := TTaskStatus.WaitingToRun;
  if Finished then
    result := TTaskStatus.Completed;
end;

initialization

finalization

FreeAndNil(FThreadedPool);

end.
