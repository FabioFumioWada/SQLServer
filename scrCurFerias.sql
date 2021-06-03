/***********************************************************/
/* CLIENTE                  :RM SISTEMAS                   */
/* BANCO DE DADOS           :MSSQL                         */
/* VERS�O DO BANCO DE DADOS :7.0 E 2000                    */
/* VERS�O DA BASE DE DADOS  :                              */
/* DATA DE CRIA��O          :10/12/2004                    */
/* ANALISTA RESPONS�VEL     :FUMIO                         */
/* OCORR�NCIA RMAGILIS      :                              */
/* OBJETIVO:                :ATUALIZA O CAMPO              */
/*                           "DTVENCFERIAS" DA TABELA PFUNC*/
/*                           COM OS DADOS DA TABELA        */
/*                           PFHSTFER                      */
/***********************************************************/

DECLARE @CODCOLIGADA DCODCOLIGADA
DECLARE @CHAPA DCHAPA

DECLARE CUR CURSOR FOR
  SELECT CODCOLIGADA, CHAPA
  FROM PFUNC
  ORDER BY CODCOLIGADA, CHAPA
OPEN CUR

FETCH NEXT FROM CUR INTO @CODCOLIGADA, @CHAPA

WHILE @@FETCH_STATUS = 0
BEGIN
  UPDATE PFUNC SET DTVENCFERIAS = (SELECT MAX(DTFIMPERAQUIS)
                                   FROM PFHSTFER
                                   WHERE CODCOLIGADA = @CODCOLIGADA
                                   AND CHAPA = @CHAPA)
  WHERE CODCOLIGADA = @CODCOLIGADA
  AND CHAPA = @CHAPA

  FETCH NEXT FROM CUR INTO @CODCOLIGADA, @CHAPA
END
CLOSE CUR
DEALLOCATE CUR