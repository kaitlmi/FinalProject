%%%%% To the TA's: Hi, I'm Kaitlyn, and I coded and debugged this in its
%%%%% entirety (with help from Lakshmi, an absolute legend) 
%%%%% I was pretty bad at reporting the hours, unfortunately, so
%%%%% I didn't end up doing that.


% Clears command window, workspace, and variables
sca;
close all;
clc;
clearvars;
Deck = [];
Screen('CloseAll')
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
% Getting the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% Getting flip interval
ifi = Screen('GetFlipInterval', window);
table = imread('table.jpeg'); % table background
imageTexture_table = Screen('MakeTexture', window, table);
Screen('DrawTexture', window, imageTexture_table, [], [0, 0, screenXpixels, screenYpixels], 0); % Sets up image of table
WaitSecs(2)
DrawFormattedText(window, 'Here are your cards.', 'center', 'center', white);
WaitSecs(1)


% create card 'stack' that is row vector of card values
Deck = [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13" ]; %Generate matrix of 52 cards
Deck = repmat(Deck, 1, 4);
Deck = Deck';
Deck(:);
Deck = reshape(Deck, 1, []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% deal cards %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% YOUR CARDS
c1 = randperm(length(Deck),5);
Your_cards = Deck(c1); %Generate matrix of 9 different cards
Your_cards_num = str2double(Deck(c1)); %creates numerical matrix of cards
Your_cards_suit = strings; %initializes suit matrix
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


%%%%%%%%%%%%%%%%%%%%%%
% Maximum priority level
baseRect = [0 0 200 200];
rectColor = [1 0 0];
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);
table = imread('table.jpeg');
imageTexture_table = Screen('MakeTexture', window, table);
Back = imread('backofcard.png');
imageTexture_Back = Screen('MakeTexture', window, Back);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% CP CARDS %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Back = imread('backofcard.png');
[k1, k2, k3] = size(Back);
%RectB = CenterRectOnPointd([0, 0, 0.5*k1, 0.5*k2], r, 900);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ACTUAL GAME CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while ~isempty(YourCards) && ~isempty(CPCards) && ~isempty(Deck)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%% DISPLAYS CARDS IN ORIGINAL DECK %%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Screen('DrawTexture', window, imageTexture_table, [], [0, 0, screenXpixels, screenYpixels], 0);
    RenderCardsFaceUp(Your_cards, YourCards, window);
    RenderCardsFaceDown(CP_cards, window)

    %%% Your turn%%%%
    input = GetEchoString(window, 'What is the name of the card that you want?', 45, 800, black, white);
    if  strcmp(input, 'jack') == 1 || strcmp(input, 'Jack') == 1 || strcmp(input, 'J') == 1 || strcmp(input, 'j') == 1
        input = 11;
    elseif strcmp(input, 'queen') == 1 || strcmp(input, 'Queen') == 1 || strcmp(input, 'Q') == 1 || strcmp(input, 'q') == 1
        input = 12;
    elseif strcmp(input, 'king') == 1 || strcmp(input, 'King') == 1 || strcmp(input, 'K') == 1 || strcmp(input, 'k') == 1
        input = 13;
    elseif strcmp(input, 'ace') == 1 || strcmp(input, 'Ace') == 1 || strcmp(input, 'A') == 1 || strcmp(input, 'a') == 1
        input = 1;
    else
        input = str2num(input);
    end
    input_equal_CP = ismember(CP_cards_num, input); %determines whether input has equivalent value in CP?s cards, output matrix
    input_equal_Your = ismember(Your_cards_num, input); %determines where input has equivalent value in Your cards, output matrix
    YourPoints = 0;
    if sum(input_equal_CP) > 0 %your card matches one of CP's cards
        Screen('DrawTexture', window, imageTexture_table, [], [0, 0, screenXpixels, screenYpixels], 0);
        RenderCardsFaceUp(Your_cards, YourCards, window);
        RenderCardsFaceDown(CP_cards, window)
        DrawFormattedText(window, 'You found a match!', 'center', 'center', black);
        Screen('Flip', window)
        WaitSecs(1.5)
        j = find(input_equal_CP, 1); %returns first index in CP deck where value DNE 0
        k = find(input_equal_Your, 1); %returns first index in Your deck where value ~= 0
        YourPoints = YourPoints + 1;
        Your_cards_num(k)  = [];
        Your_cards_suit(k) = [];
        Your_cards(k) = [];
        YourCards(k) = [];
        CP_cards_num(j) = [];
        CP_cards_suit(j) = [];
        CP_cards(j) = [];
        CPCards(j) = [];
    else
        %Screen('Flip', window)
        Screen('DrawTexture', window, imageTexture_table, [], [0, 0, screenXpixels, screenYpixels], 0);
        RenderCardsFaceUp(Your_cards, YourCards, window);
        RenderCardsFaceDown(CP_cards, window)
        DrawFormattedText(window, 'Go Fish!', 'center', 'center', black);
        Screen('Flip', window)
        WaitSecs(1.5)
        cy = randperm(length(Deck),1);
        Your_cards = [Your_cards Deck(cy)]; %concat deck w new card
        Your_cards_num = str2double(Your_cards);
        if cy(1) <= 13
            Your_cards_suit = [Your_cards_suit "clubs"];
        elseif cy(1) >= 14 && cy(1) <= 26
            Your_cards_suit = [Your_cards_suit "hearts"];
        elseif cy(1) >= 27 && cy(1) <= 39
            Your_cards_suit = [Your_cards_suit "diamonds"];
        else
            Your_cards_suit = [Your_cards_suit "spades"];
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
        for r = 1:length(Your_cards) %tag
            if Deck(cy) == Your_cards(r)
                Screen('DrawTexture', window, imageTexture_table, [], [0, 0, screenXpixels, screenYpixels], 0);
                RenderCardsFaceUp(Your_cards, YourCards, window);
                RenderCardsFaceDown(CP_cards, window)
                DrawFormattedText(window, 'You drew a match!', 'center', 'center', black);
                Screen('Flip', window)
                WaitSecs(1.5)
                Your_cards(r) = [];
                Your_cards(length(Your_cards)) = [];
                Your_cards_num(r) = [];
                Your_cards_num(length(Your_cards_num)) = [];
                Your_cards_suit(r) = [];
                Your_cards_suit(length(Your_cards_suit)) = [];
                YourPoints = YourPoints +1
            end
        end
        Deck(cy) = [];
        YourCards = append(Your_cards,Your_cards_suit);        
    end
    
    %%% CP Turn
    CP_equal = ismember(CP_cards_num(1), Your_cards_num); %CP asks if player has their first card, generates boolean matrix
    CPPoints = 0;
    if sum(CP_equal) ~= 0
        Screen('DrawTexture', window, imageTexture_table, [], [0, 0, screenXpixels, screenYpixels], 0);
        RenderCardsFaceUp(Your_cards, YourCards, window);
        RenderCardsFaceDown(CP_cards, window)
        DrawFormattedText(window, 'CP has found a match! Your turn.', 'center', 'center', black);
        Screen('Flip', window)
        WaitSecs(1.5)
        i = find(CP_equal, 1);
        CPPoints = CPPoints + 1;
        Your_cards_num(i)  = [];
        Your_cards_suit(i) = [];
        Your_cards(i) = [];
        YourCards(i) = [];
        CP_cards_num(1) = [];
        CP_cards_suit(1) = [];
        CP_cards(1) = [];
        CPCards(1) = [];
    else
        Screen('DrawTexture', window, imageTexture_table, [], [0, 0, screenXpixels, screenYpixels], 0);
        RenderCardsFaceUp(Your_cards, YourCards, window);
        RenderCardsFaceDown(CP_cards, window)
        DrawFormattedText(window, 'CP has gone fishing. Your turn!', 'center', 'center', black);
        Screen('Flip', window)
        WaitSecs(1.5)
        cdcp =  randperm(length(Deck),1);
        CP_cards = [CP_cards Deck(cdcp)]; %concat deck w new card
        CP_cards_num = str2double(CP_cards);
        Deck(cdcp) = [];
        if cdcp(1) <= 13
            CP_cards_suit= [CP_cards_suit "clubs"];
        elseif cdcp(1) >= 14 && cdcp(1) <= 26
            CP_cards_suit= [CP_cards_suit "hearts"];
        elseif cdcp(1) >= 27 && cdcp(1) <= 39
            CP_cards_suit= [CP_cards_suit "diamonds"];
        else
            CP_cards_suit= [CP_cards_suit "spades"];
        end
        if CP_cards(length(CP_cards)) == "1"
            CP_cards(length(CP_cards)) = "Ace";
        elseif CP_cards(length(CP_cards)) == "11"
            CP_cards(length(CP_cards)) = "J";
        elseif CP_cards(length(CP_cards)) == "12"
            CP_cards(length(CP_cards)) = "Q";
        elseif CP_cards(length(CP_cards)) == "13"
            CP_cards(length(CP_cards)) = "K";
        end
        CPCards = append(CP_cards,CP_cards_suit);
    end
end
