function ACTION_CHECK_GAMEMEMORY() {
	var MEMORY_STORAGE = noone;

	if ( os_type == os_windows )
	{
	    MEMORY_STORAGE = file_exists_ue( ( environment_get_variable_ue( "APPDATA" ) + "/RenPy/DDLC-1454445547/persistent" ) )
	}
	else if ( os_type == os_macosx )
	{
	    MEMORY_STORAGE = file_exists_ue( ( environment_get_variable_ue( "HOME" ) + "/Library/RenPy/DDLC-1454445547/persistent" ) )
	}
	else if ( os_type == os_linux )
	{
	    MEMORY_STORAGE = file_exists_ue( ( environment_get_variable_ue( "HOME" ) + "/.renpy/DDLC-1454445547/persistent" ) )
	}

	return MEMORY_STORAGE;
}