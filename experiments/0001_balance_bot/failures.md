# Failure Log: Balance Bot

## Failure 1: Initial Overshoot (t=2.3s)
**Severity**: Moderate

**What happened**: 
Bot tipped too far forward, controller couldn't recover.

**Root cause**: 
Kp parameter set too high (initially 25.0), causing aggressive corrections that led to oscillation.

**Fix**: 
Reduced Kp to 15.0, added derivative term (Kd = 0.5) to dampen oscillations.

**Lesson**: 
PID tuning requires balance - too aggressive causes instability.

---

## Failure 2: Motor Stuttering (t=5.1s)
**Severity**: Minor

**What happened**: 
Motors would stutter at low speeds, causing small jerky movements.

**Root cause**: 
Motor deadband - motors need minimum voltage to overcome friction. PWM values below ~30% didn't produce movement.

**Fix**: 
Added deadband compensation: if command < 30%, set to 0 or 30% depending on direction.

**Lesson**: 
Real hardware has non-linearities that need compensation.

---

## Failure 3: Battery Voltage Drop (t=8.7s)
**Severity**: Minor

**What happened**: 
As battery voltage dropped, motor response changed, requiring retuning.

**Root cause**: 
DC motor speed depends on voltage. As battery drains, same PWM produces different torque.

**Fix**: 
Added voltage monitoring and adaptive scaling (not fully implemented in this experiment).

**Lesson**: 
Power management matters for consistent behavior.

---

## General Observations

- Calibration is critical: MPU6050 offset must be measured accurately
- Center of mass placement significantly affects stability
- Wheel traction matters - smooth surfaces are harder
- Real-world noise in sensors requires filtering

