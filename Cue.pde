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