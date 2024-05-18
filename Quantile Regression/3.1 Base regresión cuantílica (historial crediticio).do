*Ruta
cd "D:\3. Investigaciones\Regresion cuantilica\Data"

*Base Regresión Cuantílica (faltan variables garantía, peor clasificación y compra de deuda)*
use info_ED_hipotecario.dta, clear
*Año
keep if ano==2015
*Moneda
gen MON=1 if mon=="PEN"
replace MON=0 if MON!=1
label def moneda 0 "US$" 1 "S/" 
label values MON moneda
drop mon 
*drop if MON==0/* 1 353 observations deleted*/
*Monto otorgado
split fot  , parse("/")
egen FECHA = concat ( fot3 fot2 )
destring FECHA, replace
merge m:1 FECHA using TCC.dta
drop if _merge==2
drop fot* _merge
*Plazo
gen plazo_años=PLAZO/12
*Entidad
gen ENT_NCOD_FINAL=0 if ENT_NCOD==1
replace ENT_NCOD_FINAL=1 if ENT_NCOD==2
replace ENT_NCOD_FINAL=2 if ENT_NCOD==4
replace ENT_NCOD_FINAL=3 if ENT_NCOD==6
label define ent_ncod 0 "BCP" 1 "IBK" 2 "SCO" 3 "BBVA" 
label values ENT_NCOD_FINAL ent_ncod
*Variables mercado
ren FECHA PER_INIC
merge m:1 PER_INIC using variables_mercado.dta
drop _merge
*Edad y Sexo
merge m:1 DNI using "D:\3. Investigaciones\Regresion cuantilica\Data\Variables\caracteristicas_edad_sexo.dta"
drop if _merge==2
drop if _merge==1 /*287 observations deleted*/
drop _merge
label define sexo 0 "Femenino" 1 "Masculino" 
label values SEXO sexo 
*Ingresos
merge m:1 DNI using "C:\Documentos-SBS\Fatima Uriarte\Base de Datos SPP\ingresos.dta" 
drop if _merge==2
drop _merge
merge m:1 DNI using rango_ingreso_INV.dta
drop if _merge==2
replace rango_ingresos2015= 1 if rango_ingresos2015<=3
replace rango_ingresos2015= 2 if (rango_ingresos2015>3 & rango_ingresos2015<=6)
replace rango_ingresos2015= 3 if rango_ingresos2015==7
replace rango_ingresos2015= 4 if rango_ingresos2015==8
replace rango_ingresos2015= 5 if rango_ingresos2015==9
replace rango_ingresos2015= 6 if rango_ingresos2015==10
replace rango_ingresos2014= 1 if rango_ingresos2014<=3
replace rango_ingresos2014= 2 if (rango_ingresos2014>3 & rango_ingresos2014<=6)
replace rango_ingresos2014= 3 if rango_ingresos2014==7
replace rango_ingresos2014= 4 if rango_ingresos2014==8
replace rango_ingresos2014= 5 if rango_ingresos2014==9
replace rango_ingresos2014= 6 if rango_ingresos2014==10
gen RANGO_INGRESOS_FINAL=.
replace RANGO_INGRESOS_FINAL=1 if ingresos<750 & ingresos != .
replace RANGO_INGRESOS_FINAL=1 if ingresos>=750 & ingresos<1000 & ingresos != .
replace RANGO_INGRESOS_FINAL=1 if ingresos>=1000 & ingresos<1500 & ingresos != .
replace RANGO_INGRESOS_FINAL=2 if ingresos>=1500 & ingresos<2000 & ingresos != .
replace RANGO_INGRESOS_FINAL=2 if ingresos>=2000 & ingresos<2500 & ingresos != .
replace RANGO_INGRESOS_FINAL=2 if ingresos>=2500 & ingresos<3000 & ingresos != .
replace RANGO_INGRESOS_FINAL=3 if ingresos>=3000 & ingresos<5000 & ingresos != .
replace RANGO_INGRESOS_FINAL=4 if ingresos>=5000 & ingresos<8000 & ingresos != .
replace RANGO_INGRESOS_FINAL=5 if ingresos>=8000 & ingresos<12000 & ingresos != .
replace RANGO_INGRESOS_FINAL=6 if ingresos>=12000 & ingresos != .
replace RANGO_INGRESOS_FINAL=rango_ingresos2015 if RANGO_INGRESOS_FINAL==.
replace RANGO_INGRESOS_FINAL=rango_ingresos2014 if RANGO_INGRESOS_FINAL==.
drop if RANGO_INGRESOS_FINAL==. /*2 902 observations deleted*/
label def ingreso 1 "I1" 2 "I2" 3 "I3" 4 "I4" 5 "I5" 6 "I6" 
label values RANGO_INGRESOS_FINAL ingreso
*Algoritmo para identificar outliers
bacon ingresos PLAZO tea morg , generate(outliers1) percentile (0.1) replace
scatter  ingresos tea , ml( outliers1 ) ms(i) note("0 = non outlier, 1 = outlier")
drop _merge
drop if outliers1==1 /*121 observations deleted*/
*Compra de Deuda
merge m:1 DNI ENT_NCOD using "D:\3. Investigaciones\Regresion cuantilica\Data\Compra de Deuda\compra_deuda_4grandes.dta"
drop if _merge==2
replace COMPRA_DEUDA=0 if (COMPRA_DEUDA!=1 & COMPRA_DEUDA!=3)
drop if COMPRA_DEUDA==3
label def compra_deuda 0 "No" 1 "Sí" 
label values COMPRA_DEUDA compra_deuda
*Variables seleccionadas
keep DEO_COD COMPRA_DEUDA tea ENT_NCOD ano plazo_años MON morg ENT_NCOD_FINAL INDICE TASA_DESEMPLEO EDAD SEXO DNI RANGO_INGRESOS_FINAL PER_INIC TCC
ren (tea ano plazo_años morg RANGO_INGRESOS_FINAL) (TEA ANHO PLAZO_ANHO MORG RANGO_INGRESOS)
label variable EDAD "Edad" 
label variable SEXO "Sexo" 
label variable RANGO_INGRESOS "Ingresos" 
label variable MON "Moneda" 
label variable PLAZO_ANHO "Plazo"
label variable ENT_NCOD_FINAL "Entidad"
label variable INDICE "IGCD"
label variable TASA_DESEMPLEO "Tasa de desempleo"
label variable COMPRA_DEUDA "Compra de Deuda"
save base_regresion_cuantilica.dta,replace

