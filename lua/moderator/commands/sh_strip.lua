--[[
    Copyright: Omar Saleh Assadi, Brian Hang 2014-2018; Licensed under the EUPL, with extension of article 5
    (compatibility clause) to any licence for distributing derivative works that have been
    produced by the normal use of the Work as a library
--]]

local COMMAND = {}
	COMMAND.name = "Strip Weapons"
	COMMAND.tip = "Removes the target's every weapon."
	COMMAND.icon = "basket_remove"
	COMMAND.example = "!strip #all - Removes everyone's weapons."

	function COMMAND:OnRun(client, arguments, target)
		local function Action(target)
			local weapons = {}
				for k, v in pairs(target:GetWeapons()) do
					weapons[#weapons + 1] = v:GetClass()
				end

				local weapon = target:GetActiveWeapon()

				if (IsValid(weapon)) then
					weapons[0] = weapon:GetClass()
				end

				target.modWeapons = weapons
			target:StripWeapons()
		end

		if (type(target) == "table") then
			for k, v in pairs(target) do
				Action(v)
			end
		else
			Action(target)
		end

		moderator.NotifyAction(client, target, "has stripped * of weapons")
	end
moderator.commands.strip = COMMAND
