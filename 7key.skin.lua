local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")
local JustConfig = require("sphere.JustConfig")
local ImageView = require("sphere.views.ImageView")

local root = (...):match("(.+)/.-")
local config = JustConfig:fromFile(root .. "/7key.config.lua")
local functions = require(root .. "/functions")

local noteskin = NoteSkinVsrg({
	name = "Absolute Zero",
	inputMode = "7key",
	range = {-1, 1},
	unit = 1080,
	hitposition = config:get("hitposition") * 1080 / 100,
	config = config,
})

noteskin:setInput({
	"key1",
	"key2",
	"key3",
	"key4",
	"key5",
	"key6",
	"key7",
})

local cs = config:get("columnsize") * noteskin.unit / 400

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = {cs, cs, cs, cs, cs, cs, cs},
	space = {0, 0, 0, 0, 0, 0, 0, 0},
	upscroll = false,
})

functions.setTextures(noteskin)

noteskin:setImagesAuto()

if config:get("pinknotes") then
	noteskin:setShortNote({
		image = {
			"greyshortnote",
			"pinkshortnote",
			"greyshortnote",
			"pinkshortnote",
			"greyshortnote",
			"pinkshortnote",
			"greyshortnote",
		},
		h = cs / 4,
	})

	noteskin:setLongNote({
		head = {
			"greylongnote",
			"pinklongnote",
			"greylongnote",
			"pinklongnote",
			"greylongnote",
			"pinklongnote",
			"greylongnote",
		},
		body = {
			"greylongnotebody",
			"pinklongnotebody",
			"greylongnotebody",
			"pinklongnotebody",
			"greylongnotebody",
			"pinklongnotebody",
			"greylongnotebody",
		},
		tail = {
			"greylongnote",
			"pinklongnote",
			"greylongnote",
			"pinklongnote",
			"greylongnote",
			"pinklongnote",
			"greylongnote",
		},
		h = 1,
	})
else
	noteskin:setShortNote({
		image = {
			"greyshortnote",
			"blueshortnote",
			"greyshortnote",
			"blueshortnote",
			"greyshortnote",
			"blueshortnote",
			"greyshortnote",
		},
		h = cs / 4,
	})

	noteskin:setLongNote({
		head = {
			"greylongnote",
			"bluelongnote",
			"greylongnote",
			"bluelongnote",
			"greylongnote",
			"bluelongnote",
			"greylongnote",
		},
		body = {
			"greylongnotebody",
			"bluelongnotebody",
			"greylongnotebody",
			"bluelongnotebody",
			"greylongnotebody",
			"bluelongnotebody",
			"greylongnotebody",
		},
		tail = {
			"greylongnote",
			"bluelongnote",
			"greylongnote",
			"bluelongnote",
			"greylongnote",
			"bluelongnote",
			"greylongnote",
		},
		h = 1,
	})
end

local playfield = BasePlayfield(noteskin)

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
		"Keys/StaticKey.png",
		"Keys/StaticKey.png",
		"Keys/StaticKey.png",
		"Keys/StaticKey.png",
	},
})

if config:get("stagelight") then
	if config:get("pinknotes") then
		playfield:addKeyImages({
			h = noteskin.unit,
			padding = noteskin.unit - noteskin.hitposition,
			pressed = {
				"Keys/PressedGreyKey.png",
				"Keys/PressedPinkKey.png",
				"Keys/PressedGreyKey.png",
				"Keys/PressedPinkKey.png",
				"Keys/PressedGreyKey.png",
				"Keys/PressedPinkKey.png",
				"Keys/PressedGreyKey.png",
			},
		})
	else
		playfield:addKeyImages({
			h = noteskin.unit,
			padding = noteskin.unit - noteskin.hitposition,
			pressed = {
				"Keys/PressedGreyKey.png",
				"Keys/PressedBlueKey.png",
				"Keys/PressedGreyKey.png",
				"Keys/PressedBlueKey.png",
				"Keys/PressedGreyKey.png",
				"Keys/PressedBlueKey.png",
				"Keys/PressedGreyKey.png",
			},
		})
	end
end

playfield:addNotes()

playfield:addGuidelines({
	y = {0, 0, 0, 0, 0, 0, 0, 0},
	w = {2, 0, 0, 0, 0, 0, 0, 2},
	h = {noteskin.unit, 0, 0, 0, 0, 0, 0, noteskin.unit},
	image = "Other/Pixel.png",
	color = {1,1,1,1},
	both = false,
	mode = "default",
})

if config:get("middleline") then
	playfield:add(ImageView({
		x = playfield.noteskin.columns[4] + cs / 2,
		y = 0,
		w = 1,
		h = noteskin.hitposition,
		color = {0, 0.3, 0.4, 1},
		image = "Other/Pixel.png",
		transform = playfield:newNoteskinTransform(),
	}))
end

playfield:disableCamera()

playfield:addBaseElements({"score", "accuracy", "match players"})

if config:get("combo") then
	functions.addCombo(playfield)
end

if config:get("judgement") then
	functions.addDeltaTimeJudgement(playfield)
end

if config:get("hiterror") then
	functions.addHitError(playfield, cs * 7)
end

if config:get("progress") then
	functions.addPercentProgress(playfield)
end

if config:get("health") then
	functions.addPercentHealth(playfield)
end

return noteskin