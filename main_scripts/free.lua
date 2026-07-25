-- ================================================================
-- RanzHub FREE v1.3.0
-- ================================================================

print("⚔️ RanzHub FREE v1.3.0 loaded!")
print("🔓 Free version — Fitur dasar")

-- Config
local Config = {
    AutoHarvest = true,
    AutoPlant = true,
    AutoWater = true,
    AutoSell = true,
    AutoSteal = false,  -- Free: tidak bisa steal
    WalkSpeed = 22,
}

-- Core functions (disederhanakan)
local function HarvestAll()
    print("🌾 Harvesting...")
    -- Script harvest disini
end

local function PlantSeeds()
    print("🌱 Planting...")
    -- Script tanam disini
end

-- Loop utama
while true do
    HarvestAll()
    PlantSeeds()
    task.wait(5)
end