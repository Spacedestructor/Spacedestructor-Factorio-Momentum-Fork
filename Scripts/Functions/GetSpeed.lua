local function GetSpeed()
	return math.sqrt(math.abs(_G.Momentum.VX)^2 + math.abs(_G.Momentum.VY)^2)
end

return GetSpeed