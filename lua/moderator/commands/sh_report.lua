--[[
    Copyright: Omar Saleh Assadi, Brian Hang 2014-2018; Licensed under the EUPL, with extension of article 5
    (compatibility clause) to any licence for distributing derivative works that have been
    produced by the normal use of the Work as a library
--]]
if (SERVER) then
    util.AddNetworkString("mod_ReportList")
    util.AddNetworkString("mod_ReportAdd")
    util.AddNetworkString("mod_ReportDelete")

    if (not moderator.reports) then
        moderator.reports = moderator.GetData("reports")
    end

    hook.Add("PlayerInitialSpawn", "mod_SendReports", function(client)
        timer.Simple(1, function()
            if (moderator.reports and table.Count(moderator.reports) > 0 and client:CheckGroup("moderator")) then
                net.Start("mod_ReportList")
                net.WriteTable(moderator.reports)
                net.Send(client)
            end
        end)
    end)

    net.Receive("mod_ReportDelete", function(length, client)
        if (not client:CheckGroup("moderator")) then return end
        local index = net.ReadUInt(16)
        moderator.reports[index] = nil
        moderator.SetData("reports", moderator.reports)
        local players = moderator.GetPlayersByGroup("moderator")

        if (#players > 0) then
            net.Start("mod_ReportDelete")
            net.WriteUInt(index, 16)
            net.Send(players)
        end
    end)
else
    net.Receive("mod_ReportList", function(length)
        moderator.reports = net.ReadTable()
    end)

    net.Receive("mod_ReportAdd", function(length)
        moderator.reports = moderator.reports or {}
        moderator.reports[net.ReadUInt(16)] = net.ReadTable()
        moderator.updateReports = true
    end)

    net.Receive("mod_ReportDelete", function(length)
        if (moderator.reports) then
            moderator.reports[net.ReadUInt(16)] = nil
            moderator.updateReports = true
        end
    end)
end

local COMMAND = {}
COMMAND.name = "Report"
COMMAND.tip = "Creates a new report for administrators to see."
COMMAND.noTarget = true
COMMAND.noArrays = true
COMMAND.usage = "<string message>"
COMMAND.example = "!report I am stuck - Tells all administrators you are stuck."
COMMAND.hidden = true
COMMAND.reportLength = 5
function COMMAND:OnRun(client, arguments)
    local text = table.concat(arguments, " "):sub(1, 250)

    if (#text < self.reportLength) then
        local noticeText = moderator:L(client, "reportTooShort", self.reportLength)
        return false, noticeText
    end

    if ((client.modNextReport or 0) < CurTime()) then
        client.modNextReport = CurTime() + 60
    else
        local noticeText = moderator:L(client, "reportWait", math.ceil(client.modNextReport - CurTime()))
        return false, noticeText
    end

    moderator.reports = moderator.reports or {}
    local players = moderator.GetPlayersByGroup("moderator")

    local report = {
        date = os.time(),
        text = text,
        steamID = client:SteamID()
    }

    local index = #moderator.reports + 1

    if (#players > 0) then
        net.Start("mod_ReportAdd")
        net.WriteUInt(index, 16)
        net.WriteTable(report)
        net.Send(players)

        for k, v in pairs(players) do
            local noticeText = moderator:L(v, "reportReceived", client:Name(), text)
            moderator.Notify(v, noticeText)
        end
    end

    moderator.reports[index] = report
    moderator.SetData("reports", moderator.reports)

    local noticeText = moderator:L(client, "reportPending", index)
    return false, noticeText
end

moderator.commands.report = COMMAND