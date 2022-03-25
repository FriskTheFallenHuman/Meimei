/// @description Increment Our Timer

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
	if ( !found_utlc )
		talk[0] = "NO CONNECTION.";
	else
		talk[0] = "PLEASE INPUT THE SOUL.";
}

if ( con == 1 )
{
	talk[0] = "MOLDING THE VESSEL AT HER OWN IMAGE.";

	if ( found )
		vessel = true;
	else
		talk[0] = "BUT THERE WAS NOTHING TO SHAPE FROM.";
	
	prep_con_inc();
}

if ( con == 2 )
{
	talk[0] = "THE VESSEL HAS BEEN CREATED.";
	prompt = "(Press " + string_upper(ACTION_INTERACTIONS_ALIAS(INTERACTION_TYPE.CONFIRM)) + " to continue)";
	if ( INTERACTIONS_CHECK_PRESSED( INTERACTION_TYPE.CONFIRM ) )
		con = 3;
}

if ( con == 3 )
{
	if ( alarm[0] > 0 )
		alarm[0] = -1;

	talk[0] = "NOW. WHAT'S YOUR NAME?";
	prompt = "(Press " + string_upper(ACTION_INTERACTIONS_ALIAS(INTERACTION_TYPE.INPUT_CONFIRM)) + " to continue)";
	
	show_input();
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
	hide_input();
	talk[0] = "THAT'S RIGHT, YOU'RE 'MONIKA'."
	prompt = "(Press " + string_upper(ACTION_INTERACTIONS_ALIAS(INTERACTION_TYPE.CONFIRM)) + " to continue)";
	if ( INTERACTIONS_CHECK_PRESSED( INTERACTION_TYPE.CONFIRM ) )
		con = 4;
}

if ( con == 4 )
{
	prompt = "";
	talk[0] = "I HAVE A PROPOSITION FOR YOU.";
	prep_con_inc();
}

if ( con == 5 )
{
	talk[0] = "IF YOU ACCEPT IT.";
	prep_con_inc();
}

if ( con == 6 )
{
	talk[0] = "I WILL LET YOU BE PART OF THIS 'WORLD'.";
	prep_con_inc();
}

if ( con == 7 )
{
	if ( alarm[0] )
		alarm[0] = -1;

	talk[0] = "SO WHAT DO YOU SAY?";
	prompt = "(Press " + string_upper(ACTION_INTERACTIONS_ALIAS(INTERACTION_TYPE.INPUT_CONFIRM)) + " to continue)";
	
	with( show_input() )
	{
		offert = true;
	}
}

if ( con == 7.1 )
{
	talk[0] = "SO WHAT DO YOU SAY?";
}

if ( con == 8.1 )
{
	hide_input();
	talk[0] = "EXCELLENT."
	prompt = "(Press " + string_upper(ACTION_INTERACTIONS_ALIAS(INTERACTION_TYPE.CONFIRM)) + " to continue)";
	if ( INTERACTIONS_CHECK_PRESSED( INTERACTION_TYPE.CONFIRM ) )
		con = 8;
}

if ( con == 8 )
{
	prompt = "";
	talk[0] = "TRULY EXCELLENT.";
	prep_con_inc();
}

if ( con == 9 )
{
	talk[0] = "NOW.";
	prep_con_inc();
}

if ( con == 10 )
{
	audio_stop_all();
	PROCESS_IMAGERY.preset = BktGlitchPreset.B;
	center_text = true;
	concluded = true;
	talk[0] = "I will see you soon.";
	prep_con_inc();
}

if ( con == 11 )
	game_end();