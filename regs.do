//depends on outreg2
//ssc install outreg2

local figpath figures/
capture mkdir `figpath'

local tablepath tables/
capture mkdir `tablepath'

//Let's create some handy options for our output tables. 
local out_table regtable.txt
local table_options text keep(conflict) 

//uncommment these to get FANCY LaTeX output
local out_table regtable.tex
local table_options text keep(conflict) tex(frag)


//REGRESSIONS! WITH TABLE OUTPUT TO FILE!
reg life_exp conflict
outreg2 using `tablepath'`out_table', replace `table_options' addtext(Country FE, No, Time FE, No) 

xtreg life_exp conflict, fe
outreg2 using `tablepath'`out_table', append `table_options' addtext(Country FE, Yes, Time FE, No)

xi: xtreg life_exp conflict i.year, fe
outreg2 using `tablepath'`out_table', append `table_options' addtext(Country FE, Yes, Time FE, Yes)



//Let's make a depressing figure
//generate difference in life expectancy BY COUNTRY, the bysort is very important
bysort country: gen life_diff = life_exp - life_exp[_n-1]
//make a dummy for falling life expectancy
gen fell = 0
//3 life-years per year dropped seems a reasonable threshold
replace fell = 1 if life_diff<-3
//all countries that ever had a fall bigger than threshold now get a dummy
bysort country: gen everfell = 1 if sum(fell)>0
//to show them
tab country if everfell==1

//make a panel-aware line plot 
xtline life_exp if everfell==1, i(country) t(year) overlay title(Falling life expectancy)
graph export `figpath'depressing.png, replace

