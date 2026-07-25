-- ================================================================
-- PREMIUM VERSION CONFIG
-- Konfigurasi khusus premium (semua fitur terbuka)
-- ================================================================

local PremiumConfig = {
    -- ===== UNLIMITED =====
    MaxWalkSpeed = 45,
    MaxJumpPower = 80,
    SellDelay = 0,           -- Instan
    HarvestDelay = 0.1,
    PlantDelay = 0.1,
    
    -- ===== ENABLED FEATURES =====
    AutoStealEnabled = true,
    AntiStealEnabled = true,
    AutoPetsEnabled = true,
    AutoExpandEnabled = true,
    WebhookEnabled = true,
    NoclipEnabled = true,
    PremiumUIEnabled = true,
    AutoTameWildEnabled = true,
    FastHarvestEnabled = true,
    MultiThreadingEnabled = true,
    
    -- ===== UNLIMITED FEATURES =====
    MaxPlotsToFarm = 999,
    MaxSeedsToBuy = 999,
    SeedBuyList = {"Carrot", "Tomato", "Wheat", "Berry", "Moon Seed", "Sun Seed", "Dragon Seed"},
    GearBuyList = {"Watering Can", "Sprinkler", "Fertilizer", "Gold Watering Can", "Super Sprinkler"},
    CrateBuyList = {"Basic Crate", "Seed Pack", "Premium Crate", "Mystery Box", "Legendary Crate"},
    
    -- ===== WEBHOOK =====
    WebhookStealAlerts = true,
    WebhookPetAlerts = true,
    WebhookErrorAlerts = true,
    
    -- ===== PERFORMANCE =====
    LoopInterval = 0.5,      -- Cepat
    GarbageCollection = true,
    GarbageInterval = 200,
    MaxRenderDistance = 150,
    FPSBoost = true,
    AntiLag = true,
}

return PremiumConfig