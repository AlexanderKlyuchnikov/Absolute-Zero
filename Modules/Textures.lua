local function setTextures(noteskin)
	noteskin:setTextures({
		{whiteshortnote = "Notes/WhiteShortNote.png"},
		{whitelongnote = "Notes/WhiteLongNote.png"},
		{whitelongnotebody = "Notes/WhiteLongNoteBody.png"},
		{longwhiteshortnote = "Notes/LongWhiteShortNote.png"},
		{longwhitelongnote = "Notes/LongWhiteLongNote.png"},
		{longwhitelongnotebody = "Notes/LongWhiteLongNoteBody.png"},

		{blueshortnote = "Notes/BlueShortNote.png"},
		{bluelongnote = "Notes/BlueLongNote.png"},
		{bluelongnotebody = "Notes/BlueLongNoteBody.png"},
		{longblueshortnote = "Notes/LongBlueShortNote.png"},
		{longbluelongnote = "Notes/LongBlueLongNote.png"},
		{longbluelongnotebody = "Notes/LongBlueLongNoteBody.png"},

		{yellowshortnote = "Notes/YellowShortNote.png"},
		{yellowlongnote = "Notes/YellowLongNote.png"},
		{yellowlongnotebody = "Notes/YellowLongNoteBody.png"},
		{longyellowshortnote = "Notes/LongYellowShortNote.png"},
		{longyellowlongnote = "Notes/LongYellowLongNote.png"},
		{longyellowlongnotebody = "Notes/LongYellowLongNoteBody.png"},

		{redshortnote = "Notes/RedShortNote.png"},
		{redlongnote = "Notes/RedLongNote.png"},
		{redlongnotebody = "Notes/RedLongNoteBody.png"},
		{longredshortnote = "Notes/LongRedShortNote.png"},
		{longredlongnote = "Notes/LongRedLongNote.png"},
		{longredlongnotebody = "Notes/LongRedLongNoteBody.png"},

		{violetshortnote = "Notes/VioletShortNote.png"},
		{violetlongnote = "Notes/VioletLongNote.png"},
		{violetlongnotebody = "Notes/VioletLongNoteBody.png"},
		{longvioletshortnote = "Notes/LongVioletShortNote.png"},
		{longvioletlongnote = "Notes/LongVioletLongNote.png"},
		{longvioletlongnotebody = "Notes/LongVioletLongNoteBody.png"},

		{pinkshortnote = "Notes/PinkShortNote.png"},
		{pinklongnote = "Notes/PinkLongNote.png"},
		{pinklongnotebody = "Notes/PinkLongNoteBody.png"},
		{longpinkshortnote = "Notes/LongPinkShortNote.png"},
		{longpinklongnote = "Notes/LongPinkLongNote.png"},
		{longpinklongnotebody = "Notes/LongPinkLongNoteBody.png"},

		{orangeshortnote = "Notes/OrangeShortNote.png"},
		{orangelongnote = "Notes/OrangeLongNote.png"},
		{orangelongnotebody = "Notes/OrangeLongNoteBody.png"},
		{longorangeshortnote = "Notes/LongOrangeShortNote.png"},
		{longorangelongnote = "Notes/LongOrangeLongNote.png"},
		{longorangelongnotebody = "Notes/LongOrangeLongNoteBody.png"},

		{cyanshortnote = "Notes/CyanShortNote.png"},
		{cyanlongnote = "Notes/CyanLongNote.png"},
		{cyanlongnotebody = "Notes/CyanLongNoteBody.png"},
		{longcyanshortnote = "Notes/LongCyanShortNote.png"},
		{longcyanlongnote = "Notes/LongCyanLongNote.png"},
		{longcyanlongnotebody = "Notes/LongCyanLongNoteBody.png"},

		{greenshortnote = "Notes/GreenShortNote.png"},
		{greenlongnote = "Notes/GreenLongNote.png"},
		{greenlongnotebody = "Notes/GreenLongNoteBody.png"},
		{longgreenshortnote = "Notes/LongGreenShortNote.png"},
		{longgreenlongnote = "Notes/LongGreenLongNote.png"},
		{longgreenlongnotebody = "Notes/LongGreenLongNoteBody.png"},

		{greyshortnote = "Notes/GreyShortNote.png"},
		{greylongnote = "Notes/GreyLongNote.png"},
		{greylongnotebody = "Notes/GreyLongNoteBody.png"},
		{longgreyshortnote = "Notes/LongGreyShortNote.png"},
		{longgreylongnote = "Notes/LongGreyLongNote.png"},
		{longgreylongnotebody = "Notes/LongGreyLongNoteBody.png"},

		{blackshortnote = "Notes/BlackShortNote.png"},
		{blacklongnote = "Notes/BlackLongNote.png"},
		{blacklongnotebody = "Notes/BlackLongNoteBody.png"},
		{longblackshortnote = "Notes/LongBlackShortNote.png"},
		{longblacklongnote = "Notes/LongBlackLongNote.png"},
		{longblacklongnotebody = "Notes/LongBlackLongNoteBody.png"},
	})
