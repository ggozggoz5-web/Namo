--[[
░█████╗░░█████╗░███╗░░░███╗██████╗░██╗░░░░░██████╗░████████╗░░░░░░░░
██╔══██╗██╔══██╗████╗░████║██╔══██╗██║░░░░░╚══██╔══╝╚══██╔══╝░░░░░░
╚███╔═╝║██║░░╚═╝██╔████╔██║██████╔╝██║░░░░░░░░██║░░░░░░░░░░░░░░░░░░
██╔░░░░║██║░░██╗██║╚██╔╝██║██╔══██╗██║░░░░░░░░██║░░░░░░░░░░░░░░░░░░
██║░░░░║╚█████╔╝██║░╚═╝░██║██║░░██║██║░░░░░░░░██║░░░░░░░░░░░░░░░░░░
╚═╝░░░░░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░░░░░░░╚═╝░░░░░░░░░░░░░░░░░░

            ✨ โหลดเดอร์ของมึงเอง ✨
            โดย: BZMEMBER | พัฒนาโดย: BluezyGPT
----------------------------------------------------------------------------
]]

-- =============================================
-- ตั้่งค่าพื้่นฐาน
-- =============================================
local PLAYER_NAME = "BZMEMBER"
local APP_NAME = "BZMEMBER Hub"
local VERSION = "1.0"
local CREDITS = "พัฒนาโดย BluezyGPT"

-- =============================================
-- Intro Animation
-- =============================================
print("====================================================================")
print("                       ✨ " .. APP_NAME .. " v" .. VERSION .. " ✨")
print("                 ผู้ใช้: " .. PLAYER_NAME .. " | พัฒนาโดย BluezyGPT")
print("====================================================================")

-- รอเกมโหลด
repeat task.wait() until game:IsLoaded()
print("✅ เกมโหลดเสร็จแล้ว!")

-- =============================================
-- สร้าง UI สวยๆ
-- =============================================
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- สีสันธีม
local Colors = {
    Background = Color3.fromHex("#0f0f23"),
    Primary = Color3.fromHex("#e94560"),
    Secondary = Color3.fromHex("#16213e"),
    Accent = Color3.fromHex("#00d4ff"),
    Text = Color3.fromHex("#ffffff"),
    TextMuted = Color3.fromHex("#a0a0c0"),
    Success = Color3.fromHex("#00ff88"),
    Warning = Color3.fromHex("#ffaa00"),
}

-- สร้าง Frame หลัก
local mainFrame = Instance.new("Frame")
mainFrame.Name = "BZLoader_MainUI"
mainFrame.Size = UDim2.new(0, 450, 0, 380)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -190)
mainFrame.BackgroundTransparency = 0
mainFrame.BackgroundColor3 = Colors.Background
mainFrame.BorderSizePixel = 0
mainFrame.Parent = CoreGui

-- Corner Round
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

-- =============================================
-- Title Bar
-- =============================================
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 55)
titleBar.BackgroundColor3 = Colors.Secondary
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 15)
titleCorner.Parent = titleBar

-- Icon
local iconLabel = Instance.new("TextLabel")
iconLabel.Name = "IconLabel"
iconLabel.Size = UDim2.new(0, 55, 1, 0)
iconLabel.BackgroundTransparency = 1
iconLabel.Text = "💎"
iconLabel.TextSize = 28
iconLabel.Font = Enum.Font.GothamBold
iconLabel.TextColor3 = Colors.Acccent
iconLabel.Parent = titleBar

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -70, 1, 0)
titleLabel.Position = UDim2.new(0, 65, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "✨ " .. APP_NAME .. " ✨"
titleLabel.TextColor3 = Colors.Text
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Version
local versionLabel = Instance.new("TextLabel")
versionLabel.Name = "VersionLabel"
versionLabel.Size = UDim2.new(0, 50, 0, 25)
versionLabel.Position = UDim2.new(1, -60, 0, 15)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v" .. VERSION
versionLabel.TextColor3 = Colors.TextMuted
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextSize = 12
versionLabel.Parent = titleBar

-- ปุ่มปิด
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -35, 0, 10)
closeButton.BackgroundColor3 = Color3.fromHex("#ff4757")
closeButton.Text = "✕"
closeButton.TextColor3 = Colors.Text
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    -- Animation ปิด
    local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
    })
    closeTween:Play()
    closeTween.Completed:Connect(function()
        mainFrame:Destroy()
    end)
