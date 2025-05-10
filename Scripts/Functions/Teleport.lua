local function Teleport()
	local Success = _G.Momentum.Entity.teleport(_G.Momentum.Position)
	log("\nTeleport Success: " .. serpent.line(Success))
	if Success then
		_G.Momentum.Delta.VX = _G.Momentum.VX * _G.Momentum.Friction
		_G.Momentum.Delta.VY = _G.Momentum.VY * _G.Momentum.Friction
		log("\nNew Delta: " .. serpent.block(_G.Momentum.Delta))
	end
end

return Teleport