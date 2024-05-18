*Declaramos data de supervivencia
use "C:\Documentos-SBS\Fatima Uriarte\Investigación DT\supervivencia_stata.dta", clear
set more off
stset tf,failure (incumplio_final) id(DEO_ENT)
stdescribe
stvary
* Kaplan- Meier *
sts list
sts graph, title("Función de Supervivencia Kaplan-Meier", size(medium small)) xtitle("Tiempo (meses)", size(small))
sts graph, by(CLUSTER) legend(order(1 "Cluster 1" 2 "Cluster 2" 3 "Cluster 3" 4 "Cluster 4" 5 "Cluster 5") col(5) size (small)) xtitle("Tiempo (meses)", size(small))  
*Nelson-Aelen*
sts list, cumhaz
sts graph, cumhaz title("Función de Riesgo Acumulado Nelson-Aelen", size(medium small)) xtitle("Tiempo (meses)", size(small)) 
sts graph, by (CLUSTER) cumhaz legend(order(1 "Cluster 1" 2 "Cluster 2" 3 "Cluster 3" 4 "Cluster 4" 5 "Cluster 5") col(5) size (small)) xtitle("Tiempo (meses)", size(small))
sts generate kmS=s 			/* obtenemos K-M survivor estimate */
sts generate naH=na			/* obtenemos N-A cumulative hazard estimate */
gen naS=exp(-naH)			/* obtenemos K-M survivor estimate */
gen kmH=-log(kmS)			/* obtenemos K-M cumulative hazard estimate */
label var kmS "K-M"	
label var naS "N-A"
label var kmH "K-M"
label var naH "N-A"
line kmS naS _t, c(J J) sort /* gráfico funciones de supervivencia*/
line naH kmH _t, c(J J) sort /* gráfico cumulative hazard function*/
*Función de Riesgo h(t)*
sts graph, hazard kernel (gaussian) title("Función de Riesgo Suavisada", size(medium small)) xtitle("Tiempo (meses)", size(small)) outfile("RiesgoSuavisado" , replace)
sts graph, hazard by(CLUSTER) kernel (gaussian) legend(order(1 "Cluster 1" 2 "Cluster 2" 3 "Cluster 3" 4 "Cluster 4" 5 "Cluster 5") col(5) size (small)) xtitle("Tiempo (meses)", size(small)) 
*Proportional Hazard Assumption*
sts graph, hazard by(sex) kernel (gaussian) yscale(log)
*Means*
stci
stci, by (sex)
*Test*
sts test sex, logrank
sts test sex, wilcoxon
*The Cox Proportional Hazards Model*
*Cambiamos unidades*
*Analisis univariante*
*Variables Categoticas
sts test sex, logrank
sts tes CLUSTER, logrank
*Variables continuas
stcox RCD_NSDO, nohr
stcox edad, nohr
stcox REM_FINAL, nohr
stcox EXPERIENCIA, nohr
stcox CENTIL_REM, nohr
stcox IPCLima, nohr
stcox TasadeDesempleo, nohr
stcox PBI, nohr
stcox PreciosDpto, nohr
stcox ConfianzaEmp, nohr
stcox DesempleoINEI, nohr
stcox Ocupacion, nohr
stcox IndicePrecios, nohr
stcox ConfianzaCons, nohr
stcox ÍndiceBVL, nohr
stcox SALDO_PNRLD, nohr
stcox CENTIL_SALDO, nohr
stcox TEA_PNRLD, nohr
*Modelaje*
stcox edad sexo CLUSTER CENTIL_SALDO CENTIL_REM EXPERIENCIA IPCLima TasadeDesempleo PBI ConfianzaEmp IndicePrecios ConfianzaCons ÍndiceBVL SALDO_PNRLD TEA_PNRLD , nohr
stcox edad sexo CLUSTER CENTIL_SALDO CENTIL_REM EXPERIENCIA IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons SALDO_PNRLD  TEA_PNRLD , nohr
*Interacciones
foreach i in IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons ÍndiceBVL {
	set more off
	stcox edad sexo CLUSTER CENTIL_SALDO CENTIL_REM EXPERIENCIA IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons SALDO_PNRLD  TEA_PNRLD c.edad#c.`i', nohr
}
foreach i in IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons ÍndiceBVL {
	set more off
	stcox edad sexo CLUSTER CENTIL_SALDO CENTIL_REM EXPERIENCIA IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons SALDO_PNRLD  TEA_PNRLD c.sexo#c.`i', nohr
}
foreach i in IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons ÍndiceBVL {
	set more off
	stcox edad sexo CLUSTER CENTIL_SALDO CENTIL_REM EXPERIENCIA IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons SALDO_PNRLD  TEA_PNRLD c.EXPERIENCIA#c.`i', nohr
}
foreach i in IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons ÍndiceBVL {
	set more off
	stcox edad sexo CLUSTER CENTIL_SALDO CENTIL_REM EXPERIENCIA IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons SALDO_PNRLD  TEA_PNRLD c.CENTIL_REM#c.`i', nohr
}
foreach i in IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons ÍndiceBVL {
	set more off
	stcox edad sexo CLUSTER CENTIL_SALDO CENTIL_REM EXPERIENCIA IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons SALDO_PNRLD  TEA_PNRLD c.CENTIL_SALDO#c.`i', nohr
}
stcox edad sexo CLUSTER CENTIL_SALDO CENTIL_REM EXPERIENCIA IPCLima TasadeDesempleo PBI ConfianzaEmp ConfianzaCons SALDO_PNRLD  TEA_PNRLD c.CENTIL_SALDO#c.PBI c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.ÍndiceBVL c.CENTIL_REM#c.ConfianzaCons c.CENTIL_REM#c.ConfianzaEmp c.CENTIL_REM#c.PBI c.CENTIL_REM#c.TasadeDesempleo  , nohr vce(robust)
*Regresion Inicial
stcox edad i.sexo EXPERIENCIA CENTIL_REM i.CLUSTER_OK CENTIL_SALDO SALDO_PNRLD TEA_PNRLD IPCLima TasadeDesempleo PBI ConfianzaEmp ÍndiceBVL c.CENTIL_SALDO#c.PBI c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.ÍndiceBVL c.CENTIL_REM#c.ConfianzaEmp c.CENTIL_REM#c.PBI c.CENTIL_REM#c.TasadeDesempleo  , nohr vce(robust)  /* se retira confianza del consumidor por signo inverso*/ 
stcox edad i.sexo EXPERIENCIA CENTIL_REM i.CLUSTER_OK CENTIL_SALDO SALDO_PNRLD TEA_PNRLD IPCLima TasadeDesempleo PBI ConfianzaEmp c.CENTIL_SALDO#c.PBI c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust) 
stcox edad i.sexo EXPERIENCIA CENTIL_REM i.CLUSTER_OK CENTIL_SALDO SALDO_PNRLD TEA_PNRLD IPCLima TasadeDesempleo PBI ConfianzaEmp c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)

*Modelo final
stcox edad i.sexo EXPERIENCIA CENTIL_REM i.CLUSTER_OK CENTIL_SALDO SALDO_PNRLD TEA_PNRLD IPCLima TasadeDesempleo PBI ConfianzaEmp c.CENTIL_SALDO#c.IPCLima c.CENTIL_REM#c.PBI, nohr vce(robust)
estat phtest, detail
