# Hardware Setup: Balance Bot

## Platform
ESP32 DevKit v1

## Components

### Sensors
- MPU6050 (6-axis IMU) - $2
- Encoder on each wheel - $3 each

### Actuators
- 2x DC motors with gearbox - $5 each
- Motor driver (L298N) - $3

### Other
- Battery pack (18650, 2-cell) - $5
- Chassis (3D printed or acrylic) - $3
- Wheels - $2

## Total Cost
~$28 USD

## Wiring

- MPU6050: SDA → GPIO 21, SCL → GPIO 22, VCC → 3.3V, GND → GND
- Motor Driver: IN1/IN2 → GPIO 26/27 (left motor), IN3/IN4 → GPIO 14/15 (right motor)
- Encoders: Left → GPIO 18/19, Right → GPIO 16/17

## Assembly Notes

- Center of mass should be as low as possible
- Wheels should have good traction
- Battery placement affects balance point

