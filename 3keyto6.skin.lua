local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")
local JustConfig = require("sphere.JustConfig")
local ImageView = require("sphere.views.ImageView")

local root = (...):match("(.+)/.-")
local config = JustConfig:fromFile(root .. "/Configs/3keyto6.config.lua")
local sphereElements = require(root .. "/Modules/sphereElements")
local fieldElements = require(root .. "/Modules/FieldElements")
local textures = require(root .. "/Modules/Textures")

local noteskin = NoteSkinVsrg({
	name = "Absolute Zero 3 to 6",
	inputMode = "3key",
	range = {-1, 1},
	unit = 1080,
	hitposition = config:get("hitposition") * 1080 / 100,
	config = config,
})

noteskin:setInput({
	"key1",
	"key2",
	"key3",
})

local cs = config:get("columnsize") * noteskin.unit / 400

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = {cs * 4, cs * 4, cs * 4},
	space = {0, -cs * 3, -cs * 3, 0},
	upscroll = false,
})

textures.setTextures(noteskin)

noteskin.timetable1 = {}
noteskin.timetable2 = {}
noteskin.timetable3 = {}
noteskin.notetable1 = {}
noteskin.notetable2 = {}
noteskin.notetable3 = {}

local playfield = BasePlayfield(noteskin)

playfield:add({load = function(self) 
	for _, layerdata in self.game.rhythmModel.graphicEngine.noteChart:getLayerDataIterator() do
		for _, notedata in ipairs(layerdata:getNoteDatasList("key", 1)) do
			noteskin.timetable1[#noteskin.timetable1 + 1]
				= notedata.timePoint.absoluteTime
		end
		for _, notedata in ipairs(layerdata:getNoteDatasList("key", 2)) do
			noteskin.timetable2[#noteskin.timetable2 + 1]
				= notedata.timePoint.absoluteTime
		end
		for _, notedata in ipairs(layerdata:getNoteDatasList("key", 3)) do
			noteskin.timetable3[#noteskin.timetable3 + 1]
				= notedata.timePoint.absoluteTime
		end
	end
	table.sort(noteskin.timetable1)
	table.sort(noteskin.timetable2)
	table.sort(noteskin.timetable3)
	for i, time in ipairs(noteskin.timetable1) do
		noteskin.notetable1[time] = i
	end
	for i, time in ipairs(noteskin.timetable2) do
		noteskin.notetable2[time] = i
	end
	for i, time in ipairs(noteskin.timetable3) do
		noteskin.notetable3[time] = i
	end
end})

local function GetSide1(noteView)
	local num = noteskin.notetable1[noteView.graphicalNote.startNoteData.timePoint.absoluteTime]
	return num % 2
end

local function GetSide2(noteView)
	local num = noteskin.notetable2[noteView.graphicalNote.startNoteData.timePoint.absoluteTime]
	return num % 2
end

local function GetSide3(noteView)
	local num = noteskin.notetable3[noteView.graphicalNote.startNoteData.timePoint.absoluteTime]
	return num % 2
end

noteskin:setImagesAuto()

noteskin:setShortNote({
	image = function(_, noteView, column)
		if column == 1 then
			if GetSide1(noteView) == 0 then
				return "_2to4_RSN_sleft"
			else
				return "_2to4_RSN_sright"
			end
		elseif column == 2 then
			if GetSide2(noteView) == 0 then
				return "_2to4_WSN_sleft"
			else
				return "_2to4_WSN_sright"
			end
		else
			if GetSide3(noteView) == 0 then
				return "_2to4_RSN_sleft"
			else
				return "_2to4_RSN_sright"
			end
		end
	end,
	h = cs / 4,
})

noteskin:setLongNote({
	head = function(_, noteView, column)
		if column == 1 then
			if GetSide1(noteView) == 0 then
				return "_2to4_RLN_sleft"
			else
				return "_2to4_RLN_sright"
			end
		elseif column == 2 then
			if GetSide2(noteView) == 0 then
				return "_2to4_WLN_sleft"
			else
				return "_2to4_WLN_sright"
			end
		else
			if GetSide3(noteView) == 0 then
				return "_2to4_RLN_sleft"
			else
				return "_2to4_RLN_sright"
			end
		end
	end,
	body = function(_, noteView, column)
		if column == 1 then
			if GetSide1(noteView) == 0 then
				return "_2to4_RLNB_sleft"
			else
				return "_2to4_RLNB_sright"
			end
		elseif column == 2 then
			if GetSide2(noteView) == 0 then
				return "_2to4_WLNB_sleft"
			else
				return "_2to4_WLNB_sright"
			end
		else
			if GetSide3(noteView) == 0 then
				return "_2to4_RLNB_sleft"
			else
				return "_2to4_RLNB_sright"
			end
		end
	end,
	tail = function(_, noteView, column)
		if column == 1 then
			if GetSide1(noteView) == 0 then
				return "_2to4_RLN_sleft"
			else
				return "_2to4_RLN_sright"
			end
		elseif column == 2 then
			if GetSide2(noteView) == 0 then
				return "_2to4_WLN_sleft"
			else
				return "_2to4_WLN_sright"
			end
		else
			if GetSide3(noteView) == 0 then
				return "_2to4_RLN_sleft"
			else
				return "_2to4_RLN_sright"
			end
		end
	end,
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
		"Keys/StaticKey.png",
		"Keys/StaticKey.png",
	},
})

playfield:addNotes()

playfield:addGuidelines({
	y = {0, 0, 0, 0},
	w = {2, 0, 0, 2},
	h = {noteskin.unit, 0, 0, noteskin.unit},
	image = "Other/Pixel.png",
	color = {1,1,1,1},
	both = false,
	mode = "default",
})

if config:get("middleline") then
	playfield:add(ImageView({
		x = playfield.noteskin.columns[2] + cs * 2,
		y = 0,
		w = 1,
		h = noteskin.hitposition,
		color = textures.colourtable["red"],
		image = "Other/Pixel.png",
		transform = playfield:newNoteskinTransform(),
	}))
end

playfield:disableCamera()

playfield:addBaseElements({"score", "accuracy", "match players"})

if config:get("combo") then
	sphereElements.addCombo(playfield)
end

if config:get("judgement") then
	sphereElements.addDeltaTimeJudgement(playfield)
end

if config:get("hiterror") then
	sphereElements.addHitError(playfield, cs * 6)
end

if config:get("progress") then
	fieldElements.addPercentProgress(playfield)
end

if config:get("health") then
	fieldElements.addPercentHealth(playfield)
end

return noteskin