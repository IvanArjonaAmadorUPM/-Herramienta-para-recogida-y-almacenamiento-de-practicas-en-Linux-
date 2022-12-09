# Tool-for-collection-and-storage-of-practices-in-Linux

gestiona-prac.sh

This Bash script provides a menu-driven tool for managing practices in Linux. It includes options for scheduling the collection of practices, creating a package of practices for a given subject, and viewing the size and date of a subject's file.

To use the script, run gestiona-prac.sh without any parameters. The script will present a menu of options to choose from.

Option 1 allows the user to schedule the collection of practices for a given subject. The script will prompt the user for information about the subject, such as the location of the practices and the destination for them. If the source directory does not exist, the script will display a message and write it to the log file, and will prompt the user again for the information. If the destination directory does not exist, it will be created.

Option 2 creates a package of practices for a given subject. The script will prompt the user for the subject and the destination for the package. If the destination directory does not exist, it will be created.

Option 3 displays the size and date of a subject's file. The script will prompt the user for the subject and will display the information if the file exists.

Option 4 exits the script.

Errors and actions taken by the script will be logged in a file called informe-prac.log.
