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

    % Query the frame duration
    ifi = Screen('GetFlipInterval', window);

    % Get the centre coordinate of the window
    [XCenter, YCenter] = RectCenter(WindowRect);
    %Customize the Size of the Flickering Square (pixel)
    SizeSquare=250;
    PosBaseSquare=[0,0,SizeSquare,SizeSquare];
    PosCenteredSquare=CenterRectOnPointd(PosBaseSquare,XCenter,YCenter);

    % Length of time and number of frames 

    %Customize duration of Flickering per Trial

    SecFlickering = 3;
    NumFlickeringFrames = round(SecFlickering/ ifi);
    SequenceColor=ones(1,NumFlickeringFrames )*black;



for j=0:round((1/ifi)/FreqFlickering/2)-1

    for i=1:NumFlickeringFrames
       if mod(i+j,round((1/ifi)/FreqFlickering))==0          

           SequenceColor(i)=white;

       end


    end
end
    %Customize duration of Rest between Trials

    SecRest = 2;

    NumRestFrames = round(SecRest/ ifi);



    %Customize number of Trial
    NumTrial=2;


    
    
    % Numer of frames to wait when specifying good timing
    WaitFrames = 1;

    Screen('Preference','SkipSyncTests', 0);
    
    
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
%             DrawFormattedText(window,'4', 'center', 'center', black);
     
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



    
    
    
