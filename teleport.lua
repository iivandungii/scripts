local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
 
local localPlayer = Players.LocalPlayer
 
-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerButtons"
screenGui.ResetOnSpawn = false
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
 
-- Create ScrollingFrame instead of Frame for player list
local frame = Instance.new("ScrollingFrame")
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 270, 0, 10)  -- shifted to the right
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = screenGui
 
frame.CanvasSize = UDim2.new(0, 0, 0, 0) -- initially no scrolling
frame.ScrollBarThickness = 8
frame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
 
-- Button to show/hide player list
local toggleListButton = Instance.new("TextButton")
toggleListButton.Text = "Select Player"
toggleListButton.Size = UDim2.new(0, 130, 0, 30)
toggleListButton.Position = UDim2.new(0, 10, 0, 10)
toggleListButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleListButton.BorderSizePixel = 0
toggleListButton.TextColor3 = Color3.new(1, 1, 1)
toggleListButton.Parent = screenGui
 
-- Button to enable/disable teleport
local teleportToggleButton = Instance.new("TextButton")
teleportToggleButton.Text = "Teleport OFF"
teleportToggleButton.Size = UDim2.new(0, 130, 0, 30)
teleportToggleButton.Position = UDim2.new(0, 10, 0, 50)
teleportToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
teleportToggleButton.BorderSizePixel = 0
teleportToggleButton.TextColor3 = Color3.new(1, 1, 1)
teleportToggleButton.Parent = screenGui
 
-- Hide all button
local hideAllButton = Instance.new("TextButton")
hideAllButton.Text = "OFF UI"
hideAllButton.Size = UDim2.new(0, 130, 0, 30)
hideAllButton.Position = UDim2.new(0, 10, 0, 90)
hideAllButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
hideAllButton.BorderSizePixel = 0
hideAllButton.TextColor3 = Color3.new(1, 1, 1)
hideAllButton.Parent = screenGui
 
-- Show all button (small square)
local showAllButton = Instance.new("TextButton")
showAllButton.Text = "ON UI" -- small arrow
showAllButton.Size = UDim2.new(0, 30, 0, 30) -- small square 30x30
showAllButton.Position = UDim2.new(0, 10, 0, 90) -- same position as hideAllButton
showAllButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
showAllButton.BorderSizePixel = 0
showAllButton.TextColor3 = Color3.new(1, 1, 1)
showAllButton.Visible = false
showAllButton.Parent = screenGui
 
-- Teleport position toggle button
local positionButton = Instance.new("TextButton")
positionButton.Text = "Position: Behind"
positionButton.Size = UDim2.new(0, 130, 0, 30)
positionButton.Position = UDim2.new(0, 10, 0, 130)
positionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
positionButton.BorderSizePixel = 0
positionButton.TextColor3 = Color3.new(1, 1, 1)
positionButton.Parent = screenGui
 
-- + and - buttons for teleport distance
local plusButton = Instance.new("TextButton")
plusButton.Text = "+"
plusButton.Size = UDim2.new(0, 30, 0, 30)
plusButton.Position = UDim2.new(0, 150, 0, 130)
plusButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
plusButton.BorderSizePixel = 0
plusButton.TextColor3 = Color3.new(1, 1, 1)
plusButton.Parent = screenGui
 
local minusButton = Instance.new("TextButton")
minusButton.Text = "-"
minusButton.Size = UDim2.new(0, 30, 0, 30)
minusButton.Position = UDim2.new(0, 190, 0, 130)
minusButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
minusButton.BorderSizePixel = 0
minusButton.TextColor3 = Color3.new(1, 1, 1)
minusButton.Parent = screenGui
 
-- Distance label
local distanceLabel = Instance.new("TextLabel")
distanceLabel.Text = "Distance: 4.0"
distanceLabel.Size = UDim2.new(0, 200, 0, 30)
distanceLabel.Position = UDim2.new(0, 10, 0, 170)
distanceLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
distanceLabel.BorderSizePixel = 0
distanceLabel.TextColor3 = Color3.new(1, 1, 1)
distanceLabel.Parent = screenGui
 
