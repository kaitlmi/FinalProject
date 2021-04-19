% clear (command window, variables and workspace) 
sca;
close all;
clc;
clearvars;
Deck = [];
Screen('CloseAll')
Screen('Preference', 'SkipSyncTests',1);

% set up screens
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

%variables for flipping
[~, ~] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);
[screenXpixels, screenYpixels] = Screen('WindowSize', window); % sets size of the window to that of the screen
ifi = Screen('GetFlipInterval', window); % get flip interval 

% make background card table 
table = imread('table.jpeg'); 
imageTexture_table = Screen('MakeTexture', window, table);
Screen('DrawTexture', window, imageTexture_table, [], [0, 0, screenXpixels, screenYpixels], 0); % Sets up image of table
WaitSecs(2)
DrawFormattedText(window, 'Ready to Play?', 'center', 'center', white);
WaitSecs(1)

%create the deck from the 4 suits (to keep track of card color and suit) 
hearts = 1:13; % Color: RED
spades = 1:13; % BLACK
clubs = 1:13; %BLACK
diamonds = 1:13; %RED
full_deck = [hearts,spades,clubs,diamonds];


