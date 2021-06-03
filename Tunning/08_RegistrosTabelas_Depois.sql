create table ztabelasreg_depois (
	tabela varchar(100),
	registros int)
	go

declare @tabela varchar(100),
		@comando varchar(255),
		@qtd int
		
declare cr_objetos cursor for
	select name
	from sysobjects
	where xtype = 'u'
	order by name
	
set nocount on
	
open cr_objetos
fetch next from cr_objetos into @tabela

while @@FETCH_STATUS = 0
begin
	select @comando = 'insert into ztabelasreg_depois (tabela, registros) select '+''''+@tabela+''','+'count(*) from '+@tabela 
	print @comando
	exec (@comando)

	fetch next from cr_objetos into @tabela
end			
close cr_objetos
deallocate cr_objetos
go