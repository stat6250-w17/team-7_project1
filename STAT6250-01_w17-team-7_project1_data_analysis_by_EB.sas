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

title1 'Research Question: What factors significantly correlate with making a shot?';
title2 'Rationale: Want to understand what are biggest factors in a good shot. These are factors that shooters should ensure they have when attempting a shot.';
footnote1 'The Linear Regression formula does not give a good R-Square value.';
footnote2 'All of the independent variables are significant however and we can learn from their coefficient whether they are positively or negatively correlated.';
footnote3 'Because FGM is an ordinal value, 0 or 1, the analysis should be run again using Ordinal Regression.';

*
Methodology: Use PROC REG to compute a simple linear regession model with these factors: 
SHOT_CLOCK, DRIBBLES, TOUCH_TIME, SHOT_DIST, CLOSE_DEF_DIST as they relate to made
field goals (ie FGM).
;

proc reg data=SHOT_analytic_file;
    model FGM = SHOT_CLOCK DRIBBLES TOUCH_TIME SHOT_DIST CLOSE_DEF_DIST;
run;

title;
footnote;

title1 'Research Question: Who is the best shooter in the NBA?';
title2 'Rationale: Want to see who deserves the most praise and recognition in terms of their shooting percentage.';
footnote1 'Based on the above output, DeAndre Jordan is the best shooter.';
footnote2 'DeAndre Jordan is a center and most of his shot attempts are from dunks or lobs.';
footnote3 'Further analysis is needed to select a player who actually takes jumpshots further from the basket.';
*
Methodolgy: Compute the mean shooting percentage for all players and sort in
descending order. Select the top player. Note: See Lesson 11 in SAS Essentials
;
proc means data=SHOT_analytic_file noprint;
    var FGM;
    class player_name;
	output out=SHOT_fg_perc_by_player mean=fg_perc;
run;

proc sort data=SHOT_fg_perc_by_player;
    by descending fg_perc;
run;

proc print noobs data=SHOT_fg_perc_by_player(obs=1);
    id player_name;
	var fg_perc;
run;

title;
footnote;


title1 'Research Question: Who is the best defender in the NBA?';
title2 'Rationale: Want to see who deserves the most praise and recognition based on their ability to make oppenents miss shots.';
footnote1 'Zoran Dragic is the best defender.';
footnote2 'He was only the closest defender on 2 shots, however.';
footnote3 'Further analysis is needed to qualify defenders based on number of shots gaurded.';
*
Methodolgy: Compute the opponent's shooting percentage for all defenders and
sort in descending order. Select the top player. Note: See Lesson 11 in SAS Essentials
;
proc means data=SHOT_analytic_file noprint;
    var FGM;
    class CLOSEST_DEFENDER;
	output out=SHOT_fg_perc_by_def_player mean=fg_perc_def;
run;

proc sort data=SHOT_fg_perc_by_def_player;
    by fg_perc_def;
run;

proc print noobs data=SHOT_fg_perc_by_def_player(obs=1);
    id CLOSEST_DEFENDER;
	var fg_perc_def;
run;

title;
footnote;
