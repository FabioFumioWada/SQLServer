declare @tabela varchar(100),
		@comando varchar(255)
		
declare cr_objetos cursor for
	select name
	from sysobjects
	where xtype = 'u'
	order by name
	
open cr_objetos
fetch next from cr_objetos into @tabela

while @@FETCH_STATUS = 0
begin
	select @comando = 'DBCC DBREINDEX ('+''''+@tabela+''''+')'
	print @comando
	exec (@comando)

	fetch next from cr_objetos into @tabela
end			
close cr_objetos
deallocate cr_objetos
go