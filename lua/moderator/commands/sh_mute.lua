--[[
    Copyright: Omar Saleh Assadi, Brian Hang 2014-2018; Licensed under the EUPL, with extension of article 5
    (compatibility clause) to any licence for distributing derivative works that have been
    produced by the normal use of the Work as a library
--]]
local COMMAND = {}
COMMAND.name = "Toggle Mute"
COMMAND.tip = "Toggles whether or not a player is muted."
COMMAND.icon = "sound"
COMMAND.usage = "[bool muted]"
COMMAND.example = "!mute #all 1 - Mutes everyone."

function COMMAND:OnRun(client, arguments, target)
    local force

    if (arguments[1] ~= nil) then
        force = util.tobool(arguments[1])
    end

    local function Action(target)
        target.modMuted = forced ~= nil and forced or not target.modMuted
    end

    if (type(target) == "table") then
        for k, v in pairs(target) do
            Action(v)
        end
    else
        Action(target)
    end

    if (force ~= nil) then
        moderator.NotifyAction(client, target, "has " .. (force and "muted" or "unmuted"))
    else
        moderator.NotifyAction(client, target, "toggle muted")
    end
end

hook.Add("PlayerCanHearPlayersVoice", "mod_MuteCheck", function(listener, speaker)
    if (speaker.modMuted) then return false end
end)

moderator.commands.mute = COMMAND