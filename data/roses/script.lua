-- This script's purpose is only to call the dialogueBox script.
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