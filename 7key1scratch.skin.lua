local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")
local JustConfig = require("sphere.JustConfig")
local ImageView = require("sphere.views.ImageView")

local root = (...):match("(.+)/.-")
local config = JustConfig:fromFile(root .. "/Configs/7key1scratch.config.lua")
local sphereElements = require(root .. "/Modules/sphereElements")
local fieldElements = require(root .. "/Modules/FieldElements")

local noteskin = NoteSkinVsrg({
	name = "Absolute Zero",
	inputMode = "7key1scratch",
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
	"scratch1",
})

local cs = config:get("columnsize") * noteskin.unit / 400

if config:get("scratchside") == "right" then
	noteskin:setColumns({
		offset = 0,
		align = "center",
		width = {cs, cs, cs, cs, cs, cs, cs, cs * 1.5},
		space = {1.5 * cs, 0, 0, 0, 0, 0, 0, 0, 0},
		upscroll = false,
	})
else
	noteskin:setColumns({
		offset = 0,
		align = "center",
		width = {cs, cs, cs, cs, cs, cs, cs, cs * 1.5},
		space = {-7 * cs, 0, 0, 0, 0, 0, 0, -8.5 * cs, 0},
		upscroll = false,
	})
end

sphereElements.setTextures(noteskin)

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
			"longredshortnote",
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
			"longredlongnote",
		},
		body = {
			"greylongnotebody",
			"pinklongnotebody",
			"greylongnotebody",
			"pinklongnotebody",
			"greylongnotebody",
			"pinklongnotebody",
			"greylongnotebody",
			"longredlongnotebody",
		},
		tail = {
			"greylongnote",
			"pinklongnote",
			"greylongnote",
			"pinklongnote",
			"greylongnote",
			"pinklongnote",
			"greylongnote",
			"longredlongnote",
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
			"longredshortnote",
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
			"longredlongnote",
		},
		body = {
			"greylongnotebody",
			"bluelongnotebody",
			"greylongnotebody",
			"bluelongnotebody",
			"greylongnotebody",
			"bluelongnotebody",
			"greylongnotebody",
			"longredlongnotebody",
		},
		tail = {
			"greylongnote",
			"bluelongnote",
			"greylongnote",
			"bluelongnote",
			"greylongnote",
			"bluelongnote",
			"greylongnote",
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
				"Keys/PressedRedKey.png",
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
				"Keys/PressedRedKey.png",
			},
		})
	end
end

playfield:addNotes()

--left line
if config:get("scratchside") == "right" then
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
		x = playfield.noteskin.columns[8],
		y = 0,
		w = 2,
		h = noteskin.unit,
		color = {1, 1, 1, 1},
		image = "Other/Pixel.png",
		transform = playfield:newNoteskinTransform(),
	}))
end

--right line
if config:get("scratchside") == "right" then
	playfield:add(ImageView({
		x = playfield.noteskin.columns[8] + (1.5 * cs),
		y = 0,
		w = 2,
		h = noteskin.unit,
		color = {1, 1, 1, 1},
		image = "Other/Pixel.png",
		transform = playfield:newNoteskinTransform(),
	}))
else
	playfield:add(ImageView({
		x = playfield.noteskin.columns[7] + cs,
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
		x = playfield.noteskin.columns[4] + cs / 2,
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
	if config:get("scratchside") == "right" then
		playfield:add(ImageView({
			x = playfield.noteskin.columns[8],
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
	sphereElements.addCombo(playfield)
end

if config:get("judgement") then
	sphereElements.addDeltaTimeJudgement(playfield)
end

if config:get("hiterror") then
	sphereElements.addHitError(playfield, cs * 7)
end

if config:get("progress") then
	fieldElements.addPercentProgress(playfield)
end

if config:get("health") then
	fieldElements.addPercentHealth(playfield)
end

return noteskin