local github = "https://raw.githubusercontent.com/22fatmordate/silverhub/refs/heads/main/source/"
local _name = "module.lua"
local _function = "Function.lua"

_G.modules = loadstring(game:HttpGet(github.._name))()
_G.func = loadstring(game:HttpGet(github.._function))()

local Players = _G.modules.Players
local RunService = _G.modules.RunService
local VirtualInputManager = _G.modules.VirtualInputManager
local player = _G.modules.player
local adornedPlayers = _G.modules.adornedPlayers
local f = _G.func

return function()
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
		if _G.modules.adornedPlayers[targetPlayer] then return end

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
				if conn then
					-- anti override
					conn:Disconnect()
					conn = nil
				end
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

			local haki = f.CheckHaki()
			local v4 = f.Ken()

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
end