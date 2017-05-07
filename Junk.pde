/* THIS IS A STORAGE AREA FOR JUNK CODE I WROTE THAT MAY BE USEFUL IN THE FUTURE

   // Returns the number of right square brackets in a REPEAT structure - needed for a correct implementation of iterative nesting
   int number_of_RBs()
   {  int result = 0;
      for ( int x = 0 ; x < commands.length ; x++ ) if ( (commands[x].equals("]")) ) result++;
      return result;
   }
   
   // Returns the number of REPEATs in a command - needed for a correct implementation of iterative nesting
   int number_of_REPEATs()
   {  int result = 0;
      for ( int x = 0 ; x < commands.length ; x++ ) if ( (commands[x].equals("REPEAT")) ) result++;
      return result;
   }
   
   // Finding the other REPEATs in a multi-REPEAT command string [ important for evaluating possible iterative nesting versus sequential looping ]
   int[] REPEAT_positions()
   {  int[] positions = new int[number_of_REPEATs()];
      int pos_counter = 0;
      for ( int x = 0 ; x < commands.length ; x++ ) 
      {  if ( (commands[x].equals("REPEAT")) )
         {  positions[pos_counter] = x;
            pos_counter++;
         }
      }
      return positions;
   }  
   
   // Checking for iterative nesting
   boolean REPEAT_in_REPEAT()
   {  boolean _2meta4me = false;
      if ( ( commands[0].equals("REPEAT") ) && ( commands[1].equals("[") ) && ( (REPEAT_positions()[1]) < returnFirstRB() ) ) _2meta4me = true;
      return _2meta4me; 
   }
   
   // Returns the first RB position
   int returnFirstRB()
   {  int x;
      for ( x = 0 ; x < commands.length ; x++ ) if ( (commands[x].equals("]")) ) break;
      return x;
   }
   
   // Returns the index position of the right square bracket [invoked during REPEAT evaluation] {there's a hack used to handle nested loops that returns the last right sq bracket}
   int returnRBpos()
   {  if ( number_of_RBs() == 1 )
      {  int x;
         for ( x = 0 ; x < commands.length ; x++ ) if ( (commands[x].equals("]")) ) break;
         return x;
      }
      else if ( ( number_of_REPEATs() > 1 ) && ( REPEAT_in_REPEAT() ) )
      {  int RB_counter = 0;
         int x;
         for ( x = 0 ; x < commands.length ; x++ ) 
         {  if ( (commands[x].equals("]")) )
            {  RB_counter++;
               if ( RB_counter == number_of_RBs() ) break;
            }
         }
         return x;
      }
      else return commands.length-1; 
   }

*/
