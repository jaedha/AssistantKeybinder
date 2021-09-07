--[[
-------------------------------------------------------------------------------
-- Name: Assistant Keybinder
-- Author: jaedha
-- Description: This is an updated version of "Summon Assistant" by Jarth
--              It now supports the companions added in Blackwood
-------------------------------------------------------------------------------
This software is under : CreativeCommons CC BY-NC-SA 4.0
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

You are free to:

	Share — copy and redistribute the material in any medium or format
	Adapt — remix, transform, and build upon the material
	The licensor cannot revoke these freedoms as long as you follow the license terms.

Under the following terms:

	Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
	NonCommercial — You may not use the material for commercial purposes.
	ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
	No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.

Please read full licence at :
http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
]]

local ADDON_NAME = "AssistantKeybinder"

local ASSISTANTS = {
	[267] = true, -- Tythis Andromo, Banker
	[300] = true, -- Nuzhimeh, Merchant
	[301] = true, -- Pirharri, Fence
	[396] = true, -- Allaria Erwen, Merchant
	[397] = true, -- Cassus Andronicus, Banker
	[6376] = true, -- Ezabi, Banker
	[6378] = true, -- Fezez, Merchant
	[9245] = true, -- Bastian Helix, Companion
	[9353] = true, -- Mirri Elendis, Companion
}

function KEYBINDING_MANAGER:IsChordingAlwaysEnabled()
	return true
end

local function CreateBindings()
	for assistantIndex in pairs(ASSISTANTS) do
		local name, _, _, _, unlocked = GetCollectibleInfo(assistantIndex)
		if unlocked then
			local stringId = "SI_BINDING_NAME_ASSISTANTKEYBINDER_" .. assistantIndex
			if GetString(_G[stringId]) == "" then
				ZO_CreateStringId(stringId, ZO_CachedStrFormat(SI_COLLECTIBLE_NAME_FORMATTER, name))
			end
		end
	end
end

local function OnAddonLoaded(_, addonName)
	if addonName == ADDON_NAME then
		CreateBindings()
		EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_COLLECTIBLE_UPDATED, CreateBindings)
		EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_COLLECTION_UPDATED, CreateBindings)
		EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED)
	end

end

EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)
