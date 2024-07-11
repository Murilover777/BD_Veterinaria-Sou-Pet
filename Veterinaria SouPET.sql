DROP SCHEMA IF EXISTS SouPet;
CREATE SCHEMA SouPet;
USE SouPet;

CREATE TABLE CLIENTE (
id_cliente int primary key  auto_increment,
nome varchar(100),
endereco varchar(100),
telefone bigint);

CREATE TABLE ANIMAL (
id_animal int primary key  auto_increment,
nome varchar(100),
idade varchar(100) ,
sexo varchar(2),
id_especie int,
id_cliente int);

CREATE TABLE CONSULTA (
id_consulta int primary key  auto_increment ,
dataC datetime,
historico varchar(100),
id_tratamento int,
id_veterinario int );

CREATE TABLE ESPECIE (
id_especie int primary key auto_increment,
descricao varchar(100)
);
CREATE TABLE EXAME (
id_exame int primary key auto_increment,
descricao varchar(100),
id_consulta int);

CREATE TABLE TRATAMENTO (
id_tratamento int primary key auto_increment,
data_inicial datetime,
data_final datetime,
id_animal int);

CREATE TABLE VETERINARIO (
id_veterinario int primary key auto_increment,
nome varchar(100),
endereco varchar(100),
telefone bigint);

-- fk--
ALTER TABLE EXAME
ADD CONSTRAINT FK_consulta FOREIGN KEY (id_consulta) REFERENCES CONSULTA(id_consulta);
ALTER TABLE CONSULTA
ADD CONSTRAINT FK_tratamento FOREIGN KEY (id_tratamento) REFERENCES TRATAMENTO(id_Tratamento);
ALTER TABLE CONSULTA
ADD CONSTRAINT FK_veterinario FOREIGN KEY (id_veterinario) REFERENCES VETERINARIO(id_veterinario);
ALTER TABLE TRATAMENTO
ADD CONSTRAINT FK_animal FOREIGN KEY (id_animal) REFERENCES ANIMAL(id_animal);
ALTER TABLE ANIMAL
ADD CONSTRAINT FK_especie FOREIGN KEY (id_especie) REFERENCES ESPECIE(id_especie) ;
ALTER TABLE ANIMAL
ADD CONSTRAINT FK_cliente FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente);
 
 
 insert into especie (descricao) values
('Cachorro'),
('Gato'),
('Passaro');

insert into cliente (nome,endereco,telefone)values
('Marta Rocha','Rua dos Inconfidentes 300 centro 24324564000 Belo Horizonte MG',31975233245),
('Joao Alves','Rua da Lapinha 23 centro 23498099000 Belo Horizonte MG',31987689088),
('Karina Angeli','Av Dom Bosco 241 Castelo 45698709000 Belo Horizonte MG',31990987765),
('Jonas Birra','Rua Caramelos 2321 Lurdes 32434333000 Belo Horizonte MG',31976556776),
('Tolentino Neves','Av Pedra Bonita 56 Padre-Eustaquio 80162343000 Belo Horizonte MG',31998123034);

insert into cliente (nome,endereco,telefone)values
('Teclaudio Barras','Rua dos Inconfidentes 300 centro 24324564000 Belo Horizonte MG',31975233245);

insert into VETERINARIO (nome,endereco,telefone)values
('DR.Jonas Campelo','Rua Comembol 23',31986433267),
('DRa.Marta Supliane','Av Meneslau 1225',31989077876),
('DRa.Ana Falange','Rua Fartura 980',31981233121);

insert into ANIMAL (nome,idade,sexo,id_especie,id_cliente ) values
('Todinho','6-meses','MA',1,1),
('Kiki','9-meses','FE',1,2),
('Bilu','2-anos','FE',2,3),
('Barba','3-anos','MA',3,4),
('Lisa','4-anos','FE',1,5),
('Toto','8-meses','MA',1,3);
insert into ANIMAL (nome,idade,sexo,id_especie,id_cliente ) values
('TodinhAo','6-meses','MA',1,1);
insert into TRATAMENTO (data_inicial,data_final,id_animal)values
('2016-03-12','2016-04-12',1),
('2016-04-01','2016-04-04',2),
('2017-03-11','2017-08-11',3),
('2017-03-03','2017-04-04',6),
('2017-03-10','2017-04-10',5);

insert into consulta (dataC,historico,id_tratamento,id_veterinario)values
('2016-02-12','Muita pulga',1,1),
('2016-03-01','Muita pulga',2,1),
('2017-03-11','Pelo Caindo',3,2),
('2017-02-03','Olho Lacrimejando',4,3),
('2016-02-10','Pata Quebrada',5,3);

insert into exame (descricao,id_consulta)values
('Analise de Pelo',1),
('Analise de Pelo',2),
('Analise de Pelo',3),
('Visão Ocular',4),
('Raio x',5);

