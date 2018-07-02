
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
ADD COLUMN sexo ENUM ('F', 'f', 'M', 'm');

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

/*Inserir dados em todas as tabelas utilizando insert*/
INSERT INTO departamento
(CodDepartamento, Descricao) VALUES 
('102' , 'Comercial'),
('103' , 'Recursos Humanos'),
('104' , 'Informática'),
('105' , 'Tecnologia');

INSERT INTO funcionario
(CodFuncionario, Nome, CodDepartamento) VALUES 
('2' , 'Paulo Mendes', '101'),
('3' , 'Ricardo Freitas', '102'),
('4' , 'Ricardo Alves', '102'),
('5' , 'Catarina Rios', '102'),
('6' , 'Leonor Santos', '103'),
('7' , 'Alan Passos',  '104'),
('8' , 'José Maria', '104'); 

INSERT INTO tipo_equipamento
(CodTipoEquipamento, Descricao) VALUES 
('1' , 'Computador'),
('2' , 'Impressora'),
('3' , 'Fax'),
('4' , 'Monitor'),
('5' , 'Fotocopiadora');


INSERT INTO equipamento
(Etiqueta, Marca, Descricao, DataAquisicao, CodTipoEquipamento, CodDepartamento) VALUES 
('PC001CTB' , 'HP' , 'Computador DualCore 200GB', '2011-2-3', '1', '101' ),
('PC002CTB' , 'HP' , 'Computador DualCore 200GB', '2012-2-19', '1', '101' ),
('PC001INF' , 'HP' , 'Computador DualCore 500GB', '2012-12-19', '1', '104' ),
('PC002INF' , 'HP' , 'Computador DualCore 500GB', '2012-3-20', '1', '104' ),
('IM001INF' , 'HP' , 'Impressora HP Laserjet', '2012-3-28', '2', '104' );

INSERT INTO avaria
(CodAvaria, Descricao, DataAtual, Etiqueta, CodFuncionario) VALUES 
('1' , 'O computador não da partida' , '2011-3-3', 'PC001CTB', '2'),
('2' , 'Trocar o tonner' , '2012-5-28', 'IM001INF'          , '7'),
('3' , 'HD queimado' , '2013-3-18', 'PC002CTB', '3'),
('4' , 'teclado ruim' , '2014-2-10', 'PC001INF', '5'),
('5' , 'defeito na tela' , '2014-3-15', 'PC002INF', '8');

INSERT INTO intervencao
(CodIntervencao, Descricao, DataAtual, CodAvaria, CodFuncionario) VALUES 
('1' , 'Trocar a placa mãe' , '2011-3-5', '1', '8'),
('2' , 'Trocar tooner' , '2011-4-10', '2', '6'),
('3' , 'Trocar HD' , '2012-5-15', '3', '3'),
('4' , 'Trocar teclado' , '2012-6-20', '4', '4'),
('5' , 'Trocar tela' , '2013-7-18', '5', '1');


/*Copias das tabelas*/
CREATE TABLE avarianova SELECT * FROM avaria;
CREATE TABLE departamentonova SELECT * FROM departamento;
CREATE TABLE equipamentonova SELECT * FROM equipamento;
CREATE TABLE funcionarionova SELECT * FROM funcionario;
CREATE TABLE intervencaonova SELECT * FROM intervencao;
CREATE TABLE tipo_equipamento_nova SELECT * FROM tipo_equipamento;


DELETE from funcionario;

DELETE from equipamentos WHERE CodDepartamento =
(SELECT CodDepartamento from departamento WHERE Descricao = 'Departamento Informatica');

UPDATE equipamento SET marca = 'Samsung';

UPDATE funcionario SET CodDepartamento = 101 WHERE nome LIKE 'Ricardo%';

UPDATE funcionario SET CodDepartamento =
(SELECT CodDepartamento from departamento WHERE descricao = 'Departamento informatica');

SELECT * from funcionarios;

SELECT * from funcionarios WHERE CodDepartamento = 
(SELECT CodDepartamento from departamento WHERE descricao = 'Comercial');

SELECT * from equipamento WHERE CodTipoEquipamento =
(SELECT CodTipoEquipamento from tipo_equipamento WHERE descricao = 'Computador');

