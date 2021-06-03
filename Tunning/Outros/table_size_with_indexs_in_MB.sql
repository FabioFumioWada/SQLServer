
DECLARE 
@id int,
@pages int,
@objname varchar(750)

SET NOCOUNT ON

CREATE TABLE #tblSize
(
	Name varchar (100),
	Rows varchar (100),
	Reserved varchar (100),
	Data varchar (100),
	Index_Size varchar (100),
	Unused varchar (100)
)
 
CREATE TABLE #spt_space
(
	rows  int null,
	reserved dec(15) null,
	data  dec(15) null,
	indexp  dec(15) null,
	unused  dec(15) null
)

-- declare main cursor to get first user table name from sysobjects
DECLARE TabNameCur CURSOR FOR 
	SELECT  id, name 
	FROM dbo.sysobjects
	WHERE xtype = 'u'
	ORDER BY name
 

OPEN  TabNameCur 
FETCH TabNameCur INTO @id, @objname
 
WHILE @@FETCH_STATUS = 0
BEGIN 
  
	TRUNCATE TABLE #spt_space
	
		INSERT INTO #spt_space (reserved)
			SELECT sum(reserved)
			FROM sysindexes
			WHERE indid in (0, 1, 255)
			AND id = @id
	 
		SELECT @pages = sum(dpages)
			FROM sysindexes
			WHERE indid < 2
			AND id = @id
	 
		SELECT @pages = @pages + isnull(sum(used), 0)
			FROM sysindexes
			WHERE indid = 255
			AND id = @id
	 
		UPDATE #spt_space
			SET data = @pages
	 
		UPDATE #spt_space
			SET indexp = (SELECT sum(used)
			FROM sysindexes
			WHERE indid in (0, 1, 255)
			AND id = @id) - data
	 
		UPDATE #spt_space
			SET unused = reserved
			- (SELECT sum(used)
			FROM sysindexes
			WHERE indid in (0, 1, 255)
			AND id = @id)
	 
	 	UPDATE #spt_space
			SET rows = i.rows
			FROM sysindexes i
			WHERE i.indid < 2
			AND i.id = @id


	--This step required as 'convert.../1000' cannot be used with varchars
	 	INSERT INTO #tblSize
		SELECT name = object_name(@id),
			rows, --= convert(char(11), rows),
			reserved = convert(decimal (8,2), (reserved * d.low / 1024.)/1000),
			data = convert(decimal (8,2), (data * d.low / 1024.)/1000),
			index_size = convert(decimal (8,2), (indexp * d.low / 1024.)/1000),
			unused = convert(decimal (8,2), (unused * d.low / 1024.)/1000)
			FROM #spt_space, master.dbo.spt_values d
			WHERE d.number = 1
			AND d.type = 'E'


	FETCH NEXT FROM TabNameCur INTO @id, @objname
	END
 

-- close & deallocate main cursor
CLOSE TabNameCur 
DEALLOCATE TabNameCur


	SELECT Name, Rows, 
		Reserved + ' MB' as Reserved, 
		Data + ' MB' as Data, 
		index_size + ' MB' as Index_Size, 
		unused  + ' MB' as Unused
		FROM #tblSize
order by Reserved desc
go
drop table #tblsize
drop table #spt_space



