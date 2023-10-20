local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")
local JustConfig = require("sphere.JustConfig")
local ImageView = require("sphere.views.ImageView")

local root = (...):match("(.+)/.-")
local config = JustConfig:fromFile(root .. "/Configs/1keyto4.config.lua")
local sphereElements = require(root .. "/Modules/SphereElements")
local fieldElements = require(root .. "/Modules/FieldElements")
local textures = require(root .. "/Modules/Textures")

local noteskin = NoteSkinVsrg({
	name = "Absolute Zero 1 to 4",
	inputMode = "1key",
	range = {-1, 1},
	unit = 1080,
	hitposition = config:get("hitposition") * 1080 / 100,
	config = config,
})

noteskin:setInput({
	"key1",
})

local cs = config:get("columnsize") * noteskin.unit / 400

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = {cs * 4},
	space = {0, 0},
	upscroll = false,
})

textures.setTextures(noteskin)

noteskin.timetable = {}
noteskin.notetable = {}

local playfield = BasePlayfield(noteskin)

playfield:add({load = function(self) 
	for _, layerdata in self.game.rhythmModel.graphicEngine.noteChart:getLayerDataIterator() do
		for _, notedata in ipairs(layerdata:getNoteDatasList("key", 1)) do
			noteskin.timetable[#noteskin.timetable + 1]
				= notedata.timePoint.absoluteTime
		end
	end
	table.sort(noteskin.timetable)
	for i, time in ipairs(noteskin.timetable) do
		noteskin.notetable[time] = i
	end
end})

local function GetSide(noteView)
	local num = noteskin.notetable[noteView.graphicalNote.startNoteData.timePoint.absoluteTime]
	return num % 4
end

noteskin:setImagesAuto()

noteskin:setShortNote({
	image = {
		function(_, noteView, column)
			if GetSide(noteView) == 0 then
				return "_2to4_WSN_sleft"
			elseif GetSide(noteView) == 1 then
				return "_2to4_RSN_middle_left"
			elseif GetSide(noteView) == 2 then
				return "_2to4_WSN_sright"
			else
				return "_2to4_RSN_middle_right"
			end
		end,
	},
	h = cs / 4,
})

noteskin:setLongNote({
	head = {
		function(_, noteView, column)
			if GetSide(noteView) == 0 then
				return "_2to4_WLN_sleft"
			elseif GetSide(noteView) == 1 then
				return "_2to4_RLN_middle_left"
			elseif GetSide(noteView) == 2 then
				return "_2to4_WLN_sright"
			else
				return "_2to4_RLN_middle_right"
			end
		end,
	},
	body = {
		function(_, noteView, column)
			if GetSide(noteView) == 0 then
				return "_2to4_WLNB_sleft"
			elseif GetSide(noteView) == 1 then
				return "_2to4_RLNB_middle_left"
			elseif GetSide(noteView) == 2 then
				return "_2to4_WLNB_sright"
			else
				return "_2to4_RLNB_middle_right"
			end
		end,
	},
	tail = {
		function(_, noteView, column)
			if GetSide(noteView) == 0 then
				return "_2to4_WLN_sleft"
			elseif GetSide(noteView) == 1 then
				return "_2to4_RLN_middle_left"
			elseif GetSide(noteView) == 2 then
				return "_2to4_WLN_sright"
			else
				return "_2to4_RLN_middle_right"
			end
		end,
	},
	h = 1,
})

playfield:addBga({
	transform = {{1 / 2, -16 / 9 / 2}, {0, -7 / 9 / 2}, 0, {0, 16 / 9}, {0, 16 / 9}, 0, 0, 0, 0}
})

playfield:enableCamera()

playfield:addColumnsBackground({
	color = {0, 0, 0, config:get("playfieldblackout") / 100},
})

playfield:addStaticKeyImages({
	h = noteskin.unit - noteskin.hitposition,
	padding = 0,
	image = {
		"Keys/StaticKey.png",
	},
})

playfield:addNotes()

playfield:addGuidelines({
	y = {0, 0},
	w = {2, 2},
	h = {noteskin.unit, noteskin.unit},
	image = "Other/Pixel.png",
	color = {1,1,1,1},
	both = false,
	mode = "default",
})

playfield:disableCamera()

playfield:addBaseElements({"score", "accuracy", "match players"})

if config:get("combo") then
	sphereElements.addCombo(playfield)
end

if config:get("judgement") then
	sphereElements.addDeltaTimeJudgement(playfield)
end

if config:get("hiterror") then
	sphereElements.addHitError(playfield, cs * 4)
end

if config:get("progress") then
	fieldElements.addPercentProgress(playfield)
end

if config:get("health") then
	fieldElements.addPercentHealth(playfield)
end

return noteskin