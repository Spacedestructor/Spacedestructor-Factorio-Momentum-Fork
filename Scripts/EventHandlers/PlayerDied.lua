---Runs when a Player either is about to die or already has died.
local function PlayerDied(event)
	log("\nEvent: " .. serpent.block(event) .. "\nStorage: " .. serpent.block(storage))
	local Player = game.get_player(event.player_index)
	if Player then
		local Character = Player.character
		if Character then
			log("\nCharacter Unit Number: " .. tostring(Character.unit_number))
			local Crash = rawget(storage.Momentum.Knockback, tostring(Character.unit_number))
			if Crash then
				Crash.Position = Character.position
				Crash.Surface = Character.surface

				rawset(storage.Momentum.Knockback, tostring(Character.unit_number), Crash)

				log("\nStorage: " .. serpent.block(rawget(storage.Momentum.Knockback, tostring(Character.unit_number))))

				GetEntity(tostring(Character.unit_number))
			end
		end
	end
end
return PlayerDied