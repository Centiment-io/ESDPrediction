data dataset;
	set Syn;
proc sql;
select Year, Month, sum(Jobs) as TotalJobs, sum(Economic) as TotalEco, sum(Tax) as TotalIncomeTax, sum(number) as TotalPermits
from dataset
group by Year, Month
order by Year, Month;
run;
quit;
