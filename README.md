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

### GPIO interfacing
1. Include necessary libraries
    * ```#include "hardware/gpio.h"```
2. Using GPIO Pins
    * initialise gpio pin: ```gpio_init(LED_PIN);```
    * set gpio pin direction: ```gpio_set_dir(LED_PIN, GPIO_OUT);```
    * set gpio value (for direction out): ```gpio_put(LED_PIN, 1);// 1 for HIGH```
    * read gpio value (for direction in):
        * pullup function: ```gpio_pull_up(BUTTON_PIN)```
        * read button: ```gpio_get(BUTTON_PIN);```
3. Modify CMakeLists.txt
    * target_link_libraries(pwm_interfacing pico_stdlib hardware_gpio)

### PWM interfacing
1. Include necessary libraries
    * ```#include "hardware/pwm.h"```
2. Using PWM function of GPIO pins
    * Set PWM function: ```gpio_set_function(LED_PIN, GPIO_FUNC_PWM);```
    * Get PWM Slice number: ```uint slice_num = pwm_gpio_to_slice_num(LED_PIN);```
        * RP2040 has a total of 8 PWM Slicers each of which have 2 PWM outputs.
        * These PWM outputs share the same PWM frequency but can be of different duty cycle.
    * Set PWM Clock, PWM frequency and Enable PWM Output: 
        * ```pwm_set_clkdiv(slice_num, 125.0f);  // Divide clock by 125 (1MHz)```
        * ```pwm_set_wrap(slice_num, 1000);      // 1MHz / 1000 = 1kHz PWM frequency```
        * ```pwm_set_enabled(slice_num, true);   // Enable PWM```
    * Set PWM pulse width: ```pwm_set_gpio_level(LED_PIN, duty_cycle);```
        * ```duty_cycle``` varies from 0 to pwm_set_wrap
3. Modify CMakeLists.txt
    * ```target_link_libraries(pwm_interfacing pico_stdlib hardware_gpio)```
