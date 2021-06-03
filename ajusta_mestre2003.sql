/* Microsoft SQL Server - Scripting			*/
/* Server: DBCAIO					*/
/* Database: Bastos					*/
/* Creation Date 2/2/00 12:47:16 PM 			*/

/****** Object:  Stored Procedure dbo.Habilita_ForeignKey    Script Date: 2/2/00 12:47:17 PM ******/
if exists (select * from sysobjects where id = object_id('dbo.Habilita_ForeignKey') and sysstat & 0xf = 4)
	drop procedure dbo.Habilita_ForeignKey
GO

/****** Object:  Stored Procedure dbo.Habilita_ForeignKey    Script Date: 2/2/00 12:47:17 PM ******/
if exists (select * from sysobjects where id = object_id('dbo.Desabilita_ForeignKey') and sysstat & 0xf = 4)
	drop procedure dbo.Desabilita_ForeignKey
GO

/****** Object:  Stored Procedure dbo.Habilita_ForeignKey    Script Date: 2/2/00 12:47:17 PM ******/
CREATE PROCEDURE Habilita_ForeignKey
AS

DECLARE @tabelaname varchar(100)
DECLARE @tabelaid int
DECLARE @constraintname varchar(100)
DECLARE @constraintcabecalho varchar(100)


DECLARE tabela_cursor CURSOR FOR select o.name,o.id
        from   sysobjects o
        where  o.type in ('U') order by o.name


OPEN tabela_cursor
FETCH NEXT FROM tabela_cursor INTO @tabelaname,@tabelaid

WHILE (@@fetch_status <> -1)
BEGIN
     IF (@@fetch_status <> -2)
     BEGIN
 
 
          DECLARE constraint_cursor CURSOR FOR select  o.name
                  from  sysconstraints c, sysobjects o
                  where c.id = @tabelaid and o.id = c.constid and o.type in ('F')
           OPEN constraint_cursor
          FETCH NEXT FROM constraint_cursor INTO @constraintname

          WHILE (@@fetch_status <> -1)           BEGIN
	       IF (@@fetch_status <> -2)
	       BEGIN
		     
                    SELECT @constraintcabecalho = 'Habilitando constraint ' + RTRIM(UPPER(@constraintname)) + ' da tabela ' + @tabelaname
		    PRINT @constraintcabecalho
                    exec ('ALTER TABLE ' + @tabelaname + ' CHECK CONSTRAINT '  + @constraintname)
                    PRINT ' '
	       END
	       FETCH NEXT FROM constraint_cursor INTO @constraintname
          END
          DEALLOCATE constraint_cursor          
   
      END
      FETCH NEXT FROM tabela_cursor INTO @tabelaname,@tabelaid 
END

DEALLOCATE tabela_cursor
PRINT ' '
PRINT ' '
PRINT 'Todas a foreigns keys foram habilitadas'
GO

/****** Object:  Stored Procedure dbo.Desabilita_ForeignKey    Script Date: 2/2/00 12:47:17 PM ******/
CREATE PROCEDURE Desabilita_ForeignKey
AS

DECLARE @tabelaname varchar(100)
DECLARE @tabelaid int
DECLARE @constraintname varchar(100)
DECLARE @constraintcabecalho varchar(100)


DECLARE tabela_cursor CURSOR FOR select o.name,o.id
        from   sysobjects o
        where  o.type in ('U') order by o.name


OPEN tabela_cursor
FETCH NEXT FROM tabela_cursor INTO @tabelaname,@tabelaid

WHILE (@@fetch_status <> -1)
BEGIN
     IF (@@fetch_status <> -2)
     BEGIN
 
 
          DECLARE constraint_cursor CURSOR FOR select  o.name
                  from  sysconstraints c, sysobjects o
                  where c.id = @tabelaid and o.id = c.constid and o.type in ('F')
           OPEN constraint_cursor
          FETCH NEXT FROM constraint_cursor INTO @constraintname

          WHILE (@@fetch_status <> -1)           BEGIN
	       IF (@@fetch_status <> -2)
	       BEGIN
		     
                    SELECT @constraintcabecalho = 'Desabilitando constraint ' + RTRIM(UPPER(@constraintname)) + ' da tabela ' + @tabelaname
		    PRINT @constraintcabecalho
                    EXEC ('ALTER TABLE ' + @tabelaname + ' NOCHECK CONSTRAINT '  + @constraintname)
                    PRINT ' '
	       END
	       FETCH NEXT FROM constraint_cursor INTO @constraintname
          END
          DEALLOCATE constraint_cursor          
   
      END
      FETCH NEXT FROM tabela_cursor INTO @tabelaname,@tabelaid 
END

DEALLOCATE tabela_cursor
PRINT ' '
PRINT ' '
PRINT 'Todas a foreigns keys foram desabilitadas'
GO


/* Ajusta Mestre --- Atenção execute antes o arquivo FOREIGN.SQL ------*/
exec desabilita_foreignkey
go
delete from gusuario where codusuario = 'mestre'
go
delete from gacesso where codacesso = 'Default'
go
INSERT INTO GUSUARIO (CODUSUARIO, NOME, STATUS, DATAINICIO, DATAEXPIRACAO, CONFIRMABTNOK, SENHA, CONTROLE, ULTIMACOLIGADA, CODACESSO, DTAEXPSENHA, DIASEXPSENHA, OBRIGAALTERARSENHA, NUMLOGININVALIDO, DATALOGININVALIDO, EMAIL)
 VALUES ('mestre', 'Usuario mestre', 1, '03/26/2002', '03/26/2003', NULL, 'rjoQbnJL', -18541, 1, 'Default', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT INTO GACESSO (CODACESSO, DESCRICAO, DBUSERNAME, DBPASSWORD, CONTROLE, DONOTABELA)
 VALUES ('Default', NULL, '\8Dkr\BE\3A\18\F8\BB', '\8Dkr\BE\3A\18\F8\BB', -21334, 1)
go
exec habilita_foreignkey
go
drop procedure desabilita_foreignkey
go
drop procedure habilita_foreignkey
go







select * from gacesso



