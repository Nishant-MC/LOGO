// fLOGO - a fake Graphical User Interface (GUI) for the LOGO programming language
// Author - Nishant Mohanchandra, NYUAD Student, 3rd year [Junior] Computer Science [CS] major (as of 2013)
// Questions? Comments? E-mail me at: nm1345@nyu.edu

// This interface was designed to closely mimic the LOGO programming interface, designed by Seymour Papert [MIT] in 1960
// Its express purpose is to teach young children the basics of computer programming in a "fun" way

// Personally I think LOGO is an *extremely* defunct and useless relic of a bygone era in computer science
// If I was designing a CS curriculum aimed at young children, I would just start them off directly with Python or ProcessingJS
// However, the Nepali Computer Science curriculum used at GN Boarding School mandates learning LOGO's language and command set from Class 2 onwards
// ... And this is why I created fLOGO

// Should the program code need maintenance or editing, I have left my work well-commented
// Pretty much anyone with a brain and a basic understanding of Java (ProcessingJS in particular) should be able to edit it according to their needs

// Good luck, have fun (GL, HF) and happy hunting! Hopefully you will find this program useful
// It took about 6-7 hours of total programming time spread over 4 days to finish implementing the basic functions
// All this code is free, open-source, and editing to suit your needs is encouraged 


// Command buffer
String buffer = "";

// Command line + command counter
String[] command_line;
int command_counter = 3;

// Execution array + execution counter
Command[] parsed_commands;
int execute_counter = 0;

// Draw array + draw counter
XYLine[] draw_commands;
int draw_counter = 0;

// Turtle definition
Turtle turtle;

// The setup() function - sets aside space for the needed arrays and populates the command line
void setup()
{  
   // Setting up the window
   background(0);
   size(1366,728);
   
   // Setting up the command line
   command_line = new String[10000];
   command_line[0] = "FOREACH is defined!";
   command_line[1] = "All set, have fun!!";
   command_line[2] = "Toplevel";

   // Setting up the execution array and draw array
   parsed_commands = new Command[10000];
   draw_commands = new XYLine[10000];

   // Displaying the header and the turtle
   header();
   turtle = new Turtle(width/2,height/2,270);
   turtle.display();
  
   // TEST AREA - use as needed
   
}


// The draw() function is empty - redrawing anything over and over in it produced weird visual effects
void draw()
{  
}

// keyTyped() is where most of the command processing happens
void keyTyped()
{  
   // If the key typed is NOT enter
   if (key != ENTER) 
   {  
      // If the key typed is backspace and something can be removed from the buffer
      if ( (key == BACKSPACE) && (buffer.length() > 0) ) 
      buffer = buffer.substring(0,buffer.length()-1);
      
      // Do nothing if the buffer is empty
      else if ( (key == BACKSPACE) && (buffer.length() == 0) );
      
      // Else add the key to the buffer (in upper case wherever applicable)
      else { buffer += char_to_String(key).toUpperCase(); }
      
      clrscr();
      header();
      turtle.display(); 
   }
   
   // Handling enter being pressed
   else
   {  command_line[command_counter] = new String(buffer);
      command_counter++;
     
      parsed_commands[execute_counter] = new Command(buffer);
      parsed_commands[execute_counter].execute_command();
      execute_counter++;
      
      buffer = "";
      
      clrscr();
      header();
      turtle.display();
   }
}
