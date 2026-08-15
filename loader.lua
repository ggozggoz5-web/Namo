--[[
██╗   ██╗ ██████╗ ██╗██████╗ ██╗    ██╗ █████╗ ██████╗ ███████╗
██║   ██║██╔═══██╗██║██╔══██╗██║    ██║██╔══██╗██╔══██╗██╔════╝
██║   ██║██║   ██║██║██║  ██║██║ █╗ ██║███████║██████╔╝█████╗  
╚██╗ ██╔╝██║   ██║██║██║  ██║██║███╗██║██╔══██║██╔═══╝ ██╔══╝  
 ╚████╔╝ ╚██████╔╝██║██████╔╝╚███╔███╔╝██║  ██║██║     ███████╗
  ╚═══╝   ╚═════╝ ╚═╝╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝     ╚══════╝

                🚀 นะโม — Loader 🚀
----------------------------------------------------------------------------
  คำสั่งการใช้งาน:
  นำโค้ดด้านล่่างไปวางใน exploit editor แล้่วรันได้ทันที
  (ไม่ต้องกดลิงก์ใดๆ)

  รองรบั: Roblox (Luau) | พัทฒนาโดย นะโม
----------------------------------------------------------------------------
]]--

-- โหมดดีบัก: ตั้งค่าเป็ น true ถ้าต้องการดูรายละเอีียดการทำงานของสคริปต์ใน output
local DEBUG_MODE = shared.NamoDebug or false

-- ฟังก์ชั่ นช่ วยเหลือสำหรั บพิมพ์ดีบัก
local function debugLog(...)
	if DEBUG_MODE then
		local args = { ... }
		local msg = table.concat(args, " ")
		warn("[DEBUG] " .. msg)
		pcall(function()
			if not isfolder("namo_debug") then
				makefolder("namo_debug")
			end
			local debugFile = "namo_debug/namo_log.txt"
			local current = isfile(debugFile) and readfile(debugFile) or ""
			local timestamp = os.date("%Y-%m-%d %H:%M:%S")
			writefile(debugFile, current .. string.format("[%s] %s\n", timestamp, msg))
		end)
	end
end

repeat
	task.wait()
until game:IsLoaded()

debugLog("เริ่ มต้ นทำงานแล้ ว | ID เกม: " .. tostring(game.GameId))

-- ตารางจั บคู่ เกimei แกบสคริปตป์ เป้ ้าหมาย
local meta = {
	[0] = {
		title = "Universal (ทั่ วไปถึ ง)",
		dev = "namo.lua",
		script = "https://raw.githubusercontent.com/namo/loader/main/Universal.lua",
	},
	[2619619496] = {
		title = "Bedwars",
		dev = "namo.lua",
		script = "https://raw.githubusercontent.com/namo/loader/main/Bedwars.lua",
	},
	[7008097940] = {
		no = true,
		title = "Ink Game",
		dev = "namo.lua",
		script = "https://raw.githubusercontent.com/namo/loader/main/InkGame.lua",
	},
	[6331902150] = {
		title = "Forsaken",
		dev = "namo.lua",
		script = "https://raw.githubusercontent.com/namo/loader/main/Forsaken.lua",
	},
	[7326934954] = {
		title = "99 คืนในป่า",
		dev = "namo.lua",
		script = "https://raw.githubusercontent.com/namo/loader/main/99Nights.lua",
	},
}

debugLog("ค้ นหา ID เกม: " .. tostring(game.GameId))
local data = meta[game.GameId]
if not data then
	debugLog("ไม ่ พบข้อมู ลเกมเฉพาะ ใช ้ Universal แทน")
	data = meta[0]
	shared.NAMO_DISABLE = true
else
	debugLog("พบข้อมู ลเกมสำหรั บ: " .. tostring(data.title))
end

pcall(function()
	shared.ACTIVE_LOADER:Destroy()
end)

-- ตั วช่ วยรันฟังก์ชั่ นพร้อ ม timeout
local timedFunction = function(call, timeout, resFunction, ...)
	local suc, err
	local args = {}
	if call ~= nil and call == true then
		call = timeout
		timeout = 5
		args = { resFunction, ... }
	end
	task.spawn(function()
		suc, err = pcall(function()
			return call(unpack(args))
		end)
	end)
	timeout = timeout or 5
	local start = tick()
	repeat
		task.wait()
	until suc ~= nil or tick() - start >= timeout
	if suc == nil then
		suc = false
		err = "TIMEOUT_EXCEEDED"
	end
	if not suc then
		warn(debug.traceback(err))
	end
	if resFunction ~= nil and type(resFunction) == "function" then
		return resFunction(suc, err)
	end
	return suc, err
end

local __def_table = setmetatable({}, {
	__index = function(self)
		return self
	end,
	__call = function(self)
		return self
	end,
	__newindex = function(self)
		return self
	end,
})

local loaderFile
if data ~= nil and data.no then
	loaderFile = __def_table
end

