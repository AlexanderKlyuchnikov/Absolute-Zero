local gfx_util = require("gfx_util")
local math = require("math")
local spherefonts = require("sphere.assets.fonts")
local root = (...):match("^(.+)/(.-)/(.-)$")

local function addPercentProgress(playfield)
	playfield:add({
		draw = function(self)
			local tf = gfx_util.transform(playfield:newLaneCenterTransform(1080))
			love.graphics.replaceTransform(tf)
			local minTime = self.game.rhythmModel.timeEngine.minTime
			if minTime == nil then
				return
			end
			local maxTime = self.game.rhythmModel.timeEngine.maxTime
			local currentTime = self.game.rhythmModel.timeEngine.currentTime
			local value = math.floor((currentTime - minTime) * 100 / (maxTime - minTime)) 
			if value < 0 or value > 99 then
				love.graphics.setColor(0.85, 0.3, 1, 1)
			else
				love.graphics.setColor(0.6, 0.2, 1, 1)
			end
			love.graphics.setFont(spherefonts.get(root .. "/Other/Calibri.ttf", 30))
			gfx_util.printBaseline(
				tostring(value) .. "%",
				-540,
				playfield.noteskin.config:get("progressposition") * 1080 / 100,
				1080,
				1,
				"center"
			)
		end
	})
end

local function addPercentHealth(playfield)
	playfield:add({
		draw = function(self)
			local tf = gfx_util.transform(playfield:newLaneCenterTransform(1080))
			love.graphics.replaceTransform(tf)
			local sshp = self.game.rhythmModel.scoreEngine.scoreSystem.hp
			if sshp == nil then
				return
			end
			local currentHp = sshp:getCurrent()
			local maxHp = sshp.max
			local value = math.ceil(currentHp* 100 / maxHp)
			if value > 0 then
				love.graphics.setColor(0, 1, 0, 1)
			else
				love.graphics.setColor(0, 0.5, 0, 1)
			end
			love.graphics.setFont(spherefonts.get(root .. "/Other/Calibri.ttf", 30))
			gfx_util.printBaseline(
				tostring(value) .. "%",
				-540,
				playfield.noteskin.config:get("healthposition") * 1080 / 100,
				1080,
				1,
				"center"
			)
		end
	})
end

local functions = {
	addPercentProgress = addPercentProgress,
	addPercentHealth = addPercentHealth,
}

return functions