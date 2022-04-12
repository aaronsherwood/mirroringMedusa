import org.monome.Monome;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress tidalCycles;

Monome m;
boolean dirty;
int[][] led;
int[][] onOff;

public void setup() {
  m = new Monome(this);

  led = new int[8][16];

  onOff = new int[8][16];


  for (int x=0; x<16; x++) {
    for (int y=0; y<8; y++) {
      led[y][x] = 0;
      onOff[y][x] = 0;
    }
  }

  dirty = true;

  oscP5 = new OscP5(this, 12200);
  tidalCycles = new NetAddress("127.0.0.1", 6010);
}

public void draw() {
  if (dirty) {

    //// display steps
    for (int x=0; x<16; x++) {
      for (int y=0; y<8; y++) {
        if (x<3 && y==0 || ( x==4 && y==0))
          led[y][x] = 4 + onOff[y][x]*11;
        if (x<3 && y==1)
          led[y][x] = 4 + onOff[y][x]*11;
        if (x<2 && y==2)
          led[y][x] = 4 + onOff[y][x]*11;
        if (x<2 && y==3)
          led[y][x] = 4 + onOff[y][x]*11;
        if (x<3 && y==4)
          led[y][x] = 4 + onOff[y][x]*11;
        if (x<3 && y==5)
          led[y][x] = 4 + onOff[y][x]*11;
        if (x<3 && y==6)
          led[y][x] = 4 + onOff[y][x]*11;
        if (x<3 && y==7)
          led[y][x] = 4 + onOff[y][x]*11;
        if (x==6 || x==7)
          led[y][x] = 4 + onOff[y][x]*11;
        if (x>=9 && x<=12 && y<2){
          led[y][x] = 4 + onOff[y][x]*11;
        }
      }
    }

    // update grid
    m.refresh(led);
    dirty = false;
  }
}

public void key(int x, int y, int s) {
  if ( x==4 && y==0) {
    onOff[y][x] = 1 - onOff[y][x];
    for (int j=0; j<16; j++) {
      for (int i=0; i<8; i++) {
        onOff[i][j] = 0;
      }
    }
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("vocal0");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("vocal1");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("vocal2");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("igloo0");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("igloo1");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("igloo2");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //drums

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("drums0");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("drums1");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //big beat
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("bigBeat");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("complex");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //glitch
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("glitch0");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("glitch1");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("glitch2");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //sophie
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("sophie0");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("sophie1");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("sophie2");

      myMessage.add(float(0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //chords
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("chords0");

      myMessage.add((0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("chords1");

      myMessage.add((0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("chords2");

      myMessage.add((0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //chords
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("climax0");

      myMessage.add((0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("climax1");

      myMessage.add((0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("climax2");

      myMessage.add((0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
     //more drums
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("moreDrums0");

      myMessage.add((0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("moreDrums1");

      myMessage.add((0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("moreDrums2");

      myMessage.add((0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("moreDrums3");

      myMessage.add((0)); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    
    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("more0");

      myMessage.add(0); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("more1");

      myMessage.add(0); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("more2");

      myMessage.add(0); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    
    {
      for (int i=0; i<8; i++) {
        onOff[i][x]=0;
      }
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("thisLove");

      myMessage.add(0); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    {
      for (int i=0; i<8; i++) {
        onOff[i][x]=0;
      }
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("gormaduli");



      myMessage.add(0); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
  }


  // toggle steps
  if (s==1) {
    if (x<3 && y==0)
      onOff[y][x] ^= 1;
    if (x<3 && y==1)
      onOff[y][x] ^= 1;
    if (x<2 && y==2)
      onOff[y][x] ^= 1;
    if (x<2 && y==3)
      onOff[y][x] ^= 1;
    if (x<3 && y==4)
      onOff[y][x] ^= 1;
    if (x<3 && y==5)
      onOff[y][x] ^= 1;
    if (x<3 && y==6)
      onOff[y][x] ^= 1;
    if (x<3 && y==7)
      onOff[y][x] ^= 1;
    if (x>=9 && x<=12 && y<2){
      onOff[y][x] ^= 1;
    }

    if (x==6) {
      onOff[y][x] ^= 1;
      for (int i=0; i<8; i++) {
        if (i!=y)
          onOff[i][x]=0;
      }
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("thisLove");

      float vol = 1.0-(float(y)/7.0);

      println(vol);

      myMessage.add(vol); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (x==7) {
      onOff[y][x] ^= 1;
      for (int i=0; i<8; i++) {
        if (i!=y)
          onOff[i][x]=0;
      }
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("gormaduli");

      float vol = 1.0-(float(y)/7.0);

      println(vol);

      myMessage.add(vol); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }



    //vocals
    if (y==0 && x==0) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("vocal0");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==0 && x==1) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("vocal1");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    
    if (y==0 && x==2) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("vocal2");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //igloo
    if (y==1 && x==0) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("igloo0");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==1 && x==1) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("igloo1");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==1 && x==2) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("igloo2");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //drums

    if (y==2 && x==0) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("drums0");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==2 && x==1) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("drums1");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //big beat
    if (y==3 && x==0) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("bigBeat");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    
    if (y==3 && x==1) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("complex");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //glitch
    if (y==4 && x==0) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("glitch0");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==4 && x==1) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("glitch1");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==4 && x==2) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("glitch2");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //sophie
    if (y==5 && x==0) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("sophie0");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==5 && x==1) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("sophie1");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==5 && x==2) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("sophie2");

      myMessage.add(float(onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //chords
    if (y==6 && x==0) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("chords0");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==6 && x==1) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("chords1");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==6 && x==2) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("chords2");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    //chords
    if (y==7 && x==0) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("climax0");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==7 && x==1) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("climax1");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==7 && x==2) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("climax2");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    
    //more drums
    if (y==0 && x==9) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("moreDrums0");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==0 && x==10) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("moreDrums1");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==0 && x==11) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("moreDrums2");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    
    if (y==0 && x==12) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("moreDrums3");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }
    
    //morePerc
    if (y==1 && x==9) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("more0");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==1 && x==10) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("more1");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    if (y==1 && x==11) {
      OscMessage myMessage = new OscMessage("/ctrl");
      myMessage.add("more2");

      myMessage.add((onOff[y][x])); /* add an int to the osc message */

      /* send the message */
      oscP5.send(myMessage, tidalCycles);
    }

    dirty = true;
  }
}
