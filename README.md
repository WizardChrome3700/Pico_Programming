create a folder named Pico_Programming in ~/ folder and place them both that folder.

give execution access to the files using this command.

chmod +x ~/Pico_Programming/create_project.sh
chmod +x ~/Pico_Programming/pico_sdk_setup.sh

### Raspberry Pi Pico W pinout
![pico W pinout](./board_pinouts/picow-pinout.svg "pico W pinout")

### To use create_project
```
./create_project.sh <Project_Name> <board_name>
```
#### Board Names
| Board | Board_name |
|--------|-----------|
|Raspberry Pi Pico   | pico |
|Raspberry Pi Pico W | pico_w |
|Raspberry Pi Pico 2 | pico2 |

### To build project
```
cd ./<Project_Name>
./BuildProject.sh
```
