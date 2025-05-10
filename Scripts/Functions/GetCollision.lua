local function GetCollision()
	local Speed = {
		X = math.abs(_G.Momentum.VX),
		Y = math.abs(_G.Momentum.VY)
	}

	local BoundingBoxSize = {
		Width = _G.Momentum.BoundingBox.right_bottom.x - _G.Momentum.BoundingBox.left_top.x,
	 	Height = _G.Momentum.BoundingBox.right_bottom.y - _G.Momentum.BoundingBox.left_top.y,
	}

	if BoundingBoxSize.Width < 0.4 then
		local Expansion = (0.4 - BoundingBoxSize.Width) / 2
		_G.Momentum.BoundingBox.left_top.x = _G.Momentum.BoundingBox.left_top.x- Expansion
		_G.Momentum.BoundingBox.right_bottom.x = _G.Momentum.BoundingBox.right_bottom.x + Expansion
		log("\nAdjusted Width to: " .. serpent.line(_G.Momentum.BoundingBox.right_bottom.x - _G.Momentum.BoundingBox.left_top.x))
	end
	if BoundingBoxSize.Height < 0.4 then
		local Expansion = (0.4 - BoundingBoxSize.Height) / 2
		_G.Momentum.BoundingBox.left_top.y = _G.Momentum.BoundingBox.left_top.y - Expansion
		_G.Momentum.BoundingBox.right_bottom.y = _G.Momentum.BoundingBox.right_bottom.y + Expansion
		log("\nAdjusted Height to: " .. serpent.line(_G.Momentum.BoundingBox.right_bottom.y - _G.Momentum.BoundingBox.left_top.y))
	end

	local NewBoundingBoxSize = {
		Width = _G.Momentum.BoundingBox.right_bottom.x - _G.Momentum.BoundingBox.left_top.x,
		Height = _G.Momentum.BoundingBox.right_bottom.y - _G.Momentum.BoundingBox.left_top.y
	}
	log("\nNew Bounding Box Size: " .. serpent.line(NewBoundingBoxSize))

	local Offset = {
		X = 0,
		Y = 0
	}

	if Speed.X > NewBoundingBoxSize.Width then
		Offset.X = (Speed.X - NewBoundingBoxSize.Width) * (_G.Momentum.VX / math.abs(_G.Momentum.VX))
	end
	if Speed.Y > NewBoundingBoxSize.Height then
		Offset.Y = (Speed.Y - NewBoundingBoxSize.Height) * (_G.Momentum.VX / math.abs(_G.Momentum.VX))
	end

	local SearchArea = {
		{
			X = _G.Momentum.BoundingBox.left_top.x + _G.Momentum.VX - math.max(0, Offset.X),
			Y = _G.Momentum.BoundingBox.left_top.y + _G.Momentum.VY - math.max(0, Offset.Y)
		},
		{
			X = _G.Momentum.BoundingBox.right_bottom.x + _G.Momentum.VX - math.min(0, Offset.X),
			Y = _G.Momentum.BoundingBox.right_bottom.y + _G.Momentum.VY - math.min(0, Offset.Y)
		}
	}
	log("\nSearch Area: " .. serpent.block(SearchArea))

	local Colliders = _G.Momentum.Entity.surface.find_entities_filtered{
		area = SearchArea,
		collision_mask = {
			"player",
			"train",
			"car",
			"is_object"
		}
	}
	log("\nColliders: " .. serpent.block(Colliders))

	local FilteredTable = {}
	for _, Collider in pairs(Colliders) do
		if Collider.type == "character" then
			table.insert(FilteredTable, #FilteredTable + 1, Collider)
		end
	end
	log("\nFiltered Table: " .. serpent.block(FilteredTable))

	return FilteredTable
end

return GetCollision