SELECT nome from funcionario WHERE CodFuncionario =
(SELECT CodFuncionario from avaria);


-- Segunda parte

SELECT COUNT(funcionario.CodFuncionario), departamento.descricao FROM funcionario 
INNER JOIN departamento ON funcionario.CodDepartamento = departamento.CodDepartamento;


ALTER TABLE funcionario
ADD salario float(10);

UPDATE funcionario
SET salario = 2500
WHERE CodFuncionario = 1;


UPDATE funcionario
SET salario = 7000
WHERE CodFuncionario = 5;

UPDATE funcionario
SET salario = 7000
WHERE CodFuncionario = 3;


SELECT MAX(salario), MIN(salario), SUM(salario), AVG(salario) from funcionario ;

INSERT INTO avaria
(CodAvaria, Descricao, DataAtual, Etiqueta, CodFuncionario) VALUES 
('6' , 'Computador com problema' , '2015-3-3', 'PC001CTB', '3'),
('7' , 'Tela vazada' , '2014-5-02', 'PC002CTB', '4'),
('8' , 'Bateria ruim' , '2018-4-18', 'PC001INF', '7'),
('9' , 'Não liga' , '2017-9-02', 'PC002INF', '5');



SELECT funcionario.nome, COUNT(avaria.CodAvaria) FROM funcionario
INNER JOIN avaria ON funcionario.CodFuncionario = avaria.CodFuncionario;

SELECT intervencao.descricao, funcionario.nome, avaria.descricao, avaria.DataAtual FROM intervencao
INNER JOIN funcionario ON funcionario.CodFuncionario=intervencao.CodFuncionario
INNER JOIN avaria ON avaria.CodAvaria = intervencao.CodAvaria;

-- Função do SQL - YEAR()

SELECT COUNT(equipamento.Etiqueta), YEAR(equipamento.DataAquisicao)
FROM equipamento GROUP BY YEAR(equipamento.DataAquisicao);

SELECT tipo_equipamento.descricao, COUNT(equipamento.Etiqueta)
FROM equipamento INNER JOIN tipo_equipamento ON equipamento.CodTipoEquipamento = tipo_equipamento.CodTipoEquipamento
GROUP BY tipo_equipamento.descricao;

SELECT YEAR(equipamento.DataAquisicao), tipo_equipamento.descricao, COUNT(equipamento.Etiqueta)
FROM equipamento INNER JOIN tipo_equipamento
ON equipamento.CodTipoEquipamento = tipo_equipamento.CodTipoEquipamento
GROUP BY YEAR(equipamento.DataAquisicao), tipo_equipamento.descricao;


SELECT nome, salario from funcionario
GROUP BY nome, salario
having salario = (select MAX(salario) from funcionario);

SELECT descricao, etiqueta from avaria
where etiqueta in (select etiqueta from avaria where etiqueta like 'PC%' );

SELECT CodFuncionario from funcionario 
WHERE NOT EXISTS (SELECT CodFuncionario FROM intervencao 
	WHERE intervencao.CodFuncionario = funcionario.CodFuncionario);

-- Mostrar avarias que possuiram intervenções com exists, in  e join
SELECT CodAvaria from avaria
WHERE EXISTS(SELECT CodAvaria from intervencao
	WHERE avaria.CodAvaria = intervencao.CodAvaria);
    
SELECT CodAvaria from avaria
where CodAvaria in (SELECT CodAvaria from intervencao
	WHERE avaria.CodAvaria = intervencao.CodAvaria );

SELECT avaria.CodAvaria FROM avaria
INNER JOIN intervencao ON avaria.CodAvaria = intervencao.CodAvaria;

SELECT departamento.descricao, SUM(funcionario.salario) FROM departamento
INNER JOIN funcionario ON funcionario.CodDepartamento = departamento.CodDepartamento
GROUP BY departamento.descricao;

SELECT departamento.descricao, AVG(funcionario.salario) FROM departamento
INNER JOIN funcionario ON funcionario.CodDepartamento = departamento.CodDepartamento
GROUP BY departamento.descricao
ORDER BY AVG(funcionario.salario) desc ;

