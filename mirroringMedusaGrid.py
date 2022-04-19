#! /usr/bin/env python3

import asyncio
import monome
import math
from pythonosc import udp_client

class SoundOnOff():
    def __init__(self, y, x, route):
        self.y = y
        self.x = x
        self.route = route
        self.basicBrightness = 4
        self.onOff = 0

    def draw(self):
        return self.onOff * 11 + self.basicBrightness;

    def toggleButton(self):
        self.onOff ^= 1

    def sendMessage(self):
        client.send_message("/ctrl", [self.route, self.onOff])

class Fader():
    def __init__(self, x, route):
        self.y = [0,0,0,0,0,0,0,0]
        self.x = x
        self.route = route
        self.basicBrightness = 4
        self.vol = 0
        self.destination = 0

    def draw(self, i):
        return self.y[i] * 11 + self.basicBrightness;

    def toggleButton(self, yPos):
        for index, row in enumerate(self.y):
            self.y[index] = 0
            if index == yPos:
                self.y[index] = 1
        self.destination = math.sqrt(1.0-(float(yPos)/7.0))

    def fadeVolume(self):
        self.vol += (self.destination-self.vol)*.75;
        self.sendMessage();

    def sendMessage(self):
        client.send_message("/ctrl", [self.route, self.vol])

class MirroringMedusa(monome.GridApp):
    def __init__(self):
        super().__init__()


    def on_grid_ready(self):
        self.toggleSounds = []

        self.toggleSounds.append(SoundOnOff(0, 0, "vocal0"))
        self.toggleSounds.append(SoundOnOff(0, 1, "vocal1"))
        self.toggleSounds.append(SoundOnOff(0, 2, "vocal2"))
        self.toggleSounds.append(SoundOnOff(1, 0, "igloo0"))
        self.toggleSounds.append(SoundOnOff(1, 1, "igloo1"))
        self.toggleSounds.append(SoundOnOff(1, 2, "igloo2"))
        self.toggleSounds.append(SoundOnOff(2, 0, "drums0"))
        self.toggleSounds.append(SoundOnOff(2, 1, "drums1"))
        self.toggleSounds.append(SoundOnOff(3, 0, "bigBeat"))
        self.toggleSounds.append(SoundOnOff(3, 1, "complex"))
        self.toggleSounds.append(SoundOnOff(4, 0, "glitch0"))
        self.toggleSounds.append(SoundOnOff(4, 1, "glitch1"))
        self.toggleSounds.append(SoundOnOff(4, 2, "glitch2"))
        self.toggleSounds.append(SoundOnOff(5, 0, "sophie0"))
        self.toggleSounds.append(SoundOnOff(5, 1, "sophie1"))
        self.toggleSounds.append(SoundOnOff(5, 2, "sophie2"))
        self.toggleSounds.append(SoundOnOff(6, 0, "chords0"))
        self.toggleSounds.append(SoundOnOff(6, 1, "chords1"))
        self.toggleSounds.append(SoundOnOff(6, 2, "chords2"))
        self.toggleSounds.append(SoundOnOff(7, 0, "climax0"))
        self.toggleSounds.append(SoundOnOff(7, 1, "climax1"))
        self.toggleSounds.append(SoundOnOff(7, 2, "climax2"))

        self.toggleSounds.append(SoundOnOff(0, 9, "moreDrums0"))
        self.toggleSounds.append(SoundOnOff(0, 10, "moreDrums1"))
        self.toggleSounds.append(SoundOnOff(0, 11, "moreDrums2"))
        self.toggleSounds.append(SoundOnOff(0, 12, "moreDrums3"))
        self.toggleSounds.append(SoundOnOff(1, 9, "more0"))
        self.toggleSounds.append(SoundOnOff(1, 10, "more1"))
        self.toggleSounds.append(SoundOnOff(1, 11, "more2"))
        self.toggleSounds.append(SoundOnOff(1, 12, "more3"))
        self.toggleSounds.append(SoundOnOff(1, 13, "more4"))
        self.toggleSounds.append(SoundOnOff(1, 14, "more5"))

        self.faders = []

        self.faders.append(Fader(6, "thisLove"))
        self.faders.append(Fader(7, "gormaduli"))

        asyncio.ensure_future(self.play())

        self.onOff = 0

    async def play(self):
        while True:
            self.draw()

            for fader in self.faders:
                fader.fadeVolume()

            await asyncio.sleep(0.1)

    def draw(self):
        buffer = monome.GridBuffer(self.grid.width, self.grid.height)

        # all off
        buffer.led_level_set(4, 0, self.onOff*11+4)

        for toggle in self.toggleSounds:
                buffer.led_level_set(toggle.x, toggle.y, toggle.draw())

        for fader in self.faders:
            for index, row in enumerate(fader.y):
                buffer.led_level_set(fader.x, index, fader.draw(index))

        # update grid
        buffer.render(self.grid)

    def on_grid_key(self, x, y, s):
        # all off
        if x == 4 and y ==0:
            self.onOff ^= 1
            for toggle in self.toggleSounds:
                toggle.onOff = 0
                toggle.sendMessage()
            for fader in self.faders:
                for index, row in enumerate(fader.y):
                    fader.y[index] = 0
                fader.destination = 0
        # toggle steps
        if s == 1:
            for toggle in self.toggleSounds:
                if x == toggle.x and y == toggle.y:
                    toggle.onOff ^= 1;
                    toggle.sendMessage();

            for fader in self.faders:
                if x == fader.x:
                    fader.toggleButton(y)

            self.draw()


if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    mirroring_medusa = MirroringMedusa()

    def serialosc_device_added(id, type, port):
        print('connecting to {} ({})'.format(id, type))
        asyncio.ensure_future(mirroring_medusa.grid.connect('127.0.0.1', port))

    serialosc = monome.SerialOsc()
    serialosc.device_added_event.add_handler(serialosc_device_added)

    client = udp_client.SimpleUDPClient("127.0.0.1", 6010)

    loop.run_until_complete(serialosc.connect())
    loop.run_forever()
