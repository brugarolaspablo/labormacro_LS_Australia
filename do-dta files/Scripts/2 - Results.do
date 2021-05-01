
cd "/Users/pablobrugarolas/Google Drive/Cloud/2020-21/MILE msc/SECOND TERM/Labor Macroeconomics/do-dta files/"

use "Data/australia", clear
generate ttime=tq(1985q1)+_n-1
format %tq ttime
tsset ttime


gen Lt_rate = Lt/Zt
label variable Lt_rate "Labor force"

gen Nt_rate = Nt/Zt
label variable Nt_rate "Employment rate"
gen Nt_rate_serv = employment_services/Zt
*label variable Nt_rate "Employment rate"
gen Nt_rate_const = emp_const/Zt
gen Nt_rate_ag = emp_agr/Zt

 

gen lt=log(Lt)
gen lt_nad=log(Lt_nad)
gen nt=log(Nt)
gen wt=log(Wt)
gen zt=log(Zt)
gen zt_nad=log(Zt_nad)
gen nt_serv=log(employment_services)
gen nt_const=log(emp_const)
gen nt_ag=log(emp_agr)
gen nt_manuf =log(emp_manuf)
gen ft =log(fertility_r) 
gen tt =log(tertiary_r) 
   
  
* Exploratory analysis - motivation  

set scheme plotplain
tsline Lt_rate, ylabel(0.65(0.05)0.8) tlabel(1985q1(4)2021q1, angle(90))

   
*Table 1 : non-seasonally adjusted vs. seasonally adjusted vars  

regress lt_nad L.lt_nad nt wt zt_nad
estimates store tb1_nad 

regress lt L.lt nt wt zt
estimates store tb1_ad

reg Lt L.lt_nad // A fake regression for making space for LR coefficients
estimates store fake

esttab tb1_nad fake tb1_ad fake, compress nogaps  b(%4.3f) se(%4.3f) star(* 0.10 ** 0.05 *** 0.01) 
esttab tb1_nad fake tb1_ad fake using "Results/Tables/Table 1.tex",  tex compress nogaps  b(%4.3f) se(%4.3f) replace


*Table 2 : the effect of empl industries

regress lt L.lt  wt zt nt_serv nt_const nt_ag nt_manuf
estimates store tb2_ind

reg lt L.lt
estimates store fake1

esttab  tb1_ad fake1 tb2_ind fake1, compress nogaps  b(%4.3f) se(%4.3f)  star(* 0.10 ** 0.05 *** 0.01) 
esttab  tb1_ad fake1 tb2_ind fake1 using "Results/Tables/Table 2.tex",  tex  compress nogaps  b(%4.3f) se(%4.3f) replace

tsline Nt employment_services emp_manuf emp_const emp_agr,  tlabel(1985q1(4)2021q1, angle(90)) // Graphically
 
  
*Table 3 : controlling for demographic outcomes

regress lt L.lt  wt zt nt ft tt
estimates store tb3_fert
 
esttab tb1_ad fake1 tb3_fert fake1, compress nogaps b(%4.3f) se(%4.3f) 
esttab tb1_ad fake1 tb3_fert fake1 using "Results/Tables/Table 3.tex",  tex compress nogaps  b(%4.3f) se(%4.3f) replace

 