-- State variables
local selectedPlayer = nil
local teleportEnabled = false
local positionBehind = true
local distanceFromTarget = 4.0
 
-- Function to create player button
local function createPlayerButton(player)
    local btn = Instance.new("TextButton")
    btn.Text = player.Name
    btn.Size = UDim2.new(0, 180, 0, 25)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Parent = frame
 
    btn.MouseButton1Click:Connect(function()
        selectedPlayer = player
        -- Update button colors
        for _, child in pairs(frame:GetChildren()) do
            if child:IsA("TextButton") then
                if child.Text == player.Name then
                    child.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                else
                    child.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                end
            end
        end
    end)
 
    return btn
end
 
-- Handler for showing/hiding player list
toggleListButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    if frame.Visible then
        -- Clear old buttons
        for _, child in pairs(frame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        -- Create buttons for all players except local
        local yOffset = 0
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                local btn = createPlayerButton(player)
                btn.Position = UDim2.new(0, 10, 0, yOffset)
                yOffset = yOffset + 30
                if player == selectedPlayer then
                    btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                end
            end
        end
        frame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
    end
end)
 
-- Enable/disable teleport
teleportToggleButton.MouseButton1Click:Connect(function()
    teleportEnabled = not teleportEnabled
    if teleportEnabled then
        teleportToggleButton.Text = "Teleport ON"
    else
        teleportToggleButton.Text = "Teleport OFF"
    end
end)
 
-- Hide all buttons and panel
hideAllButton.MouseButton1Click:Connect(function()
    toggleListButton.Visible = false
    teleportToggleButton.Visible = false
    hideAllButton.Visible = false
    positionButton.Visible = false
    plusButton.Visible = false
    minusButton.Visible = false
    distanceLabel.Visible = false
    frame.Visible = false
    showAllButton.Visible = true
end)
 
-- Show all buttons and panel
showAllButton.MouseButton1Click:Connect(function()
    toggleListButton.Visible = true
    teleportToggleButton.Visible = true
    hideAllButton.Visible = true
    positionButton.Visible = true
    plusButton.Visible = true
    minusButton.Visible = true
    distanceLabel.Visible = true
    showAllButton.Visible = false
end)
 
-- Toggle teleport position
positionButton.MouseButton1Click:Connect(function()
    positionBehind = not positionBehind
    if positionBehind then
        positionButton.Text = "Position: Behind"
    else
        positionButton.Text = "Position: In Front"
    end
end)
 
-- Increase distance
plusButton.MouseButton1Click:Connect(function()
    distanceFromTarget = distanceFromTarget + 0.5
    distanceLabel.Text = "Distance: " .. string.format("%.1f", distanceFromTarget)
end)
 
-- Decrease distance
minusButton.MouseButton1Click:Connect(function()
    distanceFromTarget = math.max(0.5, distanceFromTarget - 0.5)
    distanceLabel.Text = "Distance: " .. string.format("%.1f", distanceFromTarget)
end)
 
-- Teleport function
local function teleportToPlayer(targetPlayer)
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    local targetHRP = targetPlayer.Character.HumanoidRootPart
    local localCharacter = localPlayer.Character
    if not localCharacter or not localCharacter:FindFirstChild("HumanoidRootPart") then
        return
    end
    local localHRP = localCharacter.HumanoidRootPart
 
    local targetCFrame = targetHRP.CFrame
    local offset
    if positionBehind then
        offset = -targetHRP.CFrame.LookVector * distanceFromTarget
        localHRP.CFrame = CFrame.new(targetHRP.Position + offset, targetHRP.Position + offset + targetHRP.CFrame.LookVector)
    else
        offset = targetHRP.CFrame.LookVector * distanceFromTarget
        localHRP.CFrame = CFrame.new(targetHRP.Position + offset, targetHRP.Position)
    end
end
 
-- Continuous teleportation when enabled
RunService.Heartbeat:Connect(function()
    if teleportEnabled and selectedPlayer then
        teleportToPlayer(selectedPlayer)
    end
end)
