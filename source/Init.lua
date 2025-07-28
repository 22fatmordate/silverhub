return function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local screenGui = Instance.new("ScreenGui", player:FindFirstChild("PlayerGui"))
    screenGui.Name = "SilverGui"
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = UDim2.new(0, 300, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Active = true
    mainFrame.Draggable = true

    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

    Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(40, 255, 190)

    local title = Instance.new("TextLabel", mainFrame)
    title.Text = "Silver Hub"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextColor3 = Color3.fromRGB(180, 255, 230)
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 10)

    function createToggleButton(name, yPosition, defaultState, callback)
        local button = Instance.new("TextButton", mainFrame)
        button.Size = UDim2.new(0.8, 0, 0, 40)
        button.Position = UDim2.new(0.1, 0, 0, yPosition)
        button.Text = name .. ": " .. (defaultState and "ON" or "OFF")
        button.Font = Enum.Font.Gotham
        button.TextSize = 18
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        button.TextColor3 = Color3.fromRGB(200, 255, 255)
        button.BorderSizePixel = 0
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

        local enabled = defaultState or false
        pcall(callback, enabled)
        button.MouseButton1Click:Connect(function()
            enabled = not enabled
            button.Text = name .. ": " .. (enabled and "ON" or "OFF")
            pcall(callback, enabled)
        end)
    end

    createToggleButton("Show Circle", 60, true, function(b) getgenv().HienThiVongTron = b end)

    createToggleButton("Direction Lines", 110, true, function(a) getgenv().directionlines = a end)
end