end

local colourshortnote = 
{
	white = "whiteshortnote",
	blue = "blueshortnote",
	yellow = "yellowshortnote",
	red = "redshortnote",
	violet = "violetshortnote",
	pink = "pinkshortnote",
	orange = "orangeshortnote",
	cyan = "cyanshortnote",
	green = "greenshortnote",
	grey = "greyshortnote",
	black = "blackshortnote"
}

local colourlongnote = 
{
	white = "whitelongnote",
	blue = "bluelongnote",
	yellow = "yellowlongnote",
	red = "redlongnote",
	violet = "violetlongnote",
	pink = "pinklongnote",
	orange = "orangelongnote",
	cyan = "cyanlongnote",
	green = "greenlongnote",
	grey = "greylongnote",
	black = "blacklongnote"
}

local colourlongnotebody = 
{
	white = "whitelongnotebody",
	blue = "bluelongnotebody",
	yellow = "yellowlongnotebody",
	red = "redlongnotebody",
	violet = "violetlongnotebody",
	pink = "pinklongnotebody",
	orange = "orangelongnotebody",
	cyan = "cyanlongnotebody",
	green = "greenlongnotebody",
	grey = "greylongnotebody",
	black = "blacklongnotebody"
}

local longcolourshortnote = 
{
	white = "longwhiteshortnote",
	blue = "longblueshortnote",
	yellow = "longyellowshortnote",
	red = "longredshortnote",
	violet = "longvioletshortnote",
	pink = "longpinkshortnote",
	orange = "longorangeshortnote",
	cyan = "longcyanshortnote",
	green = "longgreenshortnote",
	grey = "longgreyshortnote",
	black = "longblackshortnote"
}

local longcolourlongnote = 
{
	white = "longwhitelongnote",
	blue = "longbluelongnote",
	yellow = "longyellowlongnote",
	red = "longredlongnote",
	violet = "longvioletlongnote",
	pink = "longpinklongnote",
	orange = "longorangelongnote",
	cyan = "longcyanlongnote",
	green = "longgreenlongnote",
	grey = "longgreylongnote",
	black = "longblacklongnote"
}

local longcolourlongnotebody = 
{
	white = "longwhitelongnotebody",
	blue = "longbluelongnotebody",
	yellow = "longyellowlongnotebody",
	red = "longredlongnotebody",
	violet = "longvioletlongnotebody",
	pink = "longpinklongnotebody",
	orange = "longorangelongnotebody",
	cyan = "longcyanlongnotebody",
	green = "longgreenlongnotebody",
	grey = "longgreylongnotebody",
	black = "longblacklongnotebody"
}

local pressedkeycolour =
{
    white = "Keys/PressedWhiteKey.png",
	blue = "Keys/PressedBlueKey.png",
	yellow = "Keys/PressedYellowKey.png",
	red = "Keys/PressedRedKey.png",
	violet = "Keys/PressedVioletKey.png",
	pink = "Keys/PressedPinkKey.png",
	orange = "Keys/PressedOrangeKey.png",
	cyan = "Keys/PressedCyanKey.png",
	green = "Keys/PressedGreenKey.png",
	grey = "Keys/PressedGreyKey.png",
	black = "Keys/PressedBlackKey.png"
}

local colourtable =
{
	white = {0.5, 0.5, 0.5, 1},
	blue = {0.04, 0.23, 0.5, 1},
	yellow = {0.5, 0.5, 0, 1},
	red = {0.5, 0, 0, 1},
	violet = {0.2, 0, 0.5, 1},
	pink = {0.4, 0, 0.5, 1},
	orange = {0.5, 0.23, 0, 1},
	cyan = {0, 0.5, 0.5, 1},
	green = {0, 0.5, 0, 1},
	grey = {0.15, 0.15, 0.15, 1},
	black = {0, 0, 0, 1}
}

local colourmap =
{
    setTextures = setTextures,
    colourshortnote = colourshortnote,
    colourlongnote = colourlongnote,
    colourlongnotebody = colourlongnotebody,
    longcolourshortnote = longcolourshortnote,
    longcolourlongnote = longcolourlongnote,
    longcolourlongnotebody = longcolourlongnotebody,
    pressedkeycolour = pressedkeycolour,
	colourtable = colourtable
}

return colourmap