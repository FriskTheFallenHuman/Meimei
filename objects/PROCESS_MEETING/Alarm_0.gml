/// @description Increment our Con value
if ( found == false )
	show_error("You're not ready.", true);

if ( vessel )
{
	// Decompress the persistent file
	// TODO
	/*var buffer = -1, buffer2 = -1;
	buffer = buffer_load( ddlc_persistent );
	if ( buffer < 0 )
	{
		show_message( "Couldn't load buffer." );
		exit; 
	}
	
	//buffer2 = buffer_deflate( buffer, 0, buffer_get_size( buffer ), 1 );
	buffer2 = buffer_decompress(buffer);
	if ( buffer2 < 0 ) 
	{
		show_message( "Couldn't deflate error" );
		exit;
	}

	var buffer_savefile = get_save_filename("*.txt*", "");
	if ( buffer_savefile == "" ) 
		exit;

	buffer_save_ext( buffer2, buffer_savefile, 0, buffer_tell( buffer2 ) );
	
    if ( buffer != -1 ) 
		buffer_delete( buffer );

    if ( buffer2 != -1 ) 
		buffer_delete( buffer2 );*/
	
	// Copy the file to the working directory
	file_copy( ddlc_persistent, ( working_directory + filename_name(ddlc_persistent) + ".txt" ) );
}

if ( concluded )
{
	// Write our ini file to UTLC directory
	ini_open( utlc_save_dir + "meimei.ini" );
	ini_write_real( "VESSEL", "EXPERIMENT", concluded );
	ini_close();	
}

con += 1;