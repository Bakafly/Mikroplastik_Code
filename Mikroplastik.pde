class Mikroplastik {
  // set local variables for the Mikroplastik class
  PVector mikroplastikPos, speed, acceleration;
  int id;
  color c;

  Mikroplastik(int iid) { // Independent and identically distributed values
    // meaning every new value has the same initial point
    id = iid; 
    // set the starting position of the particles
    mikroplastikPos = new PVector(random(imageSizeX/1.35, imageSizeX/1.331), random(imageSizeY/1.59, imageSizeY/1.564));
    speed = new PVector( random(-1, 1), random(-1, 1), 0 );
    acceleration = new PVector( 0, 0, 0 );
    c = color(random(255), random(255), random(255)); //color(#FF0000);
  }
  void draw() {
    simulate(); // movement of the particles
    render(); // actual "drawing" of the circles

    boolean touchedLand = false; // are the particles still in the water?
    color test = map.get((int)mikroplastikPos.x+mikroplastikSize/4, (int)mikroplastikPos.y+mikroplastikSize/4); // get the color on the current particle position
    int red = test >> 16 & 0xFF;
    int green = test >> 8 & 0xFF;
    int blue = test & 0xFF;

    if (red!=109 && green!=191 && blue!=229) touchedLand = true; // if the "color is not blue anymore" (not in water anymore)
    if (touchedLand) {
       speed.x = 0;
       speed.y = 0;
    }
  }
  
  void simulate() {
    acceleration.x = 0;
    acceleration.y = 0;
    for (int i=0; i<streamDirections.size (); i++) {
      if ( streamDirections.get(i).is_in_stream(mikroplastikPos.x, mikroplastikPos.y) ) { // check if there is a vector nearby
        acceleration.add(streamDirections.get(i).directionVector);  // particle moves according to its closest vector
      }
    }
    speed.mult(1);
    speed.limit(2);
    speed.add(acceleration);
    mikroplastikPos.add(speed);
  }

  void render() {   // visualization of the plastic particles 
    fill(c);
    noStroke();
    ellipse(mikroplastikPos.x, mikroplastikPos.y, mikroplastikSize, mikroplastikSize);
  }
}

