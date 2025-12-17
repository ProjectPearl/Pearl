# Hardware Setup: Navigation Bot

## Platform
ESP32 DevKit v1

## Task
Move forward 1 meter without collision using ultrasonic sensor feedback.

## Components

### Sensors
- HC-SR04 Ultrasonic sensor - $2
- 2x Wheel encoders - $3 each

### Actuators
- 2x DC motors with gearbox - $5 each
- Motor driver (L298N) - $3

### Other
- Battery pack (18650, 2-cell) - $5
- Chassis (3D printed) - $4
- Wheels - $2

## Total Cost
~$29 USD

## Wiring

- HC-SR04: Trig → GPIO 5, Echo → GPIO 18, VCC → 5V, GND → GND
- Motor Driver: IN1/IN2 → GPIO 26/27 (left motor), IN3/IN4 → GPIO 14/15 (right motor)
- Encoders: Left → GPIO 19/21, Right → GPIO 22/23

## Assembly Notes

- Ultrasonic sensor mounted on front, pointing forward
- Center of mass low for stability
- Wheels with good traction
- Battery mounted low for balance

