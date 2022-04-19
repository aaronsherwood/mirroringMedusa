import org.monome.Monome;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress tidalCycles;

Monome m;
int[][] led;
SoundOnOff toggleSounds[];
Fader faders[];
int allOff = 0;

public void setup() {
  m = new Monome(this);

  oscP5 = new OscP5(this, 12200);
  tidalCycles = new NetAddress("127.0.0.1", 6010);

  led = new int[8][16];

  toggleSounds = new SoundOnOff[32];

  toggleSounds[0] = new SoundOnOff(0, 0, "vocal0");
  toggleSounds[1] = new SoundOnOff(0, 1, "vocal1");
  toggleSounds[2] = new SoundOnOff(0, 2, "vocal2");
  toggleSounds[3] = new SoundOnOff(1, 0, "igloo0");
  toggleSounds[4] = new SoundOnOff(1, 1, "igloo1");
  toggleSounds[5] = new SoundOnOff(1, 2, "igloo2");
  toggleSounds[6] = new SoundOnOff(2, 0, "drums0");
  toggleSounds[7] = new SoundOnOff(2, 1, "drums1");
  toggleSounds[8] = new SoundOnOff(3, 0, "bigBeat");
  toggleSounds[9] = new SoundOnOff(3, 1, "complex");
  toggleSounds[10] = new SoundOnOff(4, 0, "glitch0");
  toggleSounds[11] = new SoundOnOff(4, 1, "glitch1");
  toggleSounds[12] = new SoundOnOff(4, 2, "glitch2");
  toggleSounds[13] = new SoundOnOff(5, 0, "sophie0");
  toggleSounds[14] = new SoundOnOff(5, 1, "sophie1");
  toggleSounds[15] = new SoundOnOff(5, 2, "sophie2");
  toggleSounds[16] = new SoundOnOff(6, 0, "chords0");
  toggleSounds[17] = new SoundOnOff(6, 1, "chords1");
  toggleSounds[18] = new SoundOnOff(6, 2, "chords2");
  toggleSounds[19] = new SoundOnOff(7, 0, "climax0");
  toggleSounds[20] = new SoundOnOff(7, 1, "climax1");
  toggleSounds[21] = new SoundOnOff(7, 2, "climax2");

  toggleSounds[22] = new SoundOnOff(0, 9, "moreDrums0");
  toggleSounds[23] = new SoundOnOff(0, 10, "moreDrums1");
  toggleSounds[24] = new SoundOnOff(0, 11, "moreDrums2");
  toggleSounds[25] = new SoundOnOff(0, 12, "moreDrums3");
  toggleSounds[26] = new SoundOnOff(1, 9, "more0");
  toggleSounds[27] = new SoundOnOff(1, 10, "more1");
  toggleSounds[28] = new SoundOnOff(1, 11, "more2");
  toggleSounds[29] = new SoundOnOff(1, 12, "more3");
  toggleSounds[30] = new SoundOnOff(1, 13, "more4");
  toggleSounds[31] = new SoundOnOff(1, 14, "more5");

  faders = new Fader[2];

  faders[0] = new Fader(6, "thisLove");
  faders[1] = new Fader(7, "gormaduli");

  for (int x=0; x<16; x++) {
    for (int y=0; y<8; y++) {
      led[y][x] = 0;
    }
  }
}

public void draw() {
  if (frameCount%20==0) {
    for (int i=0; i<faders.length; i++) {
      faders[i].fadeVolume();
    }
  }

  //allOff
  led[0][4] = allOff*11+4;

  //toggle sounds
  for (int i=0; i<toggleSounds.length; i++) {
    led[toggleSounds[i].y][toggleSounds[i].x] = toggleSounds[i].draw();
  }

  //faders
  for (int i=0; i<faders.length; i++) {
    for (int j=0; j<8; j++) {
      led[j][faders[i].x] = faders[i].draw(j);
    }
  }

  //update grid
  m.refresh(led);
}

public void key(int x, int y, int s) {
  //send an off to everything
  if ( x==4 && y==0) {
    allOff ^= 1;
    for (int i=0; i<toggleSounds.length; i++) {
      toggleSounds[i].onOff = 0;
      toggleSounds[i].sendMessage();
    }

    //faders
    for (int i=0; i<faders.length; i++) {
      for (int j=0; j<8; j++) {
        faders[i].y[j] = 0;
      }
      faders[i].destination = 0;
    }
  }

  //toggle sounds
  if (s==1) {
    for (int i=0; i<toggleSounds.length; i++) {
      if (x == toggleSounds[i].x && y == toggleSounds[i].y) {
        toggleSounds[i].onOff ^= 1;
        toggleSounds[i].sendMessage();
      }
    }

    //faders
    for (int i=0; i<faders.length; i++) {
      if (x == faders[i].x) {
        faders[i].toggleButton(y);
      }
    }
  }
}

class SoundOnOff {
  int x, y, basicBrightness, onOff;
  String route;
  SoundOnOff(int _y, int _x, String _route) {
    x = _x;
    y = _y;
    basicBrightness = 4;
    route = _route;
    onOff = 0;
  }

  int draw() {
    return onOff * 11 + basicBrightness;
  }

  void toggleButton() {
    onOff ^= 1;
  }

  void sendMessage() {
    OscMessage myMessage = new OscMessage("/ctrl");
    myMessage.add(route);
    myMessage.add(onOff);
    /* send the message */
    oscP5.send(myMessage, tidalCycles);
  }
}

/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

class Fader {
  int x, basicBrightness;
  String route;
  int[] y;
  float vol, destination;

  Fader(int _x, String _route) {
    x = _x;
    route = _route;
    basicBrightness = 4;
    y = new int[8];
    vol = 0;
  }

  int draw(int i) {
    return y[i] * 11 + basicBrightness;
  }

  void toggleButton(int yPos) {
    for (int i=0; i<y.length; i++) {
      y[i] = 0;
      if (i==yPos) y[i]=1;
    }
    destination = sqrt(1.0-(float(yPos)/7.0));
  }

  void fadeVolume() {
    vol += (destination-vol)*.75;
    sendMessage();
  }

  void sendMessage() {
    OscMessage myMessage = new OscMessage("/ctrl");
    myMessage.add(route);
    myMessage.add(vol);
    /* send the message */
    oscP5.send(myMessage, tidalCycles);
  }
}
