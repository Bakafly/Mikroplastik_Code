ArrayList<Mikroplastik> mikroplastikParticles; // Creating a list of Mikroplastik-particles
ArrayList<Stream> streamDirections; // Creating a list of Vectors
int num_mikroplastikParticles = 4000; // set how many particles we want
int mikroplastikSize = 5;
int boardSize; // board (fields) to be filled with vectors (See the draw function of "Stream")
int cellWidth; // Size of the fields
PImage map;
int imageSizeX, imageSizeY;
color testForLand;
int redLand, greenLand, blueLand;

void setup() {
  // basic setup
  // noLoop();
  map = loadImage("test1.png");
  imageSizeX = map.width;
  imageSizeY = map.height;
  size(imageSizeX, imageSizeY, P2D); 
  rectMode(CORNER);
  ellipseMode(CENTER);
  boardSize = width/40; // the size of the fields depend on the window size, so it's equally disstributed
  cellWidth = width/boardSize; 
  mikroplastikParticles = new ArrayList();
  streamDirections = new ArrayList();

  // add new Mikroplastic Particles: as many as we set with "num_mikroplastikParticles" 
  for (int i=0; i<num_mikroplastikParticles; mikroplastikParticles.add (new Mikroplastik (i++)));

  // add new "Streams" (=direction in which the plastic will float)
  for (int x = 0; x < boardSize; x++) {
    for (int y = 0; y < boardSize; y++) {
      testForLand = map.get((int)x*cellWidth+cellWidth/2, (int)y*cellWidth+cellWidth/2); // get the color on the current particle position
      redLand = testForLand >> 16 & 0xFF;
      greenLand = testForLand >> 8 & 0xFF;
      blueLand = testForLand & 0xFF;
      if (redLand==109 && greenLand==191 && blueLand==229) {
        streamDirections.add (new Stream (x*cellWidth+cellWidth/2, y*cellWidth+cellWidth/2));
      }
    }
  }
  for (int i=0; i<streamDirections.size (); streamDirections.get(i++).setVectors());
}

void draw() {
  background(255);
  image(map, 0, 0);
  for (int i=0; i<streamDirections.size (); streamDirections.get(i++).draw());
  for (int i=0; i<mikroplastikParticles.size (); mikroplastikParticles.get(i++).draw());
}

class Stream {
  // set local variables for the Stream class
  float vectorXPos, vectorYPos, ratio; // position and size
  PVector directionVector; // the actual Vector 
  color randomColor;
  // initializing the vector
  Stream(float xPos, float yPos) {
    vectorXPos = xPos;
    vectorYPos = yPos;
    ratio = cellWidth/2;
    directionVector = new PVector(random(-.1, 0), random(-.1, .1), 0);
  }

  // To see the vectors, use this draw function. 
  // It has no further purpose than visualization though.
  void draw() {
      /*
    noFill();
    stroke(0);
    strokeWeight(2);
    rect(vectorXPos-ratio, vectorYPos-ratio, 2*ratio, 2*ratio); 
    pushMatrix();
    translate(vectorXPos, vectorYPos);
    line(0, 0, directionVector.x*ratio*10, +directionVector.y*ratio*10);
    strokeWeight(1);
    popMatrix();
      */
  }
  
  void setVectors() {
    
  }

  // checks where (in which stream) the particle is
  boolean is_in_stream(float x, float y) {
    return(dist(x, y, vectorXPos, vectorYPos) <= ratio);
  }
}

