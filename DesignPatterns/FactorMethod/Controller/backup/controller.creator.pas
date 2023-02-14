unit Controller.Creator;

{$mode ObjFPC}{$H+}

interface

uses
  Controller.Product;

type
  { Creator }
  IFactoryMethod = interface
    function ConsultarPrazo(const Prazo: string): ITipoPrazo;
  end;

implementation

end.

