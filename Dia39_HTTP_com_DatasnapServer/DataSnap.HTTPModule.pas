{ *************************************************************************** }
{ }
{ }
{ Copyright (C) Amarildo Lacerda }
{ }
{ https://github.com/amarildolacerda }
{ }
{ }
{ *************************************************************************** }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{ http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{ }
{ *************************************************************************** }
{
  HowTo:
    unit WebModuleUnit1;
    ..
    private
          FHttpModule:TDataSnapHTTPModule;
    ..


    procedure TWebModule1.WebModuleCreate(Sender: TObject);
    begin
       // incia o a pasta onde será hospedado o URLBase para oa arquivos de HTTP
       FHttpModule:=TDataSnapHTTPModule.Create(self);
       FHttpModule.URLPath := ExtractFilePath(paramStr(0)) + 'www';
       ForceDirectories(FHttpModule.URLPath);
       ...
    end;


    procedure TWebModule1.WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    begin

      FHttpModule.GoURLDocument(Request, Response, Handled);
      if Handled then
        exit;
      ..
    end;


}
unit DataSnap.HTTPModule;

interface

uses System.Classes, System.SysUtils, IdGlobalProtocols, WEB.HttpApp;

type
  {TODO: incluir suporte a diretorio virtual}
  {TODO: incluir suporte a compactação do conteúdo}
  TDataSnapHTTPModule = class(TComponent)
  private
    FURLPath: string;
    FDefaultPage: string;
    procedure SetURLPath(const Value: string);
    procedure SetDefaultPage(const Value: string);
  public
    constructor create(AOwner: TComponent); override;
    procedure GoURLDocument(Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

  published
    property URLPath: string read FURLPath write SetURLPath;
    property DefaultPage: string read FDefaultPage write SetDefaultPage;
  end;


procedure Register;

implementation

//uses System.Classes.helper;

procedure Register;
begin
    RegisterComponents('Store',[TDataSnapHTTPModule]);
end;

{ TDataSnapHTTPModule }

procedure TDataSnapHTTPModule.SetDefaultPage(const Value: string);
begin
  FDefaultPage := Value;
end;

procedure TDataSnapHTTPModule.SetURLPath(const Value: string);
begin
  FURLPath := Value;
end;

constructor TDataSnapHTTPModule.create(AOwner: TComponent);
begin
  inherited;
  FURLPath := ExtractFilePath(paramStr(0)) + 'www';
  FDefaultPage := 'index.html';
end;

procedure TDataSnapHTTPModule.GoURLDocument(Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  doc: string;
  // str: TStringList; // exemplo usando Lendo com TStringList;
begin
  doc := StringReplace(FURLPath + Request.InternalPathInfo, '/', '\', [rfReplaceAll]);
  if Request.InternalPathInfo <> '' then
    if Request.InternalPathInfo[high(Request.InternalPathInfo)] = '/' then
      doc := doc + FDefaultPage; // pagina default
  if fileExists(doc) then
  begin
    // str := TStringList.create();
    try
      Response.ContentStream := TFileStream.create(doc, fmOpenRead);
      Response.FreeContentStream := false; // algumas versões do delphi não possuem este propriedade - nao há problema em ignora-la (o free é feito no finally)
      // str.LoadFromFile(doc, TEncoding.UTF8);
      // Response.Content := str.Text;
      Response.ContentType := GetMIMETypeFromFile(doc);  // obtem o tipo de documento a responder.
      Response.SendResponse;
      Handled := true;
    finally
      Response.ContentStream.Free;
      // str.Free;
    end;
  end;
end;

end.
