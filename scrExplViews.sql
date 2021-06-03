  /*********************************************************/
  /* CLIENTE                  :IMESP                       */
  /* BANCO DE DADOS           :MSSQL                       */
  /* VERSÃO DO BANCO DE DADOS :2000                        */
  /* VERSÃO DA BASE DE DADOS  :4.02                        */
  /* DATA DE CRIAÇÃO          :25/06/2002                  */
  /* ANALISTA RESPONSÁVEL     :FUMIO                       */
  /* OCORRÊNCIA RMAGILIS      :                            */
  /* OBJETIVO:                :EXEMPLO DE VIEWS E CRIAÇÃO  */
  /*                           DE TABELAS                  */
  /*********************************************************/

/****************************************************************************/
/* TABELAS DE INTEGRAÇÃO A SEREM CRIADAS NA BASE DE DADOS "DBINT_IO_ECALC"  */
/****************************************************************************/ 

/****************************************************************************/
/* TABELA INT_CLIENTESFORNEC                                                */
/****************************************************************************/

CREATE TABLE INT_CLIENTESFORNEC
(
  CODCOLIGADA    SMALLINT,
  ID             INTEGER     IDENTITY (1,1) NOT NULL,
  CODCFO 	 VARCHAR(25),
  OPERACAO_INT   VARCHAR(01),   /* I, A OU E */ 
  DATAOPERACAO   DATETIME DEFAULT GETDATE(),
  TABELA	 VARCHAR(25),
  STATUS_INT     VARCHAR(01),
)
GO

/****************************************************************************/
/* TABELA INT_FORMPAG                                                       */
/****************************************************************************/

CREATE TABLE INT_FORMPAG
(
  CODCOLIGADA    SMALLINT,
  ID             INTEGER     IDENTITY (1,1) NOT NULL,
  CODIGO	 VARCHAR(5),
  DESCRICAO      VARCHAR(40), /* verificar */
  PRAZOMEDIO     INTEGER,
  STATUS_INT     VARCHAR(01),
  OPERACAO_INT   VARCHAR(01)
)
GO

/****************************************************************************/
/* TABELA INT_ITENS                                                         */
/****************************************************************************/

CREATE TABLE INT_ITENS
(
  CODCOLIGADA    SMALLINT,
  ID             INTEGER     IDENTITY (1,1) NOT NULL,
  CODIGOPRD      VARCHAR(30), 
  NOMEFANTASIA   VARCHAR(100),
  DESCRICAO      VARCHAR(240),
  DATAOPERCAO    DEFAULT GETDATE(),
  TABELA         VARCHAR(25),
  STATUS_INT     VARCHAR(01),
  OPERACAO_INT	 VARCHAR(01)
)
GO

/****************************************************************************/
/* TABELA INT_SECRETARIAS                                                   */
/****************************************************************************/

CREATE TABLE INT_SECRETARIAS
(
  CODCOLIGADA    SMALLINT,
  ID             INTEGER IDENTITY (1,1) NOT NULL ,
  CODIGO	 VARCHAR(10),
  DESCRICAO      VARCHAR(100), 
  DATAOPERACAO   DATETIME DEFAULT GETDATE(),
  STATUS_INT     VARCHAR(01),
  OPERACAO_INT	 VARCHAR(01) 
)
GO

/****************************************************************************/
/* TABELA INT_VENDEDORES                                                    */
/****************************************************************************/

