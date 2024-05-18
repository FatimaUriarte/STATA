
clear
set more off
cd "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\Big Data\Final project\Data"	

use energy_total.dta, clear
drop LATITUDE LONGITUDE DOF_FLOOR_AREA LARGE_FLOOR_AREA YEAR_BUILT OCCUPANCY FUEL_OIL1 FUEL_OIL2 FUEL_OIL4 FUEL_OIL56 NATURAL_GAS_USE ELECTRICITY_USE
reshape wide WNSourceEUI ESTAR GHG TYPE , i(BBL) j(YEAR)
egen ESTAR_MIS= rowmiss(ESTAR*)
gen IND_STAR=0 if ESTAR_MIS==6 
replace IND_STAR=1 if IND_STAR!=0
*Pluto
merge m:1 BBL using PLUTO_proc.dta
drop if _merge==2
drop _merge
*Type
egen str TYPE2=rowlast(TYPE*)
egen str TYPE1=rowfirst(TYPE*)
gen TYPE=TYPE2 if TYPE2!=""
replace TYPE=TYPE1 if TYPE1!="" & TYPE==""
drop if TYPE==""
keep if TYPE=="Multifamily Housing" /*Only Multifamily Housing*/
save energy_total_final.dta, replace

*Energy*************************************************************************
use energy_total_final.dta, clear
egen ENERGY_MIS= rowmiss(WNSourceEUI*)
drop if ENERGY_MIS>=3
*Delta - Energy
egen ENERGY_1=rowfirst(WNSourceEUI*)
egen ENERGY_2=rowlast(WNSourceEUI*)
gen DELTA= (log(ENERGY_2)-log(ENERGY_1))*100
*drop if abs(DELTA)>50
drop if DELTA==0
*Probit model
global X "LOTAREA BLDGAREA AREASOURCE NUMFLOORS YEARBUILT"
dprobit IND_STAR $X
outreg2 using probit.xls, e(r2_w) replace
predict pscore
histogram pscore, by (IND_STAR)
pscore IND_STAR $X, pscore(pscore_b) blockid(id) comsup det numblo(5) level(0.00001)
*Seed
set seed 50
drawnorm orden
sort orden
*Model
psmatch2 IND_STAR $X, outcome (DELTA) n(1) trim(20) ai(1)
psmatch2 IND_STAR $X, outcome (DELTA) n(1) trim(20) com ai(1)
kdensity  pscore if IND_STAR==0, addplot(kdensity  pscore if IND_STAR==1, bwidth(0.05)) bwidth(0.05)legend(order(1 "Control" 2 "Treated") col(2)) xtitle("Participation Probability", size(small)) ytitle("Density", size(small)) 

*GHG emissions******************************************************************
use energy_total_final.dta, clear
egen ENERGY_MIS= rowmiss(GHG*)
drop if ENERGY_MIS>=3
*Delta - Energy
egen EGHG_1=rowfirst(GHG*)
egen EGHG_2=rowlast(GHG*)
gen DELTA=(log(EGHG_2)-log(EGHG_1))*100
drop if DELTA==0
*Probit model
global X "LOTAREA BLDGAREA AREASOURCE NUMFLOORS YEARBUILT"
dprobit IND_STAR $X
outreg2 using probit.xls, e(r2_w)
predict pscore
histogram pscore, by (IND_STAR)
pscore IND_STAR $X, pscore(pscore_b) blockid(id) comsup det numblo(5) level(0.00001)
*Seed
set seed 50
drawnorm orden
sort orden
*Model
psmatch2 IND_STAR $X, outcome (DELTA) n(1) com
psmatch2 IND_STAR $X, outcome (DELTA) n(1) trim(20)

kdensity  pscore if IND_STAR==0, addplot(kdensity  pscore if IND_STAR==1, bwidth(0.05)) bwidth(0.05)legend(order(1 "Control" 2 "Treated") col(2)) xtitle("Participation Probability", size(small)) ytitle("Density", size(small)) 

