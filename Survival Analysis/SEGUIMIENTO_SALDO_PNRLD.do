*Base con saldo de créditos 
foreach i in 20100131 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	collapse (sum) RCD_NSDO, by ( DEO_COD ENT_NCOD PER_NCOD)
	tostring DEO_COD ENT_NCOD, replace
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	drop DEO_COD ENT_NCOD
	sort DEO_ENT
	merge 1:1 DEO_ENT using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\CODIGOS_MUESTRA.dta"
	keep if _merge==3
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\SEGUIMIENTO_SALDO_PNRLD.dta", replace
}
foreach i in 20100228 20100331 20100430 20100531 20100630 20100731 20100831 20100930 20101031 20101130 20101231 20110131 20110228 20110331 20110430 20110531 20110630 20110731 20110831 20110930 20111031 20111130 20111231 20120131 20120229 20120331 20120430 20120531 20120630 20120731 20120831 20120930 20121031 20121130 20121231 20130131 20130228 20130331 20130430 20130531 20130630 20130731 20130831 20130930 20131031 20131130 20131231 20140131 20140228 20140331 20140430 20140531 20140630 20140731 20140831 20140930 20141031 20141130 20141231 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	collapse (sum) RCD_NSDO, by ( DEO_COD ENT_NCOD PER_NCOD)
	tostring DEO_COD ENT_NCOD, replace
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	drop DEO_COD ENT_NCOD
	sort DEO_ENT
	merge 1:1 DEO_ENT using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\CODIGOS_MUESTRA.dta"
	keep if _merge==3
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\SEGUIMIENTO_SALDO_PNRLD.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\SEGUIMIENTO_SALDO_PNRLD.dta", replace
}
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\SEGUIMIENTO_SALDO_PNRLD.dta", clear
ren (PER_NCOD RCD_NSDO) (ano SALDO_PNRLD)
drop _merge
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\SEGUIMIENTO_SALDO_PNRLD.dta", replace