*Deudores identificados para conseguir peor clasificación y garantía
use base_regresion_cuantilica.dta,clear
keep DNI ENT_NCOD
duplicates drop
save caracteristicas_saldos.dta, replace
keep DNI
duplicates drop
save peor_clasificacion_nuevo.dta,replace

*Obtenemos la variable garantía
foreach i in 20150131 20150228 20150331 20150430 20150531 20150630 20150731 20150831 20150930 20151031 20151130 20151231 20160131 20160229 20160331 20160430 20160531 20160630 {
	drop _all
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Data completo\prestamos_`i'.dta", clear
	*Cuentas
	generate CTA_NCOD6=trunc(CTA_NCOD/100000000)
	generate CTA_NCOD4=trunc(CTA_NCOD/10000000000)
	*Hipotecarios y Garantía
	keep if CTA_NCOD6 ==140104 | CTA_NCOD6 ==140404 | CTA_NCOD6 ==140504 | CTA_NCOD6 ==140604 | CTA_NCOD4==8404
	gen TIPO="Directa" if  CTA_NCOD4==1401 | CTA_NCOD4==1403 |CTA_NCOD4==1404 | CTA_NCOD4==1405 | CTA_NCOD4==1406
	replace TIPO="Garantía" if CTA_NCOD4==8404
	merge m:1 DEO_COD using "C:\Documentos-SBS\Fatima Uriarte\DNI Deudores\DNI_consolidado_completo.dta"
	drop if _merge==2
	collapse (sum) RCD_NSDO, by(ENT_NCOD DNI PER_NCOD DIG_NCOD TIPO)
	replace DIG_NCOD=1 if DIG_NCOD==3
	egen CATEGORIA=concat(TIPO DIG_NCOD)
	collapse (sum) RCD_NSDO, by(ENT_NCOD DNI CATEGORIA)
	reshape wide RCD_NSDO , i( DNI ENT_NCOD) j( CATEGORIA ) string
	replace RCD_NSDODirecta1=0 if RCD_NSDODirecta1==.
	replace RCD_NSDODirecta2=0 if RCD_NSDODirecta2==.
	replace RCD_NSDOGarantía1=0 if RCD_NSDOGarantía1==.
	replace RCD_NSDOGarantía2=0 if RCD_NSDOGarantía2==.
	gen GAR_`i'= RCD_NSDOGarantía1+ RCD_NSDOGarantía2
	drop RCD_NSDOGarantía1 RCD_NSDOGarantía2
	gen HIPO_`i'=RCD_NSDODirecta1+RCD_NSDODirecta2
	ren (RCD_NSDODirecta1 RCD_NSDODirecta2) (HIPO_MN_`i' HIPO_ME_`i')
	merge m:1 DNI ENT_NCOD using caracteristicas_saldos.dta
	drop if _merge==1
	drop _merge
	display `i'
	save caracteristicas_saldos.dta, replace
}
use base_regresion_cuantilica.dta,clear
keep DNI ENT_NCOD PER_INIC
merge m:1 DNI ENT_NCOD using caracteristicas_saldos.dta
drop _merge
gen MONTO_OTORGADO_RCD=.
gen GARANTIA=.
drop HIPO_MN_* HIPO_ME_*
egen GAR_FIRST=rlast(GAR_*)
egen MAX_GAR=rmax( GAR_*)
egen HIPO_FIRST=rlast(HIPO_*)
egen MAX_HIPO=rmax(HIPO_*)
*Garantia
replace GARANTIA=GAR_FIRST
replace GARANTIA=MAX_GAR if GARANTIA==0
*Monto otorgado RCD
replace MONTO_OTORGADO_RCD=HIPO_FIRST
replace MONTO_OTORGADO_RCD=MAX_HIPO if MONTO_OTORGADO_RCD==0
drop HIPO_* GAR_*
collapse (max) GARANTIA MONTO_OTORGADO_RCD , by(ENT_NCOD DNI) 
save garantia_clasificación.dta, replace
save caracteristicas_saldos_final.dta, replace

*Obtenemos la variable peor clasificación
foreach i in 20010131 20010228 20010331 20010430 20010531 20010630 20010731 20010831 20010930 20011031 20011130 20011231 20020131 20020228 20020331 20020430 20020531 20020630 20020731 20020831 20020930 20021031 20021130 20021231 20030131 20030228 20030331 20030430 20030531 20030630 20030731 20030831 20030930 20031031 20031130 20031231 20040131 20040229 20040331 20040430 20040531 20040630 20040731 20040831 20040930 20041031 20041130 20041231 20050131 20050228 20050331 20050430 20050531 20050630 20050731 20050831 20050930 20051031 20051130 20051231 20060131 20060228 20060331 20060430 20060531 20060630 20060731 20060831 20060930 20061031 20061130 20061231 20070131 20070228 20070331 20070430 20070531 20070630 20070731 20070831 20070930 20071031 20071130 20071231 20080131 20080229 20080331 20080430 20080531 20080630 20080731 20080831 20080930 20081031 20081130 20081231 20090131 20090228 20090331 20090430 20090531 20090630 20090731 20090831 20090930 20091031 20091130 20091231 20100131 20100228 20100331 20100430 20100531 20100630 20100731 20100831 20100930 20101031 20101130 20101231 20110131 20110228 20110331 20110430 20110531 20110630 20110731 20110831 20110930 20111031 20111130 20111231 20120131 20120229 20120331 20120430 20120531 20120630 20120731 20120831 20120930 20121031 20121130 20121231 20130131 20130228 20130331 20130430 20130531 20130630 20130731 20130831 20130930 20131031 20131130 20131231 20140131 20140228 20140331 20140430 20140531 20140630 20140731 20140831 20140930 20141031 20141130 20141231{
	use "C:\Documentos-SBS\Fatima Uriarte\Data completo\prestamos_`i'.dta" 
	set more off
	merge m:1 DEO_COD using "C:\Documentos-SBS\Fatima Uriarte\DNI Deudores\DNI_consolidado_completo.dta"
	drop if _merge==2
	generate CTA_NCOD4=trunc(CTA_NCOD/10000000000)
	keep if (CTA_NCOD4 >=1401 & CTA_NCOD4<=1406) 
	replace CLA_NCOD=0 if CLA_NCOD==8
	collapse (max) CLA_NCOD, by(DNI)
	ren CLA_NCOD CLA_NCOD_`i'
	merge 1:1 DNI using peor_clasificacion_nuevo.dta
	drop if _merge==1
	drop _merge
	display `i'
	save peor_clasificacion_nuevo.dta, replace
}


