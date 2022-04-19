#! /usr/bin/env python3

import asyncio
import monome

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

class MirroringMedusa(monome.GridApp):
    def __init__(self):
        super().__init__()

    def on_grid_ready(self):
        self.step = [[0 for col in range(self.grid.width)] for row in range(8)]
        self.toggleSounds = []
        # for col in range(16):
        #     for row in range(8):

        self.toggleSounds.append( SoundOnOff(0, 0, "vocal0") )
        self.toggleSounds.append( SoundOnOff(0, 1, "vocal1") )
        # self.toggleSounds[1] = SoundOnOff(1, 1, "vocal1")
        # self.toggleSounds.append(ts)
        asyncio.ensure_future(self.play())

    async def play(self):
        while True:
            self.draw()

            await asyncio.sleep(0.1)

    def draw(self):
        buffer = monome.GridBuffer(self.grid.width, self.grid.height)

        # display steps
        # for x in range(self.grid.width):
        #     for y in range(self.grid.height):
        #         index = x + y * self.grid.width;
        for toggle in self.toggleSounds:
                buffer.led_level_set(toggle.x, toggle.y, toggle.draw())

        # update grid
        buffer.render(self.grid)

    def on_grid_key(self, x, y, s):
        # toggle steps
        if s == 1:
            # for (i ) {
            #       if (x == toggleSounds[i].x && y == toggleSounds[i].y) {
            #         toggleSounds[i].onOff ^= 1;
            #         toggleSounds[i].sendMessage();
            #       }
            #     }
            self.step[y][x] ^= 1
            self.draw()


if __name__ == '__main__':
    loop = asyncio.get_event_loop()
    mirroring_medusa = MirroringMedusa()

    def serialosc_device_added(id, type, port):
        print('connecting to {} ({})'.format(id, type))
        asyncio.ensure_future(mirroring_medusa.grid.connect('127.0.0.1', port))

    serialosc = monome.SerialOsc()
    serialosc.device_added_event.add_handler(serialosc_device_added)

    loop.run_until_complete(serialosc.connect())
    loop.run_forever()
