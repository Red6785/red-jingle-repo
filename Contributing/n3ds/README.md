# Want to add 3DS jingles to this repo, but don't know how? It's really simple!

First, get your 3DS rom files ready. This means they'll need to be in either the .3ds or .cci file format. If you have .zcci, .z3ds, .cia, or .app, you will have to convert them into one of these two formats.
Secondly, please install [Python](https://www.python.org/downloads/release/python-3143/) if you don't already have it.

Do you know how to fork a repository and contribute to the original? If yes, move on. If no, 

- Download [Github Desktop](https://desktop.github.com/download/)
- Sign into Github Desktop
- Clone Repository from URL and input `Red6785/red-jingle-repo`, then navigate to wherever it saves the folder in your file manager.

Navigate to Contributing/n3ds, you should see a folder called "games." Please put all of your 3ds ROMs here. Do not worry about accidentally uploading them to the repository, we have a .gitignore file to prevent tracking all 3ds ROM variants.
Then run one of the two scripts (.bat for Windows, .sh for macOS and Linux), and watch the magic happen!
The scripts will automatically extract all of your jingles, convert their name to the proper format, move them to the proper location, and then automatically update the index.json for you!
Once it's done, click the "commit to main" button in the bottom left corner of your screen in GitHub Desktop, and you're golden!


