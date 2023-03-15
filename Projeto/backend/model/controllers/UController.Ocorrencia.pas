unit UController.Ocorrencia;

interface

uses
  Horse,
  GBSwagger.Path.Attributes,
  UController.Base,
  UEntity.Ocorrencias;

type
  [SwagPath('ocorrencia', 'Ocorr�ncia')]
  TControllerOcorrencia = class(TControllerBase)
  private

  public
    [SwagGET('Listar Ocorr�ncias', True)]
    [SwagResponse(200, TOcorrencia, 'Informa��es da Ocorr�ncia', True)]
    [SwagResponse(404)]
    class procedure Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

    [SwagGET('{id}', 'Procurar uma Ocorr�ncia')]
    [SwagParamPath('id', 'id da Ocorr�ncia')]
    [SwagResponse(200, TOcorrencia, 'Informa��es da Ocorr�ncia')]
    [SwagResponse(404)]
    class procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

    [SwagGET('usuario/{id}','Listar ocorr�ncias de um usu�rio')]
    [SwagResponse(200, TOcorrencia, 'Informa��es de ocorr�ncias de um usu�rio', True)]
    [SwagResponse(404)]
    class procedure GetsByUser(Req: THorseRequest; Res: THorseResponse; Next: TProc);

    [SwagGET('bairro/{bairro}','Listar ocorr�ncias de um bairro')]
    [SwagResponse(200, TOcorrencia, 'Informa��es de ocorr�ncias de um bairro', True)]
    [SwagResponse(404)]
    class procedure GetsByBairro(Req: THorseRequest; Res: THorseResponse; Next: TProc);

    [SwagGET('logradouro/{logradouro}','Listar ocorr�ncias de um logradouro')]
    [SwagResponse(200, TOcorrencia, 'Informa��es de ocorr�ncias de um logradouro', True)]
    [SwagResponse(404)]
    class procedure GetsByLogradouro(Req: THorseRequest; Res: THorseResponse; Next: TProc);

    [SwagPOST('Adicionar Nova Ocorr�ncia')]
    [SwagParamBody('Informa��es da Ocorrencia', TOcorrencia)]
    [SwagResponse(201)]
    [SwagResponse(400)]
    class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

    [SwagUPDATE('Atualizar uma Ocorr�ncia')]
    [SwagParamBody('Informa��es da Ocorrencia', TOcorrencia)]
    [SwagResponse(204)]
    [SwagResponse(400)]
    [SwagResponse(404)]
    class procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);

    [SwagDELETE('{id}', 'Deletar uma Ocorr�ncia')]
    [SwagParamPath('id', 'Id da Ocorr�ncia')]
    [SwagResponse(204)]
    [SwagResponse(400)]
    [SwagResponse(404)]
    class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

  end;

implementation

{ TControllerOcorrencia }

uses
  UDAO.Ocorrencia, System.SysUtils, JSON, UEntity.Enderecos, UEntity.Usuarios,
  System.DateUtils;

class procedure TControllerOcorrencia.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOOcorrencia.Create;
  inherited;
end;

class procedure TControllerOcorrencia.Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOOcorrencia.Create;
  inherited;
end;

class procedure TControllerOcorrencia.Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOOcorrencia.Create;
  inherited;
end;

class procedure TControllerOcorrencia.GetsByBairro(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xBairro: String;
begin
  if (Req.Params.Count <> 1) or (not(Req.Params.ContainsKey('bairro'))) then
  begin
    Res.Status(THTTPStatus.BadRequest);
    Exit;
  end;
  xBairro := Req.Params.Items['bairro'];
  FDAO := TDAOOcorrencia.Create;
  Res.Send<TJSONArray>(TDAOOcorrencia(FDAO).ObterRegistrosPorBairro(xBairro));
end;

class procedure TControllerOcorrencia.GetsByLogradouro(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xLogradouro: String;
begin
  if (Req.Params.Count <> 1) or (not(Req.Params.ContainsKey('logradouro'))) then
  begin
    Res.Status(THTTPStatus.BadRequest);
    Exit;
  end;
  xLogradouro := Req.Params.Items['logradouro'];
  FDAO := TDAOOcorrencia.Create;
  Res.Send<TJSONArray>(TDAOOcorrencia(FDAO).ObterRegistrosPorLogradouro(xLogradouro));
end;

class procedure TControllerOcorrencia.GetsByUser(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xId: Integer;
begin
  if (Req.Params.Count <> 1) or (not(Req.Params.ContainsKey('id'))) then
  begin
    Res.Status(THTTPStatus.BadRequest);
    Exit;
  end;
  xId := StrToIntDef(Req.Params.Items['id'], 0);
  FDAO := TDAOOcorrencia.Create;
  Res.Send<TJSONArray>(TDAOOcorrencia(FDAO).ObterRegistrosPorUsuario(xId));
end;

class procedure TControllerOcorrencia.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOOcorrencia.Create;
  inherited;
end;

class procedure TControllerOcorrencia.Update(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xJSON: TJSONObject;
  xId, xIdStatus, xQtdApoio : Integer;
begin
  xJSON := Req.Body<TJSONObject>;

  xId := xJSON.GetValue<Integer>('id');
  xIdStatus := xJSON.GetValue<Integer>('idstatus');
  xQtdApoio := xJSON.GetValue<Integer>('qtdapoio');

  FDAO := TDAOOcorrencia.Create;
  if TDAOOcorrencia(FDAO).AtualizarRegistro(xId, xIdStatus, xQtdApoio) then
    Res.Status(THTTPStatus.OK)
  else
    Res.Status(THTTPStatus.InternalServerError);
end;

end.
