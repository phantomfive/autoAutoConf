#!/usr/bin/tclsh
set sources {}
set headers {}
set libraryName "a"
set version     "0.1.2"


#-----------------------------------------------------------------
#Here we parse the command line arguments. Obviously.
#-----------------------------------------------------------------
set collectingSources     0
set collectingHeaders     0
set collectingLibraryName 0
set collectingVersion     0
foreach parameter $argv  {

	#Every parameter is of the format --param <args>
	#In this section we parse the <args>. Later we parse the --param
	if { ![string match "--*" $parameter]} {
		if {$collectingSources==1} {
			lappend sources $parameter

		} elseif {$collectingHeaders==1} {
			lappend headers $parameter

		} elseif {$collectingLibraryName==1} {
			set libraryName $parameter
			set collectingLibraryName 0

		} elseif {$collectingVersion==1} {
			set version $parameter
			set collectingVersion 0

		} else {
			puts "Unrecognized parameter: $parameter"
			exit
		}

		continue;
	}
	
	#reset our variables that do the communicating between
	#the top section and the bottom section
	set collectingSources     0
	set collectingHeaders     0
	set collectingLibraryName 0
	set collectingVersion     0

	#And in this section we parse the --param
	if { $parameter=="--sources" } {
		set collectingSources 1
	
	} elseif { $parameter=="--headers" } {
		set collectingHeaders 1
	
	} elseif { $parameter=="--version" } {
		set collectingVersion 1
	
	} elseif { $parameter=="--name" } {
		set libraryName 1

	} else {
		puts "Unrecognized parameter: $parameter"
		exit
	}
}


foreach file $sources {
	puts "Found file $file"
}

foreach header $headers {
	puts "Found header $header"
}

puts "Using library name $libraryName"
puts "Using version $version"


