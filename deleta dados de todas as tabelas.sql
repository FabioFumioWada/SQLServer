DECLARE @TABELA VARCHAR (100)
DECLARE @COMANDO VARCHAR (255)
DECLARE TABELA CURSOR FOR
SELECT NAME FROM SYSOBJECTS WHERE TYPE='U' ORDER BY NAME
OPEN TABELA
FETCH NEXT FROM TABELA INTO @TABELA

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @COMANDO = 'DELETE '+@TABELA
	--EXEC (@COMANDO)
	PRINT @COMANDO
	FETCH NEXT FROM TABELA INTO @TABELA 
END
CLOSE TABELA
DEALLOCATE TABELA

