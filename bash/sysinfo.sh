#!/bin/bash

# Testing if the script is run with root privilage and if not, exit
if [ "$(id -u)" != "0" ]; then
	echo "You need to be root for this script";
	exit 1
fi

# Importing the function library to load functions and variables
source reportfunctions.sh

# Variables Designed to Store Command Output
lshwOutput=$(lshw)
lscpuOutput=$(lscpu)
dmidecodeOutput=$(dmidecode)
lsblkOutput=$(lsblk)


# Refactor variables used to determine script behavior.
verbose=false
systemReport=false
diskReport=false
networkReport=false
fullReport=true


# A while loop is established to filter and iterate through commands.
while [ $# -gt 0 ]; do
	# case command is used to create options for the script
	case ${1} in
		# -h \ --help option displays the help function
		# displayhelp function is called
		-h | --help)
		displayHelp
		exit 0
		;;
		# -v \ --verbose option to run script verbosely.
		# verbose variable value is changed to true
		-v | --verbose)
		verbose=true
		;;
		# -s \ --system option to display only system report
		# systemReport variable value is changed to true
		-s | --system)
		systemReport=true
		;;
		# -d \ --disk option to display only disk report
		# diskReport variable value is changed to true
		-d | --disk)
		diskReport=true
		;;
		# -n \ --network option to display only network report
		# networkReport variable value is changed to true
		-n | --network)
		networkReport=true
		;;
		# any other option except the ones mentioned above give a error
		*)
		echo "Invalid option
Usage: sysinfo.sh [Options]
try 'sysinfo.sh --help' for information"
		errorMessage "$@"
		exit 1
		;;
	esac
	shift
done

# If statements are utilized to examine the options requested by a user via the command line. This is accomplished by comparing the values of variables established to define the behavior of a script.

# If the verbose value is set to true, the script will execute in a verbose manner, providing detailed information, and any errors that occur will be shown to the user.
if [[ "$verbose" == true ]]; then
	fullReport=false
	errorMessage
fi

# If the systemreport variable is set to true, only the computer information, CPU information, OS information, RAM information, and video card information will be displayed.
if [[ "$systemReport" == true ]]; then
	fullReport=false
	computerreport
	osreport
	cpureport
	ramreport
	videoreport
fi

# if the diskReport variable is true, then display only the disk information.
if [[ "$diskReport" == true ]]; then
	fullReport=false
	diskreport
fi

# If the networkreport variable is set to true, then only the network interface information will be shown.
if [[ "$networkReport" == true ]]; then
	fullReport=false
	networkreport
fi

# If the user doesn't select or input any options, the system will display the full report.
if [[ "$fullReport" == true ]]; then
    computerreport
    osreport
    cpureport
    ramreport
    videoreport
    diskreport
    networkreport
fi
