-- ⚠️ CẢNH BÁO NGƯỜI DÙNG
warn("⚠️ Script này sẽ gửi danh sách pet của bạn về Discord webhook để bạn tự theo dõi. Hãy chắc chắn rằng bạn đồng ý!")

-- 🌐 Địa chỉ webhook của bạn (đổi thành webhook thật)
local webhookURL = "https://discord.com/api/webhooks/your_webhook_id_here"

-- Lấy danh sách pet từ Inventory
local player = game.Players.LocalPlayer
local inventory = player and player:FindFirstChild("Inventory")

if not inventory then
    warn("❌ Không tìm thấy kho đồ pet!")
    return
end

-- Gom thông tin pet
local petList = {}
for _, pet in ipairs(inventory:GetChildren()) do
    if pet:IsA("Model") or pet:IsA("Folder") then
        local name = pet.Name
        local weight = pet:FindFirstChild("Weight") and pet.Weight.Value or "?"
        local age = pet:FindFirstChild("Age") and pet.Age.Value or "?"
        table.insert(petList, string.format("- %s [%s KG] [Age %s]", name, weight, age))
    end
end

-- Gửi về webhook
local HttpService = game:GetService("HttpService")
local function sendToWebhook(content)
    local payload = HttpService:JSONEncode({
        content = "**📦 Pet Inventory:**\n" .. content
    })

    HttpService:PostAsync(webhookURL, payload, Enum.HttpContentType.ApplicationJson)
end

-- Gửi đi
sendToWebhook(table.concat(petList, "\n"))
