function ACTION_CHECK_GAMEMEMORY() {
	var MEMORY_STORAGE = undefined;

	if ( os_type == os_windows )
	{
	    MEMORY_STORAGE = ( environment_get_variable( "APPDATA" ) + "/RenPy/DDLC-1454445547/persistent" );
	}
	else if ( os_type == os_macosx )
	{
	    MEMORY_STORAGE = ( environment_get_variable( "HOME" ) + "/Library/RenPy/DDLC-1454445547/persistent" );
	}
	else if ( os_type == os_linux )
	{
	    MEMORY_STORAGE = ( environment_get_variable( "HOME" ) + "/.renpy/DDLC-1454445547/persistent" );
	}

	return MEMORY_STORAGE;
}