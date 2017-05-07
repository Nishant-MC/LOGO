class Turtle
{  float x;
   float y;
   float angle;
   boolean show_turtle;
   boolean turtle_writing;
   
   // Turtle constructor
   Turtle(float w, float h, float a)
   {  x = w;
      y = h;
      angle = a;
      show_turtle = false;
      turtle_writing = true;
   }
   
   // Setter that controls the turtle's angle
   void set_angle(float a)
   {  angle = a;  }
   
   // Setters for the turtle's x and y positions
   void set_x(float w)
   {  x = w;  }
   void set_y(float h)
   {  y = h;  }
   
   // Setters that control the turtle's visibility
   void show_turtle()
   {  show_turtle = true;  }
   void hide_turtle()
   {  show_turtle = false; }
   
   // Setters that control whether the turtle can write or not
   void pen_down()
   {  turtle_writing = true;  }
   void pen_up()
   {  turtle_writing = false; }
   
   // Turtle display routine
   void display()
   {  if (show_turtle == true) 
      {  fill(255);
         ellipse(x,y,20,20);
         
         // Red line rendering
         stroke(255,0,0);
         strokeWeight(2);
         line( x + (cos(radians(angle))*10) , y + (sin(radians(angle))*10) , x , y);
         strokeWeight(1);
         stroke(0);
      }
   }
   
}

class Command
{  String[] commands;
   String raw_commands;
   int number_of_tokens;
   
   // Command constructor
   Command (String command)
   {  raw_commands = command;
      commands = splitTokens(raw_commands);
      number_of_tokens = commands.length;
   }
   
   // Prints the command, token-delimited by a pipeline "|" symbol
   String print_command()
   {  String result = "";
      for ( int i = 0 ; i < commands.length ; i++ )
      {  result += commands[i]; 
         result += "|";
      }
      return(result);
   }
   
   // Section returner from the commands[] array - needed for implementation of REPEAT - returns a subarray from index i to index j
   String[] return_subarray(int i, int j)
   {  String[] commands_copy = new String[ ( j - i ) + 1 ];
      for ( int x = 0 ; x < commands_copy.length ; x++ ) commands_copy[x] = string_copy(commands, x + i);
      return commands_copy;
   }
   
   // Evaluating iteration [finding the correct RSQB - right square bracket - position] to execute the correct amount of commands for REPEAT
   int evaluate_iteration()
   {  int REP_counter = 0;
      int LSQB_counter = 0;
      int RSQB_counter = 0;
      int x;
      
      for ( x = 0 ; x < commands.length ; x++ )
      {  if ( commands[x].equals("REPEAT") ) REP_counter++;
         if ( commands[x].equals("[") ) LSQB_counter++;
         if ( commands[x].equals("]") ) RSQB_counter++;
                  
         if ( ( LSQB_counter == RSQB_counter ) && ( LSQB_counter != 0 ) ) break;
      }
      
      return x;  
   }
   
