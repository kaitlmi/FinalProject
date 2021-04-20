% clear everything (command window, variables, workspace)
sca;
close all;
clc;
clearvars;
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests',1);

%SCREENS SETUP
screens = Screen('Screens');
screenNumber = max(screens);
%COLOR SETUP 
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
%grey = white / 2;    % NOTE TO SELF ---- DO YOU NEED THIS LINE? 
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% SOUNDS SETUP

% Text Setup (size and font) 
Screen('TextSize', window, 85);
% Setup the text font
Screen('TextFont', window,'Euphemia UCAS');


% FLIPPING VARIABLES
[screenXpixels, screenYpixels] = Screen('WindowSize', window); % gets size of the screen (for the size of the window)
ifi = Screen('GetFlipInterval', window); % get flip interval 

% SET BACKGROUND to be the solitaire background
background = imread('SolitaireBackground.png');             % make the background the Solitaire background image
Background_texture = Screen('MakeTexture', window, background);
Screen('DrawTexture', window, Background_texture, [], [0, 0, screenXpixels, screenYpixels], 0); % Sets up card table image

% CREATE DECK --- as a row vector from the 4 suits (to keep track of card color and suit) 
hearts = 1:13; % Color: RED
spades = 1:13; % BLACK
clubs = 1:13; % BLACK
diamonds = 1:13; % RED
full_deck = [hearts;spades;clubs;diamonds];
card_deck = [101:113, 201:213, 301:313, 401:413];

%SHUFFLE DECK (randomize the full_deck vector)
[m,n]=size(full_deck);
card_loc=randperm(n);
randomized_deck=full_deck;
randomized_deck(1,card_loc)=full_deck(1,:);



%initialize game (variable) 
game = true; 
while game == true
    WaitSecs(1)
    DrawFormattedText(window, 'Lets Play Solitaire!', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2)
  

    %%% DISPLAY GAME INSTRUCTIONS %%% 
    DrawFormattedText(window, 'Lets Play Solitaire!', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(3);
   sca;
  
end

Screen('Flip', window);
DrawFormattedText(window, 'Well Played!', 'center', 'center', white);
WaitSecs(2);
Screen('Flip', window);

% DrawFormattedText(window, 'Your Time was, _______ !', 'center', 'center',
% white);  %%% NOTE TO SELF --> NEED TO MAKE THIS A STRING WITH THE TIMER
% READING IN THE BLANK once you set up the timer 
%Screen('Flip', window);
%WaitSecs(2);

sca;
   