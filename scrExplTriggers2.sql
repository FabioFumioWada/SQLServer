  /*********************************************************/
  /* CLIENTE                  :ANIBAL                      */
  /* BANCO DE DADOS           :MSSQL                       */
  /* VERS�O DO BANCO DE DADOS :2000                        */
  /* VERS�O DA BASE DE DADOS  :5.00                        */
  /* DATA DE CRIA��O          :27/05/2003                  */
  /* ANALISTA RESPONS�VEL     :FUMIO                       */
  /* OCORR�NCIA RMAGILIS      :                            */
  /* OBJETIVO:                :EXEMPLO DE TRIGGERS         */
  /*********************************************************/

DROP TRIGGER TRG_NOBRA
GO

CREATE TRIGGER TRG_NOBRA ON TMOV
FOR INSERT,UPDATE AS   
  UPDATE TMOV
  SET TMOV.CAMPOLIVRE1 = FCFOCONTATO.NOME
  FROM TMOV,FCFOCONTATO
  WHERE TMOV.CODCOLIGADA = (SELECT CODCOLIGADA FROM INSERTED)
  AND TMOV.CODCOLIGADA = FCFOCONTATO.CODCOLIGADA
  AND TMOV.CODCFO = (SELECT CODCFO FROM INSERTED)
  AND TMOV.CODCFO = FCFOCONTATO.CODCFO
  AND TMOV.IDCONTATOENTREGA = (SELECT IDCONTATOENTREGA FROM INSERTED)
  AND TMOV.IDCONTATOENTREGA = FCFOCONTATO.IDCONTATO
  AND TMOV.CODTMV = (SELECT CODTMV FROM INSERTED)
  GO
GO