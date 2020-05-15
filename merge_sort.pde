int state = 0; /*the state indicates the stage the program is at, 0 is the menu,
1 is with example values, 2 is with a users own numbers, and 3 is the explanation page*/

int boxwidth = 75;
int stageOfVisualisation = 0;

Button exampleNumbers;
Button ownNumbers;
Button explainMergeSort;
Button home;
Button next;
Button prev;

int percentage=0;

boolean firstLower = false;

float[] movementStart;
float[] movementEndHeight;
float movementEnd;


int[] button1 = {(width/2)-150, 300, 300, 100};
int[] button2 = {(width/2)-150, 425, 300, 100};
int[] button3 = {(width/2)-150, 550, 300, 100};
int[] homeButton = {0, 0, 80, 40};                                                                                                                                                                                     
int[] exampleValues = {38, 27, 43, 3, 9, 82, 10};
int[] newValues = new int[7];

int[] array1 = new int[2];
int[] array2 = new int[2];

int[] firstHalf = new int[4];


int boxToMove;

void setup() { 
  size(1280, 720);
  surface.setTitle("Merge Sort");

  button1[0] = (width/2)-150;
  button2[0] = (width/2)-150;
  button3[0] = (width/2)-150;
  homeButton[1] = height-40;
  
  movementStart = new float[100];
  movementStart[0] = (width/2) - 3.5*(boxwidth+5);
  movementEndHeight = new float [100];
  movementEndHeight[0] = 15;
  
 
  exampleNumbers = new Button(button1, "Run with example numbers", 20);
  ownNumbers = new Button(button2, "Run with your own numbers", 20);
  explainMergeSort = new Button(button3, "Merge sort explanation", 20);
  home = new Button(homeButton, "Home", 20);
}

