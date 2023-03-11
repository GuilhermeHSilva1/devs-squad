unit UController.Ocorrencia;

interface

uses
  Horse,
  GBSwagger.Path.Attributes,
  UController.Base,
  UEntity.Ocorrencias;

type
  [SwagPath('ocorr�ncia', 'Ocorr�ncia')]
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

    [SwagPOST('Adicionar Nova Ocorr�ncia')]
    [SwagParamBody('Informa��es da Ocorrencia', TOcorrencia)]
    [SwagResponse(201)]
    [SwagResponse(400)]
    class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

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
  UDAO.Intf,
  UDAO.Ocorrencia,
  System.JSON,
  System.SysUtils;

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

class procedure TControllerOcorrencia.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOOcorrencia.Create;
  inherited;
end;

end.
