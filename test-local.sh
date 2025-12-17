#!/bin/bash

# Quick test script for Embodied Learning project
# Tests if files exist and basic structure is correct

echo "🧪 Testing Embodied Learning Project"
echo "===================================="
echo ""

# Check if we're in the right directory
if [ ! -f "README.md" ]; then
    echo "❌ Error: Not in project root. Run from project root directory."
    exit 1
fi

echo "✅ Project root found"
echo ""

# Check required files
echo "Checking required files..."

files=(
    "README.md"
    "web/index.html"
    "web/submit.html"
    "web/experiments.html"
    "web/config.js"
    "web/schema-validator.js"
    "web/styles.css"
    "schema/experiment_schema.json"
    "experiments/0001_balance_bot/results.json"
    "experiments/0002_navigation_bot/results.json"
)

missing=0
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file (MISSING)"
        missing=$((missing + 1))
    fi
done

echo ""

if [ $missing -gt 0 ]; then
    echo "❌ $missing file(s) missing"
    exit 1
fi

echo "✅ All required files present"
echo ""

# Check config.js
echo "Checking Supabase configuration..."
if grep -q "url: ''" web/config.js; then
    echo "  ⚠️  Supabase not configured (this is OK for local testing)"
    echo "     To test with database, edit web/config.js"
else
    echo "  ✅ Supabase configuration found"
fi

echo ""

# Check schema
echo "Checking schema version..."
if grep -q '"version": "0.2"' schema/experiment_schema.json; then
    echo "  ✅ Schema version 0.2"
else
    echo "  ⚠️  Schema version not found"
fi

echo ""

# Summary
echo "===================================="
echo "✅ Basic structure test passed!"
echo ""
echo "Next steps:"
echo "1. Open web/index.html in a browser"
echo "2. Or start a local server:"
echo "   cd web && python3 -m http.server 8000"
echo "3. Then open: http://localhost:8000"
echo ""
echo "For full testing with database, see TESTING.md"

