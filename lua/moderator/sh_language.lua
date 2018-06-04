--[[
    add your copyright thingy here.
]]

moderator.language = {}
moderator.language.list = {}
moderator.languageExchange = {
    en = "english",
    kr = "korean",
}

local ClientGetInfo = FindMetaTable("Player").GetInfo
function moderator:getLanguage(client)
    -- nutscript support mate.
    if (SERVER) then
        if (IsValid(client) and moderator.nutscript) then
            return ClientGetInfo(client, "nut_language")
        end
    else
        if (moderator.nutscript) then
		    return NUT_CVAR_LANG:GetString()
        end
    end

    return moderator.myLanguage or "english"
end

function moderator:getLanguageTable(client)
    local lang = moderator:getLanguage(client)
    local langTable = moderator.language.list

    if (lang) then
        if (langTable[lang]) then
            return langTable[lang]
        else
            return langTable.english
        end
    end
end

if (CLIENT) then
    function moderator:L(key, ...)
        local curLang = moderator:getLanguageTable()
        local langTable = moderator.language.list

        if (curLang) then
            local word = curLang[key]
            if (word) then
                return string.format(word, ...)
            else
                return key
            end
        else
            return key
        end
    end
else
    function moderator:L(client, key, ...)
        local curLang = moderator:getLanguageTable(client)
        local langTable = moderator.language.list

        if (curLang) then
            local word = curLang[key]
            if (word) then
                return string.format(word, ...)
            else
                return key
            end
        else
            return key
        end
    end
end

local LANG = moderator.language.list
LANG.english = {
    moderatorTitle = "Moderator",
    menuStatistics = "Statistics",
    menuReports = "Reports",
    menuPlayers  = "Players",
    menuGroups = "Groups",
    menuBans = "Bans",
    menuSettings = "Settings",

    statBans = "Active Bans: %s",
    statReports = "Active Reports: %s",
    statPlayers = "Players %s/%s",
    statStaffs = "Staff Online",

    reportNoReport = "There are currently no reports to view.",

    groupGroup = "Group",
    groupParent = "Parent",
    groupName = "Name",
    groupColor = "Color",
    groupIcon = "Icon",
    groupImmunity = "Immunity",
    groupPermissions = "Permissions",

    bansNoBan = "There are currently no bans to view.",

    settingsColor = "Color Options",
    settingAdministrative = "Administrative Options", 
    settingClearSelection = "Clear selection after a command", 

    reportPending = "your report (# %s) has been sent and is awaiting review.",
    reportReceived = "%s has reported %s.",
    reportTooShort = "The report should contain at least 5 characters.",
    reportWait = "You must wait %s second(s) to send another report.",
}

LANG.korean = {
    moderatorTitle = "관리자 패널",
    menuStatistics = "통계",
    menuReports = "신고",
    menuPlayers  = "사용자",
    menuGroups = "그룹",
    menuBans = "추방 목록",
    menuSettings = "설정",

    statBans = "총 추방된 플레이어: %s",
    statReports = "처리되지 않은 신고: %s",
    statPlayers = "플레이어 %s/%s",
    statStaffs = "접속중인 스태프",

    reportNoReport = "현재 접수된 신고가 없습니다.",

    groupGroup = "그룹",
    groupParent = "부모",
    groupName = "이름",
    groupColor = "색깔",
    groupIcon = "아이콘",
    groupImmunity = "파워",
    groupPermissions = "권한",

    bansNoBan = "현재 추방된 플레이어가 없습니다.",

    settingsColor = "메뉴 색 파레트",
    settingAdministrative = "관리 옵션", 
    settingClearSelection = "명령어 실행후 선택한 사용자 체크 해제", 

    reportPending = "#%s 번 신고가 성공적으로 접수되었습니다.",
    reportReceived = "%s 님이 신고를 접수했습니다: %s.",
    reportTooShort = "신고하시려면 적어도 %s자는 적어야 합니다.",
    reportWait = "다음 신고까지 %s초 기다려주시기 바랍니다.",
}