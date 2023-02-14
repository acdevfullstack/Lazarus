unit Controller.ConcreteCreator;

{$mode ObjFPC}{$H+}

interface

uses
  Controller.Creator, Model.Product;

type

  { TFabricaPrazos }

  TFabricaPrazos = class(TInterfacedObject, IFactoryMethod)
    function ConsultarPrazo(const Prazo: string): ITipoPrazo;
  end;

implementation

uses
  Controller.ConcreteProduct;

{ TFabricaPrazos }

function TFabricaPrazos.ConsultarPrazo(const Prazo: string): ITipoPrazo;
begin
  // Factory Method
  // A decisão de qual método criar fica a critério deste método

  if Prazo = 'Mensal' then
    result := TPrazoMensal.Create
  else if Prazo = 'Semestral' then
    result := TPrazoSemestral.Create
  else if Prazo = 'Anual' then
    result := TPrazoAnual.Create;
end;

end.

