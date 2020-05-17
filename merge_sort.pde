int state = 0; /*the state indicates the stage the program is at, 0 is the menu,
1 is with example values, 2 is with a users own numbers, and 3 is the explanation page*/

int boxwidth = 75; //the size of each of the boxes that the represent one element of the arrays
int stageOfVisualisation = 0; /*the stage of visualisation is the point of the animation we are at
a higher stage means more is displayed vs a lower stage*/

boolean inputNumbers = false; //if true it asks the user to input their own numbers
boolean isNumber = true; /*if false the number string inputted contains letters so must be
inputted again*/

//all the buttons that the program uses:
Button exampleNumbers;
Button ownNumbers;
Button explainMergeSort;
Button home;
Button next;
Button prev;

int percentage=0; //used to calculate how far to along a given path a moving object is
int counter = 0; //used at many stages to increment and used as an exit condition

boolean firstLower = false; //boolean used in the comparrsion of sblists

float[] movementStart; /*movementStart arrays contains the start point of the paths along
which the arrays and objects move*/
float[] movementEndHeight; //this contains the height of these paths
float movementEnd; //finishing point of the paths

String userInput = ""; //the empty string replaced with the users inputted values

String confirmedUserInput = ""; //used to store confirmedUserInput text when user has hit enter.


//these are all the coordinates and sizes of the buttons uses
int[] button1 = {(width/2)-150, 300, 300, 100};
int[] button2 = {(width/2)-150, 425, 300, 100};
int[] button3 = {(width/2)-150, 550, 300, 100};
int[] homeButton = {0, 0, 80, 40};       

//used values is replaced with either examples values of a users inputs
int[] usedValues = {2, 1, 23, 13, 9, 8, 10};
int[] exampleValues = {38, 27, 43, 3, 9, 82, 10};
int[] newValues = new int[7];
int[] newValuesDup = new int[7]; //used in duplicating arrays

//these 6 arrays are used to store the sublists of the merge sort as it split up
int[] array1 = new int[2];
int[] array2 = new int[2];
int[] array3 = new int[2];
int[] array4 = new int[1];
int[] array5 = new int[4];
int[] array6 = new int[3];

int[] firstHalf = new int[4]; //first half of the sorted array
int[] secondHalf = new int[3]; //second half of the sorted array
int[] finalSort = new int[7]; //completely sorted array


int boxToMove; //which array box to manipulate and move

/* called at the beginning of the program but only then, this is when variables are assigned and constructors
 * called in order to assign values to everything
 */
void setup() { 
  size(1280, 720); //size set according to specification
  surface.setTitle("Merge Sort"); //title of the application set

  //buttons given their coordinates this needed to be done beforehand in order for 
  button1[0] = (width/2)-150;
  button2[0] = (width/2)-150;
  button3[0] = (width/2)-150;
  homeButton[1] = height-40;
  
  //the original start of the array is set with the first movementStart and endHeight values
  //this is for the first 7 boxes at the very top (the original array)
  movementStart = new float[100];
  movementStart[0] = (width/2) - 3.5*(boxwidth+5);
  movementEndHeight = new float [100];
  movementEndHeight[0] = 15;
  
  /*the buttons are created by calling their constructors with the approriate arrays. The arrays donate
  the position and size of the buttons whilst the text represents what will be put ion the buttons and the 
  final number the size of that text*/
  exampleNumbers = new Button(button1, "Run with example numbers", 20);
  ownNumbers = new Button(button2, "Run with your own numbers", 20);
  explainMergeSort = new Button(button3, "Merge sort explanation", 20);
  home = new Button(homeButton, "Home", 20);
}

/* Draw is continuously called throught the program in this programming any moving objects are drawn in the
 * draw function. This is because due to the incremental nature of some values they cannot be placed in subfunctions.
 * Stationary objects are drawn in the merge function which is called within draw in order to make the program
 * cleaner.
 */
