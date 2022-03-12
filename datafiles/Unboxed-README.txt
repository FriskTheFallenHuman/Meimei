Unboxed is a free and open source extension written in Pascal for GMS2 that allows you to work with files 
without having to deal with GM's limitations (or features).

Supports Windows, Linux and MacOS. 

Please note that the Linux version hasn't been tested with GMS2 yet as I don't have a readily Linux system 
(same goes with MacOS). It was cross-compile from Windows to Linux/MacOS and then tested by calling it's 
functions via a Linux program running in WSL (Windows Subsystem for Linux).



This extension currently supports:
- Handling UTF-16 paths on Windows and UTF-8 paths on Linux/MacOS.
- Copying, renaming, moving and deleting files.
- Creating, renaming, moving and deleting directories.
- Creating, reading and writing UTF-8 text files.
- Searching for files and directories from a given mask.
- Get environment variables (there is a GMS equivalent for this function but it's Windows-only).



======== LIST OF FUNCTIONS =========



File manipulation functions:
---------------------------------

- file_exists_ue(path)
    Returns true if there's a file exists at the given path.
	* Example: if (file_exists_ue("d:/mygame/data.dat")) ; // Do something
	
- file_delete_ue(path)
    Deletes a file, returns true whether successful.
	* Example: file_delete_ue("d:/mygame/data.dat");
	
- file_rename_ue(oldname, newname)
    Renames a file, returns true whether successful.
    You can also use this function to move files around.
	* Example: file_rename_ue("d:/mygame/data.dat", "d:/mygame/backups/data_newname.dat");
	
- file_copy_ue(oldpath, newpath)
    Copies a file to a new location, returns true whether successful.
	* Example: file_copy_ue("d:/mygame/data.dat", "d:/mygame/backups/data_backup.dat");
	


Directory manipulation functions:
---------------------------------

- directory_exists_ue(path)
    Returns true if there's a directory exists at the given path.
	* Example: if (directory_exists_ue("d:/mygame/backups")) ; // Do something
	
- directory_create_ue(path)
    Create a new directory at given path, returns true whether successful.
	* Example: directory_create_ue("d:/mygame/backups");
	
- directory_delete_ue(path)
    Deletes a directory, returns true whether successful.
    Note that you cannot delete non-empty directories.
	* Example: directory_delete_ue("d:/mygame/backups");
	
- directory_rename_ue(oldname, newname)
    Renames a directory, returns true whether successful.
    You can also use this function to move directories around.
	* Example: directory_rename_ue("d:/mygame/backups", "d:/mygame/trash/backups_newname");
	
	
	
Text file functions:
---------------------------------

- file_text_open_write_ue(path)
    Create a new empty file, returns a file handler whether successful, or empty string if failed.
    Note that this function will override any existing files.
	
- file_text_open_read_ue(path)
    Open an existing file to read at the start of the file, returns a file handler whether successful, 
    or empty string if failed.
	
- file_text_open_append_ue(path)
    Open an existing file to read at the end of the file, returns a file handler whether successful, 
    or empty string if failed.

- file_text_readln_ue(file)
    Read a line from a file and go to the next line.

- file_text_writeln_ue(file, text)
    Write text to a file, then put an end-of-line symbol at the end of text.
	
- file_text_eof_ue(file)
    Returns true if file pointer reach end of file.

- file_text_close_ue(file)
    Close opened file.

    * Examples:
	// Create a new file at the same directory with the game
	var f = file_text_open_write_ue("save.txt");
	// Write some texts to it
	file_text_writeln_ue(f, "Hello, World!");
	file_text_writeln_ue(f, "こんにちは！");
	// Close the file
	file_text_close_ue(f);
	
	// Reopen file to write additional data at the end of the file
	var f = file_text_open_append_ue("save.txt");
	file_text_writeln_ue(f, "Bye!");
	file_text_close_ue(f);
	
	// Open file, read all the content in the file and print to output window
	var f = file_text_open_read_ue("save.txt");
	while (!file_text_eof_ue(f)) {
		show_debug_message(file_text_readln_ue(f));
	}
	file_text_close_ue(f);
	
	
	
File/directory search functions:
---------------------------------

- file_find_first_ue(mask)
    Begins the search (non-recursive) for files/directories matching the given mask and returns the first result.
    Returns empty string if nothing to be found.

- file_find_next_ue()
    Returns the next files/directories matching the given mask.
    Returns empty string if no more results left.

- file_find_attributes_ue()
    Returns the attributes of the most recently returned file in search.
     
- file_find_size_ue()
    Returns the size of the most recently returned file in search.

- file_find_close_ue()
    Finalizes the current search. 
	
	* Examples:
	// List all files (with size in bytes) and directories in 'C:/Program Files/'
	for (var f = file_find_first_ue("C:/Program Files/*"); f != ""; f = file_find_next_ue()) {
		if (file_find_attributes_ue() & fa_directory) 
			show_debug_message(f + " [DIR]");
		else
			show_debug_message(f + " (" + string(file_find_size_ue()) + " bytes)");
	}
	file_find_close_ue();

	

Miscs:
---------------------------------

- working_directory_ue
    Returns the game executable's current path.
	* Example: var path = working_directory_ue();
	
- environment_get_variable_ue(name)
    Returns the value (a string) of the environment variable with the given string.
	* Example: var value = environment_get_variable_ue("APPDATA");
	