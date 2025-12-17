# Good First Issues

These are starter issues perfect for new contributors. Pick one and open a PR!

## Issue 1: Add Chart - Reward vs Time

**Difficulty**: Easy  
**Type**: Frontend / Visualization  
**Labels**: `good-first-issue`, `data`, `frontend`

### Description
Add a simple chart showing reward over time for experiments. This helps visualize learning progress.

### Tasks
- [ ] Add a charting library (Chart.js or similar) to `experiments.html`
- [ ] Fetch experiment data with timestamps
- [ ] Plot reward (y-axis) vs timestamp (x-axis)
- [ ] Make it responsive for mobile
- [ ] Add tooltip showing experiment details on hover

### Expected Outcome
When viewing experiments, users see a line chart showing how reward changes over time across experiments.

### Resources
- [Chart.js Documentation](https://www.chartjs.org/docs/latest/)
- Example data structure in `experiments/0002_navigation_bot/results.json`

### How to Get Started
1. Fork the repository
2. Create a branch: `git checkout -b feature/reward-chart`
3. Add Chart.js CDN to `experiments.html`
4. Create a canvas element for the chart
5. Fetch experiments and plot data
6. Submit a PR!

---

## Issue 2: Improve Schema for Encoder Sensors

**Difficulty**: Medium  
**Type**: Schema / Data  
**Labels**: `good-first-issue`, `schema`, `data`

### Description
The current schema doesn't explicitly support encoder data well. Add better support for encoder readings (counts, velocity, position).

### Tasks
- [ ] Review current schema in `schema/experiment_schema.json`
- [ ] Add encoder-specific fields to `sensors` object
- [ ] Document encoder data format
- [ ] Update example experiments to use new format
- [ ] Update validation in `schema-validator.js`
- [ ] Update `submit.html` form to support encoder data

### Expected Outcome
Schema clearly supports encoder data with fields like:
- `encoder_left_counts`: array of counts
- `encoder_right_counts`: array of counts
- `encoder_left_velocity`: array of velocities (counts/second)
- `encoder_right_velocity`: array of velocities

### Resources
- Current schema: `schema/experiment_schema.json`
- Example with encoders: `experiments/0002_navigation_bot/results.json`

### How to Get Started
1. Study the current schema structure
2. Look at how encoders are currently stored (as generic sensor arrays)
3. Design a better structure for encoder data
4. Update schema, examples, and validation
5. Submit a PR with clear explanation of changes

---

## Issue 3: ESP32 Example Firmware for Logging

**Difficulty**: Medium  
**Type**: Firmware / Hardware  
**Labels**: `good-first-issue`, `firmware`, `hardware`

### Description
Create a complete, working ESP32 firmware example that logs experiment data in the correct JSON format.

### Tasks
- [ ] Create `firmware/esp32/example_logger/` directory
- [ ] Write Arduino/PlatformIO code that:
  - Reads sensors (IMU, encoders, etc.)
  - Logs actions (motor commands)
  - Formats data according to our schema
  - Outputs JSON via Serial (or SD card)
- [ ] Include wiring diagram
- [ ] Add README with setup instructions
- [ ] Test with real hardware (if possible)

### Expected Outcome
A complete firmware example that contributors can copy and adapt for their hardware. Output should match our JSON schema exactly.

### Resources
- Schema: `schema/experiment_schema.json`
- Example data: `experiments/0001_balance_bot/results.json`
- ESP32 documentation: https://docs.espressif.com/

### How to Get Started
1. Set up PlatformIO or Arduino IDE with ESP32 support
2. Create basic structure (sensor reading, action logging)
3. Format output as JSON matching our schema
4. Test with Serial output
5. Document everything
6. Submit a PR!

---

## How to Contribute

1. **Pick an issue** from above (or create your own!)
2. **Comment on the issue** (or create one on GitHub) saying you're working on it
3. **Fork and branch** the repository
4. **Make your changes** following our [Contributing Guide](CONTRIBUTING.md)
5. **Test thoroughly** - make sure it works!
6. **Submit a PR** with a clear description

## Need Help?

- Open a [Discussion](https://github.com/ProjectPearl/Pearl/discussions)
- Check [CONTRIBUTING.md](CONTRIBUTING.md)
- Review existing code for patterns

## After Your First PR

Once you've completed a good first issue:
- You'll be added as a contributor
- You can pick more complex issues
- You can propose new features
- You're part of the community! 🎉

