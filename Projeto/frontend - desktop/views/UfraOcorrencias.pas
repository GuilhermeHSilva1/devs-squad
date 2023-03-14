unit UfraOcorrencias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects, FMX.Controls.Presentation, UEntity.Ocorrencias, Skia, Skia.FMX;

type
  TfraOcorrencias = class(TFrame)
    fraOcorrencias: TLabel;
    rectLista: TRectangle;
    lstOcorrencias: TListView;
  private
    { Private declarations }
    procedure PreparaListView(aOcorrenciaUser: TOcorrencia);
  public
    { Public declarations }
    procedure CarregarRegistros;
  end;

var
  FraOcorrencia: TFraOcorrencias;

implementation

uses
  UService.Intf, UService.Ocorrencia,
  UService.Usuario.Authenticated;

{$R *.fmx}

{ TfraOcorrencias }

procedure TfraOcorrencias.CarregarRegistros;
var
  xServiceOcorrencia : IService;
  xOcorrencia : TOcorrencia;
begin
  lstOcorrencias.Items.Clear;

  xServiceOcorrencia := TServiceOcorrencia.Create;
  TServiceOcorrencia(xServiceOcorrencia).ListaPorUsuario(gbInstance.Usuario.Id);
  for xOcorrencia in TServiceOcorrencia(xServiceOcorrencia).Ocorrencias do
  begin
    Self.PreparaListView(xOcorrencia);
  end;

end;


procedure TfraOcorrencias.PreparaListView(aOcorrenciaUser: TOcorrencia);
var
  xItem: TListViewItem;
  xUrgencia: String;
begin
  xItem := lstOcorrencias.Items.Add;
  xItem.Tag := aOcorrenciaUser.Id;

  TListItemText(xItem.Objects.FindDrawable('txtBairro')).Text := 'Bairro: ' + aOcorrenciaUser.Endereco.Bairro;
  TListItemText(xItem.Objects.FindDrawable('txtRua')).Text := aOcorrenciaUser.Endereco.Logradouro;
  TListItemText(xItem.Objects.FindDrawable('txtApoiadores')).Text := 'Apoios: ' +  aOcorrenciaUser.QntApoio.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtNumero')).Text := 'N�: ' +  aOcorrenciaUser.Endereco.Numero.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtDescricao')).Text :=  'Descri��o: ' +  aOcorrenciaUser.Descricao;

  if aOcorrenciaUser.Urgencia.ToString = '0' then
    xUrgencia := 'N�o urgente'
  else
    xUrgencia := 'URGENTE';

  TListItemText(xItem.Objects.FindDrawable('txtUrgencia')).Text := xUrgencia;

end;

end.
