# PEARL
### Physical Embodied Autonomous Robotics Learning

An open-source infrastructure for collecting and sharing real-world robotics learning data.

**This is not a vibe project.** It's designed for research-grade data integrity.

---

## Project Status

| Metric | Value |
|--------|-------|
| Schema Version | 0.2 |
| Experiments | Growing |
| Contributors | Open |
| Task Types | 6 canonical |
| Data License | CC BY 4.0 |

---

## Why PEARL Exists

Most ML research ignores physical interaction. Simulations don't capture:
- Mechanical slip
- Sensor noise
- Power brownouts
- Environmental interference

PEARL collects **real failure data** from physical systems. Failures are features, not bugs.

---

## Core Design Principles

### 🔒 Immutable Records
Once submitted, experiments **cannot be edited**. This prevents hindsight bias and ensures data trustworthiness.

### ❌ Failures First
Default view shows failures before successes. Hardware learning = learning from failure.

### 📋 Strict Schema (Hard Fail)
- Missing reward → **rejected**
- Missing outcome → **rejected**
- Missing hardware + task → **rejected**

No "optional everything." Quality > quantity.

### 🌍 Environment Metadata Required
Every experiment must include:
- Surface (tile, carpet, dirt, etc.)
- Lighting (indoor/outdoor)
- Load (none/light/heavy)

Physical learning without environment context is meaningless.

### 🔧 Hardware Fingerprints
Structured hardware descriptions (MCU, motors, power source) are hashed into a `hardware_id`. This enables cross-experiment comparison.

### 📊 Reproducibility Scoring
Experiments are auto-scored based on metadata completeness. Good logging is encouraged without social policing.

### 🚫 Anti-Vibe Guardrails
- **No ML models yet** — Infrastructure first
- **No anonymous mass uploads** — Rate limited (10/hour per contributor)
- **No likes or gamification** — Honesty over performance theater

---

## Schema v0.2

Breaking changes require major version bump.

**Required fields:**
- `schema_version` — Declares which schema version
- `experiment_id` — Format: `NNNN_descriptive_name`
- `timestamp` — ISO 8601
- `contributor` — GitHub username (no anonymous)
- `task` — Type + description (min 10 chars)
- `hardware` — Platform, MCU, motors, power, sensors, actuators
- `environment` — Surface, lighting, load
- `outcome` — Success/failure + duration + failure_mode (if failed)
- `reward` — Numeric reward signal

See [`schema/experiment_schema.json`](schema/experiment_schema.json) for full spec.

---

## Canonical Tasks

| Task | Description |
|------|-------------|
| `balance` | Maintain upright position |
| `navigation` | Move from A to B |
| `grasping` | Pick up an object |
| `locomotion` | Move/traverse terrain |
| `tracking` | Follow a moving target |
| `avoidance` | Navigate while avoiding obstacles |

See [`docs/CANONICAL_TASKS.md`](docs/CANONICAL_TASKS.md) for expected sensors, rewards, and failure modes.

---

## Failure Mode Ontology

Standardized failure categories enable pattern recognition across experiments:

| Code | Description |
|------|-------------|
| `control_instability` | Oscillation, runaway behavior |
| `mechanical_slip` | Traction loss |
| `perception_error` | Bad sensor data |
| `actuator_saturation` | Motor at max, can't provide more |
| `power_dropout` | Brownout, reset |
| `sensor_noise` | High noise floor |
| `communication_loss` | Wireless/serial failure |
| `environmental_interference` | External disruption |
| `timeout` | Didn't finish in time |
| `collision` | Unintended contact |

See [`docs/FAILURE_MODES.md`](docs/FAILURE_MODES.md) for details.

---

## Quick Start

### View Data
```
cd web
python3 -m http.server 8080
# Open http://localhost:8080
```

### Submit an Experiment
1. Go to http://localhost:8080/submit.html
2. Fill all required fields (marked with *)
3. Submit — it's permanent

### Database Setup (Supabase)
1. Create free account at [supabase.com](https://supabase.com)
2. Run SQL from [`CREATE_TABLE.sql`](CREATE_TABLE.sql)
3. Copy Project URL + anon key to `web/config.js`

---

## Project Structure

```
PEARL/
├── web/                    # Frontend
│   ├── index.html         # Home
│   ├── submit.html        # Submission form
│   ├── experiments.html   # View experiments
│   └── failures.html      # Negative results index
├── schema/
│   └── experiment_schema.json  # JSON Schema v0.2
├── docs/
│   ├── CANONICAL_TASKS.md     # Task definitions
│   └── FAILURE_MODES.md       # Failure ontology
├── CREATE_TABLE.sql       # Supabase schema
└── experiments/           # Example experiments
```

---

## What NOT To Do

❌ Don't add ML models yet — infrastructure first  
❌ Don't optimize UI before data quality  
❌ Don't add auth complexity prematurely  
❌ Don't chase contributor count — quality > quantity  

---

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for guidelines.

Good first issues: [`GOOD_FIRST_ISSUES.md`](GOOD_FIRST_ISSUES.md)

---

## The Litmus Test

For every feature, ask:

> **Does this make physical learning more cumulative?**

If not → don't build it.

---

## License

- **Code:** MIT
- **Data:** CC BY 4.0
- **Docs:** CC BY-SA 4.0

---

## What This Becomes

If we stay disciplined:

- A real-world embodied learning dataset
- A community around physical experimentation
- A reference point that researchers cite

That's rare. That's serious.
