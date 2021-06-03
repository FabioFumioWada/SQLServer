use pwnt

DECLARE @TableName sysname
DECLARE @IndexName VARCHAR(255)
DECLARE @indid int
DECLARE cur_tblfetch CURSOR FOR
SELECT name from sysobjects where xtype='U'
--and name not like '%ev_log%' 
--and name not like '%ops_log%'
--and name not like '%audit%'
	

OPEN cur_tblfetch
	FETCH NEXT FROM cur_tblfetch INTO @TableName
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		DECLARE cur_indfetch CURSOR FOR
		SELECT indid,name FROM sysindexes WHERE id = OBJECT_ID (@TableName) and keycnt > 0 
		OPEN cur_indfetch
			FETCH NEXT FROM cur_indfetch INTO @indid,@IndexName
			WHILE @@FETCH_STATUS = 0
				BEGIN 
				  print 'Defrag and Reindex ' + (@TableName) + '.' + (@IndexName)
				  IF @indid <> 255 DBCC INDEXDEFRAG (0, @TableName, @indid)
				  IF @indid <> 255 DBCC DBREINDEX (@TableName, @IndexName)
				  FETCH NEXT FROM cur_indfetch INTO @indid,@IndexName
				END
		CLOSE cur_indfetch
		DEALLOCATE cur_indfetch
		FETCH NEXT FROM cur_tblfetch INTO @TableName
	END
CLOSE cur_tblfetch
DEALLOCATE cur_tblfetch