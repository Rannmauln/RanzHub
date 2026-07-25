-- ================================================================
-- FREE VERSION CONFIG
-- Konfigurasi khusus free version (dengan batasan)
-- ================================================================

local FreeConfig = {
    -- ===== LIMITATIONS =====
    MaxWalkSpeed = 22,
    MaxJumpPower = 50,
    SellDelay = 5,           -- Jeda 5 detik per jual
    HarvestDelay = 0.5,      -- Jeda 0.5 detik per panen
    PlantDelay = 0.5,        -- Jeda 0.5 detik per tanam
    
    -- ===== DISABLED FEATURES =====
    AutoStealEnabled = false,
    AntiStealEnabled = false,
    AutoPetsEnabled = false,
    AutoExpandEnabled = false,
    WebhookEnabled = false,
    NoclipEnabled = false,
    PremiumUIEnabled = false,
    
    -- ===== LIMITED FEATURES =====
    MaxPlotsToFarm = 20,
    MaxSeedsToBuy = 5,
    SeedBuyList = {"Carrot", "Tomato", "Wheat"},
    GearBuyList = {"Watering Can"},
    CrateBuyList = {"Basic Crate"},
    
    -- ===== WATERMARK =====
    ShowWatermark = true,
    WatermarkText = "⚔️ RANZHUB FREE — Get Premium at github.com/Rannmauln/RanzHub",
    
    -- ===== PERFORMANCE =====
    LoopInterval = 1.5,      -- Lebih lambat (stabil)
    GarbageCollection = true,
}

return FreeConfig