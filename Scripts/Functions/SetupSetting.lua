---@generic T: ModSettingValue
---@param Name string
---@param Default number
---@return number
local function SetupSetting(Name, Default)
	local Setting = settings.startup[Name]
	if not Setting then
		if Debug then
			log('\nSetting "' .. Name .. '" not found, using Default: ' .. tostring(Default))
		end
		return Default
	else
		if Debug then
			log('\nSetting "' .. Name .. '" to ' .. tostring(Setting.value))
		end
		return Setting.value
	end
end

return SetupSetting