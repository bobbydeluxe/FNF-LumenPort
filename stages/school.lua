local pauseMusic = ''
function onCreate()
    --[[
        Add the animation through scripting since the Stage Editor
        doesn't support .txt files for animations.
    ]]
    addAnimation('trees', 'anim', {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18}, 12)

    -- Default Game Over.
	setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-pixel-dead')
	setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx-pixel')
	setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', 'gameOver-pixel')
	setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', 'gameOverEnd-pixel')

    -- Pause Music turns into its 'Pixel' variant, if there's one.
    pauseMusic = getPropertyFromClass('backend.ClientPrefs', 'data.pauseMusic')
	fileName = pauseMusic:gsub(' ', '-'):lower()
    if checkFileExists('music/'..fileName..'-pixel.ogg') then
        setPropertyFromClass('backend.ClientPrefs', 'data.pauseMusic', pauseMusic..' Pixel')
    end
end

function onDestroy()
    -- Resets the Pause Music to its original version, else it'll apply everywhere.
	setPropertyFromClass('backend.ClientPrefs', 'data.pauseMusic', pauseMusic)
end

--[[
	Everything below is to make the characters bop their head on beat.
	It also checks if the 'BG Freaks Expression' event is played to swap their dance anim.
]]
girlsDanced = true
girlsSuffix = ''
function onBeatHit()
    if lowQuality == false then
		girlsDanced = not girlsDanced
		if girlsDanced == true then
			playAnim('girlfreaks', 'danceLeft'..girlsSuffix, true)
		else
			playAnim('girlfreaks', 'danceRight'..girlsSuffix, true)
		end
	end
end

function onEvent(event, value1, value2, strumTime)
    if event == 'BG Freaks Expression' then
        if girlsSuffix == '' then
            girlsSuffix = '-mad'
        else
            girlsSuffix = ''
        end

        if girlsDanced == true then
			playAnim('girlfreaks', 'danceLeft'..girlsSuffix, true)
		else
			playAnim('girlfreaks', 'danceRight'..girlsSuffix, true)
		end
    end
end