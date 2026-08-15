-- ==========================================================
-- ระบบโหลดสคริปต์ส่วนตัว (ภาษาไทยอ่านง่าย)
-- ==========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- ⚙️ [ตั้งค่าข้อมูลของคุณตรงนี้]
local HUB_NAME = "นะโม ฮับ"
local MAIN_SCRIPT_URL = "" -- ใส่ลิงก์สคริปต์หลักตรงนี้ (ถ้ามี)

-- รายชื่อ Place ID เกมที่รองรับ (ใส่ 0 เพื่อให้รันได้ทุกเกม)
local SUPPORTED_GAMES = {
	[0] = true,
}

-- 1. สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NamoSimpleLoader"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true

local ok = pcall(function()
	screenGui.Parent = CoreGui
end)
if not ok then
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- 2. แอนิเมชันตัวอักษรวิ่งตอนเริ่ม
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleText"
titleLabel.Size = UDim2.new(1, 0, 1, -40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = ""
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 64
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextTransparency = 1
titleLabel.Parent = screenGui

local frames = { "[ ]", "[ น ]", "[นะ ]", "[ นะม ]", "[ นะโม ]", "[ " .. HUB_NAME .. " ]" }

titleLabel.Text = frames[1]
local fadeIn = TweenService:Create(titleLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { TextTransparency = 0 })
fadeIn:Play()
fadeIn.Completed:Wait()
task.wait(0.2)

for i = 2, #frames do
	titleLabel.Text = frames[i]
	task.wait(0.15)
end
task.wait(0.8)

local fadeOut = TweenService:Create(titleLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad), { TextTransparency = 1 })
fadeOut:Play()
fadeOut.Completed:Wait()
titleLabel:Destroy()

-- 3. ฟังก์ชันสร้าง Pop-up แจ้งเตือนภาษาไทยอ่านง่าย
local function showDialog(titleText, descText, btnText, btnAction)
	local tintFrame = Instance.new("Frame")
	tintFrame.Name = "TintFrame"
	tintFrame.Size = UDim2.fromScale(1, 1)
	tintFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	tintFrame.BackgroundTransparency = 0.4
	tintFrame.Parent = screenGui

	local root = Instance.new("CanvasGroup")
	root.Name = "Root"
	root.Size = UDim2.fromOffset(420, 200)
	root.AnchorPoint = Vector2.new(0.5, 0.5)
	root.Position = UDim2.fromScale(0.5, 0.5)
	root.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	root.GroupTransparency = 1
	root.Parent = tintFrame

	local rootCorner = Instance.new("UICorner")
	rootCorner.CornerRadius = UDim.new(0, 10)
	rootCorner.Parent = root

	local rootStroke = Instance.new("UIStroke")
	rootStroke.Color = Color3.fromRGB(70, 70, 70)
	rootStroke.Thickness = 1.5
	rootStroke.Parent = root

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Size = UDim2.new(1, -40, 0, 40)
	title.Position = UDim2.new(0, 20, 0, 15)
	title.BackgroundTransparency = 1
	title.Text = titleText
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 20
	title.Font = Enum.Font.GothamBold
	title.Parent = root

	local body = Instance.new("TextLabel")
	body.Name = "Body"
	body.Size = UDim2.new(1, -40, 0, 65)
	body.Position = UDim2.new(0, 20, 0, 50)
	body.BackgroundTransparency = 1
	body.Text = descText
	body.TextColor3 = Color3.fromRGB(200, 200, 200)
	body.TextSize = 14
	body.Font = Enum.Font.Gotham
	body.TextWrapped = true
	body.Parent = root

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -40, 0, 40)
	btn.Position = UDim2.new(0, 20, 1, -55)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.Text = btnText or "โอเค"
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 15
	btn.Font = Enum.Font.GothamMedium
	btn.Parent = root

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		if btnAction then btnAction() end
		screenGui:Destroy()
	end)

	TweenService:Create(root, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { GroupTransparency = 0 }):Play()
end

-- 4. ตรวจสอบการทำงาน
local currentPlaceId = game.PlaceId

if SUPPORTED_GAMES[currentPlaceId] or SUPPORTED_GAMES[0] then
	if MAIN_SCRIPT_URL ~= "" then
		loadstring(game:HttpGet(MAIN_SCRIPT_URL))()
	else
		showDialog(HUB_NAME, "สคริปต์พร้อมใช้งานแล้ว ลุยได้เลย!", "โอเค ลุย!", nil)
	end
else
	showDialog(
		"ยังใช้กับเกมนี้ไม่ได้นะ",
		"ไอดีแมปนี้คือ: " .. tostring(currentPlaceId) .. "\nตอนนี้ตั้งค่าเปิดให้ใช้แค่บางแมปเท่านั้น",
		"เข้าใจแล้ว",
		nil
	)
end
