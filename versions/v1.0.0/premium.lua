-- ================================================================
-- RanzHub PREMIUM v1.0.0 — VERSI PERTAMA
-- Rilis: 2026-07-20
-- ================================================================

print("⭐ RanzHub PREMIUM v1.0.0")
print("📌 Initial release")

local Config = {
    AutoHarvest = true,
    AutoPlant = true,
    AutoWater = true,
    AutoSell = true,
    AutoSteal = true,
    WalkSpeed = 35,
    Noclip = true,
}

local function HarvestAll()
    print("🌾 Premium Harvesting...")
end

local function PlantSeeds()
    print("🌱 Premium Planting...")
end

local function StealFruits()
    print("💰 Stealing...")
end

while true do
    HarvestAll()
    PlantSeeds()
    if Config.AutoSteal then StealFruits() end
    task.wait(3)
end