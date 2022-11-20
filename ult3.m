function bestpD = ult3(idd)
if isStringScalar(idd) == 1
    id=str2double(idd);
else
    id=idd
end


data_sets=["C4:C47","C50:C106","C109:C136","C139:C203","C206:C301","C304:C379","C381:C402","C404:C457","C460:C530","C531:C615"];
days=["A4:A47","A50:A106","A109:A136","A139:A203","A206:A301","A304:A379","A381:A402","A404:A457","A460:A530","A531:A615"];
[pp, ll]=size(data_sets);
%injections=['A4:A14','A14:A23','A23:A32','A32:A93','A93:A105'];
injections=["D4:D47","D50:D106","D109:D136","D139:D203","D206:D301","D304:D379","D381:D402","D404:D457","D460:D530","D531:D615"];
x1_initial=[926.4933,307.7245,230.7336,585.1368,314.5374,178.4779,135.6402,219.4429,247.1457,688.3532];


daysread=xlsread('PLDNewVolume.csv',1,days(id));

f_day=daysread(1); % the number of the first day considered in the experiment
l_day=daysread(end);% the number of the last day considered in the experiment

global y time_span x1_0 x2_0 x3_0 x4_0 number_of_day
 
y=xlsread("PLDNewVolume.csv",1,data_sets(id));
[s1, s2]=size(y);
t=linspace(f_day,l_day,s1);%set 't' for the first plot

%time_span = [0 10;0 9;0 9;0 61;0 12];


%Defining of timespans for ode45
inj=xlsread("PLDNewVolume.csv",1,injections(id));
[iii, bbb]=size(inj);
nums=[];
for i=1:iii
    if inj(i)==8
        nums=[nums i];
    end
end
[w,ww]=size(nums);
spans=[];
for i=1:ww
    spans=[spans daysread(nums(i))];
end
[ttt,qqq]=size(spans);
spans1=[];
for i=1:qqq-1
    spans1=[spans1 abs(spans(i)-spans(i+1))];
end
spans1=[spans1 abs(spans(end)-daysread(end))];
[q1,w2]=size(spans1);
spans_final=[];
for i=1:w2
    spans_final=[spans_final; [0 spans1(i)]];
end
time_span = spans_final;

%y=[926.4933, 1382.8, 360.7292, 503.9498, 1270.3 1471.6, 2069.9, 1175.3, 1513, 791.1397, 725.0006, 609.1031, 748.1899, 588.2446, 401.7718, 307.3068, 237.3108, 187.0804, 365.3638, 269.9051, 384.0982, 278.5476, 233.0143, 220.7504, 189.2077,0,0,0,0,0,0,0,0,123.7409,149.045,302.9331,356.5531,642.4427,756.4903,919.1142,1385.9,2128.5]; %values of volume we have from data
%y=[1270.3, 1471.6, 2069.9, 1175.3, 1513];
%y=[1513, 791.1397, 725.0006, 609.1031, 748.1899];
    
    
%time_span=[0 10;0 9;0 9;0 61;0 12];% time span for ode45, took as 10 days because I consider range from day 4 until day 14
%initial conditions for x1,x2,x3,x4
x1_0=x1_initial(id);
x2_0=0;
x3_0=8;%as if we add injection of 8
x4_0=0;
%number_of_day=[0,3,5,7,10,12,14,17,19,21,24,26,28,31,34,38,40,42,45,47,49,52,54,56,59,61,63,66,68,70,73,75,77,80,82,84,87,89,91,94,96,101];

if id==7 || id==8
        number_of_days=daysread-2;
    elseif id==10
        number_of_days=daysread;
    else
        number_of_days=daysread-4;
end
number_of_day=number_of_days;



%number_of_day=[0,3,5,7,10];% the number of each day when the measurement of volume was made in span of 10 days 
%number_of_day=[0,3,5,7,10,12,14,17,19,21,24,26,28,31,34,38,40,42,45,47,49,52,54,56,59,61,63,66,68,70,73,75,77,80,82,84,87,89,91,94,96,101];
% that is considered in the experiment

% parameter values put in struct variable 'd'
%d=[0.12,0.44,0.00031, 0.00056, 6.75, 66.68, 0.037, 0.809, 0.1, 0.1];
d=[0.12,0.44,0.00031, 0.00056, 6.75, 66.68, 0.037, 0.809, 0.1];
%d=[0.12,0.44,0.00031, 0.00056, 6.75, 66.68, 0.037, 0.809];
%d=[0.00279037855492574,	4.99963313462859,	2.78723435111829e-09,	0.367679079755417,	1.98465301656969,	2.99861995762657,	1.16381772337352,	297.904773153560,	1.51026828970420];


y1=y.';
%plot of the measured volumes 
figure(id)
clf
h1=plot(t,y1,'-ok','MarkerFaceColor','k');
xlabel('Time [days]');
ylabel('Volume [mm^{3}]');

%calculating our prediction using ode45
% [tmp,pred]=predRecoveryErr1_my(d,time_span,x1_0,x2_0,x3_0,x4_0);
[pred]=predRecoveryErr1_my(d);
[mm, nn] =size(pred);

tplot1=linspace(f_day,l_day,nn);
% plotting our prediction
hold on
h2 =plot(tplot1,pred,'-r');
A=[];
b=[];
Aeq=[];
beq=[];
%ub=[2 5 0.001 2 2 3 360 300];
ub=[2 5 0.001 2 2 3 360 300 360];
%lb=[0,0,0,0,0,0,0,0];
lb=[0,0,0,0,0,0,0,0, 0];
nlcon=[];


%finding the best choice of parameters
%bestP=fit_my('predRecoveryErr_my',d,{'a','b','n','ED_50','k1','k2','w','c'});
%bestP=fit_my('predRecoveryErr_my',d,{'a','b','n','k1','k2','w','c'},number_of_day,y,time_span,x1_0,x2_0,x3_0,x4_0);
%bestP=fit_my('predRecoveryErr_my',d,{'a','b','n','k1','k2','w'},number_of_day,y,time_span,x1_0,x2_0,x3_0,x4_0);
%bestP=fit_my('predRecoveryErr_my',d,{'a','b','n'},number_of_day,y,time_span,x1_0,x2_0,x3_0,x4_0);
%bestP=fit_my('predRecoveryErr_my',d,{'a','b','n','ED_50','k1','k2'},number_of_day,y,time_span,x1_0,x2_0,x3_0,x4_0);
%options = optimoptions('fmincon','FiniteDifferenceStepSize',0.000001,'MaxFunctionEvaluations',1800);
options = optimoptions('fmincon','FiniteDifferenceStepSize',0.000001,'MaxFunctionEvaluations',1800);

bestP=fmincon(@objectiveee,d,A,b,Aeq,beq,lb,ub,nlcon,options);
bestpD=bestP;
%calculating the prediction with the best choice of parameters
[bestPred]=predRecoveryErr1_my(bestP);

[m, n]=size(bestPred);

%plotting the prediction with the best choice of parameters
tplot2=linspace(f_day,l_day,n);

h3=plot(tplot2, bestPred, '-b');
legend({'Data Measurements','Initial Guess','Best prediction'},'Location','northwest')
%legend({'Data Measurements','Best prediction'},'Location','northwest')


end

