-- ui skid chat gpt --
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
mainFrame.Visible = true

local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 12)

local shadow = Instance.new("UIStroke", mainFrame)
shadow.Thickness = 2
shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
shadow.Color = Color3.fromRGB(40, 255, 190)

local title = Instance.new("TextLabel", mainFrame)
title.Text = "Silver Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(180, 255, 230)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)

local function createToggleButton(name, yPosition, defaultState, callback)
	local button = Instance.new("TextButton", mainFrame)
	button.Size = UDim2.new(0.8, 0, 0, 40)
	button.Position = UDim2.new(0.1, 0, 0, yPosition)
	button.Text = name .. ": " .. (defaultState and "ON" or "OFF")
	button.Font = Enum.Font.Gotham
	button.TextSize = 18
	button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	button.TextColor3 = Color3.fromRGB(200, 255, 255)
	button.BorderSizePixel = 0

	local corner = Instance.new("UICorner", button)
	corner.CornerRadius = UDim.new(0, 8)

	local enabled = defaultState or false

	if callback then
		pcall(callback, enabled)
	end

	button.MouseButton1Click:Connect(function()
		enabled = not enabled
		button.Text = name .. ": " .. (enabled and "ON" or "OFF")
		pcall(callback, enabled)
	end)
end

createToggleButton("Show Circle", 60, true, function(b)
    getgenv().HienThiVongTron = b
end)
createToggleButton("Direction Lines", true, 110, function(a)
    getgenv().directionlines = a
end)

if not cloneref then
	cloneref = function(obj) return obj end
end

local Services = setmetatable({}, {
	__index = function(_, name)
		return cloneref(game:GetService(name))
	end
})

local adornPart, ring1, ring2, ring3, cone, connection
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local vfxfolder = workspace._WorldOrigin

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local adornedPlayers = {}

local function CheckHaki()
    return player.Character:FindFirstChild("HasBuso") and "ON" or "OFF"
end

local function Ken()
    return player.PlayerGui.Main.BottomHUDList.UniversalContextButtons.BoundActionKen.DodgesLeftLabel.Visible and "ON" or "OFF"
end

local targets

local function checkV4()
    local size = player.PlayerGui.Main.RaceEnergy.Fill.Size
    if math.abs(size.X.Scale - 1) < 0.01 and math.abs(size.X.Offset - 2) < 1 and
       math.abs(size.Y.Scale - 1.2) < 0.01 and math.abs(size.Y.Offset - 0) < 1 then
        return "Ready"
    else
        return "..."
    end
end

local function getPlayersInCircle(centerPosition, radius)
	local playersInRange = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local targetHRP = p.Character.HumanoidRootPart
			local offset = Vector3.new(targetHRP.Position.X - centerPosition.X, 0, targetHRP.Position.Z - centerPosition.Z)
			local distance = offset.Magnitude
			if distance <= radius then
				table.insert(playersInRange, {player = p, distance = distance})
			end
		end
	end
	table.sort(playersInRange, function(a, b) return a.distance < b.distance end)
	return playersInRange
end