use base_regresion_cuantilica.dta,clear
merge m:1 DNI ENT_NCOD using garantia_clasificación.dta
drop if _merge==2
drop _merge
*Ajuste errores en el monto otorgado
replace MORG= MONTO_OTORGADO_RCD if (MONTO_OTORGADO_RCD>MORG & MONTO_OTORGADO_RCD!=.)
gen morg_dolares=(MORG/TCC)/1000
ren morg_dolares MONTO_OTORGADO 
label variable MONTO_OTORGADO "Monto otorgado"
*LTV
gen LTV=(MORG/GARANTIA)*100
gen LTV_FINAL=0 if (LTV==. | LTV>100)
replace LTV_FINAL=1 if  (LTV>80 & LTV<=100)
replace LTV_FINAL=2 if (LTV>60 & LTV<=80)
replace LTV_FINAL=3 if (LTV>0 & LTV<=60)
label define ltv 0 "Sin garantía o LTV>100%" 1"<80%,100%]" 2 "<60%,80%]" 3 "<0%,60%]" 
label values LTV_FINAL ltv
label variable LTV_FINAL "LTV" 
*Peor clasificacion
merge m:1 DNI using peor_clasificacion_nuevo.dta
foreach i in 20010131 20010228 20010331 20010430 20010531 20010630 20010731 20010831 20010930 20011031 20011130 20011231 20020131 20020228 20020331 20020430 20020531 20020630 20020731 20020831 20020930 20021031 20021130 20021231 20030131 20030228 20030331 20030430 20030531 20030630 20030731 20030831 20030930 20031031 20031130 20031231 20040131 20040229 20040331 20040430 20040531 20040630 20040731 20040831 20040930 20041031 20041130 20041231 20050131 20050228 20050331 20050430 20050531 20050630 20050731 20050831 20050930 20051031 20051130 20051231 20060131 20060228 20060331 20060430 20060531 20060630 20060731 20060831 20060930 20061031 20061130 20061231 20070131 20070228 20070331 20070430 20070531 20070630 20070731 20070831 20070930 20071031 20071130 20071231 20080131 20080229 20080331 20080430 20080531 20080630 20080731 20080831 20080930 20081031 20081130 20081231 20090131 20090228 20090331 20090430 20090531 20090630 20090731 20090831 20090930 20091031 20091130 20091231 20100131 20100228 20100331 20100430 20100531 20100630 20100731 20100831 20100930 20101031 20101130 20101231 20110131 20110228 20110331 20110430 20110531 20110630 20110731 20110831 20110930 20111031 20111130 20111231 20120131 20120229 20120331 20120430 20120531 20120630 20120731 20120831 20120930 20121031 20121130 20121231 20130131 20130228 20130331 20130430 20130531 20130630 20130731 20130831 20130930 20131031 20131130 20131231 20140131 20140228 20140331 20140430 20140531 20140630 20140731 20140831 20140930 20141031 20141130 20141231{
	replace CLA_NCOD_`i'=1 if CLA_NCOD_`i'!=0 & CLA_NCOD_`i'!=. 
}
egen NUM_CLA=rownonmiss(CLA_NCOD_*)
egen MAL_CLA= rowtotal(CLA_NCOD_*)
gen HIST_CRED1= (NUM_CLA- MAL_CLA)/ NUM_CLA*100
gen HIST_CRED=0 if HIST_CRED1==.
replace HIST_CRED=1 if (HIST_CRED1<80 & HIST_CRED1!=.)
replace HIST_CRED=2 if (HIST_CRED1>=80 & HIST_CRED1<90 & HIST_CRED1!=.)
replace HIST_CRED=3 if (HIST_CRED1>=90 & HIST_CRED1<100 & HIST_CRED1!=.)
replace HIST_CRED=4 if (HIST_CRED1==100 & HIST_CRED1!=.)
label def hist_cred 0 "Sin Historial" 1 "<80%" 2 "[80%,90%>"  3 "[90%,100%>"  4 "=100%" 
label values HIST_CRED hist_cred
label variable HIST_CRED "Historial Crediticio" 
drop CLA_NCOD_* _merge HIST_CRED1
save base_regresion_cuantilica1.dta,replace

