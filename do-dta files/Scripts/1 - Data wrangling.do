
cd "/Users/pablobrugarolas/Google Drive/Cloud/2020-21/MILE msc/SECOND TERM/Labor Macroeconomics/do-dta files/"



global file act_pop_ad emp_pop_ad wage work_age_pop_ad act_pop_nad work_age_pop_nad  emp_pop_ag emp_pop_const emp_pop_serv emp_pop_manuf fertility tertiary_educ

foreach f of global file   { 

	import excel "Data/Australia/`f'.xlsx", sheet("Data") firstrow clear
	save "Data/Australia/`f'", replace
	}
	*

	
use "Data/Australia/act_pop_ad", clear

merge 1:1 time  using "Data/Australia/emp_pop_ad.dta" 
drop _merge
merge 1:1 time  using "Data/Australia/wage.dta" 
drop _merge
merge 1:1 time  using "Data/Australia/work_age_pop_ad.dta" 
drop _merge
merge 1:1 time  using "Data/Australia/act_pop_nad.dta" 
drop _merge
merge 1:1 time  using "Data/Australia/work_age_pop_nad.dta" 
drop _merge
merge 1:1 time  using "Data/Australia/emp_pop_ag.dta" 
drop _merge
merge 1:1 time  using "Data/Australia/emp_pop_const.dta" 
drop _merge
merge 1:1 time  using "Data/Australia/emp_pop_serv.dta" 
drop _merge
merge 1:1 time  using "Data/Australia/emp_pop_manuf.dta"  
drop _merge
merge 1:1 time  using "Data/Australia/fertility.dta" 
drop _merge
merge 1:1 time  using "Data/Australia/tertiary_educ.dta" 
drop _merge
       

keep in 103/247

* Fil in missing values for fertility/tertiary using last-observation-carried-fo rward (LOCF)
replace fertility_r=fertility_r[_n-1] if fertility_r==.
replace tertiary_r=tertiary_r[_n-1] if tertiary_r==.

rename active_pop Lt
rename active_pop_nad Lt_nad
rename emp_pop Nt
rename wage Wt
rename work_pop Zt
rename working_age_pop_nad Zt_nad


save "Data/australia", replace
