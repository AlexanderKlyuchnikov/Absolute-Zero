local JustConfig = require("sphere.JustConfig")
local imgui = require("imgui")
local just = require("just")
local config = JustConfig()
config.w = 550
config.h = 700
local root = (...):match("(.+)/.-")
local functions = require(root .. "/functions")

config.data = --[[data]] {
	autosave = true,
	columnsize = 32,
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
	pinknotes = false,
	playfieldblackout = 100,
	progress = true,
	progressposition = 50,
	stagelight = true
} --[[/data]]

function config:draw(w, h)
	local data = self.data

	functions.addConfigIntroduce()
	just.indent(15)
	just.text("7key keymode")
	imgui.setSize(w, h, w / 2, 55)
	functions.addConfigBaseSettings(data)
	
	imgui.separator()
	if imgui.button("Write config file", "Write") then
		self:write()
	end
	data.autosave = imgui.checkbox("autosave", data.autosave, "Autosave")
end

return config
