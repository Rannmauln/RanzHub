-- ================================================================
-- FRUIT DATABASE MODULE
-- Database nilai buah dan mutation
-- ================================================================

local FruitDatabase = {
    values = {
        Carrot = 10,
        GoldCarrot = 150,
        RainbowCarrot = 500,
        Tomato = 15,
        GoldTomato = 200,
        RainbowTomato = 750,
        Wheat = 5,
        GoldWheat = 100,
        Berry = 20,
        GoldBerry = 250,
        StarApple = 300,
        StarstruckApple = 600,
        MoonFruit = 400,
        SunFruit = 450,
        DragonFruit = 800,
        MagicMelon = 350,
        CosmicCorn = 900,
    },
    
    mutations = {"Gold", "Rainbow", "Starstruck", "Cosmic", "Dragon", "Magic", "Sun", "Moon"},
}

-- ================================================================
-- GET VALUE
-- ================================================================

function FruitDatabase:GetValue(name)
    return self.values[name] or 0
end

-- ================================================================
-- IS MUTATION
-- ================================================================

function FruitDatabase:IsMutation(name)
    for i, m in ipairs(self.mutations) do
        if string.find(name, m) then
            return true
        end
    end
    return false
end

-- ================================================================
-- GET ALL FRUITS
-- ================================================================

function FruitDatabase:GetAllFruits()
    local fruits = {}
    for name, _ in pairs(self.values) do
        table.insert(fruits, name)
    end
    return fruits
end

-- ================================================================
-- GET HIGHEST VALUE
-- ================================================================

function FruitDatabase:GetHighestValue()
    local highest = 0
    local highestName = ""
    
    for name, value in pairs(self.values) do
        if value > highest then
            highest = value
            highestName = name
        end
    end
    
    return highestName, highest
end

return FruitDatabase