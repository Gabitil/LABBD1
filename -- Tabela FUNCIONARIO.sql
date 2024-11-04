-- Tabela FUNCIONARIO
CREATE TABLE FUNCIONARIO (
    Cpf CHAR(11) PRIMARY KEY,
    Primeiro_nome VARCHAR(50) NOT NULL,
    Ultimo_nome VARCHAR(50) NOT NULL,
    Data_nasc DATE,
    Endereco VARCHAR(100),
    Sexo CHAR(1),
    Salario DECIMAL(10, 2),
    Cpf_supervisor CHAR(11),
    Numero_departamento INT,
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf) ON DELETE SET NULL,
    FOREIGN KEY (Numero_departamento) REFERENCES DEPARTAMENTO(Numero_departamento) ON DELETE SET NULL
);

-- Tabela DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    Numero_departamento INT PRIMARY KEY,
    Nome_departamento VARCHAR(50) UNIQUE NOT NULL,
    Cpf_gerente CHAR(11) UNIQUE,
    Data_inicio_gerente DATE,
    FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(Cpf) ON DELETE SET NULL
);

-- Tabela LOCALIZACOES_DEPARTAMENTO
CREATE TABLE LOCALIZACOES_DEPARTAMENTO (
    Numero_departamento INT,
    Local VARCHAR(50),
    PRIMARY KEY (Numero_departamento, Local),
    FOREIGN KEY (Numero_departamento) REFERENCES DEPARTAMENTO(Numero_departamento) ON DELETE CASCADE
);

-- Tabela PROJETO
CREATE TABLE PROJETO (
    Numero_projeto INT PRIMARY KEY,
    Nome_projeto VARCHAR(50) NOT NULL,
    Local_projeto VARCHAR(50),
    Numero_departamento INT,
    FOREIGN KEY (Numero_departamento) REFERENCES DEPARTAMENTO(Numero_departamento) ON DELETE SET NULL
);

-- Tabela TRABALHA_EM
CREATE TABLE TRABALHA_EM (
    Cpf_funcionario CHAR(11),
    Numero_projeto INT,
    Horas DECIMAL(5, 2),
    PRIMARY KEY (Cpf_funcionario, Numero_projeto),
    FOREIGN KEY (Cpf_funcionario) REFERENCES FUNCIONARIO(Cpf) ON DELETE CASCADE,
    FOREIGN KEY (Numero_projeto) REFERENCES PROJETO(Numero_projeto) ON DELETE CASCADE
);

-- Tabela DEPENDENTE
CREATE TABLE DEPENDENTE (
    Cpf_funcionario CHAR(11),
    Nome_dependente VARCHAR(50),
    Sexo CHAR(1),
    Data_nascimento DATE,
    Parentesco VARCHAR(20),
    PRIMARY KEY (Cpf_funcionario, Nome_dependente),
    FOREIGN KEY (Cpf_funcionario) REFERENCES FUNCIONARIO(Cpf) ON DELETE CASCADE
);

-- Insert de funcionário
INSERT INTO FUNCIONARIO (Cpf, Primeiro_nome, Ultimo_nome, Data_nasc, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento) VALUES
('12345678966', 'João', 'Silva', '1965-01-01', 'Rua das Flores, 751, São Paulo, SP', 'M', 25000, NULL, 5),
('45646545786', 'Fernando', 'Lima', '1968-09-01', 'Rua da Lapa, 34, São Paulo, SP', 'M', 33000, '33344565587', 5),
('35345347376', 'Alice', 'Zelaya', '1965-10-11', 'Rua Sousa Lima, 95, Curitiba, PR', 'F', 41000, '98765432168', 1),
('33344565587', 'Maria', 'Silva', '1972-01-09', 'Rua das Antas, 532, Campinas, SP', 'F', 43000, NULL, 4),
('98765432168', 'André', 'Pereira', '1972-09-05', 'Rua da Consolação, 35, São Paulo, SP', 'M', 48000, '88866555756', 1),
('88866555756', 'Jorge', 'Britto', '1937-11-10', 'Rua do Horto, 36, São Paulo, SP', 'M', 55000, NULL, 1);

-- Insert de departamento
INSERT INTO DEPARTAMENTO (Numero_departamento, Nome_departamento, Cpf_gerente, Data_inicio_gerente) VALUES
(5, 'Pesquisa', '33344565587', '1988-05-22'),
(4, 'Administração', '98765432168', '1993-01-01'),
(1, 'Matriz', '88866555756', '1981-06-19');

-- Insert de localizações
INSERT INTO LOCALIZACOES_DEPARTAMENTO (Numero_departamento, Local) VALUES
(1, 'São Paulo'),
(1, 'Mauá'),
(4, 'Santo André'),
(5, 'São Paulo');

-- Insert de projeto
INSERT INTO PROJETO (Numero_projeto, Nome_projeto, Local_projeto, Numero_departamento) VALUES
(2, 'ProdutoX', 'Santo André', 5),
(3, 'ProdutoY', 'Blu', 1),
(10, 'Informática', 'Mauá', 4),
(20, 'Reorganização', 'São Paulo', 1),
(30, 'NovosBenefícios', 'Mauá', 4);

-- Insert de trabalha_em
INSERT INTO TRABALHA_EM (Cpf_funcionario, Numero_projeto, Horas) VALUES
('12345678966', 2, 32.5),
('12345678966', 3, 7.5),
('45646545786', 2, 20.0),
('35345347376', 2, 20.0),
('33344565587', 10, 10.0),
('33344565587', 20, 10.0),
('98765432168', 30, 30.0),
('88866555756', 30, 25.0),
('98765432168', 20, 35.0),
('88866555756', 20, NULL); -- Exemplo de violação de não-nulo

-- Insert de dependente
INSERT INTO DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco) VALUES
('33344565587', 'Alicia', 'F', '1989-05-05', 'Filha'),
('33344565587', 'Tiago', 'M', '1983-12-05', 'Filho'),
('33344565587', 'Janaína', 'F', '1968-03-03', 'Esposa'),
('98765432168', 'Michael', 'M', '1973-01-04', 'Filho'),
('88866555756', 'Andrea', 'F', '1972-08-10', 'Filha'),
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');


-- Exemplo de violação de domínio

INSERT INTO FUNCIONARIO (Cpf, Primeiro_nome, Ultimo_nome, Data_nasc, Endereco, Sexo, Salario) 
VALUES ('99999999999', 'Carlos', 'Ferreira', '1970-06-15', 'Rua dos Cravos, 123, SP', 'X', 30000);

-- Exemplo de violação de chave

INSERT INTO FUNCIONARIO (Cpf, Primeiro_nome, Ultimo_nome, Data_nasc, Endereco, Sexo, Salario) 
VALUES ('12345678966', 'Carlos', 'Ferreira', '1970-06-15', 'Rua dos Cravos, 123, SP', 'M', 30000);

-- Exemplo de violação não-nulo

INSERT INTO TRABALHA_EM (Cpf_funcionario, Numero_projeto, Horas) VALUES
('35345347376', 20, NULL);

-- Exemplo de integridade referencial

INSERT INTO FUNCIONARIO (Cpf, Primeiro_nome, Ultimo_nome, Data_nasc, Endereco, Sexo, Salario, Numero_departamento) 
VALUES ('99999999999', 'Carlos', 'Ferreira', '1970-06-15', 'Rua dos Cravos, 123, SP', 'M', 30000, 10);

