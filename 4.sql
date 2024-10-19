-- Linha 1: Cria ou substitui o procedimento FAZ_ALGO com dois parâmetros:
--          - IN X INTEGER: Parâmetro de entrada do tipo inteiro.
--          - OUT Y REAL: Parâmetro de saída do tipo real.
CREATE OR REPLACE PROCEDURE FAZ_ALGO(IN X INTEGER, OUT Y REAL)
AS $$
BEGIN
  -- Linha 5: Calcula o valor de Y adicionando 5% ao valor de X.
  Y := X + X * 0.05;
END;
$$ LANGUAGE plpgsql;

-- Como chamar o procedimento:

-- Linha 9: Inicia um bloco anônimo para executar o procedimento.
DO $$
DECLARE
  -- Linha 11: Declara uma variável para armazenar o resultado.
  resultado REAL;
BEGIN
  -- Linha 14: Chama o procedimento FAZ_ALGO com o valor 100 e armazena o resultado em 'resultado'.
  CALL FAZ_ALGO(100, resultado);
  -- Linha 16: Exibe o resultado usando RAISE NOTICE.
  RAISE NOTICE 'O resultado é: %', resultado;
END;
$$ LANGUAGE plpgsql;
