sca;
close all;
clearvars;
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 0);

screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
[window, windowRect] = PsychImaging('OpenWindow',screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

ifi = Screen('GetFlipInterval', window);

escapeKey = KbName('a');
upKey = KbName('UpArrow');
downKey = KbName('DownArrow');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');

[xCenter, yCenter] = RectCenter(windowRect);

baseRect = [0 0 200 200];

rectColor = [1 0 0];

squareX = xCenter;
squareY = yCenter;

% Set the amount we want our square to move on each button press
pixelsPerPress = 10;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

Background = imread('Background.png');
imageTexture_Background = Screen('MakeTexture', window, Background);
[d1, d2, d3] = size(Background); % Finding size of picture 
Jae = imread('Jae.png');
imageTexture_Jae = Screen('MakeTexture', window, Jae);
[j1, j2, j3] = size(Jae);
theRect = CenterRectOnPointd([0, 0, 0.5*j1, 0.5*j2], screenXpixels/2, screenYpixels/2);

Screen('DrawTexture', window, imageTexture_Background, [], [0 0 screenXpixels screenYpixels] , 0);
Screen('DrawTexture', window, imageTexture_Jae, [], theRect, 0);
Screen('Flip', window);

KbStrokeWait;
% This is the cue which determines whether we exit the demo
% exitDemo = false;

% Loop the animation until the escape key is pressed
% while exitDemo == false
% 
%     % Check the keyboard to see if a button has been pressed
%     [keyIsDown,secs, keyCode] = KbCheck;
%     [ch, ~] = GetChar;
% 
%     % Depending on the button press, either move ths position of the square
%     % or exit the demo
%     if keyCode(escapeKey)
%         exitDemo = true;
%     elseif keyCode(leftKey)
%         squareX = squareX - pixelsPerPress;
%     elseif keyCode(rightKey)
%         squareX = squareX + pixelsPerPress;
%     elseif keyCode(upKey)
%         squareY = squareY - pixelsPerPress;
%     elseif keyCode(downKey)
%         squareY = squareY + pixelsPerPress;
%     end
% 
%     % We set bounds to make sure our square doesn't go completely off of
%     % the screen
%     if squareX < 0
%         squareX = 0;
%     elseif squareX > screenXpixels
%         squareX = screenXpixels;
%     end
% 
%     if squareY < 0
%         squareY = 0;
%     elseif squareY > screenYpixels
%         squareY = screenYpixels;
%     end
% 
%     % Center the rectangle on the centre of the screen
%     centeredRect = CenterRectOnPointd(baseRect, squareX, squareY);
% 
%     % Draw the rect to the screen
%     Screen('FillRect', window, rectColor, centeredRect);
% 
%     % Flip to the screen
%     vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
% 
% end


% Clear the screen
sca;