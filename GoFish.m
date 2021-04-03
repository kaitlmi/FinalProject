%Clear everything
clc
Deck = []

% create card 'stack' that is row vector of card values 
Deck = [ "Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K" ]; %Generate matrix of 52 cards
Deck = repmat(Deck, 1, 4);
Deck = Deck';
Deck(:);
Deck = reshape(Deck, 1, [])

% deal cards 
c = randi(length(Deck),3)
Your_cards = Deck(c) %Generate matrix of 9 different cards
Deck(c) = [];
length(Deck)

%Your_cards = [ ]
%CP1_cards = [ ]
% add another player later

%print("instructions") 