void draw() { 
  background(#75FC7B);
  if(state == 0){
    title();
    
    exampleNumbers.drawButton();
    ownNumbers.drawButton();  
    explainMergeSort.drawButton();
  }
  else{
    home.drawButton();  
  }
  if(state==3){title();}
  if(state==1 || state == 2){
   merge();
   if(stageOfVisualisation == 3){
      if(movementStart[0] < 40 && movementEndHeight[0] > 150) stageOfVisualisation ++;
      textAlign(CENTER, CENTER);
      for(int i=0; i < 4; i++){
        fill(255);
        stroke(0);
        rect(movementStart[0]+(i*(boxwidth+5)), movementEndHeight[0], boxwidth, boxwidth);
        fill(0);
        text(exampleValues[i], movementStart[0]+(i*(boxwidth+5))+boxwidth/2, movementEndHeight[0]+boxwidth/2);        
      }
      movementStart[0]= movementStart[0] - 1.5;
      float x = ((width/2) - 3.5*(boxwidth+5))-40;
      x = 1/x;
      x = x * 146;
      movementEndHeight[0] = movementEndHeight[0]+(1.5*x);
   }
   if(stageOfVisualisation == 5){
      if(movementStart[1] > width-(boxwidth+5)*3-40 && movementEndHeight[1] > 150) stageOfVisualisation ++;
      textAlign(CENTER, CENTER);
      for(int i=0; i < 3; i++){
        fill(255);
        stroke(0);
        rect(movementStart[1]+(i*(boxwidth+5)), movementEndHeight[1], boxwidth, boxwidth);
        fill(0);
        text(exampleValues[i+4], movementStart[1]+(i*(boxwidth+5))+boxwidth/2, movementEndHeight[1]+boxwidth/2);        
      }
      movementStart[1] = movementStart[1]+2;
      float x = (width-(boxwidth+5)*3-40) - ((width/2) - 3.5*(boxwidth+5));
      x = 1/x;
      x = x * 146;
      movementEndHeight[1] = movementEndHeight[1]+(4*x);
   }
   if(stageOfVisualisation == 7){
     if(movementStart[3] > (40+(2*(boxwidth+5)) + 200)) stageOfVisualisation ++;
      textAlign(CENTER, CENTER);
      for(int i=0; i < 2; i++){
        fill(255);
        stroke(0);
        rect(movementStart[3]+(i*(boxwidth+5)), 161, boxwidth, boxwidth);
        fill(0);
        text(exampleValues[2+i], movementStart[3]+(i*(boxwidth+5))+boxwidth/2, 161+boxwidth/2);        
      }
      if(movementStart[4] < (width-(boxwidth+5)*3)-240);
      textAlign(CENTER, CENTER);
      for(int i=0; i < 2; i++){
        fill(255);
        stroke(0);
        rect(movementStart[4]+(i*(boxwidth+5)), 161, boxwidth, boxwidth);
        fill(0);
        text(exampleValues[4+i], movementStart[4]+(i*(boxwidth+5))+boxwidth/2, 161+boxwidth/2);        
      }
      movementStart[4]--;
      movementStart[3]++;
   }
   if(stageOfVisualisation == 9){
     if(movementStart[5] > 130+(boxwidth+5)) stageOfVisualisation ++;
      fill(255);
      stroke(0);
      rect(movementStart[5], 161, boxwidth, boxwidth);
      fill(0);
      text(exampleValues[1], movementStart[5]+boxwidth/2, 161+boxwidth/2);        
      stroke(0);
      fill(255);
      rect(movementStart[6], 161, boxwidth, boxwidth);
      fill(0);
      text(exampleValues[3], movementStart[6]+(boxwidth/2), 161+boxwidth/2);
      stroke(0);
      fill(255);
      rect(movementStart[7], 161, boxwidth, boxwidth);
      fill(0);
      text(exampleValues[5], movementStart[7]+(boxwidth/2), 161+boxwidth/2);   

      
      movementStart[5]++;
      movementStart[6]++;
      if(movementStart[7] < 970){
         movementStart[7]++;
      }
   }
   if(stageOfVisualisation == 12 || stageOfVisualisation == 14 || stageOfVisualisation == 16){
     if(firstLower){
      if(movementStart[stageOfVisualisation-3] - boxwidth - movementStart[stageOfVisualisation-4] < 11){
        stageOfVisualisation ++;       
      }
      else{
        fill(255);
        stroke(0);
        rect(movementStart[stageOfVisualisation-4],movementEndHeight[stageOfVisualisation-4], boxwidth, boxwidth);  
        fill(0);
        text(exampleValues[stageOfVisualisation-12], movementStart[stageOfVisualisation-4]+(boxwidth/2), movementEndHeight[stageOfVisualisation-4]+boxwidth/2);   
        fill(255);
        stroke(0);
        rect(movementStart[stageOfVisualisation-3],movementEndHeight[stageOfVisualisation-4], boxwidth, boxwidth);
        fill(0);
        text(exampleValues[stageOfVisualisation-11], movementStart[stageOfVisualisation-3]+(boxwidth/2), movementEndHeight[stageOfVisualisation-4]+boxwidth/2);   
        fill(0);
        movementEndHeight[stageOfVisualisation-4]++;
        movementStart[stageOfVisualisation-4] = movementStart[stageOfVisualisation-4]+0.26;
        movementStart[stageOfVisualisation-3] = movementStart[stageOfVisualisation-3]-0.26;    
      }      
    }
    else{
      if(movementStart[stageOfVisualisation-4] - boxwidth - movementStart[stageOfVisualisation-3] > 9){
        stageOfVisualisation ++;    
      }
      else{
        fill(255);
        stroke(0);
        rect(movementStart[stageOfVisualisation-4],movementEndHeight[stageOfVisualisation-4], boxwidth, boxwidth);
        fill(0);
        text(exampleValues[stageOfVisualisation-12], movementStart[stageOfVisualisation-4]+(boxwidth/2), movementEndHeight[stageOfVisualisation-4]+boxwidth/2);   
        fill(255);
        stroke(0);
        rect(movementStart[stageOfVisualisation-3],movementEndHeight[stageOfVisualisation-4], boxwidth, boxwidth);
        fill(0);
        text(exampleValues[stageOfVisualisation-11], movementStart[stageOfVisualisation-3]+(boxwidth/2), movementEndHeight[stageOfVisualisation-4]+boxwidth/2);   
        fill(0);
        movementEndHeight[stageOfVisualisation-4]++;
        float f = 42.9 / 0.26;
        f = (42.9+boxwidth+10) / f;
        movementStart[stageOfVisualisation-4] = movementStart[stageOfVisualisation-4]+(f);
        movementStart[stageOfVisualisation-3] = movementStart[stageOfVisualisation-3]-(f);    
      }      
   }
  }
  if(stageOfVisualisation == 18){
    if(movementEndHeight[13] < 326){
      fill(255);
      stroke(0);
      rect(movementStart[1]+(2*(boxwidth+5)), movementEndHeight[13], boxwidth, boxwidth);  
      fill(0);
      text(exampleValues[6], movementStart[1]+(2*(boxwidth+5))+(boxwidth/2), movementEndHeight[13]+boxwidth/2);   
    }
    else{
      stageOfVisualisation++;
    }
    movementEndHeight[13]++;
  }
  
  if(stageOfVisualisation > 19 && stageOfVisualisation < 27 && stageOfVisualisation % 2 == 0){
    
    if(movementStart[15] != movementStart[16] || movementEndHeight[15] < 480){
      fill(255);
      stroke(0);
      rect(movementStart[15], movementEndHeight[15], boxwidth, boxwidth);
      fill(0);
      text(newValues[boxToMove], movementStart[15]+(boxwidth/2), movementEndHeight[15]+boxwidth/2);   
      if(movementEndHeight[15] < 480) movementEndHeight[15] = movementEndHeight[15] + 2;
      if(movementStart[15] != movementStart[16]){
        if(movementStart[15] < movementStart[16]) movementStart[15]++;
        else movementStart[15]--; 
      }
    }
    else{
      stageOfVisualisation++;
    }
    

  }
  
  }
}

void mousePressed() {
  if(state == 0){
    if(exampleNumbers.hoverOverButton()) {
     state = 1;
    }
    if(ownNumbers.hoverOverButton()) {
     state =2;
    }
    if(explainMergeSort.hoverOverButton()) {
     state = 3;
    }
  }  
  if(state != 0 && home.hoverOverButton()){
    state = 0;
    stageOfVisualisation= 0;
  }
  if(state ==1 || state == 2){
    if(next != null && prev != null){
      if(next.hoverOverButton()){
        stageOfVisualisation++;
      }
      if(prev.hoverOverButton() && stageOfVisualisation > 0)
      {
        if(stageOfVisualisation == 4 || stageOfVisualisation == 6 || stageOfVisualisation == 8 || stageOfVisualisation == 13 || stageOfVisualisation == 15) stageOfVisualisation--;
        stageOfVisualisation--;
        if(stageOfVisualisation > 19 && stageOfVisualisation < 27) stageOfVisualisation = 19;
      }
    }
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
          movementStart[9] = 82.9;  
          movementStart[8] = 167.1;
          movementEndHeight[8] = 326;
        }
        if(stageOfVisualisation == 15){
          movementStart[10] = 527.124;  
          movementStart[11] = 442.87598;
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
          array1[0] = newValues[0];
          array1[1] = newValues[1];
         
          array2[0] = newValues[2];
          array2[1] = newValues[3];

          boxToMove = largerArray(array1, array2);
        }
        if(stageOfVisualisation == 22){
          boxToMove = largerArray(array1, array2);
        }
        if(stageOfVisualisation == 24){
          boxToMove = largerArray(array1, array2);
        }
        if(stageOfVisualisation == 26){
          boxToMove = largerArray(array1, array2);
        }
        if(stageOfVisualisation > 19 && stageOfVisualisation < 27 && stageOfVisualisation % 2 == 0){
          int i = 0;
          if(boxToMove < 2){
            if(boxToMove % 2 != 0) i =1;
            movementStart[15] = ceil(movementStart[9-i]);
            movementStart[16] = 171+((boxwidth+5)*((stageOfVisualisation/2) - 10));
            movementEndHeight[15] = 326;
          }
          else
          {
            if(boxToMove % 2 != 0) i =1;
            movementStart[15] = ceil(movementStart[11-i]);
            movementStart[16] = 171+((boxwidth+5)*((stageOfVisualisation/2) - 10));
            movementEndHeight[15] = 326;
          }
          if(next.hoverOverButton()) firstHalf[(stageOfVisualisation/2) - 10] = newValues[boxToMove];
        }
        if(stageOfVisualisation == 28){
          array1[0] = newValues[0];
          array1[1] = newValues[1];
         
          array2[0] = newValues[2];
          array2[1] = newValues[3];

          boxToMove = largerArray(array1, array2);
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
    text(exampleValues[i], (width/2) - 3.5*(boxwidth+5) + (i*(boxwidth+5)) + (boxwidth/2), 15+boxwidth/2);
  }
  if(stageOfVisualisation == 1){
    fill(#FA0303);
    text("To start the array is split into 2 halves", width/2, 110);
  }
  if(stageOfVisualisation == 7){
    fill(#FA0303);
    text("These 2 halves are then both split in half", width/2, 160);
  }
  if(stageOfVisualisation > 0){ 
    stroke(#FA0303);
    strokeWeight(6);
    float f = (width/2) - 3.5*(boxwidth+5) + (4*(boxwidth+5)) -2;
    line(f, 10, f, 95); 
    strokeWeight(1);
  }
  if(stageOfVisualisation > 1){
   strokeWeight(3);
   float f = (width/2) - 3.5*(boxwidth+5) + (2*(boxwidth+5));
   float f2 = (width/2) - 3.5*(boxwidth+5) + (0.5*(boxwidth+5));
   line(f, 100, f2, 200);
   f = f + 3.5*(boxwidth+5);
   f2 = f2 + 6*(boxwidth+5);
   line(f, 100, f2, 200);
   strokeWeight(1);
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
        text(exampleValues[i], movementStart[0]+(i*(boxwidth+5))+boxwidth/2, movementEndHeight[0]+boxwidth/2);        
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
        text(exampleValues[i+4], movementStart[1]+(i*(boxwidth+5))+boxwidth/2, movementEndHeight[1]+boxwidth/2);        
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
      text(exampleValues[i+2], movementStart[3]+(i*(boxwidth+5))+boxwidth/2, 161+boxwidth/2);        
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
        text(exampleValues[((i+1)*2)-1], movementStart[i+5]+boxwidth/2, 161+boxwidth/2);   
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
      text(exampleValues[4+i], movementStart[4]+boxwidth/2+(i*(boxwidth+5)), 161+boxwidth/2); 
    }

    if(stageOfVisualisation >12 ){
        fill(255);
        stroke(0);
        rect(movementStart[9], movementEndHeight[8], boxwidth, boxwidth);
        fill(0);
        text(newValues[0], movementStart[9]+boxwidth/2, movementEndHeight[8]+boxwidth/2);
        fill(255);
        stroke(0);
        rect(movementStart[8], movementEndHeight[8], boxwidth, boxwidth);
        fill(0);
        text(newValues[1], movementStart[8]+boxwidth/2, movementEndHeight[8]+boxwidth/2);
        for(int i = 0; i<10; i++){
        }
    }
    if(stageOfVisualisation >14){
      for(int i = 0; i < 2; i++){
        fill(255);
        stroke(0);
        rect(movementStart[10+i], movementEndHeight[10], boxwidth, boxwidth);
        fill(0);
        text(exampleValues[i+2], movementStart[10+i]+boxwidth/2, movementEndHeight[10]+boxwidth/2);   
      }
    }
    if(stageOfVisualisation >16){
      for(int i = 0; i < 2; i++){
        fill(255);
        stroke(0);
        rect(movementStart[12+i], movementEndHeight[12], boxwidth, boxwidth);
        fill(0);
        text(exampleValues[i+4], movementStart[12+i]+boxwidth/2, movementEndHeight[12]+boxwidth/2);   
      }
    }
    if(stageOfVisualisation >18){
      fill(255);
      stroke(0);
      rect(movementStart[1]+(2*(boxwidth+5)), 326, boxwidth, boxwidth);  
      fill(0);
      text(exampleValues[6], movementStart[1]+(2*(boxwidth+5))+(boxwidth/2), 326+boxwidth/2);  
    }
   
  }
  if(stageOfVisualisation == 11 || stageOfVisualisation == 13 || stageOfVisualisation == 15){
    if(exampleValues[stageOfVisualisation-11] > exampleValues[stageOfVisualisation-10]){
      firstLower = false;
      newValues[stageOfVisualisation-11] = exampleValues[stageOfVisualisation-10];
      newValues[stageOfVisualisation-10] = exampleValues[stageOfVisualisation-11];
    }
    else{
      firstLower = true;
      newValues[stageOfVisualisation-11] = exampleValues[stageOfVisualisation-11];
      newValues[stageOfVisualisation-10] = exampleValues[stageOfVisualisation-10];
    }   
  }
  if(stageOfVisualisation == 17) newValues[7] = exampleValues[7];
  
  if(stageOfVisualisation>20){
    int temp = (stageOfVisualisation-1)/2;
    for(int i =0; i < temp-9; i++){
      fill(255);
      stroke(0);
      rect(171+(i*(boxwidth + 5)), 480, boxwidth, boxwidth);
      fill(0);
      text(firstHalf[i], 171+(i*(boxwidth + 5))+boxwidth/2, 480+boxwidth/2);   
   }
    
  }
 }
 
 
 public int largerArray(int[] a, int[]b){
   for(int i=0; i< 2; i++){
     if(a[i]!=9999)
     {
       for(int j = 0; j < 2; j++){
         if(b[j] != 9999){
           if(a[i] <= b[j]){
             a[i] = 9999;
             return i;
           }
           else{
             b[j] = 9999;
             return j+2;
           }
         }
       }
     }    
   }
   for(int i=0; i< 2; i++){
     if(b[i] != 9999){
       b[i] = 9999;
       return i+2;
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
