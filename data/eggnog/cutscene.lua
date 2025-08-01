local cutsceneStarted = false
function onEndSong()
    if isStoryMode == true and cutsceneStarted == false then
        cutsceneStarted = true
        playSound('Lights_Shut_off')

        makeLuaSprite('blackScreen', nil, -screenWidth * getProperty('camGame.zoom'), -screenHeight * getProperty('camGame.zoom'))
        makeGraphic('blackScreen', screenWidth * 3, screenHeight * 3, '000000')
        setScrollFactor('blackScreen', 0, 0)
        addLuaSprite('blackScreen', true)

        setProperty('inCutscene', true)
        setProperty('camHUD.visible', false)
        runTimer('delayEndSong', 1.5)
        return Function_Stop
    end
    return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'delayEndSong' then
        endSong()
    end
end