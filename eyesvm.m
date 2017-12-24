% data1=importdata ('lf.mat');
% data2=importdata  ('lhc.mat');
% data3=importdata  ('sd.mat');
% data4=importdata  ('zrb.mat');
%  data=[data1;data2;data4];
% % data=[data2];
clc;
clear;
%data=importdata  ('data_raw.mat');
% data1=importdata ('data.mat');
% % data2=importdata ('data (2).mat');
%% 刘俊杭数据
% data=data1([4,12,13,14,17,24,29,33,38,40,45,48,2,15,22,28,31,37,46,50,40,30,32,25],:);%%删除了14,38
% data=data1([4,12,13,14,24,29,38,40,45,48,2,15,22,28,31,39,50,31,32,25],1:6);
%   ttemp=[ones(25,1);ones(25,1)*2];
 %data=data1;
 
% ttemp=[1 1 2 2 2 1 1 1 2 2 1 1 1 2 2 2 1 1 2 2 2 1 1 2 2 1 2 2 2 1 1 2 2 1 1 1 2 1 2 1 1 2 1 2 1 2 1 2 1 2]';
% [m1,m2]=find(ttemp==1);
% [n1,n2]=find(ttemp==2);
% data1=datamap(data1); 
% datax=[data1(m1,:);data1(n1,:)]
% temp=[ones(25,1);ones(25,1)*2];
% data=[temp datax];
%% 沈平中数据
% data=data1([1,4,12:19,21,24,27,31,33,34,36:42,45:48],:);
% data=data1([1,4,13:18,21,24,27,33,34,37:41,45:48,2,3,6:11,20,21,23,25,26,28,29,30,32,35,43,44,49,50],:);
% ttemp=[ones(22,1);ones(22,1)*2];

% ttemp=[1 1 2 2 2 1 1 1 2 2 1 1 1 2 2 2 1 1 2 2 2 1 1 2 2 1 2 2 2 1 1 2 2 1 1 1 2 1 2 1 1 2 1 2 1 2 1 2 1 2]';
% [m1,m2]=find(ttemp==1);
% [n1,n2]=find(ttemp==2);
% data1=datamap(data1); 
% datax=[data1(m1,:);data1(n1,:)]
% temp=[ones(25,1);ones(25,1)*2];
% data=[temp datax];
%% 李永平数据
% data1=importdata ('dataa.mat');
% data2=importdata ('datab.mat');
% data3=importdata ('datac.mat');
% data=[data1;data2;data3];
% data_text=data([1:9,13],[1:4,6:8]);
% 
% datax=datamap(data_text);
% temp=[ones(5,1);ones(5,1)*2];
% data=[temp datax];
%% 
% data1=importdata ('dataa.mat');
% data2=importdata ('datab.mat');
% data3=importdata('datac.mat');
% data=[data1;data2;data3(1:5,:)];
% 
% 
% datax=datamap(data);
% % datax=datax(:,[1,3:5,7,8])
% temp=[ones(5,1);ones(5,1)*2;ones(5,1)*3];
% data=[temp datax];
% % data=data(:,[1,3,6,7,8,9]);
%%
happy=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_happy.mat');
angry=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_angry.mat');
surprise=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_surprise.mat');
sad=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_sad.mat');
fear=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_fear.mat');
neutral=importdata('E:\aa0011\音乐+脑电\database\casia汉语情感语料库\相同文本50\zhaozuoxiang\datasum_neutral.mat');
data=[happy;angry;surprise;sad;fear;neutral]';
data(any(isnan(data),2),:)=[];
data=data';

% n=ga_speech_opt;
% data=data(:,n);
%  data1=data(:,[56;30;32;36;28;15;20;25;61;46;41;17;18;27;23;19;24;26;14;13;16;21;22;11]);
add1=ones(size(data,1)/6,1);
add2=ones(size(data,1)/6,1)*2;
add3=ones(size(data,1)/6,1)*3;
add4=ones(size(data,1)/6,1)*4;
add5=ones(size(data,1)/6,1)*5;
add6=ones(size(data,1)/6,1)*6;
add=[add1;add2;add3;add4;add5;add6];%%数据标号
datax=datamap(data)
data=[add datax];

