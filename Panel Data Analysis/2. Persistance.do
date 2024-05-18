********************************************************************************
*Inflation Persistance**********************************************************
*Author: Fatima Uriarte Caceres*************************************************
********************************************************************************

*Install necessary packages
sysdir set PLUS "\\SIPAXFSC\Users\flu2103\Desktop\macroeconometrics\ado\"
ssc install rolling2, replace
ssc install dfsummary, replace
ssc install outreg2, replace

*Initial settings
cd "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\MacroPaper"
capture log close
set logtype text
log using inflation_persistance, replace

foreach i in 1 2 3 4 6 8 9{
	cd "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\MacroPaper"
	use revela_data.dta, clear
	drop if date=="Dec-17" | date=="Nov-17" 
	keep if id==`i'
	keep country date current_inflation mes id
	duplicates drop country date current_inflation, force
	*Format date
	split date , p("-")
	egen date3=concat( date1 date2)
	drop date date1 date2
	ren date3 date
	gen time=date(mes,"DMY")
	drop mes
	format time %td
	gen month=month(time)
	gen year=year(time)
	gen monthly=ym(year, month)
	format monthly %tm
	tsset monthly
	*dfsummary current_inflation, lag(5)
	*corrgram current_inflation if tin(2006m12,2012m4), lags(30)
	*corrgram current_inflation if tin(2012m5,2017m10), lags(30)
	display `i'
	cd "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\MacroPaper\Graphs"
	*First Period
	pac current_inflation if tin(2006m12,2012m4), lags(9) 
	graph save `i'_1, replace
	dfsummary current_inflation if tin(2006m12,2012m4), lag(5)
	*Second Period
	pac current_inflation if tin(2012m5,2017m10), lags(9) 
	graph save `i'_2, replace
	dfsummary current_inflation if tin(2012m5,2017m10), lag(5)		
}
foreach i in 5 7{
	cd "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\MacroPaper"
	use revela_data.dta, clear
	drop if date=="Dec-17" | date=="Nov-17" 
	keep if id==`i'
	keep country date current_inflation mes id
	duplicates drop country date current_inflation, force
	*Format date
	split date , p("-")
	egen date3=concat( date1 date2)
	drop date date1 date2
	ren date3 date
	gen time=date(mes,"DMY")
	drop mes
	format time %td
	gen month=month(time)
	gen year=year(time)
	gen monthly=ym(year, month)
	format monthly %tm
	generate time1 = q(2006q4) + _n-1
	format time1 %tq
	tsset time1
	display `i'
	*First Period
	dfsummary current_inflation if tin(2006q4,2012q1), lag(5)
	*Second Period
	dfsummary current_inflation if tin(2012q2,2017q3), lag(5)	
}
log close






