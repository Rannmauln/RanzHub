-- ================================================================
-- KEY SYSTEM MODULE
-- Validasi premium key
-- ================================================================

local KeySystem = {}

-- ================================================================
-- HARDWARE ID
-- ================================================================

function KeySystem:GetHardwareID()
    local hwid = ""
    local identifiers = {
        game.JobId,
        tostring(game.PlaceId),
        tostring(settings().Network.PeerId or 0),
    }
    hwid = table.concat(identifiers, "|")
    hwid = game:GetService("HttpService"):SHA256(hwid)
    return hwid
end

-- ================================================================
-- VALIDATE KEY DARI GITHUB
-- ================================================================

function KeySystem:Validate(key)
    if not key or key == "" then
        return false, "❌ Masukkan premium key!"
    end
    
    local hwid = self:GetHardwareID()
    
    -- Download key database dari GitHub
    local url = "https://raw.githubusercontent.com/Rannmauln/RanzHub/main/keys/active_keys.json"
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not success then
        return false, "❌ Gagal validasi key (internet?)"
    end
    
    local keys = game:GetService("HttpService"):JSONDecode(response)
    
    for i, keyData in ipairs(keys) do
        if keyData.key == key then
            -- Cek aktif
            if not keyData.isActive then
                return false, "❌ Key sudah dinonaktifkan!"
            end
            
            -- Cek expired
            if os.time() > keyData.expiry then
                return false, "❌ Key sudah kadaluarsa!"
            end
            
            -- Cek limit pemakaian
            if keyData.used >= keyData.maxUses then
                return false, "❌ Key sudah dipakai!"
            end
            
            -- Bind HWID (kalo belum)
            if not keyData.hwidLocked then
                keyData.hwidLocked = true
                keyData.hardwareID = hwid
                -- Simpan update (tapi harus upload ulang)
                return true, "✅ Key berhasil diaktifkan!"
            end
            
            -- Cek HWID
            if keyData.hardwareID ~= hwid then
                return false, "❌ Key terikat ke perangkat lain!"
            end
            
            return true, "✅ Key valid!"
        end
    end
    
    return false, "❌ Key tidak ditemukan!"
end

-- ================================================================
-- SHOW KEY INPUT UI
-- ================================================================

function KeySystem:ShowKeyInput(callback)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeyInputUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 280)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -140)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
    mainFrame.Parent = screenGui
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundTransparency = 0.2
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.Text = "⭐ DARKFARM PREMIUM"
    title.Parent = mainFrame
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 30)
    subtitle.Position = UDim2.new(0, 0, 0, 50)
    subtitle.BackgroundTransparency = 1
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 220)
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextScaled = true
    subtitle.Text = "Enter your premium key below"
    subtitle.Parent = mainFrame
    
    -- Key input
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.8, 0, 0, 40)
    keyBox.Position = UDim2.new(0.1, 0, 0, 100)
    keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    keyBox.BorderSizePixel = 1
    keyBox.BorderColor3 = Color3.fromRGB(100, 0, 200)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 18
    keyBox.Text = ""
    keyBox.PlaceholderText = "XXXX-XXXX-XXXX-XXXX"
    keyBox.Parent = mainFrame
    
    -- Submit
    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(0.3, 0, 0, 40)
    submitBtn.Position = UDim2.new(0.35, 0, 0, 160)
    submitBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    submitBtn.BorderSizePixel = 0
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextScaled = true
    submitBtn.Text = "ACTIVATE"
    submitBtn.Parent = mainFrame
    
    -- Status
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 30)
    status.Position = UDim2.new(0, 0, 0, 215)
    status.BackgroundTransparency = 1
    status.TextColor3 = Color3.fromRGB(255, 200, 100)
    status.Font = Enum.Font.Gotham
    status.TextScaled = true
    status.Text = ""
    status.Parent = mainFrame
    
    submitBtn.MouseButton1Click:Connect(function()
        local key = string.upper(keyBox.Text)
        if callback then
            callback(key, status, screenGui)
        end
    end)
    
    keyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            submitBtn.MouseButton1Click:Fire()
        end
    end)
    
    return screenGui
end

return KeySystem