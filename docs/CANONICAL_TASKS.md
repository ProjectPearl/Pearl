# Canonical Tasks

PEARL supports a fixed set of canonical task types. This ensures experiments are comparable and data is aggregatable.

## Why Fixed Tasks?

- **Comparability** - Same task type = comparable results
- **Aggregation** - Combine data across experiments
- **Standards** - Clear success criteria
- **Focus** - Prevents scope creep

---

## Task Types

### 🎯 Balance
**Code:** `balance`

Maintain upright position against disturbances.

**Expected sensors:**
- IMU (accelerometer + gyroscope)
- Optionally: encoders for wheel position

**Recommended reward:**
- +1 per second of maintained balance
- -10 on fall
- Bonus for minimal control effort

**Common failure modes:**
- `control_instability` (oscillation)
- `actuator_saturation` (motor can't correct fast enough)
- `sensor_noise` (IMU drift)

**Success criteria:**
- Remain upright for >30 seconds
- Maximum tilt angle < 15°

---

### 🗺️ Navigation
**Code:** `navigation`

Move from point A to point B.

**Expected sensors:**
- Distance sensors (ultrasonic, IR, LiDAR)
- Encoders or odometry
- Optionally: camera, compass

**Recommended reward:**
- +100 on reaching goal
- -1 per second (time penalty)
- -50 on collision
- Distance-based shaping optional

**Common failure modes:**
- `collision`
- `perception_error` (wrong distance reading)
- `mechanical_slip` (odometry drift)
- `timeout`

**Success criteria:**
- Reach goal within tolerance (e.g., 5cm)
- No collisions
- Within time limit

---

### 🤚 Grasping
**Code:** `grasping`

Pick up an object.

**Expected sensors:**
- Camera or proximity sensor
- Force/pressure sensor (optional)
- Gripper position feedback

**Recommended reward:**
- +100 on successful grasp
- +50 on object contact
- -10 on drop
- -50 on collision/damage

**Common failure modes:**
- `perception_error` (object localization)
- `actuator_saturation` (grip force)
- `mechanical_slip` (object drops)

**Success criteria:**
- Object lifted >5cm
- Held for >5 seconds
- No damage to object

---

### 🦿 Locomotion
**Code:** `locomotion`

Move forward/backward, turn, traverse terrain.

**Expected sensors:**
- IMU
- Encoders
- Current sensing (optional)

**Recommended reward:**
- +1 per meter traveled
- -1 per second (efficiency)
- -10 on stuck/stall

**Common failure modes:**
- `mechanical_slip`
- `actuator_saturation`
- `power_dropout`

**Success criteria:**
- Cover target distance
- Maintain heading (within tolerance)
- No stalls

---

### 👁️ Tracking
**Code:** `tracking`

Follow a moving target (object, line, light).

**Expected sensors:**
- Camera
- IR array (line following)
- Light sensors

**Recommended reward:**
- Negative distance to target
- Bonus for smooth tracking
- Penalty for lost tracking

**Common failure modes:**
- `perception_error`
- `control_instability` (oscillation)
- `sensor_noise`

**Success criteria:**
- Maintain tracking for >30 seconds
- Average error below threshold
- No complete loss of target

---

### 🚫 Avoidance
**Code:** `avoidance`

Navigate while avoiding obstacles.

**Expected sensors:**
- Distance sensors (multiple)
- Camera (optional)
- Bump sensors (optional)

**Recommended reward:**
- +1 per second of safe operation
- -100 on collision
- Bonus for smooth paths

**Common failure modes:**
- `collision`
- `perception_error`
- `environmental_interference`

**Success criteria:**
- Zero collisions
- Operate for target duration
- Minimum safe distance maintained

---

### ❓ Other
**Code:** `other`

For tasks that don't fit existing categories.

**Requirements:**
- Must provide detailed `task.description`
- Must define custom `task.success_criteria`

**Note:** If you use "other" frequently for similar tasks, propose a new canonical task via GitHub issue.

---

## Adding New Canonical Tasks

New task types require:

1. **Documentation** - Clear definition, sensors, rewards, failures
2. **Examples** - At least 3 real experiments submitted
3. **Community review** - Discussion on GitHub
4. **Schema update** - Added in next minor version

Submit proposals via GitHub issue with label `task-proposal`.

---

## Cross-Task Analysis

Because tasks are standardized, you can query patterns:

```sql
-- Success rate by task type
SELECT 
  task->>'type' as task_type,
  COUNT(*) as total,
  SUM(CASE WHEN (outcome->>'success')::boolean THEN 1 ELSE 0 END) as successes,
  ROUND(100.0 * SUM(CASE WHEN (outcome->>'success')::boolean THEN 1 ELSE 0 END) / COUNT(*), 1) as success_rate
FROM experiments
GROUP BY task->>'type';

-- Common failures per task
SELECT 
  task->>'type' as task_type,
  outcome->>'failure_mode' as failure_mode,
  COUNT(*) as count
FROM experiments
WHERE (outcome->>'success')::boolean = false
GROUP BY task->>'type', outcome->>'failure_mode'
ORDER BY count DESC;
```

