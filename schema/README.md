# Experiment Schema

## Version 0.1 (Current)

**Status**: Frozen — breaking changes discouraged

The schema in `experiment_schema.json` is version 0.1. We're prioritizing stability over perfection.

## Why Freeze?

Open-source datasets die when schemas keep shifting. Contributors need stability to build tools, analysis, and trust.

## Schema Changes Policy

- **v0.1**: Current stable version
- **v0.2+**: Future versions will maintain backward compatibility
- **Breaking changes**: Only in major versions (v1.0, v2.0, etc.)

## Extending the Schema

You can extend the schema with:
- Additional optional fields
- New sensor types
- New action types
- Additional metadata

**What you can't do**:
- Remove required fields
- Change field types
- Rename existing fields

## Migration

When we do need breaking changes:
1. Announce 3 months in advance
2. Provide migration scripts
3. Support both old and new formats during transition
4. Document changes clearly

## Current Schema

See `experiment_schema.json` for the full schema definition.

**Required fields**:
- `experiment_id`
- `timestamp`
- `hardware`
- `sensors`
- `actions`
- `outcome`
- `reward`

**Optional fields**:
- `contributor`
- `notes`
- `failures`
- Additional metrics in `outcome.metrics`

