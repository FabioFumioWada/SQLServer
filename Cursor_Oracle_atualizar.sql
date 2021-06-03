SET SERVEROUTPUT ON SIZE 1000000
ACCEPT VELHA PROMPT 'Digite o numero da coligada que deseja ser substituida : '
ACCEPT NOVA  PROMPT 'Digite um numero para atualizar essa coligada : '
PROMPT Processando aguarde .....
SPOOL C:\COLIGADAS_DEL.TXT
SET VERIFY OFF
DECLARE
  TABELA_TEMP VARCHAR2(50);
  CAMPO_TEMP  VARCHAR2(50);
  cid INTEGER;
  i INTEGER;
  CURSOR C_MUDA IS 
    SELECT T.TABLE_NAME,C.COLUMN_NAME
           FROM SYS.DBA_TABLES T, DBA_TAB_COLUMNS C
           WHERE T.OWNER=C.OWNER 
                 AND T.TABLE_NAME=C.TABLE_NAME
                 AND C.COLUMN_NAME LIKE 'CODCOL%';               
  BEGIN
    OPEN C_MUDA;
    FETCH C_MUDA INTO TABELA_TEMP,CAMPO_TEMP;
    LOOP EXIT WHEN C_MUDA%NOTFOUND;      
       cid := DBMS_SQL.OPEN_CURSOR;     
        DBMS_SQL.PARSE(cid, 'UPDATE ' || TABELA_TEMP || ' SET ' ||CAMPO_TEMP||' = '||&&NOVA ||' WHERE ' ||CAMPO_TEMP || ' = '||&&VELHA ,dbms_sql.v7);
        i:= DBMS_SQL.EXECUTE(cid);
         FETCH C_MUDA INTO TABELA_TEMP,CAMPO_TEMP;
       END LOOP;
    DBMS_SQL.CLOSE_CURSOR(cid); 
    CLOSE C_MUDA;
  END;
/
PROMPT Processamento concluido com sucesso !!!!
COMMIT;
UNDEFINE NOVA
UNDEFINE VELHA
SET SERVEROUTPUT OFF
SPOOL OF
SET VERIFY ON
