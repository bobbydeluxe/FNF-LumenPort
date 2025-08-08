-- This script's purpose is to call the dialogueBox script, and make the transition at the end.
function onStartCountdown()
    if isStoryMode == true and seenCutscene == false then
        if getVar('dialogueFinished') == false then
            triggerEvent('Set Camera Target', 'dad', '0')
            callScript('data/'..songPath..'/dialogueBox', 'createDialogueBox', {true})
            return Function_Stop
        end
    end
    return Function_Continue
end

function onBeatHit()
    if isStoryMode == true and curBeat == 180 then
        makeLuaSprite('redScreen', -20, -20)
        makeGraphic('redScreen', screenWidth * 1.5, screenHeight * 1.5, 'FF1B31')
        setObjectCamera('redScreen', 'camHUD')
        addLuaSprite('redScreen', true)
        setProperty('redScreen.alpha', 0)

        for i = 0, getProperty('strumLineNotes.length') - 1 do
            noteTweenAlpha('fadeOutNote'..i, i, 0, 1.5, 'linear')
        end
        doTweenAlpha('fadeOutHUD', 'uiGroup', 0, 1.5, 'linear')
        doTweenAlpha('screenFadeIn', 'redScreen', 1, 2, 'linear')
    end
end