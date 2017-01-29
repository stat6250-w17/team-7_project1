

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


title1 'Research Question 1: Which player takes the most dribbles before making a shot?';
title2 'Rationale: would like to see which player holds the ball longest and makes successful shots.'

footnote1 'I ran the results using proc sql on my local VM, code will be converted to SAS code'
footnote2 'Looks like Dennis Schrod dribbles the most based on averages before a making a shot'

*
Methodolgy: Take average dribbles for 'made' shots by each player.
;

proc sql;
  select player_name, avg(dribbles) as avg_db from work.import
  where short_result='made' group by player_name
  order by avg_db desc;
run;


title1 'Research Question 2: Who are the top three leading scorers in NBA?'

title2 'Rationale: Wanted to see who are the top scorers in NBA making them the most valuable players.'

footnote1 'Ran on my local VM using proc sql, the code will be converted to SAS code soon.'
footnote2 'The top points scorers are Stephen Curry, James Harden and Klay Thompson. Lebron James is 4th.'

proc sql;
  select player_name, sum(pts) as points from work.import
  where shot_result='made' group by player_name
  order by points desc;
run;

*
Methodolog: Sum points for all made shorts and group by players.
;


title1 'Research Question 3:  Which player shoots successful baskets from the farthest distance?'

title2 'Rationale: Wanted to analyze which player has best average for the farthest distance shots.'

footnote1 'Mike Miller seems to be leading the farthest shot distance average(23.13ft), Steph Curry has an average of 15.5ft'
footnote2 'Surprisingly, I did not see any famous players in the top list.'

proc sql;
  select player_name, avg(shot_dist) as avg_shot_dist from work.import
  where shot_result='made' group by player_name
  order by avg_shot_dist desc;
run;

*
Methodology: Take average of shooting distance grouped by players for all successful shots.
;


