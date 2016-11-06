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