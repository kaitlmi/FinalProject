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

oneKey = KbName('1');
% Getting the size of the screen
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

DrawFormattedText(window, 'Welcome to Hangman!', 'center', 'center', white);
Screen('Flip', window);
WaitSecs(3);
DrawFormattedText(window, ['You will be playing' 'against a computer for 3 rounds.'],'center', 'center', white);
Screen('Flip', window);
WaitSecs(4);
DrawFormattedText(window, ['Try to beat it!' ],'center', 'center', white);
Screen('Flip', window);
WaitSecs(3)
DrawFormattedText(window, ['Select a category to play by' '\n pressing the appropriate number', '\n\n 1. Locations', '\n 2. Brown U', '\n 3. Instruments'], 'center', 'center', white);
Screen('Flip', window);
[keyIsDown, secs, keyCode] = KbCheck;
if keyIsDown
    if keyCode(oneKey) 
    % Drawing the hangman noose
        Screen('DrawLines', window, [0.5*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, 0.25*screenYpixels], 5);
        Screen('DrawLines', window, [0.8*screenXpixels, 0.8*screenXpixels ; 0.25*screenYpixels, screenYpixels], 5);
        Screen('DrawLines', window, [0.5*screenXpixels, 0.5*screenXpixels ; 0.25*screenYpixels, 0.30*screenYpixels], 5);
        Screen('Flip', window);
        WaitSecs(2);
        sca
    end
end



