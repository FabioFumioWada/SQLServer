  /*********************************************************/
  /* CLIENTE                  :PSEVERINI                   */
  /* BANCO DE DADOS           :MSSQL                       */
  /* VERSÃO DO BANCO DE DADOS :7.0                         */
  /* VERSÃO DA BASE DE DADOS  :4.02                        */
  /* DATA DE CRIAÇÃO          :10/02/2002                  */
  /* ANALISTA RESPONSÁVEL     :FUMIO                       */
  /* OCORRÊNCIA RMAGILIS      :                            */
  /* OBJETIVO:                :TROCAR OS CÓDIGOS DAS CONTAS*/
  /*                           CONTÁBEIS, ONDE TÊM OS (.)  */
  /*                           DEVEMOS DEIXAR VAZIO        */ 
  /*********************************************************/



SELECT *,REPLACE(CODCONTA,'.','') AS CODCONTANOVA
FROM CCONTA



/*##MAGNA##*/