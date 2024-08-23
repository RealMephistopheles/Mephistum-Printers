
# Mephistum Printers

Basic Customizable Garry's Mod Money Printers for DarkRP

Credit :

- In this Addon i'm using 3D2D ImGui made by [@wyozi-gmod](https://github.com/wyozi-gmod/) - [link to ImGui Repo](https://github.com/wyozi-gmod/)
- My Big Brain for making this __Kappa__
## Features

Here a simple list of the current features:

- Level system
- Storage system
- Custom color
- Custom Print Rate
- Upgradeable Printer

__( I dont know if I ever will add more features to it or improve it ( Read the section under to learn more ) )__
## Can we get more than that?

If you looking for more features in my printers and want some custom made changes or brand new printers to fit you own needs

You can reach to me via discord : `RealMephistopheles`

__Disclaimer : Everything has a price, I made these printers public for anybody to use or learn from even-though the code is not perfect__
## Installation

Download the code on the top right.

Open the downloaded zip file.

Drop the folder **'Mephistum-Printers-main'** into your **'garrysmod/garrysmod/addons'** folder

Enoy :)

## Config

I made this as simple I as could think of !! To config each individual printer you need go in the following path :
```text
'Mephistum-Printers-main/lua/config'
```

Once you get there you will have files with the same name as each printers. Open up the file and configure it as you wish :)
## Create New Printers

To make new Printers it is quite easy heres how :

- **STEP 1 - THE ENTITY FILE**

First we need to create the new entity.
First go in the following folder :
```text
    Mephistum-Printers-main/lua/entities
```
Once you're there you must copy and paste one of the many printers 
it will have the same name but with '**- Copy**' at the end

You want to change that to the name you wish to call you're brand new printer
( it will be its entity name in-game ( ex : mmp_Bronze ) )


- **STEP 2 - THE CONFIG FILE**

Now we want to make its own config file.
You must go in the config folder at the following path:
```text
    Mephistum-Printers-main/lua/config
```

Now Copy and Paste one of the file, same as for the folder you did previously,

Rename it the same as the new printer folder you've made.

- **STEP 3 - THE ENTITY TO ITS CONFIG FILE**

Once you did that you need to go back in the printer folder you made,  you want to open the '**shared.lua**' file

and in the like where it says
```lua
include("config/[PRINTERNAME].lua")
```

You want to replace **[PRINTERNAME]** by the config file you created.

Congrats! You made you're own printer :)

## Authors

- [@RealMephistopheles](https://github.com/RealMephistopheles/)

