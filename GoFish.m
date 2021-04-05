% Clears command window, workspace, and variables
sca;
close all;
clc;
clearvars;
Deck = [];
Screen('Preference', 'SkipSyncTests',1);

% sets up screens
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


% create card 'stack' that is row vector of card values 
Deck = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13" ]; %Generate matrix of 52 cards
Deck = repmat(Deck, 1, 4);
Deck = Deck';
Deck(:);
Deck = reshape(Deck, 1, []);

% deal cards
c1 = randi(length(Deck),3);
Your_cards = Deck(c1); %Generate matrix of 9 different cards
Your_cards_num = str2double(Deck(c1)); %creates numerical matrix of cards
for n= 1:9
    if Your_cards(n) == "1"
        Your_cards(n) = "Ace";
    elseif Your_cards(n) == "11"
        Your_cards(n) = "J";
    elseif Your_cards(n) == "12"
        Your_cards(n) = "Q";
    elseif Your_cards(n) == "13"
        Your_cards(n) = "K";
    end 
end 
Your_cards_str = mat2str(Your_cards);
disp(strcat('your cards are', Your_cards_str));
Deck(c1) = [];


c2 = randi(length(Deck),3);
CP_cards = Deck(c2); %Generate matrix of 9 different cards
Deck(c2) = [];

% Opening a black window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
% Getting the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% Getting flip interval
ifi = Screen('GetFlipInterval', window);
table = imread('table.jpeg'); % table background
imageTexture_table = Screen('MakeTexture', window, table);
Screen('DrawTexture', window, imageTexture_table, [], [], 0); % Sets up image of an elevator going up
Screen('Flip', window); % Flips to the image of an elevator going up.
WaitSecs(3)

