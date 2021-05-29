CREATE TABLE #OriginalFileList1 (
Col1 varchar(1000) NULL)

CREATE TABLE #ParsedFileList1 (
PFLID INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
DateTimeStamp datetime NOT NULL,
FileSize varchar(50) NOT NULL,
FileName1 varchar (255) NOT NULL)

SELECT @CMD1 = ''
SELECT @CMD2 = '' 
SELECT @FilePath = '\\192.168.11.13\sharedDev\vrmbsdata\vrmbslogs\portal\exceptionlog'


SELECT  'master.dbo.xp_cmdshell ' + char(39) + 'dir ' + '\\192.168.11.13\sharedDev\vrmbsdata\vrmbslogs\portal\exceptionlog' + '\*.*' + char(39)


