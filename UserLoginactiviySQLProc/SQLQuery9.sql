Declare @i int
set @i = 1
Create table #t (value int, identifire varchar(3))
While (@i < 257)
Begin
insert into #t Values(@i, char(@i))
Set @i=@i+1
End


select * from #t

--drop table #t
