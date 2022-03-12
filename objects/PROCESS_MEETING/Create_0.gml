/// @description Init the THING
if ( debug )
	show_debug_overlay( true );

// Global Surface
global.textsurface = noone;

// Music
audio_play_sound(AUDIO_MEETING, 100, true);

// Init our text array
for ( var i = 0; i < 1; i++ )
	talk[i] = noone;
prompt = "";

// Find the persistent file.
ddlc_persistent = ACTION_CHECK_GAMEMEMORY();
if ( ddlc_persistent || ( debug && file_exists( "persistent" ) ) )
{
	found = true;
	if ( debug )
		ddlc_persistent = ( "persistent" );
}

// Get our save Directory
switch( os_type )
{
	case os_windows:
		utlc_save_dir = environment_get_variable( "LOCALAPPDATA" ) + "/UT_LiteratureClub/";
	break;
	case os_linux:
		utlc_save_dir = ( environment_get_variable( "HOME" ) + "/.config/UT_LiteratureClub/" );
	break;
	case os_macosx:
		utlc_save_dir = ( environment_get_variable( "HOME" ) + "/Library/Application Support/UT_LiteratureClub/" );
	break;
}

// Write our ini file to UTLC directory
ini_open( utlc_save_dir + "meimei.ini" );
ini_write_real( "VESSEL", "MEETING", 0 );
ini_close();

// Start our timer
alarm[0] = 5*room_speed;