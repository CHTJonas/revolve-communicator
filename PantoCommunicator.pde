import processing.serial.*;

Serial conn;
PrintWriter output;
CueStack cues;
int[] buffer = new int[40000];
int buffer_i = 0;

void setup() {
  conn = new Serial(this, Serial.list()[3], 1200);
  output = createWriter("data.txt");
  cues = new CueStack();
}

void draw() {
  if (conn.available() > 0) {
    buffer[buffer_i++] = conn.read();
  }
}

void keyPressed() {
  for(int i = 0; i < 40000; i = i + 2){
    int value_high = buffer[i];
    int value_low = buffer[i+1];
    int value = (value_low & 0x0f) | (value_high & 0xf0);
    cues.importByte(value);
  }
   
  
  output.println(cues);
  output.println(cues.getBytesImported());
  output.flush();
  output.close();
  exit();
}

class CueStack{
   ArrayList<Cue> cues = new ArrayList();
   private int bytesImported = 0;
   
   public void importByte(int x){
     if(bytesImported % 20 == 0){
       cues.add(new Cue());
     }
     
     cues.get(bytesImported / 20).importByte(x);
     bytesImported++;
   }
   
   public int getBytesImported(){
     return this.bytesImported;
   }
   
   String toString(){
     String result = "";
     for(int i = 0; i < cues.size(); i++){
       result += cues.get(i) + "\n";
     }
     return result;
   }
}

class Cue{
  int[] data = new int[20];
  private int bytesImported = 0;
  
  String toString(){
    String result = "";
    for(int i = 0; i < data.length; i++){
        if(i == 1 || i == 7){
            continue;
        }
        result += data[i] + ",";
    }
    return result.substring(0, result.length() - 1);
  }
  
  public void importByte(int x){
    switch(bytesImported){
      case 1:
      case 7:
        data[bytesImported - 1] = (x << 8) | data[bytesImported - 1];
        break;
      case 12:
      case 13:
      case 14:
      case 15:
        break;
      default:
        data[bytesImported] = x;
    }
    bytesImported++;
  }
  
}
 