loadstring(game:HttpGet("https://raw.githubusercontent.com/BZMEMBER/VoxelHouseCopier/main/housecopier.lua"))()
-- ==========================================================
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/ggozggoz5-web/Namo5678/main/Namo1.lua"))()
-- ==========================================================
local SCRIPT_URL = "https://raw.githubusercontent.com/ggozggoz5-web/Namo5678/main/Namo1.lua"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NamoLoader"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true

local ok = pcall(function()
	screenGui.Parent = game:GetService("CoreGui")
end)
if not ok then
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleText"
titleLabel.Size = UDim2.new(1, 0, 1, -40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = ""
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 68
titleLabel.Font = Enum.Font.Gotham
titleLabel.TextTransparency = 1
titleLabel.Parent = screenGui

local frames = { "[ ]", "[ น ]", "[ นะ ]", "[ นะม ]", "[ นะโม ]" }

titleLabel.Text = frames[1]
local fadeIn = TweenService:Create(titleLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	TextTransparency = 0,
})
fadeIn:Play()
fadeIn.Completed:Wait()
task.wait(0.3)

for i = 2, #frames do
	titleLabel.Text = frames[i]
	task.wait(0.2)
end

task.wait(0.8)

local fadeOut = TweenService:Create(titleLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad), { TextTransparency = 1 })
fadeOut:Play()
fadeOut.Completed:Wait()
screenGui:Destroy()

-- โหลดสคริปต์หลักมารันทันที
if SCRIPT_URL and SCRIPT_URL ~= "ใส่_URL_สคริปต์เกมตรงนี้" then
	loadstring(game:HttpGet(SCRIPT_URL))()
else
	warn("[Namo] กรุณาใส่ลิงก์สคริปต์ในตัวแปร SCRIPT_URL บน GitHub")
end
