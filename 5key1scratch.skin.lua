local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")
local JustConfig = require("sphere.JustConfig")
local ImageView = require("sphere.views.ImageView")

local root = (...):match("(.+)/.-")
local config = JustConfig:fromFile(root .. "/5key1scratch.config.lua")
local functions = require(root .. "/functions")

local noteskin = NoteSkinVsrg({
	name = "Absolute Zero",
	inputMode = "5key1scratch",
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
	"scratch1",
})

local cs = config:get("columnsize") * noteskin.unit / 400

if config:get("scratchright") then
	noteskin:setColumns({
		offset = 0,
		align = "center",
		width = {cs, cs, cs, cs, cs, cs * 1.5},
		space = {1.5 * cs, 0, 0, 0, 0, 0, 0},
		upscroll = false,
	})
else
	noteskin:setColumns({
		offset = 0,
		align = "center",
		width = {cs, cs, cs, cs, cs, cs * 1.5},
		space = {-5 * cs, 0, 0, 0, 0, -6.5 * cs, 0},
		upscroll = false,
	})
end

functions.setTextures(noteskin)

noteskin:setImagesAuto()

if config:get("pinknotes") then
	noteskin:setShortNote({
		image = {
			"pinkshortnote",
			"greyshortnote",
			"pinkshortnote",
			"greyshortnote",
			"pinkshortnote",
			"longredshortnote",
		},
		h = cs / 4,
	})

	noteskin:setLongNote({
		head = {
			"pinklongnote",
			"greylongnote",
			"pinklongnote",
			"greylongnote",
			"pinklongnote",
			"longredlongnote",
		},
		body = {
			"pinklongnotebody",
			"greylongnotebody",
			"pinklongnotebody",
			"greylongnotebody",
			"pinklongnotebody",
			"longredlongnotebody",
		},
		tail = {
			"pinklongnote",
			"greylongnote",
			"pinklongnote",
			"greylongnote",
			"pinklongnote",
			"longredlongnote",
		},
		h = 1,
	})
else
	noteskin:setShortNote({
		image = {
			"blueshortnote",
			"greyshortnote",
			"blueshortnote",
			"greyshortnote",
			"blueshortnote",
			"longredshortnote",
		},
		h = cs / 4,
	})

	noteskin:setLongNote({
		head = {
			"bluelongnote",
			"greylongnote",
			"bluelongnote",
			"greylongnote",
			"bluelongnote",
			"longredlongnote",
		},
		body = {
			"bluelongnotebody",
			"greylongnotebody",
			"bluelongnotebody",
			"greylongnotebody",
			"bluelongnotebody",
			"longredlongnotebody",
		},
		tail = {
			"bluelongnote",
			"greylongnote",
			"bluelongnote",
			"greylongnote",
			"bluelongnote",
			"longredlongnote",
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
	},
})

if config:get("stagelight") then
	if config:get("pinknotes") then
		playfield:addKeyImages({
			h = noteskin.unit,
			padding = noteskin.unit - noteskin.hitposition,
			pressed = {
				"Keys/PressedPinkKey.png",
				"Keys/PressedGreyKey.png",
				"Keys/PressedPinkKey.png",
				"Keys/PressedGreyKey.png",
				"Keys/PressedPinkKey.png",
				"Keys/PressedRedKey.png",
			},
		})
	else
		playfield:addKeyImages({
			h = noteskin.unit,
			padding = noteskin.unit - noteskin.hitposition,
			pressed = {
				"Keys/PressedBlueKey.png",
				"Keys/PressedGreyKey.png",
				"Keys/PressedBlueKey.png",
				"Keys/PressedGreyKey.png",
				"Keys/PressedBlueKey.png",
				"Keys/PressedRedKey.png",
			},
		})
	end
end

playfield:addNotes()

--left line
if config:get("scratchright") then
	playfield:add(ImageView({
		x = playfield.noteskin.columns[1],
		y = 0,
		w = 2,
		h = noteskin.unit,
		color = {1, 1, 1, 1},
		image = "Other/Pixel.png",
		transform = playfield:newNoteskinTransform(),
	}))
else
	playfield:add(ImageView({
		x = playfield.noteskin.columns[6],
		y = 0,
		w = 2,
		h = noteskin.unit,
		color = {1, 1, 1, 1},
		image = "Other/Pixel.png",
		transform = playfield:newNoteskinTransform(),
	}))
end

--right line
if config:get("scratchright")then
	playfield:add(ImageView({
		x = playfield.noteskin.columns[6] + (1.5 * cs),
		y = 0,
		w = 2,
		h = noteskin.unit,
		color = {1, 1, 1, 1},
		image = "Other/Pixel.png",
		transform = playfield:newNoteskinTransform(),
	}))
else
	playfield:add(ImageView({
		x = playfield.noteskin.columns[5] + cs,
		y = 0,
		w = 2,
		h = noteskin.unit,
		color = {1, 1, 1, 1},
		image = "Other/Pixel.png",
		transform = playfield:newNoteskinTransform(),
	}))
end

--middle line
if config:get("middleline") then
	playfield:add(ImageView({
		x = playfield.noteskin.columns[3] + cs / 2,
		y = 0,
		w = 1,
		h = noteskin.hitposition,
		color = {0, 0.3, 0.4, 1},
		image = "Other/Pixel.png",
		transform = playfield:newNoteskinTransform(),
	}))
end

--scratch line
if config:get("scratchline") then
	if config:get("scratchright") then
		playfield:add(ImageView({
			x = playfield.noteskin.columns[6],
			y = 0,
			w = 1,
			h = noteskin.hitposition,
			color = {0.75, 0.2, 0, 1},
			image = "Other/Pixel.png",
			transform = playfield:newNoteskinTransform(),
		}))
	else
		playfield:add(ImageView({
			x = playfield.noteskin.columns[1],
			y = 0,
			w = 1,
			h = noteskin.hitposition,
			color = {0.75, 0.2, 0, 1},
			image = "Other/Pixel.png",
			transform = playfield:newNoteskinTransform(),
		}))
	end
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
	functions.addHitError(playfield, cs * 5)
end

if config:get("progress") then
	functions.addPercentProgress(playfield)
end

if config:get("health") then
	functions.addPercentHealth(playfield)
end

return noteskin