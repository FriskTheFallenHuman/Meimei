enum INTERACTION_TYPE {
	CONFIRM,
	INPUT_CONFIRM
}
enum INTERACTION_STATUS {
	OFF,
	HOLD,
	PRESSED,
	RELEASED
}

function INTERACTION_MAPPINGS() constructor
{
	MAPPINGS = [];

    static SET_MAPPING = function(MAPPING_NO, MAPPING)
    {
		MAPPINGS[MAPPING_NO] = MAPPING;
		return MAPPING;
    }
}

function INTERACTION_MAPPING(_KEYS) constructor
{
	KEYS = _KEYS;
}
function INTERACTION_MAPPING_KEY(_KEYCODE, _ALIAS) constructor
{
	KEYCODE = _KEYCODE;
	ALIAS = _ALIAS;
}

global.INTERACTION_MAPPINGS = new INTERACTION_MAPPINGS();
global.INTERACTION_MAPPINGS.SET_MAPPING(
	INTERACTION_TYPE.CONFIRM,
	new INTERACTION_MAPPING([new INTERACTION_MAPPING_KEY(vk_shift, "shift")])
);
global.INTERACTION_MAPPINGS.SET_MAPPING(
	INTERACTION_TYPE.INPUT_CONFIRM,
	new INTERACTION_MAPPING([new INTERACTION_MAPPING_KEY(vk_enter, "enter")])
);

global.INTERACTION_STATUS = array_create(array_length(global.INTERACTION_MAPPINGS.MAPPINGS));

function ACTION_INTERACTIONS_ALIAS(INTERACTION, TYPE = 0)
{
	return global.INTERACTION_MAPPINGS.MAPPINGS[INTERACTION].KEYS[TYPE].ALIAS;
}
function ACTION_INTERACTIONS_KEYS(INTERACTION)
{
	return global.INTERACTION_MAPPINGS.MAPPINGS[INTERACTION].KEYS;
}

function ACTION_INTERACTIONS_UPDATE()
{
	for (var INDEX = 0; INDEX < array_length(global.INTERACTION_MAPPINGS.MAPPINGS); INDEX++)
	{
		var MAPPING = global.INTERACTION_MAPPINGS.MAPPINGS[INDEX];
		var OLD_STATUS = global.INTERACTION_STATUS[INDEX];
		global.INTERACTION_STATUS[INDEX] = INTERACTION_STATUS.OFF;
		var DISPATCHING_STATUS = global.INTERACTION_STATUS[INDEX];
		for (var INDEX2 = 0; INDEX2 < array_length(MAPPING.KEYS); INDEX2++)
		{
			var KEY = MAPPING.KEYS[INDEX2];
			if keyboard_check_pressed(KEY.KEYCODE)
				&& DISPATCHING_STATUS != INTERACTION_STATUS.HOLD
			{
				DISPATCHING_STATUS = INTERACTION_STATUS.PRESSED;
			}
			else if keyboard_check_released(KEY.KEYCODE)
				&& DISPATCHING_STATUS != INTERACTION_STATUS.HOLD
				&& DISPATCHING_STATUS != INTERACTION_STATUS.PRESSED
			{
				DISPATCHING_STATUS = INTERACTION_STATUS.RELEASED;
			}
			else if keyboard_check(KEY.KEYCODE)
				// && DISPATCHING_STATUS != INTERACTION_STATUS.RELEASED
			{
				DISPATCHING_STATUS = INTERACTION_STATUS.HOLD;
			}
		}
		global.INTERACTION_STATUS[INDEX] = DISPATCHING_STATUS;
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