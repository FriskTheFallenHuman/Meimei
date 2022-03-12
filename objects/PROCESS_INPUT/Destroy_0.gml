/// @description Mark this part has completed
with(THING)
{
	is_done = true;
	
	// Write our ini file to UTLC directory
	ini_open( utlc_save_dir + "meimei.ini" );
		ini_write_real( "Vessel", "SetupDone", is_done );
	ini_close();
}
