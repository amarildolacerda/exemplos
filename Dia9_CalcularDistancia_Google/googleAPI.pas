unit googleAPI;

interface

uses sysUtils, classes;

{$I Delphi.inc}

type

  TGoogleMapDistance = class;

  TGoogleDirecoesItem = class(TCollectionItem)
  public
    route: integer;
    endereco: string;
    distancia: integer; // em km
    distancia_text: string;
    duracao: integer;
    duracao_text: string;
    function getText: string;
  end;

  TGoogleDirecoes = class(TCollection)
  private
    FWayPoints: TStringList;
    FMapDistancias: TGoogleMapDistance;
    function GetItems(idx: integer): TGoogleDirecoesItem;
    procedure SetItems(idx: integer; const Value: TGoogleDirecoesItem);
    procedure SetMapDistancias(const Value: TGoogleMapDistance);
  published
  public
    Response: string;
    constructor create;
    destructor Destroy; override;
    function GetDirecoes(de, para: string): string;
    property WayPoints: TStringList read FWayPoints;
    property Items[idx: integer]: TGoogleDirecoesItem read GetItems
      write SetItems;
    function getText: string;
    property MapDistancias: TGoogleMapDistance read FMapDistancias
      write SetMapDistancias;
  end;

  TGoogleMapDistanceItem = class(TCollectionItem)
  public
    route: integer;
    endereco: string;
    distancia: integer; // em km
    distancia_text: string;
    duracao: integer;
    duracao_text: string;
    Latitude: string;
    Longitude: string;
  end;

  TGoogleMapDistance = class(TCollection)
  private
    FDestino: string;
    FOrigem: string;
    FRoutes: TStringList;
    procedure SetDestino(const Value: string);
    procedure SetOrigem(const Value: string);
    function GetItems(idx: integer): TGoogleMapDistanceItem;
    procedure SetItems(idx: integer; const Value: TGoogleMapDistanceItem);
  public
    Response: string;
    constructor create;
    destructor Destroy; override;
    property Origem: string read FOrigem write SetOrigem;
    property Destino: string read FDestino write SetDestino;
    function GetDistancia(de, para: string): string;
    property Items[idx: integer]: TGoogleMapDistanceItem read GetItems
      write SetItems;
    function getText: string;
  end;

procedure LocalizarNoGoogleMap(url: string);
procedure LocalizarNoGoogleImage(url: string);
procedure LocalizarNoGoogle(url: string);
procedure LocalizarNoTanslate(url: string);
procedure InitWebLinks;
function GetWebLink(key: string; texto: string = ''): string;

implementation

uses
  mFunctions, IniFileList,
  {$ifndef BPL}
  ACBrSocket,
  {$endif}
  uJson,  IniFilesEx;

const
  lnk = 'Links';

var
  webLinksInited: boolean = false;

const
  googleMapsMatrix =
    'http://maps.googleapis.com/maps/api/distancematrix/json?origins=%s&destinations=%s&mode=driving&language=pt-BR&sensor=false';
  googleDirecoes =
    'http://maps.googleapis.com/maps/api/directions/json?origin=%s&destination=%s&sensor=false&language=pt-BR';

procedure InitWebLinks;
var
  n: integer;
begin
  if webLinksInited then
    exit;

  // nao mudar a mask  {texto}
{$IFNDEF BPL}
  with GetIniFile('store.ini') do
  begin
    n := GetValuesCount(lnk);
    ReadStringDefault(lnk, 'translate',
      'http://translate.google.com.br/m?hl=pt-BR&sl=pt-BR&tl=en&ie=UTF-8&prev=_m&q={texto}');
    ReadStringDefault(lnk, 'map',
      'http://maps.google.com.br/maps?q={texto}&bl=pt-BR');
    ReadStringDefault(lnk, 'image',
      'http://images.google.com.br/images?q={texto}&bl=pt-BR');
    ReadStringDefault(lnk, 'google',
      'http://www.google.com.br/search?q={texto}&bl=pt-BR');
    if n <> GetValuesCount(lnk) then
      UpdateFile;
  end;
{$ENDIF}
  webLinksInited := true;
end;

function GetWebLink(key: string; texto: string = ''): string;
begin
  if not webLinksInited then
    InitWebLinks;
  with GetIniFile('store.ini') do
  begin
    result := ReadString(lnk, key, '');
    if texto <> '' then
    begin
      result := StringReplace(result, '{texto}', StringReplace(texto, ' ',
        '%20', [rfReplaceAll]), [rfReplaceAll]);
    end;
  end;
end;

procedure LocalizarNoGoogleMap(url: string);
var
  s: string;
begin
  s := GetWebLink('map');
  url := StringReplace(s, '{texto}', StringReplace(url, ' ', '%20',
    [rfReplaceAll]), [rfReplaceAll]);
  ShellExec('"' + url + '"', '', '', false, 0);
