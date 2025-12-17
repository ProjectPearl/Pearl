# Failure Mode Ontology

PEARL uses a standardized taxonomy of failure modes. This enables pattern recognition across experiments and hardware configurations.

## Standard Failure Categories

### 🔴 Control Instability
**Code:** `control_instability`

The control system fails to maintain stable behavior.

**Symptoms:**
- Oscillation around setpoint
- Growing amplitude of corrections
- Runaway behavior

**Common causes:**
- PID gains too high
- Insufficient sensor sampling rate
- Control loop latency

**Related tasks:** balance, tracking

---

### 🟠 Mechanical Slip
**Code:** `mechanical_slip`

Loss of traction or mechanical coupling.

**Symptoms:**
- Wheels spinning without movement
- Unexpected position drift
- Encoder-actual position mismatch

**Common causes:**
- Low surface friction
- Worn wheels/treads
- Overloaded payload

**Related tasks:** navigation, locomotion

---

### 🟡 Perception Error
**Code:** `perception_error`

Sensors return incorrect or noisy data.

**Symptoms:**
- Incorrect distance readings
- False positive/negative detections
- Erratic sensor values

**Common causes:**
- Environmental interference
- Sensor saturation
- Calibration drift

**Related tasks:** navigation, avoidance, tracking

---

### 🟣 Actuator Saturation
**Code:** `actuator_saturation`

Actuators reach physical limits.

**Symptoms:**
- Motor stall
- PWM at 100% without desired effect
- Servo hitting mechanical stops

**Common causes:**
- Insufficient motor torque
- Battery voltage drop
- Mechanical binding

**Related tasks:** grasping, locomotion

---

### ⚫ Power Dropout
**Code:** `power_dropout`

Loss of electrical power.

**Symptoms:**
- System reset
- Brown-out behavior
- Intermittent operation

**Common causes:**
- Battery depletion
- Current spike exceeds capacity
- Loose connections

**Related tasks:** all

---

### 🔵 Sensor Noise
**Code:** `sensor_noise`

High noise floor corrupts measurements.

**Symptoms:**
- Jittery readings
- False motion detection
- Unreliable threshold triggers

**Common causes:**
- EMI from motors
- Inadequate shielding
- ADC resolution limits

**Related tasks:** balance, tracking

---

### ⚪ Communication Loss
**Code:** `communication_loss`

Failure in data transmission.

**Symptoms:**
- Commands not received
- Telemetry gaps
- Desynchronization

**Common causes:**
- Wireless interference
- Buffer overflow
- Protocol timeout

**Related tasks:** all (remote operation)

---

### 🟤 Environmental Interference
**Code:** `environmental_interference`

External factors disrupt operation.

**Symptoms:**
- IR sensor fooled by sunlight
- Ultrasonic interference from HVAC
- Magnetic field distortion

**Common causes:**
- Uncontrolled environment
- Other robots/devices nearby
- Weather conditions

**Related tasks:** navigation, avoidance

---

### ⏱️ Timeout
**Code:** `timeout`

Task not completed within time limit.

**Symptoms:**
- Task incomplete at deadline
- Stalled progress

**Common causes:**
- Conservative control parameters
- Unexpected obstacles
- Suboptimal path planning

**Related tasks:** navigation, grasping

---

### 💥 Collision
**Code:** `collision`

Unintended physical contact.

**Symptoms:**
- Impact detected
- Mechanical damage
- Task abort

**Common causes:**
- Sensor blind spots
- Insufficient reaction time
- Speed too high for sensing

**Related tasks:** navigation, avoidance

---

### ❓ Other
**Code:** `other`

Failure doesn't fit standard categories.

When using this category, **always** provide a detailed `failure_description` in your submission. If you see a pattern of similar "other" failures, propose a new category via GitHub issue.

---

## Using Failure Modes

### In submissions

```json
{
  "outcome": {
    "success": false,
    "failure_mode": "perception_error",
    "failure_description": "Ultrasonic sensor returned 0cm reading when obstacle was 50cm away"
  }
}
```

### Querying by failure mode

```sql
-- Find all perception errors
SELECT * FROM experiments 
WHERE outcome->>'failure_mode' = 'perception_error';

-- Count failures by mode
SELECT outcome->>'failure_mode' as mode, COUNT(*) 
FROM experiments 
WHERE (outcome->>'success')::boolean = false
GROUP BY mode;
```

---

## Why This Matters

1. **Pattern Recognition** - Similar failures across different hardware reveal fundamental challenges
2. **Targeted Improvement** - Know exactly what to fix
3. **Research Value** - Standardized categories enable meta-analysis
4. **Community Learning** - Everyone learns from everyone's failures

---

## Proposing New Failure Modes

If you encounter a consistent failure pattern not covered here:

1. Document at least 3 occurrences
2. Propose via GitHub issue with:
   - Suggested code name
   - Description and symptoms
   - Related tasks
3. Community review
4. Add to next schema version

