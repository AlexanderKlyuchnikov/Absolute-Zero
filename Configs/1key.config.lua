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
	columnsize = 75,
	combo = true,
	comboposition = 42,
	health = true,
	healthposition = 65,
	hiterror = true,
	hiterrorposition = 55,
	hitposition = 95,
	judgement = true,
	judgementposition = 73,
	playfieldblackout = 100,
	primarycolour = "blue",
	progress = true,
	progressposition = 50,
	showperfecterror = true,
	showperfectjudgement = true,
	stagelight = true
} --[[/data]]

function config:draw(w, h)
	local data = self.data

	sphereElements.addConfigIntroduce()
	just.indent(15)
	just.text("1key keymode")
	imgui.setSize(w, h, w / 2, 55)
	sphereElements.addConfig1keySettings(data)
	
	imgui.separator()
	if imgui.button("Write config file", "Write") then
		self:write()
	end
	data.autosave = imgui.checkbox("autosave", data.autosave, "Autosave")
end

return config
