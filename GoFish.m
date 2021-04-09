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
% Opening a black window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
% Getting the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% Getting flip interval
ifi = Screen('GetFlipInterval', window);
table = imread('table.jpeg'); % table background
imageTexture_table = Screen('MakeTexture', window, table);
Screen('DrawTexture', window, imageTexture_table, [], [0, 0, screenXpixels, screenYpixels], 0); % Sets up image of table
Screen('Flip', window); % Flips to the image of table
WaitSecs(3)
DrawFormattedText(window, 'Here are your cards.', 'center', 'center', white);
Screen('Flip', window);

% create card 'stack' that is row vector of card values 
Deck = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13" ]; %Generate matrix of 52 cards
Deck = repmat(Deck, 1, 4);
Deck = Deck';
Deck(:);
Deck = reshape(Deck, 1, []);

% deal cards
c1 = randperm(length(Deck),5);
disp(c1)
Your_cards = Deck(c1); %Generate matrix of 9 different cards
Your_cards_num = str2double(Deck(c1)); %creates numerical matrix of cards
Your_cards_suit = strings; %initializes suit matrix
Your_cards_str = strings; %creates string of cards 
for n= 1:5
    Your_cards_str(n) = num2str(Your_cards_num(n));
end
Deck(c1) = []; %removes cards from the deck so there are no repeats

for n = 1:5 %for creating a matrix of suits 
    if c1(n) <= 13 
        Your_cards_suit(n) = "clubs";
    elseif c1(n) >= 14 && c1(n) <= 26
        Your_cards_suit(n) = "hearts";
    elseif c1(n) >= 27 && c1(n) <= 39 
        Your_cards_suit(n) = "diamonds";
    else 
        Your_cards_suit(n) = "spades";
    end
end

YourCards =  strings;

for n = 1:10
    if mod(n,2) == 1 
        YourCards(n) = Your_cards_str((n+1)/2);  
    else
        YourCards(n) = Your_cards_suit(n/2);
    end
end

for n= 1:5 %Substitutes values for actual cards
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

disp(YourCards)


c2 = randperm(length(Deck),5);
CP_cards = Deck(c2); %Generate matrix of 5 different cards
Deck(c2) = [];
disp(CP_cards);


