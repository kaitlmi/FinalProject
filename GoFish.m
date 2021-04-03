%Clear everything
clc
Deck = [];

% create card 'stack' that is row vector of card values 
Deck = [ "Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K" ]; %Generate matrix of 52 cards
Deck = repmat(Deck, 1, 4);
Deck = Deck';
Deck(:);
Deck = reshape(Deck, 1, []);

% deal cards
%numplayers = 2
%for 1:numplayers
c1 = randi(length(Deck),3);
Your_cards = Deck(c1); %Generate matrix of 9 different cards
Your_cards_str = mat2str(Your_cards);
disp(strcat('your cards are', Your_cards_str))
Deck(c1) = [];


c2 = randi(length(Deck),3);
CP_cards = Deck(c2); %Generate matrix of 9 different cards
Deck(c2) = [];
disp(length(Deck));

% add another player later

%print("instructions") 
