
-- SigbinHub Spawner UI (Fixed Version)
repeat wait() until game:IsLoaded()

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/ataturk123/GardenSpawner/refs/heads/main/Spawner.lua"))()
local allowedPets = Spawner.GetPets()

local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "SigbinHubSpawner"

-- Toggle Button
local toggleButton = Instance.new("TextButton", gui)
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.Text = "🦋"
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 20

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 280)
frame.Position = UDim2.new(0.5, -130, 0.4, -140)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "🦋 SigbinHub"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

-- Close Button
local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 16
closeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- Pet Dropdown
local selectedPet = nil

local function createLabel(y, text)
    local label = Instance.new("TextLabel", frame)
    label.Position = UDim2.new(0, 10, 0, y)
    label.Size = UDim2.new(0, 100, 0, 20)
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    return label
end

local function createInputBox(y, placeholder)
    local box = Instance.new("TextBox", frame)
    box.Position = UDim2.new(0, 10, 0, y)
    box.Size = UDim2.new(1, -20, 0, 30)
    box.PlaceholderText = placeholder
    box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    box.TextColor3 = Color3.new(0, 0, 0)
    box.Font = Enum.Font.SourceSans
    box.TextSize = 16
    return box
end

createLabel(40, "Select Pet:")
local petDropdown = Instance.new("TextButton", frame)
petDropdown.Position = UDim2.new(0, 10, 0, 65)
petDropdown.Size = UDim2.new(1, -20, 0, 30)
petDropdown.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
petDropdown.TextColor3 = Color3.new(1, 1, 1)
petDropdown.Font = Enum.Font.SourceSans
petDropdown.TextSize = 16
petDropdown.Text = "Choose Pet"

petDropdown.MouseButton1Click:Connect(function()
    if frame:FindFirstChild("DropdownMenu") then
        frame.DropdownMenu:Destroy()
        return
    end

    local menu = Instance.new("Frame", frame)
    menu.Name = "DropdownMenu"
    menu.Position = UDim2.new(0, 10, 0, 100)
    menu.Size = UDim2.new(1, -20, 0, 100)
    menu.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

    local scroll = Instance.new("ScrollingFrame", menu)
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.CanvasSize = UDim2.new(0, 0, 0, #allowedPets * 30)
    scroll.ScrollBarThickness = 6
    scroll.BackgroundTransparency = 1

    for i, pet in ipairs(allowedPets) do
        local option = Instance.new("TextButton", scroll)
        option.Size = UDim2.new(1, 0, 0, 25)
        option.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
        option.Text = pet
        option.TextColor3 = Color3.new(1, 1, 1)
        option.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        option.Font = Enum.Font.SourceSansBold
        option.TextSize = 16

        option.MouseButton1Click:Connect(function()
            petDropdown.Text = pet
            selectedPet = pet
            menu:Destroy()
        end)
    end
end)

createLabel(140, "Weight (KG):")
local kgBox = createInputBox(165, "e.g. 10")

createLabel(200, "Age:")
local ageBox = createInputBox(225, "e.g. 5")

-- Spawn Button
local spawnPetButton = Instance.new("TextButton", frame)
spawnPetButton.Position = UDim2.new(0, 10, 0, 260)
spawnPetButton.Size = UDim2.new(1, -20, 0, 30)
spawnPetButton.BackgroundColor3 = Color3.fromRGB(70, 180, 100)
spawnPetButton.Text = "Spawn Pet"
spawnPetButton.TextColor3 = Color3.new(1, 1, 1)
spawnPetButton.Font = Enum.Font.SourceSansBold
spawnPetButton.TextSize = 18

spawnPetButton.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sigbinhub/pet-spawner/refs/heads/main/sigbinhub/gagscript"))()
    end)
    if not success then
        warn("Failed to run external script:", err)
    end
end)
