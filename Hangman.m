% Boilerplate Setup 
sca;
close all;
clearvars;
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 0);

screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
[window, windowRect] = PsychImaging('OpenWindow',screenNumber, black);

% Setting up Text Size
Screen('TextSize', window, 70);

% Setting up certain keys on the keyboard. 
KbName('UnifyKeyNames')
oneKey = KbName('1!');
twoKey = KbName('2@');
threeKey = KbName('3#');

% Getting the size of the screen
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

DrawFormattedText(window, 'Welcome to Hangman!', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, ['You will be playing' '\n against a computer for 3 rounds.'],'center', 'center', white);
Screen('Flip', window);
WaitSecs(4);
DrawFormattedText(window, 'Try to beat it!','center', 'center', white);
Screen('Flip', window);
WaitSecs(3)
DrawFormattedText(window, ['Select a category to play by' '\n pressing the appropriate number', '\n\n 1. US Vacation Spots', '\n 2. Dishes from around the World', '\n 3. Famous American Singers  in 2020'], 'center', 'center', white);
Screen('Flip', window);

move_forward = false;
while move_forward == false
    [keyIsDown, secs, keyCode] = KbCheck;    
    if keyCode(oneKey)
        % Setting up the Puzzles for category US Vacation spots
        Puzzle_1 = 'new york city';  
        Puzzle_2 = 'yosemite';                               
        Puzzle_3 = 'san francisco';   
        Puzzle_4 = 'honolulu';                       
        Puzzle_5 = 'las vegas';                              
        Puzzle_6 = 'grand canyon';                       
        Puzzle_7 = 'new orleans';  
        Puzzle_8 = 'chicago';               
        Puzzle_9 = 'yellowstone';          

        move_forward = true;
    elseif keyCode(twoKey)
        % Setting up the Puzzles
        Puzzle_1 = 'beef wellington';  
        Puzzle_2 = 'kimchi jjigae';                               
        Puzzle_3 = 'margherita pizza';   
        Puzzle_4 = 'xiaolongbao';                       
        Puzzle_5 = 'okonomiyaki';                              
        Puzzle_6 = 'enchilada';                       
        Puzzle_7 = 'tandoori chicken';  
        Puzzle_8 = 'lomi salmon';               
        Puzzle_9 = 'kachumbari';          
        
        move_forward = true;
    elseif keyCode(threeKey)
        % Setting up the Puzzles
        Puzzle_1 = 'Taylor Swift';  
        Puzzle_2 = 'Cardi B';                               
        Puzzle_3 = 'Katy Perry';   
        Puzzle_4 = 'Billie Eilish';                       
        Puzzle_5 = 'Marshmello';                              
        Puzzle_6 = 'Post Malone';                       
        Puzzle_7 = 'Ariana Grande';  
        Puzzle_8 = 'Selena Gomez';               
        Puzzle_9 = 'Travis Scott';          
        
        move_forward = true;
    end
end

