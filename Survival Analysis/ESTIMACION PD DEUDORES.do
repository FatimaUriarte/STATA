*Periodo inicial
foreach i in 201012 201112 201212 201312 {
	drop _all
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia_stata.dta", clear
	collapse (first) ENT_NCOD RCD_NSDO ingreso, by(DEO_ENT)
	keep if ingreso==`i'
	ren ingreso PER_NCOD
	sort DEO_ENT
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_`i'.dta", replace
}
*Seguimiento PD
foreach i in 201012{	
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_`i'.dta", clear
set more off
format %12.0g RCD_NSDO
	foreach a in 20110131 20110228 20110331 20110430 20110531 20110630 20110731 20110831 20110930 20111031 20111130 20111231{
		merge DEO_ENT using "D:\PD\PD_`a'.dta"
		drop if _merge==2
		drop _merge
		ren CLA_NCOD CLA_NCOD_`a'
		recast int CLA_NCOD_`a'
		sort DEO_ENT
		save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_`i'.dta", replace
		}
}
foreach i in 201112{	
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_`i'.dta", clear
set more off
format %12.0g RCD_NSDO
	foreach a in 20120131 20120229 20120331 20120430 20120531 20120630 20120731 20120831 20120930 20121031 20121130 20121231{
		merge DEO_ENT using "D:\PD\PD_`a'.dta"
		drop if _merge==2
		drop _merge
		ren CLA_NCOD CLA_NCOD_`a'
		recast int CLA_NCOD_`a'
		sort DEO_ENT
		save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_`i'.dta", replace
		}
}
foreach i in 201212{	
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_`i'.dta", clear
set more off
format %12.0g RCD_NSDO
	foreach a in 20130131 20130228 20130331 20130430 20130531 20130630 20130731 20130831 20130930 20131031 20131130 20131231{
		merge DEO_ENT using "D:\PD\PD_`a'.dta"
		drop if _merge==2
		drop _merge
		ren CLA_NCOD CLA_NCOD_`a'
		recast int CLA_NCOD_`a'
		sort DEO_ENT
		save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_`i'.dta", replace
		}
}
foreach i in 201312{	
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_`i'.dta", clear
set more off
format %12.0g RCD_NSDO
	foreach a in 20140131 20140228 20140331 20140430 20140531 20140630 20140731 20140831 20140930 20141031 20141130 20141231{
		merge DEO_ENT using "D:\PD\PD_`a'.dta"
		drop if _merge==2
		drop _merge
		ren CLA_NCOD CLA_NCOD_`a'
		recast int CLA_NCOD_`a'
		sort DEO_ENT
		save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_`i'.dta", replace
		}
}
*Hallamos la PD por número de deudores
foreach i in 201012 201112 201212 201312 {	
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_`i'.dta", clear
	egen PD= rowlast(CLA_NCOD_*)
	split DEO_ENT  , parse("-")
	drop DEO_ENT2
	ren DEO_ENT1 DEO_COD
	destring DEO_COD, replace
	*collapse (sum) RCD_NSDO, by( PER_NCOD PD DEO_COD )
	collapse (count) DEO_COD, by(PER_NCOD PD ENT_NCOD)
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_PD_`i'.dta", replace
	}
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_PD_201012.dta", clear
foreach i in 201112 201212 201312 {	
	set more off
	display "`i'"
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\Periodo_Inicial_PD_`i'.dta"
}
gen indicador="."
replace PD=0 if PD==8
replace indicador="PD" if (PD>2)
replace indicador="no PD" if (PD<3)
replace indicador="missing" if (PD==.)
