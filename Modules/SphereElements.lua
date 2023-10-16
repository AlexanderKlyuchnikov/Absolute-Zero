local imgui = require("imgui")
local just = require("just")
local root = (...):match("^(.+)/(.-)/(.-)$")
local configElements = require(root .. "/Modules/ConfigElements")
local colourset = {"white", "blue", "yellow", "red", "violet", "pink", "orange", "cyan",  "green", "grey", "black"}
local scratchsideset = {"left", "right"}

local function addConfigIntroduce()
	just.indent(15)
	just.text("Absolute Zero")
	just.indent(15)
	just.text("Skin by KLV")
end

local function addBaseSettings(data)
	just.indent(15)
	data.hitposition = configElements.Cutslider("hitposition", data.hitposition, "%f", 0, 100, 0.1, "Hit position")
	just.indent(15)
	data.columnsize = configElements.Cutslider("columnsize", data.columnsize, "%f", 0, 100, 0.1, "Column size")
	just.indent(15)
	data.playfieldblackout = configElements.Cutslider("playfieldblackout", data.playfieldblackout, "%f", 0, 100, 0.1, "Playfield blackout")
	just.indent(15)
end

local function addSratchsideSettings(data)
	data.scratchside = configElements.StringStepper("scratchside", data.scratchside, scratchsideset, "Scratch side")
	just.indent(15)
end

local function addColourSettings(data)
	data.primarycolour = configElements.StringStepper("primarycolour", data.primarycolour, colourset, "Primary colour")
	just.indent(15)
	data.secondarycolour = configElements.StringStepper("secondarycolour", data.secondarycolour, colourset, "Secondary colour")
	just.indent(15)
end

local function addSingleColourSettings(data)
	data.primarycolour = configElements.StringStepper("primarycolour", data.primarycolour, colourset, "Primary colour")
	just.indent(15)
end

local function addScratchColourSettings(data)
	data.scratchcolour = configElements.StringStepper("scratchcolour", data.scratchcolour, colourset, "Scratch colour")
	just.indent(15)
end

local function addPlayfieldElementsSettings(data)
	data.stagelight = imgui.checkbox("stagelight", data.stagelight, "Stage light")
	just.indent(15)
	data.middleline = imgui.checkbox("middleline", data.middleline, "Middle line")
	just.indent(15)
	data.judgement = imgui.checkbox("judgement", data.judgement, "Judgement")
	just.indent(15)
	data.judgementposition = configElements.Cutslider("judgementposition", data.judgementposition, "%f", 0, 100, 0.1, "Judgement position")
	just.indent(15)
	data.hiterror = imgui.checkbox("hiterror", data.hiterror, "HitError")
	just.indent(15)
	data.hiterrorposition = configElements.Cutslider("hiterrorposition", data.hiterrorposition, "%f", 0, 100, 0.1, "HitError position")
	just.indent(15)
	data.combo = imgui.checkbox("combo", data.combo, "Combo")
	just.indent(15)
	data.comboposition = configElements.Cutslider("comboposition", data.comboposition, "%f", 0, 100, 0.1, "Combo position")
	just.indent(15)
	data.progress = imgui.checkbox("progress", data.progress, "Progress")
	just.indent(15)
	data.progressposition = configElements.Cutslider("progressposition", data.progressposition, "%f", 0, 100, 0.1, "Progress position")
	just.indent(15)
	data.health = imgui.checkbox("health", data.health, "Health")
	just.indent(15)
	data.healthposition = configElements.Cutslider("healthposition", data.healthposition, "%f", 0, 100, 1, "Health position")
end

local function addConfigBaseSettings(data)
	addBaseSettings(data)
	addColourSettings(data)
	addPlayfieldElementsSettings(data)
end

local function addConfig1keySettings(data)
	addBaseSettings(data)
	addSingleColourSettings(data)
	addPlayfieldElementsSettings(data)
end

local function addConfigScratchSettings(data)
	addBaseSettings(data)
	addSratchsideSettings(data)
	addColourSettings(data)
	addScratchColourSettings(data)
	addPlayfieldElementsSettings(data)
end

local function addDeltaTimeJudgement(playfield)
	playfield:addDeltaTimeJudgement({
		x = 0, 
		y =  playfield.noteskin.config:get("judgementposition") * 2700 / 100, 
		ox = 0.5, 
		oy = 0.5,
		rate = 1,
		transform = playfield:newLaneCenterTransform(2700),
		judgements = {
			"Judgements/Miss.png",
			-0.12,
			"Judgements/NotPerfect3.png",
			-0.0747,
			"Judgements/NotPerfect2.png",
			-0.04,
			"Judgements/NotPerfect1.png",
			-0.016,
			"Judgements/Perfect.png",
			-0.0027,
			"Judgements/Perfectg.png",
			0.0027,
			"Judgements/Perfect.png",
			0.016,
			"Judgements/NotPerfect1.png",
			0.04,
			"Judgements/NotPerfect2.png",
			0.0747,
			"Judgements/NotPerfect3.png",
			0.12,
			"Judgements/Miss.png",
		}
	})
end

local function addCombo(playfield)
	playfield:addCombo({
		x = -540,
		baseline = playfield.noteskin.config:get("comboposition") * 1080 / 100,
		limit = 1080,
		align = "center",
		font = {
			filename = root .. "/Other/Calibri.ttf",
			size = 150
		},
		transform = playfield:newLaneCenterTransform(1080),
		color = {1, 1, 1, 1},
	})
end

local function hitcolor(value, unit)	
    if value < -0.12 then
        return {1, 0.1, 0.1, 1}
    elseif value < -0.0747 then
        return {1, 0.46, 0.18, 1}
    elseif value < -0.04 then
        return {1, 0.72, 0.17, 1}
    elseif value < -0.016 then
        return {1, 1, 0.16, 1}
    elseif value < -0.0027 then
        return {0.33, 0.87, 1, 1}
    elseif value <= 0.0027 then
        return {0.58, 0.9, 1, 1}
    elseif value <= 0.016 then
        return {0.33, 0.87, 1, 1}
    elseif value <= 0.04 then
        return {1, 1, 0.16, 1}
    elseif value <= 0.0747 then
        return {1, 0.72, 0.17, 1}
    elseif value <= 0.12 then
        return {1, 0.46, 0.18, 1}
    else
        return {1, 0.1, 0.1, 1}
    end
end

local function addHitError(playfield, width)
playfield:addHitError({
    transform = playfield:newLaneCenterTransform(playfield.noteskin.unit),
    x = 0,
    y = playfield.noteskin.config:get("hiterrorposition") * 1080 / 100,
    w = width,
    h = 40,
    origin = {
        w = 1,
        h = 40 * 2,
        color = {1, 1, 1, 1}
    },
    background = {
        color = {0, 0, 0, 0}
    },
    unit = 0.12,
    color = hitcolor,
    radius = 1,
    count = 20,
})
end

local functions = {
	addHitError = addHitError,
	addDeltaTimeJudgement = addDeltaTimeJudgement,
	addCombo = addCombo,
	addConfigIntroduce = addConfigIntroduce,
	addConfigBaseSettings = addConfigBaseSettings,
	addConfigScratchSettings = addConfigScratchSettings,
	addConfig1keySettings = addConfig1keySettings
}

return functions