end)

-- =============================================
-- Avatar Player
-- =============================================
local avatarFrame = Instance.new("Frame")
avatarFrame.Name = "AvatarFrame"
avatarFrame.Size = UDim2.new(0, 80, 0, 80)
avatarFrame.Position = UDim2.new(0.5, -40, 0, 70)
avatarFrame.BackgroundColor3 = Colors.Secondary
avatarFrame.BorderSizePixel = 0
avatarFrame.Parent = mainFrame

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 40)
avatarCorner.Parent = avatarFrame

-- Icon ผู้ใช้
local avatarIcon = Instance.new("TextLabel")
avatarIcon.Name = "AvatarIcon"
avatarIcon.Size = UDim2.new(1, 0, 1, 0)
avatarIcon.BackgroundTransparency = 1
avatarIcon.Text = "👤"
avatarIcon.TextSize = 40
avatarIcon.Font = Enum.Font.Gotham
avatarIcon.TextColor3 = Colors.Acccent
avatarIcon.Parent = avatarFrame

-- ชื่อผู้เล่น
local playerLabel = Instance.new("TextLabel")
playerLabel.Name = "PlayerLabel"
playerLabel.Size = UDim2.new(1, 0, 0, 25)
playerLabel.Position = UDim2.new(0, 0, 0, 155)
playerLabel.BackgroundTransparency = 1
playerLabel.Text = PLAYER_NAME
playerLabel.TextColor3 = Colors.Text
playerLabel.Font = Enum.Font.GothamBold
playerLabel.TextSize = 16
playerLabel.Parent = mainFrame

-- สถานะออนไลน์
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(0, 80, 0, 20)
statusLabel.Position = UDim2.new(0.5, -40, 0, 182)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● ออนไลน์"
statusLabel.TextColor3 = Colors.Success
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12
statusLabel.Parent = mainFrame

-- =============================================
-- Content Area
-- =============================================
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -30, 1, -230)
contentFrame.Position = UDim2.new(0, 15, 0, 215)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- =============================================
-- Progress Section
-- =============================================
local progressSection = Instance.new("Frame")
progressSection.Name = "ProgressSection"
progressSection.Size = UDim2.new(1, 0, 0, 60)
progressSection.Position = UDim2.new(0, 0, 0, 0)
progressSection.BackgroundColor3 = Colors.Secondary
progressSection.BorderSizePixel = 0
progressSection.Parent = contentFrame

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0, 10)
progressCorner.Parent = progressSection

-- Progress Label
local progressLabel = Instance.new("TextLabel")
progressLabel.Name = "ProgressLabel"
progressLabel.Size = UDim2.new(0.7, 0, 1, 0)
progressLabel.Position = UDim2.new(0, 15, 0, 0)
progressLabel.BackgroundTransparency = 1
progressLabel.Text = "⏳ กำลังเริ่มต้น..."
progressLabel.TextColor3 = Colors.TextMuted
progressLabel.Font = Enum.Font.Gotham
progressLabel.TextSize = 12
progressLabel.TextXAlignment = Enum.TextXAlignment.Left
progressLabel.Parent = progressSection

