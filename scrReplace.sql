  /*********************************************************/
  /* CLIENTE                  :PSEVERINI                   */
  /* BANCO DE DADOS           :MSSQL                       */
  /* VERS�O DO BANCO DE DADOS :7.0                         */
  /* VERS�O DA BASE DE DADOS  :4.02                        */
  /* DATA DE CRIA��O          :10/02/2002                  */
  /* ANALISTA RESPONS�VEL     :FUMIO                       */
  /* OCORR�NCIA RMAGILIS      :                            */
  /* OBJETIVO:                :TROCAR OS C�DIGOS DAS CONTAS*/
  /*                           CONT�BEIS, ONDE T�M OS (.)  */
  /*                           DEVEMOS DEIXAR VAZIO        */ 
  /*********************************************************/



SELECT *,REPLACE(CODCONTA,'.','') AS CODCONTANOVA
FROM CCONTA



/*##MAGNA##*/