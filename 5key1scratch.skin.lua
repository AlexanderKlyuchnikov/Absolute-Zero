local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")
local JustConfig = require("sphere.JustConfig")
local ImageView = require("sphere.views.ImageView")

local root = (...):match("(.+)/.-")
local config = JustConfig:fromFile(root .. "/Configs/5key1scratch.config.lua")
local sphereElements = require(root .. "/Modules/sphereElements")
local fieldElements = require(root .. "/Modules/FieldElements")
local textures = require(root .. "/Modules/Textures")

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

if config:get("scratchside") == "right" then
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

textures.setTextures(noteskin)

noteskin:setImagesAuto()

noteskin:setShortNote({
	image = {
		textures.colourshortnote[config:get("secondarycolour")],
		textures.colourshortnote[config:get("primarycolour")],
		textures.colourshortnote[config:get("secondarycolour")],
		textures.colourshortnote[config:get("primarycolour")],
		textures.colourshortnote[config:get("secondarycolour")],
		textures.longcolourshortnote[config:get("scratchcolour")]
	},
	h = cs / 4,
})

noteskin:setLongNote({
	head = {
		textures.colourlongnote[config:get("secondarycolour")],
		textures.colourlongnote[config:get("primarycolour")],
		textures.colourlongnote[config:get("secondarycolour")],
		textures.colourlongnote[config:get("primarycolour")],
		textures.colourlongnote[config:get("secondarycolour")],
		textures.longcolourlongnote[config:get("scratchcolour")]
	},
	body = {
		textures.colourlongnotebody[config:get("secondarycolour")],
		textures.colourlongnotebody[config:get("primarycolour")],
		textures.colourlongnotebody[config:get("secondarycolour")],
		textures.colourlongnotebody[config:get("primarycolour")],
		textures.colourlongnotebody[config:get("secondarycolour")],
		textures.longcolourlongnotebody[config:get("scratchcolour")]
	},
	tail = {
		textures.colourlongnote[config:get("secondarycolour")],
		textures.colourlongnote[config:get("primarycolour")],
		textures.colourlongnote[config:get("secondarycolour")],
		textures.colourlongnote[config:get("primarycolour")],
		textures.colourlongnote[config:get("secondarycolour")],
		textures.longcolourlongnote[config:get("scratchcolour")]
	},
	h = 1,
})

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
	playfield:addKeyImages({
		h = noteskin.unit,
		padding = noteskin.unit - noteskin.hitposition,
		pressed = {
			textures.pressedkeycolour[config:get("secondarycolour")],
			textures.pressedkeycolour[config:get("primarycolour")],
			textures.pressedkeycolour[config:get("secondarycolour")],
			textures.pressedkeycolour[config:get("primarycolour")],
			textures.pressedkeycolour[config:get("secondarycolour")],
			textures.pressedkeycolour[config:get("scratchcolour")],
		},
	})
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
if config:get("scratchside") == "right" then
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
		color = textures.colourtable[config:get("secondarycolour")],
		image = "Other/Pixel.png",
		transform = playfield:newNoteskinTransform(),
	}))
end

--scratch line
if config:get("scratchline") then
	if config:get("scratchside") == "right" then
		playfield:add(ImageView({
			x = playfield.noteskin.columns[6],
			y = 0,
			w = 1,
			h = noteskin.hitposition,
			color = textures.colourtable[config:get("scratchcolour")],
			image = "Other/Pixel.png",
			transform = playfield:newNoteskinTransform(),
		}))
	else
		playfield:add(ImageView({
			x = playfield.noteskin.columns[1],
			y = 0,
			w = 1,
			h = noteskin.hitposition,
			color = textures.colourtable[config:get("scratchcolour")],
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
	sphereElements.addHitError(playfield, cs * 5)
end

if config:get("progress") then
	fieldElements.addPercentProgress(playfield)
end

if config:get("health") then
	fieldElements.addPercentHealth(playfield)
end

return noteskin