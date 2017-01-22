

*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding NBA shooters and defenders
Dataset Name: SHOT_analytic_file created in external file
STAT6250-01_w17-team-7_project1_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset FRPM1516_analytic_file;
%include '.\STAT6250-01_w17-team-7_project1_data_preparation.sas';

*
Research Question 1: Which player takes the most dribbles before shooting?
;


*
Research Question 2:  Which player takes the most open shots? (largest average Clos_def_dist)
;

data SHOT_shooting_cnt;
	set SHOT_analytic_file;
	Shooting_Cnt
run;

proc sort data=SHOT_analytic_file_temp
    by descending Shooting_Cnt
run;
	
proc print noobs data=SHOT_analytic_file_temp(obs=1)
    id player_name;
	var Shooting_Cnt;
run;

*
Research Question 3:  What is average SHOT_CLOCK, DRIBBLES, TOUCH_TIME, SHOT_DIST for players?
;