end;

procedure LocalizarNoGoogleImage(url: string);
var
  s: string;
begin
  s := GetWebLink('image');
  url := StringReplace(s, '{texto}', StringReplace(url, ' ', '%20',
    [rfReplaceAll]), [rfReplaceAll]);
  ShellExec('"' + url + '"', '', '', false, 0);
end;

procedure LocalizarNoTanslate(url: string);
var
  s: string;
begin
  s := GetWebLink('translate');
  url := StringReplace(s, '{texto}', StringReplace(url, ' ', '%20',
    [rfReplaceAll]), [rfReplaceAll]);
  ShellExec('"' + url + '"', '', '', false, 0);
end;

procedure LocalizarNoGoogle(url: string);
var
  s: string;
begin
  s := GetWebLink('google');
  url := StringReplace(s, '{texto}', StringReplace(url, ' ', '%20',
    [rfReplaceAll]), [rfReplaceAll]);
  ShellExec('"' + url + '"', '', '', false, 0);
end;

{ TGoogleMapDistance }

constructor TGoogleMapDistance.create;
begin
  inherited create(TGoogleMapDistanceItem);
  FRoutes := TStringList.create;
end;

destructor TGoogleMapDistance.Destroy;
begin
  FRoutes.Free;
  inherited;
end;

function TGoogleMapDistance.GetDistancia(de, para: string): string;
var
  // rsp: string;
  {$ifndef BPL}
  http: TACBrHTTP;
  {$endif}
  js, jsRows: IJson;
  aJS, aLocal: IJSONArray;
  n: integer;
begin
  FOrigem := de;
  FDestino := para;
  clear;
  Response := '';
  result := '';
  {$ifndef BPL}
  http := TACBrHTTP.create(nil);
  try
    http.HTTPGet(Format(googleMapsMatrix, [StringReplace(de, ' ', '%20',
      [rfReplaceAll]), StringReplace(para, ' ', '%20', [rfReplaceAll])]));
    Response := http.RespHTTP.Text;
  finally
    http.Free;
  end;
  {$endif}

  //JSONFree;
  js := TJSON.parse(Response);
  try

  if js.s('status') <> 'OK' then
    exit;

  aLocal := js.O('destination_addresses').AsArray ;

  n := aLocal.Length;
  if aLocal.Length = 0 then
    exit;
  for n := 0 to aLocal.Length - 1 do
    with TGoogleMapDistanceItem(add) do
    begin
      endereco := aLocal.Get(n).Value; // .asString;
      FRoutes.add(aLocal.Get(n).Value); // .asString);
    end;
  aJS := js.O('rows').asArray;
  if aJS.Length > 0 then
  begin
    js := aJS.Get(0) as TJSON;
    aJS := js.O('elements').asArray;
    for n := 0 to aJS.Length - 1 do
    begin
      jsRows := aJS.Get(n) as TJSON;
      if jsRows.s('status') = 'OK' then
      begin
        js := jsRows.O('distance');
        Items[n].route := n;
        Items[n].distancia := js.I('value');
        Items[n].distancia_text := js.s('text');
        result := FloatToStr(Items[n].distancia / 1000);

        js := jsRows.O('duration');
        Items[n].duracao := js.I('value');
        Items[n].duracao_text := js.s('text');

      end
      else
      begin
        Items[n].distancia_text := jsRows.s('status');
      end;
    end;
  end;
  finally
    js.Free;
  end;
end;

function TGoogleMapDistance.GetItems(idx: integer): TGoogleMapDistanceItem;
begin
  result := TGoogleMapDistanceItem(inherited Items[idx]);
end;

procedure TGoogleMapDistance.SetDestino(const Value: string);
begin
  FDestino := Value;
end;

procedure TGoogleMapDistance.SetItems(idx: integer;
  const Value: TGoogleMapDistanceItem);
begin
  Items[idx] := Value;
end;

procedure TGoogleMapDistance.SetOrigem(const Value: string);
begin
  FOrigem := Value;
end;

function TGoogleMapDistance.getText: string;
var
  I: integer;
begin
  result := '';
  for I := 0 to Count - 1 do
    result := result + iff(I > 0, '#10', '') + Items[I].endereco + '=' +
      FloatToStr(Items[I].distancia / 1000) + '(' + Items[I].duracao_text + ')';
end;

{ TGoogleDirecoes }

constructor TGoogleDirecoes.create;
begin
  inherited create(TGoogleDirecoesItem);
  FWayPoints := TStringList.create;
end;

destructor TGoogleDirecoes.Destroy;
begin
  FWayPoints.Free;
  inherited;
end;

function TGoogleDirecoes.GetDirecoes(de, para: string): string;
var
{$ifndef BPL}
  http: TACBrHTTP;
  {$endif}
  wp: string;
  I, x, y: integer;
  js: IJson;
  jLegs, jSteps: IJSONArray;
  ja: IJSONArray;
  s: string;
