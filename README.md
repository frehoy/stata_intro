## Stata tutorial

Hello and welcome to the mini Stata+LaTeX tutorial!

You will learn how to:
Import, clean, reshape and merge datasets.
Compute some interesting variables
Make plots
Make tables
Compile it all in a LaTeX document.

The repository consists of 5 files:
* main.do - the stata do-file that controls everything Stata-related
* regs.do - the stata do-file that runs our regressions and makes our tables
* paper/report.tex - the .tex document that creates our fancy looking report. 
* ucdp-prio-acd-4-2015.dta - the UCDP/PRIO Armed Conflict Dataset version 4-2015 (1)
* worldbank.csv - a wide-format dataset from the World Bank containing a subset of the World development indicators. 

Disclaimer:
The scripts contained are not best practices but a very brief introduction to a Stata+LaTeX workflow that can be walked through step by step to show some hopefully interesting features, not to be used as a styleguide. 


UCDP PRIO ACD is by:
Melander, Erik and Therése Pettersson & Lotta Themnér (2016) Organized violence, 1989-2015. Journal of Peace Research 53(5).
Gleditsch, Nils Petter, Peter Wallensteen, Mikael Eriksson, Margareta Sollenberg, and Håvard Strand (2002) Armed Conflict 1946-2001: A New Dataset. Journal of Peace Research 39(5). 