local github = "https://raw.githubusercontent.com/22fatmordate/silverhub/refs/heads/main/source/"
local _name = "module.lua"
_G.modules = loadstring(game:HttpGet(github.._name))()

local yes = {}

function yes.CheckHaki()
    return _G.modules.player.Character:FindFirstChild("HasBuso") and "ON" or "OFF"
end

function yes.Ken()
    local gui = _G.modules.player:FindFirstChild("PlayerGui")
    if not gui then return "OFF" end

    local main = gui:FindFirstChild("Main")
    if not main then return "OFF" end

    local hud = main:FindFirstChild("BottomHUDList")
    if not hud then return "OFF" end

    local context = hud:FindFirstChild("UniversalContextButtons")
    if not context then return "OFF" end

    local ken = context:FindFirstChild("BoundActionKen")
    if not ken then return "OFF" end

    local label = ken:FindFirstChild("DodgesLeftLabel")
    if not label then return "OFF" end

    return label.Visible and "ON" or "OFF"
end

return yes