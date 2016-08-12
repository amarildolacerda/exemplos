unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm6 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

uses IniFiles, System.DateUtils, System.Rtti, System.TypInfo;

type

  {
    Fragmento de:    System.Classes.Helper
    https://github.com/amarildolacerda/helpers/blob/master/System.Classes.Helper.pas
  }
  TMemberVisibilitySet = set of TMemberVisibility;

  // RTTI para pegar propriedades do object
  TObjectHelper = class helper for TObject
  private
    procedure GetPropertiesItems(AList: TStrings;
      const AVisibility: TMemberVisibilitySet);
  end;

  // Adiciona Uso de RTTI para o INI
  TCustomIniFileHelper = class Helper for TCustomIniFile
  private
    procedure WriteObject(const ASection: string; AObj: TObject);
    procedure ReadObject(const ASection: string; AObj: TObject);
  public
  end;

  // Adiciona funções ao TValue
  TValueHelper = record helper for TValue
  private
    function IsNumeric: Boolean;
    function IsFloat: Boolean;
    function AsFloat: Extended;
    function IsBoolean: Boolean;
    function IsDate: Boolean;
    function IsDateTime: Boolean;
    function IsDouble: Boolean;
    function AsDouble: Double;
    function IsInteger: Boolean;
  end;

  // Classe a ser gravar no INI
  TIniSecaoClass = class
  private
    Fbase_datetime: TDatetime;
    Fbase_numerico: Double;
    Fbase_string: string;
    Fbase_integer: integer;
    Fbase_boolean: Boolean;
    procedure Setbase_datetime(const Value: TDatetime);
    procedure Setbase_numerico(const Value: Double);
    procedure Setbase_string(const Value: string);
    procedure Setbase_integer(const Value: integer);
    procedure Setbase_boolean(const Value: Boolean);
  public
    // propriedades a serem gravadas ou lidas no INI
    property base_string: string read Fbase_string write Setbase_string;
    property base_datetime: TDatetime read Fbase_datetime
      write Setbase_datetime;
    property base_numerico: Double read Fbase_numerico write Setbase_numerico;
    property base_integer: integer read Fbase_integer write Setbase_integer;
    property base_boolean: Boolean read Fbase_boolean write Setbase_boolean;
  end;

var
  obj: TIniSecaoClass;

function TValueHelper.IsNumeric: Boolean;
begin
  Result := Kind in [tkInteger, tkChar, tkEnumeration, tkFloat,
    tkWChar, tkInt64];
end;

function TValueHelper.IsFloat: Boolean;
begin
  Result := Kind = tkFloat;
end;

function TValueHelper.AsFloat: Extended;
begin
  Result := AsType<Extended>;
end;

function TValueHelper.IsBoolean: Boolean;
begin
  Result := TypeInfo = System.TypeInfo(Boolean);
end;

function TValueHelper.IsDate: Boolean;
begin
  Result := TypeInfo = System.TypeInfo(TDate);
end;

function TValueHelper.IsDateTime: Boolean;
begin
  Result := TypeInfo = System.TypeInfo(TDatetime);
end;

function TValueHelper.IsDouble: Boolean;
begin
  Result := TypeInfo = System.TypeInfo(Double);
end;

function TValueHelper.AsDouble: Double;
begin
  Result := AsType<Double>;
end;

function TValueHelper.IsInteger: Boolean;
begin
  Result := TypeInfo = System.TypeInfo(integer);
end;

function ISODateTimeToString(ADateTime: TDatetime): string;
var
  fs: TFormatSettings;
begin
  fs.TimeSeparator := ':';
  Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', ADateTime, fs);
end;

function ISOStrToDateTime(DateTimeAsString: string): TDatetime;
begin
  Result := EncodeDateTime(StrToInt(Copy(DateTimeAsString, 1, 4)),
    StrToInt(Copy(DateTimeAsString, 6, 2)),
    StrToInt(Copy(DateTimeAsString, 9, 2)),
    StrToInt(Copy(DateTimeAsString, 12, 2)),
    StrToInt(Copy(DateTimeAsString, 15, 2)),
    StrToInt(Copy(DateTimeAsString, 18, 2)), 0);
end;

procedure TCustomIniFileHelper.WriteObject(const ASection: string;
  AObj: TObject);
var
  aCtx: TRttiContext;
  AFld: TRttiProperty;
  AValue: TValue;
begin
  aCtx := TRttiContext.Create;
  try
    for AFld in aCtx.GetType(AObj.ClassType).GetProperties do
    begin
      if AFld.Visibility in [mvPublic] then
      begin
        AValue := AFld.GetValue(AObj);
        if AValue.IsDate or AValue.IsDateTime then
          WriteString(ASection, AFld.Name, ISODateTimeToString(AValue.AsDouble))
        else if AValue.IsBoolean then
          WriteBool(ASection, AFld.Name, AValue.AsBoolean)
        else if AValue.IsInteger then
          WriteInteger(ASection, AFld.Name, AValue.AsInteger)
        else if AValue.IsFloat or AValue.IsNumeric then
          WriteFloat(ASection, AFld.Name, AValue.AsFloat)
        else
          WriteString(ASection, AFld.Name, AValue.ToString);
      end;
    end;
  finally
    aCtx.free;
  end;
