/** tabela INT_EVENTO **/

CREATE OR REPLACE TRIGGER TG_INT_EVENTO_BEFOREINSERT
AFTER INSERT ON INT_EVENTO
--FOR EACH ROW
DECLARE 
  v_COUNT NUMBER(5);
  
  C_ID            NUMBER(5,0);
  C_INTERFACE     NUMBER(5,0);
  C_STATUS_INT    VARCHAR2(1);
  C_OPERACAO_INT  VARCHAR2(1);
  C_CODCOLIGADA	NUMBER(5,0);
  C_CODIGO	VARCHAR2(10);
  C_DESCRICAO	VARCHAR2(80);

CURSOR C_EVENTO IS
  SELECT ID, INTERFACE, STATUS_INT, OPERACAO_INT, CODCOLIGADA, CODIGO, DESCRICAO
  FROM INT_EVENTO
  WHERE STATUS_INT = 'I';

BEGIN
 OPEN C_EVENTO;
 LOOP
   FETCH C_EVENTO INTO C_ID, C_INTERFACE, C_STATUS_INT, C_OPERACAO_INT, C_CODCOLIGADA, C_CODIGO, C_DESCRICAO;
   EXIT WHEN C_EVENTO%NOTFOUND;
     IF (C_INTERFACE = 1) AND (C_STATUS_INT = 'I')
     THEN
       UPDATE INT_EVENTO
       SET STATUS_INT = 'E'
       WHERE ID = C_ID;
       IF (C_OPERACAO_INT = 'I')
       THEN
         FOR REG IN (SELECT CODCOLIGADA
                     FROM ZCOLIGADASREPLICACAO
                     WHERE CODCOLIGADA <> C_CODCOLIGADA)
         LOOP
           SELECT COUNT(*)
           INTO v_COUNT
           FROM PEVENTO
           WHERE PEVENTO.CODCOLIGADA = REG.CODCOLIGADA AND
                 PEVENTO.CODIGO = C_CODIGO;
           IF v_COUNT <= 0 
           THEN
             INSERT INTO PEVENTO (CODCOLIGADA, CODIGO, DESCRICAO)
             VALUES (REG.CODCOLIGADA, C_CODIGO, C_DESCRICAO);
           END IF;
         END LOOP;
       ELSIF (C_OPERACAO_INT = 'A')
       THEN
         FOR REG IN (SELECT CODCOLIGADA
                     FROM ZCOLIGADASREPLICACAO
                     WHERE CODCOLIGADA <> C_CODCOLIGADA)
         LOOP
           UPDATE PEVENTO
           SET DESCRICAO = C_DESCRICAO
           WHERE PEVENTO.CODCOLIGADA = REG.CODCOLIGADA AND
                 PEVENTO.CODIGO = C_CODIGO;
         END LOOP;
       ELSE
         FOR REG IN (SELECT CODCOLIGADA
                     FROM ZCOLIGADASREPLICACAO
                     WHERE CODCOLIGADA <> C_CODCOLIGADA)
         LOOP 
           DELETE FROM PEVENTO
           WHERE PEVENTO.CODCOLIGADA = REG.CODCOLIGADA AND
                 PEVENTO.CODIGO = C_CODIGO;
         END LOOP;
       END IF;
       UPDATE INT_EVENTO
       SET STATUS_INT = 'T'
       WHERE ID = C_ID;
     END IF;
   /*END IF;*/
 END LOOP;
 CLOSE C_EVENTO;
END;
/
