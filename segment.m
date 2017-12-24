clc;
clear;
[A,txt,raw]= xlsread('江南-黑-黑.xlsx');
a=txt(:,40);
a1=size(a,1);
b=0;
for i=1:a1
    TF=strcmp('',a(i,1))
    if (TF==0)
       b=b+1;
       index1(b)=i;
    end
end
c=(b-1)/2;

for j=1:c 
    num=j+5;%%命名数字
  name=['c' num2str(num)];
  x=raw(index1(2*j):index1(2*j+1),:);
  xx=[txt(1,:);x]
  save (name,'xx')
  
end