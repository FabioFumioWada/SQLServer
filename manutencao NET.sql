-- Script para remoção dos erros do C# como por exemplo 
-- Couldn't perform the edit because another user changed the record.

-- ATENÇÃO: ESTE NÃO DEVE SER EXECUTADO SE O BANCO FIZER BACKUP DE LOG 

set nocount on
declare @comando varchar(255)
declare @comando1 varchar(255)
declare @comando2 varchar(255)
declare @comando3 varchar(255)
declare @comando4 varchar(255)
declare @database varchar(100)
declare @datab varchar(50)
set @datab = (select distinct table_catalog from information_schema.tables)
if (select count(*) from master.dbo.sysprocesses where dbid in ( select dbid from master.dbo.sysdatabases where name = @datab )) <= 1 
begin
	print ' '
	print 'Acertando permissões do banco.'
	exec sp_dboption @datab, 'single', 'true' 
	exec sp_dboption @datab, 'trunc. log on chkpt.', 'true'
	exec sp_dboption @datab, 'auto create statistics', 'false'
	exec sp_dboption @datab, 'auto update statistics', 'false'
	exec sp_dboption @datab, 'ansi null default', 'true'
	print ' '
	print 'Verificando base de dados.'
	set @comando1 ='dbcc checkdb ('+@datab+')'
	exec (@comando1)
	print ' '
	print 'Acertando fragmentação na base de dados.'
	set @comando3= 'dbcc newalloc ('+@datab+')'
	exec (@comando3)
	declare @tabela varchar (100)
	declare @comando5 varchar (255)
	declare tabela cursor for
		select name from sysobjects where type = 'u' order by name
	open tabela
	fetch next from tabela into @tabela
	while @@fetch_status = 0
	begin
		print ''
		print 'Verificando tabela '+@tabela
		print ''
		set @comando5 = 'dbcc checktable ('+@tabela +', repair_allow_data_loss)'
		exec (@comando5)
		set @comando = 'dbcc dbreindex ('+@tabela+')' 
		exec (@comando5)
		set @comando5= 'dbcc checkconstraints ('+@tabela+')'
		exec (@comando5)
		fetch next from tabela into @tabela
	end
	close tabela
	deallocate tabela
	exec sp_dboption @datab, 'single', 'false' 
	declare @tab_nome varchar(255)
	declare @tab_statistic varchar(255)
	declare @sql_str varchar(255)
	declare @db_nome varchar(255)
	select @db_nome=name from master..sysdatabases where dbid=(select dbid from master..sysprocesses where spid=@@spid)
	checkpoint
	declare cur cursor for 
		select object_name(id),name from sysindexes where name like '_wa_sys%'
	set nocount on
	open cur 
	fetch next from cur into @tab_nome,@tab_statistic
	while(@@fetch_status=0)
	begin
		set @sql_str='drop statistics ' + @tab_nome + '.' + @tab_statistic
		exec (@sql_str)
		fetch next from cur into @tab_nome,@tab_statistic
	end	
	close cur
	deallocate cur
	exec sp_updatestats
	print '*******************************************************************************************'
	print 'FINAL DA MANUNTENCAO'
	print '*******************************************************************************************'
end
else
	begin
	print '****** A T E N Ç Â O *******'
	print 'A BASE ESTÁ SENDO USADA. ESTE SCRIPT SÓ PODE SER EXECUTADO EM MONOUSUÁRIO !!!'
	print '***********************************************************************************************************************'
	print 'Seguintes estações/número de conexões estão acessado a base de dados:'
	declare @tab varchar(20)
	declare @num varchar(2)
	declare tabs cursor for select hostname,count(*) from master.dbo.sysprocesses where dbid in ( select dbid from master.dbo.sysdatabases where name = @datab ) group by hostname
	open tabs
	fetch next from tabs into @tab,@num
	while(@@fetch_status=0)
	begin
		print @tab +'/'+@num
		fetch next from tabs into @tab,@num
	end
	close tabs
	deallocate tabs
end

