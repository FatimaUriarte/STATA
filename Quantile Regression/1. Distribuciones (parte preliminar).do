cd "D:\3. Investigaciones\Regresion cuantilica\Data"

*Tasas de Interés
foreach i in USD{
	use Hipotecario_Total_2015.dta, clear
	set more off
	destring año, replace
	drop if año<2005
	drop if kvi==0
	drop if tea<4 | tea>23
	keep if mon=="`i'"
	destring año, replace
	twoway (histogram tea, percent color(gs12)) (histogram tea if año==2015,percent fcolor(none) lcolor(black)), legend(order(1 "Stock" 2 "Desembolsado 2015" )) xtitle("Tasa Efectiva Anual (%)", size(small)) ytitle("Frecuencia - Deudores (%)", size(small)) ylabel(0(4)20) xlabel(5(2)23)
	graph save DIST_`i'.gph, replace
}
