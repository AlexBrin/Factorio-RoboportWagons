require("lib")


local roboport_wagon1 = {
    type = "technology",
    name = "roboport-wagon-1",
    localised_name = {"technology.roboport-wagon-1"},
    icon_size = 256,
    icon_mipmaps = nil,
    icon = "__RoboportWagons__/graphics/technology/roboport-wagon-1.png",
    effects = {
        {
            type = "unlock-recipe",
            recipe = "roboport-wagon-1",
        }
    },
    prerequisites = {"railway", "personal-roboport-equipment"},
    unit = {
        count = 300,
        ingredients = {
            {"automation-science-pack", 2},
            {"logistic-science-pack", 2},
            {"chemical-science-pack", 1},
        },
        time = 30,
    },
    order = "c-g-a-a-c"
}

local roboport_wagon2 = {
    type = "technology",
    name = "roboport-wagon-2",
    localised_name = {"technology.roboport-wagon-2"},
    icon_size = 256,
    icon_mipmaps = 4,
    icon = "__RoboportWagons__/graphics/technology/roboport-wagon-2.png",
    effects = {
        {
            type = "unlock-recipe",
            recipe = "roboport-wagon-2",
        }
    },
    prerequisites = {"roboport-wagon-1", "personal-roboport-mk2-equipment"},
    unit = {
        count = 600,
        ingredients = {
            {"automation-science-pack", 3},
            {"logistic-science-pack", 2},
            {"chemical-science-pack", 1},
        },
        time = 60,
    },
    order = "c-g-a-a-c"
}

local roboport_wagon3 = {
    type = "technology",
    name = "roboport-wagon-3",
    localised_name = {"technology.roboport-wagon-3"},
    icon_size = 256,
    icon_mipmaps = 4,
    icon = "__RoboportWagons__/graphics/technology/roboport-wagon-3.png",
    effects = {
        {
            type = "unlock-recipe",
            recipe = "roboport-wagon-3",
        }
    },
    prerequisites = {"roboport-wagon-2"},
    unit = {
        count = 1500,
        ingredients = {
            {"automation-science-pack", 3},
            {"logistic-science-pack", 3},
            {"chemical-science-pack", 3},
        },
        time = 60,
    },
    order = "c-g-a-a-c"
}

if HasSEInstalled() then
    -- roboport_wagon3.unit.ingredients = {
    --     {"automation-science-pack", 3},
    --     {"se-energy-science-pack-1", 1},
    -- }
end

data:extend({roboport_wagon1, roboport_wagon2, roboport_wagon3})
