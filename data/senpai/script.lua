-- This script's purpose is to make the introduction and call the dialogueBox script.
function onCreate()
    if isStoryMode == true and seenCutscene == false then
        makeLuaSprite('blackScreen', -100, -100)
        makeGraphic('blackScreen', screenWidth * 2, screenHeight * 2, '000000')
        setScrollFactor('blackScreen', 0, 0)
        addLuaSprite('blackScreen', true)
    end
end

function onStartCountdown()
    if isStoryMode == true and seenCutscene == false then
        if getVar('dialogueFinished') == false then
            triggerEvent('Set Camera Target', 'dad', '0')
            runTimer('dialogueBGFadeIn', 0.83, 5)
            runTimer('screenFadeOut', 0.3)
            return Function_Stop
        end
    end
    return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'screenFadeOut' then
        setProperty('blackScreen.alpha', getProperty('blackScreen.alpha') - 0.15)
        if getProperty('blackScreen.alpha') <= 0 then
            callScript('data/'..songPath..'/dialogueBox', 'createDialogueBox', {false})
        else
            runTimer('screenFadeOut', 0.3)
        end
    end
end