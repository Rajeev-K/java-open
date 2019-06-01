# java-open
This emacs extension lets you open Java source files by placing the cursor on the class name and pressing a key.

## What is it?
java-open.el lets you open Java source files by placing the cursor on the class name and pressing a key.

## How does it work?
Java is different from other languages in that something like etags is really not necessary to figure out locations of files.
This is because Java restricts you to one public class per source file, and the name of the file must be the same as the class. When this class is used in other files, an import declaration must be used. The import declaration specifies the location of the class.

All Emacs needs to do to open the Java source file corresponding to the class name under point is to look for the import declaration, and figure out the filename and relative path from this declaration. Then a variable similar to CLASSPATH can be used to determine the absolute path.

