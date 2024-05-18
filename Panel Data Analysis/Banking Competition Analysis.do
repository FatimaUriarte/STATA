clear
cd "K:\DAIM\Plan Estratégico\2015\Competencia\Datos\Base Stata"
use BaseFinalCompetencia
xtset entcod tiempo
******************* COSTO MARGINAL
*Test de Hausman
set more off
xtreg lcost lw1 lw2 lw3 lw4 lcr lw11 lw22 lw33 lw44 lcr2 lw12 lw13 lw14 lw23 lw24 lw34 lw1cr lw2cr lw3cr lw4cr ltend ltend2 Dconsumo, fe
estimates store fe
xtreg lcost lw1 lw2 lw3 lw4 lcr lw11 lw22 lw33 lw44 lcr2 lw12 lw13 lw14 lw23 lw24 lw34 lw1cr lw2cr lw3cr lw4cr ltend ltend2 Dconsumo, re
estimates store re
hausman fe re, sigmamore

set more off
*MCO con dummies (Efectos Fijos) con restricciones:
constraint define 1 _b[lw1]+_b[lw2]+_b[lw3]+_b[lw4]=1 //Precios de los factores
constraint define 2 _b[lw1cr]+_b[lw2cr]+_b[lw3cr]+_b[lw4cr]=0 //Iteracciones entre los precios de los factores
constraint define 3 _b[lw11]*2+_b[lw22]*2+_b[lw33]*2+_b[lw44]*2+_b[lw12]+_b[lw13]+_b[lw14]+_b[lw23]+_b[lw24]+_b[lw34]=0
xi: cnsreg lcost lw1 lw2 lw3 lw4 lcr lw11 lw22 lw33 lw44 lcr2 lw12 lw13 lw14 lw23 lw24 lw34 lw1cr lw2cr lw3cr lw4cr ltend ltend2 Dconsumo i.entcod, constr(1-3) robust
estimates store cmg
estimates table cmg, star stats(N r2 r2_a) drop (_Ientcod*)
*Genera R2 para tabla:
predict lcostp if e(sample) 
corr lcost lcostp if e(sample) 
di r(rho)^2
drop _Ientcod*
drop _est* lcostp 
*Costo marginal: capa y todas
gen cmg= (costb/cred)*(1.0701471-.00583545*lcr*2-.01902628*lw1+.020439*lw2-0.00004157*lw3-0.00137114*lw4)
*gen cmg= (costb/cred)*(1.0538991-.00513941*lcr*2-.01837802*lw1+.02565939*lw2-0.00835683*lw3+0.00107547*lw4)
sum cmg

*Mediante un panel balanceado, previo a cada estimación se verifica poolability (Breusch Pagan), autocorrelación (Baltagi Li) y correlación entre paneles (Breusch Pagan). En el panel no balanceado se verifica heterocedasticidad (Wald modificado) 

*******************  Indicadores generales ******************* 

***Lerner
gen tiacmg=tia/100 //En %, en las mismas unidades que el cmg
gen lerner=(tiacmg-cmg)/tiacmg
sum lerner
gen lcmg=ln(cmg)

*Capa y Tiib ya son estacionarias
*Tc tomar 1° dif
gen d1ltc=ltc-ltc[_n-1] 
save BaseFinalCompetencia, replace

*Pruebas a los paneles (panel balanceado):
use BaseFinalCompetencia, clear
set more off
xtset entcod tiempo
xtdescribe 
drop tiempo
ren tendencia_mens tiempo
xtset entcod tiempo
*Solo entidades que han estado durante todo el periodo:
set more off
keep if entcod==2 | entcod==55 | entcod==72 | entcod==73 | entcod==82 | entcod==101 | entcod==102 | entcod==103 | entcod==104 | entcod==106 | entcod==107 | entcod==108 | entcod==109 | entcod==110 | entcod==111 | entcod==112 | entcod==114 | entcod==123 | entcod==142 | entcod==143 | entcod==156 | entcod==157 | entcod==162 | entcod==164 | entcod==169 | entcod==170 | entcod==227 | entcod==228 | entcod==230 | entcod==231 | entcod==232 | entcod==234 | entcod==235 | entcod==236 | entcod==237 | entcod==238
hotdeck costb laba clab tip capa capc prov cred roa tia capact part activos cmg lerner, store imput(1) by (entcod) keep (entcod tiempo)
drop costb laba clab tip capa capc prov cred roa tia capact part activos cmg l*
merge m:m entcod tiempo using imp1
drop if _m!=3
drop _m
gen lw1=ln(clab)
gen lw2=ln(tip)
gen lw3=ln(capa) // Ojo
gen lw4=ln(prov)
gen lcr=ln(cred)
gen lroa=ln(roa+45) //Traslación
gen ltia=ln(tia)
gen lpart=ln(part)
gen lcapact=ln(capact)
gen ltc=ln(tc)
gen ltiib=ln(tiib)
gen lpbi=ln(pbi)
gen lipc=ln(ipc)
gen lact=ln(activos)
gen ltend=ln(tiempo)
gen ltend2=ltend*ltend
gen lcmg=ln(cmg)
gen lpart_sibn=ln(part_sibn)
save BaseCompetenciaBalanceado, replace

