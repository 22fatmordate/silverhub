local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

return {
    adornPart = nil,
    targets = nil,
    ring1 = nil,
    ring2 = nil,
    ring3 = nil,
    cone = nil,
    connection = nil,
    Players = Players,
    RunService = RunService,
    VirtualInputManager = VirtualInputManager,
    player = Players.LocalPlayer,
    camera = workspace.CurrentCamera,
    adornedPlayers = {}
}