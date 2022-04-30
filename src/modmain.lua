local require = GLOBAL.require

require "constants"

local function printHandler(text)
    return function()
        print(text)
    end
end

local function talkerSayHandler(text)
    return function()
        local player = GLOBAL.ThePlayer
        if not player then return end
        player.components.talker:Say(text)
    end
end

local function exampleHandler()
    local player = GLOBAL.ThePlayer
    if not player then return end
    local position = player:GetPosition()
    print("[*")
    print(position.x)
    print(position.y)
    print(position.z)
    print("*]")
end

local function hotReload()
    if GLOBAL.TheWorld.ismastersim then
        GLOBAL.c_reset()
        -- GLOBAL.c_rollback(0)
        -- GLOBAL.DoReload()
    else
        GLOBAL.TheNet:SendRemoteExecute("c_reset()")
    end
end

local function tryHotReload()
    local name = GLOBAL.TheFrontEnd:GetActiveScreen().name
    -- ChatInputScreen
    -- ConsoleScreen
    if name == "HUD" then
        hotReload()
    end
end

local function enumerateGlobal()
    print("enumerateGlobal")
    for key, value in pairs(GLOBAL) do print(key, value) end
end

local function comboKey(key, action)
    return function()
        if GLOBAL.TheInput:IsKeyDown(key) then
            action()
        end
    end
end

GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_H, printHandler("GLOBAL.KEY_H"))

GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_H, printHandler(GLOBAL.KEY_H))

GLOBAL.TheInput:AddKeyUpHandler(GLOBAL.KEY_G, printHandler("key up 103"))

GLOBAL.TheInput:AddKeyUpHandler(GLOBAL.KEY_G, exampleHandler)

GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_J, function()
    print(GLOBAL.TheFrontEnd:GetActiveScreen().name)
end)

GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_KP_5, talkerSayHandler("GLOBAL.KEY_KP_5 was pressed"))

GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_R, comboKey(GLOBAL.KEY_CTRL, tryHotReload))

GLOBAL.TheInput:AddKeyDownHandler(GetModConfigData("BAR_KEY"), function()
    GLOBAL.c_give("goldnugget", 1)
end)

print("[Cucumba] mod is running!")
