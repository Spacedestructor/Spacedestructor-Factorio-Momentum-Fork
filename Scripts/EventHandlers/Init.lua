---Handles Initial setup on New Game or loaded Save.
local function Init()
	storage.Momentum = storage.Momentum or {}
	storage.Momentum.Knockback = storage.Momentum.Knockback or {}
  end
  return Init