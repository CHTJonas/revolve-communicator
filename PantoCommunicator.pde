import processing.serial.*;

Serial wConn;
Serial rConn;

PrintWriter wFile;
CueStack cues;


void setup() {
  //wConn = new Serial(this, Serial.list()[1], 1200);
  rConn = new Serial(this, Serial.list()[3], 1200);
  wFile = createWriter("data.txt");
  cues = new CueStack();
}

void keyPressed() {
  processRead();
  exit();
}