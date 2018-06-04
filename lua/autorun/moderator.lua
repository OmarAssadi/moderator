--[[
    Copyright: Omar Saleh Assadi, Brian Hang 2014-2018; Licensed under the EUPL, with extension of article 5
    (compatibility clause) to any licence for distributing derivative works that have been
    produced by the normal use of the Work as a library
--]]
moderator = moderator or {}
moderator.IsValid = function()
    return (UNLOAD_MODERATOR != true)
end

if (SERVER) then
    include("moderator/sv_moderator.lua")
    AddCSLuaFile("moderator/cl_moderator.lua")

    hook.Add("PostGamemodeLoaded", moderator, function()
        if (nut) then
            -- If we have nutscript for this one, we're going to use nutscript internal resource.
            moderator.nutscript = true
        else
            -- If we don't have nutscript, then just make them download this shit
            moderator.nutscript = false

            resource.AddFile("materials/moderator/leave.png")
            resource.AddFile("materials/moderator/menu.png")
        end
    end)
else
    hook.Add("PostGamemodeLoaded", moderator, function()
        -- to prevent nut table violation.
        moderator.nutscript = (nut and true or false)

        if (moderator.nutscript and NUT_CVAR_LANG:GetString() == "korean") then
            surface.CreateFont("mod_TitleFont", {
                size = 32,
                font = "Malgun Gothic",
                weight = 200,
                extended = true,
            })

            surface.CreateFont("mod_TextFont", {
                size = 16,
                font = "Malgun Gothic",
                weight = 200,
                extended = true,
            })

            surface.CreateFont("mod_SubTitleFont", {
                size = 24,
                font = "Malgun Gothic",
                weight = 200,
                extended = true,
            })
        end
    end)

    include("moderator/cl_moderator.lua")
end