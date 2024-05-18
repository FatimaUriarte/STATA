use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos_FINAL.dta", clear
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\creditos.dta", replace
*BASE DE DATOS - SEGUIMIENTO SALDOS DE CRÉDITO
foreach i in 20100131 20100228 20100331 20100430 20100531 20100630 20100731 20100831 20100930 20101031 20101130 20101231 20110131 20110228 20110331 20110430 20110531 20110630 20110731 20110831 20110930 20111031 20111130 20111231 20120131 20120229 20120331 20120430 20120531 20120630 20120731 20120831 20120930 20121031 20121130 20121231 20130131 20130228 20130331 20130430 20130531 20130630 20130731 20130831 20130930 20131031 20131130 20131231 20140131 20140228 20140331 20140430 20140531 20140630 20140731 20140831 20140930 20141031 20141130 20141231{
	set more off  
	use "C:\Documentos-SBS\Fatima Uriarte\Informe de Mercado No revolventes\prestamosLD_`i'.dta", clear
	collapse (sum) RCD_NSDO, by ( DEO_COD ENT_NCOD)
	tostring DEO_COD ENT_NCOD , replace
	egen DEO_ENT = concat ( DEO_COD ENT_NCOD ), punct(-)
	drop DEO_COD ENT_NCOD
	merge m:m DEO_ENT using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\creditos.dta"
	drop if _merge==1
	drop _merge
	ren RCD_NSDO RCD_NSDO_`i'
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\creditos.dta", replace
	}
*GENERAMOS FECHA DE SALIDA DEL SISTEMA FINANCIERO
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\creditos.dta", clear
gen salidaSF1=""	
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\salidaSF.dta", replace
foreach i in 20141231 20141130 20141031 20140930 20140831 20140731 20140630 20140531 20140430 20140331 20140228 20140131  20131231 20131130 20131031 20130930 20130831 20130731 20130630 20130531 20130430 20130331 20130228  20130131  20121231 20121130 20121031 20120930 20120831 20120731 20120630 20120531 20120430 20120331 20120229 20120131 20111231 20111130 20111031 20110930 20110831 20110731 20110630 20110531 20110430 20110331 20110228 20110131 20101231 20101130 20101031 20101231 20101130 20101031 20100930 20100831 20100731 20100630 20100531 20100430 20100331 20100228 20100131{
	use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\salidaSF.dta", clear 
	set more off
	replace salidaSF1="`i'" if (RCD_NSDO_`i'< . & salidaSF1=="")
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\salidaSF.dta", replace 
}		
keep DEO_ENT salidaSF1
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\salidaSF.dta", replace 
*BASE DE DATOS - SEGUIMIENTO DE CLASIFICACIONES
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\DataNuevos_FINAL.dta", clear
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\clasificaciones.dta", replace
foreach i in 20100131 20100228 20100331 20100430 20100531 20100630 20100731 20100831 20100930 20101031 20101130 20101231 20110131 20110228 20110331 20110430 20110531 20110630 20110731 20110831 20110930 20111031 20111130 20111231 20120131 20120229 20120331 20120430 20120531 20120630 20120731 20120831 20120930 20121031 20121130 20121231 20130131 20130228 20130331 20130430 20130531 20130630 20130731 20130831 20130930 20131031 20131130 20131231 20140131 20140228 20140331 20140430 20140531 20140630 20140731 20140831 20140930 20141031 20141130 20141231{
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\clasificaciones.dta", clear
	merge m:m DEO_ENT using "D:\PD\PD_`i'.dta"
	drop if _merge==2
	drop _merge
	replace CLA_NCOD=0 if CLA_NCOD==8
	ren CLA_NCOD CLA_`i'
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\clasificaciones.dta", replace
	}
*GENERAMOS FECHA DE INCUMPLIMIENTO
gen incumplio1=""	
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\clasificaciones.dta", replace
foreach i in 20100131 20100228 20100331 20100430 20100531 20100630 20100731 20100831 20100930 20101031 20101130 20101231 20110131 20110228 20110331 20110430 20110531 20110630 20110731 20110831 20110930 20111031 20111130 20111231 20120131 20120229 20120331 20120430 20120531 20120630 20120731 20120831 20120930 20121031 20121130 20121231 20130131 20130228 20130331 20130430 20130531 20130630 20130731 20130831 20130930 20131031 20131130 20131231 20140131 20140228 20140331 20140430 20140531 20140630 20140731 20140831 20140930 20141031 20141130 20141231 {
	set more off
	use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\clasificaciones.dta", clear 
	replace incumplio1="`i'" if ((CLA_`i'==3 | CLA_`i'==4) & incumplio1=="")
	save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\clasificaciones.dta", replace 
}
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\clasificaciones.dta", replace 
merge m:m DEO_ENT using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\salidaSF.dta"
tab _merge
duplicates drop
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia.dta", replace 
************************************************************************************************************************************************************************************************************************
*GENERAMOS BASE DE SUPERVIVENCIA
************************************************************************************************************************************************************************************************************************
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia.dta", clear
set more off
drop CLA_* _merge
duplicates drop
collapse (first) ENT_NCOD DEO_COD RCD_NSDO DEU_CSEX edad sexo DNI REM_FINAL EXPERIENCIA incumplio1 salidaSF1, by( DEO_ENT PER_NCOD)
*Eliminamos duplicados
duplicates tag DEO_ENT , generate(dup)
drop if dup>0 /*se eliminan 12 observaciones que se encuentran duplicadas*/
drop dup
*Centiles de ingreso
centile REM_FINAL, centile(1(1)99)
gen CENTIL_REM=.
foreach num of numlist 1/99 {
        replace CENTIL_REM=`num' if REM_FINAL>r(c_`num')
}
replace CENTIL_REM=1 if CENTIL_REM>=.
ren PER_NCOD ingreso /*fecha de bancarización*/
*Centiles de saldo inicial
centile RCD_NSDO, centile(1(1)99)
gen CENTIL_SALDO=.
foreach aaa of numlist 1/99 {
        replace CENTIL_SALDO=`aaa' if RCD_NSDO>r(c_`aaa')
}
replace CENTIL_SALDO=1 if CENTIL_SALDO>=.
*Generamos las variables tiempo de falla y censura
destring salidaSF1, replace
destring incumplio1, replace
replace salidaSF =trunc(salidaSF1/100)
replace incumplio=trunc(incumplio1 /100)
ren (incumplio1 salidaSF1) (incumplio salidaSF)
generate sal_incump= incumplio if (incumplio < .)
replace sal_incump= salidaSF if (sal_incump >=.)
generate S_ingreso=string(int(ingreso /100))+"m"+string(ingreso -int(ingreso/100)*100)
generate S_sal_incump=string(int(sal_incump /100))+"m"+string(sal_incump -int(sal_incump/100)*100)
generate tf = monthly( S_sal_incump ,"YM")-monthly( S_ingreso ,"YM")
gen incump=0
replace incump=1 if incumplio<.
*Algoritmo para identificar outliers
bacon RCD_NSDO CENTIL_REM edad , generate(outliers1) percentile (0.005) replace
scatter  RCD_NSDO CENTIL_REM , ml( outliers1 ) ms(i) note("0 = non outlier, 1 = outlier")
drop if outliers1==1
scatter  RCD_NSDO CENTIL_REM , ml( outliers1 ) ms(i) note("0 = non outlier, 1 = outlier")
drop outliers1 /* 253 observaciones eliminadas*/
*Genramos formato requerido de stata para realizar análisis de supervivencia
expand 60
sort DEO_ENT
by DEO_ENT: gen aaa=_n
gen bbb=tf-aaa
drop if bbb<-1
gen ano=.
replace ano=ingreso if DEO_ENT!= DEO_ENT[_n-1]
replace ano=(ano[_n-1]+1) if DEO_ENT==DEO_ENT[_n-1]
*Iniciados en el año 2010
replace ano=201101 if ano==201013
replace ano=201102 if ano==201014
replace ano=201103 if ano==201015
replace ano=201104 if ano==201016
replace ano=201105 if ano==201017
replace ano=201106 if ano==201018
replace ano=201107 if ano==201019
replace ano=201108 if ano==201020
replace ano=201109 if ano==201021
replace ano=201110 if ano==201022
replace ano=201111 if ano==201023
replace ano=201112 if ano==201024
replace ano=201201 if ano==201025
replace ano=201202 if ano==201026
replace ano=201203 if ano==201027
replace ano=201204 if ano==201028
replace ano=201205 if ano==201029
replace ano=201206 if ano==201030
replace ano=201207 if ano==201031
replace ano=201208 if ano==201032
replace ano=201209 if ano==201033
replace ano=201210 if ano==201034
replace ano=201211 if ano==201035
replace ano=201212 if ano==201036
replace ano=201301 if ano==201037
replace ano=201302 if ano==201038
replace ano=201303 if ano==201039
replace ano=201304 if ano==201040
replace ano=201305 if ano==201041
replace ano=201306 if ano==201042
replace ano=201307 if ano==201043
replace ano=201308 if ano==201044
replace ano=201309 if ano==201045
replace ano=201310 if ano==201046
replace ano=201311 if ano==201047
replace ano=201312 if ano==201048
replace ano=201401 if ano==201049
replace ano=201402 if ano==201050
replace ano=201403 if ano==201051
replace ano=201404 if ano==201052
replace ano=201405 if ano==201053
replace ano=201406 if ano==201054
replace ano=201407 if ano==201055
replace ano=201408 if ano==201056
replace ano=201409 if ano==201057
replace ano=201410 if ano==201058
replace ano=201411 if ano==201059
replace ano=201412 if ano==201060
*Iniciados en el año 2011
replace ano=201201 if ano==201113
replace ano=201202 if ano==201114
replace ano=201203 if ano==201115
replace ano=201204 if ano==201116
replace ano=201205 if ano==201117
replace ano=201206 if ano==201118
replace ano=201207 if ano==201119
replace ano=201208 if ano==201120
replace ano=201209 if ano==201121
replace ano=201210 if ano==201122
replace ano=201211 if ano==201123
replace ano=201212 if ano==201124
replace ano=201301 if ano==201125
replace ano=201302 if ano==201126
replace ano=201303 if ano==201127
replace ano=201304 if ano==201128
replace ano=201305 if ano==201129
replace ano=201306 if ano==201130
replace ano=201307 if ano==201131
replace ano=201308 if ano==201132
replace ano=201309 if ano==201133
replace ano=201310 if ano==201134
replace ano=201311 if ano==201135
replace ano=201312 if ano==201136
replace ano=201401 if ano==201137
replace ano=201402 if ano==201138
replace ano=201403 if ano==201139
replace ano=201404 if ano==201140
replace ano=201405 if ano==201141
replace ano=201406 if ano==201142
replace ano=201407 if ano==201143
replace ano=201408 if ano==201144
replace ano=201409 if ano==201145
replace ano=201410 if ano==201146
replace ano=201411 if ano==201147
replace ano=201412 if ano==201148
*Iniciados en el año 2012
replace ano=201301 if ano==201213
replace ano=201302 if ano==201214
replace ano=201303 if ano==201215
replace ano=201304 if ano==201216
replace ano=201305 if ano==201217
replace ano=201306 if ano==201218
replace ano=201307 if ano==201219
replace ano=201308 if ano==201220
replace ano=201309 if ano==201221
replace ano=201310 if ano==201222
replace ano=201311 if ano==201223
replace ano=201312 if ano==201224
replace ano=201401 if ano==201225
replace ano=201402 if ano==201226
replace ano=201403 if ano==201227
replace ano=201404 if ano==201228
replace ano=201405 if ano==201229
replace ano=201406 if ano==201230
replace ano=201407 if ano==201231
replace ano=201408 if ano==201232
replace ano=201409 if ano==201233
replace ano=201410 if ano==201234
replace ano=201411 if ano==201235
replace ano=201412 if ano==201236
*Iniciados en el año 2013
replace ano=201401 if ano==201313
replace ano=201402 if ano==201314
replace ano=201403 if ano==201315
replace ano=201404 if ano==201316
replace ano=201405 if ano==201317
replace ano=201406 if ano==201318
replace ano=201407 if ano==201319
replace ano=201408 if ano==201320
replace ano=201409 if ano==201321
replace ano=201410 if ano==201322
replace ano=201411 if ano==201323
replace ano=201412 if ano==201324
*Generamos fecha en cada mes
generate S_ano=string(int(ano /100))+"m"+string(ano -int(ano/100)*100)
ren tf tf1
by DEO_ENT: gen tf=_n
*Juntamos con base de datos de variables macroeconómicas
merge m:1 ano using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\datos_macro.dta"
keep if _merge==3
sort DEO_ENT tf
gen zzz=tf1-tf
gen incumplio_final=0 if zzz!=-1
replace incumplio_final=incump if zzz==-1
drop sal_incump S_ingreso S_sal_incump tf1 aaa bbb S_ano zzz _merge
merge 1:1 DEO_ENT ano using  "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\SEGUIMIENTO_SALDO_PNRLD.dta"
drop if _merge==2
drop _merge
merge m:1 ENT_NCOD using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\CLUSTER.dta"
drop if _merge==2
replace SALDO_PNRLD=0 if SALDO_PNRLD>=.
drop _merge
merge m:m ENT_NCOD ano using "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\TEA_PNRLD.dta"
drop if _merge==2
drop _merge
gen CLUSTER_OK=1 if CLUSTER==2
replace CLUSTER_OK=2 if CLUSTER==1
replace CLUSTER_OK=3 if CLUSTER==3
replace CLUSTER_OK=4 if CLUSTER==4
replace CLUSTER_OK=5 if CLUSTER==5
save "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia_stata.dta", replace
