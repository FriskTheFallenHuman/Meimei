/// @description Init the THING
if ( debug )
	show_debug_overlay( true );

// Music
audio_play_sound(AUDIO_MEETING, 100, true);

// Init our text array
for ( var i = 0; i < 1; i++ )
	talk[i] = noone;
prompt = "";

// Find the persistent file.
ddlc_persistent = ACTION_CHECK_GAMEMEMORY();
if ( file_exists(ddlc_persistent) || ( debug && file_exists( "persistent" ) ) )
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

// Create our directory if doesn't Exist
if (!directory_exists(utlc_save_dir))
	directory_create(utlc_save_dir)

if (directory_exists(utlc_save_dir))
{
	found_utlc = true;
	// Write our ini file to UTLC directory
	ini_open( utlc_save_dir + "meimei.ini" );
	ini_write_real( "VESSEL", "MEETING", 0 );
	ini_close();
}

// Start our timer
alarm[0] = 5*room_speed;

function prep_con_inc(seconds = 4)
{
	if( alarm[0] <= 0 )
		alarm[0] = seconds * room_speed;
}

function show_input()
{
	if ( !instance_exists( TEXTINPUTOBJ ) )
	{
		TEXTINPUTOBJ = instance_create_depth((room_width/2), (room_height/2), 0, PROCESS_INPUT);
		with( TEXTINPUTOBJ )
		{
			keyboard_string = "";
			if ( message != "" )
				message = "";
		}
	}
	return TEXTINPUTOBJ;
}

function hide_input()
{
	instance_destroy(TEXTINPUTOBJ);
	keyboard_string = "";
}