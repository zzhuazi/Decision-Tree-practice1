clear all; close all; clc
%获得训练集中的字母
[trainone,txt] = xlsread('letter-recognition.xls','A1:A4000');
%获得训练集中的1-16个特征
traintwo = xlsread('letter-recognition.xls','B1:Q4000');
%训练
t=treefit(traintwo,txt);
%显示决策树
treedisp(t);

%计算c,s,n（节点个数？）,best（最优的裁剪层次）
%[c,s,n,best]=treetest(t,'cost',traintwo,txt);
%裁剪
%t2=treeprune(t,'level',best);
%treedisp(t2);
%画出错误率图
%[mincost,minloc] = min(c);
%plot(n,c,'b-o',...
%    n(best+1),c(best+1),'bs',...
%    n,(mincost+s(minloc))*ones(size(n)),'k--');
%    xlabel('Tree size (number of terminal nodes)')
%    ylabel('Cost')


%获得测试集数据（如果先进行裁剪再进行测试，错误率会更低？）
test = xlsread('test-recognition.xls','A1:P16000');
%用决策树t测试
[result,node,cname] = treeval(t,test);
%将结果写入到excel文件中
xlswrite('2-letter.xls',cname);

%取出测试的结果
[result2,txt2]=xlsread('9-letter.xls','A1:A16000');

%绘制错误率图
[c,s,n,best]=treetest(t,'cost',test,txt2);
[mincost,minloc] = min(c);
plot(n,c,'b-o',...
    n(best+1),c(best+1),'bs',...
    n,(mincost+s(minloc))*ones(size(n)),'k--');
    xlabel('Tree size (number of terminal nodes)')
    ylabel('Cost')