debugLog("กำลั งโหลดไฟลด์ตั วโหลด...")
loaderFile = loaderFile
	or timedFunction(
		function()
			debugLog("ดรกื ไฟลด์ตั วโหลดจาก URL...")
			local url = "https://raw.githubusercontent.com/namo/loader/main/loader_core.lua"
			debugLog("URL ตั วโหลด: " .. url)

			local success, response = pcall(function()
				return game:HttpGet(url, true)
			end)

			if not success then
				debugLog("HTTP GET ล้มเหลว: " .. tostring(response))
				return nil
			end

			debugLog("HTTP GET สำเรั จ | ความยาว: " .. tostring(string.len(response)))
			debugLog("ตั วอย่ างข้อมู ล: " .. string.sub(response, 1, 200) .. "...")

			if response and response ~= "nil" then
				debugLog("ข้อมู ลถู กตั อง กำลั งบันทึ กไฟลด์...")
				timedFunction(function()
					if not isfolder("namo_libs") then
						makefolder("namo_libs")
						debugLog("สร้ างโฟลเดอรด์ namo_libs แล้ ว")
					end
					writefile("namo_libs/loader_core.lua", response)
					debugLog("บันทึ ก loader_core.lua เสรั จ")
				end, 1)
				debugLog("กำลั ง compile string...")
				local compiled = loadstring(response)
				if compiled then
					debugLog("compile สำเรั จ")
					return compiled()
				else
					debugLog("compile ล้มเหลว!")
					return nil
				end
			else
				debugLog("คำเตื อน: ข้อมู ลเป็ น nil หรื อค่า 'nil'")
				return nil
			end
		end,
		5,
		function(suc, err)
			debugLog("ผลการโหลดครั้ งแรก: success=" .. tostring(suc) .. ", err=" .. tostring(err))
			return suc and err
				or timedFunction(
					function()
						debugLog("พยายามโหลดจากไฟลด์สำรอง...")
						if not isfolder("namo_libs") then
							makefolder("namo_libs")
						end
						if not isfile("namo_libs/loader_core.lua") then
							debugLog("ผิดพลาด: ใม่ มีไฟลด์ loader_core.lua!")
							error("ไม่พบไฟลด์ตั วโหลดสำรอง")
							return
						end
						debugLog("อ้ าญไฟลด์ loader_core.lua...")
						local content = readfile("namo_libs/loader_core.lua")
						debugLog("อ้ าญเสรั จ ความยาว: " .. tostring(string.len(content)))
						local compiled = loadstring(content)
						if compiled then
							debugLog("โหลดจากไฟลด์สำเรั จ")
							return compiled()
						else
							debugLog("compile จากไฟลด์ล้มเหลว")
							return nil
						end
					end,
					5,
					function(suc, err)
						debugLog("ผลการโหลดสำรอง: success=" .. tostring(suc) .. ", err=" .. tostring(err))
						return suc and err or __def_table
					end
				)
		end
	)

debugLog("จั ดการ loaderFile...")
if loaderFile and type(loaderFile) == "table" and loaderFile.Colors then
	debugLog("loaderFile ถู กตั อง มีคณุ สมบัตกิ ารสัี")
else
	debugLog("คำเตื อน: loaderFile อาจไมถ่ ู กตั อง | Type: " .. type(loaderFile))
end

-- กำหนดสี Gradient สำหรั บ UI
loaderFile.Colors.Gradient = {
	ColorSequenceKeypoint.new(0, Color3.fromHex("#00f2ff")),
	ColorSequenceKeypoint.new(0.5, Color3.fromHex("#7b2fff")),
	ColorSequenceKeypoint.new(1, Color3.fromHex("#ff00aa")),
}

local stitle = "นะโม"
local sicon = nil
pcall(function()
	if tostring(shared.NAMO_SCRIPT_TYPE) == "99_NIGHTS_NAMO" then
		loaderFile.Colors.Gradient = {
			ColorSequenceKeypoint.new(0, Color3.fromHex("#a855f7")),
			ColorSequenceKeypoint.new(0.5, Color3.fromHex("#6366f1")),
			ColorSequenceKeypoint.new(1, Color3.fromHex("#3b82f6")),
		}
		stitle = "นะโม Core"
		sicon = nil
	end
end)

debugLog("สร้ าง instance ตั วโหลด...")
local loader = loaderFile:Loader(sicon)
shared.ACTIVE_LOADER = loader

loader:Connect(function(res)
	debugLog("ผลลัพธด์ ้าน loader: " .. tostring(res))
	shared.ACTIVE_LOADER = nil
end)

loader:Update("กำลั งเริ่ มต้ง้ ระบบ...", 0)
loader:Update("กำลั งดึงข้อมู ลเกม...", 10)

if data and data.staging and not shared.NamoDev then
	debugLog("พบ staging data แต่ไม่ ใช่ม โหมดพั ฒนา กำลั งล้างค่า...")
	data = nil
end

