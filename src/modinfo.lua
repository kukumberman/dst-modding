name = "Cucumba"
description = "Learning how to make mods"
author = "kukumberman"
version = "0.0.1"
forumthread = ""
icon_atlas = "modicon.xml"
icon = "modicon.tex"

priority = 0

client_only_mod = true
server_only_mod = false
all_clients_require_mod = false
server_filter_tags = {}

-- DS
api_version = 6
dont_starve_compatible = false
reign_of_giants_compatible = false -- DLC0001
shipwrecked_compatible = false -- DLC0002
hamlet_compatible = false -- DLC0003 

-- DST
api_version_dst = 10
dst_compatible = true
forge_compatible = false

local string = ""
local keys = {}

local function generateKeys(result, from, to)
    local s = string.byte(from, 1)
    local e = string.byte(to, 1)
    do
        local i = s
        while i <= e do
            local key = string.char(i)
            result[#result + 1] = { description = key:upper(), data = i }
            i = i + 1
        end
    end
end

local function SectionTitle(label)
    return {
        name = label:upper(),
        label = label, 
        hover = "",
        options = { { description = "", data = 0 } },
        default = 0,
    }
end

local function Boolean(name, defaultValue, label, yes, no, hover)
    return {
        name = name,
        label = label,
        default = defaultValue,
        options = {
            { description = yes, data = true, hover = "" },
            { description = no, data = false, hover = "" },
        },
        hover = hover
	}
end

local function BooleanYesNo(name, defaultValue, label, hover)
    return Boolean(name, defaultValue, label, "Yes", "No", hover)
end

local function BooleanEnabledDisabled(name, defaultValue, label, hover)
    return Boolean(name, defaultValue, label, "Enabled", "Disabled", hover)
end

local function Keybind(name, defaultValue, label, hover)
    return {
        name = name,
        label = label,
        --default = string.byte(defaultValue:lower(), 1),
        default = defaultValue:lower():byte(),
        options = keys,
        hover = hover,
    }
end

generateKeys(keys, "0", "9")
generateKeys(keys, "a", "z")

configuration_options = {
    SectionTitle("First"),
    Boolean("BOOLEAN_1", true, "Foo", "Yes", "No", "Foo hover"),
    Boolean("BOOLEAN_2", false, "Bar", "Enabled", "Disabled"),
    Keybind("FOO_KEY", "F", "Foo key", "foo key hover"),
    Keybind("BAR_KEY", "B", "Bar key", "bar key hover"),
    SectionTitle("Second"),
    BooleanYesNo("BOOLEAN_3", true, "Another Foo", "Another hover"),
    BooleanEnabledDisabled("BOOLEAN_4", false, "Another Bar"),
}