SELECT cliente.nome,animal.nome,especie.descricao,tratamento.data_final FROM cliente
INNER JOIN animal
ON cliente.id_cliente = animal.id_cliente
inner join especie  on animal.id_especie = especie.id_especie
inner join tratamento on
animal.id_animal = tratamento.id_animal;




-- 1 Encontre o nome do veterinario e o nome do animal que fez uma consulta a algum animal.
select v.nome,a.nome from VETERINARIO as v join consulta as c
on v.id_veterinario = c.id_veterinario join tratamento as T 
on t.id_tratamento = c.id_tratamento join animal as A
on t.id_animal = a.id_animal;

-- 2 Encontre o nome do veterinario  que fez uma consulta ao Totó(nome do animal).
SELECT veterinario.nome AS Nome_Veterinario
FROM veterinario
INNER JOIN consulta ON veterinario.id_veterinario = consulta.id_veterinario
INNER JOIN tratamento ON consulta.id_tratamento = tratamento.id_tratamento
INNER JOIN animal ON tratamento.id_animal = animal.id_animal
WHERE animal.nome = 'Toto';

-- 3 Encontre qual exame fez o animal que tem como tutor Jonas Birra.
SELECT exame.descricao AS Exame_Realizado
FROM cliente
INNER JOIN animal ON cliente.id_cliente = animal.id_cliente
INNER JOIN consulta ON animal.id_animal = consulta.id_tratamento
INNER JOIN exame ON consulta.id_consulta = exame.id_consulta
WHERE cliente.nome = 'Jonas Birra';

-- 4 Encontre qual a data inicial e final de tratamento de todos os animais que o fizeram.
SELECT animal.nome, tratamento.data_inicial, tratamento.data_final
FROM animal
INNER JOIN tratamento ON animal.id_animal = tratamento.id_animal;

-- 5 Apresente o nome do tutor, o nome do animal, o tratamento que esse animal fez,
-- qual é a especie desse animal.
SELECT cliente.nome AS Tutor, animal.nome AS Nome_Animal, tratamento.id_tratamento AS Tratamento, especie.descricao AS Especie
FROM cliente
INNER JOIN animal ON cliente.id_cliente = animal.id_cliente
INNER JOIN tratamento ON animal.id_animal = tratamento.id_animal
INNER JOIN especie ON animal.id_especie = especie.id_especie;

-- 6 Apresente o nome do animal, que fez uma consulta com um veterinario(nome) e qual o periodo
-- de tratamento desse animal.
SELECT animal.nome AS Nome_Animal, veterinario.nome AS Nome_Veterinario, tratamento.data_inicial, tratamento.data_final
FROM animal
INNER JOIN tratamento ON animal.id_animal = tratamento.id_animal
INNER JOIN consulta ON tratamento.id_animal = consulta.id_tratamento
INNER JOIN veterinario ON consulta.id_veterinario = veterinario.id_veterinario;


-- 7 Apresente o nome do veterinario, quais consultas ele fez e quais os exames ele pediu.
SELECT veterinario.nome AS Nome_Veterinario, consulta.historico AS Historico_Consulta, exame.descricao AS Exame_Pedido
FROM veterinario
INNER JOIN consulta ON veterinario.id_veterinario = consulta.id_veterinario
INNER JOIN exame ON consulta.id_consulta = exame.id_consulta;

-- 8 Apresente a especie do animal, qual a data da consulta que ele fez e qual a data do inicio do tratamento
SELECT especie.descricao AS Especie, consulta.dataC AS Data_Consulta, tratamento.data_inicial AS Data_Inicio_Tratamento
FROM especie
INNER JOIN animal ON especie.id_especie = animal.id_especie
INNER JOIN tratamento ON animal.id_animal = tratamento.id_animal
INNER JOIN consulta ON tratamento.id_animal = consulta.id_tratamento;

-- 9 Qual nome do veterinario que consultou o toto, e qual o nome do tutor do animal.
SELECT veterinario.nome AS Nome_Veterinario, cliente.nome AS Tutor
FROM animal
INNER JOIN tratamento ON animal.id_animal = tratamento.id_animal
INNER JOIN consulta ON tratamento.id_animal = consulta.id_tratamento
INNER JOIN veterinario ON consulta.id_veterinario = veterinario.id_veterinario
INNER JOIN cliente ON animal.id_cliente = cliente.id_cliente
WHERE animal.nome = 'Toto';

-- 10 Quais os exames foram feitos. É preciso saber qual veterinario que os pediu nas consultas que realizou, e qual historico da consulta
SELECT exame.descricao AS Exame_Realizado, veterinario.nome AS Nome_Veterinario, consulta.historico AS Historico_Consulta
FROM exame
INNER JOIN consulta ON exame.id_consulta = consulta.id_consulta
INNER JOIN veterinario ON consulta.id_veterinario = veterinario.id_veterinario;