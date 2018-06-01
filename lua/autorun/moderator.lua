--[[
    Copyright: Omar Saleh Assadi, Brian Hang 2014-2018; Licensed under the EUPL, with extension of article 5
    (compatibility clause) to any licence for distributing derivative works that have been
    produced by the normal use of the Work as a library
--]]

moderator = moderator or {}

if (SERVER) then
	include("moderator/sv_moderator.lua")
	AddCSLuaFile("moderator/cl_moderator.lua")

	resource.AddFile("materials/moderator/leave.png")
	resource.AddFile("materials/moderator/menu.png")
else
	include("moderator/cl_moderator.lua")
end
