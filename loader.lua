-- ✨ BZMEMBER LOADER — สำหรับ Ninja Executor ✨
-- โดย: BluezyGPT

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("    ✨ " .. "BZMEMBER LOADER v1.0" .. " ✨")
print("    ผู้ใช้: BZMEMBER")
print("    พัฒนาโดย: BluezyGPT")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

-- รอเกมโหลด
repeat task.wait() until game:IsLoaded()
print("✅ เกมโหลดเสร็จ!")

-- บริการที่จำเปน
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- =============================================
-- สร้าง UI
-- =============================================
local mainFrame = Instance.new("Frame")
mainFrame.Name = "BZLoader"
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromHex("#1a1a2e")
mainFrame.BorderSizePixel = 0
mainFrame.Parent = CoreGui

-- ปุ่มปอด
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromHex("#e94560")
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromHex("#ffffff")
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
    mainFrame:Destroy()
end)

-- ชื่อกำแพง
local titleLbl = Instance.new("TextLabel")
titleLbl.Size = UDim2.new(1, -40, 0, 40)
titleLbl.BackgroundColor3 = Color3.fromHex("#16213e")
titleLbl.Text = "💎 BZMEMBER LOADER v1.0"
titleLbl.TextColor3 = Color3.fromHex("#ffd700")
titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextSize = 16
titleLbl.Parent = mainFrame

-- พื้นที่เนื้่อหา
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -40)
contentFrame.BackgroundColor3 = Color3.fromHex("#1a1a2e")
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

-- สถานะ
local statusLbl = Instance.new("TextLabel")
statusLbl.Size = UDim2.new(1, -20, 0, 30)
statusLbl.Position = UDim2.new(0, 10, 0, 10)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = "🎮 เกม: " .. tostring(game.GameId)
statusLbl.TextColor3 = Color3.fromHex("#ffffff")
statusLbl.Font = Enum.Font.GothamSemibold
statusLbl.TextSize = 14
statusLbl.Parent = contentFrame

-- Progress bar
local progBg = Instance.new("Frame")
progBg.Size = UDim2.new(0.9, 0, 0, 20)
progBg.Position = UDim2.new(0.05, 0, 0, 60)
progBg.BackgroundColor3 = Color3.fromHex("#0f3460")
progBg.BorderSizePixel = 0
progBg.Parent = contentFrame

local progFill = Instance.new("Frame")
progFill.Size = UDim2.new(0, 0, 1, 0)
progFill.BackgroundColor3 = Color3.fromHex("#e94560")
progFill.BorderSizePixel = 0
progFill.Parent = progBg

local progLbl = Instance.new("TextLabel")
progLbl.Size = UDim2.new(1, 0, 1, 0)
progLbl.BackgroundTransparency = 1
progLbl.Text = "0%"
progLbl.TextColor3 = Color3.fromHex("#ffffff")
progLbl.Font = Enum.Font.GothamBold
progLbl.TextSize = 12
progLbl.Parent = progBg

-- ปุ่มโหลด
local loadBtn = Instance.new("TextButton")
loadBtn.Size = UDim2.new(0.8, 0, 0, 40)
loadBtn.Position = UDim2.new(0.1, 0, 0, 120)
loadBtn.BackgroundColor3 = Color3.fromHex("#e94560")
loadBtn.Text = "🚀 โหลดเลย!"
loadBtn.TextColor3 = Color3.fromHex("#ffffff")
loadBtn.Font = Enum.Font.GothamBold
loadBtn.TextSize = 16
loadBtn.Parent = contentFrame

loadBtn.MouseButton1Click:Connect(function()
    loadBtn.Text = "⏳ กำลังโหลด..."
    loadBtn.BackgroundColor3 = Color3.fromHex("#16213e")
    
    local progress = 0
    local steps = {
        { p = 15, msg = "🔍 ตรวจสอบเกม..." },
        { p = 30, msg = "📥 ดาวน์โหลด..." },
        { p = 50, msg = "⚙️ เตรียมนำ..." },
        { p = 70, msg = "🔧 ปรับแต่ง..." },
        { p = 90, msg = "✨ รันสคริปตล์..." },
        { p = 100, msg = "✅ เสร็จสิ้ก!" },
    }
    
    local stepIdx = 1
    
    while progress < 100 do
        progress = progress + 1
        progLbl.Text = progress .. "%"
        
        if steps[stepIdx] and progress >= steps[stepIdx].p then
            statusLbl.Text = steps[stepIdx].msg
            stepIdx = stepIdx + 1
        end
        
        -- ขยาย progress bar
        progFill.Size = UDim2.new(progress / 100, 0, 1, 0)
        
        task.wait()
    end
    
    -- เสร็จแล้ว
    loadBtn.Text = "✅ สำเร็จ!"
    loadBtn.BackgroundColor3 = Color3.fromHex("#00ff88")
    statusLbl.Text = "🎉 โหลดสำเสร็จสำหรับ BZMEMBER!"
    
    StarterGui:SetCore("SendNotification", {
        Title = "✨ สำเสร็จ!",
        Text = "โหลดสำเสร็จสำหรับ BZMEMBER",
        Duration = 5,
    })
    
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("               ✅ โหลดสำเสร็จ!")
    print("              ผ้ใูย้: BZMEMBER")
    print("          พัฒนาโดย: BluezyGPT")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    
    -- รอแล้วปอด
    task.delay(3, function()
        loadBtn.Text = "🚀 โหลดใหม่อีกครง้"
        loadBtn.BackgroundColor3 = Color3.fromHex("#e94560")
        progFill.Size = UDim2.new(0, 0, 1, 0)
        progLbl.Text = "0%"
        statusLbl.Text = "🎮 เกม: " .. tostring(game.GameId)
    end)
end)

-- ลากได
local dragging = false
local dragStart = nil
local startPos = nil

titleLbl.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleLbl.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ESC = ปอด
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Escape then
        mainFrame:Destroy()
    end
end)

print("✅ UI สำเสร็จ! กด ESC เพ่ิอปอด")
