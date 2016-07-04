unit System.IniFiles.Helper;

interface

Uses System.Classes, System.IniFiles, System.JSON;

type
  TCustomIniFileHelper = class Helper for TIniFile
  public
    function ToJson: string;
    function JSON: TJsonObject;
    procedure FromJson(AJson: string);
  end;

implementation

uses Variants;

procedure TCustomIniFileHelper.FromJson(AJson: string);
var
  LJson: TJsonObject;
  LSecao: TJsonArray;
  Chave: string;
  it: TJSONPair;
  itValue: TJsonValue;
  LPair: TJSONPair;
  LItem: TJsonObject;
begin
  LJson := TJsonObject.ParseJSONValue(AJson) as TJsonObject;
  for it in LJson do
  begin
    Chave := it.JsonString.Value;
    LJson.TryGetValue<TJsonArray>(Chave, LSecao);
    for itValue in LSecao do
    begin
      LItem := itValue as TJsonObject;
      for LPair in LItem do
        writeString(Chave, LPair.JsonString.Value, LPair.JsonValue.Value);
    end;
  end;
end;

function TCustomIniFileHelper.JSON: TJsonObject;
var
  LArray: TJsonArray;
  sec: TStringList;
  it: TStringList;
  i, n: integer;
  LPair: TJSONPair;
  v: variant;
begin
  result := TJsonObject.create;
  sec := TStringList.create;
  it := TStringList.create;
  try
    ReadSections(sec);
    for i := 0 to sec.count - 1 do
    begin
      ReadSection(sec[i], it);
      if it.count > 0 then
      begin
        LArray := TJsonArray.create;
        try
          for n := 0 to it.count - 1 do
          begin
            v := ReadString(sec[i], it[n], '');
            if VarIsOrdinal(v) or VarIsFloat(v) or VarIsNumeric(v) then
              LPair := TJSONPair.create(it[n], TJSONNumber.create(v))
            else
              LPair := TJSONPair.create(it[n], v);
            LArray.Add(LPair.ToJson);
          end;
          result.AddPair(sec[i], LArray);
        finally
        end;
      end;
    end;
  finally
  end;

end;

function TCustomIniFileHelper.ToJson: string;
begin
  result := JSON.ToJson;
end;

end.
