unit UController.Usuario;

interface

uses
  Horse,
  GBSwagger.Path.Attributes,
  UController.Base,
  UEntity.Usuarios;

type
  [SwagPath('users', 'Usu�rios')]
  TControllerUsuario = class(TControllerBase)
    private
    public
      class function ValidateUser(const aUserName, aPassWord: String): Boolean;

      [SwagGET('Listar Usu�rios', True)]
      [SwagResponse(200, TUsuario, 'Informa��es do Usu�rio', True)]
      [SwagResponse(404)]
      class procedure Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

      [SwagGET('{id}', 'Procurar um Usu�rio')]
      [SwagParamPath('id', 'id do Usu�rio')]
      [SwagResponse(200, TUsuario, 'Informa��es do Usu�rio')]
      [SwagResponse(404)]
      class procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

      [SwagPOST('Adicionar Novo Usu�rio')]
      [SwagParamBody('Informa��es do Usu�rio', TUsuario)]
      [SwagResponse(201)]
      [SwagResponse(400)]
      class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

      [SwagDELETE('{id}', 'Deletar um Usu�rio')]
      [SwagParamPath('id', 'Id do Usu�rio')]
      [SwagResponse(204)]
      [SwagResponse(400)]
      [SwagResponse(404)]
      class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
  end;

var
  GIdUser: Integer;

implementation

{ TControllerUser }

uses
  UDAO.Usuario,
  UDAO.Intf;

class procedure TControllerUsuario.Delete(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOUsuario.Create;
  Inherited;
end;

class procedure TControllerUsuario.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOUsuario.Create;
  Inherited;
end;

class procedure TControllerUsuario.Gets(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOUsuario.Create;
  Inherited;
end;

class procedure TControllerUsuario.Post(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOUsuario.Create;
  Inherited;
end;

class function TControllerUsuario.ValidateUser(const aUserName,
  aPassWord: String): Boolean;
var
  xDAO: IDAO;
begin
  xDAO   := TDAOUsuario.Create;

  GIdUser := TDAOUsuario(xDAO).ValidarLogin(aUserName, aPassWord);

  Result := GIdUser > 0;
end;

end.
