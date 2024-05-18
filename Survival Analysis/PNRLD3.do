
*Información basada en el Informe de Mercado de Préstamos No revolventes para libre disponibilidad
foreach i in 20091130 20091231 20100131 20100228 20100331 20100430 20100531 20100630 20100731 20100831 20100930 20101031 20101130 20101231 20110131 20110228 20110331 20110430 20110531 20110630 20110731 20110831 20110930 20111031 20111130 20111231 20120131 20120229 20120331 20120430 20120531 20120630 20120731 20120831 20120930 20121031 20121130 20121231 20130131 20130228 20130331 20130430 20130531 20130630 20130731 20130831 20130930 20131031 20131130 { 
        use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
		set more off
		sort DEO_COD
		egen max=max(DEO_COD)
		format %12.0g max
		display `i'
		display %12.0g max
}
*Data nuevos códigos de deudores
foreach i in 20100131 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 96873664
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	*append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20100228 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 97550664
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20100331 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>  98202648
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20100430 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 98954136
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20100531 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 99616248
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20100630{
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 100308928
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
} 
foreach i in 20100731 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 100992648
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20100831 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 101741112
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20100930 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 102506152
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20101031 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 103327008
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20101130 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 104146904
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20101231 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>  105011776
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20110131 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 105962072
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20110228 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 106890752
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20110331 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>  107661504
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
} 
foreach i in 20110430 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 108638784
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20110531 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>  109432456
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20110630 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 110303808
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20110731 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>  111119784
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20110831 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 111923952
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20110930 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>  112781504
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20111031 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>  113657696
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20111130{
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 114615800
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20111231 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>115536960
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
} 
foreach i in 20120131 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 116582280
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20120229 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 117362512
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20120331 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 118223656
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20120430 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>  119237808
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20120531 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 120105496
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20120630 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>  121172144
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20120731 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 122154096
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20120831 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 123143784
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20120930{
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 124098336
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
} 
foreach i in 20121031 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD>  125041488
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20121130 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 126018096
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20121231 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 127040048
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20130131 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 128012904
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20130228 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 129359496
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20130331 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 130139392
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in  20130430{
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 130976760
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in  20130531{
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 131848296
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in  20130630{
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 132680640
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
} 
foreach i in 20130731 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 133547720
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20130831 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 134431952
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20130930 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 135278832
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20131031 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 136101168
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20131130 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 137005456
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
foreach i in 20131231 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	sort DEO_COD
	keep if DEO_COD> 137884640
	replace ENT_NCOD=123 if ENT_NCOD==226 /*Mibanco*/
	replace ENT_NCOD=230 if ENT_NCOD==154 /*Credinka*/
	collapse (sum) RCD_NSDO, by (DEO_COD PER_NCOD ENT_NCOD CLA_NCOD)
	format %14.0g DEO_COD
	tostring DEO_COD , replace
	tostring ENT_NCOD, replace
	ren CLA_NCOD CLA_NCOD1
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	sort DEO_ENT
	append using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta"
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", replace
}
******************************************************************************************************************
* Para obtener el género y edad de los deudores
drop _all
odbc load, exec("SELECT DEO_COD, DEU_CSEX, DEU_FNAC FROM DMT_DEUDOR") dsn("stata") user(furiarte) password(uriarte2013) 
sort DEO_COD
format %14.0g DEO_COD
drop if DEU_FNAC>=.
sort DEO_COD
tostring DEU_FNAC, generate(fecha) usedisplayformat force
gen nac = substr( fecha , 6, 10)
split nac  , parse(" ")
destring nac1, replace force
gen edad=2014-nac1
drop if DEU_CSEX=="(no aplica)"
drop if DEU_CSEX=="(sin valor)"
gen sexo=1 if DEU_CSEX=="Masculino"
replace sexo=0 if DEU_CSEX=="Femenino"
keep DEO_COD DEU_CSEX edad sexo
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\caracteristicas.dta", replace

*Data de deudores de préstamos libre disponibilidad nuevos en el periodo 2010-2013
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos.dta", clear
keep if CLA_NCOD1==0 /*solo deudores clasificados como normal*/
drop if RCD_NSDO<100 /*1 139 158 observaciones*/
destring DEO_COD, replace
merge m:1 DEO_COD using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\caracteristicas.dta"
keep if _merge==3 /* 1 119 236 observaciones*/
drop _merge
merge m:1 DEO_COD using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DNI_consolidado.dta"
keep if _merge==3/*388 observaciones no tienen DNI*/
drop _merge /*1 118 848 observaciones*/
merge m:1 DNI using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\ingresos.dta"
keep if _merge==3 /* 283 773 observaciones y 25% de la población de análisis*/
drop _merge
destring ENT_NCOD, replace
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos_FINAL.dta", replace















