local github = "https://raw.githubusercontent.com/22fatmordate/silverhub/refs/heads/main/source/"
local _name = "module.lua"
_G.modules = loadstring(game:HttpGet(github.._name))()

local yes = {}

function yes.CheckHaki()
    return _G.modules.player.Character:FindFirstChild("HasBuso") and "ON" or "OFF"
end

function yes.Ken()
    return _G.modules.player.PlayerGui.Main.BottomHUDList.UniversalContextButtons.BoundActionKen.DodgesLeftLabel.Visible and "ON" or "OFF"
end

return yes