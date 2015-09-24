##Romanesco Unu 1.1.1.28
Romanesco is a Generative Live Art Application, but can be
your object manager to test your sketch in a P3D world.
Those sketches are the progress work. 
To download the last built version [app 1.1.0.27](http://romanescoproject.wordpress.com/download/)

##Architecture Sketches
* Romanesco : Sketch to set the Romanesco application.
* Controleur : interface slider to use the objects and the different parameters.
* Prescene : use to move the object in the 3D space.
* Scene : Display the result, we can use this one to send to syphon or not.
* Romanesco must be coded with Processing 3.0a5


##Memory
Romanesco Prescene and Scene need a lot of memory to run in Processing. May be you will need to increase the Processing memory.

##Help to code
If you want code in Romanesco there few compulsory variables, methods and functions.  You find the different files in the folder "HELP/Romanesco Code/" and others who can help you.

##Code and Export
* Create a new tab with a clean sub class "SuperRomanesco" in Prescene Sketch
* Give number ID to this one, this number must be in the series of the other. No interruption from the first Obj ID to the last ID.
* When your code is done, run the Prescene to create the index of yours objects in the folder : index_romanesco_objects.csv :  "Prescene-#/preferences/objects" paste this one in the to the folder "Controleur-#/preferences/objects".
* Change or add a thumbnail for your object "Controleur_##/data/thumbnail/.../name+IDnumber+png" there is 4 pic for each object. Size 22x22 pixel in png mode. You can use the illustrator file in the main folder.
* Run the sketch Controleur
* If your code work fine, you can past your brick in the folder "Scene-##"

##Built Romanesco on OSX
* Before export your sketches
* Create a main folder, in this one create a folder named "sources".
* In "sources" you create "preferences" folder
* In "preferences" you drop :
 * "background_shader" folder
 * "Font" folder
 * "Images" folder 
 * "Karaoke" folder 
 * "network" folder 
 * "objects" folder 
 * "pixel"  folder
 * sketchProperty.csv file
 * "setting" folder 
 * shaderBackgroundList.csv file 
 * sliderListEN.csv file
 * sliderListFR.csv file
* Export all your sketches
  * For the Scene, you must export the sketch two times. In the first you must comment the line ````fullScreen()```` after you add "_fullscreen" to the end of the name file. After you make the second export uncomment ````fullScreen()````and comment the line ````size()````. When the export is done, add "_window"  to the end of the name file.
  * For the other exportation nothing in particular.
  * Put the "Launcher.app" in the main Folder
  * For the other "Controleur_##", "Prescene_##", "Scene_##_window" and "Scene_##_fullscreen" in "sources" drop it in the "sources" folder. 
  * *You can embeded Java when you export your differents app. That make bigger file but easiest to use on other platform.
* Check your internet connexion and run.

##Built Romanesco on Linux
* ?

##Built Romanesco on Windows
* ?

##Libraries used for the application
* OSC, add from libraries Manager of Processing.
* YahooWeather, add from libraries Manager of Processing.
* [Geomerative](http://www.ricardmarxer.com/geomerative/)
* [Leapmotion] (https://github.com/heuermh/leap-motion-processing)
* [Tablet] (http://interfaze.info/libraries/tablet/)
* Syphon, add from libraries Manager of Processing.
* Video, add from libraries Manager of Processing.
* Minim, add from libraries Manager of Processing.
* The Midi Bus, add from libraries Manager of Processing.
* [Romefeeder, Toxilib and Twitter] (https://www.dropbox.com/s/jl0kr6tug7daut5/libraries_romanesco.zip?dl=0)


##LICENCE
ROMANESCO is under the licence [CeCILL](http://www.cecill.info/licences/Licence_CeCILL_V2.1-en.html).
Romanesco is a free software.
For the commercial using [make a donation can be good  ](http://romanescoproject.wordpress.com/download/) to support the project !
ROMANESCO 2011-2015.
