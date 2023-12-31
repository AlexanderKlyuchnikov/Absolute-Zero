local JustConfig = require("sphere.JustConfig")
local imgui = require("imgui")
local just = require("just")
local config = JustConfig()
config.w = 550
config.h = 700
local root = (...):match("^(.+)/(.-)/(.-)$")
local sphereElements = require(root .. "/Modules/SphereElements")

config.data = --[[data]] {
	autosave = true,
	columnsize = 37,
	combo = true,
	comboposition = 42,
	health = true,
	healthposition = 65,
	hiterror = true,
	hiterrorposition = 55,
	hitposition = 95,
	judgement = true,
	judgementposition = 73,
	middleline = true,
	playfieldblackout = 100,
	primarycolour = "white",
	progress = true,
	progressposition = 50,
	secondarycolour = "blue",
	showperfecterror = true,
	showperfectjudgement = true,
	stagelight = true
} --[[/data]]

function config:draw(w, h)
	local data = self.data

	sphereElements.addConfigIntroduce()
	just.indent(15)
	just.text("6key keymode")
	imgui.setSize(w, h, w / 2, 55)
	sphereElements.addConfigBaseSettings(data)
	
	imgui.separator()
	if imgui.button("Write config file", "Write") then
		self:write()
	end
	data.autosave = imgui.checkbox("autosave", data.autosave, "Autosave")
end

return config
