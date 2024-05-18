*Ruta
cd "D:\3. Investigaciones\Regresion cuantilica\Data"

*Guardamos el procedimiento en un archivo log
log using Resultados_Regresion_Cuantilica_Final_Ingresos_MN_HC.smcl, replace

*Comparamos coeficientes entre cuantiles
use base_regresion_cuantilica_final.dta, clear
keep if MON==1
twoway (histogram TEA if MODALIDAD_FINAL ==1, percent color(gs12)) (histogram TEA if MODALIDAD_FINAL ==0,percent fcolor(none) lcolor(black)), legend(order(1 "Préstamo Hipotecario" 2 "MiVivienda" )) xtitle("Tasa Efectiva Anual (%)", size(small)) ytitle("Frecuencia - Deudores (%)", size(small)) ylabel(0(4)20) xlabel(5(2)23)

*Definimos las variables a ser usadas
global Y "TEA"
*global X "EDAD SEXO i.HIST_CRED RANGO_INGRESOS MONTO_OTORGADO MODALIDAD_FINAL PLAZO_ANHO i.LTV_FINAL i.ENT_NCOD_FINAL COMPRA_DEUDA INDICE TASA_DESEMPLEO"
global X "i.HIST_CRED RANGO_INGRESOS MONTO_OTORGADO MODALIDAD_FINAL PLAZO_ANHO i.LTV_FINAL i.ENT_NCOD_FINAL COMPRA_DEUDA INDICE TASA_DESEMPLEO"
*OLS
quietly regress $Y $X
estimates store OLS
set seed 10101
*QR_10
quietly bsqreg $Y $X, reps(100) quantile(.10)
estimates store QR_10
*QR_20
quietly bsqreg $Y $X, reps(100) quantile(.20)
estimates store QR_20
*QR_30
quietly bsqreg $Y $X, reps(100) quantile(.30)
estimates store QR_30
*QR_40
quietly bsqreg $Y $X, reps(100) quantile(.40)
estimates store QR_40
*QR_50
quietly bsqreg $Y $X, reps(100) quantile(.50)
estimates store QR_50
*QR_60
quietly bsqreg $Y $X, reps(100) quantile(.60)
estimates store QR_60
*QR_70
quietly bsqreg $Y $X, reps(100) quantile(.70)
estimates store QR_70
*QR_80
quietly bsqreg $Y $X, reps(100) quantile(.80)
estimates store QR_80
*QR_90
quietly bsqreg $Y $X, reps(100) quantile(.90)
estimates store QR_90
*Resumen de estimaciones
estimates table OLS QR_10 QR_20 QR_30 QR_40 QR_50 QR_60 QR_70 QR_80 QR_90, b(%7.3f) se varlabel
est store Full
outreg2 [*] using myfile_HC, see replace  label
*Test de heterocedasticidad
quietly regress $Y $X
estat hettest $X, iid
log close
