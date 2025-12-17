// JSON Schema Validator using Ajv
// This validates experiment data against our schema

class SchemaValidator {
  constructor(schema) {
    this.schema = schema;
    this.errors = [];
  }

  validate(data) {
    this.errors = [];
    
    // Basic required field checks
    const required = this.schema.required || [];
    for (const field of required) {
      if (data[field] === undefined || data[field] === null) {
        this.errors.push(`Missing required field: ${field}`);
      }
    }

    // Type checks
    if (data.experiment_id && typeof data.experiment_id !== 'string') {
      this.errors.push('experiment_id must be a string');
    }

    if (data.timestamp && typeof data.timestamp !== 'string') {
      this.errors.push('timestamp must be a string (ISO 8601 format)');
    }

    if (data.reward !== undefined && typeof data.reward !== 'number') {
      this.errors.push('reward must be a number');
    }

    // Hardware validation
    if (data.hardware) {
      if (!data.hardware.platform || typeof data.hardware.platform !== 'string') {
        this.errors.push('hardware.platform is required and must be a string');
      }
      if (!Array.isArray(data.hardware.sensors)) {
        this.errors.push('hardware.sensors must be an array');
      }
      if (!Array.isArray(data.hardware.actuators)) {
        this.errors.push('hardware.actuators must be an array');
      }
    }

    // Outcome validation
    if (data.outcome) {
      if (typeof data.outcome.success !== 'boolean') {
        this.errors.push('outcome.success must be a boolean');
      }
      if (typeof data.outcome.duration_seconds !== 'number' || data.outcome.duration_seconds < 0) {
        this.errors.push('outcome.duration_seconds must be a non-negative number');
      }
    }

    // Actions validation
    if (data.actions && Array.isArray(data.actions)) {
      data.actions.forEach((action, idx) => {
        if (typeof action.timestamp !== 'number') {
          this.errors.push(`actions[${idx}].timestamp must be a number`);
        }
        if (typeof action.action_type !== 'string') {
          this.errors.push(`actions[${idx}].action_type must be a string`);
        }
        if (!Array.isArray(action.values)) {
          this.errors.push(`actions[${idx}].values must be an array`);
        }
      });
    }

    return this.errors.length === 0;
  }

  getErrors() {
    return this.errors;
  }
}

// Load schema and create validator
let validator = null;

async function loadValidator() {
  if (validator) return validator;
  
  try {
    const response = await fetch('./schema.json');
    const schema = await response.json();
    validator = new SchemaValidator(schema);
    return validator;
  } catch (error) {
    console.error('Failed to load schema:', error);
    // Return a basic validator as fallback (must match v0.2 schema)
    validator = new SchemaValidator({ required: ['experiment_id', 'timestamp', 'contributor', 'task', 'hardware', 'outcome', 'reward'] });
    return validator;
  }
}

