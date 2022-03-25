// Huge input system
// By Dobby233Liu


function INTERACTION_MAPPINGS() constructor
{
	MAPPINGS = [];

    static SET_MAPPING = function(MAPPING_NO, MAPPING)
    {
		MAPPINGS[MAPPING_NO] = MAPPING;
		return MAPPING;
    }
}


#macro ERROR_NOT_IMPLEMENTED "Not implemented"

function INTERACTION_MAPPING_KEY() constructor
{
	static IS_HELD = function()
	{
		throw ERROR_NOT_IMPLEMENTED;
	}
	static IS_PRESSED = function()
	{
		throw ERROR_NOT_IMPLEMENTED;
	}
	static IS_RELEASED = function()
	{
		throw ERROR_NOT_IMPLEMENTED;
	}

	static CLEAR = function()
	{
		throw ERROR_NOT_IMPLEMENTED;
	}

	static GET_ALIAS = function()
	{
		throw ERROR_NOT_IMPLEMENTED;
	}
	static toString = function()
	{
		return GET_ALIAS();
	}
}

function INTERACTION_MAPPING_KEY_KEYBOARD(_KEYCODE) : INTERACTION_MAPPING_KEY() constructor
{
	KEYCODE = _KEYCODE;

	static IS_HELD = function()
	{
		return keyboard_check(KEYCODE);
	}
	static IS_PRESSED = function()
	{
		return keyboard_check_pressed(KEYCODE);
	}
	static IS_RELEASED = function()
	{
		return keyboard_check_released(KEYCODE);
	}

	static CLEAR = function()
	{
		keyboard_clear(KEYCODE);
	}

	static GET_ALIAS = function()
	{
		try
		{
			return global.KB_KEYCODE_ALIASES[KEYCODE];
		}
		catch (_)
		{
			return global.KB_KEYCODE_ALIASES[-1];
		}
	}
}


function INTERACTION_MAPPING(_KEYS) constructor
{
	KEYS = _KEYS;

	static GET_STATUS = function()
	{
		var DISPATCHING_STATUS = INTERACTION_STATUS.OFF;
		for (var INDEX = 0; INDEX < array_length(KEYS); INDEX++)
		{
			var KEY = KEYS[INDEX];
			if KEY.IS_PRESSED()
				&& DISPATCHING_STATUS != INTERACTION_STATUS.HOLD
			{
				DISPATCHING_STATUS = INTERACTION_STATUS.PRESSED;
			}
			else if KEY.IS_RELEASED()
				&& DISPATCHING_STATUS != INTERACTION_STATUS.HOLD
				&& DISPATCHING_STATUS != INTERACTION_STATUS.PRESSED
			{
				DISPATCHING_STATUS = INTERACTION_STATUS.RELEASED;
			}
			else if KEY.IS_HELD()
			{
				DISPATCHING_STATUS = INTERACTION_STATUS.HOLD;
			}
		}
		return DISPATCHING_STATUS;
	}

    static CLEAR_KEYS = function()
    {
		for (var INDEX = 0; INDEX < array_length(KEYS); INDEX++)
		{
			KEYS[INDEX].CLEAR();
		}
    }
}

ACTION_INTERACTIONS_CONFIG();
global.INTERACTION_STATUS = array_create(array_length(global.INTERACTION_MAPPINGS.MAPPINGS));

function array_join(array, sep = " ")
{
	var str = string(array[0]);
	if (array_length(array) > 1)
	{
		for (var i = 1; i < array_length(array); i++)
		{
			str = str + sep + string(array[i]);
		}
	}
	return str;
}

function ACTION_INTERACTIONS_KEYS(INTERACTION)
{
	return global.INTERACTION_MAPPINGS.MAPPINGS[INTERACTION].KEYS;
}
function ACTION_INTERACTIONS_ALIAS(INTERACTION, TYPE = -1)
{
	var KEYS = ACTION_INTERACTIONS_KEYS(INTERACTION);
	if (TYPE == -1) 
	{
		return array_join(KEYS, "/");
	}
	return string(KEYS[TYPE]);
}

function ACTION_INTERACTIONS_UPDATE()
{
	for (var INDEX = 0; INDEX < array_length(global.INTERACTION_MAPPINGS.MAPPINGS); INDEX++)
	{
		var MAPPING = global.INTERACTION_MAPPINGS.MAPPINGS[INDEX];
		global.INTERACTION_STATUS[INDEX] = MAPPING.GET_STATUS();
	}
}

function ACTION_INTERACTIONS_CHECK(INTERACTION)
{
	return global.INTERACTION_STATUS[INTERACTION] == INTERACTION_STATUS.HOLD;
}
function ACTION_INTERACTIONS_CHECK_PRESSED(INTERACTION)
{
	return global.INTERACTION_STATUS[INTERACTION] == INTERACTION_STATUS.PRESSED;
}
function ACTION_INTERACTIONS_CHECK_RELEASED(INTERACTION)
{
	return global.INTERACTION_STATUS[INTERACTION] == INTERACTION_STATUS.RELEASED;
}

function INTERACTIONS_CHECK(INTERACTION) {
	return ACTION_INTERACTIONS_CHECK(INTERACTION);
}
function INTERACTIONS_CHECK_PRESSED(INTERACTION) {
	return ACTION_INTERACTIONS_CHECK_PRESSED(INTERACTION);
}
function INTERACTIONS_CHECK_RELEASED(INTERACTION) {
	return ACTION_INTERACTIONS_CHECK_RELEASED(INTERACTION);
}

function ACTION_INTERACTIONS_CLEAR(INTERACTION)
{
	var MAPPING = global.INTERACTION_MAPPINGS.MAPPINGS[INTERACTION];
	global.INTERACTION_STATUS[INTERACTION] = 0;
	MAPPING.CLEAR_KEYS();
}
function ACTION_INTERACTIONS_CLEAR_ALL()
{
	for (var INDEX = 0; INDEX < array_length(global.INTERACTION_MAPPINGS.MAPPINGS); INDEX++)
	{
		ACTION_INTERACTIONS_CLEAR(INDEX);
	}
}

function INTERACTIONS_CLEAR(INTERACTION) {
	return ACTION_INTERACTIONS_CLEAR(INTERACTION);
}
function INTERACTIONS_CLEAR_ALL() {
	return ACTION_INTERACTIONS_CLEAR_ALL();
}