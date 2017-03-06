//disable the -more- prompt that forces you to mash a key to get output
set more off
//clear data from memory
clear all


//print working directory
pwd

//change directory
cd /Users/efx/Dropbox/github/Stata_intro/

//print working directory
pwd

//UCDP data containing conflicts by year
use ucdp-prio-acd-4-2015.dta, clear

//drop all except
keep location year

//rename variable "location" to "country"
rename location country
//generate a variable
gen conflict = 1


//make lowercase and remove double spaces
replace country = itrim(lower(country))

//we want to remove some of the weird names
//vietnam (north vietnam), zimbabwe (rhodesia)

//split country by "(" and ","
//creating temp1-tempN in the process
split country, p("(") gen(temp)
//assign the first piece of the split names back to country
replace country = temp1
//drop all variables beginning with temp
drop temp*
//repeat for the comma sign
split country, p(",") gen(temp)
replace country = temp1
drop temp*


duplicates drop
save ucdp.dta, replace

//let's get that wolrd bank data
import delimited worldbank.csv, varnames(1) clear

//drop the stupid footer the WB insists on putting in it's data files.
drop in 745/749
//uniquie identifiers
gen id = _n

//make the dataset long, taking the yr values and placing in their own columns with the year following the yr1995
reshape long yr, i(id) j(year)

rename yr data 
destring data, replace force
//we now have a column called data and a row for each variable for each country for each year. no plz

//give the series (WB name for variables) their own numbers
encode seriescode, gen(varnum)

//chuck everything we don't need. 
keep countryname year varnum data
//unique IDs again, we want to have a year and country on each row
egen id = group(countryname year)

reshape wide data, i(id) j(varnum)

rename countryname country
rename data3 life_exp
label variable life_exp "Life expectancy"
replace country = itrim(lower(country))

//MERGE!
merge 1:1 country year using ucdp.dta
rm ucdp.dta
replace conflict = 0 if missing(conflict)

//Stata loves panels but it doesn't like strings as panel identifiers
egen countryid = group(country)
//set the individuals to country and the time units to year.
xtset countryid year



//do-ception
do "regs.do"

