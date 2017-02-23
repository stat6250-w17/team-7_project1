*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;
*IL: use line breaks to make paragraphs in comments;
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

*IL: be careful with typos;
*IL: never wrap string literals;
*IL: research questions should be general, not specific to a specific dataset;
title1 'Research question: In this data set of 128069 observations for a given NBA basketbal season what is the average time between shots for each player?';
title2 "Rationale: It is desired to see what is the avarage time between shots for each player
that is the time between any consecutive shots for each player .";
*IL: conclusions should not include methodology, but should include a more
     complete summary of findings, along with possible explanations for "why?";
footnote1 'Calculate the mean for all the GAME_CLOCK';
footnote2 'The end result is calculated based on the entire data set.';
footnote3 'The avg_t can be compared to any single GAME_CLOCK data point seperatly.';

*
Methodology: take the avarage betwee SHOT_CLOCK for each player.
compare the avarage to each individual player.
Note: See Chapter 2, and 3 for Proc, and Proc mean commands. 
;

proc means data=SHOT_analytic_file noprint;
    var SHOT_CLOCK;
    class player_name;
    output out= avg_t_bwn_shots_for_each_player;
run;
  
*IL: use var and label statements to create more meaningful output;
proc print noobs data=avg_t_bwn_shots_for_each_player(obs=5);
run;
 
title;
footnote;

title1 'Research question: In this data set of 128069 observations for a given NBA basketbal season
what is the average points type for each player?';
title2 "Rationale: It is desired to review performance of each player based on their points type per game";
footnote1 'Calculate the mean for PTS_TYPE data.';
footnote2 'Total number of shots for each player is displayed.';
footnote3 'Result can be compared amongst all players.';

*IL: be consistent with wrapping comments at 80 characters;
*
Methodology: Take the sum of shots for each player compare this value between all the players 
Note: See Chapter 2, and 3 for Proc, and Proc mean commands
;

proc means data=SHOT_analytic_file noprint;
    var PTS_TYPE;
    class player_name;
    output out= sum_of_points_of_each_player;
*IL: be careful with spurious line breaks;
run;
  
proc print noobs data=sum_of_points_of_each_player(obs=5);
run;
 
title;
footnote;

title1 'Research question: In this data set of 128069 observations for a given NBA basketbal season 
what is the average shot dribbles per player, per game?';
title2 'Rationale: It is desired to caculate the avarage dribbls before any shot per player, per game.';
footnote1 'Calculate the mean for DRIBBLES.';
footnote2 'Avarage of dribbles for each player is displayed.';
footnote3 'Result can be compared amongst all players.';
*
Methodology: take the avarage of dribbles for each player. 
Note: See Chapter 2, and 3 for Proc, and Proc mean commands.
;
proc means data=SHOT_analytic_file noprint;
    var DRIBBLES;
    class player_name;
    output out= avg_of_dribbles_for_each_player;
run;
  
proc print noobs data= avg_of_dribbles_for_each_player(obs=5);
run;
 
title;
footnote;
