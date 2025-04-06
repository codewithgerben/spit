#!/bin/bash

# Usage: ./spit_format_check.sh <path-to-java-project>

PROJECT_DIR=$1
REPORT="spit-format-violations-report.txt"

if [ -z "$PROJECT_DIR" ]; then
  echo "Usage: $0 <path-to-java-project>"
  exit 1
fi

cd "$PROJECT_DIR" || { echo "Invalid project directory: $PROJECT_DIR"; exit 1; }

echo "# SPIT Java Format Violations Report" > "$REPORT"
echo "Scanned Project: $PROJECT_DIR" >> "$REPORT"
echo "" >> "$REPORT"

# Check for google-java-format tool
if ! command -v google-java-format &> /dev/null; then
  echo "google-java-format is not installed."
  echo "Install it from https://github.com/google/google-java-format or via brew/apt/mvn plugin."
  exit 1
fi

# Scan all Java files and report those with formatting issues
find . -name "*.java" | while read file; do
  if ! google-java-format --dry-run "$file" > /dev/null 2>&1; then
    echo "- $file" >> "$REPORT"
  fi
done

echo "" >> "$REPORT"
echo "_Generated by SPIT Java Format Checker_" >> "$REPORT"
echo "Format violation report generated: $REPORT"
