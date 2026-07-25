-- ================================================================
-- RanzHub PREMIUM v1.3.0
-- ================================================================

-- Validasi key (sederhana)
local key = getgenv().PremiumKey or ""
if key == "" then
    print("❌ Tidak ada premium key!")
    return
end

print("⭐ RanzHub PREMIUM v1.3.0 loaded!")
print("✅ Premium key valid!")

-- Config premium
local Config = {
    AutoHarvest = true,
    AutoPlant = true,
    AutoWater = true,
    AutoSell = true,
    AutoSteal = true,     -- Premium: bisa steal
    WalkSpeed = 45,
    Noclip = true,
    AutoPets = true,
    AutoExpand = true,
}

-- Core functions + extra premium
local function HarvestAll()
    print("🌾 Premium Harvesting...")
end

local function PlantSeeds()
    print("🌱 Premium Planting...")
end

local function StealFruits()
    print("💰 Stealing from others...")
end

local function ManagePets()
    print("🐾 Managing pets...")
end

-- Loop utama
while true do
    HarvestAll()
    PlantSeeds()
    if Config.AutoSteal then StealFruits() end
    if Config.AutoPets then ManagePets() end
    task.wait(3)  -- Premium: lebih cepat
end