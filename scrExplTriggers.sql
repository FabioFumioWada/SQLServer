  /*********************************************************/
  /* CLIENTE                  :IMESP                       */
  /* BANCO DE DADOS           :MSSQL                       */
  /* VERSÃO DO BANCO DE DADOS :2000                        */
  /* VERSÃO DA BASE DE DADOS  :4.02                        */
  /* DATA DE CRIAÇÃO          :25/06/2002                  */
  /* ANALISTA RESPONSÁVEL     :FUMIO                       */
  /* OCORRÊNCIA RMAGILIS      :                            */
  /* OBJETIVO:                :EXEMPLO DE TRIGGERS         */
  /*********************************************************/


/******************************************************************************/
/*TRIGGERS DE INTEGRAÇÃO A SEREM CRIADAS NA BASE DE DADOS "FINANCEIRO"        */
/******************************************************************************/ 

/****************************************************************************/
/* 1.0 - INT_CLIENTESFORNEC                                                 */
/****************************************************************************/

/****************************************************************************/
/* 1.1 - TRIGGER TRG_INS_INTFCFO       (FCFO)                               */
/****************************************************************************/

DROP TRIGGER TRG_INS_INTFCFO
GO

CREATE TRIGGER TRG_INS_INTFCFO ON FCFO
FOR INSERT AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_CLIENTESFORNEC
    (CODCOLIGADA,CODCFO,OPERACAO_INT,STATUS_INT,TABELA)
  SELECT CODCOLIGADA,CODCFO,'I','I','FCFO' FROM INSERTED
GO
 
/****************************************************************************/
/* 1.2 - TRIGGER TRG_UP_INTFCFO       (FCFO)                                */
/****************************************************************************/

DROP TRIGGER TRG_UP_INTFCFO
GO

CREATE TRIGGER TRG_UP_INTFCFO ON FCFO
FOR UPDATE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON


  INSERT INTO DBINT_IO_ECALC..INT_CLIENTESFORNEC
    (CODCOLIGADA,CODCFO,OPERACAO_INT,STATUS_INT,TABELA)
  SELECT CODCOLIGADA,CODCFO,'A','I','FCFO' FROM INSERTED
GO  
  
/****************************************************************************/
/* 1.3 - TRIGGER TRG_DEL_INTFCFO      (FCFO)                                */
/****************************************************************************/

DROP TRIGGER TRG_DEL_INTFCFO
GO

CREATE TRIGGER TRG_DEL_INTFCFO ON FCFO
FOR DELETE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  
  INSERT INTO DBINT_IO_ECALC..INT_CLIENTESFORNEC
    (CODCOLIGADA,CODCFO,OPERACAO_INT,STATUS_INT,TABELA)
  SELECT CODCOLIGADA,CODCFO,'E','I','FCFO' FROM DELETED
GO  

/****************************************************************************/
/* 1.4 - TRIGGER TRG_GERAL_INTFCFOCOMPL      (FCFOCOMPL)                    */
/****************************************************************************/

DROP TRIGGER TRG_GERAL_INTFCFOCOMPL
GO

CREATE TRIGGER TRG_GERAL_INTFCFOCOMPL ON FCFOCOMPL
FOR INSERT, UPDATE, DELETE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_CLIENTESFORNEC
    (CODCOLIGADA,CODCFO,OPERACAO_INT,STATUS_INT,TABELA)
  SELECT CODCOLIGADA,CODCFO,'A','I','FCFO' FROM INSERTED
GO
 
/****************************************************************************/
/* 1.5 - TRIGGER TRG_GERAL_INTFCFOCONTATO      (FCFOCONTATO)                */
/****************************************************************************/

DROP TRIGGER TRG_GERAL_INTFCFOCONTATO
GO

CREATE TRIGGER TRG_GERAL_INTFCFOCONTATO ON FCFOCONTATO
FOR INSERT, UPDATE, DELETE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_CLIENTESFORNEC
    (CODCOLIGADA,CODCFO,OPERACAO_INT,STATUS_INT,TABELA)
  SELECT CODCOLIGADA,CODCFO,'A','I','FCFO' FROM INSERTED
GO  

/****************************************************************************/
/* 1.6 - TRIGGER TRG_GERAL_INTFCFOCONTATOCOMPL      (FCFOCONTATOCOMPL)      */
/****************************************************************************/

DROP TRIGGER TRG_GERAL_INTFCFOCONTATOCOMPL
GO

CREATE TRIGGER TRG_GERAL_INTFCFOCONTATOCOMPL ON FCFOCONTATOCOMPL
FOR INSERT, UPDATE, DELETE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON


  INSERT INTO DBINT_IO_ECALC..INT_CLIENTESFORNEC
    (CODCOLIGADA,CODCFO,OPERACAO_INT,STATUS_INT,TABELA)
  SELECT CODCOLIGADA,CODCFO,'A','I','FCFO' FROM INSERTED