CREATE TABLE INT_VENDEDORES
(
  ID             INTEGER  IDENTITY (1,1),
  CODCOLIGADA    SMALLINT,
  OPERACAO       VARCHAR(1),
  CODVEN 	 VARCHAR(16),
  NOME           VARCHAR(40),
  RAZAOSOCIAL    VARCHAR(80),
  PJ_PF          VARCHAR(1),
  CNPJ_CPF	 VARCHAR(1),
  ENDERECO	 VARCHAR(80),
  MUNICIPIO	 VARCHAR(40),
  ESTADO	 VARCHAR(2),
  CEP		 VARCHAR(8),
  DDD		 VARCHAR(3),
  TELEFONE	 VARCHAR(20),
  FAX		 VARCHAR(20),
  BIPTEL	 VARCHAR(20),
  BIPCODIGO	 VARCHAR(30),
  COMISSAO	 NUMERIC(15,2),
  STATUS_INT     VARCHAR(01),
  OPERACAO_INT	 VARCHAR(01)  
)
GO

/****************************************************************************/
/* TABELA INT_FATURA                                                        */
/****************************************************************************/

CREATE TABLE INT_FATURA
(
ID             INTEGER IDENTITY (1,1),	 
CODCOLIGADA    SMALLINT,	
SOLICITACAO    VARCHAR(06),
FATURA         VARCHAR(06),
DATAEMISSAO    DATETIME DEFAULT GETDATE(),   
STATUS_INT     VARCHAR(01),
OPERACAO_INT   VARCHAR(01),
)
GO

/****************************************************************************/
/* VIEW INT_VIEWCLIENTES                                                    */
/****************************************************************************/

DROP VIEW INT_VIEWCLIENTES
GO

CREATE VIEW INT_VIEWCLIENTES AS
SELECT FCFO.CODCFO CODIGO, 
       FCFO.NOMEFANTASIA NOME, 
       FCFO.NOME RAZAOSOCIAL,
       CASE FCFO.PESSOAFISOUJUR
        WHEN 'F' THEN 1
        ELSE 0
       END AS PJ_PF, 
       FCFO.CGCCFO CNPJ_CPF,
       FCFO.RUA + ' ' + FCFO.NUMERO + ' ' + FCFO.BAIRRO ENDERECO, 
       FCFO.CIDADE MUNICIPIO,
       FCFO.CODETD ESTADO, 
       FCFO.CEP, NULL DDD, 
       FCFO.TELEFONE, 
       FCFO.FAX, 
       FCFO.EMAIL,
       FCFO.CONTATO, 
       FCFOCOMPL.CODLIBCREDITO STATUSCREDITO, 
       NULL HOMEPAGE,
       CASE FCFO.ATIVO
        WHEN 0 THEN 'N'
        ELSE 'S'
       END AS ATIVO,
       CASE FCFO.PAGREC
        WHEN 2 THEN 'N'
        ELSE 'S'
       END AS VENDA,
       NULL CODVEND1, 
       NULL COMVEND1, 
       NULL CODVEND2, 
       NULL COMVEND2,
       FCFODEF.CODTB4FLX 
       CODSECRETARIA, 
       FCFO.CODTCF
FROM FINANCEIRO..FCFO FCFO, FINANCEIRO..FCFOCOMPL FCFOCOMPL, FINANCEIRO..FCFODEF FCFODEF
WHERE FCFO.CODCOLIGADA = FCFOCOMPL.CODCOLIGADA
AND FCFO.CODCFO = FCFOCOMPL.CODCFO
AND FCFODEF.CODCOLIGADA = FCFO.CODCOLIGADA
AND FCFODEF.CODCFO = FCFO.CODCFO
AND PAGREC IN (1,3)
GO

/****************************************************************************/
/* VIEW INT_VIEWCONTATOSCLIENTE                                             */
/****************************************************************************/
DROP VIEW INT_VIEWCONTATOSCLIENTE
GO

CREATE VIEW INT_VIEWCONTATOSCLIENTE AS
SELECT FCFOCONTATO.CODCFO,FCFOCONTATO.IDCONTATO,FCFOCONTATO.NOME,FCFOCONTATO.EMAIL,
       FCFOCONTATO.TELEFONE,FCFOCONTATO.RAMAL,FCFOCONTATO.FAX,FCFOCONTATO.FUNCAO,
       FCFOCONTATO.OBSERVACAO,FCFOCONTATO.CODUSUARIO,
       FCFOCONTATO.RUA,FCFOCONTATO.NUMERO,FCFOCONTATO.COMPLEMENTO,FCFOCONTATO.BAIRRO,
       FCFOCONTATO.CIDADE,FCFOCONTATO.CODETD,FCFOCONTATO.CEP,FCFOCONTATO.PAIS,
       FCFOCONTATOCOMPL.TIPO
