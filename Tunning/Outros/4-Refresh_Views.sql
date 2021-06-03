/******************************************************************* 
	RUN ON THE PRO-WATCH DATABASE   
This script will Refresh ALL Views in Pro-Watch
 
*********************************************************************/
USE PWNT

DECLARE @viewname varchar(255)
DECLARE @viewname_header varchar(255)
DECLARE vnames_cursor CURSOR FOR SELECT name FROM sysobjects 
	WHERE type = 'v'
OPEN vnames_cursor
FETCH NEXT FROM vnames_cursor INTO @viewname
WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN
		SELECT @viewname_header = 'Refreshing ' +RTRIM(UPPER(@viewname))
		PRINT  @viewname_header
		EXEC ('sp_refreshview ' +  @viewname )
	END
	FETCH NEXT FROM vnames_cursor INTO @viewname
END
PRINT ' '
PRINT ' '
SELECT @viewname_header = '*************  NO MORE VIEWS TO REFRESH  *************'
PRINT @viewname_header
PRINT ' '
PRINT 'All Pro-Watch Views Have Been Refreshed.'
DEALLOCATE vnames_cursor