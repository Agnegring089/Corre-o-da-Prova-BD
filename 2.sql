-- 1. Criação das Tabelas

CREATE TABLE alunos (
  matricula INTEGER PRIMARY KEY,
  nome VARCHAR(100)
);

CREATE TABLE cursos (
  codigo INTEGER PRIMARY KEY,
  nome VARCHAR(100)
);

CREATE TABLE matriculas (
  codigo_mat INTEGER PRIMARY KEY,
  matricula INTEGER REFERENCES alunos(matricula),
  codigo INTEGER REFERENCES cursos(codigo)
);

-- 2. Inserção de Dados

INSERT INTO alunos (matricula, nome) VALUES (1, 'João');
INSERT INTO alunos (matricula, nome) VALUES (2, 'Maria');
INSERT INTO alunos (matricula, nome) VALUES (3, 'Pedro');

INSERT INTO cursos (codigo, nome) VALUES (101, 'Matemática');
INSERT INTO cursos (codigo, nome) VALUES (102, 'História');
INSERT INTO cursos (codigo, nome) VALUES (103, 'Biologia');

INSERT INTO matriculas (codigo_mat, matricula, codigo) VALUES (1001, 1, 101);
INSERT INTO matriculas (codigo_mat, matricula, codigo) VALUES (1002, 2, 101);
INSERT INTO matriculas (codigo_mat, matricula, codigo) VALUES (1003, 3, 102);

-- 3. Criação da Função

CREATE OR REPLACE FUNCTION obter_quantidade_alunos_por_curso()
RETURNS TABLE(nome_curso VARCHAR, quantidade_alunos BIGINT) AS $$
BEGIN
  RETURN QUERY
    SELECT c.nome AS nome_curso, COUNT(m.matricula) AS quantidade_alunos
    FROM cursos c
    LEFT JOIN matriculas m ON c.codigo = m.codigo
    GROUP BY c.nome
    ORDER BY c.nome;
END;
$$ LANGUAGE plpgsql;

-- 4. Uso da Função (com declarações de tipo apropriadas)

SELECT * FROM obter_quantidade_alunos_por_curso();

DO $$
DECLARE
  nome_curso VARCHAR;
  quantidade_alunos BIGINT;
BEGIN
  FOR nome_curso, quantidade_alunos IN SELECT * FROM obter_quantidade_alunos_por_curso() LOOP
    RAISE NOTICE 'Curso: %, Quantidade de Alunos: %', nome_curso, quantidade_alunos;
  END LOOP;
END;
$$ LANGUAGE plpgsql;
