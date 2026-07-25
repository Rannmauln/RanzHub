-- ================================================================
-- GLOBAL CONFIGURATION
-- Konfigurasi yang dipakai di semua versi
-- ================================================================

local GlobalConfig = {
    -- ===== VERSION =====
    Version = "1.3.0",
    BuildDate = "2026-07-24",
    
    -- ===== FRUIT DATABASE =====
    FruitValues = {
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
    
    Mutations = {"Gold", "Rainbow", "Starstruck", "Cosmic", "Dragon", "Magic", "Sun", "Moon"},
    
    -- ===== PERFORMANCE =====
    DefaultLoopInterval = 1,
    MaxLoopIterations = 100,
    GarbageCollectionInterval = 100,
    
    -- ===== UI =====
    Keybind = "K",
    Theme = "Dark",
    
    -- ===== GITHUB =====
    RepoOwner = "Rannmauln",   -- Ganti dengan username GitHub lu
    RepoName = "RanzHub",
    Branch = "main",
}

return GlobalConfig