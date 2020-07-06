# joystick2

This is my personal project where I made a joy stick application in flutter for controlling video games in PC. The app and PC is connected using a http server in flutter. PC backend is made with Python. The backend code is available in JoyStick.ipynb file. For controling the keystrokes sendkeys.py is used. 
## Screen Shots

### Connect Page
![alt text](https://github.com/naharamal/Joy_Stick_App_In_Flutter/blob/master/scrn_shot_2.jpg)
This is the initial page of the app. When the connect key is pressed the http server will be initialised and it will connect to the predefined ip address of my pc.

### Main Page
![alt text](https://github.com/naharamal/Joy_Stick_App_In_Flutter/blob/master/scrn_shot_1.jpg)

This is the page where game is controlled. This joystick is made primarily for the automobile control in GTA-5 game. For each button press in the app, a specific keyword string is passed to pc using the http server client method. This string is processed and used by the python scripy to identify the desired keystroke. Using the SendKeys.py script, the desired key is pressed.

### To do
* Resolve the latency of control.
* Resolve the issues with multiple keystrokes at a time.
* Include mouse control

