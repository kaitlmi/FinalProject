% create card 'stack' that is row vector of card values   
Deck = [ "Ace", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K" ]; %Generate matrix of 52 cards
Deck = repmat(Deck, 4);
Deck = Deck'
Deck(:);
Deck = reshape(Deck, 1, []);

% deal cards 
Your_cards = Deck(randi(length(Deck), 3)) %Generate matrix of 9 different cards

%Your_cards = [ ]
%CP1_cards = [ ]
% add another player later

%print("instructions") 
