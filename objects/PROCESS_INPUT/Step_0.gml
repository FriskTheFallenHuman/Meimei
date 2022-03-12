/// @description Get our input from the keyboard
var saved = false;

// Store our inputs in here
if ( string_length( keyboard_string ) < limit ) 
    message = keyboard_string;
else
    keyboard_string = message;

// Saved our string
if ( keyboard_check_pressed(vk_enter) )
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
			with(THING)
				con = 3.3;
			break;
			case "sayori":
			with(THING)
			{
				talk[0] = "CLOUDY DAY, MEMORIES AWAY."
				con = 3.1;
			}
			break;
			case "yuri":
			with(THING)
			{
				talk[0] = "THE PAIN DOESN'T GO AWAY."
				con = 3.1;
			}
			break;
			case "natsuki":
			with(THING)
			{
				talk[0] = "LIFE IS HARD."
				con = 3.1;
			}
			break;
			case "gaster":
			with(THING)
			{
				string_shuffle( keyboard_string );
				talk[0] = string_shuffle("PLEASE INPUT THE RIGHT NAME.");
				con = 3.2;			
			}
			break;
			default:
			case "":
			with(THING)
			{
				talk[0] = "PLEASE INPUT THE RIGHT NAME.";
				con = 3.1;
			}
			break;
		}
	}
}
else
{
		switch( save_message )
		{
			case "yes":
			with(THING)
				con = 8.1;
			break;
			case "no":
			with(THING)
			{
				talk[0] = string_shuffle("THEN, THE WORLD WOULD COME TO END.");
				con = 3.2;
			}
			break;
			default:
			case "":
			with(THING)
				con = 7.1;
			break;
		}	
}