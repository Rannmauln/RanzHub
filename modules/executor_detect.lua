-- ================================================================
-- EXECUTOR DETECTION MODULE
-- Deteksi executor yang dipakai user
-- ================================================================

local ExecutorDetect = {}

-- ================================================================
-- DETECT EXECUTOR
-- ================================================================

function ExecutorDetect:Detect()
    local info = {
        name = "Unknown",
        type = "Unknown",  -- "High", "Medium", "Low"
        isPotassium = false,
        isKrnl = false,
        isDelta = false,
        isSynapse = false,
        isArceus = false,
        isScriptWare = false,
    }
    
    -- Coba pake getexecutorname
    local success, name = pcall(function()
        return getexecutorname()
    end)
    
    if success and name then
        local lowerName = string.lower(name)
        
        if string.find(lowerName, "potassium") then
            info.name = "Potassium"
            info.type = "Medium"
            info.isPotassium = true
        elseif string.find(lowerName, "krnl") then
            info.name = "KRNL"
            info.type = "Medium"
            info.isKrnl = true
        elseif string.find(lowerName, "delta") then
            info.name = "Delta"
            info.type = "Medium"
            info.isDelta = true
        elseif string.find(lowerName, "synapse") then
            info.name = "Synapse X"
            info.type = "High"
            info.isSynapse = true
        elseif string.find(lowerName, "arceus") then
            info.name = "Arceus X"
            info.type = "Medium"
            info.isArceus = true
        elseif string.find(lowerName, "script%-ware") or string.find(lowerName, "scriptware") then
            info.name = "Script-Ware"
            info.type = "High"
            info.isScriptWare = true
        end
    end
    
    -- Fallback detection
    if info.name == "Unknown" then
        if pcall(function() return syn and syn.request end) then
            info.name = "Synapse X"
            info.type = "High"
            info.isSynapse = true
        elseif pcall(function() return getgenv().KRNL_LOADED end) then
            info.name = "KRNL"
            info.type = "Medium"
            info.isKrnl = true
        end
    end
    
    return info
end

-- ================================================================
-- GET COMPATIBILITY MODE
-- ================================================================

function ExecutorDetect:GetCompatibilityMode()
    local info = self:Detect()
    
    if info.isPotassium then
        return "Potassium"
    elseif info.type == "Medium" then
        return "Medium"
    elseif info.type == "High" then
        return "High"
    else
        return "Unknown"
    end
end

return ExecutorDetect