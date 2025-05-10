---Handles the per Entity Damage dealt Logic
local function EntityDamaged(Event)
	if not storage.Momentum.Knockback[tostring(Event.entity.unit_number)] then
		local Entity = Event.entity
		assert(Entity ~= nil, "Event Entity missing or invalid.")

		local Corpse
		if Entity.type == "character" then
			Corpse = prototypes.entity[Entity.name].character_corpse or nil
		else
			Corpse = (prototypes.entity[Entity.name].corpses ~= nil and #prototypes.entity[Entity.name].corpses > 0 and prototypes.entity[Entity.name].corpses[1]) or nil
		end
		--Commenting this out because we can still handle living entities, no corpse just means we will delete the crash on death. assert(Corpse ~= nil, "Event Corpse missing.")

		local HasCorpse
		if Corpse == nil then
			HasCorpse = false
		else
			HasCorpse = true
		end

		local Source = Event.source
		assert(Source ~= nil, "Event Source missing.")

		local SourceType = Source.type
		assert(SourceType ~= nil, "Event Source type missing.")

		if SourceType == "unit" then
			game.print("Ouch, " .. serpent.line(Entity.type) .. " has been attacked by a " .. serpent.line(Source.type) .. ".", PrintSettings)
			log("\nOuch, " .. serpent.line(Entity.type) .. " has been attacked by a " .. serpent.line(Source.type) .. ".")
		elseif SourceType == "car" then
			game.print("Vrooom, " .. serpent.line(Entity.type) .. " has been run over by a " .. serpent.line(Source.type) .. ".", PrintSettings)
			log("\nVrooom, " .. serpent.line(Entity.type) .. " has been run over by a " .. serpent.line(Source.type) .. ".")
		elseif SourceType == "locomotive" then
			game.print("Hooonk, " .. serpent.line(Entity.type) .. " stood on the Rails of a " .. serpent.line(Source.type) .. ".", PrintSettings)
			log("\nHooonk, " .. serpent.line(Entity.type) .. " stood on the Rails of a " .. serpent.line(Source.type) .. ".")
		elseif SourceType == "cargo-wagon" then
			game.print("Freight is heavy, " .. serpent.line(Entity.type) .. " got slammed by a " .. serpent.line(Source.type) .. ".", PrintSettings)
			log("\nFreight is heavy, " .. serpent.line(Entity.type) .. " got slammed by a " .. serpent.line(Source.type) .. ".")
		elseif SourceType == "fluid-wagon" then
			game.print("Sticky, " .. serpent.line(Entity.type) .. " got covered in the fluids of a " .. serpent.line(Source.type) .. ".", PrintSettings)
			log("\nSticky, " .. serpent.line(Entity.type) .. " got covered in the fluids of a " .. serpent.line(Source.type) .. ".")
		elseif SourceType == "artillery-wagon" then
			game.print("Cabooom, " .. serpent.line(Entity.type) .. " ran in front of a " .. serpent.line(Source.type) .. ".", PrintSettings)
			log("\nCabooom, " .. serpent.line(Entity.type) .. " ran in front of a " .. serpent.line(Source.type) .. ".")
		elseif SourceType == "infinity-cargo-wagon" then
			game.print("Infinite is a lot, " .. serpent.line(Entity.type) .. " couldnt handle a " .. serpent.line(Source.type) .. ".", PrintSettings)
			log("\nInfinite is a lot, " .. serpent.line(Entity.type) .. " couldnt handle a " .. serpent.line(Source.type) .. ".")
		else
			game.print("Colision," .. serpent.line(Entity.type) .. " got hit by a " .. serpent.line(Source.type) .. ".", PrintSettings)
			log("\nColision," .. serpent.line(Entity.type) .. " got hit by a " .. serpent.line(Source.type) .. ".")
		end

		local Damage = Event.original_damage_amount
		assert(Damage ~= nil, "Collision Damage missing.")

		local Orientation = Source.orientation
		assert(Orientation, "Source Orientation missing.")

		local Rad = Orientation * 2 * math.pi
		assert(Rad ~= nil, "Rad is missing.")

		local Angle = -math.pi / 2
		assert(Angle ~= nil, "Angle is missing.")

		local Speed = Damage / 30
		assert(Speed ~= nil, "Speed is missing.")

		local VX = math.cos(Rad + Angle) * Speed * 0.07 * (settings.startup["Spacedestructor-Momentum-Mult"].value or 1.5)
		assert(VX ~= nil, "VX is missing.")

		local VY = math.sin(Rad + Angle) * Speed * 0.07 * (settings.startup["Spacedestructor-Momentum-Mult"].value or 1.5)
		assert(VY ~= nil, "VY is missing.")

		storage.Momentum.Knockback[tostring(Entity.unit_number)] = {Index = tostring(Entity.unit_number), Surface = Entity.surface, Entity = Entity, Corpse = Corpse, HasCorpse = HasCorpse, Source = Source, Position = Entity.position, VX = VX, VY = VY}
	else
		log("\nEvent Entity " .. serpent.block(Event.entity) .. " has already a crash logged, ignoring it.")
	end
end

return EntityDamaged