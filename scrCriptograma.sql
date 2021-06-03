/*********************************************************/
/* CLIENTE                  :RM SISTEMAS                 */
/* BANCO DE DADOS           :MSSQL                       */
/* VERS�O DO BANCO DE DADOS :7.0 E 2000                  */
/* VERS�O DA BASE DE DADOS  :                            */
/* DATA DE CRIA��O          :                            */
/* ANALISTA RESPONS�VEL     :                            */
/* OCORR�NCIA RMAGILIS      :                            */
/* OBJETIVO:                :CRIPTOGRAMA                 */
/*                           ANULAR OS DADOS PARA A      */
/*                           ENTREGA DA BASE DE DADOS    */ 
/*                           (� CONFIGUR�VEL E PARAMETRI */
/*                            Z�VEL)                     */
/*********************************************************/


DECLARE @TABELA VARCHAR(20)
DECLARE @CAMPO  VARCHAR(20)
DECLARE @COMANDO VARCHAR(255)
DECLARE INFO CURSOR FOR 
       SELECT T.NAME,C.NAME FROM SYSOBJECTS T, SYSCOLUMNS C
       WHERE T.ID=C.ID AND T.NAME LIKE 'P%' AND (C.NAME LIKE 'SALA%' OR C.NAME LIKE 'VALOR%'OR C.NAME LIKE 'DATA%')
OPEN INFO
 FETCH NEXT FROM INFO INTO @TABELA,@CAMPO
  WHILE @@FETCH_STATUS = 0
   BEGIN
      SET @COMANDO = 'UPDATE ' + @TABELA + ' SET ' + ''+@CAMPO+'' + ' = NULL '
      EXEC ( @COMANDO)
      PRINT 'O campo '+@campo+' da tabela '+@tabela +' foi anulado.'
   FETCH NEXT FROM INFO INTO @TABELA,@CAMPO
 END
CLOSE INFO
DEALLOCATE INFO


/*##MAGNA##*/