function onCreate()
    if isStoryMode == true and seenCutscene == false then
        makeLuaSprite('whiteFlash')
        makeGraphic('whiteFlash', screenWidth * 2, screenHeight * 2)
        setScrollFactor('whiteFlash', 0, 0)
        setBlendMode('whiteFlash', 'ADD')
        addLuaSprite('whiteFlash', true)
    end
end

local stopCountdown = true
function onStartCountdown()
    if isStoryMode == true and seenCutscene == false then
        if stopCountdown == true then
            local num = getRandomInt(1, 2)
            setProperty('inCutscene', true)
            setProperty('camHUD.visible', false)
            triggerEvent('Set Camera Target', 'Dad,150', '0')
            playSound('thunder_'..num)

            playAnim('gf', 'scared', true)
            setProperty('gf.stunned', true)
            playAnim('boyfriend', 'scared', true)
            setProperty('boyfriend.stunned', true)
            runTimer('delayFlash', 0.1)
            return Function_Stop
        end
    end
    return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'delayFlash' then
        doTweenAlpha('flashScreen', 'whiteFlash', 0, 1, 'linear')
    end
end

function onTweenCompleted(tag)
    if tag == 'flashScreen' then
        stopCountdown = false
        removeLuaSprite('whiteFlash')
        setProperty('gf.stunned', false)
        setProperty('boyfriend.stunned', false)
        setProperty('camHUD.visible', true)
        startCountdown()
        triggerEvent('Set Camera Target', '', '') -- Doing that, or else the camera will stay focused
    end
end