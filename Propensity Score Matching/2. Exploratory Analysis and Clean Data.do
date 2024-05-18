
clear
set more off
cd "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\Big Data\Final project\Data"	

foreach i in 2011 2012 2013 2014{
	import delimited Energy_and_Water_Data_Disclosure_for_Local_Law_84_`i'.csv, clear
	display `i'
	keep bbl weathernormalizedsourceeui energystarscore primarypropertytypeselfselected totalghgemissionsmtco2e longitude latitude
	ren (bbl weathernormalizedsourceeui energystarscore primarypropertytypeselfselected totalghgemissionsmtco2e longitude latitude) (BBL WNSourceEUI ESTAR TYPE GHG LONGITUDE LATITUDE)
	destring BBL WNSourceEUI ESTAR GHG LONGITUDE LATITUDE, replace force
	duplicates drop
	duplicates tag BBL, gen(dup)
	tab dup
	keep if dup==0 /*same BBL but different information*/
	drop dup
	gen YEAR=`i'
	save energy_`i'.dta, replace
}

foreach i in 2015 2016{
	import delimited Energy_and_Water_Data_Disclosure_for_Local_Law_84_`i'.csv, clear
	display `i'
	keep bbl weathernormalizedsourceeui energystarscore primarypropertytypeselfselected totalghgemissionsmtco2e longitude latitude dofgrossfloorarea largestpropertyusetypegrossfloor yearbuilt occupancy fueloil1usekbtu fueloil2usekbtu fueloil4usekbtu fueloil56usekbtu naturalgasusekbtu electricityusegridpurchasekbtu
	ren (bbl weathernormalizedsourceeui energystarscore primarypropertytypeselfselected totalghgemissionsmtco2e longitude latitude dofgrossfloorarea largestpropertyusetypegrossfloor yearbuilt occupancy fueloil1usekbtu fueloil2usekbtu fueloil4usekbtu fueloil56usekbtu naturalgasusekbtu electricityusegridpurchasekbtu) (BBL WNSourceEUI ESTAR TYPE GHG LONGITUDE LATITUDE DOF_FLOOR_AREA LARGE_FLOOR_AREA YEAR_BUILT OCCUPANCY FUEL_OIL1 FUEL_OIL2 FUEL_OIL4 FUEL_OIL56 NATURAL_GAS_USE ELECTRICITY_USE)
	destring BBL WNSourceEUI ESTAR GHG LONGITUDE LATITUDE LARGE_FLOOR_AREA FUEL_OIL1 FUEL_OIL2 FUEL_OIL4 FUEL_OIL56 NATURAL_GAS_USE ELECTRICITY_USE YEAR_BUILT , replace force
	duplicates drop
	duplicates tag BBL, gen(dup)
	tab dup
	keep if dup==0 /*same BBL but different information*/
	drop dup
	gen YEAR=`i'
	save energy_`i'.dta, replace
}

*All databases
use energy_2011.dta, clear
foreach i in 2012 2013 2014 2015 2016{ 
	display `i'
	append using energy_`i'.dta
}
merge m:1 BBL using PLUTO_PROC.dta
drop if _merge==2
tab _merge
drop if _merge==1 /*725 observations deleted (1%)*/
drop if WNSourceEUI<5 | WNSourceEUI>1000 /*20,359 observations deleted*/
drop _merge
save energy_total.dta, replace

*Distributions*
use energy_total.dta, clear
drop if WNSourceEUI>500
kdensity WNSourceEUI if YEAR==2011 , addplot(kdensity WNSourceEUI if YEAR ==2012, lcolor(eltblue) bwidth(20) || kdensity WNSourceEUI if YEAR ==2013, lcolor(brown) bwidth(20) || kdensity WNSourceEUI if YEAR ==2014, lcolor(cranberry) bwidth(20) || kdensity WNSourceEUI if YEAR ==2015, lcolor(red) bwidth(20) || kdensity WNSourceEUI if YEAR ==2016, lcolor(purple) bwidth(20)) lcolor(blue) xlabel(0(100)500, labsize(small)) legend(order(1 "2011" 2 "2012" 3 "2013" 4 "2014" 5 "2015" 6 "2016") size(small) col(6)) ylabel(0 0.01, angle(horizontal) labsize(small) format(%3.2f))xtitle("WNSourceEUI", size(small)) ytitle( "Density", size(small))  bwidth(20)

