title "Sample Size for Risk Difference";
proc power;
twosamplefreq alpha=0.025
groupproportions = (0.40, 0.40)
test=fm
sides=1
power=0.8
nullproportiondiff = 0.15
ntotal = .
;
run;
title;


title "Sample Size for Risk Ratio";
proc power;
twosamplefreq alpha=0.025
groupproportions = (0.40, 0.40)
test=fm_rr
sides=1
power=0.8
nullrelativerisk = 1.375
ntotal = .
;
run;
title;




proc format;
	value $trt_format "T"="New Treatment" "C"=" Active Control";
	value outcome_format 0="No Lice" 1="Lice";
run;

data lice;
	input trt $ outcome count;
	format trt $trt_format. outcome outcome_format.;
cards;
T 0 96
T 1 131
C 0 117
C 1 100
;
run;

proc print data=lice label;
run;


title "Risk Difference for a Negative Outcome";
proc freq data=lice;
	table trt*outcome / nocol nopercent alpha=0.025 riskdiff (column=2 noninf method=fm margin=0.15);
	weight count;
run;
title;

title "Relative Risk / Risk Ratio for a Negative Outcome";
proc freq data=lice;
	table trt*outcome / nocol nopercent alpha=0.025 relrisk (column=2 noninf method=fm margin=0.7273);
	weight count;
run;
title;


ODS HTML close;
ODS HTML;
