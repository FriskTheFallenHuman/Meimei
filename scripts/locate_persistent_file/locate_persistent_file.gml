function locate_persistent_file() {
	var found = false
	var ddlc_persistent = noone;

	if ( os_type == os_windows )
	{
	    ddlc_persistent = file_exists_ue( ( environment_get_variable_ue( "APPDATA" ) + "/RenPy/DDLC-1454445547/persistent" ) )
	    if ( ddlc_persistent )
	        found = true
	}

	if ( os_type == os_linux || os_type == os_macosx )
	{
	    ddlc_persistent = file_exists_ue( ( environment_get_variable_ue( "HOME" ) + "/.renpy/DDLC-1454445547/persistent" ) )
	    if ( os_type == os_macosx )
	        ddlc_persistent = file_exists_ue( ( environment_get_variable_ue( "HOME" ) + "/Library/RenPy/DDLC-1454445547/persistent" ) )

	    if ( ddlc_persistent )
	        found = true
	}
	return found;



}
