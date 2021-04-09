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
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% deal cards %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% YOUR CARDS 
c1 = randperm(length(Deck),5);
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
YourCards = append(Your_cards,Your_cards_suit); %YourCards used to cue visuals
disp(YourCards)
%%%%% CP CARDS 
c2 = randperm(length(Deck),5);
CP_cards = Deck(c2); %Generate matrix of 5 different cards
CP_cards_num = str2double(Deck(c2)); %creates numerical matrix of cards
CP_cards_suit = strings; %initializes suit matrix
CP_cards_str = strings; %creates string of cards 
for n= 1:5
    CP_cards_str(n) = num2str(CP_cards_num(n));
end
Deck(c2) = []; %removes cards from the deck so there are no repeats
for n = 1:5 %for creating a matrix of suits 
    if c2(n) <= 13 
        CP_cards_suit(n) = "clubs";
    elseif c2(n) >= 14 && c2(n) <= 26
        CP_cards_suit(n) = "hearts";
    elseif c2(n) >= 27 && c2(n) <= 39 
        CP_cards_suit(n) = "diamonds";
    else 
        CP_cards_suit(n) = "spades";
    end
end
for n= 1:5 %Substitutes values for actual cards
    if CP_cards(n) == "1"
        CP_cards(n) = "Ace";
    elseif CP_cards(n) == "11"
        CP_cards(n) = "J";
    elseif CP_cards(n) == "12"
        CP_cards(n) = "Q";
    elseif CP_cards(n) == "13"
        CP_cards(n) = "K";
    end 
end 
CPCards = append(CP_cards,CP_cards_suit);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% ACTUAL GAME CODE %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while length(YourCards) > 0 && length(CPCards) > 0 
%%% Your turn%%%%
for n = 1: length(CP_cards_num) 
    if input = CP_cards_num(n)
        YourPoints = YourPoints + 1;
        CP_cards_num(n)  = [ ];
        CP_cards_str(n) = [ ];
        CP_cards_suit(n) = [ ];
        CP_cards(n) = [ ];
        CPCards(n) = [ ];
        Index_input = find(Your_cards_num == input);
        Your_cards_num(Index_input) = [ ];
        Your_cards_str(Index_input) = [ ];
        Your_cards_suit(Index_input) = [ ];
        Your_cards(Index_input) = [ ];
        YourCards(Index_input) = [ ];
    else
        disp(' go fish') %% PTB text overlay%%
        cd =  randperm(length(Deck),1
        Your_cards = [Your_cards cd)] %concat deck w new card
        Your_cards_num = str2double(Deck(c1));
        Your_cards_str(n) = num2str(Your_cards_num(n));
        Deck(cd) = [ ];
        if cd(1) <= 13 
            Your_cards_suit(length(Your_cards_suit)) = "clubs";
   		elseif cd(1) >= 14 && cd(1) <= 26
            Your_cards_suit(length(Your_cards_suit)) = "hearts";
        elseif cd(n) >= 27 && cd(n) <= 39 
            Your_cards_suit(length(Your_cards_suit)) = "diamonds";
        else 
            Your_cards_suit(length(Your_cards_suit)) = "spades";
        end
        if Your_cards(length(Your_cards)) == "1"
            Your_cards(length(Your_cards)) = "Ace";
        elseif Your_cards(length(Your_cards)) == "11"
            Your_cards(length(Your_cards)) = "J";
        elseif Your_cards(length(Your_cards)) == "12"
            Your_cards(length(Your_cards)) = "Q";
        elseif Your_cards(length(Your_cards)) == "13"
            Your_cards(length(Your_cards)) = "K";
        end 
        YourCards = append(Your_cards,Your_cards_suit)
    end
end 
