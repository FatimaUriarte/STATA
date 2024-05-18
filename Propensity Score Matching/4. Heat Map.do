
clear
set more off
cd "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\Big Data\Final project\Data"	

*All databases
use energy_2011.dta, clear
foreach i in 2012 2013 2014 2015 2016{ 
	append using energy_`i'.dta
}
merge m:1 BBL using PLUTO_PROC.dta
drop if _merge==2
tab _merge
drop if _merge==1 /*725 observations deleted (1%)*/
*drop if WNSourceEUI<5 | WNSourceEUI>1000 /*20,359 observations deleted*/
drop _merge
keep if YEAR==2011 | YEAR==2016
replace LONGITUDE=- LONGITUDE
keep LATITUDE LONGITUDE YEAR
drop if LATITUDE==.
export delimited using heat_map.csv, nolabel replace
