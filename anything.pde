
/*
 * This sketch uses the text drawn to an offscreen PGraphics to determine
 * if a randomly chosen xy-coordinate is inside the drawn text. If so it will
 * draw a shape to the main screen. In addition, the sketch has no background
 * call in draw(), so the drawings will accumulate on top of each other
 * much like a painting's canvas.
 * 
 * USAGE:
 * - click the mouse to move through the three different drawing modes
 */

int drawSpeed = 32; // number of drawn shapes per draw() call
int drawMode = 3; // move through the drawing modes by clicking the mouse
color BACKGROUND_COLOR = color(255);
color PGRAPHICS_COLOR = color(0);

PGraphics pg;

PFont font;

void setup() {
  size(640, 120);
  background(BACKGROUND_COLOR); // start of with a white background
  //colorMode(HSB, 360, 100, 100); // change to Hue-Saturation-Brightness color mode
  colorMode(RGB, 255);
  rectMode(CENTER);

  // create and draw to PPraphics (see Getting Started > UsingPGraphics example)
  pg = createGraphics(width, height, JAVA2D);
  pg.beginDraw();
  pg.textSize(100);
  pg.textAlign(LEFT, CENTER);
  pg.fill(PGRAPHICS_COLOR);
  pg.text("YUTA TOGA", 0, pg.height/2); 
  pg.endDraw();
  
  font = loadFont("Helvetica-13.vlw"); 
}

void draw() {
  // This for loop ensures the code is repeated 'drawSpeed' times
  for (int i=0; i<drawSpeed; i++) {
    // pick a random coordinate
    int x = (int) random(width);
    int y = (int) random(height);
    // check if the coordinate is inside the text (in the offscreen PGraphics)
    boolean insideText = (pg.get(x, y) == PGRAPHICS_COLOR);
    // if it is indeed, then draw a shape in the main screen
    if (insideText) {
      // switch based on the current draw mode (move through them by clicking the mouse)
      // each drawing mode has custom settings (stroke, fill, shape, rotation) 
      pushMatrix();
      translate(x, y);
      switch (drawMode) {
      case 0:
        float er = random(2, 13);
        color ec = color(random(100, 150), random(100, 150), random(100, 150), random(30,60));
        //stroke(0);
        noStroke();
        fill(ec);
        ellipse(0, 0, er, er);
        break;
      case 1: 
        float td = random(2, 7);
        float tr = random(TWO_PI);
        color tc = color(random(180, 300), 100, random(50, 100));
        noStroke();
        fill(tc);
        rotate(tr);
        triangle(0, -td, -td, td, td, td);
        break;
      case 2: 
        float rw = random(2, 7);
        float rh = random(3, 13);
        float rr = random(TWO_PI);
        color rc = color(random(20), random(70, 100), random(20, 100));
        //stroke(0);
        noStroke();
        fill(rc);
        rotate(rr);
        rect(0, 0, rw, rh);
        break;
      case 3: 
        //Y
        fill(0);
        textSize(100);
        if(x > textWidth("") && x < textWidth("Y")){
          textSize(13);
          text("y", 0, 0);
        }else if(x > textWidth("Y") && x < textWidth("YU")){
          textSize(13);
          text("u", 0, 0);  
        }else if(x > textWidth("YU") && x < textWidth("YUT")){
          textSize(13);
          text("t", 0, 0);  
        }else if(x > textWidth("YUT") && x < textWidth("YUTA")){
          textSize(13);
          text("a", 0, 0);  
        }else if(x > textWidth("YUTA ") && x < textWidth("YUTA T")){
          textSize(13);
          text("t", 0, 0);  
        }else if(x > textWidth("YUTA T") && x < textWidth("YUTA TO")){
          textSize(13);
          text("0", 0, 0);  
        }else if(x > textWidth("YUTA TO") && x < textWidth("YUTA TOG")){
          textFont(font, 26);
          text("g", 0, 0);  
        }else if(x > textWidth("YUTA TOG") && x < textWidth("YUTA TOGA")){
          textSize(13);
          text("a", 0, 0);  
        }
        break;
      }
      popMatrix();
    }
  }
}

void mousePressed() {
  background(BACKGROUND_COLOR); // clear the screen when changing drawing mode
  drawMode = ++drawMode%4; // move through 3 drawing modes (0, 1, 2)
}