***Panzar y Roose
cls
* 1. Equilibrio de largo plazo:
use BaseCompetenciaBalanceado, clear
set more off
xtreg lroa lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, re robust
xttest1
*xtreg lroa lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, fe
*xttest2
use BaseFinalCompetencia, clear
xtset entcod tiempo
set more off
xtreg lroa lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, fe
xttest3
*Test de Hausman
set more off
xtreg lroa lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, fe
estimates store fe
xtreg lroa lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, re
estimates store re
hausman fe re
*----- Problemas: autocorrelación y heterocedasticidad, no es posible analizar correlación entre paneles
use BaseFinalCompetencia, clear
xtset entcod tiempo
set more off
*Efectos fijos:
xtscc lroa lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, fe
estimates store pyr
estimates table pyr, star stats(N r2 r2_a)
predict lroap if e(sample) 
corr lroa lroap if e(sample) 
di r(rho)^2
drop lroap
test (_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]=0) //p-val>0.05 no rech --> Si se cumple
outreg2 using pyrtotal.xls, e(r2_w)

* 2. Estimación de competencia :
cls
use BaseCompetenciaBalanceado, clear
xtset entcod tiempo
set more off
xtreg ltia lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, re robust
xttest1
*xtreg ltia lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, fe
*xttest2
use BaseFinalCompetencia, clear
xtset entcod tiempo
set more off
xtreg ltia lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, fe
xttest3
*Test de Hausman
set more off
xtreg ltia lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, fe
estimates store fe
xtreg ltia lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, re
estimates store re
hausman fe re

use BaseFinalCompetencia, clear
xtset entcod tiempo
set more off
*Base solo IMF:
*keep if imf==1
*Replica EF: http://www.stata.com/statalist/archive/2012-01/msg00940.html
xtscc ltia lw1 lw2 lw3 lw4 d1ltc ltiib lcapact, fe
estimates store pyr
estimates table pyr, star stats(N r2 r2_a)
predict ltiap if e(sample) 
corr ltia ltiap if e(sample) 
di r(rho)^2
drop ltiap
outreg2 using pyrtotal.xls, e(r2_w)

