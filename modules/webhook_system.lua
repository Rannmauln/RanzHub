-- ================================================================
-- WEBHOOK SYSTEM MODULE
-- Kirim notifikasi ke Discord
-- ================================================================

local WebhookSystem = {}

-- ================================================================
-- SEND WEBHOOK
-- ================================================================

function WebhookSystem:Send(webhookURL, message, embed)
    if not webhookURL or webhookURL == "" then
        return false
    end
    
    local data = {
        content = message or "",
        embeds = embed and {embed} or nil,
    }
    
    local json = game:GetService("HttpService"):JSONEncode(data)
    local headers = {["Content-Type"] = "application/json"}
    
    local success, result = pcall(function()
        return request({
            Url = webhookURL,
            Method = "POST",
            Headers = headers,
            Body = json
        })
    end)
    
    return success
end

-- ================================================================
-- SEND RARE ALERT
-- ================================================================

function WebhookSystem:SendRareAlert(webhookURL, fruitName, value)
    if not webhookURL or webhookURL == "" then return end
    
    local embed = {
        title = "🌱 RARE HARVEST!",
        description = string.format("**%s** harvested!", fruitName),
        color = 0x00FF00,
        fields = {
            {name = "Value", value = tostring(value), inline = true},
            {name = "Time", value = os.date("%H:%M:%S"), inline = true},
        },
        footer = {text = "DarkFarm v1.3.0"},
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
    }
    
    self:Send(webhookURL, "", embed)
end

-- ================================================================
-- SEND STATS
-- ================================================================

function WebhookSystem:SendStats(webhookURL, stats)
    if not webhookURL or webhookURL == "" then return end
    
    local embed = {
        title = "📊 Farm Statistics",
        color = 0x3498DB,
        fields = {
            {name = "Plots", value = tostring(stats.plots or 0), inline = true},
            {name = "Inventory", value = tostring(stats.inventory or 0), inline = true},
            {name = "Pets", value = tostring(stats.pets or 0), inline = true},
            {name = "Uptime", value = tostring(stats.uptime or "00:00:00"), inline = true},
        },
        footer = {text = "DarkFarm v1.3.0"},
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
    }
    
    self:Send(webhookURL, "", embed)
end

-- ================================================================
-- SEND STEAL ALERT
-- ================================================================

function WebhookSystem:SendStealAlert(webhookURL, fruitName, value, owner)
    if not webhookURL or webhookURL == "" then return end
    
    local embed = {
        title = "💰 STOLEN!",
        description = string.format("Stole **%s** from **%s**", fruitName, owner),
        color = 0xFF0000,
        fields = {
            {name = "Value", value = tostring(value), inline = true},
            {name = "Time", value = os.date("%H:%M:%S"), inline = true},
        },
        footer = {text = "DarkFarm Premium"},
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
    }
    
    self:Send(webhookURL, "", embed)
end

return WebhookSystem