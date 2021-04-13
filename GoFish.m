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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% deal cards %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% ACTUAL GAME CODE %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while ~isempty(YourCards) && ~isempty(CPCards) && ~isempty(Deck)
%%% Your turn%%%%
    input = GetEchoString(window, 'What is the name of the card that you want?', 45, 675, black, white);
    if  strcmp(input, 'jack') == 1 || strcmp(input, 'Jack') == 1
        input = 11;
    elseif strcmp(input, 'queen') == 1 || strcmp(input, 'Queen') == 1
        input = 12;
    elseif strcmp(input, 'king') == 1 || strcmp(input, 'King') == 1
        input = 13;
    elseif strcmp(input, 'ace') == 1 || strcmp(input, 'Ace') == 1
        input = 1;
    else
        input = str2num(input);
    end
    input_equal_CP = ismember(input, CP_cards_num); %determines whether input has equivalent value in CP?s cards, output matrix 
    input_equal_Your = ismember(input, Your_cards_num); %determines where input has equivalent value in Your cards, output matrix 
    YourPoints = 0;
    
    if sum(input_equal_CP) > 0 
		j = find(input_equal_CP, 1); %returns first index in CP deck where value DNE 0
		k = find(input_equal_Your, 1); %returns first index in Your deck where value ~= 0
		YourPoints = YourPoints + 1;
        Your_cards_num(k)  = [];
        Your_cards_str(k) = [];
        Your_cards_suit(k) = [];
        Your_cards(k) = [];
        YourCards(k) = [];
        CP_cards_num(j) = [];
        CP_cards_str(j) = [];
        CP_cards_suit(j) = [];
        CP_cards(j) = [];
        CPCards(j) = [];
    else
        disp('go fish') %%%%%%% TAG TAG TAG PTB text overlay%%%%%%%
        cd =  randperm(length(Deck),1);
        Your_cards = [Your_cards cd]; %concat deck w new card
        Your_cards_num = str2double(Deck(cd));
        for n= 1:length(Your_cards)
   			Your_cards_str(n) = num2str(Your_cards_num(n));
        end
        Deck(cd) = [];
        if cd(1) <= 13 
            Your_cards_suit(length(Your_cards_suit)) = "clubs";
        elseif cd(1) >= 14 && cd(1) <= 26
            Your_cards_suit(length(Your_cards_suit)) = "hearts";
        elseif cd(1) >= 27 && cd(1) <= 39 
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
        YourCards = append(Your_cards,Your_cards_suit);
    end
    
%%% CP Turn
    CP_equal = ismember(CP_cards_num(1), Your_cards_num); %CP asks if player has their first card, generates boolean matrix 
    CPPoints = 0;
    if sum(CP_equal) ~= 0
        i = find(CP_equal, 1);
        CPPoints = CPPoints + 1;
        Your_cards_num(i)  = [];
        Your_cards_str(i) = [];
        Your_cards_suit(i) = [];
        Your_cards(i) = [];
        YourCards(i) = [];
        CP_cards_num(1) = [];
        CP_cards_str(1) = [];
        CP_cards_suit(1) = [];
        CP_cards(1) = [];
        CPCards(1) = [];
    else
        disp(' CP has to go fish') %% PTB text overlay%%
        cdcp =  randperm(length(Deck),1);
        CP_cards = [Your_cards cdcp]; %concat deck w new card
        CP_cards_num = str2double(Deck(cdcp));
        for n= 1:length(CP_cards)
            CP_cards_str(n) = num2str(CP_cards_num(n));
        end
        Deck(cdcp) = [ ];
        if cdcp(1) <= 13 
        	CP_cards_suit(length(CP_cards_suit)) = "clubs";
        elseif cdcp(1) >= 14 && cdcp(1) <= 26
        	CP_cards_suit(length(CP_cards_suit)) = "hearts";
    	elseif cdcp(1) >= 27 && cdcp(1) <= 39 
        	Your_cards_suit(length(Your_cards_suit)) = "diamonds";
        else 
        	Your_cards_suit(length(Your_cards_suit)) = "spades";
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