FROM FINANCEIRO..FCFOCONTATO FCFOCONTATO, FINANCEIRO..FCFOCONTATOCOMPL FCFOCONTATOCOMPL
WHERE FCFOCONTATO.CODCOLIGADA = FCFOCONTATOCOMPL.CODCOLIGADA
AND FCFOCONTATO.CODCFO = FCFOCONTATOCOMPL.CODCFO
AND FCFOCONTATO.IDCONTATO = FCFOCONTATOCOMPL.IDCONTATO
GO


/****************************************************************************/
/* VIEW INT_VIEWSECRETARIAS                                                 */
/****************************************************************************/
DROP VIEW INT_VIEWSECRETARIAS
GO

CREATE VIEW INT_VIEWSECRETARIAS AS
SELECT CODTB4FLX CODIGO, DESCRICAO
FROM FINANCEIRO..FTB4
GO

/****************************************************************************/
/* VIEW INT_VIEWITENS                                                       */
/****************************************************************************/
DROP VIEW INT_VIEWITENS
GO

CREATE VIEW INT_VIEWITENS AS
SELECT TPRD.CODIGOPRD CODIGO, TPRD.NOMEFANTASIA NOME, TPRD.DESCRICAO,
       CASE  
         WHEN (CODIGOAUXILIAR BETWEEN '620.000' AND '629.999') OR 
              (CODIGOAUXILIAR BETWEEN '800.000' AND '899.999') THEN 1
         ELSE 0
       END ITEMPROD,
       TPRD.CUSTOREPOSICAO, TPRDCOMPL.TIPOITEM TIPO, TPRDCOMPL.GRAMATURA,
       TPRD.LARGURA, TPRD.COMPRIMENTO, TPRD.ESPESSURA, TPRD.CODUNDCONTROLE UNIDADE
FROM FINANCEIRO..TPRD TPRD,  FINANCEIRO..TPRDCOMPL TPRDCOMPL
WHERE TPRD.CODCOLIGADA *= TPRDCOMPL.CODCOLIGADA
AND TPRD.IDPRD *= TPRDCOMPL.IDPRD
GO

/****************************************************************************/
/* VIEW INT_VIEWESTOQUE                                                     */
/****************************************************************************/
DROP VIEW INT_VIEWESTOQUE
GO

CREATE VIEW INT_VIEWESTOQUE AS
SELECT TPRD.CODIGOPRD CODIGO, TPRD.NOMEFANTASIA NOME, TPRD.DESCRICAO,
       CASE  
         WHEN (CODIGOAUXILIAR BETWEEN '620.000' AND '629.999') OR 
              (CODIGOAUXILIAR BETWEEN '800.000' AND '899.999') THEN 1
         ELSE 0
       END ITEMPROD, 
       ISNULL(TPRDLOC.SALDOFISICO2,0) QUANTEST, 
       ISNULL(TPRD.CUSTOREPOSICAO,0) CUSTOREPOSICAO, 
       ISNULL(TPRDLOC.SALDOFISICO8,0) QUANTDISP
FROM FINANCEIRO..TPRDLOC TPRDLOC, FINANCEIRO..TPRD TPRD
WHERE TPRDLOC.CODCOLIGADA =* TPRD.CODCOLIGADA
AND TPRDLOC.IDPRD =* TPRD.IDPRD
AND TPRD.CODCOLIGADA = 1
AND TPRDLOC.CODFILIAL = 1
AND TPRDLOC.CODLOC = '01.001'
GO


/*##MAGNA##*/