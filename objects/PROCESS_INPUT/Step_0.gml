/// @description Get our input from the keyboard
var saved = false;

// Store our inputs in here
if ( string_length( keyboard_string ) < limit ) 
    message = keyboard_string;
else
    keyboard_string = message;

// Saved our string
if ( INTERACTIONS_CHECK_PRESSED(INTERACTION_TYPE.INPUT_CONFIRM) )
{
	save_message = string_lower( message );
	saved = true;
}

// Check if we meet the special conditions to trigger
if ( !offert )
{
	if ( saved )
	{
		switch( save_message )
		{
			case "monika":
				with(PROCESS_MEETING)
					con = 3.3;
				break;
			case "sayori":
				with(PROCESS_MEETING)
				{
					talk[0] = "CLOUDY DAY, MEMORIES AWAY."
					con = 3.1;
				}
				break;
			case "yuri":
				with(PROCESS_MEETING)
				{
					talk[0] = "THE PAIN DOESN'T GO AWAY."
					con = 3.1;
				}
				break;
			case "natsuki":
				with(PROCESS_MEETING)
				{
					talk[0] = "LIFE IS HARD."
					con = 3.1;
				}
				break;
			case "gaster":
				with(PROCESS_MEETING)
				{
					string_shuffle( keyboard_string );
					talk[0] = string_shuffle("PLEASE INPUT THE RIGHT NAME.");
					con = 3.2;			
				}
			break;
			case "":
				with(PROCESS_MEETING)
				{
					talk[0] = "PLEASE INPUT THE RIGHT NAME.";
					con = 3.1;
				}
				break;
			default:
				break;
		}
	}
}
else
{
	switch( save_message )
	{
		case "yes":
			with (PROCESS_MEETING)
				con = 8.1;
			break;
		case "no":
			with(PROCESS_MEETING)
			{
				talk[0] = string_shuffle("THEN, THE WORLD WOULD COME TO END.");
				con = 3.2;
			}
			break;
		case "":
			with(PROCESS_MEETING)
				con = 7.1;
			break;
		default:
			break;
	}	
}