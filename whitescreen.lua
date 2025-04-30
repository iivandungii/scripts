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
