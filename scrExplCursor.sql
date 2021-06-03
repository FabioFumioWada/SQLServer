  /**********************************************************/
  /* CLIENTE                  :RM SISTEMAS                  */
  /* BANCO DE DADOS           :ORACLE                       */
  /* VERSÃO DO BANCO DE DADOS :                             */
  /* VERSÃO DA BASE DE DADOS  :4.02                         */
  /* DATA DE CRIAÇÃO          :                             */
  /* ANALISTA RESPONSÁVEL     :                             */
  /* OCORRÊNCIA RMAGILIS      :                             */
  /* OBJETIVO:                :EXEMPLO DE CURSORES EM ORACLE*/
  /**********************************************************/

DECLARE
  TABELA_TEMP VARCHAR(20);
  CAMPO_TEMP  VARCHAR(20);
  CURSOR C_INFO IS 
    SELECT T.TABLE_NAME,C.COLUMN_NAME
    FROM DBA_TABLES T, DBA_TAB_COLUMNS C
    WHERE T.OWNER=C.OWNER 
    AND T.TABLE_NAME=C.TABLE_NAME
    AND T.TABLE_NAME LIKE 'P%' 
    AND (C.COLUMN_NAME LIKE 'NOME%' OR 
         C.COLUMN_NAME LIKE 'SALARIO%'OR 
         C.COLUMN_NAME LIKE 'ENDERECO%');
  BEGIN
    OPEN C_INFO;
    FETCH C_INFO INTO TABELA_TEMP,CAMPO_TEMP;
    LOOP EXIT WHEN C_INFO%NOTFOUND;
      UPDATE TABELA_TEMP SET CAMPO_TEMP = NULL;
      FETCH C_INFO INTO TABELA_TEMP, CAMPO_TEMP;
    END LOOP;
    CLOSE C_INFO;
  END;
  
  
  
/*##MAGNA##*/