begin
  if assigned(FMapDistancias) then
    FMapDistancias.clear;

  wp := '';
  if FWayPoints.Count > 0 then
  begin
    for I := 0 to FWayPoints.Count - 1 do
    begin
      if I = 0 then
        wp := '&waypoints=';
      wp := wp + iff(I > 0, '|', '') + StringReplace(FWayPoints[I], ' ', '+',
        [rfReplaceAll]);
    end;
    // waypoints=Charlestown,MA|Lexington
  end;

  {$ifndef BPL}
  http := TACBrHTTP.create(nil);
  try
    http.HTTPGet(Format(googleDirecoes + wp, [StringReplace(de, ' ', '%20',
      [rfReplaceAll]), StringReplace(para, ' ', '%20', [rfReplaceAll])]));
    Response := http.RespHTTP.Text;
  finally
    http.Free;
  end;
  {$endif}

  js := TJSON.parse(Response);
  try
  ja := js.O('routes').asArray;
  for I := 0 to ja.Length - 1 do
  begin // legs...
    jLegs := (ja.Get(I) as TJSON).O('legs').asArray;

    for x := 0 to jLegs.Length - 1 do
    begin
      jSteps := (jLegs.Get(x) as TJSON).O('steps').asArray;
      if assigned(FMapDistancias) then
      begin
        with TGoogleMapDistanceItem(FMapDistancias.add) do
        begin
          route := I;
          endereco := (jLegs.Get(x) as TJSON).s('end_address');
          FMapDistancias.FRoutes.add(endereco);
          js := (jLegs.Get(x) as TJSON).O('distance');
          distancia := js.I('value');
          distancia_text := js.s('text');
          js := (jLegs.Get(x) as TJSON).O('duration');
          duracao := js.I('value');
          duracao_text := js.s('text');

          js := (jLegs.Get(x) as TJSON).O('end_location');
          Latitude := js.S('lat');//.AsString;
          Longitude := js.S('lng');//.AsString;

          (* "end_location" : {
            "lat" : -23.592780,
            "lng" : -46.602350
            },
          *)

        end;
      end;
      for y := 0 to jSteps.Length - 1 do
      begin
        s := (jSteps.Get(y) as TJSON).s('html_instructions');
        with TGoogleDirecoesItem(add) do
        begin
          route := I;
          endereco := s;
          js := (jSteps.Get(y) as TJSON).O('distance');
          distancia := js.I('value');
          distancia_text := js.s('text');
          js := (jSteps.Get(y) as TJSON).O('duration');
          duracao := js.I('value');
          duracao_text := js.s('text');
        end;
      end;
    end;
  end;

  result := iff(Response <> '', 'OK', '');
  result := Response;
  finally
    js.Free;
  end;

end;

function TGoogleDirecoes.GetItems(idx: integer): TGoogleDirecoesItem;
begin
  result := TGoogleDirecoesItem(inherited Items[idx]);
end;

function TGoogleDirecoes.getText: string;
var
  I: integer;