   // Evaluating print statements
   String evaluate_print()
   {  String result = "";
   
      // Print is not yet fully functional! It cannot "truly" handle mathematical expressions yet so I'm keeping this stopgap
      if ( ( isOperator(commands[2]) ) && ( isInt(commands[1]) ) && ( isInt(commands[3]) ) && (commands.length >= 5) ) result += "Print is not yet fully functional for complex math expressions! Sorry!";
   
      // Handling mathematical expressions
      else if ( ( isOperator(commands[2]) ) && ( isInt(commands[1]) ) && ( isInt(commands[3]) ) )
      {  if ( commands[2].equals("+") ) result += int_to_String(toInt(commands[1]) + toInt(commands[3]));
         else if ( commands[2].equals("-") ) result += int_to_String(toInt(commands[1]) - toInt(commands[3]));
         else if ( commands[2].equals("*") ) result += int_to_String(toInt(commands[1]) * toInt(commands[3]));
         else if ( commands[2].equals("/") ) result += int_to_String(toInt(commands[1]) / toInt(commands[3]));
         else if ( commands[2].equals("%") ) result += int_to_String(toInt(commands[1]) % toInt(commands[3]));
         else result += "ERROR: Invalid mathematical expression! ";
      }
      
      // Handling SUM / SUB / MULT / DIV / MOD
      else if ( ( ( commands[1].equals("SUM") ) || ( commands[1].equals("ADD") ) ) && ( isInt(commands[2]) ) && ( isInt(commands[3]) ) ) 
      {  result += int_to_String(toInt(commands[2]) + toInt(commands[3]));
      }
      
      else if ( ( ( commands[1].equals("MULT") ) || ( commands[1].equals("MULTIPLY") ) ) && ( isInt(commands[2]) ) && ( isInt(commands[3]) ) ) 
      {  result += int_to_String(toInt(commands[2]) * toInt(commands[3]));
      }
      
      else if ( ( ( commands[1].equals("SUB") ) || ( commands[1].equals("SUBTRACT") ) ) && ( isInt(commands[2]) ) && ( isInt(commands[3]) ) ) 
      {  result += int_to_String(toInt(commands[2]) - toInt(commands[3]));
      }
      
      else if ( ( ( commands[1].equals("DIV") ) || ( commands[1].equals("DIVIDE") ) ) && ( isInt(commands[2]) ) && ( isInt(commands[3]) ) ) 
      {  result += int_to_String(toInt(commands[2]) / toInt(commands[3]));
      }
      
      else if ( ( ( commands[1].equals("MOD") ) || ( commands[1].equals("MODULUS") ) ) && ( isInt(commands[2]) ) && ( isInt(commands[3]) ) ) 
      {  result += int_to_String(toInt(commands[2]) % toInt(commands[3]));
      }
      
      else result += recombineStrings ( return_subarray ( 1 , commands.length-1 ) ) ;
   
      return result;
   }
   
      
   // This is where all the LOGO magic happens... presumably
   void execute_command()
   {  
      // Handling no input [do nothing]
      if ( commands.length == 0 );
     
      // Handling PRINT and REPEAT detritus [begins with a ">>" or "]"]
      else if ( (commands[0].equals(">>")) || (commands[0].equals("]")) )
      {  // Do nothing except refresh the display
         clrscr();
         header();
         turtle.display();
      }
      
      // Handling a PRINT command first and foremost - a PRINT command invalidates all other commands that follow it and merely prints text to the command line 
      // (SUM/SUB/MULT/DIV/MOD and mathematical expressions still get evaluated pre-printing
      else if ( (commands[0].equals("PRINT")) )
      {  // Adding print results to the command line so they become visible
         // command_line[command_counter] = new String( " >> " + recombineStrings ( return_subarray ( 1 , commands.length - 1 ) ) ) ;
         command_line[command_counter] = new String( " >> " + evaluate_print() ) ;
         command_counter++;
         
         clrscr();
         header();
         turtle.display();
      }
     
      // Handling the ST [show turtle] command
      else if ( (commands[0].equals("ST")) && (number_of_tokens == 1) )
      {  turtle.show_turtle();
         clrscr();
         header();
         turtle.display();
      }
      
      // Handling the HT [hide turtle] command
      else if ( (commands[0].equals("HT")) && (number_of_tokens == 1) )
      {  turtle.hide_turtle();
         clrscr();
         header();
         turtle.display();
      }
      
      // Handling the PU [pen up] command
      else if ( (commands[0].equals("PU")) && (number_of_tokens == 1) )
      {  turtle.pen_up();
         clrscr();
         header();
         turtle.display();
      }
      
      // Handling the PD [pen down] command
      else if ( (commands[0].equals("PD")) && (number_of_tokens == 1) )
      {  turtle.pen_down();
         clrscr();
         header();
         turtle.display();
      }
      
      // Handling the FD [forward] command
      else if ( (commands[0].equals("FD")) && (number_of_tokens == 2) )
      {  if (isInt(commands[1]))
         {  draw_commands[draw_counter] = new XYLine( turtle.x, turtle.y, turtle.x + ( cos(radians(turtle.angle))*toInt(commands[1]) ) , turtle.y + ( sin(radians(turtle.angle))*toInt(commands[1]) ) );
            turtle.set_x( turtle.x + ( cos(radians(turtle.angle))*toInt(commands[1]) ) ); turtle.set_y( turtle.y + ( sin(radians(turtle.angle))*toInt(commands[1]) ) );
            draw_counter++;
            
            clrscr();
            header();
            turtle.display();
         }
      }
      
      // Handling the BK [backward] command
      else if ( (commands[0].equals("BK")) && (number_of_tokens == 2) )
      {  if (isInt(commands[1]))
         {  draw_commands[draw_counter] = new XYLine( turtle.x, turtle.y, turtle.x - ( cos(radians(turtle.angle))*toInt(commands[1]) ) , turtle.y - ( sin(radians(turtle.angle))*toInt(commands[1]) ) );
            turtle.set_x( turtle.x - ( cos(radians(turtle.angle))*toInt(commands[1]) ) ); turtle.set_y( turtle.y - ( sin(radians(turtle.angle))*toInt(commands[1]) ) );
            draw_counter++;
            
            clrscr();
            header();
            turtle.display();
         }
      }

      // Handling the RT [turn right; clockwise] command
      else if ( (commands[0].equals("RT")) && (number_of_tokens == 2) )
      {  if (isInt(commands[1]))
         {  turtle.set_angle( turtle.angle + toInt(commands[1]) );
            
            clrscr();
            header();
            turtle.display();
         }
      }
      
      // Handling the LT [turn left; counter-clockwise] command
      else if ( (commands[0].equals("LT")) && (number_of_tokens == 2) )
      {  if (isInt(commands[1]))
         {  turtle.set_angle( turtle.angle - toInt(commands[1]) );
            
            clrscr();
            header();
            turtle.display();
         }
      }

      // Handling the HOME [return to center] command
      else if ( (commands[0].equals("HOME")) && (number_of_tokens == 1) )
      {  turtle.set_x(width/2);
         turtle.set_y(height/2);
         turtle.show_turtle();
         
         clrscr();
         header();
         turtle.display();
      }
      
      // Handling the CS [clear screen and return turtle to home] command
      else if ( (commands[0].equals("CS")) && (number_of_tokens == 1) )
      {  // Set the turtle's position back to HOME position, shows the turtle, and sets the angle back to the default angle (270 / 90 up)
         turtle.set_x(width/2);
         turtle.set_y(height/2);
         turtle.show_turtle();
         turtle.set_angle(270);
         
         clear_lines(draw_commands);
         
         clrscr();
         header();
         turtle.display();
      }
      
      // Handling the CLEAN [clear draw array, keep the turtle where it is] command
      else if ( (commands[0].equals("CLEAN")) && (number_of_tokens == 1) )
      {  // Show the turtle, clear the draw array
         turtle.show_turtle();
         clear_lines(draw_commands);
         
         clrscr();
         header();
         turtle.display();
      }
      
      // Handling REPEAT [iteration structures]
      else if ( (commands[0].equals("REPEAT")) && (number_of_tokens >= 2) )
      {  // Handling recursion is a non-trivial problem!! Each line here is very important and its purpose is explained
         
         // Check that an INT [integer] follows REPEAT
         if (isInt(commands[1]))
         {  // Getting the number of times a recursive call needs to be made
            int number_of_iterations = toInt(commands[1]);
            int RSQB_pos = evaluate_iteration(); 
            
            // Executing what lies inside the iteration structure
            for ( int y = 0 ; y < number_of_iterations ; y++ )
            {  // Test line which checks that the recursion will approach a base case
               // println( ( new Command ( recombineStrings ( return_subarray ( 3 , commands.length - 2 ) ) ) ).print_command() );
               
               // Stripping REPEAT, [some integer], "[" and "]" before undergoing execution recursion               
               ( new Command ( recombineStrings ( return_subarray ( 3 , RSQB_pos ) ) ) ).execute_command();
            }
            
            // Executing anything that comes after the iterative structure [if it exists]
            // println(RSQB_pos + " " + commands.length + " " + (RSQB_pos<commands.length-1) );
            if ( RSQB_pos < (commands.length - 1) )
            {  ( new Command ( recombineStrings ( return_subarray ( RSQB_pos + 1 , commands.length - 1 ) ) ) ).execute_command();  }
         
         }
      
         // Refresh the screen
         clrscr();
         header();
         turtle.display();
      }
      
      // Handling compound commands (number of tokens >= 2)
      else if ( (number_of_tokens >= 2) )
      {  
         // Handling one token commands
         if ( (commands[0].equals("CS")) || (commands[0].equals("HT")) || (commands[0].equals("ST")) || (commands[0].equals("PU")) || (commands[0].equals("PD")) || (commands[0].equals("CLEAN")) || (commands[0].equals("HOME")) || (commands[0].equals("BYE")) )
         {  
            // Executing the one token command
            ( new Command ( recombineStrings ( return_subarray ( 0 , 0 ) ) ) ).execute_command();
            
            // Executing the rest of the command string [recursive call]
            ( new Command ( recombineStrings ( return_subarray ( 1 , commands.length - 1 ) ) ) ).execute_command();
         }
         
         // Handling two token commands
         else if ( ( (commands[0].equals("FD")) || (commands[0].equals("BK")) || (commands[0].equals("LT")) || (commands[0].equals("RT")) ) && (isInt(commands[1])) )
         {  
            // Executing the two token command
            ( new Command ( recombineStrings ( return_subarray ( 0 , 1 ) ) ) ).execute_command();
            
            // Executing the rest of the command string [recursive call]
            ( new Command ( recombineStrings ( return_subarray ( 2 , commands.length - 1 ) ) ) ).execute_command();
         }
      }
      
      // Handling the BYE [quit] command
      else if ( (commands[0].equals("BYE")) && (number_of_tokens == 1) )
      {  exit();
      }
      
      // Catchall for handling exceptions
      else
      {  command_line[command_counter] = new String(" >> Invalid command!");
         println(print_command());
         command_counter++;
         clrscr();
         header();
         turtle.display();
      }
   
   }
}


// XYLine class - used to graphically repesent the lines made by the fLOGO user
class XYLine
{  float x1;
   float x2;
   float y1;
   float y2;
   boolean line_visible;
   
   // XYLine constructor
   XYLine(float a1, float b1, float a2, float b2)
   {  x1 = a1;
      x2 = a2;
      y1 = b1;
      y2 = b2;
      if ( (turtle.turtle_writing == true ) ) line_visible = true;
      else line_visible = false;
   }
   
   // Line drawing function
   void draw_line()
   {  
      // If the turtle is able to write, draw a white line
      if ( (line_visible == true ) )
      {  stroke(255);
         line(x1,y1,x2,y2);
         stroke(0);
      }
      
      // If the turtle has it's pen up, draw a black line
      else
      {  stroke(0);
         line(x1,y1,x2,y2);
      }
   }
}
