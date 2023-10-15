local NoteSkinVsrg = require("sphere.models.NoteSkinModel.NoteSkinVsrg")
local BasePlayfield = require("sphere.models.NoteSkinModel.BasePlayfield")
local JustConfig = require("sphere.JustConfig")

local root = (...):match("(.+)/.-")
local config = JustConfig:fromFile(root .. "/Configs/6key.config.lua")
local sphereElements = require(root .. "/Modules/sphereElements")
local fieldElements = require(root .. "/Modules/FieldElements")
local textures = require(root .. "/Modules/Textures")

local noteskin = NoteSkinVsrg({
	name = "Absolute Zero",
	inputMode = "6key",
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
})

local cs = config:get("columnsize") * noteskin.unit / 400

noteskin:setColumns({
	offset = 0,
	align = "center",
	width = {cs, cs, cs, cs, cs, cs},
	space = {0, 0, 0, 0, 0, 0, 0},
	upscroll = false,
})

textures.setTextures(noteskin)

noteskin:setImagesAuto()

noteskin:setShortNote({
	image = {
		textures.colourshortnote[config:get("secondarycolour")],
		textures.colourshortnote[config:get("primarycolour")],
		textures.colourshortnote[config:get("secondarycolour")],
		textures.colourshortnote[config:get("secondarycolour")],
		textures.colourshortnote[config:get("primarycolour")],
		textures.colourshortnote[config:get("secondarycolour")],
	},
	h = cs / 4,
})

noteskin:setLongNote({
	head = {
		textures.colourlongnote[config:get("secondarycolour")],
		textures.colourlongnote[config:get("primarycolour")],
		textures.colourlongnote[config:get("secondarycolour")],
		textures.colourlongnote[config:get("secondarycolour")],
		textures.colourlongnote[config:get("primarycolour")],
		textures.colourlongnote[config:get("secondarycolour")],
	},
	body = {
		textures.colourlongnotebody[config:get("secondarycolour")],
		textures.colourlongnotebody[config:get("primarycolour")],
		textures.colourlongnotebody[config:get("secondarycolour")],
		textures.colourlongnotebody[config:get("secondarycolour")],
		textures.colourlongnotebody[config:get("primarycolour")],
		textures.colourlongnotebody[config:get("secondarycolour")],
	},
	tail = {
		textures.colourlongnote[config:get("secondarycolour")],
		textures.colourlongnote[config:get("primarycolour")],
		textures.colourlongnote[config:get("secondarycolour")],
		textures.colourlongnote[config:get("secondarycolour")],
		textures.colourlongnote[config:get("primarycolour")],
		textures.colourlongnote[config:get("secondarycolour")],
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
			textures.pressedkeycolour[config:get("secondarycolour")],
			textures.pressedkeycolour[config:get("primarycolour")],
			textures.pressedkeycolour[config:get("secondarycolour")],
		},
	})
end

playfield:addNotes()

playfield:addGuidelines({
	y = {0, 0, 0, 0, 0, 0, 0},
	w = {2, 0, 0, 0, 0, 0, 2},
	h = {noteskin.unit, 0, 0, 0, 0, 0, noteskin.unit},
	image = "Other/Pixel.png",
	color = {1,1,1,1},
	both = false,
	mode = "default",
})

if config:get("middleline") then
	playfield:addGuidelines({
		y = {0, 0, 0, 0, 0, 0, 0},
		w = {0, 0, 0, 1, 0, 0, 0},
		h = {0, 0, 0, noteskin.hitposition, 0, 0, 0},
		image = "Other/Pixel.png",
		color = textures.colourtable[config:get("secondarycolour")],
		both = false,
		mode = "default",
	})
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