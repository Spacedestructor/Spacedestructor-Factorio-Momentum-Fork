---Will get Player 1, enabled cheat mode, attempt to get Player Character and if true attempt to insert Starting Items and set the hotbar slots to them as well.
local function InsertStartingItems()
	local Player = game.players[1]
	if Player ~= nil then
		Player.cheat_mode = true
		local Character = Player.character
		if Character ~= nil then
			local Inventory = Player.get_main_inventory()
			if Inventory ~= nil then
				Inventory.clear()
				Inventory.insert({name = "blueprint", count = 1})
				local Blueprint = Inventory.find_item_stack("blueprint") or nil
				assert(Blueprint, "Failed to find Blueprint Item.")
				---@diagnostic disable-next-line: undefined-field
				Blueprint.import_stack("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")
				Player.set_quick_bar_slot(1, Blueprint)

				Inventory.insert({name = "rail", count = 1062})
				local Rail = Inventory.find_item_stack("rail")
				assert(Rail, "Failed to find Rail Item.")
				Player.set_quick_bar_slot(2, Rail)

				Inventory.insert({name = "train-stop", count = 8})
				local TrainStop = Inventory.find_item_stack("train-stop")
				assert(TrainStop, "Failed to find Train Stop Item.")
				Player.set_quick_bar_slot(3, TrainStop)

				Inventory.insert({name = "locomotive", count = 4})
				local Locomotive = Inventory.find_item_stack("locomotive")
				assert(Locomotive, "Failed to find Locomotive Item.")
				Player.set_quick_bar_slot(4, Locomotive)

				Inventory.insert({name = "cargo-wagon", count = 1})
				local CargoWagon = Inventory.find_item_stack("cargo-wagon")
				assert(CargoWagon, "Failed to find Cargo Wagon Item.")
				Player.set_quick_bar_slot(5, CargoWagon)

				Inventory.insert({name = "fluid-wagon", count = 1})
				local FluidWagon = Inventory.find_item_stack("fluid-wagon")
				assert(FluidWagon, "Failed to find Fluid Wagon Item.")
				Player.set_quick_bar_slot(6, FluidWagon)

				Inventory.insert({name = "artillery-wagon", count = 1})
				local ArtilleryWagon = Inventory.find_item_stack("artillery-wagon")
				assert(ArtilleryWagon, "Failed to find Artillery Wagon Item.")
				Player.set_quick_bar_slot(7, ArtilleryWagon)

				Inventory.insert({name = "nuclear-fuel", count = 12})
				local NuclearFuel = Inventory.find_item_stack("nuclear-fuel")
				assert(NuclearFuel, "Failed to find Nuclear Fuel Item.")
				Player.set_quick_bar_slot(8, NuclearFuel)

				Inventory.insert({name = "stone-wall", count = 58})
				local StoneWall = Inventory.find_item_stack("stone-wall")
				assert(StoneWall, "Failed to find Stone Wall Item.")
				Player.set_quick_bar_slot(9, StoneWall)

				Inventory.insert({name = "gate", count = 4})
				local Gate = Inventory.find_item_stack("gate")
				assert(Gate, "Failed to find Gate Item.")
				Player.set_quick_bar_slot(19, Gate)

				log("\nSpace Age: " .. serpent.line(script.active_mods["space-age"]))
				local Armor = Player.get_inventory(defines.inventory.character_armor)
				assert(Armor, "Failed to find Armor Inventory.")
				if script.active_mods["space-age"] ~= nil then
					Armor.insert({name = "mech-armor", quality = "legendary", count = 1})
					--Size: 15 17, so 0, 0 to 14, 16
					local Equipment = Armor[1].grid
					assert(Equipment, "Failed to find Armor Grid.")
					Equipment.put({name = "fusion-reactor-equipment", quality = "legendary", position = {x = 0, y = 0}, by_player = Player, ghost = false})
					Equipment.put({name = "fusion-reactor-equipment", quality = "legendary", position = {x = 4, y = 0}, by_player = Player, ghost = false})
					Equipment.put({name = "fusion-reactor-equipment", quality = "legendary", position = {x = 8, y = 0}, by_player = Player, ghost = false})

					Equipment.put({name = "fusion-reactor-equipment", quality = "legendary", position = {x = 0, y = 4}, by_player = Player, ghost = false})
					Equipment.put({name = "fusion-reactor-equipment", quality = "legendary", position = {x = 4, y = 4}, by_player = Player, ghost = false})
					Equipment.put({name = "fusion-reactor-equipment", quality = "legendary", position = {x = 8, y = 4}, by_player = Player, ghost = false})
					--Organize Later
					Equipment.put({name = "exoskeleton-equipment", quality = "legendary", position = {x = 12, y = 0}, by_player = Player, ghost = false})
					Equipment.put({name = "belt-immunity-equipment", quality = "legendary", position = {x = 14, y = 0}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 14, y = 1}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 14, y = 3}, by_player = Player, ghost = false})
					Equipment.put({name = "exoskeleton-equipment", quality = "legendary", position = {x = 12, y = 4}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 0, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 1, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 2, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 3, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 4, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 5, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 6, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 7, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 8, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 9, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 10, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 11, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 0, y = 10}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 2, y = 10}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 4, y = 10}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 6, y = 10}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 8, y = 10}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 10, y = 10}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 0, y = 12}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 2, y = 12}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 4, y = 12}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 6, y = 12}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 8, y = 12}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", quality = "legendary", position = {x = 10, y = 12}, by_player = Player, ghost = false})
					Equipment.put({name = "energy-shield-mk2-equipment", quality = "legendary", position = {x = 0, y = 14}, by_player = Player, ghost = false})
					Equipment.put({name = "energy-shield-mk2-equipment", quality = "legendary", position = {x = 2, y = 14}, by_player = Player, ghost = false})
					Equipment.put({name = "energy-shield-mk2-equipment", quality = "legendary", position = {x = 4, y = 14}, by_player = Player, ghost = false})
					Equipment.put({name = "energy-shield-mk2-equipment", quality = "legendary", position = {x = 6, y = 14}, by_player = Player, ghost = false})
					Equipment.put({name = "energy-shield-mk2-equipment", quality = "legendary", position = {x = 8, y = 14}, by_player = Player, ghost = false})
					Equipment.put({name = "energy-shield-mk2-equipment", quality = "legendary", position = {x = 10, y = 14}, by_player = Player, ghost = false})

					Equipment.put({name = "night-vision-equipment", quality = "legendary", position = {x = 12, y = 12}, by_player = Player, ghost = false})
					Equipment.put({name = "toolbelt-equipment", quality = "legendary", position = {x = 12, y = 14}, by_player = Player, ghost = false})
					Equipment.put({name = "toolbelt-equipment", quality = "legendary", position = {x = 12, y = 15}, by_player = Player, ghost = false})
					Equipment.put({name = "toolbelt-equipment", quality = "legendary", position = {x = 0, y = 16}, by_player = Player, ghost = false})
					Equipment.put({name = "toolbelt-equipment", quality = "legendary", position = {x = 3, y = 16}, by_player = Player, ghost = false})
					Equipment.put({name = "toolbelt-equipment", quality = "legendary", position = {x = 6, y = 16}, by_player = Player, ghost = false})
					Equipment.put({name = "toolbelt-equipment", quality = "legendary", position = {x = 9, y = 16}, by_player = Player, ghost = false})
					Equipment.put({name = "toolbelt-equipment", quality = "legendary", position = {x = 12, y = 16}, by_player = Player, ghost = false})
					Equipment.put({name = "exoskeleton-equipment", quality = "legendary", position = {x = 12, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 14, y = 5}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 14, y = 7}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 14, y = 9}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk3-equipment", quality = "legendary", position = {x = 14, y = 11}, by_player = Player, ghost = false})

					Inventory.insert({name = "construction-robot", count = 744})
					local Robot = Inventory.find_item_stack("construction-robot")
					assert(Robot, "Failed to find Robot Item.")
					Player.set_quick_bar_slot(10, Robot)
				else
					Armor.insert({name = "power-armor-mk2", count = 1})
					--Size: 10 10, so 0, 0 to 9, 9
					local Equipment = Armor[1].grid
					assert(Equipment, "Failed to find Armor Grid.")

					Equipment.put({name = "fission-reactor-equipment", position = {x = 0, y = 0}, by_player = Player, ghost = false})
					Equipment.put({name = "fission-reactor-equipment", position = {x = 0, y = 4}, by_player = Player, ghost = false})
					Equipment.put({name = "fission-reactor-equipment", position = {x = 4, y = 0}, by_player = Player, ghost = false})
					Equipment.put({name = "fission-reactor-equipment", position = {x = 4, y = 4}, by_player = Player, ghost = false})

					Equipment.put({name = "battery-mk2-equipment", position = {x = 0, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk2-equipment", position = {x = 1, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk2-equipment", position = {x = 2, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk2-equipment", position = {x = 3, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk2-equipment", position = {x = 4, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk2-equipment", position = {x = 5, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk2-equipment", position = {x = 6, y = 8}, by_player = Player, ghost = false})
					Equipment.put({name = "battery-mk2-equipment", position = {x = 7, y = 8}, by_player = Player, ghost = false})

					Equipment.put({name = "night-vision-equipment", position = {x = 8, y = 0}, by_player = Player, ghost = false})

					Equipment.put({name = "belt-immunity-equipment", position = {x = 8, y = 2}, by_player = Player, ghost = false})

					Equipment.put({name = "solar-panel-equipment", position = {x = 9, y = 2}, by_player = Player, ghost = false})
					Equipment.put({name = "solar-panel-equipment", position = {x = 8, y = 3}, by_player = Player, ghost = false})
					Equipment.put({name = "solar-panel-equipment", position = {x = 9, y = 3}, by_player = Player, ghost = false})

					Equipment.put({name = "personal-roboport-mk2-equipment", position = {x = 8, y = 4}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", position = {x = 8, y = 6}, by_player = Player, ghost = false})
					Equipment.put({name = "personal-roboport-mk2-equipment", position = {x = 8, y = 8}, by_player = Player, ghost = false})

					Inventory.insert({name = "construction-robot", count = 75})
					local Robot = Inventory.find_item_stack("construction-robot")
					assert(Robot, "Failed to find Robot Item.")
					Player.set_quick_bar_slot(10, Robot)
				end
				script.on_event(defines.events.on_tick, nil)
			end
		end
	end
end
---If "StartingItems" was run at tick 0 this will check once per tick if we have moved past tick 0 and if true call "InsertStartingItems".
---@param Tick number
local function DelayedStartingItems(Tick)
	---@diagnostic disable-next-line: undefined-field
	if Tick > 0 then
		InsertStartingItems()
	end
end
---Checks If we have moved on past the load/init tick, if true calls "InsertStartingItems" otherwise calls "DelayedStartingItems".
---
---Event must be either Player created or cutscene end for this to function as intended.
---@param Tick number
local function StartingItems(Tick)
	if Debug == true then
		---@diagnostic disable-next-line: undefined-field
		if Tick < 1 then
			script.on_event(defines.events.on_tick, function(Event) DelayedStartingItems(Event.tick) end)
		else
			InsertStartingItems()
		end
	end
end

return StartingItems