local github = "https://raw.githubusercontent.com/22fatmordate/silverhub/refs/heads/main/source/"
local _init = "Init.lua"
local _3some = "3d.lua"
local fuckingtable = {
    loadinit = loadstring(game:HttpGet(github.._init))(),
    load3d = loadstring(game:HttpGet(github.._3some))()
}

fuckingtable.loadinit()
fuckingtable.load3d()