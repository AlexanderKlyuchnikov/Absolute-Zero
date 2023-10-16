local just = require("just")
local imgui = require("imgui")
local TextCellImView = require("sphere.imviews.TextCellImView")
local StepperView = require("sphere.views.StepperView")
local spherefonts = require("sphere.assets.fonts")
local gfx_util = require("gfx_util")
local math_util = require("math_util")

local _w = 550 / 2
local _h = 55

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

---@param id any
---@param v number
---@param format string
---@param a number
---@param b number
---@param c number
---@param label string?
---@return number
local function Cutslider(id, v, format, a, b, c, label)
	local delta = just.wheel_over(id, just.is_over(_w, _h))
	if delta then
		v = math.min(math.max(v + c * delta, a), b)
	end

	local _v = math_util.map(v, a, b, 0, 1)
	local dispval = format:format(v)
	_v = imgui.Slider(id, _v, _w, _h, string.sub(dispval, 0, #dispval - 5)) or _v
	just.sameline()
	imgui.label(id .. "label", label)

	v = math_util.map(_v, 0, 1, a, b)
	v = math_util.round(v, c)

	return v
end
local configElements =
{
    StringStepper = StringStepper,
	Cutslider = Cutslider
}

return configElements