clc;
Puzzle_Number = randperm(9,3);
round = 1;
placement = 1;
while round <= 3
    
    if Puzzle_Number(placement) == 1
       Puzzle = Puzzle_1;
    elseif Puzzle_Number(placement) == 2
        Puzzle = Puzzle_2;
    elseif Puzzle_Number(placement) == 3
        Puzzle = Puzzle_3;
    elseif Puzzle_Number(placement) == 4
        Puzzle = Puzzle_4;
    elseif Puzzle_Number(placement) == 5
        Puzzle = Puzzle_5;
    elseif Puzzle_Number(placement) == 6
        Puzzle = Puzzle_6;
    elseif Puzzle_Number(placement) == 7
        Puzzle = Puzzle_7;
    elseif Puzzle_Number(placement) == 8
        Puzzle = Puzzle_8;
    elseif Puzzle_Number(placement) == 9
        Puzzle = Puzzle_9;
    end
    
    Puzzle_spaces = num2cell(Puzzle);
    Puzzle_letters = cell2mat(Puzzle_spaces);
    Puzzle_spaces = cell2mat(Puzzle_spaces);
    
    for ii = 1:length(Puzzle_spaces)
        if Puzzle_spaces(ii) == ' '
            Puzzle_spaces(ii) = ' ';
        else 
            Puzzle_spaces(ii) = '-';
        end
    end
      
    guess_wrong = 0;   
    Puzzle_spaces_new = Puzzle_spaces;
    Screen('DrawLines', window, [0.5*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
    Screen('DrawLines', window, [0.8*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
    Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.25*screenYpixels, 0.40*screenYpixels], 5);
    DrawFormattedText(window, Puzzle_spaces_new,.10*screenXpixels, 'center', white);
    DrawFormattedText(window, 'Guess a letter', 'center', .10*screenYpixels, white);
    Screen('Flip', window); 
    while guess_wrong <= 6              
        FlushEvents;
        ch = GetKbChar;
        for jj = 1:length(Puzzle_letters)
            if ch == Puzzle_letters(jj)
                Puzzle_spaces_new(jj) = ch;                
            end
        end
        
        if Puzzle_spaces_new == Puzzle_letters
            DrawFormattedText(window, 'Good job! You guessed the clue!', 'center', 'center', white);
            Screen('Flip', window);
            WaitSecs(3);
            guess_wrong = 7;
        
        elseif Puzzle_spaces_new == Puzzle_spaces
            guess_wrong = guess_wrong + 1;
            DrawFormattedText(window, 'Wrong letter', 'center', 'center', white);
            Screen('Flip', window);
            WaitSecs(2);
            Screen('DrawLines', window, [0.5*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
            Screen('DrawLines', window, [0.8*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
            Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.25*screenYpixels, 0.40*screenYpixels], 5);
            DrawFormattedText(window, Puzzle_spaces_new, .10*screenXpixels, 'center', white);
            DrawFormattedText(window, 'Guess a letter', 'center', .10*screenYpixels, white)            
            if guess_wrong == 1               
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('Flip', window);
            elseif guess_wrong == 2
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 3
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.42*screenXpixels, 0.5*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 4
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.42*screenXpixels, 0.5*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.58*screenXpixels ; 0.64*screenYpixels, 0.6*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 5
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.42*screenXpixels, 0.5*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.58*screenXpixels ; 0.64*screenYpixels, 0.6*screenYpixels], 5);
                Screen('DrawLines', window, [0.45*screenXpixels, 0.5*screenXpixels ; 0.9*screenYpixels, 0.8*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 6
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.42*screenXpixels, 0.5*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.58*screenXpixels ; 0.64*screenYpixels, 0.6*screenYpixels], 5);
                Screen('DrawLines', window, [0.45*screenXpixels, 0.5*screenXpixels ; 0.9*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.55*screenXpixels ; 0.8*screenYpixels, 0.9*screenYpixels], 5);
                Screen('Flip', window);
                WaitSecs(3);
                DrawFormattedText(window, 'Unfortunately, you lost this round...', 'center', 'center', white);
                Screen('Flip', window);
                WaitSecs(2);
                guess_wrong = guess_wrong + 1;
              
                
            end
        else            
            Screen('DrawLines', window, [0.5*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
            Screen('DrawLines', window, [0.8*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
            Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.25*screenYpixels, 0.40*screenYpixels], 5);
            DrawFormattedText(window, Puzzle_spaces_new, .10*screenXpixels, 'center', white);
            DrawFormattedText(window, 'Guess a letter', 'center', .10*screenYpixels, white);
            if guess_wrong == 1               
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('Flip', window);
            elseif guess_wrong == 2
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 3
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.42*screenXpixels, 0.5*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 4
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.42*screenXpixels, 0.5*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.58*screenXpixels ; 0.64*screenYpixels, 0.6*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 5
                Screen('DrawDots', window, [0.5*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.42*screenXpixels, 0.5*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('DrawLines', window, [0.5*screenXpixels, 0.58*screenXpixels ; 0.64*screenYpixels, 0.6*screenYpixels], 5);
                Screen('DrawLines', window, [0.45*screenXpixels, 0.5*screenXpixels ; 0.9*screenYpixels, 0.8*screenYpixels], 5);
                Screen('Flip', window);               
            end
        end
        Puzzle_spaces = Puzzle_spaces_new;      
    end
        
%         
%         if Puzzle_spaces_new == Puzzle_spaces
%             guessing_done = guessing_done + 1;
%             DrawFormattedText(window, 'Wrong Letter', 'center', 'center', white);
%             Screen('Flip', window);
%             WaitSecs(2);           
%             Screen('DrawLines', window, [0.5*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
%             Screen('DrawLines', window, [0.8*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
%             Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.25*screenYpixels, 0.30*screenYpixels], 5);
%             DrawFormattedText(window, Puzzle_spaces_new,.10*screenXpixels, 'center', white);
%             DrawFormattedText(window, 'Guess a letter', 'center', .10*screenYpixels, white);
%             Screen('Flip', window);       
%             KbStrokeWait;
%         elseif Puzzle_spaces_new ~= Puzzle_spaces          
%             Screen('DrawLines', window, [0.5*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
%             Screen('DrawLines', window, [0.8*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
%             Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.25*screenYpixels, 0.30*screenYpixels], 5);
%             DrawFormattedText(window, Puzzle_spaces_new,.10*screenXpixels, 'center', white);
%             DrawFormattedText(window, 'Guess a letter', 'center', .10*screenYpixels, white);
%             Screen('Flip', window);
%             Puzzle_spaces_new = Puzzle_spaces;
%             KbStrokeWait;
%         elseif Puzzle_spaces_new == Puzzle_letters
%             Screen('DrawLines', window, [0.5*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
%             Screen('DrawLines', window, [0.8*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
%             Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.25*screenYpixels, 0.30*screenYpixels], 5);
%             DrawFormattedText(window, Puzzle_spaces_new,.10*screenXpixels, 'center', white);
%             DrawFormattedText(window, 'Guess a letter', 'center', .10*screenYpixels, white);
%             Screen('Flip', window);           
%             guessing_done = 6;
%             DrawFormattedText(window, 'Nice Job! You beat the computer!', 'center', 'center', white);
%             Screen('Flip', window);
%             KbStrokeWait;
%             
           
    placement = placement + 1;
    round = round + 1;
    KbStrokeWait;
end
sca;
