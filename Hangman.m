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

KbName('UnifyKeyNames')
escapeKey = KbName('Escape');
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
DrawFormattedText(window, ['Try to beat it!'],'center', 'center', white);
Screen('Flip', window);
WaitSecs(3)
DrawFormattedText(window, ['Select a category to play by' '\n pressing the appropriate number', '\n\n 1. US Vacation Spots', '\n 2. Dishes', '\n 3. Famous Singers'], 'center', 'center', white);
Screen('Flip', window);

exit = false;
while exit == false
    [keyIsDown, secs, keyCode] = KbCheck;    
    if keyCode(escapeKey)
        sca;
        return 
    elseif keyCode(oneKey)
        % Setting up the Puzzle
        Puzzle_1 = 'new york city';  
        Puzzle_2 = 'yosemite';                               
        Puzzle_3 = 'san francisco';   
        Puzzle_4 = 'honolulu';                       
        Puzzle_5 = 'las vegas';                              
        Puzzle_6 = 'grand canyon';                       
        Puzzle_7 = 'new orleans';  
        Puzzle_8 = 'chicago';               
        Puzzle_9 = 'yellowstone';          
        
        DrawFormattedText(window, (Puzzle_1),'center', 'center', white);
        Screen('Flip', window);
        WaitSecs(2);
        exit = true;
    end
end
% Drawing the hangman noose
Screen('DrawLines', window, [0.5*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
Screen('DrawLines', window, [0.8*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.25*screenYpixels, 0.30*screenYpixels], 5);
Screen('Flip', window);
KbStrokeWait
sca

