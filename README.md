# UCIDEV

UCIDEV is a Open Source, Configurable Text / Code editor made in Godot.

[UCID itch.io](https://unitedcatdom.itch.io/ucidev)
![itchiobanner](https://user-images.githubusercontent.com/78739707/149632044-61e655a3-1c0d-4d4e-a9ad-458c97289efb.png)


### Table of Contents
- [How to Build](#how-to-build)
- [How to Install](#how-to-install)
- [How to Use](#how-to-use)
- [Customization](#customization)
- [Plans for next Releases](https://github.com/CuteBladeYT/UCIDEV/projects/1)

<br>

### How to Build
Make sure you have [Git](https://git-scm.com/downloads) installed on your PC
1. Open Terminal / CMD and type
```bash
git clone https://github.com/CuteBladeYT/UCIDEV
```
2. Download and Run [Godot 3.4](https://github.com/godotengine/godot/releases/tag/3.4-stable)
3. Import the project by clicking **Import** and selecting the folder with project
4. Navigate though `Project > Export > Add > (YOUR OS) ` then in **Export path** select where to export the app
5. If you don't have any export templates, download one in **Export** tab in Godot
6. **Export project**, Remember to uncheck **Export with debugging**!
7. Done!

<br>

### How to Install
Go to [Github Releases](https://github.com/CuteBladeYT/UCIDEV/releases) page and download the version for your Operating System

<br>

### How to Use

#### Directories
Settings / Prefixes directory is `user://`
`user://` on:
- Windows: `%AppData%\Godot\UCIDEV`
- Linux: `~/.local/share/godot/`
- Mac OSX: `~/Library/Application Support/Godot/`

#### Keybinds

**Note: On Mac `CTRL` is `CMD`**

`CTRL + S` - Save
`CTRL + SHIFT + S` - Save As
`CTRL + O` - Open new file
`CTRL + D` - Change current directory

<br>

### Customization
**Note:** Paths are listed [here](#how-to-use)

Settings file is in `user://settings.uci`<br>
It looks like this:
```
caretBlink 1
caretBlock 0
careBlinkSpeed 0.65
minimap 1
minimapWidth 80
lineNum 1
drawTabs 1
drawSpaces 1
brpointGutter 1
foldGutter 1
```

<br>

Theme config can be found in `user://theme.tres` and it can be easily edited in Godot with live preview.
