local just = require("just")
local TextCellImView = require("sphere.imviews.TextCellImView")
local StepperView = require("sphere.views.StepperView")
local spherefonts = require("sphere.assets.fonts")
local gfx_util = require("gfx_util")

local function StringStepper(id, value, valset, label)

    local function Getelemindex(elem)
		for i, currentValue in ipairs(valset) do
			if elem == currentValue then
				return i
			end
		end
	end

    local w = 500
    local result = value
    local w2 = w / 2
	just.row(true)
	just.indent(15)
	TextCellImView(w2, 72, "center", "", value)
	just.indent(-w2)
	local elemindex = Getelemindex(value)
	local count = #valset
	local overAll, overLeft, overRight = StepperView:isOver(w2, 72)
	local delta = just.wheel_over(id .. "A", overAll)
	local changedLeft = just.button(id .. "L", overLeft)
	local changedRight = just.button(id .. "R", overRight)
	if changedLeft or delta == -1 then
		if elemindex > 1 then
			result = valset[elemindex - 1]
		end
	elseif changedRight or delta == 1 then
        if elemindex < count then
			result = valset[elemindex + 1]
        end
	end
	StepperView:draw(w2, 72, elemindex, count)
    
	local x = w2 + 15
	love.graphics.setFont(spherefonts.get("Noto Sans", 24))
	gfx_util.printBaseline(tostring(label), x, 45, w, 1, "left")
	just.next(w, 72)

    just.row()
    
    return result
end

local configElements =
{
    StringStepper = StringStepper
}

return configElements