local function adornPlayer(targetPlayer)
	if not targetPlayer.Character then return end
	if adornedPlayers[targetPlayer] then return end

	local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local adornFolder = Instance.new("Folder")
	adornFolder.Name = "Adornsxxx"
	adornFolder.Parent = hrp
	adornedPlayers[targetPlayer] = adornFolder

	local evadeBillboard = Instance.new("BillboardGui")
	evadeBillboard.Name = "EvadeLabel"
	evadeBillboard.Size = UDim2.new(0, 100, 0, 30)
	evadeBillboard.StudsOffset = Vector3.new(0, -3.5, 0)
	evadeBillboard.Adornee = hrp
	evadeBillboard.AlwaysOnTop = true
    evadeBillboard.MaxDistance = 40
	evadeBillboard.Parent = adornFolder

	local evadeText = Instance.new("TextLabel")
	evadeText.Size = UDim2.new(1, 0, 1, 0)
	evadeText.BackgroundTransparency = 1
	evadeText.Text = "LOADING"
	evadeText.TextColor3 = Color3.fromRGB(255, 255, 255)
	evadeText.TextStrokeTransparency = 0.5
	evadeText.Font = Enum.Font.SourceSans
	evadeText.TextSize = 30
	evadeText.SizeConstraint = Enum.SizeConstraint.RelativeXY
	evadeText.RichText = true
	evadeText.Parent = evadeBillboard

	local ring = Instance.new("CylinderHandleAdornment")
	ring.Transparency = 0.2
	ring.Color3 = Color3.fromRGB(255, 255, 0)
	ring.Radius = 7
	ring.InnerRadius = 6.7
	ring.Height = 0.015
	ring.Adornee = hrp
	ring.CFrame = CFrame.Angles(math.rad(90), 0, 0)
	ring.ZIndex = 1
	ring.AdornCullingMode = Enum.AdornCullingMode.Never
	ring.Parent = adornFolder

    local ring2 = Instance.new("CylinderHandleAdornment")
	ring2.Transparency = 0.2
    ring2.Color3 = Color3.fromRGB(0, 255, 255)
	ring2.Radius = 45
	ring2.InnerRadius = 44.7
	ring2.Height = 0.015
	ring2.Adornee = hrp
	ring2.CFrame = CFrame.Angles(math.rad(90), 0, 0)
	ring2.ZIndex = 1
	ring2.AdornCullingMode = Enum.AdornCullingMode.Never
	ring2.Parent = adornFolder
	-- Cone
	local cone = Instance.new("ConeHandleAdornment")
	cone.Transparency = 0.2
	cone.Radius = 0.45
	cone.Height = 65
	cone.Color3 = Color3.fromRGB(255, 0, 0)
	cone.Adornee = hrp
	cone.CFrame = CFrame.new(0, 0, -1.5)
	cone.ZIndex = 2
	cone.AdornCullingMode = Enum.AdornCullingMode.Never
	cone.Parent = adornFolder

	local updateInterval = 0.1
	local lastUpdate = 0

	local conn
	conn = RunService.RenderStepped:Connect(function()
		if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			if adornFolder and adornFolder.Parent then
				adornFolder:Destroy()
			end
			adornedPlayers[targetPlayer] = nil
			if conn then conn:Disconnect() end
			return
		end

		local hrp = targetPlayer.Character.HumanoidRootPart
		cone.CFrame = hrp.CFrame:ToObjectSpace(CFrame.new(0, 0, -1.5))

		local now = tick()
		if now - lastUpdate >= updateInterval then
			lastUpdate = now

			local haki = targetPlayer.Character:FindFirstChild("HasBuso") and "ON" or "OFF"
			local hakiColor = (haki == "ON") and "rgb(0,255,0)" or "rgb(255,0,0)"

			local newText = string.format(
				'<font color="%s">Buso: %s</font>',
				hakiColor, haki
			)

			if evadeText.Text ~= newText then
				evadeText.Text = newText
			end

			local h = (tick() * 0.5) % 1.2
			local color = Color3.fromHSV(h, 1, 1)
			ring2.Color3 = color
			cone.Color3 = color
		end
	end)
end