use base_regresion_cuantilica1.dta,clear
keep DNI 
duplicates drop
save prestamos_muestra.dta, replace

*Obtenemos la variable garantía
foreach i in 20150131 20150228 20150331 20150430 20150531 20150630 20150731 20150831 20150930 20151031 20151130 20151231 20160131 20160229 20160331 20160430 20160531 20160630  {
	drop _all
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Data completo\prestamos_`i'.dta", clear
	generate int CTA_NCOD4=int(CTA_NCOD/10000000000)
	keep if TCR_NCOD==23
	keep if CTA_NCOD4==1401 | CTA_NCOD4==1403 |CTA_NCOD4==1404 | CTA_NCOD4==1405 | CTA_NCOD4==1406  
	merge m:1 DEO_COD using "C:\Documentos-SBS\Fatima Uriarte\DNI Deudores\DNI_consolidado_completo.dta"
	drop if _merge==2
	*Modalidad
	gen modalidad="prestamo hipotecario" if (CTA_NCOD ==14010406010000 | CTA_NCOD ==14010406020000  |CTA_NCOD ==14040406010000 |CTA_NCOD ==14040406020000  | CTA_NCOD ==14050406010000 |CTA_NCOD ==14050406020000  |  CTA_NCOD ==14060406010000 | CTA_NCOD ==14060406020000 | CTA_NCOD ==14050419060000 | CTA_NCOD ==14060419060000)
	replace modalidad="mi vivienda" if (CTA_NCOD ==14010423000000 | CTA_NCOD ==14010424000000  |CTA_NCOD ==14010425000000 |CTA_NCOD ==14040423000000  | CTA_NCOD ==14040424000000 |CTA_NCOD ==14040425000000  |  CTA_NCOD ==14050419230000 | CTA_NCOD ==14050419240000 | CTA_NCOD ==14050419250000 | CTA_NCOD ==14050423000000 |  CTA_NCOD ==14050424000000 | CTA_NCOD ==14050425000000 | CTA_NCOD ==14060419230000 | CTA_NCOD ==14060419240000 |  CTA_NCOD ==14060419250000 | CTA_NCOD ==14060423000000 | CTA_NCOD ==14060424000000 | CTA_NCOD == 14060425000000)
	replace modalidad="prestamo hipotecario" if modalidad==""
	collapse (sum) RCD_NSDO, by( modalidad DNI PER_NCOD)
	gsort DNI -RCD_NSDO
	duplicates drop DNI, force
	ren modalidad modalidad_`i'
	drop PER_NCOD RCD_NSDO
	merge 1:1 DNI using prestamos_muestra.dta
	drop if _merge==1
	drop _merge
	save prestamos_muestra.dta, replace
}
