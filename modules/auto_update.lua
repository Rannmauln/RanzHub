-- ================================================================
-- AUTO UPDATE MODULE
-- Cek update dari GitHub dan download otomatis
-- ================================================================

local AutoUpdate = {}

-- ================================================================
-- CONFIG
-- ================================================================

AutoUpdate.Config = {
    REPO_OWNER = "Rannmauln",          -- Ganti dengan username lu
    REPO_NAME = "RanzHub",
    BRANCH = "main",
    CHECK_INTERVAL = 3600,               -- Cek tiap 1 jam
    AUTO_UPDATE = true,
}

-- ================================================================
-- CHECK FOR UPDATES
-- ================================================================

function AutoUpdate:CheckForUpdates()
    print("🔄 Checking for updates...")
    
    local url = string.format(
        "https://raw.githubusercontent.com/%s/%s/%s/version.txt",
        self.Config.REPO_OWNER,
        self.Config.REPO_NAME,
        self.Config.BRANCH
    )
    
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not success then
        print("⚠️ Could not check updates")
        return false
    end
    
    local remoteVersion = string.gsub(response, "%s+", "")
    local localVersion = getgenv().DarkFarmVersion or "1.0.0"
    
    print("📦 Local: v" .. localVersion)
    print("📦 Remote: v" .. remoteVersion)
    
    -- Compare versions
    local function VersionToNumber(v)
        local parts = {}
        for part in string.gmatch(v, "%d+") do
            table.insert(parts, tonumber(part) or 0)
        end
        return parts
    end
    
    local localParts = VersionToNumber(localVersion)
    local remoteParts = VersionToNumber(remoteVersion)
    
    for i = 1, math.max(#localParts, #remoteParts) do
        local localPart = localParts[i] or 0
        local remotePart = remoteParts[i] or 0
        if remotePart > localPart then
            return true, remoteVersion
        elseif remotePart < localPart then
            return false, remoteVersion
        end
    end
    
    return false, remoteVersion
end

-- ================================================================
-- DOWNLOAD UPDATE
-- ================================================================

function AutoUpdate:DownloadUpdate()
    print("📥 Downloading update...")
    
    local files = {
        "main_scripts/free.lua",
        "main_scripts/premium.lua",
        "main_scripts/loader.lua",
        "version.txt",
    }
    
    local updated = {}
    for i, filePath in ipairs(files) do
        local url = string.format(
            "https://raw.githubusercontent.com/%s/%s/%s/%s",
            self.Config.REPO_OWNER,
            self.Config.REPO_NAME,
            self.Config.BRANCH,
            filePath
        )
        
        local success, content = pcall(function()
            return game:HttpGet(url)
        end)
        
        if success and content then
            updated[filePath] = content
            print("✅ Downloaded: " .. filePath)
        else
            print("❌ Failed: " .. filePath)
        end
        
        task.wait(0.5)
    end
    
    return updated
end

return AutoUpdate