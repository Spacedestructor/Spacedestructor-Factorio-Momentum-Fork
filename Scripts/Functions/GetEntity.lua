---Hard Dependency for VX, VY, Entity/Corpse. Soft Dependency for BoundingBox
local function GetEntity()
	local BoundingBox = {
		Left = _G.Momentum.BoundingBox and _G.Momentum.BoundingBox.left_top.x or 0,
		Top = _G.Momentum.BoundingBox and _G.Momentum.BoundingBox.left_top.y or 0,
		Right = _G.Momentum.BoundingBox and _G.Momentum.BoundingBox.right_bottom.x or 0,
		Bottom = _G.Momentum.BoundingBox and _G.Momentum.BoundingBox.right_bottom.y or 0
	}
	log("\nBounding Box: " .. serpent.block(BoundingBox))

	local BoundingBoxSize = {
		Width = BoundingBox.Right - BoundingBox.Left,
		Height = BoundingBox.Bottom - BoundingBox.Top
	}
	log("\nBounding Box Size: " .. serpent.block(BoundingBoxSize))

	if BoundingBoxSize.Width < 0.4 then
		local Expansion = (0.4 - BoundingBoxSize.Width) / 2
		BoundingBox.Left = BoundingBox.Left - Expansion
		BoundingBox.Right = BoundingBox.Right + Expansion
		BoundingBoxSize.Width = BoundingBox.Right - BoundingBox.Left
		assert(BoundingBoxSize.Width >= 0.4, "Bounding Box is too thin: " .. serpent.line(BoundingBoxSize.Width) .. " / 0.4")
		log("\nNew Bounding Box Width: " .. serpent.line(BoundingBoxSize.Width))
	end
	if BoundingBoxSize.Height < 0.4 then
		local Expansion = (0.4 - BoundingBoxSize.Height) / 2
		BoundingBox.Top = BoundingBox.Top - Expansion
		BoundingBox.Bottom = BoundingBox.Bottom + Expansion
		BoundingBoxSize.Height = BoundingBox.Bottom - BoundingBox.Top
		assert(BoundingBoxSize.Height >= 0.4, "Bounding Box is too short: " .. serpent.line(BoundingBoxSize.Height) .. " / 0.4")
		log("\nNew Bounding Box Height: " .. serpent.line(BoundingBoxSize.Height))
	end
	_G.Momentum.BoundingBox = _G.Momentum.BoundingBox or {}
	_G.Momentum.BoundingBox.left_top = _G.Momentum.BoundingBox.left_top or {}
	_G.Momentum.BoundingBox.left_top.x = BoundingBox.Left
	_G.Momentum.BoundingBox.left_top.y = BoundingBox.Top
	_G.Momentum.BoundingBox.right_bottom = _G.Momentum.BoundingBox.right_bottom or {}
	_G.Momentum.BoundingBox.right_bottom.x = BoundingBox.Right
	_G.Momentum.BoundingBox.right_bottom.y = BoundingBox.Bottom

	local Offset = {
		X = 0,
		Y = 0
	}

	if math.abs(_G.Momentum.VX) > BoundingBoxSize.Width then
		Offset.X = (math.abs(_G.Momentum.VX) - BoundingBoxSize.Width) * (_G.Momentum.VX / math.abs(_G.Momentum.VX))
	end
	if math.abs(_G.Momentum.VY) > BoundingBoxSize.Height then
		Offset.Y = (math.abs(_G.Momentum.VY) - BoundingBoxSize.Height) * (_G.Momentum.VX / math.abs(_G.Momentum.VX))
	end
	log("\nOffset: " .. serpent.block(Offset))

	local SearchArea = {
		{
			X = BoundingBox.Left + _G.Momentum.VX - math.max(0, Offset.X),
			Y = BoundingBox.Top + _G.Momentum.VY - math.max(0, Offset.Y)
		},
		{
			X = BoundingBox.Right + _G.Momentum.VX - math.min(0, Offset.X),
			Y = BoundingBox.Bottom + _G.Momentum.VY - math.min(0, Offset.Y)
		}
	}
	log("\nName: " .. serpent.line(_G.Momentum.Corpse.name) .. "\nSearch Area: " .. serpent.line(SearchArea) .. "\nPosition: " .. serpent.line(_G.Momentum.Position))

	_G.Momentum.Entity = _G.Momentum.Surface.find_entities_filtered({area = SearchArea, name = _G.Momentum.Corpse.name, position = _G.Momentum.Position})
	log("\nEntity: " .. serpent.line(_G.Momentum.Entity))

	if _G.Momentum.Entity == nil or not _G.Momentum.Entity.valid then
		log("\nInvalid Crash Entity: " .. serpent.block(_G.Momentum.Entity))
	else
		log("\nResulting Entity: " .. serpent.line(_G.Momentum.Entity))
	end
end

return GetEntity