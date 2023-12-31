CREATE DATABASE EMPRESA;
USE EMPRESA;

CREATE TABLE EMPREGADO (
	ENOME VARCHAR (200),
    CPF VARCHAR (11),
    NASC DATE,
    ENDERECO VARCHAR (200),
    SEXO VARCHAR (1), #F OU M
    SALARIO FLOAT (6),
    SUPERV VARCHAR (11),
    DEPT VARCHAR (10), 
    PRIMARY KEY (CPF),
    FOREIGN KEY (SUPERV) REFERENCES EMPREGADO (CPF)
    #FOREIGN KEY (DEPT) REFERENCES DEPARTAMENTO (DNUM)
);
CREATE TABLE DEPARTAMENTO (
	DNOME VARCHAR (200),
    DNUM VARCHAR (10),
    GERENTE VARCHAR (11),
	PRIMARY KEY (DNUM),
	FOREIGN KEY (GERENTE) REFERENCES EMPREGADO (CPF)
);
ALTER TABLE EMPREGADO ADD FOREIGN KEY (DEPT) REFERENCES DEPARTAMENTO (DNUM);

CREATE TABLE LOCAL_DEPT (
	NUMDEPT VARCHAR (10),
    LOCALDEPT VARCHAR (10),
    PRIMARY KEY (NUMDEPT, LOCALDEPT),
    FOREIGN KEY (NUMDEPT) REFERENCES DEPARTAMENTO (DNUM)
);

CREATE TABLE PROJETO (
	PNOME VARCHAR (200),
    PNUM INT (10),
    PLOCAL VARCHAR (200),
    NUMDEPT VARCHAR (10),
    PRIMARY KEY (PNUM),
    FOREIGN KEY (NUMDEPT) REFERENCES DEPARTAMENTO (DNUM)
);

CREATE TABLE TRABALHO_NO (
	EMP VARCHAR (11),
    PROJ INT (10),
    HORAS FLOAT (4),
    PRIMARY KEY (EMP, PROJ),
    FOREIGN KEY (EMP) REFERENCES EMPREGADO (CPF),
    FOREIGN KEY (PROJ) REFERENCES PROJETO (PNUM)
);

CREATE TABLE DEPENDENTES (
	EMP VARCHAR (11),
    NOMEDEPEND VARCHAR (200),
    SEXO VARCHAR (1),
    NASC DATE,
    PARENTESCO VARCHAR (100),
    PRIMARY KEY (EMP, NOMEDEPEND),
    FOREIGN KEY (EMP) REFERENCES EMPREGADO (CPF)
);

#1. Insira um empregado de CPF 2222 e nome Bruno.
INSERT INTO EMPREGADO (ENOME, CPF, NASC, ENDERECO, SEXO, SALARIO, SUPERV, DEPT)
VALUES ('BRUNO','2222', '2000-10-03', 'Rua Flores', 'M', '10000', NULL,  NULL); 

#2. Insira um projeto de nome EDUCACIONAL, vinculado ao departamento de código 3
INSERT INTO DEPARTAMENTO (DNOME, DNUM, GERENTE)
VALUES ('EDUCACIONAL', 3, '2222');

UPDATE EMPREGADO SET DEPT ='3'
WHERE CPF = '2222';

INSERT INTO EMPREGADO (ENOME, CPF, NASC, ENDERECO, SEXO, SALARIO, SUPERV, DEPT) 
VALUES ('JOAO','1111', '1980-11-04', 'Rua da Lapa,', 'M', '8000', 2222,  3);

#3. Altere o projeto onde o empregado 56789 trabalha para o de código 2.
INSERT INTO EMPREGADO (ENOME, CPF, NASC, ENDERECO, SEXO, SALARIO, SUPERV, DEPT) 
VALUES ('MARIA','56789', '1990-11-04', 'Rua Souza', 'F', '7000', '2222',3 );

INSERT INTO EMPREGADO (ENOME, CPF, NASC, ENDERECO, SEXO, SALARIO, SUPERV, DEPT) 
VALUES ('MARTA','456123', '1970-12-13', 'Rua Silva', 'F', '20000', NULL, NULL );

INSERT INTO DEPARTAMENTO (DNOME, DNUM, GERENTE)
VALUES ('FINANCEIRO', 2, '456123');

UPDATE EMPREGADO SET DEPT = 2
WHERE CPF = '56789';

#4. Altere o salário do empregado 1111 para o dobro do seu atual salário.
UPDATE EMPREGADO SET SALARIO = '16000' WHERE CPF = '1111';

#5. Remova o empregado de código 56788
INSERT INTO EMPREGADO (ENOME, CPF, NASC, ENDERECO, SEXO, SALARIO, SUPERV, DEPT) 
VALUES ('MARY','56788', '1970-01-06', 'RUA B', 'F', '7000', '1111',3 );

