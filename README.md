# AnimShaderControl

If substance player's glsl shaders have `Time` variable, this plugin keeps updating the variable. (in second)
Using the variable, you can create animated custom shaders as you like.

## usage
Copy plugin/AnimShaderControl folder into your substance painter document folder.
The folder path is like `C:\Users\{Username}\Documents\Allegorithmic\Substance Painter\plugins` for Windows.

Start Substance Painter, you'll find `AnimShaderControl` menu item in plugin menu and also `Animation Control` toolbar. if the toolbar not shown, select `reload` from menu item.
Press `Start` button in the toolbar, shaders which manage `Time` variable start animation. You can control animation speed and update fps by the toolbar.

## animated shader
Although animated shader should be written by yourself, there's a sample shader in shader folder.
Copy it into your shelf/shaders folder ( should be `C:\Users\{Username}\Documents\Allegorithmic\Substance Painter\shelf\shaders`).


This plugin was developed with Windows 10 / Substance Painter 2019.2.0.
