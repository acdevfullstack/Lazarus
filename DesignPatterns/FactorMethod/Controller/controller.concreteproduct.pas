unit Controller.ConcreteProduct;

{$mode ObjFPC}{$H+}

interface

uses
  Model.Product;

type
  { Concrete Product }
  // classe que implementa a Interface ITipoPrazo
  // e servirá como classe base para os tipos de prazos

  { TTipoPrazo }

  TTipoPrazo = class(TInterfacedObject, ITipoPrazo)
  protected
    ValorTotal: real;

    function GerarCalc(const Valor, Juros: real;
      const QtdeParcelas, Intervalo: smallint): string;
    function ConsultarTotal: string;
  public
    function ConsultarDescricao: string; virtual; abstract;
    function ConsultarJuros: string; virtual; abstract;
    function ConsultarCalc(const Valor: real;
      const QtdeParcelas: integer): string; virtual; abstract;
  end;

  // classe referente ao tipo de prazo mensal

  { TPrazoMensal }

  TPrazoMensal = class(TTipoPrazo)
  public
    function ConsultarDescricao: string; override;
    function ConsultarJuros: string; override;
    function ConsultarCalc(const Valor: real;
      const QtdeParcelas: integer): string; override;
  end;

  // classe referente ao tipo de prazo semestral

  { TPrazoSemestral }

  TPrazoSemestral = class(TTipoPrazo)
  public
    function ConsultarDescricao: string; override;
    function ConsultarJuros: string; override;
    function ConsultarCalc(const Valor: real;
      const QtdeParcelas: integer): string; override;
  end;

  // classe referente ao tipo de prazo anual

  { TPrazoAnual }

  TPrazoAnual = class(TTipoPrazo)
  public
    function ConsultarDescricao: string; override;
    function ConsultarJuros: string; override;
    function ConsultarCalc(const Valor: real;
      const QtdeParcelas: integer): string; override;
  end;

implementation

uses
  Classes, SysUtils;

{ TPrazoSemestral }

function TPrazoSemestral.ConsultarDescricao: string;
begin
   result := 'Prazo Semestral para Pagamento';
end;

function TPrazoSemestral.ConsultarJuros: string;
begin
  result := 'Juros de 5,8% simples ao semestre' + sLineBreak;
end;

function TPrazoSemestral.ConsultarCalc(const Valor: real;
  const QtdeParcelas: integer): string;
begin
   // chama o método da classe base,
  // informando o percentual de 5,8% e intervalo de 6 meses
  result := GerarCalc(Valor, 0.058, QtdeParcelas, 6);
end;

{ TPrazoMensal }

function TPrazoMensal.ConsultarDescricao: string;
begin
    result := 'Prazo Mensal para Pagamento';
end;

function TPrazoMensal.ConsultarJuros: string;
begin
  result := 'Juros de 3,1% simples ao mês' + sLineBreak;
end;

function TPrazoMensal.ConsultarCalc(const Valor: real;
  const QtdeParcelas: integer): string;
begin
  // chama o método da classe base,
  // informando o percentual de 3,1% e intervalo de 1 mês
  result := GerarCalc(Valor, 0.031, QtdeParcelas, 1);
end;

{ TPrazoAnual }

function TTipoPrazo.GerarCalc(const Valor, Juros: real;
  const QtdeParcelas, Intervalo: smallint): string;
var
  // TStringList para armazenar os dados das parcelas
  Lista: TStringList;
  // contador do número de parcelas
  nContador: smallint;
  // variável para armazenar o valor ajustado conforme os juros
  ValorAjustado: real;
  // variável para armazenar o valor com formatação de casas decimais
  ValorFormatado: string;
  // variável referente à data da parcela
  DataParcela: string;
begin
  // acumulador do valor de parcelas
  ValorTotal := 0;

  ValorAjustado := Valor;
  DataParcela := DateToStr(Date);
  Lista := TStringList.Create;
  try
    for nContador := 1 to QtdeParcelas do
    begin
      // calcula o valor
      ValorAjustado := ValorAjustado + (Valor * Juros);
      // soma o valor na variável acumuladora
      ValorTotal := ValorTotal + ValorAjustado;
      // formata o valor calculado
      ValorFormatado := FormatFloat('###,##0.00', ValorAjustado);
      // incrementa a data conforme o tipo de prazo (1, 6 ou 12)
      DataParcela := FormatDateTime('dd/mm/yyyy', IncMonth(StrToDate(DataParcela), Intervalo));

      // adiciona os dados da parcela na TStringList
      Lista.Add(Format('Parcela %.2d (%s): %s', [nContador, DataParcela, ValorFormatado]));
    end;
    // retorna o conteúdo da TStringList
    result := Lista.Text;
  finally
    FreeAndNil(Lista);
  end;
end;

function TTipoPrazo.ConsultarTotal: string;
begin
    result := 'Total: ' + FormatFloat('###,##0.00', ValorTotal);
end;

function TPrazoAnual.ConsultarDescricao: string;
begin
  result := 'Prazo Anual para Pagamento';
end;

function TPrazoAnual.ConsultarJuros: string;
begin
  result := 'Juros de 10,5% simples ao ano' + sLineBreak;
end;

function TPrazoAnual.ConsultarCalc(const Valor: real;
  const QtdeParcelas: integer): string;
begin
  // chama o método da classe base,
  // informando o percentual de 10,5% e intervalo de 12 meses
  result := GerarCalc(Valor, 0.105, QtdeParcelas, 12);
end;

end.

