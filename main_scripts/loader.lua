-- ================================================================
-- RANZHUB LOADER — GIT DEPLOYMENT
-- ================================================================

local GIT_CONFIG = {
    REPO_RAW = "https://raw.githubusercontent.com/Rannmauln/RanzHub/main/",
    VERSION_FILE = "version.txt",
    FREE_SCRIPT = "main_scripts/free.lua",
    PREMIUM_SCRIPT = "main_scripts/premium.lua",
}

local function SafeHttpGet(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if success then return result end
    return nil
end

local function GetGitFile(path)
    local url = GIT_CONFIG.REPO_RAW .. path
    return SafeHttpGet(url)
end

local function LoadScript(content)
    if not content then
        print("❌ Gagal download script")
        return
    end
    loadstring(content)()
end

-- Check premium key
local key = getgenv().PremiumKey or ""

if key ~= "" then
    print("⭐ Loading PREMIUM version...")
    local content = GetGitFile(GIT_CONFIG.PREMIUM_SCRIPT)
    LoadScript(content)
else
    print("🔓 Loading FREE version...")
    local content = GetGitFile(GIT_CONFIG.FREE_SCRIPT)
    LoadScript(content)
end