DECLARE @CMD1 varchar(5000) 
DECLARE @CMD2 varchar(5000)
DECLARE @FilePath varchar(200)

CREATE TABLE #OriginalFileList (
Col1 varchar(1000) NULL
)

-- 3 - Create the #ParsedFileList temporary table to suppor the cleansed file list
CREATE TABLE #ParsedFileList (
PFLID INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
DateTimeStamp datetime NOT NULL,
FileSize varchar(50) NOT NULL,
FileName1 varchar (255) NOT NULL
)

SELECT @CMD1 = ''
SELECT @CMD2 = '' 
SELECT @FilePath = '\\192.168.11.13\sharedDev\vrmbsdata\vrmbslogs\portal\exceptionlog'

SELECT @CMD1 = 'master.dbo.xp_cmdshell ' + char(39) + 'dir ' + @FilePath + '\*.*' + char(39)

SELECT @CMD2 = 'INSERT INTO #OriginalFileList(Col1)' + char(13) + 'EXEC ' + @CMD1

EXEC (@CMD2)

DELETE FROM #OriginalFileList
WHERE COL1 IS NULL

DELETE FROM #OriginalFileList
WHERE COL1 LIKE '%Volume%'

DELETE FROM #OriginalFileList
WHERE COL1 LIKE '%Directory%'

DELETE FROM #OriginalFileList
WHERE COL1 LIKE '%bytes%'

Delete from #ParsedFileList 
where FileName1 Like '%.%'


INSERT INTO #ParsedFileList (DateTimeStamp, FileSize, FileName1)
SELECT LTRIM(SUBSTRING (Col1, 1, 20)) AS 'DateTimeStamp',
LTRIM(SUBSTRING (Col1, 21, 18)) AS 'FileSize',
LTRIM(SUBSTRING (Col1, 40, 1000)) AS 'FileName1'
FROM #OriginalFileList

Delete from #ParsedFileList 
where FileName1 Like '%.%'

delete from #ParsedFileList 
where datediff(DD,datetimestamp,Getdate())> 2

select * from #ParsedFileList
select * from #OriginalFileList



