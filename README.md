# PEARL

**Physical Embodied Autonomous Robotics Learning**

An open-source infrastructure for collecting and sharing real-world robotics learning data.

---

## Inspiration

As robotics enthusiasts and machine learning practitioners, we've always been frustrated by a fundamental gap in the field: **most ML research ignores physical reality.**

Simulations are clean. Real robots are messy. They slip, overheat, brownout, and fail in ways that simulators never capture. Yet almost every robotics dataset comes from controlled lab environments or synthetic physics engines.

The researchers building real physical systems — hobbyists, students, small labs — generate incredible learning data every day. But that data disappears. No one shares their failures. No one documents what *didn't* work.

This is where PEARL comes in. PEARL creates an open infrastructure where **failure is a feature, not a bug**. We believe the path to robust embodied intelligence runs through thousands of documented crashes, slips, and sensor glitches — not pristine simulation runs.

---

## What It Does

PEARL is a complete system for collecting, validating, and sharing real-world robotics experiment data.

Our platform provides:

- **Structured Experiment Submission** — A web form that enforces data quality. Missing fields = rejected. No garbage data.
- **Immutable Records** — Once submitted, experiments cannot be edited. This prevents hindsight bias and builds trust.
- **Failures-First View** — The default view shows failures before successes. Because that's where learning happens.
- **Hardware Fingerprinting** — Every hardware configuration gets a unique hash, enabling cross-experiment comparison.
- **Failure Mode Ontology** — Standardized categories (control instability, mechanical slip, perception error, etc.) so patterns emerge across projects.
- **Reproducibility Scoring** — Auto-calculated score based on how complete your documentation is.

Overall, PEARL does the following:

- ✅ Validates experiment data against a strict JSON schema
- ✅ Stores experiments in a permanent, append-only database
- ✅ Categorizes failures with standardized failure modes
- ✅ Enables cross-hardware pattern recognition
- ✅ Prevents data pollution with rate limiting and required fields

---

## How We Built It

PEARL was built using a pure HTML/CSS/JavaScript frontend with a neon cyberpunk aesthetic. We used Supabase as our backend-as-a-service for the database, authentication, and API layer.

The system enforces data quality through multiple layers:

- **JSON Schema validation** on the client side
- **Database constraints** (CHECK constraints, NOT NULL, UNIQUE)
- **Row Level Security** policies that allow INSERT and SELECT but block UPDATE and DELETE
- **Rate limiting** via database triggers (max 10 experiments per hour per contributor)

The frontend uses vanilla JavaScript with no frameworks — keeping it simple, fast, and dependency-free. The schema is versioned and documented to enable long-term data compatibility.

---

## Challenges We Ran Into

Building PEARL wasn't straightforward. We faced several pivots and technical hurdles:

**Schema Design Iterations** — Getting the right balance between strictness and usability took multiple attempts. Too strict and no one submits. Too loose and the data is worthless. We settled on requiring core fields (task, hardware, outcome, reward) while making detailed sensor data optional.

**Immutability Implementation** — Making records truly immutable in Supabase required careful RLS policy design. We had to explicitly NOT create UPDATE or DELETE policies, which feels counterintuitive but ensures data integrity.

**Failure Mode Taxonomy** — Categorizing failures is hard. What's the difference between "control instability" and "actuator saturation"? We researched existing robotics literature and created a practical ontology that covers 90% of real-world failures.

**Balancing Research-Grade vs Accessible** — We wanted this to be usable by hobbyists but rigorous enough for researchers. This tension shaped every design decision.

---

## Accomplishments That We're Proud Of

We're proud that PEARL is **end-to-end functional**. You can submit an experiment right now, and it will be validated, stored, and viewable — permanently.

Key accomplishments:

- **True immutability** — No one, not even admins, can edit submitted experiments
- **Failure-first philosophy** — We believe we're the first open robotics dataset to explicitly prioritize failures
- **Zero dependencies frontend** — Pure HTML/CSS/JS means it works everywhere
- **Research-grade schema** — Versioned, documented, and strict enough for academic use

Beyond the technical work, we're proud of articulating a clear philosophy: *failures are features*. This isn't just a data dump — it's an infrastructure for cumulative learning.

---

## What We Learned

Building PEARL taught us several important lessons:

**Strictness Pays Off** — Every time we relaxed a requirement "to make it easier," we regretted it. Garbage in, garbage out. The schema is strict because it has to be.

**Immutability Changes Behavior** — When you know you can't edit, you're more careful. This is a feature. It encourages thoughtful submission over rapid iteration.

**Failures Are Undervalued** — The robotics community celebrates successes and hides failures. But the failure data is often more valuable. A successful run tells you it works. A failure tells you *why* it doesn't.

**Simple Beats Complex** — No React. No TypeScript. No build tools. Just files that work in any browser. This made development faster and the result more accessible.

---

## What's Next for PEARL

As PEARL evolves, we have a clear roadmap:

**Short Term:**
- More example experiments with real hardware data
- Visualization tools for failure patterns
- ESP32 firmware for auto-logging experiments

**Medium Term:**
- Cross-hardware analysis tools ("Show me all failures on 2-wheel robots on carpet")
- Community annotations system (append-only comments on experiments)
- Integration with common robotics frameworks (ROS, Arduino)

**Long Term:**
- Enough data to enable meta-analysis across experiments
- Published insights from aggregated failure patterns
- A reference dataset that researchers actually cite

What we will **NOT** add:
- ❌ ML models (infrastructure first)
- ❌ Social features (no likes, no gamification)
- ❌ Authentication complexity (anon key is fine for now)

The goal isn't to be a platform. It's to be **infrastructure** — boring, reliable, and cumulative.

---

## Quick Start

```bash
cd web
python3 -m http.server 8080
# Open http://localhost:8080
```

### Submit an Experiment
1. Go to `http://localhost:8080/submit.html`
2. Fill all required fields
3. Submit — it's permanent

### Database Setup
1. Create free account at [supabase.com](https://supabase.com)
2. Run SQL from `CREATE_TABLE.sql`
3. Add credentials to `web/config.js`

---

## Schema

| Field | Required | Description |
|-------|----------|-------------|
| `experiment_id` | ✅ | Format: `NNNN_name` |
| `contributor` | ✅ | GitHub username |
| `task` | ✅ | Type + description |
| `hardware` | ✅ | Platform, MCU, motors, power, sensors |
| `outcome` | ✅ | Success/failure + duration |
| `reward` | ✅ | Numeric reward signal |
| `notes` | ❌ | Optional observations |

See [`schema/experiment_schema.json`](schema/experiment_schema.json) for full spec.

---

## Failure Modes

| Code | Description |
|------|-------------|
| `control_instability` | Oscillation, runaway |
| `mechanical_slip` | Traction loss |
| `perception_error` | Bad sensor reading |
| `actuator_saturation` | Motor maxed out |
| `power_dropout` | Brownout, reset |
| `sensor_noise` | High noise floor |
| `collision` | Unintended contact |

---

## License

- **Code:** MIT
- **Data:** CC BY 4.0
- **Docs:** CC BY-SA 4.0

---

## The Litmus Test

For every feature, ask:

> **Does this make physical learning more cumulative?**

If not → don't build it.

---

## About

PEARL creates open infrastructure for real-world robotics learning data. Failures are features. Immutability ensures trust. No ML yet — infrastructure first.