cls
***t
*Monopolio:
test (_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]=0)
local sign_k2 = sign(_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4])
display "Ho: coef <= 0  p-value = " ttail(r(df_r),`sign_k2'*sqrt(r(F)))
*Competencia Monopolística:
test (_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]=0.5)
*menor
local sign_k2 = sign(_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]-0.5)
display "Ho: coef <= 0.5  p-value = " ttail(r(df_r),`sign_k2'*sqrt(r(F)))
*mayor
local sign_k2 = sign(_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]-0.5)
display "Ho: coef >= 0.5  p-value = " 1-ttail(r(df_r),`sign_k2'*sqrt(r(F)))
*Competencia perfecta:
test (_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]=1)
local sign_k2 = sign(_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]-1)
display "Ho: coef >= 1  p-value = " 1-ttail(r(df_r),`sign_k2'*sqrt(r(F)))

***Z
*Monopolio:
test (_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]=0)
local sign_k2 = sign(_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4])
display "Ho: coef <= 0  p-value = " 1-normal(`sign_k2'*sqrt(r(chi2)))
*Competencia Monopolística:
test (_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]=0.5)
*menor
local sign_k2 = sign(_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]-0.5)
display "Ho: coef <= 0.5  p-value = " 1-normal(`sign_k2'*sqrt(r(chi2)))
*mayor
local sign_k2 = sign(_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]-0.5)
display "Ho: coef >= 0.5  p-value = " normal(`sign_k2'*sqrt(r(chi2)))
*Competencia perfecta:
test (_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]=1)
local sign_k2 = sign(_b[lw1] +_b[lw2] +_b[lw3]+_b[lw4]-1)
display "Ho: coef >= 1  p-value = " normal(`sign_k2'*sqrt(r(chi2)))

***Boone
cls
use BaseCompetenciaBalanceado, clear
xtset entcod tiempo
set more off
xtreg lpart lcmg, re robust
xttest1
*xtreg lpart_sibn lcmg, fe
*xttest2
use BaseFinalCompetencia, clear
xtset entcod tiempo
set more off
xtreg lpart lcmg, fe
xttest3
*Test de Hausman
set more off
xtreg lpart lcmg, fe
estimates store fe
xtreg lpart lcmg, re
estimates store re
hausman fe re

use BaseFinalCompetencia, clear
xtset entcod tiempo
set more off
xtscc lpart lcmg, fe
estimates store estimacion
estimates table estimacion, star stats(N r2 r2_a)
predict lpartp if e(sample) 
corr lpart lpartp if e(sample) 
di r(rho)^2
drop lpartp 

******************* Evolución de los Indicadores:
**P&R:
cls
use BaseFinalCompetencia, clear
xtset entcod tiempo
set more off 
*Dummies trimestrales:
forvalues i = 2(1)16{
if `i'<=9 {
forvalues j = 1(1)4{
gen d_200`i'`j'=0
}
replace d_200`i'1=1 if (mes<=3 & anio==200`i')
replace d_200`i'2=1 if (mes>=4 & mes<=6 & anio==200`i')
replace d_200`i'3=1 if (mes>=7 & mes<=9 & anio==200`i')
replace d_200`i'4=1 if (mes>=10 & anio==200`i')
}
if `i'>=10 {
forvalues j = 1(1)4{
gen d_20`i'`j'=0
}
replace d_20`i'1=1 if (mes<=3 & anio==20`i')
replace d_20`i'2=1 if (mes>=4 & mes<=6 & anio==20`i')
replace d_20`i'3=1 if (mes>=7 & mes<=9 & anio==20`i')
replace d_20`i'4=1 if (mes>=10 & anio==20`i')
}
}

set more off
forvalues i = 2(1)16{
forvalues j = 1(1)4{
if `i'<=9 {
gen lw1_`i'`j'=lw1*d_200`i'`j'
gen lw2_`i'`j'=lw2*d_200`i'`j'
gen lw3_`i'`j'=lw3*d_200`i'`j'
gen lw4_`i'`j'=lw4*d_200`i'`j'
}
if `i'>=10 {
gen lw1_`i'`j'=lw1*d_20`i'`j'
gen lw2_`i'`j'=lw2*d_20`i'`j'
gen lw3_`i'`j'=lw3*d_20`i'`j'
gen lw4_`i'`j'=lw4*d_20`i'`j'
}
}
}
set more off
gen d1lpbi=lpbi-lpbi[_n-1] 
xtscc ltia lw1_* lw2_* lw3_* lw4_* d1ltc ltiib lcapact, fe
outreg2 using pyr.xls, e(r2_w)
predict ltiap if e(sample) 
corr ltia ltiap if e(sample) 
di r(rho)^2
drop ltiap 

**Boone:
set more off
forvalues i = 2(1)16{
forvalues j = 1(1)4{
if `i'<=9 {
gen lcmg_`i'`j'=lcmg*d_200`i'`j'
}
if `i'>=10 {
gen lcmg_`i'`j'=lcmg*d_20`i'`j'
}
}
}

set more off
xtscc lpart lcmg_*, fe
outreg2 using boone.xls, e(r2_w)
set more off
predict lpartp if e(sample) 
corr lpart lpartp if e(sample) 
di r(rho)^2
drop lpartp 

**Lerner promedio
use BaseFinalCompetencia, clear
xtset entcod tiempo
*keep if mes==3 | mes==6 | mes==9 | mes==12
gen lernermcdo0=lerner*activos
collapse (sum) activos lernermcdo0, by (tiempo)
gen lernermcdo=lernermcdo0/activos
format %16.0g activos lernermcdo0
edit //Pegar en excel "Competencia"

*** Juntar con competencia: Solo P&R y Boone, jalar Lerner Individual
clear
cd "K:\DAIM\Plan Estratégico\2015\Competencia\Datos\Base Stata"
import excel Competencia.xlsx, sheet("Competencia") firstrow
merge m:m tiempo using BaseFinalEstabilidad
drop if _m!=3
drop _m
*Base solo IMF:
keep if imf==1
drop pyr2 boone2 d1lpbi d1lipc
gen pyr2=pyr*pyr
gen boone2=boone*boone
sum pyr boone
/*Pbi e ipc son estacionarias con la 1° diferencia
gen d1lpbi=lpbi-lpbi[_n-1]
gen d1lipc=lipc-lipc[_n-1]*/
save BaseFinalEstabilidad, replace

