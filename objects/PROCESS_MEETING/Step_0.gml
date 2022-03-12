/// @description Increment Our Timer

ACTION_INTERACTIONS_CHECKKEYS();

if ( faded == false ) 
{
   if ( alpha > 0 ) 
       alpha -= 0.05;
   else 
       faded = true;
} 
else
{
   if ( alpha < 1 )
       alpha += 0.05;
   else
       faded = false;
}

if ( con == 0 )
{
	if ( found == false )
		talk[0] = "NO CONNECTION.";
	else
		talk[0] = "PLEASE INPUT THE SOUL.";
}

if ( con == 1 )
{
	talk[0] = "MOLDING THE VESSEL AT HER OWN IMAGE.";
	if ( file_exists_ue( ddlc_persistent ) || ( debug & file_exists( ddlc_persistent ) ) )
		vessel = true;
	else
	{
		talk[0] = "BUT THERE WAS NOTHING TO SHAPE FROM.";
		found = false;
		
		if ( !alarm[0] )
			alarm[0] = 4*room_speed; // Aborting...
	}
	
	if( !alarm[0] )
		alarm[0] = 4*room_speed;
}

if ( con == 2 )
{
	talk[0] = "THE VESSEL HAS BEEN CREATED.";
	prompt = "(Press SHIFT to continue)";
	if ( keyboard_check_pressed( vk_shift ) )
		con = 3;
}

if ( con == 3 )
{
	if ( alarm[0] )
		alarm[0] = -1;

	talk[0] = "NOW. WHAT'S YOUR NAME?";
	prompt = "(Press ENTER to continue)";
	
	var TEXTINPUT = instance_exists( INPUT );
	if ( !TEXTINPUT )
		TEXTINPUTOBJ = instance_create_depth((room_width/2), (room_height/2), 0, INPUT);
}

if ( con == 3.1 )
{
}

if ( con == 3.2 )
{
	PROCESS_IMAGERY.preset = BktGlitchPreset.B;
	alarm[0] = -1;
	audio_stop_all();
	audio_play_sound(AUDIO_NOISE, 100, true);
	prompt = "";
	if( !alarm[1] )
		alarm[1] = 4*room_speed;
}

if ( con == 3.3 )
{
	instance_destroy(TEXTINPUTOBJ);
	talk[0] = "THAT'S RIGHT, YOU'RE 'MONIKA'."
	prompt = "(Press SHIFT to continue)";
	if ( keyboard_check_pressed( vk_shift ) )
		con = 4;
}

if ( con == 4 )
{
	prompt = "";
	talk[0] = "I HAVE A PROPOSITION FOR YOU.";
	if( !alarm[0] )
		alarm[0] = 4*room_speed;
}

if ( con == 5 )
{
	talk[0] = "IF YOU ACCEPT IT.";
	if( !alarm[0] )
		alarm[0] = 4*room_speed;
}

if ( con == 6 )
{
	talk[0] = "I WILL LET YOU BE PART OF THIS 'WORLD'.";
	if( !alarm[0] )
		alarm[0] = 4*room_speed;
}

if ( con == 7 )
{
	if ( alarm[0] )
		alarm[0] = -1;

	talk[0] = "SO WHAT DO YOU SAY?";
	prompt = "(Press ENTER to continue)";
	
	var TEXTINPUT = instance_exists( INPUT );
	if ( !TEXTINPUT )
	{
		TEXTINPUTOBJ = instance_create_depth((room_width/2), (room_height/2), 0, INPUT);
		with( TEXTINPUTOBJ )
		{
			if ( message != "" )
				message = "";
			offert = true;
		}
	}
}

if ( con == 7.1 )
{
	talk[0] = "SO WHAT DO YOU SAY?";
}

if ( con == 8.1 )
{
	instance_destroy(TEXTINPUTOBJ);
	talk[0] = "EXCELLENT."
	prompt = "(Press SHIFT to continue)";
	if ( keyboard_check_pressed( vk_shift ) )
		con = 8;
}

if ( con == 8 )
{
	prompt = "";
	talk[0] = "TRULY EXCELLENT.";
	if( !alarm[0] )
		alarm[0] = 4*room_speed;
}

if ( con == 9 )
{
	talk[0] = "NOW.";
	if( !alarm[0] )
		alarm[0] = 4*room_speed;	
}

if ( con == 10 )
{
	PROCESS_IMAGERY.preset = BktGlitchPreset.B;
	audio_stop_all();
	talk[0] = "I will see you soon.";
	if( !alarm[0] )
		alarm[0] = 4*room_speed;
	center_text = true;
	concluded = true;
}

if ( con == 11 )
	game_end();