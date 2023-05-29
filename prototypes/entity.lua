require("lib")

local function createWagonInterface(wagon)
    local power = format_number(wagon.max_power)
    local energy = power * 1.1

    data:extend({
        {
            type = "electric-energy-interface",
            name = wagon.name .. "-power",
            icon = wagon.icon,
            icon_size = 32,
            localised_name = {"entity-name." .. wagon.name},
			collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
			selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
			collision_mask = {"ground-tile"},
			selectable_in_game = false,
            energy_source =
			{
				type = "electric",
				buffer_capacity = (energy * 2) .. "J",
				usage_priority = "secondary-input",
				input_flow_limit = energy .. "J" ,
				drain = power / 10 .. "J" ,
				render_no_network_icon = false,
				render_no_power_icon = false
			},
            picture =
			{
				filename = "__core__/graphics/empty.png",
				priority = "extra-high",
				width = 1,
				height = 1
			},
			order = "z"
        }
    })
end

local function createRoboportWagon(wagon)
    local name = wagon.name
    local power = format_number(wagon.max_power)
    local energy = power * 1.1

    wagon.icon = "__RoboportWagons__/graphics/" .. name .. "/item.png"
    wagon.equipment_grid = name .. "-equipment-grid"
    wagon.enable_logistics_while_moving = true
    wagon.burner = {fuel_inventory_size = 0}
    wagon.minable = {
        mining_time = 0.5,
        result = name,
    }
    wagon.energy_source = {
        type = "electric",
        buffer_capacity = (energy * 2) .. "J",
        usage_priority = "secondary-input",
        input_flow_limit = energy .. "J" ,
        drain = power / 10 .. "J" ,
        render_no_network_icon = true,
        render_no_power_icon = true
    }
    wagon.logistic_mode = "passive-provider"

    wagon.pictures.layers[1].filenames = {
        "__RoboportWagons__/graphics/" .. name .. "/cargo-wagon-1.png",
        "__RoboportWagons__/graphics/" .. name .. "/cargo-wagon-2.png",
        "__RoboportWagons__/graphics/" .. name .. "/cargo-wagon-3.png",
        "__RoboportWagons__/graphics/" .. name .. "/cargo-wagon-4.png"
    }
    wagon.pictures.layers[1].hr_version.filenames = {
        "__RoboportWagons__/graphics/" .. name .. "/hr-cargo-wagon-1.png",
        "__RoboportWagons__/graphics/" .. name .. "/hr-cargo-wagon-2.png",
        "__RoboportWagons__/graphics/" .. name .. "/hr-cargo-wagon-3.png",
        "__RoboportWagons__/graphics/" .. name .. "/hr-cargo-wagon-4.png"
    }
    wagon.horizontal_doors.layers[1].filename = "__RoboportWagons__/graphics/" .. name .. "/cargo-wagon-door-horizontal-end.png"
    wagon.horizontal_doors.layers[1].hr_version.filename = "__RoboportWagons__/graphics/" .. name .. "/hr-cargo-wagon-door-horizontal-end.png"
    wagon.horizontal_doors.layers[2].filename = "__RoboportWagons__/graphics/" .. name .. "/cargo-wagon-door-horizontal-side.png"
    wagon.horizontal_doors.layers[2].hr_version.filename = "__RoboportWagons__/graphics/" .. name .. "/hr-cargo-wagon-door-horizontal-side.png"
    wagon.horizontal_doors.layers[4].filename = "__RoboportWagons__/graphics/" .. name .. "/cargo-wagon-door-horizontal-top.png"
    wagon.horizontal_doors.layers[4].hr_version.filename = "__RoboportWagons__/graphics/" .. name .. "/hr-cargo-wagon-door-horizontal-top.png"
    wagon.vertical_doors.layers[1].filename = "__RoboportWagons__/graphics/" .. name .. "/cargo-wagon-door-vertical-end.png"
    wagon.vertical_doors.layers[1].hr_version.filename = "__RoboportWagons__/graphics/" .. name .. "/hr-cargo-wagon-door-vertical-end.png"
    wagon.vertical_doors.layers[2].filename = "__RoboportWagons__/graphics/" .. name .. "/cargo-wagon-door-vertical-side.png"
    wagon.vertical_doors.layers[2].hr_version.filename = "__RoboportWagons__/graphics/" .. name .. "/hr-cargo-wagon-door-vertical-side.png"
    wagon.vertical_doors.layers[4].filename = "__RoboportWagons__/graphics/" .. name .. "/cargo-wagon-door-vertical-top.png"
    wagon.vertical_doors.layers[4].hr_version.filename = "__RoboportWagons__/graphics/" .. name .. "/hr-cargo-wagon-door-vertical-top.png"

    data:extend({wagon})
    createWagonInterface(wagon)
end

local cargo_wagon_1 = table.deepcopy(data.raw['cargo-wagon']['cargo-wagon'])
cargo_wagon_1.name = "roboport-wagon-1"
cargo_wagon_1.inventory_size = 30
cargo_wagon_1.max_health = 800
cargo_wagon_1.weight = 1500
cargo_wagon_1.max_speed = 1.8
cargo_wagon_1.max_power = "6000kW"
cargo_wagon_1.braking_force = 4
cargo_wagon_1.friction_force = 0.375
cargo_wagon_1.air_resistance = 0.003
cargo_wagon_1.icon_size = 32
cargo_wagon_1.icon_mipmaps = nil

local cargo_wagon_2 = table.deepcopy(data.raw['cargo-wagon']['cargo-wagon'])
cargo_wagon_2.name = "roboport-wagon-2"
cargo_wagon_2.inventory_size = 50
cargo_wagon_2.max_health = 800
cargo_wagon_2.weight = 1500
cargo_wagon_2.max_speed = 1.8
cargo_wagon_2.max_power = "16500kW"
cargo_wagon_2.braking_force = 4
cargo_wagon_2.friction_force = 0.375
cargo_wagon_2.air_resistance = 0.003
cargo_wagon_2.icon_size = 32
cargo_wagon_2.icon_mipmaps = nil

local cargo_wagon_3 = table.deepcopy(data.raw['cargo-wagon']['cargo-wagon'])
cargo_wagon_3.name = "roboport-wagon-3"
cargo_wagon_3.inventory_size = 80
cargo_wagon_3.max_health = 800
cargo_wagon_3.weight = 1500
cargo_wagon_3.max_speed = 1.8
cargo_wagon_3.max_power = "31500kW"
cargo_wagon_3.braking_force = 4
cargo_wagon_3.friction_force = 0.375
cargo_wagon_3.air_resistance = 0.003
cargo_wagon_3.icon_size = 32
cargo_wagon_3.icon_mipmaps = nil

data.raw["locomotive"]["locomotive"].inventory_size = 60
data.raw["locomotive"]["locomotive"].trash_inventory_size = 60

createRoboportWagon(cargo_wagon_1)
createRoboportWagon(cargo_wagon_2)
createRoboportWagon(cargo_wagon_3)
