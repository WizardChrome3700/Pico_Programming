/**
 * Simple LED Blink for Raspberry Pi Pico
 * Blinks an LED connected to GPIO 0
 */

#include "pico/stdlib.h"
#include "hardware/gpio.h"

#define LED_PIN 0

int main() {
    stdio_init_all();
    
    // Initialize LED pin
    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);

    while (true) {
        gpio_put(LED_PIN, 1);  // LED ON
        sleep_ms(1000);
        gpio_put(LED_PIN, 0);  // LED OFF
        sleep_ms(1000);
    }
}