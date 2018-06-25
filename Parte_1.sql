
/*********************************************** DDL *************************************************/
/*  Criação da base de dados  */
CREATE DATABASE atividade_banco
DEFAULT CHARACTER  SET utf8
DEFAULT COLLATE utf8_general_ci;

/*Criação das tabelas com as chaves primárias*/
CREATE TABLE departamento(
	CodDepartamento int(4) NOT NULL ,
    Descricao varchar(30),
    PRIMARY KEY(CodDepartamento)
) DEFAULT CHARSET= utf8;

CREATE TABLE funcionario(
	CodFuncionario int(4) NOT NULL,
    Nome varchar(100),
    CodDepartamento int(4) NOT NULL,
    PRIMARY KEY(CodFuncionario)
)DEFAULT CHARSET = utf8;

CREATE TABLE tipo_equipamento(
	CodTipoEquipamento int(4) NOT NULL,
    Descricao varchar(100),
    PRIMARY KEY(CodTipoEquipamento)
)DEFAULT CHARSET = utf8;

CREATE TABLE equipamento(
	Etiqueta varchar(8) NOT NULL,
    Marca varchar(2) NOT NULL,
    Descricao varchar(30),
    DataAquisicao date NOT NULL,
    CodTipoEquipamento int(4) NOT NULL,
    CodDepartamento int(4) NOT NULL,
    PRIMARY KEY(Etiqueta)
)DEFAULT CHARSET = utf8;

CREATE TABLE avaria(
	CodAvaria int(4) NOT NULL,
    Descricao varchar(30),
    DataAtual date NOT NULL,
    Etiqueta varchar(8) NOT NULL,
    CodFuncionario int(4) NOT NULL,
    PRIMARY KEY(CodAvaria)
)DEFAULT CHARSET = utf8;

CREATE TABLE intervencao(
	CodIntervencao int(4) NOT NULL,
    Descricao varchar(30),
    DataAtual date NOT NULL,
    CodAvaria int(4) NOT NULL,
    CodFuncionario int(4) NOT NULL,
    PRIMARY KEY(CodIntervencao)
)DEFAULT CHARSET = utf8;

/*Adição de chaves estrangeiras*/

ALTER TABLE funcionario ADD CONSTRAINT fk_funcionario 
FOREIGN KEY(CodDepartamento) 
REFERENCES departamento(CodDepartamento);

ALTER TABLE equipamento ADD CONSTRAINT fk_equipamento 
FOREIGN KEY(CodTipoEquipamento) 
REFERENCES tipo_equipamento(CodTipoEquipamento);

ALTER TABLE equipamento ADD CONSTRAINT fk_equipamento_dep 
FOREIGN KEY(CodDepartamento) 
REFERENCES departamento(CodDepartamento);

ALTER TABLE avaria ADD CONSTRAINT fk_avaria 
FOREIGN KEY(etiqueta) 
REFERENCES equipamento(etiqueta);

ALTER TABLE avaria ADD CONSTRAINT fk_avaria_func 
FOREIGN KEY(CodFuncionario) 
REFERENCES funcionario(CodFuncionario);

ALTER TABLE intervencao ADD CONSTRAINT fk_intervencao 
FOREIGN KEY(CodAvaria) 
REFERENCES avaria(CodAvaria);

ALTER TABLE intervencao ADD CONSTRAINT fk_intervencao_func 
FOREIGN KEY(CodFuncionario) 
REFERENCES funcionario(CodFuncionario);


/*Alteração da tabela Funcionario colocando a caracteristica nome como not null*/

ALTER TABLE funcionario
MODIFY COLUMN Nome varchar(30) NOT NULL; /*quando colocou somente not null, não foi*/


/* Apagar a constraint FK da tabela avaria  e adicionar*/

/*Apagar*/
ALTER TABLE avaria 
DROP FOREIGN KEY fk_avaria;

ALTER TABLE avaria 
DROP INDEX fk_avaria;

ALTER TABLE avaria 
DROP FOREIGN KEY fk_avaria_func;

ALTER TABLE avaria 
DROP INDEX fk_avaria_func;

/* Adicionar*/
ALTER TABLE avaria ADD CONSTRAINT fk_avaria 
FOREIGN KEY(etiqueta) 
REFERENCES equipamento(etiqueta);

ALTER TABLE avaria ADD CONSTRAINT fk_avaria_func 
FOREIGN KEY(CodFuncionario) 
REFERENCES funcionario(CodFuncionario);


/* criar domínio DOMSEXO que receba somente valores 'F' 'f' 'M' 'm' para os sexos

CREATE DOMAIN dom_sexo AS CHAR(1) CHECK
(value = 'F' or value= 'f' or value='M' or value='m');*/
 
/*Adição do atributo sexo na tabela funcionário e representação do domínio a partir de uma enum*/

ALTER TABLE funcionario
add column sexo enum('F', 'f', 'M', 'm');

/*Apagar a tabela departamento com a opção restrict*/

/*Criar registro de departamento e empregado*/
INSERT INTO departamento
(CodDepartamento, Descricao)
VALUES
('101','Contabilidade');

INSERT INTO funcionario
(CodFuncionario, Nome, CodDepartamento)
VALUES
('1','Ana Souza', '101');

/*Apagar a tabela departamento com restrict*/
DROP TABLE departamento RESTRICT;



/****************************************************** DML **************************************************/