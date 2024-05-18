use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia_stata.dta", clear
set more off
stset tf,failure (incumplio_final) id(DEO_ENT)
*Modelo final
stcox edad i.sexo EXPERIENCIA CENTIL_REM i.CLUSTER_OK CENTIL_SALDO SALDO_PNRLD TEA_PNRLD IPCLima PBI ConfianzaEmp c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)
estat phtest, detail /*a nivel global no se cumple el supuesto de riesgos proporcionales de Cox*/
*Testeo de hipotesis por mes
foreach i in 201001 201002 201003 201004 201005 201006 201007 201009 201010 201011 201012 {
	use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia_stata.dta", clear
	set more off
	stset tf,failure (incumplio_final) id(DEO_ENT)
	keep if ingreso==`i'
	stcox edad sexo EXPERIENCIA CENTIL_REM CENTIL_SALDO c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)
	display `i'
	estat phtest, detail
}
foreach i in 201101 201102 201103 201104 201105 201106 201107 201108 201109 201110 201112 {
	use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia_stata.dta", clear
	set more off
	stset tf,failure (incumplio_final) id(DEO_ENT)
	keep if ingreso==`i'
	stcox edad sexo EXPERIENCIA CENTIL_REM CENTIL_SALDO c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)
	display `i'
	estat phtest, detail
}
foreach i in 201201 201202 201203 201204 201205 201206 201207 201208 201209 201210 201211 201212 {
	use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia_stata.dta", clear
	set more off
	stset tf,failure (incumplio_final) id(DEO_ENT)
	keep if ingreso==`i'
	stcox edad sexo EXPERIENCIA CENTIL_REM CENTIL_SALDO c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)
	display `i'
	estat phtest, detail
}
foreach i in 201301 201302 201303 201304 201305 201306 201307 201308 201309 201310 201311 201312 {
	use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia_stata.dta", clear
	set more off
	stset tf,failure (incumplio_final) id(DEO_ENT)
	keep if ingreso==`i'
	stcox edad sexo EXPERIENCIA CENTIL_REM CENTIL_SALDO c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)
	display `i'
	estat phtest, detail
}
foreach i in  201009 201010 {
	use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia_stata.dta", clear
	set more off
	stset tf,failure (incumplio_final) id(DEO_ENT)
	keep if ingreso==`i'
	stcox edad sexo EXPERIENCIA CENTIL_REM CENTIL_SALDO c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)
	display `i'
	estat phtest, detail
}
