% Clear the workspace and the screen
close all;

sca;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);



% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens');

% To draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen.
ScreenNumber = max(screens);

% Define black and white (white will be 1 and black 0). This is because
% in general luminace values are defined between 0 and 1 with 255 steps in
% between. All values in Psychtoolbox are defined between 0 and 1
white = WhiteIndex(ScreenNumber);
black = BlackIndex(ScreenNumber);

try
%%    

%Label Output via PortTalk


    % Open an on screen window using PsychImaging.
    [window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);


    % Get the size of the on screen window
    [ScreenXpixels, ScreenYpixels] = Screen('WindowSize', window);
    
    % Get the centre coordinate of the window
    [XCenter, YCenter] = RectCenter(WindowRect);
    
    
    % Query the frame duration
    ifi = Screen('GetFlipInterval', window);
    ScreenRefreshRate= round(1/ifi);
	
    %计算不同时间段帧数
    
	NumBlackScreenFrames=round(TimeBlackScreen*ScreenRefreshRate);
	
	NumCountDownFrames=round(TimeCountDown*ScreenRefreshRate);
	
	NumShowImageFrames=round(TimeShowImage*ScreenRefreshRate);
	
	NumImitationFrames=round(TimeImitation*ScreenRefreshRate);
	
	NumKeepFrames=round(TimeKeep*ScreenRefreshRate);
	
	NumBreakFrames=round(TimeBreak*ScreenRefreshRate);
    
    
    % Numer of frames to wait when specifying good timing
    WaitFrames = 1;
    
    
    
    
    
    %设置窗口对象的字体和大小
    Screen('TextFont', window, 'TimesNewRoman');
    Screen('TextSize', window, 40);
    
    vbl = Screen('Flip',window);
    
    
  
   
    
    

    for frame=1:NumBlackScreenFrames
        
    if frame == 1
    %lptwrite调用porttalk模块进行并口输出，53264为并口（LPT）地址，1为并口输出的内容 
    % 1：表示黑屏开始
    % 2：表示倒计时开始
    % 3：表示表情显示阶段 
        % 31：代表情绪1
        % 32：代表情绪2
        % 33：代表情绪3
        % 34：代表情绪4
        % 35：代表情绪5
        % 36：代表情绪6
    % 4：表示表情模仿阶段
    % 5：表示表情维持阶段
    % 6：表示休息阶段
    
   
    %黑屏开始标记  
    lptwrite(53264,1);
        
    elseif frame == round(NumBlackScreenFrames/2)
    
    lptwrite(53264,0);    
    
    end    
        
    Screen('DrawingFinished', window);
    vbl = Screen('Flip', window, vbl + (WaitFrames - 0.5) * ifi);    


    end 

    for trial=1:NumTrials  
        
 
        
        for i=1:NumCountDownFrames
            
            if frame == 1
            
            %倒计时开始标记  
            lptwrite(53264,2);

            elseif frame == round(NumBlackScreenFrames/2)

            lptwrite(53264,0);    

            end    
            
            
            DrawFormattedText(window,num2str(fix(frame/ScreenRefreshRate)), 'center', 'center', white);

            Screen('DrawingFinished', window);      
            vbl = Screen('Flip', window, vbl + (WaitFrames - 0.5) * ifi); 


        end
        
        for i=1:NumShowImageFrames
            
            
            if frame == 1
            
            %倒计时开始标记  
            lptwrite(53264,3);
            
            elseif frame == round(NumBlackScreenFrames*(1/4))
                
            lptwrite(53264,0);

            elseif frame == round(NumBlackScreenFrames*(2/4))
                
            lptwrite(53264,30+);
            
            elseif frame == round(NumBlackScreenFrames*(3/4))
                
            lptwrite(53264,0);
                
               

            end    

            Screen('DrawingFinished', window);
            vbl = Screen('Flip', window, vbl + (WaitFrames - 0.5) * ifi); 





        end
        
         for i=1:NumImitationFrames
             
             
            if frame == 1
            
            %表情模仿开始标记  
            lptwrite(53264,4);

            elseif frame == round(NumBlackScreenFrames/2)

            lptwrite(53264,0);    

            end    

            Screen('DrawingFinished', window);
            vbl = Screen('Flip', window, vbl + (WaitFrames - 0.5) * ifi); 

         end
        
         for i=1:NumKeepFrames
             
            if frame == 1
            
            %表情保持开始标记  
            lptwrite(53264,5);

            elseif frame == round(NumBlackScreenFrames/2)

            lptwrite(53264,0);    

            end    

            Screen('DrawingFinished', window);
            vbl = Screen('Flip', window, vbl + (WaitFrames - 0.5) * ifi); 





         end
         
          for i=1:NumBreakFrames
              
            if frame == 1
            
            %休息开始标记  
            lptwrite(53264,6);

            elseif frame == round(NumBlackScreenFrames/2)

            lptwrite(53264,0);    

            end    

            Screen('DrawingFinished', window);
            vbl = Screen('Flip', window, vbl + (WaitFrames - 0.5) * ifi); 


         end
        
        
        
    end 
        



    %Customize number of Trial
    NumTrial=2;


    
    
    % Numer of frames to wait when specifying good timing
    WaitFrames = 1;

    
    
    %设置窗口对象的字体和大小
    Screen('TextFont', window, '微软雅黑');
    Screen('TextSize', window, 40);
    
    
    % Retreive the maximum priority number
    TopPriorityLevel = MaxPriority(window);
    Priority(TopPriorityLevel);

   
   
 %%
    
   
    for trial = 1:NumTrial
        
        DrawFormattedText(window,'Press Any Key to Start', 'center', 'center', white);
        Screen('DrawingFinished', window);
        vbl = Screen('Flip', window);
        pause;
         
        tic;    
        for frame = 1:NumFlickeringFrames
                
            Screen('FillRect', window, SequenceColor(frame),PosCenteredSquare);

     
            % tell PTB that no more drawing commands will be given between coloring the
            % screen and the flip command. This, under some circumstances, can help
            % acheive good timing.
            % Tell PTB no more drawing commands will be issued until the next flip
            Screen('DrawingFinished', window);

            % Flip to the screen
            vbl = Screen('Flip', window, vbl + (WaitFrames - 0.5) * ifi);
            if frame==1 
            putvalue(ParallelPort,Line(1:8),1); %闪烁开始标记点
            
            elseif frame==round(NumFlickeringFrames/2)
                
            putvalue(ParallelPort,Line(1:8),0);
            end
       end
       toc
       
       tic;

        for frame = 1:NumRestFrames
            
            % Tell PTB no more drawing commands will be issued until the next flip
            Screen('DrawingFinished', window);

            % Flip to the screen
            vbl = Screen('Flip', window, vbl + (WaitFrames - 0.5) * ifi);
            
            if frame==1 
  
            
            elseif frame==round(NumRestFrames/2)
                
            
            end

        end
        
        
        toc


    end
    Priority(0);

catch exception
    
    Priority(0);    
    
    sca;
    
    rethrow(exception);
   

    
    

end




% Clear the screen.
% close all;
% clear all;
sca;



    
    
    
