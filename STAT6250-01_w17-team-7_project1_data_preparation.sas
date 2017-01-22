*******************************************************************************
*******************************************************************************
/*
[Dataset Name] NBA shot logs

[Experimental Units] Basketball shot attempt resulting in a make or miss

[Number of Observations] 128069
                    
[Number of Features] 21

[Data Source] https://www.kaggle.com/dansbecker/nba-shot-logs/downloads/nba-shot-logs.zip

[Data Dictionary] https://www.kaggle.com/dansbecker/nba-shot-logs (I was unable to find an explicit dicitonary, but all the columns
are easy to understand).

[Unique ID Schema] A compostite key of GAME_ID and SHOT_NUMBER
*/
*******************************************************************************
*******************************************************************************

* setup environmental parameters;
%let inputDatasetURL = 
https://github.com/stat6250/team-7_project1/blob/master/shot_logs.csv?raw=true
;

* load raw SHOTLOG dataset over the web;
filename SHOTtemp TEMP;
proc http
	method="get"
	url="&inputDatasetURL."
	out=SHOTtemp
	;
run;

proc import
	file=SHOTtemp
	out=SHOT_raw replace
	dbms=csv
	;
run;

filename SHOTtemp clear;

* check raw SHOT dataset for duplicates with respect to its composite key;
proc sort nodupkey data=SHOT_raw dupout=SHOT_raw_dups out=_null_;
	by GAME_ID SHOT_NUMBER;
run;

*build analytic dataset from SHOTLOG dataset with the least number of columns
and minimal cleaning/transformation needed to address research questions in
corresponding data-analysis files;

data SHOT_analytic_file;
	retain
		DRIBBLES
		SHOT_CLOCK
		TOUCH_TIME
		SHOT_DIST
		CLOSE_DEF_DIST
		player_name
		CLOSEST_DEFENDER
		SHOT_RESULT
	;
	keep
		DRIBBLES
		SHOT_CLOCK
		TOUCH_TIME
		SHOT_DIST
		CLOSE_DEF_DIST
		player_name
		CLOSEST_DEFENDER
		SHOT_RESULT
	;
	set SHOT_raw;
run;



