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

title1 'Research question: What is the average time between shots for each player?';
title2 'Rationale: It'd be interesting to see what is the avarage time between shots for each player.';
footnote1 'proc mean is used to calculate the mean for GAME_CLOCK';
footnote2 'the end result is calculated based on the entire data set.';
footnote3 'the avg_t can be compared to any single GAME_CLOCK data point seperatly.';

*
Methodology: take the avarage betwee SHOT_CLOCK for each player.
compare the avarage to each individual player.
Note: See Chapter 2, and 3 for Proc, and Proc mean commands. 
;

proc means data=SHOT_analytic_file noprint;
	var GAME_CLOCK;
	class player_name;
	output out= avg_t_bwn_shots_for_each_player mean= avg_t;
run;

proc sort data=avg_t_bwn_shots_for_each_player;
    by descending avg_t;
run;
  
proc print noobs data=avg_t_bwn_shots_for_each_player(obs=1);
    id player_name;
    var avg_t;
run;
 
title;
footnote;

title1 'Research question: What is the average shots per game for each player?';
title2 'Rationale:I'd like to review performance of a player based on their shots per game';
footnote1 'proc mean is used to calculate the mean for SHOT_RESULT.';
footnote2 'total number of shots for each player is displayed.';
footnote3 'result can be compared amongst all players.';

*
Methodology: Take the sum of shots for each player compare this value between all the players 
Note: See Chapter 2, and 3 for Proc, and Proc mean commands
;

proc means data=SHOT_analytic_file noprint;
var SHOT_RESULT;
class player_name;
output out= sum_of_shots_of_each_player mean= sum_s;

run;

proc sort data=sum_of_shots_of_each_player;
    by descending sum_s;
run;
  
proc print noobs data=sum_of_shots_of_each_player(obs=1);
    id player_name;
    var sum_s;
 run;
 
title;
footnote;

title1 'Research question: What is the average shot dribbles per player, per game?';
title2 'Rationale: I'd like to caculate the avarage dribbls before any shot per player, per game.';
footnote1 'proc mean is used to calculate the mean for DRIBBLES.';
footnote2 'avarage of dribbles for each player is displayed.';
footnote3 'result can be compared amongst all players.';

*
Methodology: take the avarage of dribbles for each player. 
Note: See Chapter 2, and 3 for Proc, and Proc mean commands.
;

proc means data=SHOT_analytic_file noprint;
var DRIBBLES;
class player_name;
output out= avg_of_dribbles_for_each_player mean= avg_d;

run;

proc sort data= avg_of_dribbles_for_each_player;
    by descending avg_d;
run;
  
proc print noobs data= avg_of_dribbles_for_each_player(obs=1);
    id player_name;
    var avg_d;
 run;
 
title;
footnote;