begin
  result := '';
  for I := 0 to Count - 1 do
    result := result + iff(I > 0, #10, '') + Items[I].getText;
end;

procedure TGoogleDirecoes.SetItems(idx: integer;
  const Value: TGoogleDirecoesItem);
begin
  Items[idx] := Value;
end;

procedure TGoogleDirecoes.SetMapDistancias(const Value: TGoogleMapDistance);
begin
  FMapDistancias := Value;
end;

(*

  {
  "routes" : [
  {
  "bounds" : {
  "northeast" : {
  "lat" : -23.493080,
  "lng" : -46.597490
  },
  "southwest" : {
  "lat" : -23.592780,
  "lng" : -46.65495000000001
  }
  },
  "copyrights" : "Dados cartográficos ©2013 Google, MapLink",
  "legs" : [
  {
  "distance" : {
  "text" : "9,9 km",
  "value" : 9869
  },
  "duration" : {
  "text" : "20 minutos",
  "value" : 1198
  },
  "end_address" : "Rua Lino Coutinho - Ipiranga, São Paulo, República Federativa do Brasil",
  "end_location" : {
  "lat" : -23.592780,
  "lng" : -46.602350
  },
  "start_address" : "Avenida Paulista - São Paulo, República Federativa do Brasil",
  "start_location" : {
  "lat" : -23.563070,
  "lng" : -46.654360
  },
  "steps" : [
  {
  "distance" : {
  "text" : "82 m",
  "value" : 82
  },
  "duration" : {
  "text" : "1 min",
  "value" : 7
  },
  "end_location" : {
  "lat" : -23.562570,
  "lng" : -46.65495000000001
  },
  "html_instructions" : "Siga na direção \u003cb\u003enoroeste\u003c/b\u003e na \u003cb\u003eAv. Paulista\u003c/b\u003e em direção à \u003cb\u003eR. Itapeva\u003c/b\u003e",
  "polyline" : {
  "points" : "ddynCvdw{GcBtB"
  },
  "start_location" : {
  "lat" : -23.563070,
  "lng" : -46.654360
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,8 km",
  "value" : 801
  },
  "duration" : {
  "text" : "2 minutos",
  "value" : 131
  },
  "end_location" : {
  "lat" : -23.557520,
  "lng" : -46.64971000000001
  },
  "html_instructions" : "Pegue a 1ª \u003cb\u003eà direita\u003c/b\u003e para \u003cb\u003eR. Itapeva\u003c/b\u003e",
  "polyline" : {
  "points" : "`aynClhw{GcBgBYY}@oAwFyB_E}AGOuBcFqAwCeA{AgBeC"
  },
  "start_location" : {
  "lat" : -23.562570,
  "lng" : -46.65495000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,2 km",
  "value" : 163
  },
  "duration" : {
  "text" : "1 min",
  "value" : 30
  },
  "end_location" : {
  "lat" : -23.556060,
  "lng" : -46.64989000000001
  },
  "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e na \u003cb\u003eR. Rocha\u003c/b\u003e",
  "polyline" : {
  "points" : "naxnCtgv{GcHb@"
  },
  "start_location" : {
  "lat" : -23.557520,
  "lng" : -46.64971000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,5 km",
  "value" : 467
  },
  "duration" : {
  "text" : "2 minutos",
  "value" : 95
  },
  "end_location" : {
  "lat" : -23.555390,
  "lng" : -46.64550000000001
  },
  "html_instructions" : "Na \u003cb\u003ePraça Quatorze-bis\u003c/b\u003e, pegue a \u003cb\u003e1ª\u003c/b\u003e saída para a \u003cb\u003eR. Manuel Dutra\u003c/b\u003e",
  "polyline" : {
  "points" : "jxwnCxhv{GCSIQMSMKOMQKSeHGcBIwCOkEAOAO"
  },
  "start_location" : {
  "lat" : -23.556060,
  "lng" : -46.64989000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,1 km",
  "value" : 142
  },
  "duration" : {
  "text" : "1 min",
  "value" : 44
  },
  "end_location" : {
  "lat" : -23.554120,
  "lng" : -46.645670
  },
  "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e na \u003cb\u003eR. João Passaláqua\u003c/b\u003e",
  "polyline" : {
  "points" : "dtwnCjmu{G}F`@"
  },
  "start_location" : {
  "lat" : -23.555390,
  "lng" : -46.64550000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,2 km",
  "value" : 204
  },
  "duration" : {
  "text" : "1 min",
  "value" : 22
  },
  "end_location" : {
  "lat" : -23.554850,
  "lng" : -46.64416000000001
  },
  "html_instructions" : "Curva suave à \u003cb\u003edireita\u003c/b\u003e na \u003cb\u003eR. Prof. Laerte Ramos de Carvalho\u003c/b\u003e",
  "polyline" : {
  "points" : "flwnClnu{Ga@KESHSTYb@e@`AuAr@cB"
  },
  "start_location" : {
  "lat" : -23.554120,
  "lng" : -46.645670
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,2 km",
  "value" : 241
  },
  "duration" : {
  "text" : "1 min",
  "value" : 19
  },
  "end_location" : {
  "lat" : -23.55547000000001,
  "lng" : -46.64190000000001
  },
  "html_instructions" : "Pegue a rampa de acesso à \u003cb\u003eesquerda\u003c/b\u003e para a \u003cb\u003eVd. Júlio de Mesquita Filho\u003c/b\u003e",
  "polyline" : {
  "points" : "xpwnC~du{GJm@FY@MRmARoADQ\\_BX}A"
  },
  "start_location" : {
  "lat" : -23.554850,
  "lng" : -46.64416000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,6 km",
  "value" : 595
  },
  "duration" : {
  "text" : "1 min",
  "value" : 31
  },
  "end_location" : {
  "lat" : -23.556410,
  "lng" : -46.636160
  },
  "html_instructions" : "Continue para \u003cb\u003eVd. Jaceguai\u003c/b\u003e",
  "polyline" : {
  "points" : "ttwnCzvt{G@IBe@HqAPiD?K@Q@Q@I?GDUN{@BSD]LqA\\iDLeA@KBU@IBSBQ@YXsCDUBU@G@I?I"
  },
  "start_location" : {
  "lat" : -23.55547000000001,
  "lng" : -46.64190000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,3 km",
  "value" : 322
  },
  "duration" : {
  "text" : "1 min",
  "value" : 17
  },
  "end_location" : {
  "lat" : -23.556530,
  "lng" : -46.633020
  },
  "html_instructions" : "Continue para \u003cb\u003eAv. Radial Leste-oeste\u003c/b\u003e",
  "polyline" : {
  "points" : "pzwnC~rs{GBOZsD@I?KBsD?M?KKwDAS"
  },
  "start_location" : {
  "lat" : -23.556410,
  "lng" : -46.636160
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,4 km",
  "value" : 373
  },
  "duration" : {
  "text" : "1 min",
  "value" : 30
  },
  "end_location" : {
  "lat" : -23.556290,
  "lng" : -46.629380
  },
  "html_instructions" : "Pegue a saída à \u003cb\u003eesquerda\u003c/b\u003e em direção a \u003cb\u003eR. Glicério\u003c/b\u003e",
  "polyline" : {
  "points" : "h{wnCj_s{GEq@OkBIqDSqFCcBBSB]"
  },
  "start_location" : {
  "lat" : -23.556530,
  "lng" : -46.633020
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "52 m",
  "value" : 52
  },
  "duration" : {
  "text" : "1 min",
  "value" : 18
  },
  "end_location" : {
  "lat" : -23.556730,
  "lng" : -46.62956000000001
  },
  "html_instructions" : "Vire à \u003cb\u003edireita\u003c/b\u003e na \u003cb\u003eR. Glicério\u003c/b\u003e",
  "polyline" : {
  "points" : "xywnCrhr{GXHTFf@P"
  },
  "start_location" : {
  "lat" : -23.556290,
  "lng" : -46.629380
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,3 km",
  "value" : 298
  },
  "duration" : {
  "text" : "1 min",
  "value" : 50
  },
  "end_location" : {
  "lat" : -23.55755000000001,
  "lng" : -46.626820
  },
  "html_instructions" : "Pegue a 1ª \u003cb\u003eà esquerda\u003c/b\u003e para \u003cb\u003eR. São Paulo\u003c/b\u003e",
  "polyline" : {
  "points" : "p|wnCvir{GpAiE~@_DNs@@eC"
  },
  "start_location" : {
  "lat" : -23.556730,
  "lng" : -46.62956000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "86 m",
  "value" : 86
  },
  "duration" : {
  "text" : "1 min",
  "value" : 19
  },
  "end_location" : {
  "lat" : -23.556780,
  "lng" : -46.62681000000001
  },
  "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e na \u003cb\u003eAv. Pref. Passos\u003c/b\u003e",
  "polyline" : {
  "points" : "taxnCrxq{GyCA"
  },
  "start_location" : {
  "lat" : -23.55755000000001,
  "lng" : -46.626820
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,4 km",
  "value" : 429
  },
  "duration" : {
  "text" : "1 min",
  "value" : 70
  },
  "end_location" : {
  "lat" : -23.55630,
  "lng" : -46.622630
  },
  "html_instructions" : "Vire à \u003cb\u003edireita\u003c/b\u003e na \u003cb\u003eR. Leopoldo Miguez\u003c/b\u003e",
  "polyline" : {
  "points" : "z|wnCpxq{GCi@m@uKIyAO{B@EMwBGo@"
  },
  "start_location" : {
  "lat" : -23.556780,
  "lng" : -46.62681000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "1,4 km",
  "value" : 1382
  },
  "duration" : {
  "text" : "2 minutos",
  "value" : 132
  },
  "end_location" : {
  "lat" : -23.563070,
  "lng" : -46.612230
  },
  "html_instructions" : "Curva suave à \u003cb\u003edireita\u003c/b\u003e na \u003cb\u003eAv. do Estado\u003c/b\u003e",
  "polyline" : {
  "points" : "zywnCl~p{Gj@_BfA}EViAl@mCl@gC|AkH`AwEn@gCz@iCRe@P_@lAgBbAoA^c@ZYx@k@hBgAfD{AbBc@l@MvAa@j@K"
  },
  "start_location" : {
  "lat" : -23.55630,
  "lng" : -46.622630
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "3,1 km",
  "value" : 3107
  },
  "duration" : {
  "text" : "5 minutos",
  "value" : 315
  },
  "end_location" : {
  "lat" : -23.586450,
  "lng" : -46.598480
  },
  "html_instructions" : "Pegue a rampa de acesso à \u003cb\u003eesquerda\u003c/b\u003e para a \u003cb\u003eAv. do Estado\u003c/b\u003e",
  "polyline" : {
  "points" : "ddynCl}n{Gb@a@tAaATKpAo@TQ^WFCLGbPyHbBw@t@a@dBkBJONSN]Jm@LWJWvAkD\\q@tBiEbAoB^k@d@a@l@c@t@Y\\Kj@IbBG`BC|@Gr@Mj@Wn@c@`@W|AuARSbB_BjAiAfEeDtBwAdCeAlEuBjBk@ZIfC[lLNz@@T?R@T@zB?tBKnAIt@SvAi@lEsCx@e@"
  },
  "start_location" : {
  "lat" : -23.563070,
  "lng" : -46.612230
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,4 km",
  "value" : 391
  },
  "duration" : {
  "text" : "1 min",
  "value" : 31
  },
  "end_location" : {
  "lat" : -23.589940,
  "lng" : -46.59807000000001
  },
  "html_instructions" : "Curva suave à \u003cb\u003edireita\u003c/b\u003e na \u003cb\u003eAv. das Juntas Provisórias\u003c/b\u003e",
  "polyline" : {
  "points" : "hv}nCngl{GdFk@|EStFQ"
  },
  "start_location" : {
  "lat" : -23.586450,
  "lng" : -46.598480
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,3 km",
  "value" : 336
  },
  "duration" : {
  "text" : "1 min",
  "value" : 64
  },
  "end_location" : {
  "lat" : -23.590250,
  "lng" : -46.601350
  },
  "html_instructions" : "Pegue a 3ª \u003cb\u003eà direita\u003c/b\u003e para \u003cb\u003eR. Alm. Lobo\u003c/b\u003e",
  "polyline" : {
  "points" : "bl~nC|dl{GP~CRpFV|F"
  },
  "start_location" : {
  "lat" : -23.589940,
  "lng" : -46.59807000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,3 km",
  "value" : 272
  },
  "duration" : {
  "text" : "1 min",
  "value" : 48
  },
  "end_location" : {
  "lat" : -23.592680,
  "lng" : -46.601120
  },
  "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e na 3ª rua transversal para \u003cb\u003eR. Silva Bueno\u003c/b\u003e",
  "polyline" : {
  "points" : "`n~nClyl{GhFUzFW"
  },
  "start_location" : {
  "lat" : -23.590250,
  "lng" : -46.601350
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,1 km",
  "value" : 126
  },
  "duration" : {
  "text" : "1 min",
  "value" : 25
  },
  "end_location" : {
  "lat" : -23.592780,
  "lng" : -46.602350
  },
  "html_instructions" : "Pegue a 2ª \u003cb\u003eà direita\u003c/b\u003e para \u003cb\u003eR. Lorde Cockrane\u003c/b\u003e",
  "polyline" : {
  "points" : "f}~nC~wl{GRtF"
  },
  "start_location" : {
  "lat" : -23.592680,
  "lng" : -46.601120
  },
  "travel_mode" : "DRIVING"
  }
  ],
  "via_waypoint" : []
  },
  {
  "distance" : {
  "text" : "13,7 km",
  "value" : 13741
  },
  "duration" : {
  "text" : "27 minutos",
  "value" : 1598
  },
  "end_address" : "Rua Domingos Luís - Santana, São Paulo, República Federativa do Brasil",
  "end_location" : {
  "lat" : -23.493080,
  "lng" : -46.615160
  },
  "start_address" : "Rua Lino Coutinho - Ipiranga, São Paulo, República Federativa do Brasil",
  "start_location" : {
  "lat" : -23.592780,
  "lng" : -46.602350
  },
  "steps" : [
  {
  "distance" : {
  "text" : "0,5 km",
  "value" : 498
  },
  "duration" : {
  "text" : "1 min",
  "value" : 89
  },
  "end_location" : {
  "lat" : -23.592360,
  "lng" : -46.597490
  },
  "html_instructions" : "Siga na direção \u003cb\u003eleste\u003c/b\u003e na \u003cb\u003eR. Lorde Cockrane\u003c/b\u003e em direção à \u003cb\u003eR. Silva Bueno\u003c/b\u003e",
  "polyline" : {
  "points" : "z}~nCt_m{GSuFUyFK_CGqBMcDA]Eg@"
  },
  "start_location" : {
  "lat" : -23.592780,
  "lng" : -46.602350
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,4 km",
  "value" : 410
  },
  "duration" : {
  "text" : "1 min",
  "value" : 65
  },
  "end_location" : {
  "lat" : -23.588680,
  "lng" : -46.59782000000001
  },
  "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e na \u003cb\u003eAv. das Juntas Provisórias\u003c/b\u003e",
  "polyline" : {
  "points" : "f{~nChal{GkEPm@@mFVcFRS@"
  },
  "start_location" : {
  "lat" : -23.592360,
  "lng" : -46.597490
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,2 km",
  "value" : 217
  },
  "duration" : {
  "text" : "1 min",
  "value" : 51
  },
  "end_location" : {
  "lat" : -23.586750,
  "lng" : -46.598060
  },
  "html_instructions" : "Curva suave à \u003cb\u003eesquerda\u003c/b\u003e na \u003cb\u003eVd. Gazeta do Ipiranga\u003c/b\u003e",
  "polyline" : {
  "points" : "fd~nCjcl{GWFQDMBKBmAF}@DG?eCHc@@"
  },
  "start_location" : {
  "lat" : -23.588680,
  "lng" : -46.59782000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "3,0 km",
  "value" : 2991
  },
  "duration" : {
  "text" : "5 minutos",
  "value" : 309
  },
  "end_location" : {
  "lat" : -23.564150,
  "lng" : -46.610950
  },
  "html_instructions" : "Pegue a rampa de acesso para a \u003cb\u003eAv. do Estado\u003c/b\u003e",
  "polyline" : {
  "points" : "dx}nCzdl{GW@w@Fg@N[L_A~@u@l@e@V_AXaBf@kC^kDEmAEG?SAK?M?a@CeICoBFiAJkCr@gGfCkFpC_B`AqB`Bw@v@iCfCwBrBg@\\_@Pq@Tw@JmELm@Bs@Nm@Pq@`@q@p@u@fAcBbDkCrFs@rAaAhBUt@e@v@S^g@d@w@f@mAj@mBx@mCrAi@TsErBq@^WPYR"
  },
  "start_location" : {
  "lat" : -23.586750,
  "lng" : -46.598060
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "2,0 km",
  "value" : 2008
  },
  "duration" : {
  "text" : "3 minutos",
  "value" : 180
  },
  "end_location" : {
  "lat" : -23.55324000000001,
  "lng" : -46.62550
  },
  "html_instructions" : "Continue para \u003cb\u003eAv. do Estado - Pista Central\u003c/b\u003e",
  "polyline" : {
  "points" : "|jynClun{GYVyAr@OH{B~@iD|A{Ap@{CvAqAr@{@l@aAt@_A~@m@t@m@z@s@lAIRSb@M\\M^Wx@s@jCs@hDeAlEs@dDcAvEQr@WjA{@vDeAvCMT_ApBiAdBm@x@o@l@gB~AkA|@]TEBEDIDUNGBc@V"
  },
  "start_location" : {
  "lat" : -23.564150,
  "lng" : -46.610950
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "2,5 km",
  "value" : 2528
  },
  "duration" : {
  "text" : "4 minutos",
  "value" : 234
  },
  "end_location" : {
  "lat" : -23.531830,
  "lng" : -46.625480
  },
  "html_instructions" : "Continue para \u003cb\u003eAv. do Estado\u003c/b\u003e",
  "polyline" : {
  "points" : "vfwnCjpq{GWJODQDKBkBTSBKDIBKBMBEBODSFs@RyA`@kEnAy@Zk@R}@f@{@`@QFi@VgBz@QHSJ{@d@sB|@eDv@_BVq@BuANe@@G?k@@}@BeCIiAMUCYEQCi@GyA_@eBi@{@YQISGa@OWIo@UICoAa@e@QiAa@yAi@{IsCUI[KwIcDoBs@uCi@eACu@?aBJs@LuElA"
  },
  "start_location" : {
  "lat" : -23.55324000000001,
  "lng" : -46.62550
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "3,7 km",
  "value" : 3653
  },
  "duration" : {
  "text" : "7 minutos",
  "value" : 393
  },
  "end_location" : {
  "lat" : -23.4990,
  "lng" : -46.624490
  },
  "html_instructions" : "Curva suave à \u003cb\u003edireita\u003c/b\u003e na \u003cb\u003eAv. Cruzeiro do Sul\u003c/b\u003e",
  "polyline" : {
  "points" : "|`snCfpq{G{BKgFAS?sSQa@?]?cA?}BAo@A_BAo@Aw@AqEKcA@yDCiDCsBCS?I?[?I?S?O?MAU?W?U?OAo@A]AYAK?M?G@G?E?I?G?O?}@AqEGmKWiCEeFGW?aDE}C@MAQ?iHGqDGcB?uB@uBGUAK?M?gCGS?_FMgBAkB?wBCeAAgAKkA?S?gA?sE?_D?e@AY?yCC"
  },
  "start_location" : {
  "lat" : -23.531830,
  "lng" : -46.625480
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,5 km",
  "value" : 543
  },
  "duration" : {
  "text" : "2 minutos",
  "value" : 103
  },
  "end_location" : {
  "lat" : -23.499210,
  "lng" : -46.61917000000001
  },
  "html_instructions" : "Vire à \u003cb\u003edireita\u003c/b\u003e na \u003cb\u003eR. Cnso. Saraiva\u003c/b\u003e",
  "polyline" : {
  "points" : "vslnC`jq{GDqBB_BBkBD{BAoADwCDiCDmCDmB"
  },
  "start_location" : {
  "lat" : -23.4990,
  "lng" : -46.624490
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,4 km",
  "value" : 360
  },
  "duration" : {
  "text" : "1 min",
  "value" : 57
  },
  "end_location" : {
  "lat" : -23.49640,
  "lng" : -46.61741000000001
  },
  "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e na \u003cb\u003eR. Antônio Guganis\u003c/b\u003e",
  "polyline" : {
  "points" : "`ulnCxhp{GqP_J"
  },
  "start_location" : {
  "lat" : -23.499210,
  "lng" : -46.61917000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "73 m",
  "value" : 73
  },
  "duration" : {
  "text" : "1 min",
  "value" : 17
  },
  "end_location" : {
  "lat" : -23.496080,
  "lng" : -46.618030
  },
  "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e na \u003cb\u003eR. Padre Azevedo\u003c/b\u003e",
  "polyline" : {
  "points" : "nclnCx}o{Gg@jAWn@"
  },
  "start_location" : {
  "lat" : -23.49640,
  "lng" : -46.61741000000001
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "0,5 km",
  "value" : 452
  },
  "duration" : {
  "text" : "2 minutos",
  "value" : 92
  },
  "end_location" : {
  "lat" : -23.493130,
  "lng" : -46.615110
  },
  "html_instructions" : "Pegue a 1ª \u003cb\u003eà direita\u003c/b\u003e para \u003cb\u003eR. Prof. Fábio Fanucchi\u003c/b\u003e",
  "polyline" : {
  "points" : "nalnCtap{G]Sq@_@_@SkAq@_Ac@aAm@_@e@CCk@aAYi@o@iA}@qAw@iA"
  },
  "start_location" : {
  "lat" : -23.496080,
  "lng" : -46.618030
  },
  "travel_mode" : "DRIVING"
  },
  {
  "distance" : {
  "text" : "8 m",
  "value" : 8
  },
  "duration" : {
  "text" : "1 min",
  "value" : 8
  },
  "end_location" : {
  "lat" : -23.493080,
  "lng" : -46.615160
  },
  "html_instructions" : "Vire à \u003cb\u003eesquerda\u003c/b\u003e na \u003cb\u003eR. Domingos Luís\u003c/b\u003e",
  "polyline" : {
  "points" : "`oknCloo{GIH"
  },
  "start_location" : {
  "lat" : -23.493130,
  "lng" : -46.615110
  },
  "travel_mode" : "DRIVING"
  }
  ],
  "via_waypoint" : []
  }
  ],
  "overview_polyline" : {
  "points" : "ddynCvdw{GcBtBcBgBYY}@oAwLwE}BsFqAwCeA{AgBeCcHb@CSIQ[_@a@Y[iK]cK}F`@a@KESHSx@_A`AuAr@cBRgAT{AXaBv@}D`@kHDy@XmB~@_JJ_ADk@^iDFq@`@yEBaEKcEGeAOkBIqDWuIFq@n@Pf@PpAiE~@_DNs@@eCyCAq@_MYuEK}BGo@j@_B~AgHzAuG~CcOn@gCz@iCd@eAlAgBbAoAz@}@bDsBfD{AbBc@dCo@j@Kb@a@tAaATKpAo@TQf@[pPaIxCyApB{B^q@Jm@LWbBcErC{FbAoB^k@rAeArAe@j@IbBG`BC|@Gr@Mj@WpA{@`HsGfEeDtBwAdCeAlEuBfCu@fC[lLNpA@h@BzB?tBKnAIt@SvAi@lEsCx@e@dFk@rMe@d@pKV|FhFUzFWRtFi@oNSqFOaEEg@kEP{GXwFTcATyGV{@Bw@Fg@N[L_A~@u@l@e@VaD`AkC^kDEuAE_@Ao@CeICoBFiAJkCr@gGfCkFpC_B`AqB`BaE~DwBrBg@\\qAf@w@JmELm@Bs@Nm@Pq@`@q@p@u@fAoFvKuB|DUt@e@v@S^g@d@w@f@mAj@mBx@mCrA}FhCiAp@s@j@iB|@eH|CwFhCqAr@{@l@aAt@_A~@{ApB}@`Ba@`Ae@xAs@jCs@hDyBrJiDnOsAlD_ApBiAdBm@x@o@l@gB~AkA|@c@XOJ]R{@b@a@JwBXu@Pw@TmCt@kEnAy@Zk@R}@f@mAh@wDhB{@d@sB|@eDv@_BVq@BuANm@@iBDeCIiAMo@I{@K_EiAmAc@}Bw@iEyAgNsEgMwEuCi@eACu@?aBJs@LuElA{BKgFAgTQaGAwFGqEKcA@cJGmDCoCCsBEc@@_BA_R_@oJMyDEkD?{HGuGGuB@uBGa@AiKUsEA}DEgAKkA?{A?sLAyCCDqBFkED{BAoAJaHJ{FqP_Jg@jAWn@]SqAs@kCuAaAm@_@e@o@eAiAsBuB{CIH"
  },
  "summary" : "Av. do Estado e Av. Cruzeiro do Sul",
  "warnings" : [],
  "waypoint_order" : [ 0 ]
  }
  ],
  "status" : "OK"
  }

*)

{ TGoogleDirecoesItem }

function TGoogleDirecoesItem.getText: string;
begin
  result := endereco + ' (' + distancia_text + ') ';
end;

end.
