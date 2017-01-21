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
Research Question: What factors significantly correlate with making a shot? 

Rationale: Want to understand what are biggest factors in a good shot. These
are factor that shooters should ensure they have when taking a shot.

Methodology: Use PROC REG to compute a regession model with these factors: 
SHOT_CLOCK, DRIBBLES, TOUCH_TIME, SHOT_DIST, CLOSE_DEF_DIST

Note that SHOT_RESULT will need to be recoded as made=1 and missed=0
;

proc reg data=SHOT_analytic_file;
    model SHOT_RESULT = SHOT_CLOCK DRIBBLES TOUCH_TIME SHOT_DIST CLOSE_DEF_DIST;
run;


*
Research Question: Who is the best shooter in the NBA?

Rationale: Want to see who deserves the most praise and recognition in
terms of their shooting percentage.

Methodolgy: Compute the shooting percentage for all players and sort in
descending order. Select the top player.
;

data SHOT_shooting_perc;
	set SHOT_analytic_file;
	Shooting_Perc
run;

proc sort data=SHOT_analytic_file_temp
    by descending Shooting_Perc
run;
	
proc print noobs data=SHOT_analytic_file_temp(obs=1)
    id player_name;
	var Shooting_Perc;
run;
*
Research Question: Who is the best defender in the NBA?

Rationale: Want to see who deserves the most praise and recognition based
on their ability to make oppenents miss shots.

Methodolgy: Compute the opponent's shooting percentage for all defenders and
sort in descending order. Select the top player.
;

proc data=SHOT_analytic_file;


proc sort data=SHOT_analytic_file_temp;
	by descending Opp_Shooting_Perc;
run;
	
proc print noobs data=SHOT_analytic_file_temp(obs=1);
	id CLOSEST_DEFENDER;
	var Opp_Shooting_Perc;
run;	

	
	
	
	
