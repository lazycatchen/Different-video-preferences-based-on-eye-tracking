clc;
clear;
mydir=uigetdir('E:\aa0011\������Ƶ');
if mydir(end)~='\'
    mydir=[mydir,'\'];
end
DIRS=dir([mydir,'*.mat']); %��չ��
n=length(DIRS);
% label=[ones(n/2,1);ones(n/2,1)*2];

for zz=1:n

 if ~DIRS(zz).isdir
    %filename=DIRS(zz).name;
    try  
    num=zz;%%��������
      name=['c' num2str(num) '.mat'];
     load(name);

     %%
     pupil1=xx(2:end,81);
     pupil2=xx(2:end,82);
     pupil1(cellfun(@isempty,pupil1))=[];
     pupil2(cellfun(@isempty,pupil2))=[];
     pupil1=cell2mat(pupil1);
     pupil2=cell2mat(pupil2);
     ave1=mean(pupil1);%��ͫ�׾�ֵ
     ave2=mean(pupil2);%��ͫ�׾�ֵ
     %%
     indexs=xx(:,45);
     a1=size(indexs,1);
%% ��ע��״̬ʱ��Ӧ����
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
%% ȥ��
a2=size(index3,1);
b=0;
for j=2:a2
    if(index3(j,1)~=index3(j-1,1))
       b=b+1;
       index(b)= index3(j-1,2);
    end
end
index=[index index3(a2,2)];%%��������������Ƶ��
%% ����
a3=size(index,2);
for k=1:a3
    time(k)=xx(index(k),48) %%ȡע��ʱ����
    distance1(k)=xx(index(k),49);%%ȡע��λ��x
    distance2(k)=xx(index(k),50);%5ע��λ��y
end
time=cell2mat(time);
distance1(cellfun(@isempty,distance1))=[]
distance2(cellfun(@isempty,distance2))=[]
distance1=str2double(char(distance1));
distance2=str2double(char(distance2));
distance=[distance1 distance2];
dis=diff(distance);
%% �����
temp=dis.^2;
temp=sum(temp,2);
disdis=sqrt(temp(:))
GCave=mean(disdis);%%���������ֵ
gazechanges=diff(disdis);
GCver=std(gazechanges)%%ע��λ�ñ仯��׼��

%% ��ʱ��
TIave=mean(time);%ע��λ�ü��ж�
di=diff(time);
result=std(di) %%ע��ʱ��仯��׼��
%%result1=mean(di)%%ע��ʱ��仯��ֵ
result1=mean(abs(di));
eyefreq=saccadepro(xx);%%����Ƶ��
A(zz,:)=[GCave TIave GCver result1 result eyefreq ave1 ave2];
clear index1 index2 index3 index time distance1 distance2 distance ave1 ave2
     catch
     continue
    end
end
end
% A=[label A];
save datac A