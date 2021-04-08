clear all;
close all;

%%SETUP%% 

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

%%%PLAYING GAME%%%
for games_played=1:steps 
    % computer win % 
    if Computer(1,games_played)>Human(1,games_played)  % if the computer's card is higher --> computer wins round  
        
        cur_computer=find(~Computer(:,games_played),1,'first');     %Put new cards in first 0 of winner's "deck" vector (computer here human below)
        Computer(cur_computer+0,games_played+1)=Computer(1,games_played);         %add cards to end of winners deck (computer) 
        Computer(cur_computer+1,games_played+1)=Human(1,games_played); %the new card's value is the last card the oponent played
        
        for j=1:51                     %remove cards just played from beginning of each players deck vector and shift up "cards" by one index (puts their "second card" originally distributed in position 1 to be played next round) 
            Computer(j,games_played+1)=Computer(j+1,games_played+1);
            Human(j,games_played+1)=Human(j+1,games_played+1);
        end
        win_computer=win_computer+1;                          %add point to winner's score (add visual for this?  if have time at end) 
        
        Computer(:,games_played+1)=Computer(:,games_played);          %START NEXT ROUND
        Human(:,games_played+1)=Human(:,games_played);
        
    elseif Computer(1,games_played)<Human(1,games_played)
       
        cur_Human=find(~Human(:,games_played),1,'first');     %find first open spot in deck 
        Human(cur_Human+0,games_played+1)=Human(1,games_played);         %add card to winners deck (human) 
        Human(cur_Human+1,games_played+1)=Computer(1,games_played);
        
        for j=1:51                       %remove cards just played from beginning of deck and shift up other cards indexes (putting 2nd card in front) 
            Computer(j,games_played+1)=Computer(j+1,games_played+1);
            Human(j,games_played+1)=Human(j+1,games_played+1);
        end
        
        win_human=win_human+1;                        %add point to winners score
        
          
        Computer(:,games_played+1)=Computer(:,games_played);          % START NEXT ROUND 
        Human(:,games_played+1)=Human(:,games_played);

