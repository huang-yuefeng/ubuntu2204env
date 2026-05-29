#!/bin/bash

# With progress bar using 'pv' if available
# Save as: git_push_progress.sh

FILE_PATTERN="codex_image.*"
files=($(ls -v $FILE_PATTERN))
total=${#files[@]}
current=0

echo "Total files to push: $total"
echo ""

for file in "${files[@]}"; do
    current=$((current + 1))
    percent=$((current * 100 / total))
    
    echo "[$current/$total] ($percent%) Processing: $file"
    
    git add "$file" && \
    git commit -m "Add $file" && \
    git push origin master
    
    if [ $? -eq 0 ]; then
        echo "✓ Done"
    else
        echo "✗ Failed at $file"
        exit 1
    fi
    echo ""
done

echo "✅ Complete! Pushed $total files successfully."
