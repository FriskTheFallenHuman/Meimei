/// @description Increment our Con value
if ( found == false )
	show_error("You're not ready.", true);

if ( vessel )
{
	// Copy the file to the working directory
	if (file_exists(ddlc_persistent)) {
		show_message("[Perisistent] I Exist");
		file_copy( ddlc_persistent, ( working_directory + filename_name(ddlc_persistent) ) );
	} else {
		show_message("[Perisistent] Bruh");
	}

	// Dump our data file
	var pdataa = rpy_persistent_read("persistent");
	var pdata = rpy_persistent_convert_from_abstract(pdataa);
	var dump = "";
	var file = file_text_open_write("persistent.txt");
	var keys = variable_struct_get_names(pdata);
	for (var i = 0; i < array_length(keys); i++) {
		dump += keys[i] + " = " + string(pdata[$ keys[i]]) + "\n";
	}
	file_text_write_string(file, dump);
	file_text_close(file);
	
	//show_message(dump);

	if (file_exists(file)) {
		show_message("I Exist");	
		//file_copy( file, ( working_directory + filename_name(file) ) );
	} else {
		show_message("Bruh");
	}
}

if ( concluded )
{
	// Write our ini file to UTLC directory
	ini_open( utlc_save_dir + "meimei.ini" );
	ini_write_real( "VESSEL", "EXPERIMENT", concluded );
	ini_close();	
}

con += 1;