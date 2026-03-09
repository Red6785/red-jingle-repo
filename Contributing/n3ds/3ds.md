Want to add 3DS jingles to this repo, but don't know how? It's really simple!

Fork the repository and we'll get started.

First, get your 3DS rom files ready. This means they'll need to be in either the .3ds or .cci file format. If you have them in .zcci or .z3ds, convert them back.

Then, you're going to need to download the tools `3dstools` and `vgmstream`. Depending on the rom, I would highly recommend you have `python3.`
Once you have these installed, move all your ROMs into one folder. For ease of use, I have created a bash script to easily rip your .wavs! (`extract_jingle.sh` in the Contributing/n3ds directory of the repository.) There is also a .bat script for you Windows users, created by Celthium! (the .bat script in this same place.)

Once you've ripped your jingles from your ROMs, please rename them in a reasonable manner. For example,
`Metroid - Samus Returns.wav` becomes `metroid-samus-returns.wav`

Then, move your jingles into `jingles/n3ds`, and edit the `index.json` in the root of the repository accordingly, adding a new entry in the json with this format:

```
    { "game": "*game name as it appears in cocoon*", "file": "jingles/n3ds/*your jingle here*.wav"},
```

For example,

```
    {"game": "Animal Crossing - New Leaf", "file": "jingles/n3ds/animal-crossing-new-leaf.wav"},
```

It would be very much appreciated if you placed these in alphabetical order.

Once that's done, open a pull request, and you're done!

Don't know how to make a pull request, but still want to add jingles? Contact me on Discord at `red6785`! I'll probably accept!
