function [eyefreq]=saccadepro(xx)
indexs=xx(:,46);
a1=size(indexs,1);
time=(cell2mat(xx(a1,27))-cell2mat(xx(2,27)))/1000;
%% 有注视状态时对应的列
b=0;
for i=2:a1
    TF=strcmp('',indexs(i,1))
    if (TF==0)
       b=b+1;
       index1(b,1)=indexs(i,1);
       index2(b,1)=i;

    end
end
index1=cell2mat(index1);
index3=[index1 index2];
%% 去重
a2=size(index3,1);
b=0;
for j=2:a2
    if(index3(j,1)~=index3(j-1,1))
       b=b+1;
       index(b)= index3(j-1,2);
    end
end
index=[index index3(a2,2)];
a3=size(index,2);
eyefreq=a3/time;