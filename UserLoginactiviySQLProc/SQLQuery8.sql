drop table #c
declare @i varchar(20)
declare @j varchar(28)
declare @k int
set @k = 1
select name , Row_number() over (order by Name) as i into #c from #t
while (@k < (select max(i) from #c)+1 )
begin
set @i = (select name from #c where i = @k)
set @j= 'vichara india  \ '+ @i
Print @j 
set @k = @k+1
End


select *,Row_number() over (order by Name)i from #t

select * from #c
drop table #c