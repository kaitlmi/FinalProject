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
%[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
% Getting the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% Getting flip interval
ifi = Screen('GetFlipInterval', window);
table = imread('table.jpeg'); % table background
imageTexture_table = Screen('MakeTexture', window, table);
Screen('DrawTexture', window, imageTexture_table, [], [0, 0, screenXpixels, screenYpixels], 0); % Sets up image of table
WaitSecs(1)
DrawFormattedText(window, 'Here are your cards.', 'center', 'center', white);
WaitSecs(3)
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
[d1, d2, d3] = size(table); % Finding size of picture

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% DISPLAYS CARDS IN ORIGINAL DECK %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[j1, j2, j3] = size(AceC);
for n = 1:length(Your_cards)
	r = 300 + (n*100);
    Rect = CenterRectOnPointd([0, 0, 0.5*j1, 0.5*j2], r, 300);
end
for n = 1:length(Your_cards)
    if strcmp(YourCards(n), 'Aceclubs') == 1
		AceC = imread('ace_of_clubs.png');
		imageTexture_AceC = Screen('MakeTexture', window, AceC);
        Screen('DrawTexture', window, imageTexture_AceC, [], Rect1, 0);
	elseif strcmp(YourCards(n), 'Acespades') == 1
		AceS = imread('ace_of_spades.png');
		imageTexture_AceS = Screen('MakeTexture', window, AceS);
        Screen('DrawTexture', window, imageTexture_AceS, [], Rect1, 0);
    elseif strcmp(YourCards(n), 'Acehearts') == 1
		AceH = imread('ace_of_hearts.png');
		imageTexture_AceH = Screen('MakeTexture', window, AceH);
	elseif strcmp(YourCards(n), 'Acediamonds') == 1
		AceD = imread('ace_of_diamonds.png');
		imageTexture_AceD = Screen('MakeTexture', window, AceD);
%%%%% TWOS %%%%
    elseif strcmp(YourCards(n), '2clubs') == 1
		twoC = imread('2_of_clubs.png');
		imageTexture_2C= Screen('MakeTexture', window, twoC);
	elseif strcmp(YourCards(n), '2spades') == 1
		twoS = imread('2_of_spades.png');
		imageTexture_2S = Screen('MakeTexture', window, twoS);
    elseif strcmp(YourCards(n), '2hearts') == 1
		twoH = imread('2_of_hearts.png');
		imageTexture_2H = Screen('MakeTexture', window, twoH);
	elseif strcmp(YourCards(n), '2diamonds') == 1
		twoD = imread('2_of_diamonds.png');
		imageTexture_2D = Screen('MakeTexture', window, twoD);
%%%%% THREES %%%%
    elseif strcmp(YourCards(n), '3clubs') == 1
		threeC = imread('3_of_clubs.png');
		imageTexture_3C= Screen('MakeTexture', window, threeC);
	elseif strcmp(YourCards(n), '3spades') == 1
		threeS = imread('3_of_spades.png');
		imageTexture_3S = Screen('MakeTexture', window, threeS);
    elseif strcmp(YourCards(n), '3hearts') == 1
		threeH = imread('3_of_hearts.png');
		imageTexture_3H = Screen('MakeTexture', window, threeH);
	elseif strcmp(YourCards(n), '3diamonds') == 1
		threeD = imread('3_of_diamonds.png');
		imageTexture_3D = Screen('MakeTexture', window, threeD);
%%%%% FOURS %%%%
    elseif strcmp(YourCards(n), '4clubs') == 1
		fourC = imread('4_of_clubs.png');
		imageTexture_4C= Screen('MakeTexture', window, fourC);
	elseif strcmp(YourCards(n), '4spades') == 1
		fourS = imread('4_of_spades.png');
		imageTexture_4S = Screen('MakeTexture', window, fourS);
    elseif strcmp(YourCards(n), '4hearts') == 1
		fourH = imread('4_of_hearts.png');
		imageTexture_4H = Screen('MakeTexture', window, fourH);
	elseif strcmp(YourCards(n), '4diamonds') == 1
		fourD = imread('4_of_diamonds.png');
		imageTexture_4D = Screen('MakeTexture', window, fourD);
%%%%% FIVES %%%%
    elseif strcmp(YourCards(n), '5clubs') == 1
		fiveC = imread('5_of_clubs.png');
		imageTexture_5C= Screen('MakeTexture', window, fiveC);
	elseif strcmp(YourCards(n), '5spades') == 1
		fiveS = imread('5_of_spades.png');
		imageTexture_5S = Screen('MakeTexture', window, fiveS);
    elseif strcmp(YourCards(n), '5hearts') == 1
		fiveH = imread('5_of_hearts.png');
		imageTexture_5H = Screen('MakeTexture', window, fiveH);
	elseif strcmp(YourCards(n), '5diamonds') == 1
		fiveD = imread('5_of_diamonds.png');
		imageTexture_5D = Screen('MakeTexture', window, fiveD);
%%%%% SIXES %%%%
    elseif strcmp(YourCards(n), '6clubs') == 1
		sixC = imread('6_of_clubs.png');
		imageTexture_6C= Screen('MakeTexture', window, sixC);
	elseif strcmp(YourCards(n), '6spades') == 1
		sixS = imread('6_of_spades.png');
		imageTexture_6S = Screen('MakeTexture', window, sixS);
    elseif strcmp(YourCards(n), '6hearts') == 1
		sixH = imread('6_of_hearts.png');
		imageTexture_6H = Screen('MakeTexture', window, sixH);
	elseif strcmp(YourCards(n), '6diamonds') == 1
		sixD = imread('6_of_diamonds.png');
		imageTexture_6D = Screen('MakeTexture', window, sixD);
%%%%% SEVENS %%%%
    elseif strcmp(YourCards(n), '7clubs') == 1
		sevenC = imread('7_of_clubs.png');
		imageTexture_7C= Screen('MakeTexture', window, sevenC);
	elseif strcmp(YourCards(n), '7spades') == 1
		sevenS = imread('7_of_spades.png');
		imageTexture_7S = Screen('MakeTexture', window, sevenS);
    elseif strcmp(YourCards(n), '7hearts') == 1
		sevenH = imread('7_of_hearts.png');
		imageTexture_7H = Screen('MakeTexture', window, sevenH);
	elseif strcmp(YourCards(n), '7diamonds') == 1
		sevenD = imread('7_of_diamonds.png');
		imageTexture_7D = Screen('MakeTexture', window, sevenD);
%%%%% EIGHTS %%%%
    elseif strcmp(YourCards(n), '8clubs') == 1
		eightC = imread('8_of_clubs.png');
		imageTexture_8C= Screen('MakeTexture', window, eightC);
	elseif strcmp(YourCards(n), '8spades') == 1
		eightS = imread('8_of_spades.png');
		imageTexture_8S = Screen('MakeTexture', window, eightS);
    elseif strcmp(YourCards(n), '8hearts') == 1
		eightH = imread('8_of_hearts.png');
		imageTexture_8H = Screen('MakeTexture', window, eightH);
	elseif strcmp(YourCards(n), '8diamonds') == 1
		eightD = imread('8_of_diamonds.png');
		imageTexture_8D = Screen('MakeTexture', window, eightD);
%%%%% NINES %%%%
    elseif strcmp(YourCards(n), '9clubs') == 1
		nineC = imread('9_of_clubs.png');
		imageTexture_9C= Screen('MakeTexture', window, nineC);
	elseif strcmp(YourCards(n), '9spades') == 1
		nineS = imread('9_of_spades.png');
		imageTexture_9S = Screen('MakeTexture', window, nineS);
    elseif strcmp(YourCards(n), '9hearts') == 1
		nineH = imread('9_of_hearts.png');
		imageTexture_9H = Screen('MakeTexture', window, nineH);
	elseif strcmp(YourCards(n), '9diamonds') == 1
		nineD = imread('9_of_diamonds.png');
		imageTexture_9D = Screen('MakeTexture', window, nineD);
%%%%% TENS %%%%
    elseif strcmp(YourCards(n), '10clubs') == 1
		tenC = imread('10_of_clubs.png');
		imageTexture_10C= Screen('MakeTexture', window, tenC);
	elseif strcmp(YourCards(n), '10spades') == 1
		tenS = imread('10_of_spades.png');
		imageTexture_10S = Screen('MakeTexture', window, tenS);
    elseif strcmp(YourCards(n), '10hearts') == 1
		tenH = imread('10_of_hearts.png');
		imageTexture_10H = Screen('MakeTexture', window, tenH);
	elseif strcmp(YourCards(n), '10diamonds') == 1
		tenD = imread('10_of_diamonds.png');
		imageTexture_10D = Screen('MakeTexture', window, tenD);
%%%%% JACKS %%%%
    elseif strcmp(YourCards(n), 'Jclubs') == 1
		JC = imread('jack_of_clubs.png');
		imageTexture_JC= Screen('MakeTexture', window, JC);
	elseif strcmp(YourCards(n), 'Jspades') == 1
		JS = imread('jack_of_spades.png');
		imageTexture_JS = Screen('MakeTexture', window, JS);
    elseif strcmp(YourCards(n), 'Jhearts') == 1
		JH = imread('jack_of_hearts.png');
		imageTexture_JH = Screen('MakeTexture', window, JH);
	elseif strcmp(YourCards(n), 'Jdiamonds') == 1
		JD = imread('jack_of_diamonds.png');
		imageTexture_JD = Screen('MakeTexture', window, JD);
%%%%% QUEENS %%%%
    elseif strcmp(YourCards(n), 'Qclubs') == 1
		QC = imread('queen_of_clubs.png');
		imageTexture_QC= Screen('MakeTexture', window, QC);
	elseif strcmp(YourCards(n), 'Qspades') == 1
		QS = imread('queen_of_spades.png');
		imageTexture_QS = Screen('MakeTexture', window, QS);
    elseif strcmp(YourCards(n), 'Qhearts') == 1
		QH = imread('queen_of_hearts.png');
		imageTexture_QH = Screen('MakeTexture', window, QH);
	elseif strcmp(YourCards(n), 'Qdiamonds') == 1
		QD = imread('queen_of_diamonds.png');
		imageTexture_QD = Screen('MakeTexture', window, QD);
%%%%% KINGS %%%%
    elseif strcmp(YourCards(n), 'Kclubs') == 1
		KC = imread('King_of_clubs.png');
		imageTexture_KC= Screen('MakeTexture', window, KC);
	elseif strcmp(YourCards(n), 'Kspades') == 1
		KS = imread('King_of_spades.png');
		imageTexture_KS = Screen('MakeTexture', window, KS);
    elseif strcmp(YourCards(n), 'Khearts') == 1
		KH = imread('King_of_hearts.png');
		imageTexture_KH = Screen('MakeTexture', window, KH);
	else 
		KD = imread('King_of_diamonds.png');
		imageTexture_KD = Screen('MakeTexture', window, KD);
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% ACTUAL GAME CODE %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while ~isempty(YourCards) && ~isempty(CPCards) && ~isempty(Deck)
%%% Your turn%%%%
    input = GetEchoString(window, 'What is the name of the card that you want?', 45, 800, black, white);
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
    
    if sum(input_equal_CP) > 0 %your card matches one of CP's cards
        DrawFormattedText(window, 'You found a match!', 'center', 'center', black);
        WaitSecs(1.5)
        Screen('Flip', window); %%%%%%%%%%%%%
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
        DrawFormattedText(window, 'Go Fish!', 'center', 'center', black); 
        WaitSecs(1.5)
        Screen('Flip', window); %%%%%%%%%%%%
        cy = randperm(length(Deck),1);
        Your_cards = [Your_cards Deck(cy)]; %concat deck w new card
        Your_cards_num = str2double(Your_cards);
        Deck(cy) = [];
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
        YourCards = append(Your_cards,Your_cards_suit);
    end
    
%%% CP Turn
    CP_equal = ismember(CP_cards_num(1), Your_cards_num); %CP asks if player has their first card, generates boolean matrix 
    CPPoints = 0;
    if sum(CP_equal) ~= 0
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
        disp(' CP has to go fish') %% PTB text overlay%%
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


