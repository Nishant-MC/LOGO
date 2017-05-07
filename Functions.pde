// Does a char-String conversion
String char_to_String(char a)
{  char data[] = {a};
   return new String(data);
}

// Does an int-String conversion
String int_to_String(int a)
{  return "" + a;
}

// String copy function (from a string array)
String string_copy(String[] commands, int index)
{  String result = "";
   result += commands[index];
   return result;
}

// Recombines a string array into a space-delimited command string
String recombineStrings(String[] commands)
{  String result = "";
   for ( int i = 0 ; i < commands.length ; i++ )
   {  result += commands[i];
      result += " ";
   }
   return result;
}

// Checks if a given string is a positive integer
boolean isInt(String a)
{  for ( int i = 0 ; i < a.length() ; i++ )
   {  // ASCII range of the characters 0-9 is 48 to 57
      if ( ( int(a.charAt(i)) >= 48)  && ( int(a.charAt(i)) <= 57 ) )  continue;
      else return false;
   }
   return true;
}

// Checks if a given string is a mathematical operator for addition, subtraction, multiplication, division or modulus [+,-,*,/,%]
boolean isOperator(String a)
{  if ( ( a.equals("+") ) || ( a.equals("-") ) || ( a.equals("*") ) || ( a.equals("/") ) || ( a.equals("%") ) ) return true;
   else return false;
}

// Converts a given string to a positive integer (if possible)
int toInt(String a)
{  int result = 0;
   if (isInt(a))
   {  for ( int i = 0 ; i < a.length() ; i++ )
      {  result *= 10;
         result += (int(a.charAt(i)) - 48);
      }
      return result;
   }
   else return -1;
}

// Deletes the "draw" array and resets the draw counter
void clear_lines(XYLine[] draw_commands)
{  for ( int i = 0 ; i < draw_counter ; i++ ) draw_commands[i] = null;
   draw_counter = 0;
}

// "Clears" the LOGO screen
void clrscr()
{  fill(0);
   rect(0,0,width,height);
   fill(255);
}

// Currently only displays the command line and draw array (MAY DO MORE IN THE FUTURE)
void header()
{  stroke(0);
   text("?"+command_line[command_counter-3],20,height-100);
   text("?"+command_line[command_counter-2],20,height-82);
   text("?"+command_line[command_counter-1],20,height-64);
   text("?"+buffer,20,height-46);

   // Displays the draw array
   for ( int i = 0 ; i < draw_counter ; i++ ) draw_commands[i].draw_line();
}
