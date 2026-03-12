Want to add 3DS jingles to this repo, but don't know how? It's really simple!

Fork the repository and we'll get started.

First, get your 3DS rom files ready. This means they'll need to be in either the .3ds or .cci file format. If you have them in .zcci or .z3ds, convert them back.

Then, you're going to need to download the tools `3dstools` and `vgmstream`. Depending on the rom, I would highly recommend you have `python3.`
Once you have these installed, move all your ROMs into one folder. For ease of use, I have created a bash script to easily rip your .wavs! (`extract_jingle.sh` in the Contributing/n3ds directory of the repository.) There is also a .bat script for you Windows users, created by Celthium! (the .bat script in this same place.)

Once you've ripped your jingles from your ROMs, please rename them in a reasonable manner. For example,
`Metroid - Samus Returns.wav` becomes `metroid-samus-returns.wav`

The shell script should do this automatically for you, but there are some cases in which manual editing may be preferred. For example: 

The Legend of Zelda is typically shortened to 'tloz', and any following subtitle is also shortened. The Legend of Zelda, A Link Between Worlds: tloz-albw

Metal Gear Solid becomes 'mgs'

Shin Megami Tensei becomes 'smt'

The current exact rules are still being defined, but we are currently leaning to this format:

If the series name is three words or longer, it should be shortened into an acronym. So, Metal Gear Solid is shortened into mgs.

If the series name contains an 'and', you may use the ampersand. So, Mario and Luigi would become m&l.

If the series has been shortened, then the subtitle should also be shortened unless it is exactly one word long. For example, Mario and Luigi - Bowser's Inside Story would be written as m&l-bis, but Mario and Luigi - Brothership would be written as m&l-brothership.

On top of this, the subtitle should be shortened in any case in which it is three words or longer, excluding fillers. For example, Paper Mario and the Thousand Year Door should become paper-mario-ttyd. However, Kirby and the Rainbow Curse would simply be written as kirby-and-the-rainbow-curse.

Hyphenated words will be considered as two words. Spider-Man will be considered as "Spider Man". Filler words are any words that would not be capitalized if they were placed in the middle of a title. If two titles inside the same folder share an acronym, then the last word of both games will be expanded. For example, on the GBA, Super Mario Bros. and Super Monkey Ball both expand to smb.wav. This would be resolved by changing it to smbros.wav and smball.wav.

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
