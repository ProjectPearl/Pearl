# Firmware: Navigation Bot

## Overview
Simple obstacle avoidance using ultrasonic sensor. Robot moves forward, stops if obstacle detected within 20cm, turns, then continues.

## Key Features
- HC-SR04 ultrasonic reading (distance in cm)
- Encoder feedback for distance traveled
- Simple state machine: FORWARD → STOP → TURN → FORWARD
- Motor PWM control

## Dependencies
- NewPing library (for HC-SR04)
- Encoder library

## Control Algorithm

```
State: FORWARD
  - Read ultrasonic distance
  - If distance < 20cm: State = STOP
  - Else: Move forward at 60% speed

State: STOP
  - Stop motors
  - Wait 0.5s
  - State = TURN

State: TURN
  - Turn right 90 degrees (using encoders)
  - State = FORWARD
```

## Parameters
- Forward speed: 60% PWM
- Turn speed: 40% PWM
- Obstacle threshold: 20cm
- Target distance: 100cm (1 meter)

## Data Logging
- Logs: timestamp, distance, encoder counts, state, motor commands
- Output: Serial at 115200 baud
- Can be extended to SD card logging

## Notes
- Ultrasonic sensor has ~15 degree cone, may miss thin obstacles
- Encoder calibration needed for accurate distance
- Battery voltage affects motor speed
- Hard floor surfaces work best

