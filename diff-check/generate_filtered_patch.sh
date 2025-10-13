#!/bin/bash
# Generate filtered patch excluding copyright/header-only changes
# Only includes files with substantive code changes

# ============ CONFIGURATION ============
OLD_DIR="proverif2.03"
NEW_DIR="proverif-compfun"
OUTPUT_FILE="proverif_substantive_changes.patch"
MIN_SUBSTANTIVE_LINES=5  # Minimum non-header changes required
# =======================================

echo "======================================"
echo "Filtered Patch Generator"
echo "======================================"
echo "Configuration:"
echo "  Source directory: $OLD_DIR"
echo "  Target directory: $NEW_DIR"
echo "  Output file: $OUTPUT_FILE"
echo "  Excluding copyright header changes"
echo "  Minimum substantive lines: $MIN_SUBSTANTIVE_LINES"
echo ""

# Clear output file
> "$OUTPUT_FILE"

echo "Scanning for files with substantive code changes..."
echo ""

changed_files=()
total_files=0

for file in $(diff -rq "$OLD_DIR/" "$NEW_DIR/" | grep differ | awk '{print $2}'); do
  # Count changed lines, excluding:
  # - Diff headers (^[+-]{3})
  # - Copyright headers with *
  # - "Cryptographic protocol verifier"
  # - "Bruno Blanchet, Vincent Cheval"
  # - "Copyright (C) INRIA, CNRS"
  # - "This file is modified from ProVerif"
  # - "ProVerif 2.04 is by"
  # - "anonymous for submission to USENIX"
  
  substantive_lines=$(diff -u "$file" "${file/$OLD_DIR/$NEW_DIR}" | \
    grep -E "^[+-]" | \
    grep -v "^[+-]{3}" | \
    grep -v "^\(+\|-\) \*" | \
    grep -v "^\(+\|-\)(\*\*\*\*\*" | \
    grep -v "Cryptographic protocol verifier" | \
    grep -v "Bruno Blanchet, Vincent Cheval" | \
    grep -v "Copyright (C) INRIA, CNRS" | \
    grep -v "This file is modified from ProVerif" | \
    grep -v "ProVerif 2.04 is by" | \
    grep -v "anonymous for submission to USENIX" | \
    wc -l)
  
  if [ $substantive_lines -gt $MIN_SUBSTANTIVE_LINES ]; then
    changed_files+=("$file")
    total_files=$((total_files + 1))
    echo "  ✓ ${file#$OLD_DIR/}: $substantive_lines substantive lines changed"
  fi
done

echo ""
echo "Found $total_files files with substantive code changes"
echo ""
echo "Generating patch file..."
echo ""

# Generate patch for each file
count=0
for file in "${changed_files[@]}"; do
  count=$((count + 1))
  modified_file="${file/$OLD_DIR/$NEW_DIR}"
  filename="${file#$OLD_DIR/}"
  
  echo "  [$count/$total_files] Adding $filename..."
  diff -rupN "$file" "$modified_file" >> "$OUTPUT_FILE"
done

echo ""
echo "======================================"
echo "✓ Patch generation complete!"
echo "======================================"
echo "Output file: $OUTPUT_FILE"
echo "Files included: $total_files"
echo ""
echo "Note: Copyright header changes are still in the patch,"
echo "      but were excluded from the filtering criteria."
echo ""
echo "To apply this patch:"
echo "  cd $OLD_DIR && patch -p1 < ../$OUTPUT_FILE"