DELETE FROM EMPREGADO WHERE CPF = '56788';

#6. Recupere todos os dados dos dependentes do sexo masculino
INSERT INTO DEPENDENTES (EMP, NOMEDEPEND, SEXO, NASC, PARENTESCO) 
VALUES ('2222', 'CAIO', 'M','2020-05-18','FILHO');

INSERT INTO DEPENDENTES (EMP, NOMEDEPEND, SEXO, NASC, PARENTESCO) 
VALUES ('456123', 'CARLA', 'F','1950-06-20','MAE');

INSERT INTO DEPENDENTES (EMP, NOMEDEPEND, SEXO, NASC, PARENTESCO) 
VALUES ('1111', 'CARLOS', 'M','1995-07-21','IRMAO');

SELECT * FROM DEPENDENTES WHERE SEXO = 'M';

#7. Liste o nome de todos os projetos, com os seus respectivos locais
INSERT INTO PROJETO (PNOME, PNUM, PLOCAL, NUMDEPT)
VALUES ('PROJETO A', 1, 'RUA A', 3);

INSERT INTO PROJETO (PNOME, PNUM, PLOCAL, NUMDEPT)
VALUES ('PROJETO B', 2, 'RUA B',2 );

SELECT PLOCAL FROM PROJETO;
SELECT*FROM EMPREGADO;

#8. Selecione os empregados que trabalham no departamento D5 e ganham mais do que R$5.000. 
INSERT INTO EMPREGADO (ENOME, CPF, NASC, ENDERECO, SEXO, SALARIO, SUPERV, DEPT) 
VALUES ('VERA','555555', '1990-09-06', 'RUA D', 'F', '15000', NULL, NULL );

INSERT INTO DEPARTAMENTO (DNOME, DNUM, GERENTE) VALUES ('RECURSOS HUMANOS', 'D5','555555');

UPDATE EMPREGADO SET DEPT ='D5'
WHERE CPF = '555555';

INSERT INTO EMPREGADO (ENOME, CPF, NASC, ENDERECO, SEXO, SALARIO, SUPERV, DEPT) 
VALUES ('ENZO','13145', '1994-01-015', 'RUA E', 'F', '3000','555555', 'D5' );

INSERT INTO EMPREGADO (ENOME, CPF, NASC, ENDERECO, SEXO, SALARIO, SUPERV, DEPT) 
VALUES ('VALENTINA','987654', '1970-07-06', 'RUA C', 'F', '11000', NULL, 'D5' );

UPDATE EMPREGADO SET SUPERV ='555555'
WHERE SUPERV = NULL;

SELECT ENOME 
FROM EMPREGADO WHERE SALARIO > '5000' AND DEPT = 'D5';

# 9.Liste os nomes dos supervisores dos empregados que ganham mais do que R$5.000.  
SELECT E1.ENOME FROM EMPREGADO E1, EMPREGADO E2 
WHERE E1.CPF = E2.SUPERV AND E2.SALARIO > 5000;

# 10. Obtenha o nome do gerente de cada departamento. 
SELECT E.ENOME FROM EMPREGADO E, DEPARTAMENTO D 
WHERE D.GERENTE = E.CPF IS NOT NULL; 

#11. Retorne o CPF dos empregados que não trabalham em nenhum projeto
INSERT INTO EMPREGADO (ENOME, CPF, NASC, ENDERECO, SEXO, SALARIO, SUPERV, DEPT) 
VALUES ('JOSÉ','131214', '1998-03-25', 'RUA SEIS', 'M', '3000','456123', '2' );

INSERT INTO TRABALHO_NO (EMP, PROJ, HORAS) 
VALUES ('1111', 1, 10), 
       ('131214', 1, 10),
       ('13145', 1, 15),
       ('2222', 2, 20),
       ('456123', 2, 13),
       ('555555', 2, 15);
       
INSERT INTO TRABALHO_NO (EMP, PROJ, HORAS) 
VALUES ('56789', 1, NULL),
       ('987654', 2, NULL);
       
SELECT*FROM TRABALHO_NO;

SELECT E.CPF FROM EMPREGADO E
JOIN TRABALHO_NO T ON E.CPF = T.EMP
WHERE T.HORAS IS NULL;

#12. Retorne o nome e o sexo dos dependentes em ordem alfabética, juntamente com o nome e o CPF dos seus respectivos empregados responsáveis.
SELECT D.NOMEDEPEND, D.SEXO, E.ENOME, E.CPF
FROM DEPENDENTES D JOIN EMPREGADO E ON E.CPF = D.EMP
WHERE D.EMP IS NOT NULL
ORDER BY D.NOMEDEPEND;

#Aluna: Paloma S. da Costa TDS 
