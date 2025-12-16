# Firmware: Balance Bot

## Overview
Simple PID controller for balancing on two wheels.

## Key Features
- MPU6050 reading (pitch angle)
- Encoder feedback for wheel speed
- PID control loop at 100Hz
- Motor PWM control

## Dependencies
- MPU6050 library (I2C)
- PID library

## Control Algorithm

```
error = target_angle - current_pitch
motor_output = Kp * error + Kd * d_error/dt
```

## Parameters
- Kp: 15.0
- Kd: 0.5
- Target angle: 0° (upright)

## Data Logging
- Logs: timestamp, pitch angle, motor commands, encoder readings
- Output: Serial (can be extended to SD card)

## Notes
- Requires calibration of MPU6050 offset
- Motor deadband compensation needed
- Battery voltage affects motor response

