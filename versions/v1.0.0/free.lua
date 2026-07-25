-- ================================================================
-- RanzHub FREE v1.0.0 — VERSI PERTAMA
-- Rilis: 2026-07-20
-- ================================================================

print("⚔️ RanzHub FREE v1.0.0")
print("📌 Initial release")

local Config = {
    AutoHarvest = true,
    AutoPlant = true,
    AutoWater = true,
    AutoSell = true,
    AutoSteal = false,
    WalkSpeed = 20,
}

local function HarvestAll()
    -- Fungsi harvest sederhana
    local plants = workspace:FindFirstChild("Plants")
    if not plants then return end
    
    for _, plant in ipairs(plants:GetChildren()) do
        if plant:FindFirstChild("Fruit") then
            -- Harvest logic
            print("🌾 Harvesting: " .. plant.Name)
        end
    end
end

local function PlantSeeds()
    -- Fungsi tanam sederhana
    print("🌱 Planting seeds...")
end

-- Main loop
while true do
    HarvestAll()
    PlantSeeds()
    task.wait(5)
end