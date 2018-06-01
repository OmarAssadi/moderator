--[[
    Copyright: Omar Saleh Assadi, Brian Hang 2014-2018; Licensed under the EUPL, with extension of article 5
    (compatibility clause) to any licence for distributing derivative works that have been
    produced by the normal use of the Work as a library
--]]

local COMMAND = {}
	COMMAND.name = "RCON"
	COMMAND.tip = "Runs an RCON command."
	COMMAND.hidden = true
	COMMAND.noTarget = true
	COMMAND.usage = "<string command>"
	COMMAND.example = "!rcon bot - Adds a bot to the game."

	function COMMAND:OnRun(client, arguments)
		local command = table.concat(arguments, " ")

		game.ConsoleCommand(command.."\n")
		moderator.NotifyAction(client, nil, "has ran the RCON command: "..command)
	end
moderator.commands.rcon = COMMAND
