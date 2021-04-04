clear all;
close all;

%setting upthe deck
steps=1000;
H=1:13; %hearts
S=1:13; %spades
C=1:13; %clubs
D=1:13; %diamonds
full_deck= [D,C,S,H];
 
%shuffle deck
[m,n]=size(full_deck);
card_loc=randperm(n);
randomized_deck=full_deck;
randomized_deck(1,card_loc)=full_deck(1,:);

 
%deal deck (half deck to each player = 26 cards each)
Computer = zeros(52,steps);
Human = zeros(52,steps);
Computer(1:26)= randomized_deck(1:26);
Human(1:26)= randomized_deck(27:52);

