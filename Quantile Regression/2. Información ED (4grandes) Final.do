*******************************************************************************************************
***************CONSOLIDADO ESTRUCTURA DE DATOS (2016)**************************************************
*******************************************************************************************************
*Ruta
cd "D:\3. Investigaciones\Regresion cuantilica\Data"

*Banco de Crédito
drop _all
set more off
import delimited "\\sbs.gob.pe\data\EDs\2016\BCP\ED_HM_REPORTEED01_SPOOL_BCP.txt", delimiter("|") 
ren tio tpr
keep csbs nid mon morg kvi ccvi skcr tcr fot fveg tpr tea
destring nid tcr ccvi, replace force
sort tpr
merge tpr using leyendaTPR.dta
drop if _merge==2
drop _merge
gen ENT_NCOD=1
gen fecha="31/03/2016"
drop tpr
ren tpr1 tpr
sort csbs
save ED_2016_1.dta, replace

*Continental
drop _all
use "\\sbs.gob.pe\data\EDs\2016\BBVA Continental\ed01_v3.dta", clear
keep csbs nid mon morg kvi ccvi skcr tcr fot fveg tea ing 
gen ENT_NCOD=6
destring nid, replace force
gen fecha="31/05/2016"
save ED_2016_6.dta, replace

*Interbank
drop _all
import delimited "\\sbs.gob.pe\data\EDs\2016\Interbank\ANEXO01.txt", delimiter(";")
rename( v2 v4 v7 v8 v10 v17 v18 v36 v41 v47 v51 v9) (csbs nid mon morg tcr kvi ccvi  fot fveg tpr tea skcr)
keep csbs nid mon morg kvi ccvi skcr tcr fot fveg tpr tea
gen ENT_NCOD=2
destring nid, replace force
destring ccvi, replace
gen fecha="30/04/2016"
save ED_2016_2.dta, replace

*Scotiabank* La información no tienes tasas de interés

*********************************************************

*Consolidado
use ED_2015_4.dta, clear
keep if tcr==13 /*hipotecario*/
save ED_2016_grandes.dta, replace
foreach x in 1 2 6 {
	set more off
	use ED_2016_`x'.dta, clear
	keep if tcr==13 /*hipotecario*/
	display `x'
	append using ED_2016_grandes.dta
	save ED_2016_grandes.dta, replace
}
*Damos formato a la base de datos
format %12s fveg
*Fechas de desembolsos (otorgamiento)
split fot  , parse("/")
* --- Mes y año de otorgamiento del crédito
egen ingreso = concat ( fot3 fot2 )
drop fot1 fot2
rename fot3 ano
destring ingreso, replace
generate s_desembolso=string(int(ingreso/100))+"m"+string(ingreso -int(ingreso/100)*100)
*Fechas de vencimiento
split fveg  , parse("/")
egen vencimiento = concat ( fveg3 fveg2 )
drop fveg1 fveg2 fveg3
destring vencimiento, replace 
generate s_vencimiento=string(int(vencimiento/100))+"m"+string(vencimiento -int(vencimiento/100)*100)
drop ingreso vencimiento
generate PLAZO = monthly( s_vencimiento ,"YM")-monthly( s_desembolso ,"YM")
*Créditos Hipotecarios 2011-2015
destring ano, replace
keep if (ano>=2011 & ano<=2015)
ren csbs DEO_COD
*Créditos Vigentes
drop if kvi==0
drop if kvi>=. /*corresponde a deudores que no tienen TEA*/
*TEA=0
drop if tea==0 /*652 observations deleted*/
ren nid DNI
save info_ED_hipotecario.dta, replace

*Población: 97 621 deudores que tenían crédito hipotecario vigente al 30 de junio
foreach i in 20160630{
	drop _all
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Data completo\prestamos_`i'.dta", clear
	generate int CTA_NCOD4=int(CTA_NCOD/10000000000)
	keep if TCR_NCOD==23
	keep if CTA_NCOD4==1401
	collapse (sum) RCD_NSDO, by(ENT_NCOD DEO_COD)
	keep if ENT_NCOD<=6
	merge 1:1 DEO_COD ENT_NCOD using caracteristicas_saldos_final
	drop if _merge==1
	tab _merge 
	keep if _merge==3
	drop _merge
	save caracteristicas_saldos_final_vigente30jun.dta, replace
}

*Estadísticas ED -2015
use "D:\3. Investigaciones\Regresion cuantilica\Data\ED_2015_TOTAL.dta", clear
drop if tea==0
