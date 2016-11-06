int[] buffer = new int[40000];
int buffer_i = 0;

void draw() {
  if (rConn.available() > 0) {
    buffer[buffer_i++] = rConn.read();
  }
}

void processRead(){
  for(int i = 0; i < 40000; i = i + 2){
    int value_high = buffer[i];
    int value_low = buffer[i+1];
    int value = (value_low & 0x0f) | (value_high & 0xf0);
    cues.importByte(value);
  }
   
  wFile.println(cues);
  wFile.println(cues.getBytesImported());
  wFile.flush();
  wFile.close();
}
 