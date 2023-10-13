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
	columnsize = 35,
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
	pinknotes = true,
	playfieldblackout = 65,
	primarycolour = "white",
	progress = true,
	progressposition = 50,
	scratchcolour = "red",
	scratchline = true,
	scratchright = false,
	secondarycolour = "blue",
	stagelight = true
} --[[/data]]

function config:draw(w, h)
	local data = self.data

	sphereElements.addConfigIntroduce()
	just.indent(15)
	just.text("7key1scratch keymode")
	imgui.setSize(w, h, w / 2, 55)
	sphereElements.addConfigBaseSettings(data)
	
	just.indent(15)
	data.scratchright = imgui.checkbox("scratchright", data.scratchright, "Scratch on the right side")
	just.indent(15)
	data.scratchline = imgui.checkbox("scratchline", data.scratchline, "Scratch line")
	
	imgui.separator()
	if imgui.button("Write config file", "Write") then
		self:write()
	end
	data.autosave = imgui.checkbox("autosave", data.autosave, "Autosave")
end

return config
