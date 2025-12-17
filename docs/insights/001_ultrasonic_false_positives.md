# Insight #001: Ultrasonic Sensor False Positives

**Date**: December 16, 2024  
**Based on**: Navigation bot experiments (0002_navigation_bot)  
**Data points**: 23 attempts, 8 false positive events

## Finding

**Most navigation failures (35%) are caused by false positive obstacle detection from ultrasonic sensors.**

When the HC-SR04 ultrasonic sensor reports an obstacle distance < 20cm, the robot stops and turns. However, in 8 out of 23 attempts, this was a false positive — no actual obstacle was present.

## Evidence

From `experiments/0002_navigation_bot/failures.md`:
- **Pattern 1: False Positive Obstacle Detection** — 8 occurrences
- Root causes identified:
  - Sensor noise and reflections
  - HC-SR04 has ~15 degree cone, picks up floor reflections
  - Electrical interference from motors

## Data Visualization

```
False Positive Rate by Distance Reading:
< 15cm:  62% false positives (5/8)
15-20cm: 38% false positives (3/8)
> 20cm:   0% false positives (0/0)
```

**Key observation**: Lower distance readings (< 15cm) are more likely to be false positives.

## Implications

1. **Sensor filtering is critical**: Simple threshold-based detection is unreliable
2. **Multiple sensors help**: Single ultrasonic sensor insufficient for robust navigation
3. **Calibration matters**: Sensor placement and environment affect readings

## Recommendations

- Use 3-sample averaging (reduces but doesn't eliminate false positives)
- Increase threshold to 25cm (reduces false positives but may miss real obstacles)
- Consider Time-of-Flight (ToF) sensors as alternative
- Add secondary sensor (camera, LiDAR) for validation

## Next Steps

- Test with ToF sensor (VL53L0X) in same conditions
- Compare false positive rates
- Document sensor comparison in new experiment

---

*This insight demonstrates the value of documenting failures. Without the detailed failure logs, this pattern would not be visible.*

