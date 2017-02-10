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
title2 'Rationale: would like to see which player holds the ball longest and makes successful shots.';
footnote1 'I used proc sql in SAS to select playername and average of dribbles sorted in descending';
footnote2 'The first observation in the result gives the top player for highest average dribbles';

*
Methodolgy: Take average dribbles for 'made' shots by each player and sort by the average dribbles
in descending order.
;

proc sql;
  select 
    player_name, 
    avg(dribbles) as avg_db 
  from 
    SHOT_analytic_file
  where 
    short_result='made' 
  group by player_name
  order by avg_db desc;

title;
footnote;



title1 'Research Question 2: Who are the top three leading scorers in NBA?';
title2 'Rationale: Wanted to see who are the top scorers in NBA making them the most valuable players.';
footnote1 'PROC SQL was used to sort the players with highest sum of points';
footnote2 'The top three observations will give the top players.';

*
Methodolog: Sum points for all made shorts and group by players, sort by points in descending order.
;

proc sql;
  select 
    player_name, 
    sum(pts) as points 
  from 
    SHOT_analytic_file
  where 
    shot_result='made' 
  group by player_name
  order by points desc;


title;
footnote;


title1 'Research Question 3:  Which player shoots successful baskets from the farthest distance?';
title2 'Rationale: Wanted to analyze which player has best average for the farthest distance shots.';
footnote1 'Players were sorted in descending order by their averages of shot_distance';
footnote2 'None of the famous players made the list so I am thinking this may not be a very interesting metric for this game';

*
Methodology: Take average of shooting distance grouped by players for all successful shots and sort by avg shot 
distance in descending order.
;

proc sql;
  select 
    player_name, 
    avg(shot_dist) as avg_shot_dist 
  from 
    SHOT_analytic_file
  where 
    shot_result='made' 
  group by player_name
  order by avg_shot_dist desc;

title;
footnote;


