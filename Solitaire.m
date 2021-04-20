% clear everything (before starting) 
sca;
close all;
clc;
clearvars;
Deck = [];
Screen('CloseAll')
Screen('Preference', 'SkipSyncTests',1);

%screens setup
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

%flipping variables
[~, ~] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', window);
rr = FrameRate(window);
[screenXpixels, screenYpixels] = Screen('WindowSize', window); % sets size of the window to that of the screen
ifi = Screen('GetFlipInterval', window); % get flip interval 

% set background to be the solitaire background
background = imread('SolitaireBackground.png');             % make the background the Solitaire background image
Background_texture = Screen('MakeTexture', window, background);
Screen('DrawTexture', window, Background_texture, [], [0, 0, screenXpixels, screenYpixels], 0); % Sets up card table image
WaitSecs(2)
DrawFormattedText(window, 'Ready to Play?', 'center', 'center', white);
WaitSecs(2)

%create the deck as a row vector from the 4 suits (to keep track of card color and suit) 
hearts = 1:13; % Color: RED
spades = 1:13; % BLACK
clubs = 1:13; % BLACK
diamonds = 1:13; % RED
full_deck = [hearts,spades,clubs,diamonds];



%initialize game (variable) 
game = true; 

while game == true
    
    
end



   
