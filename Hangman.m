% Boilerplate Setup 
sca;
close all;
clearvars;
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 0);

% Setting up the screens 
screens = Screen('Screens');
screenNumber = max(screens);
% Setting up colors black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
[window, windowRect] = PsychImaging('OpenWindow',screenNumber, black);

% Setup the text size
Screen('TextSize', window, 70);

% Setting up the sounds used in the experiment
[wavedata1, freq1] = audioread('Right Buzzer.m4a'); % Right Buzzer sound
[wavedata2, freq2] = audioread('Wrong buzzer.m4a'); % Wrong Buzzer sound
InitializePsychSound(1); % Initializing the PsychToolBox Sound. 
pahandle1 = PsychPortAudio('Open', [], 1, 1, freq1, 2); % pahandle for elevator sound
pahandle2 = PsychPortAudio('Open', [], 1, 1, freq2, 2); % pahandle for distracting sound
PsychPortAudio('FillBuffer', pahandle1, [wavedata1, wavedata1]'); 
PsychPortAudio('FillBuffer', pahandle2, [wavedata2, wavedata2]');

% Setting up the 1, 2, and 3 key on the keyboard for KbCheck.
KbName('UnifyKeyNames')
oneKey = KbName('1!');
twoKey = KbName('2@');
threeKey = KbName('3#');

% Getting the size of the screen
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Introductory words before entering the game. 
DrawFormattedText(window, 'Welcome to Hangman!', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, ['You will be playing' '\n against a computer for 3 rounds.'],'center', 'center', white);
Screen('Flip', window);
WaitSecs(4);
DrawFormattedText(window, 'Try to beat it!','center', 'center', white);
Screen('Flip', window);
WaitSecs(3)
% Setting up the words to select a category to play from. 
DrawFormattedText(window, ['Select a category to play by' '\n pressing the appropriate number', '\n\n 1. US Vacation Spots', '\n 2. Dishes from around the World', '\n 3. Punk Pop/Rock Anthems 2000s'], 'center', 'center', white);
Screen('Flip', window);


move_forward = false; % whether the program can move forward from setting up the puzzles. 
while move_forward == false % while move_forward is false
    % Check whether 1, 2, or 3 is pressed on the keyboard. 
    [secs, keyCode, deltaSecs] = KbWait;    
    if keyCode(oneKey) % If the 1 key is pressed
        % Setting up the Puzzles for category: US Vacation spots
        Puzzle_1 = 'new york city';  
        Puzzle_2 = 'yosemite';                               
        Puzzle_3 = 'san francisco';   
        Puzzle_4 = 'honolulu';                       
        Puzzle_5 = 'las vegas';                              
        Puzzle_6 = 'grand canyon';                       
        Puzzle_7 = 'new orleans';  
        Puzzle_8 = 'chicago';               
        Puzzle_9 = 'yellowstone';          
        
        move_forward = true; % Done setting up the puzzles. 
        
    elseif keyCode(twoKey) % If the 2 key is pressed 
        % Setting up the Puzzles for category: Dishes from around the world
        Puzzle_1 = 'beef wellington';  
        Puzzle_2 = 'kimchi jjigae';                               
        Puzzle_3 = 'margherita pizza';   
        Puzzle_4 = 'xiaolongbao';                       
        Puzzle_5 = 'okonomiyaki';                              
        Puzzle_6 = 'enchilada';                       
        Puzzle_7 = 'tandoori chicken';  
        Puzzle_8 = 'lomi salmon';               
        Puzzle_9 = 'kachumbari';          
        
        move_forward = true; % Done setting up the puzzles. 
        
    elseif keyCode(threeKey) % If the 3 key is pressed
        % Setting up the Puzzles for category: Punk Pop/Rock Anthems 2000s 
        Puzzle_1 = 'the middle';  
        Puzzle_2 = 'dirty little secret';                               
        Puzzle_3 = 'all the small things';   
        Puzzle_4 = 'sugar were going down';                       
        Puzzle_5 = 'american idiot';                              
        Puzzle_6 = 'mr brightside';                       
        Puzzle_7 = 'check yes juliet';  
        Puzzle_8 = 'misery business';               
        Puzzle_9 = 'im not okay';                  
        move_forward = true;
    elseif ~keyCode(oneKey) && ~keyCode(twoKey) && ~keyCode(threeKey)
        DrawFormattedText(window, 'Wrong Key. Press 1, 2, or 3', 'center', 'center', white);
        Screen('Flip', window);
        WaitSecs(2);
        DrawFormattedText(window, ['Select a category to play by' '\n pressing the appropriate number', '\n\n 1. US Vacation Spots', '\n 2. Dishes from around the World', '\n 3. Punk Pop/Rock Anthems 2000s'], 'center', 'center', white);
        Screen('Flip', window);     
    end
end

% Clear the command window
clc;
% Generate a vector of 3 random numbers from 1-9 
Puzzle_Number = randperm(9,3);

round = 1; % the number of the round

placement = 1; % the position number in the vector, Puzzle_Number
rounds_won = 0; % Counts the number of rounds the player has won. 

while round <= 3 % While round is less than or equal to 3. 
    
    % If the value in the Puzzle_Number vector is... 
    if Puzzle_Number(placement) == 1
       Puzzle = Puzzle_1; % Set variable Puzzle to be equal to Puzzle_1
    elseif Puzzle_Number(placement) == 2
        Puzzle = Puzzle_2; % Set variable Puzzle to be equal to Puzzle_2
    elseif Puzzle_Number(placement) == 3
        Puzzle = Puzzle_3; % Set variable Puzzle to be equal to Puzzle_3
    elseif Puzzle_Number(placement) == 4
        Puzzle = Puzzle_4; % Set variable Puzzle to be equal to Puzzle_4
    elseif Puzzle_Number(placement) == 5
        Puzzle = Puzzle_5; % Set variable Puzzle to be equal to Puzzle_5
    elseif Puzzle_Number(placement) == 6
        Puzzle = Puzzle_6; % Set variable Puzzle to be equal to Puzzle_6
    elseif Puzzle_Number(placement) == 7
        Puzzle = Puzzle_7; % Set variable Puzzle to be equal to Puzzle_7
    elseif Puzzle_Number(placement) == 8
        Puzzle = Puzzle_8; % Set variable Puzzle to be equal to Puzzle_8
    elseif Puzzle_Number(placement) == 9
        Puzzle = Puzzle_9; % Set variable Puzzle to be equal to Puzzle_9
    end
    
    %Create variable Puzzle_spaces which is converted into the cell format. 
    Puzzle_spaces = num2cell(Puzzle);
    % Puzzle_letters converted from cell to matrix and stored in Puzzle_letters.
    Puzzle_letters = cell2mat(Puzzle_spaces);
    % Puzzle_spaces is converted from cell to a matrix and stored in Puzzle_spaces.
    Puzzle_spaces = cell2mat(Puzzle_spaces);
    
    % Enter a for loop to create empty spots for the letters and spaces for the spaces. 
    for ii = 1:length(Puzzle_spaces) % ii is from 1 to the length of the puzzle.       
        if Puzzle_spaces(ii) == ' ' % If there is a space 
            Puzzle_spaces(ii) = ' '; % Leave the space as is
        else % If anything else
            Puzzle_spaces(ii) = '-'; % Change the value to be a blank.
        end
    end
    
    % variable for the number of times the player guesses wrong
    guess_wrong = 0; 
    %  Puzzle_spaces_new will be updated as the player continues to play (letters replace dashes)
    Puzzle_spaces_new = Puzzle_spaces;
    % Creates a string with words: 'Guessed:'
    string = 'Guessed:';
    % Setting up the visual of the noose    
    Screen('DrawLines', window, [0.6*screenXpixels, 0.9*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
    Screen('DrawLines', window, [0.9*screenXpixels, 0.9*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
    Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.25*screenYpixels, 0.40*screenYpixels], 5);
     % Setting up the visual of the puzzle
    Screen('TextSize', window, 70);   
    DrawFormattedText(window, Puzzle_spaces_new,.10*screenXpixels, 'center', white);
    % Setting up instructions for player 
    DrawFormattedText(window, 'Guess a letter', 'center', .10*screenYpixels, white);
    % Setting up the letters guessed corner
    Screen('TextSize', window, 60);
    DrawFormattedText(window, string,0.05*screenXpixels, 0.9*screenYpixels, white);
    Screen('Flip', window);
    
    % Enter a while loop
    while guess_wrong <= 6 % While the number of wrong guesses is less than or equal to 6
        % Synchronize GetKbChar
        FlushEvents;
        % Name of key that was pressed on the keyboard as a string into variable ch
        ch = GetKbChar;
        % append string and the guessed character (ch) for the guessed corner
        string = append(string, ch);
        % Enter a for loop to check whether ch is in the puzzle. 
        for jj = 1:length(Puzzle_letters) % For jj between 1 and the length of the Puzzle
            if ch == Puzzle_letters(jj) % if ch is in the puzzle
                Puzzle_spaces_new(jj) = ch; % replace the dash with ch in Puzzle_spaces_new             
            end
        end
                
        if Puzzle_spaces_new == Puzzle_letters % if Puzzle_spaces_new is equal to the original puzzle.
            % Play right buzzer sound 
            PsychPortAudio('Start', pahandle1);
            PsychPortAudio('Stop', pahandle1, 1,1,4)
            rounds_won = rounds_won + 1; % Add one to rounds_won
            % Congratulatory message to the player 
            Screen('TextSize', window, 70);
            DrawFormattedText(window, ['Good job! You guessed the clue!', '\n Press Enter to continue'], 'center', 'center', white);
            Screen('Flip', window);
            WaitSecs(3); % Show for 3 seconds
            guess_wrong = 7; % Have guess_wrong equal to 7 to exit the while loop. 
        
        elseif Puzzle_spaces_new == Puzzle_spaces % When the wrong letter is guessed. 
            guess_wrong = guess_wrong + 1; % Add one to guess_wrong
            % Wrong Letter Message
            Screen('TextSize', window, 70);
            DrawFormattedText(window, 'Wrong letter', 'center', 'center', white);
            Screen('Flip', window);
            % Play wrong buzzer sound
            PsychPortAudio('Start', pahandle2);
            PsychPortAudio('Stop', pahandle2, 1,1)
            WaitSecs(1); % Wait for 1 seconds
            % Setup the hangman noose 
            Screen('DrawLines', window, [0.6*screenXpixels, 0.9*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
            Screen('DrawLines', window, [0.9*screenXpixels, 0.9*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
            Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.25*screenYpixels, 0.40*screenYpixels], 5);
            % Setup the visual of Puzzle_spaces_new.
            Screen('TextSize', window, 70);
            DrawFormattedText(window, Puzzle_spaces_new, .10*screenXpixels, 'center', white);
            % Setup the instructions message. 
            DrawFormattedText(window, 'Guess a letter', 'center', .10*screenYpixels, white);
            % Setup the Guessed letters corner. 
            Screen('TextSize', window, 60);
            DrawFormattedText(window, string,0.05*screenXpixels, 0.9*screenYpixels, white);
            if guess_wrong == 1 % if guess_wrong is equal to 1
                % Draw the head of the hangman
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('Flip', window);
            elseif guess_wrong == 2 % if guess_wrong is equal to 2
                % Add the body of the hangman
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 3 % if guess_wrong is equal to 3
                % Add the left arm of the hangman 
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.52*screenXpixels, 0.6*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 4 % if guess_wrong is equal to 4 
                % Add the right arm of the hangman
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.52*screenXpixels, 0.6*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.68*screenXpixels ; 0.64*screenYpixels, 0.6*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 5 % if guess_wrong is equal to 5
                % Add the left leg of the hangman
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.52*screenXpixels, 0.6*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.68*screenXpixels ; 0.64*screenYpixels, 0.6*screenYpixels], 5);
                Screen('DrawLines', window, [0.55*screenXpixels, 0.6*screenXpixels ; 0.9*screenYpixels, 0.8*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 6 % if guess_wrong is equal to 6
                % Add the right leg of the hangman
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.52*screenXpixels, 0.6*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.68*screenXpixels ; 0.64*screenYpixels, 0.6*screenYpixels], 5);
                Screen('DrawLines', window, [0.55*screenXpixels, 0.6*screenXpixels ; 0.9*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.65*screenXpixels ; 0.8*screenYpixels, 0.9*screenYpixels], 5);
                Screen('Flip', window);
                WaitSecs(2); % Wait 2 seconds
                % Setup loss of round message
                Screen('TextSize', window, 70);
                DrawFormattedText(window, ['Unfortunately, you lost this round...' '\n Press Enter to continue to the next round'], 'center', 'center', white);
                Screen('Flip', window);
                WaitSecs(3); % Wait 3 seconds
                guess_wrong = guess_wrong + 1; % Add one to guess_wrong to exit the while loop. 
                             
            end
        else % if the correct letter is guessed  
            % Setup the hangman noose 
            Screen('DrawLines', window, [0.6*screenXpixels, 0.9*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
            Screen('DrawLines', window, [0.9*screenXpixels, 0.9*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
            Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.25*screenYpixels, 0.40*screenYpixels], 5);
            % Setup the visual of Puzzle_spaces_new.
            Screen('TextSize', window, 70);
            DrawFormattedText(window, Puzzle_spaces_new, .10*screenXpixels, 'center', white);
            % Setup the instructions message. 
            DrawFormattedText(window, 'Guess a letter', 'center', .10*screenYpixels, white);
            % Setup the Guessed letters corner. 
            Screen('TextSize', window, 60);
            DrawFormattedText(window, string,0.05*screenXpixels, 0.9*screenYpixels, white);
            % Play right buzzer sound
            PsychPortAudio('Start', pahandle1);
            PsychPortAudio('Stop', pahandle1, 1,1)

            if guess_wrong == 0 % if guess_wrong is equal to zero        
                Screen('Flip', window); % 
            elseif guess_wrong == 1 % if guess_wrong is equal to 1
                % Keep the head of the hangman
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('Flip', window);
            elseif guess_wrong == 2 % if guess_wrong is equal to 2
                % Keep the head+body of the hangman
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 3 % if guess_wrong is equal to 3
                % Keep the head+body+left arm of the hangman
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.52*screenXpixels, 0.6*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 4 % if guess_wrong is equal to 4
                % Keep the head+body+left+right arm of the hangman
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.52*screenXpixels, 0.6*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.68*screenXpixels ; 0.64*screenYpixels, 0.6*screenYpixels], 5);
                Screen('Flip', window);
            elseif guess_wrong == 5 % if guess_wrong is equal to 5
                % Keep the head+body+left+right arm+left leg of the hangman
                Screen('DrawDots', window, [0.6*screenXpixels 0.45*screenYpixels],130, white);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.6*screenXpixels ; 0.40*screenYpixels, 0.8*screenYpixels], 5);
                Screen('DrawLines', window, [0.52*screenXpixels, 0.6*screenXpixels ; 0.6*screenYpixels, 0.64*screenYpixels], 5);
                Screen('DrawLines', window, [0.6*screenXpixels, 0.68*screenXpixels ; 0.64*screenYpixels, 0.6*screenYpixels], 5);
                Screen('DrawLines', window, [0.55*screenXpixels, 0.6*screenXpixels ; 0.9*screenYpixels, 0.8*screenYpixels], 5);
                Screen('Flip', window);               
            end
            Puzzle_spaces = Puzzle_spaces_new; % Update Puzzle_spaces to include the new letters
        end
           
    end           
           
    placement = placement + 1; % Shift placement to 1 to change puzzles
    round = round + 1; % Add one to round '
    clc; % Clear the command window
    
    KbStrokeWait
   
end
% Ending Message
Screen('TextSize', window, 70);
DrawFormattedText(window, 'You finished all of the rounds.', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, ['You won ' num2str(rounds_won) ' rounds.'], 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
if rounds_won < 2 % if rounds_won is less than 2
    % Ending message for losing against the computer
    DrawFormattedText(window, ['Unfortunately you lost against' '\n the computer'], 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    DrawFormattedText(window, 'Try again next time!', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(2);
    sca; % Exit the program 
elseif rounds_won > 1
    % Ending message for winning against the computer
    DrawFormattedText(window, 'You won against the computer!', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(3);
    DrawFormattedText(window, 'Congratulations!', 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(3);
    DrawFormattedText(window, ['Try a different category' '\n next time!'], 'center', 'center', white);
    Screen('Flip', window);
    WaitSecs(5);
    sca; % Exit the program
end
    
