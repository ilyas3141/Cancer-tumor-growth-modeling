function y_pred = ff2(in_y,t,y,x,array)
%pred=ff2(init,days,common,m,number_of_day);

[l, n] = size(y);

y_pred(1)=in_y;
pos(1)=1;
for i = 2:x
    pos(i)=n/t*array(i);
    pos_round=round(pos);
end
for i=1:x
    y_pred(i)=y(pos_round(i));
end
    