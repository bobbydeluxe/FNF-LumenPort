-- This script handles the cutscene and then calls the dialogueBox script.
function onCreate()
    if isStoryMode == true and seenCutscene == false then
        makeLuaSprite('coverScreen', -100, -100)
        makeGraphic('coverScreen', screenWidth * 2, screenHeight * 2, 'FF1B31')
        setScrollFactor('coverScreen', 0, 0)
        addLuaSprite('coverScreen', true)

        makeAnimatedLuaSprite('senpaiCrazy', 'weeb/senpaiCrazy')
        addAnimationByPrefix('senpaiCrazy', 'anim', 'Senpai Pre Explosion', 24, false)
        setScrollFactor('senpaiCrazy', 0, 0)
        scaleObject('senpaiCrazy', 6, 6)
        screenCenter('senpaiCrazy')
        addLuaSprite('senpaiCrazy', true)
        setProperty('senpaiCrazy.antialiasing', false)
        setProperty('senpaiCrazy.x', getProperty('senpaiCrazy.x') + 300)
        setProperty('senpaiCrazy.alpha', 0)
        setProperty('senpaiCrazy.animation.curAnim.curFrame', 0)
        callMethod('senpaiCrazy.animation.curAnim.pause')
    end
end

local cutsceneFinished = false
function onStartCountdown()
    if isStoryMode == true and seenCutscene == false then
        if getVar('dialogueFinished') == false and cutsceneFinished == true then
            triggerEvent('Set Camera Target', 'dad', '0')
            runTimer('dialogueBGFadeIn', 0.83, 5)
            runTimer('screenFadeOut', 0.3)
            return Function_Stop
        elseif cutsceneFinished == false then
            setProperty('camHUD.visible', false)
            setProperty('inCutscene', true)
            runTimer('senpaiFadeIn', 0.3)
            return Function_Stop
        end
    end
    return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'senpaiFadeIn' then
        setProperty('senpaiCrazy.alpha', getProperty('senpaiCrazy.alpha') + 0.15)
        if getProperty('senpaiCrazy.alpha') >= 1 then
            playAnim('senpaiCrazy', 'anim')
            playSound('Senpai_Dies', 1, 'senpaiDeathSound')
            runTimer('delayScreenFade', 3.2)
        else
            runTimer('senpaiFadeIn', 0.3)
        end
    end
    if tag == 'delayScreenFade' then
        cameraFade('game', 'FFFFFF', 1.6)
    end
    if tag == 'screenFadeOut' then
        setProperty('coverScreen.alpha', getProperty('coverScreen.alpha') - 0.15)
        if getProperty('coverScreen.alpha') <= 0 then
            callScript('data/'..songPath..'/dialogueBox-evil', 'createDialogueBox')
        else
            runTimer('screenFadeOut', 0.3)
        end
    end
end

function onSoundFinished(tag)
    if tag == 'senpaiDeathSound' then
        cutsceneFinished = true
        removeLuaSprite('senpaiCrazy')
        setProperty('camHUD.visible', true)
        setProperty('coverScreen.color', 0x000000)
        cameraFade('game', 'FFFFFF', 0.4, true, true)
        startCountdown()
    end
end