local function setupCharacter(character)
	local hrp = character:WaitForChild("HumanoidRootPart")

	if adornPart then adornPart:Destroy() end
	if connection then connection:Disconnect() end

	adornPart = Instance.new("Part")
	adornPart.Anchored = true
	adornPart.CanCollide = false
	adornPart.Transparency = 1
	adornPart.Size = Vector3.new(1, 1, 1)
	adornPart.CFrame = hrp.CFrame * CFrame.new(0, -3, 0)
	adornPart.Parent = workspace

    local evadeBillboard = Instance.new("BillboardGui")
    evadeBillboard.Name = "EvadeLabel"
    evadeBillboard.Size = UDim2.new(0, 100, 0, 30)
    evadeBillboard.StudsOffset = Vector3.new(0, -3.5, 0)
    evadeBillboard.Adornee = hrp
    evadeBillboard.AlwaysOnTop = true
    evadeBillboard.Parent = adornPart

    local evadeText = Instance.new("TextLabel")
    evadeText.Size = UDim2.new(1, 0, 1, 0)
    evadeText.BackgroundTransparency = 1
    evadeText.Text = "LOADING"
    evadeText.TextColor3 = Color3.fromRGB(255, 255, 255)
    evadeText.TextStrokeTransparency = 0.5
    evadeText.Font = Enum.Font.SourceSans
    evadeText.TextSize = 30
    evadeText.Parent = evadeBillboard
    evadeText.SizeConstraint = Enum.SizeConstraint.RelativeXY
    evadeText.RichText = true

    ring1 = Instance.new("CylinderHandleAdornment")
    ring1.Transparency = 0.2
	ring1.Radius = 7
    ring1.Color3 = Color3.fromRGB(0,255,119)
	ring1.InnerRadius = 6.7
	ring1.Height = 0.015
	ring1.Adornee = adornPart
	ring1.CFrame = CFrame.Angles(math.rad(90), 0, 0)
	ring1.ZIndex = 1
	ring1.AdornCullingMode = Enum.AdornCullingMode.Never
	ring1.Parent = adornPart
    -- old ring ring2.Transparency = 0.5
	ring2 = Instance.new("CylinderHandleAdornment")
	ring2.Transparency = 0.2
    ring2.Color3 = Color3.fromRGB(0, 255, 255)
	ring2.Radius = 45
	ring2.InnerRadius = 44.7
	ring2.Height = 0.015
	ring2.Adornee = adornPart
	ring2.CFrame = CFrame.Angles(math.rad(90), 0, 0)
	ring2.ZIndex = 1
	ring2.AdornCullingMode = Enum.AdornCullingMode.Never
	ring2.Parent = adornPart

    ring3 = Instance.new("CylinderHandleAdornment")
	ring3.Transparency = 0.2
    ring3.Color3 = Color3.fromRGB(255, 255, 0)
	ring3.Radius = 95
	ring3.InnerRadius = 94.56
	ring3.Height = 0.015
	ring3.Adornee = adornPart
	ring3.CFrame = CFrame.Angles(math.rad(90), 0, 0)
	ring3.ZIndex = 1
	ring3.AdornCullingMode = Enum.AdornCullingMode.Never
	ring3.Parent = adornPart

	cone = Instance.new("ConeHandleAdornment")
	cone.Transparency = 1
	cone.Radius = 0.15
	cone.Height = 25
	cone.Adornee = hrp
	cone.CFrame = CFrame.new(0, 0, -1.5)
	cone.ZIndex = 1
	cone.Parent = hrp

    local lastUpdate = 0
    local updateInterval = 0.1

    connection = RunService.RenderStepped:Connect(function()
        if not (hrp and adornPart and ring2 and cone and evadeText) then return end
        adornPart.CFrame = CFrame.new(hrp.Position - Vector3.new(0, 3, 0))
		local h = (tick() * 0.5) % 1.2
		local color = Color3.fromHSV(h, 1, 1)
		ring3.Color3 = color
		cone.Color3 = color

        local now = tick()
        if now - lastUpdate < updateInterval then return end
        lastUpdate = now

        local haki = CheckHaki()
        local v4 = Ken()

        local hakiColor = (haki == "ON") and "rgb(0,255,0)" or "rgb(255,0,0)"
        local v4Color = (v4 == "ON") and "rgb(251,251,140)" or "rgb(255,0,0)"
        local targetText = string.format(
            '<font color="rgb(255,255,255)">Target: %s</font>',
            (targets and targets[1] and targets[1].player and targets[1].player.Name) or "None"
        )

        local newText = string.format(
            '<font color="%s">Buso: %s</font>, <font color="%s">Ken: %s</font>\n%s',
            hakiColor, haki,
            v4Color, v4,
            targetText
        )

        if evadeText.Text ~= newText then
            evadeText.Text = newText
        end

        local showRing = getgenv().HienThiVongTron == true
        local targetTransparency = showRing and 0.35 or 1
        if ring1.Transparency ~= targetTransparency then
            ring1.Transparency = targetTransparency
            ring2.Transparency = targetTransparency
            ring3.Transparency = targetTransparency
        end

        local showCone = getgenv().directionlines == true
        local coneTargetTransparency = showCone and 0.2 or 1
        if cone.Transparency ~= coneTargetTransparency then
            cone.Transparency = coneTargetTransparency
        end

        targets = getPlayersInCircle(adornPart.Position, 95)
    end)
end

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)

RunService.Heartbeat:Connect(function()
    if targets and targets[1] then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v == targets[1].player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                PlayersPosition = v.Character.HumanoidRootPart.Position
            end
        end
    else
        PlayersPosition = nil
    end
end)

spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg,false)
    gg.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        if tostring(method) == "FireServer" then
            if tostring(args[1]) == "RemoteEvent" then
                if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                    if targets and targets[1] and PlayersPosition then
                        args[2] = PlayersPosition
                        return old(unpack(args))
                    end
                end
            end
        end
        return old(...)
    end)
end)

for _, p in ipairs(Players:GetPlayers()) do
	if p ~= player then
		if p.Character then adornPlayer(p) end
		p.CharacterAdded:Connect(function()
			task.wait(1)
			adornPlayer(p)
		end)
	end
end

Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function()
		task.wait(1)
		adornPlayer(p)
	end)
end)
