# Embodied Learning

## What is this?

An open-source project to collect and share real-world embodied learning data from low-cost physical systems.

## Why does it exist?

Most ML research ignores physical interaction. This project exists to study learning through real-world sensing, action, failure, and feedback.

## What counts as a contribution?

- **Experiments**: Real-world trials with hardware, sensors, and actuators
- **Hardware builds**: Open designs for low-cost embodied systems
- **Firmware**: Code that runs on embedded devices (ESP32, Arduino, etc.)
- **Analysis**: Insights from collected data, metrics, and learning approaches
- **Documentation**: Guides, schemas, and examples that help others contribute

## What this is NOT

- ❌ Not a startup
- ❌ Not AGI
- ❌ Not simulation-only
- ❌ Not closed datasets

## How to get started in 30 minutes

1. **Read the schema** (`schema/experiment_schema.json`) - understand what data we collect
2. **Check out an example** (`experiments/0001_balance_bot/`) - see how experiments are documented
3. **Pick your path**:
   - **Builder?** Run an experiment and submit data via `web/submit.html`
   - **Developer?** Improve the web app, firmware, or schema validation
   - **Thinker?** Analyze existing data in `experiments/` and propose insights
4. **Submit your first contribution** - follow `CONTRIBUTING.md`

If you can't contribute in 30 minutes, we've failed. [Open an issue](https://github.com/ananyadevdesai/embodied-learning/issues) and tell us why.

## Core Principles

- **Open data schemas**: Everything is documented and extensible
- **Transparent experiments**: Success and failure are both valuable
- **No proprietary lock-in**: Use standard formats, open hardware
- **Real-world only**: No simulation-only experiments
- **Failure logs are as valuable as success**: Document what didn't work

## License

- **Code**: MIT License (see `LICENSE`)
- **Data**: CC BY 4.0 (see `DATA_LICENSE.md`)
- **Documentation**: CC BY-SA 4.0

## Quick Links

- [Contributing Guide](CONTRIBUTING.md)
- [Code of Conduct](CODE_OF_CONDUCT.md)
- [Governance](GOVERNANCE.md)
- [Project Vision](docs/vision.md)
- [Experiment Schema](schema/experiment_schema.json)
