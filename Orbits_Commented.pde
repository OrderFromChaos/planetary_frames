Planetoid Sun;
Planetoid Mercury;
Planetoid Venus;
Planetoid Earth;
Planetoid Mars;
Planetoid Jupiter;
Planetoid Saturn;
Planetoid Uranus;
Planetoid Neptune;
float time = PI/10;
//this is how many years pass each increment (increments are in decimal values of seconds. so if increments = 1, this is per second.)
//in this case, I have chosen PI/10 so that one Earth orbit is completed per 20 ticks.
float time2 = 1/time;
 
float increments = 0.5;
 
float quality = 20;
 
void setup() {
  size(1000, 1000);
  background(0);
   
  Sun = new Planetoid(0,0,0);
  Mercury = new Planetoid(0, TAU/(0.24085*time2)/quality, 10/2);
  Venus = new Planetoid(0, TAU/(0.72334*time2)/quality, 18/2);
  Earth = new Planetoid(0, TAU/(1*time2)/quality, 25/2);
  Mars = new Planetoid(0, TAU/(1.88082*time2)/quality, 38/2);
  Jupiter = new Planetoid(0, TAU/(11.86262*time2)/quality, 130/2);
  Saturn = new Planetoid(0, TAU/(29.44750*time2)/quality, 239/2);
  Uranus = new Planetoid(0, TAU/(84.01685*time2)/quality, 480/2);
  Neptune = new Planetoid(0, TAU/(164.79132*time2)/quality, 753/2);
  //Each of the values before "time2" are calculated based on the planetary velocity of the planet. the final values (all over 2) represent the distance to the sun,
  //after being converted to the number of pixels that fit the simulation. They were originally derived based on the values at bit.ly/1YFaRvC
  //Other data table (for finding planetary revolution period): bit.ly/23WVaU5
}
 
void draw() {
  //background(0);
  //Uncomment this if you don't want the lines to show up on the screen (only the points)
   
  // This translates the origin point to the center of the screen (and draws a circle there):
  translate(width/2, height/2);
  ellipse(0,0,5,5);
   
  Sun.move();
  Mercury.move();
  Venus.move();
  Earth.move();
  Mars.move();
  Jupiter.move();
  Saturn.move();
  Uranus.move();
  Neptune.move();
   
  // This translates to the chosen planet. If you want a planet like Neptune, replace all instances of "Sun" with "Neptune".
  translate(Neptune.orbit_dist*cos(Neptune.theta),Neptune.orbit_dist*sin(Neptune.theta));
  //When you change to a new planetary reference frame, be sure to comment (using double forward slashes) the .display(); line for that planet. This will
  //ensure that there are no issues with spurious planets being simulated. And, of course, uncomment the one you just changed the focus from.
  
  //The reason there is a move class and a display class is so that everything can be calculated in the heliocentric frame while rendering planetary centric models.
  //(In other words, the calculations are done in the heliocentric frame, and then the display is translated to show it from the perspective of a different planet.)
   
  Sun.display();
  Mercury.display();
  Venus.display();
  Earth.display();
  Mars.display();
  Jupiter.display();
  Saturn.display();
  Uranus.display();
  //Neptune.display();
   
  //This code allows frames to be saved from the program. (This is how the original movies were created.) You can uncomment this code by removing
  //the opening and closing lines (/* and the other), but be aware doing that will produce 400 PNG files, which will be placed in your program's folder.
  /*
  if(frameCount % 5 == 0 && frameCount<=2000) {
    saveFrame("Frame-####.png");
  } else if(frameCount>2000) {
    stop();
  }
  */
   
  // These lines ensure that the "time" count is kept constant, so even if the program finishes rendering early, it waits momentarily so that the program time is
  // kept under control.
  int t_passed = millis() % 1000;
  delay((int) increments*(1000-t_passed));
   
}
 
 
//This class determines the attributes of "Planetoid" - it keeps track of planetary velocity and distance from the Sun.
 
class Planetoid {
   
  float theta;
  //x position and y position are determined from this variable
  float theta_vel;
  float orbit_dist;
  //to get this value, I did (AU distance from Sun)*12.5. This gave me a spacing relative to the number of pixels that I have (1000).
   
  Planetoid(float t, float tv, float r) {
    theta = t;
    theta_vel = tv;
    orbit_dist = r;
  }
   
  void display() {
    // This converts polar to Cartesian coordinates
    float x = orbit_dist * cos(theta);
    float y = orbit_dist * sin(theta);
     
    // This draws the ellipse (well, point at this size) at the found Cartesian coordinate
    ellipseMode(CENTER);
    noStroke();
    fill(200);
    ellipse(x, y, 1, 1);
  }
   
  void move() {
    theta += theta_vel;
  }
   
}

void mousePressed() {
  saveFrame();
}