void draw() { 
  background(#75FC7B); //background set to pastel green
  if(state == 0){ //if the state is 0 it is a title screen so call the title function
    title(); //this draws the titles
    
    //also draw all the buttons associated with the titles
    exampleNumbers.drawButton();
    ownNumbers.drawButton();  
    explainMergeSort.drawButton();
  }
  else{
    //otherwise a homebutton is needed regardless of the state because we are not at the menu
    home.drawButton();  
  }
  if(state==3){title();} //if state is three then the epxlanation needs to come up which is located in the title function too
  if(state==1 || state == 2){ //otherwise the visualisation is occuring
    if(state == 2 && inputNumbers == true){ //if inputNumbers is true this means the user needs to input numbers
      if(counter < 7){ //if less than 7 numbers have been inputted
        int indent = width/2; //the point to draw the tet
        fill(0);
        
        text("Click in this window and type. \nHit enter to save. ", indent, 40);
        text("Input: " + userInput,indent,190);
        text("confirmed number: " + confirmedUserInput,indent,230);
        if(confirmedUserInput.matches(".*[a-zA-Z]+.*")){ //if the input contaisn any letters
          isNumber=false; //it isnt a number
        }
        if(confirmedUserInput.length()>0 && confirmedUserInput.matches(".*[a-zA-Z]+.*")==false){
        //if it is more than no characters and also has no letters
          isNumber=true; //it is a number
          counter++; //so the counter is incremented
          usedValues[counter-1] = Integer.parseInt(confirmedUserInput); //and it is put into the usedValues array
        }
        if(!isNumber) text("Sorry that wasn't a number please try again",width/2, 400); //otherwise display erros messgaes
        confirmedUserInput = "";
        if(counter > 6) inputNumbers = false;
      }
    }
    if(state==2 && inputNumbers == false || state ==1){ //if no usernumbers are needed to be inputted the visualisation continues
    merge(); //all stationary objects at this stage are drawn
    if(stageOfVisualisation == 3){ //if the stage of visualisation is three it is time for the first split
      if(movementStart[0] < 40 && movementEndHeight[0] > 150) stageOfVisualisation ++; //when the box arraive at the correctbplace increment the stage
      textAlign(CENTER, CENTER);
      for(int i=0; i < 4; i++){ //draw the four boes that a moving
        fill(255);
        stroke(0);
        rect(movementStart[0]+(i*(boxwidth+5)), movementEndHeight[0], boxwidth, boxwidth);
        fill(0);
        text(usedValues[i], movementStart[0]+(i*(boxwidth+5))+boxwidth/2, movementEndHeight[0]+boxwidth/2);        
      }
      movementStart[0]= movementStart[0] - 1.5; //and incrmement their x coordinates ready for the next calling of the draw
      float x = ((width/2) - 3.5*(boxwidth+5))-40;
      x = 1/x;
      x = x * 146;
      movementEndHeight[0] = movementEndHeight[0]+(1.5*x); //add the correct percentage of y to match the change in x
   }
   //when the stage is 5 is ready for the next movement of half the array
   if(stageOfVisualisation == 5){
      if(movementStart[1] > width-(boxwidth+5)*3-40 && movementEndHeight[1] > 150) stageOfVisualisation ++;
      textAlign(CENTER, CENTER);
      for(int i=0; i < 3; i++){ //this time only 3 boxes are drawn
        fill(255);
        stroke(0);
        rect(movementStart[1]+(i*(boxwidth+5)), movementEndHeight[1], boxwidth, boxwidth);
        fill(0);
        text(usedValues[i+4], movementStart[1]+(i*(boxwidth+5))+boxwidth/2, movementEndHeight[1]+boxwidth/2);        
      }
      movementStart[1] = movementStart[1]+2; //position increased by 1
      float x = (width-(boxwidth+5)*3-40) - ((width/2) - 3.5*(boxwidth+5));
      x = 1/x;
      x = x * 146;
      movementEndHeight[1] = movementEndHeight[1]+(4*x); //and x by the same percentage
   }
   //when the stage is 7 it is time to split the half arrays into smaller sub halfs
   if(stageOfVisualisation == 7){
     if(movementStart[3] > (40+(2*(boxwidth+5)) + 200)) stageOfVisualisation ++; //if the boxes reach their target increase the stage
      textAlign(CENTER, CENTER);
      for(int i=0; i < 2; i++){ //only 2 boxes drawn since fist half of 4
        fill(255);
        stroke(0);
        rect(movementStart[3]+(i*(boxwidth+5)), 161, boxwidth, boxwidth);
        fill(0);
        text(usedValues[2+i], movementStart[3]+(i*(boxwidth+5))+boxwidth/2, 161+boxwidth/2);        
      }
      if(movementStart[4] < (width-(boxwidth+5)*3)-240); //second half hasn't reached the target
      textAlign(CENTER, CENTER);
      for(int i=0; i < 2; i++){ //draw those 2 boxes
        fill(255);
        stroke(0);
        rect(movementStart[4]+(i*(boxwidth+5)), 161, boxwidth, boxwidth);
        fill(0);
        text(usedValues[4+i], movementStart[4]+(i*(boxwidth+5))+boxwidth/2, 161+boxwidth/2);        
      }
      //then incrment the positions of both
      movementStart[4]--;
      movementStart[3]++;
   }
   //then each of the halfs is split again into individual objects using the same principle
   if(stageOfVisualisation == 9){
     if(movementStart[5] > 130+(boxwidth+5)) stageOfVisualisation ++;
      fill(255);
      stroke(0);
      rect(movementStart[5], 161, boxwidth, boxwidth); //first box
      fill(0);
      text(usedValues[1], movementStart[5]+boxwidth/2, 161+boxwidth/2);        
      stroke(0);
      fill(255);
      rect(movementStart[6], 161, boxwidth, boxwidth); //second box
      fill(0);
      text(usedValues[3], movementStart[6]+(boxwidth/2), 161+boxwidth/2);
      stroke(0);
      fill(255);
      rect(movementStart[7], 161, boxwidth, boxwidth); //thirs box
      fill(0);
      text(usedValues[5], movementStart[7]+(boxwidth/2), 161+boxwidth/2);     
      movementStart[5]++; //with those positions incrmementing
      movementStart[6]++;
      if(movementStart[7] < 970){
         movementStart[7]++;
      }
   }
   //at these stages the 2 individual elements of all the pairs this is more complicated 
   if(stageOfVisualisation == 12 || stageOfVisualisation == 14 || stageOfVisualisation == 16){
     if(firstLower){ //if the first of the 2 elements is smaller we don't need to swap them
      if(movementStart[stageOfVisualisation-3] - boxwidth - movementStart[stageOfVisualisation-4] < 11){ //if they get to their points then increment
        stageOfVisualisation ++;       
      }
      else{
        //here the boxes are drawn
        fill(255);
        stroke(0);
        rect(movementStart[stageOfVisualisation-4],movementEndHeight[stageOfVisualisation-4], boxwidth, boxwidth);  
        fill(0);
        text(usedValues[stageOfVisualisation-12], movementStart[stageOfVisualisation-4]+(boxwidth/2), movementEndHeight[stageOfVisualisation-4]+boxwidth/2);   
        fill(255);
        stroke(0);
        rect(movementStart[stageOfVisualisation-3],movementEndHeight[stageOfVisualisation-4], boxwidth, boxwidth);
        fill(0);
        text(usedValues[stageOfVisualisation-11], movementStart[stageOfVisualisation-3]+(boxwidth/2), movementEndHeight[stageOfVisualisation-4]+boxwidth/2);   
        fill(0);
        movementEndHeight[stageOfVisualisation-4]++;
        movementStart[stageOfVisualisation-4] = movementStart[stageOfVisualisation-4]+0.26; //and their psoition values incremented
        movementStart[stageOfVisualisation-3] = movementStart[stageOfVisualisation-3]-0.26;    
      }      
    }
    else{ //this means the first isn't the lower values so tghe positions need to be swapped
      if(movementStart[stageOfVisualisation-4] - boxwidth - movementStart[stageOfVisualisation-3] > 9){
        stageOfVisualisation ++;  //when the boxes are in the right position they are no longer incremented and the stage is increased 
      }
      else{ //boxes are then drawn
        fill(255);
        stroke(0);
        rect(movementStart[stageOfVisualisation-4],movementEndHeight[stageOfVisualisation-4], boxwidth, boxwidth);
        fill(0);
        text(usedValues[stageOfVisualisation-12], movementStart[stageOfVisualisation-4]+(boxwidth/2), movementEndHeight[stageOfVisualisation-4]+boxwidth/2);   
        fill(255);
        stroke(0);
        rect(movementStart[stageOfVisualisation-3],movementEndHeight[stageOfVisualisation-4], boxwidth, boxwidth);
        fill(0);
        text(usedValues[stageOfVisualisation-11], movementStart[stageOfVisualisation-3]+(boxwidth/2), movementEndHeight[stageOfVisualisation-4]+boxwidth/2);   
        fill(0);
        movementEndHeight[stageOfVisualisation-4]++;
        float f = 42.9 / 0.26; //since they have to travel further new distances need to moved each rotation
        f = (42.9+boxwidth+10) / f; //this is done as a percentage of the overall distance needed to be changed 
        movementStart[stageOfVisualisation-4] = movementStart[stageOfVisualisation-4]+(f);
        movementStart[stageOfVisualisation-3] = movementStart[stageOfVisualisation-3]-(f);  //the values are increased by this new amount  
      }      
   }
  }
  if(stageOfVisualisation == 18){
    if(movementEndHeight[13] < 326){
      fill(255);
      stroke(0);
      rect(movementStart[1]+(2*(boxwidth+5)), movementEndHeight[13], boxwidth, boxwidth);  
      fill(0);
      text(usedValues[6], movementStart[1]+(2*(boxwidth+5))+(boxwidth/2), movementEndHeight[13]+boxwidth/2);   
    }
    else{
      stageOfVisualisation++;
    }
    movementEndHeight[13]++;
  }
  
  if(stageOfVisualisation > 19 && stageOfVisualisation < 27 && stageOfVisualisation % 2 == 0){ //this range of values is when the newly formed pairs need to be matched back up    
    if(movementStart[15] != movementStart[16] || movementEndHeight[15] < 480){ //as long as the boxes arent in the correct place keep going
      fill(255);
      stroke(0);
      rect(movementStart[15], movementEndHeight[15], boxwidth, boxwidth);
      fill(0);
      text(newValues[boxToMove], movementStart[15]+(boxwidth/2), movementEndHeight[15]+boxwidth/2); //box drawn at the appropriate movementstart
      //this movement start is changed depending on the stage
      if(movementEndHeight[15] < 480) movementEndHeight[15] = movementEndHeight[15] + 2; //increase distance down each time
      //however we don't knwo whether the ex value will be less or more so we need to check and then decrease it if necessary
      //new movementStart value calculated
      if(movementStart[15] != movementStart[16]){
        if(movementStart[15] < movementStart[16]) movementStart[15]++;
        else movementStart[15]--; 
      }
    }
    else{
      stageOfVisualisation++;
    }
  }
  
  if(stageOfVisualisation > 27 && stageOfVisualisation < 33 && stageOfVisualisation % 2 == 0){ //this range is when the second half (the final three) values are formed into the second half
    //the logic is exactly the same as the if clause above. But the start and end points are different
    if(movementStart[17] != movementStart[18] || movementEndHeight[17] < 480){
      fill(255);
      stroke(0);
      rect(movementStart[17], movementEndHeight[17], boxwidth, boxwidth);
      fill(0);
      text(newValues[boxToMove+4], movementStart[17]+(boxwidth/2), movementEndHeight[17]+boxwidth/2);   
      if(movementEndHeight[17] < 480) movementEndHeight[17] = movementEndHeight[17] + 2;
      if(movementStart[17] != movementStart[18]){
        if(movementStart[17] < movementStart[18]) movementStart[17]++;
        else movementStart[17]--; 
      }
    }
    else{
      stageOfVisualisation++;
    }
  }
  
  //This is the same as above but it merges the 2 havles bacvk into the full set of 7 array elemtents.
  if(stageOfVisualisation > 33 && stageOfVisualisation < 47 && stageOfVisualisation % 2 == 0){
    if(movementStart[19] != movementStart[20] || movementEndHeight[19] < height - 15 - boxwidth){
      fill(255);
      stroke(0);
      rect(movementStart[19], movementEndHeight[19], boxwidth, boxwidth);
      fill(0);
      text(newValuesDup[boxToMove], movementStart[19]+(boxwidth/2), movementEndHeight[19]+boxwidth/2);   
      if(movementEndHeight[19] < height - 15 - boxwidth) movementEndHeight[19] = movementEndHeight[19] + 2;
      if(movementStart[19] != movementStart[20]){
        if(movementStart[19] < movementStart[20]) movementStart[19]++;
        else movementStart[19]--; 
      }
    }
    else{
      stageOfVisualisation++;
    }
   } 
  }
 }
}

/* The function is constantly checked with each repetition as to whether a key is pressed and if so it is acted upon
 * this only happens if the state is 2 and a number needs to be entered in other words when the computer is asking the user
 * for an input
 */
void keyPressed() {
  if(state == 2 && inputNumbers==true){
    // If the return key is pressed save the string and clear it
    if (key == '\n' ) {
      confirmedUserInput = userInput;
      // it is also cleared by setting it equal to ""
      userInput = ""; 
    } else {
      // every character is added to the end of the variable.
      userInput = userInput + key; 
    }
  }
}

/* This is also called every roatation to see if the mouse is clicked within this function I check to see if the mouse is within the boundaries
 * of any of the buttons and if so to act upon it
 */
void mousePressed() {
  if(state == 0){ //menu state
    if(exampleNumbers.hoverOverButton()) { //if over examples
     state = 1; //.change to the appropriate state
     for(int i = 0; i < 7; i++){
       usedValues [i] = exampleValues[i]; //and set the usedValues to the example ones
     }
    }
    if(ownNumbers.hoverOverButton()) { //if own numbers is selected
     state =2; //the state is set
     inputNumbers = true; //this means next iteration through draw the program will ask for the users inputs
     counter =0; //counter set to 0 as user has given no inputs yet
    }
    if(explainMergeSort.hoverOverButton()) { //this measn the explain mergesort button has been held over
     state = 3;
    }
  }  
  if(state != 0 && home.hoverOverButton()){ //if the home button is drawn (not in state 0)
    state = 0;
    stageOfVisualisation= 0; //change back to 0 and return to menu
  }
  if(state ==1 || state == 2){ //otherwise if the visualisation is occuring
    if(next != null && prev != null){ //and the next and previous buttons exist
      if(next.hoverOverButton()){ //if it was the next button that was pressed
        stageOfVisualisation++; //increase the stage
      }
      if(prev.hoverOverButton() && stageOfVisualisation > 0) //otherwise decrease it
      {
        if(stageOfVisualisation == 4 || stageOfVisualisation == 6 || stageOfVisualisation == 8 || stageOfVisualisation == 13 || stageOfVisualisation == 15) stageOfVisualisation--;
        stageOfVisualisation--;
        //it was decreased more for certain stages since that was mid way through an animation
        if(stageOfVisualisation > 19 && stageOfVisualisation < 27) stageOfVisualisation = 19; //these are all in animations
        if(stageOfVisualisation > 27 && stageOfVisualisation < 33) stageOfVisualisation = 27; //so certain reduction is needed
        if(stageOfVisualisation > 33) stageOfVisualisation = 33;
      }
    }
    //These next set of if clauses set the start end end x and y coordinates for all the animations
    if(stageOfVisualisation == 3){
          movementStart[0] = (width/2) - 3.5*(boxwidth+5);
          movementEndHeight[0] = 15;
        }
        if(stageOfVisualisation == 5){
          movementStart[1] = (width/2) + 0.5*(boxwidth+5);
          movementEndHeight[1] = 15;
        }
        if(stageOfVisualisation == 7){
          movementStart[3] = 40+((boxwidth+5)*2);
          movementStart[4] = (width-(boxwidth+5)*3)-40;
        }
        if(stageOfVisualisation == 9){
          movementStart[5] = 40+(boxwidth+5);
          movementStart[6] = (40+(3*(boxwidth+5)) + 200);
          movementStart[7] = movementStart[4]+(boxwidth+5);
        }
        if(stageOfVisualisation == 10){
          movementStart[5] = 130+(boxwidth+5);
          movementStart[6] = (40+(3*(boxwidth+5)) + 290);
          movementStart[7] = 970.25;         
        }
        if(stageOfVisualisation == 12){
          movementStart[8] = movementStart[0];  
          movementStart[9] = movementStart[5];
          movementEndHeight[8] = 161;
        }
        if(stageOfVisualisation == 14){
          movementStart[10] = movementStart[3];
          movementStart[11] = movementStart[6];
          movementEndHeight[10] = 161;
        }
        if(stageOfVisualisation == 16){
          movementStart[12] = movementStart[4];
          movementStart[13] = movementStart[7];
          movementEndHeight[12] = 161;
        }
        if(stageOfVisualisation == 13){
          movementStart[8] = 82.9;  
          movementStart[9] = 167.1;
          movementEndHeight[8] = 326;
        }
        if(stageOfVisualisation == 15){
          movementStart[11] = 527.124;  
          movementStart[10] = 442.87598;
          movementEndHeight[10] = 326;
        }
        if(stageOfVisualisation == 17){
          movementStart[12] = 842.6416;
          movementStart[13] = 927.8684;
          movementEndHeight[12] = 326;
        }
        if(stageOfVisualisation == 18){
          movementEndHeight[13] = 161;
        }
        if(stageOfVisualisation == 20){
          //this is when arrays of more than size one are merged
          array1[0] = newValues[0];
          array1[1] = newValues[1];
         
          array2[0] = newValues[2];
          array2[1] = newValues[3];

          boxToMove = largerArray(array1, array2); //the boxtomove is which element in the overall array needs to be mpoved next
          //it is calculated using largerarray functuion which takes the 2 arrays and works it out
        }
        if(stageOfVisualisation == 22){
          boxToMove = largerArray(array1, array2); //this process is repeated for all the elements of the 2 arrays being merged...
        }
        if(stageOfVisualisation == 24){
          boxToMove = largerArray(array1, array2); //...through here...
        }
        if(stageOfVisualisation == 26){
          boxToMove = largerArray(array1, array2); //...and ending here
        }
        if(stageOfVisualisation > 19 && stageOfVisualisation < 27 && stageOfVisualisation % 2 == 0){
          int i = 0;
          //then depending on which box needs to move the positions are set differetly
          if(boxToMove < 2){ //being less than 2 means the first box to move is in the first array
            if(boxToMove % 2 != 0) i =1;
            movementStart[15] = ceil(movementStart[8+i]);
            movementStart[16] = 171+((boxwidth+5)*((stageOfVisualisation/2) - 10));
            movementEndHeight[15] = 326;
            //these coordinates are then set accordingly
          }
          else //otherwise the coordinates are set differently
          {
            if(boxToMove % 2 != 0) i =1;
            movementStart[15] = ceil(movementStart[10+i]);
            movementStart[16] = 171+((boxwidth+5)*((stageOfVisualisation/2) - 10));
            movementEndHeight[15] = 326;
          }
          if(next.hoverOverButton()) firstHalf[(stageOfVisualisation/2) - 10] = newValues[boxToMove];
        }
        if(stageOfVisualisation == 28){
          //this system of using arrays, calling boxtomove and updating the start and end cooridnates depending on
          // what box needs to be moved is repeated
          array3[0] = newValues[4];
          array3[1] = newValues[5];
         
          array4[0] = newValues[6];

          boxToMove = largerArray(array3, array4);
        }
        if(stageOfVisualisation == 30){
          boxToMove = largerArray(array3, array4);
        }
        if(stageOfVisualisation == 32){
          boxToMove = largerArray(array3, array4);
        }
        if(stageOfVisualisation > 27 && stageOfVisualisation < 33 && stageOfVisualisation % 2 == 0){
          int i = 0;
          if(boxToMove < 2){
            if(boxToMove % 2 != 0) i =1;
            movementStart[17] = ceil(movementStart[12]) + (boxwidth+5)*i;
            movementStart[18] = ceil((movementStart[12]-100)+((boxwidth+5)*((stageOfVisualisation/2) - 14)));
            movementEndHeight[17] = 326;
          }
          else
          {
            movementStart[17] = ceil(movementStart[1]+(2*(boxwidth+5)));
            movementStart[18] = ceil((movementStart[12]-100)+((boxwidth+5)*((stageOfVisualisation/2) - 14)));
            movementEndHeight[17] = 326;
          }
          if(next.hoverOverButton()) secondHalf[(stageOfVisualisation/2) - 14] = newValues[boxToMove+4];
        }
        //this is the final merger. newvaluesDup is then filled with the current order of the arrays
        if(stageOfVisualisation == 34){
          for(int i = 0; i <4; i++) array5[i] = firstHalf[i];
          for(int i = 0; i <3; i++) array6[i] = secondHalf[i];
          for(int i = 0; i <4; i++) newValuesDup[i] = firstHalf[i];
          for(int i = 0; i <3; i++) newValuesDup[i+4] = secondHalf[i];
          boxToMove = largerArray(array5, array6);
        }
        //again using calls to the same function the boxtoMove is calculated
        if(stageOfVisualisation == 36){
          boxToMove = largerArray(array5, array6);
        }
        if(stageOfVisualisation == 38){
          boxToMove = largerArray(array5, array6);
        }
        if(stageOfVisualisation == 40){
          boxToMove = largerArray(array5, array6);
        }
        if(stageOfVisualisation == 42){
          boxToMove = largerArray(array5, array6);
        }
        if(stageOfVisualisation == 44){
          boxToMove = largerArray(array5, array6);
        }
        if(stageOfVisualisation == 46){
          boxToMove = largerArray(array5, array6);
        }
        //and then the coordinates of the start and end of the motion are determined
        if(stageOfVisualisation > 33 && stageOfVisualisation < 47 && stageOfVisualisation % 2 == 0){
          if(boxToMove < 4){
            movementStart[19] = ceil(171+((boxwidth+5)*(boxToMove)));
            movementStart[20] =(width/2) - 3.5*(boxwidth+5)+((stageOfVisualisation/2)-17)*(boxwidth+5);
            movementEndHeight[19] = 480;
          }
          else
          {
            float temp = movementStart[12]-100;
            movementStart[19] = ceil(temp+((boxwidth+5)*(boxToMove-4)));
            movementStart[20] = (width/2) - 3.5*(boxwidth+5)+((stageOfVisualisation/2)-17)*(boxwidth+5);
            movementEndHeight[19] = 480;
          }
          if(next.hoverOverButton()) finalSort[(stageOfVisualisation/2) - 17] = newValuesDup[boxToMove];         
        }
  }
}
 
 void title(){
   fill(0);
   textSize(80);
   textAlign(CENTER, TOP);
   text("Merge Sort", width/2, 80);
   textSize(30);
   text("Joe Moore - u1917702 - 2020", width/2, 200);
 }
 
 void merge(){
  int[] nextButton = {width-100, height-40, 100, 40};
  int[] prevButton = {width-nextButton[2]*2-5, height-40, 100, 40};
  next = new Button(nextButton, "Next", 20);
  prev = new Button(prevButton, "Previous", 20);
  
  System.out.println(stageOfVisualisation);
  
  next.drawButton();
  prev.drawButton();
  
  for(int i=0; i < 7; i++){
    fill(255);
    stroke(0);
    rect((width/2) - 3.5*(boxwidth+5) + (i*(boxwidth+5)), 15, boxwidth, boxwidth);
    fill(0);
    text(usedValues[i], (width/2) - 3.5*(boxwidth+5) + (i*(boxwidth+5)) + (boxwidth/2), 15+boxwidth/2);
  }
  if(stageOfVisualisation == 1){
    fill(#FA0303);
    text("To start the array is split into 2 halves", width/2, 110);
  }
  if(stageOfVisualisation == 7){
    fill(#FA0303);
    text("These 2 halves are then both split in half", width/2, 160);
  }
  if(stageOfVisualisation > 3){
    movementStart[0] = 40;
    movementEndHeight[0] = 161;
    int j = 4;
    if(stageOfVisualisation > 6) j = 2;
    if(stageOfVisualisation > 8) j = 1;
    for(int i=0; i < j; i++){
        fill(255);
        if(stageOfVisualisation == 11) if(i == 0) fill(#FF3131);
        stroke(0);
        rect(movementStart[0]+(i*(boxwidth+5)), movementEndHeight[0], boxwidth, boxwidth);
        fill(0);
        text(usedValues[i], movementStart[0]+(i*(boxwidth+5))+boxwidth/2, movementEndHeight[0]+boxwidth/2);        
      } 
  }
  if(stageOfVisualisation > 5){
    movementStart[1] = width-(boxwidth+5)*3-40;
    movementEndHeight[1] = 161;
    int j = 0;
    if(stageOfVisualisation > 6) j = 2;
    if(stageOfVisualisation > 8) j = 2;
    for(int i=j; i < 3; i++){
        fill(255);
        stroke(0);
        if(stageOfVisualisation == 17) if(i == 2) fill(#FF3131);
        rect(movementStart[1]+(i*(boxwidth+5)), movementEndHeight[1], boxwidth, boxwidth);
        fill(0);
        text(usedValues[i+4], movementStart[1]+(i*(boxwidth+5))+boxwidth/2, movementEndHeight[1]+boxwidth/2);        
    } 
  }
  if(stageOfVisualisation > 7){
     movementStart[3] = (40+(2*(boxwidth+5)) + 200);
     movementStart[4] = (width-(boxwidth+5)*3)-240;
     int j = 2;
     if(stageOfVisualisation > 8) j = 1;
     for(int i=0; i < j; i++){
      fill(255);
      stroke(0);
      if(stageOfVisualisation == 13) if(i == 0) fill(#FF3131);
      rect(movementStart[3]+(i*(boxwidth+5)), 161, boxwidth, boxwidth);
      fill(0);
      text(usedValues[i+2], movementStart[3]+(i*(boxwidth+5))+boxwidth/2, 161+boxwidth/2);        
    }
    if(stageOfVisualisation > 9){
      for(int i = 0; i < 3; i++){
        fill(255);
        if(stageOfVisualisation == 11) if(i == 0) fill(#FF3131);
        if(stageOfVisualisation == 13) if(i == 1) fill(#FF3131);
        if(stageOfVisualisation == 15) if(i == 2) fill(#FF3131);
        stroke(0);
        rect(movementStart[i+5], 161, boxwidth, boxwidth);
        fill(0);
        text(usedValues[((i+1)*2)-1], movementStart[i+5]+boxwidth/2, 161+boxwidth/2);   
      }
    }
    fill(255);
    int h = 2;
    if(stageOfVisualisation > 8) h = 1;
    for(int i = 0; i < h; i++){
      fill(255);
      if(stageOfVisualisation == 15) fill(#FF3131);
      stroke(0);
      rect(movementStart[4]+(i*(boxwidth+5)), 161, boxwidth, boxwidth);
      fill(0);
      text(usedValues[4+i], movementStart[4]+boxwidth/2+(i*(boxwidth+5)), 161+boxwidth/2); 
    }
    
      if(stageOfVisualisation == 11 || stageOfVisualisation == 13 || stageOfVisualisation == 15){
    if(usedValues[stageOfVisualisation-11] > usedValues[stageOfVisualisation-10]){
      firstLower = false;
      newValues[stageOfVisualisation-11] = usedValues[stageOfVisualisation-10];
      newValues[stageOfVisualisation-10] = usedValues[stageOfVisualisation-11];
    }
    else{
      firstLower = true;
      newValues[stageOfVisualisation-11] = usedValues[stageOfVisualisation-11];
      newValues[stageOfVisualisation-10] = usedValues[stageOfVisualisation-10];
    } 
    if(newValues[stageOfVisualisation-10]<newValues[stageOfVisualisation-11]){
      int temp = newValues[stageOfVisualisation-10];
      newValues[stageOfVisualisation-10] = newValues[stageOfVisualisation-11];
      newValues[stageOfVisualisation-11] = temp;
    }
    System.out.println(newValues[stageOfVisualisation-11] + "    " + newValues[stageOfVisualisation-10]);
  }
  if(stageOfVisualisation == 17) newValues[6] = usedValues[6];

    if(stageOfVisualisation >12 ){
      fill(255);
      stroke(0);
      rect(82.9, movementEndHeight[8], boxwidth, boxwidth);
      fill(0);
      text(newValues[0], 82.9+boxwidth/2, movementEndHeight[8]+boxwidth/2);
      fill(255);
      stroke(0);
      rect(82.9+boxwidth+10, movementEndHeight[8], boxwidth, boxwidth);
      fill(0);
      text(newValues[1], 82.9+boxwidth+10+boxwidth/2, movementEndHeight[8]+boxwidth/2);
    }
    if(stageOfVisualisation >14){
      System.out.println(newValues[2] + " : " + newValues[3]);
      if(newValues[2] > newValues[3]){
        int temp = newValues[2];
        newValues[2] = newValues[3];
        newValues[3] = temp;
      }
      fill(255);
      stroke(0);
      rect(442.87598, movementEndHeight[10], boxwidth, boxwidth);
      fill(0);
      text(newValues[2], 442.87598+boxwidth/2, movementEndHeight[10]+boxwidth/2);
      fill(255);
      stroke(0);
      rect(442.87598+boxwidth+10, movementEndHeight[10], boxwidth, boxwidth);
      fill(0);
      text(newValues[3], 442.87598+boxwidth+10+boxwidth/2, movementEndHeight[10]+boxwidth/2);
    }
    if(stageOfVisualisation >16){
      fill(255);
      stroke(0);
      rect(842.6416, movementEndHeight[10], boxwidth, boxwidth);
      fill(0);
      text(newValues[4], 842.6416+boxwidth/2, movementEndHeight[10]+boxwidth/2);
      fill(255);
      stroke(0);
      rect(842.6416+boxwidth+10, movementEndHeight[10], boxwidth, boxwidth);
      fill(0);
      text(newValues[5], 842.6416+boxwidth+10+boxwidth/2, movementEndHeight[10]+boxwidth/2);
    }
    
    if(stageOfVisualisation >18){
      fill(255);
      stroke(0);
      rect(movementStart[1]+(2*(boxwidth+5)), 326, boxwidth, boxwidth);  
      fill(0);
      text(usedValues[6], movementStart[1]+(2*(boxwidth+5))+(boxwidth/2), 326+boxwidth/2);  
    }
   
  }

  
  if(stageOfVisualisation>20){
    int temp;
    if(stageOfVisualisation % 2 ==0) temp = (stageOfVisualisation-1)/2;
    else temp = stageOfVisualisation/2;
    if(stageOfVisualisation > 27) temp = 13;
    for(int i =0; i < temp-9; i++){
      fill(255);
      stroke(0);
      rect(171+(i*(boxwidth + 5)), 480, boxwidth, boxwidth);
      fill(0);
      text(firstHalf[i], 171+(i*(boxwidth + 5))+boxwidth/2, 480+boxwidth/2);   
   }
  }
   
   if(stageOfVisualisation>28){
    int temp;
    if(stageOfVisualisation % 2 ==0) temp = (stageOfVisualisation-1)/2;
    else temp = stageOfVisualisation/2;  
    if(stageOfVisualisation > 33) temp = 16;
    for(int i =0; i < temp-13; i++){
      fill(255);
      stroke(0);
      rect((movementStart[12]-100)+((boxwidth+5)*(i)), 480, boxwidth, boxwidth);
      fill(0);
      text(secondHalf[i], (movementStart[12]-100)+((boxwidth+5)*(i))+boxwidth/2, 480+boxwidth/2);   
   }
   
   if(stageOfVisualisation>34){
    int tempVal;
    if(stageOfVisualisation % 2 ==0) tempVal = (stageOfVisualisation-1)/2;
    else tempVal = stageOfVisualisation/2;  
    for(int i =0; i < tempVal-16; i++){
      fill(255);
      stroke(0);
      rect(((width/2) - 3.5*(boxwidth+5))+((boxwidth+5)*(i)), height-15-boxwidth, boxwidth, boxwidth);
      fill(0);
      text(finalSort[i], ((width/2) - 3.5*(boxwidth+5))+((boxwidth+5)*(i))+boxwidth/2, height-15-boxwidth/2);   
   }
   }
  }
} 
 
 public int largerArray(int[] a, int[]b){
   for(int i=0; i< a.length; i++){
     if(a[i]!=9999)
     {
       for(int j = 0; j < b.length; j++){
         if(b[j] != 9999){
           if(a[i] <= b[j]){
             a[i] = 9999;
             return i;
           }
           else{
             b[j] = 9999;
             return j+a.length;
           }
         }
         else{
           
         }
       }
       a[i]=9999;
       return i;
     }    
   }
   for(int i=0; i< b.length; i++){
     if(b[i] != 9999){
       b[i] = 9999;
       return i+a.length;
     }
   }
   return 9999;
 }
 

 

class Button{
 int[] array;
 int fillColour;
 int fontsize;
 String text;
 
 Button(int[] array, String text, int fontsize){
   this.array = array;
   fillColour = 255;
   this.text = text;
   this.fontsize = fontsize;
}

boolean hoverOverButton() 
{
  if (mouseX >= array[0] && mouseX <= array[0]+array[2] && 
      mouseY >= array[1] && mouseY <= array[1]+array[3]) {
    return true;
  } else {
    return false;
  }
}

void drawButton(){
  if(hoverOverButton()){
    fillColour = 204;
  }
  else{
    fillColour = 255;
  }
  fill(fillColour);
  stroke(255);
  rect(array[0], array[1], array[2], array[3]);
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(fontsize);
  text(text, array[0]+(array[2]/2), array[1]+(array[3]/2));
  
}
}
