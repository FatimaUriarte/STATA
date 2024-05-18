*PLUTO
cd "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\Big Data\data\pluto"
foreach x in MN BX BK QN SI {
	insheet using `x'2017V1.csv, comma names clear
	tempfile pluto`x'
	save `pluto`x'', replace
	}
use `plutoMN'
append using `plutoBX'
append using `plutoBK'
append using `plutoQN'
append using `plutoSI'
save "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\Big Data\Final project\Data\PLUTO.dta", replace

cd "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\Big Data\Final project\Data"
use PLUTO.dta, clear
keep bbl ownertype yearbuilt lotarea numfloors bldgarea areasource
ren (bbl ownertype yearbuilt lotarea numfloors bldgarea areasource) (BBL OWNERTYPE YEARBUILT LOTAREA NUMFLOORS BLDGAREA AREASOURCE)
duplicates tag BBL, gen(dup)
tab dup
drop dup /*no duplicates*/
save PLUTO_proc.dta, replace
