function INTERACTION_MAPPINGS() constructor
{
	ITEMS = [];

    static ADD_MAPPING = function(ITEM)
    {
		array_push(ITEMS, ITEM);
		return ITEM;
    }

    static TOTAL_ITEMS = function()
    {
		return array_length(ITEMS);
    }
    static GET_ITEM_BY_KEYCODE = function(KEYCODE)
    {
		for (var INDEX = 0; INDEX < TOTAL_ITEMS(); INDEX++) {
			var ITEM = ITEMS[INDEX];
			if ITEM.KEYCODE == KEYCODE {
				return ITEM;
				break;
			}
		}
		return noone;
    }
	// YOU WOULD NEVER WANT TO INDEX A MAPPING BY ITS ALIAS.
}
function INTERACTION_MAPPING_ITEM(_KEYCODE, _ALIAS) constructor
{
	KEYCODE = _KEYCODE;
	ALIAS = _ALIAS;
}

global.INTERACTION_MAPPINGS = new INTERACTION_MAPPINGS();
global.INTERACTION_MAPPINGS.ADD_MAPPING(new INTERACTION_MAPPING_ITEM(vk_enter, "enter"));
global.INTERACTION_MAPPINGS.ADD_MAPPING(new INTERACTION_MAPPING_ITEM(vk_shift, "shift"));

global.INTERACTION_STATUS = [];

function ACTION_INTERACTIONS_ALIAS(INTERACTION)
{
	return global.INTERACTION_MAPPINGS.ITEMS[INTERACTION].ALIAS;
}
function ACTION_INTERACTIONS_KEYCODE(INTERACTION)
{
	return global.INTERACTION_MAPPINGS.ITEMS[INTERACTION].KEYCODE;
}

function ACTION_INTERACTIONS_CHECKKEYS()
{
	for (var INDEX = 0; INDEX < array_length(global.INTERACTION_MAPPINGS.ITEMS); INDEX++)
	{
		var ITEM = global.INTERACTION_MAPPINGS.ITEMS[INDEX];
		if keyboard_check_pressed(ITEM.KEYCODE)
		{
			global.INTERACTION_STATUS[INDEX] = 2
		}
		else if keyboard_check_released(ITEM.KEYCODE)
		{
			global.INTERACTION_STATUS[INDEX] = 3
		}
		else if keyboard_check(ITEM.KEYCODE)
		{
			global.INTERACTION_STATUS[INDEX] = 1
		}
		else
		{
			global.INTERACTION_STATUS[INDEX] = 0
		}
	}
}
function ACTION_INTERACTIONS_CHECK(INTERACTION)
{
	return global.INTERACTION_STATUS[INTERACTION] == 1;
}
function ACTION_INTERACTIONS_CHECK_PRESSED(INTERACTION)
{
	return global.INTERACTION_STATUS[INTERACTION] == 2;
}
function ACTION_INTERACTIONS_CHECK_RELEASED(INTERACTION)
{
	return global.INTERACTION_STATUS[INTERACTION] == 3;
}