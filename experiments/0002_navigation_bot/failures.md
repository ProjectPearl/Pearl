# Failure Log: Navigation Bot

## Summary
- **Total attempts**: 23
- **Successes**: 3
- **Failures**: 20

## Failure Patterns

### Pattern 1: False Positive Obstacle Detection (8 occurrences)
**What happened**: 
Ultrasonic sensor reported obstacle (< 20cm) when nothing was present.

**Root cause**: 
- Sensor noise and reflections
- HC-SR04 has ~15 degree cone, picks up floor reflections
- Electrical interference from motors

**Fix attempts**:
- Added 3-sample averaging (helped but didn't eliminate)
- Increased threshold to 25cm (reduced false positives but missed real obstacles)
- Added debounce delay (helped slightly)

**Lesson**: 
Ultrasonic sensors need filtering and calibration. Multiple sensors or different sensor type (LiDAR, ToF) would be better.

---

### Pattern 2: Inaccurate Turn Execution (6 occurrences)
**What happened**: 
Robot overshot or undershot 90-degree turns, causing navigation errors.

**Root cause**: 
- Encoder-based turn calculation inaccurate
- Uneven floor surface
- Motor speed differences (even with same PWM)

**Fix attempts**:
- Calibrated encoder counts per degree (helped)
- Added PID for turn control (improved but still not perfect)
- Used IMU for turn feedback (best solution, but added complexity)

**Lesson**: 
Open-loop control is unreliable. Need feedback (IMU, camera, or better encoders).

---

### Pattern 3: Encoder Stalling (4 occurrences)
**What happened**: 
Encoder readings stopped updating during turns or on rough surfaces.

**Root cause**: 
- Mechanical binding in encoder mounting
- Loose connections
- Debouncing issues in software

**Fix attempts**:
- Tightened encoder mounts (helped)
- Improved wiring connections (fixed most cases)
- Added hardware debouncing (eliminated remaining issues)

**Lesson**: 
Mechanical reliability matters as much as software. Check connections and mounting.

---

### Pattern 4: Distance Calculation Errors (2 occurrences)
**What happened**: 
Robot thought it traveled 1m but actually only went ~80cm.

**Root cause**: 
- Encoder calibration wrong (counts per cm)
- Wheel slip on smooth surfaces
- Battery voltage affecting motor speed

**Fix attempts**:
- Re-calibrated by measuring actual distance (fixed)
- Added voltage compensation (helped)
- Used multiple encoder samples (improved accuracy)

**Lesson**: 
Always validate sensor readings against ground truth. Calibration is critical.

---

## Success Cases

### Success #1 (Attempt 3)
- Clean floor, good lighting
- No false positives
- Accurate turn
- Reached 95cm before timeout

### Success #2 (Attempt 15)
- After encoder calibration
- Used IMU for turn feedback
- Reached 78cm, avoided 1 obstacle successfully

### Success #3 (Attempt 23)
- All fixes applied
- Reached 100cm target
- Avoided 2 obstacles
- Smooth navigation

## Key Learnings

1. **Sensor reliability**: Ultrasonic sensors are noisy. Need filtering or better sensors.
2. **Feedback is essential**: Open-loop control doesn't work for precise navigation.
3. **Calibration matters**: Every sensor needs ground-truth validation.
4. **Real-world is messy**: Battery voltage, floor texture, lighting all affect performance.
5. **Failure is data**: Each failure taught us something. Document everything.

## Recommendations for Future Experiments

- Use ToF (Time-of-Flight) sensor instead of ultrasonic
- Add IMU for orientation feedback
- Implement proper state estimation (Kalman filter)
- Add camera for visual obstacle detection
- Use better encoders (magnetic or optical with higher resolution)