if not data then
	debugLog("ไมร่ อรองรบเก้ นนี้ นะ!")
	print("ไมร่ อรองรบเก้ นนี้ นะ :c")
	loader:Abort("ไมร่ อรองรบเก้ นนี้ นะ :c")
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = stitle .. " | ตั วโหลด",
		Text = "ไมร่ อรองรบเก้ นนี้ นะ :c",
		Duration = 15,
	})
	return
else
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = stitle .. " | ตั วโหลด",
		Text = "กำลั งโหลดสำหรั บ " .. tostring(data.title) .. "...",
		Duration = 15,
	})
	loader:Update(`กำลั งเตรียมน ${stitle} สำหรั บ ${tostring(data.title)}...`, 40)
	local res, err

	if shared.NamoDev and data.dev ~= nil and ({ pcall(function()
		return isfile(data.dev)
	end) })[2] then
		debugLog("ใชแ้ ฟลด์ dev: " .. tostring(data.dev))
		res, err = loadstring(readfile(data.dev))
	else
		debugLog("ดุ งสคริปต์จาก URL: " .. tostring(data.script))
		local success, scriptContent = pcall(function()
			return game:HttpGet(data.script, true)
		end)

		debugLog("ผลการดุ งสคริปต์: success=" .. tostring(success))
		if not success then
			debugLog("ดุ งสคริปต์ล้มเหลว: " .. tostring(scriptContent))
		elseif scriptContent == nil or scriptContent == "nil" then
			debugLog("คำเตื อน: เนื้อหาสคริปต์เป็ น nil!")
		else
			debugLog("ดุ งสคริปต์สำเรั จ | ความยาว: " .. tostring(string.len(scriptContent)))
			debugLog("ตั วอย่ างสคริปต์: " .. string.sub(scriptContent, 1, 500) .. "...")
		end

		if scriptContent == nil or scriptContent == "nil" then
			loader:Abort("นะโม ใม่ สามารถเข้ าถึ งไดป้ ะจำภูกุ ภาคของคุ ณ! \n กรุณาใชเ้ VPN แลว้ รันใหม่อีกครั้ ง!")
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "นะโม ใม่ รองรบั ในภูกุ ภาคของคุ ณ",
				Text = "กรุณาเปิ ด VPN แลว้ รัน นะโม ใหม่อีกครั้ ง!",
				Duration = 15,
			})
			return
		end
		debugLog("กำลั ง compile สคริปต์หลั ก...")
		res, err = loadstring(scriptContent)
		if res then
			debugLog("compile สำเรั จ | Type: " .. type(res))
		else
			debugLog("compile ล้มเหลว! ผิดพลาด: " .. tostring(err))
		end
	end

	if type(res) ~= "function" then
		debugLog("res ไม่ ใชฟ์ ังคชัน้ ! Type: " .. type(res))
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = stitle .. " | โหลดล้มเหลว",
			Text = tostring(res),
			Duration = 15,
		})
		print(`โหลดล้มเหลว ${tostring(err)} :c \n กรุณาลองใหม่อีกครั้ ง\n`)
		loader:Abort(`โหลดล้มเหลว ${tostring(err)} :c \n กรุณาลองใหม่อีกครั้ ง\n`)
		task.delay(0.5, function()
			if shared.NamoDev then return end
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = stitle .. " | รายงานปั ญหา",
				Text = "กรุณารายงานปั ญหาไปท่ี นะโม \n หรอื เข้ าร่วม Discord หลั ก",
				Duration = 15,
			})
		end)
	else
		debugLog("กำลั งรันสคริปต์หลั ก...")
		loader:Update(`กำลั งโหลด ${stitle}...`, 60)
		local suc, err = pcall(res)
		if not suc then
			debugLog("รันสคริปต์หลั กล้มเหลว: " .. tostring(err))
			print(`รันหลั กล้มเหลว ${tostring(err)} :c \n กรุณาลองใหม่อีกครั้ ง\n`)
			loader:Abort(`รันหลั กล้มเหลว ${tostring(err)} :c \n กรุณาลองใหม่อีกครั้ ง\n`)
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = stitle .. " | ผิดพลาดหลั ก",
				Text = tostring(err),
				Duration = 15,
			})
			task.delay(0.5, function()
				if shared.NamoDev then return end
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = stitle .. " | รายงานปั ญหา",
					Text = "กรุณารายงานปั ญหาไปท่ี นะโม \n หรอื เข้ าร่วม Discord หลั ก",
					Duration = 15,
				})
			end)
		else
			debugLog("รันสคริปต์หลั กสำเรั จ!")
			loader:Update(`กำลั งปิดระบบ...`, 80)
			shared.ACTIVE_LOADER = nil
			loader:Update(`โหลด ${stitle} สำหรั บ ${tostring(data.title)} สำเรั จแลว้ :D`, 100)
			task.delay(0.5, function()
				pcall(function()
					loader:Destroy()
				end)
				debugLog("ทำลาย loader เสรั จ")
			end)
		end
	end
end

debugLog("สคริปต์เสรั จสิ้ น")
