# Contributing to Embodied Learning

Thank you for your interest! This guide helps you find your place in the project.

## Contributor Paths

### 🛠️ Builders

**What you do:**
- Run real-world experiments with hardware
- Upload experiment data via the web interface
- Share hardware setup documentation
- Log failures and unexpected behaviors

**How to start:**
1. Review `schema/experiment_schema.json` to understand data format
2. Check `experiments/0001_balance_bot/` for an example
3. Run your experiment and document it
4. Submit via `web/submit.html` or open a PR with your experiment folder

**What we need:**
- Real sensor data (IMU, cameras, encoders, etc.)
- Action logs (motor commands, actuator states)
- Outcomes (success/failure, metrics)
- **Failure logs are especially valuable** - document what didn't work

### 💻 Developers

**What you do:**
- Improve the experiment schema
- Enhance the web application
- Develop firmware for embedded devices
- Add validation and tooling

**How to start:**
1. Check `backend/README.md` for backend architecture
2. Check `firmware/esp32/README.md` for firmware guidelines
3. Review open issues labeled `good-first-issue`
4. Submit PRs with tests and documentation

**What we need:**
- Schema improvements that maintain backward compatibility
- Better data validation
- Firmware templates for common platforms
- Web UI improvements

### 🧠 Thinkers

**What you do:**
- Analyze collected data
- Propose new metrics and evaluation approaches
- Suggest learning algorithms and architectures
- Write insights and research notes

**How to start:**
1. Explore data in `experiments/` directory
2. Create analysis notebooks or scripts
3. Document insights in `docs/`
4. Open issues with proposals for new metrics or approaches

**What we need:**
- Data analysis and visualizations
- Proposals for learning objectives
- Failure pattern analysis
- Comparative studies across experiments

## Contribution Process

1. **Fork the repository**
2. **Create a branch** (`git checkout -b feature/your-contribution`)
3. **Make your changes**
4. **Test your changes** (if applicable)
5. **Submit a Pull Request** with a clear description

## Data Quality Standards

All experiments must:
- ✅ Validate against `schema/experiment_schema.json`
- ✅ Include reward/outcome information
- ✅ Document hardware setup
- ✅ Include failure logs (if applicable)

Submissions missing required fields will be rejected.

## Questions?

- Open a [Discussion](https://github.com/ProjectPearl/Pearl/discussions)
- Check existing [Issues](https://github.com/ProjectPearl/Pearl/issues)
- Review `GOVERNANCE.md` for decision-making process

