--[[
    Copyright: Omar Saleh Assadi, Brian Hang 2014-2018; Licensed under the EUPL, with extension of article 5
    (compatibility clause) to any licence for distributing derivative works that have been
    produced by the normal use of the Work as a library
--]]
local COMMAND = {}
COMMAND.name = "Slay"
COMMAND.tip = "Slays the specified target."
COMMAND.icon = "bin"
COMMAND.example = "!slay #alive - Slays everyone who is alive."
COMMAND.aliases = {"kill"}

function COMMAND:OnRun(client, arguments, target)
    local force

    if (arguments[1] ~= nil) then
        force = util.tobool(arguments[1])
    end

    local function Action(target)
        if (force) then
            target:KillSilent()
        else
            target:Kill()
        end
    end

    if (type(target) == "table") then
        for k, v in pairs(target) do
            Action(v)
        end
    else
        Action(target)
    end

    moderator.NotifyAction(client, target, "has slayed")
end

moderator.commands.slay = COMMAND