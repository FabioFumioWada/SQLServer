/***********************************************************/
/* CLIENTE:                  IMPLANT                       */
/* BANCO DE DADOS:           MSSQL                         */
/* VERS?O DO BANCO DE DADOS: 2000                          */
/* VERS?O DA BASE DE DADOS:  5.03                          */
/* DATA DE CRIA??O:          19/07/2004                    */
/* ANALISTA RESPONS?VEL:     FUMIO                         */
/* OCORR?NCIA RMAGILIS:                                    */
/* OBJETIVO:                 RECALCULAR O SALDO FINANCEIRO */
/*                           DA TABELA DE PRODUTO (TPRD)   */
/***********************************************************/


CREATE PROCEDURE SP_RECALCULASALDOPROD (@CODCOLIGADA DCODCOLIGADA)
AS
/* RECALCULA SALDO GERAL FINANCEIRO DA TABELA DE PRODUTO (TPRD) */
  IF EXISTS (SELECT NAME 
             FROM SYSOBJECTS
             WHERE XTYPE = 'U'
             AND NAME = 'ZTPRD_SALDO')
    DROP TABLE ZTPRD_SALDO

  SELECT CODCOLIGADA, IDPRD, CODIGOPRD, SALDOGERALFINANC, 
         (CUSTOUNITARIO*SALDOGERALFISICO) AS SALDOGERALFINANCTEMPORARIO
  INTO ZTPRD_SALDO
  FROM TPRD

  /* RECALCULA PARA TODAS AS COLIGADAS, SE INFORMADO O PAR?METRO 0 (ZERO) */
  IF (@CODCOLIGADA = 0)
  BEGIN
    UPDATE TPRD SET SALDOGERALFINANC = (CUSTOUNITARIO*SALDOGERALFISICO)
  END
  /* RECALCULA PARA A COLIGADA INFORMADA NO PAR?METRO */
  ELSE
  BEGIN
    UPDATE TPRD SET SALDOGERALFINANC = (CUSTOUNITARIO*SALDOGERALFISICO)
    WHERE CODCOLIGADA = @CODCOLIGADA
  END
GO