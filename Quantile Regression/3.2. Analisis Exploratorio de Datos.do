*Ruta*
cd "D:\3. Investigaciones\Regresion cuantilica\Data"

*Análisis exploratorio de datos*
use base_regresion_cuantilica1.dta, clear
set more off
merge m:1 DNI using prestamos_muestra.dta
drop if _merge==2
gen MODALIDAD=""
foreach i in 20150131 20150228 20150331 20150430 20150531 20150630 20150731 20150831 20150930 20151031 20151130 20151231 20160131 20160229 20160331 20160430 20160531 20160630  {
	replace MODALIDAD=modalidad_`i' if MODALIDAD==""
}
replace MODALIDAD="prestamo hipotecario" if MODALIDAD==""
gen MODALIDAD_FINAL=1 if MODALIDAD=="prestamo hipotecario"
replace MODALIDAD_FINAL=0 if MODALIDAD!="prestamo hipotecario"
label def mod_final  0 "MiVivienda" 1 "Préstamo Hipotecario"
label values MODALIDAD_FINAL mod_final
label variable MODALIDAD_FINAL "Modalidad" 
drop modalidad_* MODALIDAD _merge
/* Variables númericas: TEA EDAD MONTO_OTORGADO PLAZO_ANHO INDICE TASA_DESEMPLEO */
/* Variables categóricas: SEXO MAX_CLASIF RANGO_INGRESOS MON LTV_FINAL ENT_NCOD_FINAL */
*Histogramas
histogram TEA, normal
histogram EDAD, normal
histogram MONTO_OTORGADO, normal
histogram PLAZO_ANHO, normal
histogram INDICE, normal
histogram TASA_DESEMPLEO, normal
*Diagrama de Caja
graph box TEA
graph box EDAD
graph box MONTO_OTORGADO
graph box PLAZO_ANHO
graph box INDICE
graph box TASA_DESEMPLEO
*Dispersión matricial
graph matrix TEA EDAD MONTO_OTORGADO PLAZO_ANHO INDICE TASA_DESEMPLEO
*Elimanos outliers
drop if MONTO_OTORGADO>=800 /*4 observations deleted*/
drop if PLAZO_ANHO<=1  /*4 observations deleted*/
*Medidas descriptivas
summarize TEA EDAD MONTO_OTORGADO PLAZO_ANHO INDICE TASA_DESEMPLEO, detail
save base_regresion_cuantilica_final.dta, replace


*Cuadro Estadísticas Descriptivas
use base_regresion_cuantilica_final.dta, clear
foreach i in TEA EDAD MONTO_OTORGADO PLAZO_ANHO INDICE TASA_DESEMPLEO{
	egen MEAN_`i'=mean(`i')
	egen SD_`i'=sd(`i')
	egen MIN_`i'=min(`i')
	egen MAX_`i'=max(`i')
}
collapse (mean) MEAN_* SD_* MIN_* MAX_* 

use base_regresion_cuantilica_final.dta, clear
tab SEXO
tab MON
tab HIST_CRED
tab RANGO_INGRESOS 
tab LTV_FINAL 
tab MOD
tab ENT_NCOD_FINAL
tab COMPRA_DEUDA
