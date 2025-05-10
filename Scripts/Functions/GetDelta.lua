local function GetDelta()
	local Speed = GetSpeed()
	if Speed <= 5 then
		_G.Momentum.Delta.VX = _G.Momentum.VX
		_G.Momentum.Delta.VY = _G.Momentum.VY
	else
		local Scale = 5 / Speed
		_G.Momentum.Delta.VX = _G.Momentum.VX * Scale
		_G.Momentum.Delta.VY = _G.Momentum.VY * Scale
	end
end

return GetDelta