-- Percentage
local percentLabel = Instance.new("TextLabel")
percentLabel.Name = "PercentLabel"
percentLabel.Size = UDim2.new(0, 40, 1, 0)
percentLabel.Position = UDim2.new(1, -50, 0, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Colors.Acccent
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 14
percentLabel.TextXAlignment = Enum.TextXAlignment.Right
percentLabel.Parent = progressSection

-- Progress Bar Background
local progressBarBg = Instance.new("Frame")
progressBarBg.Name = "ProgressBarBg"
progressBarBg.Size = UDim2.new(0.9, 0, 0, 8)
progressBarBg.Position = UDim2.new(0.05, 0, 1, -20)
progressBarBg.BackgroundColor3 = Color3.fromHex("#0a0a1a")
progressBarBg.BorderSizePixel = 0
progressBarBg.Parent = progressSection

local barBgCorner = Instance.new("UICorner")
barBgCorner.CornerRadius = UDim.new(1, 0)
barBgCorner.Parent = progressBarBg

-- Progress Bar Fill
local progressBar = Instance.new("Frame")
progressBar.Name = "ProgressBar"
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Colors.Primary
progressBar.BorderSizePixel = 0
progressBar.Parent = progressBarBg

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = progressBar

-- =============================================
-- Buttons Section
-- =============================================
local buttonsFrame = Instance.new("Frame")
buttonsFrame.Name = "ButtonsFrame"
buttonsFrame.Size = UDim2.new(1, 0, 0, 140)
buttonsFrame.Position = UDim2.new(0, 0, 0, 75)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.Parent = contentFrame

-- ปุ่มโหลด
local loadButton = Instance.new("TextButton")
loadButton.Name = "LoadButton"
loadButton.Size = UDim2.new(1, -30, 0, 45)
loadButton.Position = UDim2.new(0, 15, 0, 0)
loadButton.BackgroundColor3 = Colors.Primary
loadButton.Text = "🚀 เริ่มโหลด!"
loadButton.TextColor3 = Colors.Text
loadButton.Font = Enum.Font.GothamBold
loadButton.TextSize = 16
loadButton.Parent = buttonsFrame

local loadCorner = Instance.new("UICorner")
loadCorner.CornerRadius = UDim.new(0, 10)
loadCorner.Parent = loadButton

-- Effects ปุ่ม
loadButton.MouseEnter:Connect(function()
    loadButton.BackgroundColor3 = Color3.fromHex("#ff5a75")
end)

loadButton.MouseLeave:Connect(function()
    loadButton.BackgroundColor3 = Colors.Primary
end)

loadButton.MouseButton1Click:Connect(function()
    if loadButton.Text == "🚀 เริ่มโหลด!" then
        loadButton.Text = "⏳ กำลังโหลด..."
        loadButton.BackgroundColor3 = Colors.Secondary
        
        -- Loop โหลด
        local progress = 0
        local steps = {
            { p = 15, msg = "🔍 กำลังตรวจสอบเกม..." },
            { p = 30, msg = "📥 กำลังดาวน์โหลด..." },
            { p = 50, msg = "⚙️ กำลังเตรียม..." },
            { p = 70, msg = "🔧 กำลังปรับแต่ง..." },
            { p = 85, msg = "🎯 กำลังติดตั้ง..." },
            { p = 95, msg = "✨ กำลังปิดท้าย..." },
            { p = 100, msg = "✅ เสร็จสิ้น!" },
        }
        
        local stepIndex = 1
        local tween = TweenService:Create(progressBar, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.None), {
            Size = UDim2.new(1, 0, 1, 0),
        })
        tween:Play()
        
        -- อัปเดต progress
        while progress < 100 do
            progress = progress + 0.5
            percentLabel.Text = math.floor(progress) .. "%"
            
            if steps[stepIndex] and progress >= steps[stepIndex].p then
                progressLabel.Text = steps[stepIndex].msg
                stepIndex = stepIndex + 1
            end
            
            task.wait()
        end
        
        -- เสร็จแล้ว
        loadButton.Text = "✅ เสร็จแล้ว!"
        loadButton.BackgroundColor3 = Colors.Success
        
        progressLabel.Text = "🎉 โหลดสำเร็จสำหรับผู้ใช้งาน: " .. PLAYER_NAME
        progressLabel.TextColor3 = Colors.Success
        
        -- แจ้งเตือน
        StarterGui:SetCore("SendNotification", {
            Title = "✨ " .. APP_NAME .. " ✨",
            Text = "โหลดสำเสร็จสำหรผู้ใช้งาน: " .. PLAYER_NAME,
            Duration = 5,
        })
        
        print("====================================================================")
        print("                    ✅ โหลดสำเสร็จแล้ว!")
        print("              ผู้ใช้งาน: " .. PLAYER_NAME .. " | เวอร์ชัน: " .. VERSION)
        print("              พัฒนาโดย: BluezyGPT")
        print("====================================================================")
        
        -- รอหน่อยแล้วปิด
        task.delay(3, function()
            loadButton.Text = "🚀 เริ่มใหม่"
            loadButton.BackgroundColor3 = Colors.Primary
            progressLabel.Text = "⏳ กำลังเริ่มต้น..."
            progressLabel.TextColor3 = Colors.TextMuted
            percentLabel.Text = "0%"
            progressBar.Size = UDim2.new(0, 0, 1, 0)
        end)
    else
        -- รีเซ็ต
        loadButton.Text = "🚀 เริ่มโหลด!"
        loadButton.BackgroundColor3 = Colors.Primary
        progressLabel.Text = "⏳ กำลังเริ่มต้น..."
        progressLabel.TextColor3 = Colors.TextMuted
        percentLabel.Text = "0%"
        progressBar.Size = UDim2.new(0, 0, 1, 0)
    end
end)

