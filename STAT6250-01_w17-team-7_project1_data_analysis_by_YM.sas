

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
Research Question 1: Which player takes the most dribbles before making a shot?

Rationale: would like to see which player holds the ball longest and makes successful
shots.

Methodolgy: Sort all successful shots by dribbles, take average, descending and select the top
player.
;


*
Research Question 2:  Who makes most baskets in NBA?

Rationale: Who is the most valuable player with most made shots in NBA.

Methodology: Select 'made' shots, run MEANs by players and select the Maximum.
;



*
Research Question 3:  Which players shoots successful baskets from the farthest distance?

Rationale: Who has the best accuracy in NBA.

Methodolgy: Take average of shot_dist  of successful shots group by each player, sorted 
descending by shot_dist. Pick the first observation.
;


