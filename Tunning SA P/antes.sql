drop table #tblsize
drop table #spt_space

declare @id int,
			@pages int,
			@objname varchar(750)
			
set nocount on

create table tblsize_antes (
	name varchar(100),
	rows varchar(100),
	reserved varchar(100),
	data varchar(100),
	index_size varchar(100),
	unused varchar(100))
	
	create table spt_space_antes (
		rows int null,
		reserved dec(15) null,
		data dec(15) null,
		indexp dec(15) null,
		unused dec(15) null)
		
declare tabnamecur cursor for
	select id, name 
	from dbo.sysobjects 		
	where xtype = 'u'
	order by name

open tabnamecur
fetch tabnamecur into @id, @objname

while @@FETCH_STATUS = 0
begin
	truncate table spt_space_antes
	
	insert into spt_space_antes (reserved)
		select SUM(reserved)
		from sysindexes
		where indid in (0,1,255)
		and id = @id
		
		select @pages = SUM(dpages)
		from sysindexes
		where indid < 2
		and id = @id
		
		select @pages = @pages + ISNULL(sum(used),0)
		from sysindexes
		where indid = 255
		and id = @id
		
		update spt_space_antes set data = @pages
		
		update spt_space_antes set indexp = (select SUM(used) from sysindexes where indid in (0,1,255)
		and id = @id) - data
		
		update spt_space_antes set unused = reserved - (select SUM(used) from sysindexes where indid in (0,1,255) and id = @id)
		
		update spt_space_antes set rows = i.rows from sysindexes i where i.indid < 2 and i.id = @id
		
		insert into tblsize_antes
		select name = object_name(@id),
				rows, --=convert(char(11), rows),
				reserved = CONVERT(decimal (8,2), (reserved * d.low /1024.)/1000),
				data = convert(decimal(8,2), (data * d.low / 1024.) /1000),
				index_size = convert(decimal (8,2), (indexp * d.low / 1024.)/1000),
				unused = convert(decimal (8,2), (unused * d.low / 1024.)/1000)
				from spt_space_antes, master.dbo.spt_values d
				where d.number = 1
				and d.type = 'E'
				
				fetch next from tabnamecur into @id, @objname
				end
				
				close tabnamecur
				deallocate tabnamecur
go				
				
				select *
				from tblsize_antes
		