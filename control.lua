require("lib")

local WagCount = 0
local WagControlCount = 0

function Init()
    global = {}
    global.WagonList = {}
    global.WagControlList = {}
end

function ReInit()
    Init()
    Load()
end

function Load()
    WagCount = #global.WagonList
    WagControlCount = #global.WagControlList
end

function OnInit()
    Init()
    Load()
end

function OnLoad()
    Load()
end

script.on_init(OnInit)
script.on_load(OnLoad)

function fillGridRoboportWagon1(entity)
    -- If the ElectricTrains mod is installed, the generator is not needed. 
    -- The power supply of the car comes from the same network as the locomotive
    -- if HasElectricTrainInstalled() then
        -- entity.grid.put({name="personal-roboport-mk2-equipment", position={0,0}})
    -- else
    entity.grid.put({name="rw-wagon-generator-1", position={0,0}})
    -- end

    entity.grid.put({name="personal-roboport-equipment", position={2,0}})
    entity.grid.put({name="personal-roboport-equipment", position={4,0}})
end

function fillGridRoboportWagon2(entity)
    -- if HasElectricTrainInstalled() then
        -- entity.grid.put({name="personal-roboport-mk2-equipment", position={0,0}})
    -- else
        entity.grid.put({name="rw-wagon-generator-2", position={0,0}})
    -- end

    entity.grid.put({name="personal-roboport-mk2-equipment", position={0,2}})
    entity.grid.put({name="personal-roboport-mk2-equipment", position={2,0}})
    entity.grid.put({name="personal-roboport-mk2-equipment", position={2,2}})
end

function fillGridRoboportWagon3(entity)
    -- if HasElectricTrainInstalled() then
        -- entity.grid.put({name="personal-roboport-mk2-equipment", position={0,0}})
    -- else
    entity.grid.put({name="rw-wagon-generator-3", position={0,0}})
    -- end
    
    entity.grid.put({name="personal-roboport-mk2-equipment", position={0,2}})
    entity.grid.put({name="personal-roboport-mk2-equipment", position={0,4}})
    entity.grid.put({name="personal-roboport-mk2-equipment", position={2,0}})
    entity.grid.put({name="personal-roboport-mk2-equipment", position={2,2}})
    entity.grid.put({name="personal-roboport-mk2-equipment", position={2,4}})
    entity.grid.put({name="personal-roboport-mk2-equipment", position={4,0}})
    entity.grid.put({name="personal-roboport-mk2-equipment", position={4,2}})
    entity.grid.put({name="personal-roboport-mk2-equipment", position={4,4}})
end

local roboport_grid_fill_function = {
    ["roboport-wagon-1"] = fillGridRoboportWagon1,
    ["roboport-wagon-2"] = fillGridRoboportWagon2,
    ["roboport-wagon-3"] = fillGridRoboportWagon3,
}

function CreateProvider(wag)
    local control = global.WagControlList[1]
    local pos = control.position
    local surface = control.surface
    local force = control.force
    local entity = surface.create_entity{name=wag.entity.name .. "-power", position=pos, force=force}
    wag.provider = entity
end

function OnBuildEntity(event)
    local entity = event.created_entity or event.entity

    if global.WagonList == nil then
        ReInit()
    end
    
    local fillFunction = roboport_grid_fill_function[entity.name]
    if fillFunction then
        fillFunction(entity)
        -- CreateProvider(entity)

        entity.grid.get({0,0}).burner.inventory.insert({
            name = "rw-electric-wagon-fuel",
            count = 1
        })

        table.insert(global.WagonList, {entity=entity, provider=nil})
        WagCount = WagCount + 1
    end
end

function OnRemoveEntity(event)
    local entity = event.entity

    if entity and entity.valid then
        if entity.name:match("^roboport%-wagon%-%d$") then
            entity.grid.clear()

            for i, control in pairs(global.WagControlList) do
                for _, wag in pairs(global.WagonList) do
                    if wag.provider and wag.provider.valid then
                        wag.provider.destroy()
                    end
                    wag.provider = nil
                end

                table.remove(global.WagonList, i)
                WagCount = WagCount - 1
                break
            end
        end
    end
end



script.on_event({defines.events.on_built_entity,defines.events.on_robot_built_entity,defines.events.script_raised_built}, OnBuildEntity)
script.on_event({defines.events.on_pre_player_mined_item,defines.events.on_robot_pre_mined,defines.events.on_entity_died,defines.events.script_raised_destroy}, OnRemoveEntity)

local function onTickElectricWagon(event)
    for x, wag in ipairs(global.WagonList) do
        if not (wag.provider and wag.provider.valid) then
            if not wag.entity or not wag.entity.valid then
                table.remove(global.WagonList, x)
                WagCount = WagCount - 1
            else
                CreateProvider(wag)
            end
        else
            if not wag.entity or not wag.entity.valid then
                table.remove(global.WagonList, x)
                WagCount = WagCount - 1
            else
                local burner = wag.entity.grid.get({0,0}).burner
                if burner and burner.valid then
                    needPower = burner.currently_burning.fuel_value - burner.remaining_burning_fuel
                    restPower = wag.provider.energy - needPower
                    if restPower > 0 then
                        burner.remaining_burning_fuel = burner.currently_burning.fuel_value
                        wag.provider.energy = wag.provider.energy - needPower
                    else
                        burner.remaining_burning_fuel = burner.remaining_burning_fuel + wag.provider.energy
                        wag.provider.energy = 0
                    end
                end
            end
        end
    end
end

local function onTickBurnerWagon(event)
    for x, entity in ipairs(global.WagonList) do
        if entity.valid then
            burner_inventory = entity.grid.get({0, 0}).burner.inventory
            wagon_inventory = entity.get_inventory(defines.inventory.cargo_wagon)
            for i = 0, #wagon_inventory - 1 do 
                itemstack = wagon_inventory[#wagon_inventory - i]
                if itemstack.valid then
                    burner_inventory[1].transfer_stack(itemstack)
                end
            end
        else
            table.remove(global.WagonList, x)
            WagCount = WagCount - 1
        end
    end
end

function CheckControllers()
    if not HasElectricTrainInstalled() then
        return
    end

    if #global.WagControlList > 0 then
        return
    end

    for _, surface in pairs(game.surfaces) do
        local controls = surface.find_entities_filtered{type="electric-energy-interface"}
        for _, control in pairs(controls) do
            if control.name:match("^et%-control%-station%-%d$") then
                table.insert(global.WagControlList, control)
            end
        end
    end
end

function OnTick(event)
    if WagCount > 0 then
        CheckControllers()

        if HasElectricTrainInstalled() then
            onTickElectricWagon(event)
        else
            onTickBurnerWagon(event)
        end
    end
end

script.on_nth_tick(1, OnTick)
