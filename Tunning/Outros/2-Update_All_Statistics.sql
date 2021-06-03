
/******************************************************************* 
	RUN ON THE PRO-WATCH DATABASE   
This script will update statistics for ALL indexes in Pro-Watch
 ...Statistical information is used by the 
 query processor to determine the optimal strategy 
 for evaluating a query. When statistical information
 is out of date performance may be degraded...
*********************************************************************/
USE PWNT

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
		SELECT @tablename_header = 'Updating '  
			+RTRIM(UPPER(@tablename))
		PRINT @tablename_header
		EXEC ('UPDATE STATISTICS ' +  @tablename )
	END
	FETCH NEXT FROM tnames_cursor INTO @tablename
END
PRINT ' '
PRINT ' '
SELECT @tablename_header = '*************  NO MORE TABLES  *************'
PRINT @tablename_header
PRINT ' '
PRINT 'Statistics for All Pro-Watch tables have been updated.'
DEALLOCATE tnames_cursor