%%
num=size(data,1);
k=rand(1,num);
[m,n]=sort(k);
traindata=data(n(1:num),2:end);
trainlabel=data(n(1:num),1);
% discount=0.9;
% testdata=data(n(num*discount+1:num),2:end);
% testlabel=data(n(num*discount+1:num),1);
%% c g初始化 遗传算法
t=cputime;
t=cputime;
ga_option.maxgen = 200;
ga_option.sizepop = 20; 
ga_option.cbound = [0,100];
ga_option.gbound = [0,100];
ga_option.v = 5;
ga_option.ggap = 0.9;
 [bestacc,bestc,bestg] = gaSVMcgForClass(trainlabel,traindata,ga_option);
% bestc=76.47647;
% bestg=1.736547; %%原107维计算出来惩罚参数
% bestc=85.83850;
% bestg=5.78299; %%GA+CFS计算出来惩罚参数


roop_num=100;
for count=1:roop_num
discount=0.9;
k=rand(1,num);
[m,n]=sort(k);
testdata=data(n(num*discount+1:num),2:end);
testlabel=data(n(num*discount+1:num),1);

%% 
% [bestacc,bestc,bestg] =psoSVMcgForClass(trainlabel,traindata);
cmd = ['-s 1 ','-t 2 ','-c ',num2str(bestc),' -g ',num2str(bestg)];
% cmd = ['-s 1 ','-t 2 ','-c ',2,' -g ',1];
%%
 model=svmtrain(trainlabel,traindata,cmd);
 [ptrain,accuracy,acctrain]=svmpredict(trainlabel,traindata,model);
 [ptest,accuracy1,acctest]=svmpredict(testlabel,testdata,model);
 [m,n]=find(testlabel==ptest);
 
 kk=zeros(1,6);
 for right_num=1:size(testlabel,1)
     switch testlabel(right_num)
         case 1
             kk(1,1)=kk(1,1)+1;
         case 2
             kk(1,2)=kk(1,2)+1;    
         case 3
             kk(1,3)=kk(1,3)+1;  
         case 4
             kk(1,4)=kk(1,4)+1;    
         case 5
             kk(1,5)=kk(1,5)+1;    
         case 6
             kk(1,6)=kk(1,6)+1;    
          
     end      
             
 end

k1=zeros(1,6);
 for right_num=1:size(testlabel(m),1)
     switch testlabel(m(right_num))
         case 1
             k1(1,1)=k1(1,1)+1;
         case 2
             k1(1,2)=k1(1,2)+1;    
         case 3
             k1(1,3)=k1(1,3)+1;  
         case 4
             k1(1,4)=k1(1,4)+1;    
         case 5
             k1(1,5)=k1(1,5)+1;    
         case 6
             k1(1,6)=k1(1,6)+1;    
          
     end      
             
 end
 
 picture1(count,:)=testlabel;
 picture2(count,:)=ptest; 
 rate_single(count,:)=k1./kk;
 AA(count)=accuracy1(1,1);
 str=['计算次数',num2str(count)];
 clc;
 disp(str) 
end
time=(cputime-t)/roop_num
rate_single(any(isnan(rate_single),2),:)=[];
rate_s=mean(rate_single)
rata_ma=mean(rate_s)
% rate=mean(AA)

% figure;
% hold on;
% plot(picture1(1,:),'o','LineWidth',1);
% plot(picture2(1,:),'r*','LineWidth',1);
% xlabel('SVM验证GA+CFS方法测试集样本分类图','FontSize',14);
% ylabel('分类标签','FontSize',14);
% legend('实际测试集分类','预测测试集分类');
% % title('SVM验证GA+CFS方法分类图','FontSize',12);
% grid on;