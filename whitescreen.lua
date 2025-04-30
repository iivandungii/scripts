local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local startTime = time()
local isRendering = false -- Trạng thái ban đầu: tắt 3D rendering

-- Khởi đầu tắt rendering
RunService:Set3dRenderingEnabled(isRendering)
setfpscap(15)

-- Tạo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "vandungGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Hàm tạo TextLabel với hiệu ứng galaxy
local function createGalaxyLabel(text, size, position)
	local label = Instance.new("TextLabel")
	label.Size = size
	label.Position = position
	label.Text = text
	label.TextScaled = true
	label.Font = Enum.Font.SourceSansBold
	label.BackgroundTransparency = 1
	label.TextStrokeTransparency = 0.4
	label.TextStrokeColor3 = Color3.new(0, 0, 0)
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Parent = screenGui

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(128, 0, 255)),
		ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 170, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 170)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 0, 170)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0))
	}
	gradient.Rotation = 45
	gradient.Parent = label

	return label
end

-- Label "vandung"
createGalaxyLabel("e-z.bio/xyzvandung", UDim2.new(0.6, 0, 0.12, 0), UDim2.new(0.2, 0, 0.3, 0))

-- Label FPS + thời gian treo
local infoLabel = createGalaxyLabel("Đang tải...", UDim2.new(0.6, 0, 0.07, 0), UDim2.new(0.2, 0, 0.44, 0))

-- Nút ON/OFF Rendering
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.2, 0, 0.07, 0)
toggleButton.Position = UDim2.new(0.4, 0, 0.6, 0)
toggleButton.Text = "WhitrScreen: OFF"
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Parent = screenGui

-- Sự kiện nút
toggleButton.MouseButton1Click:Connect(function()
	isRendering = not isRendering
	RunService:Set3dRenderingEnabled(isRendering)
	toggleButton.Text = "Rendering: " .. (isRendering and "ON" or "OFF")
end)

-- Cập nhật FPS + thời gian treo
local lastTick = tick()

RunService.RenderStepped:Connect(function()
	local currentTick = tick()
	local delta = currentTick - lastTick
	lastTick = currentTick
	
	local fps = math.floor(1 / delta)
	local uptime = math.floor(time() - startTime)
	local minutes = math.floor(uptime / 60)
	local seconds = uptime % 60
	local timeStr = string.format("%02d:%02d", minutes, seconds)

	infoLabel.Text = "FPS: " .. fps .. " | time afk: " .. timeStr
end)
-- Chống AFK ẩn hoàn toàn, chỉ log ra Output khi bị phát hiện
local vu = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:Connect(function()
	vu:CaptureController()
	vu:ClickButton2(Vector2.new())
	print("[Anti-AFK] Roblox phát hiện idle, đã tự xử lý.")
end)
 local v0;local v1=game;local v2=v1.Workspace;local v3=v1.Lighting;local v4=v2.Terrain;v4.WaterWaveSize=0;v4.WaterWaveSpeed=0;v4.WaterReflectance=0;v4.WaterTransparency=0;v3.GlobalShadows=false;v3.FogEnd=8999999488;v3.Brightness=0;settings().Rendering.QualityLevel="Level01";for v18,v19 in pairs(v1:GetDescendants()) do if (v19:IsA("Part") or v19:IsA("Union") or v19:IsA("CornerWedgePart") or v19:IsA("TrussPart")) then v19.Material="Plastic";v19.Reflectance=0;elseif (v19:IsA("Decal") or (v19:IsA("Texture") and v0)) then v19.Transparency=1;elseif (v19:IsA("ParticleEmitter") or v19:IsA("Trail")) then v19.Lifetime=NumberRange.new(0);elseif v19:IsA("Explosion") then v19.BlastPressure=1;v19.BlastRadius=1;elseif (v19:IsA("Fire") or v19:IsA("SpotLight") or v19:IsA("Smoke")) then v19.Enabled=false;elseif v19:IsA("MeshPart") then v19.Material="Plastic";v19.Reflectance=0;v19.TextureID=10385902758728956;end end for v20,v21 in pairs(v3:GetChildren()) do if (v21:IsA("BlurEffect") or v21:IsA("SunRaysEffect") or v21:IsA("ColorCorrectionEffect") or v21:IsA("BloomEffect") or v21:IsA("DepthOfFieldEffect")) then v21.Enabled=false;end end local v13=game:GetService("UserInputService");local v14=game:GetService("RunService");local v15=function()v14:Set3dRenderingEnabled(false);return;end;local v16=function()v14:Set3dRenderingEnabled(true);return;end;local v17=function()v13.WindowFocusReleased:Connect(v15);v13.WindowFocused:Connect(v16);return;end;v17(); 
