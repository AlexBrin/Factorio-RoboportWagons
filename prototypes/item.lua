require("lib")

function createWagonItem(name, typ) 
    local subgroup = "transport"
    if HasElectricTrainInstalled() then
        subgroup = "electric-transport-cargo"
    end

    data:extend({
        {
            type = "item-with-entity-data",
            name = name,
            icon = "__RoboportWagons__/graphics/" .. name .. "/item.png",
            icon_size = 32,
            subgroup = subgroup,
            order = "a[train-system]-g[" .. typ .. "-wagon]",
            place_result = name,
            stack_size = 5,
        }
    })
end

createWagonItem("roboport-wagon-1", "roboport")
createWagonItem("roboport-wagon-2", "roboport")
createWagonItem("roboport-wagon-3", "roboport")

-- local generator = table.deepcopy(data.raw["generator-equipment"]["fusion-reactor-equipment"])
-- generator.name = rw-wagon-generator

function createWagonGenerator(power, level)
    level = tostring(level)

    data:extend({
        {
            type = "generator-equipment",
            name = "rw-wagon-generator-" .. level,
            categories = {"armor"},
            energy_source = {
                buffer_capacity = power,
                type = "electric",
                usage_priority = "secondary-output",
            },
            shape = {
                type = "full",
                width = 2,
                height = 2,
            },
            sprite = {
                filename = "__base__/graphics/icons/boiler.png",
                size = 32,
            },
            power = power,
            burner = {
                type = "burner",
                fuel_inventory_size = 1
            },
        },
        {
            type = "item",
        name = "rw-wagon-generator-" .. level,
        icon = "__base__/graphics/icons/boiler.png",
		icon_size = 32,
		placed_as_equipment_result = "rw-wagon-generator-" .. level,
		subgroup = "equipment",
		order = "a[energy-source]-b[fusion-reactor]",
		stack_size = 1,
        }
    })
end

createWagonGenerator("2MW", 1)
createWagonGenerator("12MW", 2)
createWagonGenerator("32MW", 3)

data:extend({
    {
		type = "item",
		name = "rw-electric-wagon-fuel",
		icon = "__base__/graphics/icons/wood.png",
		icon_size = 32,
		flags = { "hidden" },
		fuel_value = "20MJ",
		fuel_category = "chemical",
		stack_size = 5
	}
})
