﻿--[[
    Copyright: Omar Saleh Assadi, Brian Hang 2014-2018; Licensed under the EUPL, with extension of article 5
    (compatibility clause) to any licence for distributing derivative works that have been
    produced by the normal use of the Work as a library
--]]
local COMMAND = {}
local name = "Armor"
local name2 = name:lower()
COMMAND.name = "Set " .. name
COMMAND.tip = "Sets the " .. name2 .. " of a player."
COMMAND.icon = "shield"
COMMAND.usage = "[number amount]"
COMMAND.example = "!armor Chessnut 50 - Sets Chessnut's armor to 50."

function COMMAND:OnRun(client, arguments, target)
    local amount = math.floor(tonumber(arguments[1]) or 100)

    local function Action(target)
        target["Set" .. name](target, amount)
    end

    if (type(target) == "table") then
        for k, v in pairs(target) do
            Action(v)
        end
    else
        Action(target)
    end

    moderator.NotifyAction(client, target, "has set the " .. name2 .. " of * to " .. amount)
end

function COMMAND:OnClick(menu, client)
    for i = 1, 10 do
        menu:AddOption((i * 10) .. " " .. name, function()
            self:Send(client, i * 10)
        end)
    end

    menu:AddOption("Specify", function()
        Derma_StringRequest("Set " .. name, "Specify the amount of " .. name2 .. " to set.", 100, function(text)
            self:Send(client, tonumber(text) or 100)
        end)
    end)
end

moderator.commands[name2] = COMMAND