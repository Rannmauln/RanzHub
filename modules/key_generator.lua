-- ================================================================
-- KEY GENERATOR MODULE
-- Generate premium keys
-- ================================================================

local KeyGenerator = {}

-- ================================================================
-- GENERATE KEY STRING
-- ================================================================

function KeyGenerator:GenerateKeyString()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local key = ""
    
    for i = 1, 4 do
        for j = 1, 4 do
            local charIndex = math.random(1, #chars)
            key = key .. string.sub(chars, charIndex, charIndex)
        end
        if i < 4 then
            key = key .. "-"
        end
    end
    
    return key
end

-- ================================================================
-- GENERATE PREMIUM KEY
-- ================================================================

function KeyGenerator:GeneratePremiumKey(expiryDays, maxUses, username)
    local key = self:GenerateKeyString()
    
    local keyData = {
        key = key,
        created = os.time(),
        expiry = os.time() + ((expiryDays or 30) * 86400),
        maxUses = maxUses or 1,
        used = 0,
        username = username or "Unknown",
        isActive = true,
        hardwareID = nil,
        hwidLocked = false,
        createdAt = os.date("%Y-%m-%d %H:%M:%S"),
    }
    
    return keyData
end

-- ================================================================
-- GENERATE BULK KEYS
-- ================================================================

function KeyGenerator:GenerateBulkKeys(count, expiryDays, maxUses)
    local keys = {}
    for i = 1, count do
        local keyData = self:GeneratePremiumKey(expiryDays, maxUses, "Bulk-" .. i)
        table.insert(keys, keyData)
    end
    return keys
end

-- ================================================================
-- SAVE KEYS TO JSON
-- ================================================================

function KeyGenerator:SaveKeysToFile(keys, filename)
    filename = filename or "active_keys.json"
    local json = game:GetService("HttpService"):JSONEncode(keys)
    local success, err = pcall(function()
        writefile(filename, json)
    end)
    if success then
        print("💾 Keys saved to: " .. filename)
        return true
    else
        print("❌ Failed to save: " .. tostring(err))
        return false
    end
end

-- ================================================================
-- VALIDATE KEY (untuk generator)
-- ================================================================

function KeyGenerator:ValidateKey(key, keysDB)
    for i, keyData in ipairs(keysDB) do
        if keyData.key == key then
            if not keyData.isActive then
                return false, "❌ Key deactivated"
            end
            if os.time() > keyData.expiry then
                return false, "❌ Key expired"
            end
            if keyData.used >= keyData.maxUses then
                return false, "❌ Key usage limit reached"
            end
            return true, "✅ Key valid", keyData
        end
    end
    return false, "❌ Key not found", nil
end

return KeyGenerator