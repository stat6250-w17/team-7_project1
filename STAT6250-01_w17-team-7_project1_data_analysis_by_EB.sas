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

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset;
%include '.\STAT6250-01_w17-team-7_project1_data_preparation.sas';

title1 'Research Question: What factors significantly correlate with making a shot?';
title2 'Rationale: Want to understand what are biggest factors in a good shot. These are factors that shooters should ensure they have when attempting a shot.';
footnote1 'A logit regression is used with the descending option to model made shots (1).';
footnote2 'All of the independent variables are significant and we can learn from their coefficient whether they are positively or negatively correlated.';
footnote3 'Example: For every one unit increase in SHOT_CLOCK, the log odds of making the shot increases by 0.0154.';

*
Methodology: Use PROC LOGISTIC to compute a simple binary regession model 
with these factors: SHOT_CLOCK, DRIBBLES, TOUCH_TIME, SHOT_DIST, 
CLOSE_DEF_DIST as they relate to made field goals (FGM).
;

proc logistic data=SHOT_analytic_file descending;
    model FGM = SHOT_CLOCK DRIBBLES TOUCH_TIME SHOT_DIST CLOSE_DEF_DIST;
run;

title;
footnote;

title1 'Research Question: Who is the best shooter in the NBA?';
title2 'Rationale: Want to see who deserves the most praise and recognition in terms of their shooting percentage.';
footnote1 'The shooter with best field goal percentage is displayed. His average shot distance and number of shots is also shown.';
footnote2 'A shooter typically takes most of his shots from outside the key and does not get many dunks or lobs.';
footnote3 'A filter is used to select players with an average shot distance greater than 7.5 feet and with more than 99 shot attempts. These values can be adjusted as the data analyst sees fit.';

*
Methodolgy: Compute the mean shooting percentage for all players and sort in
descending order. Select the top player. 
Note: See Lesson 11 in SAS Essentials
;
proc means data=SHOT_analytic_file noprint;
    var FGM SHOT_DIST;
    class player_name;
	output out=SHOT_fg_perc_by_player mean=fg_perc shot_dist_avg n=num_shots;
run;

proc sort data=SHOT_fg_perc_by_player;
    by descending fg_perc;
run;

proc print noobs data=SHOT_fg_perc_by_player(obs=1);
    id player_name;
	var fg_perc shot_dist_avg num_shots;
	where shot_dist_avg > 7.5 & num_shots > 99;
run;

title;
footnote;


title1 'Research Question: Who is the best defender in the NBA?';
title2 'Rationale: Want to see who deserves the most praise and recognition based on their ability to make oppenents miss shots.';
footnote1 'The defender with the lowest field goal percentage for oppenents is displayed. His number of defensive plays is shown as well.';
footnote2 'A filter is used to select defenders that have defended more than 99 shots. This value can be adjusted as the data analyst sees fit.';

*
Methodolgy: Compute the opponent's shooting percentage for all defenders and
sort in descending order. Select the top player. 
Note: See Lesson 11 in SAS Essentials
;
proc means data=SHOT_analytic_file noprint;
    var FGM;
    class CLOSEST_DEFENDER;
	output out=SHOT_fg_perc_by_def_player mean=fg_perc_def n=num_defends;
run;

proc sort data=SHOT_fg_perc_by_def_player;
    by fg_perc_def;
run;

proc print noobs data=SHOT_fg_perc_by_def_player(obs=1);
    id CLOSEST_DEFENDER;
	var fg_perc_def num_defends;
	where num_defends > 99;
run;

title;
footnote;
