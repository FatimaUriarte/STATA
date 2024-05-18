use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia_stata.dta", clear
set more off
stset tf,failure (incumplio_final) id(DEO_ENT)
*Modelo final
stcox edad sexo EXPERIENCIA CENTIL_REM CENTIL_SALDO SALDO_PNRLD TEA_PNRLD IPCLima PBI ConfianzaEmp c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)
stcox edad sexo CLUSTER_OK EXPERIENCIA CENTIL_REM CENTIL_SALDO SALDO_PNRLD TEA_PNRLD IPCLima PBI ConfianzaEmp c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)
stcox edad sexo i.CLUSTER_OK EXPERIENCIA CENTIL_REM CENTIL_SALDO SALDO_PNRLD TEA_PNRLD IPCLima PBI ConfianzaEmp c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)
*Función de Riesgo Base h0(t)*
stcurve, hazard title("Función de Riesgo Base Suavisada", size(medium small)) xtitle("Tiempo (meses)", size(small)) ytitle("", size(small)) outfile("RiesgoBase" , replace)
*Calculo Funciones Modelo Riesgos Proporcionales Cox
tab h0
predict double s, basesurv
predict xb, hr
gen ht=h0*xb
gen st=s^xb
*Funcion de Riesgo Acumulado Base H0(t)*
predict H0, basechazard
line H0 _t, c(J) sort title("Función de Riesgo Acumulado Base", size(medium small)) xtitle("Tiempo (meses)", size(small)) ytitle("", size(small)) 
*Función de Supervivencia base S0(t)*
predict S0, basesurv
line S0 _t, c(J) sort title("Función de Supervivencia Base", size(medium small)) xtitle("Tiempo (meses)", size(small)) ytitle("", size(small)) 
*Función de Riesgo Base h0(t)*
stcurve, hazard title("Función de Riesgo Base Suavisada", size(medium small)) xtitle("Tiempo (meses)", size(small)) ytitle("", size(small)) 
*Matrices de Transición***********************************************************************************************************************************************************************
*Ejemplo: Matriz obtenida del paper de Lando http://www.sciencedirect.com/science/article/pii/S037842660100228X
drop _all
matrix foo = (-0.10084,0.10084,0\0.10909,-0.21818,0.10909\0,0,0)
mata : st_matrix("foobar", exp(st_matrix("foo")))
mat li foobar /*de aquí observamos que la diagonal principal de la matriz está ok, y que al resto de elementos hay que restarles uno*/
*Considerando promedio anuales*************
**2010**
drop _all
matrix foo = (-0.1742,0.1742\0,0)
mata : st_matrix("foobar", exp(st_matrix("foo")))
mat li foobar
**2011**
drop _all
matrix foo = (-0.2573,0.2573\0,0)
mata : st_matrix("foobar", exp(st_matrix("foo")))
mat li foobar
**2012**
drop _all
matrix foo = (-0.2843,0.2843\0,0)
mata : st_matrix("foobar", exp(st_matrix("foo")))
mat li foobar
*2013**
drop _all
matrix foo = (-0.3019,0.3019\0,0)
mata : st_matrix("foobar", exp(st_matrix("foo")))
mat li foobar
*Cluster*************
**Cluster 1**
drop _all
matrix foo = (-0.0810,0.0810\0,0)
mata : st_matrix("foobar", exp(st_matrix("foo")))
mat li foobar
**Cluster 2**
drop _all
matrix foo = (-0.2663,0.2663\0,0)
mata : st_matrix("foobar", exp(st_matrix("foo")))
mat li foobar
**Cluster 3**
drop _all
matrix foo = (-0.1233,0.1233\0,0)
mata : st_matrix("foobar", exp(st_matrix("foo")))
mat li foobar
*Cluster 4**
drop _all
matrix foo = (-0.2717,0.2717\0,0)
mata : st_matrix("foobar", exp(st_matrix("foo")))
mat li foobar
*Cluster 5**
drop _all
matrix foo = (-0.4261,0.4261\0,0)
mata : st_matrix("foobar", exp(st_matrix("foo")))
mat li foobar
