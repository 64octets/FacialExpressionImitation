%Matlab Script

%开始黑屏时长设置

TimeBlackScreen = 3 ;%秒;

%倒计时时长设置

TimeCountDown = 3 ;%秒


%图片显示时长

TimeShowImage = 2 ;%秒


%表情模仿时长

TimeImitation = 2 ;%秒

%表情维持时长

TimeKeep = 2 ;%秒

%休息时长（一次实验不同情绪间隔休息时间）

TimeBreak = 5 ; %秒



%实验循环次数（六种情绪过一遍为一个Trial）

NumTrials = 1 ;

%参数有效性判断


if isnum (TimeBlackScreen) && isnum (TimeCountDown) && isnum (TimeShowImage) &&...
   isnum (TimeImitation)   && isnum (TimeKeep)      && isnum (TimeBreak)     &&...
   isnum (NumLoop)  ...                              %判断输入参数是否为数值 
   &&  ...
   TimeBlackScreen>0 && TimeCountDown>0 &&TimeShowImage>0    && TimeImitation>0 &&...
   TimeKeep>0        && TimeBreak>0     && TimeBlackScreen>0 && NumLoop>0 ...
   &&  ...                                           %判断输入参数是否为正数
   NumLoop==fix(NumLoop)                             %判断循环次数是否为整数
   
   
	disp('参数设定完成！');

else 

errordlg('参数设置有误！','Error');	
return;
  
end
  