end;

procedure TCustomIniFileHelper.ReadObject(const ASection: string;
  AObj: TObject);
var
  aCtx: TRttiContext;
  AFld: TRttiProperty;
  AValue, ABase: TValue;
begin
  aCtx := TRttiContext.Create;
  try
    for AFld in aCtx.GetType(AObj.ClassType).GetProperties do
    begin
      if AFld.Visibility in [mvPublic] then
      begin
        ABase := AFld.GetValue(AObj);
        AValue := AFld.GetValue(AObj);
        if ABase.IsDate or ABase.IsDateTime then
          AValue := ISOStrToDateTime(ReadString(ASection, AFld.Name,
            ISODateTimeToString(ABase.AsDouble)))
        else if ABase.IsBoolean then
          AValue := ReadBool(ASection, AFld.Name, ABase.AsBoolean)
        else if ABase.IsInteger then
          AValue := ReadInteger(ASection, AFld.Name, ABase.AsInteger)
        else if ABase.IsFloat or ABase.IsNumeric then
          AValue := ReadFloat(ASection, AFld.Name, ABase.AsFloat)
        else
          AValue := ReadString(ASection, AFld.Name, ABase.asString);
        AFld.SetValue(AObj, AValue);
      end;
    end;
  finally
    aCtx.free;
  end;
end;

procedure TObjectHelper.GetPropertiesItems(AList: TStrings;
  const AVisibility: TMemberVisibilitySet);
var
  aCtx: TRttiContext;
  aProperty: TRttiProperty;
  aRtti: TRttiType;
  AValue: TValue;
begin
  AList.clear;
  aCtx := TRttiContext.Create;
  try
    aRtti := aCtx.GetType(self.ClassType);
    for aProperty in aRtti.GetProperties do
    begin
      if aProperty.Visibility in AVisibility then
      begin
        AValue := aProperty.GetValue(self);
        if AValue.IsDate or AValue.IsDateTime then
          AList.Add(aProperty.Name + '=' + ISODateTimeToString(AValue.AsDouble))
        else if AValue.IsBoolean then
          AList.Add(aProperty.Name + '=' + ord(AValue.AsBoolean).ToString)
        else
          AList.Add(aProperty.Name + '=' + AValue.ToString);
      end;
    end;
  finally
    aCtx.free;
  end;

end;

procedure TForm6.Button1Click(Sender: TObject);
begin
  obj.GetPropertiesItems(Memo1.lines, [mvPublic]);
end;

{ TIniSecaoClass }

procedure TIniSecaoClass.Setbase_boolean(const Value: Boolean);
begin
  Fbase_boolean := Value;
end;

procedure TIniSecaoClass.Setbase_datetime(const Value: TDatetime);
begin
  Fbase_datetime := Value;
end;

procedure TIniSecaoClass.Setbase_integer(const Value: integer);
begin
  Fbase_integer := Value;
end;

procedure TIniSecaoClass.Setbase_numerico(const Value: Double);
begin
  Fbase_numerico := Value;
end;

procedure TIniSecaoClass.Setbase_string(const Value: string);
begin
  Fbase_string := Value;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  // grava o objeto  OBJ no INI
  with TIniFile.Create('teste.ini') do
    try
      WriteObject('SecaoClass', obj);
    finally
      free;
    end;

end;

procedure TForm6.Button3Click(Sender: TObject);
var
  i: integer;
begin
  // Ler os dados gravados no INI - mostra no memo2
  with TIniFile.Create('teste.ini') do
    try
      ReadSection('SecaoClass', Memo2.lines);
      for i := 0 to Memo2.lines.Count - 1 do
        Memo2.lines[i] := Memo2.lines[i] + '=' + ReadString('SecaoClass',
          Memo2.lines[i], '');
    finally
      free;
    end;
end;

procedure TForm6.Button4Click(Sender: TObject);
begin
  // Ler os dados do INI para o OBJ
  with TIniFile.Create('teste.ini') do
    try
      ReadObject('SecaoClass', obj);
    finally
      free;
    end;
  obj.GetPropertiesItems(Memo2.lines, [mvPublic]);
end;

procedure TForm6.Button5Click(Sender: TObject);
var
  i: integer;
begin
  // grava o memo1 no INI
  With TIniFile.Create('teste.ini') do
    try
      for i := 0 to Memo1.lines.Count - 1 do
        WriteString('SecaoClass', Memo1.lines.Names[i],
          Memo1.lines.ValueFromIndex[i]);

    finally
      free;
    end;
end;

initialization

// Inicia o objecto a ser utilizado para gravar no INI
obj := TIniSecaoClass.Create;
with obj do
begin
  base_string := 'meu teste';
  base_datetime := now;
  base_numerico := 123.34;
  base_integer := 1234;
end;

finalization

obj.free;

end.
