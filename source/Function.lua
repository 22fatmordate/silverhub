local github = "https://raw.githubusercontent.com/22fatmordate/silverhub/refs/heads/main/source/"
local _name = "module.lua"
_G.modules = loadstring(game:HttpGet(github.._name))()

local yes = {}

function yes.checkV4()
    local size = _G.modules.player.PlayerGui.Main.RaceEnergy.Fill.Size
    if math.abs(size.X.Scale - 1) < 0.01 and math.abs(size.X.Offset - 2) < 1 and
       math.abs(size.Y.Scale - 1.2) < 0.01 and math.abs(size.Y.Offset - 0) < 1 then
        return "Ready"
    else
        return "..."
    end
end

function yes.CheckHaki()
    return _G.modules.player.Character:FindFirstChild("HasBuso") and "ON" or "OFF"
end

function yes.Ken()
    return _G.modules.player.PlayerGui.Main.BottomHUDList.UniversalContextButtons.BoundActionKen.DodgesLeftLabel.Visible and "ON" or "OFF"
end

return yes