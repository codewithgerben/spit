#!/bin/bash

# Usage: ./spit_dead_weight.sh <path-to-java-project>

PROJECT_DIR=$1
REPORT="spit-dead-weight-report.md"

if [ -z "$PROJECT_DIR" ]; then
  echo "Usage: $0 <path-to-java-project>"
  exit 1
fi

cd "$PROJECT_DIR" || { echo "Invalid project directory: $PROJECT_DIR"; exit 1; }

echo "# SPIT Dead Weight Detection Report" > "$REPORT"
echo "Project scanned: \`$PROJECT_DIR\`" >> "$REPORT"
echo "" >> "$REPORT"

# 1. Unused Classes (basic grep reference check)
echo "## Potential Unused Classes" >> "$REPORT"
for file in $(find . -name "*.java" | grep -v "Test.java"); do
  class=$(basename "$file" .java)
  ref_count=$(grep -r "$class" . --include="*.java" | grep -v "$file" | wc -l)
  if [ "$ref_count" -eq 0 ]; then
    echo "- $class (in \`$file\`) appears unused" >> "$REPORT"
  fi
done
echo "" >> "$REPORT"

# 2. Spring Beans never referenced
echo "## Spring Beans Never Injected or Used" >> "$REPORT"
for file in $(grep -rl "@(Component\|Service\|Repository\|Configuration\|RestController)" . --include="*.java"); do
  bean=$(basename "$file" .java)
  usage=$(grep -r "$bean" . --include="*.java" | grep -v "$file" | wc -l)
  if [ "$usage" -eq 0 ]; then
    echo "- $bean (defined in \`$file\`) is never referenced" >> "$REPORT"
  fi
done
echo "" >> "$REPORT"

# 3. Empty Methods and Classes
echo "## Empty Methods or Classes" >> "$REPORT"
grep -r "void [a-zA-Z0-9_]*() { *}" . --include="*.java" | sed 's/^/- /' >> "$REPORT"
grep -r "class [A-Za-z0-9_]* *{ *}" . --include="*.java" | sed 's/^/- /' >> "$REPORT"
echo "" >> "$REPORT"

# 4. Commented Out Code Blocks
echo "## Commented-Out Code" >> "$REPORT"
grep -r "//.*;" . --include="*.java" | grep -v "// TODO" | sed 's/^/- /' >> "$REPORT"
echo "" >> "$REPORT"

echo "_Generated by SPIT Dead Weight Detector_" >> "$REPORT"
echo "Dead weight report generated: $REPORT"