*++++++++++++++++ COMPETENCIA Y ESTABILIDAD
*Pruebas a los paneles (panel balanceado):
use BaseFinalEstabilidad, clear
set more off
keep if entcod==104 | 	entcod==106 | 	entcod==111 | 	entcod==107 | 	entcod==108 | 	entcod==109 | 	entcod==110 | 	entcod==103 | 	entcod==101 | 	entcod==114 | 	entcod==112 | 	entcod==102 | 	entcod==164 | 	entcod==156 | 	entcod==162 | 	entcod==157 | 	entcod==169 | 	entcod==170 | 	entcod==238 | 	entcod==237 | 	entcod==236 | 	entcod==235 | 	entcod==232 | 	entcod==234 | 	entcod==123 | 	entcod==228 | 	entcod==231 | 	entcod==227 | 	entcod==230 | 	entcod==72 | 	entcod==73 | 	entcod==82 | 	entcod==142 | 	entcod==143
set more off
drop tiempo
ren tendencia tiempo
hotdeck z1 z2 z3 z4 z5 activos retail mor fondeo eficiencia pyr boone, store imput(1) by (entcod) keep (entcod tiempo)
drop z1 z2 z3 z4 z5 activos retail mor fondeo eficiencia pyr boone pyr2 boone2 lact
merge m:m entcod tiempo using imp1
drop if _m!=3
drop _m
gen lact=ln(activos)
gen lret=ln(retail)
gen lrcred=ln(mor)
gen lrliq=ln(liquidez)
gen lfond=ln(fondeo)
gen lefic=ln(eficiencia)
gen pyr2=pyr*pyr
gen boone2=boone*boone
save BaseEstabilidadBalanceado, replace

/*clear
cd "K:\DAIM\Plan Estratégico\2015\Competencia\Datos\Base Stata"
use BaseFinalEstabilidad, clear
merge m:m entcod using TipoEntidades
drop if _m!=3
drop _m
gen dcm=0
replace dcm=1 if tipoentidad=="CM"
save BaseFinalEstabilidad, replace
*/

cls
use BaseEstabilidadBalanceado, clear
xtset entcod tiempo
foreach i in pyr boone{
set more off
keep if imf==1
xtreg z1 `i' `i'2 lact retail mor liquidez fondeo eficiencia d1lpbi d1lipc, re robust
display "`i'1"
xttest1
xtreg z1 `i' `i'2 lact retail mor liquidez fondeo eficiencia d1lpbi d1lipc, fe
display "`i'2"
xttest2
use BaseFinalEstabilidad, clear
xtset entcod tiempo
set more off
xtreg z1 `i' `i'2 lact retail mor liquidez fondeo eficiencia d1lpbi d1lipc, fe
display "`i'3"
xttest3
use BaseEstabilidadBalanceado, clear
xtset entcod tiempo
}

*Hausman
cls
set more off
use BaseFinalEstabilidad, clear
xtset entcod tiempo
forvalues j = 1(1)5{
foreach i in pyr boone{
xtreg z`j' `i' `i'2 lact mype mor liquidez fondeo eficiencia d1lpbi d1lipc, fe
estimates store fe
xtreg z`j' `i' `i'2 lact mype mor liquidez fondeo eficiencia d1lpbi d1lipc, re
estimates store re
display "`i'-`j'"
hausman fe re //, sigmamore : para pyr5 y boone5
use BaseFinalEstabilidad, clear
xtset entcod tiempo
}
}

*Estimaciones:
cls
use BaseFinalEstabilidad, clear
xtset entcod tiempo
set more off
forvalues j = 1(1)5{
foreach i in pyr boone{
xtscc z`j' `i' `i'2 lact mype mor liquidez eficiencia d1lipc, fe   //sale fondeo y PBI
outreg2 using estabilidad.xls, e(r2_w) append ctitle("`j'-`i'-xtscc") label
xtreg z`j' `i' `i'2 lact mype mor liquidez eficiencia d1lipc, fe robust cluster(entcod)
outreg2 using estabilidad.xls, e(r2_w) append ctitle("`j'-`i'-xtreg-ef") label
xtreg z`j' `i' `i'2 lact mype mor liquidez eficiencia d1lipc, re robust cluster(entcod)
outreg2 using estabilidad.xls, e(r2_w) append ctitle("`j'-`i'-xtreg-ea") label
}
}


*Calcula R2 total:
predict zp if e(sample) 
corr z5 zp if e(sample) 
di r(rho)^2