use energy_total.dta, clear
drop if GHG>1000
kdensity GHG if YEAR==2011 , addplot(kdensity GHG if YEAR ==2012, lcolor(eltblue) bwidth(50) || kdensity GHG if YEAR ==2013, lcolor(brown) bwidth(50) || kdensity GHG if YEAR ==2014, lcolor(cranberry) bwidth(50) || kdensity GHG if YEAR ==2015, lcolor(red) bwidth(50) || kdensity GHG if YEAR ==2016, lcolor(purple) bwidth(50)) lcolor(blue) xlabel(0(100)1000, labsize(small)) legend(order(1 "2011" 2 "2012" 3 "2013" 4 "2014" 5 "2015" 6 "2016") size(small) col(6)) ylabel(0 0.001, angle(horizontal) labsize(small) format(%3.2f))xtitle("Energy Star Score", size(small)) ytitle( "Density", size(small))  bwidth(50)

use energy_total.dta, clear
drop if ESTAR>100
kdensity ESTAR if YEAR==2011 , addplot(kdensity ESTAR if YEAR ==2012, lcolor(eltblue) bwidth(20) || kdensity ESTAR if YEAR ==2013, lcolor(brown) bwidth(20) || kdensity ESTAR if YEAR ==2014, lcolor(cranberry) bwidth(20) || kdensity ESTAR if YEAR ==2015, lcolor(red) bwidth(20) || kdensity ESTAR if YEAR ==2016, lcolor(purple) bwidth(20)) lcolor(blue) xlabel(0(20)120, labsize(small)) legend(order(1 "2011" 2 "2012" 3 "2013" 4 "2014" 5 "2015" 6 "2016") size(small) col(6)) ylabel(0 0.001, angle(horizontal) labsize(small) format(%3.2f))xtitle("Energy Star Score", size(small)) ytitle( "Density", size(small))  bwidth(20)

*Gross Impacts*
forval i = 2011/2012 {
	use energy_total.dta, clear
	keep if YEAR==`i' | YEAR==`i'+1
	drop FUEL_OIL1 FUEL_OIL2 FUEL_OIL4 FUEL_OIL56 NATURAL_GAS_USE ELECTRICITY_USE LATITUDE LONGITUDE DOF_FLOOR_AREA LARGE_FLOOR_AREA YEAR_BUILT OCCUPANCY
	reshape wide WNSourceEUI ESTAR GHG TYPE , i(BBL) j(YEAR)
	egen str TYPE2=rowlast(TYPE*)
	egen str TYPE1=rowfirst(TYPE*)
	gen TYPE=TYPE2 if TYPE2!=""
	replace TYPE=TYPE1 if TYPE1!="" & TYPE==""
	drop if TYPE==""
	egen WNSourceEUI2=rowlast(WNSourceEUI*)
	egen WNSourceEUI1=rowfirst(WNSourceEUI*)
	gen EUI_GROWTH= (WNSourceEUI2/WNSourceEUI1 -1)*100
	drop if abs(EUI_GROWTH)>50
	gen EUI_IMPACT= -(WNSourceEUI2-WNSourceEUI1)*BLDGAREA
	gen T_WNSourceEUI2=WNSourceEUI2*BLDGAREA
	gen T_WNSourceEUI1=WNSourceEUI1*BLDGAREA
	egen T_GHG2=rowlast(GHG*)
	egen T_GHG1=rowfirst(GHG*)
	egen TOTAL_WNSourceEUI2=total(T_WNSourceEUI2)
	egen TOTAL_WNSourceEUI1=total(T_WNSourceEUI1)
	egen TOTAL_IMPACT=total(EUI_IMPACT)
	egen TOTAL_GHG2=total(T_GHG2)
	egen TOTAL_GHG1=total(T_GHG1)
	gen YEAR=`i'
	keep YEAR TOTAL_*
	format %20.0g TOTAL_*
	duplicates drop
	save gross_energy_savings_`i'.dta, replace
}

use gross_energy_savings_2011.dta, replace
foreach i in 2012 2013 2014 2015{ 
	append using gross_energy_savings_`i'.dta
}