GO  

/****************************************************************************/
/* 2.0 - INT_FORMPAG                                                        */
/****************************************************************************/

/****************************************************************************/
/* 2.1 - TRIGGER TRG_INS_INTTCPG                                            */
/****************************************************************************/

DROP TRIGGER TRG_INS_INTTCPG 
GO

CREATE TRIGGER TRG_INS_INTTCPG ON TCPG
FOR INSERT AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_FORMPAG 
   (CODCOLIGADA,CODIGO,DESCRICAO,PRAZOMEDIO,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,CODCPG,NOME,
  (((VALORPAGAMENTO1/100)*PRAZO1)+
  ((VALORPAGAMENTO2/100)*PRAZO2)+
  ((VALORPAGAMENTO3/100)*PRAZO3)+
  ((VALORPAGAMENTO4/100)*PRAZO4)+
  ((VALORPAGAMENTO5/100)*PRAZO5)),'I','I'
  FROM INSERTED
GO

/****************************************************************************/
/* 2.2 - TRIGGER TRG_UP_INTTCPG                                             */
/****************************************************************************/

DROP TRIGGER TRG_UP_INTTCPG 
GO

CREATE TRIGGER TRG_UP_INTTCPG ON TCPG
FOR UPDATE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_FORMPAG 
   (CODCOLIGADA,CODIGO,DESCRICAO,PRAZOMEDIO,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,CODCPG,NOME,
   (((VALORPAGAMENTO1/100)*PRAZO1)+
   ((VALORPAGAMENTO2/100)*PRAZO2)+
   ((VALORPAGAMENTO3/100)*PRAZO3)+
   ((VALORPAGAMENTO4/100)*PRAZO4)+
   ((VALORPAGAMENTO5/100)*PRAZO5)),'I','A'  
  FROM INSERTED
GO

/****************************************************************************/
/* 2.3 - TRIGGER TRG_DEL_INTTCPG                                            */
/****************************************************************************/

DROP TRIGGER TRG_DEL_INTTCPG 
GO

CREATE TRIGGER TRG_DEL_INTTCPG ON TCPG
FOR DELETE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_FORMPAG 
   (CODCOLIGADA,CODIGO,DESCRICAO,PRAZOMEDIO,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,CODCPG,NOME,
   (((VALORPAGAMENTO1/100)*PRAZO1)+
   ((VALORPAGAMENTO2/100)*PRAZO2)+
   ((VALORPAGAMENTO3/100)*PRAZO3)+
   ((VALORPAGAMENTO4/100)*PRAZO4)+
   ((VALORPAGAMENTO5/100)*PRAZO5)),'I','E'
  FROM DELETED
GO

/****************************************************************************/
/* 3.0 - INT_ITENS                                                          */
/****************************************************************************/

/****************************************************************************/
/* 3.1 - TRIGGER TRG_INS_INTITENS      (TPRD)                               */
/****************************************************************************/

DROP TRIGGER TRG_GERAL_INTITENS
GO

CREATE TRIGGER TRG_GERAL_INTITENS ON TPRD
FOR INSERT AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_ITENS
    (CODCOLIGADA,CODIGOPRD,NOMEFANTASIA,DESCRICAO,TABELA,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,CODIGOPRD,NOMEFANTASIA,DESCRICAO,'TPRD','I','I' FROM INSERTED
GO  

/****************************************************************************/
/* 3.2 - TRIGGER TRG_UP_INTITENS      (TPRD)                                */
/****************************************************************************/

DROP TRIGGER TRG_UP_INTITENS
GO

CREATE TRIGGER TRG_UP_INTITENS ON TPRD
FOR UPDATE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_ITENS
    (CODCOLIGADA,CODIGOPRD,NOMEFANTASIA,DESCRICAO,TABELA,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,CODIGOPRD,NOMEFANTASIA,DESCRICAO,'TPRD','I','A' FROM INSERTED
GO  

/****************************************************************************/
/* 3.3 - TRIGGER TRG_DEL_INTITENS      (TPRD)                               */
/****************************************************************************/

DROP TRIGGER TRG_DEL_INTITENS
GO

CREATE TRIGGER TRG_DEL_INTITENS ON TPRD
FOR DELETE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_ITENS
    (CODCOLIGADA,CODIGOPRD,NOMEFANTASIA,DESCRICAO,TABELA,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,CODIGOPRD,NOMEFANTASIA,DESCRICAO,'TPRD','I','E' FROM DELETED
GO  

/****************************************************************************/
/* 3.4 - TRIGGER TRG_GERAL_INTITENS      (TPRDCOMPL)                        */
/****************************************************************************/

DROP TRIGGER TRG_GERAL_INTITENS
GO

CREATE TRIGGER TRG_GERAL_INTITENS ON TPRDCOMPL
FOR INSERT, UPDATE, DELETE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_ITENS
    (CODCOLIGADA,CODIGOPRD,NOMEFANTASIA,DESCRICAO,TABELA,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,CODIGOPRD,NOMEFANTASIA,DESCRICAO,'TPRD','I','A' FROM INSERTED
GO  

/****************************************************************************/
/* 4.0 - INT_SECRETARIAS                                                    */
/****************************************************************************/

/****************************************************************************/
/* 4.1 - TRIGGER TRG_INS_INTSECRETARIAS      (FTB4)                         */
/****************************************************************************/

DROP TRIGGER TRG_INS_INTSECRETARIAS
GO

CREATE TRIGGER TRG_INS_INTSECRETARIAS ON FTB4
FOR INSERT AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_SECRETARIAS
    (CODCOLIGADA,CODIGO,DESCRICAO,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,CODTB4FLX,DESCRICAO,'I','I' FROM INSERTED
GO  

/****************************************************************************/
/* 4.2 - TRIGGER TRG_UP_INTSECRETARIAS      (FTB4)                          */
/****************************************************************************/

DROP TRIGGER TRG_UP_INTSECRETARIAS
GO

CREATE TRIGGER TRG_INS_INTSECRETARIAS ON FTB4
FOR UPDATE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_SECRETARIAS
    (CODCOLIGADA,CODIGO,DESCRICAO,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,CODTB4FLX,DESCRICAO,'I','A' FROM INSERTED
GO  

/****************************************************************************/
/* 4.3 - TRIGGER TRG_INS_INTSECRETARIAS      (FTB4)                         */
/****************************************************************************/

DROP TRIGGER TRG_DEL_INTSECRETARIAS
GO

CREATE TRIGGER TRG_DEL_INTSECRETARIAS ON FTB4
FOR DELETE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_SECRETARIAS
    (CODCOLIGADA,CODIGO,DESCRICAO,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,CODTB4FLX,DESCRICAO,'I','D' FROM DELETED
GO  

/****************************************************************************/
/* 5.0 - INT_VENDEDORES                                                     */
/****************************************************************************/

/****************************************************************************/
/* 5.1 - TRIGGER TRG_INS_INTTVEN                                            */
/****************************************************************************/

DROP TRIGGER TRG_INS_INTTVEN
GO

CREATE TRIGGER TRG_INS_INTTVEN ON TVEN
FOR INSERT AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_VENDEDORES 
  (CODCOLIGADA,OPERACAO,CODVEN,NOME,RAZAOSOCIAL,PJ_PF,CNPJ_CPF,
  ENDERECO,MUNICIPIO,ESTADO,CEP,DDD,TELEFONE,FAX,BIPTEL,BIPCODIGO,COMISSAO,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,'',CODVEN,NOME,'','','','','','','','','','','','',
  COMISSAO1,'I','I' FROM INSERTED WHERE VENDECOMPRA=0
GO  
  
/****************************************************************************/
/* 5.2 - TRIGGER TRG_UP_INTTVEN                                             */
/****************************************************************************/

DROP TRIGGER TRG_UP_INTTVEN
GO

CREATE TRIGGER TRG_UP_INTTVEN ON TVEN
FOR UPDATE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_VENDEDORES 
  (CODCOLIGADA,OPERACAO,CODVEN,NOME,RAZAOSOCIAL,PJ_PF,CNPJ_CPF,
  ENDERECO,MUNICIPIO,ESTADO,CEP,DDD,TELEFONE,FAX,BIPTEL,BIPCODIGO,COMISSAO,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,'',CODVEN,NOME,'','','','','','','','','','','','',
  COMISSAO1,'I','A' FROM INSERTED WHERE VENDECOMPRA=0
GO  

/****************************************************************************/
/* 5.3 - TRIGGER TRG_DEL_INTTVEN                                            */
/****************************************************************************/

DROP TRIGGER TRG_DEL_INTTVEN
GO

CREATE TRIGGER TRG_DEL_INTTVEN ON TVEN
FOR DELETE AS

  SET ANSI_NULL_DFLT_ON ON
  SET ANSI_WARNINGS ON
  SET XACT_ABORT ON

  INSERT INTO DBINT_IO_ECALC..INT_VENDEDORES 
  (CODCOLIGADA,OPERACAO,CODVEN,NOME,RAZAOSOCIAL,PJ_PF,CNPJ_CPF,
  ENDERECO,MUNICIPIO,ESTADO,CEP,DDD,TELEFONE,FAX,BIPTEL,BIPCODIGO,COMISSAO,STATUS_INT,OPERACAO_INT)
  SELECT CODCOLIGADA,'',CODVEN,NOME,'','','','','','','','','','','','',
  COMISSAO1,'I','E' FROM DELETED WHERE VENDECOMPRA=0
GO


/*##MAGNA##*/