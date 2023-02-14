unit Model.Product;

{$mode ObjFPC}{$H+}

interface

type
  { Product }
  ITipoPrazo = interface
    function ConsultarDescricao: string;
    function ConsultarJuros: string;
    function ConsultarResultado(const Valor: real; const QtdeParcelas: integer): string;
    function ConsultarTotal: string;
  end;

  implementation
end.

