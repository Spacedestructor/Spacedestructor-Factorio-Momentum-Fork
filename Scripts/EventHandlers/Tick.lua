---Handles all the per Tick Logic.
local function Tick()
	if table_size(storage.Momentum.Knockback) > 0 then
		for Index, Data in pairs(storage.Momentum.Knockback) do
			if Data ~= nil and Data.HasCorpse == true then
				log("\nData: " .. serpent.block(Data))

				---@type number
				_G.Momentum.VX = Data.VX
				assert(_G.Momentum.VX ~= nil and type(_G.Momentum.VX) == "number", "VX " .. serpent.line(_G.Momentum.VX) .. " is empty or not a number.")

				---@type number
				_G.Momentum.VY = Data.VY
				assert(_G.Momentum.VY ~= nil and type(_G.Momentum.VY) == "number", "VY " .. serpent.line(_G.Momentum.VY) .. " is empty or not a number.")

				---@type LuaEntityPrototype
				_G.Momentum.Corpse = Data.Corpse
				---@diagnostic disable-next-line: undefined-field
				assert(_G.Momentum.Corpse ~= nil and type(_G.Momentum.Corpse) == "userdata" and (_G.Momentum.Corpse.type == "character-corpse" or _G.Momentum.Corpse.type == "corpse") and _G.Momentum.Corpse.object_name == "LuaEntityPrototype", "Entity Prototype " .. serpent.line(_G.Momentum.Corpse) .. " is not a Corpse.")

				---@type LuaEntity
				_G.Momentum.Entity = Data.Entity
				assert(_G.Momentum.Entity ~= nil and type(_G.Momentum.Entity) == "userdata" and _G.Momentum.Entity.object_name == "LuaEntity", "\nEntity " .. serpent.line(_G.Momentum.Entity) .. " is not an Entity,")

				if _G.Momentum.Entity == nil or not _G.Momentum.Entity.valid then
					log("\nEntity is invalid.")
					GetEntity()
				else
					log("\nEntity is valid.")
				end

				error("Debug End.", 1)
				---Clean up for Code below this Line.

				_G.Momentum = {}
				assert(_G.Momentum ~= nil and type(_G.Momentum) == "table", "\nGlobal Momentum " .. serpent.block(_G.Momentum) .. " is either missing or not a table.")

				---@type string
				_G.Momentum.Index = Data.Index
				assert(_G.Momentum.Index ~= nil, type(_G.Momentum.Index) == "string", tonumber(_G.Momentum.Index) ~= nil, "\nIndex " .. serpent.line(_G.Momentum.Index) .. " is either missing, not a string or not a stringified number.")

				---@type LuaSurface
				_G.Momentum.Surface = Data.Surface
				assert(_G.Momentum.Surface ~= nil and type(_G.Momentum.Surface) == "userdata" and  _G.Momentum.Surface.object_name == "LuaSurface", "Surface " .. serpent.line(_G.Momentum.Surface) .. " is not a Surface.")

				---@type BoundingBox
				_G.Momentum.BoundingBox = _G.Momentum.BoundingBox or (_G.Momentum.Entity and _G.Momentum.Entity.bounding_box) or (_G.Momentum.Corpse and _G.Momentum.Corpse.collision_box) or {}
				if _G.Momentum.BoundingBox == {} then
					---@type MapPosition
					_G.Momentum.BoundingBox.left_top = {}
					---@type double
					_G.Momentum.BoundingBox.left_top.x = 1
					---@type double
					_G.Momentum.BoundingBox.left_top.y = 1
					---@type MapPosition
					_G.Momentum.BoundingBox.right_bottom = {}
					---@type double
					_G.Momentum.BoundingBox.right_bottom.x = 1
					---@type double
					_G.Momentum.BoundingBox.right_bottom.y = 1
				end
				log("\nBounding Box: " .. serpent.block(_G.Momentum.BoundingBox))
				--Skipping asserts from now on until something actually goes wrong and i need to find where the4 issue starts. nested tables require too complex assert structures to just randomly write them for the hell of it. Using Logs instead to see visually during development if i need to use asserts.

				---@type boolean
				_G.Momentum.HasCorpse = Data.HasCorpse
				assert(_G.Momentum.HasCorpse ~= nil and type(_G.Momentum.HasCorpse) == "boolean", "\nHas Corpse " .. serpent.line(_G.Momentum.HasCorpse) .. " is either missing or not a boolean.")

				---@type MapPosition
				_G.Momentum.Position = Data.Position
				assert((_G.Momentum.Position ~= nil and type(_G.Momentum.Position) == "table") and ((_G.Momentum.Position.x ~= nil and type(_G.Momentum.Position.x) == "number") or (_G.Momentum.Position[1] ~= nil and type(_G.Momentum.Position[1]) == "number")) and ((_G.Momentum.Position.y ~= nil and type(_G.Momentum.Position.y) == "number") or (_G.Momentum.Position[2] ~= nil and type(_G.Momentum.Position[2]) == "number")), "Position " .. serpent.line(_G.Momentum.Position) .. " is either empty or not a Map Position.")

				---@type LuaEntity
				_G.Momentum.Source = Data.Source
				assert(_G.Momentum.Source ~= nil and type(_G.Momentum.Source) == "userdata" and _G.Momentum.Source.object_name == "LuaEntity", "Source " .. serpent.line(_G.Momentum.Source) .. " is not an Entity.")

				---@type table
				_G.Momentum.Delta = {}
				assert(_G.Momentum.Delta ~= nil and type(_G.Momentum.Delta) == "table", "Delta " .. serpent.line(_G.Momentum.Delta) .. " is empty or not a table.")

				---@type number
				_G.Momentum.Delta.VX = 0
				assert(_G.Momentum.Delta.VX ~= nil and type(_G.Momentum.Delta.VX) == "number", "Delta VX " .. serpent.line(_G.Momentum.Delta.VX) .. " is empty or not a number.")

				---@type number
				_G.Momentum.Delta.VY = 0
				assert(_G.Momentum.Delta.VY ~= nil and type(_G.Momentum.Delta.VY) == "number", "Delta VY " .. serpent.line(_G.Momentum.Delta.VY) .. " is empty or not a number.")

				---@type number
				_G.Momentum.Friction = 0
				assert(_G.Momentum.Friction ~= nil and type(_G.Momentum.Friction) == "number", "Friction " .. serpent.line(_G.Momentum.Friction) .. " is empty or not a number.")

				GetDelta()

				if (_G.Momentum.VX or _G.Momentum.VY) == nil or ((_G.Momentum.VX < 0.1 and _G.Momentum.VX > -0.1) and (_G.Momentum.VY < 0.1 and _G.Momentum.VY > -0.1)) then
					log("\nDelta unavailable or less then minimum Speed.")
					storage.Momentum.Knockback[Index] = nil
				else
					local Moved = nil

					local TargetPosition = {}

					log("\nEntity Position: " .. serpent.line(_G.Momentum.Entity.position))

					TargetPosition = {
						X = _G.Momentum.Entity.position.x + _G.Momentum.VX,
						Y = _G.Momentum.Entity.position.y + _G.Momentum.VY
					}

					log("\nTarget Position: " .. serpent.line(TargetPosition))

					local Collisions = GetCollision()
					log("\nCollisions: " .. serpent.block(Collisions))

					if #Collisions == 0 then
						Moved = true
						Teleport()
					else
						error("Debug End.", 1)
						local Source = _G.Momentum.Source
						log("\nSource: " .. serpent.line(Source))

						local Speed = GetSpeed()
						log("\nSpeed: " .. serpent.line(Speed))

						local Damage = Speed * 200
						log("\nDamage: " .. serpent.line(Damage))

						while #Collisions > 0 do
							local Collision = nil
							while #Collisions > 0 do
								local Value = table.remove(Collisions, 1)
								if Value.valid then
									Collision = Value
								end
							end
							log("\nProcessing Collision: " .. serpent.line(Collision))

							local NewDamage, Penetration = nil, nil
							if Damage * 2 < 1 then
								return 0, false
							elseif Collision == nil then
								return Damage * 2, false
							else
								Collision.damage(Damage * 2, _G.Momentum.Entity.force or _G.Momentum.Corpse.force, "impact", _G.Momentum.Source,
									_G.Momentum.Entity or _G.Momentum.Corpse)
								return Damage * 2, true
							end
							log("\nNewDamage: " .. serpent.line(NewDamage))

							if _G.Momentum.Entity.valid then
								_G.Momentum.Entity.damage(NewDamage * 0.5, _G.Momentum.Entity.force, "impact", Collision or _G.Momentum.Entity,
									_G.Momentum.Source or _G.Momentum.Entity)
							end

							Moved = not Penetration

							local Friction = 0.5 + 0.5 * (1 / #Collisions)
							log("\nFriction: " .. serpent.line(Friction))

							_G.Momentum.Friction = Friction
							log("\nData: " .. serpent.block(_G.Momentum))

							Teleport()
						end
					end
					if Moved then
						_G.Momentum.Position = _G.Momentum.Entity.position or _G.Momentum.Corpse.position
						log("\nNew Position: " .. serpent.line(_G.Momentum.Position))
					end
					if _G.Momentum.Entity.valid then
						local function HalveDistance()
							if GetSpeed() >= 0.1 then
								if #Collisions > 0 then
									HalveDistance()
								else
									_G.Momentum.Position = {
										_G.Momentum.Entity.position.x + _G.Momentum.VX,
										_G.Momentum.Entity.position.y + _G.Momentum.VY
									}
									_G.Momentum.Entity.teleport(_G.Momentum.Position)
									_G.Momentum.VX = _G.Momentum.VX / 2
									_G.Momentum.VY = _G.Momentum.VY / 2
									HalveDistance()
								end
							end
						end
						HalveDistance()
						_G.Momentum = nil
					else
						_G.Momentum = nil
						log("\nCollision Handling Concluded, Data deleted. Remaining Collisions: " ..
						serpent.block(storage.Momentum.Knockback))
					end
				end
				log("\nEnd of Tick Data\nGlobal: " .. serpent.block(_G.Momentum) .. "\nData: " .. serpent.block(Data))
				storage.Momentum.Knockback[Index] = _G.Momentum
				--rawset(storage.Momentum.Knockback, Index, Data)
			else
				storage.Momentum.Knockback[Index] = nil
			end
		end
	end
end

return Tick
