%Matlab Script

%��ʼ����ʱ������

TimeBlackScreen = 3 ;%��;

%����ʱʱ������

TimeCountDown = 3 ;%��


%ͼƬ��ʾʱ��

TimeShowImage = 2 ;%��


%����ģ��ʱ��

TimeImitation = 2 ;%��

%����ά��ʱ��

TimeKeep = 2 ;%��

%��Ϣʱ����һ��ʵ�鲻ͬ���������Ϣʱ�䣩

TimeBreak = 5 ; %��



%ʵ��ѭ������������������һ��Ϊһ��Trial��

NumTrials = 1 ;

%������Ч���ж�


if isnum (TimeBlackScreen) && isnum (TimeCountDown) && isnum (TimeShowImage) &&...
   isnum (TimeImitation)   && isnum (TimeKeep)      && isnum (TimeBreak)     &&...
   isnum (NumLoop)  ...                              %�ж���������Ƿ�Ϊ��ֵ 
   &&  ...
   TimeBlackScreen>0 && TimeCountDown>0 &&TimeShowImage>0    && TimeImitation>0 &&...
   TimeKeep>0        && TimeBreak>0     && TimeBlackScreen>0 && NumLoop>0 ...
   &&  ...                                           %�ж���������Ƿ�Ϊ����
   NumLoop==fix(NumLoop)                             %�ж�ѭ�������Ƿ�Ϊ����
   
   
	disp('�����趨��ɣ�');

else 

errordlg('������������','Error');	
return;
  
end
  









