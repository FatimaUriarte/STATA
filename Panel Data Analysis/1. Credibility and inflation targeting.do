********************************************************************************
*Credibility Inflation Targeting************************************************
*Author: Fatima Uriarte Caceres*************************************************
********************************************************************************

*Install necessary packages
sysdir set PLUS "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\Macroeconometrics\ado"
ssc install rolling2, replace
ssc install dfsummary, replace
ssc install outreg2, replace

*Initial settings
cd "\\SIPAXFSC\Users\flu2103\Desktop\PEPM CITRIX\2. Spring\MacroPaper"
capture log close
set logtype text
log using credibility_inflation_targeting, replace
use revela_data.dta, clear
drop if date=="Dec-17" | date=="Nov-17" /*only emerging economies*/
drop if id>=100
preserve

********************************************************************************
*Testing for Bias in Inflation Expectations*************************************
********************************************************************************
gen month=substr( date,1,3) 
keep if month=="Dec"
duplicates drop date country, force
gen forecast_error= infexp- inf_dec
reg forecast_error /*Pool*/
outreg2 using inflation_bias.xls, e(r2_w) replace
xi: regress forecast_error i.id /*Country FE*/
outreg2 using inflation_bias.xls, e(r2_w)
restore

********************************************************************************
*Estimating the Credibility of Inflation- Targeting*****************************
********************************************************************************
drop inf_dec
*Format date
split date , p("-")
egen date3=concat( date1 date2)
split date_predicted , p("-")
egen date4=concat( date_predicted1 date_predicted2 )
drop date date_predicted date1 date2 date_predicted1 date_predicted2
ren (date3 date4) (date date_predicted)
*exchangerate 
reshape wide infexp, i(country date current_inflation ) j( date_predicted ) string
egen inf_exp_dect=rowfirst(infexp*)
egen inf_exp_dect12=rowlast(infexp*)
drop infexp*
merge 1:m id mes using control.dta
drop if _merge==2
drop _merge
*Set panel
gen time=date(mes,"DMY")
drop mes
format time %td
gen anho=year(time)
egen mes=group(time)
duplicates drop id mes, force
xtset id mes
xtdescribe 
sort country mes
by country: gen lag_inf_exp_dect12 = inf_exp_dect12[_n-1]
by country: gen lag_inflation = current_inflation[_n-1]
by country: gen lag_target = target[_n-1]
*Poolability
local regvars "inf_exp_dect12 lag_inf_exp_dect12 current_inflation"
local regvars_control1 "inf_exp_dect12 lag_inf_exp_dect12 current_inflation exchangerate"
local regvars_control2 "inf_exp_dect12 lag_inf_exp_dect12 current_inflation internationalreserves"
local regvars_lr "inf_exp_dect12 current_inflation"
xtreg `regvars', re robust
xttest0 
*OLS regression
reg `regvars' if id==1
outreg2 using inflation_shocks_expectations.xls, e(r2_w) replace
local i=2
while `i'<=9{
	display `i'
	reg `regvars' if id==`i'
	outreg2 using inflation_shocks_expectations.xls, e(r2_w)
	local i=`i'+1
}
*OLS regression - Control 1
reg `regvars_control1' if id==1
outreg2 using inflation_shocks_expectations_control1.xls, e(r2_w) replace
local i=2
while `i'<=9{
	display `i'
	reg `regvars_control1' if id==`i'
	outreg2 using inflation_shocks_expectations_control1.xls, e(r2_w)
	local i=`i'+1
}
*OLS regression - Control 2
reg `regvars_control2' if id==1
outreg2 using inflation_shocks_expectations_control2.xls, e(r2_w) replace
local i=2
while `i'<=9{
	display `i'
	reg `regvars_control2' if id==`i'
	outreg2 using inflation_shocks_expectations_control2.xls, e(r2_w)
	local i=`i'+1
}
*Regression on a rolling moving time window
rolling _b _se, window(30) saving(betas, replace) keep(date): reg `regvars'
save revela_data_pool.dta, replace

********************************************************************************
*Inflation Credibility and the Inflation Target*********************************
********************************************************************************
gen breaching_target=max(lag_inflation-lag_target,1)
gen breaching_target_min=max(lag_target-lag_inflation,1)
replace breaching_target_min=0 if breaching_target_min<=1
replace breaching_target_min=1 if breaching_target_min>1
local regvars_target "inf_exp_dect12 lag_inf_exp_dect12 current_inflation breaching_target breaching_target_min"
* Regression Target
xtreg `regvars_target', re
xttest0
*OLS
reg `regvars_target' if id==1
outreg2 using inflation_shocks_expectations_ols.xls, e(r2_w) replace
local i=2
while `i'<=9{
	display `i'
	reg `regvars_target' if id==`i'
	outreg2 using inflation_shocks_expectations_ols.xls, e(r2_w)
	local i=`i'+1
}
log close








