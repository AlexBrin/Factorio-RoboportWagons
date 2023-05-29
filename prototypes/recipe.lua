require("lib")

local roboport_wagon1_recipe = {
    {"cargo-wagon", 2},
    {"iron-plate", 20},
    {"steel-plate", 20},
    {"roboport", 5}
}

local roboport_wagon2_recipe = {
    {"cargo-wagon", 2},
    {"iron-plate", 40},
    {"steel-plate", 20},
    {"personal-roboport-mk2-equipment", 4}
}

local roboport_wagon3_recipe = {
    {"cargo-wagon", 4},
    {"iron-plate", 100},
    {"steel-plate", 100},
    {"personal-roboport-mk2-equipment", 8}
}

if HasSEInstalled() then
    roboport_wagon1_recipe = {
        {"cargo-wagon", 2},
        {"electric-motor", 15},
        {"iron-plate", 20},
        {"roboport", 5},	
    }

    roboport_wagon2_recipe = {
        {"cargo-wagon", 2},
        {"electric-motor", 10},
        {"iron-plate", 20},
        {"low-density-structure", 10},
        {"personal-roboport-mk2-equipment", 4},	
    }

    roboport_wagon3_recipe = {
        {"cargo-wagon", 2},
        {"electric-engine-unit", 20},
        {"iron-plate", 40},
        {"steel-plate", 40},
        {"low-density-structure", 20},
        {"personal-roboport-mk2-equipment", 8},	
    }
end

data:extend({
    {	
        type = "recipe",
        name = "roboport-wagon-1",
        enabled = false,
        ingredients = roboport_wagon1_recipe,
        result = "roboport-wagon-1",
        energy_required = 1,
    },
    {	
        type = "recipe",
        name = "roboport-wagon-2",
        enabled = false,
        ingredients = roboport_wagon2_recipe,
        result = "roboport-wagon-2",
        energy_required = 2,
    },
    {	
        type = "recipe",
        name = "roboport-wagon-3",
        enabled = false,
        ingredients = roboport_wagon3_recipe,
        result = "roboport-wagon-3",
        energy_required = 5,
    },
})