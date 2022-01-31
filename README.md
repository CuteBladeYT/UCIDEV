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
Settings / Prefixes directory is `res://`<br>
BUT there's also Project directory (for logs) in `user://`<br>
`user://` on:
- Windows: `%AppData%\Godot\UCIDEV`
- Linux: `~/.local/share/godot/`
- Mac OS X: `~/Library/Application Support/Godot/`

#### Keybinds

**Note: On Mac `CTRL` is `CMD`**

`CTRL + S` - Save<br>
`CTRL + SHIFT + S` - Save As<br>
`CTRL + O` - Open new file<br>
`CTRL + D` - Change project directory<br>

<br>

### Customization
**Note:** Paths are listed [here](#how-to-use)

#### Settings

Settings file is in `res://settings.uci`<br>
It looks like this:
```
lineNum true
drawTabs true
minimap true
minimapWid 80
caretBlock false
caretBlink false
smoothScroll false
```
This is default settings that comes with 

<br>

Theme and Highlighting colors config files can be found in `res://theme/`. They can be easiy customized with Godot

<br>

#### Plugins

Well yeah, in version **v2.0.0** plugins got included, they are stored in `res://plugins/` and they can be written in **GodotScript**, **NativeScript** and **VisualScript**. There's an example plugin that comes with UCID named `.example.gd` and is written in GodotScript.

<br>

#### Custom Background?!?!

Yep. In version **v2.0.0** you can use your own custom background image.<br>
It's stored in `res://` and the name should be `bg` ending with `.jpg` or `.png`
