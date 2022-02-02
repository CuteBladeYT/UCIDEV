# UCIDEV

UCIDEV is a Open Source, Configurable Text / Code editor made in Godot.

[UCID itch.io](https://unitedcatdom.itch.io/ucidev)
![Untitled](https://user-images.githubusercontent.com/78739707/151876623-2feb5bd9-6971-4c55-a978-83c63447df36.png)


### Table of Contents
- [How to Build](#how-to-build)
- [How to Install](#how-to-install)
- [How to Use](#how-to-use)
- [Customization](#customization)

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
6. **Export project**, it doesn't really matter that much if you check or uncheck **Export with debugging**
7. Done!

<br>

### How to Install
Go to [Github Releases](https://github.com/CuteBladeYT/UCIDEV/releases) page and download the version for your Operating System

<br>

### How to Use

#### Directories
Settings / Prefixes directory is `user://`<br>
`user://` on:
- Windows: `%AppData%\Godot\UCIDEV`
- Linux: `~/.local/share/godot/`
- Mac OS X: `~/Library/Application Support/Godot/`

#### Keybinds

**Mac: `CTRL` = `CMD` | `ALT` = `Option`**
- `F11` - Toggle Fullscreen
- `CTRL + S` - Save
- `CTRL + SHIFT + S` - Save As
- `CTRL + O` - Open new file
- `CTRL + D` - Change project directory
- `ALT + 1-9` - Change current file to equivalent key

<br>

### Customization
**Note:** Paths are listed [here](#how-to-use)

#### Settings

Settings file is in `res://settings.uci` and `res://settingsbackup.uci` (backup)<br>
This is default settings that comes with 

<br>

Theme and Highlighting colors config files can be found in `res://theme/`. They can be easiy customized with Godot

<br>

#### Plugins

Well yeah, in version **v2.0.0** plugins got included, ~~they are stored in `res://plugins/`~~ (FIXED IN [v2.2.0](https://github.com/CuteBladeYT/UCIDEV/releases/tag/v2.2.0), to install plugins you have to build the app for yourself. [How to Build](#how-to-build).<br>
How to install plugins:
- Do first three steps from [How to Build](#how-to-build)
- In project tree there's Control node named `plugins` (on top of the list), inside it create another Control node named with the same name your plugins is
- Click on the plugin name (inside project tree) and on the tree on the right scroll to the bottom then next to `Script` there should be `[empty]`. Click on it then click on `Load` and select the script.
- Do the rest from [How to Build](#how-to-build) and you're ready to go!
<br>

Plugins can be written in **GodotScript**, **NativeScript** and **VisualScript**. First line should **always** start with `extends Control`

<br>

#### Custom Background?!?!

Yep. In version **v2.0.0** you can use your own custom background image.<br>
It's stored in `res://` and the name should be `bg` ending with `.jpg` or `.png`
