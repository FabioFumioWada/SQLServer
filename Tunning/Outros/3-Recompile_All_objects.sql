/*******************************************************************/ 
		RUN ON THE PRO-WATCH DATABASE 

This may take a while to run.  There is a built in delay to spread 
the task out and ease the processor load.

The queries used by stored procedures and triggers are optimized 
when they are compiled. 

As indexes or other changes that affect statistics are made to the 
database, compiled stored procedures and triggers may lose 
efficiency. By recompiling stored procedures and triggers that act 
on a table, you can reoptimize the queries.
/********************************************************************/

Use PWNT

DECLARE @tablename varchar(128)
DECLARE @tablename_header varchar(128)
DECLARE tnames_cursor CURSOR FOR SELECT name FROM sysobjects 
	WHERE type = 'U'
OPEN tnames_cursor
FETCH NEXT FROM tnames_cursor INTO @tablename
WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN

		SELECT @tablename_header = 'Updating '+ RTRIM(UPPER(@tablename))
		PRINT @tablename_header
		EXEC ('SP_RECOMPILE ' +  @tablename )

	END
--waitfor delay '00:00:02'
	FETCH NEXT FROM tnames_cursor INTO @tablename
END
PRINT ' '
PRINT ' '
SELECT @tablename_header = '**********  NO MORE STUFF TO MARK FOR RECOMPILATION *************'
PRINT @tablename_header
PRINT ' '
PRINT 'ALL Objects in Pro-Watch have been marked for recompilation.'
DEALLOCATE tnames_cursor