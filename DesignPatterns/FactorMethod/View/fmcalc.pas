unit FMCalc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TfrmCalc }

  TfrmCalc = class(TForm)
    btnProcessar: TBitBtn;
    btnSair: TBitBtn;
    cbxQtdeParc: TComboBox;
    cbxPrazoPG: TComboBox;
    edtvrlatual: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    mmolog: TMemo;
    pnfundocabecalho: TPanel;
    pnFundo: TPanel;
    pnfundorodape: TPanel;
    procedure btnProcessarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtvrlatualKeyPress(Sender: TObject; var Key: char);
  private
     function validacampos: Boolean;

  end;

var
  frmCalc: TfrmCalc;

implementation

uses
  System.UITypes, Model.Product, Controller.Creator, Controller.ConcreteCreator;

{$R *.lfm}

{ TfrmCalc }

procedure TfrmCalc.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmCalc.edtvrlatualKeyPress(Sender: TObject; var Key: char);
begin
  if not (CharInSet(Key, ['0'..'9', #8])) then
  Key := #0;
end;

function TfrmCalc.validacampos: Boolean;
var
  vOK: Boolean;
begin
  vOK:= True;
  if Length(edtvrlatual.Text) < 1
  then
  begin
    MessageDlg('Digite valor atual.', mtInformation, [mbOK], 0);
    vOK:= False;
    Exit;
  end;

  if cbxQtdeParc.ItemIndex < 0
  then
  begin
    MessageDlg('Digite a quantidade de parcelas.', mtInformation, [mbOK], 0);
    cbxQtdeParc.DroppedDown := True;
    vOK:= False;
    Exit;
  end;

  if cbxPrazoPG.ItemIndex < 0
  then
  begin
    MessageDlg('Selecione o prazo de pagamento.', mtInformation, [mbOK], 0);
    cbxPrazoPG.DroppedDown := True;
    vOK:= False;
    Exit;
  end;

  Result:= vOK;
end;

procedure TfrmCalc.btnProcessarClick(Sender: TObject);
var
  FabricaPrazos: IFactoryMethod;
  TipoPrazo: ITipoPrazo;
  Valor: real;
  QtdeParcelas: integer;
begin
  if validacampos
  then
  begin
    // cria a fábrica (Factory Method)
    FabricaPrazos := TFabricaPrazos.Create;
    // retorna um objeto de tipo de prazo de acordo com o tipo de prazo
    TipoPrazo := FabricaPrazos.ConsultarPrazo(cbxPrazoPG.Text);

    // alimenta as variáveis
    Valor := StrToFloatDef(edtvrlatual.Text, 0);
    QtdeParcelas := StrToIntDef(cbxQtdeParc.Text, 0);

    // consulta o conteúdo do tipo de prazo retornado pela fábrica
    mmolog.Lines.Clear;
    mmolog.Lines.Add(TipoPrazo.ConsultarDescricao);
    mmolog.Lines.Add(TipoPrazo.ConsultarJuros);
    mmolog.Lines.Add(TipoPrazo.ConsultarCalc(Valor, QtdeParcelas));
    mmolog.Lines.Add(TipoPrazo.ConsultarTotal);
  end;
end;

end.

