-- ================================================================
-- UTILITY FUNCTIONS
-- Fungsi-fungsi bantuan yang dipakai di banyak tempat
-- ================================================================

local Utils = {}

-- ================================================================
-- TABLE FUNCTIONS
-- ================================================================

-- Cari value di table (manual, karena Potassium ga punya table.find)
function Utils:TableFind(tbl, value)
    for i, v in ipairs(tbl) do
        if v == value then
            return i
        end
    end
    return nil
end

-- Hitung panjang table (manual)
function Utils:TableLen(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

-- ================================================================
-- SAFE WAIT (fallback untuk task.wait)
-- ================================================================

function Utils:SafeWait(time)
    local success, err = pcall(function()
        if time then
            task.wait(time)
        else
            task.wait()
        end
    end)
    
    if not success then
        if time then
            wait(time)
        else
            wait()
        end
    end
end

-- ================================================================
-- SAFE HTTP GET (fallback untuk game:HttpGet)
-- ================================================================

function Utils:SafeHttpGet(url, retries)
    retries = retries or 3
    local attempts = 0
    
    while attempts < retries do
        attempts = attempts + 1
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        
        if success and result then
            return result
        end
        
        print("⚠️ Download failed (attempt " .. attempts .. "/" .. retries .. "): " .. url)
        self:SafeWait(2)
    end
    
    return nil
end

-- ================================================================
-- TELEPORT (aman)
-- ================================================================

function Utils:TeleportToPosition(position, character)
    if not position then return end
    local root = character and character:FindFirstChild("HumanoidRootPart") or game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local success, err = pcall(function()
        root.CFrame = CFrame.new(position)
    end)
    
    if not success then
        pcall(function()
            root.Position = position
        end)
    end
    
    self:SafeWait(0.1)
end

-- ================================================================
-- IS MUTATION
-- ================================================================

function Utils:IsMutation(fruitName)
    local mutations = {"Gold", "Rainbow", "Starstruck", "Cosmic", "Dragon", "Magic", "Sun", "Moon"}
    for i, m in ipairs(mutations) do
        if string.find(fruitName, m) then
            return true
        end
    end
    return false
end

-- ================================================================
-- GET FRUIT VALUE
-- ================================================================

function Utils:GetFruitValue(fruitName)
    local valueDB = {
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
    }
    return valueDB[fruitName] or 0
end

return Utils