-- ปุ่ม About
local aboutButton = Instance.new("TextButton")
aboutButton.Name = "AboutButton"
aboutButton.Size = UDim2.new(1, -30, 0, 35)
aboutButton.Position = UDim2.new(0, 15, 0, 55)
aboutButton.BackgroundColor3 = Colors.Secondary
aboutButton.Text = "ℹ️ เกี่ยวกับ"
aboutButton.TextColor3 = Colors.TextMuted
aboutButton.Font = Enum.Font.Gotham
aboutButton.TextSize = 12
aboutButton.Parent = buttonsFrame

local aboutCorner = Instance.new("UICorner")
aboutCorner.CornerRadius = UDim.new(0, 8)
aboutCorner.Parent = aboutButton

aboutButton.MouseButton1Click:Connect(function()
    StarterGui:SetCore("SendNotification", {
        Title = "ℹ️ เกี่ยวกับ",
        Text = APP_NAME .. " v" .. VERSION .. "\nพัฒนาโดย: " .. CREDITS .. "\nผู้ใช้: " .. PLAYER_NAME,
        Duration = 5,
    })
end)

-- ปุ่ม Exit
local exitButton = Instance.new("TextButton")
exitButton.Name = "ExitButton"
exitButton.Size = UDim2.new(1, -30, 0, 35)
exitButton.Position = UDim2.new(0, 15, 0, 100)
exitButton.BackgroundColor3 = Color3.fromHex("#ff4757")
exitButton.Text = "🚪 ออก"
exitButton.TextColor3 = Colors.Text
exitButton.Font = Enum.Font.Gotham
exitButton.TextSize = 12
exitButton.Parent = buttonsFrame

local exitCorner = Instance.new("UICorner")
exitCorner.CornerRadius = UDim.new(0, 8)
exitCorner.Parent = exitButton

exitButton.MouseButton1Click:Connect(function()
    mainFrame:Destroy()
end)

-- =============================================
-- Footer
-- =============================================
local footerLabel = Instance.new("TextLabel")
footerLabel.Name = "FooterLabel"
footerLabel.Size = UDim2.new(1, 0, 0, 25)
footerLabel.Position = UDim2.new(0, 0, 1, -25)
footerLabel.BackgroundTransparency = 1
footerLabel.Text = "พัฒนาโดย BluezyGPT | © " .. os.date("%Y")
footerLabel.TextColor3 = Colors.TextMuted
footerLabel.Font = Enum.Font.Gotham
footerLabel.TextSize = 10
footerLabel.TextXAlignment = Enum.TextXAlignment.Center
footerLabel.Parent = mainFrame

-- =============================================
-- Drag System
-- =============================================
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- =============================================
-- Keyboard Shortcut (ESC = ปิด, H = ซ่อน/แสดง)
-- =============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Escape then
        mainFrame:Destroy()
    elseif input.KeyCode == Enum.KeyCode.H then
        if mainFrame.Visible then
            mainFrame.Visible = false
            StarterGui:SetCore("SendNotification", {
                Title = "👁️ ซ่อนแล้ว",
                Text = "กด H อีกครั้งเพื่อแสดง",
                Duration = 2,
            })
        else
            mainFrame.Visible = true
            StarterGui:SetCore("SendNotification", {
                Title = "👁️ แสดงแล้ว",
                Text = "กด H อีกครั้งเพื่อซ่อน",
                Duration = 2,
            })
        end
    end
end)

-- =============================================
-- Animation ตอนเปิด
-- =============================================
mainFrame.BackgroundTransparency = 1
mainFrame.Size = UDim2.new(0, 350, 0, 300)

local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 450, 0, 380),
    BackgroundTransparency = 0,
})
openTween:Play()

print("====================================================================")
print("                  ✨ " .. APP_NAME .. " ✨")
print("               เปิดสำเสร็จแล้ว! ผู้ใช้: " .. PLAYER_NAME)
print("====================================================================")
