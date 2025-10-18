/**
 * PWM Example for Raspberry Pi Pico
 * Controls LED brightness using PWM
 * Connect LED between GPIO 0 and GND with 220Ω resistor
 */
#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/pwm.h"

#define LED_PIN 0

int main() {
    stdio_init_all();
    printf("PWM LED Brightness Control Started!\n");

    // Initialize PWM on the LED pin
    gpio_set_function(LED_PIN, GPIO_FUNC_PWM);
    
    // Get PWM slice number (each slice controls two pins)
    uint slice_num = pwm_gpio_to_slice_num(LED_PIN);
    
    // Set PWM frequency
    // System clock is 125MHz, wrap = 125000000 / freq
    pwm_set_clkdiv(slice_num, 125.0f);  // Divide clock by 125 (1MHz)
    pwm_set_wrap(slice_num, 1000);      // 1MHz / 1000 = 1kHz PWM frequency
    pwm_set_enabled(slice_num, true);   // Enable PWM

    printf("PWM initialized on GPIO %d\n", LED_PIN);
    printf("PWM Frequency: 1kHz\n");

    while (true) {
        // Fade in
        printf("Fading in...\n");
        for (int duty_cycle = 0; duty_cycle <= 1000; duty_cycle += 10) {
            pwm_set_gpio_level(LED_PIN, duty_cycle);
            sleep_ms(10);
        }

        // Fade out
        printf("Fading out...\n");
        for (int duty_cycle = 1000; duty_cycle >= 0; duty_cycle -= 10) {
            pwm_set_gpio_level(LED_PIN, duty_cycle);
            sleep_ms(10);
        }
        
        sleep_ms(1000);
    }
}