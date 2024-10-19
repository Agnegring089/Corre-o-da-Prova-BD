-- Criação da tabela produto
CREATE TABLE IF NOT EXISTS produto (
  p_cod_produto INTEGER PRIMARY KEY,
  p_nome_produto VARCHAR(255),
  p_descricao TEXT,
  p_preco NUMERIC(10, 2),
  p_qtde_estoque INTEGER
);

-- Criação do procedimento para atualizar o preço de um produto
CREATE OR REPLACE PROCEDURE atualizar_preco_produto(
  codigo_produto INTEGER,
  novo_preco NUMERIC(10, 2)
)
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE produto
  SET p_preco = novo_preco
  WHERE p_cod_produto = codigo_produto;

  IF FOUND THEN
    RAISE NOTICE 'Preço do produto com código % atualizado para R$ %.2f.', codigo_produto, novo_preco;
  ELSE
    RAISE NOTICE 'Produto com código % não encontrado.', codigo_produto;
  END IF;
END;
$$;
