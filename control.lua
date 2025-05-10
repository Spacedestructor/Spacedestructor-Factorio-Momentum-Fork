Debug = false
if script.active_mods["gvv"] then require("__gvv__.gvv")(); Debug = true end
if script.active_mods["0-event-trace"] then Debug = true end
if __DebugAdapter ~= nil then Debug = true end
log('\n"Debug Mode: "' .. tostring(Debug))
--[[
local CollisionLayers = {}
for Name, CollisionLayer in pairs(prototypes.collision_layer) do
	table.insert(CollisionLayers, #CollisionLayers+1, Name)
end
log("\nCollision Layers: " .. serpent.block(CollisionLayers))
]]
PrintSettings = {color = {r = 255, g = 255, b = 255, a = 255}, sound = defines.print_sound.never, skip = defines.print_skip.never, game_state = false}

--Our Starting Items for Debugging purposes.
local StartingItems = require("Scripts.Functions.Debug")
script.on_event(defines.events.on_player_created, function(Event) StartingItems(Event.tick) end)

--Helper Functions

GetEntity = require("Scripts.Functions.GetEntity")
Teleport = require("Scripts.Functions.Teleport")
GetCollision = require("Scripts.Functions.GetCollision")
GetSpeed = require("Scripts.Functions.GetSpeed")
GetDelta = require("Scripts.Functions.GetDelta")
SetupSetting = require("Scripts.Functions.SetupSetting")

--Settings

M_MULT = SetupSetting("Spacedestructor-Momentum-Mult", 1.5)

--Event Handler

local Init = require("Scripts.EventHandlers.Init")
local Tick = require("Scripts.EventHandlers.Tick")
local EntityDamaged = require("Scripts.EventHandlers.EntityDamaged")

--local PlayerDied = require("Scripts.EventHandlers.PlayerDied")

--New Game

script.on_init(Init)

--Load Game

script.on_configuration_changed(Init)

--Runs once per game tick

script.on_event(defines.events.on_tick, Tick)

--Runs once per instance of Damage dealt to an Entity, filtered based on EntityDamagedFilter

script.on_event(defines.events.on_entity_damaged, function(Event) EntityDamaged(Event) end, {{filter = "damage-type", type = "impact"}, {filter = "type", mode = "and", type = "character"}, {filter = "damage-type", mode = "or", type = "impact"}, {filter = "type", mode = "and", type = "unit"}})

--Runs once per Player Death
--should this trigger at on_player_died or at on_pre_player_died?
--Do We even need this? everything this does is also handled somewhere else already.

--script.on_event(defines.events.on_player_died, function(Event) PlayerDied(Event) end)